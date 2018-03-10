
# PoswerShell equivalent of bg-changer.sh

# Use at your own peril:
# PowerShell.exe -ExecutionPolicy Unrestricted -WindowStyle hidden -NoLogo -NonInteractive -File bg-changer.ps1

add-type @"
using System;
using System.Runtime.InteropServices;
using Microsoft.Win32;

namespace Wallpaper {
  public enum Style : int {
      Span, Fill, Fit, Center, Tile, NoChange
  }

  public class Setter {
     private const int SetDesktopWallpaper = 20;
     private const int UpdateIniFile = 0x01;
     private const int SendWinIniChange = 0x02;

     [DllImport("user32.dll", SetLastError = true, CharSet = CharSet.Auto)]
     private static extern int SystemParametersInfo (int uAction, int uParam, string lpvParam, int fuWinIni);

     public static void Set ( string path, Wallpaper.Style style ) {
        SystemParametersInfo( SetDesktopWallpaper, 0, path, UpdateIniFile | SendWinIniChange );

        RegistryKey key = Registry.CurrentUser.OpenSubKey("Control Panel\\Desktop", true);
        switch( style )
        {
           case Style.Span :
              key.SetValue(@"WallpaperStyle", "22") ;
              key.SetValue(@"TileWallpaper", "0") ;
              break;
           case Style.Fill :
              key.SetValue(@"WallpaperStyle", "10") ;
              key.SetValue(@"TileWallpaper", "0") ;
              break;
           case Style.Fit :
              key.SetValue(@"WallpaperStyle", "6") ;
              key.SetValue(@"TileWallpaper", "0") ;
              break;
           case Style.Center :
              key.SetValue(@"WallpaperStyle", "1") ;
              key.SetValue(@"TileWallpaper", "0") ;
              break;
           case Style.Tile :
              key.SetValue(@"WallpaperStyle", "1") ;
              key.SetValue(@"TileWallpaper", "1") ;
              break;
           case Style.NoChange :
              break;
        }
        key.Close();
     }
  }
}
"@

Function Set-WallPaper($value)
{
  $b = Get-ChildItem $value\* -Recurse -Include *.jpg, *.jpeg, *.png, *.gif | Get-Random
  [Wallpaper.Setter]::Set( $b.FullName, "Fit" )
  echo $b.FullName
}

while (1) {
  Set-WallPaper -value 'D:\Data\Graphics\Reference\Cosmos'
  start-sleep -seconds 3600
}
