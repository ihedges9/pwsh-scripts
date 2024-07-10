# Remove WhatIf parameter from Line 20 to delete files

# IN CASE MORE FOLDERS NEED ADDED, READ BELOW
### Array for file paths of folders to remove excess packages is inside of the ForEach statement for users (Line 9)


# Working code block
gci "C:\Users" | ? { $_.Name -like "UIPath*bot*" } | ForEach-Object {
    $paths = @("C:\Users\$_\.nuget\packages\uipath", "C:\Users\$_\.nuget\packages\uipath.system.activities", "C:\Users\$_\.nuget\packages\uipath.uiautomation.activities")
    ForEach ( $path in $paths ) {
        Get-ChildItem $path -File | 
                # Sort them from Newest to Oldest
                Sort-Object CreationTime -Descending |
                # Skip the first two (the newest)
                Select-Object -Skip 2 |
                # Remove the rest
                Remove-Item -Force -WhatIf
    }
}
