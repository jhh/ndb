require_relative 'test_helper'

class TestFullTextSearch < Test::Unit::TestCase

  def setup
    @db = SQLite3::Database.new(ENV["NDB_DB"])
  end

  must "conduct full text search" do
    results = @db.execute("select * from FOOD where description match ?", ["corn flake bar"])
    assert_equal("43595", results[0][0])
  end

end
