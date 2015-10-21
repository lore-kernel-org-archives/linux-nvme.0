From: dan.j.williams@intel.com (Dan Williams)
Date: Wed, 21 Oct 2015 13:20:07 -0400
Subject: [PATCH v3 08/12] nvme: suspend i/o during runtime
 blk_integrity_unregister
In-Reply-To: <20151021171921.6456.1646.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <20151021171921.6456.1646.stgit@dwillia2-desk3.amr.corp.intel.com>
Message-ID: <20151021172007.6456.90618.stgit@dwillia2-desk3.amr.corp.intel.com>

Synchronize pending i/o against a change in the integrity profile to
avoid the possibility of spurious integrity errors.

Cc: Matthew Wilcox <willy at linux.intel.com>
Acked-by: Keith Busch <keith.busch at intel.com>
[keith: also protect dynamic integrity registration]
Signed-off-by: Dan Williams <dan.j.williams at intel.com>
---
 drivers/nvme/host/pci.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index ad06f8dcf582..4757a2c9366e 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2035,6 +2035,7 @@ static int nvme_revalidate_disk(struct gendisk *disk)
 	pi_type = ns->ms == sizeof(struct t10_pi_tuple) ?
 					id->dps & NVME_NS_DPS_PI_MASK : 0;
 
+	blk_mq_freeze_queue(disk->queue);
 	if (blk_get_integrity(disk) && (ns->pi_type != pi_type ||
 				ns->ms != old_ms ||
 				bs != queue_logical_block_size(disk->queue) ||
@@ -2054,6 +2055,7 @@ static int nvme_revalidate_disk(struct gendisk *disk)
 
 	if (dev->oncs & NVME_CTRL_ONCS_DSM)
 		nvme_config_discard(ns);
+	blk_mq_unfreeze_queue(disk->queue);
 
 	kfree(id);
 	return 0;
