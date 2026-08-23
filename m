Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3638EC5DF8C
	for <linux-nvme@archiver.kernel.org>; Sun, 23 Aug 2026 08:49:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:Cc:To:From:Content-Type:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+DK7ON2bBB4lEgwL/cBWaPsHtk3R3CgMcEtSwNcvmH4=; b=BEBBrwubmJqY6pbWYzMGeRfGFW
	Qu1q3eg3nLNZtMAHvoQHZ0B+zugy8Lk7ZJiqqOKonKQgjPMkKP8NJZoquIrbPbqO++hs/UTvq+avB
	uvlV4f4aldB9ljfxn3xkDdz6vYYCerEiSyK0YzUz8BOba7zmn+VbN9sE8R39XTEut0HnohJLiaz9h
	IA02fg7TlZwKUrNi/isguh9PRpCNHSotV5cIMjzkQ7NQ1CxhmjIYgrvDnE8/LrSSOqiK0UR/Kua46
	GfeJbtL+1COBDE3bcfG+Kht0bzB75ocTZ5B1oobBs5qlPyAY5XMIq+h7yAgYR6SNqdngn0Ri72GYe
	u69cfYUQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wy3tE-0000000FBXW-2vaF;
	Sun, 23 Aug 2026 08:49:16 +0000
Received: from mail-ed1-f46.google.com ([209.85.208.46])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wy3tC-0000000FBUs-2x14
	for linux-nvme@lists.infradead.org;
	Sun, 23 Aug 2026 08:49:15 +0000
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-6a0c8283146so4330995a12.0
        for <linux-nvme@lists.infradead.org>; Sun, 23 Aug 2026 01:49:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787474953; x=1788079753;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+DK7ON2bBB4lEgwL/cBWaPsHtk3R3CgMcEtSwNcvmH4=;
        b=FhM6GNTjGjZCYQdlKjOoeskBxA9GX38rtR77S3iT4tXrRzw90m9TZFOsVm4Rz6AOko
         BtcEaO8Mf064+48ZaRlV68A2UIo6XV/x4/pc2qz44WJawulVo+mt4dI9jbmB9xRCctg3
         QGGzuo3UJgGYNGPQSQUb8gasQaxkv62ExNFzt4V7RF6PwvCVHeyhR5T09B6fSkCDmAIM
         53w5yRVXXBEMa+wXAT1HYuE3Mp7y8LfFZ2skjcQRfTM7ZGXGcnQKZioukbRadLChYnsE
         xK63YCMpC1LWLic/vwRB1z4j4tWzejUNIUVlgsFO2IyYUhxGKSP5ZhOPPXlepUP/he7J
         /YKw==
X-Gm-Message-State: AFuF++kpINuanaCxCKUC9p25d+p2He5xAFIl/KYX58rebaGO+wkBHbR8
	RJUuuMn6y/iIrYgbD+yw+1Y4TcYMGwcr7KhmKrHYFrhnjyBe8/K8v3GDz4+ROA==
X-Gm-Gg: AR+sD13x+bvvWelKZOcLKgHcuB2LjVED6X7aRhJnwrFMHOyVm3YCWX4TowAjKc2kM9j
	8t93MBv9L1GFEUcPRVktzTqmBZLygTYK7S1o4T8fZnjuMuH4S5hEeBvvnkgw3pzbAVWJV0S10w7
	zYQcRCoNv/PTjXn29N/m1YPAHH/o+O22cm+sra9mMyuqZP3DJcVRLka59H1HtLqt981JiInmqQd
	S9vdYHmmz3LBagKdAfMt2c6wQA7UoOAaE2QbxyYe4TCaKOcrZ6nJM5xorHkxd5qk8Fsmm/0D8re
	z7O9MBNHtg9CkTezBXY+ENef7o7wl517vpAkQ57rnsUzEieZXnCu/I6rpiAxc4MddLh+2qTPiVa
	F8lkVNpJ+G3YqoFanmlNhMlm8spsPqJjvLfAe9A7Jxbjd+xRzMZ8FlSCIke38VetLBGL3TFWJjT
	IwEAnxf79+nvy21lE6VuGZkbUOmL+IW08TUfdqL9L9nOao7d7EnPIupXxehPQrF2bhjrwtHSgk6
	+LxN+NH4KxGhZytM+fwCOQXEYr9/brscXo8lY2HYOkRdtXI16M=
X-Received: by 2002:a05:6402:2187:b0:6a3:905b:3c40 with SMTP id 4fb4d7f45d1cf-6a42f1d0649mr21101117a12.8.1787474952787;
        Sun, 23 Aug 2026 01:49:12 -0700 (PDT)
Received: from vastdata-ubuntu2.vastdata.com (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a59e00129fsm2566761a12.1.2026.08.23.01.49.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Aug 2026 01:49:12 -0700 (PDT)
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nvme@lists.infradead.org,
	Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Chaitanya Kulkarni <kch@nvidia.com>
Cc: Daniel Wagner <dwagner@suse.de>,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH 4/6] nvme-mpath: support controller crd when failing over request
Date: Sun, 23 Aug 2026 11:49:00 +0300
Message-ID: <20260823084903.193188-5-sagi@grimberg.me>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260823084903.193188-1-sagi@grimberg.me>
References: <20260823084903.193188-1-sagi@grimberg.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260823_014914_769207_C010435C 
X-CRM114-Status: GOOD (  20.55  )
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

When failing over a request (due to a path based status) we should
repect controller crd returned in the nvme completion as much as
possible. Hence we want to delay the failover command execution by
the controller crdt.

We allocate a new nvme_mpath_failover_timer referencing the request
stolen bios in a staging list, and when the command retry delay expires,
and only then the bios are moved to the mpath head requeue list which is
immediately kicked to re-submit these bios. If we failed to allocate
a fot, we fallback to the existing behavior.

Given that we now have a new staging list for mpath devices, we drain
them when removing the device.

Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/host/multipath.c | 96 +++++++++++++++++++++++++++++++++--
 drivers/nvme/host/nvme.h      |  1 +
 2 files changed, 93 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index b5501217303c..959dd1e05a2d 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -9,6 +9,13 @@
 #include <trace/events/block.h>
 #include "nvme.h"
 
+struct nvme_mpath_failover_timer {
+	struct list_head	entry;
+	struct nvme_ns_head	*head;
+	struct bio_list		bios;
+	struct timer_list	timer;
+};
+
 bool multipath = true;
 static bool multipath_always_on;
 
@@ -144,10 +151,48 @@ void nvme_mpath_start_freeze(struct nvme_subsystem *subsys)
 			blk_freeze_queue_start(h->disk->queue);
 }
 
+static void nvme_mpath_failover_timer_fn(struct timer_list *t)
+{
+	struct nvme_mpath_failover_timer *fot = timer_container_of(fot, t, timer);
+	struct nvme_ns_head *head = fot->head;
+	unsigned long flags;
+
+	spin_lock_irqsave(&head->requeue_lock, flags);
+	if (list_empty(&fot->entry)) {
+		spin_unlock_irqrestore(&head->requeue_lock, flags);
+		return;
+	}
+
+	list_del_init(&fot->entry);
+	if (fot->bios.head)
+		bio_list_merge(&head->requeue_list, &fot->bios);
+	spin_unlock_irqrestore(&head->requeue_lock, flags);
+	kblockd_schedule_work(&head->requeue_work);
+	kfree(fot);
+}
+
+static struct nvme_mpath_failover_timer *
+nvme_mpath_alloc_failover_timer(struct nvme_ns_head *head)
+{
+	struct nvme_mpath_failover_timer *fot;
+
+	fot = kzalloc(sizeof(*fot), GFP_ATOMIC);
+	if (!fot)
+		goto out;
+	fot->head = head;
+	bio_list_init(&fot->bios);
+	INIT_LIST_HEAD(&fot->entry);
+	timer_setup(&fot->timer, nvme_mpath_failover_timer_fn, 0);
+out:
+	return fot;
+}
+
 void nvme_failover_req(struct request *req)
 {
 	struct nvme_ns *ns = req->q->queuedata;
 	u16 status = nvme_req(req)->status & NVME_SCT_SC_MASK;
+	struct nvme_mpath_failover_timer *fot = NULL;
+	unsigned int delay;
 	unsigned long flags;
 	struct bio *bio;
 
@@ -167,13 +212,27 @@ void nvme_failover_req(struct request *req)
 	for (bio = req->bio; bio; bio = bio->bi_next)
 		bio_set_dev(bio, ns->head->disk->part0);
 
-	spin_lock_irqsave(&ns->head->requeue_lock, flags);
-	blk_steal_bios(&ns->head->requeue_list, req);
-	spin_unlock_irqrestore(&ns->head->requeue_lock, flags);
+	delay = nvme_crd_msecs(nvme_req(req));
+	if (delay) {
+		fot = nvme_mpath_alloc_failover_timer(ns->head);
+		if (fot) {
+			blk_steal_bios(&fot->bios, req);
+			spin_lock_irqsave(&ns->head->requeue_lock, flags);
+			list_add_tail(&fot->entry, &ns->head->fots);
+			spin_unlock_irqrestore(&ns->head->requeue_lock, flags);
+			mod_timer(&fot->timer, jiffies + msecs_to_jiffies(delay));
+		}
+	}
+	/* no CRD or timer allocation failed, fallback to immediate failover */
+	if (!fot) {
+		spin_lock_irqsave(&ns->head->requeue_lock, flags);
+		blk_steal_bios(&ns->head->requeue_list, req);
+		spin_unlock_irqrestore(&ns->head->requeue_lock, flags);
+		kblockd_schedule_work(&ns->head->requeue_work);
+	}
 
 	nvme_req(req)->status = 0;
 	nvme_end_req(req);
-	kblockd_schedule_work(&ns->head->requeue_work);
 }
 
 void nvme_mpath_start_request(struct request *rq)
@@ -689,6 +748,32 @@ static void nvme_requeue_work(struct work_struct *work)
 	}
 }
 
+static void nvme_mpath_drain_failover_timers(struct nvme_ns_head *head)
+{
+	struct nvme_mpath_failover_timer *fot;
+	unsigned long flags;
+
+	while (true) {
+		spin_lock_irqsave(&head->requeue_lock, flags);
+		fot = list_first_entry_or_null(&head->fots,
+			struct nvme_mpath_failover_timer, entry);
+		if (!fot) {
+			spin_unlock_irqrestore(&head->requeue_lock, flags);
+			return;
+		}
+		list_del_init(&fot->entry);
+		spin_unlock_irqrestore(&head->requeue_lock, flags);
+
+		timer_delete_sync(&fot->timer);
+
+		spin_lock_irqsave(&head->requeue_lock, flags);
+		if (fot->bios.head)
+			bio_list_merge(&head->requeue_list, &fot->bios);
+		spin_unlock_irqrestore(&head->requeue_lock, flags);
+		kfree(fot);
+	}
+}
+
 static void nvme_remove_head(struct nvme_ns_head *head)
 {
 	if (test_and_clear_bit(NVME_NSHEAD_DISK_LIVE, &head->flags)) {
@@ -696,6 +781,7 @@ static void nvme_remove_head(struct nvme_ns_head *head)
 		 * requeue I/O after NVME_NSHEAD_DISK_LIVE has been cleared
 		 * to allow multipath to fail all I/O.
 		 */
+		nvme_mpath_drain_failover_timers(head);
 		kblockd_schedule_work(&head->requeue_work);
 
 		if (test_and_clear_bit(NVME_NSHEAD_CDEV_LIVE, &head->flags))
@@ -731,6 +817,7 @@ int nvme_mpath_alloc_disk(struct nvme_ctrl *ctrl, struct nvme_ns_head *head)
 	mutex_init(&head->lock);
 	bio_list_init(&head->requeue_list);
 	spin_lock_init(&head->requeue_lock);
+	INIT_LIST_HEAD(&head->fots);
 	INIT_WORK(&head->requeue_work, nvme_requeue_work);
 	INIT_WORK(&head->partition_scan_work, nvme_partition_scan_work);
 	INIT_DELAYED_WORK(&head->remove_work, nvme_remove_head_work);
@@ -1424,6 +1511,7 @@ void nvme_mpath_put_disk(struct nvme_ns_head *head)
 	if (!head->disk)
 		return;
 	/* make sure all pending bios are cleaned up */
+	nvme_mpath_drain_failover_timers(head);
 	kblockd_schedule_work(&head->requeue_work);
 	flush_work(&head->requeue_work);
 	flush_work(&head->partition_scan_work);
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 944462e912f6..e63f21b3110c 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -565,6 +565,7 @@ struct nvme_ns_head {
 	struct bio_list		requeue_list;
 	spinlock_t		requeue_lock;
 	struct work_struct	requeue_work;
+	struct list_head	fots;
 	struct work_struct	partition_scan_work;
 	struct mutex		lock;
 	unsigned long		flags;
-- 
2.43.0


