Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11EADC47258
	for <linux-nvme@archiver.kernel.org>; Thu, 25 Jan 2024 16:53:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kjczz8mPkeKokmXTN6NURwCatsfIVh3T4Cfy2Zqik+o=; b=npqbveuKfaKzzzkF3wNt4pLMFf
	BdPAvXx8F9arqvttmDAXX0qk+ghs9QqjZZueBbDF7XQWJl3FN4etF4X7NzmSkhPJ8oklGG/Gl9uN1
	tNOllJGLogxOyth0g7i5SFDtW4MKZfMJdld+SAN7M5RYnz1+4lJZ3z5PXn/5qOSTV7GPwvfS3sKPP
	UqlbTuuc8f6W8heWfFMHy3oq4DYrVe6ewx30YcRGUffAD4DfylmtJG3vY5Fpf+WQnhruCPztvRYyv
	pJDiM9BzaNakBC8IroIZi2C9ZRCIe1A4a0DvVAL3f8OpZBngBvkCfuudiv40/3g2sSh9DSWGa5YKK
	rbEfMJiw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rT2z3-00000000yAO-25dh;
	Thu, 25 Jan 2024 16:53:45 +0000
Received: from esa1.hgst.iphmx.com ([68.232.141.245])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rT2yz-00000000y6j-37rQ
	for linux-nvme@lists.infradead.org;
	Thu, 25 Jan 2024 16:53:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1706201621; x=1737737621;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=CVSDtwbfJeIFTP08Wyxu5GIZXiQgdv2rMRXO0YSre0A=;
  b=bFlK4I+yLa0HCdPWkkh8cWwRCDq11lxkrvrIrzX2io1N7q8Gh8Awv6xP
   hibJ7t9gYFjW1loXQlSpXLMYqpAbL+/ULOMWhfhcGY2Ek7/91WTTWEMHy
   U1UlpXCNN/61tmVEX+lIah8msHSrmIDTvBKtQhzDvwpwD/r5rXjkp9SVD
   fcCNulza6iw8hOrHLw5dhuZ0Sd85kI/n3Zk+935+fmdCeHp8QKSfcARNf
   HILyVgXug3MbPRoW45Mio67oLyPjNMLQSeYE3zNiDtSenw8am3oYbTscE
   RlkALwae+ULqoBci5ldLmdi4TA4lDcnHvehiBMRgjhhXVBqOTP0rqysYI
   g==;
X-CSE-ConnectionGUID: qPsBcSJ3SfSbJyalF/kYfw==
X-CSE-MsgGUID: c4YbtVjtTKa5+raBnvKKww==
X-IronPort-AV: E=Sophos;i="6.05,216,1701100800"; 
   d="scan'208";a="7967079"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 26 Jan 2024 00:53:40 +0800
IronPort-SDR: bcXu/Ix6anqY/RW/z6aDbYyO94fMdeXxjdBa46MaC//umOC7PyoRz+erLNgMCW5UhldS48Nj6I
 iEVhlK9VX+nw==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 25 Jan 2024 07:57:59 -0800
IronPort-SDR: sBgbgkN5bVB0enbBw/iyb8cMMu+2pAh1JkthbGxPDDItWfESaHFsqFp68AyWN5LkQ+syR4acGA
 0IKcbDNJkDbA==
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.6])
  by uls-op-cesaip01.wdc.com with ESMTP; 25 Jan 2024 08:53:37 -0800
From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Date: Thu, 25 Jan 2024 08:53:25 -0800
Subject: [PATCH v2 2/5] dm: dm-zoned: guard blkdev_zone_mgmt with noio
 scope
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240125-zonefs_nofs-v2-2-2d975c8c1690@wdc.com>
References: <20240125-zonefs_nofs-v2-0-2d975c8c1690@wdc.com>
In-Reply-To: <20240125-zonefs_nofs-v2-0-2d975c8c1690@wdc.com>
To: Damien Le Moal <dlemoal@kernel.org>, 
 Naohiro Aota <naohiro.aota@wdc.com>, Johannes Thumshirn <jth@kernel.org>, 
 Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@kernel.org>, 
 Mikulas Patocka <mpatocka@redhat.com>, dm-devel@lists.linux.dev, 
 Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, 
 David Sterba <dsterba@suse.com>, Jaegeuk Kim <jaegeuk@kernel.org>, 
 Chao Yu <chao@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
 Chaitanya Kulkarni <kch@nvidia.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-btrfs@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, 
 linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, 
 Johannes Thumshirn <johannes.thumshirn@wdc.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1706201608; l=1101;
 i=johannes.thumshirn@wdc.com; s=20230613; h=from:subject:message-id;
 bh=CVSDtwbfJeIFTP08Wyxu5GIZXiQgdv2rMRXO0YSre0A=;
 b=oFwFIqk+a1bu3Gme4liw+RG2cMT5QTjli7I99okyi7hJJltokvsxJSP+mr+nCDIrJWXq34TTT
 jsVdpNzfNZbAcO1z7yd2EbMw7/v2dBFV8630y+/qR9JS2+Bul5QIMOO
X-Developer-Key: i=johannes.thumshirn@wdc.com; a=ed25519;
 pk=TGmHKs78FdPi+QhrViEvjKIGwReUGCfa+3LEnGoR2KM=
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240125_085341_899390_EDE83771 
X-CRM114-Status: GOOD (  14.15  )
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

Guard the calls to blkdev_zone_mgmt() with a memalloc_noio scope.
This helps us getting rid of the GFP_NOIO argument to blkdev_zone_mgmt();

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 drivers/md/dm-zoned-metadata.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/md/dm-zoned-metadata.c b/drivers/md/dm-zoned-metadata.c
index fdfe30f7b697..165996cc966c 100644
--- a/drivers/md/dm-zoned-metadata.c
+++ b/drivers/md/dm-zoned-metadata.c
@@ -1655,10 +1655,13 @@ static int dmz_reset_zone(struct dmz_metadata *zmd, struct dm_zone *zone)
 
 	if (!dmz_is_empty(zone) || dmz_seq_write_err(zone)) {
 		struct dmz_dev *dev = zone->dev;
+		unsigned int noio_flag;
 
+		noio_flag = memalloc_noio_save();
 		ret = blkdev_zone_mgmt(dev->bdev, REQ_OP_ZONE_RESET,
 				       dmz_start_sect(zmd, zone),
-				       zmd->zone_nr_sectors, GFP_NOIO);
+				       zmd->zone_nr_sectors, GFP_KERNEL);
+		memalloc_noio_restore(noio_flag);
 		if (ret) {
 			dmz_dev_err(dev, "Reset zone %u failed %d",
 				    zone->id, ret);

-- 
2.43.0


