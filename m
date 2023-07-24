Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2170C001E0
	for <linux-nvme@archiver.kernel.org>; Mon, 24 Jul 2023 09:20:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=inNilHgopBwpg1t1BqSoI6AYReA6sc6emAfdsuV1JHM=; b=ZvUAi6xMpD5oE6ovjOiGx/DpRD
	ycv4KmPs7+comfOJx7htI/pWJoLDgxFQVV2kx7lAfNgY+mgi2D4wX2wj5xhz4e2ixHFVSmklsQSnY
	h5Bi8v1vbl6+DSUIRtXe1Q3/9yuEauIRP/FFWGvuyjNNrdsleBapHvy9Jd3DBu3nHNEmBeMf3VSg1
	/8w8ymG+JJQEbqwJcXAc8JnpQNeOiFkiYeyU1+BgzNLm1/eV/ueE6nLrUU6OCZXZShCrPimDAddqO
	skrCUvaiWetjjfbm8bjhYlpJtUEqbWTJsTS4P2bR2XyJNrD0GzQBHdobMOyzglYZCZ5zUkbGF9Tlh
	FIErPh4Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qNrk3-003Nn6-25;
	Mon, 24 Jul 2023 09:20:35 +0000
Received: from mail-wm1-f43.google.com ([209.85.128.43])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qNrk0-003Nje-0V
	for linux-nvme@lists.infradead.org;
	Mon, 24 Jul 2023 09:20:33 +0000
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-3fbb634882dso8162605e9.0
        for <linux-nvme@lists.infradead.org>; Mon, 24 Jul 2023 02:20:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690190429; x=1690795229;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=inNilHgopBwpg1t1BqSoI6AYReA6sc6emAfdsuV1JHM=;
        b=COfjCPQPTX/uT8BGcDNj6foH3980dv9EnIYaJDEEGDY2AT7b56lrEAmKrpaDwQgnWG
         KGJKJhYUEVcO0dt9QZk+LFsYLXXN+5P1eC+XL1wrSPh7auvGlYstPDdaZeaHUKnhPCsp
         5GIy5WKRaDeRzvbp3i76Gcks7PKcUf0Iazs9e0Pwo09pF78FSXQJYv4rDLqbKazAsoLA
         RrgCdCMyBKhI2Vtja6+WtHWePfSC20jtHVzyhBZQ3P6e91DQzKEhCcpWZvmFE1S6TYdO
         WjJspywNRtxh3zsUR4gwnCSuR/mdd2DuQAl5rs1mkmuU/WnINeNb//u774cLPpDQxqAz
         iPRQ==
X-Gm-Message-State: ABy/qLYiiMHL3KxY//HsVOc2g/ks/CnC2RxJ18ZV4gE4ljw9Z4ZRgahM
	djR+3YmrKzLfk1NDlfxNq7pcD4fa9SE=
X-Google-Smtp-Source: APBJJlFjhxMrFFprqF4tiabEuAlM+sEUHy6wv838sywf7Y2VuFLGnLLEGAwC8pohiF8jRMMt9TiQhw==
X-Received: by 2002:a05:600c:46c4:b0:3fb:aadc:41dc with SMTP id q4-20020a05600c46c400b003fbaadc41dcmr8358953wmo.4.1690190428522;
        Mon, 24 Jul 2023 02:20:28 -0700 (PDT)
Received: from localhost.localdomain (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id x21-20020a05600c21d500b003fb41491670sm12354052wmj.24.2023.07.24.02.20.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jul 2023 02:20:27 -0700 (PDT)
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nvme@lists.infradead.org
Cc: Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Daniel Wagner <dwagner@suse.de>,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH rfc 2/6] nvme-tcp: use nvmf_resolve_address helper
Date: Mon, 24 Jul 2023 12:20:18 +0300
Message-ID: <20230724092023.708335-3-sagi@grimberg.me>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230724092023.708335-1-sagi@grimberg.me>
References: <20230724092023.708335-1-sagi@grimberg.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230724_022032_192348_481ECF2C 
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
 drivers/nvme/host/tcp.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 3e7dd6f91832..a47b597ace3e 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -2537,8 +2537,7 @@ static struct nvme_ctrl *nvme_tcp_create_ctrl(struct device *dev,
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


