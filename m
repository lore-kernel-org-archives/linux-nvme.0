Return-Path: <SRS0=uaVC=IP=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87BCCC433DB
	for <linux-nvme@archiver.kernel.org>; Wed, 17 Mar 2021 22:12:08 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F209D64F18
	for <linux-nvme@archiver.kernel.org>; Wed, 17 Mar 2021 22:12:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F209D64F18
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=Tz0+8SuLDTDp/IES1V5+NtyFwNJy0gj8X2R/8Q+AHQM=; b=DyDeoyVKcGv/DMIFkdCcHZrbf
	E9orn8XL1TqP943lZW9l6D3zQgAvXsetx0NjGoiynLu3cYUaLI8sgleiyTZpJMIOS+etOhJ1pAHD9
	Z/B5VRTvuofTVZoAzzt+zpdMBsBGCpXu69/VrJ43jVytR+oRXDNJBp9KuC4i4XVJwjtNGsHCp3Ikk
	v1k9Lc56ZVPCje09GBFkut0VwVGx/JDY8F1BR+egM9j375yda14yirqZbi4PajMmC66BURRJ1TiRu
	5HCuSAwzVsVx17WqwafukEKLbOY6cMRpJv0TgklLuDOM2IjDihhfBCpV/XYLs+DTbYEMCxOrzU36g
	XXtQcd5Mg==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lMeOI-0040DW-NA; Wed, 17 Mar 2021 22:11:47 +0000
Received: from mail-io1-xd2c.google.com ([2607:f8b0:4864:20::d2c])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lMeNB-004032-KI
 for linux-nvme@lists.infradead.org; Wed, 17 Mar 2021 22:10:39 +0000
Received: by mail-io1-xd2c.google.com with SMTP id n21so190538ioa.7
 for <linux-nvme@lists.infradead.org>; Wed, 17 Mar 2021 15:10:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel-dk.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=8W7+YYUKDmGyivm8spLtYU/+YJefZ0TTuK53JMdcwuc=;
 b=kJpn053CDGSDSFKkT+BuV67pbHLv+J3RjCdYZU8NrHGWb+A1JSkLWM7WTUD9FwMm9P
 rbP8YDN40/AEzZuerKFc0YSSlUvDr/VXpFPQyuuukUtgK5tdQrulT3802piNYEzVAcqc
 RMhYvZIL2TwX9zA+xkM1AAG6cVcXgq7hn6O/LzO1VBu7ODTEl6RHEBRkKYxJPjsAGXJA
 MIqxD0x3N6hK/bUt4LKuq9yqz5xIcbnNvnr4Fna/zQtx6mg3moV/SKG+3rRyIjOQqvlU
 /YodPoCjNMLI/pYZ5cDhMnxl0C5jV0W2Q3xz2FRyDJmmkQWiQjNjNIRJ5PGh05UA6Awe
 H0Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=8W7+YYUKDmGyivm8spLtYU/+YJefZ0TTuK53JMdcwuc=;
 b=kQHqfUvj2VuM7KN8PsCGOtKf+ooroYUYo8uRRoxdDCaKAfOzpDoUy91bRkbhvFytFX
 /gQLBktDMdSGM0QvSfdtRQQUhuVI1CT9npWwueQ4drYvUX7HSbH2Xr03rsiDlLLtJjJe
 IhwQXG9eDhYYVCmIOgwLLHavD4NydOOGkwPPZigK6hbv3sryAUIJGrd5BTooObEKkvSG
 qVq0H6rzOmMYd5ckxl/EUmynWnW/VK4ib7jVAKECcK6As4v3i01p1+dWlohpah7VzaCG
 VEYl0/Wx8JzeGFdKF4J/CEIuiQnk7wpaUzDEBpgHwso3n6vLs0VInquFqBTn1EYchS12
 I4bA==
X-Gm-Message-State: AOAM533TcvmcnUq4Kgm5/rbJPgsv9hswM1fKHgCRx+H4mMvOUFrdrsU2
 sq/SrbXALOE450RsSUoLe83/nA==
X-Google-Smtp-Source: ABdhPJw5Ck1Am8737XlkTvQ8dG9m//Gff1fYra95vWECv4y5EfCwE/8akIC1dsAJSv+7yV4ooLZGFQ==
X-Received: by 2002:a5d:8b09:: with SMTP id k9mr8011584ion.185.1616019036485; 
 Wed, 17 Mar 2021 15:10:36 -0700 (PDT)
Received: from p1.localdomain ([65.144.74.34])
 by smtp.gmail.com with ESMTPSA id r3sm160700ilq.42.2021.03.17.15.10.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Mar 2021 15:10:36 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: io-uring@vger.kernel.org
Cc: joshi.k@samsung.com, hch@lst.de, kbusch@kernel.org,
 linux-nvme@lists.infradead.org, metze@samba.org,
 Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 5/8] block: wire up support for file_operations->uring_cmd()
Date: Wed, 17 Mar 2021 16:10:24 -0600
Message-Id: <20210317221027.366780-6-axboe@kernel.dk>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20210317221027.366780-1-axboe@kernel.dk>
References: <20210317221027.366780-1-axboe@kernel.dk>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210317_221037_770156_DEA20507 
X-CRM114-Status: GOOD (  14.31  )
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

Pass it through the mq_ops->uring_cmd() handler, so we can plumb it
through all the way to the device driver.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 block/blk-mq.c         | 11 +++++++++++
 fs/block_dev.c         | 10 ++++++++++
 include/linux/blk-mq.h |  6 ++++++
 include/linux/blkdev.h |  2 ++
 4 files changed, 29 insertions(+)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index d4d7c1caa439..6c68540a89c0 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -3919,6 +3919,17 @@ int blk_poll(struct request_queue *q, blk_qc_t cookie, bool spin)
 }
 EXPORT_SYMBOL_GPL(blk_poll);
 
+int blk_uring_cmd(struct block_device *bdev, struct io_uring_cmd *cmd,
+		  enum io_uring_cmd_flags issue_flags)
+{
+	struct request_queue *q = bdev_get_queue(bdev);
+
+	if (!q->mq_ops || !q->mq_ops->uring_cmd)
+		return -EOPNOTSUPP;
+
+	return q->mq_ops->uring_cmd(q, cmd, issue_flags);
+}
+
 unsigned int blk_mq_rq_cpu(struct request *rq)
 {
 	return rq->mq_ctx->cpu;
diff --git a/fs/block_dev.c b/fs/block_dev.c
index 92ed7d5df677..cbc403ad0330 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -34,6 +34,7 @@
 #include <linux/part_stat.h>
 #include <linux/uaccess.h>
 #include <linux/suspend.h>
+#include <linux/io_uring.h>
 #include "internal.h"
 
 struct bdev_inode {
@@ -317,6 +318,14 @@ struct blkdev_dio {
 
 static struct bio_set blkdev_dio_pool;
 
+static int blkdev_uring_cmd(struct io_uring_cmd *cmd,
+			    enum io_uring_cmd_flags flags)
+{
+	struct block_device *bdev = I_BDEV(cmd->file->f_mapping->host);
+
+	return blk_uring_cmd(bdev, cmd, flags);
+}
+
 static int blkdev_iopoll(struct kiocb *kiocb, bool wait)
 {
 	struct block_device *bdev = I_BDEV(kiocb->ki_filp->f_mapping->host);
@@ -1840,6 +1849,7 @@ const struct file_operations def_blk_fops = {
 	.splice_read	= generic_file_splice_read,
 	.splice_write	= iter_file_splice_write,
 	.fallocate	= blkdev_fallocate,
+	.uring_cmd	= blkdev_uring_cmd,
 };
 
 /**
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 2c473c9b8990..70ee55c148c1 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -376,6 +376,12 @@ struct blk_mq_ops {
 	 */
 	int (*map_queues)(struct blk_mq_tag_set *set);
 
+	/**
+	 * @uring_cmd: queues requests through io_uring IORING_OP_URING_CMD
+	 */
+	int (*uring_cmd)(struct request_queue *q, struct io_uring_cmd *cmd,
+				enum io_uring_cmd_flags issue_flags);
+
 #ifdef CONFIG_BLK_DEBUG_FS
 	/**
 	 * @show_rq: Used by the debugfs implementation to show driver-specific
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index bc6bc8383b43..7eb993e82783 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -957,6 +957,8 @@ int blk_status_to_errno(blk_status_t status);
 blk_status_t errno_to_blk_status(int errno);
 
 int blk_poll(struct request_queue *q, blk_qc_t cookie, bool spin);
+int blk_uring_cmd(struct block_device *bdev, struct io_uring_cmd *cmd,
+			enum io_uring_cmd_flags issue_flags);
 
 static inline struct request_queue *bdev_get_queue(struct block_device *bdev)
 {
-- 
2.31.0


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
