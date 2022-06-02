$name = Read-Host "Enter your name "
$age = Read-Host "Hello $name, Enter your age "
if ( $age -le 18 )
{
    echo "You are not able to do vote"
}
else
{
    echo "You are able to do vote"
}