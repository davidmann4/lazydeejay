#DB ||= Sequel::Model.db
# Sequel should NOT handle timezones. Every TIMESTAMP in the DB is in UTC.
#Sequel.default_timezone=:utc

# load extension for pagination
#DB.extension(:pagination)
require "sequel"

# connect to an in-memory database
DB = Sequel.sqlite

# create an items table
DB.create_table :tracks do
  primary_key :id
  String :video_id
  String :name
  String :username
  String :thumb
  String :description
end

# create a dataset from the tracks table
TRACKS = DB[:tracks]

