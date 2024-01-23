Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34C39C47DDC
	for <linux-nvme@archiver.kernel.org>; Tue, 23 Jan 2024 09:44:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Message-Id:Date:Subject:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=c3V485QR15mzzWFdAVRJ2utjiAickSkqCmojnyiDwIM=; b=EkexE/mztXMXa7
	aTK/JkT60Emk+6p0u38ukd5bCsXmvHbVVPZDlDi+MI/p9b5Y56S/Ha/MFK2GA2XSHMJod4rBiDouv
	j82oTADVGvPbx6O1EQR1hRSj6cJLhwMtfixYZtgk3eXkdz6Dz6ovSNgbJoMrG1cGT8uJm4myugvA5
	0wR7eNcdoMaWsm3ZZX3CxDOCTCmxCy+zDw5SchNgUL13ewQbcYLrDVquZzkTSyl8uYbfEr3NZ5jXt
	mV1RW3r1uwSG11M114KaGPRTXAZqcZBjlpOSYs5I5EvOanDA0ScmF6Gl7xgSqO6dgaZjfPMAV8Wzg
	ToyUInKUCbwyDXDAQ7YA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rSDJz-00FmbU-34;
	Tue, 23 Jan 2024 09:43:55 +0000
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rSDJx-00FmaH-14
	for linux-nvme@lists.infradead.org;
	Tue, 23 Jan 2024 09:43:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1706003033; x=1737539033;
  h=from:subject:date:message-id:mime-version:
   content-transfer-encoding:to:cc;
  bh=/4h6qYS/eHpSlVim37uPdGcbFkvmnDTQ5JZLyrLcZnE=;
  b=eLvGuPdXq20+ZVJxculdvb3wCwOdQpE2dI/lisjWCmPDhE3OWYNqP++V
   awL1q/vNjUZYm7B5jSv7fB6XNoLfH3o4YEIHz3/q7EIc8wB8DojRtpL3j
   mB0FImsz0X8Ac9c4domBRHa2gd1a9PTz0qI7tqgjLa1ULjDJeVtxqtsvf
   qsVQoLL8Mpm+4L5ssCYRCUONqLLJa3xPL2Pt9ISTgsL9EOWG8yTVAMMud
   MIKK4XmuhgN1Xhod8YdRghOhwJZhdTCg5gynEifS7zbMqzuyu/1KdR0i1
   JT5AVnJHjtgmMw8Ns1yQ1LtNutoJ61kpVnezYlzp41/+Fpgql0iPGQy6L
   A==;
X-CSE-ConnectionGUID: dfynkHqITEqZnwRvvvUOYA==
X-CSE-MsgGUID: qAgZNczIQS2rXc5OLrUTQg==
X-IronPort-AV: E=Sophos;i="6.05,214,1701100800"; 
   d="scan'208";a="7240338"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 23 Jan 2024 17:43:51 +0800
IronPort-SDR: uEdUC7DUYuImYIPX5kpt89o237g3bfKZZaQNZuxnQ9aOGFtohOq/ulaNudaOO4Vp+KsWwH6cm3
 o7TKXt1SXLXw==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 23 Jan 2024 00:48:13 -0800
IronPort-SDR: zUnRHHmVsKHmYWHqPESmgsAEmU5gU8xkWm6MN/q4pTyWM+A4c3LciGXWMEKUbx1GLBqQ7hfn4G
 QMsyEBuf/JKg==
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.6])
  by uls-op-cesaip02.wdc.com with ESMTP; 23 Jan 2024 01:43:47 -0800
From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH 0/5] block: remove gfp_mask for blkdev_zone_mgmt()
Date: Tue, 23 Jan 2024 01:43:41 -0800
Message-Id: <20240123-zonefs_nofs-v1-0-cc0b0308ef25@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAE2Kr2UC/x3MMQqAMAxA0atIZgtpKA5eRUTUppqllQZELL27x
 fEN/xdQzsIKY1cg8y0qKTbYvoP9XOPBRnwzEJJDa9G8KXLQJaagxnvLRBsxugFacWUO8vy3aa7
 1AzrU4INdAAAA
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1706003027; l=1540;
 i=johannes.thumshirn@wdc.com; s=20230613; h=from:subject:message-id;
 bh=/4h6qYS/eHpSlVim37uPdGcbFkvmnDTQ5JZLyrLcZnE=;
 b=XWApU1yRY0zet3szE9Y5YwxO0lp/MB+nH+oGhmBdyhChEBIQpYa6r7zw4rgXKerbrVnIXc2mT
 UtgASe05xPWAqN+bStf/4/hcrd6JLPpuUKW556WA7lZY9ZeLtErtKq6
X-Developer-Key: i=johannes.thumshirn@wdc.com; a=ed25519;
 pk=TGmHKs78FdPi+QhrViEvjKIGwReUGCfa+3LEnGoR2KM=
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240123_014353_437378_8A54B10D 
X-CRM114-Status: UNSURE (   9.66  )
X-CRM114-Notice: Please train this message.
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
Johannes Thumshirn (5):
      zonefs: pass GFP_KERNEL to blkdev_zone_mgmt() call
      dm: dm-zoned: pass GFP_KERNEL to blkdev_zone_mgmt
      btrfs: zoned: call blkdev_zone_mgmt in nofs scope
      f2fs: guard blkdev_zone_mgmt with nofs scope
      block: remove gfp_flags from blkdev_zone_mgmt

 block/blk-zoned.c              | 19 ++++++++-----------
 drivers/md/dm-zoned-metadata.c |  2 +-
 drivers/nvme/target/zns.c      |  5 ++---
 fs/btrfs/zoned.c               | 35 +++++++++++++++++++++++++----------
 fs/f2fs/segment.c              | 15 ++++++++++++---
 fs/zonefs/super.c              |  2 +-
 include/linux/blkdev.h         |  2 +-
 7 files changed, 50 insertions(+), 30 deletions(-)
---
base-commit: 7ed2632ec7d72e926b9e8bcc9ad1bb0cd37274bf
change-id: 20240110-zonefs_nofs-dd1e22b2e046

Best regards,
-- 
Johannes Thumshirn <johannes.thumshirn@wdc.com>


