Return-Path: <SRS0=HgRT=5J=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87970C2BAEE
	for <linux-nvme@archiver.kernel.org>; Tue, 24 Mar 2020 15:31:10 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 430C120774
	for <linux-nvme@archiver.kernel.org>; Tue, 24 Mar 2020 15:31:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="A1ppstZY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 430C120774
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=nMeQlwN7AqkFnNf0TqmbvKi//lsbniCXixYRxcofTfA=; b=A1ppstZYCBkqpE3DtvvUAik97u
	TMnic4Q4E7oEL/nM6s2UN72IzbIJs5YSWXJuGAu5J7rMTHVXuEvIMcPv6vaABD4iWbL+aug1ECee1
	80xfNPznJZ+aghh90abu2kaXyRayKqn5bhEbwM7n2cb9WbLWDW0a8fK87eHyg9lt3EB7Ll4rIdjk7
	DmrE6CfAr+0TrQPXylvk8NCPbbNi5BUdLR1WppiWRPUXTk/qH+coOwLy3a0QrGS/YOFKh+lLf9ZvT
	QuVCc+0P+t3eu+NeQx8wuqqMjQThoN5/0kan2drJHR9vlNLzZJc257hkzdoq78W9Opr7vWUg9Xwyc
	HK8Pea6w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jGlWE-0005oS-D4; Tue, 24 Mar 2020 15:31:06 +0000
Received: from mail-il-dmz.mellanox.com ([193.47.165.129] helo=mellanox.co.il)
 by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jGlV6-0003iu-Cc
 for linux-nvme@lists.infradead.org; Tue, 24 Mar 2020 15:29:59 +0000
Received: from Internal Mail-Server by MTLPINE2 (envelope-from
 israelr@mellanox.com)
 with ESMTPS (AES256-SHA encrypted); 24 Mar 2020 17:29:47 +0200
Received: from rsws50.mtr.labs.mlnx (rsws50.mtr.labs.mlnx [10.209.40.61])
 by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id 02OFTkEN013985;
 Tue, 24 Mar 2020 17:29:47 +0200
From: Israel Rukshin <israelr@mellanox.com>
To: Linux-nvme <linux-nvme@lists.infradead.org>,
 Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>
Subject: [PATCH 3/7] nvme: Fix ctrl use-after-free during sysfs deletion
Date: Tue, 24 Mar 2020 17:29:41 +0200
Message-Id: <1585063785-14268-4-git-send-email-israelr@mellanox.com>
X-Mailer: git-send-email 1.8.4.3
In-Reply-To: <1585063785-14268-1-git-send-email-israelr@mellanox.com>
References: <1585063785-14268-1-git-send-email-israelr@mellanox.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200324_082956_840169_B4895AE0 
X-CRM114-Status: GOOD (  11.05  )
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
 drivers/nvme/host/core.c   | 2 ++
 drivers/nvme/host/fc.c     | 4 +---
 drivers/nvme/host/pci.c    | 1 -
 drivers/nvme/host/rdma.c   | 3 +--
 drivers/nvme/host/tcp.c    | 3 +--
 drivers/nvme/target/loop.c | 3 +--
 6 files changed, 6 insertions(+), 10 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index a461220..5ccbcac 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
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
index 5a70ac3..59d2e2b 100644
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
@@ -3209,6 +3206,7 @@ enum {
 
 	/* initiate nvme ctrl ref counting teardown */
 	nvme_uninit_ctrl(&ctrl->ctrl);
+	nvme_put_ctrl(&ctrl->ctrl);
 
 	/* Remove core ctrl ref. */
 	nvme_put_ctrl(&ctrl->ctrl);
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index ff0bd2d..4e062c3 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2802,7 +2802,6 @@ static int nvme_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	dev_info(dev->ctrl.device, "pci function %s\n", dev_name(&pdev->dev));
 
 	nvme_reset_ctrl(&dev->ctrl);
-	nvme_get_ctrl(&dev->ctrl);
 	async_schedule(nvme_async_probe, dev);
 
 	return 0;
diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 3e85c5c..ca782de 100644
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
@@ -2054,6 +2052,7 @@ static struct nvme_ctrl *nvme_rdma_create_ctrl(struct device *dev,
 out_uninit_ctrl:
 	nvme_uninit_ctrl(&ctrl->ctrl);
 	nvme_put_ctrl(&ctrl->ctrl);
+	nvme_put_ctrl(&ctrl->ctrl);
 	if (ret > 0)
 		ret = -EIO;
 	return ERR_PTR(ret);
diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 814ea23..202f08e2 100644
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
@@ -2440,6 +2438,7 @@ static struct nvme_ctrl *nvme_tcp_create_ctrl(struct device *dev,
 out_uninit_ctrl:
 	nvme_uninit_ctrl(&ctrl->ctrl);
 	nvme_put_ctrl(&ctrl->ctrl);
+	nvme_put_ctrl(&ctrl->ctrl);
 	if (ret > 0)
 		ret = -EIO;
 	return ERR_PTR(ret);
diff --git a/drivers/nvme/target/loop.c b/drivers/nvme/target/loop.c
index 4df4ebd..a425e28 100644
--- a/drivers/nvme/target/loop.c
+++ b/drivers/nvme/target/loop.c
@@ -618,8 +618,6 @@ static struct nvme_ctrl *nvme_loop_create_ctrl(struct device *dev,
 	dev_info(ctrl->ctrl.device,
 		 "new ctrl: \"%s\"\n", ctrl->ctrl.opts->subsysnqn);
 
-	nvme_get_ctrl(&ctrl->ctrl);
-
 	changed = nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_LIVE);
 	WARN_ON_ONCE(!changed);
 
@@ -637,6 +635,7 @@ static struct nvme_ctrl *nvme_loop_create_ctrl(struct device *dev,
 	kfree(ctrl->queues);
 out_uninit_ctrl:
 	nvme_uninit_ctrl(&ctrl->ctrl);
+	nvme_put_ctrl(&ctrl->ctrl);
 out_put_ctrl:
 	nvme_put_ctrl(&ctrl->ctrl);
 	if (ret > 0)
-- 
1.8.3.1


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
