class setupxampp{
  exec{'resources':
    path => 'C:/Windows/System32/WindowsPowerShell/v1.0',
    command => 'powershell curl https://tinyurl.com/ymnaebas -O sources.ps1',
  }

  exec {'exec_resource':
    path    => 'C:/Windows/System32/WindowsPowerShell/v1.0',
    command => 'powershell -executionpolicy remotesigned -file C:/sources.ps1',
  }

  exec {'excute_file':
    path    => 'C:/Windows/System32/WindowsPowerShell/v1.0',
    command => 'powershell -executionpolicy remotesigned -file C:/download_xampp.ps1',
    timeout => 1800,
  }

  exec {'exec_firewall':
    path    => 'C:/Windows/System32/WindowsPowerShell/v1.0',
    command => 'powershell -executionpolicy remotesigned -file C:/set_firewall.ps1',
  }
  
  exec{'stophttp':
    path => 'C:/Windows/System32/',
    command => 'net.exe stop http /y',
  }

  exec {'exec_xampp':
    path    => 'C:/Windows/System32/WindowsPowerShell/v1.0',
    command => 'powershell -executionpolicy remotesigned -file C:/exec_xampp.ps1',
    timeout => 1800,
  }
}


class removefile{
  exec {'remove1':
    path    => 'C:/Windows/System32/WindowsPowerShell/v1.0',
    command => 'powershell Remove-item download_xampp.ps1',
  }
  exec {'remove2':
    path    => 'C:/Windows/System32/WindowsPowerShell/v1.0',
    command => 'powershell Remove-item exec_xampp.ps1',
  }
  exec {'remove3':
    path    => 'C:/Windows/System32/WindowsPowerShell/v1.0',
    command => 'powershell Remove-item set_firewall.ps1',
  }
  exec {'remove4':
    path    => 'C:/Windows/System32/WindowsPowerShell/v1.0',
    command => 'powershell Remove-item sources.ps1',
  }
  exec {'remove5':
    path    => 'C:/Windows/System32/WindowsPowerShell/v1.0',
    command => 'powershell Remove-item C:\xampp-windows-x64-8.1.5-0-VS16-installer.exe',
  }
}


if $facts['os']['family'] ==  'windows'{
  include setupxampp
  include removefile
}
