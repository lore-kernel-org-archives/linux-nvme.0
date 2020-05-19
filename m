Return-Path: <SRS0=SbN/=7B=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D71BEC433DF
	for <linux-nvme@archiver.kernel.org>; Tue, 19 May 2020 15:15:36 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E3732081A
	for <linux-nvme@archiver.kernel.org>; Tue, 19 May 2020 15:15:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="KmTNVYDV";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="T69ukPV2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E3732081A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=2OwOnHRTxN0EMAX054TIFeE24j44zcExjhUIJdcXRlo=; b=KmTNVYDViz+5NB
	3a6bIS86ho/LuDMFRGOSrRKKLX5sfhmXvgCeH61+kMjgv+w4BlgizCU7i4L4FOHEWtTXZB6NRNHfE
	lyyBuwyyHef/DI3OI1w8VbjeR9DlxNNgNFsKcS3Qs8VxzB1lEMBL7KYpyIsy5vgYKjStAtaD+dd17
	+r3Ph6Hgr7Crg3YbXrdarw1zorfVS4dd1aZM4XOxkU7Efprj/dtmIinDOMWHRyPScwdg9cKVXfyS6
	5Qknv8NLz7iwVOR2M5BxwVsJ0G1m1x1QFT9tskzHY+Sw89DTvQXo1Qx6W84DjEXQsPKhLxHX5VN+h
	ddiOLNEgvBGS58ZY4qQA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jb3xs-0003zu-LY; Tue, 19 May 2020 15:15:32 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jb2sz-0001cE-G0
 for linux-nvme@bombadil.infradead.org; Tue, 19 May 2020 14:06:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description;
 bh=NU9DLz5ZX6hquvJcn/VyKQ4yciOp3h+TOMo32Fh91Zs=; b=T69ukPV2gMXblORTH9hKz5w3cM
 wGDmaX85x9PvX36cGam0uaR6QrDW5MTMRtVDKEyoj8/xqjOG9M9KvnRypyudL82LSNIkGzlwtavUM
 voAaScy38twohy4S2MOmX35tlDts3jUCYpFo++bsWvG5dmFoJoE73MSe68eN1Y1+SdYAOZqV0oRcD
 i+KUrbI4U6EoF7AvEwdxdaYkVQ9kH/Xxy2xDGfUFPV+9Jr0WbiukoHLWhWANzrDTnq/PFo/Zf/jMD
 VucVG1NCkzNYeDioWPZ0jty9gMWRLgY83cereTbaQJ2c8wn79AAvGXZSZhwHUzyqHmnvoBweZr3L+
 C8c12seQ==;
Received: from mail-il-dmz.mellanox.com ([193.47.165.129] helo=mellanox.co.il)
 by casper.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jb2so-0004Wc-DV
 for linux-nvme@lists.infradead.org; Tue, 19 May 2020 14:06:24 +0000
Received: from Internal Mail-Server by MTLPINE1 (envelope-from
 maxg@mellanox.com)
 with ESMTPS (AES256-SHA encrypted); 19 May 2020 17:06:03 +0300
Received: from mtr-vdi-031.wap.labs.mlnx. (mtr-vdi-031.wap.labs.mlnx
 [10.209.102.136])
 by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id 04JE63xi006590;
 Tue, 19 May 2020 17:06:03 +0300
From: Max Gurtovoy <maxg@mellanox.com>
To: sagi@grimberg.me, linux-nvme@lists.infradead.org, kbusch@kernel.org,
 hch@lst.de, martin.petersen@oracle.com, jsmart2021@gmail.com,
 axboe@kernel.dk
Subject: [PATCH 01/16] block: always define struct blk_integrity in genhd.h
Date: Tue, 19 May 2020 17:05:48 +0300
Message-Id: <20200519140603.166576-2-maxg@mellanox.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200519140603.166576-1-maxg@mellanox.com>
References: <20200519140603.166576-1-maxg@mellanox.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200519_150616_146516_D3503AF1 
X-CRM114-Status: GOOD (  10.32  )
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
Cc: vladimirk@mellanox.com, shlomin@mellanox.com, israelr@mellanox.com,
 idanb@mellanox.com, oren@mellanox.com, Max Gurtovoy <maxg@mellanox.com>,
 nitzanc@mellanox.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

This will reduce the amount of ifdefs inside the source code for various
drivers and also will reduce the amount of stub functions that were
created for the !CONFIG_BLK_DEV_INTEGRITY case.

Suggested-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Max Gurtovoy <maxg@mellanox.com>
Reviewed-by: Israel Rukshin <israelr@mellanox.com>
Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
---
 include/linux/genhd.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/include/linux/genhd.h b/include/linux/genhd.h
index f9c226f..2590bed 100644
--- a/include/linux/genhd.h
+++ b/include/linux/genhd.h
@@ -169,8 +169,6 @@ struct disk_part_tbl {
 struct disk_events;
 struct badblocks;
 
-#if defined(CONFIG_BLK_DEV_INTEGRITY)
-
 struct blk_integrity {
 	const struct blk_integrity_profile	*profile;
 	unsigned char				flags;
@@ -179,8 +177,6 @@ struct blk_integrity {
 	unsigned char				tag_size;
 };
 
-#endif	/* CONFIG_BLK_DEV_INTEGRITY */
-
 struct gendisk {
 	/* major, first_minor and minors are input parameters only,
 	 * don't use directly.  Use disk_devt() and disk_max_parts().
-- 
1.8.3.1


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
