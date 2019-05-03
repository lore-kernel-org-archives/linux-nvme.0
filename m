From: kbusch@kernel.org (Keith Busch)
Date: Fri, 3 May 2019 10:01:16 -0600
Subject: [PATCHv3 1/2] nvme-multipath: avoid crash on invalid subsystem
 cntlid enumeration
In-Reply-To: <20190503133736.111201-2-hare@suse.de>
References: <20190503133736.111201-1-hare@suse.de>
 <20190503133736.111201-2-hare@suse.de>
Message-ID: <20190503160116.GA30291@localhost.localdomain>

On Fri, May 03, 2019@03:37:35PM +0200, Hannes Reinecke wrote:
> A process holding an open reference to a removed disk prevents it
> from completing deletion, so its name continues to exist. A subsequent
> gendisk creation may have the same cntlid which risks collision when
> using that for the name. Use the unique ctrl->instance instead.
> 
> Signed-off-by: Hannes Reinecke <hare at suse.com>

Looks good

Reviewed-by: Keith Busch <keith.busch at intel.com>
