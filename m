Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFDE5C433F5
	for <linux-nvme@archiver.kernel.org>; Tue, 22 Feb 2022 16:34:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=soEcvVlUiZe830oEa7YN9adcolCM5/tsmhK+wvMSF60=; b=KDAZWpVzGnf2t2W+66TM3gl2bl
	XyrFxBXCD5L8wxnALOQiqvU/DQ/b60bHxseCoc7rwBJlQowUALF8RPFG9j5Yk4bmnslUn6zDSmVJ2
	p4fxajYe0RLISdxDQWskvjU0fyE6KGDuqVzEQOf/V5gWQLbPlQZcTuWqhgFirI0buP1skhxNjA7yk
	60FDP7ex6RaF+7X4Sgzy6qrjunR9+IjAkCLVc38lVzmlp0GzeA5KocVqhOoKN4xe6NT1OmBR/VgLO
	ojQV5teDlAn5Ulxpxk0y7P1BtGjbqGSyU+TPKnhuRu8tC0PNb9Cchq7WgAuicPsDZy8vVGYYEnQN+
	3Jo8s9xQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nMY75-00Aek5-AT; Tue, 22 Feb 2022 16:34:07 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nMY5O-00Ado1-7V
 for linux-nvme@lists.infradead.org; Tue, 22 Feb 2022 16:32:25 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id BA2A560AD5;
 Tue, 22 Feb 2022 16:32:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72ABAC340FB;
 Tue, 22 Feb 2022 16:32:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1645547541;
 bh=UcJmaYKYSUedgav8DTnlV/x/GzgaonSprD2wkPg3Hq4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=pW31tNlM7vrf4Vja9RGa/oOYqzpEBdOuNydh7Ok1ffO63/zOdH2U0436X7xpoxH/8
 7s6I316cTMlOtl6fP7RXS+RVgFgxGG5E823yZS5kPKCn3awuLuwEbPgJZATptM5xXG
 C0nlmBtQHPmAPwvKugvDIo7PJXkZs9TZj79n6IMUVDugAWJUmeT+WjvcP6V6njW8wD
 AXeVPSmqv4Y8KdVJrjVsQ1jiYk1hDAi9OPnwhVH1TOrZKJnA1RaGGHU0DmHO3mVJls
 vBARKxLPPxYkqEZ/tWPceK9rZ5KhnYxAB34eR5iEalccUIb/p7mWMMkyBxCKs8aqLy
 kZ5NghPYeOjOg==
From: Keith Busch <kbusch@kernel.org>
To: linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 linux-crypto@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org
Cc: axboe@kernel.dk, hch@lst.de, martin.petersen@oracle.com, colyli@suse.de,
 Keith Busch <kbusch@kernel.org>, Hannes Reinecke <hare@suse.de>
Subject: [PATCHv3 02/10] nvme: allow integrity on extended metadata formats
Date: Tue, 22 Feb 2022 08:31:36 -0800
Message-Id: <20220222163144.1782447-3-kbusch@kernel.org>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20220222163144.1782447-1-kbusch@kernel.org>
References: <20220222163144.1782447-1-kbusch@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220222_083222_406593_38BDB983 
X-CRM114-Status: GOOD (  13.36  )
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

Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/nvme/host/core.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 3b876dcab730..8132b1282082 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1760,12 +1760,9 @@ static int nvme_configure_metadata(struct nvme_ns *ns, struct nvme_id_ns *id)
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


