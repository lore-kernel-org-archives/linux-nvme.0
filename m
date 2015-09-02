From: sagig@dev.mellanox.co.il (Sagi Grimberg)
Date: Wed, 2 Sep 2015 11:04:52 +0300
Subject: [PATCH 3/3] block: Refuse adding appending a gapped integrity
 page to a bio
In-Reply-To: <20150819104246.GA4956@infradead.org>
References: <1436966356-8979-1-git-send-email-sagig@mellanox.com>
 <1436966356-8979-4-git-send-email-sagig@mellanox.com>
 <55A67C17.4080706@kernel.dk> <20150716092646.GA17712@infradead.org>
 <55A7D4B6.9020101@kernel.dk> <55ABBFB1.7070201@dev.mellanox.co.il>
 <20150819094003.GB14734@infradead.org> <55D45AE0.50805@dev.mellanox.co.il>
 <20150819104246.GA4956@infradead.org>
Message-ID: <55E6ADA4.5040905@dev.mellanox.co.il>

On 8/19/2015 1:42 PM, Christoph Hellwig wrote:
> On Wed, Aug 19, 2015@01:30:56PM +0300, Sagi Grimberg wrote:
>> Actually I didn't. I started to, but then I noticed that
>> I was still seeing gaps when using cfq (e.g. non-mq code
>> path), I assume that this was never tested?
>
> It probably wasn't.  The only user so far is the NVMe driver which
> is blk-mq only.

So I got back to have a look on this. I originally thought that
this issue was specific to io schedulers, but I don't think it is
anymore, its just easier to trigger with io schedulers.

It seems we are only protecting against gapped back merges (i.e.
appending a gapped bio to a request biotail) but we are not protecting
against front merges (i.e. adding a gapped bio to request as the bio
head).

Imagine we have two bio_vec elements and the queue boundary is 0xfff:
req_bvec: offset=0xe00 length=0x200
bio_bvec: offset=0x0 length=0x200

bvec_gap_to_prev() will allow back merging {req_bvec, bio_bvec} as
bio_vec->offset=0x0 and req_bvec->offset + req_bvec->length is aligned
to the queue boundary, but the problem is we might do a front merge
{bio_bvec, req_bvec} which gives us a gap.

I'm able to reproduce this with iser with 512B sequential reads
(encourage gapped merges) but I wonder how this issue was missed in
nvme (the code seem to allow front merges)?

Anyway, the patch below seems to solved the issue for me:

Comments?

--
commit 100383e208045368b4e3ac20e3fa46bdad966df2
Author: Sagi Grimberg <sagig at mellanox.com>
Date:   Wed Sep 2 01:31:39 2015 +0300

     block: Protect against front merges with gaps

     We seem to have missed gaps detection on front merges.
     Introduce req_gap_to_next call that is should detect
     a gap in a front merge.

     Signed-off-by: Sagi Grimberg <sagig at mellanox.com>

diff --git a/block/blk-merge.c b/block/blk-merge.c
index 09bf5cb..c95152a 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -327,9 +327,20 @@ int ll_back_merge_fn(struct request_queue *q, 
struct request *req,
         return ll_new_hw_segment(q, req, bio);
  }

+static int req_gap_to_next(struct request *req, struct bio *bio)
+{
+       struct bio *next = req->bio;
+
+       return bvec_gap_to_prev(req->q, &bio->bi_io_vec[bio->bi_vcnt - 1],
+                       next->bi_io_vec[0].bv_offset);
+}
+
  int ll_front_merge_fn(struct request_queue *q, struct request *req,
                       struct bio *bio)
  {
+       if (req_gap_to_next(req, bio))
+               return 0;
+
         if (blk_rq_sectors(req) + bio_sectors(bio) >
             blk_rq_get_max_sectors(req)) {
                 req->cmd_flags |= REQ_NOMERGE;
--
