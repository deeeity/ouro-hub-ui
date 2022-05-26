-- Prerequisites [change this]
local user = "deeeity"
local repo = "ouro-hub-ui"
local branch = "master"

-- Services
local http = game:GetService("HttpService")

-- Preloaded Functions
local include = function(path)
    local link = ("https://raw.githubusercontent.com/%s/%s/%s/%s"):format(user, repo, branch, path)
    local data = syn.request({
        Url = link,
        Method = "GET"
    }).Body

    if string.sub(data, 1, 1) == "{" then
        return http:JSONDecode(data)
    else
        return loadstring(data)()
    end
end

local reloadEnv = function(latestVersion)
    local function load()
        getgenv()["ohui"] = {
            components = {
                Window = include("components/window.lua")
            },
            version = latestVersion
        }
        print("Reloaded Environment")
        print("Version", ohui.version)
        return
    end

    local latestVersion = include("info.json")['version']
    if not getgenv()["ohui"] then
        load()
    else
        if ohui.version < latestVersion then
            load()
        end
    end

    print("Already up to date, Version", ohui.version)
    return
end

reloadEnv()


