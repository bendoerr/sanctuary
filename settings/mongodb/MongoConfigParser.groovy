def settingsFile = new File(/${System.getenv("DEV_STTGS")}\mongodb\mongo.conf/)

def settings = settingsFile.text
settings = settings.replace("@dbpath@", /${System.getenv("MONGODB_DATA_LOCATION")}/)
settings = settings.replace("@logpath@", /${System.getenv("MONGODB_LOG_FILE")}/)

settingsFile.write(settings)