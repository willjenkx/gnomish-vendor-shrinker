$installdirectory = "G:\World of Warcraft\_retail_\Interface\AddOns\GnomishVendorShrinker\"

rm "$installdirectory*" -Recurse -Force

Copy-Item -Path ".\src\*" -Destination $installdirectory -Recurse