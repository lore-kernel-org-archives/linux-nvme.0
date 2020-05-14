Return-Path: <SRS0=zrHs=64=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B60BC433E0
	for <linux-nvme@archiver.kernel.org>; Thu, 14 May 2020 06:05:35 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D87520575
	for <linux-nvme@archiver.kernel.org>; Thu, 14 May 2020 06:05:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="rjoxyZph"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D87520575
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=nc9FZ/0X9czLAlrlgBMd4VyJ7pTTLjriiIrgBdls/+c=; b=rjo
	xyZphS9ziyt8tQ2IIa9CiffW7ggWPxUOOc7ZhzgGtHHFzzYCeLPVEHM8FjK0aQ28N5YndPSSh2r45
	kXl+i+PJ7EUUJH75nfEFpCNGfzs6FslOiJbHgwI/CfNgpcdzIBOCrcU408Wzgxi6+p2fFIB7Rg2lk
	XOgbWvdmZKhHoiLP4GCks+SEWYX+hDrBIVN1NgghQiNG3vSKM1JJU7MTcdo4NpJWPp6H3fEprepzk
	aSI/lLsMzNUaZQ0YzET6K9LaEpV4Rx0oLEm9FKRdUfv17TTD3GLwyEDRHOqZlbT+7XHqtbpwzFyrO
	eIorcFsD1VqSREc5j8PwAAVipvgbiLQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jZ6zr-0004MA-WA; Thu, 14 May 2020 06:05:32 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jZ6zo-0004LW-1M
 for linux-nvme@lists.infradead.org; Thu, 14 May 2020 06:05:31 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 3BDEAACFA;
 Thu, 14 May 2020 06:05:24 +0000 (UTC)
From: Hannes Reinecke <hare@suse.de>
To: Christoph Hellwig <hch@lst.de>
Subject: [PATCH] nvme: set 'io_opt' to '0' if not specified
Date: Thu, 14 May 2020 08:05:14 +0200
Message-Id: <20200514060514.85309-1-hare@suse.de>
X-Mailer: git-send-email 2.16.4
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200513_230529_837939_4BFF6F95 
X-CRM114-Status: GOOD (  13.20  )
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
Cc: Damien LeMoal <damien.lemoal@wdc.com>, Mike Snitzer <snitzer@redhat.com>,
 Keith Busch <keith.busch@wdc.com>, linux-nvme@lists.infradead.org,
 Hannes Reinecke <hare@suse.de>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Sagi Grimberg <sagi@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

When no optimal I/O size is report we should set the value of
io_opt to '0', not the block size.
This avoids any potential miscalculation of the block limits
for stacking devices.

Reported-by: Damien LeMoal <damien.lemoal@wdc.com>
Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/nvme/host/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index a4d8c90ee7cc..6a8a8e749d11 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1785,12 +1785,12 @@ static void nvme_update_disk_info(struct gendisk *disk,
 		atomic_bs = bs;
 	}
 	phys_bs = bs;
-	io_opt = bs;
+	io_opt = 0;
 	if (id->nsfeat & (1 << 4)) {
 		/* NPWG = Namespace Preferred Write Granularity */
 		phys_bs *= 1 + le16_to_cpu(id->npwg);
 		/* NOWS = Namespace Optimal Write Size */
-		io_opt *= 1 + le16_to_cpu(id->nows);
+		io_opt = bs * 1 + le16_to_cpu(id->nows);
 	}
 
 	blk_queue_logical_block_size(disk->queue, bs);
-- 
2.16.4


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
