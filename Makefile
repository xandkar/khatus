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

.PHONY: \
	build \
	clean


build: $(AWK_EXECUTABLES)

clean:
	rm $(AWK_EXECUTABLES)


bin/khatus_bar: \
	src/awk/exe/bar.awk \
	src/awk/lib/cache.awk \
	src/awk/lib/msg_in.awk \
	src/awk/lib/msg_out.awk \
	src/awk/lib/util.awk
	echo '#! $(PATH_TO_AWK) -f' > $@
	cat $^ >> $@
	chmod +x $@

bin/khatus_actuate_alert_to_notify_send: \
	src/awk/exe/actuate_alert_to_notify_send.awk \
	src/awk/lib/msg_in.awk
	echo '#! $(PATH_TO_AWK) -f' > $@
	cat $^ >> $@
	chmod +x $@

bin/khatus_actuate_device_add_to_automount: \
	src/awk/exe/actuate_device_add_to_automount.awk \
	src/awk/lib/msg_in.awk \
	src/awk/lib/msg_out.awk \
	src/awk/lib/alert.awk
	echo '#! $(PATH_TO_AWK) -f' > $@
	cat $^ >> $@
	chmod +x $@

bin/khatus_actuate_status_bar_to_xsetroot_name: \
	src/awk/exe/actuate_status_bar_to_xsetroot_name.awk \
	src/awk/lib/msg_in.awk
	echo '#! $(PATH_TO_AWK) -f' > $@
	cat $^ >> $@
	chmod +x $@

bin/khatus_monitor_devices: \
	src/awk/exe/monitor_devices.awk \
	src/awk/lib/msg_in.awk \
	src/awk/lib/msg_out.awk \
	src/awk/lib/alert.awk
	echo '#! $(PATH_TO_AWK) -f' > $@
	cat $^ >> $@
	chmod +x $@

bin/khatus_monitor_energy: \
	src/awk/exe/monitor_energy.awk \
	src/awk/lib/msg_in.awk \
	src/awk/lib/msg_out.awk \
	src/awk/lib/alert.awk \
	src/awk/lib/util.awk
	echo '#! $(PATH_TO_AWK) -f' > $@
	cat $^ >> $@
	chmod +x $@

bin/khatus_monitor_errors: \
	src/awk/exe/monitor_errors.awk \
	src/awk/lib/msg_in.awk \
	src/awk/lib/msg_out.awk \
	src/awk/lib/alert.awk
	echo '#! $(PATH_TO_AWK) -f' > $@
	cat $^ >> $@
	chmod +x $@

bin/khatus_parse_bluetoothctl_show: \
	src/awk/exe/parse_bluetoothctl_show.awk \
	src/awk/lib/msg_out.awk
	echo '#! $(PATH_TO_AWK) -f' > $@
	cat $^ >> $@
	chmod +x $@

bin/khatus_parse_df_pcent: \
	src/awk/exe/parse_df_pcent.awk \
	src/awk/lib/msg_out.awk
	echo '#! $(PATH_TO_AWK) -f' > $@
	cat $^ >> $@
	chmod +x $@

bin/khatus_parse_fan_file: \
	src/awk/exe/parse_fan_file.awk \
	src/awk/lib/msg_out.awk
	echo '#! $(PATH_TO_AWK) -f' > $@
	cat $^ >> $@
	chmod +x $@

bin/khatus_parse_free: \
	src/awk/exe/parse_free.awk \
	src/awk/lib/msg_out.awk
	echo '#! $(PATH_TO_AWK) -f' > $@
	cat $^ >> $@
	chmod +x $@

bin/khatus_parse_ip_addr: \
	src/awk/exe/parse_ip_addr.awk \
	src/awk/lib/msg_out.awk
	echo '#! $(PATH_TO_AWK) -f' > $@
	cat $^ >> $@
	chmod +x $@

bin/khatus_parse_iwconfig: \
	src/awk/exe/parse_iwconfig.awk \
	src/awk/lib/msg_out.awk
	echo '#! $(PATH_TO_AWK) -f' > $@
	cat $^ >> $@
	chmod +x $@

bin/khatus_parse_loadavg_file: \
	src/awk/exe/parse_loadavg_file.awk \
	src/awk/lib/msg_out.awk
	echo '#! $(PATH_TO_AWK) -f' > $@
	cat $^ >> $@
	chmod +x $@

bin/khatus_parse_metar_d_output: \
	src/awk/exe/parse_metar_d_output.awk \
	src/awk/lib/msg_out.awk \
	src/awk/lib/util.awk
	echo '#! $(PATH_TO_AWK) -f' > $@
	cat $^ >> $@
	chmod +x $@

bin/khatus_parse_mpd_status_currentsong: \
	src/awk/exe/parse_mpd_status_currentsong.awk \
	src/awk/lib/msg_out.awk
	echo '#! $(PATH_TO_AWK) -f' > $@
	cat $^ >> $@
	chmod +x $@

bin/khatus_parse_pactl_list_sinks: \
	src/awk/exe/parse_pactl_list_sinks.awk \
	src/awk/lib/msg_out.awk
	echo '#! $(PATH_TO_AWK) -f' > $@
	cat $^ >> $@
	chmod +x $@

bin/khatus_parse_ps: \
	src/awk/exe/parse_ps.awk \
	src/awk/lib/msg_out.awk
	echo '#! $(PATH_TO_AWK) -f' > $@
	cat $^ >> $@
	chmod +x $@

bin/khatus_parse_sys_block_stat: \
	src/awk/exe/parse_sys_block_stat.awk \
	src/awk/lib/msg_out.awk
	echo '#! $(PATH_TO_AWK) -f' > $@
	cat $^ >> $@
	chmod +x $@

bin/khatus_parse_udevadm_monitor_block: \
	src/awk/exe/parse_udevadm_monitor_block.awk \
	src/awk/lib/msg_out.awk
	echo '#! $(PATH_TO_AWK) -f' > $@
	cat $^ >> $@
	chmod +x $@

bin/khatus_parse_upower: \
	src/awk/exe/parse_upower.awk \
	src/awk/lib/msg_out.awk
	echo '#! $(PATH_TO_AWK) -f' > $@
	cat $^ >> $@
	chmod +x $@
