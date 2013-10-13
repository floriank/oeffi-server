Dir["vendor/*.jar"].each do |file|
  require file
end

require File.expand_path "api/stations"
