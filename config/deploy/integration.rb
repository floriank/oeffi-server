set :default_environment, {
  "TMPDIR"     => "/home/deployer"
}
server "ryuk.it.ewerk.com", :web, :app, :primary => true

set :user, "deployer"
set :branch, "HEAD"

set :keep_releases, "2"
set :rails_env, stage
set :use_sudo, false

deployer_key = File.expand_path("~/.ssh/deployer-ryuk.pem")

ssh_options[:keys] = [deployer_key]
