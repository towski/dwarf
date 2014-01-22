class Display < Channel
  attr_accessor :win
  def run
    my_str = "f"
    @win = Curses::Window.new( Curses.lines, Curses.cols, 0, 0)
    @win.box("|", "-")
    @cursor_y = 2
    @cursor_x = 3
    @win.setpos(@cursor_y, @cursor_x)
    # or even
    #win << "u" 
    @win.refresh

    Thread.new {
      loop do
        @win.refresh
        sleep 0.1
      end
    }

    channel = Channel.new {
      loop do
        key = @win.getch
        case key
        when "w"
          @win.setpos(@cursor_y -= 1, @cursor_x)
        when "s"
          @win.setpos(@cursor_y += 1, @cursor_x)
        when "d"
          @win.setpos(@cursor_y, @cursor_x += 1)
        when "a"
          @win.setpos(@cursor_y, @cursor_x -= 1)
        when "q"
          self.write "quit"
          break
        end
      end
    }

    loop do
      response = self.read
      if response == "quit"
        write_out("quit")
        @win.close
        return
      else
        move_char response
      end
    end
  end

  def move_char hash
    Curses.curs_set(0)
    @win.setpos(hash[:old_x], hash[:old_y])
    @win.addstr(" ")
    @win.setpos(hash[:x], hash[:y])
    @win.addstr(hash[:char])
    Curses.curs_set(1)
    @win.setpos(@cursor_y, @cursor_x)
  end
end
