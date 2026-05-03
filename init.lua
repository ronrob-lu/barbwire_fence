-- Barbwire Fence Mod for Luanti/Minetest
-- Creates a 2-block high fence with chain-link and barbwire

local S = minetest.get_translator("barbwire_fence")

-- Define the barbwire fence node
minetest.register_node("barbwire_fence:fence", {
    description = S("Barbwire Fence (2 blocks high)"),
    drawtype = "nodebox",
    paramtype = "light",
    paramtype2 = "facedir",
    sunlight_propagates = true,
    walkable = false,
    pointable = true,
    diggable = true,
    buildable_to = false,
    floodable = true,
    
    -- Collision box - makes it solid for players/mobs but allows projectiles through gaps
    collision_box = {
        type = "fixed",
        fixed = {
            -- Bottom post
            {-0.05, -0.5, -0.05, 0.05, 1.5, 0.05},
            -- Top post  
            {-0.05, 0.5, -0.05, 0.05, 2.5, 0.05},
            -- Chain link bottom section (lower half of block 1)
            {-0.04, -0.5, -0.02, 0.04, 0.5, 0.02},
            {-0.04, -0.5, 0.02, 0.04, 0.5, 0.06},
            -- Chain link top section (upper half of block 1 + lower half of block 2)
            {-0.04, 0.5, -0.02, 0.04, 1.5, 0.02},
            {-0.04, 0.5, 0.02, 0.04, 1.5, 0.06},
            -- Barbwire strands at top
            {-0.1, 1.8, -0.03, 0.1, 1.85, 0.03},
            {-0.1, 2.0, -0.03, 0.1, 2.05, 0.03},
            {-0.1, 2.2, -0.03, 0.1, 2.25, 0.03},
        }
    },
    
    -- Selection box
    selection_box = {
        type = "fixed",
        fixed = {
            {-0.15, -0.5, -0.15, 0.15, 2.5, 0.15},
        }
    },
    
    node_box = {
        type = "fixed",
        fixed = {
            -- Metal posts (vertical supports)
            {-0.04, -0.5, -0.04, 0.04, 2.5, 0.04}, -- Main post
            
            -- Chain-link mesh bottom section (first meter)
            {-0.03, -0.5, -0.01, 0.03, 0.5, 0.01}, -- Vertical wires
            {-0.03, -0.5, 0.01, 0.03, 0.5, 0.05}, -- Horizontal wires
            
            -- Chain-link mesh middle section (second meter, half height)
            {-0.03, 0.5, -0.01, 0.03, 1.0, 0.01}, -- Vertical wires (half chainlink)
            {-0.03, 0.5, 0.01, 0.03, 1.0, 0.05}, -- Horizontal wires (half chainlink)
            
            -- Barbwire strands at the very top (above chainlink)
            {-0.08, 1.9, -0.02, 0.08, 1.92, 0.02}, -- Strand 1
            {-0.08, 2.1, -0.02, 0.08, 2.12, 0.02}, -- Strand 2
            {-0.08, 2.3, -0.02, 0.08, 2.32, 0.02}, -- Strand 3
            
            -- Diagonal barbs on wire (small angled pieces)
            {-0.06, 1.91, -0.01, -0.04, 1.93, 0.01},
            {-0.02, 1.91, -0.01, 0.0, 1.93, 0.01},
            {-0.06, 2.11, -0.01, -0.04, 2.13, 0.01},
            {-0.02, 2.11, -0.01, 0.0, 2.13, 0.01},
            {-0.06, 2.31, -0.01, -0.04, 2.33, 0.01},
            {-0.02, 2.31, -0.01, 0.0, 2.33, 0.01},
        }
    },
    
    tiles = {
        {
            name = "barbwire_fence_chainlink.png",
            animation = {
                type = "vertical_frames",
                aspect_w = 16,
                aspect_h = 16,
                length = 0.0,
            },
        },
        "barbwire_fence_barbwire.png",
        "barbwire_fence_chainlink_barbwire.png",
    },
    
    -- Use special material type for see-through behavior
    use_tile_alpha = true,
    alpha = "blend",
    wield_image = "barbwire_fence_wield.png",
    
    groups = {
        fence = 1, 
        barrier = 1, 
        snappy = 2, 
        not_in_creative_inventory = 0,
        level = 2,
    },
    
    sounds = default.node_sound_metal_sounds(),
    
    after_place_node = function(pos, placer, itemstack, pointed_thing)
        -- Set the facedir based on where player is looking
        if placer and placer:is_player() then
            local dir = minetest.dir_to_facedir(placer:get_look_dir())
            local node = minetest.get_node(pos)
            node.param2 = dir
            minetest.set_node(pos, node)
        end
    end,
    
    on_rotate = function(pos, node, user, mode, new_param2)
        -- Allow rotation
        node.param2 = new_param2
        minetest.set_node(pos, node)
        return true
    end,
})

-- Creative inventory item
minetest.register_craftitem("barbwire_fence:fence_item", {
    description = S("Barbwire Fence"),
    inventory_image = "barbwire_fence_wield.png",
    on_place = function(itemstack, player, pointed_thing)
        if pointed_thing.type ~= "node" then
            return itemstack
        end
        
        local pos = pointed_thing.above
        local node = minetest.get_node(pos)
        
        -- Check if we can place here
        if not minetest.is_air(node.name) then
            return itemstack
        end
        
        -- Place the fence
        local placer_pos = player:get_pos()
        placer_pos.y = placer_pos.y + 1.5 -- Eye level
        
        local fake_player = {
            is_player = function() return true end,
            get_look_dir = function() return player:get_look_dir() end,
            get_pos = function() return placer_pos end,
        }
        
        minetest.set_node(pos, {name = "barbwire_fence:fence"})
        local dir = minetest.dir_to_facedir(player:get_look_dir())
        local placed_node = minetest.get_node(pos)
        placed_node.param2 = dir
        minetest.set_node(pos, placed_node)
        
        if not minetest.is_creative_enabled(player:get_player_name()) then
            itemstack:take_item()
        end
        
        return itemstack
    end,
})

-- Crafting recipe
minetest.register_craft({
    output = "barbwire_fence:fence_item 4",
    recipe = {
        {"default:steel_ingot", "default:steel_ingot", "default:steel_ingot"},
        {"default:steel_ingot", "default:stick", "default:steel_ingot"},
        {"default:steel_ingot", "default:stick", "default:steel_ingot"},
    }
})

-- Alternative recipe with more barbwire focus
minetest.register_craft({
    output = "barbwire_fence:fence_item 2",
    recipe = {
        {"default:steel_ingot", "", "default:steel_ingot"},
        {"default:steel_ingot", "default:stick", "default:steel_ingot"},
        {"default:steel_ingot", "default:stick", "default:steel_ingot"},
    }
})

minetest.log("action", "[barbwire_fence] Loaded successfully!")
