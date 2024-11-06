local meld = require("__core__.lualib.meld")
local hit_effects = require("__base__/prototypes/entity/hit-effects")
local sounds = require("__base__/prototypes/entity/sounds")
local simulations = {}
local updates = require("__se-space-trains__/prototypes/elevated-rails/sloped-space-trains-updates")

simulations.factoriopedia_space_locomotive =
{
  init =
  [[
    game.simulation.camera_position = {1, 0.5}
    game.surfaces[1].create_entities_from_blueprint_string
    {
      string = "0eNqV0+9ugyAQAPB3uc+0Ef9VfZVlMUhv9jIEA9StMb77ULs0y7pkfIOT+52Quxk6dcXRkvbQzEDSaAfNywyOei3UGtNiQGjAClKwMCB9xk9o+PLKALUnT7hnbJtbq69DhzYcYN+Zzofc/uIPG8FgNC5kGb3iQTrkacHgti44DwXOZFHu3/OF/XLTCDeLcLMIl0e4+cMdhcSDMtIMxtOEz2heH/nP50AtOoWtMj05T9K1HxcK+8FMpHto3oRyyMBYCnXFbiXHtHjyJ8X/b8jriBuWEe4pwj1FuDEdVEW4f3dQaH/njXxvw8joPXyfnDV6P0Eeh1DnMWMMJrRuI4oyrfO6LrKqSpIyX5YvleIp7Q==",
      position = {0, 0}
    }
  ]]
}

simulations.factoriopedia_space_cargo_wagon =
{
  init =
  [[
    game.simulation.camera_position = {1, 0.5}
    game.surfaces[1].create_entities_from_blueprint_string
    {
      string = "0eNqV0+FugjAQB/B3uc/FWAUVXsUspOANLytX01adIbz7DnExy1yyfqNH/7+jpDdAY8948sQRqgGodRyg2g8QqGNjpxqbHqECb8jCqID4gJ9Q6fFNAXKkSDgn7otbzee+QS8b1HcyRMl2x5jdCQUnFyTleMJFyvJVoeA2PWgtDQ7ksZ3f56P65a4S3HWCu05wdYKbP92TaTFrje9cdjWdBF7Yulzon/8D2TQWa+s6CpHaUF+PJOveXYg7qN6NDajAeZLGZraWi4kgvkjJeaH4bO2Lbyv+f2ZdJpx5k+BuE9xtgptyp3YJ7t93SgYiRNd+1DJEPJcfszRVHzsoYi99nlOn4II+3IlisyrzsizWu91yucnH8QuWcTBU",
      position = {0, 0}
    }
  ]]
}

simulations.factoriopedia_space_fluid_wagon =
{
  init =
  [[
    game.simulation.camera_position = {1, 0.5}
    game.surfaces[1].create_entities_from_blueprint_string
    {
      string = "0eNqV011ugzAMAOC7+DlU/IUCV6kmFMCl1kKCSGhXIe6+AJ06aZ3UvBFjf04ke4ZaTjiMpCyUM1CjlYHyNIOhTgm5xpToEUoYBUlYGJBq8QvKaPlggMqSJdwrtsO9UlNf4+gS2E+lsa62u9hgIxgM2rgqrVbcSUEautz7+hFFrkFLIzb7/3Rhf9z4bTcpCg838XCPHm76dAfRYHCWE7XBTXSu4JXND1HMf/uoRC2xkrojY6kx1e1C7tzrK6kOyrOQBhnokVxjsVvhIeYvrsI9nsg9nph5uImHe/RwfUYof9/N/x8hN//G6uazcjuj9vBjddboI4Ms9q7Pc8kYXHE0G8GzuEiLgid5HoZZuizfi3YqMw==",
      position = {0, 0}
    }
  ]]
}

local locomotive_reflection = function()
    return
    {
      pictures =
      {
        filename = "__base__/graphics/entity/locomotive/reflection/locomotive-reflection.png",
        priority = "extra-high",
        width = 20,
        height = 52,
        shift = util.by_pixel(0, 40),
        variation_count = 1,
        scale = 5
      },
      rotate = true,
      orientation_to_variation = false
    }
  end

local rolling_stock_back_light = function()
    return
    {
      {
        minimum_darkness = 0.3,
        color = {1, 0.1, 0.05, 0},
        shift = {-0.6, 3.5},
        size = 2,
        intensity = 0.6,
        add_perspective = true
      },
      {
        minimum_darkness = 0.3,
        color = {1, 0.1, 0.05, 0},
        shift = {0.6, 3.5},
        size = 2,
        intensity = 0.6,
        add_perspective = true
      }
    }
  end
  
  local rolling_stock_stand_by_light = function()
    return
    {
      {
        minimum_darkness = 0.3,
        color = {0.05, 0.2, 1, 0},
        shift = {-0.6, -3.5},
        size = 2,
        intensity = 0.5,
        add_perspective = true
      },
      {
        minimum_darkness = 0.3,
        color = {0.05, 0.2, 1, 0},
        shift = {0.6, -3.5},
        size = 2,
        intensity = 0.5,
        add_perspective = true
      }
    }
  end

data:extend({
 {
    type = "item-with-entity-data",
    name = "space-locomotive-wagon",
    icon = "__se-space-trains__/graphics/icons/space-cargo-wagon.png",
    icon_size = 64,
    icon_mipmaps = 1,
    subgroup = "train-transport",
    order = "space[train-system]-e[locomotive-wagon]",
    place_result = "space-locomotive-wagon",
    stack_size = 5,
    inventory_move_sound = item_sounds.locomotive_inventory_move,
    pick_sound = item_sounds.locomotive_inventory_pickup,
    drop_sound = item_sounds.locomotive_inventory_move
  }, {
    type = "recipe",
    name = "space-locomotive-wagon",
    energy_required = 60,
    enabled = false,
    ingredients = {
        {type="item", name="locomotive", amount=1},
        {type="item", name="processing-unit", amount=20},
      },
    results = {{type="item", name="space-locomotive-wagon", amount = 1}},
  }, {
  type = "locomotive",
  name = "space-locomotive-wagon",
  icon = "__se-space-trains__/graphics/icons/space-cargo-wagon.png",
  icon_size = 64,
  flags = {"placeable-neutral", "player-creation", "placeable-off-grid"},
  minable = {
      mining_time = 1,
      result = "space-locomotive-wagon"
  },
  mined_sound = sounds.deconstruct_large(0.8),
  max_health = 1500,
  deliver_category = "vehicle",
  corpse = "locomotive-remnants",
  dying_explosion = "locomotive-explosion",
  factoriopedia_simulation = simulations.factoriopedia_space_locomotive,
  collision_box = {{-0.6, -2.6}, {0.6, 2.6}},
  selection_box = {{-1, -3}, {1, 3}},
  damaged_trigger_effect = hit_effects.entity(),
  drawing_box_vertical_extension = 1,
  alert_icon_shift = util.by_pixel(0, -24),
  weight = 12000,
  max_speed = 2.4,
  max_power = "4.2MW",
  reversing_power_modifier = 1.0,
  braking_force = 40,
  friction_force = 0.50,
  vertical_selection_shift = -0.5,
  air_resistance = 0.0010, -- this is a percentage of current speed that will be subtracted
  connection_distance = 3,
  joint_distance = 4,
  energy_per_hit_point = 5,
  allow_robot_dispatch_in_automatic_mode = true,
  icons_positioning =
  {
    {inventory_index = defines.inventory.fuel, shift = {0, 0.3}, max_icons_per_row = 3},
  },
  resistances = {{
      type = "fire",
      decrease = 20,
      percent = 75
  }, {
      type = "physical",
      decrease = 15,
      percent = 30
  }, {
      type = "impact",
      decrease = 50,
      percent = 75
  }, {
      type = "explosion",
      decrease = 15,
      percent = 30
  }, {
      type = "acid",
      decrease = 5,
      percent = 25
  }},
  energy_source = {
    type = "burner",
    fuel_categories = {"electrical"},
    effectivity = 0.95,
    fuel_inventory_size = 3,
    burnt_inventory_size = 1
},
  front_light = {{
      type = "oriented",
      minimum_darkness = 0.3,
      picture = {
          filename = "__core__/graphics/light-cone.png",
          priority = "extra-high",
          flags = {"light"},
          scale = 2,
          width = 200,
          height = 200
      },
      shift = {-0.6, -16},
      size = 2,
      intensity = 0.8,
      color = {
        r = 0.25,
        g = 0.25,
        b = 0.8,
        a = 0.25
    }
  }, {
      type = "oriented",
      minimum_darkness = 0.3,
      picture = {
          filename = "__core__/graphics/light-cone.png",
          priority = "extra-high",
          flags = {"light"},
          scale = 2,
          width = 200,
          height = 200
      },
      shift = {0.6, -16},
      size = 2,
      intensity = 0.8,
      color  = {
        r = 0.25,
        g = 0.25,
        b = 0.8,
        a = 0.25
    }
  }},
  back_light = rolling_stock_back_light(),
  stand_by_light = rolling_stock_stand_by_light(),
  color = {
      r = 0.20,
      g = 0.20,
      b = 0.20,
      a = 0.5
  },
  default_copy_color_from_train_stop = true,
  pictures = {
    rotated = {
        layers = {{
            priority = "very-low",
            dice = 4,
            width = 1000,
            height = 600,
            back_equals_front = true,
            direction_count = 128,
            allow_low_quality_rotation = true,
            filenames = {"__se-space-trains__/graphics/entity/vehicles/space-trains/hr_space_cargo_wagon_1.png",
                            "__se-space-trains__/graphics/entity/vehicles/space-trains/hr_space_cargo_wagon_2.png",
                            "__se-space-trains__/graphics/entity/vehicles/space-trains/hr_space_cargo_wagon_3.png",
                            "__se-space-trains__/graphics/entity/vehicles/space-trains/hr_space_cargo_wagon_4.png"},
            line_length = 4,
            lines_per_file = 8,
            shift = {0, -0.8},
            scale = 0.4
        }, {
            flags = {"mask"},
            priority = "very-low",
            dice = 4,
            width = 1000,
            height = 600,
            direction_count = 128,
            allow_low_quality_rotation = true,
            back_equals_front = true,
            apply_runtime_tint = true,
            shift = {0, -0.8},
            filenames = {"__se-space-trains__/graphics/entity/vehicles/space-trains/hr_space_cargo_wagon_mask_1.png",
                            "__se-space-trains__/graphics/entity/vehicles/space-trains/hr_space_cargo_wagon_mask_2.png",
                            "__se-space-trains__/graphics/entity/vehicles/space-trains/hr_space_cargo_wagon_mask_3.png",
                            "__se-space-trains__/graphics/entity/vehicles/space-trains/hr_space_cargo_wagon_mask_4.png"},
            line_length = 4,
            lines_per_file = 8,
            scale = 0.4
        }, {
            flags = {"shadow"},
            priority = "very-low",
            dice = 4,
            width = 1000,
            height = 600,
            back_equals_front = true,
            draw_as_shadow = true,
            direction_count = 128,
            allow_low_quality_rotation = true,
            filenames = {"__se-space-trains__/graphics/entity/vehicles/space-trains/hr_space_cargo_wagon_shadows_1.png",
                            "__se-space-trains__/graphics/entity/vehicles/space-trains/hr_space_cargo_wagon_shadows_2.png",
                            "__se-space-trains__/graphics/entity/vehicles/space-trains/hr_space_cargo_wagon_shadows_3.png",
                            "__se-space-trains__/graphics/entity/vehicles/space-trains/hr_space_cargo_wagon_shadows_4.png"},
            line_length = 4,
            lines_per_file = 8,
            shift = {0, -0.8},
            scale = 0.4
        }}
    }
},
  minimap_representation = {
      filename = "__se-space-trains-fixes__/graphics/space-locomotive-minimap-representation.png",
      flags = {"icon"},
      size = {20, 40},
      scale = 0.5
  },
  selected_minimap_representation = {
      filename = "__se-space-trains-fixes__/graphics/space-locomotive-selected-minimap-representation.png",
      flags = {"icon"},
      size = {20, 40},
      scale = 0.5
  },
  wheels = space_train_wheels,
  stop_trigger = { -- left side
  {
      type = "create-trivial-smoke",
      repeat_count = 125,
      smoke_name = "smoke-train-stop",
      initial_height = 0,
      -- smoke goes to the left
      speed = {-0.03, 0},
      speed_multiplier = 0.75,
      speed_multiplier_deviation = 1.1,
      offset_deviation = {{-0.75, -2.7}, {-0.3, 2.7}}
  }, -- right side
  {
      type = "create-trivial-smoke",
      repeat_count = 125,
      smoke_name = "smoke-train-stop",
      initial_height = 0,
      -- smoke goes to the right
      speed = {0.03, 0},
      speed_multiplier = 0.75,
      speed_multiplier_deviation = 1.1,
      offset_deviation = {{0.3, -2.7}, {0.75, 2.7}}
  }, {
      type = "play-sound",
      sound = sounds.train_brakes
  }},
  --drive_over_tie_trigger = drive_over_tie(),
  --tie_distance = 50,
  vehicle_impact_sound = sounds.generic_impact,
  working_sound = {
    sound = {
        filename = "__se-space-trains__/sound/space-train-engine.ogg",
        volume = 0.4,
    modifiers =
        {
          volume_multiplier("main-menu", 1.8),
          volume_multiplier("driving", 0.9),
          volume_multiplier("tips-and-tricks", 0.8)
        },
    },
    match_speed_to_activity = true,
    max_sounds_per_type = 2
},
  open_sound = { filename = "__base__/sound/spidertron/spidertron-door-open.ogg", volume = 0.35 },
  close_sound = { filename = "__base__/sound/spidertron/spidertron-door-close.ogg", volume = 0.4 },
  sound_minimum_speed = 0.5,
  water_reflection = locomotive_reflection(),
  allow_remote_driving = true
}
})

data.raw["assembling-machine"]["space-train-battery-charging-station"].energy_source.input_flow_limit = "20MW"
data.raw["assembling-machine"]["space-train-battery-charging-station"].energy_source.emissions_per_minute  = { pollution = 0.01 }
data.raw["assembling-machine"]["space-train-battery-charging-station"].allowed_effects = {"consumption", "speed", "pollution" }
data.raw["assembling-machine"]["space-train-battery-charging-station"].module_slots = 4
data.raw["assembling-machine"]["space-train-battery-charging-station"].icons_positioning = {{
inventory_index = defines.inventory.assembling_machine_modules,
shift = {0, 0}, 
multi_row_initial_height_modifier = -0.3,
max_icons_per_row = 2,
max_icon_rows = 2
}}

data.raw["locomotive"]["space-locomotive"].color = { r = 0.20, g = 0.20, b = 0.20, a = 0.5 }
data.raw["cargo-wagon"]["space-cargo-wagon"].color = { r = 0.20, g = 0.20, b = 0.20, a = 0.5 }
data.raw["fluid-wagon"]["space-fluid-wagon"].color = { r = 0.20, g = 0.20, b = 0.20, a = 0.5 }

data.raw["locomotive"]["space-locomotive"].open_sound = { filename = "__base__/sound/spidertron/spidertron-door-open.ogg", volume= 0.35 }
data.raw["locomotive"]["space-locomotive"].close_sound = { filename = "__base__/sound/spidertron/spidertron-door-close.ogg", volume = 0.4 }
data.raw["cargo-wagon"]["space-cargo-wagon"].open_sound = { filename = "__base__/sound/spidertron/spidertron-door-open.ogg", volume= 0.35 }
data.raw["cargo-wagon"]["space-cargo-wagon"].close_sound = { filename = "__base__/sound/spidertron/spidertron-door-close.ogg", volume = 0.4 }
data.raw["fluid-wagon"]["space-fluid-wagon"].open_sound = { filename = "__base__/sound/spidertron/spidertron-door-open.ogg", volume= 0.35 }
data.raw["fluid-wagon"]["space-fluid-wagon"].close_sound = { filename = "__base__/sound/spidertron/spidertron-door-close.ogg", volume = 0.4 }

data.raw["locomotive"]["space-locomotive"].minimap_representation.filename = "__se-space-trains-fixes__/graphics/space-locomotive-minimap-representation.png"
data.raw["locomotive"]["space-locomotive"].selected_minimap_representation.filename = "__se-space-trains-fixes__/graphics/space-locomotive-selected-minimap-representation.png"
data.raw["cargo-wagon"]["space-cargo-wagon"].minimap_representation.filename = "__se-space-trains-fixes__/graphics/space-cargo-wagon-minimap-representation.png"
data.raw["cargo-wagon"]["space-cargo-wagon"].selected_minimap_representation.filename = "__se-space-trains-fixes__/graphics/space-cargo-wagon-selected-minimap-representation.png"
data.raw["fluid-wagon"]["space-fluid-wagon"].minimap_representation.filename = "__se-space-trains-fixes__/graphics/space-fluid-wagon-minimap-representation.png"
data.raw["fluid-wagon"]["space-fluid-wagon"].selected_minimap_representation.filename = "__se-space-trains-fixes__/graphics/space-fluid-wagon-selected-minimap-representation.png"

data.raw["locomotive"]["space-locomotive"].allow_robot_dispatch_in_automatic_mode = true
data.raw["cargo-wagon"]["space-cargo-wagon"].allow_robot_dispatch_in_automatic_mode = true
data.raw["fluid-wagon"]["space-fluid-wagon"].allow_robot_dispatch_in_automatic_mode = true

data.raw["locomotive"]["space-locomotive"].default_copy_color_from_train_stop = true
data.raw["cargo-wagon"]["space-cargo-wagon"].default_copy_color_from_train_stop = true
data.raw["fluid-wagon"]["space-fluid-wagon"].default_copy_color_from_train_stop = true

data.raw["locomotive"]["space-locomotive"].factoriopedia_simulation = simulations.factoriopedia_space_locomotive
data.raw["cargo-wagon"]["space-cargo-wagon"].factoriopedia_simulation = simulations.factoriopedia_space_cargo_wagon
data.raw["fluid-wagon"]["space-fluid-wagon"].factoriopedia_simulation = simulations.factoriopedia_space_fluid_wagon

data.raw["item-with-entity-data"]["space-locomotive"].order = "space[train-system]-d[locomotive-wagon]"
data.raw["item-with-entity-data"]["space-cargo-wagon"].order = "space[train-system]-f[cargo-wagon]"
data.raw["item-with-entity-data"]["space-fluid-wagon"].order = "space[train-system]-g[fluid-wagon]"

data.raw["cargo-wagon"]["space-cargo-wagon"].pictures = {
        rotated = {
            layers = {{
                priority = "very-low",
                dice = 4,
                width = 1000,
                height = 600,
                back_equals_front = true,
                direction_count = 128,
                allow_low_quality_rotation = true,
                filenames = {"__se-space-trains__/graphics/entity/vehicles/space-trains/hr_space_cargo_wagon_1.png",
                                "__se-space-trains__/graphics/entity/vehicles/space-trains/hr_space_cargo_wagon_2.png",
                                "__se-space-trains__/graphics/entity/vehicles/space-trains/hr_space_cargo_wagon_3.png",
                                "__se-space-trains__/graphics/entity/vehicles/space-trains/hr_space_cargo_wagon_4.png"},
                line_length = 4,
                lines_per_file = 8,
                shift = {0, -0.8},
                scale = 0.4
            }, {
                flags = {"mask"},
                priority = "very-low",
                dice = 4,
                width = 1000,
                height = 600,
                direction_count = 128,
                allow_low_quality_rotation = true,
                back_equals_front = true,
                apply_runtime_tint = true,
                shift = {0, -0.8},
                filenames = {"__se-space-trains__/graphics/entity/vehicles/space-trains/hr_space_cargo_wagon_mask_1.png",
                                "__se-space-trains__/graphics/entity/vehicles/space-trains/hr_space_cargo_wagon_mask_2.png",
                                "__se-space-trains__/graphics/entity/vehicles/space-trains/hr_space_cargo_wagon_mask_3.png",
                                "__se-space-trains__/graphics/entity/vehicles/space-trains/hr_space_cargo_wagon_mask_4.png"},
                line_length = 4,
                lines_per_file = 8,
                scale = 0.4
            }, {
                flags = {"shadow"},
                priority = "very-low",
                dice = 4,
                width = 1000,
                height = 600,
                back_equals_front = true,
                draw_as_shadow = true,
                direction_count = 128,
                allow_low_quality_rotation = true,
                filenames = {"__se-space-trains__/graphics/entity/vehicles/space-trains/hr_space_cargo_wagon_shadows_1.png",
                                "__se-space-trains__/graphics/entity/vehicles/space-trains/hr_space_cargo_wagon_shadows_2.png",
                                "__se-space-trains__/graphics/entity/vehicles/space-trains/hr_space_cargo_wagon_shadows_3.png",
                                "__se-space-trains__/graphics/entity/vehicles/space-trains/hr_space_cargo_wagon_shadows_4.png"},
                line_length = 4,
                lines_per_file = 8,
                shift = {0, -0.8},
                scale = 0.4
            }}
        }
    }

if settings.startup["space-locomotive-speed-setting"].value == "238 km/h (Vanilla)" then
    data.raw["locomotive"]["space-locomotive-wagon"].max_speed = 1.1
  elseif settings.startup["space-locomotive-speed-setting"].value == "378 km/h" then
    data.raw["locomotive"]["space-locomotive-wagon"].max_speed = 1.75
end

if mods["Krastorio2"] then
    data.raw["locomotive"]["space-locomotive-wagon"].equipment_grid = "kr-locomotive-grid"
else
    data.raw["locomotive"]["space-locomotive"].equipment_grid = "space-locomotive-equipment-grid"
    data.raw["locomotive"]["space-locomotive-wagon"].equipment_grid = "space-locomotive-equipment-grid"
    data.raw["cargo-wagon"]["space-cargo-wagon"].equipment_grid = "space-cargo-equipment-grid"
    data.raw["fluid-wagon"]["space-fluid-wagon"].equipment_grid = "space-fluid-equipment-grid"
end

if mods["Krastorio2"] then
    data.raw["recipe"]["space-locomotive-wagon"].ingredients = {{type="item", name="locomotive", amount=1}, {type="item", name="processing-unit", amount=20}, {type="item", name="electronic-components", amount=20}, {type="item", name="steel-gear-wheel", amount=20}, {type="item", name="rare-metals", amount=80}}
end

if mods["space-exploration"] then
    table.insert(data.raw["recipe"]["space-locomotive-wagon"].ingredients, {type="item", name="se-heat-shielding", amount=20})
  if mods["space-exploration"] and not mods["Krastorio2"] then
    table.insert(data.raw["recipe"]["space-locomotive-wagon"].ingredients, {type="item", name="steel-plate", amount=20})
  end
else
    table.insert(data.raw["recipe"]["space-locomotive-wagon"].ingredients, {type="item", name="steel-plate", amount=20})
end

if mods["space-age"] then

    data.raw["locomotive"]["space-locomotive"].surface_conditions = {{ property = "gravity", min = 1 }}

    -- --------------------------- Add weights and default import planets --------------------------- --
    data.raw["item-with-entity-data"]["space-locomotive-wagon"].default_import_location = "fulgora"
    data.raw["item-with-entity-data"]["space-locomotive-wagon"].weight = 1000*kg

    -- ----------------- Change the recipes now to use the electromagentics facility ---------------- --
    data.raw["recipe"]["space-locomotive-wagon"].subgroup = "fulgora-processes"
    data.raw["recipe"]["space-locomotive-wagon"].category = "electromagnetics"
    data.raw["recipe"]["space-locomotive-wagon"].allow_productivity = true

    -- ------------------------------------- Add new ingredients ------------------------------------ --
    table.insert(data.raw["recipe"]["space-locomotive-wagon"].ingredients, {type="item", name="supercapacitor", amount=5})
    table.insert(data.raw["recipe"]["space-locomotive-wagon"].ingredients, {type="item", name="superconductor", amount=10})
end

if not mods["Krastorio2"] then
    data:extend({
      -- New universal equipment category (all grids can use this)
      {
        type = "equipment-category",
        name = "universal-equipment",
      },
      -- New robot interaction equipment for roboport and similar only for entity with inventory
      {
        type = "equipment-category",
        name = "robot-interaction-equipment",
      },
    })
  
    data:extend ({
      {
        type = "equipment-grid",
        name = "space-locomotive-equipment-grid",
        width = 6,
        height = 6,
        equipment_categories = {
            "universal-equipment", 
          },
      }, 
      {
        type = "equipment-grid",
        name = "space-cargo-equipment-grid",
        width = 12,
        height = 12,
        equipment_categories = {
          "universal-equipment",
          "robot-interaction-equipment",
        },
      }, 
      {
        type = "equipment-grid",
        name = "space-fluid-equipment-grid",
        width = 8,
        height = 8,
        equipment_categories = {
          "universal-equipment",
        },
      }
      })
  
  -- Equipments categories
  table.insert(data.raw["energy-shield-equipment"]["energy-shield-equipment"].categories, "universal-equipment")
  table.insert(data.raw["energy-shield-equipment"]["energy-shield-mk2-equipment"].categories, "universal-equipment")
  table.insert(data.raw["battery-equipment"]["battery-equipment"].categories, "universal-equipment")
  table.insert(data.raw["battery-equipment"]["battery-mk2-equipment"].categories, "universal-equipment")
  table.insert(data.raw["solar-panel-equipment"]["solar-panel-equipment"].categories, "universal-equipment")
  table.insert(data.raw["generator-equipment"]["fission-reactor-equipment"].categories, "universal-equipment")
  table.insert(data.raw["active-defense-equipment"]["personal-laser-defense-equipment"].categories, "universal-equipment")
  table.insert(data.raw["movement-bonus-equipment"]["exoskeleton-equipment"].categories, "universal-equipment")
  table.insert(data.raw["roboport-equipment"]["personal-roboport-equipment"].categories, "robot-interaction-equipment")
  table.insert(data.raw["roboport-equipment"]["personal-roboport-mk2-equipment"].categories, "robot-interaction-equipment")

  if mods["space-age"] then
  table.insert(data.raw["battery-equipment"]["battery-mk3-equipment"].categories, "universal-equipment")
  table.insert(data.raw["generator-equipment"]["fusion-reactor-equipment"].categories, "universal-equipment")
  end

end

if mods["elevated-rails"] then
    meld(data.raw["cargo-wagon"]["space-cargo-wagon"], updates.cargo_wagon)
    meld(data.raw["locomotive"]["space-locomotive-wagon"], updates.cargo_wagon)
end