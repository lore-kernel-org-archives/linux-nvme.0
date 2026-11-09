Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38814606A31C
	for <linux-nvme@archiver.kernel.org>; Mon,  9 Nov 2026 20:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=xrgwSdoy;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=iGR6ODA2
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Unsubscribe-Post:List-Owner;
	bh=Eb+hoZoEFxDwsfEy9vV5deqB5Q9xbZn2iQ2lGq3bA6A=; b=xrgwSdoyD4IXY5danbo89OA77x
	rU1rOVr4/uNGzjFkpu+G3R8hm8fnLLWon4AcpR1atTlBL8i9C04Dk8JJ8enWTIYWRMAzjDBBNaWmw
	YFhzXjW/dqLwUeKKk1xYQLyxoX5FUYwq3Adu+oK0G2mDHtP59QXJsK9hVgyQZMxD6B/987gAhEdVz
	kL3+wde+Zw0Tt+Nnp6CBRpG9rZob8I0usYllRC2jnnKPbFtsqMQx+WbT0R6g5w4ryy3TKvJDyuAYe
	HU7EDfw9LQpEGyv9hgCsxV3Gvqoxlb8h9StXWZpHNMyjXI6Zj86kql+cHDtv6+xzF9RRvsYSnWRe7
	bIkBuZYQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQVxA-00000001eD9-2Gkb;
	Mon, 09 Nov 2026 20:26:56 +0000
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQVx7-00000001eCl-2iVu
	for linux-nvme@lists.infradead.org;
	Mon, 09 Nov 2026 20:26:54 +0000
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-c4d28f75d62so175187766b.0
        for <linux-nvme@lists.infradead.org>; Mon, 09 Nov 2026 12:26:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794256012; x=1794860812; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Eb+hoZoEFxDwsfEy9vV5deqB5Q9xbZn2iQ2lGq3bA6A=;
        b=iGR6ODA2Spi5BfDZIb1bFOoP87Rti6ewFdwjD03jempDrkYRAa9xDAujslAAtP+H9y
         0tL0l5wkTQRydls0yB5vvsYqoIy4pLyZe5rQ6tjdKcatYLDukDU0dAaLTIgqo4N1U7V1
         yskh2+fgZxkPHQzS3z9+ZBqIkF3QMx6a0+tEYFwLj7bV5l9euiBDFuG7WqUsZNXVVnT3
         hhV4v2ANxi6FsrN08jwdmtej52KVG64z1hVwrpSr4N1W8DU51zVCi+NxkVdmTXHv9d8y
         KwCuf1EWL33GqXIwWKIXU4Z7M2Ox0HjDd3HTpgxnbKCgas5mrOyTmSuCQSGnjcmezp9I
         814g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794256012; x=1794860812;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Eb+hoZoEFxDwsfEy9vV5deqB5Q9xbZn2iQ2lGq3bA6A=;
        b=fYY0H9jI2CSXe2HFVOS+Ggoc6TD1aH0rQjzHF4UTBzwMOMxW/hmSrcDZ9rxSjt0rU0
         6Yan+gROwMvc52zuLdEWoy65UE0qvLqdJYSD6dvcyC5S9R2j2qXJr2F08r1bx698xs7Z
         JIOKT04ULFTEJg8HdMfiZ6hdmNiaB0Zt4WseeT/rneT1Ct58q6Wk6XoisA6AaS8GYc3W
         121z6VrBZbhON/qSru+zSkbAO0ZMEbCxpY5z3TWfxljKEqLjHLsiE9bZm/a+nNAEJz2N
         drLa8TIL7+28JRpS10kQ64JdXeas4GXIndOXoEiahmsqPlhJqSdTThH0hXZqXgVucoFE
         /k2w==
X-Gm-Message-State: APuU4Z/DUVxX2vrgrpG1OMh7mjFWPw5bsVqKPdl5ZpRBHj8vy+1PvQbV
	xr46LfnkYYkr52lB4xGq9PBYdkwrotVvf/cj/vxBCiQiBgyP5GHypNa6pIBIw2YpSTZ8ig==
X-Gm-Gg: AYBFou3IdY16ABCzzonZh9Lczq16pXV6n3nkofmydsiMSd+nKk9wrp5lHxfzidRiTaF
	Qi8qcUT7nTNv7tlG0F6FoC1d+kpAN22DZdgpTGLYoHC7pRpJYww3z/4PpSjAxXppxH4HJI97IoW
	Cojma/GZ1wbH7a+KEEGhrDSK0KDItiTd4a0vV1K1L7RWCZWDlR9ik2ea7ipugjgzmNYALkthe7A
	fpEg+ljU6dbSnuw3OhLwlU25hvTeQ6RtVeA54GLAjJ8k7XcZkEmEZ1XEvDDGik8ac+NGykcvzrY
	6TAAF7/zQzbOrX4thhnIccwQnHUfCsPNizHzWA+6lZY1zSExnUD+nYvVrTArhglkLQy3garhnta
	iXFmTa/qr3bc/DD+I8B1L/IlEVxNw4NzjedG0MMI2GinilY30+41FmROfLoJVy37tDPLCh5WtpF
	1fe3CDszyRoMe446d0rZaqIKqQ43jQ+tZ7VTkdWl6Cdeqt+UsaYgkFJlvOHrZKArG+peRYHcSTz
	HQnEVyE+yf4iUMDRz42nmfTzGANKyZtI4HMnp/odZOcElxNMYzGvT7SGtGtrzr5U6xQZ8terlr9
	Q2NsjJv+Ccq3cmmFa9Jq/IsvuVW7eWyE4rrPTpV6nozTG3Vi7AQga0DrJsAyPLG6BaT74xA6and
	p292DxG0QUh3Kaw==
X-Received: by 2002:a17:906:7c94:b0:c3f:55e6:83e6 with SMTP id a640c23a62f3a-c504952be13mr31352866b.15.1794256011531;
        Mon, 09 Nov 2026 12:26:51 -0800 (PST)
Received: from fedora.tailb87685.ts.net (ip-194.15.124.140.laito.net.pl. [194.15.124.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c504a5704cfsm12465366b.15.2026.11.09.12.26.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 12:26:51 -0800 (PST)
From: Platon Miller <platon.ksenzenkokk@gmail.com>
To: linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org,
	axboe@kernel.dk,
	hch@lst.de,
	sagi@grimberg.me,
	Platon Miller <platon.ksenzenkokk@gmail.com>
Subject: [PATCH] nvme-pci: merge duplicate 1d97:2263 entries in nvme_id_table
Date: Mon,  9 Nov 2026 21:26:35 +0100
Message-ID: <20261109202635.11310-1-platon.ksenzenkokk@gmail.com>
X-Mailer: git-send-email 2.56.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261109_122653_710922_DF413B80 
X-CRM114-Status: GOOD (  12.72  )
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

Signed-off-by: Platon Miller <platon.ksenzenkokk@gmail.com>
---
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


