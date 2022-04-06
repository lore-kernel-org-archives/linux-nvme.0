Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EACB6C433F5
	for <linux-nvme@archiver.kernel.org>; Wed,  6 Apr 2022 06:23:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Z466ZFUUKBaH6hbYD0HK+8FHR1O7bsGB8sNIWBFJhOk=; b=NgY30h26H2PBMFC4VrCXmPXRCU
	ZupDav+70445qFJFB4nqkWZfR6YYRTrcgxYwnCREXFpO7AC7X4BKUr0bnnLXnnLmYLEh2d4NvmKdM
	ZEhzT6kUELTFEmvDf3a1Tje8/5wDlFtXWOSxLFJhsJ6KFf/5S27LM3BsodMUUkMwfgd4J1PMJIb8+
	2DVoW/2h/Q1bl2m1JEpq5ZQxBhXGVxnMYNG9UIy9XyUG39sIKNJKloXdz2+RoYL6AzErDFWTfVOl3
	E2Jjfq0lom+wDj/12HX87FAZoSlLLWuh55yvzpJOhIbDdChXjcvGnUB5GrgboNlz2VPOwshvjbIm2
	QC+/UJ0Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nbz4L-0044Dv-6i; Wed, 06 Apr 2022 06:23:05 +0000
Received: from 213-225-3-188.nat.highway.a1.net ([213.225.3.188]
 helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nbyo5-003vNP-I4; Wed, 06 Apr 2022 06:06:18 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: dm-devel@redhat.com, linux-xfs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-um@lists.infradead.org,
 linux-block@vger.kernel.org, drbd-dev@lists.linbit.com,
 nbd@other.debian.org, ceph-devel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, xen-devel@lists.xenproject.org,
 linux-bcache@vger.kernel.org, linux-raid@vger.kernel.org,
 linux-mmc@vger.kernel.org, linux-mtd@lists.infradead.org,
 linux-nvme@lists.infradead.org, linux-s390@vger.kernel.org,
 linux-scsi@vger.kernel.org, target-devel@vger.kernel.org,
 linux-btrfs@vger.kernel.org, linux-ext4@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com,
 jfs-discussion@lists.sourceforge.net, linux-nilfs@vger.kernel.org,
 ntfs3@lists.linux.dev, ocfs2-devel@oss.oracle.com, linux-mm@kvack.org
Subject: [PATCH 15/27] block: use bdev_alignment_offset in
 part_alignment_offset_show
Date: Wed,  6 Apr 2022 08:05:04 +0200
Message-Id: <20220406060516.409838-16-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220406060516.409838-1-hch@lst.de>
References: <20220406060516.409838-1-hch@lst.de>
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

Replace the open coded offset calculation with the proper helper.
This is an ABI change in that the -1 for a misaligned partition is
properly propagated, which can be considered a bug fix and maches
what is done on the whole device.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/partitions/core.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/block/partitions/core.c b/block/partitions/core.c
index 2ef8dfa1e5c85..240b3fff521e4 100644
--- a/block/partitions/core.c
+++ b/block/partitions/core.c
@@ -200,11 +200,7 @@ static ssize_t part_ro_show(struct device *dev,
 static ssize_t part_alignment_offset_show(struct device *dev,
 					  struct device_attribute *attr, char *buf)
 {
-	struct block_device *bdev = dev_to_bdev(dev);
-
-	return sprintf(buf, "%u\n",
-		queue_limit_alignment_offset(&bdev_get_queue(bdev)->limits,
-				bdev->bd_start_sect));
+	return sprintf(buf, "%u\n", bdev_alignment_offset(dev_to_bdev(dev)));
 }
 
 static ssize_t part_discard_alignment_show(struct device *dev,
-- 
2.30.2


