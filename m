Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23695C433FE
	for <linux-nvme@archiver.kernel.org>; Tue,  1 Feb 2022 19:02:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wziSKiUNPiCMmJZ4Pb9zHTKfpMpgK93z7lnQtngVPeg=; b=FBclDmx39WiY3bGEgFQNFpzcX8
	vpnglHTz//I3QDBWXdHn0nCVYwpbJWzecnFJE8w4i9kCnpdfOhU1s4jhyRZ4ILrE6s6V2DAfFzOal
	ZB10sGyh9Z79RNbmVgX6KQo9eKI+qfUz+KKOkAxIRE/iQIiSBH7FPzAZ5v+9ZP5itFSisjuTdQsGO
	/4C6PRE8JW2Dgq3H8H9c8++ErGZ1eLnDVii2wjZliRLbEBUB609aGSwNFf6FjFwi0xdJJvEOcHraG
	OLfk5C8mkCw9f6A+T3nn0/DBzurPtwN4SNKGwOjORod86Y2Kb83NYrDG7u7yoFxaLuy1zLzvKsRwP
	1aUg1GoA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nEyPd-00DSpf-Jw; Tue, 01 Feb 2022 19:01:57 +0000
Received: from ams.source.kernel.org ([145.40.68.75])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nEyPI-00DSeX-3m
 for linux-nvme@lists.infradead.org; Tue, 01 Feb 2022 19:01:37 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id DCA65B82F6B;
 Tue,  1 Feb 2022 19:01:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C45A5C340F2;
 Tue,  1 Feb 2022 19:01:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1643742093;
 bh=VRyH49oabNK9tq5d8ITbMCbDVSNwxXXmYIC92KD8pAk=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=fi+UTk5gKsIOw6y/x5rzHWQN/dnuO/rcJ2Xny2s+2Q88W0N8SybiTPxqM2DK7/24v
 oc/3jbMdTQsoMiKdWMxWYVug5ow3HaLAUjFRczq7DhXBMLgmVYgqlGG7GzGug2KnPL
 QMIK3GC9JD7b2hkx+iWsEuDTTJ9VWjJkHm/KlN90BXsGZMzDLbHaTGTXnwICBQFsAp
 3ntQ6T9fgHXAf9+1oLBj6GojrZacR5vN2aX5zv91rESdRcNN7/ch++E5T2Ny111EC6
 yzKSfynwDKOzwRKqAn8Zn/scTeWnqa39hGJMBEGczewg6o3A2HNtN83ohpkyX0pDCm
 JWJht0H1Jfp6Q==
From: Keith Busch <kbusch@kernel.org>
To: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-block@vger.kernel.org
Cc: axboe@kernel.dk, hch@lst.de, martin.petersen@oracle.com, colyli@suse.de,
 Keith Busch <kbusch@kernel.org>
Subject: [PATCHv2 2/7] nvme: allow integrity on extended metadata formats
Date: Tue,  1 Feb 2022 11:01:23 -0800
Message-Id: <20220201190128.3075065-3-kbusch@kernel.org>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20220201190128.3075065-1-kbusch@kernel.org>
References: <20220201190128.3075065-1-kbusch@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220201_110136_317083_BB32146F 
X-CRM114-Status: GOOD (  13.41  )
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

The block integrity subsystem knows how to construct protection
information buffers with metadata beyond the protection information
fields. Remove the driver restriction.

Note, this can only work if the PI field appears first in the metadata,
as the integrity subsystem doesn't calculate guard tags on preceding
metadata.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/nvme/host/core.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 5e0bfda04bd7..b3eabf6a08b9 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1726,12 +1726,9 @@ static int nvme_configure_metadata(struct nvme_ns *ns, struct nvme_id_ns *id)
 {
 	struct nvme_ctrl *ctrl = ns->ctrl;
 
-	/*
-	 * The PI implementation requires the metadata size to be equal to the
-	 * t10 pi tuple size.
-	 */
 	ns->ms = le16_to_cpu(id->lbaf[id->flbas & NVME_NS_FLBAS_LBA_MASK].ms);
-	if (ns->ms == sizeof(struct t10_pi_tuple))
+	if (id->dps & NVME_NS_DPS_PI_FIRST ||
+	    ns->ms == sizeof(struct t10_pi_tuple))
 		ns->pi_type = id->dps & NVME_NS_DPS_PI_MASK;
 	else
 		ns->pi_type = 0;
-- 
2.25.4


