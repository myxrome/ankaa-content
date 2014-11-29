namespace :content do
  namespace :db do

    desc 'Content module migration'
    task :migrate => [:environment] do
      migrate_path = File.expand_path(File.join(AnkaaContent::Engine.root, %w{ db/migrate/ }))
      ActiveRecord::Base.establish_connection "#{Rails.env}".to_sym
      ActiveRecord::Migrator.migrate(migrate_path)
    end

  end
end