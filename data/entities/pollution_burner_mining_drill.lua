local name = names.pollution_burner_mining_drill

local id = "Pollution Burner Mining Drill"

local drill = util.copy(data.raw["mining-drill"]["burner-mining-drill"])      -- This imports the two graphics from the Factorio API
local spawner_graphics = util.copy(data.raw["unit-spawner"]["biter-spawner"]) -- This imports the two graphics from the Factorio API
local tint = {r = 0.65, b = 0.60, g = 0.4}                                    -- This tints the graphics that will be applied to the graphics
util.recursive_hack_scale(spawner_graphics, 0.60)                            -- This scales the spawner to overlap with the miner
util.recursive_hack_make_hr(spawner_graphics)
util.recursive_hack_tint(spawner_graphics, tint)

util.recursive_hack_make_hr(drill)
util.recursive_hack_tint(drill, tint)

-- drill.icons creates the two different images and overlays them instead of drill.icon which only keeps one of them!
drill.icons =
{
  {
    icon = spawner_graphics.icon,
    icon_size = spawner_graphics.icon_size,
    tint = tint
  },
  {
    icon = drill.icon,
    icon_size = drill.icon_size,
    tint = tint
  }
}
drill.icon = nil
drill.name = name
drill.localised_name = {name}
drill.order = "a-a"
drill.collision_box = util.area({0,0}, 1.75)
drill.selection_box = util.area({0,0}, 1.75)
drill.mining_speed = 0
drill.energy_source = {type = "void", emissions_per_minute = 6}
drill.resource_searching_radius = 0.5
drill.collision_mask = util.buildable_on_creep_collision_mask()
drill.resource = {"coal", "copper-ore", "iron-ore", "stone"}
drill.vector_to_place_result = {0, 0}
drill.base_picture = spawner_graphics.animations[4]
drill.working_sound = spawner_graphics.working_sound
drill.vehicle_impact_sound = spawner_graphics.vehicle_impact_sound
drill.module_specification = nil
drill.dying_explosion = spawner_graphics.dying_explosion
drill.corpse = nil

local subgroup =
{
  type = "item-subgroup",
  name = "pollution-drill-subgroup",
  group = "enemies",
  order = "b"
}

local item =
{
  type = "item",
  name = name,
  localised_name = {name},
  localised_description = {"requires-pollution-can-mine-ressources", names.required_pollution[name] * names.pollution_cost_multiplier, "coal, iron, copper, or stone"},
  icons = drill.icons,
  icon = drill.icon,
  icon_size = drill.icon_size,
  flags = {},
  subgroup = subgroup.name,
  order = "aa-"..name,
  place_result = name,
  stack_size = 50
}

data:extend
{
  drill,
  item,
  subgroup
}
