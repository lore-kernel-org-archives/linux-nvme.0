Return-Path: <SRS0=WFi/=JF=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65F59C433ED
	for <linux-nvme@archiver.kernel.org>; Thu,  8 Apr 2021 12:13:19 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D5861610F8
	for <linux-nvme@archiver.kernel.org>; Thu,  8 Apr 2021 12:13:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5861610F8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=ADZczbgwS5ZgmM6S/VaqLzYq6FWeLqMVZsIRXd0+154=; b=idMziwdu59BSyiKKq+C6XnJXE
	X+ml9WOqoKtjpYCyh5UCfrfTjHl1Yt7A8xtBSyJYRhLCl1QxIEq+/lMPucD//Gv88uwLP75LA2beY
	mb4F1V9fkYt+0xFiSfZUBKDk+0lhIu0qHCsP41YeeB52AYvfIwa4kck7tAtx6SdG7WWgNkTBia2dF
	eUHyfOtSPX1RaRfz4NW2QASdOvhqLt4sRzMbPKeDm2ZwNWU18vviTXu4iNzWv9uWhYvRtmy8vdR9Y
	P/jc1wYqXl7+TkgzoQ9eQoGjVTumSZPzF8Z9VoDxBjexk9YUFqKqFOSOfHcaUEgK4jaGeEJbihd3i
	LDvqgZfgQ==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lUTX8-007wBw-S6; Thu, 08 Apr 2021 12:13:15 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lUTX5-007wBT-T4
 for linux-nvme@lists.infradead.org; Thu, 08 Apr 2021 12:13:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
 :Reply-To:Content-Type:Content-ID:Content-Description;
 bh=eTmeJo+bD82bsoBpLwhOlM0tdsOvS+4Dgx457hGzCzM=; b=UuyjrZccEPpxSAWz0YQ1yvN4ri
 0dVGzxWrmBr0OjdRg7lTW7TEhZUrFq2IyHCgcT5E6eBbFub6hYmwkZhLWbbYK5BIdyEOBa2WIeKEA
 01gWDqya/m7rPVmIUhAqoNky772iQHu8tirbelaP5/QyUxiufdV45lTnziYjBcxxlx8lbm/J/PCq8
 Pk5Cgut5C12VvAnJ/OHskDvSf+evyoq59ZzL1wEzudColZQyfr6WJmpEnSNgnV86uyll4sR3jgyGL
 FCdP1k3cSVd8Yrdd2cXL/tw4ZSg6JJPYUXxRt81rLJfX7ieMFr3I3pMNNVkRExN3WW6ihANjPytYP
 4/m8kckw==;
Received: from 213-225-2-171.nat.highway.a1.net ([213.225.2.171]
 helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
 id 1lUTX1-00HAC1-J5; Thu, 08 Apr 2021 12:13:08 +0000
From: Christoph Hellwig <hch@lst.de>
To: Minwoo Im <minwoo.im.dev@gmail.com>, Keith Busch <kbusch@kernel.org>,
 Sagi Grimberg <sagi@grimberg.me>
Cc: Kanchan Joshi <joshiiitr@gmail.com>,
 Javier Gonz??lez <javier.gonz@samsung.com>, linux-nvme@lists.infradead.org
Subject: [PATCH 01/13] nvme: add a nvme_ns_head_multipath helper
Date: Thu,  8 Apr 2021 14:08:30 +0200
Message-Id: <20210408120842.1450092-2-hch@lst.de>
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

From: Minwoo Im <minwoo.im.dev@gmail.com>

Move the multipath gendisk out of #ifdef CONFIG_NVME_MULTIPATH and add
a new nvme_ns_head_multipath that uses it to check if a ns_head has
a multipath device associated with it.

Signed-off-by: Minwoo Im <minwoo.im.dev@gmail.com>
[hch: added the IS_ENABLED, converted a few existing users]
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/host/core.c | 8 ++------
 drivers/nvme/host/nvme.h | 7 ++++++-
 2 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 314705da2c1076..4d13bca83cfefa 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1873,11 +1873,9 @@ static int nvme_open(struct block_device *bdev, fmode_t mode)
 {
 	struct nvme_ns *ns = bdev->bd_disk->private_data;
 
-#ifdef CONFIG_NVME_MULTIPATH
 	/* should never be called due to GENHD_FL_HIDDEN */
-	if (WARN_ON_ONCE(ns->head->disk))
+	if (WARN_ON_ONCE(nvme_ns_head_multipath(ns->head)))
 		goto fail;
-#endif
 	if (!kref_get_unless_zero(&ns->kref))
 		goto fail;
 	if (!try_module_get(ns->ctrl->ops->module))
@@ -2215,8 +2213,7 @@ static int nvme_update_ns_info(struct nvme_ns *ns, struct nvme_id_ns *id)
 			return ret;
 	}
 
-#ifdef CONFIG_NVME_MULTIPATH
-	if (ns->head->disk) {
+	if (nvme_ns_head_multipath(ns->head)) {
 		blk_mq_freeze_queue(ns->head->disk->queue);
 		nvme_update_disk_info(ns->head->disk, ns, id);
 		blk_stack_limits(&ns->head->disk->queue->limits,
@@ -2224,7 +2221,6 @@ static int nvme_update_ns_info(struct nvme_ns *ns, struct nvme_id_ns *id)
 		blk_queue_update_readahead(ns->head->disk->queue);
 		blk_mq_unfreeze_queue(ns->head->disk->queue);
 	}
-#endif
 	return 0;
 
 out_unfreeze:
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 815c032a190eff..67ff5d41e7d03b 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -413,8 +413,8 @@ struct nvme_ns_head {
 	bool			shared;
 	int			instance;
 	struct nvme_effects_log *effects;
-#ifdef CONFIG_NVME_MULTIPATH
 	struct gendisk		*disk;
+#ifdef CONFIG_NVME_MULTIPATH
 	struct bio_list		requeue_list;
 	spinlock_t		requeue_lock;
 	struct work_struct	requeue_work;
@@ -425,6 +425,11 @@ struct nvme_ns_head {
 #endif
 };
 
+static inline bool nvme_ns_head_multipath(struct nvme_ns_head *head)
+{
+	return IS_ENABLED(CONFIG_NVME_MULTIPATH) && head->disk;
+}
+
 enum nvme_ns_features {
 	NVME_NS_EXT_LBAS = 1 << 0, /* support extended LBA format */
 	NVME_NS_METADATA_SUPPORTED = 1 << 1, /* support getting generated md */
-- 
2.30.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
