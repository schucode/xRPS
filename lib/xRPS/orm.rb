module RPS

  # DATABASE NAME: rps-database

  class ORM

    def initialize
        @db = PG.connect(host: 'localhost', dbname: 'task_manager')
        build_tables
    end

    def build_tables
      # users, games, matches, moves

      command = <<-sQL
        CREATE TABLE IF NOT EXISTS matches (
          id SERIAL, 
          ,
          PRIMARY KEY(id))
        sQL

      command = <<-sQL
        CREATE TABLE IF NOT EXISTS entries (
          id SERIAL, 
          input numeric,
          PRIMARY KEY(id))
        sQL

      command = <<-sQL
        CREATE TABLE IF NOT EXISTS entries (
          id SERIAL, 
          input numeric,
          PRIMARY KEY(id))
        sQL

      #@db.exec(command)
    end



  end # class end
end # RPS end