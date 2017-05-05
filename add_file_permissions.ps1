$file = ""
$user = ""

$acl = Get-Acl -Path $file
$hasAccess = $false

foreach ($access in $acl.Access) {
    if ($access.IdentityReference.Value -eq $user) {
        $hasAccess = $true
    }
}

if (!$hasAccess) {
    $rule = New-Object System.Security.AccessControl.FileSystemAccessRule($user, 'FullControl', 'Allow')
    $acl.AddAccessRule($rule)
}

Set-Acl -Path $file -AclObject $acl

$acl = Get-Acl -Path $file
$acl.Access