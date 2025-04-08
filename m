Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55D6FC369A2
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Apr 2025 15:30:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7fOXxI7eus0bgcCRwa7EOKoqUWfQ6pdGYHnSmc6eIG8=; b=vxtFk/IqTO8V9l6fwPJeKW7y3w
	OALRAvGsUgmFaXJ4AFj6czc2sWpY1S1INnLKxoj9czn+aFdluUrUk5tA4O+hMM9FGrlwCeh1EL14x
	LFQc1EZsxatTjSZJhhO2DpJlBBVBv2ccL21CpIyRbKjKxfWcVbChWivIJOFD+2LDjOFTEGsPZZVud
	uEbxen9+CFQCIWraIWqLu/oj70gR+U6AOAKTsu7ZEa8W9uI1/octEuQeuevnd3Rr1K2oPLs6DEA2W
	Pr2hNPlF31cto8hJg9+1odYTbqQkpTb9KDU/YrfkZJu6zfL5auCU/4upVwLhMKPbqwkdYy8bUK3ne
	J57WLUYA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u2Atl-00000004cUs-3Iz2;
	Tue, 08 Apr 2025 15:30:01 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u2AtJ-00000004cJ9-1I5e
	for linux-nvme@lists.infradead.org;
	Tue, 08 Apr 2025 15:29:34 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id BE71A4A148;
	Tue,  8 Apr 2025 15:29:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0988CC4CEE5;
	Tue,  8 Apr 2025 15:29:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744126172;
	bh=tsk2YMjqBLydxk+bAIUX9VPBT2iOvhNNO848oWtfRbY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=G/3P65yasluv92XU+RZtxMrHfkil9eol/CREQG+XPaGqJRrNFe/Om3IlRqnCoay+b
	 IthqrthbVOaV6lGAGGuyPAYbqOQVByyk903hixR01L0BQI/e6KXYJBDWODy5dRvWLy
	 jF38AoMtK2VTB5QvFv9p36+oy+Qr3EgUqIUV3My/YI6pQag7otvz5UDxMA2bstD64E
	 LCTeQRyvOCHR6+hIGEL8HLZ/Lb1lfiDD2a1TiNYpojJrNAaNm+Ij7JA7KSAKJ9VN6v
	 +xDIqHV+Wdre5TCNAsXFWscL0m6ZQbYNqzS6MwKZy3T0gyxWssFk7GTMCreYwRNhyJ
	 Ts0mbVdL+0VPw==
From: Daniel Wagner <wagi@kernel.org>
Date: Tue, 08 Apr 2025 17:29:09 +0200
Subject: [PATCH 7/8] nvmet-fc: take tgtport reference only once
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250408-nvmet-fcloop-part-one-v1-7-382ec97ab7eb@kernel.org>
References: <20250408-nvmet-fcloop-part-one-v1-0-382ec97ab7eb@kernel.org>
In-Reply-To: <20250408-nvmet-fcloop-part-one-v1-0-382ec97ab7eb@kernel.org>
To: James Smart <james.smart@broadcom.com>, Christoph Hellwig <hch@lst.de>, 
 Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>, 
 Jens Axboe <axboe@kernel.dk>, Hannes Reinecke <hare@suse.de>
Cc: James Smart <jsmart2021@gmail.com>, linux-nvme@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Daniel Wagner <wagi@kernel.org>
X-Mailer: b4 0.14.2
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250408_082933_371887_41FBE379 
X-CRM114-Status: GOOD (  15.23  )
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

Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Daniel Wagner <wagi@kernel.org>
---
 drivers/nvme/target/fc.c | 22 +++++++---------------
 1 file changed, 7 insertions(+), 15 deletions(-)

diff --git a/drivers/nvme/target/fc.c b/drivers/nvme/target/fc.c
index 42613280c06e82a0236520d93470ec6fdede37ea..61e9eea3bee430bfdef541bfe0d1f2538a49d9eb 100644
--- a/drivers/nvme/target/fc.c
+++ b/drivers/nvme/target/fc.c
@@ -1018,33 +1018,24 @@ nvmet_fc_alloc_hostport(struct nvmet_fc_tgtport *tgtport, void *hosthandle)
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
@@ -1053,6 +1044,7 @@ nvmet_fc_alloc_hostport(struct nvmet_fc_tgtport *tgtport, void *hosthandle)
 		kfree(newhost);
 		newhost = match;
 	} else {
+		nvmet_fc_tgtport_get(tgtport);
 		newhost->tgtport = tgtport;
 		newhost->hosthandle = hosthandle;
 		INIT_LIST_HEAD(&newhost->host_list);

-- 
2.49.0


