require 'gosu'
require_relative 'player'

class Healing < Gosu::Window

  def initialize
    super 640, 480
    self.caption = "Healing"

    @player = Player.new 320, 240

    @key = {kb_left: Gosu::KbLeft,
            kb_right: Gosu::KbRight,
            kb_up: Gosu::KbUp,
            kb_down: Gosu::KbDown,
            gp_left: Gosu::GpLeft,
            gp_up: Gosu::GpUp,
            gp_down: Gosu::GpDown,
            gp_right: Gosu::GpRight}
  end   

  def update
    if Gosu::button_down? @key[:kb_up] or Gosu::button_down? @key[:gp_up] then
      @player.move :up
    end
    if Gosu::button_down? @key[:kb_right] or Gosu::button_down? @key[:gp_right] then
      @player.move :right
    end
    if Gosu::button_down? @key[:kb_down] or Gosu::button_down? @key[:gp_down] then
      @player.move :down
    end
    if Gosu::button_down? @key[:kb_left] or Gosu::button_down? @key[:gp_left] then
      @player.move :left
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
    if id == @key[:kb_up] or id == @key[:gp_up] then
      @player.stop_move
    end
    if id == @key[:kb_down] or id == @key[:gp_down] then
      @player.stop_move
    end
  end

end

Healing.new.show
