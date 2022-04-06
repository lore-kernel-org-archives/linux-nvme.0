Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2CEAC433EF
	for <linux-nvme@archiver.kernel.org>; Wed,  6 Apr 2022 06:29:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=CCltYPwX8bAZQe3AOk2m+rVDM7liIR3xNyzg1pXv0K0=; b=BPoOBNBVkQRQ/34pzH46VkqbPn
	b2Er47A3+ebB6xh+ASmrGdRQ/0KmNQNpluFrtCkypsRN2yvXu2jUlgbAWG0bfEl2nUIMmgM/6ZNxL
	vY7GoXMYDMXaX2QRi495ww8+39/NoU2MLN/ecSvvVRiRG3M2xtUbgJ5Jx6F5xF1eTQmDxoMUxVIvo
	jfdWqqZqrTasK6M8cGAX8FdYr2G5SN/yFR+I6Nr9QL4dDkt/xOW8nGRq3b1zD+wQoV4zI4mvuQ6Jx
	TKNl0PvIe4D6FnkFrl40MlvcaF8kCC3JGiHSHDambJ1UWLnWgk4sDvjjQKQRe5zXfQYc/mRtAaKp5
	8TI0kboA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nbzAO-0047SI-Oc; Wed, 06 Apr 2022 06:29:20 +0000
Received: from 213-225-3-188.nat.highway.a1.net ([213.225.3.188]
 helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nbyoO-003vfZ-P9; Wed, 06 Apr 2022 06:06:37 +0000
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
Subject: [PATCH 20/27] block: use bdev_discard_alignment in
 part_discard_alignment_show
Date: Wed,  6 Apr 2022 08:05:09 +0200
Message-Id: <20220406060516.409838-21-hch@lst.de>
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

Use the bdev based alignment helper instead of open coding it.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/partitions/core.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/block/partitions/core.c b/block/partitions/core.c
index 240b3fff521e4..70dec1c78521d 100644
--- a/block/partitions/core.c
+++ b/block/partitions/core.c
@@ -206,11 +206,7 @@ static ssize_t part_alignment_offset_show(struct device *dev,
 static ssize_t part_discard_alignment_show(struct device *dev,
 					   struct device_attribute *attr, char *buf)
 {
-	struct block_device *bdev = dev_to_bdev(dev);
-
-	return sprintf(buf, "%u\n",
-		queue_limit_discard_alignment(&bdev_get_queue(bdev)->limits,
-				bdev->bd_start_sect));
+	return sprintf(buf, "%u\n", bdev_discard_alignment(dev_to_bdev(dev)));
 }
 
 static DEVICE_ATTR(partition, 0444, part_partition_show, NULL);
-- 
2.30.2


