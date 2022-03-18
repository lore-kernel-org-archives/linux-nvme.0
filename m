Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56444C433F5
	for <linux-nvme@archiver.kernel.org>; Fri, 18 Mar 2022 01:30:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=y8hWtjydg1Uns+eOzqAaZoK2Vcd2nxaf7d5KD8AEEt4=; b=MBpYtU3KMW/emRTDfvVysbn2MF
	wQCq+xXtBy47kBTQ97TJw5HLOXR0fUqcvDGi7Vp+TwXn4oqDkwIRlVwuZwFklM+tG2P8YDh4az+/q
	S10WB+YZZL9Pr1W+10WGocHn66px+/rO7vlAfQ8ui0K9ph7hVU5I1qrJr/MLb2iTR+V5ZauWJ6mLq
	kHYIjc2sDpeCc4uHN2f7EvCO30izWsRxW/qbNzE17TgijEJ6GgcwhMYjGU0+YDZ4fvYz+FKEj1QXQ
	ZibdUO7AaZx7lAMcLwplbIIiiGKZUSjEAW2ezrHrvvS51KxcqfZDap1F5GZBObiXpFf3zzJ4yBm3I
	yhAvwYRA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nV1Rd-0007qH-4h; Fri, 18 Mar 2022 01:30:21 +0000
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nV1Ra-0007pC-M7
 for linux-nvme@lists.infradead.org; Fri, 18 Mar 2022 01:30:19 +0000
Received: by mail-wr1-x429.google.com with SMTP id h23so9180801wrb.8
 for <linux-nvme@lists.infradead.org>; Thu, 17 Mar 2022 18:30:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=y8hWtjydg1Uns+eOzqAaZoK2Vcd2nxaf7d5KD8AEEt4=;
 b=hBcKG/WWy4HsVunBcI3ydG4SVMw/+29z7t+io0+b0TKqfjgmGEmZ6UIS16BlYMVnwH
 LxM8FKgjziksWCiNEINZw5PnnjGyJ0TFNAGqqmfkffcNSldXqTB0ahWuMKbSLTla0rSm
 aVCNkZcqC4xnqvxoIyrYoZe/yVo+ziL8w0HNivZbX7THsXlDKOltYyjBVlrpG6+OExVP
 vNgFLlz++46k3zKIhiMIw6lbWM5rb35CI0eOcQJuefJdUr/J23F3Qp4XLu7ftVDezuAs
 YgRPfekxmOYFaEu2294R2k5pLnxC8R9N46JAFHGHMsjZa5+h4eOh5bRzCemrU83DQHFp
 kNog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=y8hWtjydg1Uns+eOzqAaZoK2Vcd2nxaf7d5KD8AEEt4=;
 b=P1MdNAhssR3jdvYN47iR1qMP0bKM4R/zXqM0ue39fDGRlzEzgi4eaJW7Og73/Lz6KP
 Xfspm3Gcz3BhCQXi0xJVlz2SGp4Wrx/4+hm2VjGKEio2KoEDfPgJIqEMWHI5RnwZtrjG
 iKTs3IC2I18wOL0vF/V3r6xYxU2m6wQ1FeRZrdfsizFI7sgV7iC+YEcWjPC1Z/eS6C18
 fUTei5VXyxWPRIsKyCjs/eZOKgxNMDtg18ZKKXNVB2D2BzkDgrFw6LC3Rq+MZr6esIFZ
 LgLXH8P+hIcOM+PmqHT9/goJbQK/PmNehh3jrN6rf7uEHAaj5XghkzR9hucXFpLGw+Fw
 kMkg==
X-Gm-Message-State: AOAM531iob6UHVoXBjFVEXpcJP+8uAti/4hs6iyNf2CxP1l9xxJezK89
 akqna0nIqysBKa+2fXzKzLs=
X-Google-Smtp-Source: ABdhPJy44/ZTFxrG+FCtGZtXs1cj8lLzdIGlbJvYj5LgXRGfXlHaGY9J6mj7f3LTMs9tZivMYD9a9Q==
X-Received: by 2002:a5d:59ab:0:b0:203:cc07:8d82 with SMTP id
 p11-20020a5d59ab000000b00203cc078d82mr5881291wrr.688.1647567015653; 
 Thu, 17 Mar 2022 18:30:15 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net.
 [80.193.200.194]) by smtp.gmail.com with ESMTPSA id
 n65-20020a1c2744000000b003862bfb509bsm9534520wmn.46.2022.03.17.18.30.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Mar 2022 18:30:15 -0700 (PDT)
From: Colin Ian King <colin.i.king@gmail.com>
To: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <kch@nvidia.com>, linux-nvme@lists.infradead.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
 llvm@lists.linux.dev
Subject: [PATCH] nvmet: remove redundant assignment after left shift
Date: Fri, 18 Mar 2022 01:30:14 +0000
Message-Id: <20220318013014.90698-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220317_183018_760721_4723420E 
X-CRM114-Status: GOOD (  12.39  )
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

The left shift is followed by a re-assignment back to cc_css,
the assignment is redundant. Fix this by replacing the <<=
operator with << instead.

Cleans up clang scan build warning:
drivers/nvme/target/core.c:1124:10: warning: Although the value
stored to 'cc_css' is used in the enclosing expression, the
value is never actually read from 'cc_css' [deadcode.DeadStores]

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/nvme/target/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index 724a6d373340..75876f70a7eb 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -1121,7 +1121,7 @@ static inline u8 nvmet_cc_iocqes(u32 cc)
 
 static inline bool nvmet_css_supported(u8 cc_css)
 {
-	switch (cc_css <<= NVME_CC_CSS_SHIFT) {
+	switch (cc_css << NVME_CC_CSS_SHIFT) {
 	case NVME_CC_CSS_NVM:
 	case NVME_CC_CSS_CSI:
 		return true;
-- 
2.35.1


