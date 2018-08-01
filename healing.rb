require 'gosu'
require_relative 'player'

class Healing < Gosu::Window

  def initialize
    super 640, 480
    self.caption = "Healing"

    @player = Player.new 320, 240

    @key = {kb_left: Gosu::KbLeft,
            kb_right: Gosu::KbRight,
            gp_left: Gosu::GpLeft,
            gp_right: Gosu::GpRight}
  end   

  def update
    if Gosu::button_down? @key[:kb_left] or Gosu::button_down? @key[:gp_left] then
      @player.move :left
    end
    if Gosu::button_down? @key[:kb_right] or Gosu::button_down? @key[:gp_right] then
      @player.move :right
    end
  end

  def draw
    @player.draw
  end

  def button_down(id)
    if id == Gosu::KB_ESCAPE
      close
    else
      super
    end
  end

  def button_up(id)
    if id == @key[:kb_left] or id == @key[:gp_left] then
      @player.stop_move
    end
    if id == @key[:kb_right] or id == @key[:gp_right] then
      @player.stop_move
    end
  end

end

Healing.new.show
