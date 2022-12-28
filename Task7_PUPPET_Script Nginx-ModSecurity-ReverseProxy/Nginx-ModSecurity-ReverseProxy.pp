class tool{
  # install unzip package
  package { 'unzip': ensure => installed }
  package { 'git': ensure => installed }
}

class prepare_install{
  # execute 'apt-get update'
  exec {'apt-update':
    command => '/usr/bin/apt-get update',
  }
  exec {'export':
    path => ['/usr/bin', '/usr/sbin',],
    command => '/bin/sh -c export DEBIAN_FRONTEND=noninteractive',
  }
  exec {'repository':
    path => ['/usr/bin', '/usr/sbin',],
    command => '/bin/add-apt-repository ppa:ondrej/nginx-mainline -y',
  }
}

class install{
  # execute 'apt-get update'
  exec {'apt-update2':
    command => '/usr/bin/apt-get update',
  }
  package { "nginx-core": ensure => installed }
  package { "nginx-common": ensure => installed }
  package { "nginx": ensure => installed }
  package { "nginx-full": ensure => installed }
  
  exec{'rm':
    path => ['/usr/bin', '/usr/sbin',],
    command => '/bin/rm -r /etc/apt/sources.list.d/* ',
  }

  exec{'wget1':
    path => ['/usr/bin', '/usr/sbin',],
    command => '/bin/wget -O ondrej-ubuntu-nginx-mainline-focal.list https://tinyurl.com/3dcpsp4w',
  }

  exec{'cp':
    path    => ['/usr/bin', '/usr/sbin',],
    command => '/bin/cp ondrej-ubuntu-nginx-mainline-focal.list /etc/apt/sources.list.d/',
  }

  # execute 'apt-get update'
  exec {'apt-update3':
    command => '/usr/bin/apt-get update',
  }
}

class install_Nginx{
  package { 'dpkg-dev': ensure => installed }

  package { 'gcc': ensure => installed }
  package { 'make': ensure => installed }
  package { 'build-essential': ensure => installed }
  package { 'autoconf': ensure => installed }
  package { 'automake': ensure => installed }
  package { 'libtool': ensure => installed }
  package { 'libcurl4-openssl-dev': ensure => installed }
  package { 'liblua5.3-dev': ensure => installed }
  package { 'libfuzzy-dev': ensure => installed }
  package { 'ssdeep': ensure => installed }
  package { 'gettext': ensure => installed }
  package { 'pkg-config': ensure => installed }
  package { 'libpcre3': ensure => installed }
  package { 'libpcre3-dev': ensure => installed }
  package { 'libxml2': ensure => installed }
  package { 'libxml2-dev': ensure => installed }
  package { 'libcurl4': ensure => installed }
  package { 'libgeoip-dev': ensure => installed }
  package { 'libyajl-dev': ensure => installed }
  package { 'doxygen': ensure => installed }
}

class test1{
  exec{'wget2':
    path    => ['/usr/bin', '/usr/sbin',],
    command     => '/bin/wget -O ModSecurity.zip https://tinyurl.com/2p856k7b',
  }

  #extract
  exec{'extract':
    path    => ['/usr/bin', '/usr/sbin',],
    command => '/bin/unzip ModSecurity.zip -d /usr/local/src/',
  }

  exec{'pushd':
    path => ['/usr/bin', '/usr/sbin',],
    cwd => '/usr/local/src/ModSecurity/',
    command => '/bin/make install ',
  }
}

class test2{
  exec{'cmd1':
    path    => ['/usr/bin', '/usr/sbin',],
    command => '/bin/apt build-dep nginx -y',
  }
  
  package { 'uuid-dev': ensure => installed }

  exec{'wget3':
    path    => ['/usr/bin', '/usr/sbin',],
    command     => '/bin/wget -O ngx_http_modsecurity_module.so https://tinyurl.com/msv9avcd',
  }
  exec{'cp2':
    path    => ['/usr/bin', '/usr/sbin',],
    command     => '/bin/cp ngx_http_modsecurity_module.so /usr/share/nginx/modules/',
  }
}

class test3{
  # Tai nginx.conf > /etc/nginx/nginx.conf
  exec{'wget4':
    path    => ['/usr/bin', '/usr/sbin',],
    command     => '/bin/wget -O nginx.conf https://tinyurl.com/2p862w8e',
  }
  exec{'cp3':
    path    => ['/usr/bin', '/usr/sbin',],
    command     => '/bin/cp nginx.conf /etc/nginx/',
  }
  exec{'mkdir':
    path    => ['/usr/bin', '/usr/sbin',],
    command     => '/bin/mkdir /etc/nginx/modsec/',
  }
  
  # Tai modsecurity.conf > /etc/nginx/modsec/modsecurity.conf
  exec{'wget5':
    path    => ['/usr/bin', '/usr/sbin',],
    command     => '/bin/wget -O modsecurity.conf https://tinyurl.com/bdzh2etj',
  }

  exec{'cp4':
    path    => ['/usr/bin', '/usr/sbin',],
    command     => '/bin/cp modsecurity.conf /etc/nginx/modsec/',
  }
  
  # Tai main.conf > /etc/nginx/modsec/main.conf
  
  exec{'wget6':
    path    => ['/usr/bin', '/usr/sbin',],
    command     => '/bin/wget -O main.conf https://tinyurl.com/4e4xhxw5',
  }

  exec{'cp5':
    path    => ['/usr/bin', '/usr/sbin',],
    command     => '/bin/cp main.conf /etc/nginx/modsec/',
  }

  exec{'cp6':
    path    => ['/usr/bin', '/usr/sbin',],
    command     => '/bin/cp /usr/local/src/ModSecurity/unicode.mapping /etc/nginx/modsec/',
  }
}

class test4{
  exec{'wget7':
    path    => ['/usr/bin', '/usr/sbin',],
    command     => '/bin/wget -O v3.3.2.tar.gz https://github.com/coreruleset/coreruleset/archive/v3.3.2.tar.gz',
  }
  
  exec{'tar':
    path    => ['/usr/bin', '/usr/sbin',],
    command     => '/bin/tar xvf v3.3.2.tar.gz',
  }
  exec{'mv':
    path    => ['/usr/bin', '/usr/sbin',],
    command     => '/bin/mv coreruleset-3.3.2/ /etc/nginx/modsec/',
  }
  exec{'mv1':
    path    => ['/usr/bin', '/usr/sbin',],
    command     => '/bin/mv /etc/nginx/modsec/coreruleset-3.3.2/crs-setup.conf.example /etc/nginx/modsec/coreruleset-3.3.2/crs-setup.conf',
  }

  exec{'systemctl':
    path    => ['/usr/bin', '/usr/sbin',],
    command     => '/bin/systemctl restart nginx',
  }
}

class test5{
  exec{'unlink':
    path    => ['/usr/bin', '/usr/sbin',],
    command     => '/bin/unlink /etc/nginx/sites-enabled/default',
  }

  exec{'wget8':
    path    => ['/usr/bin', '/usr/sbin',],
    command     => '/bin/wget -O reverse-proxy.conf https://tinyurl.com/4euz7e5w',
  }

  exec{'cp7':
    path    => ['/usr/bin', '/usr/sbin',],
    command     => '/bin/cp reverse-proxy.conf /etc/nginx/sites-available/',
  }

  exec{'ln':
    path    => ['/usr/bin', '/usr/sbin',],
    command     => '/bin/ln -s /etc/nginx/sites-available/reverse-proxy.conf /etc/nginx/sites-enabled/reverse-proxy.conf',
  }
}

class remove1{
  exec{'rm1':
    path => ['/usr/bin', '/usr/sbin',],
    command => '/bin/rm -r *.conf',
  }

  exec{'rm2':
    path => ['/usr/bin', '/usr/sbin',],
    command => '/bin/rm -r *.so',
  }
  exec{'rm3':
    path => ['/usr/bin', '/usr/sbin',],
    command => '/bin/rm -r *.tar.gz',
  }
  exec{'rm4':
    path => ['/usr/bin', '/usr/sbin',],
    command => '/bin/rm -r *.list',
  }
  exec{'rm6':
    path => ['/usr/bin', '/usr/sbin',],
    command => '/bin/rm -r *.zip',
  }
}

if $facts['os']['family'] == 'Debian'{
  include tool
  include prepare_install
  include install
  include install_Nginx
  include test1
  include test2
  include test3
  include test4
  include test5
  include remove1
}
