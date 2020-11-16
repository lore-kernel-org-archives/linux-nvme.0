Return-Path: <SRS0=rzv5=EW=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45C94C5519F
	for <linux-nvme@archiver.kernel.org>; Mon, 16 Nov 2020 15:09:47 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A764922240
	for <linux-nvme@archiver.kernel.org>; Mon, 16 Nov 2020 15:09:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="hwX/65kK";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="cAGojbsp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A764922240
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=WrPYEzupCjmNrtVWkA8gKx+wT8ZlPgH9GZBr/ayLzzk=; b=hwX/65kKNRoLd60a2+dmgke3E
	t9bP6aGHKIVPJd8CH0N98dGk8hbnlUfJK3pT0g0/AjPngHS2y5KS8VJW347CJePjkpMDPyk4BVrxL
	B4LTRKhIqKE21KiZalMX0VsQQ7o/6tB8IvjEjjQVJoBmCqJRVLMLI023wNYop8PEGnYdc6XiFgQGY
	dQi19daCkoxylZ84yl2cn6iDF0E0mKS+GfC6uBTVfsXJrOYvfl2AgEJMO9yg62Ucs/eqK3ydq38Uv
	xrH1IA9lNs33kh9guU2cqKPICKL8MXL90a/stC+C0WrRDBmofB+108W6pcbVGRX/ssboZJmTjdDPb
	FSiJeRh+A==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1keg8U-0001jR-2h; Mon, 16 Nov 2020 15:09:42 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kefyX-0003rY-I7
 for linux-nvme@merlin.infradead.org; Mon, 16 Nov 2020 14:59:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description;
 bh=G/1St6AKcpua/c8qIsi4IENao5SAFeNTsicWvdwJGKA=; b=cAGojbspvBWLkhCqOD3ExDenEy
 hsbkbexTXugOliCWH3wwCYbwxpTnVtQvHgLrTwVXI7TrPcURLYokj4yyAxwxnnG9BNHdwGnWa8IJp
 dYa+F3Gfpccic7jbe1Y8gwBkRHM+oEunUjIG3WI5m5UONDYn9V9VBRbIHSxNQhGM/1JRKjD49Xkx0
 0pBHsNUFU/UPntTwF6P/GQ0sJw5J/q2+RSCrhYYdXSuMK/KdhdMuk9LCQiscZHIVOefv7v6KYkI86
 OblDiO3zLuOm232EWEv9/powerW9w8u+EGbE5WQyTuk7Cg+xA59dLIs/S/NWj2DLWnBN8UoHAueaN
 ZQN++kOA==;
Received: from [2001:4bb8:180:6600:255b:7def:a93:4a09] (helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kefyU-00043H-JC; Mon, 16 Nov 2020 14:59:23 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 51/78] z2ram: use separate gendisk for the different modes
Date: Mon, 16 Nov 2020 15:57:42 +0100
Message-Id: <20201116145809.410558-52-hch@lst.de>
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

Use separate gendisks (which share a tag_set) for the different operating
modes instead of redirecting the gendisk lookup using a probe callback.
This avoids potential problems with aliased block_device instances and
will eventually allow for removing the blk_register_region framework.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Hannes Reinecke <hare@suse.de>
---
 drivers/block/z2ram.c | 100 ++++++++++++++++++++++++------------------
 1 file changed, 58 insertions(+), 42 deletions(-)

diff --git a/drivers/block/z2ram.c b/drivers/block/z2ram.c
index eafecc9a72b38d..c1d20818e64920 100644
--- a/drivers/block/z2ram.c
+++ b/drivers/block/z2ram.c
@@ -63,7 +63,7 @@ static int current_device = -1;
 
 static DEFINE_SPINLOCK(z2ram_lock);
 
-static struct gendisk *z2ram_gendisk;
+static struct gendisk *z2ram_gendisk[Z2MINOR_COUNT];
 
 static blk_status_t z2_queue_rq(struct blk_mq_hw_ctx *hctx,
 				const struct blk_mq_queue_data *bd)
@@ -283,7 +283,7 @@ static int z2_open(struct block_device *bdev, fmode_t mode)
 
 		current_device = device;
 		z2ram_size <<= Z2RAM_CHUNKSHIFT;
-		set_capacity(z2ram_gendisk, z2ram_size >> 9);
+		set_capacity(z2ram_gendisk[device], z2ram_size >> 9);
 	}
 
 	mutex_unlock(&z2ram_mutex);
@@ -315,71 +315,87 @@ static const struct block_device_operations z2_fops = {
 	.release = z2_release,
 };
 
-static struct kobject *z2_find(dev_t dev, int *part, void *data)
-{
-	*part = 0;
-	return get_disk_and_module(z2ram_gendisk);
-}
-
-static struct request_queue *z2_queue;
 static struct blk_mq_tag_set tag_set;
 
 static const struct blk_mq_ops z2_mq_ops = {
 	.queue_rq = z2_queue_rq,
 };
 
+static int z2ram_register_disk(int minor)
+{
+	struct request_queue *q;
+	struct gendisk *disk;
+
+	disk = alloc_disk(1);
+	if (!disk)
+		return -ENOMEM;
+
+	q = blk_mq_init_queue(&tag_set);
+	if (IS_ERR(q)) {
+		put_disk(disk);
+		return PTR_ERR(q);
+	}
+
+	disk->major = Z2RAM_MAJOR;
+	disk->first_minor = minor;
+	disk->fops = &z2_fops;
+	if (minor)
+		sprintf(disk->disk_name, "z2ram%d", minor);
+	else
+		sprintf(disk->disk_name, "z2ram");
+	disk->queue = q;
+
+	z2ram_gendisk[minor] = disk;
+	add_disk(disk);
+	return 0;
+}
+
 static int __init z2_init(void)
 {
-	int ret;
+	int ret, i;
 
 	if (!MACH_IS_AMIGA)
 		return -ENODEV;
 
-	ret = -EBUSY;
 	if (register_blkdev(Z2RAM_MAJOR, DEVICE_NAME))
-		goto err;
-
-	ret = -ENOMEM;
-	z2ram_gendisk = alloc_disk(1);
-	if (!z2ram_gendisk)
-		goto out_disk;
-
-	z2_queue = blk_mq_init_sq_queue(&tag_set, &z2_mq_ops, 16,
-					BLK_MQ_F_SHOULD_MERGE);
-	if (IS_ERR(z2_queue)) {
-		ret = PTR_ERR(z2_queue);
-		z2_queue = NULL;
-		goto out_queue;
+		return -EBUSY;
+
+	tag_set.ops = &z2_mq_ops;
+	tag_set.nr_hw_queues = 1;
+	tag_set.nr_maps = 1;
+	tag_set.queue_depth = 16;
+	tag_set.numa_node = NUMA_NO_NODE;
+	tag_set.flags = BLK_MQ_F_SHOULD_MERGE;
+	ret = blk_mq_alloc_tag_set(&tag_set);
+	if (ret)
+		goto out_unregister_blkdev;
+
+	for (i = 0; i < Z2MINOR_COUNT; i++) {
+		ret = z2ram_register_disk(i);
+		if (ret && i == 0)
+			goto out_free_tagset;
 	}
 
-	z2ram_gendisk->major = Z2RAM_MAJOR;
-	z2ram_gendisk->first_minor = 0;
-	z2ram_gendisk->fops = &z2_fops;
-	sprintf(z2ram_gendisk->disk_name, "z2ram");
-
-	z2ram_gendisk->queue = z2_queue;
-	add_disk(z2ram_gendisk);
-	blk_register_region(MKDEV(Z2RAM_MAJOR, 0), Z2MINOR_COUNT, THIS_MODULE,
-			    z2_find, NULL, NULL);
-
 	return 0;
 
-out_queue:
-	put_disk(z2ram_gendisk);
-out_disk:
+out_free_tagset:
+	blk_mq_free_tag_set(&tag_set);
+out_unregister_blkdev:
 	unregister_blkdev(Z2RAM_MAJOR, DEVICE_NAME);
-err:
 	return ret;
 }
 
 static void __exit z2_exit(void)
 {
 	int i, j;
-	blk_unregister_region(MKDEV(Z2RAM_MAJOR, 0), Z2MINOR_COUNT);
+
 	unregister_blkdev(Z2RAM_MAJOR, DEVICE_NAME);
-	del_gendisk(z2ram_gendisk);
-	put_disk(z2ram_gendisk);
-	blk_cleanup_queue(z2_queue);
+
+	for (i = 0; i < Z2MINOR_COUNT; i++) {
+		del_gendisk(z2ram_gendisk[i]);
+		blk_cleanup_queue(z2ram_gendisk[i]->queue);
+		put_disk(z2ram_gendisk[i]);
+	}
 	blk_mq_free_tag_set(&tag_set);
 
 	if (current_device != -1) {
-- 
2.29.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
