Return-Path: <SRS0=yPeo=GZ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D499BC433E6
	for <linux-nvme@archiver.kernel.org>; Fri, 22 Jan 2021 08:00:50 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6FD4C230F9
	for <linux-nvme@archiver.kernel.org>; Fri, 22 Jan 2021 08:00:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6FD4C230F9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=Uk64KGo7GkoCs3qk2h8V7efc/IdDGJmAdVHjmm2nx9U=; b=Bypkl+UtsBg+B9JbSTSnc0YHT
	CBKdB/itb4HJKj1iTTN39SIoomaXl56unonaBlkL/bFYPFRQcTowBwK9d9YVRgqNgIY9Q/+hFAiGV
	MSv0l6YTvp+YEULKTDSytPQy0e4ZYqYESn6OCV3SIGr669DIBW6ViMNZU1Ak3ukHL+2ad9OlDZkUp
	p1XM/dxNQwwaZlrOrlPwKviLjxF/Oz9staEfUv+d87TZh5jVRO//WMKu+PwkkiG2cnudET8+qCdHP
	n91en9lJiBtqz2+AfUYjZ8Ryid2xwhUo33W+v+jET2Y6MFFMpKhcgNeZ0jEzFf+AmYOqCequB10Ig
	xVWd3gmBw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l2rMs-0003Tl-5z; Fri, 22 Jan 2021 08:00:30 +0000
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l2rMm-0003Qz-0T
 for linux-nvme@lists.infradead.org; Fri, 22 Jan 2021 08:00:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1611302423; x=1642838423;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=5xfbHvgjhWJgLXZcVOEkOEdiGZ/g9yxwTbfqK6J5900=;
 b=oXWsK2D5fIpjDmkN7Yq3diSiGF2hg8NUuoSQ4SU3f+rS55zXPFp49sjb
 /JHqQRakLpCIcoTvJjXKRiJjVpbq0ZwPLtmLc3IHK1lF2F8aSIjwbNLgD
 d0HoCAdVmQgzX7qCjhZ7E6snp3nsyXddDhgoDPj9HXx3T0cU5MRpK88ha
 2ZJr+vtXvU838hh787/RfDUbjiA863YwOt/b3Ptt6Wlulagn40qo7E/kr
 Uy2XyJSDBOA5kgGICrRitM4dsOX7vkYcdInO/NFuqcqeQBp7s6CNgzEcp
 7r2dx5sLrzC2WYVryXGBCPKpKFsF4YQzHCqHWmeRpIheM/GJLpKB07ewi Q==;
IronPort-SDR: 2tc29XAGetxdgCtvMsXNr1VNXI9TsodD12I0MQ9ASPSLZ6h5zJf9zrJ7AjoNd4SE0qdLyCGP3J
 OXJ2uK0DMsHI8SZWU+44+HQyIDeStQ9v4lGyl/95vvX6aGRS65QSermJ37wV8qcjsg+4SRqZzk
 bBjIQEtrs4VaF3uykVR/mjzNViUsS6O7YjLNYpcb1Y0Mg7MWiMpWdoV7xwAxsweCBJC0FUSpNQ
 5fZfc/MI2/yvpmaREK+JLfymy1+1yT0vd5SiF/bB2itqKVFEKVBc81pZli+l210hK+O75SZLHL
 Wtk=
X-IronPort-AV: E=Sophos;i="5.79,366,1602518400"; d="scan'208";a="158062036"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 22 Jan 2021 16:00:21 +0800
IronPort-SDR: fQjfPEWOkyjKj93c8AcgqLQlclIs9+Y5eMhOnxhv0KTU3kksa/MMFVYQ1vbRcV8kXzwNSLYYVN
 EBNkinlZzil/I0KMpnOxViIvKMj180xn7rAEykn9NCtocWDFmEkbNFy4Rz6nQQO0ShFjl5TiIY
 Uu1L8aKW/RZr7OxX9eOsjus57leK5V2cKxZWe3to9/EwaBITrsCGDcV/CltHsmHGnJwZtiGheo
 eaO8rOiCkiuWVjgmIw08jiQtmAVBUu2PFXyfMuSUGCI23qfkCmGGNfUBRH4NtrEyMwoVqp5w1L
 1mC4XkaS+pCU5XxMdIzsrzbH
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Jan 2021 23:42:52 -0800
IronPort-SDR: DvcsHkJNFEtNvTji/LXw3hNgrcJ0I9b0dMZR16CPd3l7W226K2tH9phrbCblOykbO7PjYySuV1
 MR1ZLLwMjlq8/v6xCaH1Cb9R5gNZhauyH6vo4m1m2e3KUDbo3XSM06WdVsgfDlHOh8nhoNAe4S
 xkSboBPdJ1dx8LFAuKQtRA197nDmjJVsXWMfaEEXAwhnhwE62vrDafnYcvb9zY+CyvurAnDabb
 5rnLjvci8UkQy/q/NG8IGhTFO95xO8YvShrflxl1OQ3f4FwViCBGfyAxbxZMTPlHF3IrkyVV4p
 Ygg=
WDCIronportException: Internal
Received: from washi.fujisawa.hgst.com ([10.149.53.254])
 by uls-op-cesaip01.wdc.com with ESMTP; 22 Jan 2021 00:00:20 -0800
From: Damien Le Moal <damien.lemoal@wdc.com>
To: linux-block@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH v3 3/3] zonefs: use zone write granularity as block size
Date: Fri, 22 Jan 2021 17:00:14 +0900
Message-Id: <20210122080014.174391-4-damien.lemoal@wdc.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210122080014.174391-1-damien.lemoal@wdc.com>
References: <20210122080014.174391-1-damien.lemoal@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210122_030024_296146_81A98AD2 
X-CRM114-Status: GOOD (  12.93  )
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
Cc: linux-scsi@vger.kernel.org, Keith Busch <keith.busch@wdc.com>,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
 linux-nvme@lists.infradead.org,
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
---
 fs/zonefs/super.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/fs/zonefs/super.c b/fs/zonefs/super.c
index bec47f2d074b..8973d77ba000 100644
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
