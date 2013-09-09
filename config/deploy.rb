set :stages, %w(staging production)
set :default_stage, "production"

set :application, "copytestapp"
set :deploy_in, "/home/barouf/app.dglaymann.com"

set :scm, :git
set :repository,  "git@github.com:franck/#{application}.git"
set :branch, "master"
set :deploy_via, :remote_cache

set :user, "barouf"
set :admin_runner, "barouf"

set :use_sudo, false
set :keep_releases, 2
set :git_shallow_clone, 1

# set :scm, :git # You can set :scm explicitly or Capistrano will make an intelligent guess based on known version control directory names
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`

set :hostname, "app.dglaymann.com"
role :app, "#{hostname}"
role :web, "#{hostname}"
role :db, "#{hostname}", :primary => true

task :production do
  set :deploy_to, "#{deploy_in}/#{application}/app"
  set :env, "production"
  # Deploy to production site only from stable branch
  set :branch, "stable"
end

task :staging do
  set :deploy_to, "#{deploy_in}/#{application}/staging"
  set :env, "staging"
end


# if you want to clean up old releases on each deploy uncomment this:
# after "deploy:restart", "deploy:cleanup"

# if you're still using the script/reaper helper you will need
# these http://github.com/rails/irs_process_scripts

# If you are using Passenger mod_rails uncomment this:
namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end
end
