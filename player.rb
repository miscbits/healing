require_relative 'animation'

class Player
  attr_reader :life

  def initialize(x, y)
    @frames = Gosu::Image.load_tiles 'media/Fumiko.png', 24, 32
    @x, @y = x, y
    print @frames

    @move = {
      :left  => Animation.new(@frames[0..5], 0.1),
      :up    => Animation.new(@frames[0..5], 0.2),
      :down  => Animation.new(@frames[0..3], 0.2),
      :right => Animation.new(@frames[0..287], 0.2)
    }

    @movements = {:left => -1.0, :right => 2.0, }

    @moving = false
    @facing = :left

  end

  def warp(x, y)
    @x, @y = x, y
  end
  

  def draw
    if @moving
      @move[@facing].start.draw @x, @y, 1
    else
      @move[@facing].stop.draw @x, @y, 1
    end
  end

  def move(direction)
    @x += @movements[direction]
    @x %= 640
    
    @facing = direction
    @moving = true if @moving != true
  end

  def stop_move
    @moving = false if @moving != false
  end

end
