From: hch@lst.de (Christoph Hellwig)
Date: Fri, 17 Aug 2018 08:55:14 +0200
Subject: [PATCH 2/5] nvme: register ns_id attributes as default sysfs
 groups
In-Reply-To: <20180814073305.87255-3-hare@suse.de>
References: <20180814073305.87255-1-hare@suse.de>
 <20180814073305.87255-3-hare@suse.de>
Message-ID: <20180817065514.GC11170@lst.de>

On Tue, Aug 14, 2018@09:33:02AM +0200, Hannes Reinecke wrote:
> We should be registering the ns_id attribute as default sysfs
> attribute groups, otherwise we have a race condition between
> the uevent and the attributes appearing in sysfs.
> 
> Signed-off-by: Hannes Reinecke <hare at suse.com>
> Reviewed-by: Christoph Hellwig <hch at lst.de>

I only reviewed the original patch without the lightnvm additions.
Please drop reviewed-by tags if you make non-trivial changes.

In this case I also wonder if you should have just kept the original
patch as-is and added a new one for lightnvm.
