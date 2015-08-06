From: hch@lst.de (Christoph Hellwig)
Date: Thu, 6 Aug 2015 15:45:43 +0200
Subject: [PATCH 5/6] dm: split out a helper to find the ioctl target
In-Reply-To: <20150804180558.GB28971@redhat.com>
References: <1438672271-11309-1-git-send-email-hch@lst.de>
 <1438672271-11309-6-git-send-email-hch@lst.de>
 <20150804180558.GB28971@redhat.com>
Message-ID: <20150806134543.GC1646@lst.de>

On Tue, Aug 04, 2015@02:05:59PM -0400, Mike Snitzer wrote:
> static int dm_get_live_table_for_ioctl(struct mapped_device *md, int *srcu_idx,
> 	     struct dm_target **tgt, struct block_device **bdev, fmode_t *mode)
> 
> Otherwise, looks good.

I'll update it.
