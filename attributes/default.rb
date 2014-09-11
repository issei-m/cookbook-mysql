#
# Cookbook Name:: mysql
# Attribute:: default
#
# Copyright 2013, Issei Murasawa <issei.m7@gmail.com>
#

default['mysql']['rpms'] = [
  {
    :url => 'http://cdn.mysql.com/Downloads/MySQL-5.6/MySQL-shared-5.6.19-1.el6.x86_64.rpm',
    :file => 'MySQL-shared-5.6.19-1.el6.x86_64.rpm',
    :package_name => 'MySQL-shared'
  },
  {
    :url => 'http://cdn.mysql.com/Downloads/MySQL-5.6/MySQL-server-5.6.19-1.el6.x86_64.rpm',
    :file => 'MySQL-server-5.6.19-1.el6.x86_64.rpm',
    :package_name => 'MySQL-server'
  },
  {
    :url => 'http://cdn.mysql.com/Downloads/MySQL-5.6/MySQL-client-5.6.19-1.el6.x86_64.rpm',
    :file => 'MySQL-client-5.6.19-1.el6.x86_64.rpm',
    :package_name => 'MySQL-client'
  },
  {
    :url => 'http://cdn.mysql.com/Downloads/MySQL-5.6/MySQL-devel-5.6.19-1.el6.x86_64.rpm',
    :file => 'MySQL-devel-5.6.19-1.el6.x86_64.rpm',
    :package_name => 'MySQL-devel'
  }
]

default['mysql']['root_password'] = ''

default['mysql']['config']['client'] = {
  :port => 3306,
  :socket => '/var/lib/mysql/mysql.sock',
  :default_character_set => 'utf8mb4'
}

default['mysql']['config']['mysql'] = {
  :prompt => '\U [\d] >\_',
  :default_character_set => 'utf8mb4'
}

default['mysql']['config']['mysqld'] = {
  :server_id => '1',
  :datadir => '/var/lib/mysql',
  :port => 3306,
  :socket => '/var/lib/mysql/mysql.sock',

  :max_connections => '100',
  :max_connect_errors => '10',
  :max_allowed_packet => '8M',

  :sort_buffer_size => '2M',
  :read_buffer_size => '2M',

  :table_open_cache => '256',
  :thread_cache_size => '256',
  :query_cache_type => '1',
  :query_cache_size => '64M',

  :tmp_table_size => '64M',
  :max_heap_table_size => '64M',

  :character_set_server => 'utf8mb4',
  :collation_server => 'utf8mb4_general_ci',

  :sql_mode => 'NO_ZERO_DATE,NO_ZERO_IN_DATE',

  :log_bin => 'mysql-bin',
  :binlog_format => 'MIXED',
  :binlog_checksum => 'CRC32', 
  :master_info_repository => 'TABLE',
  :relay_log_info_repository => 'TABLE', 
  :relay_log => 'relay-mysql-bin',
  :replicate_ignore_db => 'mysql',
  :expire_logs_days => '1',

  :long_query_time => '1',

  :innodb_data_file_path => 'ibdata1:10M:autoextend',
  :innodb_data_home_dir => '/var/lib/mysql',
  :innodb_file_format => 'Barracuda',
  :innodb_buffer_pool_size => '1433M',
  :innodb_buffer_pool_instances => '1',
  :innodb_write_io_threads => '4',
  :innodb_read_io_threads => '4',
  :innodb_thread_concurrency => '0',
  :innodb_flush_log_at_trx_commit => '1',
  :innodb_additional_mem_pool_size => '16M',
  :innodb_log_file_size => '128M',
  :innodb_log_buffer_size => '16M',
  :innodb_log_files_in_group => '2',
  :innodb_flush_method => 'O_DIRECT',
  :innodb_lock_wait_timeout => '120',
  :innodb_buffer_pool_load_at_startup => '1',
  :innodb_buffer_pool_dump_at_shutdown => '1',
  :innodb_checksum_algorithm => 'CRC32',
  :innodb_io_capacity => '200',
  :innodb_large_prefix => '1',
  :innodb_print_all_deadlocks => '1'
}

default['mysql']['config']['mysqldump'] = {
  :max_allowed_packet => '16M',
  :default_character_set => 'binary'
}

default['mysql']['config']['mysqld_safe'] = {
  :open_files_limit => '8192'
}
