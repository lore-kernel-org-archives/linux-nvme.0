Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8B2EC4828F
	for <linux-nvme@archiver.kernel.org>; Wed,  7 Feb 2024 22:32:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Tnmv3EKjvaR7HWCx1Zk8jkuPmGijJAjH6QCYTa9kvSA=; b=rmwbqJEU18HwaWnvFpYARxFewV
	jsp3f9+nH5wrPJT6bwY5rajuCE21OSUKUrzGjGDLPTGserenT7b2ulXeL5jAtkeSYULu12a3UZxNy
	0E66hWR9+6nKVqmQz++5ZJZ++xoytiRvDHPyNB/y9I4kboJHec4OHU2IkdgLp7zXzOxi/Geyt8P2X
	XTOm/U6JuCI8FurxhZBOKz5GACbuBDdljvyGq/mJc+PQoHHe6Ko0HCOjnDf+vpODKMu7K6HnX1Q2f
	8TrYJ/taa1ECPW/7hfZiv7UrqhDaHpyfuHEkamroV7qEVszR7Kdr072Vkwey+K7sFYtfYQsdDy8z4
	vd/WNZow==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rXqSi-0000000C7U9-3cHg;
	Wed, 07 Feb 2024 22:32:12 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rXpSP-0000000BtpI-0OX2
	for linux-nvme@lists.infradead.org;
	Wed, 07 Feb 2024 21:28:12 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 306C661AA3;
	Wed,  7 Feb 2024 21:27:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A356EC43399;
	Wed,  7 Feb 2024 21:27:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707341267;
	bh=Vu7amYQlWzc2gJ5zlkyCD35RjnlQiWKoKLMQQOemOYc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YP3bgd6Bk3iMW1azEgSYG9x1cM0Zne93QRlFSOeuIudC+FHN/+kS1bXqXKTT83vSB
	 WN8uZdkZpxkKkPaiE1Bn7Mq5d8EZTmgvTECdS1vlCegb+y96wwL3fCJS/CfKD40hZy
	 654GPczTQHzFKak5GN43eLntjEN73SHKPkE5/Yy3LEyzYQeRI8MBaVTbggtJRazM12
	 eRrhIuO+F6ihIJUrs7D5uBTznjAfRzSBa/uXtfPf5/KBSQnl/+6q0Y11DK49NrZPZg
	 WK/4Q0PXPWIUm7hgcJK+BROeW+6qOG9vrc5SAzAv9EEe5lfef1kuwunVZusRqVa6D5
	 3qQz2RBQQG4zg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Daniel Wagner <dwagner@suse.de>,
	Hannes Reinecke <hare@suse.de>,
	Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	james.smart@broadcom.com,
	sagi@grimberg.me,
	kch@nvidia.com,
	linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 5.4 7/7] nvmet-fc: abort command when there is no binding
Date: Wed,  7 Feb 2024 16:27:31 -0500
Message-ID: <20240207212732.4627-7-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240207212732.4627-1-sashal@kernel.org>
References: <20240207212732.4627-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.268
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240207_132749_712570_28D75DCF 
X-CRM114-Status: GOOD (  12.35  )
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

From: Daniel Wagner <dwagner@suse.de>

[ Upstream commit 3146345c2e9c2f661527054e402b0cfad80105a4 ]

When the target port has not active port binding, there is no point in
trying to process the command as it has to fail anyway. Instead adding
checks to all commands abort the command early.

Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Daniel Wagner <dwagner@suse.de>
Signed-off-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/target/fc.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/target/fc.c b/drivers/nvme/target/fc.c
index f74fc6481731..2dd39299fba0 100644
--- a/drivers/nvme/target/fc.c
+++ b/drivers/nvme/target/fc.c
@@ -796,6 +796,9 @@ nvmet_fc_alloc_target_assoc(struct nvmet_fc_tgtport *tgtport)
 	int idx;
 	bool needrandom = true;
 
+	if (!tgtport->pe)
+		return NULL;
+
 	assoc = kzalloc(sizeof(*assoc), GFP_KERNEL);
 	if (!assoc)
 		return NULL;
@@ -2180,8 +2183,9 @@ nvmet_fc_handle_fcp_rqst(struct nvmet_fc_tgtport *tgtport,
 
 	fod->req.cmd = &fod->cmdiubuf.sqe;
 	fod->req.cqe = &fod->rspiubuf.cqe;
-	if (tgtport->pe)
-		fod->req.port = tgtport->pe->port;
+	if (!tgtport->pe)
+		goto transport_error;
+	fod->req.port = tgtport->pe->port;
 
 	/* clear any response payload */
 	memset(&fod->rspiubuf, 0, sizeof(fod->rspiubuf));
-- 
2.43.0


