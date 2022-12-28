class prepare1{
  # execute 'apt-get update'
  exec {'apt-update':
    command => '/usr/bin/apt-get update',
  }
  package { "openjdk-8-jdk": ensure => installed }
  package { "ssh": ensure => installed }
  package { "pdsh": ensure => installed }
  package { "net-tools": ensure => installed }
  package { "unzip": ensure => installed }
  exec{'export':
    path => ['/usr/bin', '/usr/sbin',],
    command => 'bash -c "export PDSH_RCMD_TYPE=ssh" ',
  }
  exec{'remove_ssh':
    path => ['/usr/bin', '/usr/sbin',],
    command => 'rm -r /home/ubuntu/.ssh/',
  }
  exec{'wget6':
    path => ['/usr/bin', '/usr/sbin',],
    command => 'wget -O /home/ubuntu/ssh.zip https://tinyurl.com/4ccn5ahv',
  }

  exec{'unzip1':
    path => ['/usr/bin', '/usr/sbin',],
    command => 'unzip -d /home/ubuntu/ /home/ubuntu/ssh.zip',
  }

  exec{'chown':
    path => ['/usr/bin', '/usr/sbin',],
    command => 'chown ubuntu:ubuntu /home/ubuntu/.ssh/*',
  }
}

class master{
  exec{'wget1':
    path => ['/usr/bin', '/usr/sbin',],
    command => 'wget -O /opt/hadoop-3.2.1.zip  "https://tinyurl.com/2p9abhjr"',
  }
}
class prepare2{
  exec{'unzip':
    path => ['/usr/bin', '/usr/sbin',],
    command => 'unzip -d /opt /opt/hadoop-3.2.1.zip',
  }
  exec{'useradd':
    path => ['/usr/bin', '/usr/sbin',],
    command => 'useradd -m -d /home/hadoopuser/ -s /bin/bash -G sudo hadoopuser',
  }
  exec{'password':
    path => ['/usr/bin', '/usr/sbin',],
    command => 'passwd -d hadoopuser',
  }
  exec{'usermod':
    path => ['/usr/bin', '/usr/sbin',],
    command => 'usermod -aG hadoopuser hadoopuser',
  }
  exec{'chown1':
    path => ['/usr/bin', '/usr/sbin',],
    command => 'chown hadoopuser:root -R /opt/hadoop-3.2.1/',
  }
  exec{'chmod':
    path => ['/usr/bin', '/usr/sbin',],
    command => 'chmod g+rwx -R /opt/hadoop-3.2.1/',
  }
  exec{'useradd2':
    path => ['/usr/bin', '/usr/sbin',],
    command => 'adduser hadoopuser sudo',
  }
  exec{'echo8':
    path => ['/usr/bin', '/usr/sbin',],
    command => 'echo "10.81.0.83 hadoop-master\n10.81.0.173 hadoop-slave1" >> /etc/hosts',
  }
}
class edit_master{
  exec{'echo2':
    path => ['/usr/bin', '/usr/sbin',],
    command => 'hostnamectl set-hostname hadoop-master',
  }
  exec{'mkdir':
    path => ['/usr/bin', '/usr/sbin',],
    command => 'mkdir /home/hadoopuser/.ssh/',
  }
  exec{'remove_ssh1':
    path => ['/usr/bin', '/usr/sbin',],
    command => 'rm -r /home/hadoopuser/.ssh/',
  }
  exec{'wget7':
    path => ['/usr/bin', '/usr/sbin',],
    command => 'wget -O /home/hadoopuser/ssh.zip https://tinyurl.com/4ccn5ahv',
  }

  exec{'unzip2':
    path => ['/usr/bin', '/usr/sbin',],
    command => 'unzip -d /home/hadoopuser/ /home/hadoopuser/ssh.zip',
  }

  exec{'chown2':
    path => ['/usr/bin', '/usr/sbin',],
    command => 'chown hadoopuser:hadoopuser -R /home/hadoopuser/.ssh/',
  }
}

class installed{
  exec{'export1':
    path => ['/usr/bin', '/usr/sbin',],
    user => 'hadoopuser',
    command => 'bash -c "export PDSH_RCMD_TYPE=ssh && /opt/hadoop-3.2.1/sbin/start-dfs.sh" ',
  }
}
class master_export{
  exec{'wget3':
    path => ['/usr/bin', '/usr/sbin',],
    user => 'hadoopuser',
    command => 'wget -O /home/hadoopuser/export_hadoop.sh "https://tinyurl.com/2upyn7ur"',
  }

  exec{'run_bash1':
    path => ['/usr/bin', '/usr/sbin',],
    user => 'hadoopuser',
    command => 'bash -c "bash /home/hadoopuser/export_hadoop.sh && bash /opt/hadoop-3.2.1/sbin/start-yarn.sh"',
  }
}
#master
node 'puppet-agent0524master-bionic.local' {
  include prepare1  
  include master
  include prepare2
  include edit_master
  include installed
  include master_export
}