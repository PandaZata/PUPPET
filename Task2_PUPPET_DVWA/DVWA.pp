class install{
  # execute 'apt-get update'
  exec {'apt-update':
    command => '/usr/bin/apt-get update',
  }
  # install apache2 package
  package { 'apache2':
    require => Exec['apt-update'],
    ensure => installed,
  }
  
  package { "mariadb-server": ensure => installed }
  package { "php": ensure => installed }
  package { "php-mysqli": ensure => installed }
  package { "php-gd": ensure => installed }
  package { "libapache2-mod-php": ensure => installed }

  # ensure apache2 service is running
  service { 'apache2': ensure => running }

  # ensure mariadb service is running
  service {'mariadb':
    ensure    => running,
    enable    => true,
  }
}

class tool{
  # install unrar package
  package { 'unrar': ensure => installed }
}

class dbserver{
  exec{'wget':
    path => ['/usr/bin', '/usr/sbin',],
    command => '/bin/wget -O dvwa-dump.sql https://tinyurl.com/3hkks7wd',
  }
  #exec file
  exec{'mysql':
    path    => ['/usr/bin', '/usr/sbin',],
    command => '/bin/mysql -uroot < dvwa-dump.sql',
  }

   exec{'systemctl':
    path => ['/usr/bin', '/usr/sbin',],
    command => '/bin/systemctl restart apache2.service',
    }

}

class download_DVWA{
  exec{'wget1':
    path    => ['/usr/bin', '/usr/sbin',],
    command     => '/bin/wget -O DVWA.rar https://bit.ly/3DNAKp4',
  }

  #copy file to web
  exec{'cp':
    path    => ['/usr/bin', '/usr/sbin',],
    command => '/bin/cp DVWA.rar /var/www/html/',
  }

  #extract
  exec{'extract':
    path    => ['/usr/bin', '/usr/sbin',],
    command => '/bin/unrar x /var/www/html/DVWA.rar /var/www/html/',
  }
}

class execute_DVWA{
  #Folder Permissions
  exec{'chmod1':
    path    => ['/usr/bin', '/usr/sbin',],
    cwd => '/var/www/html/DVWA/',
    command     => '/bin/chmod 777 /var/www/html/DVWA/hackable/uploads/',
  }
  exec{'chmod2':
    path    => ['/usr/bin', '/usr/sbin',],
    cwd => '/var/www/html/DVWA/',
    command     => '/bin/chmod 777 /var/www/html/DVWA/external/phpids/0.6/lib/IDS/tmp/phpids_log.txt',
  }
  exec{'chmod3':
    path    => ['/usr/bin', '/usr/sbin',],
    cwd => '/var/www/html/DVWA/',
    command     => '/bin/chmod 777 /var/www/html/DVWA/config',
  }

  exec{'wget2':
    path    => ['/usr/bin', '/usr/sbin',],
    command     => '/bin/wget -O php.ini https://bitly.com.vn/adaq74',
  }
 
  #remove file php.ini older
  exec{'rm':
    path => ['/usr/bin', '/usr/sbin',],
    command => '/bin/rm -rf /etc/php/7.4/apache2/php.ini',
  }

  #copy file to web
  exec{'cp1':
    path    => ['/usr/bin', '/usr/sbin',],
    command => '/bin/cp php.ini /etc/php/7.4/apache2/',
  }
}

if $facts['os']['family'] == 'Debian'{
  include install
  include tool
  include download_DVWA
  include execute_DVWA
  include dbserver
}

