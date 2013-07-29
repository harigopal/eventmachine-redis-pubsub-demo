# What is this?

This is a demonstration of Eventmachine and Redis Pub/Sub, with focus on the EM part.

# Requirements

*  Redis (running on default port)

# How do I run it?

    # Install required gems.
    $ bundle

    # Run the web server on port 3000, the processor, and the client (on different terminals)
    $ puma -p 3000
    $ ruby lib/processor.rb
    $ ruby lib/client.rb

# What does it do?

There are three components here:

## Client

A client application which publishes a random number into entry into redis every second.

## Processor

A processing application which is subscribed to what the client publishes, calls a webserver with received value, and
prints the response.

## Web Server

It recieves a request, sleeps for 5 seconds and responds with a hello world message that includes supplied value.

# So, what's eventmachine doing here?

Decoupling URL calls from processing of the subscribed Redis channel. Without EM, each URL call would block processing
of the application for five seconds, and it wouldn't be able to print one response per second. There's still an
unavoidable initial delay of five seconds, since that's how long it takes for the first response to arrive.
