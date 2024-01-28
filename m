Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37033C47258
	for <linux-nvme@archiver.kernel.org>; Sun, 28 Jan 2024 16:58:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=D7Ll7a40mBX94ujG6DCw9YLVk0F/pVEWnZ5bgYqDth4=; b=xcK5p3EVrov99qWFHWNg8sZU3C
	FRsu3gaVIPAVjV8e1nLXO7FUOUi94A0bUm2aRBmyLnf+8rXBkKQtO3BFYYFbTRV579PGBdmFiHYaZ
	DbIOkbNwVIC8eIlZs7XOdFOz44+nvP8f9eQh0qdzMNoQuEMKR12GkZ35NIsHKwrLJt1KdPPalp9ze
	sk+q+w0sW8uctO9sK+XuKTBuCBWIxk0Ij2wzbvdh8KMhoad3jOvlWo0GC1cOqaWC+7ZllKC1r863F
	nv8zG7StaBi78glcZ2IWmU5ASVqiFBsYI7mpCvoLVmtZ96VnPoZmk1WnlkaF6gZTcpwoe3Bs7wPdT
	mVMYPQLg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rU8UQ-0000000A23u-2bgL;
	Sun, 28 Jan 2024 16:58:38 +0000
Received: from [2001:4bb8:182:6550:c70:4a89:bc61:3] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rU8UM-0000000A1zq-0Jqe;
	Sun, 28 Jan 2024 16:58:37 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	virtualization@lists.linux.dev,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH 04/14] block: use queue_limits_commit_update in queue_max_sectors_store
Date: Sun, 28 Jan 2024 17:58:03 +0100
Message-Id: <20240128165813.3213508-5-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240128165813.3213508-1-hch@lst.de>
References: <20240128165813.3213508-1-hch@lst.de>
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

Convert queue_max_sectors_store to use queue_limits_commit_update to
check and update the max_sectors limit and freeze the queue before
doing so to ensure we don't have requests in flight while changing
the limits.

Note that this removes the previously held queue_lock that doesn't
protect against any other reader or writer.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Hannes Reinecke <hare@suse.de>
---
 block/blk-sysfs.c | 37 ++++++++++++-------------------------
 1 file changed, 12 insertions(+), 25 deletions(-)

diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index 6b2429cad81af1..26607f9825cb05 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -226,35 +226,22 @@ static ssize_t queue_zone_append_max_show(struct request_queue *q, char *page)
 static ssize_t
 queue_max_sectors_store(struct request_queue *q, const char *page, size_t count)
 {
-	unsigned long var;
-	unsigned int max_sectors_kb,
-		max_hw_sectors_kb = queue_max_hw_sectors(q) >> 1,
-			page_kb = 1 << (PAGE_SHIFT - 10);
-	ssize_t ret = queue_var_store(&var, page, count);
+	unsigned long max_sectors_kb;
+	struct queue_limits lim;
+	ssize_t ret;
+	int err;
 
+	ret = queue_var_store(&max_sectors_kb, page, count);
 	if (ret < 0)
 		return ret;
 
-	max_sectors_kb = (unsigned int)var;
-	max_hw_sectors_kb = min_not_zero(max_hw_sectors_kb,
-					 q->limits.max_dev_sectors >> 1);
-	if (max_sectors_kb == 0) {
-		q->limits.max_user_sectors = 0;
-		max_sectors_kb = min(max_hw_sectors_kb,
-				     BLK_DEF_MAX_SECTORS_CAP >> 1);
-	} else {
-		if (max_sectors_kb > max_hw_sectors_kb ||
-		    max_sectors_kb < page_kb)
-			return -EINVAL;
-		q->limits.max_user_sectors = max_sectors_kb << 1;
-	}
-
-	spin_lock_irq(&q->queue_lock);
-	q->limits.max_sectors = max_sectors_kb << 1;
-	if (q->disk)
-		q->disk->bdi->io_pages = max_sectors_kb >> (PAGE_SHIFT - 10);
-	spin_unlock_irq(&q->queue_lock);
-
+	blk_mq_freeze_queue(q);
+	lim = queue_limits_start_update(q);
+	lim.max_user_sectors = max_sectors_kb << 1;
+	err = queue_limits_commit_update(q, &lim);
+	blk_mq_unfreeze_queue(q);
+	if (err)
+		return err;
 	return ret;
 }
 
-- 
2.39.2


