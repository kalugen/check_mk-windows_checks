register_check_parameters(
    _("Operating System Resources"),
    "windows_rdp_sessions",
    _("Windows RDP Sessions"),
    Dictionary(
        elements = [
            ("session_levels",
                Tuple(
                    title = _("Maximum number of sessions")
                    label = _("Maximum number of sessions"),
                    elements = [
                        Integer(title = _("Warning at"),  maxvalue = None),
                        Integer(title = _("Critical at"), maxvalue = None),
                    ]
                ),
            ),
        ],
    ),
    None,
    "dict"
)
