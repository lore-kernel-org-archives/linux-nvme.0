Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3394DC27C53
	for <linux-nvme@archiver.kernel.org>; Fri,  7 Jun 2024 06:01:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=EJTuri4ponQChrNj2eAk+TPRiVEUrtH2e5ttPL+QHco=; b=sSaZNzG2LH8ARsTfHjX3r/GXVt
	7MHNSCgfk/fRdrLyH341vCI/Meqj4EGGX/fiLyCwYcBcPDx2KSLSJxGAdpDYh+mkZT2OvU4TXfxOb
	cZVcFJ7h8WALxHdJHkiY2uUcJhAPB5yVpkmAWCArhRZ/PHBLoqJjYTDRZdICq75hFqDbV+UjrHFnw
	Oa+R1GpNsUgwQysAFsX8c7WFFwoC4zVKBrE1LNamVylHZK9vfHudkMCNsjnkGR3fVi4Ogti0+zHSa
	MTt4n9eOT1iKRpTtM53Z/4qkdjbB541eX/GhxtCj2qxtX1rZI2iE1AWxbzA3VELGMGPPAby8A2dRN
	obBKC/Yw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sFSer-0000000Capv-1hq7;
	Fri, 07 Jun 2024 06:01:04 +0000
Received: from [2001:4bb8:2dd:aa7c:2c19:fa33:48d4:a32f] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sFSdk-0000000CaBh-28Rd;
	Fri, 07 Jun 2024 05:59:53 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>,
	"Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Mike Snitzer <snitzer@kernel.org>,
	Mikulas Patocka <mpatocka@redhat.com>,
	Song Liu <song@kernel.org>,
	Yu Kuai <yukuai3@huawei.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	linux-block@vger.kernel.org,
	dm-devel@lists.linux.dev,
	linux-raid@vger.kernel.org,
	nvdimm@lists.linux.dev,
	linux-nvme@lists.infradead.org,
	linux-scsi@vger.kernel.org
Subject: [PATCH 10/11] block: invert the BLK_INTEGRITY_{GENERATE,VERIFY} flags
Date: Fri,  7 Jun 2024 07:59:04 +0200
Message-ID: <20240607055912.3586772-11-hch@lst.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240607055912.3586772-1-hch@lst.de>
References: <20240607055912.3586772-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Invert the flags so that user set values will be able to persist
revalidating the integrity information once we switch the integrity
information to queue_limits.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
---
 block/bio-integrity.c         |  4 ++--
 block/blk-integrity.c         | 18 +++++++++---------
 include/linux/blk-integrity.h |  4 ++--
 3 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/block/bio-integrity.c b/block/bio-integrity.c
index e23acf59c12de3..48ddbc703cd8ff 100644
--- a/block/bio-integrity.c
+++ b/block/bio-integrity.c
@@ -448,10 +448,10 @@ bool bio_integrity_prep(struct bio *bio)
 		return true;
 
 	if (bio_data_dir(bio) == READ) {
-		if (!(bi->flags & BLK_INTEGRITY_VERIFY))
+		if (bi->flags & BLK_INTEGRITY_NOVERIFY)
 			return true;
 	} else {
-		if (!(bi->flags & BLK_INTEGRITY_GENERATE))
+		if (bi->flags & BLK_INTEGRITY_NOGENERATE)
 			return true;
 
 		/*
diff --git a/block/blk-integrity.c b/block/blk-integrity.c
index bec0d1df387ce9..b37b8855eed147 100644
--- a/block/blk-integrity.c
+++ b/block/blk-integrity.c
@@ -254,10 +254,11 @@ static ssize_t flag_store(struct device *dev, struct device_attribute *attr,
 	if (err)
 		return err;
 
+	/* the flags are inverted vs the values in the sysfs files */
 	if (val)
-		bi->flags |= flag;
-	else
 		bi->flags &= ~flag;
+	else
+		bi->flags |= flag;
 	return count;
 }
 
@@ -266,7 +267,7 @@ static ssize_t flag_show(struct device *dev, struct device_attribute *attr,
 {
 	struct blk_integrity *bi = dev_to_bi(dev);
 
-	return sysfs_emit(page, "%d\n", !!(bi->flags & flag));
+	return sysfs_emit(page, "%d\n", !(bi->flags & flag));
 }
 
 static ssize_t format_show(struct device *dev, struct device_attribute *attr,
@@ -301,26 +302,26 @@ static ssize_t read_verify_store(struct device *dev,
 				 struct device_attribute *attr,
 				 const char *page, size_t count)
 {
-	return flag_store(dev, attr, page, count, BLK_INTEGRITY_VERIFY);
+	return flag_store(dev, attr, page, count, BLK_INTEGRITY_NOVERIFY);
 }
 
 static ssize_t read_verify_show(struct device *dev,
 				struct device_attribute *attr, char *page)
 {
-	return flag_show(dev, attr, page, BLK_INTEGRITY_VERIFY);
+	return flag_show(dev, attr, page, BLK_INTEGRITY_NOVERIFY);
 }
 
 static ssize_t write_generate_store(struct device *dev,
 				    struct device_attribute *attr,
 				    const char *page, size_t count)
 {
-	return flag_store(dev, attr, page, count, BLK_INTEGRITY_GENERATE);
+	return flag_store(dev, attr, page, count, BLK_INTEGRITY_NOGENERATE);
 }
 
 static ssize_t write_generate_show(struct device *dev,
 				   struct device_attribute *attr, char *page)
 {
-	return flag_show(dev, attr, page, BLK_INTEGRITY_GENERATE);
+	return flag_show(dev, attr, page, BLK_INTEGRITY_NOGENERATE);
 }
 
 static ssize_t device_is_integrity_capable_show(struct device *dev,
@@ -371,8 +372,7 @@ void blk_integrity_register(struct gendisk *disk, struct blk_integrity *template
 	struct blk_integrity *bi = &disk->queue->integrity;
 
 	bi->csum_type = template->csum_type;
-	bi->flags = BLK_INTEGRITY_VERIFY | BLK_INTEGRITY_GENERATE |
-		template->flags;
+	bi->flags = template->flags;
 	bi->interval_exp = template->interval_exp ? :
 		ilog2(queue_logical_block_size(disk->queue));
 	bi->tuple_size = template->tuple_size;
diff --git a/include/linux/blk-integrity.h b/include/linux/blk-integrity.h
index 56ce1ae355805d..bafa01d4e7f95b 100644
--- a/include/linux/blk-integrity.h
+++ b/include/linux/blk-integrity.h
@@ -7,8 +7,8 @@
 struct request;
 
 enum blk_integrity_flags {
-	BLK_INTEGRITY_VERIFY		= 1 << 0,
-	BLK_INTEGRITY_GENERATE		= 1 << 1,
+	BLK_INTEGRITY_NOVERIFY		= 1 << 0,
+	BLK_INTEGRITY_NOGENERATE	= 1 << 1,
 	BLK_INTEGRITY_DEVICE_CAPABLE	= 1 << 2,
 	BLK_INTEGRITY_REF_TAG		= 1 << 3,
 };
-- 
2.43.0


