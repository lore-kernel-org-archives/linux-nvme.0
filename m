Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9265C369B9
	for <linux-nvme@archiver.kernel.org>; Mon, 14 Apr 2025 14:43:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=I52KuxtBbxEpcOBfPxaowpNFBhZMTVbSZ490JV3zCR4=; b=JWh6oBSzfkqr9egnAF4LYuiQJr
	bRavIoNamsJCBRRX9WNiECz4u9RILQMvl8uqXBh5HJKYsOCAGWhYhgywUrKTSpasI8h7CXBe1khPT
	1zs3VIFMiMWQMFib4xK4ts4ot/Rp2uS74D1k5XbA3uA5kTL+8OjGd4zoHVOmcdgFDmdt/iIJXGgJH
	yUMGtAEqqE7mhKpdwsr5AbDGCf4SOy6EMxLghCqDAWRxInnGe6j1+BwY0ptobhG/MyNvZdZB10+I/
	DVrSgLsjKUYnixNKOFe68gaa8Wj7dR2ywAVDU0MBPUwIPETBpVE+4HiDZa1mV6m2E5Hc2n2ybfqiI
	5TCqFq1w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u4L1j-00000002RUl-3yvQ;
	Mon, 14 Apr 2025 14:43:11 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u4JuG-000000029nv-0kjt
	for linux-nvme@bombadil.infradead.org;
	Mon, 14 Apr 2025 13:31:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=I52KuxtBbxEpcOBfPxaowpNFBhZMTVbSZ490JV3zCR4=; b=jmGPjPBA4s91JtPyzKgfu7wx2x
	JY6Oq+hbwIYB2Pq4wcXjGVAzivQVtUXvN30Nt7RVD0rtXfkJkarz3CbcwJRU6u2+lTtoGuDb5A7e0
	CziNYu5Xj0jVebY/HcSQ1u1xCvii2QyDPmvSpVGaBpy6pVExORl3hS4qFOd7ZiFIT9tDzBeQBqJKJ
	Sv3QwxIpg35ql/GX2EGCsLUYwmy34jihSfxmWHE8GS1OKvtYJuGwG7N5hQcDF+aX2PqjbDmV6UI8b
	OFMclsUFbqIKQaPk6GOr1HwlZusLYDt/54U/FesFjZKfOL38+AUyIhHTmu0knhBDUpHieRI7HcbUJ
	C50wHAtQ==;
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by desiato.infradead.org with esmtps (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u4JuC-00000009hCD-2qB0
	for linux-nvme@lists.infradead.org;
	Mon, 14 Apr 2025 13:31:23 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 610FF43BFC;
	Mon, 14 Apr 2025 13:31:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D58F4C4CEEB;
	Mon, 14 Apr 2025 13:31:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744637479;
	bh=kZHpTbJ32OJfohvkuDdUc6Dcq5+uv6JHJ0LJt2BxiWU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=V3nmYVMb3r4KldCEQrUOQ5QY8h1MpUoiH2GLlmWW+R7ocA/ZtwxAQV7lJKSwgWVMj
	 Y+BlyhmSEQcGzWxsq7GwZ//IaYllvu/r5AzIdnPfeFOojchji9P/UQuiEahlq0aVS1
	 Rnmz3FFCJSrBFOFoPPGgPcHhwEPy53zOwC3g6181DvQe3rFLLHPmZm1HEoB3lCw4xS
	 nVGOS19KXtO/sM5mYBI5sU9rbRYrLjdDmPSNS6d9vvBmuUQmYUHWH8ke9RlB0RYCiq
	 oTftd27zjTfv/tgPpGAdWRECMMz+ZKsEaXLhv4IdcYX0Dq8xC1ziPDG0bbsDGZ4qJL
	 YO9S9Yz71xU1A==
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
Subject: [PATCH AUTOSEL 6.1 14/17] nvmet-fc: take tgtport reference only once
Date: Mon, 14 Apr 2025 09:30:45 -0400
Message-Id: <20250414133048.680608-14-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250414133048.680608-1-sashal@kernel.org>
References: <20250414133048.680608-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.134
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250414_143121_033618_13314B7B 
X-CRM114-Status: GOOD (  13.91  )
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
index 8a02ed63b1566..50953e0f9772d 100644
--- a/drivers/nvme/target/fc.c
+++ b/drivers/nvme/target/fc.c
@@ -1044,33 +1044,24 @@ nvmet_fc_alloc_hostport(struct nvmet_fc_tgtport *tgtport, void *hosthandle)
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
@@ -1079,6 +1070,7 @@ nvmet_fc_alloc_hostport(struct nvmet_fc_tgtport *tgtport, void *hosthandle)
 		kfree(newhost);
 		newhost = match;
 	} else {
+		nvmet_fc_tgtport_get(tgtport);
 		newhost->tgtport = tgtport;
 		newhost->hosthandle = hosthandle;
 		INIT_LIST_HEAD(&newhost->host_list);
-- 
2.39.5


