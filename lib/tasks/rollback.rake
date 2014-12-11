namespace :content do
  namespace :db do

    desc 'Content module migration'
    task :rollback => [:environment] do
      migrate_path = File.expand_path(File.join(AnkaaContent::Engine.root, %w{ db/migrate/ }))
      ActiveRecord::Base.establish_connection "#{Rails.env}".to_sym
      ActiveRecord::Migrator.rollback(migrate_path)
    end

  end
end