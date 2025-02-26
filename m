Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6F1CC021B8
	for <linux-nvme@archiver.kernel.org>; Wed, 26 Feb 2025 18:46:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=LYUGSP89j8OzHF/Wy1LDagjX78mE2MKN+Fl9Kxy6m3g=; b=MLj6/oAzQPNVJH7bXiYYgkPvoR
	n9pt2mOc+mC/cc7xaoP0rEavFBec70XDczGIamepIyZL5dl6zghBYphajmsTdKUWJyrI8u8dUfptB
	GSKgzTbUtjXdt8cA7y7w1AsRRxJt/JCI/a49vDOTfoFD8l+OVlAELBQp7w0Y93taA+LfY6SgBNsXE
	hRnPGe/pkS7JYoGoY+wHdhRm2l1dv7o1frWDhFIyMvS8VDnLc6rXmBOEGx8N48p7M7NdfKhfLkHZN
	JmrgTlqDXt3fvx/UOqCATJH/yMIN2ZVV83Rtpra/NG8V6+IVV5FJaW+OY7BAV/MAZqB0bWQpX2XrE
	hMxELvhg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tnMQF-000000050Oi-1Fh6;
	Wed, 26 Feb 2025 18:46:19 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tnMQE-000000050Mh-0IX7
	for linux-nvme@lists.infradead.org;
	Wed, 26 Feb 2025 18:46:18 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 9851761535;
	Wed, 26 Feb 2025 18:46:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1AD9C4CEEC;
	Wed, 26 Feb 2025 18:46:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740595577;
	bh=LWNcOUyHSpm76/r8wsTzzymlSz71tkb01XzMtOR6qcc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=WRxP5h0kukCPaOyW+ojFaAMhTV7G6BMdg1nMeYkDaXUszhMdm9K2XPTZNtLRe5s0J
	 j6Ty7zKCZ2XJ0FX931zzsUBuwBLgwZeHkgFPlvqpopcdsQFLdfmDQQR9856n7nCSsb
	 xBzDcZbp6Jt5ZpoZIxCwR1ZcmMyhrUvVe2D6wHPdlAAXXplcsOXsGhI489VEEYxbhz
	 jJNxBZAL7CroR8cIbwFlNg7xs9Ws/NrH3XoVTKfiZSGZLCPlAarc9Z/CCfw1cS8nS9
	 joAx4V5ZKmf4kNxKoQo1fkEuXUHDEBfpP0D+jHrdL7iw35yvrGLPV85IDzi4EO7Snv
	 AUpqGCePvBtBQ==
From: Daniel Wagner <wagi@kernel.org>
Date: Wed, 26 Feb 2025 19:46:00 +0100
Subject: [PATCH 08/11] nvmet-fc: take tgtport reference only once
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250226-nvmet-fcloop-v1-8-c0bd83d43e6a@kernel.org>
References: <20250226-nvmet-fcloop-v1-0-c0bd83d43e6a@kernel.org>
In-Reply-To: <20250226-nvmet-fcloop-v1-0-c0bd83d43e6a@kernel.org>
To: James Smart <james.smart@broadcom.com>, Christoph Hellwig <hch@lst.de>, 
 Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>
Cc: Hannes Reinecke <hare@suse.de>, Keith Busch <kbusch@kernel.org>, 
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Daniel Wagner <wagi@kernel.org>
X-Mailer: b4 0.14.2
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
 drivers/nvme/target/fc.c | 18 +++---------------
 1 file changed, 3 insertions(+), 15 deletions(-)

diff --git a/drivers/nvme/target/fc.c b/drivers/nvme/target/fc.c
index b807b4c05cac7fe4764df3df76f8fa50f4bab6ba..391917b4ce0115dbc0ad99d1fb363b1af6ee0685 100644
--- a/drivers/nvme/target/fc.c
+++ b/drivers/nvme/target/fc.c
@@ -1046,29 +1046,16 @@ nvmet_fc_alloc_hostport(struct nvmet_fc_tgtport *tgtport, void *hosthandle)
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
@@ -1077,6 +1064,7 @@ nvmet_fc_alloc_hostport(struct nvmet_fc_tgtport *tgtport, void *hosthandle)
 		kfree(newhost);
 		newhost = match;
 	} else {
+		nvmet_fc_tgtport_get(tgtport);
 		newhost->tgtport = tgtport;
 		newhost->hosthandle = hosthandle;
 		INIT_LIST_HEAD(&newhost->host_list);

-- 
2.48.1


