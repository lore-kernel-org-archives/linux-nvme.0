Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4160CD1280
	for <linux-nvme@archiver.kernel.org>; Wed, 27 Mar 2024 17:21:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=JMfSUduTvICr0rbJirGIevmfZNskKYKvkkydG+5NhaE=; b=pC5DACxHzY+YV+sVFl4YLNqBSD
	BdrINFev9aGx+/quh8j16LhDuIA2tBxsZzJce/OBwzQS8nY35ZYcOENK58h/vdr22P54l7s3v6kcr
	Qaz37Kb3Oh/CCWs4c0bbOZvvJsfjBd8oI1cfUq3NNlLBpqN0AE8N+BIWdF8XOKcmbxWc1RLAyHL3B
	FKtjNCujdyEogoHPQyGHyNShlOf+5dwCIc/CVgIqEhvniDDIrRX3/dnqsNDe+lN46feffOHBz91Rp
	+Z6Zs4RIHVWabhr+bZ7n18Br77B2LZ2bcMJx3zcI2KUB5z6W5OEw/1CbkCOmGy0nlu7Ljgv5XUkn1
	JX+YJNOQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rpWyL-0000000AHAE-42hG;
	Wed, 27 Mar 2024 17:21:57 +0000
Received: from 089144220178.atnat0029.highway.webapn.at ([89.144.220.178] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rpWyH-0000000AH6Y-3LKX;
	Wed, 27 Mar 2024 17:21:54 +0000
From: Christoph Hellwig <hch@lst.de>
To: axboe@kernel.dk
Cc: kbusch@kernel.org,
	sagi@grimberg.me,
	linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org,
	Kanchan Joshi <joshi.k@samsung.com>
Subject: [PATCH 2/2] nvme: cancel the queue limit update when nvme_update_zone_info fails
Date: Wed, 27 Mar 2024 18:21:45 +0100
Message-Id: <20240327172145.2844065-2-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240327172145.2844065-1-hch@lst.de>
References: <20240327172145.2844065-1-hch@lst.de>
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

Starting an atomic queue limits update takes a mutex and thus needs
to be finished, or with the newly added helper, canceled to not leak
the lock critical section.

Fixes: 9b130d681443 ("nvme: use the atomic queue limits update API")
Reported-by: Kanchan Joshi <joshi.k@samsung.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/host/core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 943d72bdd794ca..f8a9565bee41d2 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2115,6 +2115,7 @@ static int nvme_update_ns_info_block(struct nvme_ns *ns,
 	    ns->head->ids.csi == NVME_CSI_ZNS) {
 		ret = nvme_update_zone_info(ns, lbaf, &lim);
 		if (ret) {
+			queue_limits_cancel_update(ns->disk->queue);
 			blk_mq_unfreeze_queue(ns->disk->queue);
 			goto out;
 		}
-- 
2.39.2


