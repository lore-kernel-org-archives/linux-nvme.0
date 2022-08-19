Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBB9DC25B0E
	for <linux-nvme@archiver.kernel.org>; Fri, 19 Aug 2022 06:09:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=uyVgJ1+wrRmHQHbLzZkCEtfs58onJoTrNiUjQMfsElE=; b=5GE9513+OqDp8rdGi+f2H6NRQa
	DWa0V7CnG7yQ8y+VZO8kkQ/ZboprJ8ls2wbYuE1IkEktTk/Dd1grEIhpo2s84vvijQVle13VmPxsD
	Zu6p0AG2A+b2hvFyKeYyl9E7z3uw9Ct8HbvxNpEhpSE+7tJe1KB1ImXHQanD54nX0yRJ1oB3xYYOe
	Iik541gchcGFgakWMgwt1DIgeu3oZeBiSqzqV03cFlVzG9xv6s1TxAqQlKi9ZQMeSzCoZLGvdCUki
	urPdWoLye4nEhkm9DR1/o0SX/fS6O8jVApPvG9KsOHzn2ohclPbVc1/hQ2XbhwIp3Dt3fzdkmLbWA
	Zt/gnzLg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oOvC1-002BAK-7L; Fri, 19 Aug 2022 06:09:17 +0000
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oOvBB-0029SH-9O
	for linux-nvme@lists.infradead.org; Fri, 19 Aug 2022 06:08:27 +0000
Received: by mail-ej1-x62d.google.com with SMTP id y13so6941590ejp.13
        for <linux-nvme@lists.infradead.org>; Thu, 18 Aug 2022 23:08:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=uyVgJ1+wrRmHQHbLzZkCEtfs58onJoTrNiUjQMfsElE=;
        b=f3ub8wfqCgXsggOvDWD7YThPKgrQeLezsFWKD7JNkZ3NYPkF/zkY4vAH0PC9ooLlIV
         +Nv1wNrwX1TEdf41/OZ/mYc8ZPAfjLOmXHiHS22B3UipI/WfElbUy1GnqWk3JdF+3hJM
         oLtLucbIjIWaN8g/0t2pnie/9fSrHb2rwZpOKu6ZUrzAzXVB53r3P90TgPASNXySSi4n
         KlAopEV24PQb4LwVa4zKwjDb3ZocplL2VhymDCdnMaM/v1H9z3eYuOiuG4ia3J5MvJoT
         3FUe9jAWCUd/iR5ECx8ub0totX2Yz6yfEu/5Ykvho2wkFU+TQ0OtUeAYX10G7QUfheH1
         gNyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=uyVgJ1+wrRmHQHbLzZkCEtfs58onJoTrNiUjQMfsElE=;
        b=LK5CFoMs3PnW5VpX5dhVZcMsXif6U9HPp47vH+Ir+YYpXu6GYiRIexQTjArJ18pee2
         dD8yrWpGz943ksf5JDpW3Ski7XgHlOzhGJY4uF2q1oNDdpHzeB/MHsgK/eJn+4EyNVLM
         0I/X0KZUsbtJ+kLReO8+IrmiedCMCsm/3PonLEmdq3O2idyivbX70zADJBiHH5fUzJ3F
         NHH5yBJzuOSwZ1zKk06Dvg5Y7Jef8Bhmlw1sW6wVJPQwMqp4LgqTm4bLOJcb42wzKgNG
         gZfXqATatWnPPi5ePSfnVVks438jwOFojwucwJyLuoet14iiBk8iEVuJrtuNFqgDE7Ov
         TqRw==
X-Gm-Message-State: ACgBeo1QxUQmzAYu68frvoCTPRSDswOWgHKd8j1LsyigJKmtPUWQZXTG
	L2+otNLzkq4z6n9rkxuVmBlebg==
X-Google-Smtp-Source: AA6agR4Gf40tIGiWcPwKD63vJim8JzCFckhdiFEXDhfFVJm+iVYsHTK6yhdRYuWPjreL/3DreBK2xg==
X-Received: by 2002:a17:907:a0c7:b0:734:e049:1af6 with SMTP id hw7-20020a170907a0c700b00734e0491af6mr3787864ejc.439.1660889304810;
        Thu, 18 Aug 2022 23:08:24 -0700 (PDT)
Received: from lb02065.fritz.box ([2001:9e8:143b:fd00:5207:8c7f:747a:b80d])
        by smtp.gmail.com with ESMTPSA id y14-20020a1709063a8e00b0073a644ef803sm1809660ejd.101.2022.08.18.23.08.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Aug 2022 23:08:24 -0700 (PDT)
From: Jack Wang <jinpu.wang@ionos.com>
To: linux-kernel@vger.kernel.org
Cc: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@fb.com>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org
Subject: [PATCH v1 14/19] nvme-rdma: Fix error check for ib_dma_map_sg
Date: Fri, 19 Aug 2022 08:07:56 +0200
Message-Id: <20220819060801.10443-15-jinpu.wang@ionos.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220819060801.10443-1-jinpu.wang@ionos.com>
References: <20220819060801.10443-1-jinpu.wang@ionos.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220818_230826_603192_703CC35B 
X-CRM114-Status: GOOD (  14.76  )
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

ib_dma_map_sg return 0 on error.

Cc: Keith Busch <kbusch@kernel.org>
Cc: Jens Axboe <axboe@fb.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org
Cc: linux-kernel@vger.kernel.org

Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
---
 drivers/nvme/host/rdma.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 3100643be299..d70bccbcba3e 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -1551,7 +1551,7 @@ static int nvme_rdma_dma_map_req(struct ib_device *ibdev, struct request *rq,
 
 	*count = ib_dma_map_sg(ibdev, req->data_sgl.sg_table.sgl,
 			       req->data_sgl.nents, rq_dma_dir(rq));
-	if (unlikely(*count <= 0)) {
+	if (unlikely(!*count)) {
 		ret = -EIO;
 		goto out_free_table;
 	}
@@ -1574,7 +1574,7 @@ static int nvme_rdma_dma_map_req(struct ib_device *ibdev, struct request *rq,
 					  req->metadata_sgl->sg_table.sgl,
 					  req->metadata_sgl->nents,
 					  rq_dma_dir(rq));
-		if (unlikely(*pi_count <= 0)) {
+		if (unlikely(!*pi_count)) {
 			ret = -EIO;
 			goto out_free_pi_table;
 		}
-- 
2.34.1


