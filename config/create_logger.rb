logger = Logger.new(STDERR)
logger = Logger.new(STDOUT)

# Create a logger for the file which has the specified name.

logger = Logger.new('/log/err.log')

# Create a logger for the specified file.

#file = File.open('/log/crawl.log', File::WRONLY | File::APPEND)

# To create new (and to remove old) logfile, add File::CREAT like;
file = open('/log/err.log', File::WRONLY | File::APPEND | File::CREAT)

logger = Logger.new(file)