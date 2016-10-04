require 'pg'

class Movie
  def initialize(options)
    @id = options[:id]
    @name = options[:name]
    @year = options[:year]
    @oscars = options[:oscars]
    @conn = conn = PG.connect(dbname: 'directors')
  end

  def disable_notices(conn)
    conn.exec('SET client_min_messages TO WARNING;') # still like some kind of msg to go out
  end

  def self.create_table
    conn = PG.connect(dbname: 'directors')
    conn.exec("CREATE TABLE IF NOT EXISTS movies("\
    'id SERIAL PRIMARY KEY, name VARCHAR,'\
    'year NUMBERIC, oscars VARCHAR)')
  end

  def insert
    result = @conn.exec("INSERT INTO directors (name, year, oscars) VALUES('#{@name}', '#{@year}', '#{@oscars}') RETURNING id")

    p result
    @id = result[0]['id'].to_i
  end

  def update
    @conn.exec("UPDATE directors SET name= '#{@name}', year= #{@year}, oscars= '#{@oscars}' WHERE id= #{@id}")
  end

  def save
    if @id.nil?
      insert
    else
      update
    end
  end
end

def main()
Movie.create_table
fightclub = Movie.new(name: "Fight club", year: 1999, oscars: "nominated for 1")
fightclub.save
zodiac = Movie.new(name: "Zodiac", year: 2007, oscars: "none")
zodiac.save
there_will_be_blood = Movie.new(name: "There will be blood", year: 2007, oscars: "2")
there_will_be_blood.save
boogie_nights = Movie.new(name: "Boogie Nights", year: 1997, oscars: "3")
boogie_nights.save
pulp_fiction = Movie.new(name: "Pulp Fiction", year: 1994, oscars: "1")
pulp_fiction.save
django_unchained = Movie.new(name: "Django Unchanged", year: 2012, oscars: "2")
django_unchained.save
american_beauty = Movie.new(name: "American Beauty", year: 1999, oscars: "5")
american_beauty.save
skyfall = Movie.new(name: "Skyfall", year: 2012, oscars: "2")
skyfall.save
memento = Movie.new(name: "Memento", year: 2000, oscars: "nominated for 10")
memento.save
the_dark_knight = Movie.new(name: "The Dark Knight", year: 2008, oscars: "2")
the_dark_knight.save









end

main if __FILE__==$PROGRAM_NAME
