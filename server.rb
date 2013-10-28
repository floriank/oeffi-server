require "java"
require "grape"
require "json"
require "oeffi"

require File.expand_path(File.join(*%w[ lib/api ]), File.dirname(__FILE__))

Oeffi.configure do |oeffi|
  oeffi.provider = :nasa
end

module API
  class LVB < Grape::API

    format :json

    rescue_from :all do |e|
      Rack::Response.new({ error: "#{e.message}"}.to_json, 500, { "Content-type" => "application/json" })
    end

    mount API::Stations

    get "/" do
      {identifier: "oeffi-api", version: Oeffi::VERSION}
    end
  end
end
