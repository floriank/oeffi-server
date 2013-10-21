require "java"

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
    result.trips.to_a
  end

  def self.convert(station)
    type = LocationType::STATION
    return Location.new(type, station[:id])
  end
end