Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DCC5C25B74
	for <linux-nvme@archiver.kernel.org>; Fri, 24 May 2024 06:18:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=1ZPCxDFIPoEAkgSnQKz5S0Lhl3cNyl+ZFiyUW3jUrmg=; b=aHTTdjRsN96K2Lr0NDbjVFC0h0
	eKD0iWTc9ksMlamVUJQuVSeFIsEGBG4kvo+884N6z2GQFhsEOy/bDRzgXqkpyO0tW4uOJQWnBoZC1
	6g8grh0IXxfLuzcChxaKWx2Kc0w+rz8hn/BLndkBUxTdNiW83Vo8zMU/f4ywDw2bi0EciZNH4LJwE
	MgnsCgUOqaPgYfSlykb5EE+4RMJuP3EuIU6TZXXBf4Drrtv1FEIB9C5IKbF9GY7cKbbbYTT/ffZnQ
	oB3AHZQfa47/lqGEAX90HQa0A2Oritk8NK+qZUK5tOb/sQKIz3Qvxm5r4u07gNJX5s6woyIPszP+A
	o1RFnFbQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sAOFw-00000008A8U-2laS;
	Fri, 24 May 2024 06:18:20 +0000
Received: from sin.source.kernel.org ([145.40.73.55])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sAOFu-00000008A82-1U8b
	for linux-nvme@lists.infradead.org;
	Fri, 24 May 2024 06:18:19 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 05823CE1867;
	Fri, 24 May 2024 06:18:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 833ADC2BBFC;
	Fri, 24 May 2024 06:18:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716531495;
	bh=/23+rbTCuXhKE3EBmZL7oKSwC8+hmT5Rj9RTr6KDSFs=;
	h=From:To:Cc:Subject:Date:From;
	b=j5cqvx3xSQkl/5s/TkDkG1io5oqz9rDbdYUa/EQg0B9VgEaDbgQg/dVN7e5cbr9Vk
	 Tl4txWJ2UWj47EzMIdXTSFoAHOE90C+mhZFyg0UWWl/2D1hhdb0qbrB64eGDGSn226
	 h+/gu+HGwYbLvzc109Y5FZyg2m6Fl9Nd64USuu9y1MEaNxZ9LKJB7fDc3pjwOq9MVM
	 9vGDeqCy5biUmjHTW/RGQaP3cWEOIEBRvV0MHePlELTetqmve/YTLiUglwfm1396X6
	 zWzzpeMqpub/Ea/Y4DIGwc60yHUFHU0Wib6llvsuLK5flJbbVu7WaWgLvolTGOMfNB
	 5frD4ZNYHcdTA==
From: Hannes Reinecke <hare@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Damien LeMoal <dlemoal@kernel.org>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@kernel.org>
Subject: [PATCHv2] nvme: fixup zns namespace initialisation
Date: Fri, 24 May 2024 08:18:08 +0200
Message-Id: <20240524061808.129399-1-hare@kernel.org>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240523_231818_592484_97E7C723 
X-CRM114-Status: GOOD (  10.83  )
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
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

nvme_set_chunk_sectors() needs to know whether it's a zoned namespace
or not, but the information is only set in a later call.
So move the calls around and ensure that the namespace is marked as
non-zoned initially to avoid calculation errors when trying to derive
a non-existing zone geometry.

Fixes: c85c9ab926a5 ("nvme: split nvme_update_zone_info")
Signed-off-by: Hannes Reinecke <hare@kernel.org>
---
 drivers/nvme/host/core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 111bf4197052..a968d33914a7 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2115,13 +2115,13 @@ static int nvme_update_ns_info_block(struct nvme_ns *ns,
 	lim = queue_limits_start_update(ns->disk->queue);
 	nvme_set_ctrl_limits(ns->ctrl, &lim);
 	nvme_configure_metadata(ns->ctrl, ns->head, id, nvm);
+	if (IS_ENABLED(CONFIG_BLK_DEV_ZONED) &&
+	    ns->head->ids.csi == NVME_CSI_ZNS)
+		nvme_update_zone_info(ns, &lim, &zi);
 	nvme_set_chunk_sectors(ns, id, &lim);
 	if (!nvme_update_disk_info(ns, id, &lim))
 		capacity = 0;
 	nvme_config_discard(ns, &lim);
-	if (IS_ENABLED(CONFIG_BLK_DEV_ZONED) &&
-	    ns->head->ids.csi == NVME_CSI_ZNS)
-		nvme_update_zone_info(ns, &lim, &zi);
 	ret = queue_limits_commit_update(ns->disk->queue, &lim);
 	if (ret) {
 		blk_mq_unfreeze_queue(ns->disk->queue);
-- 
2.35.3


