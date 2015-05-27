## Overview ##
Allows GitHub to be controlled via the Linux command line for quick creation and deletion of repositories
## Usage ##
```
Usage: github-repo.rb [reponame] [options]
    -a, --all                        List all (including forked repos)
    -d, --delete REPO                Delete a repository
    -l, --list                       List GitHub Repos
```
## Example ##
```
Providing a single argument to the script will create a repository with that name.
Executing the script without ang arguments will create a repository with the name
of the current directory.

[gdalziel@e3-1230v2 github-repo]$ ./github-repo.rb examplerepo
Repository 'examplerepo' successfully created

[gdalziel@e3-1230v2 github-repo]$ ./github-repo.rb
Repository 'github-repo' successfully created


-l will list the repositories owned by your user. By default forked
   repositories are not included.

[gdalziel@e3-1230v2 github-repo]$ ./github-repo.rb -l
examplerepo
rubyscripts
testservers


-a includes forked repositories in the repo list

[gdalziel@e3-1230v2 github-repo]$ ./github-repo.rb -la
examplerepo
fabric
rubyscripts
swa-common
testservers


-d will delete  the specified repository from your account. There is
   no confirmation and this cannot be undone

[gdalziel@e3-1230v2 github-repo]$ ./github-repo.rb -d examplerepo
Repository 'examplerepo' successfully deleted
[gdalziel@e3-1230v2 github-repo]$ ./github-repo.rb -l
rubyscripts
testservers
