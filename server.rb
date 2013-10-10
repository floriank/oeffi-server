require "java"
require "grape"
require "json"
require "lib/api"

require File.expand_path(File.join(*%w[ lib/api ]), File.dirname(__FILE__))

module API
  class LVB < Grape::API

    format :json

    rescue_from :all do |e|
      Rack::Response.new({ error: "#{e.message}"}.to_json, 500, { "Content-type" => "application/json" })
    end

    mount API::Stations

    get "/" do
      {identifier: "lvb-fahrplan-api", version: "0.0.1"}
    end
  end
end
