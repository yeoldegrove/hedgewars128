# Hedgewars 128

**Hedgewars with 128 teams/players support** - A Nix flake overlay that patches the official Hedgewars game to support up to 128 teams instead of the default 8 teams.

## Overview

This repository provides a minimal overlay approach to building a patched version of Hedgewars. Instead of forking the entire Hedgewars source, it only contains:

- **Patches** - Source code patches that modify team limits from 8 → 128
- **Nix configuration** - A `flake.nix` and `hedgewars128.nix` that apply patches via `overrideAttrs`
- **Assets** - Custom game logo for the 128-team version

The patches are applied on top of the official Hedgewars package from nixpkgs `nixos-26.05`.

## Quick Start

### Build and run

```bash
nix run github:yeoldegrove/hedgewars128
```

### Build only

```bash
nix build github:yeoldegrove/hedgewars128
./result/bin/hedgewars
```

### Run specific components

```bash
# Run the game engine
nix run github:yeoldegrove/hedgewars128#hwengine

# Run the server
nix run github:yeoldegrove/hedgewars128#hedgewars-server
```

## Local development

```bash
git clone https://github.com/yeoldegrove/hedgewars128.git
cd hedgewars128
nix develop
```

## What's changed?

The patches modify the following constants and arrays:

- `cMaxTeams`: Changed from 8 → 128 in all frontends, servers, and game engine
- `ClanColorArray`: Extended from 9 colors to 128 distinct team colors
- Server limits: Updated validation messages and checks for 128 teams
- Frontend limits: Updated Qt5/Qt6 frontends to support 128 teams

Files patched:
- `QTfrontend/hwconsts.cpp.in`, `QTfrontend/hwconsts.h`
- `frontend-qt6/hwconsts.cpp`
- `gameServer/Consts.hs`, `gameServer/CoreTypes.hs`, `gameServer/HWProtoInRoomState.hs`
- `hedgewars/uConsts.pas`, `hedgewars/uVariables.pas`
- `project_files/frontlib/hwconsts.h`
- `rust/hedgewars-server/src/core/room.rs`, `rust/hedgewars-server/src/handlers/inroom.rs`

## Structure

```
hedgewars128/
├── flake.nix                    # Nix flake entry point
├── flake.lock                   # Locked nixpkgs dependencies
├── hedgewars128.nix             # Derivation using overrideAttrs
├── patches/
│   ├── 0001-support-128-teams.patch
│   └── 0002-fix-128-players-in-frontend.patch
├── assets/
│   └── HedgewarsTitle.png       # Custom logo
└── README.md
```

## Upstream

Based on [Hedgewars](https://hedgewars.org/) version 1.0.3 from nixpkgs.

## License

Hedgewars is licensed under GPL-2.0. This repository's patches follow the same license.
