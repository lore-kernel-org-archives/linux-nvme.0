Return-Path: <SRS0=WFi/=JF=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 743D5C433B4
	for <linux-nvme@archiver.kernel.org>; Thu,  8 Apr 2021 12:23:24 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A5D1608FC
	for <linux-nvme@archiver.kernel.org>; Thu,  8 Apr 2021 12:23:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A5D1608FC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=ccDIQsDZCwNrurZZDciGERBgqRzxHzSL27QAEiLDoMk=; b=YEUBvUrIYfRadLEMlfEMzdKzV
	ysml+7becsIhLd9ir/knzk5FrRoGFpLii8LPi2KfNo8qDLWVcHaZaYRLTxNUiFAp41jsMPdz6/lIv
	TgREl2pTbqDAmGw1itc/nXir+ziqrbr7AuMG0W7LXqdqdux7tM2Qg7q+ecYK/IcaFHd81aqkF09X0
	tvD5Yf6qWQ1qkEqm+jwDwsyfW5JOM2g5L4C4qTR8x5qKtTbZ1wZLeJyCLq9TEFifYOuGZSE5q1E+M
	opqIxFqsbBd+BT3VLSi0CH2XyYEgkQX0Ax9lYrLr06IWbZVtOVaDBdqmLC3J803QE2vqEaTs+hnnS
	FEWspSLEQ==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lUTgt-007yDq-7q; Thu, 08 Apr 2021 12:23:19 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lUTds-007xOw-9n
 for linux-nvme@lists.infradead.org; Thu, 08 Apr 2021 12:20:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
 :Reply-To:Content-Type:Content-ID:Content-Description;
 bh=RVElzJsQjzwdVFQAfNIYYtAWRLlYe2w2tqpshk6CGWA=; b=BaVXPolAxDuXVibF/ldNoKCfxp
 K1bnpQY1tMWGsr2RobpWZAHEyt7BBQoHTpwRXk3GL8brnutfFaid3Qqq9mHS/kxBu7kl3O3UPYFvN
 qYKUeMeGVGhLEdvsCcLxQycfXOzfsUGCac4PjWMwxH6rH5DSg5FbfniTAizet5TGOOoOfEfgR0iye
 yxofVZNRud6jLSZBbv9bSua6FbhHz9txmkPpfLflFeXvBRYJaLQOgadE3ytylPRNwb8cCiZCT05Nc
 qt64u/2vNob3si3p4uhLLahyl7kn1K9Xf495rhu7e88ZZt9eWybqzNlJWhX1v6boYwQKi8WXRruV5
 QOFjl7Lg==;
Received: from [2001:4bb8:188:4907:196e:5227:9015:fba2] (helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
 id 1lUTdo-00HAUn-Bd; Thu, 08 Apr 2021 12:20:08 +0000
From: Christoph Hellwig <hch@lst.de>
To: Minwoo Im <minwoo.im.dev@gmail.com>, Keith Busch <kbusch@kernel.org>,
 Sagi Grimberg <sagi@grimberg.me>
Cc: Kanchan Joshi <joshiiitr@gmail.com>,
 Javier Gonz??lez <javier.gonz@samsung.com>, linux-nvme@lists.infradead.org
Subject: [PATCH 12/13] nvme: let namespace probing continue for unsupported
 features
Date: Thu,  8 Apr 2021 14:08:41 +0200
Message-Id: <20210408120842.1450092-13-hch@lst.de>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210408120842.1450092-1-hch@lst.de>
References: <20210408120842.1450092-1-hch@lst.de>
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Instead of failing to scan the namespace entirely when unsupported
features are detected, just mark the gendisk hidden but allow other
access like the upcoming per-namespace character device.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/host/core.c | 11 ++++++++++-
 drivers/nvme/host/zns.c  |  4 ++--
 2 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 7ebe0225e01412..eba676b260b820 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1832,7 +1832,7 @@ static int nvme_update_ns_info(struct nvme_ns *ns, struct nvme_id_ns *id)
 	if (blk_queue_is_zoned(ns->queue)) {
 		ret = nvme_revalidate_zones(ns);
 		if (ret && !nvme_first_scan(ns->disk))
-			return ret;
+			goto out;
 	}
 
 	if (nvme_ns_head_multipath(ns->head)) {
@@ -1847,6 +1847,15 @@ static int nvme_update_ns_info(struct nvme_ns *ns, struct nvme_id_ns *id)
 
 out_unfreeze:
 	blk_mq_unfreeze_queue(ns->disk->queue);
+out:
+	/*
+	 * If probing fails due an unsupported feature, hide the block device,
+	 * but still allow other access.
+	 */
+	if (ret == -ENODEV) {
+		ns->disk->flags |= GENHD_FL_HIDDEN;
+		ret = 0;
+	}
 	return ret;
 }
 
diff --git a/drivers/nvme/host/zns.c b/drivers/nvme/host/zns.c
index bc2f344f0ae018..475dd45c3db49b 100644
--- a/drivers/nvme/host/zns.c
+++ b/drivers/nvme/host/zns.c
@@ -96,7 +96,7 @@ int nvme_update_zone_info(struct nvme_ns *ns, unsigned lbaf)
 		dev_warn(ns->ctrl->device,
 			"zone operations:%x not supported for namespace:%u\n",
 			le16_to_cpu(id->zoc), ns->head->ns_id);
-		status = -EINVAL;
+		status = -ENODEV;
 		goto free_data;
 	}
 
@@ -105,7 +105,7 @@ int nvme_update_zone_info(struct nvme_ns *ns, unsigned lbaf)
 		dev_warn(ns->ctrl->device,
 			"invalid zone size:%llu for namespace:%u\n",
 			ns->zsze, ns->head->ns_id);
-		status = -EINVAL;
+		status = -ENODEV;
 		goto free_data;
 	}
 
-- 
2.30.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
