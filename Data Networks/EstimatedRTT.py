

def get_estimated_RTT(sample_RTT, estimated_RTT, alpha):
  for i in range(len(sample_RTT)):
    try:
      estimated_old = estimated_RTT[i]
      estimated_recent = (1-alpha)*estimated_old + alpha* sample_RTT[i]
      estimated_RTT.append(estimated_recent)
    except Exception:
  	  return False
  return estimated_RTT

def main():
  sample_RTT = [160, 110, 250, 230, 400]
  estimated_RTT = [115]
  alpha = 0.125
  estimated_RTT = get_estimated_RTT(sample_RTT, estimated_RTT, alpha)
  if estimated_RTT:
    print(estimated_RTT)
  else:
    print("Estimated RTTs could not be estimated due to an exception: Check if the Initial Estimated RTT, Sample RTT and alpha values are specified")

if __name__ == "__main__":
	main()

