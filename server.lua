version = '1.0.0'
subversion = ''
api_response = {}
local utils_required_version = '1.0.0'
local utils_outdated = false

function checkVersion()
    CreateThread(function()
        local connected = false
        local attempts = 0
        while not connected and attempts < 3 do
            attempts = attempts + 1

            PerformHttpRequest("https://raw.githubusercontent.com/SDMDevHub/cinematicshot/main/version", function(errorCode, resultData)
                if errorCode == 200 and resultData then
                    connected = true
                    local latest_version = Utils.Math.trim(resultData)

                    api_response.latest_version = latest_version
                    if Utils.Math.checkIfCurrentVersionisOutdated(latest_version, version) then
                        api_response.has_update = true
                        print("^4["..GetCurrentResourceName().."] An update is available, download it in https://github.com/SDMDevHub/cinematicshot/releases/latest/download/cinematicshot.zip^7 ^3[v"..api_response.latest_version.."]^7")
                    else
                        api_response.has_update = false
                    end
                end
            end, "GET", "", {})

            Wait(10000)
        end
    end)
end