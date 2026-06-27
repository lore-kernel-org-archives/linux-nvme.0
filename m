Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12B11C43458
	for <linux-nvme@archiver.kernel.org>; Sat, 27 Jun 2026 04:16:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=UqQrXbvNNtV5YXjfD1Jedf36ralgeIbi+2SpSm+BWs4=; b=U4mCQ7CmSXrduRs83vrEc2L7xj
	/2cYfqcTbn9raGCx2sY++x4CFkSv0foed7X1APfhbgPjQFEeH2mp1397KMhd0La7j2Qp6f4sBdOpX
	5dZcIhdtIcuRDb2yKdPdrEwGN6vS9JQUnA0ZHMxml+i7h4aiPS5hN98/ZSDIfrUEkvq7tqW6sjdKC
	vAVYOMoNdjRkR9ikQBCi+WZEwEOD43K4UuthozjybfJkZDrZTu/s8Dr3oCFcvvDr7D24Ejp3yfD5x
	rAmanl/CTXCGxtGB4/JPR6yTpLHYjwYmdfIb3bU/NdUOcx6WDpHtcI7wvvAQAht5kUx9O2BWFe0u3
	LYDRc9CQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wdKTP-0000000C7w7-2dBQ;
	Sat, 27 Jun 2026 04:16:55 +0000
Received: from mail-wm1-x364.google.com ([2a00:1450:4864:20::364])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wdKTN-0000000C7va-1PXp
	for linux-nvme@lists.infradead.org;
	Sat, 27 Jun 2026 04:16:54 +0000
Received: by mail-wm1-x364.google.com with SMTP id 5b1f17b1804b1-4926046fbc5so18020915e9.0
        for <linux-nvme@lists.infradead.org>; Fri, 26 Jun 2026 21:16:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1782533811; x=1783138611; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UqQrXbvNNtV5YXjfD1Jedf36ralgeIbi+2SpSm+BWs4=;
        b=A16qppbyiNHAGUksEFW/tXP+4Kya0Ap/xM7JsVJioz9fNXoK08em6RVpJFok86dra0
         EyBLlOLw4a1sQAjJs/sGOs62T5yf10sqOfl/gzft/nKXyNbnlB0M9YwIfUXKVV0ny6X0
         N7TmFpOClF30dLaBBsDHeeFGgpECdzWlmimix81Ug8KEIiDM+ukyypC6xkdsPWOqlPeK
         yzonCrLCKzkWkiNgvvzao0A5SrQu7WOant5gbk6MbC8I2vWWwikMkCqvRl4Hfl8jzFet
         Ild4fgrE5hbl/FQNlyOcj9dAqZqCgq1vkkNtjOxNbsXuArRfeMj83NfO5+4IM+QXh6Ui
         +nXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782533811; x=1783138611;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UqQrXbvNNtV5YXjfD1Jedf36ralgeIbi+2SpSm+BWs4=;
        b=F7nylJnnF2aXFFhr7hfDK7+DZQT2fhQObK7jcXrUDiWuwWW1BjnESoPn1z7JqypXNh
         OXpzRykX9cxpgUXqdT7NKrn2C0qJ+Hd74EjQM6gQl/dGwJebkaaf9N6ym+MQFi9ixvLn
         StjrZExbQheOO1wTSMBrbY+7+ta/VTHzHXDMlnIQTL0B1VRgHxLfsoq7dGlpux2KRnIb
         sVUgTHbblw41TlgvzUx1RTlApZOE5TTQf4m5kyCojgfla8BcWbjbRZ0yPi9yx9f/EaW8
         a8KWwjdX+GeBhJSYxvyKPq9rHRcaynNVGBjDQQXh2vzi7wCzh2mJh1xEb9iZ6f6zG6Y/
         fM2A==
X-Gm-Message-State: AOJu0YwK4vv7d9TBRggpu3A09b6IgMIgfj6nFTRWAQKe5uDJ+3l3eVfl
	vUArD49J8eb1w9N1FLmfp3Go7OqbGwR43iN+KbXEoYiiGDDIQ7x2KBNwlUxPyWI9/ZnPO7DCvI2
	iArz+BzgId4P3iY7aZZ1EmY8tLcdL0c16kqbYruWQmA1T9RJUF0CI
X-Gm-Gg: AfdE7cksfSO7RAHyBhUZNqcYdzskGLWlDCC8Zb/k/Ie/dBgo7+Sp+M3EGEF4G0K3RRR
	eo3XvpB8hcD87mxS9Vkh8EtsIxs8z+Mj6mMa3gEHFEaKwfxrWDGYLyEgrknc5owJJs+vlKugSZa
	Hy29T4AijlY9Ie3p/BhCNUnfPIf5tD0R354mir8N9n8awQiA74pWNrHRfZCAnbnf+zFZw+tr0em
	w2ahwE48wFNka3HjIVLCAcC8tEUjlAAB7KRzPrtjKL+GfZCfpyq1eAAjrvi1WfwsMo/NRxhiMoK
	YkoNe9RGZaAq7es0pM5LewlDzC5LFSaCwEQI73gzyCIgNDz4IcbiRP9JLZvRGikTocHGFPPqnp9
	M2CDQ3+eTgFrAoCT420Dei7aKRUM=
X-Received: by 2002:a05:600d:8497:20b0:490:af63:2cb1 with SMTP id 5b1f17b1804b1-492663e5d71mr94058485e9.7.1782533811424;
        Fri, 26 Jun 2026 21:16:51 -0700 (PDT)
Received: from c7-smtp-2026.dev.purestorage.com ([2620:125:9017:12:36:3:6:0])
        by smtp-relay.gmail.com with ESMTPS id 5b1f17b1804b1-49268ff963dsm1889285e9.8.2026.06.26.21.16.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2026 21:16:51 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-sgogte.dev.purestorage.com (bond0.slc5-n22m24-k8s.dev.purestorage.com [IPv6:2620:125:9025:20::a31:429])
	by c7-smtp-2026.dev.purestorage.com (Postfix) with ESMTP id 65FF340146;
	Fri, 26 Jun 2026 22:16:49 -0600 (MDT)
Received: by dev-sgogte.dev.purestorage.com (Postfix, from userid 1557734945)
	id 6368551219; Fri, 26 Jun 2026 22:16:49 -0600 (MDT)
From: Surabhi Gogte <sgogte@purestorage.com>
To: Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	mkhalfella@purestorage.com,
	randyj@purestorage.com,
	adailey@purestorage.com,
	Surabhi Gogte <sgogte@purestorage.com>
Subject: [PATCH v4 1/2] nvme-rdma: refactor nvme_rdma_alloc_queue() to take a queue pointer
Date: Fri, 26 Jun 2026 22:15:50 -0600
Message-ID: <20260627041551.1981256-2-sgogte@purestorage.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260627041551.1981256-1-sgogte@purestorage.com>
References: <20260627041551.1981256-1-sgogte@purestorage.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260626_211653_395686_063729E2 
X-CRM114-Status: GOOD (  13.87  )
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

Callers are responsible for initializing queue->ctrl and queue->queue_size
before calling nvme_rdma_alloc_queue(), which now derives ctrl and idx
from the queue pointer directly. This removes redundant assignments inside
the function and simplifies the interface.

Signed-off-by: Surabhi Gogte <sgogte@purestorage.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/host/rdma.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 6909e3542794..6b0b0a3dea62 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -566,16 +566,14 @@ static int nvme_rdma_create_queue_ib(struct nvme_rdma_queue *queue)
 	return ret;
 }
 
-static int nvme_rdma_alloc_queue(struct nvme_rdma_ctrl *ctrl,
-		int idx, size_t queue_size)
+static int nvme_rdma_alloc_queue(struct nvme_rdma_queue *queue)
 {
-	struct nvme_rdma_queue *queue;
+	struct nvme_rdma_ctrl *ctrl = queue->ctrl;
+	int idx = nvme_rdma_queue_idx(queue);
 	struct sockaddr *src_addr = NULL;
 	int ret;
 
-	queue = &ctrl->queues[idx];
 	mutex_init(&queue->queue_lock);
-	queue->ctrl = ctrl;
 	if (idx && ctrl->ctrl.max_integrity_segments)
 		queue->pi_support = true;
 	else
@@ -587,8 +585,6 @@ static int nvme_rdma_alloc_queue(struct nvme_rdma_ctrl *ctrl,
 	else
 		queue->cmnd_capsule_len = sizeof(struct nvme_command);
 
-	queue->queue_size = queue_size;
-
 	queue->cm_id = rdma_create_id(&init_net, nvme_rdma_cm_handler, queue,
 			RDMA_PS_TCP, IB_QPT_RC);
 	if (IS_ERR(queue->cm_id)) {
@@ -736,8 +732,9 @@ static int nvme_rdma_alloc_io_queues(struct nvme_rdma_ctrl *ctrl)
 
 	nvmf_set_io_queues(opts, nr_io_queues, ctrl->io_queues);
 	for (i = 1; i < ctrl->ctrl.queue_count; i++) {
-		ret = nvme_rdma_alloc_queue(ctrl, i,
-				ctrl->ctrl.sqsize + 1);
+		ctrl->queues[i].ctrl = ctrl;
+		ctrl->queues[i].queue_size = ctrl->ctrl.sqsize + 1;
+		ret = nvme_rdma_alloc_queue(&ctrl->queues[i]);
 		if (ret)
 			goto out_free_queues;
 	}
@@ -783,7 +780,9 @@ static int nvme_rdma_configure_admin_queue(struct nvme_rdma_ctrl *ctrl,
 	bool pi_capable = false;
 	int error;
 
-	error = nvme_rdma_alloc_queue(ctrl, 0, NVME_AQ_DEPTH);
+	ctrl->queues[0].ctrl = ctrl;
+	ctrl->queues[0].queue_size = NVME_AQ_DEPTH;
+	error = nvme_rdma_alloc_queue(&ctrl->queues[0]);
 	if (error)
 		return error;
 
-- 
2.54.0


