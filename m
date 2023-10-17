Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 628C0CDB474
	for <linux-nvme@archiver.kernel.org>; Tue, 17 Oct 2023 13:46:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=llBO4VJkGXQj8hOL1bcGabqgVmJeQ9Y3aXqlLxmu0rM=; b=lgPhWPXdX79AFMNrbU5/WsAmqa
	BEpGtp0R51wficmVnhWfUUr9uD6Gm9Ok8WXX/CarMFcPnfVfljAsWbCsF+BKCrJzpdIOrUfBMyLii
	tBRqHx70Q1gMIk7zzWtwYH84Q+4jHTLSvnN62ke1id+jXGS2LTAiUXXIAz7scLCKalL+HpW+sdTC/
	Eb9xy+pJWqFIv7KQbhQXRlDdERHs0afHYcomFZw8pzLbXAFMQHrSVvikGfC3wGjNNkNaUOoF/HKB7
	8X04mfIwOL7tSu2wX5OeTu7NYqqQJdU4q1YAy6CcGoeIjZdnPxKWlBSRymniA17YlUnyj4pSWeBIK
	zEtOSTdw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qskOT-00CS9r-11;
	Tue, 17 Oct 2023 13:45:57 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qskOQ-00CS8j-0h
	for linux-nvme@lists.infradead.org;
	Tue, 17 Oct 2023 13:45:55 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
	by smtp-out1.suse.de (Postfix) with ESMTP id E728B21D0B;
	Tue, 17 Oct 2023 13:45:38 +0000 (UTC)
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
	by relay2.suse.de (Postfix) with ESMTP id B01852D433;
	Tue, 17 Oct 2023 13:45:38 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
	id CD79051EBEB4; Tue, 17 Oct 2023 15:45:38 +0200 (CEST)
From: Hannes Reinecke <hare@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH] nvme: start keep-alive after admin queue setup
Date: Tue, 17 Oct 2023 15:45:35 +0200
Message-Id: <20231017134535.137780-1-hare@suse.de>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: ++
Authentication-Results: smtp-out1.suse.de;
	dkim=none;
	dmarc=none;
	spf=softfail (smtp-out1.suse.de: 149.44.160.134 is neither permitted nor denied by domain of hare@suse.de) smtp.mailfrom=hare@suse.de
X-Rspamd-Server: rspamd2
X-Spamd-Result: default: False [2.49 / 50.00];
	 ARC_NA(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 NEURAL_HAM_LONG(-3.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 DMARC_NA(0.20)[suse.de];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 R_SPF_SOFTFAIL(0.60)[~all:c];
	 RCPT_COUNT_FIVE(0.00)[5];
	 TO_MATCH_ENVRCPT_SOME(0.00)[];
	 VIOLATED_DIRECT_SPF(3.50)[];
	 MX_GOOD(-0.01)[];
	 NEURAL_HAM_SHORT(-1.00)[-1.000];
	 MID_CONTAINS_FROM(1.00)[];
	 RWL_MAILSPIKE_GOOD(0.00)[149.44.160.134:from];
	 RCVD_NO_TLS_LAST(0.10)[];
	 FROM_EQ_ENVFROM(0.00)[];
	 R_DKIM_NA(0.20)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_COUNT_TWO(0.00)[2];
	 BAYES_HAM(-3.00)[100.00%]
X-Rspamd-Queue-Id: E728B21D0B
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231017_064554_432202_805FFED2 
X-CRM114-Status: GOOD (  11.83  )
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

Setting up I/O queues might take quite some time on larger and/or
busy setups, so KATO might expire before all I/O queues could be
set up.
Fix this by starting keep-alive right after the admin queue is
operational.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/nvme/host/apple.c  |  4 +++-
 drivers/nvme/host/core.c   |  4 ++--
 drivers/nvme/host/fc.c     |  1 +
 drivers/nvme/host/pci.c    | 18 +++++++++++-------
 drivers/nvme/host/rdma.c   |  1 +
 drivers/nvme/host/tcp.c    |  1 +
 drivers/nvme/target/loop.c |  1 +
 7 files changed, 20 insertions(+), 10 deletions(-)

diff --git a/drivers/nvme/host/apple.c b/drivers/nvme/host/apple.c
index 596bb11eeba5..a434eb2a7129 100644
--- a/drivers/nvme/host/apple.c
+++ b/drivers/nvme/host/apple.c
@@ -1123,7 +1123,7 @@ static void apple_nvme_reset_work(struct work_struct *work)
 	dev_dbg(anv->dev, "Creating IOCQ");
 	ret = apple_nvme_create_cq(anv);
 	if (ret)
-		goto out;
+		goto out_stop;
 	dev_dbg(anv->dev, "Creating IOSQ");
 	ret = apple_nvme_create_sq(anv);
 	if (ret)
@@ -1162,6 +1162,8 @@ static void apple_nvme_reset_work(struct work_struct *work)
 	apple_nvme_remove_sq(anv);
 out_remove_cq:
 	apple_nvme_remove_cq(anv);
+ out_stop:
+	nvme_stop_keep_alive(&anv->ctrl);
 out:
 	dev_warn(anv->ctrl.device, "Reset failure status: %d\n", ret);
 	nvme_change_ctrl_state(&anv->ctrl, NVME_CTRL_DELETING);
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 62612f87aafa..7c689752b360 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3200,6 +3200,8 @@ int nvme_init_ctrl_finish(struct nvme_ctrl *ctrl, bool was_suspended)
 	clear_bit(NVME_CTRL_DIRTY_CAPABILITY, &ctrl->flags);
 	ctrl->identified = true;
 
+	nvme_start_keep_alive(ctrl);
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL(nvme_init_ctrl_finish);
@@ -4344,8 +4346,6 @@ EXPORT_SYMBOL_GPL(nvme_stop_ctrl);
 
 void nvme_start_ctrl(struct nvme_ctrl *ctrl)
 {
-	nvme_start_keep_alive(ctrl);
-
 	nvme_enable_aen(ctrl);
 
 	/*
diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index a15b37750d6e..b46b49d010d6 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -3203,6 +3203,7 @@ nvme_fc_create_association(struct nvme_fc_ctrl *ctrl)
 	dev_warn(ctrl->ctrl.device,
 		"NVME-FC{%d}: create_assoc failed, assoc_id %llx ret %d\n",
 		ctrl->cnum, ctrl->association_id, ret);
+	nvme_stop_keep_alive(&ctrl->ctrl);
 	/* send a Disconnect(association) LS to fc-nvme target */
 	nvme_fc_xmt_disconnect_assoc(ctrl);
 	spin_lock_irqsave(&ctrl->lock, flags);
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 60a08dfe8d75..97a86e7d8d27 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2731,11 +2731,11 @@ static void nvme_reset_work(struct work_struct *work)
 
 	result = nvme_setup_host_mem(dev);
 	if (result < 0)
-		goto out;
+		goto out_stop;
 
 	result = nvme_setup_io_queues(dev);
 	if (result)
-		goto out;
+		goto out_stop;
 
 	/*
 	 * Freeze and update the number of I/O queues as thos might have
@@ -2764,7 +2764,7 @@ static void nvme_reset_work(struct work_struct *work)
 		dev_warn(dev->ctrl.device,
 			"failed to mark controller live state\n");
 		result = -ENODEV;
-		goto out;
+		goto out_stop;
 	}
 
 	nvme_start_ctrl(&dev->ctrl);
@@ -2772,6 +2772,8 @@ static void nvme_reset_work(struct work_struct *work)
 
  out_unlock:
 	mutex_unlock(&dev->shutdown_lock);
+ out_stop:
+	nvme_stop_keep_alive(&dev->ctrl);
  out:
 	/*
 	 * Set state to deleting now to avoid blocking nvme_wait_reset(), which
@@ -3021,17 +3023,17 @@ static int nvme_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 
 	result = nvme_init_ctrl_finish(&dev->ctrl, false);
 	if (result)
-		goto out_disable;
+		goto out_stop;
 
 	nvme_dbbuf_dma_alloc(dev);
 
 	result = nvme_setup_host_mem(dev);
 	if (result < 0)
-		goto out_disable;
+		goto out_stop;
 
 	result = nvme_setup_io_queues(dev);
 	if (result)
-		goto out_disable;
+		goto out_stop;
 
 	if (dev->online_queues > 1) {
 		nvme_alloc_io_tag_set(&dev->ctrl, &dev->tagset, &nvme_mq_ops,
@@ -3046,7 +3048,7 @@ static int nvme_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 		dev_warn(dev->ctrl.device,
 			"failed to mark controller live state\n");
 		result = -ENODEV;
-		goto out_disable;
+		goto out_stop;
 	}
 
 	pci_set_drvdata(pdev, dev);
@@ -3056,6 +3058,8 @@ static int nvme_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	flush_work(&dev->ctrl.scan_work);
 	return 0;
 
+out_stop:
+	nvme_stop_keep_alive(&dev->ctrl);
 out_disable:
 	nvme_change_ctrl_state(&dev->ctrl, NVME_CTRL_DELETING);
 	nvme_dev_disable(dev, true);
diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 337a624a537c..f51597c0730f 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -1077,6 +1077,7 @@ static int nvme_rdma_setup_ctrl(struct nvme_rdma_ctrl *ctrl, bool new)
 		nvme_rdma_free_io_queues(ctrl);
 	}
 destroy_admin:
+	nvme_stop_keep_alive(&ctrl->ctrl);
 	nvme_quiesce_admin_queue(&ctrl->ctrl);
 	blk_sync_queue(ctrl->ctrl.admin_q);
 	nvme_rdma_stop_queue(&ctrl->queues[0]);
diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 7eeaa71d1177..cd4e9a295b9e 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -2288,6 +2288,7 @@ static int nvme_tcp_setup_ctrl(struct nvme_ctrl *ctrl, bool new)
 		nvme_tcp_destroy_io_queues(ctrl, new);
 	}
 destroy_admin:
+	nvme_stop_keep_alive(ctrl);
 	nvme_quiesce_admin_queue(ctrl);
 	blk_sync_queue(ctrl->admin_q);
 	nvme_tcp_stop_queue(ctrl, 0);
diff --git a/drivers/nvme/target/loop.c b/drivers/nvme/target/loop.c
index 48d5df054cd0..3bf469f33777 100644
--- a/drivers/nvme/target/loop.c
+++ b/drivers/nvme/target/loop.c
@@ -466,6 +466,7 @@ static void nvme_loop_reset_ctrl_work(struct work_struct *work)
 out_destroy_io:
 	nvme_loop_destroy_io_queues(ctrl);
 out_destroy_admin:
+	nvme_stop_keep_alive(&ctrl->ctrl);
 	nvme_loop_destroy_admin_queue(ctrl);
 out_disable:
 	dev_warn(ctrl->ctrl.device, "Removing after reset failure\n");
-- 
2.35.3


