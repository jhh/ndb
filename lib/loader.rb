require 'sqlite3'
require 'yaml'

class Loader

  attr_accessor :debug

  def initialize(db, tables, data)
    @db = SQLite3::Database.new(db)
    @tables = YAML.load_file(tables)
    @data = data
    @debug = false
  end

  def init
    @tables.each do |table|
      sql = create_table_stmt(table)
      @db.execute(sql)
    end
  end

  def load
    @tables.each do |table|
      log "> Loading #{table[:name]}"
      load_table(insert_stmt(table), table[:name])
    end
  end

  def index
    log "> Creating indices"
    sql = IO.read("lib/sql/create_indices.sql")
    @db.execute_batch(sql)
  end

  def pivot
    log "> Creating FOOD table with full-text search"
    sql = IO.read("lib/sql/create_food_table.sql")
    @db.execute_batch(sql)
  end
  

private

  def create_table_stmt(table)
    sql = "CREATE TABLE IF NOT EXISTS #{table[:name]} ("
    table[:columns].each do |column|
      sql << column << ","
    end
    sql[-1] = ")"
    sql
  end

  def insert_stmt(table)
    sql = "INSERT INTO #{table[:name]} VALUES ("
    table[:columns].each do |column|
      sql << "?,"
    end
    sql[-1] = ")"
    sql
  end

 def log(message)
   puts message
 end

  # Takes a '^' delimited line from the SR ASCII files and parses data into an array
  def process_line(line)
    line.split("^").map do |field|
      field.gsub(/~/, '').chomp
    end
  end

  def load_table(sql, file)
    statement = @db.prepare(sql)
    count = 0
    source = File.join(@data, "#{file}.txt")
    File.open(source, 'r') do |file|
      @db.transaction
      while line = file.gets
        data_array = process_line(line)
        statement.execute(data_array)
        STDOUT.write("#{count}...") && STDOUT.flush if (count += 1) % 1000 == 0
      end
      @db.commit
      STDOUT.write("\n") if count > 999
    end
  end

end