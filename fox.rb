class Fox < Channel
  def run
    x = 30
    y = rand(30..34)
    write_out(:old_x => x, :old_y => y, :x => x, :y => y, :char => "f")
    loop do
      x_change = 0
      y_change = 0
      sleep rand(1.5..4.0)
      move = true
      case rand(0..8)
      when 0
        y_change = -1
        x_change = -1
      when 1
        y_change = 1
      when 2
        y_change = -1
        x_change = 1
      when 3
        x_change = 1
      when 4
        x_change = 1
        y_change = 1
      when 5
        y_change = 1
      when 6
        y_change = 1
        x_change = -1
      when 7
        x_change = -1
      else
      end
      if x_change != 0 && y_change != 0
      end
      write_out(:old_x => x, :old_y => y, :x => x + x_change, :y => y + y_change, :char => "f")
      x += x_change
      y += y_change
      x_change = 0
      y_change = 0
    end
  end
end
