class Cell
  attr_reader :coordinate
  attr_accessor :ship

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
    @ship.hit unless empty? #only if you have a ship
  end

  def fired_upon?
    @hit_status
  end

  def render(reveal_ship=false)
    if reveal_ship == false && !empty?
      if fired_upon? == false
        '.'
      elsif fired_upon? && !@ship.sunk?
        'H'
      elsif @ship.sunk?
        'X'
      end
    elsif reveal_ship
      'S'
    elsif empty?
      'M'
    end
  end
end
