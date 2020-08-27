Return-Path: <SRS0=+fzK=CF=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10687C433DF
	for <linux-nvme@archiver.kernel.org>; Thu, 27 Aug 2020 17:39:10 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE2A22087E
	for <linux-nvme@archiver.kernel.org>; Thu, 27 Aug 2020 17:39:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="2TE9Jmgd";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="K7TObsEH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE2A22087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=WQEo8c/s/fTMgMlR0u2SJyeQgqbNO2IxPZN53g+C+14=; b=2TE9Jmgd5obwDdeBRr9Dlgzi1w
	qXwN6f+TO5Lu7tX2FO7rmneQ1QyufLetpmbXhsai1yQ5O8uwDrxzk80WvkIWsBH2VWVIjTP6WghaO
	rOnAZPPp6YECneO9QbGdB7YpncQElE+r3I2AJBTvI5mcfzGkH3BucnyXdZIurhU7XbYj1xdPRcD9Y
	jktxFoUFojdd7lT8EyLhWFAPfUu79t5oT9S8cFtXm8+gxW8t9h1MjyJZJmJCD51GIA8Pgvc5Oeg+V
	L8H/d4XfkUCXwisT3VZLp/T5nrivnsg1cwkG+AatDcdIOwE1omY0s4xhbowkDrvUclslQrff/2vrC
	0fOqCYmg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kBLra-0002jT-I0; Thu, 27 Aug 2020 17:39:03 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kBLrX-0002iw-F8
 for linux-nvme@lists.infradead.org; Thu, 27 Aug 2020 17:39:00 +0000
Received: from dhcp-10-100-145-180.wdl.wdc.com (unknown [199.255.45.60])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 4D86E2087E;
 Thu, 27 Aug 2020 17:38:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1598549938;
 bh=0CdIb2FTmC/a6X1HaULszosBlnfWh8iRl0FRmtr2+u4=;
 h=From:To:Cc:Subject:Date:From;
 b=K7TObsEHvhaVWx5MsbhxMO3xBUz240gsIdPQ7SWeWopuB9Ta5j7W6bHPQRzVeCLOy
 O8pb3ZPuD8+8lkSFY4h9m3hq9ISLzqFJtGrFBQuZPGMKB/Vq4UCow2SiZ/XryL2qKb
 /LkhoqMN8x6EUN4L6cLi74A9OWCUQMV6YIynxjts=
From: Keith Busch <kbusch@kernel.org>
To: linux-nvme@lists.infradead.org,
	sagi@grimberg.me,
	hch@lst.de
Subject: [PATCHv3] nvme: only use power of two io boundaries
Date: Thu, 27 Aug 2020 10:38:57 -0700
Message-Id: <20200827173857.2825087-1-kbusch@kernel.org>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200827_133859_658292_28300339 
X-CRM114-Status: GOOD (  17.25  )
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
Cc: Keith Busch <kbusch@kernel.org>,
 "Martin K . Petersen" <martin.petersen@oracle.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

The kernel requires a power of two for boundaries because that's the
only way it can efficiently split commands that cross them. A
controller, however, may report a non-power of two boundary.

The driver had been rounding the controller's value to one the kernel
can use, but splitting on the wrong boundary provides no benefit on the
device side, and incurs additional submission overhead from non-optimal
splits.

Don't provide any boundary hint if the controller's value can't be used
and log a warning when first scanning a disk's unreported IO boundary.
Since the chunk sector logic has grown, move it to a separate function.

Cc: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Keith Busch <kbusch@kernel.org>
---
v2->v3:

  Refactor the chunk sector handling to a separate function

 drivers/nvme/host/core.c | 47 ++++++++++++++++++++++++++++++++--------
 1 file changed, 38 insertions(+), 9 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 154942fc64eb..30f7b4238388 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2026,13 +2026,49 @@ static void nvme_update_disk_info(struct gendisk *disk,
 	blk_mq_unfreeze_queue(disk->queue);
 }
 
+static inline bool nvme_first_scan(struct gendisk *disk)
+{
+	/* nvme_alloc_ns() scans the disk prior to adding it */
+	return !(disk->flags & GENHD_FL_UP);
+}
+
+static void nvme_set_chunk_sectors(struct nvme_ns *ns, struct nvme_id_ns *id)
+{
+	struct nvme_ctrl *ctrl = ns->ctrl;
+	u32 iob;
+
+	if ((ctrl->quirks & NVME_QUIRK_STRIPE_SIZE) &&
+	    is_power_of_2(ctrl->max_hw_sectors))
+		iob = ctrl->max_hw_sectors;
+	else
+		iob = nvme_lba_to_sect(ns, le16_to_cpu(id->noiob));
+
+	if (!iob)
+		return;
+
+	if (!is_power_of_2(iob)) {
+		if (nvme_first_scan(ns->disk))
+			pr_warn("%s: ignoring unaligned IO boundary:%u\n",
+				ns->disk->disk_name, iob);
+		return;
+	}
+
+	if (blk_queue_is_zoned(ns->disk->queue)) {
+		if (nvme_first_scan(ns->disk))
+			pr_warn("%s: ignoring zoned namespace IO boundary\n",
+				ns->disk->disk_name);
+		return;
+	}
+
+	blk_queue_chunk_sectors(ns->queue, iob);
+}
+
 static int __nvme_revalidate_disk(struct gendisk *disk, struct nvme_id_ns *id)
 {
 	unsigned lbaf = id->flbas & NVME_NS_FLBAS_LBA_MASK;
 	struct nvme_ns *ns = disk->private_data;
 	struct nvme_ctrl *ctrl = ns->ctrl;
 	int ret;
-	u32 iob;
 
 	/*
 	 * If identify namespace failed, use default 512 byte block size so
@@ -2060,12 +2096,6 @@ static int __nvme_revalidate_disk(struct gendisk *disk, struct nvme_id_ns *id)
 		return -ENODEV;
 	}
 
-	if ((ctrl->quirks & NVME_QUIRK_STRIPE_SIZE) &&
-	    is_power_of_2(ctrl->max_hw_sectors))
-		iob = ctrl->max_hw_sectors;
-	else
-		iob = nvme_lba_to_sect(ns, le16_to_cpu(id->noiob));
-
 	ns->features = 0;
 	ns->ms = le16_to_cpu(id->lbaf[lbaf].ms);
 	/* the PI implementation requires metadata equal t10 pi tuple size */
@@ -2097,8 +2127,7 @@ static int __nvme_revalidate_disk(struct gendisk *disk, struct nvme_id_ns *id)
 		}
 	}
 
-	if (iob && !blk_queue_is_zoned(ns->queue))
-		blk_queue_chunk_sectors(ns->queue, rounddown_pow_of_two(iob));
+	nvme_set_chunk_sectors(ns, id);
 	nvme_update_disk_info(disk, ns, id);
 #ifdef CONFIG_NVME_MULTIPATH
 	if (ns->head->disk) {
-- 
2.24.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
