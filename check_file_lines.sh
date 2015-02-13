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



USAGE="Usage: $0 filename warninglines criticallines"
WC=$(which wc)

echo "$#"

if [ "$#" != "3" ]; then
 echo "${USAGE}"
 exit 3
fi

n="$(${WC} -l "$1" | awk '{print $1}')"

if [ "${n}" -gt "$3" ]; then
 echo "CRITICAL: $1 lines ${n} > $3"
 exit 2
elif [ "${n}" -gt "$2" ]; then
 echo "WARNING: $1 lines ${n} > $2"
 exit 1
fi

echo "OK: $1 lines ${n} < $2 and $3"
