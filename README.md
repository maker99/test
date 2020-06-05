![CI](https://github.com/maker99/test/workflows/CI/badge.svg)


# testing CI 

2020-06-05: the CI tests don't complete, git checkout disregards the file permissions and forces all to 644 = non executable. 
            Thus the CI scripts will not run  unless you explicitly do a chmod 755 on each script.
   
