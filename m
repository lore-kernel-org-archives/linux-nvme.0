Return-Path: <SRS0=CEZP=BQ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35410C433E1
	for <linux-nvme@archiver.kernel.org>; Thu,  6 Aug 2020 13:20:24 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2CC292073E
	for <linux-nvme@archiver.kernel.org>; Thu,  6 Aug 2020 13:20:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="WU16qgLI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CC292073E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=DWh1nl9piuMZQNcQatTosBB3SWMIkG5PhiRmBZX5clc=; b=WU16qgLIrno4K4+8RrK2EUksb
	7qP60jKUCuJKduZncp3pUK5ffdzlcZA3D14c0ZLSaJ05/tvVO2Oe2s/K4QJKXkq+6FF9Rueqc7AA8
	Wt83ON4H0GQplkiRr04pDYD1iZ7igZQU5znqOYqDoNoHR8UfGNHrUAMRGdVURCVfA7s0ua+s4Iz0e
	gFVXpwg2cZwOxHN4N94bm7qSx84whWnT3WFl/4lW4zlGkEsepO8WN2YI2zDXdyIxfsdgj8L+hyXhl
	wwGBB1mBLDfu0zvVZe8qOcqPmunCJ3XDdlxC/iihSSR2LmVgZu20Wq55oOS2WCa3J35/RFU1rba5r
	BVQkCFDxw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k3foe-00034C-ND; Thu, 06 Aug 2020 13:20:16 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k3fob-00032w-95
 for linux-nvme@lists.infradead.org; Thu, 06 Aug 2020 13:20:14 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id CC03EB6CC;
 Thu,  6 Aug 2020 13:20:27 +0000 (UTC)
From: mwilck@suse.com
To: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
 Sagi Grimberg <sagi@grimberg.me>
Subject: [PATCH 1/2] nvme: multipath: round-robin: fix single non-optimized
 path case
Date: Thu,  6 Aug 2020 15:19:31 +0200
Message-Id: <20200806131932.20017-2-mwilck@suse.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200806131932.20017-1-mwilck@suse.com>
References: <20200806131932.20017-1-mwilck@suse.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200806_092013_426320_282C3B69 
X-CRM114-Status: GOOD (  16.82  )
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
Cc: Martin George <marting@netapp.com>, Hannes Reinecke <hare@suse.de>,
 linux-nvme@lists.infradead.org, Martin Wilck <mwilck@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

From: Martin Wilck <mwilck@suse.com>

If there's only one usable, non-optimized path, nvme_round_robin_path()
returns NULL, which is wrong. Fix it by falling back to "old", like in
the single optimized path case. Also, if the active path isn't changed,
there's no need to re-assign the pointer.

Fixes: 3f6e3246db0e ("nvme-multipath: fix logic for non-optimized paths")
Signed-off-by: Martin Wilck <mwilck@suse.com>
Reported-by: Martin George <marting@netapp.com>
---
 drivers/nvme/host/multipath.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 3ded54d2c9c6..a64dfff0d0ce 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -255,12 +255,17 @@ static struct nvme_ns *nvme_round_robin_path(struct nvme_ns_head *head,
 			fallback = ns;
 	}
 
-	/* No optimized path found, re-check the current path */
+	/*
+	 * The loop above skips the current path for round-robin semantics.
+	 * Fall back to the current path if either:
+	 *  - no other optimized path found and current is optimized,
+	 *  - no other usable path found and current is usable.
+	 */
 	if (!nvme_path_is_disabled(old) &&
-	    old->ana_state == NVME_ANA_OPTIMIZED) {
-		found = old;
-		goto out;
-	}
+	    (old->ana_state == NVME_ANA_OPTIMIZED ||
+	     (!fallback && old->ana_state == NVME_ANA_NONOPTIMIZED)))
+		return old;
+
 	if (!fallback)
 		return NULL;
 	found = fallback;
-- 
2.28.0


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
