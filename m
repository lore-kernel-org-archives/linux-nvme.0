Return-Path: <SRS0=rzv5=EW=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3D88C5519F
	for <linux-nvme@archiver.kernel.org>; Mon, 16 Nov 2020 15:08:47 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 78B1D22240
	for <linux-nvme@archiver.kernel.org>; Mon, 16 Nov 2020 15:08:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ZfV7GcwN";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="QuaAvRf4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78B1D22240
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=K6TdwGpeprQJ73qLP9rmW1GNKq5Iqx+xxvOmo8fAJ/A=; b=ZfV7GcwNXLd1NYY/KAvwAPjD+
	0Ry/0OWs9d820ge10SS7tt1/cLt9npz28YHoimSyIyKsnWOdo+h2UDO3YsVGd8EiW1NhDbEC0SfTo
	PdgbkTxX+jmFq33b+tibvWQTVCPmXRb2bALa8qCGjVWsVTrYGyEoKOGMz/mp455kUP4kUnaThmGon
	RTI++1SUt8kF7lVY+6yPKIfQnxGKqU3s2tzwTy8Fk+Wn1PaNQ4fNMrLFKErF2tgdQEKtSdl92OQZt
	OQKF2WYBBlUY9zz0K2Igblsdm3cin256sssh8iuE2khaZAfynB6sEToTdG8fPgHyJ0wVWQBzM+QSG
	JHz7VzcAg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1keg7S-0001MP-4x; Mon, 16 Nov 2020 15:08:38 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kefyT-0003pZ-KB
 for linux-nvme@merlin.infradead.org; Mon, 16 Nov 2020 14:59:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description;
 bh=VpFTnx8mSRVx3CfXvp0WWOpahH+qOqL0mP+Plef//Dw=; b=QuaAvRf47Sgn9ESoWOtbCEEgKf
 SoaxupntT7YcBZyDBufAz89YGCb7+GAKx9JrFGTvtb5gkr5Mrj1a5W/A5DrAzDitUTF1NGhPPsRi1
 SwVqYv0iBeIK7LPoNhiBiDMfP76vlVOCz5Xf7CxEP2Fi3mTEXQJHqC/WuP7Qu3AmsaO2RNIWflVNw
 HDQluFLq+Cexw+XqCWcvsLMuEyrXOagZfpeUVxdZeb9NaJWSWPy5zSF1aMVGD0p6spy3vB3r2LtM3
 DuVbxT8CDDONVntDglOll0hYSPlE1qzQ6tCXf2v/dx8BmBOznqiTmYL594fNkkwXRuptP0wmQJyGf
 43+tbRTQ==;
Received: from [2001:4bb8:180:6600:255b:7def:a93:4a09] (helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kefyQ-000416-5g; Mon, 16 Nov 2020 14:59:18 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 48/78] amiflop: use separate gendisks for Amiga vs MS-DOS mode
Date: Mon, 16 Nov 2020 15:57:39 +0100
Message-Id: <20201116145809.410558-49-hch@lst.de>
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
 linux-raid@vger.kernel.org, Hannes Reinecke <hare@suse.de>,
 Stefan Hajnoczi <stefanha@redhat.com>, ceph-devel@vger.kernel.org,
 linux-block@vger.kernel.org, "Martin K. Petersen" <martin.petersen@oracle.com>,
 Minchan Kim <minchan@kernel.org>, linux-fsdevel@vger.kernel.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Roger=20Pau=20Monn=C3=A9?= <roger.pau@citrix.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Use separate gendisks (which share a tag_set) for the native Amgiga vs
the MS-DOS mode instead of redirecting the gendisk lookup using a probe
callback.  This avoids potential problems with aliased block_device
instances and will eventually allow for removing the blk_register_region
framework.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Hannes Reinecke <hare@suse.de>
---
 drivers/block/amiflop.c | 98 +++++++++++++++++++++++------------------
 1 file changed, 55 insertions(+), 43 deletions(-)

diff --git a/drivers/block/amiflop.c b/drivers/block/amiflop.c
index 71c2b156455860..9e2d0c6a387721 100644
--- a/drivers/block/amiflop.c
+++ b/drivers/block/amiflop.c
@@ -201,7 +201,7 @@ struct amiga_floppy_struct {
 	int busy;			/* true when drive is active */
 	int dirty;			/* true when trackbuf is not on disk */
 	int status;			/* current error code for unit */
-	struct gendisk *gendisk;
+	struct gendisk *gendisk[2];
 	struct blk_mq_tag_set tag_set;
 };
 
@@ -1669,6 +1669,11 @@ static int floppy_open(struct block_device *bdev, fmode_t mode)
 		return -EBUSY;
 	}
 
+	if (unit[drive].type->code == FD_NODRIVE) {
+		mutex_unlock(&amiflop_mutex);
+		return -ENXIO;
+	}
+
 	if (mode & (FMODE_READ|FMODE_WRITE)) {
 		bdev_check_media_change(bdev);
 		if (mode & FMODE_WRITE) {
@@ -1695,7 +1700,7 @@ static int floppy_open(struct block_device *bdev, fmode_t mode)
 	unit[drive].dtype=&data_types[system];
 	unit[drive].blocks=unit[drive].type->heads*unit[drive].type->tracks*
 		data_types[system].sects*unit[drive].type->sect_mult;
-	set_capacity(unit[drive].gendisk, unit[drive].blocks);
+	set_capacity(unit[drive].gendisk[system], unit[drive].blocks);
 
 	printk(KERN_INFO "fd%d: accessing %s-disk with %s-layout\n",drive,
 	       unit[drive].type->name, data_types[system].name);
@@ -1772,36 +1777,68 @@ static const struct blk_mq_ops amiflop_mq_ops = {
 	.queue_rq = amiflop_queue_rq,
 };
 
-static struct gendisk *fd_alloc_disk(int drive)
+static int fd_alloc_disk(int drive, int system)
 {
 	struct gendisk *disk;
 
 	disk = alloc_disk(1);
 	if (!disk)
 		goto out;
-
-	disk->queue = blk_mq_init_sq_queue(&unit[drive].tag_set, &amiflop_mq_ops,
-						2, BLK_MQ_F_SHOULD_MERGE);
-	if (IS_ERR(disk->queue)) {
-		disk->queue = NULL;
+	disk->queue = blk_mq_init_queue(&unit[drive].tag_set);
+	if (IS_ERR(disk->queue))
 		goto out_put_disk;
-	}
 
+	disk->major = FLOPPY_MAJOR;
+	disk->first_minor = drive + system;
+	disk->fops = &floppy_fops;
+	disk->events = DISK_EVENT_MEDIA_CHANGE;
+	if (system)
+		sprintf(disk->disk_name, "fd%d_msdos", drive);
+	else
+		sprintf(disk->disk_name, "fd%d", drive);
+	disk->private_data = &unit[drive];
+	set_capacity(disk, 880 * 2);
+
+	unit[drive].gendisk[system] = disk;
+	add_disk(disk);
+	return 0;
+
+out_put_disk:
+	disk->queue = NULL;
+	put_disk(disk);
+out:
+	return -ENOMEM;
+}
+
+static int fd_alloc_drive(int drive)
+{
 	unit[drive].trackbuf = kmalloc(FLOPPY_MAX_SECTORS * 512, GFP_KERNEL);
 	if (!unit[drive].trackbuf)
-		goto out_cleanup_queue;
+		goto out;
 
-	return disk;
+	memset(&unit[drive].tag_set, 0, sizeof(unit[drive].tag_set));
+	unit[drive].tag_set.ops = &amiflop_mq_ops;
+	unit[drive].tag_set.nr_hw_queues = 1;
+	unit[drive].tag_set.nr_maps = 1;
+	unit[drive].tag_set.queue_depth = 2;
+	unit[drive].tag_set.numa_node = NUMA_NO_NODE;
+	unit[drive].tag_set.flags = BLK_MQ_F_SHOULD_MERGE;
+	if (blk_mq_alloc_tag_set(&unit[drive].tag_set))
+		goto out_cleanup_trackbuf;
 
-out_cleanup_queue:
-	blk_cleanup_queue(disk->queue);
-	disk->queue = NULL;
+	pr_cont(" fd%d", drive);
+
+	if (fd_alloc_disk(drive, 0) || fd_alloc_disk(drive, 1))
+		goto out_cleanup_tagset;
+	return 0;
+
+out_cleanup_tagset:
 	blk_mq_free_tag_set(&unit[drive].tag_set);
-out_put_disk:
-	put_disk(disk);
+out_cleanup_trackbuf:
+	kfree(unit[drive].trackbuf);
 out:
 	unit[drive].type->code = FD_NODRIVE;
-	return NULL;
+	return -ENOMEM;
 }
 
 static int __init fd_probe_drives(void)
@@ -1812,29 +1849,16 @@ static int __init fd_probe_drives(void)
 	drives=0;
 	nomem=0;
 	for(drive=0;drive<FD_MAX_UNITS;drive++) {
-		struct gendisk *disk;
 		fd_probe(drive);
 		if (unit[drive].type->code == FD_NODRIVE)
 			continue;
 
-		disk = fd_alloc_disk(drive);
-		if (!disk) {
+		if (fd_alloc_drive(drive) < 0) {
 			pr_cont(" no mem for fd%d", drive);
 			nomem = 1;
 			continue;
 		}
-		unit[drive].gendisk = disk;
 		drives++;
-
-		pr_cont(" fd%d",drive);
-		disk->major = FLOPPY_MAJOR;
-		disk->first_minor = drive;
-		disk->fops = &floppy_fops;
-		disk->events = DISK_EVENT_MEDIA_CHANGE;
-		sprintf(disk->disk_name, "fd%d", drive);
-		disk->private_data = &unit[drive];
-		set_capacity(disk, 880*2);
-		add_disk(disk);
 	}
 	if ((drives > 0) || (nomem == 0)) {
 		if (drives == 0)
@@ -1846,15 +1870,6 @@ static int __init fd_probe_drives(void)
 	return -ENOMEM;
 }
  
-static struct kobject *floppy_find(dev_t dev, int *part, void *data)
-{
-	int drive = *part & 3;
-	if (unit[drive].type->code == FD_NODRIVE)
-		return NULL;
-	*part = 0;
-	return get_disk_and_module(unit[drive].gendisk);
-}
-
 static int __init amiga_floppy_probe(struct platform_device *pdev)
 {
 	int i, ret;
@@ -1884,9 +1899,6 @@ static int __init amiga_floppy_probe(struct platform_device *pdev)
 	if (fd_probe_drives() < 1) /* No usable drives */
 		goto out_probe;
 
-	blk_register_region(MKDEV(FLOPPY_MAJOR, 0), 256, THIS_MODULE,
-				floppy_find, NULL, NULL);
-
 	/* initialize variables */
 	timer_setup(&motor_on_timer, motor_on_callback, 0);
 	motor_on_timer.expires = 0;
-- 
2.29.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
