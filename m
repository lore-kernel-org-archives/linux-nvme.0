Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1779EC28D13
	for <linux-nvme@archiver.kernel.org>; Tue, 23 Aug 2022 02:15:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=B0JpBG7vfvINdfy3QKpBmCt4CGFBZCPyhAEjcgH4wpY=; b=usRTKP1i2IjGLx4cfbk0ZxeFtO
	XrX2RnQMrjknulXl49MGX7AVQ4BhugzcSa4UatWW6uHwjtwnrhRlGJTseQsqr9R2jbSxPDda9a/d9
	0Cw0v/G/Bd00mvILB9L8eiV6sW0Xin/h0CD2Z2hH/T8meQjrk3LfXhwSqt+XQOTVn0TcILnMI3rZk
	C9b/VBF5FGP0p3kllbppcGPgrqFEIBnKcuyA9FIO2BTY49wvZ0tRNqkznJDOMqjCgSBfh1q4hDuQs
	jD9ZknzXWCBCiAkcHoIfI6lIbDHjvhOi4XyJqjPSTePAFQyYItupkmKhnLtRLuPx+tZyDzQXEFWHE
	njyZAzuA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oQJS9-000Crp-PK; Tue, 23 Aug 2022 02:15:41 +0000
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oQJS6-000Cky-EQ
	for linux-nvme@lists.infradead.org; Tue, 23 Aug 2022 02:15:39 +0000
Received: by mail-pl1-x644.google.com with SMTP id jm11so11543965plb.13
        for <linux-nvme@lists.infradead.org>; Mon, 22 Aug 2022 19:15:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=B0JpBG7vfvINdfy3QKpBmCt4CGFBZCPyhAEjcgH4wpY=;
        b=IoHx2leDlH1m3usj9yAsA2ml/T5wMRc+Ddg+YSiAwua3ncg90a+cxcZNr2I+Pnndah
         0qC6stFRHN2B31JdNYH4Ah29U7AfhLGu6a3lw3O2/BxeHpgbaAmjAcZVfI2OJq9MwPCb
         2Wg8XJ2wWUPCOziO6QqYy5ESZ+gpuUiDUt/qD1YdiwHqoC5CWMb74Mp1Zil9T+ya1fSs
         XX/9m6j4ZTYF05KJ6v8CftWr12Ps2ALlhRkheafdOpUJgc62Kzcxk5WvxrTSH0dNLntc
         SBL3nVeGya3nQOWe0mvLOlcVaXWBf9tuTTOE/VNyAXyoMlr4JPyACEYh+sOxwoVLQmuM
         cyPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=B0JpBG7vfvINdfy3QKpBmCt4CGFBZCPyhAEjcgH4wpY=;
        b=1/kc9JYLNnSvFKw2aUyOFHIj9qGMUfi1A8opA0SQ25svYGbOPfstcH2AsDYNMvgo8U
         sY4haavotWawRK3L7KxEpEaZZKdT9Mablx4VOnU1Iy7yQIGLvKScYmdo674j9b547lEq
         kMj2GwtCvAgfomkS1Jokwf0lbvskwmwPrk1xl32qJzNc5kb+50ebtGzXhhl6XkNVUUnp
         +afXp9Eff33cuMcbWQ9pEpBi7ZwdJaJppbiGVbnvDBEkHAI69VljE/Ls7+HC30hZXgto
         T0VYBHs4hW7IcBq9sQcOjbzOHcYcXNGZv1Y7M3hXJP3kJ19Sf0MRhjBoUqddjrkWjPf8
         M65Q==
X-Gm-Message-State: ACgBeo3rfJWYIYBgnJfymSqGtKtWHIapAfBj1AbUJI+/K0lSVLPWlb7T
	KyFYYHMpf3zdXSYWmIbKwGI=
X-Google-Smtp-Source: AA6agR4KgiV9ISu+QYM0ZotHbgkMBxHsRLvuLR2wTHfHoMQ9ysl6CCm5zMRJjzu2UOYTnSZZytGrBQ==
X-Received: by 2002:a17:902:8605:b0:16b:e755:3c6e with SMTP id f5-20020a170902860500b0016be7553c6emr22523021plo.42.1661220934878;
        Mon, 22 Aug 2022 19:15:34 -0700 (PDT)
Received: from localhost.localdomain ([103.181.13.196])
        by smtp.gmail.com with ESMTPSA id b2-20020a170902d50200b0016a0bf0ce32sm9138171plg.70.2022.08.22.19.15.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Aug 2022 19:15:34 -0700 (PDT)
From: Genjian <zhanggenjian123@gmail.com>
X-Google-Original-From: Genjian <zhanggenjian@kylinos.cn>
To: hch@lst.de,
	sagi@grimberg.me,
	kch@nvidia.com
Cc: linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	zhanggenjian123@gmail.com,
	Genjian Zhang <zhanggenjian@kylinos.cn>
Subject: [PATCH v2] nvmet-auth: remove redundant parameters req
Date: Tue, 23 Aug 2022 10:14:41 +0800
Message-Id: <20220823021441.968488-1-zhanggenjian@kylinos.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220822_191538_526079_5384E37D 
X-CRM114-Status: GOOD (  11.99  )
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

From: Genjian Zhang <zhanggenjian@kylinos.cn>

The parameter is not used in this function, so remove it.

Signed-off-by: Genjian Zhang <zhanggenjian@kylinos.cn>
---
 drivers/nvme/target/fabrics-cmd-auth.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/target/fabrics-cmd-auth.c b/drivers/nvme/target/fabrics-cmd-auth.c
index ebdf9aa81041..e467be86db78 100644
--- a/drivers/nvme/target/fabrics-cmd-auth.c
+++ b/drivers/nvme/target/fabrics-cmd-auth.c
@@ -177,7 +177,7 @@ static u16 nvmet_auth_reply(struct nvmet_req *req, void *d)
 	return 0;
 }
 
-static u16 nvmet_auth_failure2(struct nvmet_req *req, void *d)
+static u16 nvmet_auth_failure2(void *d)
 {
 	struct nvmf_auth_dhchap_failure_data *data = d;
 
@@ -310,7 +310,7 @@ void nvmet_execute_auth_send(struct nvmet_req *req)
 		goto done_kfree;
 		break;
 	case NVME_AUTH_DHCHAP_MESSAGE_FAILURE2:
-		status = nvmet_auth_failure2(req, d);
+		status = nvmet_auth_failure2(d);
 		if (status) {
 			pr_warn("ctrl %d qid %d: authentication failed (%d)\n",
 				ctrl->cntlid, req->sq->qid, status);
-- 
2.25.1


