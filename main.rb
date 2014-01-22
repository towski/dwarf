require 'curses'
require 'channels'
require_relative 'fox'
require_relative 'display'
require 'ruby-debug'

Curses.init_screen()
Curses.noecho
Curses.curs_set(1)

$main_thread = Thread.current

class Main < MainChannel
  def initialize
    super
    add_subchannel(Fox.new){|response, sender| @display.write response }
    add_subchannel(Fox.new){|response, sender| @display.write response }
    @display = Display.new
    add_subchannel(@display){|response, sender|
      if response == "quit"
        puts "it's ova"
        exit
      end
    }
  end
end

Main.new
sleep
