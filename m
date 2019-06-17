From: bvanassche@acm.org (Bart Van Assche)
Date: Mon, 17 Jun 2019 09:12:22 -0700
Subject: [PATCH v3 3/3] nvme: Set physical block size and optimal I/O size
 according to NVMe 1.4
In-Reply-To: <20190617161222.253849-1-bvanassche@acm.org>
References: <20190617161222.253849-1-bvanassche@acm.org>
Message-ID: <20190617161222.253849-4-bvanassche@acm.org>

>From the NVMe 1.4 spec:

NSFEAT bit 4 if set to 1: indicates that the fields NPWG, NPWA, NPDG, NPDA,
and NOWS are defined for this namespace and should be used by the host for
I/O optimization;
[ ... ]
Namespace Preferred Write Granularity (NPWG): This field indicates the
smallest recommended write granularity in logical blocks for this namespace.
This is a 0's based value. The size indicated should be less than or equal
to Maximum Data Transfer Size (MDTS) that is specified in units of minimum
memory page size. The value of this field may change if the namespace is
reformatted. The size should be a multiple of Namespace Preferred Write
Alignment (NPWA). Refer to section 8.25 for how this field is utilized to
improve performance and endurance.
[ ... ]
Each Write, Write Uncorrectable, or Write Zeroes commands should address a
multiple of Namespace Preferred Write Granularity (NPWG) (refer to Figure
245) and Stream Write Size (SWS) (refer to Figure 515) logical blocks (as
expressed in the NLB field), and the SLBA field of the command should be
aligned to Namespace Preferred Write Alignment (NPWA) (refer to Figure 245)
for best performance.

Cc: Keith Busch <kbusch at kernel.org>
Cc: Sagi Grimberg <sagi at grimberg.me>
Cc: Hannes Reinecke <hare at suse.com>
Signed-off-by: Bart Van Assche <bvanassche at acm.org>
---
 drivers/nvme/host/core.c | 30 ++++++++++++++++++++++++++++--
 drivers/nvme/host/nvme.h |  1 +
 2 files changed, 29 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 1b7c2afd84cb..5b92d875a1a6 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1608,6 +1608,7 @@ static void nvme_update_disk_info(struct gendisk *disk,
 {
 	sector_t capacity = le64_to_cpu(id->nsze) << (ns->lba_shift - 9);
 	unsigned short bs = 1 << ns->lba_shift;
+	u32 atomic_bs, phys_bs, io_opt;
 
 	if (ns->lba_shift > PAGE_SHIFT) {
 		/* unsupported block size, set capacity to 0 later */
@@ -1616,9 +1617,33 @@ static void nvme_update_disk_info(struct gendisk *disk,
 	blk_mq_freeze_queue(disk->queue);
 	blk_integrity_unregister(disk);
 
+	/*
+	 * Bit 1 indicates whether NAWUPF is defined for this namespace
+	 * and whether it should be used instead of AWUPF. If NAWUPF == 0
+	 * then AWUPF must be used instead.
+	 */
+	if (id->nsfeat & (1 << 1) && id->nawupf)
+		atomic_bs = (1 + id->nawupf) * bs;
+	else
+		atomic_bs = (1 + ns->ctrl->subsys->awupf) * bs;
+	phys_bs = bs;
+	io_opt = bs;
+	if (id->nsfeat & (1 << 4)) {
+		/* NPWG = Namespace Preferred Write Granularity */
+		phys_bs *= 1 + le16_to_cpu(id->npwg);
+		/* NOWS = Namespace Optimal Write Size */
+		io_opt *= 1 + le16_to_cpu(id->nows);
+	}
+
 	blk_queue_logical_block_size(disk->queue, bs);
-	blk_queue_physical_block_size(disk->queue, bs);
-	blk_queue_io_min(disk->queue, bs);
+	/*
+	 * Linux filesystems assume writing a single physical block is
+	 * an atomic operation. Hence limit the physical block size to the
+	 * value of the Atomic Write Unit Power Fail parameter.
+	 */
+	blk_queue_physical_block_size(disk->queue, min(phys_bs, atomic_bs));
+	blk_queue_io_min(disk->queue, phys_bs);
+	blk_queue_io_opt(disk->queue, io_opt);
 
 	if (ns->ms && !ns->ext &&
 	    (ns->ctrl->ops->flags & NVME_F_METADATA_SUPPORTED))
@@ -2415,6 +2440,7 @@ static int nvme_init_subsystem(struct nvme_ctrl *ctrl, struct nvme_id_ctrl *id)
 	memcpy(subsys->firmware_rev, id->fr, sizeof(subsys->firmware_rev));
 	subsys->vendor_id = le16_to_cpu(id->vid);
 	subsys->cmic = id->cmic;
+	subsys->awupf = le16_to_cpu(id->awupf);
 #ifdef CONFIG_NVME_MULTIPATH
 	subsys->iopolicy = NVME_IOPOLICY_NUMA;
 #endif
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 55553d293a98..d93279fd5960 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -272,6 +272,7 @@ struct nvme_subsystem {
 	char			firmware_rev[8];
 	u8			cmic;
 	u16			vendor_id;
+	u16			awupf;	/* 0's based awupf value. */
 	struct ida		ns_ida;
 #ifdef CONFIG_NVME_MULTIPATH
 	enum nvme_iopolicy	iopolicy;
-- 
2.22.0.rc3
