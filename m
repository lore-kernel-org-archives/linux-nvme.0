Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96441C531CC
	for <linux-nvme@archiver.kernel.org>; Thu, 23 Jul 2026 20:43:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Cyyjdg8Mj0TLFiupy7K/HZDk4131Cjbb/1b/0iFmC/s=; b=CpkbAzjDt2hbhxHDmYfqMXnNFw
	A9yaQnG/YZq9cSHiu7FS1GAr4npJ/YZChz0xQZnagqtvwMqNwvCO2A2yYCLgFJOM98kWJ5W6o7GBy
	wzlyYyMtd/OSlteRmrxrq6t+tRAqAqPLwB/cjzjTBbYW5n+7O4KlDcXIRz2HHrvGBYcBDZq63C/dq
	Ac4efSi5ey8POqNNYt3zk4zvZD1mOrnAb3ugT/HaXysMjfGFNjjKto7aD2+k5UbBS7NfW0CfWFEuB
	2Axn5ua1YIMV4NvTNsJiuF17nhJzdyO9uZWvYh+rR338IHmtcuSgla9OoqtMXey4xSU0hOqY+LkyJ
	DYqj7Wcw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wn0GI-0000000F3sV-168q;
	Thu, 23 Jul 2026 20:43:22 +0000
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wn0GE-0000000F3lt-0QwQ
	for linux-nvme@lists.infradead.org;
	Thu, 23 Jul 2026 20:43:19 +0000
Received: by mail-wr1-x429.google.com with SMTP id ffacd0b85a97d-475417f010dso823693f8f.2
        for <linux-nvme@lists.infradead.org>; Thu, 23 Jul 2026 13:43:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=meshstor.io; s=google; t=1784839396; x=1785444196; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Cyyjdg8Mj0TLFiupy7K/HZDk4131Cjbb/1b/0iFmC/s=;
        b=GzVgeEgKQAgH+FCoti+9fGy6GsrMasM4hMhSULPmuxaddet/1bu2rcxjeEKiDIlzxi
         1ijcXeresWXgCvP/5ADRmD7YpArNj0jOWaAF/FQAMZImv035akyIr8hxySQXHIHKuyR5
         P7gGDaD2x8MCl08HLDevG0yAvELqvDUakF6YQRwmc6HyXn4WVFGganexGFplXbxVYyyP
         uJ/mlTBVXTfnvSoXEWWx3IXSrYMW1jEe+9DX+EDgy3EqXbRkZaECZzZ5BeW9Q2UT+fAN
         +vi+gSscOpO5G8mT3tTxTNmszPal75paAL7DAneMsKQSZ+eV5aYy/Qvbdj7ZlTFOexBy
         Z9+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784839396; x=1785444196;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Cyyjdg8Mj0TLFiupy7K/HZDk4131Cjbb/1b/0iFmC/s=;
        b=gngXhKZMEZTI1ZIgKkmCfNybIsuzaKMKkwGjasuoi5f+oaekI4omlwO8NX/mRCVKuH
         Yfue3u6unMLNnHGXAde1ZG7z+I/UvZycdXe4Xp7NaH/eUaCXpgizDoZ9VZU5xlFmvm6P
         A2Uptc6SaqBh7suxMdXB5KC/Ps/0vsz4DtzSewS9x04Q04dqq79CFEPBbBGdLEgMs0KD
         Rtqq9HftByhn/NV9uTngUlXBLCWzkB5fLoBxVIDve8+G3giHDAvS4hJyjNIlB1A7Odgk
         2K1fEoC18yxMmUbG2h3gM2sfQ2CIv84FqdPAn85at/neRKZBd7RU1nSeXzOfHX51jtE7
         HBgg==
X-Forwarded-Encrypted: i=1; AHgh+RqBLReXaFkKILFt9Ir+VsxmleWQXQ/tnK+D3vDWDAwneIrvlRxSsnvhrep3T1TFzmeMBy00A9UN0G62@lists.infradead.org
X-Gm-Message-State: AOJu0Yx8QCoE3wL8FuGE9N1cgqqANKYs+vqcGDTxmTFrXX7u8taVc2xm
	7FTt35yfb6aBWQJq00tnDeVLZVTtZU0yDWsUmRzNIJ1/uQDogMyWW7h1eKO/f4nbRg==
X-Gm-Gg: AR+sD12gLQEjWO45sa9V1fwjiKWu2LewsDVTgpi6Fq4GAMXAs7w4FchDozngwMWza2C
	WGJzp8DKr6P1Zfq5sW6N5PT7RPDGAz0CQIjiKhmIZJKoTfQZLqLuTnmJGc34ZhOSg/APlaBxTbE
	5ATdQ3pK45lDC17UMTbnKfYp8NHeg2QDKh3gLSSow+XgkTeP1TcZUyo82mIWuzTcg8b+uIglPzH
	vqSa9efqmOXLGpDHKJv/0Tb+gnyUNcCd6t0+s8n2af+YhEOYOMoM2AWI4TRUkWs+qptHzAeiwUf
	gpMoIWf2Hrcv4two9tbK4hj/A1+TzTvD++txkd4bEtVMtuu4U11atiGxbPUyBzr7WT4C+UqHlC4
	IrT1J8Mts4gM54I3JYyxzpt+vtz9uAwNV2Q67NyQJOeHpxVBIQoQT8/TRFBxtgLvlbrv4qZQKdO
	vfvgv/69fd0qE68qduBdZRkyivbK8saYVWjbXbxd0fzfeis8HJ9DHm/l16nEaxd+u4GFIaO14I8
	CS2VwTrBCJ7wZMkWQSIKRSd46ME2Fo+p0Tex9Ce5Q==
X-Received: by 2002:a05:6000:25fb:b0:47f:9446:95a1 with SMTP id ffacd0b85a97d-47f944696b0mr1793960f8f.25.1784839396094;
        Thu, 23 Jul 2026 13:43:16 -0700 (PDT)
Received: from meshstor-pc ([185.87.42.56])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f85c52fc0sm18268192f8f.23.2026.07.23.13.43.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 13:43:15 -0700 (PDT)
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
	stable@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: [PATCH v5 10/10] nvme-rdma: return BLK_STS_P2PDMA for unsupported P2P transfers
Date: Thu, 23 Jul 2026 22:42:06 +0200
Message-ID: <20260723204206.76930-11-mykola@meshstor.io>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260723204206.76930-1-mykola@meshstor.io>
References: <20260723204206.76930-1-mykola@meshstor.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260723_134318_172208_72166A5A 
X-CRM114-Status: GOOD (  13.68  )
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

A P2P transfer the PCIe topology cannot route fails DMA mapping
with -EREMOTEIO.  nvme-rdma folds every mapping error into -EIO, a
retryable host-path error: multipath requeues the I/O forever, a
single path burns its whole retry budget.

Propagate the real error code and return the unroutable case as the
non-retryable BLK_STS_P2PDMA.  As in nvme-pci, -ENOMEM now requeues
(BLK_STS_RESOURCE) and -EINVAL fails (BLK_STS_IOERR); -EIO stays a
retryable host-path error.  While at it, start the request only
after mapping succeeds -- nvme-pci's order -- and ratelimit the
map-failure message.

Fixes: 23528aa3320a ("nvme: enable PCI P2PDMA support for RDMA transport")
Cc: stable@vger.kernel.org # v7.1: requires "nvme-rdma: use ib_dma_map_sgtable_attrs()"
Assisted-by: Claude:claude-fable-5
Signed-off-by: Mykola Marzhan <mykola@meshstor.io>
---
 drivers/nvme/host/rdma.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 63830334c73e..2f50509a7a61 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -1486,10 +1486,8 @@ static int nvme_rdma_dma_map_req(struct ib_device *ibdev, struct request *rq,
 		.orig_nents	= req->data_sgl.nents,
 	};
 	ret = ib_dma_map_sgtable_attrs(ibdev, &sgt, rq_dma_dir(rq), 0);
-	if (unlikely(ret)) {
-		ret = -EIO;
+	if (unlikely(ret))
 		goto out_free_table;
-	}
 	*count = sgt.nents;
 
 	if (blk_integrity_rq(rq)) {
@@ -1511,10 +1509,8 @@ static int nvme_rdma_dma_map_req(struct ib_device *ibdev, struct request *rq,
 			.orig_nents	= req->metadata_sgl->nents,
 		};
 		ret = ib_dma_map_sgtable_attrs(ibdev, &sgt, rq_dma_dir(rq), 0);
-		if (unlikely(ret)) {
-			ret = -EIO;
+		if (unlikely(ret))
 			goto out_free_pi_table;
-		}
 		*pi_count = sgt.nents;
 	}
 
@@ -2033,8 +2029,6 @@ static blk_status_t nvme_rdma_queue_rq(struct blk_mq_hw_ctx *hctx,
 	if (ret)
 		goto unmap_qe;
 
-	nvme_start_request(rq);
-
 	if (IS_ENABLED(CONFIG_BLK_DEV_INTEGRITY) &&
 	    queue->pi_support &&
 	    (c->common.opcode == nvme_cmd_write ||
@@ -2046,11 +2040,13 @@ static blk_status_t nvme_rdma_queue_rq(struct blk_mq_hw_ctx *hctx,
 
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
@@ -2070,6 +2066,9 @@ static blk_status_t nvme_rdma_queue_rq(struct blk_mq_hw_ctx *hctx,
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


