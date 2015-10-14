From: dan.j.williams@intel.com (Williams, Dan J)
Date: Wed, 14 Oct 2015 19:42:40 +0000
Subject: [PATCH 2/5] block: Consolidate static integrity profile properties
In-Reply-To: <20151014072303.GA2544@infradead.org>
References: <B58D82457FDA0744A320A2FC5AC253B93CBE5758@fmsmsx104.amr.corp.intel.com>
 <1444683912-7140-1-git-send-email-martin.petersen@oracle.com>
 <1444683912-7140-3-git-send-email-martin.petersen@oracle.com>
 <CAPcyv4it_ju8JoNcmG7K3yiKyzS_hEsNRYhiLrU1ZvqfQHjVXw@mail.gmail.com>
 <20151014072303.GA2544@infradead.org>
Message-ID: <1444851760.3409.6.camel@intel.com>

On Wed, 2015-10-14@00:23 -0700, Christoph Hellwig wrote:
> On Tue, Oct 13, 2015@06:11:50PM -0700, Dan Williams wrote:
> > >  int nd_integrity_init(struct gendisk *disk, unsigned long meta_size)
> > >  {
> > > -       struct blk_integrity integrity = {
> > > +       struct blk_integrity bi;
> > > +       struct blk_integrity_profile profile = {
> > >                 .name = "ND-PI-NOP",
> > >                 .generate_fn = nd_pi_nop_generate_verify,
> > >                 .verify_fn = nd_pi_nop_generate_verify,
> > > -               .tuple_size = meta_size,
> > > -               .tag_size = meta_size,
> > 
> > 'profile' here needs to be made static since we reference rather than
> > copy the profile data at blk_integrity_register() time.  This is part
> > of, but I don't think all of, my blk_integrity shutdown woes.
> 
> Oh, yes.  Can we also add a single noop profile to block/blk-integrity.c
> while we're at it?
> 

Sounds good, how about?

8<------
Subject: block, libnvdimm: provide a built-in blk_integrity nop profile

From: Dan Williams <dan.j.williams@intel.com>

The libnvidmm-btt driver uses blk_integrity to reserve space for
per-sector metadata, but does not implement protection checksums.  This
property is generically useful, so teach the block core to internally
specify a nop profile if one is not provided at registration time.

Suggested-by: Christoph Hellwig <hch at lst.de>
Signed-off-by: Dan Williams <dan.j.williams at intel.com>
---
 block/blk-integrity.c |   13 ++++++++++++-
 drivers/nvdimm/core.c |   12 +-----------
 2 files changed, 13 insertions(+), 12 deletions(-)

diff --git a/block/blk-integrity.c b/block/blk-integrity.c
index dc4dea7b8a93..506cc16c1a92 100644
--- a/block/blk-integrity.c
+++ b/block/blk-integrity.c
@@ -384,6 +384,17 @@ static struct kobj_type integrity_ktype = {
 	.sysfs_ops	= &integrity_ops,
 };
 
+static int blk_integrity_nop_fn(struct blk_integrity_iter *iter)
+{
+	return 0;
+}
+
+static struct blk_integrity_profile nop_profile = {
+	.name = "nop",
+	.generate_fn = blk_integrity_nop_fn,
+	.verify_fn = blk_integrity_nop_fn,
+};
+
 /**
  * blk_integrity_register - Register a request_queue as being integrity-capable
  * @disk:	struct request_queue pointer to make integrity-aware
@@ -402,7 +413,7 @@ void blk_integrity_register(struct request_queue *q, struct blk_integrity *templ
 	bi->flags = BLK_INTEGRITY_VERIFY | BLK_INTEGRITY_GENERATE |
 		template->flags;
 	bi->interval_exp = ilog2(queue_logical_block_size(q));
-	bi->profile = template->profile;
+	bi->profile = template->profile ? template->profile : &nop_profile;
 	bi->tuple_size = template->tuple_size;
 	bi->tag_size = template->tag_size;
 
diff --git a/drivers/nvdimm/core.c b/drivers/nvdimm/core.c
index eeedd58bbcad..2ed3c934256f 100644
--- a/drivers/nvdimm/core.c
+++ b/drivers/nvdimm/core.c
@@ -392,24 +392,14 @@ void nvdimm_bus_unregister(struct nvdimm_bus *nvdimm_bus)
 EXPORT_SYMBOL_GPL(nvdimm_bus_unregister);
 
 #ifdef CONFIG_BLK_DEV_INTEGRITY
-static int nd_pi_nop_generate_verify(struct blk_integrity_iter *iter)
-{
-	return 0;
-}
-
 int nd_integrity_init(struct gendisk *disk, unsigned long meta_size)
 {
 	struct blk_integrity bi;
-	static struct blk_integrity_profile profile = {
-		.name = "ND-PI-NOP",
-		.generate_fn = nd_pi_nop_generate_verify,
-		.verify_fn = nd_pi_nop_generate_verify,
-	};
 
 	if (meta_size == 0)
 		return 0;
 
-	bi.profile = &profile;
+	bi.profile = NULL;
 	bi.tuple_size = meta_size;
 	bi.tag_size = meta_size;
 
