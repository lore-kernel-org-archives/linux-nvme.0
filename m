Return-Path: <SRS0=ghx+=G7=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBA51C433DB
	for <linux-nvme@archiver.kernel.org>; Thu, 28 Jan 2021 04:48:08 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6019C64DD8
	for <linux-nvme@archiver.kernel.org>; Thu, 28 Jan 2021 04:48:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6019C64DD8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=4Hnm94j05dQKAQmttiN/Dt+sVwV+wZNPf3PjilRfLD0=; b=AtvnvSu50sPDHsA6cK0U3wPjo
	+xBlEiWBQEmf4rY8zDBCTRvAiQXdzNPiEqiVe6UbjvuHgsEFSnpLOeXWnXwsUrT3rJ/vwlPfhHzQ1
	8A1AvcaGErZMvoarp8/EpS+7cs76L5biDqMOdKSMGGz3yDLXA5PmPR3ZbuuMFjmepQiavx9tPau8C
	pKaDI97JpTSrJvUCZDl2ZLfjHlEfFpoA0EThq87JRl9RmG4vByGgTSYzqjUkiDda/8BjZesbmEDJg
	dHzyubyF0Il223Wi3I/ej1tSPv4W2B8MaArIdrAtfCGc6+odif5eBzP2uw/CzetTB+C/Z5mSEYSlK
	CAOXApwaA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l4zDx-0002D3-8O; Thu, 28 Jan 2021 04:48:05 +0000
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l4zDe-00026W-6M
 for linux-nvme@lists.infradead.org; Thu, 28 Jan 2021 04:47:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1611809266; x=1643345266;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=AS28SYb5q1dU4ktJHvnVMu02oMpGHGEKFN6I8l7eXCY=;
 b=fYWAn0aAkWC2u3dv4EODrgI7jhFV/2hdeWdevTAlXR3+J2a7++5fdzkF
 x/vRLOTU5Nt8DGBQo4yOFUR5UI6O0jNrUt6MGW6AKqFTPvaOoKpDan0Z/
 wIFGEUdAzl0dAr+L/Vfmo0qMIVGmw41IlQSZBMQV1kdwGvhS9urdBOag7
 NZpzHnCE9T8lyZJfznFvTpW+/MgohzRMsYTHM00uPAM4E7B8nwl6G6kbq
 NbU7wlnPhVt3YGwN45PYu+FZVZM97m9p33AoD8WBEOi4Ca/Ha6ZF+v02/
 BIxumb51wgHdGliinw8+Q2P0wCL/UcgC7tYpDMMekpPNM+QS+d40Loc/J g==;
IronPort-SDR: 1Wr2ro1LoBbgmkAFoTjZS9cLSf8wA1hbefpPPQxonkScpmTM4DdAGEUuJJu8pIt0ZQRuDOOokW
 3FPkEdDpmAeOwrNJ0HZpdzSNKaxfsQwDUrRx8K+sLYSGYcQ2oWOBAURXLvkXFWnR+ma/0Dj+Yk
 SOn6SZmmriMkCM+C/6M/uv/IqJRaA6KnWJpDchwrdmM4Ks3DIQVFHikNE4ouI05cYZQd7/rbhQ
 XloktZrZM95TXPk6OfMzgTSgMGkGOa+YP87DZG1H8Rl62dG1QngaRUzs9m85mMvy7rWWUb/hYf
 Vf8=
X-IronPort-AV: E=Sophos;i="5.79,381,1602518400"; d="scan'208";a="158509633"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 28 Jan 2021 12:47:45 +0800
IronPort-SDR: Dt7d1NGnwKwgz16Hexi5sDqadhrRdMkC3p8vkAX7ZtYd+WD8k0ZqYke5fWYnxkTTI4g07Ky8qb
 E5LBppV6LTXzUzDQgU70nfi6JEp/9eWNmtrrhkoxr+AGLSDcMSndyAaLlQw10MOuGi3kBCTs99
 Ad4UqnX57iGNpMyroDkv3rS4Pv6mUQfbBhwykegH4GmQyN16s5YqyagGRO6SXMNAtlbgpSj1w4
 Umw4sRfBQmGl1wfwOEf9wZ/uo6E8hN3kZmTvuSFAaDnekhHK/OVuj6PHn5+Gi7hyeMaEp6x/7/
 t1qhmme6uBkFUoa+t/n055Yj
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Jan 2021 20:32:05 -0800
IronPort-SDR: Ih/EIXJQ+gm7gzO0vYm/RUmL/N2knyTj+4YQH3D2SEHcGrwcmtNZQxBVXi3nTLGXND293dX5dv
 3osTAZVlmO9JfrAPv/Bi40zkDPS7XHJmLbju+yPgWStmacadE7vXXBeqMt1lbcBZbPsHZBOCPL
 64LZrURWEW/UJWwRiU8cDrOw9VAqjAVlcSRnYCpzIJ/xcYXUHx4BYVRG2jEobNX+4tyWDmibgG
 e5XXPyMCMYMmFDTW1lJajFjyLc8xgiP8wDEbhRw5HIRYhra0VLM/LlE0fSOWYrKFp9pPsFoH5R
 hec=
WDCIronportException: Internal
Received: from washi.fujisawa.hgst.com ([10.149.53.254])
 by uls-op-cesaip01.wdc.com with ESMTP; 27 Jan 2021 20:47:44 -0800
From: Damien Le Moal <damien.lemoal@wdc.com>
To: linux-block@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH v4 6/8] zonefs: use zone write granularity as block size
Date: Thu, 28 Jan 2021 13:47:31 +0900
Message-Id: <20210128044733.503606-7-damien.lemoal@wdc.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210128044733.503606-1-damien.lemoal@wdc.com>
References: <20210128044733.503606-1-damien.lemoal@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210127_234746_416686_0E372E94 
X-CRM114-Status: GOOD (  12.61  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Keith Busch <keith.busch@wdc.com>,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
 linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Zoned block devices have different granularity constraints for write
operations into sequential zones. E.g. ZBC and ZAC devices require that
writes be aligned to the device physical block size while NVMe ZNS
devices allow logical block size aligned write operations. To correctly
handle such difference, use the device zone write granularity limit to
set the block size of a zonefs volume, thus allowing the smallest
possible write unit for all zoned device types.

Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
---
 fs/zonefs/super.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/fs/zonefs/super.c b/fs/zonefs/super.c
index ab68e27bb322..b9fb55b250ae 100644
--- a/fs/zonefs/super.c
+++ b/fs/zonefs/super.c
@@ -1581,12 +1581,11 @@ static int zonefs_fill_super(struct super_block *sb, void *data, int silent)
 	sb->s_time_gran	= 1;
 
 	/*
-	 * The block size is set to the device physical sector size to ensure
-	 * that write operations on 512e devices (512B logical block and 4KB
-	 * physical block) are always aligned to the device physical blocks,
-	 * as mandated by the ZBC/ZAC specifications.
+	 * The block size is set to the device zone write granularity to ensure
+	 * that write operations are always aligned according to the device
+	 * interface constraints.
 	 */
-	sb_set_blocksize(sb, bdev_physical_block_size(sb->s_bdev));
+	sb_set_blocksize(sb, bdev_zone_write_granularity(sb->s_bdev));
 	sbi->s_zone_sectors_shift = ilog2(bdev_zone_sectors(sb->s_bdev));
 	sbi->s_uid = GLOBAL_ROOT_UID;
 	sbi->s_gid = GLOBAL_ROOT_GID;
-- 
2.29.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
