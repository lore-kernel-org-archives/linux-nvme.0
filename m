Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 277DBC5DF9D
	for <linux-nvme@archiver.kernel.org>; Sun, 23 Aug 2026 08:49:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:Cc:To:From:Content-Type:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ug/YAKtrXSsD7GpoURyUuJYTJ5VCjrJao74VcpZLTHQ=; b=bv57bMhZrmFs5hKghMFmb49MBj
	d/e1cJFPUtQIw3JV6mY4rePRZPJ1uG1T9j1Gwtn4bKd2MsA5rmSKklDWQMcpOgi+aBxPRCvrpIDeQ
	5JW5dqSpe0QNQoNEpAn9md2053pn+ZfDcGIIjOM2ke7FahrhbybRuJEmqJA+NAJbN7Y6zdEr5+VXs
	2t6y8WWEbruUWn7Xi4FRg9YBlbQW5jX1HukuoVqbIMWF5DXq9ZwUUueNSpp/wteoqy+5cXDteUh6G
	omx+8XI753BTV9ap1pGBIXVwR/koDINbWBQMvLyVn/apyg2ob0ysnYuPS0WIZRJ/vWuM5nzSt+qXm
	2Y7i/T2g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wy3tE-0000000FBX0-2GEW;
	Sun, 23 Aug 2026 08:49:16 +0000
Received: from mail-ed1-f45.google.com ([209.85.208.45])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wy3tB-0000000FBUH-0Se1
	for linux-nvme@lists.infradead.org;
	Sun, 23 Aug 2026 08:49:14 +0000
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-6a0794669a6so4819772a12.2
        for <linux-nvme@lists.infradead.org>; Sun, 23 Aug 2026 01:49:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787474951; x=1788079751;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ug/YAKtrXSsD7GpoURyUuJYTJ5VCjrJao74VcpZLTHQ=;
        b=HDTEWSd3izyKJ60RwixAbmErM3N2PssG1SHHa5Pzzi6OKKmmfPpnU9edRoDWfPGl/V
         EcSXiDyGBaWg3dfBce80LWW6zwc4dbaSRQSgbXIfUb4gqaO/wsrsnW9KN6dmuXHYLQiT
         2wlw3Yj9P4aPPgUVWsRBiDOlip907KcG9HTcD3K7UdQOxlSYCltM8N1crZbj0El1sywi
         yl5xN5ZLhJTQnt+sTcathYghDtw0pM9DL38TAJ9fABdu0DaAOYbhLKoRkko5K3tZCBtj
         vOIYQBc8psEStQFgpPh2Uz2ta+88nI91H5pPRjWqgX0aKM4pjBbREOY3bqTrn8X7aLKo
         6ypw==
X-Gm-Message-State: AFuF++l84d+Uqt1D1A/lYeAC6/H6V19FgMBTKE5kCwjQUlrvycGeOQit
	NDEMyC6eN4N/KtCLmiEkqRjSDYqddyz6gwTHJwjnIBM9Kxmi3O6T5pPmmlztOg==
X-Gm-Gg: AR+sD10y7kF9d8ybURKw8d2atiiG8TUs4b0X6+VobEH6mseETw3TOS38EUPReM7asxQ
	5Mqe+4FbBkE9H42Di+367AtfpMdtySH2D4wl6nF/Z6N+dX489LUYgxIgSEZ9tF/5Z6H4Sn1TmS+
	iOiA7rhosx6GRGQ4XQzq/kxKHL9G7Wqo8FzNWpAoIHkWx1Y1Hrcc5D2mSn47YnZdBxGYfCLKSar
	okNcC2Rsvy5FmDbpZQEBg2xA2iLW8f5fVC3Tg8KAaWyMiQzWkaU/XSLQzValbutVVZnI2rMY4OM
	sNOEut3xUE8P76eW2LyVSxvVkXaDgJ7dFgadbPj9qa7ZRl+2ArPIli1H4hl9C60JM+oz+VAYsTO
	JIQW3M6oKBe/DPJM/ndswpzO1g1NDHMDuwt1WHIp5o4uD+32SUn5Dvw+oYpgciFrv0c4mmxCPhl
	wMHfAhXC0xr2SpCw1i3CqOfYSsBIwou8mjDY1y1OojV31gTG3dVpcpuW9+atttu9Ro2H0zg0lUL
	0xtnRRIbz1cW1L8OLwCmaknt+0IcDFxd2nqwA5eGap1xWNblyKyxvlnu0ERTwU=
X-Received: by 2002:a05:6402:414e:b0:698:3469:fa99 with SMTP id 4fb4d7f45d1cf-6a582979538mr12834939a12.0.1787474951176;
        Sun, 23 Aug 2026 01:49:11 -0700 (PDT)
Received: from vastdata-ubuntu2.vastdata.com (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a59e00129fsm2566761a12.1.2026.08.23.01.49.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Aug 2026 01:49:10 -0700 (PDT)
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nvme@lists.infradead.org,
	Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Chaitanya Kulkarni <kch@nvidia.com>
Cc: Daniel Wagner <dwagner@suse.de>,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH 3/6] nvme: add per request retry timer
Date: Sun, 23 Aug 2026 11:48:59 +0300
Message-ID: <20260823084903.193188-4-sagi@grimberg.me>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260823084903.193188-1-sagi@grimberg.me>
References: <20260823084903.193188-1-sagi@grimberg.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260823_014913_178620_E47A93FC 
X-CRM114-Status: GOOD (  16.51  )
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
Reply-To: sagi@grimberg.me
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

The existing command retry mechanism adds a request to retry
to a retry list and modifies a request-queue (controller) wide
dealyed queue timer.

The issue is that the existing requests in this queue may wait
for longer periods of time as more requests are completed with
a retry crd level.

Instead, add a per-request timer that will allow different
requests retry in a way that is independent of other requests.

Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/host/apple.c  |  1 +
 drivers/nvme/host/core.c   | 24 ++++++++++++++++++++++--
 drivers/nvme/host/fc.c     |  1 +
 drivers/nvme/host/nvme.h   |  2 ++
 drivers/nvme/host/pci.c    |  1 +
 drivers/nvme/host/rdma.c   |  1 +
 drivers/nvme/host/tcp.c    |  1 +
 drivers/nvme/target/loop.c |  1 +
 8 files changed, 30 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/apple.c b/drivers/nvme/host/apple.c
index be3b91b43ea5..c584b9551f7d 100644
--- a/drivers/nvme/host/apple.c
+++ b/drivers/nvme/host/apple.c
@@ -829,6 +829,7 @@ static int apple_nvme_init_request(struct blk_mq_tag_set *set,
 	iod->q = q;
 	nreq->ctrl = &anv->ctrl;
 	nreq->cmd = &iod->cmd;
+	nvme_req_retry_timer_init(nreq);
 
 	return 0;
 }
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index a49a86f96dd6..11c24f89f4fd 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -328,8 +328,11 @@ static void nvme_retry_req(struct request *req)
 	if (ns)
 		atomic_long_inc(&ns->retries);
 
-	blk_mq_requeue_request(req, false);
-	blk_mq_delay_kick_requeue_list(req->q, delay);
+	if (delay)
+		mod_timer(&nvme_req(req)->retry_timer,
+			jiffies + msecs_to_jiffies(delay));
+	else
+		blk_mq_requeue_request(req, true);
 }
 
 static void nvme_log_error(struct request *req)
@@ -538,6 +541,7 @@ bool nvme_cancel_request(struct request *req, void *data)
 	if (blk_mq_rq_state(req) != MQ_RQ_IN_FLIGHT)
 		return true;
 
+	timer_delete_sync(&nvme_req(req)->retry_timer);
 	nvme_req(req)->status = NVME_SC_HOST_ABORTED_CMD;
 	nvme_req(req)->flags |= NVME_REQ_CANCELLED;
 	blk_mq_complete_request(req);
@@ -720,6 +724,7 @@ EXPORT_SYMBOL_NS_GPL(nvme_put_ns, "NVME_TARGET_PASSTHRU");
 
 static inline void nvme_clear_nvme_request(struct request *req)
 {
+	WARN_ON_ONCE(timer_pending(&nvme_req(req)->retry_timer));
 	nvme_req(req)->status = 0;
 	nvme_req(req)->retries = 0;
 	nvme_req(req)->flags = 0;
@@ -1074,6 +1079,21 @@ static inline blk_status_t nvme_setup_rw(struct nvme_ns *ns,
 	return 0;
 }
 
+static void nvme_retry_timer_fn(struct timer_list *t)
+{
+	struct nvme_request *nr = timer_container_of(nr, t, retry_timer);
+
+	if (unlikely(nr->flags & NVME_REQ_CANCELLED))
+		return;
+	blk_mq_requeue_request(blk_mq_rq_from_pdu(nr), true);
+}
+
+void nvme_req_retry_timer_init(struct nvme_request *req)
+{
+	timer_setup(&req->retry_timer, nvme_retry_timer_fn, 0);
+}
+EXPORT_SYMBOL_GPL(nvme_req_retry_timer_init);
+
 void nvme_cleanup_cmd(struct request *req)
 {
 	if (req->rq_flags & RQF_SPECIAL_PAYLOAD) {
diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index 04363b9c4489..4117cf0f7ac2 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -2124,6 +2124,7 @@ nvme_fc_init_request(struct blk_mq_tag_set *set, struct request *rq,
 	op->op.fcp_req.private = &op->priv[0];
 	nvme_req(rq)->ctrl = &ctrl->ctrl;
 	nvme_req(rq)->cmd = &op->op.cmd_iu.sqe;
+	nvme_req_retry_timer_init(nvme_req(rq));
 	return res;
 }
 
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 6d8f6c541a61..944462e912f6 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -249,6 +249,7 @@ struct nvme_request {
 	unsigned long		start_time;
 #endif
 	struct nvme_ctrl	*ctrl;
+	struct timer_list	retry_timer;
 };
 
 /*
@@ -931,6 +932,7 @@ static inline unsigned long nvme_crd_msecs(struct nvme_request *req)
 	return req->ctrl->crdt[crd - 1] * 100;
 }
 
+void nvme_req_retry_timer_init(struct nvme_request *req);
 #define NVME_QID_ANY -1
 void nvme_init_request(struct request *req, struct nvme_command *cmd);
 void nvme_cleanup_cmd(struct request *req);
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 8438c904ec49..aaaa72ce7cbf 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -671,6 +671,7 @@ static int nvme_pci_init_request(struct blk_mq_tag_set *set,
 
 	nvme_req(req)->ctrl = set->driver_data;
 	nvme_req(req)->cmd = &iod->cmd;
+	nvme_req_retry_timer_init(nvme_req(req));
 	return 0;
 }
 
diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 6909e3542794..434999acc6ea 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -312,6 +312,7 @@ static int nvme_rdma_init_request(struct blk_mq_tag_set *set,
 
 	req->queue = queue;
 	nvme_req(rq)->cmd = req->sqe.data;
+	nvme_req_retry_timer_init(nvme_req(rq));
 
 	return 0;
 }
diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index ba5c7b3e2a7c..3503e3ad4d6b 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -562,6 +562,7 @@ static int nvme_tcp_init_request(struct blk_mq_tag_set *set,
 	nvme_req(rq)->cmd = &pdu->cmd;
 	init_llist_node(&req->lentry);
 	INIT_LIST_HEAD(&req->entry);
+	nvme_req_retry_timer_init(nvme_req(rq));
 
 	return 0;
 }
diff --git a/drivers/nvme/target/loop.c b/drivers/nvme/target/loop.c
index fcb1f8186fdd..86c21631345d 100644
--- a/drivers/nvme/target/loop.c
+++ b/drivers/nvme/target/loop.c
@@ -209,6 +209,7 @@ static int nvme_loop_init_request(struct blk_mq_tag_set *set,
 
 	nvme_req(req)->ctrl = &ctrl->ctrl;
 	nvme_req(req)->cmd = &iod->cmd;
+	nvme_req_retry_timer_init(nvme_req(req));
 	return nvme_loop_init_iod(ctrl, blk_mq_rq_to_pdu(req),
 			(set == &ctrl->tag_set) ? hctx_idx + 1 : 0);
 }
-- 
2.43.0


