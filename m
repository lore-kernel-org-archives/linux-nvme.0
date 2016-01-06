From: tom.leiming@gmail.com (Ming Lei)
Date: Wed, 6 Jan 2016 17:46:39 +0800
Subject: [PATCH for-4.4] block: split bios to max possible length
In-Reply-To: <20160106055133.GA4868@localhost.localdomain>
References: <1451931895-17474-1-git-send-email-keith.busch@intel.com>
 <CACVXFVPOYra24SNmGBthcheYv_kY=5Fv-6s=-bSwwZijudXapw@mail.gmail.com>
 <20160105150938.GA20832@localhost.localdomain>
 <CACVXFVNQQNd8_3ti4AAhZB4KN0uJEN8sdmB+xsmpykJaCLfebA@mail.gmail.com>
 <20160106055133.GA4868@localhost.localdomain>
Message-ID: <20160106174639.65e0ced4@tom-T450>

On Wed, 6 Jan 2016 05:51:34 +0000
Keith Busch <keith.busch@intel.com> wrote:

> On Wed, Jan 06, 2016@10:17:51AM +0800, Ming Lei wrote:
> 
> But this patch was to split on stripe boundaries, which is an even worse
> penalty if we get the split wrong.
> 
> > +	bool no_sg_merge = !!test_bit(QUEUE_FLAG_NO_SG_MERGE, &q->queue_flags);
> >  
> >  	bio_for_each_segment(bv, bio, iter) {
> > -		if (sectors + (bv.bv_len >> 9) > blk_max_size_offset(q, bio->bi_iter.bi_sector))
> > +		if (no_sg_merge)
> > +			goto new_segment;
> 
> Bad idea for NVMe. We need to split on SG gaps, which you've skipped,
> or you will BUG_ON in the NVMe driver.

Given it is close to v4.4 release, I propose the following fix instead
of the bvec splitting approach, which is not ready in current block stack.

-----
 block/blk-merge.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/block/blk-merge.c b/block/blk-merge.c
index e73846a..9ffe431 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -81,8 +81,16 @@ static struct bio *blk_bio_segment_split(struct request_queue *q,
 	struct bio *new = NULL;
 
 	bio_for_each_segment(bv, bio, iter) {
-		if (sectors + (bv.bv_len >> 9) > blk_max_size_offset(q, bio->bi_iter.bi_sector))
+		if (sectors + (bv.bv_len >> 9) > blk_max_size_offset(q,
+					bio->bi_iter.bi_sector)) {
+			/*
+			 * avoid to split out zero length bio if size to
+			 * chunk boundary is too small
+			 */
+			if (!sectors)
+				goto new_segment;
 			goto split;
+		}
 
 		/*
 		 * If the queue doesn't support SG gaps and adding this
-- 
1.9.1
