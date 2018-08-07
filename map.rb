class Map

    def initialize
        @map = Gosu::Image.load_tiles "media/kakariko_village.png", 256, 256
    end

    def draw(tile)
        @map[tile].draw 0, 0, 0, 2, 2
    end


end