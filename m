Return-Path: <SRS0=0e7J=G5=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 846F1C433E6
	for <linux-nvme@archiver.kernel.org>; Tue, 26 Jan 2021 00:29:47 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 00CCC2075E
	for <linux-nvme@archiver.kernel.org>; Tue, 26 Jan 2021 00:29:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00CCC2075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:References:In-Reply-To:Message-Id:Date:Subject:To:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ZkI/PuOk7KERGrF0jHMli/PiZW+w0qQjkcmTDXth0WA=; b=bbHc+u02C50dRay2LJZ6iSEdS7
	Y7I/QTC5ITtegF1StGusJJekdpmwUN6N4SM4cV9rzHxgH4j1PHFA5bXPku4/RNivcvADxDgg0CduC
	Vr5+N4oEUF0UNPMPdYtrJY8TYddJWwc+zzTOSuXULJXOkGMZOR5D/OPuRfZy5nUofg9AOiWd/yVhQ
	/d/6nY/b0mUIdxME7J+3WvGisBWBJ5fVS427NNvfaMlU1BntQL44u8lI2im0oFSg0k7Ghp2Wvpllz
	YkLHtmc8pbMRFJjwLWA7e+IsXGRpISNHh4EV0lrLC2nXgPmtZDnL5eDyK7cZBcxf5aLEhgh1Yxunh
	QmQmGV8w==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l4CEN-0005Ou-Ul; Tue, 26 Jan 2021 00:29:16 +0000
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l4CEK-0005Nt-66
 for linux-nvme@lists.infradead.org; Tue, 26 Jan 2021 00:29:13 +0000
Received: by mail-pl1-x62d.google.com with SMTP id d4so8712279plh.5
 for <linux-nvme@lists.infradead.org>; Mon, 25 Jan 2021 16:29:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=1AHl1Jx34jtswhTgBtYxAYHOD6t8RmqegigD5lUsac8=;
 b=gA4LrW6ezNXmg9lXnOFBzmx/WQMapGLtPz5AUxxxYPROCquUMiYgpVgeuoDZfQwacZ
 4dwqRAO46GYB0vGxgzBJMA8HtmO7z8E2myH0rDY7GGbj75orW39T2cCO7wJlVrrCHZs4
 T542gosGDAcQv4rrktCCBwIxVTnEoNVBt4IFMKEz3q4DGsy2H5H0cQAngiUZo9W5c0XD
 oIjhCm5Pte2gNHuMjGQAOjE6RD3RKzvryxAdnLW5Z8vzBJsmAnJ/VXpCoXoPEafELaqj
 kKUiE6NfY5mXfU7bPtet06Qrjx9hlY/AiYeufbcwvfF85q/JbGN6IHuPHlbpVYvZc2RO
 lnCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=1AHl1Jx34jtswhTgBtYxAYHOD6t8RmqegigD5lUsac8=;
 b=DIiDa3YWkmJmPWdoydPUhF2fi2OsCXqEpA53hibt0pGZURnLfd/o+PktNa/ZN6FMEq
 g4Xh1TY+Vu+WGo1opHkFx8EVyQVP3LD+ABBxONNKD0SOHxecdPtYatDsJj0+IBCgj5qe
 crgfq1OKokS6uRwWe8FgzUZ7lo8YwYf3oGWFRDZYAgJRsXmzGtJIXPuAaafjClFat6Su
 DBL7woPs7GnAwppQJteRpt+wbIn6gEngvcPONuGcDCyTrPRjeJQj1ErIIQBEGRKjc9Yf
 YR+giWZR5O8tUTq6eYlnqIc3Gc9WamBMqhqn/eZT9tScONsOQMVIovFkNMbEA/f3fu2j
 Etxw==
X-Gm-Message-State: AOAM532GDQ4CFOqoROfSpd9LB0y5a3Dd48q1vIvaNOCvbyn3vUq//IiQ
 3zMVDC304Ui0mGFEVzrYwH8=
X-Google-Smtp-Source: ABdhPJyE9yobq1Vsf/eirkfosewjx3+aPxw3rFxwL5/dV9oYN0s9MY6mWyTofZqBXmFwH8TqPbigWA==
X-Received: by 2002:a17:90b:350:: with SMTP id
 fh16mr3029352pjb.232.1611620950036; 
 Mon, 25 Jan 2021 16:29:10 -0800 (PST)
Received: from localhost.localdomain ([211.108.35.36])
 by smtp.gmail.com with ESMTPSA id 14sm16999418pfi.131.2021.01.25.16.29.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Jan 2021 16:29:09 -0800 (PST)
From: Minwoo Im <minwoo.im.dev@gmail.com>
To: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-fsdevel@vger.kernel.org
Subject: [PATCH V6 1/1] block: reject I/O for same fd if block size changed
Date: Tue, 26 Jan 2021 09:29:01 +0900
Message-Id: <20210126002901.5533-2-minwoo.im.dev@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210126002901.5533-1-minwoo.im.dev@gmail.com>
References: <20210126002901.5533-1-minwoo.im.dev@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210125_192912_233618_72643DC3 
X-CRM114-Status: GOOD (  25.15  )
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
Cc: Jens Axboe <axboe@kernel.dk>, Minwoo Im <minwoo.im.dev@gmail.com>,
 Alexander Viro <viro@zeniv.linux.org.uk>, Christoph Hellwig <hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

This patch fixes I/O errors during BLKRRPART ioctl() behavior right
after format operation that changed logical block size of the block
device with a same file descriptor opened.

This issue can be easily reproduced with a single format command in case
of NVMe (logical block size 512B to 4096B).

	nvme format /dev/nvme0n1 --lbaf=1 --force

This is because the application, nvme-cli format subcommand issues an
admin command followed by BLKRRPART ioctl to re-read partition
information without closing the file descriptor.  If file descriptor
stays opened, __blkdev_get() will not be invoked at all even logical
block size has been changed.

It will cause I/O errors with invalid Read operations during the
BLKRRPART ioctl due to i_blkbits mismatch. The invalid operations in
BLKRRPART happens with under-flowed Number of LBA(NLB) values
0xffff(65535) because i_blkbits is still set to 9 even the logical block
size has been updated to 4096.  The BLKRRPART will lead buffer_head to
hold 512B data which is less than the logical lock size of the block
device.

The root cause, which is because i_blkbits of inode of the block device
is not updated, can be solved easily by re-opening file descriptor
again from application.  But, that's just for application's business
and kernel should reject invalid Read operations during the BLKRRPART
ioctl.

This patch rejects I/O from the path of add_partitions() to avoid
issuing invalid Read operations to device.  It sets a flag to
request_queue in blk_queue_logical_block_size to minimize caller-side
updates.

Signed-off-by: Minwoo Im <minwoo.im.dev@gmail.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-settings.c    |  3 +++
 block/partitions/core.c | 12 ++++++++++++
 fs/block_dev.c          |  8 ++++++++
 include/linux/blkdev.h  |  1 +
 4 files changed, 24 insertions(+)

diff --git a/block/blk-settings.c b/block/blk-settings.c
index 4c974340f1a9..5b1e0bf54d7e 100644
--- a/block/blk-settings.c
+++ b/block/blk-settings.c
@@ -329,6 +329,9 @@ void blk_queue_logical_block_size(struct request_queue *q, unsigned int size)
 {
 	struct queue_limits *limits = &q->limits;
 
+	if (limits->logical_block_size != size)
+		blk_queue_flag_set(QUEUE_FLAG_LBSZ_CHANGED, q);
+
 	limits->logical_block_size = size;
 
 	if (limits->physical_block_size < size)
diff --git a/block/partitions/core.c b/block/partitions/core.c
index b1cdf88f96e2..092d6712c7fc 100644
--- a/block/partitions/core.c
+++ b/block/partitions/core.c
@@ -601,12 +601,24 @@ static bool blk_add_partition(struct gendisk *disk, struct block_device *bdev,
 
 int blk_add_partitions(struct gendisk *disk, struct block_device *bdev)
 {
+	struct request_queue *q = bdev_get_queue(bdev);
 	struct parsed_partitions *state;
 	int ret = -EAGAIN, p;
 
 	if (!disk_part_scan_enabled(disk))
 		return 0;
 
+	/*
+	 * Reject to check partition information if block size has been changed
+	 * in the runtime.  If block size of a block device has been changed,
+	 * the file descriptor should be opened agian to update the blkbits.
+	 */
+	if (test_bit(QUEUE_FLAG_LBSZ_CHANGED, &q->queue_flags)) {
+		pr_warn("%s: rejecting checking partition. fd should be opened again.\n",
+				disk->disk_name);
+		return -EBADFD;
+	}
+
 	state = check_partition(disk, bdev);
 	if (!state)
 		return 0;
diff --git a/fs/block_dev.c b/fs/block_dev.c
index 6f5bd9950baf..8555308c503d 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -130,7 +130,15 @@ EXPORT_SYMBOL(truncate_bdev_range);
 
 static void set_init_blocksize(struct block_device *bdev)
 {
+	struct request_queue *q = bdev_get_queue(bdev);
+
 	bdev->bd_inode->i_blkbits = blksize_bits(bdev_logical_block_size(bdev));
+
+	/*
+	 * Allow I/O commands for this block device.  We can say that this
+	 * block device has proper blkbits updated.
+	 */
+	blk_queue_flag_clear(QUEUE_FLAG_LBSZ_CHANGED, q);
 }
 
 int set_blocksize(struct block_device *bdev, int size)
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 20f3706b6b2e..f725e933db40 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -621,6 +621,7 @@ struct request_queue {
 #define QUEUE_FLAG_RQ_ALLOC_TIME 27	/* record rq->alloc_time_ns */
 #define QUEUE_FLAG_HCTX_ACTIVE	28	/* at least one blk-mq hctx is active */
 #define QUEUE_FLAG_NOWAIT       29	/* device supports NOWAIT */
+#define QUEUE_FLAG_LBSZ_CHANGED	30	/* logical block size changed */
 
 #define QUEUE_FLAG_MQ_DEFAULT	((1 << QUEUE_FLAG_IO_STAT) |		\
 				 (1 << QUEUE_FLAG_SAME_COMP) |		\
-- 
2.17.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
