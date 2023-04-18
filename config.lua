Config = {
    command = "delgun",
    button = 38, --E by default, use numbers via https://docs.fivem.net/docs/game-references/controls/#controls
    aceperm = "entityremover.delgun", --Set to nil or "" to disable permission checking.
    helptext = "Toggle the entity delete gun!",
    Display = {
        enable = true, --If you want hud to to be visable. If set to false chat messages will be sent instead.
        x = .5,
        y = .8,
        text = "You are currently deleting entities. Aim at an entity and press ~r~E ~w~to delete it.",
        scale = .6,
        center = true,
    },
}