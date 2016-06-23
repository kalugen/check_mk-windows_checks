# Very simple perf-o-meter
def perfometer_windows_print_queue(row, check_command, perf_data):
    left = float(perf_data[0][1])
    warn = float(perf_data[0][3])
    crit = float(perf_data[0][4])

    red    = "#ff0000"
    yellow = "#ffff00"
    green  = "#00ff00"

    if left >= crit:
        color = red

    elif left >= warn:
        color = yellow

    else:
        color = green

    return "%.0f%%" % left, perfometer_linear(left, color)

perfometers["check_mk-windows_print_queue"] = perfometer_windows_print_queue
