Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB8CAC4828D
	for <linux-nvme@archiver.kernel.org>; Wed,  7 Feb 2024 21:23:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=pMO98y1uJmMFCMMA+8VPSxN5v2HqbgDO0I6pZuJJX1o=; b=RyLix2WR6PvKUOnSgbpIm23y3N
	FYoV8LJCrcrn+sRbkOL7oMktsErTuRqE5lt6KAUmSms1XiJNaYGxyopxtn4IJeT85AL/Xs6z65rz5
	cj8nwaAiBVtyP8FETss10Re2BAIvno85fvCIHNIQHop/1Yc/JsO1Zmvj2jXS8q7GDc3SZbbpF2pR0
	MZdN63DSfaKWXkb4yJJKrDB5cB8A+eIZuOLfwDM0tou57g3dP6gUZDyOS61QjvCMdHQ4lIAMZqoRD
	qq3RemghSmrLygvEjnblDwrtoIW5ryPnhPd7+oJZKnPCcgcE1aB6XJ54737IOPiG0CA0Lum1rJhFq
	kCw9/Sig==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rXpOB-0000000Bqqg-0e5r;
	Wed, 07 Feb 2024 21:23:27 +0000
Received: from sin.source.kernel.org ([145.40.73.55])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rXpNz-0000000BqgP-3ddX
	for linux-nvme@lists.infradead.org;
	Wed, 07 Feb 2024 21:23:21 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 29BA8CE1B18;
	Wed,  7 Feb 2024 21:23:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18DD8C433F1;
	Wed,  7 Feb 2024 21:23:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707340993;
	bh=LT+L/7PYPwDnnATDNcJq2+vE/jlPYOwwnStBT/2zcO8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=g06LgTFy0VTEgAFfDGEI4hHgPrqz+FTMPaQ9IAVcjG0YuykWaE/Fa8a0CsiNlxcpI
	 Kj0/aQ/yZAZWyHUsI1J/+37Si8YTBUz1kMWbbA5UsQ1y2gWu0vG7c2bKBQZ3um/Hy2
	 8VUWFgigyPvtvQgMZpqEAC8QnOPxaIgcLr9wzVDooC63MrlO3k2MrB9ZFwor+ZmFkF
	 CKlCVjqlGig+seSC2Ylv62iYi6G1PxDbu6kUfVTIj4lvaXFLnQ11jHLCCez7BITQ4v
	 SlBjTbC4VexvAILFMJ+v+qd19jEhLDnsqYoiLOm0PWUnp5mkutb5k9vISGDUuUtSPU
	 MEznaTwqGlgwg==
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
Subject: [PATCH AUTOSEL 6.7 38/44] nvmet-fc: abort command when there is no binding
Date: Wed,  7 Feb 2024 16:21:05 -0500
Message-ID: <20240207212142.1399-38-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240207212142.1399-1-sashal@kernel.org>
References: <20240207212142.1399-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.7.4
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240207_132316_238424_AF519D2E 
X-CRM114-Status: GOOD (  12.46  )
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
index d50af99e847d..1eda4fa0ae06 100644
--- a/drivers/nvme/target/fc.c
+++ b/drivers/nvme/target/fc.c
@@ -1100,6 +1100,9 @@ nvmet_fc_alloc_target_assoc(struct nvmet_fc_tgtport *tgtport, void *hosthandle)
 	int idx;
 	bool needrandom = true;
 
+	if (!tgtport->pe)
+		return NULL;
+
 	assoc = kzalloc(sizeof(*assoc), GFP_KERNEL);
 	if (!assoc)
 		return NULL;
@@ -2516,8 +2519,9 @@ nvmet_fc_handle_fcp_rqst(struct nvmet_fc_tgtport *tgtport,
 
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


