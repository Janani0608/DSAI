import platform
import subprocess
import numpy as np
import matplotlib.pyplot as plt

def ping_dest(dest):
  param = 'n' if platform.system().lower()=='windows' else 'c'
  command = "ping -{} 1 {}".format(param, dest)
  try:
    output = subprocess.check_output(command, shell = True)
    if 'unreachable' in output:
      return False
    else:
      output = output.split('\n')
      rtt = np.inf
      for i in range(len(output)):
        if output[i].startswith('round-trip'):
          rtt = output[i].split("=")[1].split("/")[1]
      return rtt
  except Exception:
  	return False

def main():
  host_RTT = []
  distance = []
  with open("destinations.txt", "r") as dest_file:
    for line in dest_file:
      host_info = line.strip().split(" ")
      dest = host_info[0]
      distance.append(host_info[1])
      rtt = ping_dest(dest)
      if rtt:
        host_RTT.append(rtt)
      else:
        host_RTT.append(np.inf)
  plt.xlabel("Distance")
  plt.ylabel("RTT")
  plt.scatter(distance, host_RTT)
  plt.show()
   

if __name__ == '__main__':
  main()