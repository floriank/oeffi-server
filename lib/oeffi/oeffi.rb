require "java"
require "lib/vendor/public-enabler.jar"
require "lib/vendor/org.json.jar"
require "lib/vendor/kxml2.jar"

module Oeffi
  include_package "de.schildbach.pte"
  include_package "de.schildbach.pte.dto"

  def self.provider
    NasaProvider.new
  end

  def self.autocomplete(string)
    possibleStations= []
    provider.autocompleteStations(string).to_a.map do |station|
      possibleStations << {
        :name => station.name,
        :id   => station.id,
        :type => station.type
      }
    end

    return possibleStations
  end

  def self.query(from, to, via = nil, connections=4)
    date         = Java::JavaUtil::Date.new

    fromLocation = convert from
    toLocation   = convert to
    viaLocation  = convert via unless via.nil?

    result = provider.queryTrips(fromLocation, viaLocation, toLocation, date, true, 4, Product::ALL, NetworkProvider::WalkSpeed::NORMAL, NetworkProvider::Accessibility::NEUTRAL, nil)

    trips = result.trips.to_a.collect do |trip|
      {
        id: trip.id,
        numChanges: trip.numChanges,
        departure: trip.get_first_departure_time.to_gmt_string
      }
    end

    return trips
  end

  def self.convert(station)
    type = LocationType::STATION
    return Location.new(type, station.id)
  end
end