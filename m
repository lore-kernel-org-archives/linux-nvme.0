Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEA3EC433EF
	for <linux-nvme@archiver.kernel.org>; Wed, 15 Dec 2021 16:48:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GHkkcCmXJJ1jda2AMq/ZSPcUATnxOYXoUdBw9f6zLfY=; b=Ot8JxDmD0hZX7PNb95N41Dio1b
	lCzXG8+EWF0lGN7zePnMwv8sI4bg2stbF3Ur5nPqi66xtSdS5KPkIIZedMMRVT4wf6Kp+WBOA7UPl
	C3uFKMTFo5cvwVEvwOOy4+y0tyq/Me393bfCL9OySDilhIppV6RCw91ValLp+efmvikF92XWpW2T7
	JfQAGaPjT1VkieBRL6dXiydoLaSp2DbYZJUKuxz/MVNzJ7dlx7a0iWNlozP426bb7OhPmmIhDHPWU
	OD6qdl5jGZDW9gLfRmEqeuKHHzBUekm25NSYdcL8canQfb/mKbA+wXwmLlfK6iHlxmsxEcbSlAKLT
	7C1YRfkw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mxXRd-001qIU-1W; Wed, 15 Dec 2021 16:47:57 +0000
Received: from mail-io1-xd32.google.com ([2607:f8b0:4864:20::d32])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mxX4s-001gr9-Va
 for linux-nvme@lists.infradead.org; Wed, 15 Dec 2021 16:24:30 +0000
Received: by mail-io1-xd32.google.com with SMTP id b187so31011249iof.11
 for <linux-nvme@lists.infradead.org>; Wed, 15 Dec 2021 08:24:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel-dk.20210112.gappssmtp.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=GHkkcCmXJJ1jda2AMq/ZSPcUATnxOYXoUdBw9f6zLfY=;
 b=ZU5IohPXpgO+xmewJ00YugTyjrXWG2ypQ1u/YFHFek4LZyWQaK9FcHSC4nBhBohYoS
 //ENtZQvHIjGqWI1dV5fOjf8thL+OU+4uyY0AyqEm05TrugfJK8HrDdhCDuMuoXKLLw1
 qtz6Nx6jlA3az/4vJLSCIjVOsnJuPvNe+RYNJndFfc1P6CEX2gVk23awe2mbWXcr5dvE
 RH5o0xTpXFgZVjJxJ0tFlPpUmvWzPyNCycV3dKJunV/UyFDRWhBbMF4fhLUi6lB3R4Ne
 AMjqqe68S5CtEKoDSDKTZNtDWEF8JmwGVjjPwCQ842WwonGZK0TKdJKf5blwSMBuY0wD
 re5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=GHkkcCmXJJ1jda2AMq/ZSPcUATnxOYXoUdBw9f6zLfY=;
 b=ZnWpWUcQW10ZfmhHFPZC/6S7rae5SAT4E63S7ekRPDrva6ut4ipT+HhZ2xw75ofprk
 xfY6cHURlwJxYy7REnOL9TIlWZ6t203RKItJ5FFq65UId5j5KS39MJu7oJN3VGLQY1CM
 /VnIGloUPJ+mZoaJjFdHVSFT194YwN/zxmUPFVKXMTqGM9NST/x98wpyHGjFaWWBvzYj
 JLhr+e6JXdz3qDwBLc6BFJT3LOTppRqIGWlhCep7TsZ1+DmE9c44WUhXUW8pjZIptCwt
 kLEjx6K8PuWLj/1q3LYQsr7Faw9bgymZgT++QDKdMQb00MXP9WVuEDhjMYlHmUFFJDEf
 sXUw==
X-Gm-Message-State: AOAM531FDmSVUh5bwssbjEKZ61DPL+mmch9Jajgo743AMYx4+QBIuaFt
 MWjIubs/IBAE9fk0M4cO51Pz2b1Kl8eG2Q==
X-Google-Smtp-Source: ABdhPJxYvVA+7J1Pd0qP5bf3xStc+S/n90tNk1S8k2VdZDZFXVx3Fwt+2X3+hzrWnjkpMUulssb8bQ==
X-Received: by 2002:a02:b813:: with SMTP id o19mr5943810jam.130.1639585465929; 
 Wed, 15 Dec 2021 08:24:25 -0800 (PST)
Received: from x1.localdomain ([207.135.234.126])
 by smtp.gmail.com with ESMTPSA id g1sm1153170ild.52.2021.12.15.08.24.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Dec 2021 08:24:25 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: io-uring@vger.kernel.org,
	linux-nvme@lists.infradead.org
Cc: Jens Axboe <axboe@kernel.dk>,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH 4/4] nvme: add support for mq_ops->queue_rqs()
Date: Wed, 15 Dec 2021 09:24:21 -0700
Message-Id: <20211215162421.14896-5-axboe@kernel.dk>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211215162421.14896-1-axboe@kernel.dk>
References: <20211215162421.14896-1-axboe@kernel.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211215_082427_062760_B5C5E901 
X-CRM114-Status: GOOD (  18.58  )
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

Reviewed-by: Hannes Reinecke <hare@suse.de>
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


