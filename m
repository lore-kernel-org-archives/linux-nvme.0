Return-Path: <SRS0=Uv50=XV=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED65CC4360C
	for <linux-nvme@archiver.kernel.org>; Thu, 26 Sep 2019 23:20:13 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B9B05207E0
	for <linux-nvme@archiver.kernel.org>; Thu, 26 Sep 2019 23:20:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="nEKHK7mC";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=yadro.com header.i=@yadro.com header.b="g0Ig5vN1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9B05207E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=yadro.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=uoXIc16qZwaDl3fVlIuYJTWSdd+GsfSukl49MeA/le4=; b=nEKHK7mCOV6tlr
	cUEjQiHBMHPIW3nuJcglgb+QBD1V5sPyOmZNC06P1CvBtxFXNZt0kelzETwwHWAZ8aTKHmJy9Spl2
	Bj9IooTJNLQjfc8OsVIg0yNA0Oqjpe0l9+KJczLR+k1/ugx5zb3GfiBeCNp9LEX26vaHxK/47jFaF
	QOdMaZQUwxi7KPJzI2xQHXIFanyDaUIyR8+dr26oucINoIHAfmjEggizXDYSiUeAqjxMzHd3Z8aA2
	/26BV191Yernj8CyI+idAm9ewB3mlFZ4NEvITj8icEhi0IXR2bhSvuhXZdHRaa5j/Kmnz5uGjF27u
	bVCPdvV7EQSfRatBny1g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.2 #3 (Red Hat Linux))
	id 1iDd3R-00072O-6k; Thu, 26 Sep 2019 23:20:09 +0000
Received: from mta-02.yadro.com ([89.207.88.252] helo=mta-01.yadro.com)
 by bombadil.infradead.org with esmtps (Exim 4.92.2 #3 (Red Hat Linux))
 id 1iDd3O-0005pb-2C
 for linux-nvme@lists.infradead.org; Thu, 26 Sep 2019 23:20:08 +0000
Received: from localhost (unknown [127.0.0.1])
 by mta-01.yadro.com (Postfix) with ESMTP id 4A73A4120A;
 Thu, 26 Sep 2019 23:20:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
 content-type:content-type:mime-version:x-mailer:message-id:date
 :date:subject:subject:from:from:received:received:received; s=
 mta-01; t=1569540000; x=1571354401; bh=TjkazbXDoWc0hC4o1b+1yAkL5
 a6pTsLASjXeTHxcKbM=; b=g0Ig5vN1Oxk3I3vAFAKI99GdLv5ef3n4l4fxRW8Km
 0r1Stwl4TCh3blfKB8OX+kr/jLEnZjAdKAzOfdgeQOGvELWq1ND/SlX/0FNgfPIw
 NtwPrEycyyz/GbJrgfK3cI15QNNXhXJKlVqma893aGJPiauRJ7pwCzTUeSSItpGQ
 tQ=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
 by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id jQAZBMDZaB9h; Fri, 27 Sep 2019 02:20:00 +0300 (MSK)
Received: from T-EXCH-02.corp.yadro.com (t-exch-02.corp.yadro.com
 [172.17.10.102])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by mta-01.yadro.com (Postfix) with ESMTPS id EE972404CF;
 Fri, 27 Sep 2019 02:19:58 +0300 (MSK)
Received: from ttln-dm-ec-sle15-sp1-0.yadro.com (10.100.1.122) by
 T-EXCH-02.corp.yadro.com (172.17.10.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.1.669.32; Fri, 27 Sep 2019 02:19:54 +0300
From: Mikhail Malygin <m.malygin@yadro.com>
To: <linux-nvme@lists.infradead.org>
Subject: [PATCH] nvmet: add revalidate ns sysfs attribute to handle device
 resize
Date: Fri, 27 Sep 2019 02:19:40 +0300
Message-ID: <20190926231940.7494-1-m.malygin@yadro.com>
X-Mailer: git-send-email 2.16.4
MIME-Version: 1.0
X-Originating-IP: [10.100.1.122]
X-ClientProxiedBy: T-EXCH-01.corp.yadro.com (172.17.10.101) To
 T-EXCH-02.corp.yadro.com (172.17.10.102)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190926_162006_499136_033234CC 
X-CRM114-Status: GOOD (  13.49  )
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
Cc: Christoph Hellwig <hch@lst.de>, Mikhail Malygin <m.malygin@yadro.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Currently device size is cached in ns->size field on namespace enable, so
any device size change after that can't bee seen by initiator.
This patch adds revalidate namespace attribute. Once it is written,
target refreshes ns->size property and calls nvmet_ns_changed
so initator may perform namespace rescan

Signed-off-by: Mikhail Malygin <m.malygin@yadro.com>
---
 drivers/nvme/target/configfs.c    | 14 +++++++++++
 drivers/nvme/target/core.c        | 23 +++++++++++++++++
 drivers/nvme/target/io-cmd-bdev.c | 16 ++++++++++--
 drivers/nvme/target/io-cmd-file.c | 42 ++++++++++++++++++++++---------
 drivers/nvme/target/nvmet.h       |  3 +++
 5 files changed, 84 insertions(+), 14 deletions(-)

diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
index 98613a45bd3b..06566ad1d197 100644
--- a/drivers/nvme/target/configfs.c
+++ b/drivers/nvme/target/configfs.c
@@ -545,6 +545,19 @@ static ssize_t nvmet_ns_buffered_io_store(struct config_item *item,
 
 CONFIGFS_ATTR(nvmet_ns_, buffered_io);
 
+static ssize_t nvmet_ns_revalidate_store(struct config_item *item,
+		const char *page, size_t count)
+{
+	struct nvmet_ns *ns = to_nvmet_ns(item);
+	int ret = 0;
+
+	ret = nvmet_ns_revalidate(ns);
+
+	return ret ? ret : count;
+}
+
+CONFIGFS_ATTR_WO(nvmet_ns_, revalidate);
+
 static struct configfs_attribute *nvmet_ns_attrs[] = {
 	&nvmet_ns_attr_device_path,
 	&nvmet_ns_attr_device_nguid,
@@ -552,6 +565,7 @@ static struct configfs_attribute *nvmet_ns_attrs[] = {
 	&nvmet_ns_attr_ana_grpid,
 	&nvmet_ns_attr_enable,
 	&nvmet_ns_attr_buffered_io,
+	&nvmet_ns_attr_revalidate,
 #ifdef CONFIG_PCI_P2PDMA
 	&nvmet_ns_attr_p2pmem,
 #endif
diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index 3a67e244e568..1d90803e3c9a 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -620,6 +620,29 @@ void nvmet_ns_disable(struct nvmet_ns *ns)
 	mutex_unlock(&subsys->lock);
 }
 
+int nvmet_ns_revalidate(struct nvmet_ns *ns)
+{
+	struct nvmet_subsys *subsys = ns->subsys;
+	int ret = 0;
+
+	mutex_lock(&subsys->lock);
+	if(!ns->enabled){
+		goto out_unlock;
+	}
+
+	if(ns->bdev){
+		ret = nvmet_bdev_ns_revalidate(ns);
+	}else if(ns->file){
+		ret = nvmet_file_ns_revalidate(ns);
+	}
+
+	nvmet_ns_changed(subsys, ns->nsid);
+
+out_unlock:
+	mutex_unlock(&subsys->lock);
+	return ret;
+}
+
 void nvmet_ns_free(struct nvmet_ns *ns)
 {
 	nvmet_ns_disable(ns);
diff --git a/drivers/nvme/target/io-cmd-bdev.c b/drivers/nvme/target/io-cmd-bdev.c
index de0bff70ebb6..ea55bbe93813 100644
--- a/drivers/nvme/target/io-cmd-bdev.c
+++ b/drivers/nvme/target/io-cmd-bdev.c
@@ -47,6 +47,12 @@ void nvmet_bdev_set_limits(struct block_device *bdev, struct nvme_id_ns *id)
 	id->nows = to0based(ql->io_opt / ql->logical_block_size);
 }
 
+static void nvmet_bdev_ns_read_size(struct nvmet_ns *ns)
+{
+	ns->size = i_size_read(ns->bdev->bd_inode);
+	ns->blksize_shift = blksize_bits(bdev_logical_block_size(ns->bdev));
+}
+
 int nvmet_bdev_ns_enable(struct nvmet_ns *ns)
 {
 	int ret;
@@ -62,8 +68,8 @@ int nvmet_bdev_ns_enable(struct nvmet_ns *ns)
 		ns->bdev = NULL;
 		return ret;
 	}
-	ns->size = i_size_read(ns->bdev->bd_inode);
-	ns->blksize_shift = blksize_bits(bdev_logical_block_size(ns->bdev));
+
+	nvmet_bdev_ns_read_size(ns);
 	return 0;
 }
 
@@ -75,6 +81,12 @@ void nvmet_bdev_ns_disable(struct nvmet_ns *ns)
 	}
 }
 
+int nvmet_bdev_ns_revalidate(struct nvmet_ns *ns)
+{
+	nvmet_bdev_ns_read_size(ns);
+	return 0;
+}
+
 static u16 blk_to_nvme_status(struct nvmet_req *req, blk_status_t blk_sts)
 {
 	u16 status = NVME_SC_SUCCESS;
diff --git a/drivers/nvme/target/io-cmd-file.c b/drivers/nvme/target/io-cmd-file.c
index 05453f5d1448..84a2d664d39a 100644
--- a/drivers/nvme/target/io-cmd-file.c
+++ b/drivers/nvme/target/io-cmd-file.c
@@ -27,10 +27,30 @@ void nvmet_file_ns_disable(struct nvmet_ns *ns)
 	}
 }
 
+static int nvmet_file_ns_read_size(struct nvmet_ns *ns)
+{
+	int ret;
+	struct kstat stat;
+
+	ret = vfs_getattr(&ns->file->f_path,
+			&stat, STATX_SIZE, AT_STATX_FORCE_SYNC);
+	if (ret)
+		return ret;
+
+	ns->size = stat.size;
+	/*
+	 * i_blkbits can be greater than the universally accepted upper bound,
+	 * so make sure we export a sane namespace lba_shift.
+	 */
+	ns->blksize_shift = min_t(u8,
+			file_inode(ns->file)->i_blkbits, 12);
+
+	return 0;
+}
+
 int nvmet_file_ns_enable(struct nvmet_ns *ns)
 {
 	int flags = O_RDWR | O_LARGEFILE;
-	struct kstat stat;
 	int ret;
 
 	if (!ns->buffered_io)
@@ -43,18 +63,11 @@ int nvmet_file_ns_enable(struct nvmet_ns *ns)
 		return PTR_ERR(ns->file);
 	}
 
-	ret = vfs_getattr(&ns->file->f_path,
-			&stat, STATX_SIZE, AT_STATX_FORCE_SYNC);
-	if (ret)
-		goto err;
+	ret = nvmet_file_ns_read_size(ns);
 
-	ns->size = stat.size;
-	/*
-	 * i_blkbits can be greater than the universally accepted upper bound,
-	 * so make sure we export a sane namespace lba_shift.
-	 */
-	ns->blksize_shift = min_t(u8,
-			file_inode(ns->file)->i_blkbits, 12);
+	if(ret){
+		goto err;
+	}
 
 	ns->bvec_cache = kmem_cache_create("nvmet-bvec",
 			NVMET_MAX_MPOOL_BVEC * sizeof(struct bio_vec),
@@ -80,6 +93,11 @@ int nvmet_file_ns_enable(struct nvmet_ns *ns)
 	return ret;
 }
 
+int nvmet_file_ns_revalidate(struct nvmet_ns *ns)
+{
+	return nvmet_file_ns_read_size(ns);
+}
+
 static void nvmet_file_init_bvec(struct bio_vec *bv, struct scatterlist *sg)
 {
 	bv->bv_page = sg_page(sg);
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index c51f8dd01dc4..a9453e63e5dd 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -408,6 +408,7 @@ struct nvmet_ns *nvmet_find_namespace(struct nvmet_ctrl *ctrl, __le32 nsid);
 void nvmet_put_namespace(struct nvmet_ns *ns);
 int nvmet_ns_enable(struct nvmet_ns *ns);
 void nvmet_ns_disable(struct nvmet_ns *ns);
+int nvmet_ns_revalidate(struct nvmet_ns *ns);
 struct nvmet_ns *nvmet_ns_alloc(struct nvmet_subsys *subsys, u32 nsid);
 void nvmet_ns_free(struct nvmet_ns *ns);
 
@@ -485,6 +486,8 @@ int nvmet_bdev_ns_enable(struct nvmet_ns *ns);
 int nvmet_file_ns_enable(struct nvmet_ns *ns);
 void nvmet_bdev_ns_disable(struct nvmet_ns *ns);
 void nvmet_file_ns_disable(struct nvmet_ns *ns);
+int nvmet_bdev_ns_revalidate(struct nvmet_ns *ns);
+int nvmet_file_ns_revalidate(struct nvmet_ns *ns);
 u16 nvmet_bdev_flush(struct nvmet_req *req);
 u16 nvmet_file_flush(struct nvmet_req *req);
 void nvmet_ns_changed(struct nvmet_subsys *subsys, u32 nsid);
-- 


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
