# from https://github.com/sandal/rbp/blob/master/testing/test_unit_extensions.rb

require 'test/unit'
require 'sqlite3'

module Test::Unit
  # Used to fix a minor minitest/unit incompatibility in flexmock 
  AssertionFailedError = Class.new(StandardError)
  
  class TestCase
   
    def self.must(name, &block)
      test_name = "test_#{name.gsub(/\s+/,'_')}".to_sym
      defined = instance_method(test_name) rescue false
      raise "#{test_name} is already defined in #{self}" if defined
      if block_given?
        define_method(test_name, &block)
      else
        define_method(test_name) do
          flunk "No implementation provided for #{name}"
        end
      end
    end

    def ndb_tables_config
      @ndb_tables_config ||= YAML.load_file(ENV["NDB_TABLES"])
    end

    def ndb_table_names
      ndb_tables_config.collect {|t| t[:name]}
    end

    def ndb_table_data_path(table)
      File.join(ENV["NDB_DATA"], "#{table}.txt")
    end
    

  end
end