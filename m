Return-Path: <SRS0=SsZO=G4=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DFA0C433DB
	for <linux-nvme@archiver.kernel.org>; Mon, 25 Jan 2021 19:59:53 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1BF62224F9
	for <linux-nvme@archiver.kernel.org>; Mon, 25 Jan 2021 19:59:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1BF62224F9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kioxia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-ID:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=hCY0KvZQAyETFbLKZjoMVFR4MlVzzXYX5piGLjibPA0=; b=zM/9kX2njfBz8mVZt61pIF0UM
	qQ6IedNqEOanFAPwBMRl1KdqESaNfDYbxjk7xbl6HbdRtpjWPo1hV3KR6Ai2+/StmYEHmRw6F3YSa
	vuydYrUSUckUfsESJZLNdsKr/Nicg2kEoEUTOd28T964aQSqMTGSSIq4tqzmtzz4TJbhmFw+/t1Ow
	01KjIcrMeCWMnjZhOsaVVIbNJxo9BahDvwPqsk7CuNVNXR5T5ca6Yf9Zf6HCvK3PkXDvQcJv+b9My
	uMIszGtQQ58p6UHpGITzgK5bY16xx2s03j8vaQTSoCQhF0C2NMyTu/XaHov/pefb7oL/HdTUsTmWM
	42TgZklaw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l480y-0008G6-MP; Mon, 25 Jan 2021 19:59:08 +0000
Received: from usmailhost21.kioxia.com ([12.0.68.226]
 helo=SJSMAIL01.us.kioxia.com)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l480t-0008E6-HZ
 for linux-nvme@lists.infradead.org; Mon, 25 Jan 2021 19:59:04 +0000
Received: from localhost.localdomain (10.93.83.20) by SJSMAIL01.us.kioxia.com
 (10.90.133.90) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1779.2; Mon, 25 Jan
 2021 11:58:55 -0800
From: <clay.mayers@kioxia.com>
To: <linux-nvme@lists.infradead.org>
Subject: [PATCH V2 1/2] nvme: support fused pci nvme requests
Date: Mon, 25 Jan 2021 11:58:43 -0800
Message-ID: <20210125195844.1390581-2-clay.mayers@kioxia.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210105224939.1336-2-clay.mayers@kioxia.com>
References: <20210105224939.1336-2-clay.mayers@kioxia.com>
MIME-Version: 1.0
X-Originating-IP: [10.93.83.20]
X-ClientProxiedBy: SJSMAIL01.us.kioxia.com (10.90.133.90) To
 SJSMAIL01.us.kioxia.com (10.90.133.90)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210125_145903_600737_5C4F5B79 
X-CRM114-Status: GOOD (  22.56  )
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
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

From: Clay Mayers <clay.mayers@kioxia.com>

Adds support for fused nvme commands to be tunneled through a blk_mq
queue and submitted atomically to a pci nvme device queue.

In nvme_queue_rq(), when an nvme cmnd has the first fused flag set,
the nvme cmnd is saved in nvme_request.fctx and the command is not
queued to the device.  Once the nvme cmnd with the second fused flag
set is queued, nvme_request.nrq is used to get back to the first
fused request so both cmnds can be queued to the device atomically.

v2:
Reduced size of nvme_request by pointing to saved cmnd instead so
only fused commands require the extra 64 bytes.  The saved cmnd is
now with the first request to ease clean up.  Flipped second req
to point to the first so a union with the saved cmnd pointer can
be used to limit the fused impact to 8 bytes.

Fixed issue with aborted first fused cmnd being submitted by
unaborted second fused cmnd.

Signed-off-by: Clay Mayers <clay.mayers@kioxia.com>
---
 drivers/nvme/host/nvme.h | 12 ++++++
 drivers/nvme/host/pci.c  | 85 ++++++++++++++++++++++++++++++++++++++--
 2 files changed, 94 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 567f7ad18a91..b41ce7cd4f49 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -157,6 +157,18 @@ struct nvme_request {
 	u8			flags;
 	u16			status;
 	struct nvme_ctrl	*ctrl;
+	union {
+		struct nvme_request *nrq;	/* other fused request */
+		/*
+		 * Between the time the first fused is queued with nvme_queue_rq
+		 * and the second command is queued, the first fused command
+		 * uses fctx instead of nrq.
+		 */
+		struct nvme_fused_ctx {
+			struct nvme_request *nrq2;	/* copy of nrq */
+			struct nvme_command cmnd;	/* copy of 1st fused */
+		} *fctx;
+	};
 };
 
 /*
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 3be352403839..ba4798685811 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -491,6 +491,30 @@ static inline void nvme_write_sq_db(struct nvme_queue *nvmeq, bool write_sq)
 	nvmeq->last_sq_tail = nvmeq->sq_tail;
 }
 
+/**
+ * nvme_submit_cmd2() - Copy fused commands into a queue and ring the doorbell
+ * @nvmeq: The queue to use
+ * @cmd: The first command to send
+ * @cmd2: the second command to send
+ * @write_sq: whether to write to the SQ doorbell
+ */
+static void nvme_submit_cmd2(struct nvme_queue *nvmeq, struct nvme_command *cmd,
+			     struct nvme_command *cmd2, bool write_sq)
+{
+	spin_lock(&nvmeq->sq_lock);
+	memcpy(nvmeq->sq_cmds + (nvmeq->sq_tail << nvmeq->sqes),
+		cmd, sizeof(*cmd));
+	if (++nvmeq->sq_tail == nvmeq->q_depth)
+		nvmeq->sq_tail = 0;
+	memcpy(nvmeq->sq_cmds + (nvmeq->sq_tail << nvmeq->sqes),
+		cmd2, sizeof(*cmd2));
+	if (++nvmeq->sq_tail == nvmeq->q_depth)
+		nvmeq->sq_tail = 0;
+	nvme_write_sq_db(nvmeq, write_sq);
+	spin_unlock(&nvmeq->sq_lock);
+}
+
+
 /**
  * nvme_submit_cmd() - Copy a command into a queue and ring the doorbell
  * @nvmeq: The queue to use
@@ -876,6 +900,37 @@ static blk_status_t nvme_map_metadata(struct nvme_dev *dev, struct request *req,
 	return BLK_STS_OK;
 }
 
+static blk_status_t nvme_queue_frq(struct nvme_queue *nvmeq,
+			struct request *req, struct nvme_command *cmnd,
+			bool write_sq)
+{
+	struct nvme_fused_ctx *fctx;
+
+	if (cmnd->common.flags & NVME_CMD_FUSE_FIRST) {
+		/* Save cmnd to submit with 2nd fused */
+		fctx = kmalloc(sizeof(*fctx), GFP_KERNEL);
+		if (!fctx)
+			return BLK_STS_RESOURCE;
+		fctx->nrq2 = nvme_req(req)->nrq;
+		memcpy(&fctx->cmnd, cmnd, sizeof(*cmnd));
+		nvme_req(req)->fctx = fctx;
+		blk_mq_start_request(req);
+		return BLK_STS_OK;
+	}
+	/* handle NVME_CMD_FUSED_SECOND */
+	if (!nvme_req(req)->nrq) {
+		nvme_req(req)->status = NVME_SC_FUSED_FAIL;
+		return BLK_STS_IOERR;	/* First i/o has been canceled */
+	}
+
+	fctx = nvme_req(req)->nrq->fctx;
+	nvme_req(req)->nrq->fctx = NULL;
+	blk_mq_start_request(req);
+	nvme_submit_cmd2(nvmeq, &fctx->cmnd, cmnd, write_sq);
+	kfree(fctx);
+	return BLK_STS_OK;
+}
+
 /*
  * NOTE: ns is NULL when called on the admin queue.
  */
@@ -889,6 +944,7 @@ static blk_status_t nvme_queue_rq(struct blk_mq_hw_ctx *hctx,
 	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
 	struct nvme_command cmnd;
 	blk_status_t ret;
+	int fused;
 
 	iod->aborted = 0;
 	iod->npages = -1;
@@ -917,8 +973,15 @@ static blk_status_t nvme_queue_rq(struct blk_mq_hw_ctx *hctx,
 			goto out_unmap_data;
 	}
 
-	blk_mq_start_request(req);
-	nvme_submit_cmd(nvmeq, &cmnd, bd->last);
+	fused = cmnd.common.flags & (NVME_CMD_FUSE_FIRST|NVME_CMD_FUSE_SECOND);
+	if (likely(!fused)) {
+		blk_mq_start_request(req);
+		nvme_submit_cmd(nvmeq, &cmnd, bd->last);
+	} else {
+		ret = nvme_queue_frq(nvmeq, req, &cmnd, bd->last);
+		if (ret)
+			goto out_unmap_data;
+	}
 	return BLK_STS_OK;
 out_unmap_data:
 	nvme_unmap_data(dev, req);
@@ -2423,6 +2486,22 @@ static void nvme_pci_disable(struct nvme_dev *dev)
 	}
 }
 
+static bool nvme_pci_cancel_rq(struct request *req, void *data, bool reserved)
+{
+	if (unlikely(nvme_req(req)->cmd->common.flags & NVME_CMD_FUSE_FIRST)) {
+		struct nvme_fused_ctx *fctx = nvme_req(req)->fctx;
+
+		/* this will only be set if 2nd fused isn't queued yet */
+		if (unlikely(fctx)) {
+			fctx->nrq2->nrq = NULL;	/* break link of 2nd fused */
+			nvme_req(req)->fctx = NULL;
+			kfree(fctx);
+		}
+	}
+	return nvme_cancel_request(req, data, reserved);
+}
+
+
 static void nvme_dev_disable(struct nvme_dev *dev, bool shutdown)
 {
 	bool dead = true, freeze = false;
@@ -2459,7 +2538,7 @@ static void nvme_dev_disable(struct nvme_dev *dev, bool shutdown)
 	nvme_pci_disable(dev);
 	nvme_reap_pending_cqes(dev);
 
-	blk_mq_tagset_busy_iter(&dev->tagset, nvme_cancel_request, &dev->ctrl);
+	blk_mq_tagset_busy_iter(&dev->tagset, nvme_pci_cancel_rq, &dev->ctrl);
 	blk_mq_tagset_busy_iter(&dev->admin_tagset, nvme_cancel_request, &dev->ctrl);
 	blk_mq_tagset_wait_completed_request(&dev->tagset);
 	blk_mq_tagset_wait_completed_request(&dev->admin_tagset);
-- 
2.27.0


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
