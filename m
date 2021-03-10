Return-Path: <SRS0=Sfb4=II=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75F0AC433DB
	for <linux-nvme@archiver.kernel.org>; Wed, 10 Mar 2021 19:58:25 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EDFF164FC9
	for <linux-nvme@archiver.kernel.org>; Wed, 10 Mar 2021 19:58:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDFF164FC9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=P7hxMT9o7T8GQ9lguEwJuFru20q1I5SSk5p2A0+3B94=; b=Nf8TeGHD7ywhb/MwDgq9H674Ww
	Bst2DChcOkyPBRc08iziVtqUa9YpPjxpw6vPLSWXVOCbPieQ2tnA5Tgq7sb0fiLAPky9RCu1qUqoO
	T6/44VJ1I0vy+Z4okBk+54LTLYx8IQBHx7GNJW/IF9lZt85g6FIHb7CTklFGC2HYgWfngY983Z9cG
	92PmdLjqF6L+KOvdB/8e7igP2fwfYVxHBlgdbtDvcbeVIXHsJ/mBcbFYBmhYH6R2tiHnGawdvxppv
	LKTM2lgFJWthkfOq2BvdFMk2mYzVdLXs7fUJTrEABtgO4wmpl9Ew3bOF8jLr8p4t4IUb5kGjXeiY1
	8qqdaahg==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lK4y9-007dl5-DY; Wed, 10 Mar 2021 19:58:09 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lK4y5-007dk1-Qd
 for linux-nvme@lists.infradead.org; Wed, 10 Mar 2021 19:58:07 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id E544764FC9;
 Wed, 10 Mar 2021 19:58:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1615406282;
 bh=nqspLMdbLjCkwvgN61DLQ6kRXr3y/gkI2SvpZRTtkRk=;
 h=From:To:Cc:Subject:Date:From;
 b=KefIlpQXQbhrFAv0kTVBVu90IJdBM3twfYAPy92SyLaYxc1AZC40TQSsyjrY5H7NS
 nc/LPWIN+wxngeqsajg9BlDr2PW3Enxu+ibXtI9mr9Ve1HR1QebmdeYue7K4JgwFU9
 dpNSGAMCtMxezdIeU6aJcH76SD4WtyKBZGfgMmotE63XiAlwh9czzsV1U2UmQ+33af
 oCQHq/ltSQkCfUGVl0VWO8jJQDNoigKoQsEEgO9Lnz1jVjKCdojrcNUIPw8f5BfKup
 EybIVCQoNDaElu2Q9kAqVg3FTssnvtfMnvw3gPOGkkadokIbeiajHL2irKaqR2W6D/
 02KLsicwrOe8w==
From: Keith Busch <kbusch@kernel.org>
To: linux-nvme@lists.infradead.org,
	sagi@grimberg.me,
	hch@lst.de
Cc: Keith Busch <kbusch@kernel.org>
Subject: [PATCH] nvme: implement non-mdts command limits
Date: Wed, 10 Mar 2021 11:57:26 -0800
Message-Id: <20210310195726.3377288-1-kbusch@kernel.org>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210310_195806_200569_47248095 
X-CRM114-Status: GOOD (  21.61  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Commands that access LBA contents without a data transfer between the
host historically have not had a spec defined upper limit. The driver
set the queue constraints for such commands to the max data transfer
size just to be safe, but this artificial constraint frequently limits
devices below their capabilities.

The NVMe Workgroup ratified TP4040 defines how a controller may
advertise their non-MDTS limits. Use these if provided, and default
to the current constraints if not.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/nvme/host/core.c | 89 +++++++++++++++++++++++++++++++---------
 drivers/nvme/host/nvme.h |  3 ++
 include/linux/nvme.h     | 10 +++++
 3 files changed, 82 insertions(+), 20 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index f7bc808da3d0..af299487f7a8 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1939,7 +1939,7 @@ static void nvme_config_discard(struct gendisk *disk, struct nvme_ns *ns)
 	struct request_queue *queue = disk->queue;
 	u32 size = queue_logical_block_size(queue);
 
-	if (!(ctrl->oncs & NVME_CTRL_ONCS_DSM)) {
+	if (!(ctrl->max_discard_sectors)) {
 		blk_queue_flag_clear(QUEUE_FLAG_DISCARD, queue);
 		return;
 	}
@@ -1957,8 +1957,8 @@ static void nvme_config_discard(struct gendisk *disk, struct nvme_ns *ns)
 	if (blk_queue_flag_test_and_set(QUEUE_FLAG_DISCARD, queue))
 		return;
 
-	blk_queue_max_discard_sectors(queue, UINT_MAX);
-	blk_queue_max_discard_segments(queue, NVME_DSM_MAX_RANGES);
+	blk_queue_max_discard_sectors(queue, ctrl->max_discard_sectors);
+	blk_queue_max_discard_segments(queue, ctrl->max_discard_segments);
 
 	if (ctrl->quirks & NVME_QUIRK_DEALLOCATE_ZEROES)
 		blk_queue_max_write_zeroes_sectors(queue, UINT_MAX);
@@ -1966,25 +1966,10 @@ static void nvme_config_discard(struct gendisk *disk, struct nvme_ns *ns)
 
 static void nvme_config_write_zeroes(struct gendisk *disk, struct nvme_ns *ns)
 {
-	u64 max_blocks;
+	u64 max_blocks = ns->ctrl->max_zeroes_sectors;
 
-	if (!(ns->ctrl->oncs & NVME_CTRL_ONCS_WRITE_ZEROES) ||
-	    (ns->ctrl->quirks & NVME_QUIRK_DISABLE_WRITE_ZEROES))
+	if (max_blocks == 0)
 		return;
-	/*
-	 * Even though NVMe spec explicitly states that MDTS is not
-	 * applicable to the write-zeroes:- "The restriction does not apply to
-	 * commands that do not transfer data between the host and the
-	 * controller (e.g., Write Uncorrectable ro Write Zeroes command).".
-	 * In order to be more cautious use controller's max_hw_sectors value
-	 * to configure the maximum sectors for the write-zeroes which is
-	 * configured based on the controller's MDTS field in the
-	 * nvme_init_ctrl_finish() if available.
-	 */
-	if (ns->ctrl->max_hw_sectors == UINT_MAX)
-		max_blocks = (u64)USHRT_MAX + 1;
-	else
-		max_blocks = ns->ctrl->max_hw_sectors + 1;
 
 	blk_queue_max_write_zeroes_sectors(disk->queue,
 					   nvme_lba_to_sect(ns, max_blocks));
@@ -3063,6 +3048,65 @@ static int nvme_get_effects_log(struct nvme_ctrl *ctrl, u8 csi,
 	return 0;
 }
 
+static inline u32 nvme_mps_size_to_bytes(u8 size)
+{
+	/* XXX: modify if NVME_CTRL_PAGE_SHIFT ever changes */
+	return 1 << (size + 3);
+}
+
+static int nvme_init_non_mdts_limits(struct nvme_ctrl *ctrl)
+{
+	struct nvme_command c = { };
+	struct nvme_id_ctrl_nvm *id;
+	int ret;
+
+	if (!(ctrl->oncs & NVME_CTRL_ONCS_DSM)) {
+		ctrl->max_discard_sectors = 0;
+		ctrl->max_discard_segments = 0;
+	} else {
+		ctrl->max_discard_sectors = UINT_MAX;
+		ctrl->max_discard_segments = NVME_DSM_MAX_RANGES;
+	}
+
+	/*
+	 * Even though NVMe spec explicitly states that MDTS is not applicable
+	 * to the write-zeroes, we are cautious and limit the default size to
+	 * the controller's max_hw_sectors value, which is based on the MDTS
+	 * field and possibly other limiting factors.
+	 */
+	if (!(ctrl->quirks & NVME_QUIRK_DISABLE_WRITE_ZEROES) &&
+	    (ctrl->oncs & NVME_CTRL_ONCS_WRITE_ZEROES))
+		ctrl->max_zeroes_sectors = ctrl->max_hw_sectors;
+	else
+		ctrl->max_zeroes_sectors = 0;
+
+	if (ctrl->vs < NVME_VS(1, 2, 0))
+		return 0;
+
+	id = kzalloc(sizeof(*id), GFP_KERNEL);
+	if (!id)
+		return 0;
+
+	c.identify.opcode = nvme_admin_identify;
+	c.identify.cns = NVME_ID_CNS_CS_CTRL;
+	c.identify.csi = NVME_CSI_NVM;
+
+	ret = nvme_submit_sync_cmd(ctrl->admin_q, &c, id, sizeof(*id));
+	if (ret)
+		goto free_data;
+
+	if (id->dmrl)
+		ctrl->max_discard_segments = id->dmrl;
+	if (id->dmrsl)
+		ctrl->max_discard_sectors = le32_to_cpu(id->dmrsl);
+	if (id->wzsl)
+		ctrl->max_zeroes_sectors = nvme_mps_size_to_bytes(id->wzsl);
+
+free_data:
+	kfree(id);
+	return ret;
+}
+
 static int nvme_init_identify(struct nvme_ctrl *ctrl)
 {
 	struct nvme_id_ctrl *id;
@@ -3238,6 +3282,10 @@ int nvme_init_ctrl_finish(struct nvme_ctrl *ctrl)
 	if (ret)
 		return ret;
 
+	ret = nvme_init_non_mdts_limits(ctrl);
+	if (ret < 0)
+		return ret;
+
 	ret = nvme_configure_apst(ctrl);
 	if (ret < 0)
 		return ret;
@@ -4768,6 +4816,7 @@ static inline void _nvme_check_size(void)
 	BUILD_BUG_ON(sizeof(struct nvme_id_ns) != NVME_IDENTIFY_DATA_SIZE);
 	BUILD_BUG_ON(sizeof(struct nvme_id_ns_zns) != NVME_IDENTIFY_DATA_SIZE);
 	BUILD_BUG_ON(sizeof(struct nvme_id_ctrl_zns) != NVME_IDENTIFY_DATA_SIZE);
+	BUILD_BUG_ON(sizeof(struct nvme_id_ctrl_nvm) != NVME_IDENTIFY_DATA_SIZE);
 	BUILD_BUG_ON(sizeof(struct nvme_lba_range_type) != 64);
 	BUILD_BUG_ON(sizeof(struct nvme_smart_log) != 512);
 	BUILD_BUG_ON(sizeof(struct nvme_dbbuf) != 64);
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 76de7ed55d90..cf63ab07be4c 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -276,6 +276,9 @@ struct nvme_ctrl {
 	u32 max_hw_sectors;
 	u32 max_segments;
 	u32 max_integrity_segments;
+	u32 max_discard_sectors;
+	u32 max_discard_segments;
+	u32 max_zeroes_sectors;
 #ifdef CONFIG_BLK_DEV_ZONED
 	u32 max_zone_append;
 #endif
diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index b08787cd0881..edcbd60b88b9 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -405,6 +405,16 @@ struct nvme_id_ctrl_zns {
 	__u8	rsvd1[4095];
 };
 
+struct nvme_id_ctrl_nvm {
+	__u8	vsl;
+	__u8	wzsl;
+	__u8	wusl;
+	__u8	dmrl;
+	__le32	dmrsl;
+	__le64	dmsl;
+	__u8	rsvd16[4080];
+};
+
 enum {
 	NVME_ID_CNS_NS			= 0x00,
 	NVME_ID_CNS_CTRL		= 0x01,
-- 
2.25.4


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
