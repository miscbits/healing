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

    left  = Gosu::Image.load_tiles('media/run-left.png', 24, 32)
    up    = Gosu::Image.load_tiles('media/run-up.png', 24, 32)
    down  = Gosu::Image.load_tiles('media/run-down.png', 24, 32)
    right = Gosu::Image.load_tiles('media/run-right.png', 24, 32)


    @move = {
      :left  => Animation.new(left[1...4], 0.1),
      :up    => Animation.new(up, 0.1),
      :down  => Animation.new(down[1...5], 0.12),
      :right => Animation.new(right[1...4], 0.1)
    }

    @rest = {
      :left  => left[0],
      :up    => up[0],
      :down  => down[0],
      :right => right[0]
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
      @move[@facing].start.draw @x, @y, 1, 2, 2
    else
      @rest[@facing].draw @x, @y, 1, 2, 2
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
