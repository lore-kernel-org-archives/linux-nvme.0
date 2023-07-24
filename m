Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75835C001DF
	for <linux-nvme@archiver.kernel.org>; Mon, 24 Jul 2023 09:20:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=87gvkCB0BJQMdyTAM+nZJCQk4aEwA+OZIUnGBZ9zfNI=; b=EiG5kVtoom7O8dfTWPiqX9Q8MJ
	6eKRuKDP+dVn9fwlvViFed+bl+mOtGk+rNBeMz+YBtDF58gihA03moiAVY+WFw5wF/v9r1gFB4d+t
	oeM1YCrbCFYHI70Aqx/42I/mgJugOAr3sL6Z6Nxv+R/Z0k1ANKswipJXWlcp40H47lOhlPRHRiU4R
	IVGCLoL1ZaW1TfSeBYEd/UVERfs8pyH1BQ4ez6V8goF23Y0aCTb8aFZHXVMm7fYJDErdvYCV81tfn
	qb6taBJKgKevWZEWkuyZRlgP7QRYv5LYTZNoReN9yOVPWrwMpXbM5poKiFaoTjz+tLX6Y4SSeTsWg
	Y8takQgQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qNrk7-003Nq2-1j;
	Mon, 24 Jul 2023 09:20:39 +0000
Received: from mail-wm1-f48.google.com ([209.85.128.48])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qNrk4-003NmX-2n
	for linux-nvme@lists.infradead.org;
	Mon, 24 Jul 2023 09:20:38 +0000
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-3fa988809c0so7194695e9.1
        for <linux-nvme@lists.infradead.org>; Mon, 24 Jul 2023 02:20:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690190433; x=1690795233;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=87gvkCB0BJQMdyTAM+nZJCQk4aEwA+OZIUnGBZ9zfNI=;
        b=gjAAydyaWMuO2NHaEQDDQ6YfegVX6aighBwSYgfvjTeS3UkR7+xIymvoX9bbd0gkEF
         DibAaxE2P59RAi73lTH8YhM9BMxolaB8mBgFLxxImhzR7seUFAdCEkh7LETs7ALjfIx1
         3YoHY8JNcdVbtUo3SFtt1l5idXzmg+ZXoJlwP214TLJ1PRVgh0xghEUGINlBzml+rUOo
         UrZTlHTbDzjSp4AwGXN+uN2EyZxFw0SHx/C1+o5BiDQrBv3f6Hmg4xhI9JpxmoHBaVZU
         aCah+EMgKPPNSa1tVluYMveseXEsei50tx+KUmRiJIxy1IgSyoQksdpPSBT7rKcgw9CJ
         0yyA==
X-Gm-Message-State: ABy/qLYvXn9MZA/3yI14JguG04MehEy+Ov61ccfgARPGeTTmdFZ57WB6
	y2N88bmF2/O75GwU5K4dV8pUavAuQus=
X-Google-Smtp-Source: APBJJlF3fv8BhYzGzq43tIevMlpg9cnMAsErG/W0/xTyLOGTR88z7BV3PM8x9Ks8lnkcfTA31G5nkA==
X-Received: by 2002:a05:600c:54e3:b0:3fb:b29b:61c3 with SMTP id jb3-20020a05600c54e300b003fbb29b61c3mr7749553wmb.1.1690190433580;
        Mon, 24 Jul 2023 02:20:33 -0700 (PDT)
Received: from localhost.localdomain (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id x21-20020a05600c21d500b003fb41491670sm12354052wmj.24.2023.07.24.02.20.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jul 2023 02:20:32 -0700 (PDT)
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nvme@lists.infradead.org
Cc: Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Daniel Wagner <dwagner@suse.de>,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH rfc 5/6] nvme-rdma: re-resolve traddr upon reconnect in case it is a dns name
Date: Mon, 24 Jul 2023 12:20:21 +0300
Message-ID: <20230724092023.708335-6-sagi@grimberg.me>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230724092023.708335-1-sagi@grimberg.me>
References: <20230724092023.708335-1-sagi@grimberg.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230724_022036_908559_02A865B6 
X-CRM114-Status: GOOD (  17.26  )
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

In case traddr is a dns name, it may describe a different address
during the controller lifetime. The classic example would be
a discovery-service dns name that may be load-balanced via dns over
multiple addresses.

So try to re-resolve the controller address. There is no dns query
in case the traddr provided is an ip address.

Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/host/rdma.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 797bd192a413..2a4109bbd4a2 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -777,9 +777,22 @@ static void nvme_rdma_destroy_admin_queue(struct nvme_rdma_ctrl *ctrl)
 static int nvme_rdma_configure_admin_queue(struct nvme_rdma_ctrl *ctrl,
 		bool new)
 {
+	struct nvmf_ctrl_options *opts = ctrl->ctrl.opts;
 	bool pi_capable = false;
 	int error;
 
+	/*
+	 * it is possible that the controller traddr may be a dns name which
+	 * may have changed its ip address since it was last resolved in prior
+	 * connect. Try to re-resolve the address in this case.
+	 */
+	error = nvmf_resolve_ip_address(opts, &ctrl->addr);
+	if (error) {
+		dev_warn(ctrl->ctrl.device, "unable to resolve address: %s:%s\n",
+			opts->traddr, opts->trsvcid);
+		return error;
+	}
+
 	error = nvme_rdma_alloc_queue(ctrl, 0, NVME_AQ_DEPTH);
 	if (error)
 		return error;
@@ -2230,13 +2243,6 @@ static struct nvme_ctrl *nvme_rdma_create_ctrl(struct device *dev,
 		opts->mask |= NVMF_OPT_TRSVCID;
 	}
 
-	ret = nvmf_resolve_ip_address(opts, &ctrl->addr);
-	if (ret) {
-		pr_err("malformed address passed: %s:%s\n",
-			opts->traddr, opts->trsvcid);
-		goto out_free_ctrl;
-	}
-
 	if (opts->mask & NVMF_OPT_HOST_TRADDR) {
 		ret = inet_pton_with_scope(&init_net, AF_UNSPEC,
 			opts->host_traddr, NULL, &ctrl->src_addr);
-- 
2.41.0


