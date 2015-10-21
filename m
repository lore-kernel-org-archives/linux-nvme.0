From: mlin@kernel.org (Ming Lin)
Date: Wed, 21 Oct 2015 13:13:09 -0700
Subject: [PATCH v6 05/11] block: remove split code in
 blkdev_issue_{discard,write_same}
In-Reply-To: <20151021181812.GA5807@redhat.com>
References: <1439363241-31772-1-git-send-email-mlin@kernel.org>
 <1439363241-31772-6-git-send-email-mlin@kernel.org>
 <20151013115011.GA6546@infradead.org>
 <CAF1ivSbsH7JsduHE+a2d+BEbZL6Fo7uJWS2NCTTMNTSAUMt0UA@mail.gmail.com>
 <20151014132700.GA19401@infradead.org> <20151021160232.GA5089@redhat.com>
 <20151021161947.GA5212@redhat.com> <1445448806.26847.6.camel@ssi>
 <20151021181812.GA5807@redhat.com>
Message-ID: <1445458389.26847.10.camel@ssi>

On Wed, 2015-10-21@14:18 -0400, Mike Snitzer wrote:
> On Wed, Oct 21 2015 at  1:33pm -0400,
> Ming Lin <mlin@kernel.org> wrote:
> 
> > On Wed, 2015-10-21@12:19 -0400, Mike Snitzer wrote:
> > > On Wed, Oct 21 2015 at 12:02pm -0400,
> > > Mike Snitzer <snitzer@redhat.com> wrote:
> > > 
> > > > On Wed, Oct 14 2015 at  9:27am -0400,
> > > > Christoph Hellwig <hch@infradead.org> wrote:
> > > > 
> > > > > On Tue, Oct 13, 2015@10:44:11AM -0700, Ming Lin wrote:
> > > > > > I just did a quick test with a Samsung 900G NVMe device.
> > > > > > mkfs.xfs is OK on 4.3-rc5.
> > > > > > 
> > > > > > What's your device model? I may find a similar one to try.
> > > > > 
> > > > > This is a HGST Ultrastar SN100
> > > > > 
> > > > > Analsys and tentativ fix below:
> > > > > 
> > > > > blktrace for before the commit:
> > > > > 
> > > > > 259,0    1        2     0.000002543  2394  G   D 0 + 8388607 [mkfs.xfs]
> > > > > 259,0    1        3     0.000008230  2394  I   D 0 + 8388607 [mkfs.xfs]
> > > > > 259,0    1        4     0.000031090   207  D   D 0 + 8388607 [kworker/1:1H]
> > > > > 259,0    1        5     0.000044869  2394  Q   D 8388607 + 8388607 [mkfs.xfs]
> > > > > 259,0    1        6     0.000045992  2394  G   D 8388607 + 8388607 [mkfs.xfs]
> > > > > 259,0    1        7     0.000049559  2394  I   D 8388607 + 8388607 [mkfs.xfs]
> > > > > 259,0    1        8     0.000061551   207  D   D 8388607 + 8388607 [kworker/1:1H]
> > > > > 
> > > > > .. and so on.
> > > > > 
> > > > > blktrace with the commit:
> > > > > 
> > > > > 259,0    2        1     0.000000000  1228  Q   D 0 + 4194304 [mkfs.xfs]
> > > > > 259,0    2        2     0.000002543  1228  G   D 0 + 4194304 [mkfs.xfs]
> > > > > 259,0    2        3     0.000010080  1228  I   D 0 + 4194304 [mkfs.xfs]
> > > > > 259,0    2        4     0.000082187   267  D   D 0 + 4194304 [kworker/2:1H]
> > > > > 259,0    2        5     0.000224869  1228  Q   D 4194304 + 4194304 [mkfs.xfs]
> > > > > 259,0    2        6     0.000225835  1228  G   D 4194304 + 4194304 [mkfs.xfs]
> > > > > 259,0    2        7     0.000229457  1228  I   D 4194304 + 4194304 [mkfs.xfs]
> > > > > 259,0    2        8     0.000238507   267  D   D 4194304 + 4194304 [kworker/2:1H]
> > > > > 
> > > > > So discards are smaller, but better aligned.  Now if I tweak a single
> > > > > line in blk-lib.c to be able to use all of bi_size I get the old I/O
> > > > > pattern back and everything works fine again:
> > > > > 
> > > > > diff --git a/block/blk-lib.c b/block/blk-lib.c
> > > > > index bd40292..65b61dc 100644
> > > > > --- a/block/blk-lib.c
> > > > > +++ b/block/blk-lib.c
> > > > > @@ -82,7 +82,7 @@ int blkdev_issue_discard(struct block_device *bdev, sector_t sector,
> > > > >  			break;
> > > > >  		}
> > > > >  
> > > > > -		req_sects = min_t(sector_t, nr_sects, MAX_BIO_SECTORS);
> > > > > +		req_sects = min_t(sector_t, nr_sects, UINT_MAX >> 9);
> > > > >  		end_sect = sector + req_sects;
> > > > >  
> > > > >  		bio->bi_iter.bi_sector = sector;
> > > > 
> > > > Can we change UINT_MAX >> 9 to rounddown to the first factor of
> > > > minimum_io_size?
> > > > 
> > > > That should work for all devices and for dm-thinp (and dm-cache) in
> > > > particular will ensure that all discards that are issued will be a
> > > > multiple of the underlying device's blocksize.
> > > 
> > > Jeff Moyer pointed out having req_sects be a factor of
> > > discard_granularity makes more sense.  And I agree.  Same difference in
> > > the end (since dm-thinp sets discard_granularity to the thinp
> > > blocksize).
> > 
> > An old version of this patch did use discard_granularity
> > https://www.redhat.com/archives/dm-devel/2015-August/msg00000.html
> > 
> > But you didn't agree.
> > https://www.redhat.com/archives/dm-devel/2015-August/msg00001.html
> > 
> > Maybe we can re-add discard_granularity now?
> 
> I disagreed on a more generic level than discard_granularity shaping the
> split boundary.
> 
> But we are where we are.  If we're going to split (due to 32-bit limits
> in bio->bi_iter.bi_size) then we should at least do so in terms of the
> support discard_granularity.

How about below?
It actually reverts commit b49a0871 and adds patch at
https://www.redhat.com/archives/dm-devel/2015-August/msg00000.html

Christoph, could you help to try it?

commit 122bf0a43cb1611ed62aaf945f25b649c27a71ed
Author: Ming Lin <mlin at kernel.org>
Date:   Wed Oct 21 11:24:48 2015 -0700

    block: check discard_granularity and alignment
    
    Signed-off-by: Ming Lin <ming.l at ssi.samsung.com>
---
 block/blk-lib.c | 31 ++++++++++++++++++++++---------
 1 file changed, 22 insertions(+), 9 deletions(-)

diff --git a/block/blk-lib.c b/block/blk-lib.c
index bd40292..9ebf653 100644
--- a/block/blk-lib.c
+++ b/block/blk-lib.c
@@ -26,13 +26,6 @@ static void bio_batch_end_io(struct bio *bio)
 	bio_put(bio);
 }
 
-/*
- * Ensure that max discard sectors doesn't overflow bi_size and hopefully
- * it is of the proper granularity as long as the granularity is a power
- * of two.
- */
-#define MAX_BIO_SECTORS ((1U << 31) >> 9)
-
 /**
  * blkdev_issue_discard - queue a discard
  * @bdev:	blockdev to issue discard for
@@ -50,6 +43,8 @@ int blkdev_issue_discard(struct block_device *bdev, sector_t sector,
 	DECLARE_COMPLETION_ONSTACK(wait);
 	struct request_queue *q = bdev_get_queue(bdev);
 	int type = REQ_WRITE | REQ_DISCARD;
+	unsigned int granularity;
+	int alignment;
 	struct bio_batch bb;
 	struct bio *bio;
 	int ret = 0;
@@ -61,6 +56,10 @@ int blkdev_issue_discard(struct block_device *bdev, sector_t sector,
 	if (!blk_queue_discard(q))
 		return -EOPNOTSUPP;
 
+	/* Zero-sector (unknown) and one-sector granularities are the same.  */
+	granularity = max(q->limits.discard_granularity >> 9, 1U);
+	alignment = (bdev_discard_alignment(bdev) >> 9) % granularity;
+
 	if (flags & BLKDEV_DISCARD_SECURE) {
 		if (!blk_queue_secdiscard(q))
 			return -EOPNOTSUPP;
@@ -74,7 +73,7 @@ int blkdev_issue_discard(struct block_device *bdev, sector_t sector,
 	blk_start_plug(&plug);
 	while (nr_sects) {
 		unsigned int req_sects;
-		sector_t end_sect;
+		sector_t end_sect, tmp;
 
 		bio = bio_alloc(gfp_mask, 1);
 		if (!bio) {
@@ -82,8 +81,22 @@ int blkdev_issue_discard(struct block_device *bdev, sector_t sector,
 			break;
 		}
 
-		req_sects = min_t(sector_t, nr_sects, MAX_BIO_SECTORS);
+		/* Make sure bi_size doesn't overflow */
+		req_sects = min_t(sector_t, nr_sects, UINT_MAX >> 9);
+
+		/*
+		 * If splitting a request, and the next starting sector would be
+		 * misaligned, stop the discard at the previous aligned sector.
+		 */
 		end_sect = sector + req_sects;
+		tmp = end_sect;
+		if (req_sects < nr_sects &&
+		    sector_div(tmp, granularity) != alignment) {
+			end_sect = end_sect - alignment;
+			sector_div(end_sect, granularity);
+			end_sect = end_sect * granularity + alignment;
+			req_sects = end_sect - sector;
+		}
 
 		bio->bi_iter.bi_sector = sector;
 		bio->bi_end_io = bio_batch_end_io;
