set :application, 'nudge'
set :repository,  'git@github.com:freelancing-god/nudge.git'
set :user,        'nudge'
set :branch,      'master'
set :use_sudo,    false
set :domain,      'nudge.domain.tld'

# If you aren't deploying to /u/apps/#{application} on the target
# servers (which is the default), you can specify the actual location
# via the :deploy_to variable:
set :deploy_to, "/var/www/#{application}"

# If you aren't using Subversion to manage your source code, specify
# your SCM below:
set :scm, :git

role :app, domain
role :web, domain
role :db,  domain, :primary => true

namespace :deploy do
  task :start, :roles => :app do
    run "touch #{current_release}/tmp/restart.txt"
  end
  
  task :stop, :roles => :app do
    # Do nothing
  end
  
  task :restart, :roles => :app do
    run "touch #{current_release}/tmp/restart.txt"
  end
end

after 'deploy:setup' do
  run "mkdir -p #{shared_path}/db"
end

after 'deploy:symlink' do
  run "ln -nfs #{shared_path}/db #{release_path}/db"
end
