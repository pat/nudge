set :application, "prod"
set :repository,  "set your repository location here"

# If you aren't deploying to /u/apps/#{application} on the target
# servers (which is the default), you can specify the actual location
# via the :deploy_to variable:
set :deploy_to, "/var/www/#{application}"

# If you aren't using Subversion to manage your source code, specify
# your SCM below:
set :scm, :git

role :app, "prod.freelancing-gods.com"
role :web, "prod.freelancing-gods.com"
role :db,  "prod.freelancing-gods.com", :primary => true

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
