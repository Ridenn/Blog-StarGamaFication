# Nome da aplicação
set :application, 'blog'

# Repositório para baixar e usar
set :repo_url, 'git@github.com:aschiavon91/Blog-StarGamaFication.git'

set :user,            'deploy'
set :puma_threads,    [4, 16]
set :puma_workers,    0
set :pty,             true
set :use_sudo,        false
set :stage,           :production
set :deploy_via,      :remote_cache
# Repare nesse caminho, eh o mesmo onde ficara o banco de dados da produção
set :deploy_to, '/home/deploy/apps/blog'
set :shared_children, shared_children + %w{public}
# set :puma_bind,       "unix://#{shared_path}/tmp/sockets/#{fetch(:application)}-puma.sock"
# set :puma_state,      "#{shared_path}/tmp/pids/puma.state"
# set :puma_pid,        "#{shared_path}/tmp/pids/puma.pid"
# set :puma_access_log, "#{release_path}/log/puma.error.log"
# set :puma_error_log,  "#{release_path}/log/puma.access.log"
set :ssh_options,     { forward_agent: true, user: fetch(:user), keys: %w(~/.ssh/id_rsa.pub) }
set :puma_preload_app, true
set :puma_worker_timeout, nil
set :puma_init_active_record, true  # Change to false when not using ActiveRecord


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
      upload! 'config/env.yml', "#{shared_path}/config/env.yml"
    end
  end
end

namespace :deploy do
  desc "Make sure local git is in sync with remote."
  task :check_revision do
    on roles(:app) do
      unless `git rev-parse HEAD` == `git rev-parse origin/master`
        puts "WARNING: HEAD is not the same as origin/master"
        puts "Run `git push` to sync changes."
        exit
      end
    end
  end

  desc 'Initial Deploy'
  task :initial do
    on roles(:app) do
      before 'deploy:restart', 'puma:start'
      invoke 'deploy'
    end
  end

  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      invoke 'puma:restart'
    end
  end

  before :starting,     :check_revision
  after  :finishing,    :compile_assets
  after  :finishing,    :cleanup
end

namespace :logs do
  desc "tail rails logs"
  task :tail_rails do
    on roles(:app) do
      execute "tail -f #{shared_path}/log/#{fetch(:rails_env)}.log"
    end
  end
end

# Rodar antes do check deploy a task upload (logo acima)
before 'deploy:check', 'figaro:upload'
