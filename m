Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42CEAC00140
	for <linux-nvme@archiver.kernel.org>; Wed, 10 Aug 2022 13:41:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=IyZuXwvWxfkgzhF4RsrPMJZKJwH00vPO7yyEdw3/HlU=; b=cVbTjH4UJOlwg+6A+/mB/W9VnG
	2J/g9B+Djiz5AM6pEXPRTEY6kNXwxYQDbILOmnjnsScszDGVRnUV75UY6xFXaTbXEAMW+XjG4XCs6
	B3eyDUEfCERIUxmZcstiJwSa6wAJ8e/dbg51skZhr+GOhi57bJOaJqHef0B1kw40DsRCr9MGhYR20
	H7wv6VtrygemyZr9AKeNrb2KI2MZ2YChaswa4+SePPMfJ05CQTKYZ1BwKty+Xtq5xN1FttrhX7Qvy
	UqGDmI2qnHUFlQ03ipwbyBxiO1e5HAGOdetDkFS8Yzp7khvAJhZW/rSYHyjr63rpuAWciZiJW6jRq
	6IKDnEHA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oLlxU-00C66F-Dh; Wed, 10 Aug 2022 13:41:16 +0000
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oLlxD-00C5wz-W7
	for linux-nvme@lists.infradead.org; Wed, 10 Aug 2022 13:41:03 +0000
Received: by mail-pj1-x1036.google.com with SMTP id q9-20020a17090a2dc900b001f58bcaca95so2235859pjm.3
        for <linux-nvme@lists.infradead.org>; Wed, 10 Aug 2022 06:40:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=IyZuXwvWxfkgzhF4RsrPMJZKJwH00vPO7yyEdw3/HlU=;
        b=ntBoPYazYax6r+0qruxmbOuxL4Quz3/W4JD/frVfAWX5FLJeldi7Kf67t1zu8kWyhg
         D1CTRuLF1AdfTtu4+q/ViZUx2EYsycML1zowouHBWwdm2kFD1y/ETa5c7BK/n7AeWCGh
         25VjN9PyZmAcPKMNrNToRhoPCM3LpSsMBGYH//dodvco7MUS6ROxfJC/1wJcQo90oXc1
         i8lacWkOrJt5rJQx+/59O5XTOh5sdT0vU/Zjd1+1bkwhIaheXTK37lr37tBOUCe4g2MA
         so9+IdGuE44IwtigMXYJ+K4nfMpFOS/Bj14zNu2k5sqrLeQPGv1y84Xs+7EDCT4Eg4Ya
         9OKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=IyZuXwvWxfkgzhF4RsrPMJZKJwH00vPO7yyEdw3/HlU=;
        b=aoEVUjiB/O3M2mKE7ClCZLuwE0lPayO47ENs7iW7CHT2iSqSRDMbS7MTpLKxFfU16o
         G5th7skqkx/AI0xXD5WYkZ1aBeHJSbrBl3KqhqrqFENNHs+COSAHYjNXh/2NCRHFSEY3
         nT1+4uXNPemDhTqvyDXfS86vScyf69R9j1xs1NVWYatqFH0u06+4AMTdF/ZDyjbtzt6L
         jqgPGMUEYC2H0BjPfjsIlGA7zF8Bg+k1vXWlVcR5U5F51/Q/+mfianuroFYgZIrcJKAm
         9qEsDhkNUcIbBw3zLBPFFIZ0BDVswRZUu0PdizQGWCj+fhVBmtVMHUMp0C06ZUGUkk3g
         +2ZA==
X-Gm-Message-State: ACgBeo353cLshx6RS42VISE6FC9SSBmIW+d+nLtQfbIdojj4TebX/MUX
	XgN3bv1N4imRlfA+iKTvjO0=
X-Google-Smtp-Source: AA6agR50lS+v70l8L54U1MD/Aa7s1ADUymKDg/apa/H8HaUHjIpyM0gFNZxxl2s+u6o4hQctVzKLUw==
X-Received: by 2002:a17:90b:38c9:b0:1f7:28bb:aa16 with SMTP id nn9-20020a17090b38c900b001f728bbaa16mr3798436pjb.201.1660138854073;
        Wed, 10 Aug 2022 06:40:54 -0700 (PDT)
Received: from pipi-desktop.testerjoe ([101.88.11.237])
        by smtp.gmail.com with ESMTPSA id f23-20020aa79697000000b0052d4487ae7fsm1969999pfk.27.2022.08.10.06.40.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Aug 2022 06:40:53 -0700 (PDT)
From: Linjun Bao <meljbao@gmail.com>
To: 
Cc: Linjun Bao <meljbao@gmail.com>,
	Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@fb.com>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] nvme: align "fake" nqn with spec 1.3
Date: Wed, 10 Aug 2022 21:39:54 +0800
Message-Id: <20220810133953.5411-1-meljbao@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220810_064101_857410_090400E8 
X-CRM114-Status: GOOD (  10.40  )
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

Replace '.' with '-' to align "fake" nqn format with nvme spec 1.3 or newer.

Signed-off-by: Linjun Bao <meljbao@gmail.com>
---
 drivers/nvme/host/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index d2ea6ca37c41..d6fb91bbcf9e 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2504,7 +2504,7 @@ static void nvme_init_subnqn(struct nvme_subsystem *subsys, struct nvme_ctrl *ct
 
 	/* Generate a "fake" NQN per Figure 254 in NVMe 1.3 + ECN 001 */
 	off = snprintf(subsys->subnqn, NVMF_NQN_SIZE,
-			"nqn.2014.08.org.nvmexpress:%04x%04x",
+			"nqn.2014-08.org.nvmexpress:%04x%04x",
 			le16_to_cpu(id->vid), le16_to_cpu(id->ssvid));
 	memcpy(subsys->subnqn + off, id->sn, sizeof(id->sn));
 	off += sizeof(id->sn);
-- 
2.25.1


