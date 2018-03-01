From: sbates@raithlin.com (Stephen  Bates)
Date: Thu, 1 Mar 2018 15:58:40 +0000
Subject: [PATCH v2 08/10] nvme-pci: Add support for P2P memory in requests
In-Reply-To: <c6639530-48ba-4655-c772-7d88a030e37e@grimberg.me>
References: <20180228234006.21093-1-logang@deltatee.com>
 <20180228234006.21093-9-logang@deltatee.com>
 <c6639530-48ba-4655-c772-7d88a030e37e@grimberg.me>
Message-ID: <1CE68E79-E5FD-4EE2-BD88-B3EE57E43ACE@raithlin.com>

> Any plans adding the capability to nvme-rdma? Should be
> straight-forward... In theory, the use-case would be rdma backend
> fabric behind. Shouldn't be hard to test either...

Nice idea Sagi. Yes we have been starting to look at that. Though again we would probably want to impose the "attached to the same PCIe switch" rule which might be less common to satisfy in initiator systems. 

Down the road I would also like to discuss the best way to use this P2P framework to facilitate copies between NVMe namespaces (on both PCIe and fabric attached namespaces) without having to expose the CMB up to user space. Wasn't something like that done in the SCSI world at some point Martin?

Stephen
    
