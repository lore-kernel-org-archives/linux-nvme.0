Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 983F8606A31C
	for <linux-nvme@archiver.kernel.org>; Wed, 11 Nov 2026 00:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=ClnQzjXE;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Th/ayuNd
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Unsubscribe-Post:List-Owner;
	bh=rzYtuy9MWvV383bxP3/GBOi2+3wSZuhKWTgQueogEhs=; b=ClnQzjXEFmJN1GyfvkeeUKvZVN
	5qy4VV/q41NJGkaDrD8vxJgb7tTb9fmy9uU/hLKQ3Xe7yzUT2QuV2uOGOPpmUGz63Suq5ECEMbCzL
	ZvCcmObyD8U6LeWDzinDT7doUFFlgGfUEOP6GClJpb7unCiAaCyx+MzeHFMkmwAhY4cbtBuf4ulSG
	C/iyMVelFRD/WwjT4Cvfd0MYaTJAnOUDACYy2BHfOfiXIAvnjbp3UM2dL/ty2aPwk9i0G5KolqDCC
	7i2EKQhYp8VeIRa2bT26721AxLjgXcqgDZ5jMtQfEDDP9FNssQv3DxmYoK41As1Xe8sSM37KX11d4
	DtWeHnUA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQvuq-00000005Hit-01FP;
	Wed, 11 Nov 2026 00:10:16 +0000
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQvun-00000005HiC-04dc
	for linux-nvme@lists.infradead.org;
	Wed, 11 Nov 2026 00:10:14 +0000
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-c505186727fso177280866b.3
        for <linux-nvme@lists.infradead.org>; Tue, 10 Nov 2026 16:10:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794355810; x=1794960610; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=rzYtuy9MWvV383bxP3/GBOi2+3wSZuhKWTgQueogEhs=;
        b=Th/ayuNdJaKyQnh6yIBENsFqY7Bjw5QRyTbV5xUGGuKB3P7NmP+3/6O6PXTghZn7FP
         4UDG51q9LWEJ9bn8MZ6DKQGT2sv4RBa+DEF9RyNXCoqR08e1EJByZl6Y3O3nNGG6Eczt
         lb4SW1iI+YQOPnSdtF2wkHBZc/jlRL5FTfIltvE+7FksCClnjTlXF/WK1gqPYWOWVdA9
         MB84fjtdrtRtTy9+G5apDdjqg9/F64MLpe0/6WkG+2+77jwHglU8oiQoZCdMqH+UDfpm
         Yt8btKU9lxsrIrsCp9qTcD6gaVGng/pF2BisB+jhLXAFK3u2+A6nRXiSDXNE7gT1wtAi
         g2iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794355810; x=1794960610;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rzYtuy9MWvV383bxP3/GBOi2+3wSZuhKWTgQueogEhs=;
        b=QMe5rABin+DVuPSkYXXNR4zEbiKs2LTT1RIyrgWG8ngktb17sTreVO6QvyEe93Jxwn
         rIlm5AblPQXfdo0i6mDomEjAK/hGPhscXKpySkgtpm2hULDJ/kDywrPISDMGcRcpCe/b
         +0LA+rbAVZp6lv8xDBv8XAzDkx9iJr4zfr8o8kCn+9HgalagWcncYrxkwJKIZwBzQEEH
         m/L6YK71XX7VReRN/lQ85db+x6ioPj6kp3jP4f60dIU8KJ3ke4ZFKSGbiAfbezSomT+g
         sTNKdsd+IxylksLzaUsPDHPrTOIQ+4ENiT+DFeOzzMjEFZWcLEDyMw30UTXiA07Y5okR
         14tQ==
X-Gm-Message-State: APuU4Z8BYCqIA2nN4hEQyzeqy86rBt2Eu/OzjHwuul1KPal6UtsUM/iv
	KLI4qKsJMdlWghU1zqkQMlHCHOhYBE/52bgZp7AlQQYlu80Sau6TVBv8/72nRWyRC2Jitg==
X-Gm-Gg: AYBFou2LLgtfMylbf+NeqcZPNpW01NpZmPaXlZ0dccRdBW8OmPp1eb6E0SdEJ64skrh
	6cPckGy3uIFJU17FisGIduNQqLCeh27klcYlBG2LYjo3EnkSU4uesFAZ5T4Gvl+jyK7W+v0KIJ8
	bme96fosQu6+WaHVsyzqfAqr6J2I9GLVhnukmX5jBEyHDqGBi3aO8IuWIpSPEZLeXey4TGGi0yC
	BtyfRgwWWw34+v/C4AoFjXIgL9TdVmxBMDvZLjrp2sGj+qdxorePvuznmWwD3/MqOWosG5PtZaz
	wld1fQjEDKbCfT0vLWv8prihtTdEgG0plDAh46ZRtlNBKhFFMYJ+1cctZGFAOj3c8YMdeToylPm
	7j8rHSmBGBxzhHWYQKu4okaeIQNiGZ0QFSMz9xRsXeL/5E/m1CfquZGeWJDZfVM43LBbay9trQt
	fCywcbdHPzQBXxolCAA0nhlTmsncXI9tQlS/EDcTeG2QkU27kS94NK3w0kXUH9AgZoBkXZP/t5O
	bX2YmyEm/JhGEgDBrdNJZu4oKtLdMYtpPtp8IqNd9UnUsSNzhUlmOfRAKJ6/EqsOmG3QROjL+rk
	K7i/Ah0J6IjWh1/i7VdhQxGAiKqVlt9heDdU168ay1az6REAsTviweAXy0OviBAZ5cQ323kpBN/
	3H6KxiI2Xk0yyDA==
X-Received: by 2002:a17:907:3f9d:b0:c24:4128:c19f with SMTP id a640c23a62f3a-c5066aea631mr54362366b.11.1794355810535;
        Tue, 10 Nov 2026 16:10:10 -0800 (PST)
Received: from fedora.tailb87685.ts.net (ip-194.15.124.140.laito.net.pl. [194.15.124.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c504a618abesm168201266b.50.2026.11.10.16.10.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 16:10:10 -0800 (PST)
From: Platon Miller <platon.ksenzenkokk@gmail.com>
To: linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org,
	axboe@kernel.dk,
	hch@lst.de,
	sagi@grimberg.me,
	Platon Miller <platon.ksenzenkokk@gmail.com>
Subject: [PATCH v2] nvme-pci: merge duplicate 1d97:2263 entries in nvme_id_table
Date: Wed, 11 Nov 2026 01:09:41 +0100
Message-ID: <20261111000941.105115-1-platon.ksenzenkokk@gmail.com>
X-Mailer: git-send-email 2.56.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261110_161013_073323_2F887DA8 
X-CRM114-Status: GOOD (  13.08  )
X-Spam-Score: -2.1 (--)
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The nvme_id_table currently contains two separate entries for PCI ID
1d97:2263: one for SPCC with NVME_QUIRK_DISABLE_WRITE_ZEROES, and another
later in the table for Lexar NM610 with NVME_QUIRK_BOGUS_NID.

Because pci_match_device() returns on the first match, the Lexar NM610
entry is unreachable, leaving those drives without NVME_QUIRK_BOGUS_NID.

Merge the quirks for 1d97:2263 into a single entry with both
NVME_QUIRK_DISABLE_WRITE_ZEROES and NVME_QUIRK_BOGUS_NID, and remove the
redundant entry.

Fixes: 200dccd07df2 ("nvme-pci: add NVME_QUIRK_BOGUS_NID for Lexar NM610")
Signed-off-by: Platon Miller <platon.ksenzenkokk@gmail.com>
---
v2:
  - Add Fixes tag for commit 200dccd07df2 as suggested by Sashiko AI review
 drivers/nvme/host/pci.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index f8088d5aa..bc9d26a86 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -4440,8 +4440,9 @@ static const struct pci_device_id nvme_id_table[] = {
 		.driver_data = NVME_QUIRK_DISABLE_WRITE_ZEROES, },
 	{ PCI_DEVICE(0x15b7, 0x2001),   /*  Sandisk Skyhawk */
 		.driver_data = NVME_QUIRK_DISABLE_WRITE_ZEROES, },
-	{ PCI_DEVICE(0x1d97, 0x2263),   /* SPCC */
-		.driver_data = NVME_QUIRK_DISABLE_WRITE_ZEROES, },
+	{ PCI_DEVICE(0x1d97, 0x2263),   /* SPCC / Lexar NM610 */
+		.driver_data = NVME_QUIRK_DISABLE_WRITE_ZEROES |
+				NVME_QUIRK_BOGUS_NID, },
 	{ PCI_DEVICE(0x144d, 0xa80b),   /* Samsung PM9B1 256G and 512G */
 		.driver_data = NVME_QUIRK_DISABLE_WRITE_ZEROES |
 				NVME_QUIRK_BOGUS_NID, },
@@ -4501,8 +4502,6 @@ static const struct pci_device_id nvme_id_table[] = {
 		.driver_data = NVME_QUIRK_NO_DEEPEST_PS, },
 	{ PCI_DEVICE(0xc0a9, 0x540a),   /* Crucial P2 */
 		.driver_data = NVME_QUIRK_BOGUS_NID, },
-	{ PCI_DEVICE(0x1d97, 0x2263), /* Lexar NM610 */
-		.driver_data = NVME_QUIRK_BOGUS_NID, },
 	{ PCI_DEVICE(0x1d97, 0x1d97), /* Lexar NM620 */
 		.driver_data = NVME_QUIRK_BOGUS_NID, },
 	{ PCI_DEVICE(0x1d97, 0x2269), /* Lexar NM760 */
-- 
2.56.0


