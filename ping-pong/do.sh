for core in $(seq 0 47); do
  echo "Testing core $core"
  taskset -c $core onload sfnt-pingpong --bind <local_ip> &
  sleep 2
  # Run client from remote machine, record results
  kill %1
done
