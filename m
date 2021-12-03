Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58CA1C433FE
	for <linux-nvme@archiver.kernel.org>; Fri,  3 Dec 2021 21:46:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=o9zV3AsUZv3pbYT8ZjfgRU03aeoO//Fo4QIP9poWU10=; b=i48l5KNkrmsZ2V7FCs5PrFOEFA
	3crUqNAMJkOaeQu17QL6NxvyWKIt2/5qnfhvuOfFLY0v7A2sxjvAx8a/D8cU//qB3BRxPHpZ7UOM1
	KUZvU6NOJ65UBS4AZG8sjrbvGbYMd32nM2ZoWos2wRvREwZj2hg51i0ovsmXRQCbU90A39QsI9ciY
	oy2At7RhIgb5k1xdo0T3MLZ5m7VypB1WYaxokrEHfENGsu5TfH8MxgBjp0dU5TuBZ2uh8P3A8e4SE
	pkHh8bL/9zsEWaRpWGIKtLvkrKUFlO7RxpJb/JRXK4QtX6ZYux9ys5vMC3PNE97AoIYZTg32miXk+
	nGEmPi9w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mtGO5-00H3ue-Hl; Fri, 03 Dec 2021 21:46:37 +0000
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mtGNS-00H3mL-5J
 for linux-nvme@lists.infradead.org; Fri, 03 Dec 2021 21:45:59 +0000
Received: by mail-pj1-x1032.google.com with SMTP id x7so3334898pjn.0
 for <linux-nvme@lists.infradead.org>; Fri, 03 Dec 2021 13:45:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel-dk.20210112.gappssmtp.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=o9zV3AsUZv3pbYT8ZjfgRU03aeoO//Fo4QIP9poWU10=;
 b=O9dRHmm+b/fSAJP61fkqyLIKKrC932Ckx8rkC8pOe2OdQfHAn1+hnqLbjSdP9HvSLU
 VtEa9hdPdc8JiuZNf/aSdpn25KLqOTvEgOgAnznvWgmwbvk5te1OgglAmnuGf8UDBeFL
 2CgcPcLYAC3oXQU9jQIjSRe9KEBwZk0ZZ0gDlDAvj8LNQ8eJhecOS2A7TbexTanGNw2R
 3LLH56MBqaEe6KLl7icZXXzWMtpcsfSFJoW4IgRlphYjmz4RjuZ21B/zDNljczxuy66k
 QRPGmS8ffOfguC4hLvFMkCqi4g9UU/J0oyPp10RD3WgLZZ+5uUB1hAVPYr9YsBclzTP3
 +OJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=o9zV3AsUZv3pbYT8ZjfgRU03aeoO//Fo4QIP9poWU10=;
 b=U5jgHdbAmRbPkvp6aLHkhsHgctRRv5mcaQqtLO0rQ880ggqwkwwtEaVJL4fc4+NfeB
 3m1+ZQkDIIV+KATQl9104EM8JT6GMdl75EoHHiuTwMk9Bxc4925vuaOd8gXCpT6MavgP
 plgXU30KoI0fNj2YV2+zOVI7k6LlxRECzazWSQ901jQi/BvTWicAOm2M36cT2VfofWu2
 QfEyTWzn0B3CkAPloSNlPJjj5FUaiOwIooUz+5JujX9JoN43sfkvIYstPTkoJXEFOQtP
 6ONp9c/0IocfxML6P+CGOkKqvDNH6SXN07X2Tm8XGQ6gygzc/tuB/emM5wPLBBogS1DG
 T7gg==
X-Gm-Message-State: AOAM533dfK7s208HccCTMavIsfsNrOMsTTfecoR+Za2BC2Nxidshnr9d
 SG1KZnrUM5e/ixxrfhg+Vw/jIA==
X-Google-Smtp-Source: ABdhPJwm5/Pin5+Uog1HvCngT5V4+Ahn+yrA4GFB6w1uHITyV+zEh9CiOMWTmUiW7fh94H39ZzWsVA==
X-Received: by 2002:a17:903:24d:b0:143:beb5:b6b1 with SMTP id
 j13-20020a170903024d00b00143beb5b6b1mr25758780plh.54.1638567956943; 
 Fri, 03 Dec 2021 13:45:56 -0800 (PST)
Received: from localhost.localdomain ([66.219.217.159])
 by smtp.gmail.com with ESMTPSA id f4sm4436225pfj.61.2021.12.03.13.45.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Dec 2021 13:45:56 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 4/4] nvme: add support for mq_ops->queue_rqs()
Date: Fri,  3 Dec 2021 14:45:44 -0700
Message-Id: <20211203214544.343460-5-axboe@kernel.dk>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211203214544.343460-1-axboe@kernel.dk>
References: <20211203214544.343460-1-axboe@kernel.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211203_134558_226667_5A7D7E4E 
X-CRM114-Status: GOOD (  18.99  )
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

This enables the block layer to send us a full plug list of requests
that need submitting. The block layer guarantees that they all belong
to the same queue, but we do have to check the hardware queue mapping
for each request.

If errors are encountered, leave them in the passed in list. Then the
block layer will handle them individually.

This is good for about a 4% improvement in peak performance, taking us
from 9.6M to 10M IOPS/core.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 drivers/nvme/host/pci.c | 61 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 61 insertions(+)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 6be6b1ab4285..197aa45ef7ef 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -981,6 +981,66 @@ static blk_status_t nvme_queue_rq(struct blk_mq_hw_ctx *hctx,
 	return BLK_STS_OK;
 }
 
+static void nvme_submit_cmds(struct nvme_queue *nvmeq, struct request **rqlist)
+{
+	spin_lock(&nvmeq->sq_lock);
+	while (!rq_list_empty(*rqlist)) {
+		struct request *req = rq_list_pop(rqlist);
+		struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
+
+		memcpy(nvmeq->sq_cmds + (nvmeq->sq_tail << nvmeq->sqes),
+				absolute_pointer(&iod->cmd), sizeof(iod->cmd));
+		if (++nvmeq->sq_tail == nvmeq->q_depth)
+			nvmeq->sq_tail = 0;
+	}
+	nvme_write_sq_db(nvmeq, true);
+	spin_unlock(&nvmeq->sq_lock);
+}
+
+static bool nvme_prep_rq_batch(struct nvme_queue *nvmeq, struct request *req)
+{
+	/*
+	 * We should not need to do this, but we're still using this to
+	 * ensure we can drain requests on a dying queue.
+	 */
+	if (unlikely(!test_bit(NVMEQ_ENABLED, &nvmeq->flags)))
+		return false;
+	if (unlikely(!nvme_check_ready(&nvmeq->dev->ctrl, req, true)))
+		return false;
+
+	req->mq_hctx->tags->rqs[req->tag] = req;
+	return nvme_prep_rq(nvmeq->dev, req) == BLK_STS_OK;
+}
+
+static void nvme_queue_rqs(struct request **rqlist)
+{
+	struct request *req = rq_list_peek(rqlist), *prev = NULL;
+	struct request *requeue_list = NULL;
+
+	do {
+		struct nvme_queue *nvmeq = req->mq_hctx->driver_data;
+
+		if (!nvme_prep_rq_batch(nvmeq, req)) {
+			/* detach 'req' and add to remainder list */
+			if (prev)
+				prev->rq_next = req->rq_next;
+			rq_list_add(&requeue_list, req);
+		} else {
+			prev = req;
+		}
+
+		req = rq_list_next(req);
+		if (!req || (prev && req->mq_hctx != prev->mq_hctx)) {
+			/* detach rest of list, and submit */
+			prev->rq_next = NULL;
+			nvme_submit_cmds(nvmeq, rqlist);
+			*rqlist = req;
+		}
+	} while (req);
+
+	*rqlist = requeue_list;
+}
+
 static __always_inline void nvme_pci_unmap_rq(struct request *req)
 {
 	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
@@ -1678,6 +1738,7 @@ static const struct blk_mq_ops nvme_mq_admin_ops = {
 
 static const struct blk_mq_ops nvme_mq_ops = {
 	.queue_rq	= nvme_queue_rq,
+	.queue_rqs	= nvme_queue_rqs,
 	.complete	= nvme_pci_complete_rq,
 	.commit_rqs	= nvme_commit_rqs,
 	.init_hctx	= nvme_init_hctx,
-- 
2.34.1


