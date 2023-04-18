<h1>Entity Remover Gun by ICTechnologies</h1>

<p>Need a entity remover script that is auctually networked? Try this one! We coded this after having some frustration of not getting rid of pesky props left by modders. We made it comepletely networked and all entities are handled by the server. All you do is run the command, aim at an entity, and press E!</p>

<h3>Features</h3>

- Command Based with Ace Permissions
    - Configurable
- 2D Hud Text when the Delgun is Active
    - Configurable
- Fully Networked Requires Onesync


<h3>Config</h3>

```lua
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
```

<h3>Installation</h3>

1. Download from Github.
2. Extract
3. Place EntityRemover into Resources
4. Configure Script `config.lua`
5. Put `start EntityRemover` in your server.cfg
6. Put `add_ace group.YOURGROUPNAMEHERE entityremover.delgun allow` in your server.cfg
7. Start your Server/the script.
8. Enjoy!
