Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C12DCC44524
	for <linux-nvme@archiver.kernel.org>; Sat, 18 Jul 2026 16:26:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=dagmucy3ghWM9/yf2A3Q3PwS7L9VrlH2jBuQsiQB1xw=; b=vJPOCuq9CkEPbkB27jDcaFBc1Q
	U02qMFk7Wf/P7Smp0ZBS8aKHNhEz43nUVcMBSGBPgzLQEvioD0HxdOCiGntimI5BSwRm+JZ/R8jL9
	TMRH3hb1/0Syt71CEqt9dZBQ3EiKETBNpS6UDYS7Z3/B+jFlCs+zzhZX5WnWbsXJ7B4mYveVVPxts
	qYSfwCycMy2D6PSRWEcBv1Z+KthiIl8n6V8yriUDMxa3jiqkvADnRvjeKzivQNJbVfOaRrLa9yj3m
	OwWYwNMzzFEkKmrFpjQBG3ALxvDreOFs4IlHq7rVpePiqC+5HJX4HHAp8O+0+fpznsX6RdHBS4toq
	zVeKZ1sA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wl7s3-00000004H9p-1Kmh;
	Sat, 18 Jul 2026 16:26:35 +0000
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wl7ry-00000004H56-3x6s
	for linux-nvme@lists.infradead.org;
	Sat, 18 Jul 2026 16:26:33 +0000
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-4954aff6088so9954095e9.3
        for <linux-nvme@lists.infradead.org>; Sat, 18 Jul 2026 09:26:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=meshstor.io; s=google; t=1784391989; x=1784996789; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dagmucy3ghWM9/yf2A3Q3PwS7L9VrlH2jBuQsiQB1xw=;
        b=CAFtcAGhTGTGgT8TNvuCZo09Mk+ZvbPa0yWuZaUN6iH91kdmORHvMH/d03ARf1laim
         qAC4DbqexcxZ1OFpFDfNcZ5f7gIL2qsj3XJyJp0z0SLeTXtwd9aJzHtbOcf5zxGBARj6
         ZETsK2B+PsAkeENZIZFMhuTi2XEaJJKe4vy8BWvGNPKwzeJ0XdD2ncJgACCG7srdy0aB
         dcRw5Bote05fjSDRpy/+gwXqywAQp6S6Z9R0OVl8JaijT29eLSazPFoRbV4pVOPOlUa4
         xUQFe/CpvsShef2fpSqWN9r/DLGY9QIn1PLpETyJAatqAqpAdETp9n7uKS/sqSPcTbB/
         yvmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784391989; x=1784996789;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=dagmucy3ghWM9/yf2A3Q3PwS7L9VrlH2jBuQsiQB1xw=;
        b=nIJMzBNhuKUeExJurfbBoiTEVmwb8Y1WkKlcSjCJUn4GpdaWLH+N65V2eavXwL9eER
         SIfjjSQxDv3zPAwTbQYZu52n8sKeCnPuQoLqCQfvTV2qlFoH0lCaGlKfgXcMPY1h9636
         pa/7/eV7UBh7buYyZEarFRSiyzJP1F3uWBl84Gt6Mj1NtAMQLWseu5E305OXulm0SEOv
         EdyY8zZuCNyBPC8J/AcVlt3uwBXUSD2H2cOnoXjHz+0VzudKlER2sTspAhzPdoU5BJEi
         Eb8XuapcaciiIyE2Ncmj7TzRBNBV2bN8UVBlGWS4eQAQZ8jAmtdi08pd6TnY5ynSLUBY
         0wzg==
X-Forwarded-Encrypted: i=1; AHgh+RrKCCAkWdzsTKIfU0Soydv6TAtF6CO07bMGcnA8qqgfWaEFFvF7JJpOsWsgTP2N39ZbTf/IFLjsVBIi@lists.infradead.org
X-Gm-Message-State: AOJu0YxoTbnWtSd73NXfFPVW9FeGiLZNftzuX/e7ESxyv09MJWtCY8l0
	9Wrw+V+/oitHQ44yJvS5y6rWKZfIdpq49+SSvYz3SzbxjfGa4npAy9/CcrLOrkG1PQ==
X-Gm-Gg: AfdE7cmDL+cLFZ8gDQoe6IuKZfdbbJrFcmrafTEFm5HdzCCUhC1LnS+SSpp8/4pa0/g
	JHbLxmqHiXy16nqeVBHY7yM/kHwVJiuUubRHIngfzpgQMEFrdjtF3v/BixnWG7eL80d0T0TbwDn
	TZm42ivhegFjIX3vF/gLX2flJTiTrcSSTTtq8lD69OYOSM2smjklafP9GyG9kFiPnzNQ0XvZjJv
	Or+Vc8lHER2JtB2qcH6WndlI2DK1xUBhjh3HquWQNIvT5nAanZdAcvUxuwYaGAXwIZPi8ORhnbi
	EGGxekt44r5hyeAzUHrZkI8DqqhV8RS9iC+xV1nLnZuPf2FtJZ2cqZdFghcrOezRwdEq2evSsH4
	BdWUl1EEEXccBn0Zlze2Hz+osOCdcsvymfqt14Ify3x34JNzQJiX1DbadhEq3Sw==
X-Received: by 2002:a05:600c:1549:b0:493:c601:3e23 with SMTP id 5b1f17b1804b1-4954a3d08c0mr76801375e9.5.1784391988987;
        Sat, 18 Jul 2026 09:26:28 -0700 (PDT)
Received: from mf-00-01.. ([194.220.239.180])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4954a2eddb8sm266444085e9.14.2026.07.18.09.26.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Jul 2026 09:26:28 -0700 (PDT)
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
	Leon Romanovsky <leonro@nvidia.com>,
	Jason Gunthorpe <jgg@nvidia.com>,
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
Subject: [PATCH 6/6] nvme-rdma: return BLK_STS_TARGET for unsupported P2P transfers
Date: Sat, 18 Jul 2026 16:25:47 +0000
Message-ID: <20260718162547.448892-7-mykola@meshstor.io>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260718162547.448892-1-mykola@meshstor.io>
References: <20260718162547.448892-1-mykola@meshstor.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260718_092631_979146_DE223A60 
X-CRM114-Status: GOOD (  20.59  )
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

Since commit 23528aa3320a ("nvme: enable PCI P2PDMA support for RDMA
transport") nvme-rdma accepts P2PDMA bios, but a mapping failure for
peer memory the HCA cannot reach is misreported as a path error:
ib_dma_map_sg() returns 0, discarding the -EREMOTEIO that
dma_map_sgtable() documents for exactly this case, and the driver
converts it to -EIO -> nvme_host_path_error().

Under the default multipath configuration (the multipath head node
advertises BLK_FEAT_PCI_P2PDMA since commit fb0eeeed91f3
("nvme-multipath: enable PCI P2PDMA for multipath devices")) the
path-error status makes nvme_failover_req() requeue the bios with a
fresh retry budget each cycle, and since the mapping failure is a
deterministic property of the peer/device pairing the I/O simply
never completes: a hot requeue livelock, and a stacked md mirror
hangs instead of failing over to its other leg.  With
nvme_core.multipath=N the request burns nvme_max_retries requeues --
nothing ever reaching the wire -- and completes as
BLK_STS_TRANSPORT, which blk_path_error() classifies as retryable
and md/raid1,raid10 treat as a genuine device error: retry storms on
writes, read-error-budget eviction of a healthy member on reads (see
the preceding md patches, whose mapping-failure handling keys on
BLK_STS_TARGET).

Map the data scatterlist with ib_dma_map_sgtable_attrs() so the DMA
layer's error code is preserved, and translate -EREMOTEIO to
BLK_STS_TARGET: the classification nvme-pci established in commit
91fb2b6052f7 ("nvme-pci: convert to using dma_map_sgtable()") and
the preceding blk-mq-dma patch restores (the blk_rq_dma_map
conversion had changed it to BLK_STS_INVAL).  The failure is a
property of the peer/device pairing, so it must not be retried on
this or another path.  Start the request only after mapping
succeeds, as nvme-pci does: a mapping failure now errors out of
queue_rq on a not-yet-started request, so nvme_mpath_start_request()
accounting is never taken and cannot leak on the direct blk-mq
completion (this also closes the same latent leak for the existing
BLK_STS_IOERR returns).  A mapping -ENOMEM now takes the existing
BLK_STS_RESOURCE branch instead of masquerading as a path error, and
a DMA-layer -EINVAL completes as BLK_STS_IOERR instead of a path
error; generic -EIO keeps today's host-path-error behavior, and
virt-DMA devices are unaffected.  The metadata scatterlist keeps
ib_dma_map_sg(): integrity buffers are host memory and cannot
produce -EREMOTEIO.  Ratelimit the map-failure message -- with an md
mirror steering peer-memory I/O around an unreachable leg it fires
per redirected I/O, not per rare event.

Fixes: 23528aa3320a ("nvme: enable PCI P2PDMA support for RDMA transport")
Cc: stable@vger.kernel.org # v7.1
Assisted-by: Claude:claude-fable-5
Signed-off-by: Mykola Marzhan <mykola@meshstor.io>
---
 drivers/nvme/host/rdma.c | 26 +++++++++++++++++---------
 1 file changed, 17 insertions(+), 9 deletions(-)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 6909e3542794..b8642cd2fb79 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -1469,6 +1469,7 @@ static int nvme_rdma_dma_map_req(struct ib_device *ibdev, struct request *rq,
 		int *count, int *pi_count)
 {
 	struct nvme_rdma_request *req = blk_mq_rq_to_pdu(rq);
+	struct sg_table sgt;
 	int ret;
 
 	req->data_sgl.sg_table.sgl = (struct scatterlist *)(req + 1);
@@ -1480,12 +1481,12 @@ static int nvme_rdma_dma_map_req(struct ib_device *ibdev, struct request *rq,
 
 	req->data_sgl.nents = blk_rq_map_sg(rq, req->data_sgl.sg_table.sgl);
 
-	*count = ib_dma_map_sg(ibdev, req->data_sgl.sg_table.sgl,
-			       req->data_sgl.nents, rq_dma_dir(rq));
-	if (unlikely(*count <= 0)) {
-		ret = -EIO;
+	sgt.sgl = req->data_sgl.sg_table.sgl;
+	sgt.orig_nents = req->data_sgl.nents;
+	ret = ib_dma_map_sgtable_attrs(ibdev, &sgt, rq_dma_dir(rq), 0);
+	if (unlikely(ret))
 		goto out_free_table;
-	}
+	*count = sgt.nents;
 
 	if (blk_integrity_rq(rq)) {
 		req->metadata_sgl->sg_table.sgl =
@@ -2026,8 +2027,6 @@ static blk_status_t nvme_rdma_queue_rq(struct blk_mq_hw_ctx *hctx,
 	if (ret)
 		goto unmap_qe;
 
-	nvme_start_request(rq);
-
 	if (IS_ENABLED(CONFIG_BLK_DEV_INTEGRITY) &&
 	    queue->pi_support &&
 	    (c->common.opcode == nvme_cmd_write ||
@@ -2039,11 +2038,13 @@ static blk_status_t nvme_rdma_queue_rq(struct blk_mq_hw_ctx *hctx,
 
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
@@ -2063,6 +2064,13 @@ static blk_status_t nvme_rdma_queue_rq(struct blk_mq_hw_ctx *hctx,
 		ret = nvme_host_path_error(rq);
 	else if (err == -ENOMEM || err == -EAGAIN)
 		ret = BLK_STS_RESOURCE;
+	/*
+	 * The DMA layer refused to map peer memory to this device: a
+	 * property of the pairing, not a path failure.  Match nvme-pci
+	 * and do not retry (see blk_path_error()).
+	 */
+	else if (err == -EREMOTEIO)
+		ret = BLK_STS_TARGET;
 	else
 		ret = BLK_STS_IOERR;
 	nvme_cleanup_cmd(rq);
-- 
2.43.0


