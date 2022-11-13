Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48DA1C433FE
	for <linux-nvme@archiver.kernel.org>; Sun, 13 Nov 2022 16:11:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=beZXtSwh1gZ8xyOSBhcvxyb+Iq2r+NCVUZ+EeP2PwOU=; b=xntx3j9Bgsd57IY++74fsZltaC
	1RxhEAUH+31/akPlJk5gnrvWtITeO442sreJQacrt8mLOhSLBGUA5vDUT9zYNjpklGSHCn1fqFPMG
	h8S6bJOsffxg4dCasjIKXGWja2mh3+25wltdpSGpQWzKjDO+ycyyQaClry548i7qzAHT1PCSZXcqo
	yXqm8e+j1yn2iKYva26I2yLZikLN3PJk0MPHAZ47f3yUKwuTT0Uf436dHyR8C1tj0a/9rVxfgRoUI
	dDABeO+E5tBpruxH281UZt+s0LHlStFYWbViXauc0rhLZ5mmxHSr9BgJkA+1/FXk0OsfG/AawKm5c
	axCsJ1EQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ouFaL-00CBqa-RC; Sun, 13 Nov 2022 16:11:53 +0000
Received: from 213-225-8-167.nat.highway.a1.net ([213.225.8.167] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ouFaH-00CBoE-KV; Sun, 13 Nov 2022 16:11:50 +0000
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Gerd Bayer <gbayer@linux.ibm.com>,
	asahi@lists.linux.dev,
	linux-nvme@lists.infradead.org
Subject: [PATCH 02/13] nvme: move OPAL setup from PCIe to core
Date: Sun, 13 Nov 2022 17:11:27 +0100
Message-Id: <20221113161138.883195-3-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221113161138.883195-1-hch@lst.de>
References: <20221113161138.883195-1-hch@lst.de>
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

Nothing about the TCG Opal support is PCIe transport specific, so move it
to the core code.  For this nvme_init_ctrl_finish grows a new
was_suspended argument that allows the transport driver to tell the OPAL
code if the controller came out of a suspend cycle.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Keith Busch <kbusch@kernel.org>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Tested-by Gerd Bayer <gbayer@linxu.ibm.com>
---
 drivers/nvme/host/apple.c  |  2 +-
 drivers/nvme/host/core.c   | 25 ++++++++++++++++++++++---
 drivers/nvme/host/fc.c     |  2 +-
 drivers/nvme/host/nvme.h   |  5 +----
 drivers/nvme/host/pci.c    | 14 +-------------
 drivers/nvme/host/rdma.c   |  2 +-
 drivers/nvme/host/tcp.c    |  2 +-
 drivers/nvme/target/loop.c |  2 +-
 8 files changed, 29 insertions(+), 25 deletions(-)

diff --git a/drivers/nvme/host/apple.c b/drivers/nvme/host/apple.c
index 24e224c279a41..a85349a7e938c 100644
--- a/drivers/nvme/host/apple.c
+++ b/drivers/nvme/host/apple.c
@@ -1102,7 +1102,7 @@ static void apple_nvme_reset_work(struct work_struct *work)
 		goto out;
 	}
 
-	ret = nvme_init_ctrl_finish(&anv->ctrl);
+	ret = nvme_init_ctrl_finish(&anv->ctrl, false);
 	if (ret)
 		goto out;
 
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index ce8314aee1ddf..aedacf2fba69e 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2192,7 +2192,7 @@ const struct pr_ops nvme_pr_ops = {
 };
 
 #ifdef CONFIG_BLK_SED_OPAL
-int nvme_sec_submit(void *data, u16 spsp, u8 secp, void *buffer, size_t len,
+static int nvme_sec_submit(void *data, u16 spsp, u8 secp, void *buffer, size_t len,
 		bool send)
 {
 	struct nvme_ctrl *ctrl = data;
@@ -2209,7 +2209,23 @@ int nvme_sec_submit(void *data, u16 spsp, u8 secp, void *buffer, size_t len,
 	return __nvme_submit_sync_cmd(ctrl->admin_q, &cmd, NULL, buffer, len,
 			NVME_QID_ANY, 1, 0);
 }
-EXPORT_SYMBOL_GPL(nvme_sec_submit);
+
+static void nvme_configure_opal(struct nvme_ctrl *ctrl, bool was_suspended)
+{
+	if (ctrl->oacs & NVME_CTRL_OACS_SEC_SUPP) {
+		if (!ctrl->opal_dev)
+			ctrl->opal_dev = init_opal_dev(ctrl, &nvme_sec_submit);
+		else if (was_suspended)
+			opal_unlock_from_suspend(ctrl->opal_dev);
+	} else {
+		free_opal_dev(ctrl->opal_dev);
+		ctrl->opal_dev = NULL;
+	}
+}
+#else
+static void nvme_configure_opal(struct nvme_ctrl *ctrl, bool was_suspended)
+{
+}
 #endif /* CONFIG_BLK_SED_OPAL */
 
 #ifdef CONFIG_BLK_DEV_ZONED
@@ -3242,7 +3258,7 @@ static int nvme_init_identify(struct nvme_ctrl *ctrl)
  * register in our nvme_ctrl structure.  This should be called as soon as
  * the admin queue is fully up and running.
  */
-int nvme_init_ctrl_finish(struct nvme_ctrl *ctrl)
+int nvme_init_ctrl_finish(struct nvme_ctrl *ctrl, bool was_suspended)
 {
 	int ret;
 
@@ -3273,6 +3289,8 @@ int nvme_init_ctrl_finish(struct nvme_ctrl *ctrl)
 	if (ret < 0)
 		return ret;
 
+	nvme_configure_opal(ctrl, was_suspended);
+
 	if (!ctrl->identified && !nvme_discovery_ctrl(ctrl)) {
 		/*
 		 * Do not return errors unless we are in a controller reset,
@@ -5007,6 +5025,7 @@ static void nvme_free_ctrl(struct device *dev)
 	nvme_auth_stop(ctrl);
 	nvme_auth_free(ctrl);
 	__free_page(ctrl->discard_page);
+	free_opal_dev(ctrl->opal_dev);
 
 	if (subsys) {
 		mutex_lock(&nvme_subsystems_lock);
diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index 2d3c54838496f..1f9f4075794b5 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -3107,7 +3107,7 @@ nvme_fc_create_association(struct nvme_fc_ctrl *ctrl)
 
 	nvme_start_admin_queue(&ctrl->ctrl);
 
-	ret = nvme_init_ctrl_finish(&ctrl->ctrl);
+	ret = nvme_init_ctrl_finish(&ctrl->ctrl, false);
 	if (ret || test_bit(ASSOC_FAILED, &ctrl->flags))
 		goto out_disconnect_admin_queue;
 
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 16b34a4914959..306a120d49ab9 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -736,7 +736,7 @@ int nvme_init_ctrl(struct nvme_ctrl *ctrl, struct device *dev,
 void nvme_uninit_ctrl(struct nvme_ctrl *ctrl);
 void nvme_start_ctrl(struct nvme_ctrl *ctrl);
 void nvme_stop_ctrl(struct nvme_ctrl *ctrl);
-int nvme_init_ctrl_finish(struct nvme_ctrl *ctrl);
+int nvme_init_ctrl_finish(struct nvme_ctrl *ctrl, bool was_suspended);
 int nvme_alloc_admin_tag_set(struct nvme_ctrl *ctrl, struct blk_mq_tag_set *set,
 		const struct blk_mq_ops *ops, unsigned int flags,
 		unsigned int cmd_size);
@@ -748,9 +748,6 @@ void nvme_remove_io_tag_set(struct nvme_ctrl *ctrl);
 
 void nvme_remove_namespaces(struct nvme_ctrl *ctrl);
 
-int nvme_sec_submit(void *data, u16 spsp, u8 secp, void *buffer, size_t len,
-		bool send);
-
 void nvme_complete_async_event(struct nvme_ctrl *ctrl, __le16 status,
 		volatile union nvme_result *res);
 
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 208c387f1558d..e4f084e12b966 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2772,7 +2772,6 @@ static void nvme_pci_free_ctrl(struct nvme_ctrl *ctrl)
 	nvme_free_tagset(dev);
 	if (dev->ctrl.admin_q)
 		blk_put_queue(dev->ctrl.admin_q);
-	free_opal_dev(dev->ctrl.opal_dev);
 	mempool_destroy(dev->iod_mempool);
 	put_device(dev->dev);
 	kfree(dev->queues);
@@ -2866,21 +2865,10 @@ static void nvme_reset_work(struct work_struct *work)
 	 */
 	dev->ctrl.max_integrity_segments = 1;
 
-	result = nvme_init_ctrl_finish(&dev->ctrl);
+	result = nvme_init_ctrl_finish(&dev->ctrl, was_suspend);
 	if (result)
 		goto out;
 
-	if (dev->ctrl.oacs & NVME_CTRL_OACS_SEC_SUPP) {
-		if (!dev->ctrl.opal_dev)
-			dev->ctrl.opal_dev =
-				init_opal_dev(&dev->ctrl, &nvme_sec_submit);
-		else if (was_suspend)
-			opal_unlock_from_suspend(dev->ctrl.opal_dev);
-	} else {
-		free_opal_dev(dev->ctrl.opal_dev);
-		dev->ctrl.opal_dev = NULL;
-	}
-
 	if (dev->ctrl.oacs & NVME_CTRL_OACS_DBBUF_SUPP) {
 		result = nvme_dbbuf_dma_alloc(dev);
 		if (result)
diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 6e079abb22ee9..ccd45e5b32986 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -871,7 +871,7 @@ static int nvme_rdma_configure_admin_queue(struct nvme_rdma_ctrl *ctrl,
 
 	nvme_start_admin_queue(&ctrl->ctrl);
 
-	error = nvme_init_ctrl_finish(&ctrl->ctrl);
+	error = nvme_init_ctrl_finish(&ctrl->ctrl, false);
 	if (error)
 		goto out_quiesce_queue;
 
diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 1eed0fc26b3ae..4f8584657bb75 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -1949,7 +1949,7 @@ static int nvme_tcp_configure_admin_queue(struct nvme_ctrl *ctrl, bool new)
 
 	nvme_start_admin_queue(ctrl);
 
-	error = nvme_init_ctrl_finish(ctrl);
+	error = nvme_init_ctrl_finish(ctrl, false);
 	if (error)
 		goto out_quiesce_queue;
 
diff --git a/drivers/nvme/target/loop.c b/drivers/nvme/target/loop.c
index b45fe3adf015f..893c50f365c4d 100644
--- a/drivers/nvme/target/loop.c
+++ b/drivers/nvme/target/loop.c
@@ -377,7 +377,7 @@ static int nvme_loop_configure_admin_queue(struct nvme_loop_ctrl *ctrl)
 
 	nvme_start_admin_queue(&ctrl->ctrl);
 
-	error = nvme_init_ctrl_finish(&ctrl->ctrl);
+	error = nvme_init_ctrl_finish(&ctrl->ctrl, false);
 	if (error)
 		goto out_cleanup_tagset;
 
-- 
2.30.2


