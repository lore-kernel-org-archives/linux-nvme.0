Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E18FDC4332F
	for <linux-nvme@archiver.kernel.org>; Thu, 16 Dec 2021 16:06:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=JCw+S8MiRnjhm6Un4sTvVrQkhG8i170ZABgo8Q4BBso=; b=VaOtpgH9Wcsi2IrRyIbVYfgx/r
	zlToKzrbvonVXxY9S72bo42eQYdYNRVJyt6bnoQUlKjlyOn/BCOXK6P3DQ1ujAhb4MQoV7B39jDC4
	dRuIamuqRA2DWdHUGqx3ZigGrFhaFqaLQ6+xM9CyGOJ9VhMN2zDwrc6g1B14a6KbzmFXFF4aeRlPz
	52A2GmJvkBVjZeDlOE0zkLQWlHpkgLaVbAcICjAPFhIXYHzspL0rKa7dgBGajeqKtLjjtDJkAhSps
	J853zd15N4PY3SKBm485GbDOqqglTg50zZCmAYb1nUYGREh46iZIi3c4TKiyMMb60a1azylVqGtpD
	OAX1PDcA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mxtHM-006Tsq-9I; Thu, 16 Dec 2021 16:06:48 +0000
Received: from mail-io1-xd2b.google.com ([2607:f8b0:4864:20::d2b])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mxtGJ-006TPB-UV
 for linux-nvme@lists.infradead.org; Thu, 16 Dec 2021 16:05:45 +0000
Received: by mail-io1-xd2b.google.com with SMTP id m9so35918766iop.0
 for <linux-nvme@lists.infradead.org>; Thu, 16 Dec 2021 08:05:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel-dk.20210112.gappssmtp.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=JCw+S8MiRnjhm6Un4sTvVrQkhG8i170ZABgo8Q4BBso=;
 b=NkcbH8mZTCgYOSB2aFWY8GOOMtrhf9xV8eOfa4N5jDew+OFiLEvGEPti7SXdNShxvr
 1maa4XtP5vVq/ChUxmmQsZ2ulmFCHwe/QYA+AdDQigyxivBncO/p1XEDAQAgOLBVgJ5V
 YCY16xYo7UjQoTrqw9TnYBHow6kxGTzfgyNBrK8hfch+ETpTg882tWdTFo0S6leO1GKH
 T1LfT+UENDhltpm/lK46aH0ARilQEBU1Hh1qKNmqOLRfFsjhIUoItx6lRSxLLo4Pk4RO
 Y+6abOKfcmkllsf8muRmySKKmZp2YBQgZU1euOX6/m904BiqDqoljPaXr/aw5nyndYi/
 SYDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=JCw+S8MiRnjhm6Un4sTvVrQkhG8i170ZABgo8Q4BBso=;
 b=oeocV5gTOnalZApZ2/WmtTyCtsFtdsm9hipeA5DM4J7LtL4kqrU8f9E34PgHMe9OLB
 CQvJmabilxHjkAdRJW/dTAUIUwpDc9g3XknJuh52fFTwGSuHH81adtzFF5o/hXNHgvoT
 uLwlJiTtls3OpBbDUzCqQdR6usrvR+yxLHzTkqFNl+rheB7SEdZqOfwxE06s+GI/vf/C
 EIcPqBqauQFoQGxF2MRj0FNXkHdcKyVn2vDZZAnhHTkc0Ci2+X31r5yypnh5VNAcegrd
 DcNi+d8864XohUodqeb/AAjJOKJ/oPaJ2W29c5RDOz12P8hxWYehK20a0ppwxuKtw2IF
 ZGLQ==
X-Gm-Message-State: AOAM532ZuBZYbfXDp4oi48O3GkZJuqjuOTx43pD3Rj7Z9zfBoqhIDO4O
 XVM3qNnFy5woDgJdr7Jhxduvvg==
X-Google-Smtp-Source: ABdhPJzYVUiNQvpOOg/ChWSy3WurmZn+VAg7Kx8Ahru1rOdFB2u10I4Slb8DQn/We9TEzwUaeUPVjQ==
X-Received: by 2002:a5d:9e04:: with SMTP id h4mr9632236ioh.192.1639670743239; 
 Thu, 16 Dec 2021 08:05:43 -0800 (PST)
Received: from x1.localdomain ([207.135.234.126])
 by smtp.gmail.com with ESMTPSA id s9sm3237155ild.14.2021.12.16.08.05.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Dec 2021 08:05:42 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: io-uring@vger.kernel.org, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org
Cc: Jens Axboe <axboe@kernel.dk>, Hannes Reinecke <hare@suse.de>,
 Christoph Hellwig <hch@lst.de>
Subject: [PATCH 3/4] nvme: separate command prep and issue
Date: Thu, 16 Dec 2021 09:05:36 -0700
Message-Id: <20211216160537.73236-4-axboe@kernel.dk>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211216160537.73236-1-axboe@kernel.dk>
References: <20211216160537.73236-1-axboe@kernel.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211216_080544_029908_DF6189C8 
X-CRM114-Status: GOOD (  18.40  )
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
Reviewed-by: Christoph Hellwig <hch@lst.de>
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


