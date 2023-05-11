Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11FF0C77B7C
	for <linux-nvme@archiver.kernel.org>; Thu, 11 May 2023 15:03:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=TdIn9zcwd8t6CE22w3nfmars1aOp84NLlDuMkhfT7FE=; b=3NtXwcuWhxgIzcVnGztlPwAj7u
	eqjgWJgfXKJ1v8Hrk9VO2n4lA+KzHF/qUqX0mQlcbCYvOYGTB/vNsNSyG8yXRXEFkrjugqh3enOxn
	TgMceEyYlqYxIEeyL7pMs1HkAaUSnQDKCUkr004RoWybFRTJAXPAH20wTId8T5G4zSpj+09hPC+/4
	+tay2fQC5FuF910aFjqNS6Q6UQiTNYox2DsjXRgAeGq1KPrHfxyid3J0ucr+7qBAfc6g8h98FmC/R
	wV5LTw1FI3gHntn4zjbDqjUr6CnCasBzxSThZFcZlZ167WQTiNFQ7IC7ctU5pOBvBNowba8F4a1tp
	0YqWnYWQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1px7pO-0099QC-2C;
	Thu, 11 May 2023 15:03:34 +0000
Received: from mail-pf1-f177.google.com ([209.85.210.177])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1px7pL-0099PU-2s
	for linux-nvme@lists.infradead.org;
	Thu, 11 May 2023 15:03:34 +0000
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-643990c5373so8811358b3a.1
        for <linux-nvme@lists.infradead.org>; Thu, 11 May 2023 08:03:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683817409; x=1686409409;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TdIn9zcwd8t6CE22w3nfmars1aOp84NLlDuMkhfT7FE=;
        b=EkxfhCK9jXJXq/AQ8R3tDt/zER6+CdbyM1SXZqeI8+TUd/KTYOZqm5S8jse5J35B5X
         i3EUPQmAvxT2BYpqDPoOvwg53250jhAod3Y/ZdbLjP/e5/lXpVnM3JrKvWZ0+jdN5NXd
         5mD3XpNutA918wiYrmmUr2+aF2rofzdXhriTQN7E4UAKkOTmV0OSh9Hkcv58Kk+6RUz0
         XpTdsFSCruDDkpU3h2DpiWN9eWmCNuAM0W/m7sWgN6NQ9X0XJ/WZOM9LpBAtAhZT9359
         05BLRN6CkS6/rJDfpurVqR2Gt7ZHdGer3T0Y8KEGDBWbtUnJL9XGlQdEYEQLfsjHgsrd
         1yjw==
X-Gm-Message-State: AC+VfDyIQLJTSTFqckxY9FbWdQWQ4d4zT2y4hYkEDKfj8iQZ9ISPSbFK
	9Z0TmkBN51mW+4K4VY86npA=
X-Google-Smtp-Source: ACHHUZ7HMUlU823w+mBXhuhRA3k43WzzWumyUwDh/HMSB2T95qwE3LeqIUqK14oBbiDSehm29IJKvw==
X-Received: by 2002:a05:6a20:9389:b0:f2:e399:b114 with SMTP id x9-20020a056a20938900b000f2e399b114mr15317483pzh.1.1683817408656;
        Thu, 11 May 2023 08:03:28 -0700 (PDT)
Received: from bvanassche-glaptop2.roam.corp.google.com ([173.214.130.133])
        by smtp.gmail.com with ESMTPSA id g8-20020aa78188000000b005a8bf239f5csm5398519pfi.193.2023.05.11.08.03.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 May 2023 08:03:28 -0700 (PDT)
From: Bart Van Assche <bvanassche@acm.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org,
	Bart Van Assche <bvanassche@acm.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Hannes Reinecke <hare@suse.de>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH] nvmet-rdma: Release connections synchronously
Date: Thu, 11 May 2023 08:03:20 -0700
Message-ID: <20230511150321.103172-1-bvanassche@acm.org>
X-Mailer: git-send-email 2.40.1.606.ga4b1b128d6-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230511_080331_953164_5CA5A8FF 
X-CRM114-Status: GOOD (  24.77  )
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

Lockdep complains about flushing queue->release_work in the NVMe RDMA target
driver because all instances of queue->release_work have the same lock class
key. Assigning a different lock class key to each release_work instance is
difficult because dynamically registered lock class keys must be unregistered
and the last use of the work_struct lock class key happens after the work
callback has returned. Hence rework the code for releasing connections as
follows:
* Add an argument to __nvmet_rdma_queue_disconnect() and also to
  nvmet_rdma_queue_disconnect() that indicates whether or not these functions
  are called from inside a CM handler callback.
* Do not call rdma_destroy_id() if called from inside a CM handler callback.
* Let these functions return a negative value if the caller should free the
  CM ID.
* Let the CM handler return a negative value if its caller should free the
  CM ID.
* Remove queue->release_work since releasing connections now happens
  synchronously.

This patch suppresses the following lockdep complaint:

======================================================
WARNING: possible circular locking dependency detected
6.3.0 #62 Not tainted
------------------------------------------------------
kworker/1:3/455 is trying to acquire lock:
ffff88813bfd9420 (&id_priv->handler_mutex){+.+.}-{3:3}, at: rdma_destroy_id+0x17/0x20 [rdma_cm]

but task is already holding lock:
ffff888131327db0 ((work_completion)(&queue->release_work)){+.+.}-{0:0}, at: process_one_work+0x793/0x1350

which lock already depends on the new lock.

the existing dependency chain (in reverse order) is:

-> #3 ((work_completion)(&queue->release_work)){+.+.}-{0:0}:
       process_one_work+0x7dc/0x1350
       worker_thread+0xfc/0x1260
       kthread+0x29e/0x340
       ret_from_fork+0x2c/0x50

-> #2 ((wq_completion)nvmet-wq){+.+.}-{0:0}:
       __flush_workqueue+0x130/0x12f0
       nvmet_rdma_cm_handler+0x961/0x39c0 [nvmet_rdma]
       cma_cm_event_handler+0xb2/0x2f0 [rdma_cm]
       cma_ib_req_handler+0x1096/0x4a50 [rdma_cm]
       cm_process_work+0x46/0x3b0 [ib_cm]
       cm_req_handler+0x20e2/0x61d0 [ib_cm]
       cm_work_handler+0xc15/0x6ce0 [ib_cm]
       process_one_work+0x843/0x1350
       worker_thread+0xfc/0x1260
       kthread+0x29e/0x340
       ret_from_fork+0x2c/0x50

-> #1 (&id_priv->handler_mutex/1){+.+.}-{3:3}:
       __mutex_lock+0x186/0x18f0
       cma_ib_req_handler+0xc3c/0x4a50 [rdma_cm]
       cm_process_work+0x46/0x3b0 [ib_cm]
       cm_req_handler+0x20e2/0x61d0 [ib_cm]
       cm_work_handler+0xc15/0x6ce0 [ib_cm]
       process_one_work+0x843/0x1350
       worker_thread+0xfc/0x1260
       kthread+0x29e/0x340
       ret_from_fork+0x2c/0x50

-> #0 (&id_priv->handler_mutex){+.+.}-{3:3}:
       __lock_acquire+0x2fc0/0x60f0
       lock_acquire+0x1a7/0x4e0
       __mutex_lock+0x186/0x18f0
       rdma_destroy_id+0x17/0x20 [rdma_cm]
       nvmet_rdma_free_queue+0x7a/0x380 [nvmet_rdma]
       nvmet_rdma_release_queue_work+0x3e/0x90 [nvmet_rdma]
       process_one_work+0x843/0x1350
       worker_thread+0xfc/0x1260
       kthread+0x29e/0x340
       ret_from_fork+0x2c/0x50

other info that might help us debug this:

Chain exists of:
  &id_priv->handler_mutex --> (wq_completion)nvmet-wq --> (work_completion)(&queue->release_work)

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock((work_completion)(&queue->release_work));
                               lock((wq_completion)nvmet-wq);
                               lock((work_completion)(&queue->release_work));
  lock(&id_priv->handler_mutex);

 *** DEADLOCK ***

2 locks held by kworker/1:3/455:
 #0: ffff888127b28538 ((wq_completion)nvmet-wq){+.+.}-{0:0}, at: process_one_work+0x766/0x1350
 #1: ffff888131327db0 ((work_completion)(&queue->release_work)){+.+.}-{0:0}, at: process_one_work+0x793/0x1350

stack backtrace:
CPU: 1 PID: 455 Comm: kworker/1:3 Not tainted 6.3.0 #62
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-1.fc38 04/01/2014
Workqueue: nvmet-wq nvmet_rdma_release_queue_work [nvmet_rdma]
Call Trace:
 <TASK>
 dump_stack_lvl+0x57/0x90
 check_noncircular+0x27b/0x310
 __lock_acquire+0x2fc0/0x60f0
 lock_acquire+0x1a7/0x4e0
 __mutex_lock+0x186/0x18f0
 rdma_destroy_id+0x17/0x20 [rdma_cm]
 nvmet_rdma_free_queue+0x7a/0x380 [nvmet_rdma]
 nvmet_rdma_release_queue_work+0x3e/0x90 [nvmet_rdma]
 process_one_work+0x843/0x1350
 worker_thread+0xfc/0x1260
 kthread+0x29e/0x340
 ret_from_fork+0x2c/0x50
 </TASK>

See also https://lore.kernel.org/all/rsmmxrchy6voi5qhl4irss5sprna3f5owkqtvybxglcv2pnylm@xmrnpfu3tfpe/

Cc: Sagi Grimberg <sagi@grimberg.me>
Cc: Hannes Reinecke <hare@suse.de>
Cc: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/nvme/target/rdma.c | 70 ++++++++++++++++++++------------------
 1 file changed, 37 insertions(+), 33 deletions(-)

diff --git a/drivers/nvme/target/rdma.c b/drivers/nvme/target/rdma.c
index 4597bca43a6d..cfd9d4368248 100644
--- a/drivers/nvme/target/rdma.c
+++ b/drivers/nvme/target/rdma.c
@@ -101,7 +101,6 @@ struct nvmet_rdma_queue {
 	spinlock_t		rsps_lock;
 	struct nvmet_rdma_cmd	*cmds;
 
-	struct work_struct	release_work;
 	struct list_head	rsp_wait_list;
 	struct list_head	rsp_wr_wait_list;
 	spinlock_t		rsp_wr_wait_lock;
@@ -167,7 +166,8 @@ static void nvmet_rdma_recv_done(struct ib_cq *cq, struct ib_wc *wc);
 static void nvmet_rdma_read_data_done(struct ib_cq *cq, struct ib_wc *wc);
 static void nvmet_rdma_write_data_done(struct ib_cq *cq, struct ib_wc *wc);
 static void nvmet_rdma_qp_event(struct ib_event *event, void *priv);
-static void nvmet_rdma_queue_disconnect(struct nvmet_rdma_queue *queue);
+static int nvmet_rdma_queue_disconnect(struct nvmet_rdma_queue *queue,
+				       bool from_cm_handler);
 static void nvmet_rdma_free_rsp(struct nvmet_rdma_device *ndev,
 				struct nvmet_rdma_rsp *r);
 static int nvmet_rdma_alloc_rsp(struct nvmet_rdma_device *ndev,
@@ -693,7 +693,7 @@ static void nvmet_rdma_error_comp(struct nvmet_rdma_queue *queue)
 		 * of admin connect error, just disconnect and
 		 * cleanup the queue
 		 */
-		nvmet_rdma_queue_disconnect(queue);
+		nvmet_rdma_queue_disconnect(queue, false);
 	}
 }
 
@@ -1360,17 +1360,6 @@ static void nvmet_rdma_free_queue(struct nvmet_rdma_queue *queue)
 	kfree(queue);
 }
 
-static void nvmet_rdma_release_queue_work(struct work_struct *w)
-{
-	struct nvmet_rdma_queue *queue =
-		container_of(w, struct nvmet_rdma_queue, release_work);
-	struct nvmet_rdma_device *dev = queue->dev;
-
-	nvmet_rdma_free_queue(queue);
-
-	kref_put(&dev->ref, nvmet_rdma_free_dev);
-}
-
 static int
 nvmet_rdma_parse_cm_connect_req(struct rdma_conn_param *conn,
 				struct nvmet_rdma_queue *queue)
@@ -1441,11 +1430,6 @@ nvmet_rdma_alloc_queue(struct nvmet_rdma_device *ndev,
 	if (ret)
 		goto out_destroy_sq;
 
-	/*
-	 * Schedules the actual release because calling rdma_destroy_id from
-	 * inside a CM callback would trigger a deadlock. (great API design..)
-	 */
-	INIT_WORK(&queue->release_work, nvmet_rdma_release_queue_work);
 	queue->dev = ndev;
 	queue->cm_id = cm_id;
 	queue->port = port->nport;
@@ -1582,11 +1566,6 @@ static int nvmet_rdma_queue_connect(struct rdma_cm_id *cm_id,
 		goto put_device;
 	}
 
-	if (queue->host_qid == 0) {
-		/* Let inflight controller teardown complete */
-		flush_workqueue(nvmet_wq);
-	}
-
 	ret = nvmet_rdma_cm_accept(cm_id, queue, &event->param.conn);
 	if (ret) {
 		/*
@@ -1638,10 +1617,17 @@ static void nvmet_rdma_queue_established(struct nvmet_rdma_queue *queue)
 	spin_unlock_irqrestore(&queue->state_lock, flags);
 }
 
-static void __nvmet_rdma_queue_disconnect(struct nvmet_rdma_queue *queue)
+/*
+ * If called from inside a CM handler callback, the CM ID must not be
+ * destroyed. Instead, a negative value is returned if the caller should
+ * destroy the CM ID.
+ */
+static int __nvmet_rdma_queue_disconnect(struct nvmet_rdma_queue *queue,
+					 bool from_cm_handler)
 {
 	bool disconnect = false;
 	unsigned long flags;
+	int ret = 0;
 
 	pr_debug("cm_id= %p queue->state= %d\n", queue->cm_id, queue->state);
 
@@ -1668,12 +1654,22 @@ static void __nvmet_rdma_queue_disconnect(struct nvmet_rdma_queue *queue)
 	spin_unlock_irqrestore(&queue->state_lock, flags);
 
 	if (disconnect) {
+		struct nvmet_rdma_device *dev = queue->dev;
+
 		rdma_disconnect(queue->cm_id);
-		queue_work(nvmet_wq, &queue->release_work);
+		if (from_cm_handler)
+			ret = -ENODEV;
+		else
+			rdma_destroy_id(queue->cm_id);
+		nvmet_rdma_free_queue(queue);
+		kref_put(&dev->ref, nvmet_rdma_free_dev);
 	}
+
+	return ret;
 }
 
-static void nvmet_rdma_queue_disconnect(struct nvmet_rdma_queue *queue)
+static int nvmet_rdma_queue_disconnect(struct nvmet_rdma_queue *queue,
+				       bool from_cm_handler)
 {
 	bool disconnect = false;
 
@@ -1685,12 +1681,16 @@ static void nvmet_rdma_queue_disconnect(struct nvmet_rdma_queue *queue)
 	mutex_unlock(&nvmet_rdma_queue_mutex);
 
 	if (disconnect)
-		__nvmet_rdma_queue_disconnect(queue);
+		return __nvmet_rdma_queue_disconnect(queue, from_cm_handler);
+
+	return 0;
 }
 
 static void nvmet_rdma_queue_connect_fail(struct rdma_cm_id *cm_id,
 		struct nvmet_rdma_queue *queue)
 {
+	struct nvmet_rdma_device *dev = queue->dev;
+
 	WARN_ON_ONCE(queue->state != NVMET_RDMA_Q_CONNECTING);
 
 	mutex_lock(&nvmet_rdma_queue_mutex);
@@ -1699,7 +1699,9 @@ static void nvmet_rdma_queue_connect_fail(struct rdma_cm_id *cm_id,
 	mutex_unlock(&nvmet_rdma_queue_mutex);
 
 	pr_err("failed to connect queue %d\n", queue->idx);
-	queue_work(nvmet_wq, &queue->release_work);
+
+	nvmet_rdma_free_queue(queue);
+	kref_put(&dev->ref, nvmet_rdma_free_dev);
 }
 
 /**
@@ -1749,6 +1751,7 @@ static int nvmet_rdma_device_removal(struct rdma_cm_id *cm_id,
 	return 1;
 }
 
+/* The caller destroys @cm_id if this function does not return zero. */
 static int nvmet_rdma_cm_handler(struct rdma_cm_id *cm_id,
 		struct rdma_cm_event *event)
 {
@@ -1779,7 +1782,7 @@ static int nvmet_rdma_cm_handler(struct rdma_cm_id *cm_id,
 		fallthrough;
 	case RDMA_CM_EVENT_DISCONNECTED:
 	case RDMA_CM_EVENT_TIMEWAIT_EXIT:
-		nvmet_rdma_queue_disconnect(queue);
+		ret = nvmet_rdma_queue_disconnect(queue, true);
 		break;
 	case RDMA_CM_EVENT_DEVICE_REMOVAL:
 		ret = nvmet_rdma_device_removal(cm_id, queue);
@@ -1791,6 +1794,7 @@ static int nvmet_rdma_cm_handler(struct rdma_cm_id *cm_id,
 	case RDMA_CM_EVENT_UNREACHABLE:
 	case RDMA_CM_EVENT_CONNECT_ERROR:
 		nvmet_rdma_queue_connect_fail(cm_id, queue);
+		ret = -ENODEV;
 		break;
 	default:
 		pr_err("received unrecognized RDMA CM event %d\n",
@@ -1812,7 +1816,7 @@ static void nvmet_rdma_delete_ctrl(struct nvmet_ctrl *ctrl)
 			list_del_init(&queue->queue_list);
 			mutex_unlock(&nvmet_rdma_queue_mutex);
 
-			__nvmet_rdma_queue_disconnect(queue);
+			__nvmet_rdma_queue_disconnect(queue, false);
 			goto restart;
 		}
 	}
@@ -1831,7 +1835,7 @@ static void nvmet_rdma_destroy_port_queues(struct nvmet_rdma_port *port)
 			continue;
 
 		list_del_init(&queue->queue_list);
-		__nvmet_rdma_queue_disconnect(queue);
+		__nvmet_rdma_queue_disconnect(queue, false);
 	}
 	mutex_unlock(&nvmet_rdma_queue_mutex);
 }
@@ -2049,7 +2053,7 @@ static void nvmet_rdma_remove_one(struct ib_device *ib_device, void *client_data
 
 		pr_info("Removing queue %d\n", queue->idx);
 		list_del_init(&queue->queue_list);
-		__nvmet_rdma_queue_disconnect(queue);
+		__nvmet_rdma_queue_disconnect(queue, false);
 	}
 	mutex_unlock(&nvmet_rdma_queue_mutex);
 

