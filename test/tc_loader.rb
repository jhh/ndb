require_relative 'test_helper'

class TestLoader < Test::Unit::TestCase

  def setup
    @db = SQLite3::Database.new(ENV["NDB_DB"])
  end

  must "have equal db rows and text file lines" do
    ndb_table_names.each do |table|
      File.open(ndb_table_data_path(table), 'r') do |file|
        while file.gets; end
      end
      file_line_count = $.
      db_row_count = @db.get_first_row("select count(*) from #{table}")[0]
      assert_equal file_line_count, db_row_count, "Expected number of rows in #{table} wrong"
    end
  end

end
