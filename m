Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35D9FC369C2
	for <linux-nvme@archiver.kernel.org>; Tue, 22 Apr 2025 10:27:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nJkMDsl2cJDmNnSfqnqEhpgGBA50cIVx8LZIHLwITws=; b=tt+5MINNc7azitipx8ZCc9XMtQ
	XCkGNnBzltquexqywZP7aj8X7YUA9o/1q/u7yCbmXnrxLwYUnuVGiZCURBG+sNAo36prnf59k4ObZ
	yJeLOiJwmNO2MY23vD9He4yq6dt9gAvlNC45+NgJ7xxpWwOkLDCFJ6nzYqulH43Vmqu+6xF6lxB/P
	yN4ix52wRj90HkXNRPtdCb20Owjb7dA6/WuOMgOr1/JIZY0YLExyklZN09p/xVIgtQvw0AiO+4GYO
	n4Rv7DkKpzEF0hS1klGJFDY2HZ9s1RZ8fffGTEsnMGI8v11930jD4qK8QnU0vcD3RIqm3eDIsdO3W
	fdi9FPAw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u7Ar6-00000006ko4-0OPP;
	Tue, 22 Apr 2025 10:27:56 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u79jY-00000006WZO-3a6G
	for linux-nvme@lists.infradead.org;
	Tue, 22 Apr 2025 09:16:04 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 8A3C361362;
	Tue, 22 Apr 2025 09:15:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D060AC4CEE9;
	Tue, 22 Apr 2025 09:16:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745313364;
	bh=EL5dDoxiD/EhwTAd9gZebpCcD2eWmdLfgr+mUHxhpg0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=D85PPGLgMSRFaIIsrfhpWMmTw1PRS5g2JZL6IMylFdTObSwICaItaDSeH7vxEfoyo
	 rXcCsEf7WpYLzTPFOStzpU6vheA4KD5DrRxK5G2So5XLpvR7QpGvAqDBP97MF/pGYv
	 piDGyXq7AcdGaVVM8U25k27uhevIJ6MuzZDsQV39+BiqmIVIFuNN01Udv+/zG4+iqB
	 pOMpK1rpQOT5UODEnZbUSS+yd/OKXa/ZU+0IafUfX/+x+oRe4eGYopGr1hkzmMopBE
	 8zsRfo2xtD9NZ7VATmD4B9l9RIFF1+3AyH1rbZ58uz+/gwhWtLZ7B0mBpSUoeUESgN
	 bbNGrLToWAmjQ==
From: Hannes Reinecke <hare@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@kernel.org>
Subject: [PATCH 2/2] nvme: Do not re-authenticate queues with no prior authentication
Date: Tue, 22 Apr 2025 11:15:56 +0200
Message-Id: <20250422091556.145494-3-hare@kernel.org>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250422091556.145494-1-hare@kernel.org>
References: <20250422091556.145494-1-hare@kernel.org>
MIME-Version: 1.0
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

When sending 'connect' the queues can figure out from the return code
whether authentication is required or not. But reauthentication doesn't
disconnect the queues, so this check is not available.
Rather we need to check whether the queue had been authenticated initially
to figure out if we need to reauthenticate.

Signed-off-by: Hannes Reinecke <hare@kernel.org>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/host/auth.c | 30 ++++++++++++++++++++++--------
 1 file changed, 22 insertions(+), 8 deletions(-)

diff --git a/drivers/nvme/host/auth.c b/drivers/nvme/host/auth.c
index ebc30071df6b..be83b93aa525 100644
--- a/drivers/nvme/host/auth.c
+++ b/drivers/nvme/host/auth.c
@@ -30,6 +30,7 @@ struct nvme_dhchap_queue_context {
 	u32 s1;
 	u32 s2;
 	bool bi_directional;
+	bool authenticated;
 	u16 transaction;
 	u8 status;
 	u8 dhgroup_id;
@@ -699,6 +700,7 @@ static void nvme_auth_reset_dhchap(struct nvme_dhchap_queue_context *chap)
 static void nvme_auth_free_dhchap(struct nvme_dhchap_queue_context *chap)
 {
 	nvme_auth_reset_dhchap(chap);
+	chap->authenticated = false;
 	if (chap->shash_tfm)
 		crypto_free_shash(chap->shash_tfm);
 	if (chap->dh_tfm)
@@ -947,12 +949,14 @@ static void nvme_queue_auth_work(struct work_struct *work)
 	}
 	if (!ret) {
 		chap->error = 0;
+		chap->authenticated = true;
 		if (ctrl->opts->concat &&
 		    (ret = nvme_auth_secure_concat(ctrl, chap))) {
 			dev_warn(ctrl->device,
 				 "%s: qid %d failed to enable secure concatenation\n",
 				 __func__, chap->qid);
 			chap->error = ret;
+			chap->authenticated = false;
 		}
 		return;
 	}
@@ -1035,13 +1039,16 @@ static void nvme_ctrl_auth_work(struct work_struct *work)
 		return;
 
 	for (q = 1; q < ctrl->queue_count; q++) {
-		ret = nvme_auth_negotiate(ctrl, q);
-		if (ret) {
-			dev_warn(ctrl->device,
-				 "qid %d: error %d setting up authentication\n",
-				 q, ret);
-			break;
-		}
+		struct nvme_dhchap_queue_context *chap =
+			&ctrl->dhchap_ctxs[q];
+		/*
+		 * Skip re-authentication if the queue had
+		 * not been authenticated initially.
+		 */
+		if (!chap->authenticated)
+			continue;
+		cancel_work_sync(&chap->auth_work);
+		queue_work(nvme_auth_wq, &chap->auth_work);
 	}
 
 	/*
@@ -1049,7 +1056,13 @@ static void nvme_ctrl_auth_work(struct work_struct *work)
 	 * the controller terminates the connection.
 	 */
 	for (q = 1; q < ctrl->queue_count; q++) {
-		ret = nvme_auth_wait(ctrl, q);
+		struct nvme_dhchap_queue_context *chap =
+			&ctrl->dhchap_ctxs[q];
+		if (!chap->authenticated)
+			continue;
+		flush_work(&chap->auth_work);
+		ret = chap->error;
+		nvme_auth_reset_dhchap(chap);
 		if (ret)
 			dev_warn(ctrl->device,
 				 "qid %d: authentication failed\n", q);
@@ -1168,6 +1181,7 @@ int nvme_auth_init_ctrl(struct nvme_ctrl *ctrl)
 		chap = &ctrl->dhchap_ctxs[i];
 		chap->qid = i;
 		chap->ctrl = ctrl;
+		chap->authenticated = false;
 		INIT_WORK(&chap->auth_work, nvme_queue_auth_work);
 	}
 
-- 
2.35.3


