-- Barbwire Fence Mod for Luanti/Minetest
-- A 2-block high barbwire fence with chain-link and barbwire elements

local S = minetest.get_translator("barbwire_fence")

-- Helper function to create fence node definitions
local function create_fence_node(name, def)
    minetest.register_node("barbwire_fence:" .. name, {
        description = def.description,
        drawtype = "nodebox",
        paramtype = "light",
        paramtype2 = "facedir",
        sunlight_propagates = true,
        walkable = true,
        pointable = true,
        diggable = true,
        climbable = false,
        buildable_to = false,
        floodable = true,
        is_ground_content = false,
        groups = {
            fence = 1,
            cracky = 1,
            oddly_breakable_by_hand = 2,
            level = 2
        },
        sounds = {
            footstep = {name = "metal_footstep", gain = 0.5},
            dig = {name = "metal_dig", gain = 0.5},
            place = {name = "metal_place", gain = 0.5},
        },
        tiles = def.tiles,
        use_texture_alpha = def.use_texture_alpha or "clip",
        node_box = def.node_box,
        selection_box = def.selection_box,
        on_rotate = screwdriver and screwdriver.rotate_face or nil,
    })
end

-- Node box definitions for 2-block high fence (Y ranges from -0.5 to 1.5)
-- Chainlink fence node box (full height mesh)
local chainlink_nodebox = {
    -- Main chainlink panel (thin plane in center)
    {-0.05, -0.5, -0.05, 0.05, 1.5, 0.05},
}

-- Barbwire strand node box (top portion with barbs)
local barbwire_nodebox = {
    -- Horizontal barbwire strands at top
    {-0.5, 1.2, -0.05, 0.5, 1.25, 0.05},
    {-0.5, 1.0, -0.05, 0.5, 1.05, 0.05},
    {-0.5, 0.8, -0.05, 0.5, 0.85, 0.05},
    -- Barbs (small protrusions)
    {-0.5, 1.2, -0.1, -0.4, 1.2, 0.1},
    {-0.3, 1.2, -0.1, -0.2, 1.2, 0.1},
    {-0.1, 1.2, -0.1, 0.0, 1.2, 0.1},
    {0.1, 1.2, -0.1, 0.2, 1.2, 0.1},
    {0.3, 1.2, -0.1, 0.4, 1.2, 0.1},
}

-- Combined chainlink + barbwire node box
local combined_nodebox = {
    -- Chainlink portion (bottom)
    {-0.05, -0.5, -0.05, 0.05, 0.75, 0.05},
    -- Barbwire strands (top)
    {-0.5, 1.2, -0.05, 0.5, 1.25, 0.05},
    {-0.5, 1.0, -0.05, 0.5, 1.05, 0.05},
    {-0.5, 0.8, -0.05, 0.5, 0.85, 0.05},
}

-- Selection boxes (what you can click on)
local chainlink_selectionbox = {-0.1, -0.5, -0.1, 0.1, 1.5, 0.1}
local barbwire_selectionbox = {-0.5, 0.75, -0.1, 0.5, 1.5, 0.1}
local combined_selectionbox = {-0.1, -0.5, -0.1, 0.1, 1.5, 0.1}

-- Register Chainlink Fence Node
create_fence_node("chainlink", {
    description = S("Chainlink Fence"),
    tiles = {
        "chainlink-32px-32px.png",
    },
    use_texture_alpha = "clip",
    node_box = chainlink_nodebox,
    selection_box = chainlink_selectionbox,
})

-- Register Barbwire Fence Node (top section with barbs only)
create_fence_node("barbwire", {
    description = S("Barbwire Strand"),
    tiles = {
        "barbwire-32px-32px.png",
    },
    use_texture_alpha = "clip",
    node_box = barbwire_nodebox,
    selection_box = barbwire_selectionbox,
})

-- Register Combined Chainlink + Barbwire Fence Node
create_fence_node("chainlink_barbwire", {
    description = S("Chainlink Fence with Barbwire"),
    tiles = {
        "chainlink-32px-32px.png^barbwire-32px-32px.png",
    },
    use_texture_alpha = "clip",
    node_box = combined_nodebox,
    selection_box = combined_selectionbox,
})

-- Crafting Recipes
minetest.register_craft({
    output = "barbwire_fence:chainlink 4",
    recipe = {
        {"default:steel_ingot", "default:steel_ingot", "default:steel_ingot"},
        {"default:steel_ingot", "", "default:steel_ingot"},
        {"default:steel_ingot", "", "default:steel_ingot"},
    }
})

minetest.register_craft({
    output = "barbwire_fence:barbwire 4",
    recipe = {
        {"default:steel_ingot", "default:stick", "default:steel_ingot"},
        {"default:steel_ingot", "default:stick", "default:steel_ingot"},
        {"", "", ""},
    }
})

minetest.register_craft({
    output = "barbwire_fence:chainlink_barbwire 4",
    recipe = {
        {"default:steel_ingot", "default:stick", "default:steel_ingot"},
        {"default:steel_ingot", "default:steel_ingot", "default:steel_ingot"},
        {"default:steel_ingot", "", "default:steel_ingot"},
    }
})

-- Craft reverse recipes (fence back to ingots)
minetest.register_craft({
    type = "fuel",
    recipe = "barbwire_fence:chainlink",
    burntime = 2,
})

minetest.register_craft({
    type = "fuel",
    recipe = "barbwire_fence:barbwire",
    burntime = 2,
})

minetest.register_craft({
    type = "fuel",
    recipe = "barbwire_fence:chainlink_barbwire",
    burntime = 2,
})

minetest.log("action", "[Barbwire Fence] Mod loaded successfully!")
