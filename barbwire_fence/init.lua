minetest.register_node("barbwire_fence:full", {
    description = "Barbwire Fence (2 blocks high)",
    drawtype = "nodebox",
    paramtype = "light",
    paramtype2 = "facedir",
    sunlight_propagates = true,
    walkable = true,
    pointable = true,
    climbable = false,
    damage_groups = {snappy = 2},
    
    tiles = {
        "barbwire-32px-32px.png", -- Top texture (barbwire)
        "chainlink-32px-32px.png", -- Bottom texture (chainlink)
        "chainlink-32px-32px.png", -- Side texture (chainlink base)
        "chainlink-32px-32px.png",
        "chainlink-32px-32px.png",
        "chainlink-32px-32px.png",
    },
    
    node_box = {
        type = "fixed",
        fixed = {
            -- Chainlink bottom section (y=-0.5 to y=0.5)
            {-0.1, -0.5, -0.1, 0.1, 0.5, 0.1},
            -- Barbwire top section (y=0.5 to y=1.5) 
            {-0.1, 0.5, -0.1, 0.1, 1.5, 0.1},
        },
    },
    
    collision_box = {
        type = "fixed",
        fixed = {
            {-0.1, -0.5, -0.1, 0.1, 1.5, 0.1},
        },
    },
    
    selection_box = {
        type = "fixed",
        fixed = {
            {-0.1, -0.5, -0.1, 0.1, 1.5, 0.1},
        },
    },
    
    sounds = {
        footstep = {name = "metal_footstep", gain = 0.3},
        dig = {name = "metal_dig", gain = 0.4},
        place = {name = "metal_place", gain = 0.3},
        dug = {name = "metal_break", gain = 0.4},
    },
    
    on_place = function(itemstack, placer, pointed_thing)
        if not pointed_thing or not pointed_thing.above then
            return itemstack
        end
        
        local pos = pointed_thing.above
        local node = minetest.get_node(pos)
        local node_above = minetest.get_node({x=pos.x, y=pos.y+1, z=pos.z})
        
        -- Check if both positions are air
        if node.name ~= "air" and node.name ~= "default:air" and node.name ~= "" then
            return itemstack
        end
        if node_above.name ~= "air" and node_above.name ~= "default:air" and node_above.name ~= "" then
            return itemstack
        end
        
        -- Place the fence
        local placer_dir = math.floor((placer:get_look_horizontal() / (math.pi * 2)) + 0.5) % 4
        local facedir = 0
        if placer_dir == 0 then facedir = 2
        elseif placer_dir == 1 then facedir = 1
        elseif placer_dir == 2 then facedir = 0
        elseif placer_dir == 3 then facedir = 3
        end
        
        minetest.set_node(pos, {name = "barbwire_fence:full", param2 = facedir})
        
        if not minetest.is_creative_enabled(placer:get_player_name()) then
            itemstack:take_item()
        end
        
        return itemstack
    end,
})

-- Crafting recipe
minetest.register_craft({
    output = "barbwire_fence:full",
    recipe = {
        {"default:steel_ingot", "default:stick", "default:steel_ingot"},
        {"default:stick", "default:steel_ingot", "default:stick"},
        {"default:steel_ingot", "default:stick", "default:steel_ingot"},
    },
})
