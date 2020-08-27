Return-Path: <SRS0=+fzK=CF=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76A3FC433E1
	for <linux-nvme@archiver.kernel.org>; Thu, 27 Aug 2020 15:28:38 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 43F912080C
	for <linux-nvme@archiver.kernel.org>; Thu, 27 Aug 2020 15:28:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="g3SOLjpb";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="qwOAWMxd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43F912080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=WrJ2lEpwxy2Y3S2DOeal2wK/Hh7jZOh7akNOfkVusds=; b=g3SOLjpbA8W/+1lhbjQK4e57oZ
	y/hCdQfPc2DIWh7AM9Pbii+PhgIcKOG27aCDvZkGry3q0JbJ1ZUiVc/FId/rIydW8WzlrTBBbjJlb
	r6iSS+H0e+zgq+0ZjAOy/mXSoavWCKZRwGa/LmbXwamPccB8jFYwsUJa83n8BIXWt2axh54NbB5+j
	U85abBcR19sLihydU/HBeNM4fKH4RDOzJq/86F1/lKdFK6ukCH+Mpf2d1Nr6C3C4vJlbYxkwIZ3IY
	/uz+2yktpYk2PrTEa/aRV0QBlMdRihyZlxrGKWDdJaNEmoGt+Z4t8KVGZ3HIS8R0QQdCfzqxbQOYQ
	DCEb+p+w==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kBJpJ-0004m9-2M; Thu, 27 Aug 2020 15:28:33 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kBJpF-0004lh-WA
 for linux-nvme@lists.infradead.org; Thu, 27 Aug 2020 15:28:30 +0000
Received: from dhcp-10-100-145-180.wdl.wdc.com (unknown [199.255.45.60])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id C6B6E2080C;
 Thu, 27 Aug 2020 15:28:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1598542109;
 bh=XTU8a1+sBKC54pr6G3HoSG3LN8+S+TH07uC2gKyLvlY=;
 h=From:To:Cc:Subject:Date:From;
 b=qwOAWMxd4jXrpOd3wRLXkiLA5cEmXXDfm/HjzejahwDGAlpR3LXSZc53ezvH7+tmL
 0+2zJXbPfIKLG1aYI5XdC15wTXbj6IKmrB4cmGbYfs3HJxB8Mgr/WzBEl2WLtp8Bow
 RfLhB6uHKWt/3jArMUo91hllvTGsIYH4fekHponk=
From: Keith Busch <kbusch@kernel.org>
To: linux-nvme@lists.infradead.org,
	sagi@grimberg.me,
	hch@lst.de
Subject: [PATCHv2] nvme: only use power of two io boundaries
Date: Thu, 27 Aug 2020 08:28:24 -0700
Message-Id: <20200827152824.2784396-1-kbusch@kernel.org>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200827_112830_097271_5BE79F6E 
X-CRM114-Status: GOOD (  14.38  )
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
Cc: Keith Busch <kbusch@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

The kernel requires a power of two for boundaries because that's the
only way it can efficiently split commands that cross them. A
controller, however, may report a non-power of two boundary.

The driver had been rounding the controller's value to one the kernel
can use, but splitting on the wrong boundary provides no benefit on the
device side, and actually incurs additional submission overhead from
non-optimal splits. Don't provide any boundary hint if the controller's
value can't be used and log a warning when initially observing a disk's
unreported io boundary.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
v1->v2:

  Warn for the namespace with unusable io boundary.

 drivers/nvme/host/core.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 154942fc64eb..9bbbd600621f 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2097,8 +2097,12 @@ static int __nvme_revalidate_disk(struct gendisk *disk, struct nvme_id_ns *id)
 		}
 	}
 
-	if (iob && !blk_queue_is_zoned(ns->queue))
-		blk_queue_chunk_sectors(ns->queue, rounddown_pow_of_two(iob));
+	if (is_power_of_2(iob) && !blk_queue_is_zoned(ns->queue))
+		blk_queue_chunk_sectors(ns->queue, iob);
+	else if (iob && !(disk->flags & GENHD_FL_UP))
+		dev_warn(ctrl->device, "namespace:%u has unused io boundary:%u\n",
+			ns->head->ns_id, iob);
+
 	nvme_update_disk_info(disk, ns, id);
 #ifdef CONFIG_NVME_MULTIPATH
 	if (ns->head->disk) {
-- 
2.24.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
