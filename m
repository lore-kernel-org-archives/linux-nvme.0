Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30A2CC4829A
	for <linux-nvme@archiver.kernel.org>; Tue, 13 Feb 2024 07:35:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2ar7uAc1G22jWGawzjqLyxqJbQTxTABlLoYNg1HeWes=; b=zmGJ70l68LdRNvmhXPe45NlIzv
	flW8vU7SiyFd0JYpgHBXNIBqbHRjIpob/SK6XZKLSG8c3pnWfb0hRyFjhXAGQH1Lwt5vjsC6oJmNO
	wsjRsejOVb1JNYyu0AhuCcF533GujPvPScXF/NoSm9ewcFFKDrZfpPzvh25m90AjKVeORDT2JGMg1
	AGcJ9URrTcQIshAzQOn89t1VJ+PkIDvgqcFXHLw9GFuqckadJuFFnbgEJnN7hbLdKYjW5nhPYqzEe
	v5rR2KRG9ifnprrk8GHLINszwA2ME9QxhqT/bEXz95KIDSO1R2q0FW6E6RAuk5En3QQg0ZAKq45dH
	2QVRFeVw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rZnK5-00000008GYA-2Fvt;
	Tue, 13 Feb 2024 07:35:21 +0000
Received: from [2001:4bb8:190:6eab:b680:8f97:4b38:866d] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rZnK1-00000008GSj-44Df;
	Tue, 13 Feb 2024 07:35:19 +0000
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
	Chaitanya Kulkarni <kch@nvidia.com>,
	Ming Lei <ming.lei@redhat.com>,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH 07/15] block: use queue_limits_commit_update in queue_discard_max_store
Date: Tue, 13 Feb 2024 08:34:17 +0100
Message-Id: <20240213073425.1621680-8-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240213073425.1621680-1-hch@lst.de>
References: <20240213073425.1621680-1-hch@lst.de>
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

Convert queue_discard_max_store to use queue_limits_commit_update to
check and update the max_discard_sectors limit and freeze the queue
before doing so to ensure we don't have requests in flight while
changing the limits.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Keith Busch <kbusch@kernel.org>
Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
Reviewed-by: Ming Lei <ming.lei@redhat.com>
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
Reviewed-by: Hannes Reinecke <hare@suse.de>
---
 block/blk-sysfs.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index a1ec27f0ba4150..8c8f69d8ba48ee 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -175,7 +175,9 @@ static ssize_t queue_discard_max_store(struct request_queue *q,
 				       const char *page, size_t count)
 {
 	unsigned long max_discard_bytes;
+	struct queue_limits lim;
 	ssize_t ret;
+	int err;
 
 	ret = queue_var_store(&max_discard_bytes, page, count);
 	if (ret < 0)
@@ -187,9 +189,14 @@ static ssize_t queue_discard_max_store(struct request_queue *q,
 	if ((max_discard_bytes >> SECTOR_SHIFT) > UINT_MAX)
 		return -EINVAL;
 
-	q->limits.max_user_discard_sectors = max_discard_bytes >> SECTOR_SHIFT;
-	q->limits.max_discard_sectors = min(q->limits.max_hw_discard_sectors,
-					    q->limits.max_user_discard_sectors);
+	blk_mq_freeze_queue(q);
+	lim = queue_limits_start_update(q);
+	lim.max_user_discard_sectors = max_discard_bytes >> SECTOR_SHIFT;
+	err = queue_limits_commit_update(q, &lim);
+	blk_mq_unfreeze_queue(q);
+
+	if (err)
+		return err;
 	return ret;
 }
 
-- 
2.39.2


