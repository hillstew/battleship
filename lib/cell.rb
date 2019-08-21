class Cell
  attr_reader :coordinate, :ship

  def initialize(coordinate)
    @coordinate = coordinate
    @ship = nil
    @hit_status = false
  end

  def empty?
    @ship === nil
  end

  def place_ship(cruiser)
    @ship = cruiser
  end

  def fire_upon
    @hit_status = true
    @ship.hit
  end

  def fired_upon?
    @hit_status
  end

  def render(reveal_ship=false)
    if reveal_ship == false && @ship != nil
      if fired_upon? == false
        '.'
      elsif fired_upon? == true && @ship.health >= 1
        'H'
      elsif @ship.health == 0
        'X'
      end
    elsif reveal_ship == true
      'S'
    elsif @ship == nil
      'M'
    end
  end
end
