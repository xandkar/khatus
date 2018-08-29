BEGIN {
    OFS = Msg_fs ? Msg_fs : "|"
    Kfs = Key_fs ? Key_fs : ":"
}

function msg_out_ok(key, val) {
    msg_out("OK", key, val, "/dev/stdout")
}

function msg_out_info(location, msg) {
    msg_out("INFO", location, msg, "/dev/stderr")
}

function msg_out_error(location, msg) {
    msg_out("ERROR", location, msg, "/dev/stderr")
}

function msg_out(status, key, val, channel) {
    print(status, Module, key, val) > channel
}