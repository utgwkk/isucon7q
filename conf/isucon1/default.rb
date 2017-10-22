service 'nginx' do
  action [:start, :enable]
end

remote_file '/etc/nginx/sites-available/nginx.conf' do
  action :create
  notifies :reload, 'service[nginx]'
end

remote_file '/etc/systemd/system/isubata.ruby.service' do
  action :create
end
