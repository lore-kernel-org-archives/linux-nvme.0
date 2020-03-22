Return-Path: <SRS0=x4Ox=5H=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94330C4332B
	for <linux-nvme@archiver.kernel.org>; Sun, 22 Mar 2020 18:01:19 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D0012072E
	for <linux-nvme@archiver.kernel.org>; Sun, 22 Mar 2020 18:01:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="kqurmu0y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D0012072E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=AaiChhTltrK4UrKCluWMwCvB3mXi+nSnKAIkPLBqdVc=; b=kqurmu0yRciGfCOFKGtfqlVJNk
	0PJsdcZxBitin0CsAvMB4yWjCoPNXYBeIYQp6tysVvVkMA5gO1mJXwzLX2PbrieGJIJGGYp2zmoQe
	sasM7sfRP8+MMEYs0xiVZtGHLY5cM56FXTZ8ln6dLMP7wM7w4HqrkR/8eWdYGVimxPiKt5D1wCYjA
	P5FcK+/QLYVZ1/fzfGnpO/FgXCr60vldXcLnyFw9o/IxMqFNweOmLG2ZFYr5cagVigG+biDzJ6K2Q
	u3xzP/qAGeIaP1ryMFWFFfFKHtQnZChzVuZXqJJPjrvDVEyU/Wn/3WsEeS7xyPY6NEl8QVxcXnE48
	F86PjBjQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jG4uR-0008Vd-CC; Sun, 22 Mar 2020 18:01:15 +0000
Received: from mail-il-dmz.mellanox.com ([193.47.165.129] helo=mellanox.co.il)
 by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jG4tK-0006Z6-4M
 for linux-nvme@lists.infradead.org; Sun, 22 Mar 2020 18:00:11 +0000
Received: from Internal Mail-Server by MTLPINE1 (envelope-from
 israelr@mellanox.com)
 with ESMTPS (AES256-SHA encrypted); 22 Mar 2020 19:59:57 +0200
Received: from rsws50.mtr.labs.mlnx (rsws50.mtr.labs.mlnx [10.209.40.61])
 by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id 02MHxvSC004810;
 Sun, 22 Mar 2020 19:59:57 +0200
From: Israel Rukshin <israelr@mellanox.com>
To: Linux-nvme <linux-nvme@lists.infradead.org>,
 Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>
Subject: [PATCH 3/6] nvme: Fix ctrl use-after-free during sysfs deletion
Date: Sun, 22 Mar 2020 19:59:46 +0200
Message-Id: <1584899989-14623-4-git-send-email-israelr@mellanox.com>
X-Mailer: git-send-email 1.8.4.3
In-Reply-To: <1584899989-14623-1-git-send-email-israelr@mellanox.com>
References: <1584899989-14623-1-git-send-email-israelr@mellanox.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200322_110006_591533_E8FE84E6 
X-CRM114-Status: GOOD (  11.32  )
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
Cc: Shlomi Nimrodi <shlomin@mellanox.com>,
 Israel Rukshin <israelr@mellanox.com>, Max Gurtovoy <maxg@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

In case nvme_sysfs_delete() is called by the user before taking the ctrl
reference count, the ctrl may be freed during the creation and cause the
bug. Take the reference as soon as the controller is externally visible,
which is done by cdev_device_add() in nvme_init_ctrl(). Also take the
reference count at the core layer instead of taking it on each transport
separately.

Signed-off-by: Israel Rukshin <israelr@mellanox.com>
Reviewed-by: Max Gurtovoy <maxg@mellanox.com>
---
 drivers/nvme/host/core.c   | 4 +++-
 drivers/nvme/host/fc.c     | 3 ---
 drivers/nvme/host/pci.c    | 2 --
 drivers/nvme/host/rdma.c   | 2 --
 drivers/nvme/host/tcp.c    | 2 --
 drivers/nvme/target/loop.c | 3 ---
 6 files changed, 3 insertions(+), 13 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index a461220..ba064fd 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -171,7 +171,6 @@ static void nvme_do_delete_ctrl(struct nvme_ctrl *ctrl)
 	nvme_remove_namespaces(ctrl);
 	ctrl->ops->delete_ctrl(ctrl);
 	nvme_uninit_ctrl(ctrl);
-	nvme_put_ctrl(ctrl);
 }
 
 static void nvme_delete_ctrl_work(struct work_struct *work)
@@ -4048,6 +4047,7 @@ void nvme_uninit_ctrl(struct nvme_ctrl *ctrl)
 	nvme_fault_inject_fini(&ctrl->fault_inject);
 	dev_pm_qos_hide_latency_tolerance(ctrl->device);
 	cdev_device_del(&ctrl->cdev, ctrl->device);
+	nvme_put_ctrl(ctrl);
 }
 EXPORT_SYMBOL_GPL(nvme_uninit_ctrl);
 
@@ -4130,6 +4130,7 @@ int nvme_init_ctrl(struct nvme_ctrl *ctrl, struct device *dev,
 	if (ret)
 		goto out_release_instance;
 
+	nvme_get_ctrl(ctrl);
 	cdev_init(&ctrl->cdev, &nvme_dev_fops);
 	ctrl->cdev.owner = ops->module;
 	ret = cdev_device_add(&ctrl->cdev, ctrl->device);
@@ -4148,6 +4149,7 @@ int nvme_init_ctrl(struct nvme_ctrl *ctrl, struct device *dev,
 
 	return 0;
 out_free_name:
+	nvme_put_ctrl(ctrl);
 	kfree_const(ctrl->device->kobj.name);
 out_release_instance:
 	ida_simple_remove(&nvme_instance_ida, ctrl->instance);
diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index 5a70ac3..a8bf2fb 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -3181,10 +3181,7 @@ enum {
 		goto fail_ctrl;
 	}
 
-	nvme_get_ctrl(&ctrl->ctrl);
-
 	if (!queue_delayed_work(nvme_wq, &ctrl->connect_work, 0)) {
-		nvme_put_ctrl(&ctrl->ctrl);
 		dev_err(ctrl->ctrl.device,
 			"NVME-FC{%d}: failed to schedule initial connect\n",
 			ctrl->cnum);
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index eb65b3b..334491b 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2804,7 +2804,6 @@ static int nvme_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	dev_info(dev->ctrl.device, "pci function %s\n", dev_name(&pdev->dev));
 
 	nvme_reset_ctrl(&dev->ctrl);
-	nvme_get_ctrl(&dev->ctrl);
 	async_schedule(nvme_async_probe, dev);
 
 	return 0;
@@ -2877,7 +2876,6 @@ static void nvme_remove(struct pci_dev *pdev)
 	nvme_dev_remove_admin(dev);
 	nvme_free_queues(dev, 0);
 	nvme_uninit_ctrl(&dev->ctrl);
-	nvme_put_ctrl(&dev->ctrl);
 }
 
 #ifdef CONFIG_PM_SLEEP
diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 3e85c5c..c99a882 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -2043,8 +2043,6 @@ static struct nvme_ctrl *nvme_rdma_create_ctrl(struct device *dev,
 	dev_info(ctrl->ctrl.device, "new ctrl: NQN \"%s\", addr %pISpcs\n",
 		ctrl->ctrl.opts->subsysnqn, &ctrl->addr);
 
-	nvme_get_ctrl(&ctrl->ctrl);
-
 	mutex_lock(&nvme_rdma_ctrl_mutex);
 	list_add_tail(&ctrl->list, &nvme_rdma_ctrl_list);
 	mutex_unlock(&nvme_rdma_ctrl_mutex);
diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 814ea23..2fc2687 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -2429,8 +2429,6 @@ static struct nvme_ctrl *nvme_tcp_create_ctrl(struct device *dev,
 	dev_info(ctrl->ctrl.device, "new ctrl: NQN \"%s\", addr %pISp\n",
 		ctrl->ctrl.opts->subsysnqn, &ctrl->addr);
 
-	nvme_get_ctrl(&ctrl->ctrl);
-
 	mutex_lock(&nvme_tcp_ctrl_mutex);
 	list_add_tail(&ctrl->list, &nvme_tcp_ctrl_list);
 	mutex_unlock(&nvme_tcp_ctrl_mutex);
diff --git a/drivers/nvme/target/loop.c b/drivers/nvme/target/loop.c
index 4df4ebd..0d54e73 100644
--- a/drivers/nvme/target/loop.c
+++ b/drivers/nvme/target/loop.c
@@ -485,7 +485,6 @@ static void nvme_loop_reset_ctrl_work(struct work_struct *work)
 out_disable:
 	dev_warn(ctrl->ctrl.device, "Removing after reset failure\n");
 	nvme_uninit_ctrl(&ctrl->ctrl);
-	nvme_put_ctrl(&ctrl->ctrl);
 }
 
 static const struct nvme_ctrl_ops nvme_loop_ctrl_ops = {
@@ -618,8 +617,6 @@ static struct nvme_ctrl *nvme_loop_create_ctrl(struct device *dev,
 	dev_info(ctrl->ctrl.device,
 		 "new ctrl: \"%s\"\n", ctrl->ctrl.opts->subsysnqn);
 
-	nvme_get_ctrl(&ctrl->ctrl);
-
 	changed = nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_LIVE);
 	WARN_ON_ONCE(!changed);
 
-- 
1.8.3.1


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
