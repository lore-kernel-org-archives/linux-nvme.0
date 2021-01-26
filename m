Return-Path: <SRS0=0e7J=G5=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 418E3C433E0
	for <linux-nvme@archiver.kernel.org>; Tue, 26 Jan 2021 14:36:15 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A82BC23110
	for <linux-nvme@archiver.kernel.org>; Tue, 26 Jan 2021 14:36:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A82BC23110
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=7CKdkWlJZ8JgVTZVBWgvR9TtaVpD0ph/c0iObbVP77g=; b=SxnMbWMIxEJJryYjnCNrVajcx
	FDiN/vgvGPHLFfpJxlYwx/R8D3JMVjqmCrq29ScFjbXso9GLLlQw3WVSkk9jhjHLW8XV3lDz3FWbb
	1glBiAPLHA0zW75H0Z8j1hoaFS6kKSBTgZiK1akEuSbptycSGY2U+vKnZv+aht53jmkJC69vTFNjP
	kATAVTaCMOKDRibrFjmttdyXhMz694Csw9zkibb2i31XsO5PV2bwSdtXLx5D6LvYtnXy5I1cEYHVV
	5Cnaj5p2gbvMbMThY+GDDp54hmlu/aBy9aSvXIgpEx/Qk8oZmXwTNBc7/sZMOSvBS0YDW32yc/XLz
	b1sezWubw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l4PRl-0003sz-Jv; Tue, 26 Jan 2021 14:35:57 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l4PRk-0003sn-00
 for linux-nvme@merlin.infradead.org; Tue, 26 Jan 2021 14:35:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description;
 bh=uAijLOVlzlFNtFA5epK1dLVk2Tr9v2ryv/7iM8cK8Zo=; b=Ovbezc3+HTgEaW4815+0vDmjXn
 f7s6rCMADSJtocBqb/jiquCUK3OOt4DBLalRbHTj4mi7j8HVLi2jj4DEscvd79lqopS07NoC9wD+/
 7oBLkWs3uJV2RX9tp9QFMtde8dMiQW6+JXxIiKDGKbClw/LgdNRX5DytSPRibTFd4/x6XExaVAD+x
 PQ6H7hF1grNMuD6XU5e7uGVlqZYAno94gsGlCf3dAhlydV2EU12gv87EBzouilzkpXDWcCe/kiAip
 oCB8Kp1eGFvttT7bmdQsQEGmUrZnd0AyPzgnrFeS1RXyUN8nnNqSLiDQGCOOnHl4AzEbe33FrtyFQ
 12/d7R5w==;
Received: from [2001:4bb8:191:e347:5918:ac86:61cb:8801] (helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
 id 1l4PQm-005kHu-Tg; Tue, 26 Jan 2021 14:35:04 +0000
From: Christoph Hellwig <hch@lst.de>
To: axboe@kernel.dk
Subject: [PATCH 1/3] nvme: use bio_set_dev to assign ->bi_bdev
Date: Tue, 26 Jan 2021 15:33:06 +0100
Message-Id: <20210126143308.1960860-2-hch@lst.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210126143308.1960860-1-hch@lst.de>
References: <20210126143308.1960860-1-hch@lst.de>
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
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
Cc: linux-block@vger.kernel.org, linux-bcache@vger.kernel.org,
 linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Always use the bio_set_dev helper to assign ->bi_bdev to make sure
other state related to the device is uptodate.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/host/core.c      | 2 +-
 drivers/nvme/host/lightnvm.c  | 2 +-
 drivers/nvme/host/multipath.c | 4 ++--
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index eb7963fb167b56..ba5df80881ea98 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1133,7 +1133,7 @@ static int nvme_submit_user_cmd(struct request_queue *q,
 		if (ret)
 			goto out;
 		bio = req->bio;
-		bio->bi_bdev = bdev;
+		bio_set_dev(bio, bdev);
 		if (bdev && meta_buffer && meta_len) {
 			meta = nvme_add_user_metadata(bio, meta_buffer, meta_len,
 					meta_seed, write);
diff --git a/drivers/nvme/host/lightnvm.c b/drivers/nvme/host/lightnvm.c
index ec38128f51e994..b705988629f224 100644
--- a/drivers/nvme/host/lightnvm.c
+++ b/drivers/nvme/host/lightnvm.c
@@ -816,7 +816,7 @@ static int nvme_nvm_submit_user_cmd(struct request_queue *q,
 			vcmd->ph_rw.metadata = cpu_to_le64(metadata_dma);
 		}
 
-		bio->bi_bdev = ns->disk->part0;
+		bio_set_dev(bio, ns->disk->part0);
 	}
 
 	blk_execute_rq(NULL, rq, 0);
diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index a6d44e7a775f54..65bd6efa5e1c69 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -312,7 +312,7 @@ blk_qc_t nvme_ns_head_submit_bio(struct bio *bio)
 	srcu_idx = srcu_read_lock(&head->srcu);
 	ns = nvme_find_path(head);
 	if (likely(ns)) {
-		bio->bi_bdev = ns->disk->part0;
+		bio_set_dev(bio, ns->disk->part0);
 		bio->bi_opf |= REQ_NVME_MPATH;
 		trace_block_bio_remap(bio, disk_devt(ns->head->disk),
 				      bio->bi_iter.bi_sector);
@@ -352,7 +352,7 @@ static void nvme_requeue_work(struct work_struct *work)
 		 * Reset disk to the mpath node and resubmit to select a new
 		 * path.
 		 */
-		bio->bi_bdev = head->disk->part0;
+		bio_set_dev(bio, head->disk->part0);
 		submit_bio_noacct(bio);
 	}
 }
-- 
2.29.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
