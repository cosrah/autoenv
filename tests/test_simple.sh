# shellcheck shell=sh

. "${FUNCTIONS}"
. "${ACTIVATE_SH}"

# Prepare files/directories
mkdir -pv 'a/b' 'c/d'
echo 'echo a' > "a/.autoenv.enter"
echo 'echo b' > "a/b/.autoenv.enter"
echo 'echo c' > "c/.autoenv.enter"

# Test simple cd
patterntest 'echo "Y" | cd a' '.*a$'
# Test cd to subdirectory
( echo "Y" | cd a/b )
patterntest 'echo "Y" | cd a/b' '.*a
b$'
# Test cd with env in parent directory
patterntest 'echo "Y" | cd c/d' '.*c$'
# Test that .env is not sourced by default
mkdir -pv 'legacy'
echo 'echo legacy' > 'legacy/.env'
patterntest 'echo "Y" | cd legacy' '^$'
# Check cd into nonexistent directory
echo "Y" | cd d && exit 1 || :
