From: joseph.r.gruher@intel.com (Gruher, Joseph R)
Date: Thu, 20 Apr 2017 17:30:52 +0000
Subject: cqe dump errors on target while running nvme-of large block
 read IO
In-Reply-To: <991b26ec-69d3-9e1c-ed3e-0d6e6618e73a@grimberg.me>
References: <DE927C68B458BE418D582EC97927A9285505C9EA@ORSMSX113.amr.corp.intel.com>
 <47f19583-1882-09d4-ce1c-534b8e59068b@mellanox.com>
 <DE927C68B458BE418D582EC97927A9285505F0C9@ORSMSX113.amr.corp.intel.com>
 <52c550c1-849b-7ea5-ab34-56543cb9069d@mellanox.com>
 <991b26ec-69d3-9e1c-ed3e-0d6e6618e73a@grimberg.me>
Message-ID: <DE927C68B458BE418D582EC97927A928550680FF@ORSMSX113.amr.corp.intel.com>

> These errors are either from:
> 1. mapping error on the host side - not sure given we don't see any error
> completions/events from the rdma device. However, can you turn on dynamic
> debug to see QP events?
> 
> echo "func nvme_rdma_qp_event +p" >
> /sys/kernel/debug/dynamic_debug/control

Yes, I can try this out.  Will this just print to dmesg or do I need to collect a log from somewhere?

> The fact that null_blk didn't reproduce this was probably because it is less
> bursty (which can cause network congestion).

See email I just now sent in reply to Max (this same thread).  I believe we reproduced the same issue with null_blk last night after correctly configuring some latency into the null_blk devices.

> Joseph, are you sure that flow control is correctly configured and working
> reliably?

I believe it is set up correctly.  Running ethtool against the NIC interfaces in use reports:
	Supported pause frame use: Symmetric Receive-only

And all ports in use on the Arista 7060X switch report it turned on in both directions:
	flowcontrol send on
	flowcontrol receive on

If there's anywhere else we can check, or any direct test of flow control we can run, happy to try it.  Should we be OK with only Rx flow control at the NIC (this seems to be the default behavior) or is it recommended to set up Tx flow control as well?
