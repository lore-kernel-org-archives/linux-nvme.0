Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8801CCE8D6B
	for <linux-nvme@archiver.kernel.org>; Mon, 17 Nov 2025 20:24:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HyF6/V4nS8wYWlGdOSa2UCNoJb0kxdxyGdDvo969ZXQ=; b=YNT3Yu+q3S47zkMzImoBA+pXPr
	FAvnV+y71CePimi692q9dyyox1yXg8n0mJy5W9Yo9QLDqg6JqomUfoTHcOKk3d5aM8EXHYND8Lj4A
	QVtEiM69uZZnhYGVFf3P0y6WMdMmBEQ7YpD94pFO70z07sE/7GCMMzhrewkadvJPtGPqT3cEGa8BF
	/oaiYQmylVSAp7niiurgBBhVw0PSkP8NO1qAfbENtul94CznCYaTxW/8KHCmcuHp/uEUN6HrB1HY7
	Y24Ksg4Wn6hFD6ieB+Io06MB50KBX+LXytsZNxbv5D0epGgkCxdGBCbOvOY7zK1X57gyjJXmPFlFu
	tTgUvMlA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vL5mL-0000000GowU-2gNJ;
	Mon, 17 Nov 2025 20:24:49 +0000
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vL5mI-0000000Govp-07Ph
	for linux-nvme@lists.infradead.org;
	Mon, 17 Nov 2025 20:24:48 +0000
Received: by mail-pg1-x530.google.com with SMTP id 41be03b00d2f7-bbbc58451a3so3296228a12.0
        for <linux-nvme@lists.infradead.org>; Mon, 17 Nov 2025 12:24:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1763411085; x=1764015885; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HyF6/V4nS8wYWlGdOSa2UCNoJb0kxdxyGdDvo969ZXQ=;
        b=RbBlLe/JNeWuRRDoc99uoj2TxIKeqKXLE3WDYLU14i4+vmi9d0FSm0Vp+81r1la6Lf
         R72klkIc08dYg7aOUe/F+M3U5skB/xKfNVlCa9AFDbw521jTJzU7Po4ixwP0fctnJIZh
         Hqx0QfCsVdTNAiDn+kO9Bh1ThQnoSWEQj6LFJN9ZNeoWtUdRX2MwXVLVPjgljZpBzf7u
         7vkds6vRuPIQuGj5jJOGt4JpCzvUMwZ1vrLrZPf/1bMkmRFrCCd0TrVRjW6wFf2oLoKd
         WnVcehgmbXs+kfclUV2lOAOiHghvBVhWrj5ScVDL8I0rlA4aIYS5iTy8uSKNEWPDPWQI
         NPOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763411085; x=1764015885;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HyF6/V4nS8wYWlGdOSa2UCNoJb0kxdxyGdDvo969ZXQ=;
        b=ugBQD9jiFca0drtpGqW9VJ/lqabkcZiVO69tI+1iw1ogIn9x+v7X0Vzim0g1k8LYFw
         32H70D6s8sldbSLBAwRc4vV7ZA7cBv7Sz6gSyBWXgr1uiciJxHPy1tZh4oKd+CIzW+Ql
         LqLBGXCEqb6QNoOrkOtZsGpIPvAkpKs8s3VuQOalQXnXoCEKIGvt33L9VJMDiBi9MlGP
         l29dhv6fliCtMlkZQEcoS0I6yoL+Z/r7wJ1rW9rirKBUT4hPzkqlt93SHBdnPlaYjg5Y
         PRa9lZ17fyV5pwaXFXrhrCIeEBDPTyuzMkwvd14XhAMlUTiUp6bdyXj+I4QL4yw83cjg
         61Uw==
X-Forwarded-Encrypted: i=1; AJvYcCX93Y7fAQKhExUAp+NuC4F2jtrER2P3kJuDgjdaEmXaHHkdLwebiS2KjqM5lQoLJTtRi9ERauHaUlMK@lists.infradead.org
X-Gm-Message-State: AOJu0YxNo50BlcrK5nFOrOQOyf6CUPZaMkLQhkdMJ4qXlbWCOcp8Rufx
	uNbp6UywMeuRhVLzZzvmMcIN3VryEKKDniuuTS32Ik+w6kE7hDp2DWK7DNFnEWy3gIc=
X-Gm-Gg: ASbGncu+sHWGwttQLS/R2sYPnDrOGtz8/GV2ZWu2gO2ppqBBnZEGMtS/LLEtGcDc5kR
	Sl1UtW/4U5Xe4VR3Ke98Vuobmgmp1egdX1K3IIp0ilJzBMrXwU7VlGBTPzj1JcterdBmDl7BftO
	HSOJQO4FQgQDzC1y+F3HWmlpM1DJh/kkHt4BXSo/161hu0w/Kmjt2sfwFRDIzbDshymCnZHzoXH
	KqMDDXMrsMTS4b97CScBAdRc2CzSM9XHkJRpRjLS2yN9IKFMl20obv14iW1bgcm6780dhzQNcm2
	zEEFxWjH0KVuloBqY+E+bliVLdNLzMLhR0aUffLlf9IIkZCclgp0pqZRYRS4XSMKcqohdLmy9RU
	5mQeQrW1wHEKc8PIX/TX4FZLkEX7x66zFeu9lOrEtJOHKjCL6eWPYKXH5ARx8ZFsr2BwBg8f50R
	NAL4Ms2UZchedK1uavg/sqOdrI1JZ/8tdl58ZFsTTRJscoDS140kQx3pM=
X-Google-Smtp-Source: AGHT+IGAK8CgmTY+UZx0Sv+IjKS2O7b9jc98OXKXQYt3KWF2GTn3BjqKch0SpUJq0k9Oh0eqhxxLUg==
X-Received: by 2002:a05:7300:a987:b0:2a4:3593:6464 with SMTP id 5a478bee46e88-2a4abb1c750mr7667244eec.20.1763411084735;
        Mon, 17 Nov 2025 12:24:44 -0800 (PST)
Received: from apollo.purestorage.com ([208.88.152.253])
        by smtp.googlemail.com with ESMTPSA id 5a478bee46e88-2a49db7a753sm49298281eec.6.2025.11.17.12.24.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Nov 2025 12:24:44 -0800 (PST)
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
Subject: [PATCH v2 1/1] nvme: Convert tag_list mutex to rwsemaphore to avoid deadlock
Date: Mon, 17 Nov 2025 12:23:53 -0800
Message-ID: <20251117202414.4071380-2-mkhalfella@purestorage.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251117202414.4071380-1-mkhalfella@purestorage.com>
References: <20251117202414.4071380-1-mkhalfella@purestorage.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251117_122446_077390_12E4FE59 
X-CRM114-Status: GOOD (  26.79  )
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
 block/blk-mq-sysfs.c   | 10 ++---
 block/blk-mq.c         | 95 +++++++++++++++++++++++-------------------
 include/linux/blk-mq.h |  4 +-
 3 files changed, 58 insertions(+), 51 deletions(-)

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
index d626d32f6e57..9211d32ce820 100644
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
 
@@ -4274,56 +4274,63 @@ static void queue_set_hctx_shared(struct request_queue *q, bool shared)
 	}
 }
 
-static void blk_mq_update_tag_set_shared(struct blk_mq_tag_set *set,
-					 bool shared)
-{
-	struct request_queue *q;
-	unsigned int memflags;
-
-	lockdep_assert_held(&set->tag_list_lock);
-
-	list_for_each_entry(q, &set->tag_list, tag_set_list) {
-		memflags = blk_mq_freeze_queue(q);
-		queue_set_hctx_shared(q, shared);
-		blk_mq_unfreeze_queue(q, memflags);
-	}
-}
-
 static void blk_mq_del_queue_tag_set(struct request_queue *q)
 {
 	struct blk_mq_tag_set *set = q->tag_set;
+	struct request_queue *firstq;
+	unsigned int memflags;
 
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
+	/*
+	 * Transitioning the remaining firstq to unshared.
+	 * Also, downgrade the semaphore to avoid deadlock
+	 * with blk_mq_quiesce_tagset() while waiting for
+	 * firstq to be frozen.
+	 */
+	set->flags &= ~BLK_MQ_F_TAG_QUEUE_SHARED;
+	downgrade_write(&set->tag_list_rwsem);
+	firstq = list_first_entry(&set->tag_list, struct request_queue,
+				  tag_set_list);
+	memflags = blk_mq_freeze_queue(firstq);
+	queue_set_hctx_shared(firstq, false);
+	blk_mq_unfreeze_queue(firstq, memflags);
+	up_read(&set->tag_list_rwsem);
+out:
 	INIT_LIST_HEAD(&q->tag_set_list);
 }
 
 static void blk_mq_add_queue_tag_set(struct blk_mq_tag_set *set,
 				     struct request_queue *q)
 {
-	mutex_lock(&set->tag_list_lock);
+	struct request_queue *firstq;
+	unsigned int memflags;
 
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
-	list_add_tail(&q->tag_set_list, &set->tag_list);
+	down_write(&set->tag_list_rwsem);
+	if (!list_is_singular(&set->tag_list)) {
+		if (set->flags & BLK_MQ_F_TAG_QUEUE_SHARED)
+			queue_set_hctx_shared(q, true);
+		list_add_tail(&q->tag_set_list, &set->tag_list);
+		up_write(&set->tag_list_rwsem);
+		return;
+	}
 
-	mutex_unlock(&set->tag_list_lock);
+	/* Transitioning firstq and q to shared. */
+	set->flags |= BLK_MQ_F_TAG_QUEUE_SHARED;
+	list_add_tail(&q->tag_set_list, &set->tag_list);
+	downgrade_write(&set->tag_list_rwsem);
+	queue_set_hctx_shared(q, true);
+	firstq = list_first_entry(&set->tag_list, struct request_queue,
+				  tag_set_list);
+	memflags = blk_mq_freeze_queue(firstq);
+	queue_set_hctx_shared(firstq, true);
+	blk_mq_unfreeze_queue(firstq, memflags);
+	up_read(&set->tag_list_rwsem);
 }
 
 /* All allocations will be freed in release handler of q->mq_kobj */
@@ -4855,7 +4862,7 @@ int blk_mq_alloc_tag_set(struct blk_mq_tag_set *set)
 	if (ret)
 		goto out_free_mq_map;
 
-	mutex_init(&set->tag_list_lock);
+	init_rwsem(&set->tag_list_rwsem);
 	INIT_LIST_HEAD(&set->tag_list);
 
 	return 0;
@@ -5044,7 +5051,7 @@ static void __blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set,
 	struct xarray elv_tbl, et_tbl;
 	bool queues_frozen = false;
 
-	lockdep_assert_held(&set->tag_list_lock);
+	lockdep_assert_held_write(&set->tag_list_rwsem);
 
 	if (set->nr_maps == 1 && nr_hw_queues > nr_cpu_ids)
 		nr_hw_queues = nr_cpu_ids;
@@ -5129,9 +5136,9 @@ static void __blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set,
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


