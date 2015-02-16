#!/usr/bin/env bash
#Alert if file length exceeds given lines.

#    This program is free software: you can redistribute it and/or modify
#    it under the terms of the GNU General Public License as published by
#    the Free Software Foundation, either version 3 of the License, or
#    (at your option) any later version.
#
#    This program is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU General Public License for more details.
#
#    You should have received a copy of the GNU General Public License
#    along with this program.  If not, see <http://www.gnu.org/licenses/>.



USAGE="\nUsage: $0 filename warninglines criticallines OR "
USAGE="${USAGE} \r\n to read from stdin, omit filename.\n"
WC=$(which wc)

#echo "$#"

if [ "$#" -eq "2" ]; then
read n <<EOF
$(${WC} -l)
EOF
elif [ "$#" -eq "3" ]; then
  n="$(${WC} -l "$1" | awk '{print $1}')"
  filename="${1}"
  shift
else
 printf "${USAGE}"
 exit 3
fi



if [ "${n}" -gt "$2" ]; then
 echo "CRITICAL: ${filename} lines ${n} > $2"
 exit 2
elif [ "${n}" -gt "$1" ]; then
 echo "WARNING: ${filename} lines ${n} > $1"
 exit 1
fi

echo "OK: ${filename} lines ${n} < $1 and $2"
