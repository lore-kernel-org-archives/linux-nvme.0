Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 804E4C43334
	for <linux-nvme@archiver.kernel.org>; Fri, 22 Jul 2022 12:12:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:Subject:Cc:
	To:From:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=9194NUmzzpHs+OSvzxpnu7M72O0VjRp3jiwQaoC09RM=; b=wePA0VXQNsUABwpO4KOQb1jjHs
	EoR/28T3xVWtVQtG6XhLBW6Z7pVyW8BKqkPnB7aMzyCoaJb4yXh+H3hgGXrVbipix/u6lh3Cnqee/
	/DJuGUqnxe2qejy3nI72M6vG26bMRJtFpERog0tppTAhW2hL/t5Nf+u9Fjs5XuwhTLFIq9voPdwim
	8XGiDmMOrhQmakxgOyxatYhqIllKqPOHPF8opTemZ/n1lgSgHnhBuArj5OltIjYXBaQFyOqyczB9n
	zUM6mLD0UbderA6LFslEVz1gjELg09tSJHHWDcN7umCcR+H9CWt/FHnUgqcskQPVUIohcxJBoQttd
	Cmbl08KQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oErWL-0041Vc-PQ; Fri, 22 Jul 2022 12:12:41 +0000
Received: from out30-57.freemail.mail.aliyun.com ([115.124.30.57])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oErWH-0041Ki-Ul
	for linux-nvme@lists.infradead.org; Fri, 22 Jul 2022 12:12:40 +0000
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R811e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0VK54yNB_1658491944;
Received: from localhost(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0VK54yNB_1658491944)
          by smtp.aliyun-inc.com;
          Fri, 22 Jul 2022 20:12:28 +0800
From: Guixin Liu <kanie@linux.alibaba.com>
To: hch@lst.de,
	sagi@grimberg.me,
	kch@nvidia.com
Cc: linux-nvme@lists.infradead.org
Subject: [PATCH] nvmet: avoid unnecessary fsync and flush bio
Date: Fri, 22 Jul 2022 20:12:24 +0800
Message-Id: <1658491944-34701-1-git-send-email-kanie@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220722_051238_206099_C335ADB4 
X-CRM114-Status: GOOD (  10.29  )
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

For none buffered_io file backend and no volatile write cache
block device backend, fsync and flush bio are both unnecessary,
avoid to do that.

Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
---
 drivers/nvme/target/io-cmd-bdev.c | 11 +++++++++++
 drivers/nvme/target/io-cmd-file.c |  5 ++++-
 2 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/target/io-cmd-bdev.c b/drivers/nvme/target/io-cmd-bdev.c
index 2dc1c10..64f3eb0 100644
--- a/drivers/nvme/target/io-cmd-bdev.c
+++ b/drivers/nvme/target/io-cmd-bdev.c
@@ -333,10 +333,16 @@ static void nvmet_bdev_execute_rw(struct nvmet_req *req)
 static void nvmet_bdev_execute_flush(struct nvmet_req *req)
 {
 	struct bio *bio = &req->b.inline_bio;
+	struct request_queue *q = req->ns->bdev->bd_queue;
 
 	if (!nvmet_check_transfer_len(req, 0))
 		return;
 
+	if (!test_bit(QUEUE_FLAG_WC, &q->queue_flags)) {
+		nvmet_req_complete(req, NVME_SC_SUCCESS);
+		return;
+	}
+
 	bio_init(bio, req->ns->bdev, req->inline_bvec,
 		 ARRAY_SIZE(req->inline_bvec), REQ_OP_WRITE | REQ_PREFLUSH);
 	bio->bi_private = req;
@@ -347,6 +353,11 @@ static void nvmet_bdev_execute_flush(struct nvmet_req *req)
 
 u16 nvmet_bdev_flush(struct nvmet_req *req)
 {
+	struct request_queue *q = req->ns->bdev->bd_queue;
+
+	if (!test_bit(QUEUE_FLAG_WC, &q->queue_flags))
+		return 0;
+
 	if (blkdev_issue_flush(req->ns->bdev))
 		return NVME_SC_INTERNAL | NVME_SC_DNR;
 	return 0;
diff --git a/drivers/nvme/target/io-cmd-file.c b/drivers/nvme/target/io-cmd-file.c
index 64b47e2..801fb8a 100644
--- a/drivers/nvme/target/io-cmd-file.c
+++ b/drivers/nvme/target/io-cmd-file.c
@@ -268,7 +268,10 @@ static void nvmet_file_execute_rw(struct nvmet_req *req)
 
 u16 nvmet_file_flush(struct nvmet_req *req)
 {
-	return errno_to_nvme_status(req, vfs_fsync(req->ns->file, 1));
+	if (req->ns->buffered_io)
+		return errno_to_nvme_status(req, vfs_fsync(req->ns->file, 1));
+	else
+		return errno_to_nvme_status(req, 0);
 }
 
 static void nvmet_file_flush_work(struct work_struct *w)
-- 
1.8.3.1


