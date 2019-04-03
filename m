From: hare@suse.com (Hannes Reinecke)
Date: Thu, 4 Apr 2019 00:13:22 +0200
Subject: [PATCH 2/2] nvmet: make CNTLID range configurable
In-Reply-To: <20190403181136.GF28682@lst.de>
References: <20190329120404.55637-1-hare@suse.de>
 <20190329120404.55637-3-hare@suse.de> <20190403181136.GF28682@lst.de>
Message-ID: <b92138cd-2e58-4dc6-35ca-d159d2a82a1b@suse.com>

On 4/3/19 8:11 PM, Christoph Hellwig wrote:
> On Fri, Mar 29, 2019@01:04:04PM +0100, Hannes Reinecke wrote:
>> When trying to run in a clustered environment we need to keep the
>> controller ID values unique. So this patch add to additional config
>> attributes 'cntlid_min' and 'cntlid_max' to only allow specific ranges
>> for the controller ID.
> 
> Err, can you explain the use case a little better?  This sounds like
> running two different nvmet instances and preting they are a single
> subsystem.  Which sounds pretty dangerous without additional
> communication layers.
> 
I'm running three qemu instances with RDMA HCAs via vfio.
Two instances are accessing the same backing device and exporting that 
via NVME-oF to the third; one exports the device as 'optimized' and the 
other as 'non-optimized'.
Idea it to power-cycle/reset/crash the first instance and test failover.

Cheers,

Hannes
