require 'redis'
require 'enat'

client = Redis.new

# Let's push a random number into the Redis channel every second.
every 1.second do
  client.publish 'em_synchrony_demo_channel', rand(10000)
end
