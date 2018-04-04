From: sagi@grimberg.me (Sagi Grimberg)
Date: Wed, 4 Apr 2018 15:36:45 +0300
Subject: [PATCH] nvme-multipath: implement active-active round-robin path
 selector
In-Reply-To: <20180328080646.GB20373@lst.de>
References: <20180327043851.6640-1-baegjae@gmail.com>
 <20180328080646.GB20373@lst.de>
Message-ID: <a8574e1c-d749-3abd-bc7d-2d6010087993@grimberg.me>


> For PCIe devices the right policy is not a round robin but to use
> the pcie device closer to the node.  I did a prototype for that
> long ago and the concept can work.  Can you look into that and
> also make that policy used automatically for PCIe devices?

I think that active/active makes sense for fabrics (link throughput
aggregation) but also for dual-ported pci devices (given that
this is a real use-case).

I agree that the default can be a home-node path selection.
