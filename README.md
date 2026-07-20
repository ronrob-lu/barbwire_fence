# Barbwire Fence Mod for Luanti/Minetest

> [!IMPORTANT]
> ⚠️ **Development Note:** This mod is now part of the larger **[Enclave Mod](https://github.com/ronrob-lu/enclave)** project and is no longer developed as a standalone mod.
> 
> **Original Author:** [ronrob-lu](https://github.com/ronrob-lu) (2026)

This mod adds realistic, 2-block high defensive fences to Luanti/Minetest. It includes chain-link elements, barbwire strands, and combined security fences to secure your bases and borders.

---

## Features

- **2-Blocks High**: All fences stand 2 blocks tall upon placement, meaning you only need to place one node to create a secure perimeter.
- **See-Through Design**: Allows visibility, light, and projectiles (such as arrows) to pass through while keeping mobs and players out.
- **Collision Physics**: Fully prevents players and mobs from walking through the fence.
- **Facedir Rotatable**: Fences automatically face the direction you are looking when placed, and support rotation using the Screwdriver tool.
- **Craftable**: Made using standard survival items (Steel Ingots and Sticks).

---

## Blocks & Items

| Block Name | Description | Command to Give |
| :--- | :--- | :--- |
| **Chainlink Fence**<br>`barbwire_fence:chainlink` | A clean, metal diamond-mesh fence. | `/giveme barbwire_fence:chainlink` |
| **Barbwire Strand**<br>`barbwire_fence:barbwire` | A set of three horizontal barbwire strands with sharp spikes on top. | `/giveme barbwire_fence:barbwire` |
| **Chainlink Fence with Barbwire**<br>`barbwire_fence:chainlink_barbwire` | A heavy-duty security fence combining a chainlink base with barbwire strands on top. | `/giveme barbwire_fence:chainlink_barbwire` |

---

## Crafting Recipes

All recipes produce **4** fence blocks.

### 1. Chainlink Fence
```
[Steel Ingot] [Steel Ingot] [Steel Ingot]
[Steel Ingot] [           ] [Steel Ingot]
[Steel Ingot] [           ] [Steel Ingot]
```

### 2. Barbwire Strand
```
[Steel Ingot] [  Stick  ] [Steel Ingot]
[Steel Ingot] [  Stick  ] [Steel Ingot]
[           ] [         ] [           ]
```

### 3. Chainlink Fence with Barbwire
```
[Steel Ingot] [  Stick  ] [Steel Ingot]
[Steel Ingot] [Steel Ingot] [Steel Ingot]
[Steel Ingot] [         ] [Steel Ingot]
```

---

## Installation

1. Copy this folder into your Luanti/Minetest `mods` directory (rename the folder to `barbwire_fence`).
2. Enable the mod in your world configuration or menu.
3. Start or reload your world.

---

## Requirements

- **Luanti** (formerly Minetest) 5.0.0 or newer.

---

## License & Credits

- **Code**: MIT License (Copyright (c) 2026 ronrob-lu) - see [LICENSE.md](LICENSE.md)
- **Graphics/Textures**: CC0 1.0 Universal (Public Domain) - see [LICENSE.md](LICENSE.md)
- **Design & Assets**: Created by [ronrob-lu](https://github.com/ronrob-lu).
