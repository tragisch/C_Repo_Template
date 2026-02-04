genrule(
    name = "os",
    outs = ["os.text"],
    cmd = select(
        {
            "@platforms//os:linux": "echo linux > $@",
            "@platforms//os:macos": "echo macos > $@",
            "@platforms//os:windows": "echo windows > $@",
        },
    ),
)
