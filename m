Return-Path: <SRS0=ZjMq=ND=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CEA7C4338F
	for <linux-nvme@archiver.kernel.org>; Thu, 12 Aug 2021 07:57:35 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E3A3160FED
	for <linux-nvme@archiver.kernel.org>; Thu, 12 Aug 2021 07:57:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E3A3160FED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=EXYYjGwdsEsmTQMX4DuzqQv/PyXMy/5ZhK+KSE9u1MI=; b=2Szjq8GAApXq0I
	3kUgLnkzkwuHvWvhrTECplqC4Pp/gTUtpuyTh2DvNewAzEN1+NV9s64SsSVJjRQsqYyL+Wu8hIu0L
	lcSw7UMbw463hq21DhwUcCblavIo5uBLreMkERFRUpOf2p2GKVc+DIJDvFW59NYWvBd6hZUZQDevG
	ey+DEeizDS59E/QdA+ILpEWXog9rFfwoijawxBuMbKSqUCOD/3wZLaSVkVsaYBkrZUW9qRS0rnkf+
	jG5FEVadPm77jcziFxtCYHIcG3tfE4P5loXtnNV6cQLchwgJd0qqqcJTfycxj9Sb4U4VVhZnsYxib
	ljgP3g8JYmY/Stz9tXtw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mE5aS-0090Yf-LI; Thu, 12 Aug 2021 07:57:12 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mE5Th-008z8K-UV
 for linux-nvme@bombadil.infradead.org; Thu, 12 Aug 2021 07:50:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description;
 bh=+ZgCPc9R+8ZqAnkdxHmSlgsiJBgy6LBHpiGslEIsu7U=; b=vuZdD+TJNSCEHgQ1FizBz9Sib9
 0rW7sDwjnU8Iz8WwaYfr1xxIdoWyeomovpVk9botMAjHztCBWqe/JJXUkF5Z8SHcg5BhwMX0+P8Vv
 JPaquJsbzxABH6HmFPsqP8/EkI+HLLeyISw6t6qrtnbp41Go8ypZlb6UrjhrmFb1IGXoVpisT47dN
 EYFrfd77y6ydZ7bpleNh76VAW9ztd5kpb+Vr84yR5xYCVZNo9COtvCicJrg7XIjuUYM86/GKlHmfp
 N6hbyKIPTSAvIc/p8BS2ADt4h8VOcREdgHOCLHcXlRdmODrKIxtnmJ3p9BwsJHCafP/ssxiBvNbLC
 bwM+H6nQ==;
Received: from [2001:4bb8:184:6215:d7d:1904:40de:694d] (helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mE5Sl-00EIsT-9C; Thu, 12 Aug 2021 07:49:29 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Stefan Haberland <sth@linux.ibm.com>,
 Jan Hoeppner <hoeppner@linux.ibm.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Doug Gilbert <dgilbert@interlog.com>,
 =?UTF-8?q?Kai=20M=C3=A4kisara?= <Kai.Makisara@kolumbus.fi>,
 Luis Chamberlain <mcgrof@kernel.org>, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-s390@vger.kernel.org,
 linux-scsi@vger.kernel.org
Subject: [PATCH 3/8] sg: do not allocate a gendisk
Date: Thu, 12 Aug 2021 09:46:37 +0200
Message-Id: <20210812074642.18592-4-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210812074642.18592-1-hch@lst.de>
References: <20210812074642.18592-1-hch@lst.de>
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
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

sg is a character driver and thus does not need to allocate a gendisk,
which is only used for file system-like block layer I/O on block
devices.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/scsi/sg.c | 32 +++++++++-----------------------
 1 file changed, 9 insertions(+), 23 deletions(-)

diff --git a/drivers/scsi/sg.c b/drivers/scsi/sg.c
index 91e2221bbb0d..477267add49d 100644
--- a/drivers/scsi/sg.c
+++ b/drivers/scsi/sg.c
@@ -166,7 +166,7 @@ typedef struct sg_device { /* holds the state of each scsi generic device */
 	bool exclude;		/* 1->open(O_EXCL) succeeded and is active */
 	int open_cnt;		/* count of opens (perhaps < num(sfds) ) */
 	char sgdebug;		/* 0->off, 1->sense, 9->dump dev, 10-> all devs */
-	struct gendisk *disk;
+	char name[DISK_NAME_LEN];
 	struct cdev * cdev;	/* char_dev [sysfs: /sys/cdev/major/sg<n>] */
 	struct kref d_ref;
 } Sg_device;
@@ -202,8 +202,7 @@ static void sg_device_destroy(struct kref *kref);
 #define SZ_SG_REQ_INFO sizeof(sg_req_info_t)
 
 #define sg_printk(prefix, sdp, fmt, a...) \
-	sdev_prefix_printk(prefix, (sdp)->device,		\
-			   (sdp)->disk->disk_name, fmt, ##a)
+	sdev_prefix_printk(prefix, (sdp)->device, (sdp)->name, fmt, ##a)
 
 /*
  * The SCSI interfaces that use read() and write() as an asynchronous variant of
@@ -832,7 +831,7 @@ sg_common_write(Sg_fd * sfp, Sg_request * srp,
 
 	srp->rq->timeout = timeout;
 	kref_get(&sfp->f_ref); /* sg_rq_end_io() does kref_put(). */
-	blk_execute_rq_nowait(sdp->disk, srp->rq, at_head, sg_rq_end_io);
+	blk_execute_rq_nowait(NULL, srp->rq, at_head, sg_rq_end_io);
 	return 0;
 }
 
@@ -1119,8 +1118,7 @@ sg_ioctl_common(struct file *filp, Sg_device *sdp, Sg_fd *sfp,
 		return put_user(max_sectors_bytes(sdp->device->request_queue),
 				ip);
 	case BLKTRACESETUP:
-		return blk_trace_setup(sdp->device->request_queue,
-				       sdp->disk->disk_name,
+		return blk_trace_setup(sdp->device->request_queue, NULL,
 				       MKDEV(SCSI_GENERIC_MAJOR, sdp->index),
 				       NULL, p);
 	case BLKTRACESTART:
@@ -1456,7 +1454,7 @@ static struct class *sg_sysfs_class;
 static int sg_sysfs_valid = 0;
 
 static Sg_device *
-sg_alloc(struct gendisk *disk, struct scsi_device *scsidp)
+sg_alloc(struct scsi_device *scsidp)
 {
 	struct request_queue *q = scsidp->request_queue;
 	Sg_device *sdp;
@@ -1492,9 +1490,7 @@ sg_alloc(struct gendisk *disk, struct scsi_device *scsidp)
 
 	SCSI_LOG_TIMEOUT(3, sdev_printk(KERN_INFO, scsidp,
 					"sg_alloc: dev=%d \n", k));
-	sprintf(disk->disk_name, "sg%d", k);
-	disk->first_minor = k;
-	sdp->disk = disk;
+	sprintf(sdp->name, "sg%d", k);
 	sdp->device = scsidp;
 	mutex_init(&sdp->open_rel_lock);
 	INIT_LIST_HEAD(&sdp->sfds);
@@ -1521,19 +1517,11 @@ static int
 sg_add_device(struct device *cl_dev, struct class_interface *cl_intf)
 {
 	struct scsi_device *scsidp = to_scsi_device(cl_dev->parent);
-	struct gendisk *disk;
 	Sg_device *sdp = NULL;
 	struct cdev * cdev = NULL;
 	int error;
 	unsigned long iflags;
 
-	disk = alloc_disk(1);
-	if (!disk) {
-		pr_warn("%s: alloc_disk failed\n", __func__);
-		return -ENOMEM;
-	}
-	disk->major = SCSI_GENERIC_MAJOR;
-
 	error = -ENOMEM;
 	cdev = cdev_alloc();
 	if (!cdev) {
@@ -1543,7 +1531,7 @@ sg_add_device(struct device *cl_dev, struct class_interface *cl_intf)
 	cdev->owner = THIS_MODULE;
 	cdev->ops = &sg_fops;
 
-	sdp = sg_alloc(disk, scsidp);
+	sdp = sg_alloc(scsidp);
 	if (IS_ERR(sdp)) {
 		pr_warn("%s: sg_alloc failed\n", __func__);
 		error = PTR_ERR(sdp);
@@ -1561,7 +1549,7 @@ sg_add_device(struct device *cl_dev, struct class_interface *cl_intf)
 		sg_class_member = device_create(sg_sysfs_class, cl_dev->parent,
 						MKDEV(SCSI_GENERIC_MAJOR,
 						      sdp->index),
-						sdp, "%s", disk->disk_name);
+						sdp, "%s", sdp->name);
 		if (IS_ERR(sg_class_member)) {
 			pr_err("%s: device_create failed\n", __func__);
 			error = PTR_ERR(sg_class_member);
@@ -1589,7 +1577,6 @@ sg_add_device(struct device *cl_dev, struct class_interface *cl_intf)
 	kfree(sdp);
 
 out:
-	put_disk(disk);
 	if (cdev)
 		cdev_del(cdev);
 	return error;
@@ -1613,7 +1600,6 @@ sg_device_destroy(struct kref *kref)
 	SCSI_LOG_TIMEOUT(3,
 		sg_printk(KERN_INFO, sdp, "sg_device_destroy\n"));
 
-	put_disk(sdp->disk);
 	kfree(sdp);
 }
 
@@ -2606,7 +2592,7 @@ static int sg_proc_seq_show_debug(struct seq_file *s, void *v)
 		goto skip;
 	read_lock(&sdp->sfd_lock);
 	if (!list_empty(&sdp->sfds)) {
-		seq_printf(s, " >>> device=%s ", sdp->disk->disk_name);
+		seq_printf(s, " >>> device=%s ", sdp->name);
 		if (atomic_read(&sdp->detaching))
 			seq_puts(s, "detaching pending close ");
 		else if (sdp->device) {
-- 
2.30.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
