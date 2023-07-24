Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFAB7C001B0
	for <linux-nvme@archiver.kernel.org>; Mon, 24 Jul 2023 09:20:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=A2LNQorm2icPD+R0ZPgt41734Rk1MmPECXhjPJQctUE=; b=xwzmQbnKvYybmG+XL0jFpAUg1n
	stB4DpgcuNsJwBl2Hpor5Qm8aD7EFMcxxnWL811VgfLeXSQ4EuhTrAQFo5Fnh/1EiGkpKN35QtQWR
	iNeTlVxEGaC6UxVBR+RYvGLtIQkpSIe65vptV3vCkHuQgVNNZufddq+e/mWpVc2XlZTYkI4DsqB8t
	zptK681UHRYQq0BjMRjMuYk12nIxS5h1c4dviDLpPE7iGLI/QdNf1xkz0WviMX7cR5qL1Il6LqyKQ
	QBhod5ipB+NJJvyvOdVDhLb2lUCQqBbVketxdEcp51tBHel7ENUru1dN4saM20fzZ3SN3wvaiPgEk
	pO2F5aaA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qNrk5-003NoY-1l;
	Mon, 24 Jul 2023 09:20:37 +0000
Received: from mail-wm1-f47.google.com ([209.85.128.47])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qNrk2-003NlP-0I
	for linux-nvme@lists.infradead.org;
	Mon, 24 Jul 2023 09:20:35 +0000
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-3facc7a4e8aso4508775e9.0
        for <linux-nvme@lists.infradead.org>; Mon, 24 Jul 2023 02:20:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690190432; x=1690795232;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A2LNQorm2icPD+R0ZPgt41734Rk1MmPECXhjPJQctUE=;
        b=V/OCVpYCIuV0WJ1cizrcdE7iHCah6uAEB6tGxpxakDp/Hf7pJjYt7lWHbbjOxYiNsW
         GO/YnFD+QO/rgeahsihiBCuTxeRiI7nr7aW8NDPZUERb2YmBuboYi65OEtIpunTyYtht
         eHlgLcP3ZrmjAzPmwAwIdw54ADhoIVMFcTB5J8Vmft6Sj3UYQLfhBMuWBesOUA0Y5GiK
         I2xPndbhKTZLoltcCUXAMIuJmf/1OMtKMy/1JuErp7xBTfsQflRayx2CoSGZZ3ST/Gvj
         kschuI+kq7RbTE5V31FcU/ErMqRembgb+CX/0dn77HtAglKicj2GtgSkNa82QufAFuuX
         hdig==
X-Gm-Message-State: ABy/qLbc7OBZ6L+Hn3olLycFvYVa165aXx6qdXnuPDa6HvkBzLrZiGSU
	Q4K5QcrFRlfaR2Benoa2ZVPdaCJ8nhA=
X-Google-Smtp-Source: APBJJlE+lRolVy7uCJXwJkfa2MGPsT5rxknYUifyRLfWWtOHSnD40ZeR6yEcG5kj9xvtp2XRDpJUCw==
X-Received: by 2002:a05:600c:8610:b0:3fb:a982:8f41 with SMTP id ha16-20020a05600c861000b003fba9828f41mr7435383wmb.3.1690190432212;
        Mon, 24 Jul 2023 02:20:32 -0700 (PDT)
Received: from localhost.localdomain (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id x21-20020a05600c21d500b003fb41491670sm12354052wmj.24.2023.07.24.02.20.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jul 2023 02:20:30 -0700 (PDT)
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nvme@lists.infradead.org
Cc: Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Daniel Wagner <dwagner@suse.de>,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH rfc 4/6] nvme-rdma: use nvmf_resolve_address helper
Date: Mon, 24 Jul 2023 12:20:20 +0300
Message-ID: <20230724092023.708335-5-sagi@grimberg.me>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230724092023.708335-1-sagi@grimberg.me>
References: <20230724092023.708335-1-sagi@grimberg.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230724_022034_149346_581AD03D 
X-CRM114-Status: GOOD (  11.28  )
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

Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/host/rdma.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index d433b2ec07a6..797bd192a413 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -2230,8 +2230,7 @@ static struct nvme_ctrl *nvme_rdma_create_ctrl(struct device *dev,
 		opts->mask |= NVMF_OPT_TRSVCID;
 	}
 
-	ret = inet_pton_with_scope(&init_net, AF_UNSPEC,
-			opts->traddr, opts->trsvcid, &ctrl->addr);
+	ret = nvmf_resolve_ip_address(opts, &ctrl->addr);
 	if (ret) {
 		pr_err("malformed address passed: %s:%s\n",
 			opts->traddr, opts->trsvcid);
-- 
2.41.0


