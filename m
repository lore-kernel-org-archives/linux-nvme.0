Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F3F9C47422
	for <linux-nvme@archiver.kernel.org>; Mon, 29 Jan 2024 07:52:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Message-Id:Date:Subject:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=W5lyY5EIDF7m6oNwdabQA4ZFGwvQpF8BT40CY2RPFY0=; b=oHVlUk+ip8RzHl
	5Mhq474dJ0e3Im163wy73/lxy6Zgh/LPwjQ8Zl5WpqJhiud38Ko5FYmkedp4KXHQpODGpkMpqUecK
	cmZnSCLFBYmrz0RvUiejMq/nOWOgXp4IfSM0qeAJEV98A/GT7k8GOUFNulvCmAotgceVpiznPvc7c
	szJCzn11RqGltcvYr4wecHiDF+t671N+lyEixPy6X41RAyPsp8vVuSIl+yLJN89JjdTT2sPIJSc3q
	I7057j0IxbHwfBNNRGpiTKyJUym1Nke1kqog10Tzs3fGmV238AiH0uhIoBSZEzC8Oy86jGAytxgfu
	s4oVVgcbl4r//ZaWfTtw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rUMRa-0000000Berk-1SQQ;
	Mon, 29 Jan 2024 07:52:38 +0000
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rUMRX-0000000BepJ-0bdt
	for linux-nvme@lists.infradead.org;
	Mon, 29 Jan 2024 07:52:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1706514754; x=1738050754;
  h=from:subject:date:message-id:mime-version:
   content-transfer-encoding:to:cc;
  bh=rp5FcjO4/GYjbF5Qyk/GxKqz5Dm+QfeA7jbL0YYHdsM=;
  b=BsljqVwt88x1I8KARiEYdlfq5mzTxvlXfMhXxdpwQe6RXxESq0b2vXUB
   lNJCAlHsZTbGI0sUyTxzK19ZXTOvRZqvqylQAiM8Uw5cGExsQvV4eOF+k
   ya1e9zBk6f2QSYIneq9XmHHdHH1/cRHmfz6yCeiNvkz5LUBcioa7nGJNd
   DMOO10G/mnwWDI77jqeoQghErql9RPltHAt4FIgWvfUNOI/rkV8p0Iypu
   CuPqQF5WfyNV4WQ2xN5J8EnpkddAVc5KkNPY/BQTpQWdt5Mi1H9iMI1yf
   6CHp52XHgslBHwYIqWcugVFEALnszlNyb5c1/jI0cE1pNV2t/0Z7iJ4al
   g==;
X-CSE-ConnectionGUID: WNoBCblHRtWsSzq4steN6g==
X-CSE-MsgGUID: UKoaHi8cRh2ALMiVNDPjuA==
X-IronPort-AV: E=Sophos;i="6.05,226,1701100800"; 
   d="scan'208";a="7957641"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 29 Jan 2024 15:52:27 +0800
IronPort-SDR: pqbK1FDHyDuLv3DWJijXSmFFPzc2+7r372cj7D4+Iwb0gHNQc37tFDLPkICeJJZfyCVQmaTRkO
 ujW0gj1Z3aDg==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 28 Jan 2024 23:02:22 -0800
IronPort-SDR: a+xFj1elJxUfjnGbMLQtq4lQiX7ERjA+Y4ZquDyvRef/cnam2FbEjwxso8q5jVbsGBbnmT7XDU
 gx4d10id9lHQ==
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.6])
  by uls-op-cesaip02.wdc.com with ESMTP; 28 Jan 2024 23:52:24 -0800
From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v3 0/5] block: remove gfp_mask for blkdev_zone_mgmt()
Date: Sun, 28 Jan 2024 23:52:15 -0800
Message-Id: <20240128-zonefs_nofs-v3-0-ae3b7c8def61@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADBZt2UC/1XMywrCMBCF4VeRWRuZTC+2rnwPEbHJxGZhIonES
 +m7mxZBuzwH/m+AyMFyhN1qgMDJRutdHsV6Bao/uwsLq/MGQipRShRv79jEk/MmCq0lE3XEWNa
 Qi1tgY5+zdjjm3dt49+E140lO79ehYuEkKVAohR0W2LChav/QaqP8FSYl0X9ZLUvKJel2W6lGy
 brFXzmO4wfFfYJg3gAAAA==
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1706514743; l=1894;
 i=johannes.thumshirn@wdc.com; s=20230613; h=from:subject:message-id;
 bh=rp5FcjO4/GYjbF5Qyk/GxKqz5Dm+QfeA7jbL0YYHdsM=;
 b=2ejVcWAH227cyBcLTAnmQV/viZ0C5PHZhudgyn72fAlTiBCd6IOpK+wyllf64WvtEBVU5sViJ
 8eBBKuHqePeBlFpK16YJ9MZy0ZO2EaU/AF6A2deSt4WZJ/fyuLoWemF
X-Developer-Key: i=johannes.thumshirn@wdc.com; a=ed25519;
 pk=TGmHKs78FdPi+QhrViEvjKIGwReUGCfa+3LEnGoR2KM=
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240128_235235_284083_B02BB88E 
X-CRM114-Status: GOOD (  10.39  )
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

Fueled by the LSFMM discussion on removing GFP_NOFS initiated by Willy,
I've looked into the sole GFP_NOFS allocation in zonefs. As it turned out,
it is only done for zone management commands and can be removed.

After digging into more callers of blkdev_zone_mgmt() I came to the
conclusion that the gfp_mask parameter can be removed alltogether.

So this series switches all callers of blkdev_zone_mgmt() to either use
GFP_KERNEL where possible or grab a memalloc_no{fs,io} context.

The final patch in this series is getting rid of the gfp_mask parameter.

Link: https://lore.kernel.org/all/ZZcgXI46AinlcBDP@casper.infradead.org/

---
Changes in v3:
- Fix build error after rebase in dm-zoned-metadata.c
- Link to v2: https://lore.kernel.org/r/20240125-zonefs_nofs-v2-0-2d975c8c1690@wdc.com

Changes in v2:
- guard blkdev_zone_mgmt in dm-zoned-metadata.c with memalloc_noio context
- Link to v1: https://lore.kernel.org/r/20240123-zonefs_nofs-v1-0-cc0b0308ef25@wdc.com

---
Johannes Thumshirn (5):
      zonefs: pass GFP_KERNEL to blkdev_zone_mgmt() call
      dm: dm-zoned: guard blkdev_zone_mgmt with noio scope
      btrfs: zoned: call blkdev_zone_mgmt in nofs scope
      f2fs: guard blkdev_zone_mgmt with nofs scope
      block: remove gfp_flags from blkdev_zone_mgmt

 block/blk-zoned.c              | 19 ++++++++-----------
 drivers/md/dm-zoned-metadata.c |  5 ++++-
 drivers/nvme/target/zns.c      |  5 ++---
 fs/btrfs/zoned.c               | 35 +++++++++++++++++++++++++----------
 fs/f2fs/segment.c              | 15 ++++++++++++---
 fs/zonefs/super.c              |  2 +-
 include/linux/blkdev.h         |  2 +-
 7 files changed, 53 insertions(+), 30 deletions(-)
---
base-commit: 615d300648869c774bd1fe54b4627bb0c20faed4
change-id: 20240110-zonefs_nofs-dd1e22b2e046

Best regards,
-- 
Johannes Thumshirn <johannes.thumshirn@wdc.com>


