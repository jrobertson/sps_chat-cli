#!/usr/bin/env ruby

# file: sps_chat-cli.rb


require 'sps_chat'
require 'io/console'


CTRLC = "\u0003"
BACKSPACE = "\u007F"

class SPSChatCli < SPSChat

  def initialize(host: '127.0.0.1', port: '8080', \
                  userid: 'user' + (0..1000).to_a.sample.to_s, room: '', typing_mode: false)

    super(host: host, port: port, userid: userid, room: room)
    
    @userid, @typing_mode = userid, typing_mode
    terminated = false
    @user, @history = {}, []
    
    sleep 1
    print "\r\n"

    loop do

      @s = ''

      print "\r#{userid}> "

      begin

        c = $stdin.getch
        (terminated = true; break) if c == CTRLC
        
        if typing_mode then
          
          unless c == "\r" then
            typing c 
          else
            c = "\n"            
            @history << "#{userid}> " + @s
            send @s            
          end
        end

        @s = savebuffer @s, c
        print "\r#{@userid}>  " + ' ' * @s.length if c == BACKSPACE
        print "\r#{@userid}> " + @s 
        
      end until c == "\r" or c == "\n" or terminated

      break if terminated
      
      unless typing_mode then
        print "\r" + @userid + '> ' + @s + "\n"
        send @s
      end

    end 
  end

  def onincoming(sender, msg, typing_mode=false)    
    
    if @typing_mode then

      if msg.length <= 1 then
        c = msg                

        @user[sender] ||= ''
        @user[sender] = savebuffer @user[sender], c             
        print "\e[H\e[2J"
        print "\r\n" + @history.join("\r\n") + "\r\n"
      else        
        c = "\n"
        @history << "#{sender}> " + @user[sender]
        @user[sender] = ''
      end
 
      @user.each do |u, s|
        print "\r\r#{u}> " + s  + "\n" unless s.empty?
      end

      print "\r#{@userid}> " + @s  
      
    else
      print "\r%s> %s\n" % [sender, msg]
      print "\r%s> " % @userid
    end
  end
  
  def savebuffer(s, c='')
    
    c == BACKSPACE ?  s.chop! : s += c 
    
    return s
  end
  
  

end