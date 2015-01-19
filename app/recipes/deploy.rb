#deploy the repo

deploy_path = "/srv/www/immweb/" #path where the application needs to be deployed
repository_path = "/home/jenkin/code" #path where the application resides (GIT or SVN or GITLAB)
sql_scripts_path = "/srv/www/immweb/sql/2014/en"

mysql_username = "AeriaDBUser"
mysql_password = "B3r1!n(0g4me$"
mysql_dbname = "ImmDev"
mysql_dbhost = "immdevdb.ciguidpxtyhi.eu-west-1.rds.amazonaws.com"

bash "deploy_to_document_root" do
	code <<-EOH
	for file in #{sql_scripts_path}/*
	do
	    mysql -u #{mysql_username} -p#{mysql_password} -h #{mysql_dbhost} #{mysql_dbname} < $file
	done
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
