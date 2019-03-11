From: sagi@grimberg.me (Sagi Grimberg)
Date: Mon, 11 Mar 2019 14:16:06 -0700
Subject: [PATCH v3 1/3] nvme: fail namespace revalidate if block size exceeds
 PAGE_SIZE
In-Reply-To: <20190311211608.16628-1-sagi@grimberg.me>
References: <20190311211608.16628-1-sagi@grimberg.me>
Message-ID: <20190311211608.16628-2-sagi@grimberg.me>

If our target exposed a namespace with a block size that is greater
than PAGE_SIZE, fail it as we do not support it.

This issue encountered when the nvmet namespace was backed by a
tempfile.

Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
---
 drivers/nvme/host/core.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 7321da21f8c9..751e14468c0e 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1635,7 +1635,7 @@ static void nvme_update_disk_info(struct gendisk *disk,
 	blk_mq_unfreeze_queue(disk->queue);
 }
 
-static void __nvme_revalidate_disk(struct gendisk *disk, struct nvme_id_ns *id)
+static int __nvme_revalidate_disk(struct gendisk *disk, struct nvme_id_ns *id)
 {
 	struct nvme_ns *ns = disk->private_data;
 
@@ -1644,8 +1644,13 @@ static void __nvme_revalidate_disk(struct gendisk *disk, struct nvme_id_ns *id)
 	 * block layer can use before failing read/write for 0 capacity.
 	 */
 	ns->lba_shift = id->lbaf[id->flbas & NVME_NS_FLBAS_LBA_MASK].ds;
-	if (ns->lba_shift == 0)
+	if (ns->lba_shift > 12) {
+		dev_err(ns->ctrl->device, "ns lba_shift %d not supported\n",
+				ns->lba_shift);
+		return -ENOTSUPP;
+	} else if (ns->lba_shift == 0) {
 		ns->lba_shift = 9;
+	}
 	ns->noiob = le16_to_cpu(id->noiob);
 	ns->ms = le16_to_cpu(id->lbaf[id->flbas & NVME_NS_FLBAS_LBA_MASK].ms);
 	ns->ext = ns->ms && (id->flbas & NVME_NS_FLBAS_META_EXT);
@@ -1664,6 +1669,7 @@ static void __nvme_revalidate_disk(struct gendisk *disk, struct nvme_id_ns *id)
 		blk_queue_stack_limits(ns->head->disk->queue, ns->queue);
 	}
 #endif
+	return 0;
 }
 
 static int nvme_revalidate_disk(struct gendisk *disk)
@@ -1688,7 +1694,10 @@ static int nvme_revalidate_disk(struct gendisk *disk)
 		goto out;
 	}
 
-	__nvme_revalidate_disk(disk, id);
+	ret = __nvme_revalidate_disk(disk, id);
+	if (ret)
+		goto out;
+
 	nvme_report_ns_ids(ctrl, ns->head->ns_id, id, &ids);
 	if (!nvme_ns_ids_equal(&ns->head->ids, &ids)) {
 		dev_err(ctrl->device,
@@ -3281,7 +3290,8 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid)
 	memcpy(disk->disk_name, disk_name, DISK_NAME_LEN);
 	ns->disk = disk;
 
-	__nvme_revalidate_disk(disk, id);
+	if (__nvme_revalidate_disk(disk, id))
+		goto out_put_disk;
 
 	if ((ctrl->quirks & NVME_QUIRK_LIGHTNVM) && id->vs[0] == 0x1) {
 		if (nvme_nvm_register(ns, disk_name, node)) {
-- 
2.17.1
