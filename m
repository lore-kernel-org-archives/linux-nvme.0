Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F160C47DDB
	for <linux-nvme@archiver.kernel.org>; Mon, 29 Jan 2024 07:52:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fpd79ziWWnEkE4PQSjIRnLcjjQg7HoWMKhlTrkjmDK0=; b=rFsL1H1qGT2//hD0c/C/WM4aEW
	R1oSbqoaJt1vjkxxGBzAkdzRHBHDVbLBcAQpgzfpIWMcGofXvQDiZnRqDudix3ZiCDdC+94oOuWMS
	lmh7uHz4uisH1FBO4d36djgVuRX59Oi76erk3INd9MEIquvlrV+fhB17rtfhLGJ7OKSTwz8UroeVH
	9+bIYd9q+PruvEBSctRFxrvxzF48FJ0eDZqB7ekalUnAiwhOkVxbJhDrSv0CRdmN8eSy/8aW8d+v3
	6Q49R3aU1hXg745MnFU+LiviXTkNks5M5o5QXnJYf4dN8FcEZj24vx0wlACQnQ/CjWCu1MM52/6RK
	aP60x6TA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rUMRZ-0000000BerJ-1ONa;
	Mon, 29 Jan 2024 07:52:37 +0000
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rUMRV-0000000BepS-2kxn
	for linux-nvme@lists.infradead.org;
	Mon, 29 Jan 2024 07:52:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1706514753; x=1738050753;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=eGx4McY1FmrYKhrAp3TTxFkfkbSfbNbdZDzzsYbn3SA=;
  b=jz1ROEHXa3JuXYrZFIkQgbipfsqArEFqXaChEyef4Jhx612a5ZpTqgLP
   yROvI5l3eRxvQSB5azU9DaqF7Dds5tEE4bSF6HUy5aaM2awxGvVXNNYgR
   H2y30QUCxwKSUMrOROk1/l8iw+UGUaVq4Ca+y1TRbZTwwX86bGPBpo1cM
   R7NrxRTaN9WxgvTa/Q2c/t6Yg0UqXqXhpO+CIh1rZ/3LPLmrrROLR9ne5
   1O6QaAFymtLp6jPVbPEn9gCGLpyg1A20HONZRNuCs4KmjrMgLlZRyFm3J
   9mxpRxO1LEsjOhxqwiRNaO/Bgy5E69zoYmLawoyskZZcSUbakegRUvSAi
   Q==;
X-CSE-ConnectionGUID: z2Ht+i4KTjaepTw7FNdPpA==
X-CSE-MsgGUID: dfpeg0q+QF6BIANnNJbwUg==
X-IronPort-AV: E=Sophos;i="6.05,226,1701100800"; 
   d="scan'208";a="7957642"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 29 Jan 2024 15:52:30 +0800
IronPort-SDR: tpjsIBBt7HQ/q2ndkoBSPeoVvaWDfOGKZ7P0jdeHyoCrr0sTnXj95hXI4qnT5wUt1WCtUIxGfy
 czgUCq/mB21Q==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 28 Jan 2024 23:02:26 -0800
IronPort-SDR: TgaA8LrWz4JmksfFMd9XbYuIoWjMlrDoGLua+Pb607OI4wE3Fe9/wAPKrNdtSrWLoefyzcMDAc
 YY+ofLHHgnnA==
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.6])
  by uls-op-cesaip02.wdc.com with ESMTP; 28 Jan 2024 23:52:27 -0800
From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Date: Sun, 28 Jan 2024 23:52:16 -0800
Subject: [PATCH v3 1/5] zonefs: pass GFP_KERNEL to blkdev_zone_mgmt() call
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240128-zonefs_nofs-v3-1-ae3b7c8def61@wdc.com>
References: <20240128-zonefs_nofs-v3-0-ae3b7c8def61@wdc.com>
In-Reply-To: <20240128-zonefs_nofs-v3-0-ae3b7c8def61@wdc.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1706514743; l=1041;
 i=johannes.thumshirn@wdc.com; s=20230613; h=from:subject:message-id;
 bh=eGx4McY1FmrYKhrAp3TTxFkfkbSfbNbdZDzzsYbn3SA=;
 b=t4wcaJhs6oV11H9tXDjzJ4heS84olNEuvuiMDoCT7kiC4VWqi/UCfvHK0WP330iTVs0p8G2QQ
 0WRameby5F7DGgOvyyko8FG4gi9vkmFaf+HGZUlvOWp9nymIgGBuC/o
X-Developer-Key: i=johannes.thumshirn@wdc.com; a=ed25519;
 pk=TGmHKs78FdPi+QhrViEvjKIGwReUGCfa+3LEnGoR2KM=
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240128_235235_254323_E9A14D46 
X-CRM114-Status: GOOD (  14.57  )
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

Pass GFP_KERNEL instead of GFP_NOFS to the blkdev_zone_mgmt() call in
zonefs_zone_mgmt().

As as zonefs_zone_mgmt() and zonefs_inode_zone_mgmt() are never called
from a place that can recurse back into the filesystem on memory reclaim,
it is save to call blkdev_zone_mgmt() with GFP_KERNEL.

Link: https://lore.kernel.org/all/ZZcgXI46AinlcBDP@casper.infradead.org/
Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/zonefs/super.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/zonefs/super.c b/fs/zonefs/super.c
index 93971742613a..63fbac018c04 100644
--- a/fs/zonefs/super.c
+++ b/fs/zonefs/super.c
@@ -113,7 +113,7 @@ static int zonefs_zone_mgmt(struct super_block *sb,
 
 	trace_zonefs_zone_mgmt(sb, z, op);
 	ret = blkdev_zone_mgmt(sb->s_bdev, op, z->z_sector,
-			       z->z_size >> SECTOR_SHIFT, GFP_NOFS);
+			       z->z_size >> SECTOR_SHIFT, GFP_KERNEL);
 	if (ret) {
 		zonefs_err(sb,
 			   "Zone management operation %s at %llu failed %d\n",

-- 
2.43.0


