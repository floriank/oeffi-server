Trinidad.configure do |config|
  case config.environment
    when "integration"
      config.port = 8182
      config.address = '0.0.0.0'
      config.jruby_max_runtimes = 2
    when "production"
      config.port = 8181
      config.address = '0.0.0.0'
      config.jruby_max_runtimes = 2
    else
      config.port = 3000
      config.address = '0.0.0.0'
      config.jruby_max_runtimes = 4
  end
end