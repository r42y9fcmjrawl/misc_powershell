$file = ""
$user = ""

$acl = Get-Acl -Path $file

foreach ($access in $acl.Access) {
    if ($access.IdentityReference.Value -ne $user) {
        $acl.SetAccessRuleProtection($true, $false)
        $acl.RemoveAccessRule($access) | Out-Null
    }
}

Set-Acl -Path $file -AclObject $acl

$acl = Get-Acl -Path $file
$acl.Access