Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 128BDC47258
	for <linux-nvme@archiver.kernel.org>; Tue, 23 Jan 2024 09:44:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7IyULlbq2i/AZhH32Afb7WsVyfQNBfYwO7GDrodkVh0=; b=eIdTE9jm/h1lhUhOkElMQ7D/Z5
	NQNySd3cZ4QwZG5OU7iImM6ofZRqeLXDR/AM2w6Iu5jSNi5filUd/QU2vUlZ7hiemycvJe7k3rwva
	6R8/SpmTFqzPqWRx1yAIfeoy9Z5MKXxXeawGF03EiUkaHnISV5eIzshSCM23wFMdFSGfreBa5qMXl
	6SEmmV0F/AP7MLtWsmIn3Ga8uiprkdlfV/ySAjh5F8EbLswx6/mQ01XRnTgPXQgvHMIaayvlC4+Y9
	Cys+0WrU0wGGbsYD+x8txX4BMkh1MpWHe+1NYmQE2yo5oj6/wY4cyNuL0kTZtIl8kvTqdyrsoyTV+
	EthLmh2w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rSDK5-00Fmdn-0g;
	Tue, 23 Jan 2024 09:44:01 +0000
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rSDK2-00FmaH-2l
	for linux-nvme@lists.infradead.org;
	Tue, 23 Jan 2024 09:44:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1706003038; x=1737539038;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=aNukikOqhJIFNWqZ0ODBJWyAugGq+LPMMd8TTS5AKQ4=;
  b=fHjvuvpoqzqv7b2Zfw4H5zEBYAyTbdLb/s1ypry1CiY7JEGS+q6QQApp
   fEwEOgTq8mUBb8aeXuJCrCOnWQISA8fg3ayYQjBtRf39MSnzpOjv+WTYb
   WDovVsSA7poJDLT7heuoKvBLEvrTtTPCH1AWTWmsoU7VNr4XL1H4sDjod
   x+6Q1PTuSnjY9PaM0M+6jS90M8YLQM5HE9c+cl4MC88sdMXhXafADlbMb
   Y1zIZ50WODL2tfDZ4Y/Cy/6huB3D5jh6axZ3fp1mVoGVrIPP/IeZuu442
   tz2o6lpziTGXYjS/o3FwfK6z9tGD6lXS9ostwKY0zJVsGPpxzPcwhI18t
   A==;
X-CSE-ConnectionGUID: soFMsQ72QFKEFx7DTP1qaw==
X-CSE-MsgGUID: ihalWq2ASpW7OaapiygNkw==
X-IronPort-AV: E=Sophos;i="6.05,214,1701100800"; 
   d="scan'208";a="7240355"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 23 Jan 2024 17:43:58 +0800
IronPort-SDR: rd4XRw0/1vGpHAQtRoqAnCSOuJt1j0K7zw93q1XHiMIeZLIG2H3NlcUjsHTsYtVjAcZ4CYIEx3
 63Gdz+IwLonw==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 23 Jan 2024 00:48:20 -0800
IronPort-SDR: dAsmsPa7PoEjEqCMQJaraanxOd8c/fk8dACLylRy5NqXD//OMj6y9vGDZHd8BuQxOm/a02BIsW
 R+tMuSbewV1Q==
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.6])
  by uls-op-cesaip02.wdc.com with ESMTP; 23 Jan 2024 01:43:54 -0800
From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Date: Tue, 23 Jan 2024 01:43:43 -0800
Subject: [PATCH 2/5] dm: dm-zoned: pass GFP_KERNEL to blkdev_zone_mgmt
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240123-zonefs_nofs-v1-2-cc0b0308ef25@wdc.com>
References: <20240123-zonefs_nofs-v1-0-cc0b0308ef25@wdc.com>
In-Reply-To: <20240123-zonefs_nofs-v1-0-cc0b0308ef25@wdc.com>
To: Damien Le Moal <dlemoal@kernel.org>, 
 Naohiro Aota <naohiro.aota@wdc.com>, Mike Snitzer <snitzer@kernel.org>, 
 dm-devel@lists.linux.dev, Chris Mason <clm@fb.com>, 
 Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>, 
 Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>, 
 Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, 
 Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-btrfs@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, 
 linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, 
 Johannes Thumshirn <johannes.thumshirn@wdc.com>, 
 "Matthew Wilcox (Oracle)" <willy@infradead.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1706003027; l=991;
 i=johannes.thumshirn@wdc.com; s=20230613; h=from:subject:message-id;
 bh=aNukikOqhJIFNWqZ0ODBJWyAugGq+LPMMd8TTS5AKQ4=;
 b=ikAnavOye/kaxQOEWNUwKqvdUxWGtXZzJ7FWZYYfiyPrwIlpkg/V/fzRFKDthgXe8Ohpt6KhU
 /FHlNMKNb/eDriIYAew0yBQo7R6HpuBpWUzFGRY/CanTb/8FmZgdOJV
X-Developer-Key: i=johannes.thumshirn@wdc.com; a=ed25519;
 pk=TGmHKs78FdPi+QhrViEvjKIGwReUGCfa+3LEnGoR2KM=
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240123_014358_932976_64124440 
X-CRM114-Status: GOOD (  15.06  )
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

The call to blkdev_zone_mgmt() in dm-zoned is only used to perform a
ZONE_RESET operation when freeing a zone.

This is not done in the IO path, so we can use GFP_KERNEL here, as it will
never recurse back into the driver on reclaim.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 drivers/md/dm-zoned-metadata.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/md/dm-zoned-metadata.c b/drivers/md/dm-zoned-metadata.c
index fdfe30f7b697..a39734f0cb7d 100644
--- a/drivers/md/dm-zoned-metadata.c
+++ b/drivers/md/dm-zoned-metadata.c
@@ -1658,7 +1658,7 @@ static int dmz_reset_zone(struct dmz_metadata *zmd, struct dm_zone *zone)
 
 		ret = blkdev_zone_mgmt(dev->bdev, REQ_OP_ZONE_RESET,
 				       dmz_start_sect(zmd, zone),
-				       zmd->zone_nr_sectors, GFP_NOIO);
+				       zmd->zone_nr_sectors, GFP_KERNEL);
 		if (ret) {
 			dmz_dev_err(dev, "Reset zone %u failed %d",
 				    zone->id, ret);

-- 
2.43.0


