Dir.glob File.expand_path("lib/oeffi/*.rb") do |file|
  require file
end
require "ruby-debug"

module API
  class Stations < Grape::API
    params do
      requires :name, type: String, desc: "Name of a possible station/address/etc."
    end
    post "/search" do
      status 200
      ::Oeffi::autocomplete(params.name)
    end

    params do
      requires :from, desc: "Station for from"
      requires :to,  desc: "Station  for to"
      optional :via, desc: "Optional Via Station"
      optional :connections,  desc: "Optional number of connections"
    end

    post "/trips" do
      TripList.new(::Oeffi::query(params.from, params.to, params.via, params.connections)).as_json
    end
  end
end

