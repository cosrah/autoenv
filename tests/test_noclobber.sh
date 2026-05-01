# shellcheck shell=sh

. "${FUNCTIONS}"
. "${ACTIVATE_SH}"

mkdir a
echo 'echo a' > a/.autoenv.enter

patterntest 'set -C; echo "Y" | cd a' '.*a$'

