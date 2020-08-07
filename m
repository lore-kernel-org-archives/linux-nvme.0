Return-Path: <SRS0=rw3x=BR=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C352C433E0
	for <linux-nvme@archiver.kernel.org>; Fri,  7 Aug 2020 16:32:44 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5777320748
	for <linux-nvme@archiver.kernel.org>; Fri,  7 Aug 2020 16:32:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="hMBxxCY9";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="NwfaAEnw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5777320748
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=Ay4QYwHsq1uorJqFrz6vyou7HuFBU3RAqZAjGUWCrPQ=; b=hMBxxCY9wOR1D6s5CTm7I7r2Dl
	nxwiNHx9KFpDfU1ffBvK3vpQ/Y8Dqz0SC46dF5Dbz8u6D931TkrEIqco1JVfuscqy//6kSxbZA8Og
	pXvEewiVVCpnqKdcwFAW2YNS+Rm22DVbyzqRxt9Pwh3jgi4MDZhsBcwL0+X2KBejpuPFnc/TGhuZF
	5rFG4b2OHiyXr0bvqsTKY9mt62IgdxzdpIVsGYUSD7pjcAKabazE3ih4/nbw/+VyBb3GsrMZSJoK3
	pNJejVfETcpe61/g5VSgtQiSpiQzO/uwUSchLmihrV6aM2r35OLuHFfiBrmyEXdVi+GBLBSbDGVSb
	NCD3AYxg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k45IP-00056D-E4; Fri, 07 Aug 2020 16:32:41 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k45IL-00054P-RI
 for linux-nvme@lists.infradead.org; Fri, 07 Aug 2020 16:32:39 +0000
Received: from dhcp-10-100-145-180.wdl.wdc.com (unknown [199.255.45.60])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id B229A20748;
 Fri,  7 Aug 2020 16:32:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1596817957;
 bh=wMO8xJTCdWPgq4R6vYBsX2M78nEmm/VFiA4aCpi99RU=;
 h=From:To:Cc:Subject:Date:From;
 b=NwfaAEnwwis3M4ZTeWuaZTV0KFvqfN5MRQX02TFHRJNaG+6qzMv8uQ8jlt1YW3+Vv
 ddsDCmFlm9PWafWa1IIBexd8ne8BjSEM4BVVQqTwZ+OUMkMDyQHUjsjaBXhWN2FBar
 ud4Px5CTQPhGyxgpnBbNuunbLhCRfGF0R+dmnmB0=
From: Keith Busch <kbusch@kernel.org>
To: linux-nvme@lists.infradead.org,
	hch@lst.de,
	sagi@grimberg.me
Subject: [PATCHv2] nvme: skip noiob for zoned devices
Date: Fri,  7 Aug 2020 09:32:35 -0700
Message-Id: <20200807163235.4155607-1-kbusch@kernel.org>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200807_123238_022026_3ED7109F 
X-CRM114-Status: GOOD (  13.10  )
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

Zoned block devices reuse the chunk_sectors queue limit to define zone
boundaries. If a such a device happens to also report an optimal
boundary, do not use that to define the chunk_sectors as that may
intermittently interfere with io splitting and zone size queries.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
v1->v2: Fixed the if condition to check for *not* zoned.

 drivers/nvme/host/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 88cff309d8e4..4e0225d85e70 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2075,7 +2075,7 @@ static int __nvme_revalidate_disk(struct gendisk *disk, struct nvme_id_ns *id)
 		}
 	}
 
-	if (iob)
+	if (iob && !blk_queue_is_zoned(ns->queue))
 		blk_queue_chunk_sectors(ns->queue, rounddown_pow_of_two(iob));
 	nvme_update_disk_info(disk, ns, id);
 #ifdef CONFIG_NVME_MULTIPATH
-- 
2.24.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
