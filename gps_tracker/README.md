# GPS Tracker System

A FiveM resource for GPS tracking using ESX Legacy framework.

## Features

- Phone-style GPS tracker NUI
- Frequency creation/joining
- Live position sharing
- Custom blips
- MySQL tables
- Server-side validation
- Real-time updates
- Configurable settings
- Localization
- Admin commands
- Ping feature
- Sound notifications

## Installation

1. Download the resource.
2. Place the `gps_tracker` folder in your FiveM server's `resources` directory.
3. Add `ensure gps_tracker` to your server.cfg file.
4. Run the `database.sql` script to create the necessary tables.

## Configuration

Edit the `config.lua` file to customize the resource settings.

## Usage

- Use the NUI interface to create and join trackers.
- Use the ping feature to notify other members of your position.

## Dependencies

- es_extended
- ox_lib
- ox_inventory
- oxmysql

## License

This resource is licensed under the MIT License.