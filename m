Return-Path: <SRS0=qmg+=6S=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F318C3A5A9
	for <linux-nvme@archiver.kernel.org>; Mon,  4 May 2020 15:58:28 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D302F20705
	for <linux-nvme@archiver.kernel.org>; Mon,  4 May 2020 15:58:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="MgGH7XR/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D302F20705
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=6cSE/zbFPDI2wOF2ZDVPgh7M9HrZefZh1jnnihIIKrA=; b=MgGH7XR/YaNM3C
	lrFHN03p4NnlagiQM3I/Rk5PVAhUqjTGHg5vhmernfSG2929ykOaTOxbBz2MMmI+bFPzusccSJ3nB
	k3dcud2x9snABUPhfkbV0eneiCqnSYqjANrR8GgovoylnOJw6IA5pBcQTHZF+0ljGmPFQZDznNN2U
	U2SsKl34hedXctPTJI3feHmMZ8eQinGXJcBBR52brNufH2mM6rUHLLBVVj/AKMZFZvJLjzrJvLWGj
	jAC8plySDamMifAYrc26Kh0aqlv99wSUgK02hBWKJzCTRQ/1OLbD5VOhVAgiDcgrOLG0jRzcnhSNu
	/CvCT+3Ku73cHWxbw80w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jVdU8-0001KP-Gm; Mon, 04 May 2020 15:58:24 +0000
Received: from mail-il-dmz.mellanox.com ([193.47.165.129] helo=mellanox.co.il)
 by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jVdTo-0000yx-Tt
 for linux-nvme@lists.infradead.org; Mon, 04 May 2020 15:58:08 +0000
Received: from Internal Mail-Server by MTLPINE2 (envelope-from
 maxg@mellanox.com)
 with ESMTPS (AES256-SHA encrypted); 4 May 2020 18:57:55 +0300
Received: from mtr-vdi-031.wap.labs.mlnx. (mtr-vdi-031.wap.labs.mlnx
 [10.209.102.136])
 by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id 044FvtCD017882;
 Mon, 4 May 2020 18:57:55 +0300
From: Max Gurtovoy <maxg@mellanox.com>
To: maxg@mellanox.com, linux-nvme@lists.infradead.org, kbusch@kernel.org,
 hch@lst.de, sagi@grimberg.me, martin.petersen@oracle.com,
 jsmart2021@gmail.com, axboe@kernel.dk
Subject: [PATCH 01/16] block: always define struct blk_integrity in genhd.h
Date: Mon,  4 May 2020 18:57:40 +0300
Message-Id: <20200504155755.221125-2-maxg@mellanox.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200504155755.221125-1-maxg@mellanox.com>
References: <20200504155755.221125-1-maxg@mellanox.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200504_085805_406319_DD936DEB 
X-CRM114-Status: UNSURE (   7.35  )
X-CRM114-Notice: Please train this message.
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
 idanb@mellanox.com, oren@mellanox.com, nitzanc@mellanox.com
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
---
 include/linux/genhd.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/include/linux/genhd.h b/include/linux/genhd.h
index 058d895..8418581 100644
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
