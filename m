Return-Path: <SRS0=mRFX=GI=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71611C433E0
	for <linux-nvme@archiver.kernel.org>; Tue,  5 Jan 2021 12:27:52 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 297FF22AAA
	for <linux-nvme@archiver.kernel.org>; Tue,  5 Jan 2021 12:27:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 297FF22AAA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:References:In-Reply-To:Message-Id:Date:Subject:To:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6I2cw2WTCi20IC9js7DL6gbIcYjhk8MSZUjdqmvDCyQ=; b=DN4qda5WfBYkWvu12rL4W/XwSH
	EwRBHWYbxn9PofPvum98P4Zi1cT578T7XcBwnYg/1y1ewSm2I6y1ydKqPgINrSYeyrSXja0QahQVi
	MsCgBzBa8fyew7neZ+MltQEIe/llK7OIX1/7usm9O/yQKVFF0fVkJRzvfa/gWrLiKEphd766kVq+z
	2XG4tEyzjWkMcC3X8EtRNJ2im+Mqgi/vIeU9bTHivX365Ug+GfuYUYvTAhD2g1EIKcT4gj4h8X9dn
	VBzjMgaya55YnvhqdBHKerPx3HKaI9g9l5jpsxjudjDoPh866S83fO7z7tMeAB+GpkCSP6LeJKPvj
	jvGqFKZQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kwlRA-0003tN-3P; Tue, 05 Jan 2021 12:27:44 +0000
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kwlR6-0003rl-TQ
 for linux-nvme@lists.infradead.org; Tue, 05 Jan 2021 12:27:41 +0000
Received: by mail-pl1-x62b.google.com with SMTP id x12so16274409plr.10
 for <linux-nvme@lists.infradead.org>; Tue, 05 Jan 2021 04:27:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=GCJpwmdnZwt/uKHRtY639LOCKcFjRCkpFiLLDLiMMTA=;
 b=PpZvIHnwPrR7ghtYY4A7PxSbHFOQgPwblp/MQCEEf5Bv+Tzumyt6ZOoqnVARIheYG9
 DB1JTZwlUWKoyoQNgTS8+AUchogb3rYh9144A8Y7JFhwydB8/vxeOs/BWPBXOt8odHGD
 sTTuGXq561TDfKTh+LwvPyhtrY0Np5Oa+FzC1/Vipwx069MuOSP1WVSL/Dxq1jgeZKov
 3ADMhysUDyvbFMAixgKb3HfgKoNj+UtcnnsY3vzUVZGdnUqCN03hv7ZyLKaLqLEYn9r+
 CuuYQr0P08+1/uyWNv3vp1CIhxP9iqTdHV5NT6kDAYQvqx2b29njNkkuk+uX50JdU4a+
 R5Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=GCJpwmdnZwt/uKHRtY639LOCKcFjRCkpFiLLDLiMMTA=;
 b=rNTPp4E+7O+RHy/bqive/wZBP8rxDc5ns4NYgNH6oT22gtWgT/1kaaiftS4wdT0CBn
 M8geOKOUAOke5eQHLjWMCffiNX5E1DWHdyveCqInARMaKwDh1zJKTN7GR3iszUbwJ+0x
 CtzN1Zaj0ho34f1OZxhf3koV+uakaBUBpu3XPdId/4u/Cxt+JmW6uOuUAGknxbKBJgq6
 Io73Gp3AdG9R4+1pLgV+/m8MYDOGu1/6PepbwiMVbxGS5rst6YuVE0VW1DVGiQ88dB+/
 TJYa//DUupIo6KSScRG7Dio5xTC1IGa5M93BUW+KF8+Fpb5RG7cIPI2OLlVmTHruYw7m
 wG5g==
X-Gm-Message-State: AOAM533+VsMy5q5/fi3xkAFBZvTPVP4Z9AmmSwP5kUcoqgD0zxGkUJbn
 gXAcEBuE0Rc6pQGQPOQfoRA=
X-Google-Smtp-Source: ABdhPJxHmldIRQrvO77IFzCFAUMwQikmaQIQwCUv1MOp5bwFqwX7c01BVi88X+weOQ5v4sUVoZ1Fdg==
X-Received: by 2002:a17:90a:5509:: with SMTP id
 b9mr3874173pji.230.1609849658703; 
 Tue, 05 Jan 2021 04:27:38 -0800 (PST)
Received: from localhost.localdomain ([211.108.35.36])
 by smtp.gmail.com with ESMTPSA id gw7sm2599647pjb.36.2021.01.05.04.27.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Jan 2021 04:27:38 -0800 (PST)
From: Minwoo Im <minwoo.im.dev@gmail.com>
To: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: [PATCH V4 1/1] block: reject I/O for same fd if block size changed
Date: Tue,  5 Jan 2021 21:27:17 +0900
Message-Id: <20210105122717.2568-2-minwoo.im.dev@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210105122717.2568-1-minwoo.im.dev@gmail.com>
References: <20210105122717.2568-1-minwoo.im.dev@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210105_072740_983972_034DCD15 
X-CRM114-Status: GOOD (  25.18  )
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
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
 Christoph Hellwig <hch@lst.de>
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
---
 block/blk-settings.c    |  3 +++
 block/partitions/core.c | 12 ++++++++++++
 fs/block_dev.c          |  8 ++++++++
 include/linux/blkdev.h  |  1 +
 4 files changed, 24 insertions(+)

diff --git a/block/blk-settings.c b/block/blk-settings.c
index 43990b1d148b..48a6fc7bb5f5 100644
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
index e7d776db803b..6f175ea18ff3 100644
--- a/block/partitions/core.c
+++ b/block/partitions/core.c
@@ -612,12 +612,24 @@ static bool blk_add_partition(struct gendisk *disk, struct block_device *bdev,
 
 int blk_add_partitions(struct gendisk *disk, struct block_device *bdev)
 {
+	struct request_queue *q = bdev_get_queue(bdev);
 	struct parsed_partitions *state;
 	int ret = -EAGAIN, p, highest;
 
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
index 9293045e128c..8056a412a3d1 100644
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
index 070de09425ad..6d0542434be6 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -625,6 +625,7 @@ struct request_queue {
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
