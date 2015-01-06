#deploy the repo

deploy_path = "/srv/www/immweb/" #path where the application needs to be deployed
repository_path = "/home/jenkin/code" #path where the application resides (GIT or SVN or GITLAB)

bash "deploy_to_document_root" do
	code <<-EOH
	rm -rvf #{deploy_path}/current
	DAT=`date '+%Y%m%d%H%M%S'`
	mkdir -p #{deploy_path}/releases/$DAT
	mkdir -p #{deploy_path}/current
	cp -r #{repository_path}/* #{deploy_path}/releases/$DAT
	chown -R deploy:apache #{deploy_path}/*
	ln -s #{deploy_path}/releases/$DAT/* #{deploy_path}/current
	/etc/init.d/httpd restart
	EOH
end
