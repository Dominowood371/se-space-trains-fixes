local sefixsourceEntityTypes = {
    ["train-stop"] = true,
    ["locomotive"] = true,
    ["cargo-wagon"] = true,
    ["fluid-wagon"] = true,
  }
  
  local sefixdestinationEntityTypes = {
    ["cargo-wagon"] = true,
    ["fluid-wagon"] = true,
  }
  
  local sefixwagonsToCopy = {
    ["space-cargo-wagon"] = true,
    ["space-fluid-wagon"] = true,
  }
  
  local on_entity_settings_pasted = function(event)
    local source = event.source
    local destination = event.destination
  
    if
      (sefixwagonsToCopy[source.name] or sefixwagonsToCopy[destination.name]) -- correct train to do behaviour for
      and (
        (sefixsourceEntityTypes[source.type] and sefixdestinationEntityTypes[destination.type]) -- paste to a cargo or fluid wagon
        or (sefixsourceEntityTypes[destination.type] and sefixdestinationEntityTypes[source.type])
      )
    then -- copy from a cargo or fluid wagon
      local source_color = source.color or source.prototype.color
      if source_color then
        local destination_color = destination.color or destination.prototype.color
        destination.color = {
          r = source_color.r,
          g = source_color.g,
          b = source_color.b,
          a = destination_color and destination_color.a or 1, -- keep alpha color
        }
      end
    end
  end
  
  local init_events = function()
    script.on_event(defines.events.on_entity_settings_pasted, on_entity_settings_pasted)
  end
  
  script.on_load(function()
    init_events()
  end)
  
  script.on_init(function()
    init_events()
  end)