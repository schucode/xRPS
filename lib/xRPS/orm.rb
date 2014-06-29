require 'pg'

module RPS

  # DATABASE NAME: rps-database

  class ORM

    def initialize
        @db = PG.connect(host: 'localhost', dbname: 'rps-database')
        build_tables
    end

    def build_tables
      # users, games, matches, moves
      command = <<-sQL
        CREATE TABLE IF NOT EXISTS users (
          id SERIAL, 
          username text,
          password text,
          PRIMARY KEY(id))
        sQL
      @db.exec(command)
    end

    def username_exist?(username)
      command =<<-sQL
        SELECT * FROM users WHERE username='#{username}'
        sQL
      result = @db.exec(command)
      if result.ntuples == 0
        false
      else
        true
      end
    end


  end # class end

  def self.orm
    @__ab_instance ||= ORM.new
  end

end # RPS end