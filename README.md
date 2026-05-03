# Barbwire Fence Mod for Luanti/Minetest

A 2-block high barbwire fence mod with chain-link and barbwire elements.

## Required Graphics

You need to create **only 3 texture files** (plus 1 optional wield image):

### Required Textures (16x16 pixels each):

1. **`barbwire_fence_chainlink.png`** (16x16)
   - Chain-link fence pattern
   - Should show the diamond mesh pattern typical of chain-link fences
   - Use gray/silver colors with some transparency for the holes

2. **`barbwire_fence_barbwire.png`** (16x16)
   - Barbwire strand texture
   - Show twisted wire with barbs/spikes
   - Dark gray or metallic color
   - Can be a horizontal strand with visible barbs

3. **`barbwire_fence_chainlink_barbwire.png`** (16x16)
   - Combined texture showing both chain-link AND barbwire together
   - Chain-link on bottom half, barbwire strands on top
   - This is used for the transition area

### Optional (but recommended):

4. **`barbwire_fence_wield.png`** (16x16 or 32x32)
   - Inventory/wield image
   - Can be a small preview of the fence
   - If not provided, the game will use a default representation

## Texture Specifications

- **Format**: PNG with alpha channel (transparency)
- **Size**: 16x16 pixels (standard Minetest/Luanti texture size)
- **Color Palette**: Grays, silvers, metallic tones
- **Style**: Pixel art consistent with default game textures

## Features

- **2-blocks high on placement** - No need to stack multiple nodes
- **See-through design** - Like steelgrid, allows visibility and projectiles through gaps
- **Collision detection** - Players and mobs cannot walk through, but arrows/arrows can pass
- **Rotatable** - Faces the direction you're looking when placed
- **Craftable** - Uses steel ingots and sticks

## Installation

1. Create the texture files listed above in the `textures/` folder
2. Ensure `mod.conf` is present (already included)
3. Enable the mod in your world's `world.mt` or mod configuration

## Crafting Recipe

```
Steel Ingot | Steel Ingot | Steel Ingot
Steel Ingot | Stick       | Steel Ingot  
Steel Ingot | Stick       | Steel Ingot
```

Produces 4 barbwire fence items.

## License

[Your license here]
