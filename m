Return-Path: <SRS0=ToWz=FO=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 190EFC433FE
	for <linux-nvme@archiver.kernel.org>; Thu, 10 Dec 2020 06:26:50 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8B98C23C43
	for <linux-nvme@archiver.kernel.org>; Thu, 10 Dec 2020 06:26:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B98C23C43
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=Jl+bTgRo1xoCYkvsweTcij+H4DvPPLfQkAi9X8JbEoI=; b=kpl8f3c+tHjeM1eiGFNYw0FOj
	1ykUyAz+Ih/Px1WnEeLVBWnbt5G3rI+C88fsvr62vgpTvxfdQ4WN9mq+kmUz2HSIoDD8HAT8cEFHG
	P/ooAqCldIfa7JMD3Kk1iYP2a6T4OmjtBP8ZCSeuavHc5hgV07TUBz1gAxlngQ78uBJY2kqGbHEdv
	gntjREYCFfBA6CCQvzZuV6VK2K/JdTWvwaeNARGA3YgkwwPId+kB4ZpvYHcKvKBt8I8Zgf9Gum1WP
	XkFP7Z/nU6IiI2acBYCKccA2xrA5E9MJp0ZWinPdBClSUt6VQd/pAekgDs5HT62XQo2zfiW/ya/dm
	OuJat7rTg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1knFPa-00013P-Ef; Thu, 10 Dec 2020 06:26:46 +0000
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1knFPY-000132-Sw
 for linux-nvme@lists.infradead.org; Thu, 10 Dec 2020 06:26:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1607581604; x=1639117604;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=UfKvG3DF5+e1xbSx0w/6Rpv8SlZKd4h4pbL+RDgW3Js=;
 b=lxRkXcnsU/pyVbSYFwM2J5/+TO4UHN7NcfZj5EvyN9mO47gvRKMC3xEg
 yJwpjJ4r4eAqT/O2ascMlUsmYtbxB8RHeVh7Albz6gb12BRKu5ke7Li57
 8X1nIpJ+zw0szBOodST1W3RsciStcl4Ctjs7F5u9OfbMRmffkAtSL9txt
 bOiifLZ/q1kx0Lva4K4yS1cRKqTHLbi8OtRx9oTY7IiXzmBGUfH1Ck//O
 xUNsqGlxB3+APwWGfS6+lMJN9vR2QRJ2Ts2euk4g+XAS9Ly3SexFy5np3
 CbEoJ0n0Biwrx+7lr7L5rThqlMnVA088NjvhUzFKejji32VClPRNLf6F/ w==;
IronPort-SDR: D0f0/TfpYQIn48Dh2EljyoZLQ+fdDE6IWgMNCddzlkIILCPeEc0SDtXyyMe0Z2ekEhj0wd7tLW
 5cM8/3Je3dTwfhok8syO3FAcDxQ56nWZvQVG8Kj4QCbHJcYjwvIOAkGn2MdjuD8gFnkovH1uEz
 NpFlhfXbw9X2NhT6BeGMKXl6M0G6M1d7PeeusrqBP+iOsx1HIXjFrNLCxySFNchXSppRVjthZr
 XfYUuvG8uFioB/NGWFV1s+3EdqrjIDO/z59x0K4md/51lbYFXjAEcVy5WDMScMcmVfz2ShYqEs
 iBc=
X-IronPort-AV: E=Sophos;i="5.78,407,1599494400"; d="scan'208";a="154878048"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 10 Dec 2020 14:26:42 +0800
IronPort-SDR: a3s1KrZsMczPTTOZn7drhxPFhY1/aK7S3y5auU1/3GJ9+Z1oJC6KCIxpAg7IyoKDkm1UyzakIl
 DjN92Z1ygaCdYcIqmbhTgnysBkA29wWV4=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Dec 2020 22:12:07 -0800
IronPort-SDR: w1jksuCIuWKi5JWwzzO+nSoRiDFART7RuUhOgLOGYvM2/vgyEusQKbl1EVmVjzOsstexwsQtuq
 FaGmV6ET2UBA==
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip01.wdc.com with ESMTP; 09 Dec 2020 22:26:43 -0800
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: [PATCH V5 1/6] block: export bio_add_hw_pages()
Date: Wed,  9 Dec 2020 22:26:17 -0800
Message-Id: <20201210062622.62053-2-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20201210062622.62053-1-chaitanya.kulkarni@wdc.com>
References: <20201210062622.62053-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201210_012645_114298_1BCB4287 
X-CRM114-Status: GOOD (  13.72  )
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
Cc: damien.lemoal@wdc.com, sagi@grimberg.me,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>, hch@lst.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

To implement the NVMe Zone Append command on the NVMeOF target side for
generic Zoned Block Devices with NVMe Zoned Namespaces interface, we
need to build the bios with hardware limitations, i.e. we use
bio_add_hw_page() with queue_max_zone_append_sectors() instead of
bio_add_page().

Without this API being exported NVMeOF target will require to use
bio_add_hw_page() caller bio_iov_iter_get_pages(). That results in
extra work which is inefficient.

Export the API so that NVMeOF ZBD over ZNS backend can use it to build
Zone Append bios.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 block/bio.c            | 1 +
 block/blk.h            | 4 ----
 include/linux/blkdev.h | 4 ++++
 3 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index fa01bef35bb1..eafd97c6c7fd 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -826,6 +826,7 @@ int bio_add_hw_page(struct request_queue *q, struct bio *bio,
 	bio->bi_iter.bi_size += len;
 	return len;
 }
+EXPORT_SYMBOL(bio_add_hw_page);
 
 /**
  * bio_add_pc_page	- attempt to add page to passthrough bio
diff --git a/block/blk.h b/block/blk.h
index e05507a8d1e3..1fdb8d5d8590 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -428,8 +428,4 @@ static inline void part_nr_sects_write(struct hd_struct *part, sector_t size)
 #endif
 }
 
-int bio_add_hw_page(struct request_queue *q, struct bio *bio,
-		struct page *page, unsigned int len, unsigned int offset,
-		unsigned int max_sectors, bool *same_page);
-
 #endif /* BLK_INTERNAL_H */
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 05b346a68c2e..2bdaa7cacfa3 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -2023,4 +2023,8 @@ int fsync_bdev(struct block_device *bdev);
 struct super_block *freeze_bdev(struct block_device *bdev);
 int thaw_bdev(struct block_device *bdev, struct super_block *sb);
 
+int bio_add_hw_page(struct request_queue *q, struct bio *bio,
+		struct page *page, unsigned int len, unsigned int offset,
+		unsigned int max_sectors, bool *same_page);
+
 #endif /* _LINUX_BLKDEV_H */
-- 
2.22.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
