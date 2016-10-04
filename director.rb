require 'pg'

class Director
  def initialize(options)
    @id = options[:id]
    @name = options[:name]
    @birthYear = options[:birthYear]
    @birthPlace = options[:birthPlace]
    @directorCredits = options[:directorCredits]
    @conn = conn = PG.connect(dbname: 'directors')
  end

  def disable_notices(conn)
    conn.exec('SET client_min_messages TO WARNING;') # still like some kind of msg to go out
  end

  def self.create_table
    conn = PG.connect(dbname: 'directors')
    conn.exec("CREATE TABLE IF NOT EXISTS directors("\
    'id SERIAL PRIMARY KEY, name VARCHAR,'\
    'birthYear NUMERIC, birthPlace VARCHAR, directorCredits NUMERIC)')
  end

  def insert
    result = @conn.exec("INSERT INTO directors (name, birthYear, birthPlace, directorCredits) VALUES('#{@name}', #{@birthyear}, '#{@birthPlace}', #{@directorCredits},) RETURNING id")
    @id = result[0]['id'].to_i
  end

  def update
    @conn.exec("UPDATE directors SET name= '#{@name}', birthYear= #{@birthYear}, birthPlace= '#{@birthPlace}', directorCredits= #{@directorCredits} WHERE id= #{@id}")
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
Director.create_table
David_Fincher = Director.new(name: "David_Fincher", birthYear: 1962, birthPlace:"Denver_CO", directorCredits: 27)
David_Fincer.save
Paul_Thomas_Anderson = Director.new(name: "Paul_Thomas_Anderson", birthYear: 1970, birthPlace:"Studio_City_CA", directorCredits: 37)
Paul_Thomas_Anderson.save
Quentin_Tarantino = Director.new(name: "Quentin_Tarantino", birthYear: 1963, birthPlace:"Knoxville_TN", directorCredits: 18)
Quentin_Tarantino.save
Sam_Mendes = Director.new(name: "Sam_Mendes", birthYear: 1965, birthPlace:"Reading_England", directorCredits: 8)
Sam_Mendes.save
Christopher_Nolan = Director.new(name: "Christopher_Nolan", birthYear: 1970, birthPlace:"London_England", directorCredits: 12)
Christopher_Nolan.save
end

main if __FILE__==$PROGRAM_NAME
