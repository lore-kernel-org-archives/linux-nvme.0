Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 460A9C531F9
	for <linux-nvme@archiver.kernel.org>; Sun, 26 Jul 2026 11:33:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=TkTyU0DB9gKJtEp9Pq/+q6fIrgCHRa+7wKH1kyBFfbo=; b=bvT6DU61hMJgMkYFJ6qstwZxwt
	C1meHW1GVvsUG74KhwVPFm27dZbcAJjYviwcfKAR37lb3Lg+pux0+/erQvC9eA9U4noyO8igIodPI
	8TG4jC3pgGRqt8X90B9eTD2nqjDZrZnmzBm61dmbOsxTKNu5+bLZ/3zsyAeREK8RMf8W+VratK9tW
	NW5fh/Q5h4zC9n1MtUH2fJhci3alMTORHI7kUZoQ5l/6ORnajly19t0hHKw6U/WrWm4822YzcnsdC
	o82fO8trGSSy5nQyagzzQ/iuYiOvkWOOenpv1v1L+YrbsCwo0oQwSRouS9hFfjPvPDmdbGZ3kT/vH
	WZbaOxpQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wnx6R-000000017KH-0vZO;
	Sun, 26 Jul 2026 11:33:07 +0000
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wnx6O-000000017El-0Hqb
	for linux-nvme@lists.infradead.org;
	Sun, 26 Jul 2026 11:33:05 +0000
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-496bb7cdf51so3372085e9.2
        for <linux-nvme@lists.infradead.org>; Sun, 26 Jul 2026 04:33:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=meshstor.io; s=google; t=1785065582; x=1785670382; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TkTyU0DB9gKJtEp9Pq/+q6fIrgCHRa+7wKH1kyBFfbo=;
        b=WPsymaYGGlcFsld4TePIQesBvjrmK3NQMihTMglh/Yt/htrWQpw/ZDsnajMSqXY/PO
         7Il0I9F/4ROkij5chbpDHpoepYQ4m8CW0y+4nB1+tJBSjsuoAygE/CjuL4sLi8S3gcj1
         ZM69EeR0rW5cypDTX1XWO+na7QQnLac369ySjwAHX2elfM5zCE565vAz2uKmaDDqPc8i
         3uiuObH2oVi9B5+6kN90xTiY5/JoLbRG/kLw9BCZ9l8fguF4Yp7N4fWFibKR7sK+fuNI
         NfFDOnw+3Q8QmUEMEHvqKCvp86eyncBRSyUstt4FFBeaRYb+CLbixLM8lhSM+sqioTqN
         NOLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785065582; x=1785670382;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=TkTyU0DB9gKJtEp9Pq/+q6fIrgCHRa+7wKH1kyBFfbo=;
        b=OAgjJRcpRnQ3WqeUiVgtr9ySPiJjjP8RQ/kLddUBHnAA2XHVpl4Sz8koh4ZDa8cco9
         DtLh1LcjFgbW6T11SSjfQptvmbmbHlOshVcUgZ1bexrIetki2ZCZKL0XDuk24Huqxgvi
         NDxbeG/ZDo2rA8e36Zn3tuUStl3JZa+ELjzKkobHUaeh+F3NXzoR/LGf41OAJJE3Q/t8
         VoVmo/1E9VykWXWiwGp4tmYMYsJwjbT1upO17PXiaZITPfFAjcIebEv7J0ciRt44nlxz
         k6GJA5Yvhq6cYaNfWhhCmSS8l6sF6nomMVU9zFBMSCvVM6ciCnKCdRhwe7Jq4yBlnPcm
         U0mA==
X-Forwarded-Encrypted: i=1; AHgh+RoGRLz4pHYIzCpjgZWrQNySVRN62wDqearbpfBmU/WvZb0+k/Z2doa9ijk0KcCirVKql5Yaya1hadnb@lists.infradead.org
X-Gm-Message-State: AOJu0YwKfm1Sg5zH8aPbT1DyJDHXxDM9T+eCQDlXKRRnfwbddRQtHyza
	0u9+7PSRHtxCdQ6vf9qvhL++AA3l+Jx0twXZUSHI9p/t0kQSTZdX9Pf63UJ3OMi38w==
X-Gm-Gg: AR+sD13B2tHSnQY0VQa22XnvfKzmvcqb3yB0HvkErxY5Vl8YYeVxffKJ4fVu51HPaIz
	STkTiOgWsOrJc99WFMVMPZ/5X4nqRGe66VSBDff9z58a1HU2gPZyVAx0jIoopbxWgjt17xNz1+C
	179mG2Fel665uIuUypTnRslz8Y2Q9sZTk+SWz5deIY3Bvslo/EvRfKXrRD4l7k4fOLGvuPlah13
	8XwgplaK+0szhCfylqrzAilGHNlgMMD1SR//eTj9lfxcow3uMPehmToMVM/o9ZgaY8J2uolLJee
	3OrIkLDFd7IYSMf7siPmdLObTJfZaQl59h7P5ZZ4nt2qu01u90KLEA7yF1b1c9ocXnlAOP9ygWt
	VmgGaPvVq4ovE8Tghf336wVITKid1O/8hz5ErjsMZhLCgWalY/J8jNXu6R/KbDsVA+/t6NDAF31
	EDnMwhRUuKUDHSSpzpfz9yoMIuwg4IaKA9Ep00AVE7j01HYjUt0CIkOXJcZOVdgaQoAIMqrPkIN
	kwoWKOD4qF1ea/iDIa/c8uIHWObSJ4pREsRpPBH1bSqwxmxSTpHBk0RsTH03ts9RSJPAxQnqwKX
	AZtQM8c3zYF6/9wASbC1tOOc
X-Received: by 2002:a05:600c:46cb:b0:493:f78f:cd70 with SMTP id 5b1f17b1804b1-496b76164b3mr52698745e9.18.1785065581534;
        Sun, 26 Jul 2026 04:33:01 -0700 (PDT)
Received: from meshstor-pc ([185.87.42.56])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f85bb57cfsm40533083f8f.11.2026.07.26.04.32.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jul 2026 04:33:01 -0700 (PDT)
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
	linux-pci@vger.kernel.org,
	Thorsten Leemhuis <regressions@leemhuis.info>,
	Martin Wilck <mwilck@suse.com>
Subject: [PATCH v6 12/12] nvme-rdma: factor out the scatterlist DMA mapping helper
Date: Sun, 26 Jul 2026 13:32:29 +0200
Message-ID: <20260726113229.2154269-13-mykola@meshstor.io>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260726113229.2154269-1-mykola@meshstor.io>
References: <20260726113229.2154269-1-mykola@meshstor.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260726_043304_137547_A2DE6869 
X-CRM114-Status: GOOD (  15.24  )
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

The data and the metadata mapping do the same thing: describe the
segments blk_rq_map_sg() produced in a local sg_table -- the embedded
one's orig_nents is the allocated size, not the valid-segment count --
map that, and hand back the DMA-mapped count.  Fold both into a
helper.

No functional change.

Suggested-by: Logan Gunthorpe <logang@deltatee.com>
Assisted-by: Claude:claude-fable-5
Signed-off-by: Mykola Marzhan <mykola@meshstor.io>
---
 drivers/nvme/host/rdma.c | 42 +++++++++++++++++++++++++++-------------
 1 file changed, 29 insertions(+), 13 deletions(-)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 2f50509a7a61..525e5aea65a1 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -1465,11 +1465,33 @@ static int nvme_rdma_map_sg_pi(struct nvme_rdma_queue *queue,
 	return -EINVAL;
 }
 
+/*
+ * Map the segments blk_rq_map_sg() produced.  They are described by a local
+ * sg_table because the embedded one's orig_nents is the allocated size, not
+ * the number of valid segments; rdma_rw_ctx_init() does the same.
+ */
+static int nvme_rdma_dma_map_sgl(struct ib_device *ibdev,
+		struct scatterlist *sgl, int nents,
+		enum dma_data_direction dir, int *count)
+{
+	struct sg_table sgt = {
+		.sgl		= sgl,
+		.orig_nents	= nents,
+	};
+	int ret;
+
+	ret = ib_dma_map_sgtable_attrs(ibdev, &sgt, dir, 0);
+	if (unlikely(ret))
+		return ret;
+
+	*count = sgt.nents;
+	return 0;
+}
+
 static int nvme_rdma_dma_map_req(struct ib_device *ibdev, struct request *rq,
 		int *count, int *pi_count)
 {
 	struct nvme_rdma_request *req = blk_mq_rq_to_pdu(rq);
-	struct sg_table sgt;
 	int ret;
 
 	req->data_sgl.sg_table.sgl = (struct scatterlist *)(req + 1);
@@ -1481,14 +1503,10 @@ static int nvme_rdma_dma_map_req(struct ib_device *ibdev, struct request *rq,
 
 	req->data_sgl.nents = blk_rq_map_sg(rq, req->data_sgl.sg_table.sgl);
 
-	sgt = (struct sg_table) {
-		.sgl		= req->data_sgl.sg_table.sgl,
-		.orig_nents	= req->data_sgl.nents,
-	};
-	ret = ib_dma_map_sgtable_attrs(ibdev, &sgt, rq_dma_dir(rq), 0);
+	ret = nvme_rdma_dma_map_sgl(ibdev, req->data_sgl.sg_table.sgl,
+				    req->data_sgl.nents, rq_dma_dir(rq), count);
 	if (unlikely(ret))
 		goto out_free_table;
-	*count = sgt.nents;
 
 	if (blk_integrity_rq(rq)) {
 		req->metadata_sgl->sg_table.sgl =
@@ -1504,14 +1522,12 @@ static int nvme_rdma_dma_map_req(struct ib_device *ibdev, struct request *rq,
 
 		req->metadata_sgl->nents = blk_rq_map_integrity_sg(rq,
 				req->metadata_sgl->sg_table.sgl);
-		sgt = (struct sg_table) {
-			.sgl		= req->metadata_sgl->sg_table.sgl,
-			.orig_nents	= req->metadata_sgl->nents,
-		};
-		ret = ib_dma_map_sgtable_attrs(ibdev, &sgt, rq_dma_dir(rq), 0);
+		ret = nvme_rdma_dma_map_sgl(ibdev,
+					    req->metadata_sgl->sg_table.sgl,
+					    req->metadata_sgl->nents,
+					    rq_dma_dir(rq), pi_count);
 		if (unlikely(ret))
 			goto out_free_pi_table;
-		*pi_count = sgt.nents;
 	}
 
 	return 0;
-- 
2.52.0


