
register_rule("checkparams" + "/" +  _("Inventory - automatic service detection"),
    varname   = "windows_print_disabled_queues",
    title     = _("Windows print queues discovery"),
    valuespec = ListOfStrings(
        title = _("Disabled queues"),
        help  = _('This queues/printers will be ignored, you can use regular '
                  'expressions to disable multiple printers'),
        orientation = "horizontal",
    ),
    match= 'all',
)

register_check_parameters(
    _("Operating System Resources"),
    "windows_print_queues",
    _("Windows print queues"),
    Dictionary(
        elements = [
            ("job_levels",
                Tuple(
                    title = _("Maximum number of queued jobs per printer"),
                    label = _("Maximum number of queued jobs per printer"),
                    elements = [
                        Integer(title = _("Warning at"),  maxvalue = None),
                        Integer(title = _("Critical at"), maxvalue = None),
                    ]
                ),
            ),
            ("page_levels",
                Tuple(
                    title = _("Maximum number of queued pages per printer"),
                    label = _("Maximum number of queued pages per printer"),
                    elements = [
                        Integer(title = _("Warning at:"),  maxvalue = None),
                        Integer(title = _("Critical at:"), maxvalue = None),
                    ]
                ),
            ),
        ],
    ),
    TextAscii(
        title = _("Queue Name"),
        help  = _("Name of the printer queue"),
        allow_empty = True,
    ),
    "dict"
)
