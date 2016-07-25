#!/usr/bin/env ruby

# file: sps_chat-cli.rb


require 'sps_chat'
require 'io/console'


CTRLC = "\u0003"
BACKSPACE = "\u007F"

class SPSChatCli < SPSChat

  def initialize(host: '127.0.0.1', port: '8080', \
                  userid: 'user' + (0..1000).to_a.sample.to_s, room: '')

    super(host: host, port: port, userid: userid, room: room)
    terminate = false
    sleep 1
    print "\r\n"

    loop do

      s = ''

      print "\r> "

      begin

        c = $stdin.getch
        (terminate = true; break) if c == CTRLC

        unless c == BACKSPACE then
          s += c 
          print c
        else
          s.chop!
          print "\r>  " + ' ' * s.length
          print "\r> " + s
        end
      end until c == "\r" or terminate

      break if terminate

      send s
      print "\r" + @userid + '> ' + s + "\n"
    end 
  end

  def onincoming(sender, msg)
    s = ''
    print "\r%s> %s\n" % [sender.strip, msg]
    print "\r> "
  end

end

