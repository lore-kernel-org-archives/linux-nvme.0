Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59D2BC369C2
	for <linux-nvme@archiver.kernel.org>; Tue, 22 Apr 2025 10:28:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nRRoqx3UV6d6xPWfTXbXIC5/D+eGKNiNDfH1lpmJuhA=; b=guoy2PN/BtomCMQM9pcJSMkB2l
	HgK5+10p+igItq9TJYRi7ToLUSVtLPV0xNAWxQCwv4jYAKAzNkZ9PWA6e+yAOVKX7xf0F77nInoYV
	tP88QJYX/Z1GwK+x5hTEcLKijn3OrBhileFP0VtF6CQp2WCFQeDVjjp83YWdf6fzwHco+DJdEeRgc
	ikTefhuEICSO2XT4AIom5o3S8C9DaX2OWPg2lbzdEIjd09Twd2W/luiFke0APhHMSrZF8Fw8/HADZ
	jtG6kv/naZG2hIzBOpmjRd6ArO/VANQppKiz6sFnqZVvxW4F4fFRuSJ2WKk9jkvQMLQo+doVcPfFo
	NKmgHXdg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u7Ar6-00000006kpC-3ccn;
	Tue, 22 Apr 2025 10:27:56 +0000
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u79jX-00000006WYj-1We7
	for linux-nvme@lists.infradead.org;
	Tue, 22 Apr 2025 09:16:05 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 9DE6CA4C17E;
	Tue, 22 Apr 2025 09:10:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B757C4CEEA;
	Tue, 22 Apr 2025 09:16:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745313362;
	bh=bIpByRLPh3BWyyzp2OKnR0s+aq02Ne5svfNJ/F6iJlo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uPCHLGiNGMgmBl3V/iTv/8AqBw+bDKn73OntB0YzhBG+D8fy70BFxAse+x7ValxWu
	 HmyNDIdl/6fHCZHjeM4VET0li1zmC3NpyoshvX+MgG24JSYxG9AIjS6e4Lb1nJsJ+R
	 WsSf/0GmA1qBdbnvAgJtwJGKlaoAjNEosgpxtmrn975PA/l829siP3+c6tTpPZmuVn
	 09gHqT4SIVqEFD+kK3kzefes7Pnyzyhpqt2X1Pa4ytOzg9tb3qDJqhFKOV9NprIibp
	 JMrSGpVQ3Qu7LSiUbfUZaby2gO6hukrMoix9UO8a8nTLd7uxZ5rGwech4XqBMGkpp8
	 0ntm+iXLADlTQ==
From: Hannes Reinecke <hare@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@kernel.org>
Subject: [PATCH 1/2] nvmet: Authenticate on admin queue only
Date: Tue, 22 Apr 2025 11:15:55 +0200
Message-Id: <20250422091556.145494-2-hare@kernel.org>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250422091556.145494-1-hare@kernel.org>
References: <20250422091556.145494-1-hare@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250422_021603_461890_FCDD50F6 
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

Do not start authentication on I/O queues as it doesn't really add value,
and secure concatenation disallows it anyway.
Authentication commands on I/O queues are not aborted, so the host may still
run the authentication protocol on I/O queues.

Signed-off-by: Hannes Reinecke <hare@kernel.org>
---
 drivers/nvme/target/auth.c        | 9 ++++++---
 drivers/nvme/target/fabrics-cmd.c | 4 ++--
 2 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/nvme/target/auth.c b/drivers/nvme/target/auth.c
index 0eabe1fbfe10..703d514ad42c 100644
--- a/drivers/nvme/target/auth.c
+++ b/drivers/nvme/target/auth.c
@@ -378,9 +378,12 @@ void nvmet_destroy_auth(struct nvmet_ctrl *ctrl)
 
 bool nvmet_check_auth_status(struct nvmet_req *req)
 {
-	if (req->sq->ctrl->host_key &&
-	    !req->sq->authenticated)
-		return false;
+	if (req->sq->ctrl->host_key) {
+		if (req->sq->qid > 0)
+			return true;
+		if (!req->sq->authenticated)
+			return false;
+	}
 	return true;
 }
 
diff --git a/drivers/nvme/target/fabrics-cmd.c b/drivers/nvme/target/fabrics-cmd.c
index f012bdf89850..14f55192367e 100644
--- a/drivers/nvme/target/fabrics-cmd.c
+++ b/drivers/nvme/target/fabrics-cmd.c
@@ -239,8 +239,8 @@ static u32 nvmet_connect_result(struct nvmet_ctrl *ctrl, struct nvmet_sq *sq)
 	bool needs_auth = nvmet_has_auth(ctrl, sq);
 	key_serial_t keyid = nvmet_queue_tls_keyid(sq);
 
-	/* Do not authenticate I/O queues for secure concatenation */
-	if (ctrl->concat && sq->qid)
+	/* Do not authenticate I/O queues */
+	if (sq->qid)
 		needs_auth = false;
 
 	if (keyid)
-- 
2.35.3


