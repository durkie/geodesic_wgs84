require "geodesic_wgs84/version"

module GeodesicWgs84
  def self.hi
    puts "Hello from geodesic_wgs84"
  end

  def self.length(coords)
    wgs84 = Wgs84.new
    raise "Requires a 2-dimensional array of coordinates (LINESTRING), or 3-dimensional array of LINESTRINGS (MULTILINESTRING)" if !coords.is_a? Array or !coords[0].is_a? Array
    # Treat LINESTRING 2-dim array as a MULTILINESTRING with a single item
    coords = [coords] if coords.dig(0,0).is_a? Float

    coords.map do |ls|
      points = ls.map(&:reverse)
      # [0] because wgs84.distance returns an array of distance
      points.each_cons(2).map {|pt1, pt2| (wgs84.distance pt1, pt2)[0] }.sum
    end.sum
  end
end

require "geodesic_wgs84/geodesic_wgs84"
