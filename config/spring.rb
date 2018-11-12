#For this part this is a helper file to allso the startup, stop, and maintenance of some of the processes  
%w[
  .ruby-version
  .rbenv-vars
  tmp/restart.txt
  tmp/caching-dev.txt
].each { |path| Spring.watch(path) }
