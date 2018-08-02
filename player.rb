require_relative 'animation'

class Player
  attr_reader :life
  attr_reader :moving
  attr_reader :facing
  attr_reader :x
  attr_reader :y

  def initialize(x, y)
    @frames = Gosu::Image.load_tiles 'media/Fumiko.png', 24, 32
    @x, @y = x, y

    @move = {
      :left  => Animation.new(@frames[20..25], 0.1),
      :up    => Animation.new(Gosu::Image.load_tiles('media/run-up.png', 24, 32), 0.1),
      :down  => Animation.new(@frames[0..3], 0.2),
      :right => Animation.new(@frames[0..287], 0.2)
    }

    @movements = {:left => -1.0, :right => 1.0, :up => -1.0, :down => 1.0}

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
    if direction == :up or direction == :down
      @y += @movements[direction]
      @y %= 480
    else
      @x += @movements[direction]
      @x %= 640
    end

    @facing = direction
    @moving = true if @moving != true
  end

  def stop_move
    @moving = false if @moving != false
  end

end
