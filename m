Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C205C35FF8
	for <linux-nvme@archiver.kernel.org>; Tue, 18 Mar 2025 10:40:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=293ty/ewBZShEzOLV0+2TffchXeU97npX76SigjzQRU=; b=m9f7xHpuv5bwL8S1I1IC61aOBQ
	a/89frCv8dIInMATdki18g6zImxOMz7aeW8/I7ZIHW4oaI80/Yvh4IJUNbPVw+Zxj4g0FS37X9PRU
	n0Zl/0/u4Opcn9XpWabBD3urebSHAdoeU1MRP6BDuQPetgcbP3Rgxj78tufY7A+KTszl13tCob1jI
	ltQATS1wFVVtGDqZ6OyZ6SAw6dSZn16lKSfYJgoNpFcMzrNKxSlIMgSuVOpjCeDPbptJfPGKV2xGt
	3A0mstQHhwDRaBxUbQHsftZsuMzFvhAreMoLAR7T1cVVeECrQguoy56P0zvdDsMzBABkWI88TwR4O
	MeRwpmVQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tuUNI-00000005YPX-1kLF;
	Tue, 18 Mar 2025 10:40:44 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tuUNC-00000005YGj-2mUo
	for linux-nvme@lists.infradead.org;
	Tue, 18 Mar 2025 10:40:42 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 0859F5C58AD;
	Tue, 18 Mar 2025 10:38:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48F51C4CEE3;
	Tue, 18 Mar 2025 10:40:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742294437;
	bh=4nbEl4sZ5VwAwk80/F9WKLpZmL99SeHa3v/TXRfobLQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=MK4R0uxtKc2gU7pAryVQtYYERXpPBPW/8V+tFKdV62sYntJL9Z22VGO3z/VAxMxK8
	 Y1mDCG0/ezeMvpvp8vqg0jBeJWiH8voOHIq5QqcS7aeEqFCqTnBaKaF7eHpJ7/EOYC
	 THlqOxAVOc3C4a/R7EEPAnE5KXppmiJChHAokx5UpEcrl58oXTIOVPwPKYGOpE4QIQ
	 lxpUslBXR2m67DwklLaLA+tNAwBQe0D/EVi2PvTeNQ/+5hhX2LjFtNdsObsBkBoji6
	 FMcvStZT0br0bIDqhjAzpsZAWhYBF5LMxEhOsC+r7X6Xq/Fy3EQaqMGNX5qKHSrqmH
	 AbyNpXpvU60WA==
From: Daniel Wagner <wagi@kernel.org>
Date: Tue, 18 Mar 2025 11:40:08 +0100
Subject: [PATCH v3 14/18] nvmet-fc: take tgtport reference only once
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250318-nvmet-fcloop-v3-14-05fec0fc02f6@kernel.org>
References: <20250318-nvmet-fcloop-v3-0-05fec0fc02f6@kernel.org>
In-Reply-To: <20250318-nvmet-fcloop-v3-0-05fec0fc02f6@kernel.org>
To: James Smart <james.smart@broadcom.com>, Christoph Hellwig <hch@lst.de>, 
 Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>
Cc: Hannes Reinecke <hare@suse.de>, Keith Busch <kbusch@kernel.org>, 
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Daniel Wagner <wagi@kernel.org>
X-Mailer: b4 0.14.2
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250318_034038_787699_C0D04E1C 
X-CRM114-Status: GOOD (  14.84  )
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

The reference counting code can be simplified. Instead taking a tgtport
refrerence at the beginning of nvmet_fc_alloc_hostport and put it back
if not a new hostport object is allocated, only take it when a new
hostport object is allocated.

Signed-off-by: Daniel Wagner <wagi@kernel.org>
---
 drivers/nvme/target/fc.c | 24 +++++++++---------------
 1 file changed, 9 insertions(+), 15 deletions(-)

diff --git a/drivers/nvme/target/fc.c b/drivers/nvme/target/fc.c
index 8b14947906948c8b4914932837b4ec90921b419d..b2f5934209f9952679dc1235fb7c927818930688 100644
--- a/drivers/nvme/target/fc.c
+++ b/drivers/nvme/target/fc.c
@@ -1030,33 +1030,26 @@ nvmet_fc_alloc_hostport(struct nvmet_fc_tgtport *tgtport, void *hosthandle)
 	struct nvmet_fc_hostport *newhost, *match = NULL;
 	unsigned long flags;
 
+	/*
+	 * A ref on tgtport is being held while executing this function,
+	 * thus there is no need to take first one and give it back on
+	 * exit.
+	 */
+
 	/* if LLDD not implemented, leave as NULL */
 	if (!hosthandle)
 		return NULL;
 
-	/*
-	 * take reference for what will be the newly allocated hostport if
-	 * we end up using a new allocation
-	 */
-	if (!nvmet_fc_tgtport_get(tgtport))
-		return ERR_PTR(-EINVAL);
-
 	spin_lock_irqsave(&tgtport->lock, flags);
 	match = nvmet_fc_match_hostport(tgtport, hosthandle);
 	spin_unlock_irqrestore(&tgtport->lock, flags);
 
-	if (match) {
-		/* no new allocation - release reference */
-		nvmet_fc_tgtport_put(tgtport);
+	if (match)
 		return match;
-	}
 
 	newhost = kzalloc(sizeof(*newhost), GFP_KERNEL);
-	if (!newhost) {
-		/* no new allocation - release reference */
-		nvmet_fc_tgtport_put(tgtport);
+	if (!newhost)
 		return ERR_PTR(-ENOMEM);
-	}
 
 	spin_lock_irqsave(&tgtport->lock, flags);
 	match = nvmet_fc_match_hostport(tgtport, hosthandle);
@@ -1065,6 +1058,7 @@ nvmet_fc_alloc_hostport(struct nvmet_fc_tgtport *tgtport, void *hosthandle)
 		kfree(newhost);
 		newhost = match;
 	} else {
+		nvmet_fc_tgtport_get(tgtport);
 		newhost->tgtport = tgtport;
 		newhost->hosthandle = hosthandle;
 		INIT_LIST_HEAD(&newhost->host_list);

-- 
2.48.1


