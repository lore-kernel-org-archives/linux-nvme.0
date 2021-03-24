Return-Path: <SRS0=XXBd=IW=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D63CC433C1
	for <linux-nvme@archiver.kernel.org>; Wed, 24 Mar 2021 23:18:40 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F3A7761A14
	for <linux-nvme@archiver.kernel.org>; Wed, 24 Mar 2021 23:18:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3A7761A14
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=2ZP14LbOceye+cfIrF/d4muO3XXHSmLtuBn9LgrXYAg=; b=h/mA6TYdCxLE569hj+7q+/92TR
	Tl/KeP3xvfUjk8YnfoVpMO3Fakn5oCQlKD6oRUysQj5PcbCmj/66jRcShF4FJyXwXnk3Nbv0jusBR
	Pvc9kXrfVebDVaBfLUvJeZsSR5Vucrm1g3U0Qtv0YBEs7oBu+AQ/X/ICNidNOKTIp4zljkBuk5Np1
	rwcnHQCbwWO/rNnFr0kIMJ2z4lpVLafa6c/A9Se9b0Io9oZw5wZwaQ1XhGu9ZEbr7INYr+r1OWPAJ
	dcZLACfUDiyMoRexa17hUVMMmhWVhF7WJ/oRTsQhCnpcMBfLqSKNHMlPp06QXjJk2FOD0cpNcdui1
	Ye5Us/fA==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lPClZ-000LHv-IG; Wed, 24 Mar 2021 23:18:21 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lPClP-000LGE-Jo
 for linux-nvme@lists.infradead.org; Wed, 24 Mar 2021 23:18:17 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 93D8061A14;
 Wed, 24 Mar 2021 23:18:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1616627886;
 bh=1V2bckFepfLEILbbgvmhNG7pAMaewRrH9lCefmqlM/M=;
 h=From:To:Cc:Subject:Date:From;
 b=prjN5m5nHbAfgp3Ga+MEab7aAWCZ3JNF80OnHUvh6hZaQDQRmT3NUguk6QeMEuSWt
 F9mOc29xPTd/HFAE2Iy8vG/UUzqa5LeHN26DVvJUjjlmqLYyRM6JrUf9tGAG7c3aVl
 bnnX8Wx5s+sYtnHw2kxsNxLKaMCumTmZ6y5rB7ASlq552/dgT+eGp7CzM3YF2FuX2n
 1ReYRhCTvYcVls1f09lckXh/0F/0//FkceAHCVG3x2buA3kNGHwOkzefS5gFjnX3Tu
 m2X35JZv6pk98nC2kLhy1z5lQNr/SBQsbhRrkByngW5ytV2I42w8DpCzlD+f6u5WOJ
 yNtRBQljQY//A==
From: Keith Busch <kbusch@kernel.org>
To: linux-nvme@lists.infradead.org,
	hch@lst.de,
	sagi@grimberg.me
Cc: Keith Busch <kbusch@kernel.org>
Subject: [PATCHv3] nvme: implement non-mdts command limits
Date: Wed, 24 Mar 2021 16:18:05 -0700
Message-Id: <20210324231805.1232062-1-kbusch@kernel.org>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210324_231815_398622_089413D5 
X-CRM114-Status: GOOD (  23.86  )
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
advertise their non-MDTS limits. Use these if provided and default to
the current constraints if not. Since the Dataset Management command
limits are defined in logical blocks, but without a namespace to tell us
the logical block size, the code defaults to the safe 512b size.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
v2->v3:

  Remove the nvm_config_write_zeroes helper (hch)

  For clarity, don't use inverted oncs logic (hch)

  Replace nvme revision check with nvme_ctrl_limited_cns (hch)

  Rebased patch for nvme-5.13: the previous version was based on a local
  conflict-resolved 5.12+5.13 branch, so that version wouldn't have
  successfully applied to either upstream branch.

 drivers/nvme/host/core.c | 107 ++++++++++++++++++++++++++-------------
 drivers/nvme/host/nvme.h |   3 ++
 include/linux/nvme.h     |  10 ++++
 3 files changed, 86 insertions(+), 34 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 40215a0246e4e..15ee470c1b8c6 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1936,7 +1936,7 @@ static void nvme_config_discard(struct gendisk *disk, struct nvme_ns *ns)
 	struct request_queue *queue = disk->queue;
 	u32 size = queue_logical_block_size(queue);
 
-	if (!(ctrl->oncs & NVME_CTRL_ONCS_DSM)) {
+	if (ctrl->max_discard_sectors == 0) {
 		blk_queue_flag_clear(QUEUE_FLAG_DISCARD, queue);
 		return;
 	}
@@ -1954,39 +1954,13 @@ static void nvme_config_discard(struct gendisk *disk, struct nvme_ns *ns)
 	if (blk_queue_flag_test_and_set(QUEUE_FLAG_DISCARD, queue))
 		return;
 
-	blk_queue_max_discard_sectors(queue, UINT_MAX);
-	blk_queue_max_discard_segments(queue, NVME_DSM_MAX_RANGES);
+	blk_queue_max_discard_sectors(queue, ctrl->max_discard_sectors);
+	blk_queue_max_discard_segments(queue, ctrl->max_discard_segments);
 
 	if (ctrl->quirks & NVME_QUIRK_DEALLOCATE_ZEROES)
 		blk_queue_max_write_zeroes_sectors(queue, UINT_MAX);
 }
 
-static void nvme_config_write_zeroes(struct gendisk *disk, struct nvme_ns *ns)
-{
-	u64 max_blocks;
-
-	if (!(ns->ctrl->oncs & NVME_CTRL_ONCS_WRITE_ZEROES) ||
-	    (ns->ctrl->quirks & NVME_QUIRK_DISABLE_WRITE_ZEROES))
-		return;
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
-
-	blk_queue_max_write_zeroes_sectors(disk->queue,
-					   nvme_lba_to_sect(ns, max_blocks));
-}
-
 static bool nvme_ns_ids_valid(struct nvme_ns_ids *ids)
 {
 	return !uuid_is_null(&ids->uuid) ||
@@ -2156,7 +2130,8 @@ static void nvme_update_disk_info(struct gendisk *disk,
 	set_capacity_and_notify(disk, capacity);
 
 	nvme_config_discard(disk, ns);
-	nvme_config_write_zeroes(disk, ns);
+	blk_queue_max_write_zeroes_sectors(disk->queue,
+					   ns->ctrl->max_zeroes_sectors);
 
 	set_disk_ro(disk, (id->nsattr & NVME_NS_ATTR_RO) ||
 		test_bit(NVME_NS_FORCE_RO, &ns->flags));
@@ -3060,14 +3035,73 @@ static int nvme_get_effects_log(struct nvme_ctrl *ctrl, u8 csi,
 	return 0;
 }
 
+static inline u32 nvme_mps_size_to_sectors(struct nvme_ctrl *ctrl, u8 size)
+{
+	int page_shift = NVME_CAP_MPSMIN(ctrl->cap) + 12;
+
+	return 1 << (size + page_shift - 9);
+}
+
+static int nvme_init_non_mdts_limits(struct nvme_ctrl *ctrl)
+{
+	struct nvme_command c = { };
+	struct nvme_id_ctrl_nvm *id;
+	int ret;
+
+	if (ctrl->oncs & NVME_CTRL_ONCS_DSM) {
+		ctrl->max_discard_sectors = UINT_MAX;
+		ctrl->max_discard_segments = NVME_DSM_MAX_RANGES;
+	} else {
+		ctrl->max_discard_sectors = 0;
+		ctrl->max_discard_segments = 0;
+	}
+
+	/*
+	 * Even though NVMe spec explicitly states that MDTS is not applicable
+	 * to the write-zeroes, we are cautious and limit the size to the
+	 * controllers max_hw_sectors value, which is based on the MDTS field
+	 * and possibly other limiting factors.
+	 */
+	if (!(ctrl->quirks & NVME_QUIRK_DISABLE_WRITE_ZEROES) &&
+	    (ctrl->oncs & NVME_CTRL_ONCS_WRITE_ZEROES))
+		ctrl->max_zeroes_sectors = ctrl->max_hw_sectors;
+	else
+		ctrl->max_zeroes_sectors = 0;
+
+	if (nvme_ctrl_limited_cns(ctrl))
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
+		ctrl->max_zeroes_sectors = nvme_mps_size_to_sectors(ctrl,
+								    id->wzsl);
+
+free_data:
+	kfree(id);
+	return ret;
+}
+
 static int nvme_init_identify(struct nvme_ctrl *ctrl)
 {
 	struct nvme_id_ctrl *id;
-	int ret, page_shift;
 	u32 max_hw_sectors;
 	bool prev_apst_enabled;
-
-	page_shift = NVME_CAP_MPSMIN(ctrl->cap) + 12;
+	int ret;
 
 	ret = nvme_identify_ctrl(ctrl, &id);
 	if (ret) {
@@ -3124,7 +3158,7 @@ static int nvme_init_identify(struct nvme_ctrl *ctrl)
 	atomic_set(&ctrl->abort_limit, id->acl + 1);
 	ctrl->vwc = id->vwc;
 	if (id->mdts)
-		max_hw_sectors = 1 << (id->mdts + page_shift - 9);
+		max_hw_sectors = nvme_mps_size_to_sectors(ctrl, id->mdts);
 	else
 		max_hw_sectors = UINT_MAX;
 	ctrl->max_hw_sectors =
@@ -3235,6 +3269,10 @@ int nvme_init_ctrl_finish(struct nvme_ctrl *ctrl)
 	if (ret)
 		return ret;
 
+	ret = nvme_init_non_mdts_limits(ctrl);
+	if (ret < 0)
+		return ret;
+
 	ret = nvme_configure_apst(ctrl);
 	if (ret < 0)
 		return ret;
@@ -4765,6 +4803,7 @@ static inline void _nvme_check_size(void)
 	BUILD_BUG_ON(sizeof(struct nvme_id_ns) != NVME_IDENTIFY_DATA_SIZE);
 	BUILD_BUG_ON(sizeof(struct nvme_id_ns_zns) != NVME_IDENTIFY_DATA_SIZE);
 	BUILD_BUG_ON(sizeof(struct nvme_id_ctrl_zns) != NVME_IDENTIFY_DATA_SIZE);
+	BUILD_BUG_ON(sizeof(struct nvme_id_ctrl_nvm) != NVME_IDENTIFY_DATA_SIZE);
 	BUILD_BUG_ON(sizeof(struct nvme_lba_range_type) != 64);
 	BUILD_BUG_ON(sizeof(struct nvme_smart_log) != 512);
 	BUILD_BUG_ON(sizeof(struct nvme_dbbuf) != 64);
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index b0863c59fac46..815c032a190ef 100644
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
index b08787cd08812..edcbd60b88b98 100644
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
