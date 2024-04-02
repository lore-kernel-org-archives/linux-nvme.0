Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F538CD1284
	for <linux-nvme@archiver.kernel.org>; Tue,  2 Apr 2024 12:39:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7aj7kkyIp5LKmQ29hMmW1l7uduelVY2RwGjyUeekqzI=; b=ZwGEqjrQ78nlrn3mGJDpxi8iQv
	UWSM9G2GV/hmaR/0Lkq11wDF2DwRwVi1vSk0Oa/3VfUyOrzLeENoaxEwONo4Uvc70ku1q+JmQVdEr
	n029rwoVDz2wIvGgc2YT/MIS6Obdh2xevXryqDEYC9+mocGgg1NrVQ6aPF66f2eSNqnghaWSzdjOj
	HuHB+SYHaXykdqmpg2SBMJiCwiJ/epDA7/A3H4ep92TMpURgq92R8C93UCgOazq6kzsClKkMF+p+O
	Gi6boylUImDxdsQI+8KmX4ynE9zE+oscuplLGbnPyK3XdDAOaMloMfE20KYhjYnKiEOgtov29106D
	MYI8RglQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rrdQV-0000000B6Y3-2Oqo;
	Tue, 02 Apr 2024 12:39:43 +0000
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rrdQ9-0000000B6EN-41Dh
	for linux-nvme@lists.infradead.org;
	Tue, 02 Apr 2024 12:39:25 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 2FEC0CE1B58;
	Tue,  2 Apr 2024 12:39:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1750C43390;
	Tue,  2 Apr 2024 12:39:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712061558;
	bh=x5cFsMGD/lA3hPfk3eS2pT7dUwKOv8FM7clCI0JESDk=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=pYyU8iRa6dmkiKARx7QqPSKiM6djIDOKqzjFQkbHuwikj6PjmlnTFXrwQoL+TSn8u
	 XUMM1asNZpMtkQxqKC6C4pNiVJojbiBJnVtzx7JSbEPagoPbJE8+7YglHuzu4nNvhl
	 1AExlmLWLIfYxnKr0dpWEDWEaBuY8kCcbWc25EKLybqM464isGH8/C1HyFzQE+p/Tj
	 gDQ0qBSqV+pdMAiJ1njW/EMKmYQn9WXJQPLrMV/5RXx4nKD4hWPm0tLjYh42HR2wut
	 1bInqvXX8ReotnqL/0L5CsYKiPxP+pxfkIXUwvD4eOfPy7S8jf6U8v8GA6t82tAFoM
	 6xyyq7zgw7E8A==
From: Damien Le Moal <dlemoal@kernel.org>
To: linux-block@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>,
	linux-scsi@vger.kernel.org,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	dm-devel@lists.linux.dev,
	Mike Snitzer <snitzer@redhat.com>,
	linux-nvme@lists.infradead.org,
	Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>
Subject: [PATCH v4 06/28] block: Remember zone capacity when revalidating zones
Date: Tue,  2 Apr 2024 21:38:45 +0900
Message-ID: <20240402123907.512027-7-dlemoal@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240402123907.512027-1-dlemoal@kernel.org>
References: <20240402123907.512027-1-dlemoal@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240402_053922_572403_3C42BC81 
X-CRM114-Status: GOOD (  19.26  )
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

In preparation for adding zone write plugging, modify
blk_revalidate_disk_zones() to get the capacity of zones of a zoned
block device. This capacity value as a number of 512B sectors is stored
in the gendisk zone_capacity field.

Given that host-managed SMR disks (including zoned UFS drives) and all
known NVMe ZNS devices have the same zone capacity for all zones
blk_revalidate_disk_zones() returns an error if different capacities are
detected for different zones.

This also adds check to verify that the values reported by the device
for zone capacities are correct, that is, that the zone capacity is
never 0, does not exceed the zone size and is equal to the zone size for
conventional zones.

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-zoned.c      | 26 ++++++++++++++++++++++++++
 include/linux/blkdev.h |  1 +
 2 files changed, 27 insertions(+)

diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index da0f4b2a8fa0..23d9bb21c459 100644
--- a/block/blk-zoned.c
+++ b/block/blk-zoned.c
@@ -438,6 +438,7 @@ struct blk_revalidate_zone_args {
 	unsigned long	*conv_zones_bitmap;
 	unsigned long	*seq_zones_wlock;
 	unsigned int	nr_zones;
+	unsigned int	zone_capacity;
 	sector_t	sector;
 };
 
@@ -482,9 +483,20 @@ static int blk_revalidate_zone_cb(struct blk_zone *zone, unsigned int idx,
 		return -ENODEV;
 	}
 
+	if (!zone->capacity || zone->capacity > zone->len) {
+		pr_warn("%s: Invalid zone capacity\n",
+			disk->disk_name);
+		return -ENODEV;
+	}
+
 	/* Check zone type */
 	switch (zone->type) {
 	case BLK_ZONE_TYPE_CONVENTIONAL:
+		if (zone->capacity != zone->len) {
+			pr_warn("%s: Invalid conventional zone capacity\n",
+				disk->disk_name);
+			return -ENODEV;
+		}
 		if (!args->conv_zones_bitmap) {
 			args->conv_zones_bitmap =
 				blk_alloc_zone_bitmap(q->node, args->nr_zones);
@@ -500,6 +512,18 @@ static int blk_revalidate_zone_cb(struct blk_zone *zone, unsigned int idx,
 			if (!args->seq_zones_wlock)
 				return -ENOMEM;
 		}
+
+		/*
+		 * Remember the capacity of the first sequential zone and check
+		 * if it is constant for all zones.
+		 */
+		if (!args->zone_capacity)
+			args->zone_capacity = zone->capacity;
+		if (zone->capacity != args->zone_capacity) {
+			pr_warn("%s: Invalid variable zone capacity\n",
+				disk->disk_name);
+			return -ENODEV;
+		}
 		break;
 	case BLK_ZONE_TYPE_SEQWRITE_PREF:
 	default:
@@ -595,6 +619,7 @@ int blk_revalidate_disk_zones(struct gendisk *disk,
 	blk_mq_freeze_queue(q);
 	if (ret > 0) {
 		disk->nr_zones = args.nr_zones;
+		disk->zone_capacity = args.zone_capacity;
 		swap(disk->seq_zones_wlock, args.seq_zones_wlock);
 		swap(disk->conv_zones_bitmap, args.conv_zones_bitmap);
 		if (update_driver_data)
@@ -608,6 +633,7 @@ int blk_revalidate_disk_zones(struct gendisk *disk,
 
 	kfree(args.seq_zones_wlock);
 	kfree(args.conv_zones_bitmap);
+
 	return ret;
 }
 EXPORT_SYMBOL_GPL(blk_revalidate_disk_zones);
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index ec7bd7091467..4e81f714cca7 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -191,6 +191,7 @@ struct gendisk {
 	 * blk_mq_unfreeze_queue().
 	 */
 	unsigned int		nr_zones;
+	unsigned int		zone_capacity;
 	unsigned long		*conv_zones_bitmap;
 	unsigned long		*seq_zones_wlock;
 #endif /* CONFIG_BLK_DEV_ZONED */
-- 
2.44.0


