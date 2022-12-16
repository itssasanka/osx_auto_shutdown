if [ "$EUID" -ne 0 ]
  then echo "Please run as root."
  exit
fi

while true
  do 
  output=`pmset -g batt`
  for i in {10..15}
  do
    if [[ $output == *"$i%"* ]]; then
      echo "Shutting down. Battery in reserve."
      shutdown -h now
    fi
  done
  echo "Watching...battery reserve yet to be met."
  sleep 5
done


