class prepare{
  # execute 'apt-get update'
  exec {'apt-update':
    command => '/usr/bin/apt-get update',
  }
  package { "openjdk-11-jdk": ensure => installed }
  package { "openssh-server": ensure => installed }
  package { "openssh-client": ensure => installed }
}

class tool{
  package { 'unzip': ensure => installed }
}

class execute1{
  exec{'create_key':
    path => ['/usr/bin', '/usr/sbin',],
    command => '/bin/ssh-keygen -t rsa -P "" -f .ssh/id_rsa',
  }
  exec{'save_publickey':
    path => ['/usr/bin', '/usr/sbin',],
    command => '/bin/cat .ssh/id_rsa.pub >> .ssh/authorized_keys',
  }
  exec{'privilege':
    path => ['/usr/bin', '/usr/sbin',],
    command => '/bin/chmod 0600 .ssh/authorized_keys',
  }
}

class download_hadoop{
  exec{'wget1':
    path => ['/usr/bin', '/usr/sbin',],
    command => '/bin/wget -O /opt/hadoop-3.2.3.zip https://tinyurl.com/twr3ne77',
  }
  exec{'unzip1':
    path => ['/usr/bin', '/usr/sbin',],
    command => '/bin/unzip /opt/hadoop-3.2.3.zip -d /opt',
  }
}

class execute2{
  exec{'rm':
    path => ['/usr/bin', '/usr/sbin',],
    command => '/bin/rm -r .bashrc',
  }
  exec{'wget2':
    path => ['/usr/bin', '/usr/sbin',],
    command => '/bin/wget -O .bashrc https://tinyurl.com/bde593eu',
  }
  
  exec{'bash':
    path => ['/usr/bin', '/usr/sbin',],
    command => '/bin/bash -c "source ~/.bashrc" ',
  }

  exec{'pushd2':
    path => ['/usr/bin', '/usr/sbin',],
    cwd => '/opt/hadoop-3.2.3/sbin/',
    command => '/bin/bash start-all.sh',
    timeout => 800,
  }
}

class execute3{
  exec{'wget3':
    path => ['/usr/bin', '/usr/sbin',],
    command => '/bin/wget -O word-count-hadoop.zip https://tinyurl.com/2p9cam9x',
  }
  exec{'unzip2':
    path => ['/usr/bin', '/usr/sbin',],
    command => '/bin/unzip word-count-hadoop.zip',
  }

  exec{'wget5':
    path => ['/usr/bin', '/usr/sbin',],
    command => 'wget -O pushfile_hadoop.sh https://tinyurl.com/3nw6rrmz',
  }

  exec{'hdfs':
    path => ['/usr/bin', '/usr/sbin',],
    command => 'bash pushfile_hadoop.sh',
  }

  exec{'wget4':
    path => ['/usr/bin', '/usr/sbin',],
    command => 'wget -O run_hadoop.sh https://tinyurl.com/3pvzpsh9',
  }

  exec{'jar':
    path => ['/usr/bin', '/usr/sbin',],
    command => 'bash run_hadoop.sh',
  }

}

if $facts['os']['family'] == 'Debian'{
  include prepare
  include tool
  include execute1
  include download_hadoop
  include execute2
  include execute3
}
