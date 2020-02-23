Return-Path: <SRS0=vAFf=4L=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FF57C35669
	for <linux-nvme@archiver.kernel.org>; Sun, 23 Feb 2020 02:22:47 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA248208C4
	for <linux-nvme@archiver.kernel.org>; Sun, 23 Feb 2020 02:22:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="UfJ5zgyp";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="HR6Sd6yM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA248208C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=NPFnVCPhcJX7Y9jdGAyRXlzw1dUMQrsJCJOV+ySRCsA=; b=UfJ5zgypgGA9de
	pPnpwDW6P2oY1bV8ZG7fa1rvPiYXxgFlBuCCV8hjS7zlFEkFn87ZQhnEqU9/2Cb01lWP4kNeGGojf
	/nZiseifvEGt/KCRiU8WiN0fuVS+P6okc7dOmZUn37oerzb+NOt0SRqKLU9uilXG5hXzZKyUtG0fg
	vXB5VUl8XQGuO6ahZ+gxuQZ4OPM3Fv7DcrIFXdoXt8VUPShvayHhg9Fbtq4TIsUB2IT7zQW91XcmT
	2mCluUGskxO46wbUb7RABWPpEaRrIfQCsVCyFscLFvHHEPfIPhmimSoEW9E7jeu9gE4Z4IBXNa0t7
	5oXaiMeGoJBQVvpIMYrg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1j5gug-00020I-C9; Sun, 23 Feb 2020 02:22:34 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1j5gub-0001xM-J6
 for linux-nvme@lists.infradead.org; Sun, 23 Feb 2020 02:22:31 +0000
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net
 [73.47.72.35])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 4A0A7214DB;
 Sun, 23 Feb 2020 02:22:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1582424549;
 bh=fiow1jOLrBPF2kIgyQleElQONaYdG2nWNG10FhoHcNw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=HR6Sd6yM1U29ylvrHGkf4RQ0pC78bbmGCYKA/Cr2ETl8r1e2b6CbHWiNAlJbTealw
 982UOjmACc4OJUG64wXYffAMZIq1NIIS7R8wNeNCQOpLTN3VtbUfyH1HPhV/bViHsK
 5J6OESOFJohtOiLdfhmFyixile15katZOKFDCvvQ=
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.5 57/58] nvme: prevent warning triggered by
 nvme_stop_keep_alive
Date: Sat, 22 Feb 2020 21:21:18 -0500
Message-Id: <20200223022119.707-57-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200223022119.707-1-sashal@kernel.org>
References: <20200223022119.707-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200222_182229_666893_694F4966 
X-CRM114-Status: GOOD (  15.20  )
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
Cc: Jens Axboe <axboe@kernel.dk>, Sasha Levin <sashal@kernel.org>,
 James Smart <jsmart2021@gmail.com>, Sagi Grimberg <sagi@grimberg.me>,
 linux-nvme@lists.infradead.org, Nigel Kirkland <nigel.kirkland@broadcom.com>,
 Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

From: Nigel Kirkland <nigel.kirkland@broadcom.com>

[ Upstream commit 97b2512ad000a409b4073dd1a71e4157d76675cb ]

Delayed keep alive work is queued on system workqueue and may be cancelled
via nvme_stop_keep_alive from nvme_reset_wq, nvme_fc_wq or nvme_wq.

Check_flush_dependency detects mismatched attributes between the work-queue
context used to cancel the keep alive work and system-wq. Specifically
system-wq does not have the WQ_MEM_RECLAIM flag, whereas the contexts used
to cancel keep alive work have WQ_MEM_RECLAIM flag.

Example warning:

  workqueue: WQ_MEM_RECLAIM nvme-reset-wq:nvme_fc_reset_ctrl_work [nvme_fc]
	is flushing !WQ_MEM_RECLAIM events:nvme_keep_alive_work [nvme_core]

To avoid the flags mismatch, delayed keep alive work is queued on nvme_wq.

However this creates a secondary concern where work and a request to cancel
that work may be in the same work queue - namely err_work in the rdma and
tcp transports, which will want to flush/cancel the keep alive work which
will now be on nvme_wq.

After reviewing the transports, it looks like err_work can be moved to
nvme_reset_wq. In fact that aligns them better with transition into
RESETTING and performing related reset work in nvme_reset_wq.

Change nvme-rdma and nvme-tcp to perform err_work in nvme_reset_wq.

Signed-off-by: Nigel Kirkland <nigel.kirkland@broadcom.com>
Signed-off-by: James Smart <jsmart2021@gmail.com>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/core.c | 10 +++++-----
 drivers/nvme/host/rdma.c |  2 +-
 drivers/nvme/host/tcp.c  |  2 +-
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 641c07347e8d8..ada59df642d29 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -66,8 +66,8 @@ MODULE_PARM_DESC(streams, "turn on support for Streams write directives");
  * nvme_reset_wq - hosts nvme reset works
  * nvme_delete_wq - hosts nvme delete works
  *
- * nvme_wq will host works such are scan, aen handling, fw activation,
- * keep-alive error recovery, periodic reconnects etc. nvme_reset_wq
+ * nvme_wq will host works such as scan, aen handling, fw activation,
+ * keep-alive, periodic reconnects etc. nvme_reset_wq
  * runs reset works which also flush works hosted on nvme_wq for
  * serialization purposes. nvme_delete_wq host controller deletion
  * works which flush reset works for serialization.
@@ -976,7 +976,7 @@ static void nvme_keep_alive_end_io(struct request *rq, blk_status_t status)
 		startka = true;
 	spin_unlock_irqrestore(&ctrl->lock, flags);
 	if (startka)
-		schedule_delayed_work(&ctrl->ka_work, ctrl->kato * HZ);
+		queue_delayed_work(nvme_wq, &ctrl->ka_work, ctrl->kato * HZ);
 }
 
 static int nvme_keep_alive(struct nvme_ctrl *ctrl)
@@ -1006,7 +1006,7 @@ static void nvme_keep_alive_work(struct work_struct *work)
 		dev_dbg(ctrl->device,
 			"reschedule traffic based keep-alive timer\n");
 		ctrl->comp_seen = false;
-		schedule_delayed_work(&ctrl->ka_work, ctrl->kato * HZ);
+		queue_delayed_work(nvme_wq, &ctrl->ka_work, ctrl->kato * HZ);
 		return;
 	}
 
@@ -1023,7 +1023,7 @@ static void nvme_start_keep_alive(struct nvme_ctrl *ctrl)
 	if (unlikely(ctrl->kato == 0))
 		return;
 
-	schedule_delayed_work(&ctrl->ka_work, ctrl->kato * HZ);
+	queue_delayed_work(nvme_wq, &ctrl->ka_work, ctrl->kato * HZ);
 }
 
 void nvme_stop_keep_alive(struct nvme_ctrl *ctrl)
diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 2a47c6c5007e1..3e85c5cacefd2 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -1088,7 +1088,7 @@ static void nvme_rdma_error_recovery(struct nvme_rdma_ctrl *ctrl)
 	if (!nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_RESETTING))
 		return;
 
-	queue_work(nvme_wq, &ctrl->err_work);
+	queue_work(nvme_reset_wq, &ctrl->err_work);
 }
 
 static void nvme_rdma_wr_error(struct ib_cq *cq, struct ib_wc *wc,
diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index f8fa5c5b79f17..49d4373b84eb3 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -422,7 +422,7 @@ static void nvme_tcp_error_recovery(struct nvme_ctrl *ctrl)
 	if (!nvme_change_ctrl_state(ctrl, NVME_CTRL_RESETTING))
 		return;
 
-	queue_work(nvme_wq, &to_tcp_ctrl(ctrl)->err_work);
+	queue_work(nvme_reset_wq, &to_tcp_ctrl(ctrl)->err_work);
 }
 
 static int nvme_tcp_process_nvme_cqe(struct nvme_tcp_queue *queue,
-- 
2.20.1


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
