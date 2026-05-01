# shellcheck shell=sh

. "${FUNCTIONS}"
. "${ACTIVATE_SH}"

#####
# Tests what happens when .autoenv.enter is not a file.
#####

# Prepare files/directories
mkdir -pv 'a/.autoenv.enter' 'b'
mkfifo 'b/.autoenv.enter'

# .autoenv.enter is a directory
patterntest 'echo "Y" | cd a' '^$'
# .autoenv.enter is a fifo
patterntest 'echo "Y" | cd b' '^$'
