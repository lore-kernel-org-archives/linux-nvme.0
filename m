Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4ED64C001B0
	for <linux-nvme@archiver.kernel.org>; Mon, 24 Jul 2023 09:06:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=QmGn4ZQf3FojYOwvSFsh5xrujW8n06HMs5La+mg2A7E=; b=XBYZsJV9H41lIzvLAaf1rQliVO
	wC0EDV0lqYWsetJDqB1gHt/LqYTaTXRw+XFiqCQAdFYVsryipspn6WzpxfohVixrZ9OXSkUlvdNQh
	gTSlK/oUySpeog+TvMiaGG5EemhIAxc9yVj9eLV6XSosiYB7BNRP831V1/lOV1+gbU0KiekG/t0Ub
	tcz0VomRXVeRnZnIfqvDJwYYA+lE8MKSuM8uZ09RKRvsHFSeuqcWO9nFJ2DBid8XutMkUoS+bME3K
	Jk+tE2hl26FgM+aJPaIgM/UKJo58PeV5xw1ReeE6ksEUZZkEwW7vKPR4QZJ4BSc0t3hwPK9+H1TZk
	hxt2nJIQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qNrWG-003Lam-0b;
	Mon, 24 Jul 2023 09:06:20 +0000
Received: from mail-wm1-f53.google.com ([209.85.128.53])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qNrWD-003LZr-1p
	for linux-nvme@lists.infradead.org;
	Mon, 24 Jul 2023 09:06:19 +0000
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-3fbb634882dso8133975e9.0
        for <linux-nvme@lists.infradead.org>; Mon, 24 Jul 2023 02:06:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690189574; x=1690794374;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QmGn4ZQf3FojYOwvSFsh5xrujW8n06HMs5La+mg2A7E=;
        b=KE1X7XCEbt8whvD/rLbP7G1XY1IGYxkZuHYSdqTs3T8gh+0nUo/P/QOZ86U5xX8K9J
         S3LSHn/7RSaT90XQUkcc4SBgO5dB2YKrOKGQaMyWMACTb3V/OEctgB1yB4g/lUq7L1Bz
         klLN5acpyWduEv+qtCBSYc6oREEGBzY1qTzGT1aGM3cwWWtZOKDQZotwg2aiXIJ3GQYR
         RZJ+0DTWPe4UViPd+VjLKgE2HkAD1LHhJ8q9DXfda0zf51VT9U7mEiBAILBjqw6T8YRP
         ngWVucgzu4nObLEmzYG41JZf7bxqQe8Yw1UA1R6v0g/tRMxIixmd5AuVs3HreB3hgOW4
         gqZQ==
X-Gm-Message-State: ABy/qLaRCNlfKpe87jHg1QN+MWPERbg6Ywxcnj2vyBuzxwC2OCgDW2Fe
	1YoQkBewqMw1PMspNx6lcl31xA6daeg=
X-Google-Smtp-Source: APBJJlEJxxleF8qBCPZQJybMrPSRviPtOxMg/WgRzbWIlPuXW2vm3OteI33nxvFp/UrXJ/+6jYyNBQ==
X-Received: by 2002:a05:600c:46c4:b0:3fb:aadc:41dc with SMTP id q4-20020a05600c46c400b003fbaadc41dcmr8325599wmo.4.1690189573668;
        Mon, 24 Jul 2023 02:06:13 -0700 (PDT)
Received: from localhost.localdomain (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id s15-20020a05600c044f00b003fbc89af035sm9777635wmb.17.2023.07.24.02.06.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jul 2023 02:06:13 -0700 (PDT)
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nvme@lists.infradead.org
Cc: Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Daniel Wagner <dwagner@suse.de>
Subject: [PATCH libnvme] fabrics: don't pass sqflow_disable if the kernel does not support the option
Date: Mon, 24 Jul 2023 12:06:11 +0300
Message-ID: <20230724090611.705366-1-sagi@grimberg.me>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230724_020617_659947_D29A685A 
X-CRM114-Status: GOOD (  13.69  )
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

Instead of retrying again without it.

Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
 src/nvme/fabrics.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/src/nvme/fabrics.c b/src/nvme/fabrics.c
index fd761d10d0cb..2a9d8dc7f23a 100644
--- a/src/nvme/fabrics.c
+++ b/src/nvme/fabrics.c
@@ -1026,7 +1026,7 @@ nvme_ctrl_t nvmf_connect_disc_entry(nvme_host_t h,
 		return NULL;
 	}
 
-	if (e->treq & NVMF_TREQ_DISABLE_SQFLOW)
+	if (e->treq & NVMF_TREQ_DISABLE_SQFLOW && h->r->options->disable_sqflow)
 		c->cfg.disable_sqflow = true;
 
 	if (e->trtype == NVMF_TRTYPE_TCP &&
@@ -1038,16 +1038,6 @@ nvme_ctrl_t nvmf_connect_disc_entry(nvme_host_t h,
 	if (!ret)
 		return c;
 
-	if (errno == EINVAL && c->cfg.disable_sqflow) {
-		errno = 0;
-		/* disable_sqflow is unrecognized option on older kernels */
-		nvme_msg(h->r, LOG_INFO, "failed to connect controller, "
-			 "retry with disabling SQ flow control\n");
-		c->cfg.disable_sqflow = false;
-		ret = nvmf_add_ctrl(h, c, cfg);
-		if (!ret)
-			return c;
-	}
 	nvme_free_ctrl(c);
 	return NULL;
 }
-- 
2.41.0


