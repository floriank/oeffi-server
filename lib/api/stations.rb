module API
  class Stations < Grape::API
    params do
      requires :name, type: String, desc: "Name of a possible station/address/etc."
    end
    post "/suggest" do
      status 200
      Oeffi::autocomplete(params.name)
    end

    params do
      requires :from, desc: "Station for from"
      requires :to,  desc: "Station  for to"
      optional :via, desc: "Optional Via Station"
      optional :count,  desc: "Optional number of connections"
      optional :date,  desc: "Optional date to be used as departure/arrival time"
      optional :departure,  desc: "Optional departure flag, if set to false, the date given is considered arrival time"
    end
    post "/trips" do
      status 200
      trips = Oeffi::find_trips(params)
    end
  end
end

