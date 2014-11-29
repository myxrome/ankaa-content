module AnkaaContent
  class Engine < ::Rails::Engine

    rake_tasks do
      load 'tasks/migrate.rake'
    end
  end
end