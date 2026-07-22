Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AA64C4453A
	for <linux-nvme@archiver.kernel.org>; Wed, 22 Jul 2026 18:59:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ZyX4ma10pC/frHu+Y/NUZniwvhp9EvBkdSwrv0doV3k=; b=eEpt2tdt0dAXHZFLW4UK0T34Ui
	hXpCbZOVJvDOFEBy65+8O5VSKkEf/bQZFHIng/NKp3cbltOz5VBHseNRyt6BGLPtAeBPjnEJl+nEZ
	TIU7BUCSYnk3uWA704lFiSZGWBdvDa3DlT7d5c4vHFuFdmf7ysLnETEloFt0LtjrV3+djfUuWJSwz
	q2wKHQf7VUwQYewFj3E7CS88XkMTLOlqaNk0G2YoComn4ITeGDmGdFtiSQ0VZ1mFx8ygXj08YTrK/
	zHXYyBm1d2c0wL+ID9DaiFXILMESCtv4MSEfEcBrnqFAZncYA1gHzd9xjoRSUTL1c+zexePH2zw0J
	Vm8CF7Ng==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wmcA7-0000000Cay7-378B;
	Wed, 22 Jul 2026 18:59:23 +0000
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wmcA4-0000000Casr-1AHq
	for linux-nvme@lists.infradead.org;
	Wed, 22 Jul 2026 18:59:21 +0000
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-49550ec592cso23616575e9.0
        for <linux-nvme@lists.infradead.org>; Wed, 22 Jul 2026 11:59:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=meshstor.io; s=google; t=1784746759; x=1785351559; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZyX4ma10pC/frHu+Y/NUZniwvhp9EvBkdSwrv0doV3k=;
        b=YQ0b6IqjpTNNbHAKuY2wnNQDgibjhuwLYM6B1IWtjB9xlt+LMffavoIfT0Ijsgxsv2
         nEdLUT/SMeoFVkMFP4OgNDSMJr1BEo1ytmTX8hg5GNkh69EPFMNGbMVBcuUvj4aazjK8
         WcUNMsJnID0ROj/FPQzdSOodAs7qnYl6QvnVhO/HPeU1UiO4rPxM73QngUmNJX8otQKh
         JrKe14HItLAbxfQa2l+ZMFkRQaeEXbDqLqO8ZVYVOUeEXzWQlQmmYUeuxujSA9vLFHDf
         MVKCscyIpTL92KbnFDonVeO4mHgDd74qwYInk+fGACZljO+NL+Fm/7ZuCLROxRGnsAMl
         F85Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784746759; x=1785351559;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZyX4ma10pC/frHu+Y/NUZniwvhp9EvBkdSwrv0doV3k=;
        b=A6Glau0cdmBiEv8wLZTOc4kJjeLLUwDSx5DoTRJ8RamIJhoCVHc1LrkWbn/rYiugnU
         dP9DuGc96Kmo/27LV6eLSnOgrKvtCS3KJm1xoH+xPK1BNk52qCqVNwfv5smWQlQI8C05
         PChZOEDDZ7J5MoJ8rY2NQSgI2UdnhwCgXE74tZt2UwM4l6XisEZQ4wckxLMkn6m8RNC1
         ZDn8nwfRks76+qWyucLpwXt66WMHOQLoa/pMCq72sG0/h5XAO7tw2u+Wxp5du8TJC1Xb
         hbqCFW7xxsojm2Io/JUPzD0NXOOAhbPDaIZFi+jPAg2krGtGsAwTr0l0iKpj2UzqSefa
         HjEQ==
X-Forwarded-Encrypted: i=1; AHgh+RquoSZ/OBXLhFyC+fGxevi55p7xe9A+ZVF5aARquCV6RbkntOW5XNTjyG+7FbDJSg2h1L2Q2EHaO6iy@lists.infradead.org
X-Gm-Message-State: AOJu0YyMUZVXOvLUxoTUkkPdNn3AxHZ+lLnsb1FA7hcdm2qfjBOg3+6R
	YDl28GwBffKxYHVNgKJTc6E7OTqu7lW9szs29/APblu5xmuIwaUgwEWK4nDcVcLeqw==
X-Gm-Gg: AR+sD12yrSJsWnPqb6tHRSDSBhCWree78FkhzaMS+MTpAmcqhdPC08ha1060qTUhL/X
	wRqYjXY2nBVDqw4uCJBW+IFnbdmSMyXYCZkdbfCwJLLtHj4s5vI+BNgl91Wgkgd99yYddIAfYNl
	f3go9LuD64JcwdstnQmY9Kt/xQ7o7NBkuwc+0bW6fxARXNPzsV5LkqF2oKvF/oBGuH67NlK0LWr
	aJiQYbG88RF5skSh75tQDhnbivv/zRJs0LLY8YJCDNY9bUrkohu1b95tILNQfjOsk7cnO3KW2wj
	tF2nwcDTM2OzDDtgtIX0iyrbF7pb4AM53b6BdNs094KtoGvflzyPFy5rSzDxViuxwQrE9yuQRNM
	ej2+c3DpxOBe9ge4wBZA2enXM6l5JaHZhn4BO77k3Ed1vZd+xHPvBmEi/1RIiIqIAByvOvzPTvq
	GBiTXEUUL9Mc1Q3MoEEsSJyPVexhowVC4epCm0tPj3Ph5XmIg=
X-Received: by 2002:a05:600c:6610:b0:492:6f5c:fd8c with SMTP id 5b1f17b1804b1-4956a511b49mr53704175e9.15.1784746758682;
        Wed, 22 Jul 2026 11:59:18 -0700 (PDT)
Received: from ai-pc ([46.172.241.174])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-495730353d9sm13740055e9.12.2026.07.22.11.59.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 11:59:18 -0700 (PDT)
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
Subject: [PATCH v4 9/9] nvme-rdma: return BLK_STS_P2PDMA for unsupported P2P transfers
Date: Wed, 22 Jul 2026 20:58:41 +0200
Message-ID: <20260722185841.449934-10-mykola@meshstor.io>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260722185841.449934-1-mykola@meshstor.io>
References: <20260722185841.449934-1-mykola@meshstor.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260722_115920_347978_3201DBF4 
X-CRM114-Status: GOOD (  16.08  )
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

When the PCIe topology cannot route a P2P transfer between two devices,
the DMA layer fails the mapping with -EREMOTEIO, but ib_dma_map_sg()
returns 0 and the error is lost. nvme-rdma then fails the I/O with a
retryable status, so multipath requeues it forever and a single path
wastes its whole retry budget on an I/O that can never succeed.

Map the data and metadata scatterlists with ib_dma_map_sgtable_attrs(),
which preserves the error, and translate -EREMOTEIO to the new
BLK_STS_P2PDMA status so the request fails fast instead of being
retried. While at it, call nvme_start_request() only after mapping
succeeds and ratelimit the map-failure message.

Fixes: 23528aa3320a ("nvme: enable PCI P2PDMA support for RDMA transport")
Cc: stable@vger.kernel.org # v7.1
Assisted-by: Claude:claude-fable-5
Signed-off-by: Mykola Marzhan <mykola@meshstor.io>
---
 drivers/nvme/host/rdma.c | 38 ++++++++++++++++++++++----------------
 1 file changed, 22 insertions(+), 16 deletions(-)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 6909e3542794..2f50509a7a61 100644
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
+		ret = BLK_STS_P2PDMA;
 	else
 		ret = BLK_STS_IOERR;
 	nvme_cleanup_cmd(rq);
-- 
2.52.0


