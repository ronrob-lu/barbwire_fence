minetest.register_node("barbwire_fence:fence", {
    description = "Barbwire Fence",
    drawtype = "nodebox",
    paramtype = "light",
    sunlight_propagates = true,
    walkable = false, -- Allows players to walk through (like steelgrid)
    pointable = true,
    diggable = true,
    buildable_to = false,
    is_ground_content = false,
    groups = {fence = 1, snappy = 2, oddly_breakable_by_hand = 0, flammable = 0},
    
    -- Use the specific 32px textures you requested
    tiles = {
        "chainlink-32px-32px.png", 
        "barbwire-32px-32px.png"
    },
    
    -- Define two separate nodeboxes: one for chainlink (bottom), one for barbwire (top)
    node_box = {
        type = "fixed",
        fixed = {
            -- Chainlink part (bottom half of lower block to middle of upper block)
            {-0.5, -0.5, -0.05, 0.5, 1.5, 0.05}, 
            -- Barbwire part (top section with spikes)
            {-0.5, 1.5, -0.02, 0.5, 2.5, 0.02},
            -- Horizontal barbs at top
            {-0.5, 2.3, -0.1, 0.5, 2.4, 0.1},
            {-0.5, 2.1, -0.1, 0.5, 2.2, 0.1},
        }
    },
    
    selection_box = {
        type = "fixed",
        fixed = {-0.5, -0.5, -0.1, 0.5, 2.5, 0.1}
    },
    
    collision_box = {
        type = "fixed",
        fixed = {-0.5, -0.5, -0.05, 0.5, 2.5, 0.05}
    },

    sounds = {
        footstep = {name = "metal_footstep", gain = 0.3},
        dig = {name = "metal_dig", gain = 0.4},
        place = {name = "metal_place", gain = 0.3},
        dug = {name = "metal_break", gain = 0.4},
    },

    on_place = function(itemstack, placer, pointed_thing)
        if not pointed_thing or not pointed_thing.under then
            return itemstack
        end

        local under_pos = pointed_thing.under
        local above_pos = pointed_thing.above
        
        -- Check if the space above is empty (air or buildable_to)
        local node_above = minetest.get_node(above_pos)
        local is_air = (node_above.name == "air" or minetest.registered_nodes[node_above.name] and minetest.registered_nodes[node_above.name].buildable_to)

        if not is_air then
            -- Cannot place if space above is blocked
            return itemstack
        end

        -- Place the main fence node (which contains both parts via nodebox)
        minetest.set_node(under_pos, {name = "barbwire_fence:fence"})
        
        -- Return success
        if not placer:is_creative() then
            itemstack:take_item()
        end
        return itemstack
    end,
})

-- Crafting recipe (adjust based on your modpack's available items)
minetest.register_craft({
    output = "barbwire_fence:fence 2",
    recipe = {
        {"default:steel_ingot", "default:stick", "default:steel_ingot"},
        {"default:stick", "default:steel_ingot", "default:stick"},
        {"default:steel_ingot", "default:stick", "default:steel_ingot"},
    }
})
