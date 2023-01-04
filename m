Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 296DEC4332F
	for <linux-nvme@archiver.kernel.org>; Wed,  4 Jan 2023 10:20:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9/vLSl0Gx6/TXhVTzjwjqtlB8fPDsHL8LSNWBKYpfc4=; b=Og2cCg56JYG/pZsqXYsbnXQHmo
	kdRtw5JQ6nsDQkI9KCG0wVRFuOR41yIynBNG4M0NOu9P8h11m1dB+A3zTxXd3gmtzLb93w5xlQ66f
	Ff9haQxPVSFVZe0ju6Q2i1uLXXdQIUR64W+7vsM+0DDdBJfl9f6QJe5aat3UX2PstW7VP9ozu/dkJ
	xwcvNeZpqHpHXeuQLxcsXIAhBMuJlYGWPk/s4aYkP0Sk9dUExX8TwAu77jhIoBxw9stp89pVD53M2
	CLXTmURAtlybhIb7jZs4qQ6O+886kEM6hIuM/NXXgAhTQrc5I9gFFLdbzjhvfV3TPLPLmn4EoJgAA
	BBXYSoLw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pD0t2-008MHn-Kv; Wed, 04 Jan 2023 10:20:44 +0000
Received: from marcansoft.com ([212.63.210.85] helo=mail.marcansoft.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pD0pn-008LYR-L6
	for linux-nvme@lists.infradead.org; Wed, 04 Jan 2023 10:17:25 +0000
Received: from [127.0.0.1] (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sendonly@marcansoft.com)
	by mail.marcansoft.com (Postfix) with ESMTPSA id A8A6B3FB17;
	Wed,  4 Jan 2023 10:17:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=marcan.st; s=default;
	t=1672827438; bh=MLdyNUGqhsrRED5hjRcjh0VIn12dU5ghryHGCfnHNXo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=SRK2pJSe8FIQQ802ij/JBfeeRQR9w0uoN/kMMc6Z90lZUZ2yWsK0JP1YbkyOUupWn
	 bOwUplD5+or6TeojFIlOB8/WrzpsBw7vwbFkNGectMMX2UKX3l5J298llbVGubvlVT
	 j3Vzf7wwisCsBsc//+VIB5MSEIAj84SNCisk+hiLKBUsUj172bBEIFDGN+r3r8dd1Q
	 +Jtu7soMD7JaSIkpqJB5gpzFhBaNDo2+RnLGguThHgc43kcBcLvjI+f52sYwJc7Fkl
	 4Exgw0TwnQOFaOnA1vsUMht1fUT0yYkz9V4uBu+j0FanBrtU1uVj094IgHEq/FAeBi
	 H4fBMYHakRcLA==
From: Hector Martin <marcan@marcan.st>
To: Sven Peter <sven@svenpeter.dev>,
	Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@fb.com>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: Uday Shankar <ushankar@purestorage.com>,
	asahi@lists.linux.dev,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Hector Martin <marcan@marcan.st>
Subject: [PATCH] nvme-pci: Add NVME_QUIRK_IDENTIFY_CNS quirk to Apple T2 controllers
Date: Wed,  4 Jan 2023 19:16:42 +0900
Message-Id: <20230104101641.12215-1-marcan@marcan.st>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230104092148.15578-1-marcan@marcan.st>
References: <20230104092148.15578-1-marcan@marcan.st>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230104_021723_935207_37810F45 
X-CRM114-Status: GOOD (  15.62  )
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

This mirrors the quirk added to Apple Silicon controllers in apple.c.
These controllers do not support the Active NS ID List command and
behave identically to the SoC version judging by existing user
reports/syslogs, so will need the same fix. This quirk reverts
back to NVMe 1.0 behavior and disables the broken commands.

Fixes: 811f4de0344d ("nvme: avoid fallback to sequential scan due to transient issues")
Signed-off-by: Hector Martin <marcan@marcan.st>
---
 drivers/nvme/host/pci.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

Note: this is untested (since probably nobody with a T2 is running
6.2 RCs yet), but given that these controllers share the same firmware
codebase and some other quirks, it is almost certain they regressed
just like the M1/M2 controllers did. Existing syslogs from T2 machines
show the same errors we were getting on M1/M2 prior to the regression,
which points to them having the same issue of treating CNS as a binary
flag as in NVMe 1.0 all along.

Sven has asked some of the T2 folks if they can test a 6.2 RC to verify
the same regression happened, so hopefully we can get confirmation that
this needs fixing (and the fix works), but if we end up getting no
feedback I'd lean towards just getting this applied as a fix since it's
unlikely to break anything and highly likely to fix a regression.

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index b13baccedb4a..91f8adcf6056 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -3495,7 +3495,8 @@ static const struct pci_device_id nvme_id_table[] = {
 		.driver_data = NVME_QUIRK_SINGLE_VECTOR |
 				NVME_QUIRK_128_BYTES_SQES |
 				NVME_QUIRK_SHARED_TAGS |
-				NVME_QUIRK_SKIP_CID_GEN },
+				NVME_QUIRK_SKIP_CID_GEN |
+				NVME_QUIRK_IDENTIFY_CNS },
 	{ PCI_DEVICE_CLASS(PCI_CLASS_STORAGE_EXPRESS, 0xffffff) },
 	{ 0, }
 };
--
2.35.1


