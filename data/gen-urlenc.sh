# taken from https://gist.github.com/cdown/1163649#gistcomment-1256298
# related: https://askubuntu.com/questions/53770
urlencode_fast() {
  local length="${#1}"
  for (( i = 0; i < length; i++ )); do
    local c="${1:i:1}"
    case $c in
      [a-zA-Z0-9.~_-]) printf "$c" ;;
    *) printf "$c" | xxd -p -c1 | while read x;do printf "%%%s" "$x";done
    esac
  done
}

cd "./al/"
ALS=$(find . -regex ".*\.al")

CNT=0

for filename in $ALS; do
  let "CNT+=1"
  if [[ 0 == $(($CNT % 500)) ]]
    then
    echo $CNT
  fi

  filename=$(basename -- "$filename")
  CHAR="${filename%.*}"

  echo "$CHAR"

  OUT=$( urlencode_fast $CHAR )
  ln -s $filename "./$OUT.al"
done
