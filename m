Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0862FC47258
	for <linux-nvme@archiver.kernel.org>; Thu, 25 Jan 2024 16:53:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Message-Id:Date:Subject:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=+rMsCS9rqQgIJ5vRczmQ2xycPhDowhIsBQh1+x8t6+4=; b=0W+hcviaIxdBr+
	6ngGmcNyLlbb9wEXWINRMGCAhfyxA7njPw2MUWS6CE7EmihiGE7rcYfhH1m+46lT1Xjzly3P59ZeO
	Z7C6YOAfAQ+HmSot5x61dY3UPb8U8kc650NIkdNr7IfvCA+pr5hda9szNM6JzVxfauMi6i8l9uXz9
	f6Z84et4p4uqf9DXVT5OfwJuagx91glL1ymoPJkMyMbXlb4CDfG5eJ8OBpXlQAAkT6a7yKl2pOONo
	d/1zTofrfi+tH3k9CEiBE/muUivKuAE4FTrr+Pk91xgJmYxQvxkPzPC8NsB064fZAagwePRvkZk3o
	FAorTHN6MVr/GmH41pQQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rT2yx-00000000y60-1uDp;
	Thu, 25 Jan 2024 16:53:39 +0000
Received: from esa3.hgst.iphmx.com ([216.71.153.141])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rT2yu-00000000y3L-1M40
	for linux-nvme@lists.infradead.org;
	Thu, 25 Jan 2024 16:53:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1706201616; x=1737737616;
  h=from:subject:date:message-id:mime-version:
   content-transfer-encoding:to:cc;
  bh=0N4F/gjOaEHcA1EmZZhcmvU+dQFlqf6CupFhM16+QGk=;
  b=fYQULYcc/S4PdpOEWYSSk63v4qv7P7HTXZk3tU0mZfBfAZTlUCNiYD1W
   MID4aTcQ9qheeR1bCzSTAGpdeoGEpTONEpY3G4gOnEsh3VOtYij4+8rP8
   utxXgMaRptlEk9IH4MEyy11slONApj61UyHeynAIa/Txb+W1fzyGsWUCl
   iruWtqF/0FV+1i6bQ2bF/uKKnMUJwnfpqwTanRrNj16mKDr1CqfQ29psx
   h7bhncklQRCtSkZOKT2nq/htgGmYG4+2fdpfdBTKx7eaOooR6i7NtxkmN
   zJDaxgJTlcdPU+9ljpfV0Tv0OD8y7smW7wG1R67x9MN1MIuSEDpkk9fQl
   Q==;
X-CSE-ConnectionGUID: /z4TXa9WQlyYaRUa5DX3fA==
X-CSE-MsgGUID: /63FK6GdT6GHClvhPzKKaQ==
X-IronPort-AV: E=Sophos;i="6.05,216,1701100800"; 
   d="scan'208";a="7680113"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 26 Jan 2024 00:53:33 +0800
IronPort-SDR: ZZ1yqjoMv+IEp5c74nrYxTf27QMCrG+W5WYB4nl/MjNkUKvukzu+uD7hMX7ojHYr+yXmR7gOt1
 OUoVo7PBzy4Q==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 25 Jan 2024 07:57:52 -0800
IronPort-SDR: OE+tRkmMpFkhDRa1z/PeEZo8HAAoGZY5dfaVEn8/s2a64gELw2HyRSw+9hYcenKw2PYuCiSi5y
 qsHOshAr8N7g==
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.6])
  by uls-op-cesaip01.wdc.com with ESMTP; 25 Jan 2024 08:53:29 -0800
From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v2 0/5] block: remove gfp_mask for blkdev_zone_mgmt()
Date: Thu, 25 Jan 2024 08:53:23 -0800
Message-Id: <20240125-zonefs_nofs-v2-0-2d975c8c1690@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAOSsmUC/1XMywrCMBCF4VcpszYymVYRV76HFLHJxM7CRDISL
 6XvbixuXP4HzjeBchZW2DcTZC6ikmINWjXgxnO8sBFfGwipQ2vRvFPkoKeYghrvLRMNxNhtoT5
 umYM8F+3Y1x5F7ym/FrzY7/pzqP1zijVonMMBW9xxoM3h4d3apSv08zx/AOnqE66kAAAA
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1706201608; l=1733;
 i=johannes.thumshirn@wdc.com; s=20230613; h=from:subject:message-id;
 bh=0N4F/gjOaEHcA1EmZZhcmvU+dQFlqf6CupFhM16+QGk=;
 b=UDiRHl7vyONFeE/+Uc9h4ZkfV2sLDGr/bQXidpKeyTTKnEZ1boUAGnz1/g8SHkp2NIP1u8WfY
 k+ntypLEWF8Dk7T6KptUtV/AFpEKDBwUlfE02SJfrjkjKtMj15vuipc
X-Developer-Key: i=johannes.thumshirn@wdc.com; a=ed25519;
 pk=TGmHKs78FdPi+QhrViEvjKIGwReUGCfa+3LEnGoR2KM=
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240125_085336_438050_A85B0286 
X-CRM114-Status: GOOD (  10.65  )
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


