% Please run "pkg install -forge parallel" and then "pkg load parallel"

x= rand (1000,1000);
tic
fun = @(x) x*x;
y = pararrayfun(nproc, fun, x);
toc
