#deploy the repo

deploy_path = "/srv/www/immweb/" #path where the application needs to be deployed
repository_path = "/home/jenkin/code" #path where the application resides (GIT or SVN or GITLAB)

deploy deploy_path do
	user "deploy"
	group "apache"
	repository_cache repository_path
	symlink_before_migrate ({})
	symlinks ({})

	restart_command "/etc/init.d/httpd restart"
end
