From: keith.busch@intel.com (Keith Busch)
Date: Wed, 10 Feb 2016 19:49:07 +0000
Subject: [PATCH for-4.5 04/13] NVMe: Set queue limits max_dev_sectors
In-Reply-To: <20160210184031.GB7512@infradead.org>
References: <1455128250-5984-1-git-send-email-keith.busch@intel.com>
 <1455128250-5984-5-git-send-email-keith.busch@intel.com>
 <20160210182051.GA28235@infradead.org>
 <20160210182416.GC32064@localhost.localdomain>
 <20160210184031.GB7512@infradead.org>
Message-ID: <20160210194907.GA23402@localhost.localdomain>

On Wed, Feb 10, 2016@10:40:31AM -0800, Christoph Hellwig wrote:
> Ohh, I see now - blk_set_default_limits initializes max_dev_sectors to
> BLK_SAFE_MAX_SECTORS instead of leaving it as zero.  I think that's the
> issue which needs to be fixed.

Heh, that's pretty funny. I mentioned something along those lines after
I broke the the block layer in rc1, but thought it was done that way on
purpose. :)

So instead of this nvme specific patch, we should do this?

---
diff --git a/block/blk-settings.c b/block/blk-settings.c
index dd49735..c7bb666 100644
--- a/block/blk-settings.c
+++ b/block/blk-settings.c
@@ -91,8 +91,8 @@ void blk_set_default_limits(struct queue_limits *lim)
        lim->seg_boundary_mask = BLK_SEG_BOUNDARY_MASK;
        lim->virt_boundary_mask = 0;
        lim->max_segment_size = BLK_MAX_SEGMENT_SIZE;
-       lim->max_sectors = lim->max_dev_sectors = lim->max_hw_sectors =
-               BLK_SAFE_MAX_SECTORS;
+       lim->max_sectors = lim->max_hw_sectors = BLK_SAFE_MAX_SECTORS;
+       lim->max_dev_sectors = 0;
        lim->chunk_sectors = 0;
        lim->max_write_same_sectors = 0;
        lim->max_discard_sectors = 0;
--
