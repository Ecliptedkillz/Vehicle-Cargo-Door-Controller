# Cargo Door Script for FiveM

## Description

This script provides a command to toggle cargo doors on specific whitelisted vehicles in FiveM. It's useful for immersive scenarios where cargo doors need to be opened or closed.

## Features

- Toggle cargo doors on whitelisted vehicles.
- Notification system for user feedback.

## Installation

1. Ensure you have the required permissions to use this script on your FiveM server.

2. Add the `vehicle-cargo-doors` folder to your FiveM server's resources directory.

3. Configure the script settings in `cargodoors.lua` if needed (e.g., whitelist specific vehicle models).

4. Add `start vehicle-cargo-doors` to your server.cfg file to ensure the script is started when your server launches.

5. Restart your FiveM server.

## Usage

### Command

- `/cargodoor`: Toggle cargo doors on the current vehicle.
- `/bombbay`: Toggle bomb bay doors on the current vehicle


## Configuration

You can customize the script by modifying the `cargodoors.lua` file. The `vehicleWhitelist` table contains vehicle models that are allowed to use the cargo door toggle.
