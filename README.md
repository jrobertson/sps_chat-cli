# Introducing the sps_chat-cli gem

The sps_chat-cli gem is used for interactive chat using a command-line interface. 

## Setting up the SPS broker

In order for chat to work you need to install and run the SPS broker (simplepubsub gem) e.g.

    require 'simplepubsub'

    SimplePubSub::Broker.start host: '127.0.0.1', port: 8080


## Creating a user and connecting to the chat service

To connect to the chat service run the following code either in an IRB session or from an executable Ruby script file:

    require 'sps_chat-cli' 

    SPSChatCli.new typing_mode: true

Notes:

* If a userid is not supplied as a named keyword then a random userid will be created
* The default host is 127.0.0.1
* The default port is 8080
* *typing_mode* set to true allows each chat user can see the other user's message as they type it.

## Demo

Here's a short video of 3 chat users chatting with other:


Note: The chat sessions were displayed all in 1 window using the terminal multiplexer program called *screen*.

!v[](http://www.jamesrobertson.eu/r/videos/2016/jul/27/sps_chat-cli.ogv)

## Resources

* sps_chat-cli https://rubygems.org/gems/sps_chat-cli

sps_chat chat typing simplepubsub sps
