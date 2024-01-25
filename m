Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4014DC48286
	for <linux-nvme@archiver.kernel.org>; Thu, 25 Jan 2024 16:53:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fpd79ziWWnEkE4PQSjIRnLcjjQg7HoWMKhlTrkjmDK0=; b=uU0d2Jh4/TYyV/YiUFX6DDLGrS
	8OZpxCW6E0bOwOe2BBea8PvpK0fPA3fWJIvwCt2aHPGatVjDkzyZuxu62mmvj4NIcg5/1iTH6WbPT
	21Zsgy2qoqhbne3HfSrMy8g8fEeSKHwjh3LEunoUE33vood23WSjjzNuPuPoRkaErB74FP/cKEoLo
	tfe3GR/SKz5qpvbA2vihw1hSeb3eJvDPmQ2jIKrb7ecYcnG3Ihg+IacS2FrLv+upXJXByvdUxHEbv
	XchWaSalMbtgpdh2QPH4Sz0Kv6eRPUiSOUURcDUwLWjINXEJIjUPcII6t//FQ2F8XfLaWXfgk4RRn
	MrWmYakg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rT2z4-00000000yBB-2fDJ;
	Thu, 25 Jan 2024 16:53:46 +0000
Received: from esa1.hgst.iphmx.com ([68.232.141.245])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rT2yz-00000000y6Q-38O3
	for linux-nvme@lists.infradead.org;
	Thu, 25 Jan 2024 16:53:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1706201621; x=1737737621;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=eGx4McY1FmrYKhrAp3TTxFkfkbSfbNbdZDzzsYbn3SA=;
  b=H9CroMtdfZeJvwoDp8vcbuwbgWvfACbwwCOwdsD7vadSy/+Qwl3PCV7u
   Zo79Ky/YmZDRMPQDyiNjo4gYsBzOCIC9Hhv1Jo15KUk95WkC5ZgD8qQMU
   QvIPMHCfQ1blQF0hJcddApdA93kzkwibl7/CJ0sulT2kEdCqo9iEY0SET
   TKLcKfNgwKaw5CQOlCnxpLii3BWL7+wK4ZXkbYvIa8kJ5P2UIgeyi0huD
   bXSbfnYcmBDaNmSFN+tpEjCi3+NpDu9ASMX4S1ugweoBf1wbyMEC9Pg1T
   Bz3zRrZForezOqB0FnBrIZJzbdgt3iooNvt7T0C6eq6EcrjQ+d/sgDgcA
   A==;
X-CSE-ConnectionGUID: gH5Bu1JmRKWAj/3NU7xmjA==
X-CSE-MsgGUID: OSfeKAYrQfyVF79KTuiUtw==
X-IronPort-AV: E=Sophos;i="6.05,216,1701100800"; 
   d="scan'208";a="7967074"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 26 Jan 2024 00:53:39 +0800
IronPort-SDR: T+G0cdAuRUfUD0JCc7dvnAZ5JV+NNTub0JogG86R5nyY230KY9OBCJdwEo2lMpb4kdK4beVsLJ
 55+20lXnY6rw==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 25 Jan 2024 07:57:58 -0800
IronPort-SDR: VOx0UIr5lbldPsjxQBhoPSsQoOEZNWGs3Yn004iQ+BbMXVrE9gDtrUz+juD/7EPs5IyZ7d6MAQ
 oXv5yVO5EAbg==
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.6])
  by uls-op-cesaip01.wdc.com with ESMTP; 25 Jan 2024 08:53:33 -0800
From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Date: Thu, 25 Jan 2024 08:53:24 -0800
Subject: [PATCH v2 1/5] zonefs: pass GFP_KERNEL to blkdev_zone_mgmt() call
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240125-zonefs_nofs-v2-1-2d975c8c1690@wdc.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1706201608; l=1041;
 i=johannes.thumshirn@wdc.com; s=20230613; h=from:subject:message-id;
 bh=eGx4McY1FmrYKhrAp3TTxFkfkbSfbNbdZDzzsYbn3SA=;
 b=7i7rSG5FOL3Y+GFA5rvmzOGA1LPZcNa6uQEcp9OZuAhx8o+EuzcMQlp/v7AQwfxAOFFlfDgdz
 pJC/jmeDno3BoWXgTUVMLTNlb/W+P6XXYXlpj2p8o3WXeCGKXi91zBB
X-Developer-Key: i=johannes.thumshirn@wdc.com; a=ed25519;
 pk=TGmHKs78FdPi+QhrViEvjKIGwReUGCfa+3LEnGoR2KM=
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240125_085341_913095_181BB580 
X-CRM114-Status: GOOD (  14.85  )
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


