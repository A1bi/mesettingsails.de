def template(from, to)
	erb = File.read(File.expand_path("../templates/#{from}", __FILE__))
	put ERB.new(erb).result(binding), to
end

def set_default(name, *args, &block)
  set(name, *args, &block) unless exists?(name)
end

namespace :deploy do
  task :install do
		%w[config media].each do |dir|
    	run "mkdir -p #{shared_path}/#{dir}"
		end
  end
	
  desc "Symlink media folder"
  task :symlink_media, roles: :app do
    run "ln -nfs #{shared_path}/media #{current_release}/media"
  end
  after "deploy:finalize_update", "deploy:symlink_media"
  
  desc "Symlink secrets.yml"
  task :symlink_secrets, roles: :app do
    run "touch #{shared_path}/config/secrets.yml"
    run "ln -nfs #{shared_path}/config/secrets.yml #{current_release}/config/secrets.yml"
  end
  after "deploy:finalize_update", "deploy:symlink_secrets"
end