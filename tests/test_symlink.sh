# shellcheck shell=sh

. "${FUNCTIONS}"
. "${ACTIVATE_SH}"

# .autoenv.enter might be a symlink
# .autoenv.enter might be a symlink to a parent directory
# .autoenv.enter might be a symlink to a child directory
# .autoenv.enter might be a symlink to a nonexistent file
# The current directory might be a symlink

# Structure:
# a
#  - b
#    - .autoenv.enter
#  - c
#    - .autoenv.enter -> ../b/.autoenv.enter
#  - d
#    - .autoenv.enter -> ../nonexistent
#  - e -> c
# b
#   - c
#     - .autoenv.enter -> ../.autoenv.enter
#   - .autoenv.enter
# c
#   - d
#     - .autoenv.enter
#   - .autoenv.enter -> e/.autoenv.enter


# Prepare files/directories
mkdir -pv 'a/b' 'a/c' 'a/d'
mkdir -pv 'b/c'
mkdir -pv 'c/d'
ln -s '../b/.autoenv.enter' 'a/c/.autoenv.enter'
ln -s '../nonexistent' 'a/d/.autoenv.enter'
ln -s '../.autoenv.enter' 'b/c/.autoenv.enter'
ln -s 'd/.autoenv.enter' 'c/.autoenv.enter'
ln -s 'c' 'a/e'
echo 'echo b' > 'a/b/.autoenv.enter'
echo 'echo b' > 'b/.autoenv.enter'
echo 'echo d' > 'c/d/.autoenv.enter'

# .autoenv.enter is a smylink
patterntest 'echo "Y" | cd a/c' '.*b$'
# .autoenv.enter is a symlink to a parent directory
patterntest 'yes "Y" | cd b/c' '.*b$'
# .autoenv.enter is a symlink to a child directory
patterntest 'yes "Y" | cd c' '.*d$'
# .autoenv.enter is a nonexistent symlink
patterntest 'echo "Y" | cd a/d' '^$'
# The current directory is a symlink
patterntest 'echo "Y" | cd a/e' '.*b$'
