Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E0F5C27C52
	for <linux-nvme@archiver.kernel.org>; Wed,  5 Jun 2024 06:30:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hID966GzAmGkJoW58zcCvS0V7nWIipRFGVluJmB6pqg=; b=fBTREKH4WoFYbs8haEz858/Gc+
	MUmDzwrAho703GjyPJvs8aRyIFTz8K+tWG1cVDg2rlnKpHS2+VE1jrr8y9NowkZSyGtX0rNX2gIxg
	CwC95a78ol3Qdy2JYYqwbQq24FuhVO4915Sh+EIARHs+FvIFmgN4QgQIThA2aBIZtI9UgMmaTZbfI
	cP3+wvsk3KdgFx8kHyyyiddqmz5qJK1uaci9UgsZlZCMeIuw58OW9DX0nPjlasOp5CBwqSEduC+Uj
	phvKFmlVECSR1JguSGfBYCnIcSzjcKP9qy8/iXetl2ZHahadPyn+6U+qyPzVbefHyv3vXqmkej61/
	XvxutxZw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sEkAk-00000004mkd-3cqs;
	Wed, 05 Jun 2024 06:30:58 +0000
Received: from 2a02-8389-2341-5b80-5bcb-678a-c0a8-08fe.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:5bcb:678a:c0a8:8fe] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sEkAh-00000004meA-2xA5;
	Wed, 05 Jun 2024 06:30:56 +0000
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
Subject: [PATCH 06/12] block: factor out flag_{store,show} helper for integrity
Date: Wed,  5 Jun 2024 08:28:35 +0200
Message-ID: <20240605063031.3286655-7-hch@lst.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240605063031.3286655-1-hch@lst.de>
References: <20240605063031.3286655-1-hch@lst.de>
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
---
 block/blk-integrity.c | 53 +++++++++++++++++++++----------------------
 1 file changed, 26 insertions(+), 27 deletions(-)

diff --git a/block/blk-integrity.c b/block/blk-integrity.c
index e11b815c03c981..686b6adf0ea5c7 100644
--- a/block/blk-integrity.c
+++ b/block/blk-integrity.c
@@ -241,6 +241,28 @@ const char *blk_integrity_profile_name(struct blk_integrity *bi)
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
@@ -273,49 +295,26 @@ static ssize_t read_verify_store(struct device *dev,
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


