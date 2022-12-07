Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6861EC352A1
	for <linux-nvme@archiver.kernel.org>; Wed,  7 Dec 2022 11:28:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=eoJHuR6vrrcuupt24e4u/rlepnVHee4i4iPycN6mYmY=; b=RoAhuCETBnEnCDYG8hcNfCHeVf
	+nglaMxrbVteKUzTDbhehyIiI5vvTFTKNnJYkzaP7i6Abb92qpRLiX08pdbExm68geHx8vboR5a0k
	oD6herbl2q064xCmAp90MOOfb2n8rXczpV4GMniLvJeXC7NgekxTSKsKg9WOSZ6+41cQt2adg/yve
	QkUKnzSys3dGaAYIypJXOrnSzOLeW44C8y1BKQwr843Zx3Mfp2LE2XO4rBP44B96pkHHQ9xGHNPpd
	JjP7LlOAPG/TCZ0tegPVfGTXD71voejfH8qBdgkJss7cMjlEyO46gxSgkBdKtVWhl1RAsNk3dS8hZ
	eR15D2Iw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p2sbI-000p27-3h; Wed, 07 Dec 2022 11:28:32 +0000
Received: from mail-wr1-f44.google.com ([209.85.221.44])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p2sbF-000owG-7y
	for linux-nvme@lists.infradead.org; Wed, 07 Dec 2022 11:28:30 +0000
Received: by mail-wr1-f44.google.com with SMTP id q7so27648089wrr.8
        for <linux-nvme@lists.infradead.org>; Wed, 07 Dec 2022 03:28:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eoJHuR6vrrcuupt24e4u/rlepnVHee4i4iPycN6mYmY=;
        b=meSDSOMxEfA7Ll8QB7+yYPP/gVB51KyeILWn3v7IG3f9ImwlYk3D9SwO0mtelXVzGF
         OGiVtoRIvS5OSEtwdEC2LR+9/bHEEZoXDBlQ+56SjO8hEh5TEN+gmpZL2HIvCU5iLWuC
         m+/zvmHm9iOQUH4X5H6y1d9k0+ZM1qWwzA1znUeH4bFIMib2j/gSseCp9tlfo4X+mVMd
         h7GeAn/9VEhQlg4Wpv1HbPLRU++U0JQG0WdsPRMFJlE8lb7vfDgy/sfCVsmgnJRXW9QX
         ZoMKzCzx9lGelt3l+SBCzmSZjRq/H62oeElcmlZfwlNOOMqMwBYOlPZwli5YEefPGBWi
         Gc2A==
X-Gm-Message-State: ANoB5plqTbt/q14bCTL6Sx0DD2ZHlb6Idf78A896l3h4B6/gqubFrvTi
	OpUHDe2MoJe5xtYR17Tmv56hzuv+j0M=
X-Google-Smtp-Source: AA0mqf42N0EK2ryXuNdIkludtF4gm6LjXpZbKW/PU8QNbCmMI6QOpfaexLNupVBiYqhzJTBBv5wfFg==
X-Received: by 2002:a05:6000:18cd:b0:242:26ed:2d69 with SMTP id w13-20020a05600018cd00b0024226ed2d69mr20981004wrq.3.1670412506019;
        Wed, 07 Dec 2022 03:28:26 -0800 (PST)
Received: from localhost.localdomain (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id 6-20020a1c0206000000b003d1e90717ccsm1373050wmc.30.2022.12.07.03.28.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Dec 2022 03:28:25 -0800 (PST)
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nvme@lists.infradead.org
Cc: Christoph Hellwig <hch@lst.de>,
	Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
	Keith Busch <kbusch@kernel.org>
Subject: [PATCH] nvmet: don't open-code NVME_NS_ATTR_RO enumeration
Date: Wed,  7 Dec 2022 13:28:23 +0200
Message-Id: <20221207112823.1212380-1-sagi@grimberg.me>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221207_032829_317336_E4CE0621 
X-CRM114-Status: GOOD (  11.15  )
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

It is already there, just go ahead and use it.

Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/target/admin-cmd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index 6b46f90a63cf..53a004ea320c 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -561,7 +561,7 @@ static void nvmet_execute_identify_ns(struct nvmet_req *req)
 	}
 
 	if (req->ns->readonly)
-		id->nsattr |= (1 << 0);
+		id->nsattr |= NVME_NS_ATTR_RO;
 done:
 	if (!status)
 		status = nvmet_copy_to_sgl(req, 0, id, sizeof(*id));
-- 
2.34.1


