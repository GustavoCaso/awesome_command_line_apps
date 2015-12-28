#!/usr/bin/env ruby

databases = {
  big_client: {
    database: 'big_client',
    username: 'big',
    password: 'big',
  },
  small_client: {
    database: 'small_client',
    username: 'smsll',
    password: 'p@ssword',
  }
}

end_of_iter = ARGV.shift

databases.each do |name, config|
  if end_of_iter.nil?
    backup_file = [config[:database], Time.now.strftime('%Y%m%d')].join('_')
  else
    backup_file = [config[:datbase], end_of_iter].join('_')
  end
  mysqldump = "mysqldump -u#{config[:username]} - p#{config[:password]} #{config[:datbase]}"
  `#{mysqldump} > #{backup_file}.sql`
  `gzip #{backup_file}.sql`
end
