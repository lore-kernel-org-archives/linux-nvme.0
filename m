Return-Path: <SRS0=IkIX=PG=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7A7EC433F5
	for <linux-nvme@archiver.kernel.org>; Mon, 18 Oct 2021 10:14:50 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7994360E90
	for <linux-nvme@archiver.kernel.org>; Mon, 18 Oct 2021 10:14:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 7994360E90
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ua3x6oobbjatF9m91a/TfkciVlhvg2RT0UK88GOOPcc=; b=NFMJJ17ii7/CcbIgsA+w8cA0HM
	vQvs3e54NLMFkhSz7Kh4r68vLKIOpUiIYDXDALTqoWhIgpiaECu8eZSdSFvnrlZgsT7PybaGg96na
	4CUBXfUT5/SRqeKzaAVrUwyr7kQD+pwlz/psYOXHO3mYicgk65e3L0JEVQR+dfbkxvih7zQL1Nbfy
	Ct4gS2hCkgdGca9DrzbmTuvpJnefK1XcBEGI6kLaqIO0FUJy/GK+t1+V87Z+yNQ19G51jb6Z+/V6O
	MDm/IFOO7jnhpMKgc84c4yn0sojIFGEk/FHu7JtRXugh4xzWU6IWgS17AJWaNVV5rm7iLIlbm4Urh
	QSbjAgjw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mcPfM-00EwIi-55; Mon, 18 Oct 2021 10:14:48 +0000
Received: from [2001:4bb8:199:73c5:c70:4a89:bc61:2] (helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mcPcL-00Eu0X-91; Mon, 18 Oct 2021 10:11:41 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Coly Li <colyli@suse.de>, Mike Snitzer <snitzer@redhat.com>,
 Song Liu <song@kernel.org>, David Sterba <dsterba@suse.com>,
 Josef Bacik <josef@toxicpanda.com>, "Theodore Ts'o" <tytso@mit.edu>,
 OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
 Dave Kleikamp <shaggy@kernel.org>,
 Ryusuke Konishi <konishi.ryusuke@gmail.com>,
 Anton Altaparmakov <anton@tuxera.com>,
 Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
 Kees Cook <keescook@chromium.org>,
 Phillip Lougher <phillip@squashfs.org.uk>, Jan Kara <jack@suse.com>,
 linux-block@vger.kernel.org, dm-devel@redhat.com,
 drbd-dev@lists.linbit.com, linux-bcache@vger.kernel.org,
 linux-raid@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-scsi@vger.kernel.org, target-devel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org,
 linux-ext4@vger.kernel.org, jfs-discussion@lists.sourceforge.net,
 linux-nfs@vger.kernel.org, linux-nilfs@vger.kernel.org,
 linux-ntfs-dev@lists.sourceforge.net, ntfs3@lists.linux.dev,
 reiserfs-devel@vger.kernel.org, Chaitanya Kulkarni <kch@nvidia.com>
Subject: [PATCH 03/30] bcache: remove bdev_sectors
Date: Mon, 18 Oct 2021 12:11:03 +0200
Message-Id: <20211018101130.1838532-4-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211018101130.1838532-1-hch@lst.de>
References: <20211018101130.1838532-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 18 Oct 2021 03:14:03 -0700
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

Use the equivalent block layer helper instead.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Kees Cook <keescook@chromium.org>
Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
Acked-by: Coly Li <colyli@suse.de>
---
 drivers/md/bcache/super.c     | 2 +-
 drivers/md/bcache/util.h      | 4 ----
 drivers/md/bcache/writeback.c | 2 +-
 3 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/md/bcache/super.c b/drivers/md/bcache/super.c
index f2874c77ff797..4f89985abe4b7 100644
--- a/drivers/md/bcache/super.c
+++ b/drivers/md/bcache/super.c
@@ -1002,7 +1002,7 @@ static void calc_cached_dev_sectors(struct cache_set *c)
 	struct cached_dev *dc;
 
 	list_for_each_entry(dc, &c->cached_devs, list)
-		sectors += bdev_sectors(dc->bdev);
+		sectors += bdev_nr_sectors(dc->bdev);
 
 	c->cached_dev_sectors = sectors;
 }
diff --git a/drivers/md/bcache/util.h b/drivers/md/bcache/util.h
index b64460a762677..a7da7930a7fda 100644
--- a/drivers/md/bcache/util.h
+++ b/drivers/md/bcache/util.h
@@ -584,8 +584,4 @@ static inline unsigned int fract_exp_two(unsigned int x,
 void bch_bio_map(struct bio *bio, void *base);
 int bch_bio_alloc_pages(struct bio *bio, gfp_t gfp_mask);
 
-static inline sector_t bdev_sectors(struct block_device *bdev)
-{
-	return bdev->bd_inode->i_size >> 9;
-}
 #endif /* _BCACHE_UTIL_H */
diff --git a/drivers/md/bcache/writeback.c b/drivers/md/bcache/writeback.c
index 8120da278161e..c7560f66dca88 100644
--- a/drivers/md/bcache/writeback.c
+++ b/drivers/md/bcache/writeback.c
@@ -45,7 +45,7 @@ static uint64_t __calc_target_rate(struct cached_dev *dc)
 	 * backing volume uses about 2% of the cache for dirty data.
 	 */
 	uint32_t bdev_share =
-		div64_u64(bdev_sectors(dc->bdev) << WRITEBACK_SHARE_SHIFT,
+		div64_u64(bdev_nr_sectors(dc->bdev) << WRITEBACK_SHARE_SHIFT,
 				c->cached_dev_sectors);
 
 	uint64_t cache_dirty_target =
-- 
2.30.2


