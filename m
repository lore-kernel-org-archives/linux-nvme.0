Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31CEBC433EF
	for <linux-nvme@archiver.kernel.org>; Thu,  3 Mar 2022 10:51:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=LrW6BbtCpMib6/k/2RdTMmPeC54C2vdwSDhnt9pxVSw=; b=wIODFS+k6PUrAx9n6CAILRiF7Q
	dxZqqz9Z/iDSZNX5Ik/+AepJ2ODp+t8VosNpBTA1EkZgeFAnxzK0rKJc9F1ZQuJM8N8P1uUJ0n10F
	/jd5CJ1w0NJawOygRm4W8QUrhgfeHaM/hKOIRRbRi+mqHgMKJsQZIW+s3gQ2tdq2X5RLVTB1wYyOG
	xWUjzoR2qwamF8/XfswqPiKj5ctC4CCEDtBChGb5KFJ5LqRoJYeZS+LrWBA5bIUYi45JBBvMxAOR4
	x0+m9MS33EpjNvti9yIrVv7HanASCHcHarxeG02joyMxOMxctlVKa6s+6f7fmmh2bm9ynovKTskZF
	RC/xANzA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nPj3Z-0067Nn-RE; Thu, 03 Mar 2022 10:51:37 +0000
Received: from [91.93.38.115] (helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nPj2t-0067IB-9u; Thu, 03 Mar 2022 10:51:36 +0000
From: Christoph Hellwig <hch@lst.de>
To: kbusch@kernel.org,
	axboe@fb.com,
	sagi@grimberg.me
Cc: linux-nvme@lists.infradead.org
Subject: [PATCH] nvme: remove support or stream based temperature hint
Date: Thu,  3 Mar 2022 13:50:49 +0300
Message-Id: <20220303105049.315987-1-hch@lst.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

This support was added for RocksDB, but RocksDB ended up not using it.
At the same time drives on the open marked (vs those build for OEMs
for non-Linux support) that actually support streams are extremly
rare.  Don't bloat the nvme driver for it.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/host/core.c | 143 ---------------------------------------
 1 file changed, 143 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index f8084ded69e50..61f29c59b14cf 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -77,10 +77,6 @@ module_param(apst_secondary_latency_tol_us, ulong, 0644);
 MODULE_PARM_DESC(apst_secondary_latency_tol_us,
 	"secondary APST latency tolerance in us");
 
-static bool streams;
-module_param(streams, bool, 0644);
-MODULE_PARM_DESC(streams, "turn on support for Streams write directives");
-
 /*
  * nvme_wq - hosts nvme related works that are not reset or delete
  * nvme_reset_wq - hosts nvme reset works
@@ -747,108 +743,6 @@ bool __nvme_check_ready(struct nvme_ctrl *ctrl, struct request *rq,
 }
 EXPORT_SYMBOL_GPL(__nvme_check_ready);
 
-static int nvme_toggle_streams(struct nvme_ctrl *ctrl, bool enable)
-{
-	struct nvme_command c = { };
-
-	c.directive.opcode = nvme_admin_directive_send;
-	c.directive.nsid = cpu_to_le32(NVME_NSID_ALL);
-	c.directive.doper = NVME_DIR_SND_ID_OP_ENABLE;
-	c.directive.dtype = NVME_DIR_IDENTIFY;
-	c.directive.tdtype = NVME_DIR_STREAMS;
-	c.directive.endir = enable ? NVME_DIR_ENDIR : 0;
-
-	return nvme_submit_sync_cmd(ctrl->admin_q, &c, NULL, 0);
-}
-
-static int nvme_disable_streams(struct nvme_ctrl *ctrl)
-{
-	return nvme_toggle_streams(ctrl, false);
-}
-
-static int nvme_enable_streams(struct nvme_ctrl *ctrl)
-{
-	return nvme_toggle_streams(ctrl, true);
-}
-
-static int nvme_get_stream_params(struct nvme_ctrl *ctrl,
-				  struct streams_directive_params *s, u32 nsid)
-{
-	struct nvme_command c = { };
-
-	memset(s, 0, sizeof(*s));
-
-	c.directive.opcode = nvme_admin_directive_recv;
-	c.directive.nsid = cpu_to_le32(nsid);
-	c.directive.numd = cpu_to_le32(nvme_bytes_to_numd(sizeof(*s)));
-	c.directive.doper = NVME_DIR_RCV_ST_OP_PARAM;
-	c.directive.dtype = NVME_DIR_STREAMS;
-
-	return nvme_submit_sync_cmd(ctrl->admin_q, &c, s, sizeof(*s));
-}
-
-static int nvme_configure_directives(struct nvme_ctrl *ctrl)
-{
-	struct streams_directive_params s;
-	u16 nssa;
-	int ret;
-
-	if (!(ctrl->oacs & NVME_CTRL_OACS_DIRECTIVES))
-		return 0;
-	if (!streams)
-		return 0;
-
-	ret = nvme_enable_streams(ctrl);
-	if (ret)
-		return ret;
-
-	ret = nvme_get_stream_params(ctrl, &s, NVME_NSID_ALL);
-	if (ret)
-		goto out_disable_stream;
-
-	nssa = le16_to_cpu(s.nssa);
-	if (nssa < BLK_MAX_WRITE_HINTS - 1) {
-		dev_info(ctrl->device, "too few streams (%u) available\n",
-					nssa);
-		/* this condition is not an error: streams are optional */
-		ret = 0;
-		goto out_disable_stream;
-	}
-
-	ctrl->nr_streams = min_t(u16, nssa, BLK_MAX_WRITE_HINTS - 1);
-	dev_info(ctrl->device, "Using %u streams\n", ctrl->nr_streams);
-	return 0;
-
-out_disable_stream:
-	nvme_disable_streams(ctrl);
-	return ret;
-}
-
-/*
- * Check if 'req' has a write hint associated with it. If it does, assign
- * a valid namespace stream to the write.
- */
-static void nvme_assign_write_stream(struct nvme_ctrl *ctrl,
-				     struct request *req, u16 *control,
-				     u32 *dsmgmt)
-{
-	enum rw_hint streamid = req->write_hint;
-
-	if (streamid == WRITE_LIFE_NOT_SET || streamid == WRITE_LIFE_NONE)
-		streamid = 0;
-	else {
-		streamid--;
-		if (WARN_ON_ONCE(streamid > ctrl->nr_streams))
-			return;
-
-		*control |= NVME_RW_DTYPE_STREAMS;
-		*dsmgmt |= streamid << 16;
-	}
-
-	if (streamid < ARRAY_SIZE(req->q->write_hints))
-		req->q->write_hints[streamid] += blk_rq_bytes(req) >> 9;
-}
-
 static inline void nvme_setup_flush(struct nvme_ns *ns,
 		struct nvme_command *cmnd)
 {
@@ -952,7 +846,6 @@ static inline blk_status_t nvme_setup_rw(struct nvme_ns *ns,
 		struct request *req, struct nvme_command *cmnd,
 		enum nvme_opcode op)
 {
-	struct nvme_ctrl *ctrl = ns->ctrl;
 	u16 control = 0;
 	u32 dsmgmt = 0;
 
@@ -975,9 +868,6 @@ static inline blk_status_t nvme_setup_rw(struct nvme_ns *ns,
 	cmnd->rw.apptag = 0;
 	cmnd->rw.appmask = 0;
 
-	if (req_op(req) == REQ_OP_WRITE && ctrl->nr_streams)
-		nvme_assign_write_stream(ctrl, req, &control, &dsmgmt);
-
 	if (ns->ms) {
 		/*
 		 * If formated with metadata, the block layer always provides a
@@ -1696,9 +1586,6 @@ static void nvme_config_discard(struct gendisk *disk, struct nvme_ns *ns)
 		return;
 	}
 
-	if (ctrl->nr_streams && ns->sws && ns->sgs)
-		size *= ns->sws * ns->sgs;
-
 	BUILD_BUG_ON(PAGE_SIZE / sizeof(struct nvme_dsm_range) <
 			NVME_DSM_MAX_RANGES);
 
@@ -1724,31 +1611,6 @@ static bool nvme_ns_ids_equal(struct nvme_ns_ids *a, struct nvme_ns_ids *b)
 		a->csi == b->csi;
 }
 
-static int nvme_setup_streams_ns(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
-				 u32 *phys_bs, u32 *io_opt)
-{
-	struct streams_directive_params s;
-	int ret;
-
-	if (!ctrl->nr_streams)
-		return 0;
-
-	ret = nvme_get_stream_params(ctrl, &s, ns->head->ns_id);
-	if (ret)
-		return ret;
-
-	ns->sws = le32_to_cpu(s.sws);
-	ns->sgs = le16_to_cpu(s.sgs);
-
-	if (ns->sws) {
-		*phys_bs = ns->sws * (1 << ns->lba_shift);
-		if (ns->sgs)
-			*io_opt = *phys_bs * ns->sgs;
-	}
-
-	return 0;
-}
-
 static int nvme_configure_metadata(struct nvme_ns *ns, struct nvme_id_ns *id)
 {
 	struct nvme_ctrl *ctrl = ns->ctrl;
@@ -1841,7 +1703,6 @@ static void nvme_update_disk_info(struct gendisk *disk,
 	blk_integrity_unregister(disk);
 
 	atomic_bs = phys_bs = bs;
-	nvme_setup_streams_ns(ns->ctrl, ns, &phys_bs, &io_opt);
 	if (id->nabo == 0) {
 		/*
 		 * Bit 1 indicates whether NAWUPF is defined for this namespace
@@ -3133,10 +2994,6 @@ int nvme_init_ctrl_finish(struct nvme_ctrl *ctrl)
 	if (ret < 0)
 		return ret;
 
-	ret = nvme_configure_directives(ctrl);
-	if (ret < 0)
-		return ret;
-
 	ret = nvme_configure_acre(ctrl);
 	if (ret < 0)
 		return ret;
-- 
2.30.2


