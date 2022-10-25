Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5703BC38A2D
	for <linux-nvme@archiver.kernel.org>; Tue, 25 Oct 2022 14:41:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zsC5LCrtGDwY/PILkeG0NAllG5mtpvGF+RFlFdcpBBQ=; b=kNLquaWgBrys6zmZI/sjtTKQv/
	YSwdwOhfWbNoPIysT6Shoa+NkEw48I5bCJoI271d9vZtYoyTQ4m7r9WcGtNO16+JKksm1oV0yxoR0
	Ou/cmKjXfVffggDydr76tpz/m6bUjGKJC/9YUDRBTxo6m8ipJ/efiONCMa4pWyaZFeNKf1yqK7m9n
	nhDozlY5pWkBC3qcEz1t76VjYX2KrVAT57qhGHzdYvjQGLF08PpIDSZC704siHJYmvtHh1BRP9kXc
	hiEI75FbCElSyE2LZm7LdXuwZpmeI7E+9L1Dg//gpXSpnfaCTuR0SzskU0TiQL0rdtcu6h6s1A7MS
	Ht3VgW5g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1onL7N-005qPH-1K; Tue, 25 Oct 2022 14:41:25 +0000
Received: from [12.47.128.130] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
	id 1onL6N-005pnn-Rg; Tue, 25 Oct 2022 14:40:23 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>,
	Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chao Leng <lengchao@huawei.com>
Cc: Ming Lei <ming.lei@redhat.com>,
	linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org
Subject: [PATCH 11/17] nvme-pci: don't unquiesce the I/O queues in nvme_remove_dead_ctrl
Date: Tue, 25 Oct 2022 07:40:14 -0700
Message-Id: <20221025144020.260458-12-hch@lst.de>
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

nvme_remove_dead_ctrl schedules nvme_remove to be called, which will
call nvme_dev_disable and unquiesce the I/O queues.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/host/pci.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index bef98f6e1396c..3a26c9b2bf454 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2794,7 +2794,6 @@ static void nvme_remove_dead_ctrl(struct nvme_dev *dev)
 	nvme_get_ctrl(&dev->ctrl);
 	nvme_dev_disable(dev, false);
 	nvme_mark_namespaces_dead(&dev->ctrl);
-	nvme_start_queues(&dev->ctrl);
 	if (!queue_work(nvme_wq, &dev->remove_work))
 		nvme_put_ctrl(&dev->ctrl);
 }
-- 
2.30.2


