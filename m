Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2770C4451C
	for <linux-nvme@archiver.kernel.org>; Tue, 21 Jul 2026 17:46:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=AadYXUkLInAYH0JaK/HqdbVk2juyzp5yk+Dx6h3Mv+o=; b=X1W41H3qTQxE9thZUFWBky+KeQ
	L3ST74HBDB6BWjaEh827lteQJpdxb9WaIy5P750uqHSQmqYD5Vp9iXtvWNtFR8XX8VuG7pPlpot3A
	pu02iLpvxTrkYmi18RMfqDO9AwRFTWrCHssjVMztfS1jqbXiW28VhIxfyJ1ELLsqi/LNGv8aXWRLU
	raueO0wHTZczIqrkmZA0oX50lIIIJtzMsuHbAm9A05sUgvpM9GueitY5YCCwtesWI/y67HfcaP7Ha
	+16p+Jcg9/cQyTflUPa+Fz3ENWDCBG4OLoS+GtuLEjIFfq+LCiTgoWuiuis/gTwGF6tZTe4+gNBGa
	uoac0HvA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wmEXt-0000000A5cW-2PyW;
	Tue, 21 Jul 2026 17:46:21 +0000
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wmEXq-0000000A5Wj-1yaS
	for linux-nvme@lists.infradead.org;
	Tue, 21 Jul 2026 17:46:19 +0000
Received: by mail-wr1-x42a.google.com with SMTP id ffacd0b85a97d-47f7027ca11so2182062f8f.3
        for <linux-nvme@lists.infradead.org>; Tue, 21 Jul 2026 10:46:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=meshstor.io; s=google; t=1784655977; x=1785260777; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AadYXUkLInAYH0JaK/HqdbVk2juyzp5yk+Dx6h3Mv+o=;
        b=DYhx1Q9tUvgedcfmdDQyMfOzLtniQVgZAVA54/LGY/PvZv1uEK5CvDVj5CD3rSrr2Y
         FLxwS2vB7YEnxmN5Jsvov+Vk8xzvA19cOs0hE8U7al5+GAu0VZLXf2JFfjzlacH4Gyd8
         AqINWZ5njTqat/zrqHQGotDTtWty3Pt+MJ1B8gNjIi/7ke7VE4N13NwHyngVbUQ0sdYS
         ZqYX2k9Ywc1HnZMcIePsRhLgHpRh8Am8AXuBgG7UltRo/tNuLcuoNKIyuqUMCOmDpcrv
         ebW6836im8r5vJR+1PdZT2zKBlQ2w2FIw/trMZlbkLukz2lpXdFWzZz3t1MxqcHrFA7b
         nUUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784655977; x=1785260777;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=AadYXUkLInAYH0JaK/HqdbVk2juyzp5yk+Dx6h3Mv+o=;
        b=FBW/bk4nACUKlGpuhi0N2pjj7c9s9XHyG95QbVECbcYal+SsX4I9HCZs/Ck1Q2FHBV
         kiU6VPGYk4QZEHc0VLXyrekbHhCHxpmAB3HcgY46Dv+d8NNedYF1AHvqkqDN0FNwprY4
         QvIGDnuAkyTHv0AoAeWQQX5AVFHgCfwQhSsejFFTYl8ZIIWrdsD5TF4DzaNYWK/QOr+E
         8PQXJgyyfJfxoFdNEG8ES4UJxIvDMPdnHxpzJdiQWBzQxaHQJk01nKPKuL2GOAq1/X0d
         PKVab1kUX4kicBoEpgB0IfMV3muiHtyo/BtJw36yU8dKZaJombFG57IvkVAFSsN1vwCi
         Pqcw==
X-Forwarded-Encrypted: i=1; AHgh+RoSE0r/1uwXaeL5/J6qS8lmlM7jYlwGiIGZqJQwF0AN1oNVu9FmCDt0P/Zvg2fHY7xVKynssEWfYMzE@lists.infradead.org
X-Gm-Message-State: AOJu0YwSIAXxHrvGTUpoBTo6tuBlS+bcuUCDMRMCI9N2Pax5nWPZJKu4
	AZZQ1rcQYkP2u1vAPQShtjQuMz1yfU8gRq2DgEoP4nA/yMkz9JFR+GF23cbYQqfosg==
X-Gm-Gg: AR+sD10VYEx3urQ9y7vnO+iqkBzpx4y4X/K2PC8YhIt6wnic6m22beyWCEeKIDf17ew
	6aZ/OtcLAXWb6nm65N4ieChgcyHsuSBoB6hvztRPlAXqJZEdvcTwmiTs+k4iCrGzsv/OphFp/uw
	UYQbuO98MZYB55oUKOdLsh3c27KCUGtuZyC6m1aQIccGcxiDY7fsnSoT2aYnDbziZ3gxH2wKh4V
	9JF8CA6LO7DY4+PF7GcPjmNCxcJ1vKtBO+o9GCTI9AR195bJUvhrQN/ZD58J+Lfck2zX1SQG2wJ
	cf/y/LIbLJ5dYB1whmn7HtpOJvHSr6R8r2EKd+g+MGYyCvaCX+tUw5bGo3dn69Sz0IWHBFky0qt
	1SaRy5ug9Pjh/JsKJFDhfichlmuzz/yKkmqtxaC7QhaSuDFWQQEQznlQzEZGrQbb0RG1TFoQP4K
	QitkutZVqfjzyyAPMGlWQ1khKdKXJWunXkcwijGMxCxdGHFOY=
X-Received: by 2002:a05:6000:1ace:b0:477:71ef:5d81 with SMTP id ffacd0b85a97d-47f62305373mr23603687f8f.6.1784655976544;
        Tue, 21 Jul 2026 10:46:16 -0700 (PDT)
Received: from ai-pc ([46.172.241.174])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f63eddd27sm40860513f8f.28.2026.07.21.10.46.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2026 10:46:16 -0700 (PDT)
From: Mykola Marzhan <mykola@meshstor.io>
To: Jens Axboe <axboe@kernel.dk>,
	Song Liu <song@kernel.org>,
	Yu Kuai <yukuai@fygo.io>,
	Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-block@vger.kernel.org,
	linux-raid@vger.kernel.org,
	linux-nvme@lists.infradead.org
Cc: Li Nan <magiclinan@didiglobal.com>,
	Xiao Ni <xiao@kernel.org>,
	Guoqing Jiang <guoqing.jiang@linux.dev>,
	Leon Romanovsky <leon@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Kiran Kumar Modukuri <kmodukuri@nvidia.com>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Shivaji Kant <shivajikant@google.com>,
	Pranjal Shrivastava <praan@google.com>,
	Henrique Carvalho <henrique.carvalho@suse.com>,
	linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: [PATCH v3 8/8] nvme-rdma: return BLK_STS_TARGET for unsupported P2P transfers
Date: Tue, 21 Jul 2026 19:45:02 +0200
Message-ID: <20260721174502.111503-9-mykola@meshstor.io>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260721174502.111503-1-mykola@meshstor.io>
References: <20260721174502.111503-1-mykola@meshstor.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260721_104618_563718_91EDA26D 
X-CRM114-Status: GOOD (  15.48  )
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

ib_dma_map_sg() returns 0 on a P2P mapping failure, losing the DMA
layer's -EREMOTEIO, so nvme-rdma reports a path error.
Default multipath requeues the I/O forever, and without multipath
it burns nvme_max_retries requeues, then completes as retryable
BLK_STS_TRANSPORT.

Map the data and metadata scatterlists with
ib_dma_map_sgtable_attrs() and return BLK_STS_TARGET for -EREMOTEIO,
matching nvme-pci (commit 91fb2b6052f7 ("nvme-pci: convert to using
dma_map_sgtable()")).
Scatterlists stay: ib_map_mr_sg() consumes them, so blk_rq_dma_map
does not apply.

Start the request only after mapping succeeds so multipath
accounting is never taken for an unmapped request, and ratelimit
the map-failure message.

Fixes: 23528aa3320a ("nvme: enable PCI P2PDMA support for RDMA transport")
Cc: stable@vger.kernel.org # v7.1
Assisted-by: Claude:claude-fable-5
Signed-off-by: Mykola Marzhan <mykola@meshstor.io>
---
 drivers/nvme/host/rdma.c | 38 ++++++++++++++++++++++----------------
 1 file changed, 22 insertions(+), 16 deletions(-)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 6909e3542794..f8edb23552ad 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -1469,6 +1469,7 @@ static int nvme_rdma_dma_map_req(struct ib_device *ibdev, struct request *rq,
 		int *count, int *pi_count)
 {
 	struct nvme_rdma_request *req = blk_mq_rq_to_pdu(rq);
+	struct sg_table sgt;
 	int ret;
 
 	req->data_sgl.sg_table.sgl = (struct scatterlist *)(req + 1);
@@ -1480,12 +1481,14 @@ static int nvme_rdma_dma_map_req(struct ib_device *ibdev, struct request *rq,
 
 	req->data_sgl.nents = blk_rq_map_sg(rq, req->data_sgl.sg_table.sgl);
 
-	*count = ib_dma_map_sg(ibdev, req->data_sgl.sg_table.sgl,
-			       req->data_sgl.nents, rq_dma_dir(rq));
-	if (unlikely(*count <= 0)) {
-		ret = -EIO;
+	sgt = (struct sg_table) {
+		.sgl		= req->data_sgl.sg_table.sgl,
+		.orig_nents	= req->data_sgl.nents,
+	};
+	ret = ib_dma_map_sgtable_attrs(ibdev, &sgt, rq_dma_dir(rq), 0);
+	if (unlikely(ret))
 		goto out_free_table;
-	}
+	*count = sgt.nents;
 
 	if (blk_integrity_rq(rq)) {
 		req->metadata_sgl->sg_table.sgl =
@@ -1501,14 +1504,14 @@ static int nvme_rdma_dma_map_req(struct ib_device *ibdev, struct request *rq,
 
 		req->metadata_sgl->nents = blk_rq_map_integrity_sg(rq,
 				req->metadata_sgl->sg_table.sgl);
-		*pi_count = ib_dma_map_sg(ibdev,
-					  req->metadata_sgl->sg_table.sgl,
-					  req->metadata_sgl->nents,
-					  rq_dma_dir(rq));
-		if (unlikely(*pi_count <= 0)) {
-			ret = -EIO;
+		sgt = (struct sg_table) {
+			.sgl		= req->metadata_sgl->sg_table.sgl,
+			.orig_nents	= req->metadata_sgl->nents,
+		};
+		ret = ib_dma_map_sgtable_attrs(ibdev, &sgt, rq_dma_dir(rq), 0);
+		if (unlikely(ret))
 			goto out_free_pi_table;
-		}
+		*pi_count = sgt.nents;
 	}
 
 	return 0;
@@ -2026,8 +2029,6 @@ static blk_status_t nvme_rdma_queue_rq(struct blk_mq_hw_ctx *hctx,
 	if (ret)
 		goto unmap_qe;
 
-	nvme_start_request(rq);
-
 	if (IS_ENABLED(CONFIG_BLK_DEV_INTEGRITY) &&
 	    queue->pi_support &&
 	    (c->common.opcode == nvme_cmd_write ||
@@ -2039,11 +2040,13 @@ static blk_status_t nvme_rdma_queue_rq(struct blk_mq_hw_ctx *hctx,
 
 	err = nvme_rdma_map_data(queue, rq, c);
 	if (unlikely(err < 0)) {
-		dev_err(queue->ctrl->ctrl.device,
-			     "Failed to map data (%d)\n", err);
+		dev_err_ratelimited(queue->ctrl->ctrl.device,
+				    "Failed to map data (%d)\n", err);
 		goto err;
 	}
 
+	nvme_start_request(rq);
+
 	sqe->cqe.done = nvme_rdma_send_done;
 
 	ib_dma_sync_single_for_device(dev, sqe->dma,
@@ -2063,6 +2066,9 @@ static blk_status_t nvme_rdma_queue_rq(struct blk_mq_hw_ctx *hctx,
 		ret = nvme_host_path_error(rq);
 	else if (err == -ENOMEM || err == -EAGAIN)
 		ret = BLK_STS_RESOURCE;
+	/* Peer memory unreachable from this device: don't retry. */
+	else if (err == -EREMOTEIO)
+		ret = BLK_STS_TARGET;
 	else
 		ret = BLK_STS_IOERR;
 	nvme_cleanup_cmd(rq);
-- 
2.52.0


