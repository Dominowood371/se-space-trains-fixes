
if not settings.startup["space-minimap-setting-enable"].value then
      data.raw["locomotive"]["space-locomotive"].burner.fuel_categories = { "electrical" }
      data.raw["locomotive"]["space-locomotive-wagon"].burner.fuel_categories = { "electrical" }
      if mods["battery-powered"] then
        table.insert(data.raw["locomotive"]["space-locomotive"].burner.fuel_categories, "battery")
        table.insert(data.raw["locomotive"]["space-locomotive-wagon"].burner.fuel_categories, "battery")
      end
      if mods["BatteryElectricTrain"] then
        table.insert(data.raw["locomotive"]["space-locomotive"].burner.fuel_categories, "bet-fuel-battery")
        table.insert(data.raw["locomotive"]["space-locomotive-wagon"].burner.fuel_categories, "bet-fuel-battery")
      end
else
    if settings.startup["space-fuel-category-setting-enable"].value then
        data.raw["locomotive"]["space-locomotive"].burner.fuel_categories = { "chemical", "electrical" }
        data.raw["locomotive"]["space-locomotive-wagon"].burner.fuel_categories = { "chemical", "electrical" }
        if mods["battery-powered"] then
          table.insert(data.raw["locomotive"]["space-locomotive"].burner.fuel_categories, "battery")
          table.insert(data.raw["locomotive"]["space-locomotive-wagon"].burner.fuel_categories, "battery")
        end
        if mods["BatteryElectricTrain"] then
          table.insert(data.raw["locomotive"]["space-locomotive"].burner.fuel_categories, "bet-fuel-battery")
          table.insert(data.raw["locomotive"]["space-locomotive-wagon"].burner.fuel_categories, "bet-fuel-battery")
        end
       end
end

if settings.startup["space-minimap-setting-enable"].value then
    data.raw["locomotive"]["space-locomotive"].minimap_representation = { filename = "__base__/graphics/entity/diesel-locomotive/diesel-locomotive-selected-minimap-representation.png", flags = {"icon"}, size = {20, 40}, scale = 0.5 }
    data.raw["locomotive"]["space-locomotive"].selected_minimap_representation = { filename = "__base__/graphics/entity/diesel-locomotive/diesel-locomotive-selected-minimap-representation.png", flags = {"icon"}, size = {20, 40}, scale = 0.5 }
    data.raw["locomotive"]["space-locomotive-wagon"].minimap_representation = { filename = "__base__/graphics/entity/diesel-locomotive/diesel-locomotive-selected-minimap-representation.png", flags = {"icon"}, size = {20, 40}, scale = 0.5 }
    data.raw["locomotive"]["space-locomotive-wagon"].selected_minimap_representation = { filename = "__base__/graphics/entity/diesel-locomotive/diesel-locomotive-selected-minimap-representation.png", flags = {"icon"}, size = {20, 40}, scale = 0.5 }
  
    data.raw["cargo-wagon"]["space-cargo-wagon"].minimap_representation = { filename = "__base__/graphics/entity/cargo-wagon/cargo-wagon-minimap-representation.png", flags = {"icon"}, size = {20, 40}, scale = 0.5 }
    data.raw["cargo-wagon"]["space-cargo-wagon"].selected_minimap_representation = { filename = "__base__/graphics/entity/cargo-wagon/cargo-wagon-selected-minimap-representation.png", flags = {"icon"}, size = {20, 40}, scale = 0.5 }
    data.raw["fluid-wagon"]["space-fluid-wagon"].minimap_representation = { filename = "__base__/graphics/entity/fluid-wagon/fluid-wagon-minimap-representation.png", flags = {"icon"}, size = {20, 40}, scale = 0.5 }
    data.raw["fluid-wagon"]["space-fluid-wagon"].selected_minimap_representation = { filename = "__base__/graphics/entity/fluid-wagon/fluid-wagon-selected-minimap-representation.png", flags = {"icon"}, size = {20, 40}, scale = 0.5 }
end