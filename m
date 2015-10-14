From: dan.j.williams@intel.com (Williams, Dan J)
Date: Wed, 14 Oct 2015 19:36:24 +0000
Subject: [PATCH 08/11] nvme: suspend i/o during runtime
 blk_integrity_unregister
In-Reply-To: <CAPcyv4iCGu4osMe+SJTykDQjx103DzDdamqkK0J6b=H3Y5OHRw@mail.gmail.com>
References: <20151014022757.34443.25800.stgit@dwillia2-desk3.jf.intel.com>
 <20151014022841.34443.28017.stgit@dwillia2-desk3.jf.intel.com>
 <alpine.LNX.2.00.1510141355250.27742@localhost.lm.intel.com>
 <CAPcyv4iCGu4osMe+SJTykDQjx103DzDdamqkK0J6b=H3Y5OHRw@mail.gmail.com>
Message-ID: <1444851383.3409.3.camel@intel.com>

On Wed, 2015-10-14@11:17 -0700, Dan Williams wrote:
> On Wed, Oct 14, 2015@6:59 AM, Keith Busch <keith.busch@intel.com> wrote:
> > On Tue, 13 Oct 2015, Dan Williams wrote:
> >>
> >> Synchronize pending i/o against a change in the integrity profile to
> >> avoid the possibility of spurious integrity errors.
> >
> >
> > Looks good. Do we need to freeze the queue if we are register an
> > integrity profile as well?
> >
> 
> Indeed we do, I'll refresh the patch.  Thanks for that catch.

I moved the freeze to cover all the queue manipulations in
nvme_revalidate_disk()

(git am --scissors)
8<----
Subject: nvme: suspend i/o during runtime blk_integrity_unregister

From: Dan Williams <dan.j.williams@intel.com>

Synchronize pending i/o against a change in the integrity profile to
avoid the possibility of spurious integrity errors.

Cc: Matthew Wilcox <willy at linux.intel.com>
Cc: Keith Busch <keith.busch at intel.com>
[keith: also protect dynamic integrity registration]
Signed-off-by: Dan Williams <dan.j.williams at intel.com>
---
 drivers/nvme/host/pci.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 65190e51aa47..5578de67f406 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2033,6 +2033,7 @@ static int nvme_revalidate_disk(struct gendisk *disk)
 	pi_type = ns->ms == sizeof(struct t10_pi_tuple) ?
 					id->dps & NVME_NS_DPS_PI_MASK : 0;
 
+	blk_mq_freeze_queue(disk->queue);
 	if (blk_get_integrity(disk) && (ns->pi_type != pi_type ||
 				ns->ms != old_ms ||
 				bs != queue_logical_block_size(disk->queue) ||
@@ -2052,6 +2053,7 @@ static int nvme_revalidate_disk(struct gendisk *disk)
 
 	if (dev->oncs & NVME_CTRL_ONCS_DSM)
 		nvme_config_discard(ns);
+	blk_mq_unfreeze_queue(disk->queue);
 
 	kfree(id);
 	return 0;
