# Enc

save my enc files

## clone:
git clone git://github.com/soloC/enc.git


# Restor
```
dec.sh .
for i in `ls`
do
    if [ -d $i ]
    then
        mkdir $i-git
        cd $i-git
        git init .
        git am ../$i
        cd -
    fi
done
```

# Create local git repository
```
NEW_REPO=repo-name.git
mkdir $NEW_REPO
cd  $NEW_REPO
git init --bare
cd -
mkdir test
cd test
git init .
touch README.md
git add .
git commit -m "initial commit"
git remote add origin localhost:`pwd`/../$NEW_REPO
git push -u origin master 
cd -
rm test -fr
```

# Clone local git repository
```
git clone localhost:/repo-path/repo-name.git

# or

git clone user@ip:/repo-path/repo-name.git
```

