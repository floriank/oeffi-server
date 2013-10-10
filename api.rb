require "java"
require "lib/vendor/public-enabler.jar"
require "lib/vendor/org.json.jar"
require "lib/vendor/kxml2.jar"


module Api
  include_package "de.schildbach.pte"
  include_package "de.schildbach.pte.dto"
  def self.query(from, to, via=nil, connections=4)
    provider = NasaProvider.new
    date     = Java::JavaUtil::Date.new
    provider.queryTrips from, nil, to, date, true, 4, Api::Product::ALL, Api::NetworkProvider::WalkSpeed::NORMAL, Api::NetworkProvider::Accessibility::NEUTRAL, nil
  end
end

date         = Java::JavaUtil::Date.new
provider     = Api::NasaProvider.new
fromType     = Api::LocationType::STATION
fromLocation = Api::Location.new(fromType, 12996)
toType       = Api::LocationType::STATION
toLocation   = Api::Location.new(toType, 13000)

trips = provider.queryTrips fromLocation, nil, toLocation, date, true, 2, Api::Product::ALL, Api::NetworkProvider::WalkSpeed::NORMAL, Api::NetworkProvider::Accessibility::NEUTRAL, nil

trips = trips.trips.to_a.collect do |trip|
  {
    id: trip.id,
    numChanges: trip.numChanges,
    departure: trip.get_first_departure_time.to_gmt_string
  }
end

p trips

# from = trips.ambiguousFrom.to_a.shuffle.take(1).first

# trips = Api::query from, toLocation

# to = trips.ambiguousTo.to_a.first

# p "Querying #{from.name} (#{from.type}) to #{to.name} (#{to.type}) at #{Time.now}"
# trips = Api::query from, to

# p trips.trips.to_a
