From: willy@linux.intel.com (Matthew Wilcox)
Date: Tue, 10 Dec 2013 09:49:01 -0500
Subject: [PATCH] Dynamically allocate partition numbers
In-Reply-To: <52A6F712.7010308@bjorling.me>
References: <20131209175846.GH6900@linux.intel.com>
 <52A6F712.7010308@bjorling.me>
Message-ID: <20131210144901.GI6900@linux.intel.com>

On Tue, Dec 10, 2013@12:12:18PM +0100, Matias Bj?rling wrote:
> >@@ -1975,12 +1947,13 @@ static struct nvme_ns *nvme_alloc_ns(struct nvme_dev *dev, unsigned nsid,
> >  		blk_queue_max_hw_sectors(ns->queue, dev->max_hw_sectors);
> >
> >  	disk->major = nvme_major;
> >-	disk->minors = NVME_MINORS;
> >-	disk->first_minor = NVME_MINORS * nvme_get_ns_idx();
> >+	disk->minors = 0;
> 
> The above line can be removed.

Hm, yeah, good point, alloc_disk() initialises ->minors, and always has,
so we didn't need to initialise it before either.  I'll take that line
out before committing.

> Tested and works.

I'll add your tested-by.  I tested it myself with about 80 partitions.
