Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87A33C433EF
	for <linux-nvme@archiver.kernel.org>; Fri,  3 Dec 2021 21:46:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=yxdkcGfQVk3YgliGR9Ok7AI5TvejdPpxVDGMXfDvDmw=; b=zPqv+nCXxrmYOmobsI7J0V0Noo
	dYfvHI46edr9CmQsG7Cf9sIBvvQ1oCixGGH44HuGJY6qkXC6kgGR0VR0lRI3rKyaZverbgUkvulOr
	Nh+k2bc6KVXfeYuE6ZvdZeHYiaiP9HD/YHECkZKMcoLyqC/l4S35M5tOh46E2qbMjyEbGZb05h8qz
	ProdGy29E68/GBqQSnmn3g8VpfSFMCvoFvwBtkL8yPBkTPj0AHBbNxLN6Va9lFo4PwkHJ32zLuKUg
	7TsVGXg8YZUPCDnikcKKYndfYQM2OG8MDlhWF3LptH1t8ITDoxtsv5h0Jz3fEctPzWs52P80+/9Q0
	7RqgZIjg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mtGNv-00H3rb-2R; Fri, 03 Dec 2021 21:46:27 +0000
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mtGNR-00H3m1-A2
 for linux-nvme@lists.infradead.org; Fri, 03 Dec 2021 21:45:58 +0000
Received: by mail-pg1-x535.google.com with SMTP id l190so4339503pge.7
 for <linux-nvme@lists.infradead.org>; Fri, 03 Dec 2021 13:45:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel-dk.20210112.gappssmtp.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=yxdkcGfQVk3YgliGR9Ok7AI5TvejdPpxVDGMXfDvDmw=;
 b=rbNOBEBv2NoUR31USK/AYDPLPOUhO+dsBIII1KaC+beReWqI2g8RNiuS4nLx+z6kmS
 9F77UtnxERF3U3astDqQcQLgUP4OK2rTUV5/7K5to7dNB7blAIYkxA+1JduHnbxNKuGH
 PUESMy20z1wiy6LO4zvbRppKOSwzQ4sm81w12VNHZxnyWsyxRFLD688vnsC8TCeTXUDy
 t7xuOBF3K8GwVOxkyQCF5xTk+H1nKjxrmXQK7G2pHpiEdhW4G5yXYKEETAhwl5kJeK7C
 TCgUh8mRX0vbiR94K+woA3p66USVWvpTglDYzpuJa5RUw/eUHISGUMuv0sbU0JfV0zqC
 7hFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=yxdkcGfQVk3YgliGR9Ok7AI5TvejdPpxVDGMXfDvDmw=;
 b=bdWLPdAQnXZx9KlGACkMSTn3Nn3BnfV5TInOr/AFsMhcU8Dcj5Tg2ENFg6xd+F7GMV
 jRm6lOG5ir8YHhtZmT4xDUsyakxgw/lgVFkZzlffWXYD5ybRBzbfijDH2EFssklasmMh
 cx30c6Wpxi2uYe7ZVe/u36XKy/w97t8BfbJwRRpmGl19Otnn0yv252K2AuIhSfcdrJ4T
 cm1Fhq3JMitc8Gqx35kFN9ZVr+7M2sMePlVL3BCg6/qvi/l3/4Aqk21WB189LvQpeMd1
 Ro8+2juskqMBbQDloMZao0HzgkBIzWMfATBit1UWQuYj9xuegjhkRKZlccoIvA1UJfDA
 g1Dg==
X-Gm-Message-State: AOAM530ove2KO5MGJ2mZZgqGtTz38V8s9bn7rpxyj4P75avK6yYHgZiw
 4VMPfQSviWVtFLZySuMY+ajZb6F+nX0g29QJ
X-Google-Smtp-Source: ABdhPJzT1fEaPTjdNcvOwRImCv1vbb5q/LX7DIW1dRgqYVU2gef6EkgZ9O1T3hEp0DDkhe7umk71Sw==
X-Received: by 2002:a05:6a00:1705:b0:4a0:3492:16c with SMTP id
 h5-20020a056a00170500b004a03492016cmr21682439pfc.3.1638567956085; 
 Fri, 03 Dec 2021 13:45:56 -0800 (PST)
Received: from localhost.localdomain ([66.219.217.159])
 by smtp.gmail.com with ESMTPSA id f4sm4436225pfj.61.2021.12.03.13.45.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Dec 2021 13:45:55 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 3/4] nvme: separate command prep and issue
Date: Fri,  3 Dec 2021 14:45:43 -0700
Message-Id: <20211203214544.343460-4-axboe@kernel.dk>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211203214544.343460-1-axboe@kernel.dk>
References: <20211203214544.343460-1-axboe@kernel.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211203_134557_371924_FC1A8913 
X-CRM114-Status: GOOD (  17.79  )
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


