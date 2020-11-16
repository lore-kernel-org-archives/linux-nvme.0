Return-Path: <SRS0=rzv5=EW=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBD5BC4742C
	for <linux-nvme@archiver.kernel.org>; Mon, 16 Nov 2020 15:15:48 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C6F622240
	for <linux-nvme@archiver.kernel.org>; Mon, 16 Nov 2020 15:15:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="gQeqpwNw";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="VdELZpYq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C6F622240
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=eVZwhLDhvI0b82QgYrmKGO1s/vhoUfaMjuscp6Eh6vI=; b=gQeqpwNwnlSnkTcLDEvuRX90J
	xPcgWjDJeQXMSMcS32oIDJYSvJay6ZfqxvKYM21ag9WFmgZK4UoE6kaa6isJSWUMsZifxtH4I09qU
	UQMAFXhQCzWLs+jKeM2pxlaO0Jc57r3eZVs6zY1yJ5FzPVWwHFZsA9WM5k2wIEwJ5lRowD++WlTbt
	A1UUUDYu9kPzzZzVnjJjLC/kGoa+hSPJ95jptqmTlfbFN3/aHl6Ee7mWVPb23s+kwC/TQQQZFgFmw
	ikaCYbhtgDE6+3cg21qR+CmivPVbxy21klPn2SqFAMXUCAf8HnkbrOGKG4oDEWleIYcBEqWEFWZJ5
	CdoQNVoHA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kegE6-0004GG-PH; Mon, 16 Nov 2020 15:15:34 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kefz2-00048j-1l
 for linux-nvme@merlin.infradead.org; Mon, 16 Nov 2020 14:59:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description;
 bh=MRrZvPHBJ7MmOJqwCwh6BOwzTdjIUug0RFrQfdUF4D0=; b=VdELZpYq+wC9PRGd7E7gW7f022
 iWbf/yBwlwECTqIWeSXdM3vxnd7C5rUPQt4zYgr4w4y5VS7aEw4XAXZZL1+gLjTfVzbErgItFolKx
 NoEr+DW9LtrWG9rcze2kkbyopscePeN91WRL96HJxHAuEnkYQzapbI9qst3MaFX6akHBdBUBm7/eb
 Ud1nBnozpN0bnLBzUbAJlQGLF7WvSR9ySOqhWBvr5OEnKwbk0b1hc36z3Q1K2nfJ5d/hpkLfSI8aB
 GuaLrCyXWDM01VUM6hy+z+KyIliSIUOnGWO2OtY/JMGDpZLn+Yks0DpKHFYl+4qlADIgIFPwiG6NQ
 nFJMH8wg==;
Received: from [2001:4bb8:180:6600:255b:7def:a93:4a09] (helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kefyy-0004HD-T0; Mon, 16 Nov 2020 14:59:53 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 71/78] block: add a bdev_kobj helper
Date: Mon, 16 Nov 2020 15:58:02 +0100
Message-Id: <20201116145809.410558-72-hch@lst.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201116145809.410558-1-hch@lst.de>
References: <20201116145809.410558-1-hch@lst.de>
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
Cc: Justin Sanders <justin@coraid.com>, Mike Snitzer <snitzer@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 linux-nvme@lists.infradead.org, Song Liu <song@kernel.org>,
 dm-devel@redhat.com, drbd-dev@lists.linbit.com, linux-scsi@vger.kernel.org,
 xen-devel@lists.xenproject.org, Ilya Dryomov <idryomov@gmail.com>,
 Jack Wang <jinpu.wang@cloud.ionos.com>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 Josef Bacik <josef@toxicpanda.com>, nbd@other.debian.org,
 linux-raid@vger.kernel.org, Stefan Hajnoczi <stefanha@redhat.com>,
 ceph-devel@vger.kernel.org, linux-block@vger.kernel.org,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Minchan Kim <minchan@kernel.org>, linux-fsdevel@vger.kernel.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Roger=20Pau=20Monn=C3=A9?= <roger.pau@citrix.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Add a little helper to find the kobject for a struct block_device.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/md/bcache/super.c |  7 ++-----
 drivers/md/md.c           |  4 +---
 fs/btrfs/sysfs.c          | 15 +++------------
 include/linux/blk_types.h |  3 +++
 4 files changed, 9 insertions(+), 20 deletions(-)

diff --git a/drivers/md/bcache/super.c b/drivers/md/bcache/super.c
index ea2b80c3e44c38..f6edacc81527c7 100644
--- a/drivers/md/bcache/super.c
+++ b/drivers/md/bcache/super.c
@@ -1447,8 +1447,7 @@ static int register_bdev(struct cache_sb *sb, struct cache_sb_disk *sb_disk,
 		goto err;
 
 	err = "error creating kobject";
-	if (kobject_add(&dc->disk.kobj, &part_to_dev(bdev->bd_part)->kobj,
-			"bcache"))
+	if (kobject_add(&dc->disk.kobj, bdev_kobj(bdev), "bcache"))
 		goto err;
 	if (bch_cache_accounting_add_kobjs(&dc->accounting, &dc->disk.kobj))
 		goto err;
@@ -2342,9 +2341,7 @@ static int register_cache(struct cache_sb *sb, struct cache_sb_disk *sb_disk,
 		goto err;
 	}
 
-	if (kobject_add(&ca->kobj,
-			&part_to_dev(bdev->bd_part)->kobj,
-			"bcache")) {
+	if (kobject_add(&ca->kobj, bdev_kobj(bdev), "bcache")) {
 		err = "error calling kobject_add";
 		ret = -ENOMEM;
 		goto out;
diff --git a/drivers/md/md.c b/drivers/md/md.c
index b2edf5e0f965b5..7ce6047c856ea2 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -2414,7 +2414,6 @@ EXPORT_SYMBOL(md_integrity_add_rdev);
 static int bind_rdev_to_array(struct md_rdev *rdev, struct mddev *mddev)
 {
 	char b[BDEVNAME_SIZE];
-	struct kobject *ko;
 	int err;
 
 	/* prevent duplicates */
@@ -2477,9 +2476,8 @@ static int bind_rdev_to_array(struct md_rdev *rdev, struct mddev *mddev)
 	if ((err = kobject_add(&rdev->kobj, &mddev->kobj, "dev-%s", b)))
 		goto fail;
 
-	ko = &part_to_dev(rdev->bdev->bd_part)->kobj;
 	/* failure here is OK */
-	err = sysfs_create_link(&rdev->kobj, ko, "block");
+	err = sysfs_create_link(&rdev->kobj, bdev_kobj(rdev->bdev), "block");
 	rdev->sysfs_state = sysfs_get_dirent_safe(rdev->kobj.sd, "state");
 	rdev->sysfs_unack_badblocks =
 		sysfs_get_dirent_safe(rdev->kobj.sd, "unacknowledged_bad_blocks");
diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
index 279d9262b676d4..24b6c6dc69000a 100644
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -1232,8 +1232,6 @@ int btrfs_sysfs_add_space_info_type(struct btrfs_fs_info *fs_info,
 
 void btrfs_sysfs_remove_device(struct btrfs_device *device)
 {
-	struct hd_struct *disk;
-	struct kobject *disk_kobj;
 	struct kobject *devices_kobj;
 
 	/*
@@ -1243,11 +1241,8 @@ void btrfs_sysfs_remove_device(struct btrfs_device *device)
 	devices_kobj = device->fs_info->fs_devices->devices_kobj;
 	ASSERT(devices_kobj);
 
-	if (device->bdev) {
-		disk = device->bdev->bd_part;
-		disk_kobj = &part_to_dev(disk)->kobj;
-		sysfs_remove_link(devices_kobj, disk_kobj->name);
-	}
+	if (device->bdev)
+		sysfs_remove_link(devices_kobj, bdev_kobj(device->bdev)->name);
 
 	if (device->devid_kobj.state_initialized) {
 		kobject_del(&device->devid_kobj);
@@ -1353,11 +1348,7 @@ int btrfs_sysfs_add_device(struct btrfs_device *device)
 	nofs_flag = memalloc_nofs_save();
 
 	if (device->bdev) {
-		struct hd_struct *disk;
-		struct kobject *disk_kobj;
-
-		disk = device->bdev->bd_part;
-		disk_kobj = &part_to_dev(disk)->kobj;
+		struct kobject *disk_kobj = bdev_kobj(device->bdev);
 
 		ret = sysfs_create_link(devices_kobj, disk_kobj, disk_kobj->name);
 		if (ret) {
diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index 0735e335ca6c0a..5a5ccacb804cdb 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -49,6 +49,9 @@ struct block_device {
 #define bdev_whole(_bdev) \
 	((_bdev)->bd_disk->part0.bdev)
 
+#define bdev_kobj(_bdev) \
+	(&part_to_dev((_bdev)->bd_part)->kobj)
+
 /*
  * Block error status values.  See block/blk-core:blk_errors for the details.
  * Alpha cannot write a byte atomically, so we need to use 32-bit value.
-- 
2.29.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
