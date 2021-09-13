Return-Path: <SRS0=T5dq=OD=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB6C1C433F5
	for <linux-nvme@archiver.kernel.org>; Mon, 13 Sep 2021 15:31:25 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 750B461056
	for <linux-nvme@archiver.kernel.org>; Mon, 13 Sep 2021 15:31:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 750B461056
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=LWTwNNfIkiTu12ECJeWJdXF4qZh6ZoxV8l1om/s+nCI=; b=ZNCNHjZla+BSWx
	Dm6Ht+SvjWxabXBoRpV5QqSjrwap71E/GKN/OHUz0tKixYriKU5oLT/XVukq+broz3TGGBClT9Yj8
	8j0i1vZcEP6wY5OoelVMF0iA/cVZZAtyHi/2jh6eI43abz937bPyHB6/zsQxFh726TgrkqOpAQ75Y
	yYIOil7cM+3d4rywDXmB0nYKOjCmg2V2upuerF15UV8vzJc0RDGICUZdOQrenEA/t6di+grNJNewl
	GzOWMQvaK3LRP3fdubFdjV387mnesrqK9069zaUMhST5fBv4NINDS6LniclK4rSvhjAjttXPAk93r
	zS3C5/a3trHulOe5aioQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mPnvX-002Aye-7Q; Mon, 13 Sep 2021 15:31:23 +0000
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mPnvG-002Aw9-G4
 for linux-nvme@lists.infradead.org; Mon, 13 Sep 2021 15:31:07 +0000
Received: by mail-wr1-x42c.google.com with SMTP id w29so14579930wra.8
 for <linux-nvme@lists.infradead.org>; Mon, 13 Sep 2021 08:31:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=pCT0QorwpS7G+5MsAUIRUF3wCwS3K59GE+8Pf7OGEeg=;
 b=kTR19SvKdxwBrcoud+IxlVL9SLYywtt3NLJ5vWabAlNZfwiccih4sjeVmBPdlDGKFO
 sR/nCA7XBadExUFvHZiGpFve43engd5qf3e/fUv9TFj8JGYzYe6s894GtE/Kma5hQrGi
 01QJnoRnPfds9lXlx+H8dd1wA23RLNeLtDWLvqEhXeNYk28vxVHgLAanV9BtetLUB9m7
 EcofJyujpW4hgIWg8aSHNvMqs70xerqdjVsbg0z72ALTiyoBoD7LxIlP9vGPoEqluOu5
 EFZnU8XRdYlKldbxQgdO/XukNdNyZdcZwJy77xbEtdtg4x1/e0SHgYpOWpagbNJfCWwX
 U3NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=pCT0QorwpS7G+5MsAUIRUF3wCwS3K59GE+8Pf7OGEeg=;
 b=ftLcbu9Je9/jUfPy+t87CczpYNP95R3AFTsF1SY3pYGlT9tUEAUEebZ8CBSgX/GsA1
 b3FuM6QCexBVFJx1WuoqU0B2/vFTDCfHeKhUE4vI6R+6yy7kddeFi7yLICevyChDp4dl
 TUhFytAP3DlLFX3I81u8cNDyI7r+hKBCqwUZ9hRHPzaB6XcviDLywf6zbEVe3tJwiCri
 MeA5duEmkfpYHkanibq53ClvCaTvMc0wbzYFkmXe3TBdU/kRMNCnXBss+Rc76HWzILbY
 IXcrpAPjkpZPuG4/n7RmCKnGVQ5uPteFi2NWblWgnXIIyFzjDHpYZDIAx7sLEttq0cQJ
 BW+A==
X-Gm-Message-State: AOAM533LbmNgxu7Z1HAeAfHJYXwOiqCwDL/89hidwO/LF7KdfiH5KDSm
 ToINS+XpBhnt9PNkgKLYgXOwaBD/KlT3HQ==
X-Google-Smtp-Source: ABdhPJx+lJArk72hCRP/HuUTOamCcL4O3eyAIGLz7C0KUA6U6NWB107WeVMaGNMza90/4EkDPQcgsg==
X-Received: by 2002:adf:c14c:: with SMTP id w12mr13492285wre.115.1631547064384; 
 Mon, 13 Sep 2021 08:31:04 -0700 (PDT)
Received: from anton-latitude..lbits (c-76-23-2-87.hsd1.ut.comcast.net.
 [76.23.2.87])
 by smtp.googlemail.com with ESMTPSA id h8sm7054087wmb.35.2021.09.13.08.31.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Sep 2021 08:31:03 -0700 (PDT)
From: Anton Eidelman <anton.eidelman@gmail.com>
X-Google-Original-From: Anton Eidelman <anton@lightbitslabs.com>
To: linux-nvme@lists.infradead.org, hch@lst.de, kbusch@kernel.org,
 sagi@grimberg.me, axboe@fb.com
Cc: Anton Eidelman <anton@lightbitslabs.com>
Subject: [PATCH v2 2/3] nvme/multipath: cosmetic: keep ns nsid locally
Date: Mon, 13 Sep 2021 09:30:22 -0600
Message-Id: <20210913153023.70879-3-anton@lightbitslabs.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210913153023.70879-1-anton@lightbitslabs.com>
References: <20210912185459.13496-4-anton@lightbitslabs.com>
 <20210913153023.70879-1-anton@lightbitslabs.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210913_083106_580525_90F07454 
X-CRM114-Status: GOOD (  12.74  )
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

Keep the nsid of the current namespace in a local variable.
Change the type to unsigned int to make checkpatch happy.

Signed-off-by: Anton Eidelman <anton@lightbitslabs.com>
---
 drivers/nvme/host/multipath.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index e8ccdd398f78..a51561d67b93 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -600,16 +600,18 @@ static int nvme_update_ana_state(struct nvme_ctrl *ctrl,
 
 	down_read(&ctrl->namespaces_rwsem);
 	list_for_each_entry(ns, &ctrl->namespaces, list) {
-		unsigned nsid;
+		unsigned int nsid;
+		unsigned int ns_nsid = ns->head->ns_id;
+
 again:
 		nsid = le32_to_cpu(desc->nsids[n]);
-		if (ns->head->ns_id < nsid)
+		if (ns_nsid < nsid)
 			continue;
-		if (ns->head->ns_id == nsid)
+		if (ns_nsid == nsid)
 			nvme_update_ns_ana_state(desc, ns);
 		if (++n == nr_nsids)
 			break;
-		if (ns->head->ns_id > nsid)
+		if (ns_nsid > nsid)
 			goto again;
 	}
 	up_read(&ctrl->namespaces_rwsem);
-- 
2.25.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
