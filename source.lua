-- Prerequisites [change this]
local user = "deeeity"
local repo = "ouro-hub-ui"
local branch = "master"

-- Preloaded Functions
local include = function(path)
    local link = ("https://raw.githubusercontent.com/%s/%s/%s/%s"):format(user, repo, branch, path)
    return syn.request({
        Url = link,
        Method = "GET"
    }).Body
end

local reloadEnv = function(latestVersion)
    getgenv()["ohui"] = {
        components = {
            Window = include("components/window.lua")
        },
        version = latestVersion
    }

    print("Reloaded Environment")
    print("Version", ohui.version)
end

-- Services
local http = game:GetService("HttpService")

-- Get latest version
local latestVersion = http:JSONDecode(include("info.json"))['version']

if getgenv()["ohui"] ~= nil and ohui.version ~= nil and ohui.version < latestVersion then
    reloadEnv(latestVersion)
end


