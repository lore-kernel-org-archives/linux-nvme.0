Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6CA3C4321E
	for <linux-nvme@archiver.kernel.org>; Tue, 29 Nov 2022 13:22:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+UzfZIXlATJt1IVWBD1bS1TJY9K2oqEBGQq8mVduGZI=; b=taLumqYA1xU8pE2UrVMLTGiKlo
	Tl9669GS6WSlT3liS79igM5RqeN9xYY0Ld9Eym82Ydu4WHXLMLaXQi8WZK/zFDlHnVzme59KvtSGR
	9DbWo7mAlpvWmYepkVElbnr312opj5F4zgkZMO7BFP3KJZiQXwxKn1MDuPZvcixP8D8YJPY2IX3rU
	coJXWvozVwcwAv+uD2gikD/aQFaO3oFGiTz39+GZHWgbDzWskQJBp74Qmxt7nlWrTWzT8TpKM/OzF
	+jhR8eTqVbWhlwUXb8uOn2apfJIY2b952AvDxPajxK6EfJJEQAIZV9FgZYvYAHe1nsHPw2Ji5Aqdy
	Q6Chbduw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p00ZA-008lbg-I5; Tue, 29 Nov 2022 13:22:28 +0000
Received: from [2001:4bb8:192:26e7:691d:40a8:d7b5:b2f5] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p00Z3-008lYR-M3; Tue, 29 Nov 2022 13:22:22 +0000
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: James Smart <james.smart@broadcom.com>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Hector Martin <marcan@marcan.st>,
	Sven Peter <sven@svenpeter.dev>,
	asahi@lists.linux.dev,
	linux-nvme@lists.infradead.org
Subject: [PATCH 3/9] nvme: merge nvme_shutdown_ctrl into nvme_disable_ctrl
Date: Tue, 29 Nov 2022 14:22:02 +0100
Message-Id: <20221129132208.4337-4-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221129132208.4337-1-hch@lst.de>
References: <20221129132208.4337-1-hch@lst.de>
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

Many of the callers decide which one to use based on a bool argument and
there is at least some code to be shared, so merge these two.  Also
move a comment specific to a single callsite to that callsite.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/host/apple.c  |  5 +----
 drivers/nvme/host/core.c   | 33 ++++++++++-----------------------
 drivers/nvme/host/fc.c     |  2 +-
 drivers/nvme/host/nvme.h   |  3 +--
 drivers/nvme/host/pci.c    | 15 +++++++++------
 drivers/nvme/host/rdma.c   |  5 +----
 drivers/nvme/host/tcp.c    |  5 +----
 drivers/nvme/target/loop.c |  2 +-
 8 files changed, 25 insertions(+), 45 deletions(-)

diff --git a/drivers/nvme/host/apple.c b/drivers/nvme/host/apple.c
index 56d9e9be945b76..e36aeb50b4edc1 100644
--- a/drivers/nvme/host/apple.c
+++ b/drivers/nvme/host/apple.c
@@ -829,10 +829,7 @@ static void apple_nvme_disable(struct apple_nvme *anv, bool shutdown)
 			apple_nvme_remove_cq(anv);
 		}
 
-		if (shutdown)
-			nvme_shutdown_ctrl(&anv->ctrl);
-		else
-			nvme_disable_ctrl(&anv->ctrl);
+		nvme_disable_ctrl(&anv->ctrl, shutdown);
 	}
 
 	WRITE_ONCE(anv->ioq.enabled, false);
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 9f20af2406dcc8..3753f9b5b54110 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2287,23 +2287,25 @@ static int nvme_wait_ready(struct nvme_ctrl *ctrl, u32 mask, u32 val,
 	return ret;
 }
 
-/*
- * If the device has been passed off to us in an enabled state, just clear
- * the enabled bit.  The spec says we should set the 'shutdown notification
- * bits', but doing so may cause the device to complete commands to the
- * admin queue ... and we don't know what memory that might be pointing at!
- */
-int nvme_disable_ctrl(struct nvme_ctrl *ctrl)
+int nvme_disable_ctrl(struct nvme_ctrl *ctrl, bool shutdown)
 {
 	int ret;
 
 	ctrl->ctrl_config &= ~NVME_CC_SHN_MASK;
-	ctrl->ctrl_config &= ~NVME_CC_ENABLE;
+	if (shutdown)
+		ctrl->ctrl_config |= NVME_CC_SHN_NORMAL;
+	else
+		ctrl->ctrl_config &= ~NVME_CC_ENABLE;
 
 	ret = ctrl->ops->reg_write32(ctrl, NVME_REG_CC, ctrl->ctrl_config);
 	if (ret)
 		return ret;
 
+	if (shutdown) {
+		return nvme_wait_ready(ctrl, NVME_CSTS_SHST_MASK,
+				       NVME_CSTS_SHST_CMPLT,
+				       ctrl->shutdown_timeout, "shutdown");
+	}
 	if (ctrl->quirks & NVME_QUIRK_DELAY_BEFORE_CHK_RDY)
 		msleep(NVME_QUIRK_DELAY_AMOUNT);
 	return nvme_wait_ready(ctrl, NVME_CSTS_RDY, 0,
@@ -2377,21 +2379,6 @@ int nvme_enable_ctrl(struct nvme_ctrl *ctrl)
 }
 EXPORT_SYMBOL_GPL(nvme_enable_ctrl);
 
-int nvme_shutdown_ctrl(struct nvme_ctrl *ctrl)
-{
-	int ret;
-
-	ctrl->ctrl_config &= ~NVME_CC_SHN_MASK;
-	ctrl->ctrl_config |= NVME_CC_SHN_NORMAL;
-
-	ret = ctrl->ops->reg_write32(ctrl, NVME_REG_CC, ctrl->ctrl_config);
-	if (ret)
-		return ret;
-	return nvme_wait_ready(ctrl, NVME_CSTS_SHST_MASK, NVME_CSTS_SHST_CMPLT,
-			       ctrl->shutdown_timeout, "shutdown");
-}
-EXPORT_SYMBOL_GPL(nvme_shutdown_ctrl);
-
 static int nvme_configure_timestamp(struct nvme_ctrl *ctrl)
 {
 	__le64 ts;
diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index 489f5e79720469..9cb9e067969c7a 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -2506,7 +2506,7 @@ __nvme_fc_abort_outstanding_ios(struct nvme_fc_ctrl *ctrl, bool start_queues)
 	 * Other transports, which don't have link-level contexts bound
 	 * to sqe's, would try to gracefully shutdown the controller by
 	 * writing the registers for shutdown and polling (call
-	 * nvme_shutdown_ctrl()). Given a bunch of i/o was potentially
+	 * nvme_disable_ctrl()). Given a bunch of i/o was potentially
 	 * just aborted and we will wait on those contexts, and given
 	 * there was no indication of how live the controlelr is on the
 	 * link, don't send more io to create more contexts for the
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index b5c0e4312d9b60..c2a0c1593fc779 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -733,9 +733,8 @@ void nvme_cancel_tagset(struct nvme_ctrl *ctrl);
 void nvme_cancel_admin_tagset(struct nvme_ctrl *ctrl);
 bool nvme_change_ctrl_state(struct nvme_ctrl *ctrl,
 		enum nvme_ctrl_state new_state);
-int nvme_disable_ctrl(struct nvme_ctrl *ctrl);
+int nvme_disable_ctrl(struct nvme_ctrl *ctrl, bool shutdown);
 int nvme_enable_ctrl(struct nvme_ctrl *ctrl);
-int nvme_shutdown_ctrl(struct nvme_ctrl *ctrl);
 int nvme_init_ctrl(struct nvme_ctrl *ctrl, struct device *dev,
 		const struct nvme_ctrl_ops *ops, unsigned long quirks);
 void nvme_uninit_ctrl(struct nvme_ctrl *ctrl);
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index ac734c8f6640e5..84226dce9b3b92 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1500,11 +1500,7 @@ static void nvme_disable_admin_queue(struct nvme_dev *dev, bool shutdown)
 {
 	struct nvme_queue *nvmeq = &dev->queues[0];
 
-	if (shutdown)
-		nvme_shutdown_ctrl(&dev->ctrl);
-	else
-		nvme_disable_ctrl(&dev->ctrl);
-
+	nvme_disable_ctrl(&dev->ctrl, shutdown);
 	nvme_poll_irqdisable(nvmeq);
 }
 
@@ -1819,7 +1815,14 @@ static int nvme_pci_configure_admin_queue(struct nvme_dev *dev)
 	    (readl(dev->bar + NVME_REG_CSTS) & NVME_CSTS_NSSRO))
 		writel(NVME_CSTS_NSSRO, dev->bar + NVME_REG_CSTS);
 
-	result = nvme_disable_ctrl(&dev->ctrl);
+	/*
+	 * If the device has been passed off to us in an enabled state, just
+	 * clear the enabled bit.  The spec says we should set the 'shutdown
+	 * notification bits', but doing so may cause the device to complete
+	 * commands to the admin queue ... and we don't know what memory that
+	 * might be pointing at!
+	 */
+	result = nvme_disable_ctrl(&dev->ctrl, false);
 	if (result < 0)
 		return result;
 
diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 448abf8cdf1f6e..cc61a1b8311b16 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -2208,10 +2208,7 @@ static void nvme_rdma_shutdown_ctrl(struct nvme_rdma_ctrl *ctrl, bool shutdown)
 {
 	nvme_rdma_teardown_io_queues(ctrl, shutdown);
 	nvme_quiesce_admin_queue(&ctrl->ctrl);
-	if (shutdown)
-		nvme_shutdown_ctrl(&ctrl->ctrl);
-	else
-		nvme_disable_ctrl(&ctrl->ctrl);
+	nvme_disable_ctrl(&ctrl->ctrl, shutdown);
 	nvme_rdma_teardown_admin_queue(ctrl, shutdown);
 }
 
diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 79789daddeac52..95e54e9c1bb1fc 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -2142,10 +2142,7 @@ static void nvme_tcp_teardown_ctrl(struct nvme_ctrl *ctrl, bool shutdown)
 {
 	nvme_tcp_teardown_io_queues(ctrl, shutdown);
 	nvme_quiesce_admin_queue(ctrl);
-	if (shutdown)
-		nvme_shutdown_ctrl(ctrl);
-	else
-		nvme_disable_ctrl(ctrl);
+	nvme_disable_ctrl(ctrl, shutdown);
 	nvme_tcp_teardown_admin_queue(ctrl, shutdown);
 }
 
diff --git a/drivers/nvme/target/loop.c b/drivers/nvme/target/loop.c
index 6d176621f46dc6..0015aed5c16996 100644
--- a/drivers/nvme/target/loop.c
+++ b/drivers/nvme/target/loop.c
@@ -401,7 +401,7 @@ static void nvme_loop_shutdown_ctrl(struct nvme_loop_ctrl *ctrl)
 
 	nvme_quiesce_admin_queue(&ctrl->ctrl);
 	if (ctrl->ctrl.state == NVME_CTRL_LIVE)
-		nvme_shutdown_ctrl(&ctrl->ctrl);
+		nvme_disable_ctrl(&ctrl->ctrl, true);
 
 	nvme_cancel_admin_tagset(&ctrl->ctrl);
 	nvme_loop_destroy_admin_queue(ctrl);
-- 
2.30.2


