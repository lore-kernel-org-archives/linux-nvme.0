Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12CF7C02180
	for <linux-nvme@archiver.kernel.org>; Wed, 15 Jan 2025 11:53:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=H+mmprM1F/69KqAa5PAAyTaPeL8maBmZ4e2eN76AfVc=; b=XKg+H9iuY9WZfYEKRF+SGp43qa
	K3Nd7wV6tRnIIyV3trEO2r5nQ4TX/yyrCnEySD4lFge4H4MSpd6c3mWQk00vFhlDkAVbwUZy0TXp+
	VUmq5mTiRTJQu2U70KkpOHYCcdhNAxwdZ50xxco3lTCSJl5aCgjGooz2qQVEy9gsLh8tWnwiLgwwY
	Izm9ZgfmUmt4BHPImgrIYEbBfaaZDqOzUebLkH5dKoGB368Acm9fMzo25Bxx8/5Vdgo7ksoW5l6Kb
	gnbhitkAzxA2IG0mbmU+F0sNFVL/QM5suVrUbf5Z0JuTY8F2FT9Gf08F8VZfJsa+9WJ+wsdDKBbZt
	4kIIjQsg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tY1xd-0000000BkpB-0EKF;
	Wed, 15 Jan 2025 11:53:25 +0000
Received: from dggsgout12.his.huawei.com ([45.249.212.56])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tY1wX-0000000BkQa-0pLl
	for linux-nvme@lists.infradead.org;
	Wed, 15 Jan 2025 11:52:19 +0000
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4YY48z3x9Yz4f3jRC
	for <linux-nvme@lists.infradead.org>; Wed, 15 Jan 2025 19:51:47 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id EA7041A018D
	for <linux-nvme@lists.infradead.org>; Wed, 15 Jan 2025 19:52:07 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgC3Gl9aoYdnvK0ZBA--.21959S5;
	Wed, 15 Jan 2025 19:52:07 +0800 (CST)
From: Zhang Yi <yi.zhang@huaweicloud.com>
To: linux-fsdevel@vger.kernel.org,
	linux-ext4@vger.kernel.org,
	linux-block@vger.kernel.org,
	dm-devel@lists.linux.dev,
	linux-nvme@lists.infradead.org,
	linux-scsi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	hch@lst.de,
	tytso@mit.edu,
	djwong@kernel.org,
	yi.zhang@huawei.com,
	yi.zhang@huaweicloud.com,
	chengzhihao1@huawei.com,
	yukuai3@huawei.com,
	yangerkun@huawei.com
Subject: [RFC PATCH v2 1/8] block: introduce BLK_FEAT_WRITE_ZEROES_UNMAP to queue limits features
Date: Wed, 15 Jan 2025 19:46:30 +0800
Message-Id: <20250115114637.2705887-2-yi.zhang@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20250115114637.2705887-1-yi.zhang@huaweicloud.com>
References: <20250115114637.2705887-1-yi.zhang@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgC3Gl9aoYdnvK0ZBA--.21959S5
X-Coremail-Antispam: 1UD129KBjvJXoWxXrWrtw4ruw1xWr17ZrykuFg_yoW7JF1kpa
	4DKF1UtryjgF47A3Z7CF17XF129ayvkrWfGFZFk345ur42gr1xWF4kKa45X348X39xWay0
	qa1UKrZxu3yUC3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUm014x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jr4l82xGYIkIc2
	x26xkF7I0E14v26r4j6ryUM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
	A2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS
	0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2
	IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0
	Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kIc2
	xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWU
	JVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67
	kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY
	6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0x
	vEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVj
	vjDU0xZFpf9x0JUIiiDUUUUU=
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250115_035217_598263_84E74BE1 
X-CRM114-Status: GOOD (  17.92  )
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

From: Zhang Yi <yi.zhang@huawei.com>

Currently, it's hard to know whether the storage device supports unmap
write zeroes. We cannot determine it only by checking if the disk
supports the write zeroes command, as for some HDDs that do submit
actual zeros to the disk media even if they claim to support the write
zeroes command, but that should be very slow.

Therefor, add a new queue limit feature, BLK_FEAT_WRITE_ZEROES_UNMAP and
the corresponding sysfs entry, to indicate whether the block device
explicitly supports the unmapped write zeroes command. Each device
driver should set this bit if it is certain that the attached disk
supports this command. If the bit is not set, the disk either does not
support it, or its support status is unknown.

For the stacked devices cases, the BLK_FEAT_WRITE_ZEROES_UNMAP should be
supported both by the stacking driver and all underlying devices.

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
---
 Documentation/ABI/stable/sysfs-block | 14 ++++++++++++++
 block/blk-settings.c                 |  6 ++++++
 block/blk-sysfs.c                    |  3 +++
 include/linux/blkdev.h               |  3 +++
 4 files changed, 26 insertions(+)

diff --git a/Documentation/ABI/stable/sysfs-block b/Documentation/ABI/stable/sysfs-block
index 0cceb2badc83..ab4117cefd9a 100644
--- a/Documentation/ABI/stable/sysfs-block
+++ b/Documentation/ABI/stable/sysfs-block
@@ -722,6 +722,20 @@ Description:
 		0, write zeroes is not supported by the device.
 
 
+What:		/sys/block/<disk>/queue/write_zeroes_unmap
+Date:		January 2025
+Contact:	Zhang Yi <yi.zhang@huawei.com>
+Description:
+		[RO] Devices that explicitly support the unmap write zeroes
+		operation in which a single write zeroes request with the unmap
+		bit set to zero out the range of contiguous blocks on storage
+		by freeing blocks, rather than writing physical zeroes to the
+		media. If write_zeroes_unmap is 1, this indicates that the
+		device explicitly supports the write zero command. Otherwise,
+		the device either does not support it, or its support status is
+		unknown.
+
+
 What:		/sys/block/<disk>/queue/zone_append_max_bytes
 Date:		May 2020
 Contact:	linux-block@vger.kernel.org
diff --git a/block/blk-settings.c b/block/blk-settings.c
index 8f09e33f41f6..a8bf2f8f0634 100644
--- a/block/blk-settings.c
+++ b/block/blk-settings.c
@@ -652,6 +652,8 @@ int blk_stack_limits(struct queue_limits *t, struct queue_limits *b,
 		t->features &= ~BLK_FEAT_NOWAIT;
 	if (!(b->features & BLK_FEAT_POLL))
 		t->features &= ~BLK_FEAT_POLL;
+	if (!(b->features & BLK_FEAT_WRITE_ZEROES_UNMAP))
+		t->features &= ~BLK_FEAT_WRITE_ZEROES_UNMAP;
 
 	t->flags |= (b->flags & BLK_FLAG_MISALIGNED);
 
@@ -774,6 +776,10 @@ int blk_stack_limits(struct queue_limits *t, struct queue_limits *b,
 		t->zone_write_granularity = 0;
 		t->max_zone_append_sectors = 0;
 	}
+
+	if (!t->max_write_zeroes_sectors)
+		t->features &= ~BLK_FEAT_WRITE_ZEROES_UNMAP;
+
 	blk_stack_atomic_writes_limits(t, b);
 
 	return ret;
diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index 767598e719ab..13f22bee19d2 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -248,6 +248,7 @@ static ssize_t queue_##_name##_show(struct gendisk *disk, char *page)	\
 QUEUE_SYSFS_FEATURE_SHOW(poll, BLK_FEAT_POLL);
 QUEUE_SYSFS_FEATURE_SHOW(fua, BLK_FEAT_FUA);
 QUEUE_SYSFS_FEATURE_SHOW(dax, BLK_FEAT_DAX);
+QUEUE_SYSFS_FEATURE_SHOW(write_zeroes_unmap, BLK_FEAT_WRITE_ZEROES_UNMAP);
 
 static ssize_t queue_zoned_show(struct gendisk *disk, char *page)
 {
@@ -468,6 +469,7 @@ QUEUE_RO_ENTRY(queue_atomic_write_unit_min, "atomic_write_unit_min_bytes");
 
 QUEUE_RO_ENTRY(queue_write_same_max, "write_same_max_bytes");
 QUEUE_RO_ENTRY(queue_max_write_zeroes_sectors, "write_zeroes_max_bytes");
+QUEUE_RO_ENTRY(queue_write_zeroes_unmap, "write_zeroes_unmap");
 QUEUE_RO_ENTRY(queue_max_zone_append_sectors, "zone_append_max_bytes");
 QUEUE_RO_ENTRY(queue_zone_write_granularity, "zone_write_granularity");
 
@@ -615,6 +617,7 @@ static struct attribute *queue_attrs[] = {
 	&queue_poll_delay_entry.attr,
 	&queue_virt_boundary_mask_entry.attr,
 	&queue_dma_alignment_entry.attr,
+	&queue_write_zeroes_unmap_entry.attr,
 	NULL,
 };
 
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 378d3a1a22fc..14ba1e2709bb 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -335,6 +335,9 @@ typedef unsigned int __bitwise blk_features_t;
 #define BLK_FEAT_ATOMIC_WRITES_STACKED \
 	((__force blk_features_t)(1u << 16))
 
+/* supports unmap write zeroes command */
+#define BLK_FEAT_WRITE_ZEROES_UNMAP	((__force blk_features_t)(1u << 17))
+
 /*
  * Flags automatically inherited when stacking limits.
  */
-- 
2.39.2


