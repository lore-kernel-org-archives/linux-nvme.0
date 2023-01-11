Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88A5DC46467
	for <linux-nvme@archiver.kernel.org>; Wed, 11 Jan 2023 04:38:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=DrGnilphed++uUZkhm3rd0G2c4sVV31GlOelQ1DnBls=; b=h0aTObaXSyn6IN7zgMcSLCMfCa
	KALo3M3DkOemnYEU6NgQGXFobyaX6KNlAp+ZE9OYUl7zi+zSnmmNwPnT/2/WuFkr2BqxR3+7rlmF2
	9sNyGvA9hRKvrdtb/EwoFE1bZYcJxtI3RAtIcPXA1bTz0nEQhGt7yhU2LUxuILKq0Z2ckmIwSu1a2
	qcunJpOFYsdB/rFHg4VEghSbhCCHp1DBncN4teC3K7ageTWguMtZAU0z8VmDQnCmv3nwcFacsT0Iy
	jnnPcmubby7YsfShb+KqfAN4ysb3i71dYc1VqMqnnB6TrnydWko81v8nUlKIRwvbQwW5B2wwBTH3b
	BteRlhkA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pFSsy-009Ybc-Ra; Wed, 11 Jan 2023 04:38:48 +0000
Received: from marcansoft.com ([212.63.210.85] helo=mail.marcansoft.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pFSse-009YXl-Ja; Wed, 11 Jan 2023 04:38:29 +0000
Received: from [127.0.0.1] (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sendonly@marcansoft.com)
	by mail.marcansoft.com (Postfix) with ESMTPSA id A9EC6422CC;
	Wed, 11 Jan 2023 04:38:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=marcan.st; s=default;
	t=1673411907; bh=Q3CUKLEywf+vR4+nGROpaJQqVS2PQmhEl5Il4+LejRo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QY5tqf60SZHxFaNdFYSzNvp4IdFLjD4OU8BawnpwU74nj7igN5fSFDF1+fcojF39A
	 sOVlpJT9RhW6yM4BHm02nodGm1dFnVtmoqCnFikp1F9d/8cT3SuUqKczh83l09wMoo
	 Zz+ydkC/lTC43zhbi3SjksPhqde146WnH3Ge1L59zI7Cg8TeHT4GQTiqLfm70xYxh7
	 LVdvZPRhSF4FctliGqXRgKXSjYPgtSRKMkB+ouZ2NiQ/4azKsNZx88fxEu31eKkYae
	 js5/uMv+MwTL1AyrKdtdx76z3wHbPDiWP65rW7ZcORH+fhFmpmvHqNkiBHju5CgmAS
	 FS6P8dLLiUcuA==
From: Hector Martin <marcan@marcan.st>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@fb.com>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: Eric Curtin <ecurtin@redhat.com>,
	Janne Grunau <j@jannau.net>,
	Sven Peter <sven@svenpeter.dev>,
	Alyssa Rosenzweig <alyssa@rosenzweig.io>,
	asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Hector Martin <marcan@marcan.st>
Subject: [PATCH 1/2] nvme-apple: Do not try to shut down the controller twice
Date: Wed, 11 Jan 2023 13:36:13 +0900
Message-Id: <20230111043614.27087-2-marcan@marcan.st>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230111043614.27087-1-marcan@marcan.st>
References: <20230111043614.27087-1-marcan@marcan.st>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230110_203828_806436_7200914E 
X-CRM114-Status: GOOD (  14.34  )
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

The blamed commit stopped explicitly disabling the controller when we do
a controlled shutdown, but apple_nvme_reset_work was only checking for
the disable bit before deciding to issue another disable. Check for the
shutdown state too, to avoid breakage.

This issue does not affect nvme-pci, since it only issues controller
shutdowns when the system is actually shutting down anyway.

Fixes: c76b8308e4c9 ("nvme-apple: fix controller shutdown in apple_nvme_disable")
Signed-off-by: Hector Martin <marcan@marcan.st>
---
 drivers/nvme/host/apple.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/apple.c b/drivers/nvme/host/apple.c
index e13a992b6096..1961376447dc 100644
--- a/drivers/nvme/host/apple.c
+++ b/drivers/nvme/host/apple.c
@@ -1023,7 +1023,8 @@ static void apple_nvme_reset_work(struct work_struct *work)
 		goto out;
 	}
 
-	if (anv->ctrl.ctrl_config & NVME_CC_ENABLE)
+	if (anv->ctrl.ctrl_config & NVME_CC_ENABLE &&
+	    !(anv->ctrl.ctrl_config & NVME_CC_SHN_MASK))
 		apple_nvme_disable(anv, false);
 
 	/* RTKit must be shut down cleanly for the (soft)-reset to work */
-- 
2.35.1


