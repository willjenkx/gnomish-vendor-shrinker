$installdirectory = "F:\World of Warcraft\_beta_\Interface\AddOns\GnomishVendorShrinker\"

rimraf "$installdirectory*"

Copy-Item -Path ".\src\*" -Destination $installdirectory -Recurse