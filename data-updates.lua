
if not settings.startup["space-fuel-category-setting-enable"].value then
      data.raw["locomotive"]["space-locomotive"].energy_source.fuel_categories = { "electrical" }
      data.raw["locomotive"]["space-locomotive-wagon"].energy_source.fuel_categories = { "electrical" }
      if mods["battery-powered"] then
        table.insert(data.raw["locomotive"]["space-locomotive"].energy_source.fuel_categories, "battery")
        table.insert(data.raw["locomotive"]["space-locomotive-wagon"].energy_source.fuel_categories, "battery")
      end
      if mods["BatteryElectricTrain"] then
        table.insert(data.raw["locomotive"]["space-locomotive"].energy_source.fuel_categories, "bet-fuel-battery")
        table.insert(data.raw["locomotive"]["space-locomotive-wagon"].energy_source.fuel_categories, "bet-fuel-battery")
      end
else
    if settings.startup["space-fuel-category-setting-enable"].value then
        data.raw["locomotive"]["space-locomotive"].energy_source.fuel_categories = { "chemical", "electrical" }
        data.raw["locomotive"]["space-locomotive-wagon"].energy_source.fuel_categories = { "chemical", "electrical" }
        if mods["battery-powered"] then
          table.insert(data.raw["locomotive"]["space-locomotive"].energy_source.fuel_categories, "battery")
          table.insert(data.raw["locomotive"]["space-locomotive-wagon"].energy_source.fuel_categories, "battery")
        end
        if mods["BatteryElectricTrain"] then
          table.insert(data.raw["locomotive"]["space-locomotive"].energy_source.fuel_categories, "bet-fuel-battery")
          table.insert(data.raw["locomotive"]["space-locomotive-wagon"].energy_source.fuel_categories, "bet-fuel-battery")
        end
       end
end

if settings.startup["space-minimap-setting-enable"].value then
    data.raw["locomotive"]["space-locomotive"].minimap_representation = { filename = "__base__/graphics/entity/locomotive/minimap-representation/locomotive-minimap-representation.png", flags = {"icon"}, size = {20, 40}, scale = 0.5 }
    data.raw["locomotive"]["space-locomotive"].selected_minimap_representation = { filename = "__base__/graphics/entity/locomotive/minimap-representation/locomotive-selected-minimap-representation.png", flags = {"icon"}, size = {20, 40}, scale = 0.5 }
    data.raw["locomotive"]["space-locomotive-wagon"].minimap_representation = { filename = "__base__/graphics/entity/locomotive/minimap-representation/locomotive-minimap-representation.png", flags = {"icon"}, size = {20, 40}, scale = 0.5 }
    data.raw["locomotive"]["space-locomotive-wagon"].selected_minimap_representation = { filename = "__base__/graphics/entity/locomotive/minimap-representation/locomotive-selected-minimap-representation.png", flags = {"icon"}, size = {20, 40}, scale = 0.5 }
    data.raw["cargo-wagon"]["space-cargo-wagon"].minimap_representation = { filename = "__base__/graphics/entity/cargo-wagon/minimap-representation/cargo-wagon-minimap-representation.png", flags = {"icon"}, size = {20, 40}, scale = 0.5 }
    data.raw["cargo-wagon"]["space-cargo-wagon"].selected_minimap_representation = { filename = "__base__/graphics/entity/cargo-wagon/minimap-representation/cargo-wagon-selected-minimap-representation.png", flags = {"icon"}, size = {20, 40}, scale = 0.5 }
    data.raw["fluid-wagon"]["space-fluid-wagon"].minimap_representation = { filename = "__base__/graphics/entity/fluid-wagon/minimap-representation/fluid-wagon-minimap-representation.png", flags = {"icon"}, size = {20, 40}, scale = 0.5 }
    data.raw["fluid-wagon"]["space-fluid-wagon"].selected_minimap_representation = { filename = "__base__/graphics/entity/fluid-wagon/minimap-representation/fluid-wagon-selected-minimap-representation.png", flags = {"icon"}, size = {20, 40}, scale = 0.5 }
end