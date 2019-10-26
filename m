Return-Path: <SRS0=T5EX=YT=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55A8ECA9EBD
	for <linux-nvme@archiver.kernel.org>; Sat, 26 Oct 2019 13:20:58 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 22076222BE
	for <linux-nvme@archiver.kernel.org>; Sat, 26 Oct 2019 13:20:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="jnSgiv6C";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="XvT2yo23"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22076222BE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=81K/b4N/ovDdM2sbEr2DF0J/fRIfHEu0KmLgMZde24M=; b=jnSgiv6ChjjdFk
	0bSq3lEHymZO5VuHJ1FbpQLHplFT+tNIllx1OvKzvF+eP0K/ZbyHTCS7fp4N9WIlxTXTFGN7Sotmg
	Xgb70BWgroP3YRwOyT+1WVSR3rXL1zeo9a8vqZstoFthg+wNpno4jsEt8himro0ObPFv2cZPUDYrH
	UA91KmZ56t3LzchfYklcbPe53Z5Vcy1shgVy6/2yCUQFj/8QTyOSreS3+BWo6z5QIunDKXgBUbn2B
	ro1TSyM7DqLJd4smrYocuzh/XbtkkMtx8BTpIwzlvofJHyvWmBbosq9cFFf3UgAKoNX3ojUlx4q6j
	52XWPKevTOKHuiKkQ95g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iOLzl-0001bI-TE; Sat, 26 Oct 2019 13:20:42 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iOLzd-0001Uy-ON
 for linux-nvme@lists.infradead.org; Sat, 26 Oct 2019 13:20:35 +0000
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net
 [73.47.72.35])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id B3717222BD;
 Sat, 26 Oct 2019 13:20:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1572096033;
 bh=0gMrf58nyOQicRuJIsnB9fgJMehx9YiSuKXoMEcGI28=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=XvT2yo23keVe2VXfZamfI/l28P5t+AkUnBS+mUn4TKR05cpORLtWlk7y4SqRt0GlP
 6EM5NC6jZLzY5wNCm/0msNPhnBGpAvyOb1DbG1C+bmzeDslCbWZ+GoWMfZrxyJqkhi
 IKvN6YNW9I5A+kCK/p0fr0L0VaNIiH3/jOdPWSHo=
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 43/59] nvme: Prevent resets during paused
 controller state
Date: Sat, 26 Oct 2019 09:18:54 -0400
Message-Id: <20191026131910.3435-43-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191026131910.3435-1-sashal@kernel.org>
References: <20191026131910.3435-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191026_062033_830016_35D41024 
X-CRM114-Status: GOOD (  12.34  )
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
Cc: Keith Busch <kbusch@kernel.org>, Sasha Levin <sashal@kernel.org>,
 Edmund Nadolski <edmund.nadolski@intel.com>, Christoph Hellwig <hch@lst.de>,
 linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

From: Keith Busch <kbusch@kernel.org>

[ Upstream commit 4c75f877853cfa81b12374a07208e07b077f39b8 ]

A paused controller is doing critical internal activation work in the
background. Prevent subsequent controller resets from occurring during
this period by setting the controller state to RESETTING first. A helper
function, nvme_try_sched_reset_work(), is introduced for these paths so
they may continue with scheduling the reset_work after they've completed
their uninterruptible critical section.

Tested-by: Edmund Nadolski <edmund.nadolski@intel.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/core.c | 29 +++++++++++++++++++++++++----
 1 file changed, 25 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index ddd5c72a565ad..95d4f1a6dd795 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -126,6 +126,21 @@ static void nvme_queue_scan(struct nvme_ctrl *ctrl)
 		queue_work(nvme_wq, &ctrl->scan_work);
 }
 
+/*
+ * Use this function to proceed with scheduling reset_work for a controller
+ * that had previously been set to the resetting state. This is intended for
+ * code paths that can't be interrupted by other reset attempts. A hot removal
+ * may prevent this from succeeding.
+ */
+static int nvme_try_sched_reset(struct nvme_ctrl *ctrl)
+{
+	if (ctrl->state != NVME_CTRL_RESETTING)
+		return -EBUSY;
+	if (!queue_work(nvme_reset_wq, &ctrl->reset_work))
+		return -EBUSY;
+	return 0;
+}
+
 int nvme_reset_ctrl(struct nvme_ctrl *ctrl)
 {
 	if (!nvme_change_ctrl_state(ctrl, NVME_CTRL_RESETTING))
@@ -3445,13 +3460,13 @@ static void nvme_fw_act_work(struct work_struct *work)
 		if (time_after(jiffies, fw_act_timeout)) {
 			dev_warn(ctrl->device,
 				"Fw activation timeout, reset controller\n");
-			nvme_reset_ctrl(ctrl);
-			break;
+			nvme_try_sched_reset(ctrl);
+			return;
 		}
 		msleep(100);
 	}
 
-	if (ctrl->state != NVME_CTRL_LIVE)
+	if (!nvme_change_ctrl_state(ctrl, NVME_CTRL_LIVE))
 		return;
 
 	nvme_start_queues(ctrl);
@@ -3467,7 +3482,13 @@ static void nvme_handle_aen_notice(struct nvme_ctrl *ctrl, u32 result)
 		nvme_queue_scan(ctrl);
 		break;
 	case NVME_AER_NOTICE_FW_ACT_STARTING:
-		queue_work(nvme_wq, &ctrl->fw_act_work);
+		/*
+		 * We are (ab)using the RESETTING state to prevent subsequent
+		 * recovery actions from interfering with the controller's
+		 * firmware activation.
+		 */
+		if (nvme_change_ctrl_state(ctrl, NVME_CTRL_RESETTING))
+			queue_work(nvme_wq, &ctrl->fw_act_work);
 		break;
 #ifdef CONFIG_NVME_MULTIPATH
 	case NVME_AER_NOTICE_ANA:
-- 
2.20.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
