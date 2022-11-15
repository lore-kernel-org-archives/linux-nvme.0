Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6197BC4332F
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Nov 2022 14:35:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=uwsa6e4ZTTtBwUXMxaowuE/qntE7rRRmIKCy8pwcnuc=; b=R4eOoM7VSt1TuwYXEK8yNHTuTL
	JITK4CF1YZlUaNvpTygdwjglWiWaQmskHz9boldCNE6mKNaVpEdGqPGEK4LKW6FXt0X4Vwkrmwwtq
	Vk9im5AWOT8X+EMzh56Bo/Yo5GNYy4aVdm/vm1DXFixgVTImt0bpkXQBO1On7SqSPKDyqKDaYVadE
	RUmjBEc36lusbftSUFmflz3lEOlW1b34H6LfEI6EcW0bRusprISmJQOxB06JsYCYN4W55y0Xqvmlu
	smFpAE4PF/i5Jy40Y7dZWGggrTkiEtOtaCceEqJ7pEpaXnuNuDL6ssVdUiD757jNNIQDzaRsYKWlk
	8iPLMFQA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oux2L-00BvG0-OS; Tue, 15 Nov 2022 14:35:41 +0000
Received: from mail-wm1-f47.google.com ([209.85.128.47])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oux2I-00BvDt-U5
	for linux-nvme@lists.infradead.org; Tue, 15 Nov 2022 14:35:40 +0000
Received: by mail-wm1-f47.google.com with SMTP id l39-20020a05600c1d2700b003cf93c8156dso10390796wms.4
        for <linux-nvme@lists.infradead.org>; Tue, 15 Nov 2022 06:35:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uwsa6e4ZTTtBwUXMxaowuE/qntE7rRRmIKCy8pwcnuc=;
        b=MfCObN1Q1eMjxrQc85zkdjgEMI+1vOdaIBnUA4JANxV/11WYHAqvtDa3on/DcGy9TU
         L0Amtk/quO5xvOgfFliKX1/xwO3Ai5/LfxRIK/PmXNfnpr758idoFiWOi7MIysmrraPF
         dwQhA+SPmGYsCyOB5aHCv8Gwxv/yFLxgCxbvpN3+gaSwfnjNpVaLX3P+mJB3Er3bao2d
         GC8q/Gs+FWKRjw3TmY/ZXWLOV9aBvbbnitrtRYfFQ6oMuwkPOqkDB7LiD36YFJYsBdRu
         /9M3jq5orhXWPOaK0yA/W4MDQfwy0x7SZghkhMwxn+OCurpb2H9wCC5mZ9gU5vWG6FO9
         sgiw==
X-Gm-Message-State: ANoB5plg6WRG1njqVnVeWKflksExV+g8R2Aa3FTm7f/ok4sgxfHmN6Af
	mIDwme4ra4sFXUxlX6rnagFag8ZYcE0=
X-Google-Smtp-Source: AA0mqf7/8TQ9gjQMWTekn1WHtVAN2bqz2CoPM1TKmrmvUsofl9+GbCbiyEbKjZj19Z4bRzMXzy7geg==
X-Received: by 2002:a05:600c:228a:b0:3cf:7dc1:f432 with SMTP id 10-20020a05600c228a00b003cf7dc1f432mr565073wmf.148.1668522934645;
        Tue, 15 Nov 2022 06:35:34 -0800 (PST)
Received: from localhost.localdomain (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id j7-20020adfb307000000b0023c8026841csm12636738wrd.23.2022.11.15.06.35.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Nov 2022 06:35:34 -0800 (PST)
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nvme@lists.infradead.org
Cc: Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH] nvme-auth: fix compilation warning when CONFIG_NVME_AUTH is not set
Date: Tue, 15 Nov 2022 16:35:32 +0200
Message-Id: <20221115143532.1142332-1-sagi@grimberg.me>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221115_063538_982616_57903A45 
X-CRM114-Status: GOOD (  13.02  )
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

init/exit functions should be empty static inline stubs when
CONFIG_NVME_AUTH is not set.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/host/nvme.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 357fa7330bd9..a50b0743728e 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -1058,11 +1058,11 @@ int nvme_auth_negotiate(struct nvme_ctrl *ctrl, int qid);
 int nvme_auth_wait(struct nvme_ctrl *ctrl, int qid);
 void nvme_auth_free(struct nvme_ctrl *ctrl);
 #else
-int __init nvme_init_auth(void)
+static inline int nvme_init_auth(void)
 {
 	return 0;
 }
-void __exit nvme_exit_auth(void) {};
+static inline void nvme_exit_auth(void) {};
 static inline void nvme_auth_init_ctrl(struct nvme_ctrl *ctrl) {};
 static inline void nvme_auth_stop(struct nvme_ctrl *ctrl) {};
 static inline int nvme_auth_negotiate(struct nvme_ctrl *ctrl, int qid)
-- 
2.34.1


