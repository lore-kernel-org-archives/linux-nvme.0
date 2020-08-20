Return-Path: <SRS0=ANWg=B6=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFFBBC433E1
	for <linux-nvme@archiver.kernel.org>; Thu, 20 Aug 2020 05:37:10 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B4FB2072D
	for <linux-nvme@archiver.kernel.org>; Thu, 20 Aug 2020 05:37:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="cM55YV1D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B4FB2072D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe
	:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:To:From:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=yPYc6ouDujUWAfZQFZwb62vpgLrGGUx8vg/Xa02zX98=; b=cM55YV1D+S4oTQK/koRWZrjqN7
	9YPzEeWa+kiLbLv1dVaoECE2E66Xf54qeTUlyWvMawvIOwMdvAA8PxIhhwh5X9o5JkOSpjXOR23Uo
	TKAaXcEW6rMyrw4J6pAS4kORuCqM5ZYQo2VLRZVV8/QXkZlxjvdCKg3g0j59JWL4gGDEPbBkcbSUe
	GAMdIye/ueM3qkVqoeqdz+XauhaSB7udkaNR76qpDbWzvuW4MYS6O9CezEjJ+hSN1IYBMZ2tGbX7e
	8xI0eN0Z4tpUlQqpqoq10dFrWdQ7rX8ZdgZG1Df6G3PAlo/5g1TZAOOcXNZCMUOpDwNEyfaf9Mu6Y
	UZmPwrEQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k8dG8-0000c9-5h; Thu, 20 Aug 2020 05:37:08 +0000
Received: from mail-wm1-f67.google.com ([209.85.128.67])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k8dG5-0000b7-Fk
 for linux-nvme@lists.infradead.org; Thu, 20 Aug 2020 05:37:06 +0000
Received: by mail-wm1-f67.google.com with SMTP id c80so506852wme.0
 for <linux-nvme@lists.infradead.org>; Wed, 19 Aug 2020 22:37:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=5pE393Ek5z+MuEeWHl2JitKX1q1kya0niVW4iDDJUG4=;
 b=TRwkzIBi1IdOKrGAvacJ3+zVSTx72k3DulCu32GC/nvEntbokmqjvZQ+LJmwfYJIpA
 +lAd6VBF5ze+cbMgLh4q2T+1sjqTpXLFHq4tUSjSkXe4e5rB4LjD0apLrQqo/YtEr2G2
 PpoHSGvvL8U+X6FDOQ/GdIgcLZvfy/WizvGC/itKkom6T98CRy4+9OtAqTL4luDa0H7u
 cjz908aJNJPgJvcSS+ssS3B6xlvzTGY4aCfZBzEiqFUSo4OvbN7VydZMBdhVHypbxEqU
 tGBWgSIkpX5M14ZhkYZCb8St//i+c3wLtpwuLCUUxUvUqbh/7WrerigUoSinO13U/ZUf
 cy1A==
X-Gm-Message-State: AOAM533DF4kfwKmG0AIPXaWu174jSkNp8C1RPsnVJTkEoiY+S2qjMUdL
 RJrKPTLISVIve/rp6bdMTbb9Ut8/5T5yXg==
X-Google-Smtp-Source: ABdhPJxC3odfXpnGUbyBl3f2LAy9H3bxUB0KtGfh8u0yVLiAa/1GBeqTsm8zRHVJWownYrZSpuxK7g==
X-Received: by 2002:a1c:6083:: with SMTP id u125mr1655001wmb.161.1597901824123; 
 Wed, 19 Aug 2020 22:37:04 -0700 (PDT)
Received: from localhost.localdomain ([2601:647:4802:9070:7ced:8569:4373:1bd3])
 by smtp.gmail.com with ESMTPSA id a10sm1900353wro.35.2020.08.19.22.37.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Aug 2020 22:37:03 -0700 (PDT)
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
 Keith Busch <kbusch@kernel.org>, James Smart <james.smart@broadcom.com>
Subject: [PATCH v3 1/9] nvme-fabrics: don't check state NVME_CTRL_NEW for
 request acceptance
Date: Wed, 19 Aug 2020 22:36:43 -0700
Message-Id: <20200820053651.197057-2-sagi@grimberg.me>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200820053651.197057-1-sagi@grimberg.me>
References: <20200820053651.197057-1-sagi@grimberg.me>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200820_013705_535774_7ACDF266 
X-CRM114-Status: GOOD (  13.52  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
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

NVME_CTRL_NEW should never see any I/O, because in order to start
initialization it has to transition to NVME_CTRL_CONNECTING and from
there it will never return to this state.

Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/host/fabrics.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
index 4ec4829d6233..32f61fc5f4c5 100644
--- a/drivers/nvme/host/fabrics.c
+++ b/drivers/nvme/host/fabrics.c
@@ -576,7 +576,6 @@ bool __nvmf_check_ready(struct nvme_ctrl *ctrl, struct request *rq,
 	 * which is require to set the queue live in the appropinquate states.
 	 */
 	switch (ctrl->state) {
-	case NVME_CTRL_NEW:
 	case NVME_CTRL_CONNECTING:
 		if (nvme_is_fabrics(req->cmd) &&
 		    req->cmd->fabrics.fctype == nvme_fabrics_type_connect)
-- 
2.25.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
