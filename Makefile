MAKEFLAGS := --no-builtin-rules

PREFIX := $(HOME)
PATH_TO_AWK := /usr/bin/awk
AWK_EXECUTABLES := \
	bin/khatus_bar \
	bin/khatus_actuate_alert_to_notify_send \
	bin/khatus_actuate_device_add_to_automount \
	bin/khatus_actuate_status_bar_to_xsetroot_name \
	bin/khatus_monitor_devices \
	bin/khatus_monitor_energy \
	bin/khatus_monitor_errors \
	bin/khatus_parse_bluetoothctl_show \
	bin/khatus_parse_df_pcent \
	bin/khatus_parse_fan_file \
	bin/khatus_parse_free \
	bin/khatus_parse_ip_addr \
	bin/khatus_parse_iwconfig \
	bin/khatus_parse_loadavg_file \
	bin/khatus_parse_metar_d_output \
	bin/khatus_parse_mpd_status_currentsong \
	bin/khatus_parse_pactl_list_sinks \
	bin/khatus_parse_ps \
	bin/khatus_parse_sys_block_stat \
	bin/khatus_parse_udevadm_monitor_block \
	bin/khatus_parse_upower
BASH_EXECUTABLE_NAMES := \
	khatus \
	khatus_gen_bar_make_status \
	khatus_sensor_bluetooth_power \
	khatus_sensor_datetime \
	khatus_sensor_devices \
	khatus_sensor_disk_io \
	khatus_sensor_disk_space \
	khatus_sensor_energy \
	khatus_sensor_fan \
	khatus_sensor_loadavg \
	khatus_sensor_memory \
	khatus_sensor_mpd \
	khatus_sensor_net_addr_io \
	khatus_sensor_net_wifi_status \
	khatus_sensor_procs \
	khatus_sensor_screen_brightness \
	khatus_sensor_temperature \
	khatus_sensor_volume \
	khatus_sensor_weather
BASH_EXECUTABLES := $(foreach exe,$(BASH_EXECUTABLE_NAMES),bin/$(exe))
OCAML_EXECUTABLES := \
	bin/khatus_cache_dumper
EXECUTABLES := $(AWK_EXECUTABLES) $(BASH_EXECUTABLES) $(OCAML_EXECUTABLES)

define BUILD_AWK_EXE
	echo '#! $(PATH_TO_AWK) -f'                                > $@ && \
	echo 'BEGIN {Node   = Node ? Node : "$(shell hostname)"}' >> $@ && \
	echo 'BEGIN {Module = "$(notdir $@)"}'                    >> $@ && \
	cat $^                                                    >> $@ && \
	chmod +x $@
endef

define BUILD_BASH_EXE
	cat $^ > $@ && \
	chmod +x $@
endef

define GEN_BASH_EXE_RULE
bin/$(1) : src/bash/exe/$(1).sh
	$$(BUILD_BASH_EXE)
endef

.PHONY: \
	build \
	install \
	clean

build: | bin
build: $(EXECUTABLES)

install:
	$(foreach filename,$(wildcard bin/*),cp -p "$(filename)" "$(PREFIX)/$(filename)"; )

clean:
	rm -rf bin
	ocamlbuild -clean

bin:
	mkdir -p bin

#-----------------------------------------------------------------------------
# Bash
#-----------------------------------------------------------------------------
$(foreach exe,$(BASH_EXECUTABLE_NAMES),$(eval $(call GEN_BASH_EXE_RULE,$(exe))))

#-----------------------------------------------------------------------------
# AWK
#-----------------------------------------------------------------------------
bin/khatus_bar: \
	src/awk/exe/bar.awk \
	src/awk/lib/cache.awk \
	src/awk/lib/str.awk \
	src/awk/lib/msg_in.awk \
	src/awk/lib/msg_out.awk \
	src/awk/lib/num.awk
	$(BUILD_AWK_EXE)

bin/khatus_actuate_alert_to_notify_send: \
	src/awk/exe/actuate_alert_to_notify_send.awk \
	src/awk/lib/str.awk \
	src/awk/lib/msg_in.awk
	$(BUILD_AWK_EXE)

bin/khatus_actuate_device_add_to_automount: \
	src/awk/exe/actuate_device_add_to_automount.awk \
	src/awk/lib/str.awk \
	src/awk/lib/msg_in.awk \
	src/awk/lib/msg_out.awk
	$(BUILD_AWK_EXE)

bin/khatus_actuate_status_bar_to_xsetroot_name: \
	src/awk/exe/actuate_status_bar_to_xsetroot_name.awk \
	src/awk/lib/str.awk \
	src/awk/lib/msg_in.awk
	$(BUILD_AWK_EXE)

bin/khatus_monitor_devices: \
	src/awk/exe/monitor_devices.awk \
	src/awk/lib/str.awk \
	src/awk/lib/msg_in.awk \
	src/awk/lib/msg_out.awk
	$(BUILD_AWK_EXE)

bin/khatus_monitor_energy: \
	src/awk/exe/monitor_energy.awk \
	src/awk/lib/str.awk \
	src/awk/lib/msg_in.awk \
	src/awk/lib/msg_out.awk \
	src/awk/lib/num.awk
	$(BUILD_AWK_EXE)

bin/khatus_monitor_errors: \
	src/awk/exe/monitor_errors.awk \
	src/awk/lib/str.awk \
	src/awk/lib/msg_in.awk \
	src/awk/lib/msg_out.awk
	$(BUILD_AWK_EXE)

bin/khatus_parse_bluetoothctl_show: \
	src/awk/exe/parse_bluetoothctl_show.awk \
	src/awk/lib/msg_out.awk
	$(BUILD_AWK_EXE)

bin/khatus_parse_df_pcent: \
	src/awk/exe/parse_df_pcent.awk \
	src/awk/lib/msg_out.awk
	$(BUILD_AWK_EXE)

bin/khatus_parse_fan_file: \
	src/awk/exe/parse_fan_file.awk \
	src/awk/lib/msg_out.awk
	$(BUILD_AWK_EXE)

bin/khatus_parse_free: \
	src/awk/exe/parse_free.awk \
	src/awk/lib/msg_out.awk
	$(BUILD_AWK_EXE)

bin/khatus_parse_ip_addr: \
	src/awk/exe/parse_ip_addr.awk \
	src/awk/lib/msg_out.awk
	$(BUILD_AWK_EXE)

bin/khatus_parse_iwconfig: \
	src/awk/exe/parse_iwconfig.awk \
	src/awk/lib/msg_out.awk
	$(BUILD_AWK_EXE)

bin/khatus_parse_loadavg_file: \
	src/awk/exe/parse_loadavg_file.awk \
	src/awk/lib/msg_out.awk
	$(BUILD_AWK_EXE)

bin/khatus_parse_metar_d_output: \
	src/awk/exe/parse_metar_d_output.awk \
	src/awk/lib/msg_out.awk \
	src/awk/lib/str.awk
	$(BUILD_AWK_EXE)

bin/khatus_parse_mpd_status_currentsong: \
	src/awk/exe/parse_mpd_status_currentsong.awk \
	src/awk/lib/msg_out.awk
	$(BUILD_AWK_EXE)

bin/khatus_parse_pactl_list_sinks: \
	src/awk/exe/parse_pactl_list_sinks.awk \
	src/awk/lib/msg_out.awk
	$(BUILD_AWK_EXE)

bin/khatus_parse_ps: \
	src/awk/exe/parse_ps.awk \
	src/awk/lib/msg_out.awk
	$(BUILD_AWK_EXE)

bin/khatus_parse_sys_block_stat: \
	src/awk/exe/parse_sys_block_stat.awk \
	src/awk/lib/msg_out.awk
	$(BUILD_AWK_EXE)

bin/khatus_parse_udevadm_monitor_block: \
	src/awk/exe/parse_udevadm_monitor_block.awk \
	src/awk/lib/msg_out.awk
	$(BUILD_AWK_EXE)

bin/khatus_parse_upower: \
	src/awk/exe/parse_upower.awk \
	src/awk/lib/msg_out.awk
	$(BUILD_AWK_EXE)

#-----------------------------------------------------------------------------
# OCaml
#-----------------------------------------------------------------------------
bin/khatus_cache_dumper: src/ocaml/exe/khatus_cache_dumper.ml
	ocamlbuild -cflags '-w A' -pkg unix -I src/ocaml/exe -I src/ocaml/lib khatus_cache_dumper.byte
	mv _build/src/ocaml/exe/khatus_cache_dumper.byte bin/khatus_cache_dumper
	rm -f khatus_cache_dumper.byte
