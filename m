Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55D82C25B76
	for <linux-nvme@archiver.kernel.org>; Tue, 11 Jun 2024 05:23:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=rkSQ+6nZApqoAfrjo6q+Wq9Ws51k8by9JfSQNhUShHI=; b=Ed1CWf+JheFYoRbzXS7WebAGvI
	2xqetDmjbCXGtZI4qmMbI3qG94HWIBT7FSvIPEIc9W9gIqF7D4Dz+i95b1ZBNKN5Jn7lPc25Yr+is
	8N9NDm9EjH9m6UkTX1sWw0rWkXBuWh9MbwfS+6MKzoICxpWPh/esoX3OfY9xeugJp2oHaEZE0Ku9j
	CTvs4e7EcK5Lohk7g4lMmouG1bXmLvu01qqP6JO7ZMbxY4k0l9pXfEyVAFWgx6gRBHNtnOT+hMWrz
	rVinVcRjQTjmdXc1GIj6a8ZXzLiKlOKm1ajvommd2U2no9Y3fXwfj0pePqf5rKm5f9GEvU5Cykt0F
	8VI2yltQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sGtzB-00000007U2Y-430U;
	Tue, 11 Jun 2024 05:23:57 +0000
Received: from 2a02-8389-2341-5b80-cdb4-8e7d-405d-6b77.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:cdb4:8e7d:405d:6b77] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sGtvF-00000007Qwk-2PPi;
	Tue, 11 Jun 2024 05:19:54 +0000
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
	linux-block@vger.kernel.org
Subject: [PATCH 07/26] loop: fold loop_update_rotational into loop_reconfigure_limits
Date: Tue, 11 Jun 2024 07:19:07 +0200
Message-ID: <20240611051929.513387-8-hch@lst.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240611051929.513387-1-hch@lst.de>
References: <20240611051929.513387-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 10 Jun 2024 22:22:01 -0700
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

This prepares for moving the rotational flag into the queue_limits and
also fixes it for the case where the loop device is backed by a block
device.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/block/loop.c | 23 ++++-------------------
 1 file changed, 4 insertions(+), 19 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index d7cf6bbbfb1b86..2c4a5eb3a6a7f9 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -916,24 +916,6 @@ static void loop_free_idle_workers_timer(struct timer_list *timer)
 	return loop_free_idle_workers(lo, false);
 }
 
-static void loop_update_rotational(struct loop_device *lo)
-{
-	struct file *file = lo->lo_backing_file;
-	struct inode *file_inode = file->f_mapping->host;
-	struct block_device *file_bdev = file_inode->i_sb->s_bdev;
-	struct request_queue *q = lo->lo_queue;
-	bool nonrot = true;
-
-	/* not all filesystems (e.g. tmpfs) have a sb->s_bdev */
-	if (file_bdev)
-		nonrot = bdev_nonrot(file_bdev);
-
-	if (nonrot)
-		blk_queue_flag_set(QUEUE_FLAG_NONROT, q);
-	else
-		blk_queue_flag_clear(QUEUE_FLAG_NONROT, q);
-}
-
 /**
  * loop_set_status_from_info - configure device from loop_info
  * @lo: struct loop_device to configure
@@ -1003,6 +985,10 @@ static int loop_reconfigure_limits(struct loop_device *lo, unsigned short bsize)
 	lim.logical_block_size = bsize;
 	lim.physical_block_size = bsize;
 	lim.io_min = bsize;
+	if (!backing_bdev || bdev_nonrot(backing_bdev))
+		blk_queue_flag_set(QUEUE_FLAG_NONROT, lo->lo_queue);
+	else
+		blk_queue_flag_clear(QUEUE_FLAG_NONROT, lo->lo_queue);
 	loop_config_discard(lo, &lim);
 	return queue_limits_commit_update(lo->lo_queue, &lim);
 }
@@ -1099,7 +1085,6 @@ static int loop_configure(struct loop_device *lo, blk_mode_t mode,
 	if (WARN_ON_ONCE(error))
 		goto out_unlock;
 
-	loop_update_rotational(lo);
 	loop_update_dio(lo);
 	loop_sysfs_init(lo);
 
-- 
2.43.0


