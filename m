Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34C21C369BA
	for <linux-nvme@archiver.kernel.org>; Mon, 14 Apr 2025 13:30:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hzCq3un4gjLQgOBJc/Whk6CDN7BbFqovKFQl1LIiFjY=; b=E5hTO3XvwXHHWGoV2T9/ENXkwR
	Uup4IbKfw4g6Iu/XfoQqSeJV0f9j83QRP2/+brWqLj5YiYB9XnekQNhKcwY1OFOsCYG7CRAzkrfyX
	Gy27e0sRJek9dsATT/3PO0W3kakGBw602UnN2cbDsA6rEutLq4xnAK4Ii2g9mE6sAta7BVb9cB4QW
	1dc84ZcwYglu8Wte+rX00kdUXiVoPbLdKPfa3w+OGzzA3OO7PYalrjbuFk5GyrcVw+ZBRlj2vXHM2
	dUPTCeGgwoAWoGBnWuyy5G3/CkPCHokJoYTNqCnsFbTwkLg7o/LuD5fMJ7FNSBWww6PHKeqNaofNH
	e4ZiJnEQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u4JtG-000000028mV-2g9E;
	Mon, 14 Apr 2025 13:30:22 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u4Jsb-000000028Zo-2QIf
	for linux-nvme@lists.infradead.org;
	Mon, 14 Apr 2025 13:29:41 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 64CE0614C0;
	Mon, 14 Apr 2025 13:29:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7622EC4CEE2;
	Mon, 14 Apr 2025 13:29:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744637380;
	bh=zoAf7BIuluC1txZ4yjQEbLP0gHpfXijkojicAkawmCM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VERxvk2Z1eIkdYDTzWmQoFfd1a651P58cSQEgaum5E1tB1Xv4QX7X3Hg9rOCQPmsy
	 VzqdSiVTXWB9Gv/fZ7JvDkqxoZfLEvYPdVXDO1HS0d7ffCYF6dknJY/I6AIFTfNIca
	 IQvfXo4Hm24L4+t2EJWdSx4yxrHTPEDnyKdAslDlxItvNOA+tgAfwwo2HMZ/W4T/0s
	 uq4oc1wfbiyl9+t6MLwFyTyjVBokw2rsjLLP50qL/QE8ShgnrcYivTNaKfciSncDlZ
	 UfxsdKuw9LD3YDo9CJTmbQ0FbSuwmSrkYxss7mmJmh6eV8+hlP0XFkYVHNMbtP5RcX
	 W9E7votr4yOFw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Daniel Wagner <wagi@kernel.org>,
	Hannes Reinecke <hare@suse.de>,
	Christoph Hellwig <hch@lst.de>,
	Sasha Levin <sashal@kernel.org>,
	james.smart@broadcom.com,
	sagi@grimberg.me,
	kch@nvidia.com,
	linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 6.12 22/30] nvmet-fc: take tgtport reference only once
Date: Mon, 14 Apr 2025 09:28:39 -0400
Message-Id: <20250414132848.679855-22-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250414132848.679855-1-sashal@kernel.org>
References: <20250414132848.679855-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.23
Content-Transfer-Encoding: 8bit
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

From: Daniel Wagner <wagi@kernel.org>

[ Upstream commit b0b26ad0e1943de25ce82a7e5af3574f31b1cf99 ]

The reference counting code can be simplified. Instead taking a tgtport
refrerence at the beginning of nvmet_fc_alloc_hostport and put it back
if not a new hostport object is allocated, only take it when a new
hostport object is allocated.

Signed-off-by: Daniel Wagner <wagi@kernel.org>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/target/fc.c | 22 +++++++---------------
 1 file changed, 7 insertions(+), 15 deletions(-)

diff --git a/drivers/nvme/target/fc.c b/drivers/nvme/target/fc.c
index 3ef4beacde325..a3a6dfe98d6fc 100644
--- a/drivers/nvme/target/fc.c
+++ b/drivers/nvme/target/fc.c
@@ -1042,33 +1042,24 @@ nvmet_fc_alloc_hostport(struct nvmet_fc_tgtport *tgtport, void *hosthandle)
 	struct nvmet_fc_hostport *newhost, *match = NULL;
 	unsigned long flags;
 
+	/*
+	 * Caller holds a reference on tgtport.
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
@@ -1077,6 +1068,7 @@ nvmet_fc_alloc_hostport(struct nvmet_fc_tgtport *tgtport, void *hosthandle)
 		kfree(newhost);
 		newhost = match;
 	} else {
+		nvmet_fc_tgtport_get(tgtport);
 		newhost->tgtport = tgtport;
 		newhost->hosthandle = hosthandle;
 		INIT_LIST_HEAD(&newhost->host_list);
-- 
2.39.5


