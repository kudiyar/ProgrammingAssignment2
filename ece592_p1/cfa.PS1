# used to commit (commit from above)

param(
	[string]$r,
	[string]$m
)

cd $r;

../art/acp -msg $m;

cd ..;