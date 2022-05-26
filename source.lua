-- Prerequisites [change this]
local user = "deeeity"
local repo = "ouro-hub-ui"
local branch = "master"

-- Services
local http = game:GetService("HttpService")

-- Preloaded Functions
local get = function(path)
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

local reloadEnv = function()
    local latestVersion = get("info.json")['version']

    local function load()
        getgenv()["ohui"] = {
            components = {
                Window = get("components/window.lua")
            },
            version = latestVersion
        }
        print("Reloaded Environment")
        print("Version", ohui.version)
        return
    end

    if not getgenv()["ohui"] then
        load()
        return
    else
        if ohui.version < latestVersion then
            load()
            return
        end
    end

    print("Already up to date, Version", ohui.version)
    return
end

reloadEnv()


