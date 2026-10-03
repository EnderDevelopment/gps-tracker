Config = {}

-- General Settings
Config.Locale = 'en'
Config.Debug = false

-- Database Settings
Config.Database = {
    TableName = 'gps_trackers'
}

-- GPS Tracker Settings
Config.GPSTracker = {
    MaxTrackers = 5,
    UpdateInterval = 5000,
    BlipColor = 1,
    BlipScale = 1.0,
    NotificationSound = 'GPS_PING'
}

-- Admin Commands
Config.AdminCommands = {
    ReloadConfig = 'gpsreload',
    AddTracker = 'gpsadd',
    RemoveTracker = 'gpsremove'
}