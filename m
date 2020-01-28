Return-Path: <SRS0=IFMZ=3R=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_DBL_ABUSE_MALW,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACE10C32771
	for <linux-nvme@archiver.kernel.org>; Tue, 28 Jan 2020 01:44:24 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 73CA4214AF
	for <linux-nvme@archiver.kernel.org>; Tue, 28 Jan 2020 01:44:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="k6goP8/U";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="ccg/oqwG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73CA4214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=L8Y+lIaA3DveybPC6uO/5KiOTm5/8xFKOLXoYGKpbXw=; b=k6goP8/U5WdHUh
	8jvBxJdu8EObchGWpp6nUx2H/S3lxHVaPVLi3UWzfVIt97AyPslQGqov3Fdh+7UReVu8IRc/ONlcj
	96zn4MbGdsbpNZqUDdYe3EUpuvYaotPtQ+ypn/EDkEJNqPprSRy9ss54inGxkk1mrUiPCDahWI3EB
	8utW2atrQZ1K2XKOTic04R2I29uVaIbKDWPDrnqGm7XteZGHSaxrk/ES+ydH26sijSwMFlwW2gxTk
	ETljXQEeImt+p1eUafnRu1ytMFQlfmMnLUyMN4im+ZdwM8okG+htXHRjAw5etzdiqZGu3nX0o8RHz
	xkvM5kGpJvQMsPyRe99g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iwFvR-0007Ev-Cf; Tue, 28 Jan 2020 01:44:21 +0000
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iwFvO-0007EV-Ak
 for linux-nvme@lists.infradead.org; Tue, 28 Jan 2020 01:44:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1580175858; x=1611711858;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=25QxtmqtTUVqJ3tZQk1D99g/KgrDq/OeGN2Z4V8O4sA=;
 b=ccg/oqwGxOGDuIFl7FY5SwozCmmZh0kFsd01nBoNGJl+GOQfc5bhkGB4
 QeLTyQ4XsNOUMNqU01o+iRJqsa5BHk5nYxyaHPZOpXVBtxmi8H9WGSd11
 4MIrTiKWkd+QaapcQx792T86g5EgCFy2X3L1+2ud+08YiNcYutjyl3hjY
 CAogCq4FnvHBKWzMo4yvjj4Zwh4KyjmTUpb4H0qVE///sEpagMfOAKMBR
 XnjBnEiP0Sfv9o6MigL4DcSR9uN/ZYtWc1rjUkIafyCOa9ebdAHbJE5z3
 Zep9xYBvFJvh8P4HJmOMV8Ln2LRUrzo6g16vSq3hMgb5n3gqekJadyExn A==;
IronPort-SDR: KtcAlLoRrbGrYUz0mmogIvioSEjOmSxvNB1vXd1aM1xqsIa1riASVnTb+tlvo3ccsSqTWr/Ypw
 MG19Y0AcMnn+LAjOqlAnvZqpFrtDLtT8aP8WNZojEgG3ZktXZ4VN0ftRFQOSi0Hfe8n/WSGcV6
 VO+9VtLNWGC8uUNGyAd/Uuwl0Sp79Y43w00AePEwaOAy2kCx63U9hO6e6q+THHl7s4v3zWX82n
 9BxYSiLB4rbfcazOC+aufCcfT/QuKU0a7gjlX/gt5Zfwc1gPh6VlLaIvMzBVBNUsgEn0GYjRtZ
 6Eg=
X-IronPort-AV: E=Sophos;i="5.70,372,1574092800"; d="scan'208";a="128535191"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 28 Jan 2020 09:44:15 +0800
IronPort-SDR: pfXjHh2SP01l4/va7+uPJKGPGMgs1DLWvcNj1vsH2mXkwis9IhZmOwjkVGylA+FqP250br5E2l
 TYWras0o7s5mfx8dZzZU3wwM+ljoF0hOWWr32gq6dpUCv1sj+Zp4XQmV2FfUabLHIPc/izJvns
 qZYcYIWInemvo2P3sANKkTaRj2dikfcweoStRZrFPtQlIexjzuIK+0H1gw5pbX8XYEjfyuBiu1
 ykkWvGLE4sDaYmKkQxQXW6+t6+iI7930OqDZeExCP6qxV0HFc7TdSrzlgJFBS+Rj8jjJiO5kKq
 vdNKLcT37yxcWyYQWKTI0VHC
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Jan 2020 17:37:31 -0800
IronPort-SDR: nYJyy3ZuLAhrIY3S55Fh5UfkS60L531FCYpTXAA9D+bYm3TEHEdmtAX249gbLYUVRm+2KV2Gv3
 g7ryvklurRdxJheghqG8kHtDo+EO39jUzYPR5ZI9IFm7r9JguGvzWIJopAt2oxIcWb7v6KHK8m
 agu7PvN0lY1LlmiN4aQpnctNSJ7+1XoeQ3wrNeLZw7dr4g2TqO192rNr2erRNFE9SuWar5IZE8
 hw1N4j5bjRO8k+54TkrBL+sFqBSz8jLrbTS5S5kAmy2cLjrPrX3GrB/TdIS439VKJRTin1lYWm
 qQA=
WDCIronportException: Internal
Received: from iouring.labspan.wdc.com (HELO iouring.sc.wdc.com)
 ([10.6.138.107])
 by uls-op-cesaip01.wdc.com with ESMTP; 27 Jan 2020 17:44:15 -0800
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH V2] nvmet: allow block device to use buffered I/O
Date: Mon, 27 Jan 2020 17:44:09 -0800
Message-Id: <20200128014409.6824-1-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200127_174418_413090_852E958F 
X-CRM114-Status: GOOD (  16.15  )
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
Cc: hch@lst.de, Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
 sagi@grimberg.me
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

NVMeOF target already has a support to execute requests in the
buffered I/O mode with file backend. This patch allows block devices to
be used with file backend code so that buffered I/O parameter can be set
for a block device backed namespace when newly introduce configfs
parameter backeend. The new file defaults to the blockio user can switch
between "blockio" and "fileio" strings to enable the file backend for
the block device when buffered_io set to 1.

Following is the performance improvement when backend=fileio and
buffere_dio=1 :-

Device_path = /dev/nullb0, I/O type = randread.

With this patch and buffered I/O = 0, use_vfs=0 :
  read: IOPS=198k, BW=772MiB/s (809MB/s)(45.2GiB/60002msec)
  read: IOPS=198k, BW=774MiB/s (811MB/s)(45.3GiB/60002msec)
  read: IOPS=197k, BW=771MiB/s (808MB/s)(45.2GiB/60002msec)

With this patch and buffered I/O = 1, use_vfs=1:
  read: IOPS=979k, BW=3825MiB/s (4010MB/s)(224GiB/60002msec)
  read: IOPS=983k, BW=3841MiB/s (4028MB/s)(225GiB/60003msec)
  read: IOPS=980k, BW=3828MiB/s (4014MB/s)(224GiB/60002msec)

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/nvme/target/configfs.c    | 42 +++++++++++++++++++++++++++++++
 drivers/nvme/target/core.c        |  7 +++++-
 drivers/nvme/target/io-cmd-bdev.c |  3 +++
 drivers/nvme/target/io-cmd-file.c | 23 ++++++++++++-----
 drivers/nvme/target/nvmet.h       |  6 +++++
 5 files changed, 74 insertions(+), 7 deletions(-)

diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
index 98613a45bd3b..61973c047e13 100644
--- a/drivers/nvme/target/configfs.c
+++ b/drivers/nvme/target/configfs.c
@@ -545,6 +545,47 @@ static ssize_t nvmet_ns_buffered_io_store(struct config_item *item,
 
 CONFIGFS_ATTR(nvmet_ns_, buffered_io);
 
+static ssize_t nvmet_ns_backend_show(struct config_item *item, char *page)
+{
+	if (to_nvmet_ns(item)->backend == FILEIO)
+		return sprintf(page, "fileio\n");
+
+	return sprintf(page, "blockio\n");
+}
+
+static ssize_t nvmet_ns_backend_store(struct config_item *item,
+		const char *page, size_t count)
+{
+	struct nvmet_ns *ns = to_nvmet_ns(item);
+	unsigned int len;
+	int ret;
+
+	mutex_lock(&ns->subsys->lock);
+	if (ns->enabled) {
+		ret = -EBUSY;
+		goto out_unlock;
+	}
+
+	ret = -EINVAL;
+	len = strcspn(page, "\n");
+	if (!len)
+		goto out_unlock;
+
+	if (memcmp("fileio", page, strlen("fileio")) == 0)
+		ns->backend = FILEIO;
+	else if (memcmp("blockio", page, strlen("blockio")) == 0)
+		ns->backend = BLOCKIO;
+	else
+		goto out_unlock;
+
+	ret = count;
+out_unlock:
+	mutex_unlock(&ns->subsys->lock);
+	return ret;
+}
+
+CONFIGFS_ATTR(nvmet_ns_, backend);
+
 static struct configfs_attribute *nvmet_ns_attrs[] = {
 	&nvmet_ns_attr_device_path,
 	&nvmet_ns_attr_device_nguid,
@@ -552,6 +593,7 @@ static struct configfs_attribute *nvmet_ns_attrs[] = {
 	&nvmet_ns_attr_ana_grpid,
 	&nvmet_ns_attr_enable,
 	&nvmet_ns_attr_buffered_io,
+	&nvmet_ns_attr_backend,
 #ifdef CONFIG_PCI_P2PDMA
 	&nvmet_ns_attr_p2pmem,
 #endif
diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index 28438b833c1b..a8da15cf468d 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -526,8 +526,13 @@ int nvmet_ns_enable(struct nvmet_ns *ns)
 		goto out_unlock;
 
 	ret = nvmet_bdev_ns_enable(ns);
-	if (ret == -ENOTBLK)
+	if (!ret)
+		pr_info("using the blockio backend\n");
+	else if (ret == -ENOTBLK) {
 		ret = nvmet_file_ns_enable(ns);
+		if (!ret)
+			pr_info("using the fileio backend\n");
+	}
 	if (ret)
 		goto out_unlock;
 
diff --git a/drivers/nvme/target/io-cmd-bdev.c b/drivers/nvme/target/io-cmd-bdev.c
index b6fca0e421ef..2b6744d2c37d 100644
--- a/drivers/nvme/target/io-cmd-bdev.c
+++ b/drivers/nvme/target/io-cmd-bdev.c
@@ -51,6 +51,9 @@ int nvmet_bdev_ns_enable(struct nvmet_ns *ns)
 {
 	int ret;
 
+	if (ns->backend == FILEIO)
+		return -ENOTBLK;
+
 	ns->bdev = blkdev_get_by_path(ns->device_path,
 			FMODE_READ | FMODE_WRITE, NULL);
 	if (IS_ERR(ns->bdev)) {
diff --git a/drivers/nvme/target/io-cmd-file.c b/drivers/nvme/target/io-cmd-file.c
index caebfce06605..4d130b863f59 100644
--- a/drivers/nvme/target/io-cmd-file.c
+++ b/drivers/nvme/target/io-cmd-file.c
@@ -29,7 +29,9 @@ void nvmet_file_ns_disable(struct nvmet_ns *ns)
 
 int nvmet_file_ns_enable(struct nvmet_ns *ns)
 {
+	fmode_t mode = FMODE_READ | FMODE_WRITE;
 	int flags = O_RDWR | O_LARGEFILE;
+	struct block_device *bdev;
 	struct kstat stat;
 	int ret;
 
@@ -49,12 +51,21 @@ int nvmet_file_ns_enable(struct nvmet_ns *ns)
 		goto err;
 
 	ns->size = stat.size;
-	/*
-	 * i_blkbits can be greater than the universally accepted upper bound,
-	 * so make sure we export a sane namespace lba_shift.
-	 */
-	ns->blksize_shift = min_t(u8,
-			file_inode(ns->file)->i_blkbits, 12);
+	if (ns->size == 0 && ns->backend == FILEIO) {
+		bdev = blkdev_get_by_path(ns->device_path, mode, NULL);
+		if (IS_ERR(bdev))
+			goto err;
+		ns->size = i_size_read(bdev->bd_inode);
+		ns->blksize_shift = blksize_bits(bdev_logical_block_size(bdev));
+		blkdev_put(bdev, mode);
+	} else {
+		/*
+		 * i_blkbits can be greater than the universally accepted upper
+		 * bound, so make sure we export a sane namespace lba_shift.
+		 */
+		ns->blksize_shift = min_t(u8,
+				file_inode(ns->file)->i_blkbits, 12);
+	}
 
 	ns->bvec_cache = kmem_cache_create("nvmet-bvec",
 			NVMET_MAX_MPOOL_BVEC * sizeof(struct bio_vec),
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index 46df45e837c9..b8e66ea37154 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -49,6 +49,11 @@
 #define IPO_IATTR_CONNECT_SQE(x)	\
 	(cpu_to_le32(offsetof(struct nvmf_connect_command, x)))
 
+enum nvmet_ns_backend {
+	BLOCKIO,
+	FILEIO
+};
+
 struct nvmet_ns {
 	struct list_head	dev_link;
 	struct percpu_ref	ref;
@@ -73,6 +78,7 @@ struct nvmet_ns {
 	struct completion	disable_done;
 	mempool_t		*bvec_pool;
 	struct kmem_cache	*bvec_cache;
+	enum nvmet_ns_backend	backend;
 
 	int			use_p2pmem;
 	struct pci_dev		*p2p_dev;
-- 
2.22.1


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
