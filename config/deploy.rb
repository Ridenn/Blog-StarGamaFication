# Rodar com pty e sem sudo
set :pty, true
set :use_sudo, false

# Nome da aplicação
set :application, 'blog'

# Repositório para baixar e usar
set :repo_url, 'git@github.com:aschiavon91/Blog-StarGamaFication.git'

# Repare nesse caminho, eh o mesmo onde ficara o banco de dados da produção
set :deploy_to, '/home/blog/apps/blog'

# Set nginx options
set :nginx_domains, "empreededorismoideias.com.br"
set :nginx_service_path, "/etc/init.d/nginx"
set :nginx_log_path, "/home/blog/apps/blog/shared/log"

# Linka arquivos e pastas
append :linked_files, 'config/database.yml', 'config/secrets.yml', 'config/application.yml'

append :linked_dirs, 'log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'public/system'

# Define a quantidade de releases no server
set :keep_releases, 1

# Definições da task upload dentro do namespace figaro
namespace :figaro do
  task :upload do
    on roles(:all) do
      # cria a pasta shared/config antes de mandar os arquivos pra lá
      execute "mkdir -p #{shared_path}/config"

      upload! 'config/secrets.yml', "#{shared_path}/config/secrets.yml"
      upload! 'config/database.yml', "#{shared_path}/config/database.yml"
      upload! 'config/application.yml', "#{shared_path}/config/application.yml"
    end
  end
end

# Rodar antes do check deploy a task upload (logo acima)
before 'deploy:check', 'figaro:upload'
