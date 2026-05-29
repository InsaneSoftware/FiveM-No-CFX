Config = {}

-- Use a public target, e.g. "play.example.com:30120" or "cfx.re/join/abc123".
Config.TargetEndpoint = "play.myserver.com"
Config.ServerName = "Insanely FiveM Unlimited"

Config.JoinUrl = ("fivem://connect/%s"):format(Config.TargetEndpoint)
Config.FallbackMessage = ("Open F8 and run: connect %s"):format(Config.TargetEndpoint)
Config.JoinCommand = ("connect %s"):format(Config.TargetEndpoint)
Config.JoinHost = Config.TargetEndpoint:match("^([^:]+)") or Config.TargetEndpoint
