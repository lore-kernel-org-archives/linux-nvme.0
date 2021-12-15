Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6B18C433F5
	for <linux-nvme@archiver.kernel.org>; Wed, 15 Dec 2021 16:49:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1DYcik58lGFYrKDca0iP2KkrzogN79aaEMRFw0vbHgE=; b=PZ4U2fVLH0GhuuFo0ovtWU63Zh
	h7zWs9WpP/ePW3xGWkJH1bDNSDZ2nmvpqmMFT7FqQuudBlKbwS8mJ2/j0E16PsdHTFI3rhJIQTUCg
	QU1sKL7qYHl/mwsiA7oCBA5T2P5uCeL++xPcCbTlEc334LHMfu0ua9q+m7VUTQbtWjHLBIl/ZGr0D
	hW4VtGHazkmAGNel0C8w8qpe/vKi8SLgVQokl7xvSahVErhvW5gwVeuRxY148KDg3kz1JPQXKSqot
	qDrDGfCXZs2EiF3uc4LYk7tEzX2NnGASCe6CCZ8tnaLpfLRp8+WQW1Hb0hK/11tjnCN8aawfyLsA5
	go5WShMw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mxXTN-001qxz-Dg; Wed, 15 Dec 2021 16:49:45 +0000
Received: from mail-il1-x12d.google.com ([2607:f8b0:4864:20::12d])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mxX4s-001gqU-Ht
 for linux-nvme@lists.infradead.org; Wed, 15 Dec 2021 16:24:29 +0000
Received: by mail-il1-x12d.google.com with SMTP id d14so17415390ila.1
 for <linux-nvme@lists.infradead.org>; Wed, 15 Dec 2021 08:24:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel-dk.20210112.gappssmtp.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=1DYcik58lGFYrKDca0iP2KkrzogN79aaEMRFw0vbHgE=;
 b=H92UQIh7lQDE/MqXfMwjpO8DpUoqUWzLi9IbMb8r4n/C7K74At2VzjQbDjReilxNYh
 wpqtVpMJ6ElZGj1HpVCZFng+Ah+BRxbFXsS0+svajfGlAvzk6swjPkIBkEDI5j4Mwd6q
 iAav4hGc3OEggO3Y1A93ZDcsgzCWgxxcNqtAFUcbJcLE9y/ve0z01u0R8lwvSQnRzK9P
 qVsi58BNwrt3nKKmLpfAMSON127XG0SbPa32MApUnm4ax9Bl9P3kWVmW3fGlSxdXyTfB
 w/xK0c7xJ0qr235TSH8dP0U7sCvjR6rLf1Yt46yggnfsxp4tQbltRGS54lVKn2R9zhuE
 p4/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=1DYcik58lGFYrKDca0iP2KkrzogN79aaEMRFw0vbHgE=;
 b=DJlFk6+BCJF9SaEbMxZYzKeX/oZQOVQRKHOz3+BEd3A8Pl5ike8I/QxTuoOBU2+ob6
 mMIrCht/UzrJEWTvb1vG0j+pO2dB5RCuw2GR32oHiEkydIthmMsp48B5HCmrVyfsB7BZ
 AfmBqPZ+Yn/uUpVO1O6K4eHhUGjgJ8TwDiQh3PR/7Iin6Oix2N+DDw1WkBSG2dmLMydJ
 k2+seN6eZRhZciyWe8Mo6JS3Jd28mPhXS4G5vNFBu+XtxbRT6fNtYtC+FGkjSod2Q9Ff
 6Tl68vLlt9tylCRUnB+VPH2lteIgInmW83KBYPr3jm27V6QRT9ZXW1tKPtwIEMqRDUi0
 gmJA==
X-Gm-Message-State: AOAM530SG6OUPPnBoBth9XvGH5cwPCOCp/7KA/eoDhvnPz9Jlf0WB9Ca
 2TvNYg09ZS+6A7olPfTiAJ52nnwkx9D7PQ==
X-Google-Smtp-Source: ABdhPJyGsBF/9EjBrDJAqNZG7AUFniv8cq1FJggtfuaKN8uVbXbVYM6OYUO/PXlTlJH9AKEbOKDauw==
X-Received: by 2002:a05:6e02:b45:: with SMTP id
 f5mr6671558ilu.283.1639585465244; 
 Wed, 15 Dec 2021 08:24:25 -0800 (PST)
Received: from x1.localdomain ([207.135.234.126])
 by smtp.gmail.com with ESMTPSA id g1sm1153170ild.52.2021.12.15.08.24.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Dec 2021 08:24:24 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: io-uring@vger.kernel.org,
	linux-nvme@lists.infradead.org
Cc: Jens Axboe <axboe@kernel.dk>,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH 3/4] nvme: separate command prep and issue
Date: Wed, 15 Dec 2021 09:24:20 -0700
Message-Id: <20211215162421.14896-4-axboe@kernel.dk>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211215162421.14896-1-axboe@kernel.dk>
References: <20211215162421.14896-1-axboe@kernel.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211215_082426_646566_C691C065 
X-CRM114-Status: GOOD (  17.62  )
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

Add a nvme_prep_rq() helper to setup a command, and nvme_queue_rq() is
adapted to use this helper.

Reviewed-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 drivers/nvme/host/pci.c | 57 ++++++++++++++++++++++++-----------------
 1 file changed, 33 insertions(+), 24 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 09ea21f75439..6be6b1ab4285 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -918,52 +918,32 @@ static blk_status_t nvme_map_metadata(struct nvme_dev *dev, struct request *req,
 	return BLK_STS_OK;
 }
 
-/*
- * NOTE: ns is NULL when called on the admin queue.
- */
-static blk_status_t nvme_queue_rq(struct blk_mq_hw_ctx *hctx,
-			 const struct blk_mq_queue_data *bd)
+static blk_status_t nvme_prep_rq(struct nvme_dev *dev, struct request *req)
 {
-	struct nvme_ns *ns = hctx->queue->queuedata;
-	struct nvme_queue *nvmeq = hctx->driver_data;
-	struct nvme_dev *dev = nvmeq->dev;
-	struct request *req = bd->rq;
 	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
-	struct nvme_command *cmnd = &iod->cmd;
 	blk_status_t ret;
 
 	iod->aborted = 0;
 	iod->npages = -1;
 	iod->nents = 0;
 
-	/*
-	 * We should not need to do this, but we're still using this to
-	 * ensure we can drain requests on a dying queue.
-	 */
-	if (unlikely(!test_bit(NVMEQ_ENABLED, &nvmeq->flags)))
-		return BLK_STS_IOERR;
-
-	if (!nvme_check_ready(&dev->ctrl, req, true))
-		return nvme_fail_nonready_command(&dev->ctrl, req);
-
-	ret = nvme_setup_cmd(ns, req);
+	ret = nvme_setup_cmd(req->q->queuedata, req);
 	if (ret)
 		return ret;
 
 	if (blk_rq_nr_phys_segments(req)) {
-		ret = nvme_map_data(dev, req, cmnd);
+		ret = nvme_map_data(dev, req, &iod->cmd);
 		if (ret)
 			goto out_free_cmd;
 	}
 
 	if (blk_integrity_rq(req)) {
-		ret = nvme_map_metadata(dev, req, cmnd);
+		ret = nvme_map_metadata(dev, req, &iod->cmd);
 		if (ret)
 			goto out_unmap_data;
 	}
 
 	blk_mq_start_request(req);
-	nvme_submit_cmd(nvmeq, cmnd, bd->last);
 	return BLK_STS_OK;
 out_unmap_data:
 	nvme_unmap_data(dev, req);
@@ -972,6 +952,35 @@ static blk_status_t nvme_queue_rq(struct blk_mq_hw_ctx *hctx,
 	return ret;
 }
 
+/*
+ * NOTE: ns is NULL when called on the admin queue.
+ */
+static blk_status_t nvme_queue_rq(struct blk_mq_hw_ctx *hctx,
+			 const struct blk_mq_queue_data *bd)
+{
+	struct nvme_queue *nvmeq = hctx->driver_data;
+	struct nvme_dev *dev = nvmeq->dev;
+	struct request *req = bd->rq;
+	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
+	blk_status_t ret;
+
+	/*
+	 * We should not need to do this, but we're still using this to
+	 * ensure we can drain requests on a dying queue.
+	 */
+	if (unlikely(!test_bit(NVMEQ_ENABLED, &nvmeq->flags)))
+		return BLK_STS_IOERR;
+
+	if (unlikely(!nvme_check_ready(&dev->ctrl, req, true)))
+		return nvme_fail_nonready_command(&dev->ctrl, req);
+
+	ret = nvme_prep_rq(dev, req);
+	if (unlikely(ret))
+		return ret;
+	nvme_submit_cmd(nvmeq, &iod->cmd, bd->last);
+	return BLK_STS_OK;
+}
+
 static __always_inline void nvme_pci_unmap_rq(struct request *req)
 {
 	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
-- 
2.34.1


