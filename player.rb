require_relative 'animation'
require_relative 'map'

class Player
  attr_reader :life
  attr_reader :moving
  attr_reader :facing
  attr_reader :x
  attr_reader :y
  attr_reader :tile

  def initialize(x, y)
    @map = Map.new
    @tile = 0
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

    @movements = {:left => -3.0, :right => 3.0, :up => -3.0, :down => 3.0}

    @moving = false
    @facing = :left

  end

  def warp(x, y)
    @x, @y = x, y
  end
  

  def draw
    @map.draw @tile
    if @moving
      @move[@facing].start.draw @x, @y, 1, 2, 1
    else
      @rest[@facing].draw @x, @y, 1, 2, 1
    end
  end

  def move(direction)
    if direction == :up and @y <= 5 and @tile <= 3
      @y = 5
    elsif direction == :down and @y >= 507 and @tile >= 11
      @y = 507
    elsif direction == :left and @x <= 5 and @tile % 4 == 0
      @x = 5
    elsif direction == :right and @x >= 507 and @tile % 4 == 3
      @x = 507
    elsif direction == :up or direction == :down
      @y += @movements[direction]
      if @y >= 512
        @tile+=4
        @y = 5
      elsif @y <= 0
        @tile-=4
        @y = 507
      end
    elsif direction == :left or direction == :right
      @x += @movements[direction]
      if @x >= 512
        @tile+=1
        @x = 5
      elsif @x <= 0
        @tile-=1
        @x = 507
      end
      
    end

    @facing = direction
    @moving = true if @moving != true
  end

  def stop_move
    @moving = false if @moving != false
  end

end
