Return-Path: <SRS0=kk+z=3Z=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,URIBL_DBL_ABUSE_MALW,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4911C35247
	for <linux-nvme@archiver.kernel.org>; Wed,  5 Feb 2020 01:57:08 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 775B82082E
	for <linux-nvme@archiver.kernel.org>; Wed,  5 Feb 2020 01:57:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="E8zqFzny";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="UJUnNC8j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 775B82082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=+AI03Cb77acOmS4wUcV5VckWYvhQwY5RZotF2neMfEE=; b=E8zqFznyUVLrkr
	kV709SNCxQnxvQqZ4dNMbQhRKbYaqSg5/EEp5C9hvAL3RXzlDAEoDnL94RruCbBeR/JVIgCFnsS6V
	SK3FCy7TNLPbUoEN46cSvIDxs+XV+zA12DBOYvGtsOAeoHjuAYH7Ml5VNk5pLfLqF7nQBdRsX5jVH
	qhOQHkBavaNnRGQu475R67mVP3aJmhpbQ1q8vUgg6FbOHN4yGWIbZCH5E4wWRTWc7dWjdMMyFBLJD
	204bsHfhLMk1jH1gg1SFBH2y75mXqv52fWJenC98Udfft67NZUwskEUTfAaAtgN/I67RzaWNfEzcS
	l0UQ82UuyL3VG4RBgRPg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iz9w8-0008Ij-IC; Wed, 05 Feb 2020 01:57:04 +0000
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iz9w3-0008FS-8b
 for linux-nvme@lists.infradead.org; Wed, 05 Feb 2020 01:57:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1580867819; x=1612403819;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=xt2RxDJXWdyruPh5bm8fAmIv/s9P+4SonVnRb353yCQ=;
 b=UJUnNC8jGVKcXD8sNqrZI07+kq7SNO+yMuGK2zgjOaXV6z57Srr3HCEf
 ZPPUgKyf7mlpoOu22L+PIBurPzn2jEXDGboXKJi6Kdw7maPGOys4+yP1C
 CBiq0yL+eJTPyg8gFztJ+VZ/GfFRhkR8F1htputfDwNbXcFmaYUClVbij
 CZfNsbg81op1NIjqaBFKWEBUXoGrI6TMo45jTR3GZuri6I04Y+Op4j9o0
 GeizwSU1kj5KeHwciTT534/gT02J9u9llhuGBFsWhPz7JZLqd+wKHg+St
 Wv4k1JzQwifEm0AkHu4alGfNTOqf0q3crKdQxFQS0KoMZOI98GaFnhAvC Q==;
IronPort-SDR: MammH2vqmLvfoUnhb+CuxlgTKS9OezQmm+OBYWtGSZHNas3Ma6b5EZnTKKgpUcslnguwYrooip
 5sdeiiDJVV21sG1J07lrzfELDK/9ekNstgLI7FMmkQFRX+nQEehq3JAUOCe5dEYV2Ho6uThAEW
 H7fnZwKwSEItwLD4/b6eXRlzvyL2/XxOFv26eEzp0t3vFlL2HuMS+0wLYVN77naFRjSXWUDz4S
 HGZV5yyXRlN4ZR4sOn+D8rptXg27uCJyNi+CRFKjall0uwUtPlX3FFq20dOl8Fwyq5QJ+ZGPlE
 wMY=
X-IronPort-AV: E=Sophos;i="5.70,404,1574092800"; d="scan'208";a="130576284"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 05 Feb 2020 09:56:59 +0800
IronPort-SDR: 5nIYN8sXBYQsMaqDD0NUcTKZByPnUI4krkK7ZKsColJtfgMHNwxf1bjg54kuy7WGPez16XjlR1
 1M/WEMcKlrAf27/ZyiX9tA7AXdB6TeZHbpJSc0eo4n2XRnIWbx2KvLPGFEjLUgjk3LI8PF+5f5
 XSf05EtEROFNxq2CXLYpM3qSpUtPGXFieNtb15az9grqp60rL5erB+wn54aDqhc6Uf+HZ5DLLR
 eFsq4Kk0sVmbqk0aToJ+SodqMTrdWIoorGrPs1BZposAzGXJMLKQQuT/IwCESUBoVckjLegGxz
 aYBKUU41bX5E+NRIEWoWQzYt
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Feb 2020 17:50:01 -0800
IronPort-SDR: jTULsYLKcGQdnz5TYpb1VE1qpdNhpGY/TC/zHd8yQZUpvTz3PawHlQTKnCUv3ejWU0QX80tntc
 zSJFVZjJ2TfhydkDriMgC53P1tmrhAU/fqU51yQrZjx7zZAbaslA3GKPRSZBjDC55xj6ZhIWy4
 HmI/ZJndsz7h6Zo0oH40DZAyd5RcN78RCMynFbjsxpAxXkfISkiWEde4XsK+Xa2HorF8leUbA9
 aKoZbus7WGjYT46tODA+q5KAGTIMcRiLJLsnY9Afbcbz0yDx2N3T0xqTzx2YrG2aqnvGdOxlKe
 cJQ=
WDCIronportException: Internal
Received: from iouring.labspan.wdc.com (HELO iouring.sc.wdc.com)
 ([10.6.138.107])
 by uls-op-cesaip01.wdc.com with ESMTP; 04 Feb 2020 17:56:57 -0800
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH RESEND V2 1/2] nvmet: allow block device to use buffered I/O
Date: Tue,  4 Feb 2020 17:56:49 -0800
Message-Id: <20200205015653.21866-2-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200205015653.21866-1-chaitanya.kulkarni@wdc.com>
References: <20200205015653.21866-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200204_175659_385855_A1575AA4 
X-CRM114-Status: GOOD (  17.90  )
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
Cc: MRuijter@onestopsystems.com, hch@lst.de,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>, sagi@grimberg.me
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
buffered_io=1 :-

Device_path = /dev/nullb0, I/O type = randread.

With this patch and buffered I/O = 0:
  read: IOPS=198k, BW=772MiB/s (809MB/s)(45.2GiB/60002msec)
  read: IOPS=198k, BW=774MiB/s (811MB/s)(45.3GiB/60002msec)
  read: IOPS=197k, BW=771MiB/s (808MB/s)(45.2GiB/60002msec)

With this patch and buffered I/O = 1:
  read: IOPS=979k, BW=3825MiB/s (4010MB/s)(224GiB/60002msec)
  read: IOPS=983k, BW=3841MiB/s (4028MB/s)(225GiB/60003msec)
  read: IOPS=980k, BW=3828MiB/s (4014MB/s)(224GiB/60002msec)

Cc: hch@lst.de
Cc: sagi@grimberg.me
Cc: MRuijter@onestopsystems.com

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
Changes from V1:-

1. Rename use_vfs -> backend.

---
 drivers/nvme/target/configfs.c    | 42 +++++++++++++++++++++++++++++++
 drivers/nvme/target/core.c        |  7 +++++-
 drivers/nvme/target/io-cmd-bdev.c |  3 +++
 drivers/nvme/target/io-cmd-file.c | 23 ++++++++++++-----
 drivers/nvme/target/nvmet.h       |  6 +++++
 5 files changed, 74 insertions(+), 7 deletions(-)

diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
index fc4c8dac87fb..500cacfc715c 100644
--- a/drivers/nvme/target/configfs.c
+++ b/drivers/nvme/target/configfs.c
@@ -543,6 +543,47 @@ static ssize_t nvmet_ns_buffered_io_store(struct config_item *item,
 
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
@@ -550,6 +591,7 @@ static struct configfs_attribute *nvmet_ns_attrs[] = {
 	&nvmet_ns_attr_ana_grpid,
 	&nvmet_ns_attr_enable,
 	&nvmet_ns_attr_buffered_io,
+	&nvmet_ns_attr_backend,
 #ifdef CONFIG_PCI_P2PDMA
 	&nvmet_ns_attr_p2pmem,
 #endif
diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index b685f99d56a1..f32c948dac38 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -530,8 +530,13 @@ int nvmet_ns_enable(struct nvmet_ns *ns)
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
index ea0e596be15d..3d56d5c4a4a5 100644
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
index cd5670b83118..8a642cda123d 100644
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
index 42ba2ddd9e96..d78d9990e513 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -50,6 +50,11 @@
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
@@ -74,6 +79,7 @@ struct nvmet_ns {
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
