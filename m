Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04650C25B76
	for <linux-nvme@archiver.kernel.org>; Tue, 11 Jun 2024 05:24:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Lo072dU2QpGVh/xLHOL31dXMwicRfcSfRIC85i+l4AM=; b=BJ+2G3BDd7Z/cVRbc7BKZjoRa3
	FrsoczWQQx8UWa2ef/8GnYzxopfVzIoP/pMZFJoCjnfAtVfiX3G6qfTXL+ZNbCL8X8KxwQYDvkkx7
	gV/K3Z6076lLgl5m5bughyoHnSTxrtNZzq71ushVnfsby28i0Ih6GSlj+ILp7z7vuwUbiwrjIawdH
	VTZaIwd+FXaVo4B2YsYp+Z+zNyghr8haq/f0M5VgvtzdCpGT0tdM0qB1HlqSgaxVLXsU978/mHbtI
	oxsEw0QhAnpLHb+ftpHP2mGVrLT/Rqa3qRlrOOU6FtB76CHw7KNpk3lxvvCtYO2vh2EdMahQWAwpx
	IIs+Rtnw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sGtzV-00000007UJn-2Ar3;
	Tue, 11 Jun 2024 05:24:17 +0000
Received: from 2a02-8389-2341-5b80-cdb4-8e7d-405d-6b77.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:cdb4:8e7d:405d:6b77] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sGtvQ-00000007R5I-2gcI;
	Tue, 11 Jun 2024 05:20:05 +0000
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
Subject: [PATCH 11/26] block: freeze the queue in queue_attr_store
Date: Tue, 11 Jun 2024 07:19:11 +0200
Message-ID: <20240611051929.513387-12-hch@lst.de>
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

queue_attr_store updates attributes used to control generating I/O, and
can cause malformed bios if changed with I/O in flight.  Freeze the queue
in common code instead of adding it to almost every attribute.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-mq.c    | 5 +++--
 block/blk-sysfs.c | 9 ++-------
 2 files changed, 5 insertions(+), 9 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 0d4cd39c3d25da..58b0d6c7cc34d6 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -4631,13 +4631,15 @@ int blk_mq_update_nr_requests(struct request_queue *q, unsigned int nr)
 	int ret;
 	unsigned long i;
 
+	if (WARN_ON_ONCE(!q->mq_freeze_depth))
+		return -EINVAL;
+
 	if (!set)
 		return -EINVAL;
 
 	if (q->nr_requests == nr)
 		return 0;
 
-	blk_mq_freeze_queue(q);
 	blk_mq_quiesce_queue(q);
 
 	ret = 0;
@@ -4671,7 +4673,6 @@ int blk_mq_update_nr_requests(struct request_queue *q, unsigned int nr)
 	}
 
 	blk_mq_unquiesce_queue(q);
-	blk_mq_unfreeze_queue(q);
 
 	return ret;
 }
diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index f0f9314ab65c61..5c787965b7d09e 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -189,12 +189,9 @@ static ssize_t queue_discard_max_store(struct request_queue *q,
 	if ((max_discard_bytes >> SECTOR_SHIFT) > UINT_MAX)
 		return -EINVAL;
 
-	blk_mq_freeze_queue(q);
 	lim = queue_limits_start_update(q);
 	lim.max_user_discard_sectors = max_discard_bytes >> SECTOR_SHIFT;
 	err = queue_limits_commit_update(q, &lim);
-	blk_mq_unfreeze_queue(q);
-
 	if (err)
 		return err;
 	return ret;
@@ -241,11 +238,9 @@ queue_max_sectors_store(struct request_queue *q, const char *page, size_t count)
 	if (ret < 0)
 		return ret;
 
-	blk_mq_freeze_queue(q);
 	lim = queue_limits_start_update(q);
 	lim.max_user_sectors = max_sectors_kb << 1;
 	err = queue_limits_commit_update(q, &lim);
-	blk_mq_unfreeze_queue(q);
 	if (err)
 		return err;
 	return ret;
@@ -585,13 +580,11 @@ static ssize_t queue_wb_lat_store(struct request_queue *q, const char *page,
 	 * ends up either enabling or disabling wbt completely. We can't
 	 * have IO inflight if that happens.
 	 */
-	blk_mq_freeze_queue(q);
 	blk_mq_quiesce_queue(q);
 
 	wbt_set_min_lat(q, val);
 
 	blk_mq_unquiesce_queue(q);
-	blk_mq_unfreeze_queue(q);
 
 	return count;
 }
@@ -722,9 +715,11 @@ queue_attr_store(struct kobject *kobj, struct attribute *attr,
 	if (!entry->store)
 		return -EIO;
 
+	blk_mq_freeze_queue(q);
 	mutex_lock(&q->sysfs_lock);
 	res = entry->store(q, page, length);
 	mutex_unlock(&q->sysfs_lock);
+	blk_mq_unfreeze_queue(q);
 	return res;
 }
 
-- 
2.43.0


