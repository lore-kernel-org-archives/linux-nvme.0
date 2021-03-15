Return-Path: <SRS0=15CP=IN=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAB48C433DB
	for <linux-nvme@archiver.kernel.org>; Mon, 15 Mar 2021 09:37:16 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E240464E74
	for <linux-nvme@archiver.kernel.org>; Mon, 15 Mar 2021 09:37:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E240464E74
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=a30mqqw5jdNxoUCFlJaN5O1yNWP3QCQDP4mg/5BMnAA=; b=bX3BBHiwEl59KCmJ+GonxCCHCd
	pxTqEI65xZ7dtTOhrhOYUsiXwTIhhJZwPGIuYORcgCKvYPf8L9lLEl5VG4Dq1rZe4TQwhRpQo6J/L
	XDx8QoJuhIDJYbeKDIGv+SNiwkhEEkxXs9PsvLXjFtQkkgewwBy71d6kL+XGGciRHzR1HRpuNbjDY
	NMj4SHEILyoROZTgSIplabDjQxr0SvD+6WFf9sjNdl9S0EKw0ifKYJxMZJW8HXA2HlI5Atw7UzRZX
	iiZxcM2gs8EP0af44ktOo0q8FT2KycJaBKi1frb00v0wax2QO1cqwoVrzdkO4pWy0sd0xOzBUCQve
	O6X3whbg==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lLjeq-00FP5F-0f; Mon, 15 Mar 2021 09:37:04 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lLjef-00FP4l-Cf
 for linux-nvme@desiato.infradead.org; Mon, 15 Mar 2021 09:36:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:In-Reply-To:References;
 bh=iePYYEW79Es+7PnEcKj7U6kR/9F9knC2YeFUvh/iVmk=; b=cszuG354V3xu/CXSaKiIFCZgM0
 FMoi6bm9epj5hgXpwFP7jX1afONwBGoTEP2DXKRSPEZR5EqOVX8seAWxeHK9BJvtmwXyjliqFKBlJ
 Elrq46zArbrhuqbvGjAt5Yyad4SBxoFX8IbAEkAzMeAmHPqPK0PNCrGdEWax6ZRcIP0mRoBs5eGri
 dqRD7AF/ChfTlLxxomw117lADPJGRu3/POmqZSS5AzPcwHCmhFWQLpkEOXF9YuPWMOX+ttTgZ5RsX
 MKQc6xkwiCwukbEqfRfrToeujFo5lr/Qy8IRsU9GE064/2aXQ/MTJ37j/3Y6K/Sj9+uVYspoEhyC9
 pV9uzzxw==;
Received: from 089144199244.atnat0008.highway.a1.net ([89.144.199.244]
 helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
 id 1lLjeb-00HWNI-34; Mon, 15 Mar 2021 09:36:50 +0000
From: Christoph Hellwig <hch@lst.de>
To: keith.busch@wdc.com,
	sagi@grimberg.me
Cc: linux-nvme@lists.infradead.org
Subject: [PATCH] nvme: fix Write Zeroes limitations
Date: Mon, 15 Mar 2021 10:34:38 +0100
Message-Id: <20210315093438.66082-1-hch@lst.de>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

We voluntarily limit the Write Zeroes sizes to the MDTS value provided by
the hardware, but currently get the units wrong, so fix that.

Fixes: 6e02318eaea5 ("nvme: add support for the Write Zeroes command")
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/host/core.c | 36 ++++++++++++------------------------
 1 file changed, 12 insertions(+), 24 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 82ad5eef9d0c30..1bd18d7f53b316 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1964,30 +1964,18 @@ static void nvme_config_discard(struct gendisk *disk, struct nvme_ns *ns)
 		blk_queue_max_write_zeroes_sectors(queue, UINT_MAX);
 }
 
-static void nvme_config_write_zeroes(struct gendisk *disk, struct nvme_ns *ns)
+/*
+ * Even though NVMe spec explicitly states that MDTS is not applicable to the
+ * write-zeroes, we are cautious and limit the size to the controllers
+ * max_hw_sectors value, which is based on the MDTS field and possibly other
+ * limiting factors.
+ */
+static void nvme_config_write_zeroes(struct request_queue *q,
+		struct nvme_ctrl *ctrl)
 {
-	u64 max_blocks;
-
-	if (!(ns->ctrl->oncs & NVME_CTRL_ONCS_WRITE_ZEROES) ||
-	    (ns->ctrl->quirks & NVME_QUIRK_DISABLE_WRITE_ZEROES))
-		return;
-	/*
-	 * Even though NVMe spec explicitly states that MDTS is not
-	 * applicable to the write-zeroes:- "The restriction does not apply to
-	 * commands that do not transfer data between the host and the
-	 * controller (e.g., Write Uncorrectable ro Write Zeroes command).".
-	 * In order to be more cautious use controller's max_hw_sectors value
-	 * to configure the maximum sectors for the write-zeroes which is
-	 * configured based on the controller's MDTS field in the
-	 * nvme_init_identify() if available.
-	 */
-	if (ns->ctrl->max_hw_sectors == UINT_MAX)
-		max_blocks = (u64)USHRT_MAX + 1;
-	else
-		max_blocks = ns->ctrl->max_hw_sectors + 1;
-
-	blk_queue_max_write_zeroes_sectors(disk->queue,
-					   nvme_lba_to_sect(ns, max_blocks));
+	if ((ctrl->oncs & NVME_CTRL_ONCS_WRITE_ZEROES) &&
+	    !(ctrl->quirks & NVME_QUIRK_DISABLE_WRITE_ZEROES))
+		blk_queue_max_write_zeroes_sectors(q, ctrl->max_hw_sectors);
 }
 
 static bool nvme_ns_ids_valid(struct nvme_ns_ids *ids)
@@ -2159,7 +2147,7 @@ static void nvme_update_disk_info(struct gendisk *disk,
 	set_capacity_and_notify(disk, capacity);
 
 	nvme_config_discard(disk, ns);
-	nvme_config_write_zeroes(disk, ns);
+	nvme_config_write_zeroes(disk->queue, ns->ctrl);
 
 	set_disk_ro(disk, (id->nsattr & NVME_NS_ATTR_RO) ||
 		test_bit(NVME_NS_FORCE_RO, &ns->flags));
-- 
2.30.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
