Return-Path: <SRS0=Ap99=CK=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8F83C433E2
	for <linux-nvme@archiver.kernel.org>; Tue,  1 Sep 2020 15:58:37 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA317206EB
	for <linux-nvme@archiver.kernel.org>; Tue,  1 Sep 2020 15:58:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="X9XXoqFr";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="HYmAhoZ6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA317206EB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=SzM9EOmbwRJHlJ5woFrnPV/L/s8QZiI3pSKzLAiZsjs=; b=X9XXoqFrBMmT+PDfMn5lJvhW6
	j5DVmeeHHIIa2BUizP5kFIKzy/b8qc/laWmfiGgOIvOVDzHbSi+DQaJIfjdc/Pc1akxuzbdvou5HF
	kyu5YCHGmNe8VE0CjtiPNKR1fy54a5JjNVHijd6ror0eFbDnBdAHLtJKDiGBP9SlWYkKKF9uMeWkE
	7SSuU6bx1k914S0/y4nmQzQSGzzaNNhO/SrwmOd2P+kXmY2tnpXCcYejBe4N/Mj9He0HCDKLe92W0
	8ylv0v9af6sadr939P6lUKsOjmHo7jnrCxP+l5DNEPHSjv9+kw9T1OuUhQx1Y36NA1bmNCI9bMrxc
	oh/MBirUQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kD8g5-0002hI-9a; Tue, 01 Sep 2020 15:58:33 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kD8fe-0002Pq-Ds
 for linux-nvme@merlin.infradead.org; Tue, 01 Sep 2020 15:58:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description;
 bh=EF13r0+0d9O9nMlCm01+oM4tKYciqyKnGXIGW3kVD84=; b=HYmAhoZ63YSCjnl8OuIdMgC24+
 OLAuE5Qyl8+SSIbmk3g4PfdSIPkzBGGetTuDOxX+Qs71QQjZWAzLKzMrACN8ulp7QR2iOUqE4ZVNK
 06RJaa6wr36QFWrQPzM/l+J7VvHyUnAfWlNLm19OPiozI/Qs9/Fc/6hqOVJv0n5/Jq2e9uyN/MvTB
 Erk1SKzkRxjElLUaV/1kuC3vG+fazzPUHr4TI0+fOEtxoYuO96ZKZJCwD4DZy25U4usxk60CTBX5g
 JMOaZAOsbMVbuPX09gGZ17T4KknRMsn/fTvw5ptusMsDfDiH90pDKkOVpM+A202zJTr0td5QYxw9u
 KPNZLITw==;
Received: from [2001:4bb8:18c:45ba:2f95:e5:ca6b:9b4a] (helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kD8fc-0004RL-8h; Tue, 01 Sep 2020 15:58:04 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 8/9] nvdimm: simplify revalidate_disk handling
Date: Tue,  1 Sep 2020 17:57:47 +0200
Message-Id: <20200901155748.2884-9-hch@lst.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200901155748.2884-1-hch@lst.de>
References: <20200901155748.2884-1-hch@lst.de>
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
Cc: linux-raid@vger.kernel.org, linux-scsi@vger.kernel.org,
 "Martin K. Petersen" <martin.petersen@oracle.com>, linux-nvdimm@lists.01.org,
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 Josef Bacik <josef@toxicpanda.com>, linux-block@vger.kernel.org,
 dm-devel@redhat.com, linux-fsdevel@vger.kernel.org,
 Dan Williams <dan.j.williams@intel.com>, nbd@other.debian.org,
 virtualization@lists.linux-foundation.org, ceph-devel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

The nvdimm block driver abuse revalidate_disk in a strange way, and
totally unrelated to what other drivers do.  Simplify this by just
calling nvdimm_revalidate_disk (which seems rather misnamed) from the
probe routines, as the additional bdev size revalidation is pointless
at this point, and remove the revalidate_disk methods given that
it can only be triggered from add_disk, which is right before the
manual calls.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvdimm/blk.c  | 3 +--
 drivers/nvdimm/btt.c  | 3 +--
 drivers/nvdimm/bus.c  | 9 +++------
 drivers/nvdimm/nd.h   | 2 +-
 drivers/nvdimm/pmem.c | 3 +--
 5 files changed, 7 insertions(+), 13 deletions(-)

diff --git a/drivers/nvdimm/blk.c b/drivers/nvdimm/blk.c
index 1f718381a04553..22e5617b2cea14 100644
--- a/drivers/nvdimm/blk.c
+++ b/drivers/nvdimm/blk.c
@@ -226,7 +226,6 @@ static int nsblk_rw_bytes(struct nd_namespace_common *ndns,
 static const struct block_device_operations nd_blk_fops = {
 	.owner = THIS_MODULE,
 	.submit_bio =  nd_blk_submit_bio,
-	.revalidate_disk = nvdimm_revalidate_disk,
 };
 
 static void nd_blk_release_queue(void *q)
@@ -284,7 +283,7 @@ static int nsblk_attach_disk(struct nd_namespace_blk *nsblk)
 
 	set_capacity(disk, available_disk_size >> SECTOR_SHIFT);
 	device_add_disk(dev, disk, NULL);
-	revalidate_disk(disk);
+	nvdimm_check_and_set_ro(disk);
 	return 0;
 }
 
diff --git a/drivers/nvdimm/btt.c b/drivers/nvdimm/btt.c
index 0ff610e728ff6f..0d710140bf93be 100644
--- a/drivers/nvdimm/btt.c
+++ b/drivers/nvdimm/btt.c
@@ -1513,7 +1513,6 @@ static const struct block_device_operations btt_fops = {
 	.submit_bio =		btt_submit_bio,
 	.rw_page =		btt_rw_page,
 	.getgeo =		btt_getgeo,
-	.revalidate_disk =	nvdimm_revalidate_disk,
 };
 
 static int btt_blk_init(struct btt *btt)
@@ -1558,7 +1557,7 @@ static int btt_blk_init(struct btt *btt)
 	set_capacity(btt->btt_disk, btt->nlba * btt->sector_size >> 9);
 	device_add_disk(&btt->nd_btt->dev, btt->btt_disk, NULL);
 	btt->nd_btt->size = btt->nlba * (u64)btt->sector_size;
-	revalidate_disk(btt->btt_disk);
+	nvdimm_check_and_set_ro(btt->btt_disk);
 
 	return 0;
 }
diff --git a/drivers/nvdimm/bus.c b/drivers/nvdimm/bus.c
index 955265656b96c7..2304c6183822e9 100644
--- a/drivers/nvdimm/bus.c
+++ b/drivers/nvdimm/bus.c
@@ -628,7 +628,7 @@ int __nd_driver_register(struct nd_device_driver *nd_drv, struct module *owner,
 }
 EXPORT_SYMBOL(__nd_driver_register);
 
-int nvdimm_revalidate_disk(struct gendisk *disk)
+void nvdimm_check_and_set_ro(struct gendisk *disk)
 {
 	struct device *dev = disk_to_dev(disk)->parent;
 	struct nd_region *nd_region = to_nd_region(dev->parent);
@@ -639,16 +639,13 @@ int nvdimm_revalidate_disk(struct gendisk *disk)
 	 * read-only if the disk is already read-only.
 	 */
 	if (disk_ro || nd_region->ro == disk_ro)
-		return 0;
+		return;
 
 	dev_info(dev, "%s read-only, marking %s read-only\n",
 			dev_name(&nd_region->dev), disk->disk_name);
 	set_disk_ro(disk, 1);
-
-	return 0;
-
 }
-EXPORT_SYMBOL(nvdimm_revalidate_disk);
+EXPORT_SYMBOL(nvdimm_check_and_set_ro);
 
 static ssize_t modalias_show(struct device *dev, struct device_attribute *attr,
 		char *buf)
diff --git a/drivers/nvdimm/nd.h b/drivers/nvdimm/nd.h
index 85c1ae813ea318..72740108ba4206 100644
--- a/drivers/nvdimm/nd.h
+++ b/drivers/nvdimm/nd.h
@@ -361,7 +361,7 @@ u64 nd_region_interleave_set_altcookie(struct nd_region *nd_region);
 void nvdimm_bus_lock(struct device *dev);
 void nvdimm_bus_unlock(struct device *dev);
 bool is_nvdimm_bus_locked(struct device *dev);
-int nvdimm_revalidate_disk(struct gendisk *disk);
+void nvdimm_check_and_set_ro(struct gendisk *disk);
 void nvdimm_drvdata_release(struct kref *kref);
 void put_ndd(struct nvdimm_drvdata *ndd);
 int nd_label_reserve_dpa(struct nvdimm_drvdata *ndd);
diff --git a/drivers/nvdimm/pmem.c b/drivers/nvdimm/pmem.c
index fab29b514372d0..140cf3b9000c60 100644
--- a/drivers/nvdimm/pmem.c
+++ b/drivers/nvdimm/pmem.c
@@ -281,7 +281,6 @@ static const struct block_device_operations pmem_fops = {
 	.owner =		THIS_MODULE,
 	.submit_bio =		pmem_submit_bio,
 	.rw_page =		pmem_rw_page,
-	.revalidate_disk =	nvdimm_revalidate_disk,
 };
 
 static int pmem_dax_zero_page_range(struct dax_device *dax_dev, pgoff_t pgoff,
@@ -501,7 +500,7 @@ static int pmem_attach_disk(struct device *dev,
 	if (devm_add_action_or_reset(dev, pmem_release_disk, pmem))
 		return -ENOMEM;
 
-	revalidate_disk(disk);
+	nvdimm_check_and_set_ro(disk);
 
 	pmem->bb_state = sysfs_get_dirent(disk_to_dev(disk)->kobj.sd,
 					  "badblocks");
-- 
2.28.0


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
