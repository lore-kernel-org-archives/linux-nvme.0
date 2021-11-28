Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F893C433EF
	for <linux-nvme@archiver.kernel.org>; Sun, 28 Nov 2021 13:00:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=6JF1kN2h7IhOIon4sylWR+0GdERpFga03cemxMC6DRo=; b=0D43CJ4/2bnicvccjyCscx8BUB
	2O2pJMUUOTIh3Riwysqii8oYBlBa8jpoTItAeiwuhkk68bjWdoZN4ioSBJF2R94r6AukXrbrtFkQy
	7URxoI6cImpYcNyyQbizzpT1RlxFJOhRM9qQYSfX9RcoOJJ3lvZ5MgZf+K4XVxdqoysuVHdDAcYac
	tL//wA8NBY2MGOwH2WNNCgPk2cu/j0Gy7AzRfmw04uRFn4fVWb4FXP5cztZKehoT5vzo3+dNGS3Mv
	/vYxUCQ1/mGzOPrYqJ+8Wo5TkSjA0/MopFsDsVQ7O8M4LrQ2xK1Y8o8slbWqGu7387L4pQWKVFHVA
	65QqeDcg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mrJnK-00FktV-BC; Sun, 28 Nov 2021 13:00:38 +0000
Received: from mail-wm1-f53.google.com ([209.85.128.53])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mrJnI-00Fkt7-5v
 for linux-nvme@lists.infradead.org; Sun, 28 Nov 2021 13:00:37 +0000
Received: by mail-wm1-f53.google.com with SMTP id
 i8-20020a7bc948000000b0030db7b70b6bso14575832wml.1
 for <linux-nvme@lists.infradead.org>; Sun, 28 Nov 2021 05:00:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=6JF1kN2h7IhOIon4sylWR+0GdERpFga03cemxMC6DRo=;
 b=n0Vz9oqDjmqO6cIH9wkFhY6Zf09bIGA1+tlMCwgIOGlKvg9C5D+wIzt4ZZCy2NT5mf
 Zdpu54vu8/AI3rsJeRN9UexTPjDuvIuFJwv0Y7mNHuGcqbzDs8hk/MoO2BYJJpo+MLt+
 QAKT6WJXRc6bxWTiFwf+aA4ol0LrmKTYiY2Fw4CYI0dea0Io9wQt0J74x9K0oreNPWcn
 tDA8VvJd13XXbISBHSqTmUF/uJCCDsKrmKpDIH3/X32/2OO0pp/Nj7z3KX5ToVjlK8QJ
 RLo7n0+uQF3hqsFU7lLHcW/71F2/eHe4Y5JpPJRhfd6ZbExbYI8dsZ7Ci50NJlqCCDja
 YMKw==
X-Gm-Message-State: AOAM531plNDsPIrnzeBbpTTl5xS1eXc6OrOx+hNq+pNvJGya8F5Sz2W5
 Q/yBoymFlBBET1gyxHz0kXn4EIvHERs=
X-Google-Smtp-Source: ABdhPJz/qQbrnNH/dzkcntmWzLcZsVR9X/e/+Z+DLGO8oVtbTcAXktKNhX84wNGN22nQCnM8QLCMKw==
X-Received: by 2002:a7b:c76e:: with SMTP id x14mr28960584wmk.27.1638104434462; 
 Sun, 28 Nov 2021 05:00:34 -0800 (PST)
Received: from localhost.localdomain (bzq-219-42-90.isdn.bezeqint.net.
 [62.219.42.90])
 by smtp.gmail.com with ESMTPSA id p14sm15641183wms.29.2021.11.28.05.00.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 28 Nov 2021 05:00:34 -0800 (PST)
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nvme@lists.infradead.org
Cc: Keith Busch <kbusch@kernel.org>,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH libnvme] fabrics: fix endless loop in connect-all for
 NVME_NQN_CURR
Date: Sun, 28 Nov 2021 15:00:33 +0200
Message-Id: <20211128130033.489867-1-sagi@grimberg.me>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211128_050036_240810_C92642D5 
X-CRM114-Status: GOOD (  11.07  )
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

For a discovery log page entry that indicates the discovery controller
that returned it (i.e. itself), we need to set the controller as
discovered (because we got the discovery log page by connecting to it).

Without this connect-all goes in an endless loop keep connecting and
retrieving the log page from the same discovery subsystem port.

Fixes: 06a8f001d314 ("tree,fabrics: detect discovery loops")
Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
 src/nvme/fabrics.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/src/nvme/fabrics.c b/src/nvme/fabrics.c
index 686a5641aa9c..b657b0a41d74 100644
--- a/src/nvme/fabrics.c
+++ b/src/nvme/fabrics.c
@@ -657,8 +657,9 @@ nvme_ctrl_t nvmf_connect_disc_entry(nvme_host_t h,
 	}
 
 	switch (e->subtype) {
-	case NVME_NQN_DISC:
 	case NVME_NQN_CURR:
+		nvme_ctrl_set_discovered(c, true);
+	case NVME_NQN_DISC:
 		if (discover)
 			*discover = true;
 		nvme_ctrl_set_discovery_ctrl(c, true);
-- 
2.30.2


