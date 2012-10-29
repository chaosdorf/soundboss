require 'bundler/capistrano'

set :application,     "soundboss"
set :deploy_to,       '/srv/http/soundboss/'
set :deploy_via,      :remote_cache
set :main_server,     "webserver.chaosdorf.dn42"
set :repository,      "https://github.com/chaosdorf/soundboss.git"
set :scm, :git
set :use_sudo,        false
set :user,            "http"
set :default_environment, {
  'GEM_HOME' => "$HOME/.gem",
  'PATH' => "$PATH:$HOME/.gem/ruby/1.9.1/bin"
}
role :app, "webserver.chaosdorf.dn42"

namespace :deploy do
  task :restart do
    run "touch #{release_path}/tmp/restart.txt"
    run "cd #{release_path}; kill `ps -u #{user}|awk '/ruby/{print $1}'` || echo 'nothing to kill'"
    run "screen -wipe || echo 'no screens to wipe'"
    run "cd #{release_path}; screen -AmdS websocket bundle exec ruby server.rb"
  end
end
