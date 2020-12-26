Return-Path: <SRS0=+HbQ=F6=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40108C433DB
	for <linux-nvme@archiver.kernel.org>; Sat, 26 Dec 2020 18:03:16 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED77E2082D
	for <linux-nvme@archiver.kernel.org>; Sat, 26 Dec 2020 18:03:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED77E2082D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=iZmA8SiSUJU8k1ycxVY7FLf8Z/PscohYoHLGEXQ4hUs=; b=RPQ+JtnBVbRjY3cnCtL39sdtU/
	qq3ddFu4IhG+CFIJs8+dqSqv2WgGUxx9Ud10wRuDOeFdoIrC6D+Yrw9j2qDZ2jqGwX6fnJ0Tb330Z
	GAYdceCUZ/eE5QJkYEiUIJhFEkgvUbmGdOEy2vQFQfb51/TjMg1ANF7IWPoRke7Z+E7u5emsA+/Al
	GOBxi42mKPrxA6oBtkOpV4FoDGtfWSTvIDUGgqcEZSGEqke8CN3vYl62VasB9O9RczPRELBmDAO2x
	j+6rNTxGs0B8xbqWPcdBfwSbrNQFhgSFlz84bgvQz0pwHf1aPXS4w68frZn/wHy1OcB5Ty5dUC76E
	rYBTOhJg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1ktDuF-0000Ox-Rw; Sat, 26 Dec 2020 18:03:07 +0000
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1ktDuD-0000Ns-3v
 for linux-nvme@lists.infradead.org; Sat, 26 Dec 2020 18:03:06 +0000
Received: by mail-pj1-x1035.google.com with SMTP id z12so3832891pjn.1
 for <linux-nvme@lists.infradead.org>; Sat, 26 Dec 2020 10:03:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=4Y9ogSPZ5hMKc7DdJiGJQd2mRtdieX3VWNe0j8nL7fs=;
 b=oFzNCb19GRT8pD+LMUtLpzqB7x0DS2l3VE5mW0qt2uThPZgjTqulgHPnz85BlJkLSx
 bs4sdbwrPDLWPSOnXUDofSnCWETl7KE2mu4/HlYuKgVftBKLo4LPZFHXGP12FbFJo1jK
 n5LIsRKAALfaG8B+KuBrC1W/beB9FwWZwjNuNSdGGUDmSp+Lype/0IRV2ZpBh0rqIfmM
 uyuR6xd0lHnx9RES/VR8t/Y0oYR9QBJfzqrV1Bbu9BPlkmNTNCG/Em5jEOOD04oWMrRN
 jroJNH+Vq/FFFDv63UUMegnuKbTT2PgIoMvowhp4mcqYov+yKV4oQRqg0wYcZThXf1qW
 nE6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=4Y9ogSPZ5hMKc7DdJiGJQd2mRtdieX3VWNe0j8nL7fs=;
 b=XtGdKDp+tBXonyuciT93dxbQBJNZCawWO1mZ765gHm/wQECWN6mhp89l7DCKJOl7Sq
 qRPbpSwb7UfxhbqCJ/gwc+TZAR8y8KdjdQkFAQg1/lGmz26leAvbAk02f1M/KX26Q0kg
 +oSlZMuNaaFFT5OFSot2S8W5/QtUC8WxY2VzVETxgzRR57gl3yZZe4MCLPHMcHi0l6JT
 3G8ZB8PjzNeSzDqvGo3+7YQXiw50zECH8hUzPP4smtLnpllFpSnJoxlTzwVCJ8G/BgRx
 wcXdS6Mj2M8JKR66h7Nd1szVmhM0tS8Q12+STyfB3w+SlN3m6yTT8MdM6ClkR4OWGvzv
 c7xg==
X-Gm-Message-State: AOAM530EAyimmiCjl+Tpiulq/bxuqBwG0ECXuJc9226rWSc3XRp3N9nL
 /wmQxWfPHH7w+RzSTcY1Das=
X-Google-Smtp-Source: ABdhPJz1uhDLovrvbxwVJp0TqNK5JCQe3WYP09y4W3OhTDX1X//+4z1RlU16CKm+TeuGFRktfNgoIw==
X-Received: by 2002:a17:90a:b395:: with SMTP id
 e21mr13617612pjr.197.1609005779506; 
 Sat, 26 Dec 2020 10:02:59 -0800 (PST)
Received: from localhost.localdomain ([211.108.35.36])
 by smtp.gmail.com with ESMTPSA id e24sm8467038pjt.16.2020.12.26.10.02.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 26 Dec 2020 10:02:58 -0800 (PST)
From: Minwoo Im <minwoo.im.dev@gmail.com>
To: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: [RFC] block: reject I/O in BLKRRPART if block size changed
Date: Sun, 27 Dec 2020 03:02:32 +0900
Message-Id: <20201226180232.12276-1-minwoo.im.dev@gmail.com>
X-Mailer: git-send-email 2.17.1
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201226_130305_214823_85BC434B 
X-CRM114-Status: GOOD (  23.54  )
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

Background:
  Let's say we have 2 LBA format for 4096B and 512B LBA size for a
NVMe namespace.  Assume that current LBA format is 4096B and in case
we convert namespace to 512B and 4096B back again:

  nvme format /dev/nvme0n1 --lbaf=1 --force  # to 512B LBA
  nvme format /dev/nvme0n1 --lbaf=0 --force  # to 4096B LBA

  Then we can see the following errors during the BLKRRPART ioctl from
the nvme-cli format subcommand:

  [   10.771740] blk_update_request: operation not supported error, dev nvme0n1, sector 0 op 0x0:(READ) flags 0x0 phys_seg 1 prio class 0
  [   10.780262] Buffer I/O error on dev nvme0n1, logical block 0, async page read
  ...

  Also, we can see the Read commands followed by the Format command due
to BLKRRPART ioctl with Number of LBAs to 65535(0xffff) which is
under-flowed because the request for the Read commands are coming with
512B and this is because it's playing around with i_blkbits from the
block_device inode which needs to be avoided as [1].

  kworker/0:1H-56      [000] ....   913.456922: nvme_setup_cmd: nvme0: disk=nvme0n1, qid=1, cmdid=216, nsid=1, flags=0x0, meta=0x0, cmd=(nvme_cmd_read slba=0, len=65535, ctrl=0x0, dsmgmt=0, reftag=0)
  ksoftirqd/0-9       [000] .Ns.   916.566351: nvme_complete_rq: nvme0: disk=nvme0n1, qid=1, cmdid=216, res=0x0, retries=0, flags=0x0, status=0x4002
  ...

  Before we have commit 5ff9f19231a0 ("block: simplify
set_init_blocksize"), block size used to be bumped up to the
4K(PAGE_SIZE) in this example and we have not seen these errors.  But
with this patch, we have to make sure that bdev->bd_inode->i_blkbits to
make sure that BLKRRPART ioctl pass proper request length based on the
changed logical block size.

Description:
  As the previous discussion [1], this patch introduced a gendisk flag
to indicate that block size has been changed in the runtime.  This flag
is set when logical block size is changed in the runtime with sector
capacity itself.  It will be cleared when the file descriptor for the
block devie is opened again which means __blkdev_get() updates the block
size via set_init_blocksize().
  This patch rejects I/O from the path of add_partitions() and
application should open the file descriptor again to update the block
size of the block device inode.

[1] https://lore.kernel.org/linux-nvme/20201223183143.GB13354@localhost.localdomain/T/#t

Signed-off-by: Minwoo Im <minwoo.im.dev@gmail.com>
---
 block/genhd.c           |  3 +++
 block/partitions/core.c | 11 +++++++++++
 fs/block_dev.c          |  6 ++++++
 include/linux/genhd.h   |  1 +
 4 files changed, 21 insertions(+)

diff --git a/block/genhd.c b/block/genhd.c
index b84b8671e627..1f64907fac3d 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -79,6 +79,9 @@ bool set_capacity_and_notify(struct gendisk *disk, sector_t size)
 	 */
 	if (!capacity || !size)
 		return false;
+
+	disk->flags |= GENHD_FL_BLOCK_SIZE_CHANGED;
+
 	kobject_uevent_env(&disk_to_dev(disk)->kobj, KOBJ_CHANGE, envp);
 	return true;
 }
diff --git a/block/partitions/core.c b/block/partitions/core.c
index deca253583bd..7dfcda96be9e 100644
--- a/block/partitions/core.c
+++ b/block/partitions/core.c
@@ -617,6 +617,17 @@ int blk_add_partitions(struct gendisk *disk, struct block_device *bdev)
 	if (!disk_part_scan_enabled(disk))
 		return 0;
 
+	/*
+	 * Reject to check partition information if block size has been changed
+	 * in the runtime.  If block size of a block device has been changed,
+	 * the file descriptor should be opened agian to update the blkbits.
+	 */
+	if (disk->flags & GENHD_FL_BLOCK_SIZE_CHANGED) {
+		pr_warn("%s: rejecting checking partition. fd should be opened again.\n",
+				disk->disk_name);
+		return -EBADFD;
+	}
+
 	state = check_partition(disk, bdev);
 	if (!state)
 		return 0;
diff --git a/fs/block_dev.c b/fs/block_dev.c
index 9e56ee1f2652..813361ad77c1 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -132,6 +132,12 @@ EXPORT_SYMBOL(truncate_bdev_range);
 static void set_init_blocksize(struct block_device *bdev)
 {
 	bdev->bd_inode->i_blkbits = blksize_bits(bdev_logical_block_size(bdev));
+
+	/*
+	 * Allow I/O commands for this block device.  We can say that this
+	 * block device has been set to a proper block size.
+	 */
+	bdev->bd_disk->flags &= ~GENHD_FL_BLOCK_SIZE_CHANGED;
 }
 
 int set_blocksize(struct block_device *bdev, int size)
diff --git a/include/linux/genhd.h b/include/linux/genhd.h
index 809aaa32d53c..0e0e24917003 100644
--- a/include/linux/genhd.h
+++ b/include/linux/genhd.h
@@ -103,6 +103,7 @@ struct partition_meta_info {
 #define GENHD_FL_BLOCK_EVENTS_ON_EXCL_WRITE	0x0100
 #define GENHD_FL_NO_PART_SCAN			0x0200
 #define GENHD_FL_HIDDEN				0x0400
+#define GENHD_FL_BLOCK_SIZE_CHANGED		0x0800
 
 enum {
 	DISK_EVENT_MEDIA_CHANGE			= 1 << 0, /* media changed */
-- 
2.17.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
