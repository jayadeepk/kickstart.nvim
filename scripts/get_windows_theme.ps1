#!/usr/bin/env pwsh
# PowerShell script to detect Windows theme (dark/light)
# Returns "dark" or "light"

try {
    # Check if running in Windows environment
    if (-not $IsWindows -and $env:WSL_DISTRO_NAME -eq $null) {
        Write-Output "light"  # Default fallback
        exit 0
    }

    # Registry path for theme setting
    $regPath = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize"
    $regKey = "AppsUseLightTheme"
    
    # Get the registry value (0 = dark theme, 1 = light theme)
    $themeValue = Get-ItemProperty -Path $regPath -Name $regKey -ErrorAction SilentlyContinue
    
    if ($null -eq $themeValue) {
        Write-Output "light"  # Default to light if can't read registry
    } elseif ($themeValue.$regKey -eq 0) {
        Write-Output "dark"
    } else {
        Write-Output "light"
    }
} catch {
    Write-Output "light"  # Default fallback on any error
}