Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1637C41513
	for <linux-nvme@archiver.kernel.org>; Wed, 17 Jul 2024 11:03:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GxivjGoHGARbvFHuGBN9GyIXKzHNy5UUWRfrdq3vaXw=; b=0DB4yRu0D8QiBRHs5m6Z17vgLz
	cfI7mW0yfUjX+Oxysx8SiVmABdRRDG5JGVEJZMuZH4StA8Xkqrs37HdifsZXxztanoMfkcVRyH/Lg
	Z7ZCsGEntZVg2ewBvcwYcuyH/oO3SKwpvzgJ2rryRVnE2G6wr4hHIMJIkcFRBl6X54bqJbrpOeSfy
	+dePxMu911pIq3hqUx244FxX2Mx21TyV1uex/eZbr0cp25+OCtw5mbciFF0luDGtJReH6dRnb+W6I
	zt/EuvbjYEupZI9tEaw66//Rh9Ep6+WoMRKqe8l7pqdF+kpMTT41lm3NPsyMcGV/V3ThcXfxYjy+A
	MVoSSBGw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sU2Rq-0000000DYlK-0uhs;
	Wed, 17 Jul 2024 11:03:50 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sU2Rk-0000000DYkB-3voC
	for linux-nvme@lists.infradead.org;
	Wed, 17 Jul 2024 11:03:48 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 4443C616C5;
	Wed, 17 Jul 2024 11:03:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAAA0C4AF09;
	Wed, 17 Jul 2024 11:03:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721214223;
	bh=LzSDU/SthfLaHw98FJ4vBtXNs2i369bXG/q3CuvczMk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SgLlVu5T2BbtkpcPwWxFjIyUoXPPg0T8tK3gltVz7VWvQlRa5bpwUNU6nnEpgSakG
	 EyM7cJUkiri07Q7/IZt7RifJCdKPOX1KXxhfVQJBX7MQCP0wH+wPMT7eraUxxAoQtn
	 TVoOccAEWCfEQ9GKJWgZL6cfQvKamMw+corp8bWbojyNjc/Em+smVpa0AIPjM9U/p3
	 vgdlZbKORZ06R/vwKMOVa8Xbc1mDT162nm3sKCM1WnKCxPuXx/TvMzYGbDSjMO0q+f
	 nJ0Hc7dadmN/V7RVd2QOddFNmfWDn5zMRoyRfLjpP3QkNKe1a5sJIypVDJJhKS6QfY
	 yQ9qzLaW185yQ==
From: Hannes Reinecke <hare@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@kernel.org>
Subject: [PATCH 1/2] nvme: Do not re-authenticate queues with no prior authentication
Date: Wed, 17 Jul 2024 13:03:37 +0200
Message-Id: <20240717110338.27332-2-hare@kernel.org>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240717110338.27332-1-hare@kernel.org>
References: <20240717110338.27332-1-hare@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240717_040345_062657_CB6A3DDE 
X-CRM114-Status: GOOD (  14.65  )
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

When sending 'connect' the queues can figure out whether authentication
is required. But reauthentication doesn't disconnect the queues, so this
check is not available. Rather we need to check whether the queue had
been authenticated initially to figure out if we need to reauthenticate.

Signed-off-by: Hannes Reinecke <hare@kernel.org>
---
 drivers/nvme/host/auth.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/auth.c b/drivers/nvme/host/auth.c
index 23ff3df27e80..66828742586c 100644
--- a/drivers/nvme/host/auth.c
+++ b/drivers/nvme/host/auth.c
@@ -31,6 +31,7 @@ struct nvme_dhchap_queue_context {
 	u32 s1;
 	u32 s2;
 	bool bi_directional;
+	bool authenticated;
 	u16 transaction;
 	u8 status;
 	u8 dhgroup_id;
@@ -915,6 +916,7 @@ static void nvme_queue_auth_work(struct work_struct *work)
 		goto fail2;
 	if (chap->qid || !ctrl->opts->concat) {
 		chap->error = 0;
+		chap->authenticated = true;
 		return;
 	}
 	ret = nvme_auth_secure_concat(ctrl, chap);
@@ -923,8 +925,10 @@ static void nvme_queue_auth_work(struct work_struct *work)
 			 "%s: qid %d failed to enable secure concatenation\n",
 			 __func__, chap->qid);
 		chap->error = ret;
-	} else
+	} else {
 		chap->error = 0;
+		chap->authenticated = true;
+	}
 	return;
 
 fail2:
@@ -940,6 +944,8 @@ static void nvme_queue_auth_work(struct work_struct *work)
 	 */
 	if (ret && !chap->error)
 		chap->error = ret;
+	if (chap->error)
+		chap->authenticated = false;
 }
 
 int nvme_auth_negotiate(struct nvme_ctrl *ctrl, int qid)
@@ -1011,6 +1017,14 @@ static void nvme_ctrl_auth_work(struct work_struct *work)
 		return;
 
 	for (q = 1; q < ctrl->queue_count; q++) {
+		/*
+		 * Skip re-authentication if the queue had
+		 * not been authenticated initially.
+		 */
+		if (!ctrl->dhchap_ctxs[q].authenticated) {
+			ctrl->dhchap_ctxs[q].error = 0;
+			continue;
+		}
 		ret = nvme_auth_negotiate(ctrl, q);
 		if (ret) {
 			dev_warn(ctrl->device,
@@ -1064,6 +1078,7 @@ int nvme_auth_init_ctrl(struct nvme_ctrl *ctrl)
 		chap = &ctrl->dhchap_ctxs[i];
 		chap->qid = i;
 		chap->ctrl = ctrl;
+		chap->authenticated = false;
 		INIT_WORK(&chap->auth_work, nvme_queue_auth_work);
 	}
 
-- 
2.35.3


