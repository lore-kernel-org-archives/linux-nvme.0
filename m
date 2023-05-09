Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32CA9C77B7C
	for <linux-nvme@archiver.kernel.org>; Tue,  9 May 2023 13:56:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=/ShTJUrwEIN2pIILX+3qHaLCfnGJpOow3NsdyLOj+7U=; b=dW5D3Rgj2w+cP9TpMUeLpViCzy
	PbcWd0G1xy2Ethe18Kr0VZZkSVe0GpsY8+pnRZS/SLCiZv+rqUUTZrqwPACeImAQsb3GcnOjB20NI
	D/6EYB9nFiCIP5mv86h6+ESSC/flksIPR20T213i48eC+UNMn24YO8G/L7o4+djD44Z6i5HGg7Xah
	zLlc7ua9VkJdU7LlOmtmGM+EcPdQ6O0FajW4BkIAAF0FaassdAnD+UMCf+yMDO6ZC6nGVHU9g/nCE
	eKJLxebrS/FH5amfKUysde11AATNX/vhT8N8VuySeO+yX24nkqaI8oNfnwkUEE5sY1FBJHn77Z70I
	Or2sCjFw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pwNpQ-003Svi-0o;
	Tue, 09 May 2023 13:56:32 +0000
Received: from mail-pf1-f178.google.com ([209.85.210.178])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pwNpN-003Sun-0Z
	for linux-nvme@lists.infradead.org;
	Tue, 09 May 2023 13:56:30 +0000
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-64115e652eeso42737555b3a.0
        for <linux-nvme@lists.infradead.org>; Tue, 09 May 2023 06:56:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683640588; x=1686232588;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/ShTJUrwEIN2pIILX+3qHaLCfnGJpOow3NsdyLOj+7U=;
        b=enKwOJ3bzbtlmx8ZHYbv9VsBb/48yJ5xVq8eeU7T12MnQhbVUdcOkWduEOY5Q90/2P
         BCU2FF0i3w7gVN537gQGttvyCTaxEayMZzWfmAw0UzoSZgxmKaUxqVZcQnzcB1aEn2tC
         AFXY38Naa1kAlC31+pBYPnzRMFPG0c4YRSVgAapRcgEM2BxDsfhpYU2uSsEkif62f3l7
         4lliKY1oWLk3vY1XPA2kCu2QJTQt7BtX/x7Hv9l4j1h1MgCiSkfQS4HCT8/bQ7KLPQRs
         Zx8I5lnRhOcL1D6oIvE5J6ZsFxtxeNoIM0RnqejA4Cc1Wm7iLFxMFrrBKEw/P+qiST/4
         OfXw==
X-Gm-Message-State: AC+VfDzoavLPQESS6cyUVW3YLRxyWJlsdMD5QfvXUMkafI1TiKN3VbY/
	qK9DDEyvaLzNu16QNGldWKQ=
X-Google-Smtp-Source: ACHHUZ5oxDQjw6KkQycS0gAwhd8T2VGhg8/il0pTcZNxKXgBZ49sOkN10xqZFgMS18d+DsJ/Gp5oaA==
X-Received: by 2002:a05:6a20:441c:b0:101:6908:2b03 with SMTP id ce28-20020a056a20441c00b0010169082b03mr2015382pzb.25.1683640587875;
        Tue, 09 May 2023 06:56:27 -0700 (PDT)
Received: from bvanassche-glaptop2.roam.corp.google.com ([173.214.130.133])
        by smtp.gmail.com with ESMTPSA id 9-20020aa79249000000b0063db25e140bsm1824433pfp.32.2023.05.09.06.56.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 May 2023 06:56:27 -0700 (PDT)
From: Bart Van Assche <bvanassche@acm.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org,
	Bart Van Assche <bvanassche@acm.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Max Gurtovoy <maxg@mellanox.com>,
	Hannes Reinecke <hare@suse.de>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH] nvmet-rdma: Suppress a class of lockdep complaints
Date: Tue,  9 May 2023 06:56:15 -0700
Message-ID: <20230509135615.2061227-1-bvanassche@acm.org>
X-Mailer: git-send-email 2.40.1.521.gf1e218fcd8-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230509_065629_212656_74774DA8 
X-CRM114-Status: GOOD (  15.74  )
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

Waiting in nvmet_rdma_queue_connect() for previous teardowns to complete
(flush_workqueue(nvmet_wq)) confuses lockdep. Clear up this confusion by
by using dynamic lockdep keys instead of static lockdep keys for
queue->release_work.

See also the following report by Shinichiro:
https://lore.kernel.org/all/rsmmxrchy6voi5qhl4irss5sprna3f5owkqtvybxglcv2pnylm@xmrnpfu3tfpe/

This patch avoids that lockdep reports the following:

======================================================
WARNING: possible circular locking dependency detected
4.19.0-dbg+ #1 Not tainted
------------------------------------------------------
kworker/u12:0/7 is trying to acquire lock:
00000000c03a91d1 (&id_priv->handler_mutex){+.+.}, at: rdma_destroy_id+0x6f/0x440 [rdma_cm]

but task is already holding lock:
(work_completion)(&queue->release_work)){+.+.}, at: process_one_work+0x3c9/0x9f0
which lock already depends on the new lock.

the existing dependency chain (in reverse order) is:
-> #3 ((work_completion)(&queue->release_work)){+.+.}:
       process_one_work+0x447/0x9f0
       worker_thread+0x63/0x5a0
       kthread+0x1cf/0x1f0
       ret_from_fork+0x24/0x30
-> #2 ((wq_completion)"nvmet-rdma-delete-wq"){+.+.}:
       flush_workqueue+0xf3/0x970
       nvmet_rdma_cm_handler+0x1320/0x170f [nvmet_rdma]
       cma_ib_req_handler+0x72f/0xf90 [rdma_cm]
       cm_process_work+0x2e/0x110 [ib_cm]
       cm_work_handler+0x431e/0x50ba [ib_cm]
       process_one_work+0x481/0x9f0
       worker_thread+0x63/0x5a0
       kthread+0x1cf/0x1f0
       ret_from_fork+0x24/0x30
-> #1 (&id_priv->handler_mutex/1){+.+.}:
       __mutex_lock+0xfe/0xbe0
       mutex_lock_nested+0x1b/0x20
       cma_ib_req_handler+0x6aa/0xf90 [rdma_cm]
       cm_process_work+0x2e/0x110 [ib_cm]
       cm_work_handler+0x431e/0x50ba [ib_cm]
       process_one_work+0x481/0x9f0
       worker_thread+0x63/0x5a0
       kthread+0x1cf/0x1f0
       ret_from_fork+0x24/0x30
-> #0 (&id_priv->handler_mutex){+.+.}:
       lock_acquire+0xc5/0x200
       __mutex_lock+0xfe/0xbe0
       mutex_lock_nested+0x1b/0x20
       rdma_destroy_id+0x6f/0x440 [rdma_cm]
       nvmet_rdma_release_queue_work+0x8e/0x1b0 [nvmet_rdma]
       process_one_work+0x481/0x9f0
       worker_thread+0x63/0x5a0
       kthread+0x1cf/0x1f0
       ret_from_fork+0x24/0x30
other info that might help us debug this:
Chain exists of:
  &id_priv->handler_mutex --> (wq_completion)"nvmet-rdma-delete-wq" --> (work_completion)(&queue->release_work)

Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock((work_completion)(&queue->release_work));
                               lock((wq_completion)"nvmet-rdma-delete-wq");
                               lock((work_completion)(&queue->release_work));
  lock(&id_priv->handler_mutex);

 *** DEADLOCK ***

2 locks held by kworker/u12:0/7:
 #0: 00000000272134f2 ((wq_completion)"nvmet-rdma-delete-wq"){+.+.}, at: process_one_work+0x3c9/0x9f0
 #1: 0000000090531fcd ((work_completion)(&queue->release_work)){+.+.}, at: process_one_work+0x3c9/0x9f0

               stack backtrace:
CPU: 1 PID: 7 Comm: kworker/u12:0 Not tainted 4.19.0-dbg+ #1
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1 04/01/2014
Workqueue: nvmet-rdma-delete-wq nvmet_rdma_release_queue_work [nvmet_rdma]
Call Trace:
 dump_stack+0x86/0xc5
 print_circular_bug.isra.32+0x20a/0x218
 __lock_acquire+0x1c68/0x1cf0
 lock_acquire+0xc5/0x200
 __mutex_lock+0xfe/0xbe0
 mutex_lock_nested+0x1b/0x20
 rdma_destroy_id+0x6f/0x440 [rdma_cm]
 nvmet_rdma_release_queue_work+0x8e/0x1b0 [nvmet_rdma]
 process_one_work+0x481/0x9f0
 worker_thread+0x63/0x5a0
 kthread+0x1cf/0x1f0
 ret_from_fork+0x24/0x30

Cc: Sagi Grimberg <sagi@grimberg.me>
Cc: Max Gurtovoy <maxg@mellanox.com>
Cc: Hannes Reinecke <hare@suse.de>
Cc: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/nvme/target/rdma.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/target/rdma.c b/drivers/nvme/target/rdma.c
index 4597bca43a6d..2c85a15cbe8d 100644
--- a/drivers/nvme/target/rdma.c
+++ b/drivers/nvme/target/rdma.c
@@ -102,6 +102,9 @@ struct nvmet_rdma_queue {
 	struct nvmet_rdma_cmd	*cmds;
 
 	struct work_struct	release_work;
+#ifdef CONFIG_LOCKDEP
+	struct lock_class_key	key;
+#endif
 	struct list_head	rsp_wait_list;
 	struct list_head	rsp_wr_wait_list;
 	spinlock_t		rsp_wr_wait_lock;
@@ -1347,6 +1350,10 @@ static void nvmet_rdma_free_queue(struct nvmet_rdma_queue *queue)
 {
 	pr_debug("freeing queue %d\n", queue->idx);
 
+#ifdef CONFIG_LOCKDEP
+	lockdep_unregister_key(&queue->key);
+#endif
+
 	nvmet_sq_destroy(&queue->nvme_sq);
 
 	nvmet_rdma_destroy_queue_ib(queue);
@@ -1446,6 +1453,11 @@ nvmet_rdma_alloc_queue(struct nvmet_rdma_device *ndev,
 	 * inside a CM callback would trigger a deadlock. (great API design..)
 	 */
 	INIT_WORK(&queue->release_work, nvmet_rdma_release_queue_work);
+#ifdef CONFIG_LOCKDEP
+	lockdep_register_key(&queue->key);
+	lockdep_init_map(&queue->release_work.lockdep_map,
+			 "nvmet_rdma_release_work", &queue->key, 0);
+#endif
 	queue->dev = ndev;
 	queue->cm_id = cm_id;
 	queue->port = port->nport;
@@ -1462,7 +1474,7 @@ nvmet_rdma_alloc_queue(struct nvmet_rdma_device *ndev,
 	queue->idx = ida_alloc(&nvmet_rdma_queue_ida, GFP_KERNEL);
 	if (queue->idx < 0) {
 		ret = NVME_RDMA_CM_NO_RSC;
-		goto out_destroy_sq;
+		goto out_unreg_key;
 	}
 
 	/*
@@ -1511,6 +1523,12 @@ nvmet_rdma_alloc_queue(struct nvmet_rdma_device *ndev,
 	nvmet_rdma_free_rsps(queue);
 out_ida_remove:
 	ida_free(&nvmet_rdma_queue_ida, queue->idx);
+out_unreg_key:
+#ifdef CONFIG_LOCKDEP
+	lockdep_unregister_key(&queue->key);
+#else
+	;
+#endif
 out_destroy_sq:
 	nvmet_sq_destroy(&queue->nvme_sq);
 out_free_queue:

