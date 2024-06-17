Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AE14C27C6E
	for <linux-nvme@archiver.kernel.org>; Mon, 17 Jun 2024 06:11:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Ehwi9XwmCWVOUn2mUiA9tAgE4ehpoZw+qtTIhW3bZ98=; b=lu5yG4HQixmzlt0TlCQX/ed5IT
	jz8RM1P5S2MJoSvLbvnsyPIdEJfWqIVrkvfSf/8OWNs4yLDPIHT7+AfVXg3sO6cUcPhh5pOVTzRNK
	S76CRE6A5kY9CrGymMthdRo9uDKkqgXTKPAzza7aoVDNuy75vCWRyrTnyx0BrGI2lYiJbi+7VMXAT
	dHK7Q/v6ubsUxrYjdejGoZQ4Uv8LOQ5qD36QWzZ5uKGbaSZ8RRng6hD/xokagIAW0m+g7uIPfNCJF
	w96E1Iu23/pNcA/kvQRdBFLKk9vpUDxHjw9VKN/lH32x0NzsRlQqUOHDtEGG74Pp8p+bXSZLoCM5y
	ig5iljeg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sJ5aO-00000009M87-0zBZ;
	Mon, 17 Jun 2024 06:11:24 +0000
Received: from [91.187.204.140] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sJ5VD-00000009IVS-3gIx;
	Mon, 17 Jun 2024 06:06:04 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
	Richard Weinberger <richard@nod.at>,
	Philipp Reisner <philipp.reisner@linbit.com>,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	=?UTF-8?q?Christoph=20B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>,
	Josef Bacik <josef@toxicpanda.com>,
	Ming Lei <ming.lei@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	=?UTF-8?q?Roger=20Pau=20Monn=C3=A9?= <roger.pau@citrix.com>,
	Alasdair Kergon <agk@redhat.com>,
	Mike Snitzer <snitzer@kernel.org>,
	Mikulas Patocka <mpatocka@redhat.com>,
	Song Liu <song@kernel.org>,
	Yu Kuai <yukuai3@huawei.com>,
	Vineeth Vijayan <vneethv@linux.ibm.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	linux-m68k@lists.linux-m68k.org,
	linux-um@lists.infradead.org,
	drbd-dev@lists.linbit.com,
	nbd@other.debian.org,
	linuxppc-dev@lists.ozlabs.org,
	ceph-devel@vger.kernel.org,
	virtualization@lists.linux.dev,
	xen-devel@lists.xenproject.org,
	linux-bcache@vger.kernel.org,
	dm-devel@lists.linux.dev,
	linux-raid@vger.kernel.org,
	linux-mmc@vger.kernel.org,
	linux-mtd@lists.infradead.org,
	nvdimm@lists.linux.dev,
	linux-nvme@lists.infradead.org,
	linux-s390@vger.kernel.org,
	linux-scsi@vger.kernel.org,
	linux-block@vger.kernel.org,
	Bart Van Assche <bvanassche@acm.org>,
	Damien Le Moal <dlemoal@kernel.org>,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH 10/26] nbd: move setting the cache control flags to __nbd_set_size
Date: Mon, 17 Jun 2024 08:04:37 +0200
Message-ID: <20240617060532.127975-11-hch@lst.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240617060532.127975-1-hch@lst.de>
References: <20240617060532.127975-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 16 Jun 2024 23:10:52 -0700
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

Move setting the cache control flags in nbd in preparation for moving
these flags into the queue_limits structure.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Hannes Reinecke <hare@suse.de>
---
 drivers/block/nbd.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index ad887d614d5b3f..44b8c671921e5c 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -342,6 +342,12 @@ static int __nbd_set_size(struct nbd_device *nbd, loff_t bytesize,
 		lim.max_hw_discard_sectors = UINT_MAX;
 	else
 		lim.max_hw_discard_sectors = 0;
+	if (!(nbd->config->flags & NBD_FLAG_SEND_FLUSH))
+		blk_queue_write_cache(nbd->disk->queue, false, false);
+	else if (nbd->config->flags & NBD_FLAG_SEND_FUA)
+		blk_queue_write_cache(nbd->disk->queue, true, true);
+	else
+		blk_queue_write_cache(nbd->disk->queue, true, false);
 	lim.logical_block_size = blksize;
 	lim.physical_block_size = blksize;
 	error = queue_limits_commit_update(nbd->disk->queue, &lim);
@@ -1286,19 +1292,10 @@ static void nbd_bdev_reset(struct nbd_device *nbd)
 
 static void nbd_parse_flags(struct nbd_device *nbd)
 {
-	struct nbd_config *config = nbd->config;
-	if (config->flags & NBD_FLAG_READ_ONLY)
+	if (nbd->config->flags & NBD_FLAG_READ_ONLY)
 		set_disk_ro(nbd->disk, true);
 	else
 		set_disk_ro(nbd->disk, false);
-	if (config->flags & NBD_FLAG_SEND_FLUSH) {
-		if (config->flags & NBD_FLAG_SEND_FUA)
-			blk_queue_write_cache(nbd->disk->queue, true, true);
-		else
-			blk_queue_write_cache(nbd->disk->queue, true, false);
-	}
-	else
-		blk_queue_write_cache(nbd->disk->queue, false, false);
 }
 
 static void send_disconnects(struct nbd_device *nbd)
-- 
2.43.0


