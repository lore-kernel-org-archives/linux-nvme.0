Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B83F2C77B61
	for <linux-nvme@archiver.kernel.org>; Fri, 14 Apr 2023 00:56:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=7mOoC0r8zllUiWXDJ1hTEOYTwfoq/RwV/PhlcywX7jk=; b=ZfaAymmhxnVKJgYvIxZfUio9Xh
	7ethe034xF61jdd+DSS5Bn5jiJJp6C0NDFZFvqpUR3rUxWahOQVSf3CobT/0P9lAQ7E4NlDbK1KgG
	Z046twiNU4WYPUaW7D3AFQlpvYpbLmHZHz0suVMAimq8KSztgrSdLmVGElGVyjk9fyshNycQSmxX2
	tAFJUqbr9t/E1nLakJ500Fq+t083GghUnnIdVKEvtk5DkO9gpj/vDpuHY//0rIxYDXnOnbRxzD0SL
	InLrup4zkeGjvlwBRdjjLvkrYWlKSw5xYAQkF0uvkK5Um8pJENxXm+tyPfX6p4FlL6XNQ0hd5XfU3
	JiG7TtyA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pn7ji-007vQy-1p;
	Fri, 14 Apr 2023 00:56:22 +0000
Received: from mail.bakkin.moe ([107.173.146.132])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pn7jd-007vPC-1R
	for linux-nvme@lists.infradead.org;
	Fri, 14 Apr 2023 00:56:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dory.moe; s=bakkinselector;
	t=1681433865;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=7mOoC0r8zllUiWXDJ1hTEOYTwfoq/RwV/PhlcywX7jk=;
	b=FXlswQLUxZzHipiv1AYGvhew5yvqM8Sw4D9hxUcjEFPwdo56oGzf9p+fcD+P9RbGgh09NN
	oKPNuLPddQmJF2SIF5xxCm5ftCTKhY2DewSoVQrHAffTsaqFm7pG7ZqXxdP/tV7MvRiH4v
	6EopSkIHjmE3djL52bzC9MUpnDpZ0T24Z1Sugyyums1DNRHGIL1/gDymSm05aykRUIoguA
	eIcJCfqXhwmfgZktzphZQyQkFyKfe1aICGCQdDuSSikDkpqm3BSvTNetmQrDi/LSMn0qs9
	q8dDDw4Wixagug+05fKNncDGKXt/oVxuP76PwWPiXLym2pY07nH7paqLFXG5rg==
Received: 	by bakkin.moe (OpenSMTPD) with ESMTPSA id eaf535d7 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 14 Apr 2023 00:57:45 +0000 (UTC)
From: Duy Truong <dory@dory.moe>
To: linux-nvme@lists.infradead.org,
	kbusch@kernel.org,
	axboe@fb.com,
	hch@lst.de,
	sagi@grimberg.me
Cc: Duy Truong <dory@dory.moe>,
	stable@vger.kernel.org
Subject: [PATCH] nvme-pci: add NVME_QUIRK_BOGUS_NID for T-FORCE Z330 SSD
Date: Thu, 13 Apr 2023 17:55:48 -0700
Message-Id: <20230414005548.300794-1-dory@dory.moe>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230413_175617_499913_880FEBC9 
X-CRM114-Status: UNSURE (   8.62  )
X-CRM114-Notice: Please train this message.
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

Added a quirk to fix the TeamGroup T-Force Cardea Zero Z330 SSDs reporting
duplicate NGUIDs.

Signed-off-by: Duy Truong <dory@dory.moe>
Cc: stable@vger.kernel.org
---
 drivers/nvme/host/pci.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 282d808400c5..cd7873de3121 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -3443,6 +3443,8 @@ static const struct pci_device_id nvme_id_table[] = {
 	{ PCI_DEVICE(0x1d97, 0x2269), /* Lexar NM760 */
 		.driver_data = NVME_QUIRK_BOGUS_NID |
 				NVME_QUIRK_IGNORE_DEV_SUBNQN, },
+	{ PCI_DEVICE(0x10ec, 0x5763), /* TEAMGROUP T-FORCE CARDEA ZERO Z330 SSD */
+		.driver_data = NVME_QUIRK_BOGUS_NID, },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMAZON, 0x0061),
 		.driver_data = NVME_QUIRK_DMA_ADDRESS_BITS_48, },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMAZON, 0x0065),
-- 
2.40.0


