Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BE64C7EE22
	for <linux-nvme@archiver.kernel.org>; Mon,  8 May 2023 23:35:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=pnNvxAbDgsS8oMqJQbkQzDjJ73aqMdQ09CLFYKxIAQw=; b=2nYYPuKEmgF2rJ+gGkytzoT6HN
	jI3J+3BZ3J+/uD1IrfHp41eYKSCHgLTYUo+vsxkhyQhls0RfhKwkEa3cMlRBzcvndpmGb1KsVxXNF
	jkWaONXcgnH+lL8EIujWm1lwjKIZNtcs7ip3jE+C5/NG4mdSOPTNjUJrlXZCE5f+AHZAb9g7EPxNi
	ZGzMjBYC2nw7b1vV3tILmAO90/VyY2igkvTGDR+aIzZ6bxJYipfV3UOtcn3+pglayUeBA+0WxNLvm
	AtoWXx3nVn8uENtf1woMiKXMvGDiI5uvcQGeFcCRaEgRt9//dHW86lGRScOBPab2fX+hRRHQQ9vNj
	eKUPXXYQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pwANg-001iMa-2p;
	Mon, 08 May 2023 23:35:00 +0000
Received: from mail-pl1-f172.google.com ([209.85.214.172])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pwANd-001iLf-0w
	for linux-nvme@lists.infradead.org;
	Mon, 08 May 2023 23:34:58 +0000
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1aaf706768cso39284715ad.0
        for <linux-nvme@lists.infradead.org>; Mon, 08 May 2023 16:34:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683588894; x=1686180894;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pnNvxAbDgsS8oMqJQbkQzDjJ73aqMdQ09CLFYKxIAQw=;
        b=QutiB0WIRhystli+ml4PST/nC94jcRYpaHqI+32uSeeNiiSmnJ8GYjA/SPCHA0Pb3U
         5+fTY2vU+6+cPXFjURFaZLyooYOWmiyJZSr0VDjsSEabxBWI5eWVTXP8hBPTmqUluHAv
         n/VO64QBKKnM663vYbSfuixFK9vEp0jF45v4fIv5XRcfqJynAHVI/QJ9chFucpdiApaC
         YgYlxN76rPlqtN1mwSNc2KQVh24imcmOf2oXyrn2ZZElCDTsgAbi0tdJQndrTvhRGWhu
         uh/TTGw8sRYafrsWgAw07bnk9AVH9OaGgg5Som16fp/fZ4vKzuttks+TLceDaVrR101l
         jIqQ==
X-Gm-Message-State: AC+VfDzk+P2l1RJVEQFBw/GnD1HVx2ajwwk7DJOyWhU38nPUD9860qZx
	7wwQ99VkfpDjmoStB3G4+hA=
X-Google-Smtp-Source: ACHHUZ5b6njiTten49HCIB4e+UtBdbkEqpy3B1DQijCo+pjteB1xzhFWc26FZtp7L40Jfrr9wN7NcA==
X-Received: by 2002:a17:902:e882:b0:1aa:e30e:29d3 with SMTP id w2-20020a170902e88200b001aae30e29d3mr15562525plg.29.1683588894483;
        Mon, 08 May 2023 16:34:54 -0700 (PDT)
Received: from bvanassche-glaptop2.roam.corp.google.com ([2001:4958:15a0:30:be53:1f39:fc5c:7cc8])
        by smtp.gmail.com with ESMTPSA id k10-20020a170902694a00b001a4fecf79e4sm47327plt.49.2023.05.08.16.34.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 May 2023 16:34:54 -0700 (PDT)
From: Bart Van Assche <bvanassche@acm.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org,
	Bart Van Assche <bvanassche@acm.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Max Gurtovoy <maxg@mellanox.com>,
	Hannes Reinecke <hare@suse.de>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH] nvmet-rdma: Suppress a lockdep complaint
Date: Mon,  8 May 2023 16:34:46 -0700
Message-ID: <20230508233446.2021582-1-bvanassche@acm.org>
X-Mailer: git-send-email 2.40.1.521.gf1e218fcd8-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230508_163457_328767_52AF66AF 
X-CRM114-Status: GOOD (  16.44  )
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

Although the code that waits for controllers that are being teared down
in nvmet_rdma_queue_connect() is fine, lockdep complains about that code.
Lockdep complains because all release_work instances are assigned the
same static lockdep key. Avoid that lockdep complains by using dynamic
lockdep keys instead of static lockdep keys. See also the following
commits:
* 87915adc3f0a ("workqueue: re-add lockdep dependencies for flushing").
* 777dc82395de ("nvmet-rdma: occasionally flush ongoing controller teardown").
* 108c14858b9e ("locking/lockdep: Add support for dynamic keys").

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
 drivers/nvme/target/rdma.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/target/rdma.c b/drivers/nvme/target/rdma.c
index 4597bca43a6d..f28e2db6cbe3 100644
--- a/drivers/nvme/target/rdma.c
+++ b/drivers/nvme/target/rdma.c
@@ -102,6 +102,10 @@ struct nvmet_rdma_queue {
 	struct nvmet_rdma_cmd	*cmds;
 
 	struct work_struct	release_work;
+#ifdef CONFIG_LOCKDEP
+	struct lock_class_key	key;
+	struct lockdep_map	lockdep_map;
+#endif
 	struct list_head	rsp_wait_list;
 	struct list_head	rsp_wr_wait_list;
 	spinlock_t		rsp_wr_wait_lock;
@@ -1347,6 +1351,10 @@ static void nvmet_rdma_free_queue(struct nvmet_rdma_queue *queue)
 {
 	pr_debug("freeing queue %d\n", queue->idx);
 
+#ifdef CONFIG_LOCKDEP
+	lockdep_unregister_key(&queue->key);
+#endif
+
 	nvmet_sq_destroy(&queue->nvme_sq);
 
 	nvmet_rdma_destroy_queue_ib(queue);
@@ -1446,6 +1454,11 @@ nvmet_rdma_alloc_queue(struct nvmet_rdma_device *ndev,
 	 * inside a CM callback would trigger a deadlock. (great API design..)
 	 */
 	INIT_WORK(&queue->release_work, nvmet_rdma_release_queue_work);
+#ifdef CONFIG_LOCKDEP
+	lockdep_register_key(&queue->key);
+	lockdep_init_map(&queue->lockdep_map, "nvmet_rdma_release_work",
+			 &queue->key, 0);
+#endif
 	queue->dev = ndev;
 	queue->cm_id = cm_id;
 	queue->port = port->nport;
@@ -1462,7 +1475,7 @@ nvmet_rdma_alloc_queue(struct nvmet_rdma_device *ndev,
 	queue->idx = ida_alloc(&nvmet_rdma_queue_ida, GFP_KERNEL);
 	if (queue->idx < 0) {
 		ret = NVME_RDMA_CM_NO_RSC;
-		goto out_destroy_sq;
+		goto out_unreg_key;
 	}
 
 	/*
@@ -1511,6 +1524,12 @@ nvmet_rdma_alloc_queue(struct nvmet_rdma_device *ndev,
 	nvmet_rdma_free_rsps(queue);
 out_ida_remove:
 	ida_free(&nvmet_rdma_queue_ida, queue->idx);
+out_unreg_key:
+#ifdef CONFIG_LOCKDEP
+       lockdep_unregister_key(&queue->key);
+#else
+       ;
+#endif
 out_destroy_sq:
 	nvmet_sq_destroy(&queue->nvme_sq);
 out_free_queue:

