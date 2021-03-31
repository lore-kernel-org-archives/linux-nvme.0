Return-Path: <SRS0=yFSL=I5=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAD4AC433DB
	for <linux-nvme@archiver.kernel.org>; Wed, 31 Mar 2021 03:43:39 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B0C56195C
	for <linux-nvme@archiver.kernel.org>; Wed, 31 Mar 2021 03:43:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B0C56195C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=uj1PdUjUYW0V2cvsU0HtFlKmGDi1tnu12/jmWCSA00E=; b=M+4a5LxwiXjMC2UMHya02oCdRX
	Ti9PwNBmzEa3n68/pxGcSaCUKOJ3LOgAQPn98ubYO7pQt4y6kuMVCH1Y0f9F/nprXuKju2Q4SrFao
	O+fPivc4JFBMTiP2NeZhszPuX8mVHsEwciJq6BHL8HMqo8saTYIdCWUVGdATbkecbAUUSnZNzhXYs
	lmeM8CR+aSV0SVfwJBJxXTwi5RQ8tWUmYILD8kbJZc/QnKt9MNa+VH69dYBukekpui8s/QommXqfP
	iEb0dZuxG42mQ98xMgsoGJkLOHhEr1KqnY8IJrbCkr5w5eZe1zrT98we2+TlONZeDsILOhgC5wHhi
	Uxgiyw4g==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lRRlH-005Pzo-CB; Wed, 31 Mar 2021 03:43:19 +0000
Received: from mail-pf1-f174.google.com ([209.85.210.174])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lRRlB-005PzT-LN
 for linux-nvme@lists.infradead.org; Wed, 31 Mar 2021 03:43:15 +0000
Received: by mail-pf1-f174.google.com with SMTP id m11so13557992pfc.11
 for <linux-nvme@lists.infradead.org>; Tue, 30 Mar 2021 20:43:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=0YZ/44Fi+xxLPv3IaVcOXL9gQsvF66ubT2EmXKdMsuw=;
 b=Z4CDIuy9F6VD39qyd6Ee5IWKfr+uL+db1hNZtJ2zHY/B7Zc+ySRw9sAK38VnHmL3UJ
 lmeAC1IIsxYbDrEHerbYRNQ8ht83l2MRjRAZV0lOePo/VRZjnPN9oStZ8Atvj5U2gEUM
 no10w1/3pjM9rrtb5NkQrrydfk1kao4IBI9MdZrp21BPa8t6lzCCHfsRc3aSp01G4Iys
 Mwtywc0saBTb2fTnRJ9iN1R5eQRw34xde2aaN4xZ3dTQGpVUP7GVo4qYEnYSHcUVNGCH
 CdPwscZBx7OW3r4ixxl9+Z22XtgOCa1QKOyDQmBBvyL0pxMZlvi5Muee2fXotg6ChPW2
 j+wg==
X-Gm-Message-State: AOAM532PNRzgtWKUcVkV0SrQQxFlv97iVxtHv6hqiUqkSplMcZLqRdU3
 l8SNiMgFixguFPz9FVX5JWNsWJPdrJU=
X-Google-Smtp-Source: ABdhPJxHRC2v1BOduJmmv3ARW0AEZQxUfaCjuQVBRdIsnFsz9zLmsG/lSPBe6JsZiBj8IXYdDpdKmw==
X-Received: by 2002:aa7:94ad:0:b029:1ef:2392:4ee8 with SMTP id
 a13-20020aa794ad0000b02901ef23924ee8mr1030653pfl.75.1617162189762; 
 Tue, 30 Mar 2021 20:43:09 -0700 (PDT)
Received: from asus.hsd1.ca.comcast.net
 ([2601:647:4000:d7:9743:2a26:e471:8a89])
 by smtp.gmail.com with ESMTPSA id 15sm408328pfx.167.2021.03.30.20.43.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Mar 2021 20:43:08 -0700 (PDT)
From: Bart Van Assche <bvanassche@acm.org>
To: Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org,
 Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH] nvme: Report MDTS values that are too large
Date: Tue, 30 Mar 2021 20:42:14 -0700
Message-Id: <20210331034214.5792-1-bvanassche@acm.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210331_044313_842020_A41D5822 
X-CRM114-Status: GOOD (  11.37  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Instead of triggering an integer overflow and undefined behavior if MDTS is
too large, set max_hw_sectors to UINT_MAX and log an error message.

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/nvme/host/core.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 40215a0246e4..0edbc8c125a7 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3123,10 +3123,14 @@ static int nvme_init_identify(struct nvme_ctrl *ctrl)
 
 	atomic_set(&ctrl->abort_limit, id->acl + 1);
 	ctrl->vwc = id->vwc;
-	if (id->mdts)
-		max_hw_sectors = 1 << (id->mdts + page_shift - 9);
-	else
+	max_hw_sectors = UINT_MAX;
+	if (id->mdts && check_shl_overflow(1U, id->mdts + page_shift - 9,
+					   &max_hw_sectors)) {
+		dev_err(ctrl->device,
+			"MDTS = %u is too large (page_shift = %u)\n",
+			id->mdts, page_shift);
 		max_hw_sectors = UINT_MAX;
+	}
 	ctrl->max_hw_sectors =
 		min_not_zero(ctrl->max_hw_sectors, max_hw_sectors);
 

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
