Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39FE1C38A2D
	for <linux-nvme@archiver.kernel.org>; Tue, 25 Oct 2022 14:41:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3Io0eBhCr/FHLmHpxgYZ1taiPGcCUyVAts23z2QYtk0=; b=qblotv/WJY1yZ5Z3dmS5Ryl+lD
	w1ouXPZrK84apSSooEFSpsBrSowGIkgz5k3HfX0MYQbcbdeSV35FR4nY0izBr2OopcpK5xpD33rnI
	cE6xdMbbTXAAXuFAKKrVa1Mi2Ht54mJPYouZUQ9m7xp7kpMzWK1feKO23QBq4DX6/YB2B4Ew6Ivk4
	du47Ulw5DhCEgTaMF6HGBx6Kz1mo/QVSwYnbWCON1xvxPD8e0v0phezEUMq2ALFVq2t2CZtssuHrD
	75EFhSrUnM4ACRTfRpURLmiVnoaVcEj4vPaypk+uNL0gJIl/xJVeN4d669KMrYWHC/DkbO+KaNlJx
	H62r4FgA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1onL74-005qCq-Q5; Tue, 25 Oct 2022 14:41:06 +0000
Received: from [12.47.128.130] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
	id 1onL6N-005pn9-07; Tue, 25 Oct 2022 14:40:23 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>,
	Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chao Leng <lengchao@huawei.com>
Cc: Ming Lei <ming.lei@redhat.com>,
	linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org
Subject: [PATCH 08/17] nvme: don't unquiesce the admin queue in nvme_kill_queues
Date: Tue, 25 Oct 2022 07:40:11 -0700
Message-Id: <20221025144020.260458-9-hch@lst.de>
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

There are 4 callers of nvme_kill_queues:

 1) nvme_reset_work explicit call nvme_start_admin_queue toward the
    beginning of the function.  The extra call to nvme_start_admin_queue
    in nvme_reset_work this won't do anything as
    NVME_CTRL_ADMIN_Q_STOPPED will already be cleared.
 2) nvme_remove calls nvme_dev_disable with shutdown flag set to true at
    the very beginning of the function if the PCIe device was not present,
    which is the precondition for the call to nvme_kill_queues.
    nvme_dev_disable already calls nvme_start_admin_queue toward the
    end of the function when the shutdown flag is set to true, so the
    admin queue is already enabled at this point.
 3) nvme_remove_dead_ctrl schedules a workqueue to unbind the driver,
    which will end up in nvme_remove, which calls nvme_dev_disable with
    the shutdown flag.  This case will call nvme_start_admin_queue a bit
    later than before.
 4) apple_nvme_remove uses the same sequence as nvme_remove_dead_ctrl
     above.

So it is safe to just remove the call to nvme_start_admin_queue in
nvme_kill_queues without replacement.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/host/core.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 99eabbe7fac98..d4d25f1dd6dba 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -5121,9 +5121,6 @@ void nvme_kill_queues(struct nvme_ctrl *ctrl)
 	down_read(&ctrl->namespaces_rwsem);
 
 	/* Forcibly unquiesce queues to avoid blocking dispatch */
-	if (ctrl->admin_q && !blk_queue_dying(ctrl->admin_q))
-		nvme_start_admin_queue(ctrl);
-
 	list_for_each_entry(ns, &ctrl->namespaces, list)
 		nvme_set_queue_dying(ns);
 
-- 
2.30.2


