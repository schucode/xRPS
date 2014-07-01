require 'pg'
require 'pry-byebug'

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

      command = <<-sQL
        CREATE TABLE IF NOT EXISTS matches (
          id SERIAL, 
          player1 text,
          player2 text,
          open boolean DEFAULT true,
          winner text DEFAULT 'TBA',
          PRIMARY KEY(id))
        sQL
      @db.exec(command) 

      # command = <<-sQL
      #   CREATE TABLE IF NOT EXISTS moves (
      #     id SERIAL, 
      #     user text,
      #     game_id numeric, 
      #     move text,
      #     PRIMARY KEY(id))
      #   sQL
      # @db.exec(command) 

      command = <<-sQL
        CREATE TABLE IF NOT EXISTS games (
          id SERIAL, 
          match_id numeric, 
          winner text,
          PRIMARY KEY(id))
        sQL
      @db.exec(command) 

    end

    def username_exist?(username)
      command = <<-sQL
        SELECT * FROM users WHERE username='#{username}'
        sQL
      result = @db.exec(command)
      if result.ntuples == 0
        false
      else
        true
      end
    end

    def add_user(username, password_digest)
      command = <<-sQL
        INSERT INTO users (username, password) VALUES
        ('#{username}', '#{password_digest}')
        sQL
      @db.exec(command)
    end

    def get_pass(username)
      command = <<-sQL
        SELECT password FROM users WHERE username='#{username}'
        sQL
      result = @db.exec(command)
      if result.ntuples == 0
        false
      else
        result[0]["password"]
      end
    end

    def get_userid(username)
      command = <<-sQL
        SELECT id FROM users WHERE username='#{username}'
        sQL
      result = @db.exec(command)
      result[0]["id"]
    end

    def add_match(username)
      command = <<-sQL
        INSERT INTO matches (player1) VALUES ('#{username}')
        sQL
      @db.exec(command)
    end

    def get_open_matches
      command = <<-sQL
        SELECT * FROM matches WHERE open=true
        sQL
      result = @db.exec(command)
    end

    def set_player2(username, match_id)
      command = <<-sQL
        UPDATE matches SET player2='#{username}' WHERE id='#{match_id}'
        sQL
      @db.exec(command)
    end

    def get_current_matches(username)
      command = <<-sQL
        SELECT * FROM matches WHERE (player1='#{username}' OR player2='#{username}') AND open=false
        sQL
      @db.exec(command)
    end

    def match_player1(match_id)
      command = <<-sQL
        SELECT player1 FROM matches WHERE id='#{match_id}'
        sQL
      @db.exec(command)
    end

    def get_whole_match(match_id)
      command = <<-sQL
        SELECT * FROM matches WHERE id='#{match_id}'
        sQL
      @db.exec(command)
    end

    def close_match(match_id) 
      command = <<-sQL
        UPDATE matches SET open=false WHERE id='#{match_id}'
        sQL
      @db.exec(command)
    end

  end # class end

  def self.orm
    @__ab_instance ||= ORM.new
  end

end # RPS end