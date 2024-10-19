
local sefixwagons = {
  "space-cargo-wagon",
  "space-fluid-wagon"
}

for _, sefixprototype_type in pairs({
  "train-stop",
  "locomotive",
  "cargo-wagon",
}) do
  -- add wagon to other prototypes
  for _, prototype in pairs(data.raw[sefixprototype_type]) do
    local additional_pastable_entities = prototype.additional_pastable_entities or {}
    for _, wagon_name in pairs(sefixwagons) do
      table.insert(additional_pastable_entities, wagon_name)
    end
    prototype.additional_pastable_entities = additional_pastable_entities
  end
  --fluid wagon updates
  local wagon_prototypes = { data.raw["fluid-wagon"], data.raw["cargo-wagon"] }
  -- add other prototypes to the wagons
  for _, wagon_name in pairs(sefixwagons) do
    for _, wagon_proto in pairs(wagon_prototypes) do
      if wagon_proto[wagon_name] then
        local additional_pastable_entities = wagon_proto[wagon_name].additional_pastable_entities or {}
        for prototype_name, _ in pairs(data.raw[sefixprototype_type]) do
          table.insert(additional_pastable_entities, prototype_name)
        end
        wagon_proto[wagon_name].additional_pastable_entities = additional_pastable_entities
      end
    end
  end
end

if mods["space-exploration"] then
    table.insert(data.raw["technology"]["se-space-rail"].effects, {
      type = "unlock-recipe",
      recipe = "recipe-space-locomotive-wagon"
    })
else
  if mods["se-space-trains"] and not mods["space-exploration"] then
    table.insert(data.raw.technology["tech-space-trains"].effects, {
      type = "unlock-recipe",
      recipe = "recipe-space-locomotive-wagon"
    })
  end
end