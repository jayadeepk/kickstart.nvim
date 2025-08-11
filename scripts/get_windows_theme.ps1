#!/usr/bin/env pwsh
# PowerShell script to detect Windows theme (dark/light)
# Returns "dark" or "light"

try {
    # Registry path for theme setting
    $regPath = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize"
    $regKey = "AppsUseLightTheme"
    
    # Get the registry value (0 = dark theme, 1 = light theme)
    $themeValue = Get-ItemProperty -Path $regPath -Name $regKey -ErrorAction SilentlyContinue
    
    if ($null -eq $themeValue) {
        Write-Output "dark"  # Default to dark if can't read registry
    } elseif ($themeValue.$regKey -eq 0) {
        Write-Output "dark"
    } else {
        Write-Output "light"
    }
} catch {
    Write-Output "dark"  # Default fallback on any error
}