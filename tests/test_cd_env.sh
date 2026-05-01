# shellcheck shell=sh

. "${FUNCTIONS}"
. "${ACTIVATE_SH}"

# Prepare files/directories
mkdir -pv 'a/.env' 'b/.env'
echo 'echo b' > 'b/.env/.autoenv.enter'

# Test without an autoenv file
patterntest 'echo "Y" | cd a/.env' '^$'
# Test with a directory with autoenv file
patterntest 'echo "Y" | cd b/.env' '.*b$'
