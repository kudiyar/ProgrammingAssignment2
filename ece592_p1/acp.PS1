# used to commit

Param(
	[string]$msg

)

echo 'adding';
git add .;

#echo "commit: $msg";
echo 'committing';
git commit --message=$msg;

echo 'pushing';
git push;