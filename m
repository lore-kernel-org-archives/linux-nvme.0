Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 160DFFA3740
	for <linux-nvme@archiver.kernel.org>; Tue, 25 Oct 2022 14:40:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=PJP4QnM5k+m1zXW1SQKgGJS1dFXcQb6uSyDpAxiYQaI=; b=4GHqV82lrbYMJtVrSLQMg3Nb7a
	WeJWad5B81GlqvAaSrmga7EhkQvYFcBVGdVxc2/9Asca7OhFLYX+JfWrBz0zanGQKzLVuvVXGGD3O
	S5ZEQOBhRJsCoWISCZMzktWuH3vN5C7+K+mDCoWAdTeXl3/fTFsKcg447PLfelEOd+UYe64jd8l9R
	zpab2JwM0aTevWG4COcvSWQN0jqjI4Gi9cCR2J4E/fJHjp6eki45Gcd8dsPq9ZdebIjUfN5UY2Tok
	jy8xjZBZjuJ5gtt20ZGrlne4gz4cQIxIDXOSA33EIhoe1BHlixv2R7mDr/t+9bumZDzlyJxErnpyl
	XeepO9fQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1onL6j-005pzL-PS; Tue, 25 Oct 2022 14:40:45 +0000
Received: from [12.47.128.130] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
	id 1onL6L-005pmE-Rh; Tue, 25 Oct 2022 14:40:21 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>,
	Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chao Leng <lengchao@huawei.com>
Cc: Ming Lei <ming.lei@redhat.com>,
	linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org
Subject: [PATCH 04/17] nvme: don't call nvme_kill_queues from nvme_remove_namespaces
Date: Tue, 25 Oct 2022 07:40:07 -0700
Message-Id: <20221025144020.260458-5-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221025144020.260458-1-hch@lst.de>
References: <20221025144020.260458-1-hch@lst.de>
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

Only the PCIe driver can mark a controller dead, and it does so in
exactly one spot just before calling nvme_remove_namespaces.  Move the
state dependent callto nvme_kill_queues out of nvme_remove_namespaces
and into the one caller where this case can happen.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/host/core.c |  9 ---------
 drivers/nvme/host/pci.c  | 10 ++++++++++
 2 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index a92d07137cbd8..8eb46ca9f6acf 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -4560,15 +4560,6 @@ void nvme_remove_namespaces(struct nvme_ctrl *ctrl)
 	/* prevent racing with ns scanning */
 	flush_work(&ctrl->scan_work);
 
-	/*
-	 * The dead states indicates the controller was not gracefully
-	 * disconnected. In that case, we won't be able to flush any data while
-	 * removing the namespaces' disks; fail all the queues now to avoid
-	 * potentially having to clean up the failed sync later.
-	 */
-	if (ctrl->state == NVME_CTRL_DEAD)
-		nvme_kill_queues(ctrl);
-
 	/* this is a no-op when called from the controller reset handler */
 	nvme_change_ctrl_state(ctrl, NVME_CTRL_DELETING_NOIO);
 
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index ec034d4dd9eff..f971e96ffd3f6 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -3249,6 +3249,16 @@ static void nvme_remove(struct pci_dev *pdev)
 
 	flush_work(&dev->ctrl.reset_work);
 	nvme_stop_ctrl(&dev->ctrl);
+
+	/*
+	 * The dead states indicates the controller was not gracefully
+	 * disconnected. In that case, we won't be able to flush any data while
+	 * removing the namespaces' disks; fail all the queues now to avoid
+	 * potentially having to clean up the failed sync later.
+	 */
+	if (dev->ctrl.state == NVME_CTRL_DEAD)
+		nvme_kill_queues(&dev->ctrl);
+
 	nvme_remove_namespaces(&dev->ctrl);
 	nvme_dev_disable(dev, true);
 	nvme_remove_attrs(dev);
-- 
2.30.2


