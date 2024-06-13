Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDE34C27C4F
	for <linux-nvme@archiver.kernel.org>; Thu, 13 Jun 2024 08:49:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MkqWB307uYilO32w43UhOiqouC5dD/MHs5vGR6/rVlA=; b=er/wEvrsTrs9EVJV1vGYokWZKb
	Us+iYtOBxHBc1TBChuQQM6+45lGHY/9Q5NitP7rO98rfRLmhTNBYplcbYPXOROJ2LIELEGKlw70RM
	lTUMFz0Pve5yBruJyW7/WegmGOu0sSgrg1zZKXe2WP/mAnj58FbgnxSBsatp7AenHSWO7MunUdhUB
	EyrtjHO9Kf6PfNDpuNyzERzWXLSBLiaR2+00/G1/vJlL3CTnKdP+YkyKRc/B1f/tFJxf85LLXh9+Z
	DME3CmpPH7S2BeC3g+jIhqabJYYzLzhaE4MUVkwbxkeO3dV0bvgHbf0R4TcMgDRkTiz9YBee/Xdvk
	d/HgXX+Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sHg8n-0000000FnFG-49d6;
	Thu, 13 Jun 2024 08:49:05 +0000
Received: from 2a02-8389-2341-5b80-034b-6bc2-b258-c831.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:34b:6bc2:b258:c831] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sHg8k-0000000FnBe-1BuJ;
	Thu, 13 Jun 2024 08:49:02 +0000
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
	linux-scsi@vger.kernel.org,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH 07/12] block: factor out flag_{store,show} helper for integrity
Date: Thu, 13 Jun 2024 10:48:17 +0200
Message-ID: <20240613084839.1044015-8-hch@lst.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240613084839.1044015-1-hch@lst.de>
References: <20240613084839.1044015-1-hch@lst.de>
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

Factor the duplicate code for the generate and verify attributes into
common helpers.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Keith Busch <kbusch@kernel.org>
Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
Reviewed-by: Hannes Reinecke <hare@suse.de>
---
 block/blk-integrity.c | 53 +++++++++++++++++++++----------------------
 1 file changed, 26 insertions(+), 27 deletions(-)

diff --git a/block/blk-integrity.c b/block/blk-integrity.c
index 24f04575096d39..24671d9f90a124 100644
--- a/block/blk-integrity.c
+++ b/block/blk-integrity.c
@@ -243,6 +243,28 @@ const char *blk_integrity_profile_name(struct blk_integrity *bi)
 }
 EXPORT_SYMBOL_GPL(blk_integrity_profile_name);
 
+static ssize_t flag_store(struct device *dev, struct device_attribute *attr,
+		const char *page, size_t count, unsigned char flag)
+{
+	struct blk_integrity *bi = dev_to_bi(dev);
+	char *p = (char *) page;
+	unsigned long val = simple_strtoul(p, &p, 10);
+
+	if (val)
+		bi->flags |= flag;
+	else
+		bi->flags &= ~flag;
+	return count;
+}
+
+static ssize_t flag_show(struct device *dev, struct device_attribute *attr,
+		char *page, unsigned char flag)
+{
+	struct blk_integrity *bi = dev_to_bi(dev);
+
+	return sysfs_emit(page, "%d\n", !!(bi->flags & flag));
+}
+
 static ssize_t format_show(struct device *dev, struct device_attribute *attr,
 			   char *page)
 {
@@ -275,49 +297,26 @@ static ssize_t read_verify_store(struct device *dev,
 				 struct device_attribute *attr,
 				 const char *page, size_t count)
 {
-	struct blk_integrity *bi = dev_to_bi(dev);
-	char *p = (char *) page;
-	unsigned long val = simple_strtoul(p, &p, 10);
-
-	if (val)
-		bi->flags |= BLK_INTEGRITY_VERIFY;
-	else
-		bi->flags &= ~BLK_INTEGRITY_VERIFY;
-
-	return count;
+	return flag_store(dev, attr, page, count, BLK_INTEGRITY_VERIFY);
 }
 
 static ssize_t read_verify_show(struct device *dev,
 				struct device_attribute *attr, char *page)
 {
-	struct blk_integrity *bi = dev_to_bi(dev);
-
-	return sysfs_emit(page, "%d\n", !!(bi->flags & BLK_INTEGRITY_VERIFY));
+	return flag_show(dev, attr, page, BLK_INTEGRITY_VERIFY);
 }
 
 static ssize_t write_generate_store(struct device *dev,
 				    struct device_attribute *attr,
 				    const char *page, size_t count)
 {
-	struct blk_integrity *bi = dev_to_bi(dev);
-
-	char *p = (char *) page;
-	unsigned long val = simple_strtoul(p, &p, 10);
-
-	if (val)
-		bi->flags |= BLK_INTEGRITY_GENERATE;
-	else
-		bi->flags &= ~BLK_INTEGRITY_GENERATE;
-
-	return count;
+	return flag_store(dev, attr, page, count, BLK_INTEGRITY_GENERATE);
 }
 
 static ssize_t write_generate_show(struct device *dev,
 				   struct device_attribute *attr, char *page)
 {
-	struct blk_integrity *bi = dev_to_bi(dev);
-
-	return sysfs_emit(page, "%d\n", !!(bi->flags & BLK_INTEGRITY_GENERATE));
+	return flag_show(dev, attr, page, BLK_INTEGRITY_GENERATE);
 }
 
 static ssize_t device_is_integrity_capable_show(struct device *dev,
-- 
2.43.0


