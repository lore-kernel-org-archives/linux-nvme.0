Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BB43C6FD19
	for <linux-nvme@archiver.kernel.org>; Thu, 16 Mar 2023 11:50:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=jvstSV1hs9gw8dXTlAsmMiC+oPiB0B93XBXLmo76E+E=; b=L6UQwhUchFB9p+7NvE7JSRK8SN
	wGxIfsO5I/nGhygeOHR5uusK0ppzz2xsDvyUKoWqhxIrXEtPILAFg0Tv4lLH1OaddfzcE8DF2RdvP
	tsvkcKWDf9USDc7P/FV45zlgdvqHdJrIcWqTo5/I4s113SGAW/Fo7o5mS4FDI8BgYXajm0iWfCOTC
	w0IPsRZrsoH3nhj0NPeTXq6jgzroZsm/Iblev95ofKArG6GjMiNIHxDpbffK3FVAs3SXzx2NNVSA+
	jwB1Io3U9VrOJ5kE8fmUknN/SMTB0tHxLc5GEoyIJdXPMGcjrEGfY8jBKl6m1Qa8ROZ34mjmzao7F
	Y6BWEKqg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pcm7t-00GIkv-2R;
	Thu, 16 Mar 2023 11:50:33 +0000
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pcm7r-00GIkH-08
	for linux-nvme@lists.infradead.org;
	Thu, 16 Mar 2023 11:50:32 +0000
Received: by mail-pj1-x1034.google.com with SMTP id lr16-20020a17090b4b9000b0023f187954acso1319535pjb.2
        for <linux-nvme@lists.infradead.org>; Thu, 16 Mar 2023 04:50:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678967429;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jvstSV1hs9gw8dXTlAsmMiC+oPiB0B93XBXLmo76E+E=;
        b=lQ/PvEIn8dxTkLKfVOs6FOPcuzoCAQ4z5dff8f3F1465A0o3iTPN6Bz1AgJyXl9FnY
         ee7QH70tejeIgqMRZRYFPG/2O5ujpPnJ/PuOxRFdYqd3Km9oy2FuT6Rf9PJ4Wz1qNIyG
         Q9TVS2b7yb7VVIL1THBQMbW7UJPCxuPkjAmTqL8poXV4wT/mIx56xj3YfzzphlsaiGJ4
         4UrXrAGrQg/vMzq7cTg2cykbWPbuMYka29KUPQB90J7CEDnHBwzQvMtNM1zWCsUc4QqA
         o22c+5aordUTnf1/IzSOn899OOCM+aMJcb2Xmdjvo3MNcdb0ExjV/zL6ic9LkXxPSqgf
         owgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678967429;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jvstSV1hs9gw8dXTlAsmMiC+oPiB0B93XBXLmo76E+E=;
        b=a0mDZbLJrOY23hHovAQkVifNdmK3gj0HtZN09169Yvq33QmxpdVslBn/tbvORHFX8A
         vSWrlxy/HaQ0aJQLUjt7c2PKr1OKsYEaI//hqFnL/4+SilQHLVgY1uH8yXmN5x1P0gdm
         /fgsLkhC3KxH0+IT6HmvWMwsUn8Q0Vp4C9XyGbMZqDAV4mjnDy5x2ob/vCPH8auubgqP
         3BWNX2ZqfusJYdaxOjN39IeEzJqFyJZF9w1zxpH+CcsYpBAeZWLnWs0DVhz9ZbXGlfg7
         fZYff0iLg+oqz10DHBr1yFWrukJZJxVENFRamk6VgW140LXiZwAgou65OGOEN/OMD/3/
         mQ0Q==
X-Gm-Message-State: AO0yUKUZjHsAQhWCPgUd6L2MFCvOf0odlTJTyQGOBpcfgvvdqDy/hXK5
	dCLwREaUSEqm2kjPoN/kQzw=
X-Google-Smtp-Source: AK7set9AFtEtMMB7RPdiPHfgX6Y4vbCkeDGaJub8RjXRocoKH/9dkKAoEyMJ1bul1CCYIOp9fng7Yg==
X-Received: by 2002:a17:903:110f:b0:1a0:6139:e9d6 with SMTP id n15-20020a170903110f00b001a06139e9d6mr3591127plh.53.1678967429329;
        Thu, 16 Mar 2023 04:50:29 -0700 (PDT)
Received: from gooner.. ([171.76.80.150])
        by smtp.gmail.com with ESMTPSA id ke16-20020a170903341000b0019928ce257dsm5419008plb.99.2023.03.16.04.50.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Mar 2023 04:50:28 -0700 (PDT)
From: Martin George <martinus.gpy@gmail.com>
X-Google-Original-From: Martin George <marting@netapp.com>
To: hch@lst.de
Cc: linux-nvme@lists.infradead.org,
	Martin George <marting@netapp.com>
Subject: [PATCH] nvme-core: send identify with CNS 06h to IOCs alone
Date: Thu, 16 Mar 2023 17:20:09 +0530
Message-Id: <20230316115009.2668-1-marting@netapp.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230316_045031_081632_2BD8DA70 
X-CRM114-Status: GOOD (  10.44  )
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

Identify command with CNS 06h (i/o command set specific identify
controller data structure) is supported only on i/o controllers.
But nvme_init_non_mdts_limits() currently invokes this on all
controllers. So correct this by ensuring this is sent to i/o
controllers alone.

Signed-off-by: Martin George <marting@netapp.com>
---
 drivers/nvme/host/core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index d4be525f8100..1894aa993313 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3063,7 +3063,8 @@ static int nvme_init_non_mdts_limits(struct nvme_ctrl *ctrl)
 	else
 		ctrl->max_zeroes_sectors = 0;
 
-	if (nvme_ctrl_limited_cns(ctrl))
+	if ((ctrl->subsys->subtype != NVME_NQN_NVME) ||
+	    (nvme_ctrl_limited_cns(ctrl)))
 		return 0;
 
 	id = kzalloc(sizeof(*id), GFP_KERNEL);
-- 
2.34.1


