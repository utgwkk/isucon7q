require 'mysql2'

def db
  return @db_client if defined?(@db_client)

  @db_client = Mysql2::Client.new(
    host: ENV.fetch('ISUBATA_DB_HOST') { '27.133.131.164' },
    port: ENV.fetch('ISUBATA_DB_PORT') { '3306' },
    username: ENV.fetch('ISUBATA_DB_USER') { 'isucon' },
    password: ENV.fetch('ISUBATA_DB_PASSWORD') { 'isucon' },
    database: 'isubata',
    encoding: 'utf8mb4'
  )
  @db_client.query('SET SESSION sql_mode=\'TRADITIONAL,NO_AUTO_VALUE_ON_ZERO,ONLY_FULL_GROUP_BY\'')
  @db_client
end

def main
  query = %|
  SELECT id, name, data
  FROM image|
  puts query
  results = db.query(query)
  results.each { |res|
    filename = "../public/icons/#{res['name']}"
    puts filename
    File.open(filename, "wb") do |f|
      f.write res['data']
    end
  }
end

main
