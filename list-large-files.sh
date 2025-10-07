# Lists files that should be tracked by Git Large File Storage instead of vanilla Git
# OR left out of repo via gitignore
# More than 50MB

git rev-list --objects --all \
| git cat-file --batch-check='%(objecttype) %(objectname) %(objectsize) %(rest)' \
| awk '/^blob/ {print substr($0,6)}' \
| sort --numeric-sort --key=2 --reverse \
| awk '$2 > (50 * 1024 * 1024)' \
| cut -c 1-12,41-