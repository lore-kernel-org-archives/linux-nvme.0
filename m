Return-Path: <SRS0=hC3a=XD=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 457A7C4360D
	for <linux-nvme@archiver.kernel.org>; Sun,  8 Sep 2019 15:27:06 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 022BC214D9
	for <linux-nvme@archiver.kernel.org>; Sun,  8 Sep 2019 15:27:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="OinWg9A2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 022BC214D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=B8BjEATwOhpMzW0Nt5PYhunX2F6f8cLDQZL6weEH1Pc=; b=Oin
	Wg9A2VQVbk/rdRhrE/2FF5Gw0V/JOfQZW6KOigUwk1770RltL4w6vvCyMr5VSPc+ewmpsCKMF+paw
	Zq3Rb+BUj6YFM3Ecp73A5DT4BovU1Rsk/O1Fxe0ok9CiucWGJ+rChC55eHYxywlMEI/kuVyKeFPKe
	Gh5ODagyBrv+4hTr7yMQ2OMk7DUGQTalYwVX+8JnQNtsoPv6+SDVMoL7lBb9328QVF4sBaLyNpD/f
	LMaUZfsv7daH6++SBigl0BsRVfmbT0f91gDbJ48a3s4eLz3JP3k3S1cNymflucbyuG1NrLvFseIqy
	hT0Fnyju/Hqhf79gkh61WvGA9NettUw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92 #3 (Red Hat Linux))
	id 1i6z5j-0006CF-A2; Sun, 08 Sep 2019 15:27:03 +0000
Received: from mail-il-dmz.mellanox.com ([193.47.165.129] helo=mellanox.co.il)
 by bombadil.infradead.org with esmtp (Exim 4.92 #3 (Red Hat Linux))
 id 1i6z5c-00068N-Hs
 for linux-nvme@lists.infradead.org; Sun, 08 Sep 2019 15:26:59 +0000
Received: from Internal Mail-Server by MTLPINE1 (envelope-from
 maxg@mellanox.com)
 with ESMTPS (AES256-SHA encrypted); 8 Sep 2019 18:26:45 +0300
Received: from r-vnc12.mtr.labs.mlnx (r-vnc12.mtr.labs.mlnx [10.208.0.12])
 by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id x88FQjLi011361;
 Sun, 8 Sep 2019 18:26:45 +0300
From: Max Gurtovoy <maxg@mellanox.com>
To: linux-block@vger.kernel.org, axboe@kernel.dk, martin.petersen@oracle.com, 
 linux-nvme@lists.infradead.org, keith.busch@intel.com, hch@lst.de,
 sagi@grimberg.me
Subject: [PATCH v4 1/3] block: centralize PI remapping logic to the block layer
Date: Sun,  8 Sep 2019 18:26:43 +0300
Message-Id: <1567956405-5585-1-git-send-email-maxg@mellanox.com>
X-Mailer: git-send-email 1.7.1
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190908_082657_339028_5C105AD8 
X-CRM114-Status: GOOD (  16.66  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Max Gurtovoy <maxg@mellanox.com>, shlomin@mellanox.com,
 israelr@mellanox.com
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Currently t10_pi_prepare/t10_pi_complete functions are called during the
NVMe and SCSi layers command preparetion/completion, but their actual
place should be the block layer since T10-PI is a general data integrity
feature that is used by block storage protocols.

Suggested-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Max Gurtovoy <maxg@mellanox.com>
---

changes from v3:
 - fix > 80 liner
 - move the protection_type assignment into nvme_update_disk_info
 - added a comment regarding dps and DIF type values
 - drop redundant externs from t10-pi.h

changes from v2:
 - remove local variable for protection_type
 - remove remapping between NVMe T10 definition to blk definition
 - added patches 2/3 and 3/3
 - remove pi_type from ns structure

changes from v1:
 - seperate from nvme_cleanup command patches
 - introduce blk_integrity_interval_shift to avoid div in fast path
---
 block/blk-core.c         |  5 +++++
 block/blk-mq.c           |  4 ++++
 block/blk-settings.c     |  1 +
 block/t10-pi.c           | 16 ++++++----------
 drivers/nvme/host/core.c | 38 ++++++++++++++++++--------------------
 drivers/nvme/host/nvme.h |  1 -
 drivers/scsi/sd.c        | 28 ++++++++++------------------
 drivers/scsi/sd.h        |  1 -
 drivers/scsi/sd_dif.c    |  2 +-
 include/linux/blkdev.h   | 12 ++++++++++++
 include/linux/genhd.h    |  1 +
 include/linux/t10-pi.h   | 10 ++++------
 12 files changed, 62 insertions(+), 57 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index d0cc6e1..eda33f9 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -34,6 +34,7 @@
 #include <linux/ratelimit.h>
 #include <linux/pm_runtime.h>
 #include <linux/blk-cgroup.h>
+#include <linux/t10-pi.h>
 #include <linux/debugfs.h>
 #include <linux/bpf.h>
 
@@ -1405,6 +1406,10 @@ bool blk_update_request(struct request *req, blk_status_t error,
 	if (!req->bio)
 		return false;
 
+	if (blk_integrity_rq(req) && req_op(req) == REQ_OP_READ &&
+	    error == BLK_STS_OK)
+		t10_pi_complete(req, nr_bytes);
+
 	if (unlikely(error && !blk_rq_is_passthrough(req) &&
 		     !(req->rq_flags & RQF_QUIET)))
 		print_req_error(req, error, __func__);
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 0835f4d..30ec078 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -30,6 +30,7 @@
 #include <trace/events/block.h>
 
 #include <linux/blk-mq.h>
+#include <linux/t10-pi.h>
 #include "blk.h"
 #include "blk-mq.h"
 #include "blk-mq-debugfs.h"
@@ -693,6 +694,9 @@ void blk_mq_start_request(struct request *rq)
 		 */
 		rq->nr_phys_segments++;
 	}
+
+	if (blk_integrity_rq(rq) && req_op(rq) == REQ_OP_WRITE)
+		t10_pi_prepare(rq);
 }
 EXPORT_SYMBOL(blk_mq_start_request);
 
diff --git a/block/blk-settings.c b/block/blk-settings.c
index 2c18312..8183ffc 100644
--- a/block/blk-settings.c
+++ b/block/blk-settings.c
@@ -330,6 +330,7 @@ void blk_queue_max_segment_size(struct request_queue *q, unsigned int max_size)
 void blk_queue_logical_block_size(struct request_queue *q, unsigned short size)
 {
 	q->limits.logical_block_size = size;
+	q->limits.logical_block_shift = ilog2(size);
 
 	if (q->limits.physical_block_size < size)
 		q->limits.physical_block_size = size;
diff --git a/block/t10-pi.c b/block/t10-pi.c
index 0c00946..a33eac4 100644
--- a/block/t10-pi.c
+++ b/block/t10-pi.c
@@ -171,7 +171,6 @@ static blk_status_t t10_pi_type3_verify_ip(struct blk_integrity_iter *iter)
 /**
  * t10_pi_prepare - prepare PI prior submitting request to device
  * @rq:              request with PI that should be prepared
- * @protection_type: PI type (Type 1/Type 2/Type 3)
  *
  * For Type 1/Type 2, the virtual start sector is the one that was
  * originally submitted by the block layer for the ref_tag usage. Due to
@@ -181,13 +180,13 @@ static blk_status_t t10_pi_type3_verify_ip(struct blk_integrity_iter *iter)
  *
  * Type 3 does not have a reference tag so no remapping is required.
  */
-void t10_pi_prepare(struct request *rq, u8 protection_type)
+void t10_pi_prepare(struct request *rq)
 {
 	const int tuple_sz = rq->q->integrity.tuple_size;
 	u32 ref_tag = t10_pi_ref_tag(rq);
 	struct bio *bio;
 
-	if (protection_type == T10_PI_TYPE3_PROTECTION)
+	if (rq->rq_disk->protection_type == T10_PI_TYPE3_PROTECTION)
 		return;
 
 	__rq_for_each_bio(bio, rq) {
@@ -222,13 +221,11 @@ void t10_pi_prepare(struct request *rq, u8 protection_type)
 		bip->bip_flags |= BIP_MAPPED_INTEGRITY;
 	}
 }
-EXPORT_SYMBOL(t10_pi_prepare);
 
 /**
  * t10_pi_complete - prepare PI prior returning request to the block layer
  * @rq:              request with PI that should be prepared
- * @protection_type: PI type (Type 1/Type 2/Type 3)
- * @intervals:       total elements to prepare
+ * @nr_bytes:        total bytes to prepare
  *
  * For Type 1/Type 2, the virtual start sector is the one that was
  * originally submitted by the block layer for the ref_tag usage. Due to
@@ -239,14 +236,14 @@ void t10_pi_prepare(struct request *rq, u8 protection_type)
  *
  * Type 3 does not have a reference tag so no remapping is required.
  */
-void t10_pi_complete(struct request *rq, u8 protection_type,
-		     unsigned int intervals)
+void t10_pi_complete(struct request *rq, unsigned int nr_bytes)
 {
+	unsigned intervals = nr_bytes >> blk_integrity_interval_shift(rq->q);
 	const int tuple_sz = rq->q->integrity.tuple_size;
 	u32 ref_tag = t10_pi_ref_tag(rq);
 	struct bio *bio;
 
-	if (protection_type == T10_PI_TYPE3_PROTECTION)
+	if (rq->rq_disk->protection_type == T10_PI_TYPE3_PROTECTION)
 		return;
 
 	__rq_for_each_bio(bio, rq) {
@@ -276,4 +273,3 @@ void t10_pi_complete(struct request *rq, u8 protection_type,
 		}
 	}
 }
-EXPORT_SYMBOL(t10_pi_complete);
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index d3d6b7b..bdc0a64 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -194,7 +194,8 @@ static int nvme_delete_ctrl_sync(struct nvme_ctrl *ctrl)
 
 static inline bool nvme_ns_has_pi(struct nvme_ns *ns)
 {
-	return ns->pi_type && ns->ms == sizeof(struct t10_pi_tuple);
+	return ns->disk->protection_type &&
+		ns->ms == sizeof(struct t10_pi_tuple);
 }
 
 static blk_status_t nvme_error_status(struct request *req)
@@ -659,11 +660,9 @@ static inline blk_status_t nvme_setup_rw(struct nvme_ns *ns,
 			if (WARN_ON_ONCE(!nvme_ns_has_pi(ns)))
 				return BLK_STS_NOTSUPP;
 			control |= NVME_RW_PRINFO_PRACT;
-		} else if (req_op(req) == REQ_OP_WRITE) {
-			t10_pi_prepare(req, ns->pi_type);
 		}
 
-		switch (ns->pi_type) {
+		switch (req->rq_disk->protection_type) {
 		case NVME_NS_DPS_PI_TYPE3:
 			control |= NVME_RW_PRINFO_PRCHK_GUARD;
 			break;
@@ -683,13 +682,6 @@ static inline blk_status_t nvme_setup_rw(struct nvme_ns *ns,
 
 void nvme_cleanup_cmd(struct request *req)
 {
-	if (blk_integrity_rq(req) && req_op(req) == REQ_OP_READ &&
-	    nvme_req(req)->status == 0) {
-		struct nvme_ns *ns = req->rq_disk->private_data;
-
-		t10_pi_complete(req, ns->pi_type,
-				blk_rq_bytes(req) >> ns->lba_shift);
-	}
 	if (req->rq_flags & RQF_SPECIAL_PAYLOAD) {
 		struct nvme_ns *ns = req->rq_disk->private_data;
 		struct page *page = req->special_vec.bv_page;
@@ -1500,12 +1492,12 @@ static int nvme_getgeo(struct block_device *bdev, struct hd_geometry *geo)
 }
 
 #ifdef CONFIG_BLK_DEV_INTEGRITY
-static void nvme_init_integrity(struct gendisk *disk, u16 ms, u8 pi_type)
+static void nvme_init_integrity(struct gendisk *disk, u16 ms)
 {
 	struct blk_integrity integrity;
 
 	memset(&integrity, 0, sizeof(integrity));
-	switch (pi_type) {
+	switch (disk->protection_type) {
 	case NVME_NS_DPS_PI_TYPE3:
 		integrity.profile = &t10_pi_type3_crc;
 		integrity.tag_size = sizeof(u16) + sizeof(u32);
@@ -1526,7 +1518,7 @@ static void nvme_init_integrity(struct gendisk *disk, u16 ms, u8 pi_type)
 	blk_queue_max_integrity_segments(disk->queue, 1);
 }
 #else
-static void nvme_init_integrity(struct gendisk *disk, u16 ms, u8 pi_type)
+static void nvme_init_integrity(struct gendisk *disk, u16 ms)
 {
 }
 #endif /* CONFIG_BLK_DEV_INTEGRITY */
@@ -1673,9 +1665,20 @@ static void nvme_update_disk_info(struct gendisk *disk,
 	blk_queue_io_min(disk->queue, phys_bs);
 	blk_queue_io_opt(disk->queue, io_opt);
 
+	/*
+	 * Linux PI implementation requires metadata equal to t10_pi tuple size.
+	 * The NVMe dps value matches the general disk protection type because
+	 * according to the NVMe spec it supports the same protection types as
+	 * DIF (Type 1/2/3 of end-to-end data protection information).
+	 */
+	if (ns->ms == sizeof(struct t10_pi_tuple))
+		disk->protection_type = id->dps & NVME_NS_DPS_PI_MASK;
+	else
+		disk->protection_type = 0;
+
 	if (ns->ms && !ns->ext &&
 	    (ns->ctrl->ops->flags & NVME_F_METADATA_SUPPORTED))
-		nvme_init_integrity(disk, ns->ms, ns->pi_type);
+		nvme_init_integrity(disk, ns->ms);
 	if ((ns->ms && !nvme_ns_has_pi(ns) && !blk_get_integrity(disk)) ||
 	    ns->lba_shift > PAGE_SHIFT)
 		capacity = 0;
@@ -1707,11 +1710,6 @@ static void __nvme_revalidate_disk(struct gendisk *disk, struct nvme_id_ns *id)
 	ns->noiob = le16_to_cpu(id->noiob);
 	ns->ms = le16_to_cpu(id->lbaf[id->flbas & NVME_NS_FLBAS_LBA_MASK].ms);
 	ns->ext = ns->ms && (id->flbas & NVME_NS_FLBAS_META_EXT);
-	/* the PI implementation requires metadata equal t10 pi tuple size */
-	if (ns->ms == sizeof(struct t10_pi_tuple))
-		ns->pi_type = id->dps & NVME_NS_DPS_PI_MASK;
-	else
-		ns->pi_type = 0;
 
 	if (ns->noiob)
 		nvme_set_chunk_size(ns);
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 2d678fb..15a85a5 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -350,7 +350,6 @@ struct nvme_ns {
 	u16 sgs;
 	u32 sws;
 	bool ext;
-	u8 pi_type;
 	unsigned long flags;
 #define NVME_NS_REMOVING	0
 #define NVME_NS_DEAD     	1
diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
index 149d406..fa7e7d4 100644
--- a/drivers/scsi/sd.c
+++ b/drivers/scsi/sd.c
@@ -55,7 +55,6 @@
 #include <linux/sed-opal.h>
 #include <linux/pm_runtime.h>
 #include <linux/pr.h>
-#include <linux/t10-pi.h>
 #include <linux/uaccess.h>
 #include <asm/unaligned.h>
 
@@ -309,7 +308,7 @@ static void sd_set_flush_flag(struct scsi_disk *sdkp)
 {
 	struct scsi_disk *sdkp = to_scsi_disk(dev);
 
-	return sprintf(buf, "%u\n", sdkp->protection_type);
+	return sprintf(buf, "%u\n", sdkp->disk->protection_type);
 }
 
 static ssize_t
@@ -329,7 +328,7 @@ static void sd_set_flush_flag(struct scsi_disk *sdkp)
 		return err;
 
 	if (val <= T10_PI_TYPE3_PROTECTION)
-		sdkp->protection_type = val;
+		sdkp->disk->protection_type = val;
 
 	return count;
 }
@@ -343,8 +342,8 @@ static void sd_set_flush_flag(struct scsi_disk *sdkp)
 	struct scsi_device *sdp = sdkp->device;
 	unsigned int dif, dix;
 
-	dif = scsi_host_dif_capable(sdp->host, sdkp->protection_type);
-	dix = scsi_host_dix_capable(sdp->host, sdkp->protection_type);
+	dif = scsi_host_dif_capable(sdp->host, sdkp->disk->protection_type);
+	dix = scsi_host_dix_capable(sdp->host, sdkp->disk->protection_type);
 
 	if (!dix && scsi_host_dix_capable(sdp->host, T10_PI_TYPE0_PROTECTION)) {
 		dif = 0;
@@ -1209,17 +1208,15 @@ static blk_status_t sd_setup_read_write_cmnd(struct scsi_cmnd *cmd)
 
 	fua = rq->cmd_flags & REQ_FUA ? 0x8 : 0;
 	dix = scsi_prot_sg_count(cmd);
-	dif = scsi_host_dif_capable(cmd->device->host, sdkp->protection_type);
-
-	if (write && dix)
-		t10_pi_prepare(cmd->request, sdkp->protection_type);
+	dif = scsi_host_dif_capable(cmd->device->host,
+				    sdkp->disk->protection_type);
 
 	if (dif || dix)
 		protect = sd_setup_protect_cmnd(cmd, dix, dif);
 	else
 		protect = 0;
 
-	if (protect && sdkp->protection_type == T10_PI_TYPE2_PROTECTION) {
+	if (protect && sdkp->disk->protection_type == T10_PI_TYPE2_PROTECTION) {
 		ret = sd_setup_rw32_cmnd(cmd, write, lba, nr_blocks,
 					 protect | fua);
 	} else if (sdp->use_16_for_rw || (nr_blocks > 0xffff)) {
@@ -2051,11 +2048,6 @@ static int sd_done(struct scsi_cmnd *SCpnt)
 					   "sd_done: completed %d of %d bytes\n",
 					   good_bytes, scsi_bufflen(SCpnt)));
 
-	if (rq_data_dir(SCpnt->request) == READ && scsi_prot_sg_count(SCpnt) &&
-	    good_bytes)
-		t10_pi_complete(SCpnt->request, sdkp->protection_type,
-				good_bytes / scsi_prot_interval(SCpnt));
-
 	return good_bytes;
 }
 
@@ -2204,7 +2196,7 @@ static int sd_read_protection_type(struct scsi_disk *sdkp, unsigned char *buffer
 	else if (scsi_host_dif_capable(sdp->host, type))
 		ret = 1;
 
-	if (sdkp->first_scan || type != sdkp->protection_type)
+	if (sdkp->first_scan || type != sdkp->disk->protection_type)
 		switch (ret) {
 		case -ENODEV:
 			sd_printk(KERN_ERR, sdkp, "formatted with unsupported" \
@@ -2221,7 +2213,7 @@ static int sd_read_protection_type(struct scsi_disk *sdkp, unsigned char *buffer
 			break;
 		}
 
-	sdkp->protection_type = type;
+	sdkp->disk->protection_type = type;
 
 	return ret;
 }
@@ -2813,7 +2805,7 @@ static void sd_read_app_tag_own(struct scsi_disk *sdkp, unsigned char *buffer)
 	if (sdp->type != TYPE_DISK && sdp->type != TYPE_ZBC)
 		return;
 
-	if (sdkp->protection_type == 0)
+	if (sdkp->disk->protection_type == 0)
 		return;
 
 	res = scsi_mode_sense(sdp, 1, 0x0a, buffer, 36, SD_TIMEOUT,
diff --git a/drivers/scsi/sd.h b/drivers/scsi/sd.h
index 38c5094..770b6b0f 100644
--- a/drivers/scsi/sd.h
+++ b/drivers/scsi/sd.h
@@ -94,7 +94,6 @@ struct scsi_disk {
 	unsigned int	medium_access_timed_out;
 	u8		media_present;
 	u8		write_prot;
-	u8		protection_type;/* Data Integrity Field */
 	u8		provisioning_mode;
 	u8		zeroing_mode;
 	unsigned	ATO : 1;	/* state of disk ATO bit */
diff --git a/drivers/scsi/sd_dif.c b/drivers/scsi/sd_dif.c
index 4cadb26..cbd0cce 100644
--- a/drivers/scsi/sd_dif.c
+++ b/drivers/scsi/sd_dif.c
@@ -28,7 +28,7 @@ void sd_dif_config_host(struct scsi_disk *sdkp)
 {
 	struct scsi_device *sdp = sdkp->device;
 	struct gendisk *disk = sdkp->disk;
-	u8 type = sdkp->protection_type;
+	u8 type = sdkp->disk->protection_type;
 	struct blk_integrity bi;
 	int dif, dix;
 
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 1ef375d..5901a53 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -332,6 +332,7 @@ struct queue_limits {
 	unsigned int		discard_alignment;
 
 	unsigned short		logical_block_size;
+	unsigned short		logical_block_shift;
 	unsigned short		max_segments;
 	unsigned short		max_integrity_segments;
 	unsigned short		max_discard_segments;
@@ -1543,6 +1544,12 @@ static inline void blk_queue_max_integrity_segments(struct request_queue *q,
 }
 
 static inline unsigned short
+blk_integrity_interval_shift(struct request_queue *q)
+{
+	return q->limits.logical_block_shift;
+}
+
+static inline unsigned short
 queue_max_integrity_segments(struct request_queue *q)
 {
 	return q->limits.max_integrity_segments;
@@ -1626,6 +1633,11 @@ static inline void blk_queue_max_integrity_segments(struct request_queue *q,
 						    unsigned int segs)
 {
 }
+static inline unsigned short
+blk_integrity_interval_shift(struct request_queue *q)
+{
+	return 0;
+}
 static inline unsigned short queue_max_integrity_segments(struct request_queue *q)
 {
 	return 0;
diff --git a/include/linux/genhd.h b/include/linux/genhd.h
index 8b5330d..5f58736 100644
--- a/include/linux/genhd.h
+++ b/include/linux/genhd.h
@@ -219,6 +219,7 @@ struct gendisk {
 	int node_id;
 	struct badblocks *bb;
 	struct lockdep_map lockdep_map;
+	u8 protection_type;/* Data Integrity Field */
 };
 
 static inline struct gendisk *part_to_disk(struct hd_struct *part)
diff --git a/include/linux/t10-pi.h b/include/linux/t10-pi.h
index 3e2a80c..c161824 100644
--- a/include/linux/t10-pi.h
+++ b/include/linux/t10-pi.h
@@ -54,15 +54,13 @@ static inline u32 t10_pi_ref_tag(struct request *rq)
 extern const struct blk_integrity_profile t10_pi_type3_ip;
 
 #ifdef CONFIG_BLK_DEV_INTEGRITY
-extern void t10_pi_prepare(struct request *rq, u8 protection_type);
-extern void t10_pi_complete(struct request *rq, u8 protection_type,
-			    unsigned int intervals);
+void t10_pi_prepare(struct request *rq);
+void t10_pi_complete(struct request *rq, unsigned int nr_bytes);
 #else
-static inline void t10_pi_complete(struct request *rq, u8 protection_type,
-				   unsigned int intervals)
+static inline void t10_pi_complete(struct request *rq, unsigned int nr_bytes)
 {
 }
-static inline void t10_pi_prepare(struct request *rq, u8 protection_type)
+static inline void t10_pi_prepare(struct request *rq)
 {
 }
 #endif
-- 
1.8.3.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
