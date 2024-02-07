Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AF08C4828D
	for <linux-nvme@archiver.kernel.org>; Wed,  7 Feb 2024 21:26:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/bi0GG5GiEtYwHDbjKw7XuvyebpNCyzBpq0dQgdUe1Q=; b=yoG0a2RJMcvA/QjYtz07dFApdT
	MwuriHY8VZgoetmvXu50za0ibk/fo62vECntjo3Sv6yYPhD/nITLdRtW//xekPtYRLeATrKRr3LFL
	2y+HrCcZHacchmUn8wzXhZqPovVFoY1ueVDy3pc4GUhCxR7ocPTNb7rvjnZ5Qhzu+iCgUSi2KbJ0e
	jNdfPa751R5m0ePWhzx4vDgcWYi1VRRyS1cOCEBuKw+gAM/Ecv4+MiiHs7XXUs8Yx8+81Mog0YXzh
	GepRtOjgU5I8CVSUQTEx+aFj8gOuuSvpyrLIiyCNoRheRKoy4E6fJtOQyQ4FFJxu2frYQThYKmNQ5
	XCWnADiw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rXpRC-0000000BszQ-1RYm;
	Wed, 07 Feb 2024 21:26:34 +0000
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rXpQb-0000000BsYE-1vR1
	for linux-nvme@lists.infradead.org;
	Wed, 07 Feb 2024 21:26:11 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id B70B2CE1B17;
	Wed,  7 Feb 2024 21:25:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98D48C433B1;
	Wed,  7 Feb 2024 21:25:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707341155;
	bh=8DgjKcNwoJ0gbR303YsGNUiN+N+KYeLLmrDtZWXZQi4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Wz9AlSiKW/qheRJoZCRIamy/CmGNQUfg0/DysFE/8nLts1vdkU4uzOi2qF5WTnxM8
	 p2iqatESf/N2oUKKEujqem6BPfKHdXqaN3rGoPMF9z3imsxg4JqawrZmF7Lja3W+mp
	 j2bhkOjPLwYfSYjJv6qg3UYKij3vf24FhynolIGu33yBXYfxxMG9WeYWw28Ee6K+Ml
	 nsvWKVubaGPnr7deAb/SGczmI0kg05Oto+hNvWd+lysNxvyI4k4izNmhWBxuY2wn5k
	 2i6avxuJOcIi9Vt+QYYY3JJMfLSXRispEo+S3IuRlFBbKAl3QNOB0WflRcA6GY4PYY
	 lkcnFBk32F9kQ==
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
Subject: [PATCH AUTOSEL 6.1 24/29] nvmet-fc: abort command when there is no binding
Date: Wed,  7 Feb 2024 16:24:49 -0500
Message-ID: <20240207212505.3169-24-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240207212505.3169-1-sashal@kernel.org>
References: <20240207212505.3169-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.77
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240207_132557_886440_74FB4ED0 
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
index 64c26b703860..b4b2631eb530 100644
--- a/drivers/nvme/target/fc.c
+++ b/drivers/nvme/target/fc.c
@@ -1101,6 +1101,9 @@ nvmet_fc_alloc_target_assoc(struct nvmet_fc_tgtport *tgtport, void *hosthandle)
 	int idx;
 	bool needrandom = true;
 
+	if (!tgtport->pe)
+		return NULL;
+
 	assoc = kzalloc(sizeof(*assoc), GFP_KERNEL);
 	if (!assoc)
 		return NULL;
@@ -2523,8 +2526,9 @@ nvmet_fc_handle_fcp_rqst(struct nvmet_fc_tgtport *tgtport,
 
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


