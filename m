Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07E64CD5BC9
	for <linux-nvme@archiver.kernel.org>; Thu, 28 May 2026 01:43:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=QYdtLIYZ2k9Licc99EchWmK+5CZZbIedrHJtohMWcUg=; b=rCGoUoiuvD/DrnPBQ6rYx1FriG
	mChV47StsDatrSLJ+BODFpUwXWJzNgk8amfBL2gbXoEZkKiEgELN+Uq5RBw8DmoyESp0Vluqm3jOi
	t/vsM8jg25w8j0yxU1dTba3Q4MDEsVj4nt2+Gga3ebMvk+B364Nm+6FfYH0qhUn3Ne7BHUd4WrUKX
	p5kDOygckH6JSTEPjcDIECz3fuoo/f8xnlQKrni6kvZ0TghqryDxio37vCJfAY9JjovB00Zq5105v
	Z3SsSBiFETooAh2U1j4A/WoEfYUhXEqK56c+4PmKOTDtn6emBq78sh4HPruW3YO/dreqp7svquHRs
	+FFEDCAw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wSPmT-00000004xGH-1rzr;
	Thu, 28 May 2026 01:43:29 +0000
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wSPmQ-00000004xFD-48FJ
	for linux-nvme@lists.infradead.org;
	Thu, 28 May 2026 01:43:28 +0000
Received: by mail-pj1-x1031.google.com with SMTP id 98e67ed59e1d1-36a7bbb9698so3321348a91.2
        for <linux-nvme@lists.infradead.org>; Wed, 27 May 2026 18:43:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779932606; x=1780537406; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QYdtLIYZ2k9Licc99EchWmK+5CZZbIedrHJtohMWcUg=;
        b=IvxVt7qFQYU029brwyMgOcY+q4lWU02Rc8DaEs0sdwn5v2JRaN9ooevrrrnZ5EJkN/
         iyYqq/fnEWRLiOGGV/t3D4IFi4I61TLJu9JyUQvRi1m6CiySl2n/ASHUAu/AXCYWPJU8
         GevOQgfBELJK/mjqsl8v3EQySV2qIAvX+hkoI6QT4kf2BWCPlSlm23VKWqNppFWwef0Z
         v/NEzx0Xhp2Sn996iBi9C70T/PckPDVRqQ77qVxlCYQ7qOfxnkxrXVX6xomsJ18Jyiy9
         HX1pT4653RPF1yGhLK+yIJsppO+IuYFGqhk58MAfKovbjLcJvX/SSAOtyztbZwO/BcPr
         Es1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779932606; x=1780537406;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QYdtLIYZ2k9Licc99EchWmK+5CZZbIedrHJtohMWcUg=;
        b=VMpJjiN527YjeNxwK92J6r73eF0KrnC9iOvhu4LnOw8JseiUmAgL+d0YNRjxhOlrsE
         PLRJGNzvOqScsd+/7eMb8M8qs8MT6isbngoQ08MUaIg6uPViZ+ubcq9MsZ5VDXLbebcA
         P8q9ft4BtqDh+/oRJiay6TPEDTGK6D1Zdor7S14BZNY/N018+tPgUnwzELe6xM99DyJg
         80eknMAobHY230s9WKm3dNm6H4HYR5cEp/r7QQISW1FEKGQw6UVoVwceC/RUt/pm1Y1s
         +r56mQQ6MF6gf0D7z93gKB8Y8ROJLiHu6qwFR8ocKusg1gsRUPB+vVqrxUMEdaHSwOKO
         GE8g==
X-Gm-Message-State: AOJu0YzLySqrTQJA1XoeKJA7THuyHzc9edmmEQpz8QuRLRwZPeAILMKn
	nWBvuP6lL90HCzlp2q4UiSnlZfiGrvQBLwaS5vl6Y7coQdu6RlvT89Ceb+ULdMU0n0w=
X-Gm-Gg: Acq92OHnLXx4NIYfJDLoshekWeUMyl9sbY2b3M3V5VBi2Zzn6AKRIFbE7vBZOe+kPUS
	xK0417H23wiLFMbnPAv8DHHaCq9esMjncT37pzJSuLpayG6Pm326/N09NO79rIdVEOYJcDiyGlD
	Z5pBV9Rx9UF5Apj8CrtsBYKfPwHxlLLI/kIQp9VN0vK2MP668dHADImndQzgyAXwOpSABHamWTO
	tOQjzlbjdFbfNjHDKhmEU8wpVtQqfSVy7fEZn45N/jnP6XDltJGlSKC8jb2hJZ6q6aJ2TMaNkAn
	zM8Xetzt20a1J45nCr1OklkXXu+vQOQm7xqx9JQFOF7d2xq8UKS4ylR2glmPMoRRwaD/XG/q4NY
	oqja5XSz564bUukvAr6sItZTSxrDDpXZdy9xg0o9/89lrSxoOZImNJrigtaYpnQQThzkr8KEy99
	4x6cf5DqWMT4OzQo+9uS1TCYYh04ZW
X-Received: by 2002:a17:90b:37cc:b0:36a:aa9:eea0 with SMTP id 98e67ed59e1d1-36a6749e856mr23704177a91.4.1779932606047;
        Wed, 27 May 2026 18:43:26 -0700 (PDT)
Received: from [127.0.1.1] ([221.238.56.51])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36b908e4013sm214003a91.1.2026.05.27.18.43.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 18:43:25 -0700 (PDT)
From: liuxixin <gliuxen@gmail.com>
To: linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me, linux-kernel@vger.kernel.org, gliuxen@gmail.com
Subject: [PATCH v3 1/2] nvme: fix FDP fdpcidx bounds check
Date: Thu, 28 May 2026 09:43:24 +0800
Message-ID: <820c56d3908ffa2726e38c31eeb5d3d7701fc590.1779930057.git.gliuxen@gmail.com>
In-Reply-To: <cover.1779930057.git.gliuxen@gmail.com>
References: <20260527133205.GA12042@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailer: send-local.py
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260527_184327_029810_2C596A31 
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

	<cover.1779930057.git.gliuxen@gmail.com>
From: liuxixin <gliuxen@gmail.com>
Date: Thu, 28 May 2026 09:00:36 +0800
Subject: [PATCH v3 1/2] nvme: fix FDP fdpcidx bounds check

The fdpcidx bounds check sets n = NUMFDPC + 1 but used > instead of >=,
incorrectly accepting fdp_idx when it equals n (i.e. NUMFDPC + 1).

Fixes: 30b5f20bb2dd ("nvme: register fdp parameters with the block layer")
Reviewed-by: Nitesh Shetty <nj.shetty@samsung.com>
Signed-off-by: liuxixin <gliuxen@gmail.com>
---
 drivers/nvme/host/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index c3032d6ad..766157ba6 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2263,7 +2263,7 @@ static int nvme_query_fdp_granularity(struct nvme_ctrl *ctrl,
 	}
 
 	n = le16_to_cpu(h->numfdpc) + 1;
-	if (fdp_idx > n) {
+	if (fdp_idx >= n) {
 		dev_warn(ctrl->device, "FDP index:%d out of range:%d\n",
 			 fdp_idx, n);
 		/* Proceed without registering FDP streams */
-- 
2.43.0


