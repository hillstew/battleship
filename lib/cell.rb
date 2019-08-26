
class Cell
  attr_reader   :coordinate
  attr_accessor :ship

  def initialize(coordinate)
    @coordinate = coordinate
    @ship = nil
    @hit_status = false
  end

  def empty?
    @ship == nil
  end

  def place_ship(ship)
    @ship = ship
  end

  def fire_upon
    # if empty? #only if you have a ship
      @hit_status = true
      @ship.hit unless empty?
    # end
  end

  def fired_upon?
    @hit_status
  end

  #New implementation
  def render(reveal_ship=false)
    if fired_upon?
      if (empty? == false)
        if @ship.sunk?
          "X"
        else
          "H"
        end
      else
        "M"
      end
    elsif reveal_ship == true && empty? == false
      "S"
    else
      "."
    end
  end

  # original implementation
  # def render(reveal_ship=false)
  #   if reveal_ship == false && empty? == false
  #
  #     if fired_upon? == false
  #       '.'
  #     elsif fired_upon? && @ship.sunk? == false
  #       'H'
  #     elsif @ship.sunk?
  #       'X'
  #     end
  #
  #   elsif reveal_ship && empty? == false
  #     'S'
  #   else
  #     'M'
  #   end
  # end
end
