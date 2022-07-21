Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFC77C433EF
	for <linux-nvme@archiver.kernel.org>; Thu, 21 Jul 2022 06:10:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=G1RpuQUIi1PlSVYrFXv3wJCA4sBLISa5brXsynEZcvg=; b=eUMchoPNinIkIbpfRWwKOBSPlA
	LEOqjrGwwyb0xDJ9JM4aH1nOh8ozqpA4lQWvEyMsn72K5GmzGQbmYFV0hPOaXoKvwzDr5aeVEfXsH
	mYSX/wYotjTJm0VA424tie7UfAwyugBYkaP6EQlFOxxuTE6ozziU4YzS9Oz59RRqJoCQ1lGsB5JX7
	xy5xQX6nQlHDPmxmJ/Fc5fVFOnnVyHxvxvHgZagw0wt2kwE3CsAPxSW6xBdMPeDwzz4o5oXNNh2W5
	J0RpyCjFIc9vNWWOp+uxKjIZwY3dGQptUGLr8aqWCHy57S7nxwAP7E9w9UkZ0Pl47tuay1Hs1X81X
	UDRE4W9A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oEPOd-000mHa-JL; Thu, 21 Jul 2022 06:10:51 +0000
Received: from [2001:4bb8:18a:6f7a:1b03:4d0e:b929:ebb2] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oEPHS-000da9-5t; Thu, 21 Jul 2022 06:03:26 +0000
From: Christoph Hellwig <hch@lst.de>
To: Joel Granados <j.granados@samsung.com>,
	kbusch@kernel.org,
	sagi@grimberg.me
Cc: joshi.k@samsung.com,
	linux-nvme@lists.infradead.org,
	gost.dev@samsung.com,
	k.jensen@samsung.com
Subject: [PATCH 1/6] nvme: catch -ENODEV from nvme_revalidate_zones again
Date: Thu, 21 Jul 2022 08:03:15 +0200
Message-Id: <20220721060320.1704646-2-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220721060320.1704646-1-hch@lst.de>
References: <20220721060320.1704646-1-hch@lst.de>
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

nvme_revalidate_zones can also return -ENODEV if e.g. zone sizes aren't
constant or not a power of two.  In that case we should jump to marking
the gendisk hidden and only support pass through.

Fixes: 602e57c9799c ("nvme: also mark passthrough-only namespaces ready in nvme_update_ns_info")
Reported-by: Joel Granados <j.granados@samsung.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/host/core.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 698e71680e6f3..2e1af9b5c8a91 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1940,8 +1940,10 @@ static int nvme_update_ns_info(struct nvme_ns *ns, struct nvme_id_ns *id)
 
 	if (ns->head->ids.csi == NVME_CSI_ZNS) {
 		ret = nvme_update_zone_info(ns, lbaf);
-		if (ret)
-			goto out_unfreeze;
+		if (ret) {
+			blk_mq_unfreeze_queue(ns->disk->queue);
+			goto out;
+		}
 	}
 
 	set_disk_ro(ns->disk, (id->nsattr & NVME_NS_ATTR_RO) ||
@@ -1952,7 +1954,7 @@ static int nvme_update_ns_info(struct nvme_ns *ns, struct nvme_id_ns *id)
 	if (blk_queue_is_zoned(ns->queue)) {
 		ret = nvme_revalidate_zones(ns);
 		if (ret && !nvme_first_scan(ns->disk))
-			return ret;
+			goto out;
 	}
 
 	if (nvme_ns_head_multipath(ns->head)) {
@@ -1967,9 +1969,9 @@ static int nvme_update_ns_info(struct nvme_ns *ns, struct nvme_id_ns *id)
 		disk_update_readahead(ns->head->disk);
 		blk_mq_unfreeze_queue(ns->head->disk->queue);
 	}
-	return 0;
 
-out_unfreeze:
+	ret = 0;
+out:
 	/*
 	 * If probing fails due an unsupported feature, hide the block device,
 	 * but still allow other access.
@@ -1979,7 +1981,6 @@ static int nvme_update_ns_info(struct nvme_ns *ns, struct nvme_id_ns *id)
 		set_bit(NVME_NS_READY, &ns->flags);
 		ret = 0;
 	}
-	blk_mq_unfreeze_queue(ns->disk->queue);
 	return ret;
 }
 
-- 
2.30.2


