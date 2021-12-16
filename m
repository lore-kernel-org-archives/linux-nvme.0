Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 620FDC433EF
	for <linux-nvme@archiver.kernel.org>; Thu, 16 Dec 2021 16:07:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/PWmmDkqw4hfM6o+w9vrmK9zC/wyrsfBGmnpHNH1A4s=; b=jd8yTf14myl1KrHXu/+VJ8eSvr
	TPAV+bCHRBV+4E6uWq1ZtPJC9xQNN4d74SdJGKHIUAcSBEsx0XRSPoscXeTflypaCNMxjndkMwhwb
	DmqWk/pP3tDfk8qQJpc+0KK2Rr8J5w/L2zakhp6JOook4mfboZY/zsg8XqLaCumK4Us5ozhekM56r
	GW8VfGKSPxmbAXqXN3ML50n31GYln58/Klku6VSrakKx3/fctvXjA4/fPuHNZ2DJkeYUaTna2c9A4
	lQHMVa0zcRKdrL/rr8r1A5hwGUJICD9m1y0Xyl82/P+U7ktRbDi6E1nanHdq1cgBU762CGiPFCx3f
	ytqOjk9A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mxtHo-006U9z-Dh; Thu, 16 Dec 2021 16:07:16 +0000
Received: from mail-io1-xd34.google.com ([2607:f8b0:4864:20::d34])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mxtGK-006TQ9-NW
 for linux-nvme@lists.infradead.org; Thu, 16 Dec 2021 16:05:46 +0000
Received: by mail-io1-xd34.google.com with SMTP id b187so35768057iof.11
 for <linux-nvme@lists.infradead.org>; Thu, 16 Dec 2021 08:05:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel-dk.20210112.gappssmtp.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=/PWmmDkqw4hfM6o+w9vrmK9zC/wyrsfBGmnpHNH1A4s=;
 b=cZQk8FmAyyc4dLcZnnc4aVaa72YqVCZRdQ7I9wkBxidqK2R84aK3YnNFoJkKWR26BL
 vTog6F1FcDQdAchOgFXsg5mNA+bSKdknh8fAeU22bmRev82PqjrmvE60YbMvp7BL0ADS
 7EFAvQN+Hb9Liti7xR+iQfSq4ALn+vam4aXlIaYvsIWSNsN5KROKocReO3KStx/hTwxY
 kbI92/9DCl8JYB4NzqA0IQRhF5gFVxAFoyR2GjAp+OFqkHh6+EOrn1+17rWsBKcaL5Mo
 moykKhDJzWtOEAoacgrLq5fqbVMQtF2VoGXy8smC3nGyq7YG7bFySrJI0cotKZwtHMLC
 CKRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=/PWmmDkqw4hfM6o+w9vrmK9zC/wyrsfBGmnpHNH1A4s=;
 b=LLfPAmzRq3FvDc1HwGvIgB8SyHZ9saIlDR9LFWxeglgDhDiFtfZaEpsVn6tRxPJqJ5
 A4+mnJledleJ8NgwP4kb7+Uxva0eoHu3WrJ8itoZiAGipZQN1LVjULg/j4YnYkx4jXh1
 IfbHO0Eev+TZYFaJQd97vrs6RWByN1cJlnjuwA9q+8ZKCy+EuCW3sHUmfrYKKoQUVSd/
 YjU6HF97DVAR04Jfky/zEkv9myzUvYTYUQqYHQqm4j/4EjsqOCC++v8zlpQFe47RG7Ge
 uKZJoiDOmFIlbzqeOXvLWzwE9RnzdU6lAMgx4ptCbiOEbE1ozerkULYSbC7vwbTlaGQ9
 cLpw==
X-Gm-Message-State: AOAM532JNirmjzvlKifuWD2VTpeiBw1+6AWo0cI59aHntbfhwW7S0STx
 XK1mnmeYB3gkCXH8o1wLKdpF9w==
X-Google-Smtp-Source: ABdhPJyw3+fT/a7gefxPigqVMegk1UxofIMMCBv+uVydXXF56pofuEw+FLJtbXuk0WLtOds7Jal1xQ==
X-Received: by 2002:a05:6638:389a:: with SMTP id
 b26mr9781380jav.197.1639670744180; 
 Thu, 16 Dec 2021 08:05:44 -0800 (PST)
Received: from x1.localdomain ([207.135.234.126])
 by smtp.gmail.com with ESMTPSA id s9sm3237155ild.14.2021.12.16.08.05.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Dec 2021 08:05:43 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: io-uring@vger.kernel.org, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org
Cc: Jens Axboe <axboe@kernel.dk>, Hannes Reinecke <hare@suse.de>,
 Keith Busch <kbusch@kernel.org>
Subject: [PATCH 4/4] nvme: add support for mq_ops->queue_rqs()
Date: Thu, 16 Dec 2021 09:05:37 -0700
Message-Id: <20211216160537.73236-5-axboe@kernel.dk>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211216160537.73236-1-axboe@kernel.dk>
References: <20211216160537.73236-1-axboe@kernel.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211216_080544_805440_DD8D440A 
X-CRM114-Status: GOOD (  18.04  )
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
Reviewed-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 drivers/nvme/host/pci.c | 58 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 58 insertions(+)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 6be6b1ab4285..e34ad67c4c41 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -981,6 +981,63 @@ static blk_status_t nvme_queue_rq(struct blk_mq_hw_ctx *hctx,
 	return BLK_STS_OK;
 }
 
+static void nvme_submit_cmds(struct nvme_queue *nvmeq, struct request **rqlist)
+{
+	spin_lock(&nvmeq->sq_lock);
+	while (!rq_list_empty(*rqlist)) {
+		struct request *req = rq_list_pop(rqlist);
+		struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
+
+		nvme_sq_copy_cmd(nvmeq, &iod->cmd);
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
@@ -1678,6 +1735,7 @@ static const struct blk_mq_ops nvme_mq_admin_ops = {
 
 static const struct blk_mq_ops nvme_mq_ops = {
 	.queue_rq	= nvme_queue_rq,
+	.queue_rqs	= nvme_queue_rqs,
 	.complete	= nvme_pci_complete_rq,
 	.commit_rqs	= nvme_commit_rqs,
 	.init_hctx	= nvme_init_hctx,
-- 
2.34.1


