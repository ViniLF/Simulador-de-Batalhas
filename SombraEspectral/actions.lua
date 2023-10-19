local utils = require "utils"

local actions = {}

actions.list = {}

--- Cria uma lista de ações que é armazenada internamente.
function actions.build()
    -- Reset list
    actions.list = {}

    -- Ataque com Golpe Sombrio
local darkStrike = {
    description = "Ataque com Golpe Sombrio.",
    requirement = nil,
    execute = function(playerData, creatureData)
        -- Calcular dano
        local rawDamage = creatureData.attack - math.random() * playerData.defense
        local damage = math.max(1, math.ceil(rawDamage * 1.2))

        -- Aplicar o dano
        playerData.health = playerData.health - damage

        -- Apresentar resultado como print
        print(string.format("%s desferiu um Golpe Sombrio em %s e deu %d pontos de dano", creatureData.name, playerData.name, damage))
        local healthRate = math.floor((playerData.health / playerData.maxHealth) * 10)
        print(string.format("%s: %s", playerData.name, utils.getProgressBar(healthRate)))
    end
}

    -- Ataque Eclipse
local eclipseAttack = {
    description = "Ataque Eclipse",
    requirement = nil,
    execute = function(playerData, creatureData)
        -- Calcular dano
        local rawDamage = creatureData.attack - math.random() * playerData.defense
        local damage = math.max(1, math.ceil(rawDamage * 0.8))

        -- Aplicar o dano
        playerData.health = playerData.health - damage

        -- Apresentar resultado como print
        print(string.format("%s usou um Eclipse e deu %d pontos de danos", creatureData.name, damage))
        local healthRate = math.floor((playerData.health / playerData.maxHealth) * 10)
        print(string.format("%s: %s", playerData.name, utils.getProgressBar(healthRate)))
    end
}

    -- Aguardar
    local waitAction = {
        description = "Aguardar",
        requirement = nil,
        execute = function(playerData, creatureData)
            -- Apresentar resultado como print
            print(string.format("%s decidiu aguardar, e não fez nada nesse turno.", creatureData.name))
        end
    }

    -- Populate list
    actions.list[#actions.list + 1] = darkStrike
    actions.list[#actions.list + 1] = eclipseAttack
    actions.list[#actions.list + 1] = waitAction
end


--- Retorna uma lista de ações válidas
---@param playerData table Definição do jogador
---@param creatureData table Definição da criatura
---@return table
function actions.getValidActions(playerData, creatureData)
    local validActions = {}
    for _, action in pairs(actions.list) do
        local requirement = action.requirement
        local isValid = requirement == nil or requirement(playerData, creatureData)
        if isValid then
            validActions[#validActions+1] = action
        end
    end
    return validActions
end

return actions
