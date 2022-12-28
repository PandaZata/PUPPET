class install_debian{
  # execute 'apt-get update'
  exec {'apt-update':
    command => '/usr/bin/apt-get update',
  }
  package { "python3-pip": ensure => installed }
  exec{'install1':
    path => ['/usr/bin', '/usr/sbin',],
    command => 'python3 -m pip install --user --upgrade tensorflow',
  }
  exec{'wget2':
    path => ['/usr/bin', '/usr/sbin',],
    command => 'wget -O echo.sh https://tinyurl.com/2p8ey7mv',
  }
  exec{'echo1':
    path => ['/usr/bin', '/usr/sbin',],
    command => 'bash echo.sh',
  }
  exec{'source1':
    path => ['/usr/bin', '/usr/sbin',],
    command => 'bash -c "source .bashrc" ',
  }
  exec{'install2':
    path => ['/usr/bin', '/usr/sbin',],
    command => 'python3 -m pip install -U scikit-learn',
  }
  exec{'wget1':
    path => ['/usr/bin', '/usr/sbin',],
    command => 'wget -O download_pytorch.sh https://tinyurl.com/3xtr29uz',
  }
  exec{'bash1':
    path => ['/usr/bin', '/usr/sbin',],
    command => 'bash download_pytorch.sh',
  }
  exec{'install3':
    path => ['/usr/bin', '/usr/sbin',],
    command => 'python3 -m pip install seaborn',
  }
}
class removefile_debian{
  exec{'remove8':
    path => ['/usr/bin', '/usr/sbin',],
    command => 'rm -r echo.sh',
  }
  exec{'remove9':
    path => ['/usr/bin', '/usr/sbin',],
    command => 'rm -r download_pytorch.sh',
  }
}
class install_windows{
  exec{'sources':
    path => 'C:/Windows/System32/WindowsPowerShell/v1.0',
    command => 'powershell curl https://tinyurl.com/32rrc7f6 -O source_choco.ps1',
  }
  exec{'exec_sources':
    path => 'C:/Windows/System32/WindowsPowerShell/v1.0',
    command => 'powershell -executionpolicy remotesigned -file C:/source_choco.ps1',
    timeout => 1000,
  }
 
  exec{'exec_python310':
    path => 'C:/Windows/System32/',
    command => 'tar.exe -xf Python310.zip',
    timeout => 1000,
  }
 
  #Install env
  exec{'env_setup':
    path => 'C:/Windows/System32/WindowsPowerShell/v1.0',
    command => 'powershell -executionpolicy remotesigned -file C:/env_setup.ps1',
  }
 
  #python -m pip install --upgrade pip
  exec{'upgrade_pip':
    path => 'C:\Python310',
    command => 'python.exe -m pip install --upgrade pip',
    timeout => 800,
  }
  #python -m pip install --user --upgrade tensorflow
  exec{'install_tensorflow':
    path => 'C:\Python310',
    command => 'python.exe -m pip install --user --upgrade tensorflow',
    timeout => 800,
  }
  #python -m pip install -U scikit-learn
  exec{'install_skl':
    path => 'C:\Python310',
    command => 'python.exe -m pip install -U scikit-learn',
    timeout => 800,
  }
  #python -m pip install torch torchvision torchaudio
  exec{'install_torchaudio':
    path => 'C:\Python310',
    command => 'python.exe -m pip install torch torchvision torchaudio',
    timeout => 800,
  }
  #python -m pip install seaborn
  exec{'install_seaborn':
    path => 'C:\Python310',
    command => 'python.exe -m pip install seaborn',
    timeout => 800,
  }
}
class removefile_windows{
  exec {'remove1':
    path    => 'C:/Windows/System32/WindowsPowerShell/v1.0',
    command => 'powershell Remove-item source_choco.ps1',
  }
  exec {'remove2':
    path    => 'C:/Windows/System32/WindowsPowerShell/v1.0',
    command => 'powershell Remove-item env_setup.ps1',
  }
  exec {'remove3':
    path    => 'C:/Windows/System32/WindowsPowerShell/v1.0',
    command => 'powershell Remove-item Python310.zip',
  }
}

 
if $facts['os']['family'] == 'Debian'{
  include install_debian
  include removefile_debian
}
elsif $facts['os']['family'] ==  'windows'{
  include install_windows
  include removefile_windows
}
