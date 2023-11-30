Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90E8FC10DAA
	for <linux-nvme@archiver.kernel.org>; Thu, 30 Nov 2023 13:42:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=fCN2UULtCxJ77nN9Gh/qq3eEdgixchxKMaOJIrf1zbs=; b=UEZGJHyQKhN6KZPNw/pvleuCZp
	4/xHUIK2jpugbnzaY+RYwXCbess+9tZGiras2bSX26ZY1tqNqJLcbwNPMel24LE1ZhpftmpkDFJQe
	8uIdIw5CeAyJzuAIXMLsz6VkA8qAvK1jHmuN3efj+HCXeMyXaFy98nwYY5TWwJ+szYbs9msWekCqL
	UbgAbA1cM180Z/d7OwtIXJAPcVJleObzDq7zDlpKscWo8r4IjNzkX47NbvsSO3YD/Tlob1/3fi+Qk
	ezr1OoYRsbdG8v/Id86Hq9e33HV77z+ldts3SW3AFrCDdgriuT/L8w+j1eNjqpXYRdZoaQQHaWYXH
	L1o0Iy8w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r8hJ2-00AzCC-2Q;
	Thu, 30 Nov 2023 13:42:16 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r8hIz-00AzB3-33
	for linux-nvme@lists.infradead.org;
	Thu, 30 Nov 2023 13:42:15 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id D3D0961EC5;
	Thu, 30 Nov 2023 13:42:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51575C433C8;
	Thu, 30 Nov 2023 13:42:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701351732;
	bh=0KgDrt6HsA220G09WFZrtKcT8dUupa/s+ucvUg7fDgI=;
	h=From:To:Cc:Subject:Date:From;
	b=iS41tlLSVwLHjGl0Q3kMItYWs9WeXh7stoAoAheE1B14XsDKQV5/prFhpsynZCS7p
	 P9jva72ArPmpS2cFgBz3M6FHsIQ2Rc3z3v0auxGcosWLZpjiKBWpl8eM9ZujJy+QXT
	 TpxzewxMzxUMD8uqLZDaXDNSia8Q9q8eARCf+yDptrzIulNytrrDWIYnTmwSX3/Sw+
	 JcJeXQpu8YQGGn11iZBuWskHI9kJJZJ+TwB6Y/mplxee8Joo3ZkQlcO8U/w4xbBAoe
	 jBtS7BfMrbnz0FIqtBptr2OZCuQW5fGYkkr8EvDTDH8VdBmFuUbHJTP3ZvyQONv7Ml
	 iqulb3zWaqmOg==
From: hare@kernel.org
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH] nvme-rdma: fix nvme_ctrl_state() conversion
Date: Thu, 30 Nov 2023 14:42:10 +0100
Message-Id: <20231130134210.133103-1-hare@kernel.org>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231130_054214_046072_363A8327 
X-CRM114-Status: GOOD (  13.12  )
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

From: Hannes Reinecke <hare@suse.de>

The argument to nvme_ctrl_state() is 'struct nvme_ctrl'.

Fixes: b59ea0f40072 ("nvme: introduce helper function to get ctrl state")
Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/nvme/host/rdma.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 0ef2ac67d2ae..81e2621169e5 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -984,7 +984,7 @@ static void nvme_rdma_free_ctrl(struct nvme_ctrl *nctrl)
 
 static void nvme_rdma_reconnect_or_remove(struct nvme_rdma_ctrl *ctrl)
 {
-	enum nvme_ctrl_state state = nvme_ctrl_state(ctrl);
+	enum nvme_ctrl_state state = nvme_ctrl_state(&ctrl->ctrl);
 
 	/* If we are resetting/deleting then do nothing */
 	if (state != NVME_CTRL_CONNECTING) {
@@ -1060,7 +1060,7 @@ static int nvme_rdma_setup_ctrl(struct nvme_rdma_ctrl *ctrl, bool new)
 		 * unless we're during creation of a new controller to
 		 * avoid races with teardown flow.
 		 */
-		enum nvme_ctrl_state state = nvme_ctrl_state(ctrl);
+		enum nvme_ctrl_state state = nvme_ctrl_state(&ctrl->ctrl);
 
 		WARN_ON_ONCE(state != NVME_CTRL_DELETING &&
 			     state != NVME_CTRL_DELETING_NOIO);
@@ -1132,7 +1132,7 @@ static void nvme_rdma_error_recovery_work(struct work_struct *work)
 
 	if (!nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_CONNECTING)) {
 		/* state change failure is ok if we started ctrl delete */
-		enum nvme_ctrl_state state = nvme_ctrl_state(ctrl);
+		enum nvme_ctrl_state state = nvme_ctrl_state(&ctrl->ctrl);
 
 		WARN_ON_ONCE(state != NVME_CTRL_DELETING &&
 			     state != NVME_CTRL_DELETING_NOIO);
@@ -1167,7 +1167,7 @@ static void nvme_rdma_wr_error(struct ib_cq *cq, struct ib_wc *wc,
 	struct nvme_rdma_queue *queue = wc->qp->qp_context;
 	struct nvme_rdma_ctrl *ctrl = queue->ctrl;
 
-	if (nvme_ctrl_state(ctrl) == NVME_CTRL_LIVE)
+	if (nvme_ctrl_state(&ctrl->ctrl) == NVME_CTRL_LIVE)
 		dev_info(ctrl->ctrl.device,
 			     "%s for CQE 0x%p failed with status %s (%d)\n",
 			     op, wc->wr_cqe,
@@ -1950,7 +1950,7 @@ static enum blk_eh_timer_return nvme_rdma_timeout(struct request *rq)
 	dev_warn(ctrl->ctrl.device, "I/O %d QID %d timeout\n",
 		 rq->tag, nvme_rdma_queue_idx(queue));
 
-	if (nvme_ctrl_state(ctrl) != NVME_CTRL_LIVE) {
+	if (nvme_ctrl_state(&ctrl->ctrl) != NVME_CTRL_LIVE) {
 		/*
 		 * If we are resetting, connecting or deleting we should
 		 * complete immediately because we may block controller
-- 
2.35.3


