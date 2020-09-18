Return-Path: <SRS0=7z9d=C3=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF546C43464
	for <linux-nvme@archiver.kernel.org>; Fri, 18 Sep 2020 02:13:11 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5EBBB2376E
	for <linux-nvme@archiver.kernel.org>; Fri, 18 Sep 2020 02:13:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="m48iSLXF";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="SCXz3Nm3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5EBBB2376E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=LOvokBZ2rzrB57PhpopOQ6XS3PLKQ+4m0/4Zwv06Qrk=; b=m48iSLXFOGIaCSX4GSCY0bluq
	4WerR/uQK4Z6nMDViGdGWFmdwC2jmC1LBHxQe7m4/wwsSPjon6CVnt7BqbwK8Cr5bxzpJVpMx/AC4
	3juXP6MZKc6HQ3NT2E4lQ5aG95erPKQaqWQzaQeHsopYibKAl+hgg23GzNXIlvA5l5kA2bE2+f440
	Y0ADzP/w+20wFqrbksePIMucYXe518EjV4wQpVxvH1G67I4/skQFFRzx5zJkpDgrw+V5a32KhGaoS
	Zpxm9ZrtUOljvnNm2b8NsNDfC1UnIQqkVeX0mWcWZb1/s2tOiPGHbwnrKEBSuyHaJtMDMAd4Lj+1z
	XuBDdFsdQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kJ5tX-0007la-QK; Fri, 18 Sep 2020 02:13:03 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kJ5m8-0003fn-DF
 for linux-nvme@lists.infradead.org; Fri, 18 Sep 2020 02:05:25 +0000
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net
 [73.47.72.35])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 308DB23888;
 Fri, 18 Sep 2020 02:05:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1600394723;
 bh=/5hK43isotfnzUd1geZyNOm4YM4YV8hpg64VSlWeQYo=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=SCXz3Nm3LmlfxZY+5B4dn48BJrLL2yFXvSupngmQ/aICNzZSYpvSgkHsyRJxnxO7I
 VtHykKdX1IUjBFhu2+rNnq0zjQHJ4EkJ63v6+g9H48Dusz6QDVB+C6ySNUHkju9g//
 2s6nNsHVUzkH9g2Pl4lZtrefjVeIBYHMsefVWAcg=
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 206/330] nvme: Fix ctrl use-after-free during
 sysfs deletion
Date: Thu, 17 Sep 2020 21:59:06 -0400
Message-Id: <20200918020110.2063155-206-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200918020110.2063155-1-sashal@kernel.org>
References: <20200918020110.2063155-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200917_220524_624481_7AB00BF9 
X-CRM114-Status: GOOD (  17.19  )
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
Cc: Sasha Levin <sashal@kernel.org>, Israel Rukshin <israelr@mellanox.com>,
 linux-nvme@lists.infradead.org, Keith Busch <kbusch@kernel.org>,
 Max Gurtovoy <maxg@mellanox.com>, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

From: Israel Rukshin <israelr@mellanox.com>

[ Upstream commit b780d7415aacec855e2f2370cbf98f918b224903 ]

In case nvme_sysfs_delete() is called by the user before taking the ctrl
reference count, the ctrl may be freed during the creation and cause the
bug. Take the reference as soon as the controller is externally visible,
which is done by cdev_device_add() in nvme_init_ctrl(). Also take the
reference count at the core layer instead of taking it on each transport
separately.

Signed-off-by: Israel Rukshin <israelr@mellanox.com>
Reviewed-by: Max Gurtovoy <maxg@mellanox.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/core.c   | 2 ++
 drivers/nvme/host/fc.c     | 4 +---
 drivers/nvme/host/pci.c    | 1 -
 drivers/nvme/host/rdma.c   | 3 +--
 drivers/nvme/host/tcp.c    | 3 +--
 drivers/nvme/target/loop.c | 3 +--
 6 files changed, 6 insertions(+), 10 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 05688fa579e81..e51cc83969034 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -4082,6 +4082,7 @@ int nvme_init_ctrl(struct nvme_ctrl *ctrl, struct device *dev,
 	if (ret)
 		goto out_release_instance;
 
+	nvme_get_ctrl(ctrl);
 	cdev_init(&ctrl->cdev, &nvme_dev_fops);
 	ctrl->cdev.owner = ops->module;
 	ret = cdev_device_add(&ctrl->cdev, ctrl->device);
@@ -4100,6 +4101,7 @@ int nvme_init_ctrl(struct nvme_ctrl *ctrl, struct device *dev,
 
 	return 0;
 out_free_name:
+	nvme_put_ctrl(ctrl);
 	kfree_const(ctrl->device->kobj.name);
 out_release_instance:
 	ida_simple_remove(&nvme_instance_ida, ctrl->instance);
diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index dce4d6782ceb1..e5b5ded422b33 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -3170,10 +3170,7 @@ nvme_fc_init_ctrl(struct device *dev, struct nvmf_ctrl_options *opts,
 		goto fail_ctrl;
 	}
 
-	nvme_get_ctrl(&ctrl->ctrl);
-
 	if (!queue_delayed_work(nvme_wq, &ctrl->connect_work, 0)) {
-		nvme_put_ctrl(&ctrl->ctrl);
 		dev_err(ctrl->ctrl.device,
 			"NVME-FC{%d}: failed to schedule initial connect\n",
 			ctrl->cnum);
@@ -3198,6 +3195,7 @@ fail_ctrl:
 
 	/* initiate nvme ctrl ref counting teardown */
 	nvme_uninit_ctrl(&ctrl->ctrl);
+	nvme_put_ctrl(&ctrl->ctrl);
 
 	/* Remove core ctrl ref. */
 	nvme_put_ctrl(&ctrl->ctrl);
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 100da11ce98cb..f6c35c135764c 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2850,7 +2850,6 @@ static int nvme_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	dev_info(dev->ctrl.device, "pci function %s\n", dev_name(&pdev->dev));
 
 	nvme_reset_ctrl(&dev->ctrl);
-	nvme_get_ctrl(&dev->ctrl);
 	async_schedule(nvme_async_probe, dev);
 
 	return 0;
diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index d0336545e1fe0..0bf79bf9d708f 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -2053,8 +2053,6 @@ static struct nvme_ctrl *nvme_rdma_create_ctrl(struct device *dev,
 	dev_info(ctrl->ctrl.device, "new ctrl: NQN \"%s\", addr %pISpcs\n",
 		ctrl->ctrl.opts->subsysnqn, &ctrl->addr);
 
-	nvme_get_ctrl(&ctrl->ctrl);
-
 	mutex_lock(&nvme_rdma_ctrl_mutex);
 	list_add_tail(&ctrl->list, &nvme_rdma_ctrl_list);
 	mutex_unlock(&nvme_rdma_ctrl_mutex);
@@ -2064,6 +2062,7 @@ static struct nvme_ctrl *nvme_rdma_create_ctrl(struct device *dev,
 out_uninit_ctrl:
 	nvme_uninit_ctrl(&ctrl->ctrl);
 	nvme_put_ctrl(&ctrl->ctrl);
+	nvme_put_ctrl(&ctrl->ctrl);
 	if (ret > 0)
 		ret = -EIO;
 	return ERR_PTR(ret);
diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 0166ff0e4738e..187122129a1da 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -2369,8 +2369,6 @@ static struct nvme_ctrl *nvme_tcp_create_ctrl(struct device *dev,
 	dev_info(ctrl->ctrl.device, "new ctrl: NQN \"%s\", addr %pISp\n",
 		ctrl->ctrl.opts->subsysnqn, &ctrl->addr);
 
-	nvme_get_ctrl(&ctrl->ctrl);
-
 	mutex_lock(&nvme_tcp_ctrl_mutex);
 	list_add_tail(&ctrl->list, &nvme_tcp_ctrl_list);
 	mutex_unlock(&nvme_tcp_ctrl_mutex);
@@ -2380,6 +2378,7 @@ static struct nvme_ctrl *nvme_tcp_create_ctrl(struct device *dev,
 out_uninit_ctrl:
 	nvme_uninit_ctrl(&ctrl->ctrl);
 	nvme_put_ctrl(&ctrl->ctrl);
+	nvme_put_ctrl(&ctrl->ctrl);
 	if (ret > 0)
 		ret = -EIO;
 	return ERR_PTR(ret);
diff --git a/drivers/nvme/target/loop.c b/drivers/nvme/target/loop.c
index 11f5aea97d1b1..82b87a4c50f63 100644
--- a/drivers/nvme/target/loop.c
+++ b/drivers/nvme/target/loop.c
@@ -619,8 +619,6 @@ static struct nvme_ctrl *nvme_loop_create_ctrl(struct device *dev,
 	dev_info(ctrl->ctrl.device,
 		 "new ctrl: \"%s\"\n", ctrl->ctrl.opts->subsysnqn);
 
-	nvme_get_ctrl(&ctrl->ctrl);
-
 	changed = nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_LIVE);
 	WARN_ON_ONCE(!changed);
 
@@ -638,6 +636,7 @@ out_free_queues:
 	kfree(ctrl->queues);
 out_uninit_ctrl:
 	nvme_uninit_ctrl(&ctrl->ctrl);
+	nvme_put_ctrl(&ctrl->ctrl);
 out_put_ctrl:
 	nvme_put_ctrl(&ctrl->ctrl);
 	if (ret > 0)
-- 
2.25.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
