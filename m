Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3CC9C48297
	for <linux-nvme@archiver.kernel.org>; Mon, 12 Feb 2024 06:46:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BYX8dCXXtJamilTL6lZO+ppRSoMp9rw4hmsj90YbIFo=; b=T872BiJC34ROD9fEEU0J44Nc2q
	Yg6GR6x6CqHq2x0PzgX+GkOAmiVFhajGRIlZLPIkfNz55qbDEiY5ZoRZ63jy1IuCFHEjy+v1mHQ9K
	6Hmy1mqbpK/x91g9aAJVB2IsSnAzaGA9L2lsM28c4qVKdmnew6x3mOdvKedaV3v+rE9B3Mjd5tZKJ
	X3ZTpWbsbUJKc4VFyOkzb8STdpYYlvgKF+ufkHAMD9xEFeMYqlC7TgYMqiudhLTupsE6Tf004uDIR
	JzXPFiNCH8EhxJaW7k9Ld1DX/4j80GnNY2+Ozqm/ZrbWzRw89yB6VeE9rZ8J1iOZlno6VHVyomSl0
	ApVhwflg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rZQ5B-00000004Pa9-3Ntd;
	Mon, 12 Feb 2024 06:46:25 +0000
Received: from [2001:4bb8:190:6eab:75e9:7295:a6e3:c35d] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rZQ56-00000004PYu-44dn;
	Mon, 12 Feb 2024 06:46:21 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	virtualization@lists.linux.dev,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Ming Lei <ming.lei@redhat.com>,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH 01/15] block: move max_{open,active}_zones to struct queue_limits
Date: Mon, 12 Feb 2024 07:45:55 +0100
Message-Id: <20240212064609.1327143-2-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240212064609.1327143-1-hch@lst.de>
References: <20240212064609.1327143-1-hch@lst.de>
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

The maximum number of open and active zones is a limit on the queue
and should be places there so that we can including it in the upcoming
queue limits batch update API.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Keith Busch <kbusch@kernel.org>
Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
Reviewed-by: Ming Lei <ming.lei@redhat.com>
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
Reviewed-by: Hannes Reinecke <hare@suse.de>
---
 include/linux/blkdev.h | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index d7cac3de65b31b..de9251922f7583 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -189,8 +189,6 @@ struct gendisk {
 	 * blk_mq_unfreeze_queue().
 	 */
 	unsigned int		nr_zones;
-	unsigned int		max_open_zones;
-	unsigned int		max_active_zones;
 	unsigned long		*conv_zones_bitmap;
 	unsigned long		*seq_zones_wlock;
 #endif /* CONFIG_BLK_DEV_ZONED */
@@ -307,6 +305,8 @@ struct queue_limits {
 	unsigned char		discard_misaligned;
 	unsigned char		raid_partial_stripes_expensive;
 	bool			zoned;
+	unsigned int		max_open_zones;
+	unsigned int		max_active_zones;
 
 	/*
 	 * Drivers that set dma_alignment to less than 511 must be prepared to
@@ -639,23 +639,23 @@ static inline bool disk_zone_is_seq(struct gendisk *disk, sector_t sector)
 static inline void disk_set_max_open_zones(struct gendisk *disk,
 		unsigned int max_open_zones)
 {
-	disk->max_open_zones = max_open_zones;
+	disk->queue->limits.max_open_zones = max_open_zones;
 }
 
 static inline void disk_set_max_active_zones(struct gendisk *disk,
 		unsigned int max_active_zones)
 {
-	disk->max_active_zones = max_active_zones;
+	disk->queue->limits.max_active_zones = max_active_zones;
 }
 
 static inline unsigned int bdev_max_open_zones(struct block_device *bdev)
 {
-	return bdev->bd_disk->max_open_zones;
+	return bdev->bd_disk->queue->limits.max_open_zones;
 }
 
 static inline unsigned int bdev_max_active_zones(struct block_device *bdev)
 {
-	return bdev->bd_disk->max_active_zones;
+	return bdev->bd_disk->queue->limits.max_active_zones;
 }
 
 #else /* CONFIG_BLK_DEV_ZONED */
-- 
2.39.2


