Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D8A4CD98D2
	for <linux-nvme@archiver.kernel.org>; Thu, 13 Nov 2025 20:23:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=Y6+cxABZnS3YSrSISK/yjuFruYB/W5uByVrGxiYBwl4=; b=kVN4zTJGLcON+KA+zG5U+/PFJ8
	WbXNtgFvsfq7dn682zNXyAoJ8DpnPOmSFfEYtFTmJrur1QOzbS6YB2zrQdidSbd2xJ7Z/QGP15id/
	2yCA5fw8G2u+9nKNxOa/voyzO6tpx/Mq6Jag/HYivDhm4QvnvuvSZjAnIJzhYuo8yS59j6fRYYMjg
	jisNhkt805EOW7iYTeDmqU5XOKuViiGYj9RGivCTGBuXxQjuhdmnGR8VqmNnPf1P3fgWQgR5Y9lDz
	hqh0MW9OQHNu0poiwtsh7zJPXpMOJlGfqbd808GUPzcyVti/BQZ62hVUPgtr74AEwdfm39Iiy2T6T
	sv0IIICA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vJdqv-0000000B4gO-2eeJ;
	Thu, 13 Nov 2025 20:23:33 +0000
Received: from mail-pg1-x52e.google.com ([2607:f8b0:4864:20::52e])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vJdqt-0000000B4g2-3mOS
	for linux-nvme@lists.infradead.org;
	Thu, 13 Nov 2025 20:23:33 +0000
Received: by mail-pg1-x52e.google.com with SMTP id 41be03b00d2f7-ba488b064cbso967304a12.1
        for <linux-nvme@lists.infradead.org>; Thu, 13 Nov 2025 12:23:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1763065410; x=1763670210; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Y6+cxABZnS3YSrSISK/yjuFruYB/W5uByVrGxiYBwl4=;
        b=FpB3KyRdMGnbhdoBzkWixbdFdo8rWF00XDstS66hnW3y5es9AriW2kCeGno6mTREPU
         BpJYGN7eXOEfVKfv9iYVHzibqSviAjnIYxo/CkYRVKZ9iuN8M8euHRM/u3GeIqW8qUcK
         Es7LULni5HOI4FkQqxEAt8gBiuuFYRGhGl2wF7Q4tj8hL487/puEUgMcsP5eeqJq4A9V
         GE+lQNWlPBmR+p3hNhW2TyIoX1YBL0L0+t+UzxBfnUk8Dogi8DRmePngUdJwUtS9GE3K
         BQNGhejfZkHwbUQNaP4hphM5jVg0isL8qU46Ns7rMnKtl/beQNzLW2XH7/1EyscvKfXF
         Y6eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763065410; x=1763670210;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y6+cxABZnS3YSrSISK/yjuFruYB/W5uByVrGxiYBwl4=;
        b=CWRhyq+mzRwZ5p47I0C7J6DkBiOYDeA7jFy1DfaXmChAdG405t5hBeMTCVmCgfddzW
         MjeaQt+Js5B1ETFZP4+acWI+BYbRmMFPcFFTUeO9+CdrmEP8hLDyCqsU6CKS49t+D/1u
         Ud7iS3Ih1ze6CP/0/FapnuZKinkmxRv3sxPpuQchMXAChYweKh49wixwM43DFELzX/B0
         1splECSDI6xcNnsBGkjbfIB6ZX8uXfCJbH4QdPsToT7OxlITOB3gpbdcmf0wEDUOY3I2
         5GJVqQ3T9srADiv5PGznDkvoJUKazM2jbLTpwBom189RYrEIP2znnNsrbE/w3prR80ft
         10Uw==
X-Forwarded-Encrypted: i=1; AJvYcCXEh3XMDfwV2aTD20t4FYag9cdda5sjU0RBiNf+PZxVqCNS83FsO7R0csa5ghGzHactmga097GjGtcl@lists.infradead.org
X-Gm-Message-State: AOJu0YzKgxSz2KiaLpCm3WMl66ZF1w/EIQXOcSGDOtwa1OwGEpGwZTSM
	+UvyqavugISvInpmkpMMyQfwRhaB6mNTconYCSLyi1ISxr3EPQm0WA41VY8gbgyptSc=
X-Gm-Gg: ASbGnct/VGXKIWuzjh6GftrWtv0oxkbHBBF8iF1NAWOI7mTgCYj5XRg7t+M0z/8dFmg
	aqOylk7ObMMbq5QATCOkWIYZeiTr6xlpLV07mBPFze3c9WI+OLGcjH/kXoEq7uAT4/2N8M9zEt1
	2kDyJAj+9kISgNEt0TkZI9xU/EKxMwLcBuXtohzJa0xT51JReEN4Zbja9i8VKVIBX8nYLfSdhX7
	kgE9g5eBrIpHOc3aC5JpMZPz4La5OOoGGYSdG1Kgzwt29jsUeMFKq951Er6iUMlxWOT+IULLK9/
	ey3MxfVqc4rzOWBcsRQOp1B2G4qyCtztrjuMSxFVgOLmrAHqrvg4gdmBi6RGAeAiBlQER1iQecE
	+nKQGgsDa/q01uT5ura0ZIttfLufG0E+uiHmB+TKS+WF9Er94ZIZj3zMP37b/H733lG8Ek/1iGz
	GojozTNbXutPpWBPWZaojhCVetMp7nUJCqWg==
X-Google-Smtp-Source: AGHT+IEYO/JgfmWFmQJJ50sNXc0ugIY37iQsusoHNsW0AfOtpwPE5bHkyVT0KdhbbYmvBIUvJBEA/Q==
X-Received: by 2002:a05:7022:984:b0:11a:2ec0:dd02 with SMTP id a92af1059eb24-11b41605e91mr305714c88.33.1763065410097;
        Thu, 13 Nov 2025 12:23:30 -0800 (PST)
Received: from apollo.purestorage.com ([208.88.152.253])
        by smtp.googlemail.com with ESMTPSA id a92af1059eb24-11b060885cdsm1151961c88.6.2025.11.13.12.23.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Nov 2025 12:23:29 -0800 (PST)
From: Mohamed Khalfella <mkhalfella@purestorage.com>
To: Jens Axboe <axboe@kernel.dk>,
	Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>
Cc: Casey Chen <cachen@purestorage.com>,
	Vikas Manocha <vmanocha@purestorage.com>,
	Yuanyuan Zhong <yzhong@purestorage.com>,
	Hannes Reinecke <hare@suse.de>,
	Ming Lei <ming.lei@redhat.com>,
	linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Mohamed Khalfella <mkhalfella@purestorage.com>
Subject: [PATCH] nvme: Convert tag_list mutex to rwsemaphore to avoid deadlock
Date: Thu, 13 Nov 2025 12:23:20 -0800
Message-ID: <20251113202320.2530531-1-mkhalfella@purestorage.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251113_122331_974095_C1642728 
X-CRM114-Status: GOOD (  24.51  )
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

blk_mq_{add,del}_queue_tag_set() functions add and remove queues from
tagset, the functions make sure that tagset and queues are marked as
shared when two or more queues are attached to the same tagset.
Initially a tagset starts as unshared and when the number of added
queues reaches two, blk_mq_add_queue_tag_set() marks it as shared along
with all the queues attached to it. When the number of attached queues
drops to 1 blk_mq_del_queue_tag_set() need to mark both the tagset and
the remaining queues as unshared.

Both functions need to freeze current queues in tagset before setting on
unsetting BLK_MQ_F_TAG_QUEUE_SHARED flag. While doing so, both functions
hold set->tag_list_lock mutex, which makes sense as we do not want
queues to be added or deleted in the process. This used to work fine
until commit 98d81f0df70c ("nvme: use blk_mq_[un]quiesce_tagset")
made the nvme driver quiesce tagset instead of quiscing individual
queues. blk_mq_quiesce_tagset() does the job and quiesce the queues in
set->tag_list while holding set->tag_list_lock also.

This results in deadlock between two threads with these stacktraces:

  __schedule+0x48e/0xed0
  schedule+0x5a/0xc0
  schedule_preempt_disabled+0x11/0x20
  __mutex_lock.constprop.0+0x3cc/0x760
  blk_mq_quiesce_tagset+0x26/0xd0
  nvme_dev_disable_locked+0x77/0x280 [nvme]
  nvme_timeout+0x268/0x320 [nvme]
  blk_mq_handle_expired+0x5d/0x90
  bt_iter+0x7e/0x90
  blk_mq_queue_tag_busy_iter+0x2b2/0x590
  ? __blk_mq_complete_request_remote+0x10/0x10
  ? __blk_mq_complete_request_remote+0x10/0x10
  blk_mq_timeout_work+0x15b/0x1a0
  process_one_work+0x133/0x2f0
  ? mod_delayed_work_on+0x90/0x90
  worker_thread+0x2ec/0x400
  ? mod_delayed_work_on+0x90/0x90
  kthread+0xe2/0x110
  ? kthread_complete_and_exit+0x20/0x20
  ret_from_fork+0x2d/0x50
  ? kthread_complete_and_exit+0x20/0x20
  ret_from_fork_asm+0x11/0x20

  __schedule+0x48e/0xed0
  schedule+0x5a/0xc0
  blk_mq_freeze_queue_wait+0x62/0x90
  ? destroy_sched_domains_rcu+0x30/0x30
  blk_mq_exit_queue+0x151/0x180
  disk_release+0xe3/0xf0
  device_release+0x31/0x90
  kobject_put+0x6d/0x180
  nvme_scan_ns+0x858/0xc90 [nvme_core]
  ? nvme_scan_work+0x281/0x560 [nvme_core]
  nvme_scan_work+0x281/0x560 [nvme_core]
  process_one_work+0x133/0x2f0
  ? mod_delayed_work_on+0x90/0x90
  worker_thread+0x2ec/0x400
  ? mod_delayed_work_on+0x90/0x90
  kthread+0xe2/0x110
  ? kthread_complete_and_exit+0x20/0x20
  ret_from_fork+0x2d/0x50
  ? kthread_complete_and_exit+0x20/0x20
  ret_from_fork_asm+0x11/0x20

The top stacktrace is showing nvme_timeout() called to handle nvme
command timeout. timeout handler is trying to disable the controller and
as a first step, it needs to blk_mq_quiesce_tagset() to tell blk-mq not
to call queue callback handlers. The thread is stuck waiting for
set->tag_list_lock as it tires to walk the queues in set->tag_list.

The lock is held by the second thread in the bottom stack which is
waiting for one of queues to be frozen. The queue usage counter will
drop to zero after nvme_timeout() finishes, and this will not happen
because the thread will wait for this mutex forever.

Convert set->tag_list_lock mutex to set->tag_list_rwsem rwsemaphore to
avoid the deadlock. Update blk_mq_[un]quiesce_tagset() to take the
semaphore for read since this is enough to guarantee no queues will be
added or removed. Update blk_mq_{add,del}_queue_tag_set() to take the
semaphore for write while updating set->tag_list and downgrade it to
read while freezing the queues. It should be safe to update set->flags
and hctx->flags while holding the semaphore for read since the queues
are already frozen.

Fixes: 98d81f0df70c ("nvme: use blk_mq_[un]quiesce_tagset")
Signed-off-by: Mohamed Khalfella <mkhalfella@purestorage.com>
---
 block/blk-mq-sysfs.c   | 10 +++----
 block/blk-mq.c         | 63 ++++++++++++++++++++++--------------------
 include/linux/blk-mq.h |  4 +--
 3 files changed, 40 insertions(+), 37 deletions(-)

diff --git a/block/blk-mq-sysfs.c b/block/blk-mq-sysfs.c
index 58ec293373c6..f474781654fb 100644
--- a/block/blk-mq-sysfs.c
+++ b/block/blk-mq-sysfs.c
@@ -230,13 +230,13 @@ int blk_mq_sysfs_register(struct gendisk *disk)
 
 	kobject_uevent(q->mq_kobj, KOBJ_ADD);
 
-	mutex_lock(&q->tag_set->tag_list_lock);
+	down_read(&q->tag_set->tag_list_rwsem);
 	queue_for_each_hw_ctx(q, hctx, i) {
 		ret = blk_mq_register_hctx(hctx);
 		if (ret)
 			goto out_unreg;
 	}
-	mutex_unlock(&q->tag_set->tag_list_lock);
+	up_read(&q->tag_set->tag_list_rwsem);
 	return 0;
 
 out_unreg:
@@ -244,7 +244,7 @@ int blk_mq_sysfs_register(struct gendisk *disk)
 		if (j < i)
 			blk_mq_unregister_hctx(hctx);
 	}
-	mutex_unlock(&q->tag_set->tag_list_lock);
+	up_read(&q->tag_set->tag_list_rwsem);
 
 	kobject_uevent(q->mq_kobj, KOBJ_REMOVE);
 	kobject_del(q->mq_kobj);
@@ -257,10 +257,10 @@ void blk_mq_sysfs_unregister(struct gendisk *disk)
 	struct blk_mq_hw_ctx *hctx;
 	unsigned long i;
 
-	mutex_lock(&q->tag_set->tag_list_lock);
+	down_read(&q->tag_set->tag_list_rwsem);
 	queue_for_each_hw_ctx(q, hctx, i)
 		blk_mq_unregister_hctx(hctx);
-	mutex_unlock(&q->tag_set->tag_list_lock);
+	up_read(&q->tag_set->tag_list_rwsem);
 
 	kobject_uevent(q->mq_kobj, KOBJ_REMOVE);
 	kobject_del(q->mq_kobj);
diff --git a/block/blk-mq.c b/block/blk-mq.c
index d626d32f6e57..1770277fe453 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -335,12 +335,12 @@ void blk_mq_quiesce_tagset(struct blk_mq_tag_set *set)
 {
 	struct request_queue *q;
 
-	mutex_lock(&set->tag_list_lock);
+	down_read(&set->tag_list_rwsem);
 	list_for_each_entry(q, &set->tag_list, tag_set_list) {
 		if (!blk_queue_skip_tagset_quiesce(q))
 			blk_mq_quiesce_queue_nowait(q);
 	}
-	mutex_unlock(&set->tag_list_lock);
+	up_read(&set->tag_list_rwsem);
 
 	blk_mq_wait_quiesce_done(set);
 }
@@ -350,12 +350,12 @@ void blk_mq_unquiesce_tagset(struct blk_mq_tag_set *set)
 {
 	struct request_queue *q;
 
-	mutex_lock(&set->tag_list_lock);
+	down_read(&set->tag_list_rwsem);
 	list_for_each_entry(q, &set->tag_list, tag_set_list) {
 		if (!blk_queue_skip_tagset_quiesce(q))
 			blk_mq_unquiesce_queue(q);
 	}
-	mutex_unlock(&set->tag_list_lock);
+	up_read(&set->tag_list_rwsem);
 }
 EXPORT_SYMBOL_GPL(blk_mq_unquiesce_tagset);
 
@@ -4280,7 +4280,7 @@ static void blk_mq_update_tag_set_shared(struct blk_mq_tag_set *set,
 	struct request_queue *q;
 	unsigned int memflags;
 
-	lockdep_assert_held(&set->tag_list_lock);
+	lockdep_assert_held(&set->tag_list_rwsem);
 
 	list_for_each_entry(q, &set->tag_list, tag_set_list) {
 		memflags = blk_mq_freeze_queue(q);
@@ -4293,37 +4293,40 @@ static void blk_mq_del_queue_tag_set(struct request_queue *q)
 {
 	struct blk_mq_tag_set *set = q->tag_set;
 
-	mutex_lock(&set->tag_list_lock);
+	down_write(&set->tag_list_rwsem);
 	list_del(&q->tag_set_list);
-	if (list_is_singular(&set->tag_list)) {
-		/* just transitioned to unshared */
-		set->flags &= ~BLK_MQ_F_TAG_QUEUE_SHARED;
-		/* update existing queue */
-		blk_mq_update_tag_set_shared(set, false);
+	if (!list_is_singular(&set->tag_list)) {
+		up_write(&set->tag_list_rwsem);
+		goto out;
 	}
-	mutex_unlock(&set->tag_list_lock);
+
+	/* Transitioning to unshared. */
+	set->flags &= ~BLK_MQ_F_TAG_QUEUE_SHARED;
+	downgrade_write(&set->tag_list_rwsem);
+	blk_mq_update_tag_set_shared(set, false);
+	up_read(&set->tag_list_rwsem);
+out:
 	INIT_LIST_HEAD(&q->tag_set_list);
 }
 
 static void blk_mq_add_queue_tag_set(struct blk_mq_tag_set *set,
 				     struct request_queue *q)
 {
-	mutex_lock(&set->tag_list_lock);
+	down_write(&set->tag_list_rwsem);
+	if (!list_is_singular(&set->tag_list)) {
+		if (set->flags & BLK_MQ_F_TAG_QUEUE_SHARED)
+			queue_set_hctx_shared(q, true);
+		list_add_tail(&q->tag_set_list, &set->tag_list);
+		up_write(&set->tag_list_rwsem);
+		return;
+	}
 
-	/*
-	 * Check to see if we're transitioning to shared (from 1 to 2 queues).
-	 */
-	if (!list_empty(&set->tag_list) &&
-	    !(set->flags & BLK_MQ_F_TAG_QUEUE_SHARED)) {
-		set->flags |= BLK_MQ_F_TAG_QUEUE_SHARED;
-		/* update existing queue */
-		blk_mq_update_tag_set_shared(set, true);
-	}
-	if (set->flags & BLK_MQ_F_TAG_QUEUE_SHARED)
-		queue_set_hctx_shared(q, true);
+	/* Transitioning to shared. */
+	set->flags |= BLK_MQ_F_TAG_QUEUE_SHARED;
 	list_add_tail(&q->tag_set_list, &set->tag_list);
-
-	mutex_unlock(&set->tag_list_lock);
+	downgrade_write(&set->tag_list_rwsem);
+	blk_mq_update_tag_set_shared(set, true);
+	up_read(&set->tag_list_rwsem);
 }
 
 /* All allocations will be freed in release handler of q->mq_kobj */
@@ -4855,7 +4858,7 @@ int blk_mq_alloc_tag_set(struct blk_mq_tag_set *set)
 	if (ret)
 		goto out_free_mq_map;
 
-	mutex_init(&set->tag_list_lock);
+	init_rwsem(&set->tag_list_rwsem);
 	INIT_LIST_HEAD(&set->tag_list);
 
 	return 0;
@@ -5044,7 +5047,7 @@ static void __blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set,
 	struct xarray elv_tbl, et_tbl;
 	bool queues_frozen = false;
 
-	lockdep_assert_held(&set->tag_list_lock);
+	lockdep_assert_held_write(&set->tag_list_rwsem);
 
 	if (set->nr_maps == 1 && nr_hw_queues > nr_cpu_ids)
 		nr_hw_queues = nr_cpu_ids;
@@ -5129,9 +5132,9 @@ static void __blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set,
 void blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set, int nr_hw_queues)
 {
 	down_write(&set->update_nr_hwq_lock);
-	mutex_lock(&set->tag_list_lock);
+	down_write(&set->tag_list_rwsem);
 	__blk_mq_update_nr_hw_queues(set, nr_hw_queues);
-	mutex_unlock(&set->tag_list_lock);
+	up_write(&set->tag_list_rwsem);
 	up_write(&set->update_nr_hwq_lock);
 }
 EXPORT_SYMBOL_GPL(blk_mq_update_nr_hw_queues);
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index b25d12545f46..4c8441671518 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -502,7 +502,7 @@ enum hctx_type {
  * @shared_tags:
  *		   Shared set of tags. Has @nr_hw_queues elements. If set,
  *		   shared by all @tags.
- * @tag_list_lock: Serializes tag_list accesses.
+ * @tag_list_rwsem: Serializes tag_list accesses.
  * @tag_list:	   List of the request queues that use this tag set. See also
  *		   request_queue.tag_set_list.
  * @srcu:	   Use as lock when type of the request queue is blocking
@@ -530,7 +530,7 @@ struct blk_mq_tag_set {
 
 	struct blk_mq_tags	*shared_tags;
 
-	struct mutex		tag_list_lock;
+	struct rw_semaphore	tag_list_rwsem;
 	struct list_head	tag_list;
 	struct srcu_struct	*srcu;
 	struct srcu_struct	tags_srcu;
-- 
2.51.0


