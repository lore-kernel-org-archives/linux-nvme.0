From: kbusch@kernel.org (Keith Busch)
Date: Thu, 4 Apr 2019 09:45:59 -0600
Subject: nvme cli format question
In-Reply-To: <754e9409-0255-220f-c4c2-18fe55dd4df3@intel.com>
References: <754e9409-0255-220f-c4c2-18fe55dd4df3@intel.com>
Message-ID: <20190404154559.GI16792@localhost.localdomain>

On Wed, Apr 03, 2019@04:03:25PM -0700, Heitke, Kenneth wrote:
> 
> What is the expected behavior when calling 'format' on a NVMe character
> device? I see two problems with the code below.
> 
> 1) If no namespace Id is specified and the device is not a block device,
> then nvme_identify_ns() is never called and the 'ns' variable used in
> the 'if (cfg.bs)' case is  uninitialized.
> 
> 2) If the namespace_id is specified or determined from the block device,
> then the 'cfg.bs' check is redundant (and done twice).

Right, not needed. Code yanked.
