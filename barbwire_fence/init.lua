-- Barbwire Fence Mod
-- Simple 2-block high fence with neighbor detection

local modname = "barbwire_fence"

-- Helper to check if a node is our fence
local function is_fence(name)
    return name and (name == "barbwire_fence:full" or name == "barbwire_fence:top_only" or name == "barbwire_fence:bottom_only")
end

-- Get connected neighbors (returns table of directions)
local function get_connected_neighbors(pos)
    local neighbors = {}
    local dirs = {
        {x=1, y=0, z=0},
        {x=-1, y=0, z=0},
        {x=0, y=0, z=1},
        {x=0, y=0, z=-1}
    }
    
    for _, dir in ipairs(dirs) do
        local check_pos = {x=pos.x+dir.x, y=pos.y, z=pos.z+dir.z}
        local node = minetest.get_node(check_pos)
        if is_fence(node.name) then
            table.insert(neighbors, dir)
        end
    end
    return neighbors
end

-- Define the main fence node (2 blocks high)
minetest.register_node("barbwire_fence:full", {
    description = "Barbwire Fence",
    drawtype = "nodebox",
    paramtype = "light",
    paramtype2 = "facedir",
    sunlight_propagates = true,
    walkable = true,
    pointable = true,
    diggable = true,
    climbable = false,
    
    -- Use your existing textures
    tiles = {
        "chainlink-32px-32px.png",
        "barbwire-32px-32px.png"
    },
    
    use_tile_groups = false,
    inventory_image = "chainlink-32px-32px.png",
    wield_image = "chainlink-32px-32px.png",
    
    -- Nodebox for 2-block height (y from -0.5 to 1.5)
    node_box = {
        type = "fixed",
        fixed = {
            -- Bottom part (chainlink): y=-0.5 to y=0.5
            {-0.1, -0.5, -0.1, 0.1, 0.5, 0.1},
            -- Top part (barbwire): y=0.5 to y=1.5
            {-0.12, 0.5, -0.12, 0.12, 1.5, 0.12},
        }
    },
    
    collision_box = {
        type = "fixed",
        fixed = {
            {-0.1, -0.5, -0.1, 0.1, 1.5, 0.1},
        }
    },
    
    selection_box = {
        type = "fixed",
        fixed = {-0.15, -0.5, -0.15, 0.15, 1.5, 0.15},
    },
    
    sounds = {
        footstep = {name = "metal_footstep", gain = 0.4},
        place = {name = "metal_place", gain = 0.5},
        dig = {name = "metal_dig", gain = 0.6},
    },
    
    groups = {fence = 1, snappy = 2, not_in_creative_inventory = 0},
    
    on_place = function(itemstack, placer, pointed_thing)
        if not pointed_thing or not pointed_thing.under then
            return itemstack
        end
        
        local pos = pointed_thing.under
        local node_under = minetest.get_node(pos)
        local node_above = minetest.get_node({x=pos.x, y=pos.y+1, z=pos.z})
        
        -- Check if space is clear for 2-block placement
        if node_under.name ~= "air" or node_above.name ~= "air" then
            return itemstack
        end
        
        -- Place the full fence
        minetest.set_node(pos, {name = "barbwire_fence:full"})
        
        -- Update neighbor connections (visual only for now)
        local neighbors = get_connected_neighbors(pos)
        -- Could add mesh adjustment here based on neighbors
        
        if placer and placer:is_player() then
            itemstack:take_item(1)
        end
        
        return itemstack
    end,
    
    after_dig_node = function(pos, oldnode, oldmetadata, digger)
        -- Clean up any connected visual logic if needed
    end,
})

-- Creative inventory item
minetest.register_node("barbwire_fence:full_creative", {
    description = "Barbwire Fence",
    drawtype = "nodebox",
    paramtype = "light",
    paramtype2 = "facedir",
    sunlight_propagates = true,
    walkable = true,
    tiles = {"chainlink-32px-32px.png"},
    node_box = {
        type = "fixed",
        fixed = {
            {-0.1, -0.5, -0.1, 0.1, 0.5, 0.1},
            {-0.12, 0.5, -0.12, 0.12, 1.5, 0.12},
        }
    },
    collision_box = {
        type = "fixed",
        fixed = {{-0.1, -0.5, -0.1, 0.1, 1.5, 0.1}},
    },
    selection_box = {
        type = "fixed",
        fixed = {-0.15, -0.5, -0.15, 0.15, 1.5, 0.15},
    },
    groups = {fence = 1, snappy = 2, creative_inventory = 1},
})

-- Crafting recipe
minetest.register_craft({
    output = "barbwire_fence:full 4",
    recipe = {
        {"default:steel_ingot", "default:stick", "default:steel_ingot"},
        {"default:stick", "default:steel_ingot", "default:stick"},
        {"default:steel_ingot", "default:stick", "default:steel_ingot"},
    }
})

print("[MOD] Barbwire Fence loaded successfully!")
