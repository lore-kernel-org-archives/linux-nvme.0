Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A083C433EF
	for <linux-nvme@archiver.kernel.org>; Mon, 25 Jul 2022 06:28:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:Subject:Cc:
	To:From:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=d3i4aeQj54C28A82xtF+DKFlL8AtYggik0/NwrEaVxs=; b=Z6knvcC337P2eWLIM15Pk9vfu6
	osge8lIPShPlfAkw8OFtUXLR8D06+mb37QfJBRFRJlSq63EzKYvBzTlDWqnXL9QeXGlhnkfAlnLnR
	n04VFF69qX1yLV5AWW5TPQSdsX41e+1cmzu75B7tsT4HGoL7El9y7v4GnrDvucu5YBqPiGpmfLXrT
	I1BBBuIa25AknG4YzsbUz3gE+BuokFxxM87/4qm0ANz3z6wx6+G9b8PgB9pDUO6qz9YaeCQDwyd8z
	FIHfml9wuK9WZBz6Z4L3AysfnfoMOhZIGcZxWCSSml/ppsw3V5WJMeBx76Uo1n+ZDHuBgGKqdgOzl
	vMBVj1wA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oFrZx-005Qzx-EO; Mon, 25 Jul 2022 06:28:33 +0000
Received: from out30-43.freemail.mail.aliyun.com ([115.124.30.43])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oFrZs-005QwG-VY
	for linux-nvme@lists.infradead.org; Mon, 25 Jul 2022 06:28:31 +0000
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0VKIYGYA_1658730498;
Received: from localhost(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0VKIYGYA_1658730498)
          by smtp.aliyun-inc.com;
          Mon, 25 Jul 2022 14:28:22 +0800
From: Guixin Liu <kanie@linux.alibaba.com>
To: hch@lst.de,
	sagi@grimberg.me,
	kch@nvidia.com
Cc: linux-nvme@lists.infradead.org
Subject: [PATCH v2] nvmet: avoid unnecessary fsync and flush bio
Date: Mon, 25 Jul 2022 14:28:18 +0800
Message-Id: <1658730498-11857-1-git-send-email-kanie@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220724_232829_608636_8CE043AC 
X-CRM114-Status: GOOD (  10.99  )
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
Changes on v2:
- Use bdev_write_cache instead of open code.
- Use NVME_SC_SUCCESS instead of translation, and remove "else".

 drivers/nvme/target/io-cmd-bdev.c | 8 ++++++++
 drivers/nvme/target/io-cmd-file.c | 4 +++-
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/target/io-cmd-bdev.c b/drivers/nvme/target/io-cmd-bdev.c
index 2dc1c10..e63fe87 100644
--- a/drivers/nvme/target/io-cmd-bdev.c
+++ b/drivers/nvme/target/io-cmd-bdev.c
@@ -337,6 +337,11 @@ static void nvmet_bdev_execute_flush(struct nvmet_req *req)
 	if (!nvmet_check_transfer_len(req, 0))
 		return;
 
+	if (!bdev_write_cache(req->ns->bdev)) {
+		nvmet_req_complete(req, NVME_SC_SUCCESS);
+		return;
+	}
+
 	bio_init(bio, req->ns->bdev, req->inline_bvec,
 		 ARRAY_SIZE(req->inline_bvec), REQ_OP_WRITE | REQ_PREFLUSH);
 	bio->bi_private = req;
@@ -347,6 +352,9 @@ static void nvmet_bdev_execute_flush(struct nvmet_req *req)
 
 u16 nvmet_bdev_flush(struct nvmet_req *req)
 {
+	if (!bdev_write_cache(req->ns->bdev))
+		return 0;
+
 	if (blkdev_issue_flush(req->ns->bdev))
 		return NVME_SC_INTERNAL | NVME_SC_DNR;
 	return 0;
diff --git a/drivers/nvme/target/io-cmd-file.c b/drivers/nvme/target/io-cmd-file.c
index 64b47e2..fdff026 100644
--- a/drivers/nvme/target/io-cmd-file.c
+++ b/drivers/nvme/target/io-cmd-file.c
@@ -268,7 +268,9 @@ static void nvmet_file_execute_rw(struct nvmet_req *req)
 
 u16 nvmet_file_flush(struct nvmet_req *req)
 {
-	return errno_to_nvme_status(req, vfs_fsync(req->ns->file, 1));
+	if (req->ns->buffered_io)
+		return errno_to_nvme_status(req, vfs_fsync(req->ns->file, 1));
+	return NVME_SC_SUCCESS;
 }
 
 static void nvmet_file_flush_work(struct work_struct *w)
-- 
1.8.3.1


