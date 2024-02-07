Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FF90C4828F
	for <linux-nvme@archiver.kernel.org>; Wed,  7 Feb 2024 18:44:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=cuv9rvzEed+0pQINLR4eZlmzvTUXMYlIRXYRIOt5NJQ=; b=2T2bLmvtCar6+AtS9eIsXTBSo9
	pAaKTn6UPQpiBQ9oTSRDn+Xi8C/RRoisJZPJlkcwjev7CAp+/A9k3t6Y1tTBFFCiN8q36H10ANcTw
	awHzQQKfxg7My5lQo4yr4RxCPsx2Q+ZJpR4Q6SiQE2HwXrlumMqj8KWZDap8vW2sBWX5Aa7ayUnEV
	uhAAI0yF694RKhFjzehhK97QFTbXAIvsz0jH8XocTBhCNlXizWKlm2En23fD63Jj15XQunxXnOS4d
	6YGzS6cDu3nW8a3FVyeU5FIQ46eyK5oHrhnDiGDHh1XZgh+OefUne6uhVrBExhAdQr+Ag89oUs2KZ
	FToYSRQA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rXmu0-0000000BVm5-2PLm;
	Wed, 07 Feb 2024 18:44:08 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rXmtv-0000000BVi1-3MRM
	for linux-nvme@lists.infradead.org;
	Wed, 07 Feb 2024 18:44:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707331442;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cuv9rvzEed+0pQINLR4eZlmzvTUXMYlIRXYRIOt5NJQ=;
	b=aD3bHuwQ1HneLIZ0qwmrkJFtv2WagvtA2GpVC6MAngj7CijGJHvpUJCPn4IwVYhzWaY3Sk
	Ym1HiMRn14PWUJ02CB6kCySh+EJyFU5kr75nMzf5VKJ/gyTtcAnm/juffJe/JZhfo9KlcY
	UwDE+QCeBWZ53ZY3g4n5ZFW+49ba1Oo=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-664-s5caMUuGOx6vwEyw6XmQ_A-1; Wed,
 07 Feb 2024 13:42:25 -0500
X-MC-Unique: s5caMUuGOx6vwEyw6XmQ_A-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1A62D29AC012;
	Wed,  7 Feb 2024 18:42:25 +0000 (UTC)
Received: from fedora-work.redhat.com (unknown [10.22.32.236])
	by smtp.corp.redhat.com (Postfix) with ESMTP id A15F140C9444;
	Wed,  7 Feb 2024 18:42:24 +0000 (UTC)
From: David Jeffery <djeffery@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-nvme@lists.infradead.org,
	linux-scsi@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	David Jeffery <djeffery@redhat.com>,
	Laurence Oberman <loberman@redhat.com>
Subject: [RFC PATCH 4/6] pci nvme async shutdown support
Date: Wed,  7 Feb 2024 13:40:58 -0500
Message-ID: <20240207184100.18066-5-djeffery@redhat.com>
In-Reply-To: <20240207184100.18066-1-djeffery@redhat.com>
References: <20240207184100.18066-1-djeffery@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240207_104404_085330_8E12C925 
X-CRM114-Status: GOOD (  20.49  )
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

Alter nvme so that the pci nvme driver may shut down the hardware
asynchronously, providing a large benefit to shutdown time with large numbers
of nvme devices in some configurations.

The functionality of nvme_disable_ctrl is split in separate functions for
starting disabling the hardware and for waiting for the hardware to report
success. A wrapper is created which provides the same interface for the
other nvme types so they remain unchanged.

And new field is added to nvme-pci's nvme_dev to track the nvme shutdown
state so that the nvme async_shutdown_end call knows what if anything it
still needs to do.

Signed-off-by: David Jeffery <djeffery@redhat.com>
Tested-by:     Laurence Oberman <loberman@redhat.com>

---
 drivers/nvme/host/core.c | 26 +++++++++++++++-----
 drivers/nvme/host/nvme.h |  2 ++
 drivers/nvme/host/pci.c  | 53 ++++++++++++++++++++++++++++++++++++++--
 3 files changed, 73 insertions(+), 8 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 85ab0fcf9e88..b24985a843a8 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2242,20 +2242,21 @@ static int nvme_wait_ready(struct nvme_ctrl *ctrl, u32 mask, u32 val,
 	return ret;
 }
 
-int nvme_disable_ctrl(struct nvme_ctrl *ctrl, bool shutdown)
+int nvme_disable_ctrl_send(struct nvme_ctrl *ctrl, bool shutdown)
 {
-	int ret;
-
 	ctrl->ctrl_config &= ~NVME_CC_SHN_MASK;
 	if (shutdown)
 		ctrl->ctrl_config |= NVME_CC_SHN_NORMAL;
 	else
 		ctrl->ctrl_config &= ~NVME_CC_ENABLE;
 
-	ret = ctrl->ops->reg_write32(ctrl, NVME_REG_CC, ctrl->ctrl_config);
-	if (ret)
-		return ret;
+	return ctrl->ops->reg_write32(ctrl, NVME_REG_CC, ctrl->ctrl_config);
+}
+EXPORT_SYMBOL_GPL(nvme_disable_ctrl_send);
 
+
+int nvme_disable_ctrl_wait(struct nvme_ctrl *ctrl, bool shutdown)
+{
 	if (shutdown) {
 		return nvme_wait_ready(ctrl, NVME_CSTS_SHST_MASK,
 				       NVME_CSTS_SHST_CMPLT,
@@ -2266,6 +2267,19 @@ int nvme_disable_ctrl(struct nvme_ctrl *ctrl, bool shutdown)
 	return nvme_wait_ready(ctrl, NVME_CSTS_RDY, 0,
 			       (NVME_CAP_TIMEOUT(ctrl->cap) + 1) / 2, "reset");
 }
+EXPORT_SYMBOL_GPL(nvme_disable_ctrl_wait);
+
+
+int nvme_disable_ctrl(struct nvme_ctrl *ctrl, bool shutdown)
+{
+	int ret;
+
+	ret = nvme_disable_ctrl_send(ctrl, shutdown);
+	if (!ret)
+		ret = nvme_disable_ctrl_wait(ctrl, shutdown);
+
+	return ret;
+}
 EXPORT_SYMBOL_GPL(nvme_disable_ctrl);
 
 int nvme_enable_ctrl(struct nvme_ctrl *ctrl)
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 030c80818240..5bdd862328d4 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -761,6 +761,8 @@ void nvme_cancel_admin_tagset(struct nvme_ctrl *ctrl);
 bool nvme_change_ctrl_state(struct nvme_ctrl *ctrl,
 		enum nvme_ctrl_state new_state);
 int nvme_disable_ctrl(struct nvme_ctrl *ctrl, bool shutdown);
+int nvme_disable_ctrl_send(struct nvme_ctrl *ctrl, bool shutdown);
+int nvme_disable_ctrl_wait(struct nvme_ctrl *ctrl, bool shutdown);
 int nvme_enable_ctrl(struct nvme_ctrl *ctrl);
 int nvme_init_ctrl(struct nvme_ctrl *ctrl, struct device *dev,
 		const struct nvme_ctrl_ops *ops, unsigned long quirks);
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index c1d6357ec98a..c2a7b3d28a56 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -112,6 +112,12 @@ static void nvme_dev_disable(struct nvme_dev *dev, bool shutdown);
 static void nvme_delete_io_queues(struct nvme_dev *dev);
 static void nvme_update_attrs(struct nvme_dev *dev);
 
+enum nvme_disable_state {
+	NVME_DISABLE_START = 0,
+	NVME_DISABLE_WAIT = 1,
+	NVME_DISABLE_DONE = 2,
+};
+
 /*
  * Represents an NVM Express device.  Each nvme_dev is a PCI function.
  */
@@ -159,6 +165,7 @@ struct nvme_dev {
 	unsigned int nr_allocated_queues;
 	unsigned int nr_write_queues;
 	unsigned int nr_poll_queues;
+	enum nvme_disable_state disable_state;
 };
 
 static int io_queue_depth_set(const char *val, const struct kernel_param *kp)
@@ -2574,12 +2581,14 @@ static bool nvme_pci_ctrl_is_dead(struct nvme_dev *dev)
 	return (csts & NVME_CSTS_CFS) || !(csts & NVME_CSTS_RDY);
 }
 
-static void nvme_dev_disable(struct nvme_dev *dev, bool shutdown)
+static void nvme_dev_disable_start(struct nvme_dev *dev, bool shutdown)
 {
 	enum nvme_ctrl_state state = nvme_ctrl_state(&dev->ctrl);
 	struct pci_dev *pdev = to_pci_dev(dev->dev);
 	bool dead;
 
+	dev->disable_state = NVME_DISABLE_START;
+
 	mutex_lock(&dev->shutdown_lock);
 	dead = nvme_pci_ctrl_is_dead(dev);
 	if (state == NVME_CTRL_LIVE || state == NVME_CTRL_RESETTING) {
@@ -2597,7 +2606,20 @@ static void nvme_dev_disable(struct nvme_dev *dev, bool shutdown)
 
 	if (!dead && dev->ctrl.queue_count > 0) {
 		nvme_delete_io_queues(dev);
-		nvme_disable_ctrl(&dev->ctrl, shutdown);
+		nvme_disable_ctrl_send(&dev->ctrl, shutdown);
+		dev->disable_state = NVME_DISABLE_WAIT;
+	}
+}
+
+static void nvme_dev_disable_end(struct nvme_dev *dev, bool shutdown)
+{
+	struct pci_dev *pdev = to_pci_dev(dev->dev);
+
+	if (dev->disable_state == NVME_DISABLE_DONE)
+		return;
+
+	if (dev->disable_state == NVME_DISABLE_WAIT) {
+		nvme_disable_ctrl_wait(&dev->ctrl, shutdown);
 		nvme_poll_irqdisable(&dev->queues[0]);
 	}
 	nvme_suspend_io_queues(dev);
@@ -2623,6 +2645,12 @@ static void nvme_dev_disable(struct nvme_dev *dev, bool shutdown)
 	mutex_unlock(&dev->shutdown_lock);
 }
 
+static void nvme_dev_disable(struct nvme_dev *dev, bool shutdown)
+{
+	nvme_dev_disable_start(dev, shutdown);
+	nvme_dev_disable_end(dev, shutdown);
+}
+
 static int nvme_disable_prepare_reset(struct nvme_dev *dev, bool shutdown)
 {
 	if (!nvme_wait_reset(&dev->ctrl))
@@ -3120,6 +3148,25 @@ static void nvme_shutdown(struct pci_dev *pdev)
 	nvme_disable_prepare_reset(dev, true);
 }
 
+static void nvme_shutdown_start(struct pci_dev *pdev)
+{
+	struct nvme_dev *dev = pci_get_drvdata(pdev);
+
+        if (!nvme_wait_reset(&dev->ctrl)) {
+		dev->disable_state = NVME_DISABLE_DONE;
+                return;
+	}
+        nvme_dev_disable_start(dev, true);
+}
+
+static void nvme_shutdown_end(struct pci_dev *pdev)
+{
+	struct nvme_dev *dev = pci_get_drvdata(pdev);
+
+	nvme_dev_disable_end(dev, true);
+}
+
+
 /*
  * The driver's remove may be called on a device in a partially initialized
  * state. This function must not have any dependencies on the device state in
@@ -3511,6 +3558,8 @@ static struct pci_driver nvme_driver = {
 	.probe		= nvme_probe,
 	.remove		= nvme_remove,
 	.shutdown	= nvme_shutdown,
+	.async_shutdown_start 	= nvme_shutdown_start,
+	.async_shutdown_end 	= nvme_shutdown_end,
 	.driver		= {
 		.probe_type	= PROBE_PREFER_ASYNCHRONOUS,
 #ifdef CONFIG_PM_SLEEP
-- 
2.43.0


