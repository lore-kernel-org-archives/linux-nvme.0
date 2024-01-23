Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39395C47E49
	for <linux-nvme@archiver.kernel.org>; Tue, 23 Jan 2024 09:44:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xwNR4/EZjtvmjPU5B92P0twDrTPGvgcwhXfRvMp8W3M=; b=iPHjSKKuCVTzSidlTza2CC9L94
	L4fv+DKuIjjisW+knvrmidPh4Vy+/ZkBCVYA7rNAZ/dg90cAHBg4dHEAerQ0WqNFivXd0w6YFHOna
	lU8FccS2lOsa2D/MKjXTLW+wWLPRyDNj6lho/HCK+2yaOwlCc3sA5vw7YbGFGU+Avd3kNs+rm6g1Y
	v12C5iH99Fs4iwKAPtx5HOxvx6sPDzOd8+Rmdr96KB8wm5cO27V9LQu2+HppGpAIALJia3g69xnsj
	euTQue0DyI7HTo9ZWtEnrZFG2CaKtr/jotKNaXjqYZiS5RJaGdv5zh9fEH7qCVpHRvm5ceRPMhpUt
	OXFcCQZw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rSDK1-00FmcB-2I;
	Tue, 23 Jan 2024 09:43:57 +0000
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rSDK0-00FmaH-05
	for linux-nvme@lists.infradead.org;
	Tue, 23 Jan 2024 09:43:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1706003036; x=1737539036;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=USx+V+gR/5Lk+0GJr2lbq1FeCI2pXKMzpek+ct39bMM=;
  b=kmfVXeOqqQVRRA+NAECdR163sFSw279kgCOknBgXwRPr24LW7ePRnHtW
   rc9XFRVmSaucqrOcHfv8x7BeVrkyv8kS227Vz88LQ+/7A1UlNZnLQhE5r
   UF4nf0EaVyuRNIF+148oJsUrpDgmP8j6TkX0+j9Sdxk5zcuzVg07kiIub
   z0ybsKwxwr56dGiH+sc+ElOC20dZJqGgERP2bMpLqInMyVlvOEbqgnZyB
   DKZvJMlrVDEXzinsiIb+iKoKYMOumy1+klNtu7EP6ngN65KrGpBiBiM+i
   RWUocQURSfol3OA1rpUJYY4cy1XeH9Q4+HDcJWrOoNAewUmmFb2vOB3lL
   A==;
X-CSE-ConnectionGUID: 3WFo78naSsa5jJmDN72K6Q==
X-CSE-MsgGUID: 8j8ktXpYQGCaEJEDOJPRgw==
X-IronPort-AV: E=Sophos;i="6.05,214,1701100800"; 
   d="scan'208";a="7240347"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 23 Jan 2024 17:43:56 +0800
IronPort-SDR: Bw7orNrr7FtvRXAHW1eth4IuOQY1p3gh/b7IgTVK3GRGyjAOHxJKpUQeLXMT+JTVgqUhdUpVvJ
 X8IycfnOVR6w==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 23 Jan 2024 00:48:17 -0800
IronPort-SDR: P3OOCgnEiOoiT5kro0hhE2puMVinRxHrlbO9eu21ZDBzEa4K+SZFeEYuAtZNHIp7Zz4lNvn0Hv
 sg9b/x3sDNFA==
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.6])
  by uls-op-cesaip02.wdc.com with ESMTP; 23 Jan 2024 01:43:50 -0800
From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Date: Tue, 23 Jan 2024 01:43:42 -0800
Subject: [PATCH 1/5] zonefs: pass GFP_KERNEL to blkdev_zone_mgmt() call
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240123-zonefs_nofs-v1-1-cc0b0308ef25@wdc.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1706003027; l=967;
 i=johannes.thumshirn@wdc.com; s=20230613; h=from:subject:message-id;
 bh=USx+V+gR/5Lk+0GJr2lbq1FeCI2pXKMzpek+ct39bMM=;
 b=CqyzAxjrtVF3h1COiTD1vUp/FvMExp42Wy7b72mtI/+VK3Cc+nQQgb8KdYlLZ32Qn9DwLPhCQ
 2dpOdt+5tGWBTomHGv+qgGPRnYLx+GcwkDEU2N7SunPs8Zz3A98pXO5
X-Developer-Key: i=johannes.thumshirn@wdc.com; a=ed25519;
 pk=TGmHKs78FdPi+QhrViEvjKIGwReUGCfa+3LEnGoR2KM=
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240123_014356_099563_D892D1BF 
X-CRM114-Status: GOOD (  14.26  )
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


