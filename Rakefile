require 'bundler/setup'
require 'rake/clean'
require 'rake/testtask'
require_relative 'lib/loader'

ENV["NDB_DATA"]   ||= "sr23"
ENV["NDB_TABLES"] ||= "sr23.yml"
ENV["NDB_DB"]     ||= "ndb.sqlite3"

CLOBBER.include(ENV["NDB_DB"])

task :default => :load

task :environment do
  @loader = Loader.new(ENV["NDB_DB"], ENV["NDB_TABLES"], ENV["NDB_DATA"])
end

desc "Initialize empty database."
task init: [:environment] do
  @loader.init
end

desc "Create database and load all files."
task load: [:init] do
  @loader.load
end

desc "Create database indices."
task index: [:environment] do
  @loader.index
end

desc "Create FOOD table with Sqlite3 fts4 extension."
task pivot: [:index] do
  @loader.pivot
end

Rake::TestTask.new do |t|
  t.pattern = 'test/**/tc_*.rb'
  t.verbose = false
  t.warning = true
end