Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2BA8C001DE
	for <linux-nvme@archiver.kernel.org>; Mon, 24 Jul 2023 09:20:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=PBQ0SAeWGRgr7g8CP4xf2pX3qZvVcy97nEEefSOZBK0=; b=vnuqtFt19APB9m3kCA2pFq+XGB
	fv0KisaOtrL/8Hb5/NuxtqXsdsrxkfCh9WjCK3nnTid5iBIqlJNsIULNwExqXBYdTL2Z89PXLRhsc
	GLSJ5jjXZuBcPLxcoRPRK2qnuyrXZNYm8h3UkU5vVXDaTvAxznlwKnmMP1G6TxvYUqK8w4e1sDHY/
	nKYDsGwErlv0DvMWeegtDQhqeWkt0GWdcw8EFjs+2Dd+xmrbfhi1orWRMWJtkh/qU7aSWWqAVHdoq
	mciS115u7PvGb8ySNUZfowyzdO9SNJp3UzT9rw0Ps/+nx1OGjQsPqCUpOF9RxMEfGK2Wpk14Dk2j7
	IW7TiITQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qNrk2-003Nma-2r;
	Mon, 24 Jul 2023 09:20:34 +0000
Received: from mail-wm1-f49.google.com ([209.85.128.49])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qNrk0-003Nkc-25
	for linux-nvme@lists.infradead.org;
	Mon, 24 Jul 2023 09:20:33 +0000
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-3fc03d990daso8149915e9.1
        for <linux-nvme@lists.infradead.org>; Mon, 24 Jul 2023 02:20:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690190430; x=1690795230;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PBQ0SAeWGRgr7g8CP4xf2pX3qZvVcy97nEEefSOZBK0=;
        b=H5wgojjyNJ+S3Ipl5VGewgB6azfF8lEsH9IbKUb3jwzjXMtGpc6JOWj/YbwTATIc6l
         WBftnhx6cuj3JhTOEhf4ZY4xblRSHNsRupIuBlua/gN1lnvZBaKMI1ah6EAVY7Q4Qn0e
         TREPO15++2j3CcwLnSLyOo0S8pYAAIoWqBp9MIj6S+fCDKc5QbrDTi7Ibh9UGMbRw2YX
         g/DBn+XU/W0BqTDawlUlINFsWTqqjgE6Xm64IzOH/nU67Aa/IcBRnxYH2WA5zan3NLmB
         fRNlmGenz6pfbFG8p8S74toqrIMS0fYK7yWHk5he/KLy3bRalbKqNM3lcFX+u/QlixKe
         MUUw==
X-Gm-Message-State: ABy/qLY6pLdKqcZyW65PE8ueKT8FRM1bjEU46LLuJrDj7qlWeIC2cApO
	k3CgFIlCATPqz/rn7kVH0Bq00Ce440E=
X-Google-Smtp-Source: APBJJlED5CFwYOfyni4o8nT/lIaYYY1eY5TOk68X4PDC2alQ9XR/R5+CFJ3taL6lLjffNOEHv5QvUw==
X-Received: by 2002:a05:600c:1c10:b0:3f7:fb5d:6e7a with SMTP id j16-20020a05600c1c1000b003f7fb5d6e7amr8413908wms.0.1690190430239;
        Mon, 24 Jul 2023 02:20:30 -0700 (PDT)
Received: from localhost.localdomain (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id x21-20020a05600c21d500b003fb41491670sm12354052wmj.24.2023.07.24.02.20.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jul 2023 02:20:29 -0700 (PDT)
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nvme@lists.infradead.org
Cc: Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Daniel Wagner <dwagner@suse.de>,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH rfc 3/6] nvme-tcp: re-resolve traddr upon reconnect in case it is a dns name
Date: Mon, 24 Jul 2023 12:20:19 +0300
Message-ID: <20230724092023.708335-4-sagi@grimberg.me>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230724092023.708335-1-sagi@grimberg.me>
References: <20230724092023.708335-1-sagi@grimberg.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230724_022032_684610_A3069DF3 
X-CRM114-Status: GOOD (  17.35  )
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
 drivers/nvme/host/tcp.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index a47b597ace3e..d44d88d12ea0 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -1917,8 +1917,21 @@ static void nvme_tcp_destroy_admin_queue(struct nvme_ctrl *ctrl, bool remove)
 
 static int nvme_tcp_configure_admin_queue(struct nvme_ctrl *ctrl, bool new)
 {
+	struct nvmf_ctrl_options *opts = ctrl->opts;
 	int error;
 
+	/*
+	 * it is possible that the controller traddr may be a dns name which
+	 * may have changed its ip address since it was last resolved in prior
+	 * connect. Try to re-resolve the address in this case.
+	 */
+	error = nvmf_resolve_ip_address(opts, &to_tcp_ctrl(ctrl)->addr);
+	if (error) {
+		dev_warn(ctrl->device, "unable to resolve address: %s:%s\n",
+			opts->traddr, opts->trsvcid);
+		return error;
+	}
+
 	error = nvme_tcp_alloc_admin_queue(ctrl);
 	if (error)
 		return error;
@@ -2537,13 +2550,6 @@ static struct nvme_ctrl *nvme_tcp_create_ctrl(struct device *dev,
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


