require "java"
require "lib/public-enabler.jar"
require "lib/org.json.jar"
require "lib/kxml2.jar"


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
fromType     = Api::LocationType::ANY
fromLocation = Api::Location.new(fromType, 0, nil, "Halle(Saale)Hbf")
toType       = Api::LocationType::ANY
toLocation   = Api::Location.new(toType, 0, nil, "Leipzig Hbf")

trips = provider.queryTrips fromLocation, nil, toLocation, date, true, 4, Api::Product::ALL, Api::NetworkProvider::WalkSpeed::NORMAL, Api::NetworkProvider::Accessibility::NEUTRAL, nil

from = trips.ambiguousFrom.to_a.shuffle.take(1).first

trips = Api::query from, toLocation

to = trips.ambiguousTo.to_a.first

p "Querying #{from.name} (#{from.type}) to #{to.name} (#{to.type}) at #{Time.now}"
trips = Api::query from, to

p trips.trips.to_a
