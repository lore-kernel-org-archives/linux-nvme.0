Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DC7EC433F5
	for <linux-nvme@archiver.kernel.org>; Thu, 16 Dec 2021 16:56:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5IX74MWW+MmXrMtixah+OlhoboMuiSi2pn/mLZENDuU=; b=enEv1sFNjesMgBfo2iUbRkc3CW
	pZ65eMloAMqoq7MzzSXXhZAvMmVdKLPb1QdyDpl/iTZqHw6PWBk3rW+Zn6VXrVEXcPj3A6OPTjAuI
	YmV+YiB0PtWJXQx6NpWLzadGZxBGOPHIgf7q105Zu4NLwl2sXe4AsTPNL3Lld/rEbQGwIot2yehso
	aSVnoZhvADMojexE8HO/PeYWfpDkck6wL4nnjNO5a0DzUud6PqAuhAVTD0wUta/ImqxmeH7QC+EEy
	nYU1J2ll+E5zd2WvEprgQTfhY+tnG3FPJVDjgnjT7q3yHqBesqE8eexDzyzXRcmu5mPkFhXxXCmna
	2ZLU1zfw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mxu3Q-006lLU-Vp; Thu, 16 Dec 2021 16:56:29 +0000
Received: from mail-il1-x12d.google.com ([2607:f8b0:4864:20::12d])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mxtmc-006fpD-Rz
 for linux-nvme@lists.infradead.org; Thu, 16 Dec 2021 16:39:08 +0000
Received: by mail-il1-x12d.google.com with SMTP id l5so22515382ilv.7
 for <linux-nvme@lists.infradead.org>; Thu, 16 Dec 2021 08:39:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel-dk.20210112.gappssmtp.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=5IX74MWW+MmXrMtixah+OlhoboMuiSi2pn/mLZENDuU=;
 b=h+xv2L16XaQ7XBDfUh+cBCV9gZOt0jGlTL7hJlxewlVZdF/KeFEOAg7wqeIW1HM6ie
 jgXXOhESr35rI4HJ4X+Lu956zTOfva+wHc9X+OS+cHwQDYQQsiOlCjGGQNXxxxXL3I6Z
 KR8I0USQ0qocIEMrJdMij14zZSRyEl99f4ZwWWMeKgVe2FRjrLq7H62gvxYedEf7BfX8
 UmznztDNj7Rca2f7nqJ3qajucZsF2SZ9IXxANYRiCevLitEFfsZyIeWMZW6HlGpKh5mR
 rgjQnaQhIu5ogeO3wLn88mcMp1igflNUVn8bUtGxPxVpVFJhfl5cYUEJ6Hmk4t1EPSK5
 jZOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=5IX74MWW+MmXrMtixah+OlhoboMuiSi2pn/mLZENDuU=;
 b=DP2e7IUB1u9Z9qMaXTZr5Tdw85VlU4k2jm+8KQJVIdQGDNjGxNH7kZrwvOf0bGoSpK
 vXRZizVikEPKkztV0S/PmRlLGGXWr9ysd+nxbzlnKSX3k3Ib7e6c4SGTjQf1/E4CfRdR
 LU8HgThXr4+/+UksaOgIP+IBwzKvmlAGo8qRu0NjSfe6nK/PlErIUFTs4AMTye3mg3E9
 5oANvjCL2g1J0ZdiZ+Ht9sxu0Csm8Nx1Gv2iQenIrMkn9dw1b7xZZNv4rFQegZT3ZBns
 iN2US7mSI6ZVpGDjLLD5NoeeOwC6GRXo92UhJeNmX7waqa/NtgRJMy43UIJgFxIHMZY9
 grQQ==
X-Gm-Message-State: AOAM5320S2Clr8OpyeRGHvJkxtBKAoalXjDtbaPcIbLwhk9AeHZeJ5MJ
 M3/sLeY1o7niSixxvqitcY2wXg==
X-Google-Smtp-Source: ABdhPJypT/FJAV4gbG5r+26xb+eg8kD4Wm9SRoUbE/cBV9XcOAGBXdJ3GFjTL1jOtWhomlwQk+8iqg==
X-Received: by 2002:a05:6e02:1528:: with SMTP id
 i8mr10122850ilu.312.1639672746003; 
 Thu, 16 Dec 2021 08:39:06 -0800 (PST)
Received: from x1.localdomain ([207.135.234.126])
 by smtp.gmail.com with ESMTPSA id t17sm71816ilm.46.2021.12.16.08.39.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Dec 2021 08:39:05 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: io-uring@vger.kernel.org, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org
Cc: Jens Axboe <axboe@kernel.dk>, Hannes Reinecke <hare@suse.de>,
 Christoph Hellwig <hch@lst.de>
Subject: [PATCH 3/4] nvme: separate command prep and issue
Date: Thu, 16 Dec 2021 09:39:00 -0700
Message-Id: <20211216163901.81845-4-axboe@kernel.dk>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211216163901.81845-1-axboe@kernel.dk>
References: <20211216163901.81845-1-axboe@kernel.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211216_083906_966583_49F08C64 
X-CRM114-Status: GOOD (  18.79  )
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
 drivers/nvme/host/pci.c | 63 +++++++++++++++++++++++------------------
 1 file changed, 36 insertions(+), 27 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 9d2a36de228a..7062128c8204 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -903,55 +903,32 @@ static blk_status_t nvme_map_metadata(struct nvme_dev *dev, struct request *req,
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
-	spin_lock(&nvmeq->sq_lock);
-	nvme_sq_copy_cmd(nvmeq, &iod->cmd);
-	nvme_write_sq_db(nvmeq, bd->last);
-	spin_unlock(&nvmeq->sq_lock);
 	return BLK_STS_OK;
 out_unmap_data:
 	nvme_unmap_data(dev, req);
@@ -960,6 +937,38 @@ static blk_status_t nvme_queue_rq(struct blk_mq_hw_ctx *hctx,
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
+	spin_lock(&nvmeq->sq_lock);
+	nvme_sq_copy_cmd(nvmeq, &iod->cmd);
+	nvme_write_sq_db(nvmeq, bd->last);
+	spin_unlock(&nvmeq->sq_lock);
+	return BLK_STS_OK;
+}
+
 static __always_inline void nvme_pci_unmap_rq(struct request *req)
 {
 	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
-- 
2.34.1


