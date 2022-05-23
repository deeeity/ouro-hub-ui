-- Services
local http = game:GetService("HttpService")

-- Get latest version
local version = http:JSONDecode(loadstring(game:HttpGet("", true))())

-- Initialize the environment
getgenv()["ouro-ui"] = ouro-ui or {}
