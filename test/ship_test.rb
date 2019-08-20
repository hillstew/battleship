require 'minitest/autorun'
require 'minitest/pride'
require './lib/ship'

class ShipTest < Minitest::Test

     def setup
          @cruiser = Ship.new("Cruiser", 3)
     end

     def test_it_exists
          assert_instance_of Ship, @cruiser
     end

     def test_it_has_attributes
          assert_equal "Cruiser", @cruiser.name
          assert_equal 3, @cruiser.length
          assert_equal 3, @cruiser.health
     end

     def test_method_sunk_initial
          assert_equal false, @cruiser.sunk?
     end

     def test_method_hit
          @cruiser.hit
          assert_equal 2, @cruiser.health
     end

     def test_method_sunk_true
          @cruiser.hit
          @cruiser.hit
          assert_equal true, @cruiser.sunk?
          assert_equal 0, @cruiser.health # do we need this test?
     end
end
