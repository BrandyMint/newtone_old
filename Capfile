require "bundler/setup"
load 'deploy'
# Uncomment if you are using Rails' asset pipeline
load 'deploy/assets'
load 'config/deploy' # remove this line to skip loading any of the default tasks

namespace :solr do
  desc "Выполняет rake sunspot:reindex"
  task :reindex do
    #run "cd #{current_path} && #{rake} RAILS_ENV=#{rails_env} sunspot:reindex"
  end

  desc "Запускает фонове выполнение rake sunspot:reindex"
  task :background do
    #run "cd #{current_path} && exec nohup #{rake} RAILS_ENV=#{rails_env} sunspot:reindex > /tmp/sunspot_reindex.log < /dev/null 2>&1 & "
  end
end