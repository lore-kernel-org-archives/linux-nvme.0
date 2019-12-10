Return-Path: <SRS0=hdrt=2A=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_ADSP_ALL,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0741BC43603
	for <linux-nvme@archiver.kernel.org>; Tue, 10 Dec 2019 03:02:13 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BBBE520692
	for <linux-nvme@archiver.kernel.org>; Tue, 10 Dec 2019 03:02:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="NwYvCiOu";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="AsFpB88v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBBE520692
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=ZnyZeLCkEvwk959/nFbT1fAJdrgncV0rWcZUlpNBXSo=; b=NwYvCiOuHZGZLH
	isv52LcCiQYzITlYckWYl8f1rYYE5ZhUaZWV00DZ31VwGD/YV3v5JztVFyDkDgS9Q5zj95KmKZf6k
	mISnVts1fwqD0MQuNW16MTdm7tD0xejKtFc86PJ29n4zVlVEQAfq1yWmMlXqK4BfQP7rvjdT/Uq0a
	qEC51ils04T+r4szwIsr6/HEJ8mRQoJijeppqOW90+tJ7Bg8/ZMLjccNyz6mnNur6tUbUqXxi73fO
	uBJ5mgd6lTRd/GklZh8qCTDvPYXAMVm1kiIkIqlGIuMS3k5COJai3GV3VnPEGvPSi77wlRpCMFf57
	ONROD5tWpORwdS13eiow==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1ieVmp-0000Q4-4B; Tue, 10 Dec 2019 03:02:07 +0000
Received: from smtp-fw-9102.amazon.com ([207.171.184.29])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1ieVmm-0000OT-DZ
 for linux-nvme@lists.infradead.org; Tue, 10 Dec 2019 03:02:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
 t=1575946924; x=1607482924;
 h=from:to:cc:subject:date:message-id:mime-version;
 bh=9FikzcEIKro6g9Y4AA6EZXnXzUOSF+Qic1B8e6GSfpE=;
 b=AsFpB88vW7aSPDB7JPFxFtSAvVR6xwh1EzGpmDgDdQTcPwmiGFPsBStu
 N/We3DHa4QRGpMs+JDtZ2nBDC0N6UsmO51ZGf+WPpK48lf4XhDKa09kBw
 FE6VZ2CDBtKzU/2fv8yYnX/pt0J3Wr/AZcA5hM05KQ5tiQZBLqhjw2uRo 4=;
IronPort-SDR: PqyHjMR8XmdRa8HGbPhd/WoSlriDaaxfeGPcP+BjSdln+gMW8dNPWCy98H7913cwvTACeXp/cK
 poLxp3q7OzpA==
X-IronPort-AV: E=Sophos;i="5.69,297,1571702400"; d="scan'208";a="12573217"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO
 email-inbound-relay-1a-807d4a99.us-east-1.amazon.com) ([10.47.23.38])
 by smtp-border-fw-out-9102.sea19.amazon.com with ESMTP;
 10 Dec 2019 03:01:41 +0000
Received: from EX13MTAUWC001.ant.amazon.com
 (iad55-ws-svc-p15-lb9-vlan2.iad.amazon.com [10.40.159.162])
 by email-inbound-relay-1a-807d4a99.us-east-1.amazon.com (Postfix) with ESMTPS
 id D7AEDA29E6; Tue, 10 Dec 2019 03:01:38 +0000 (UTC)
Received: from EX13D11UWC003.ant.amazon.com (10.43.162.162) by
 EX13MTAUWC001.ant.amazon.com (10.43.162.135) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Tue, 10 Dec 2019 03:01:38 +0000
Received: from EX13MTAUEA001.ant.amazon.com (10.43.61.82) by
 EX13D11UWC003.ant.amazon.com (10.43.162.162) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Tue, 10 Dec 2019 03:01:37 +0000
Received: from localhost (172.23.204.141) by mail-relay.amazon.com
 (10.43.61.243) with Microsoft SMTP Server id 15.0.1367.3 via Frontend
 Transport; Tue, 10 Dec 2019 03:01:36 +0000
From: Balbir Singh <sblbir@amazon.com>
To: <linux-block@vger.kernel.org>
Subject: [RFC PATCH] block/genhd: Notify udev about capacity change
Date: Tue, 10 Dec 2019 03:01:31 +0000
Message-ID: <20191210030131.4198-1-sblbir@amazon.com>
X-Mailer: git-send-email 2.16.5
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191209_190204_502103_7A6B01F3 
X-CRM114-Status: GOOD (  14.14  )
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
Cc: axboe@kernel.dk, mst@redhat.com, jejb@linux.ibm.com,
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 Someswarudu Sangaraju <ssomesh@amazon.com>, Balbir
 Singh <sblbir@amazon.com>, hch@lst.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Allow block/genhd to notify user space (via udev) about disk size changes
using a new helper disk_set_capacity(), which is a wrapper on top
of set_capacity(). disk_set_capacity() will only notify via udev if
the current capacity or the target capacity is not zero.

disk_set_capacity() is not enabled for all devices, just virtio block,
xen-blockfront, nvme and sd. Owners of other block disk devices can
easily move over by changing set_capacity() to disk_set_capacity()

Background:

As a part of a patch to allow sending the RESIZE event on disk capacity
change, Christoph (hch@lst.de) requested that the patch be made generic
and the hacks for virtio block and xen block devices be removed and
merged via a generic helper.

Testing:
1. I did some basic testing with an NVME device, by resizing it in
the backend and ensured that udevd received the event.

Suggested-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Balbir Singh <sblbir@amazon.com>
Signed-off-by: Someswarudu Sangaraju <ssomesh@amazon.com>
---
 block/genhd.c                | 19 +++++++++++++++++++
 drivers/block/virtio_blk.c   |  4 +---
 drivers/block/xen-blkfront.c |  5 +----
 drivers/nvme/host/core.c     |  2 +-
 drivers/scsi/sd.c            |  2 +-
 include/linux/genhd.h        |  1 +
 6 files changed, 24 insertions(+), 9 deletions(-)

diff --git a/block/genhd.c b/block/genhd.c
index ff6268970ddc..94faec98607b 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -46,6 +46,25 @@ static void disk_add_events(struct gendisk *disk);
 static void disk_del_events(struct gendisk *disk);
 static void disk_release_events(struct gendisk *disk);
 
+/*
+ * Set disk capacity and notify if the size is not currently
+ * zero and will not be set to zero
+ */
+void disk_set_capacity(struct gendisk *disk, sector_t size)
+{
+	sector_t capacity = get_capacity(disk);
+
+	set_capacity(disk, size);
+	if (capacity != 0 && size != 0) {
+		char *envp[] = { "RESIZE=1", NULL };
+
+		kobject_uevent_env(&disk_to_dev(disk)->kobj, KOBJ_CHANGE, envp);
+	}
+}
+
+EXPORT_SYMBOL_GPL(disk_set_capacity);
+
+
 void part_inc_in_flight(struct request_queue *q, struct hd_struct *part, int rw)
 {
 	if (queue_is_mq(q))
diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index 7ffd719d89de..869cd3c31529 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -476,18 +476,16 @@ static void virtblk_update_capacity(struct virtio_blk *vblk, bool resize)
 		   cap_str_10,
 		   cap_str_2);
 
-	set_capacity(vblk->disk, capacity);
+	disk_set_capacity(vblk->disk, capacity);
 }
 
 static void virtblk_config_changed_work(struct work_struct *work)
 {
 	struct virtio_blk *vblk =
 		container_of(work, struct virtio_blk, config_work);
-	char *envp[] = { "RESIZE=1", NULL };
 
 	virtblk_update_capacity(vblk, true);
 	revalidate_disk(vblk->disk);
-	kobject_uevent_env(&disk_to_dev(vblk->disk)->kobj, KOBJ_CHANGE, envp);
 }
 
 static void virtblk_config_changed(struct virtio_device *vdev)
diff --git a/drivers/block/xen-blkfront.c b/drivers/block/xen-blkfront.c
index a74d03913822..8077c070fe18 100644
--- a/drivers/block/xen-blkfront.c
+++ b/drivers/block/xen-blkfront.c
@@ -2337,7 +2337,6 @@ static void blkfront_connect(struct blkfront_info *info)
 	unsigned long sector_size;
 	unsigned int physical_sector_size;
 	unsigned int binfo;
-	char *envp[] = { "RESIZE=1", NULL };
 	int err, i;
 
 	switch (info->connected) {
@@ -2352,10 +2351,8 @@ static void blkfront_connect(struct blkfront_info *info)
 			return;
 		printk(KERN_INFO "Setting capacity to %Lu\n",
 		       sectors);
-		set_capacity(info->gd, sectors);
+		disk_set_capacity(info->gd, sectors);
 		revalidate_disk(info->gd);
-		kobject_uevent_env(&disk_to_dev(info->gd)->kobj,
-				   KOBJ_CHANGE, envp);
 
 		return;
 	case BLKIF_STATE_SUSPENDED:
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index dfe37a525f3a..f1ad70aab721 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1806,7 +1806,7 @@ static void nvme_update_disk_info(struct gendisk *disk,
 	    ns->lba_shift > PAGE_SHIFT)
 		capacity = 0;
 
-	set_capacity(disk, capacity);
+	disk_set_capacity(disk, capacity);
 
 	nvme_config_discard(disk, ns);
 	nvme_config_write_zeroes(disk, ns);
diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
index cea625906440..afeae847dca6 100644
--- a/drivers/scsi/sd.c
+++ b/drivers/scsi/sd.c
@@ -3196,7 +3196,7 @@ static int sd_revalidate_disk(struct gendisk *disk)
 
 	sdkp->first_scan = 0;
 
-	set_capacity(disk, logical_to_sectors(sdp, sdkp->capacity));
+	disk_set_capacity(disk, logical_to_sectors(sdp, sdkp->capacity));
 	sd_config_write_same(sdkp);
 	kfree(buffer);
 
diff --git a/include/linux/genhd.h b/include/linux/genhd.h
index 8bb63027e4d6..d5e87d7cc357 100644
--- a/include/linux/genhd.h
+++ b/include/linux/genhd.h
@@ -449,6 +449,7 @@ static inline int get_disk_ro(struct gendisk *disk)
 extern void disk_block_events(struct gendisk *disk);
 extern void disk_unblock_events(struct gendisk *disk);
 extern void disk_flush_events(struct gendisk *disk, unsigned int mask);
+extern void disk_set_capacity(struct gendisk *disk, sector_t size);
 extern unsigned int disk_clear_events(struct gendisk *disk, unsigned int mask);
 
 /* drivers/char/random.c */
-- 
2.16.5


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
