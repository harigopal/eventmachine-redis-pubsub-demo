require 'em-hiredis'
require 'em-http-request'
require 'eventmachine'

EventMachine.run do
  client = EM::Hiredis.connect
  pubsub = client.pubsub
  pubsub.subscribe('em_synchrony_demo_channel').callback { puts 'Subscribed to em_synchrony_demo_channel!' }

  pubsub.on(:message) do |channel, msg|
    puts "Received new message: #{msg}"
    t1 = Time.now.strftime('%H:%M:%S')
    http = EventMachine::HttpRequest.new("http://localhost:3000?value=#{msg}").get
    http.callback { puts "Response for message #{msg} [#{t1} to #{Time.now.strftime('%H:%M:%S')}]: #{http.response}" }
  end
end
