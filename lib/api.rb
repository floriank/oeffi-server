Dir["lib/vendor/*.jar"].each do |file|
  require File.expand_path file
end

require File.expand_path "lib/api/stations"
