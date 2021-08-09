Return-Path: <SRS0=jKil=NA=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CE0DC4338F
	for <linux-nvme@archiver.kernel.org>; Mon,  9 Aug 2021 06:44:32 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C1F0C60527
	for <linux-nvme@archiver.kernel.org>; Mon,  9 Aug 2021 06:44:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org C1F0C60527
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=l6VmcCOy2DEQDLnMwK67s9BjdrlE13eOhcxXEmFkXdE=; b=fCYd3FvaA7GUXk
	J4m+HiIGjbA7bPV7B5f35E5dCk58Q1DTRtraLwdN4hi24DAHhtJzv/sMArCrM5+7izoiFr0j8mwZi
	SA+BIzIJVZLiFDVa5H/uWWgK5L4+kgjw0927vbkqcvu5qnJK+HcCPoe/EiNK1gs4qM+xRUum8Kf3W
	iMXfNb3aQUJD0uGcKkpX7Xc7dZNS2Ce8VYFUZBT4eo3Tnx4FZlZkrK51ThzEVP9LSYo8CHZYs9x3O
	2KN+hLhnZiiop63qTzT0/mFzxbi5/ApHR0tt45yQftj+eJqZZI4b+7Rr7OZjGG5uVFmHnel1/0gk8
	7ZqBBKf3KlEONzi0zkmQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mCz1I-00HH1W-Ay; Mon, 09 Aug 2021 06:44:20 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mCz1G-00HH1M-Ve
 for linux-nvme@bombadil.infradead.org; Mon, 09 Aug 2021 06:44:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description;
 bh=vkH3Wo8mATZ+eF4v04e/DPUXnCptiGaA42oXGO3dXG4=; b=lQL7R3cDRdHIWW/4jrP7/XPcVF
 MsRAMnS+rjdYC9Pnr9rrOrKf4sWHakOggtvQKxsRZ1PBLDt3SbL6zANOskpg2ZwckYvD+KDe8G+l4
 LxhitBBgDYwWR1nkgaACBw5ranm597FjP0AOAR2TWMmOyvEsSb/sro/++z8vrpjF2izNQpJ34mbH4
 jos4TdjL82tl5c94tMaTVkq+F4FWY57w6Qik/TQSSCs8jO/iTppjQcd+njyAUiwgVfbavHewo2S3E
 KfBRM1NQfcIKBbEzlIsXAyapZbdEjs06fJD71FiOSVAeHezm0poN0JGoeIwNUyl0ORPBmWC2SuVn+
 E2kZIj7g==;
Received: from [2a02:1205:5023:1f80:c068:bd3d:78b3:7d37] (helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mCz0V-00Aihs-Dt; Mon, 09 Aug 2021 06:43:50 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Coly Li <colyli@suse.de>, Song Liu <song@kernel.org>,
 Ulf Hansson <ulf.hansson@linaro.org>, Luis Chamberlain <mcgrof@kernel.org>,
 linux-block@vger.kernel.org, linux-bcache@vger.kernel.org,
 linux-raid@vger.kernel.org, linux-mmc@vger.kernel.org,
 linux-nvme@lists.infradead.org
Subject: [PATCH 3/8] nvme: remove the GENHD_FL_UP check in nvme_ns_remove
Date: Mon,  9 Aug 2021 08:40:23 +0200
Message-Id: <20210809064028.1198327-4-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210809064028.1198327-1-hch@lst.de>
References: <20210809064028.1198327-1-hch@lst.de>
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
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

Early probe failure never reaches nvme_ns_remove, so GENHD_FL_UP must
be set at this point.  Remove the check.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/host/core.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index dfd9dec0c1f6..e24a0143fd87 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3826,14 +3826,12 @@ static void nvme_ns_remove(struct nvme_ns *ns)
 	nvme_mpath_clear_current_path(ns);
 	synchronize_srcu(&ns->head->srcu); /* wait for concurrent submissions */
 
-	if (ns->disk->flags & GENHD_FL_UP) {
-		if (!nvme_ns_head_multipath(ns->head))
-			nvme_cdev_del(&ns->cdev, &ns->cdev_device);
-		del_gendisk(ns->disk);
-		blk_cleanup_queue(ns->queue);
-		if (blk_get_integrity(ns->disk))
-			blk_integrity_unregister(ns->disk);
-	}
+	if (!nvme_ns_head_multipath(ns->head))
+		nvme_cdev_del(&ns->cdev, &ns->cdev_device);
+	del_gendisk(ns->disk);
+	blk_cleanup_queue(ns->queue);
+	if (blk_get_integrity(ns->disk))
+		blk_integrity_unregister(ns->disk);
 
 	down_write(&ns->ctrl->namespaces_rwsem);
 	list_del_init(&ns->list);
-- 
2.30.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
