Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1135D24469
	for <linux-nvme@archiver.kernel.org>; Thu,  4 Dec 2025 18:12:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wkTYaAp/Bwr2qvdUFL9MXQBSJP8TjVnrLBt94hBT5IA=; b=ETtH7ZJeboHDKT7dAzmS0FUC2t
	I2SwkfhXmhaDxyyq9ZjaPoM+cWyiEDr6wcX9raAyC0wOhSskEoIb2+zHWDCvK3ri7ymHRPVNH4t6H
	rnRNDZOgTDneqXl07sKNLeqkJRlfQOATBZ6QT2/YEg8pVwQUcRVxTb/fOfhL40TDZYplPMJImIzv7
	l0dlMUvIEYGbpMsfTk5FNOKZYhC4iQwNt7LEXkUsWP4+0hwxnqynU54aYZGa7WSrzICaz/PsfAWVV
	zT5On849Z5HjCS/vDHKQb08mdYVICoTSlx3KeTQIyQSJn7qG7CB4/F1NDpol25MGX3HprjSiIhJBd
	07G07c6w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vRDot-00000008QGM-05Y0;
	Thu, 04 Dec 2025 18:12:47 +0000
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vRDon-00000008QFS-266y
	for linux-nvme@lists.infradead.org;
	Thu, 04 Dec 2025 18:12:45 +0000
Received: by mail-pg1-x52d.google.com with SMTP id 41be03b00d2f7-bd1b0e2c1eeso999472a12.0
        for <linux-nvme@lists.infradead.org>; Thu, 04 Dec 2025 10:12:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1764871961; x=1765476761; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wkTYaAp/Bwr2qvdUFL9MXQBSJP8TjVnrLBt94hBT5IA=;
        b=djeNwtC/BrvHCN6DjRTvWuy5rBEXST2dFotHunRvnxa1gFTcEJOo3BmRWzgV2FG48O
         HhQTqjstasA3OBOOIDE8/I/KJ1L+hOrVoYDlO0qc1oYK6zIlHe0fDtEubtLk0t49vXi5
         UUuRDzlPS7VRzUqYc5XsAEk9hUULtsbiM1NztxHdLYXv+NWjmzSCj4gKeAYaaXc00Od0
         flbQS0t+CAI3R/yFQBH/pCmewCP8wOVFoKTlVcFJ5dRPOkBVTaQTtMFz8bHdqNDZGX4U
         N5OSiDiJI7tf1yYF5+MPxhrDZMmPbyGHOCEoFCPgcGjKWc2bzwD+EpCFkwkIp2+vn5U1
         rpFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764871961; x=1765476761;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wkTYaAp/Bwr2qvdUFL9MXQBSJP8TjVnrLBt94hBT5IA=;
        b=bL/vKwyrkaS5I32LaUsp+f6rpP8wLbiFfTqgQdnOT6ebvmpKfJR4b7GJz1MpPkm5uk
         rBzduAbLjN1wCws7ekjVDtT0kEjby8aD/R0xB/ieaGTEFA3p6UI16c6xEdpgXY2MhY5D
         9zIX6rjLeyCReFU5j24v57fXyhsHcQITCMEsi/XXdhtarDqTxX8oFErvkzWAVeQRLJ6S
         kaNamDbauWpJXgwvKYBJTJW+FolLhzOAuOM2ZEH2+FyFFmEed4Zc0GldzzPXt+ANeImJ
         tH2YXXZT9UJ2LhNLIKSED7qFFro/uM4DbtcRT0PAAy+rhyQfkEO7xn+rJMj6I6I1wHOI
         YPZQ==
X-Forwarded-Encrypted: i=1; AJvYcCVIJ0TL52hzBEEqjFBxbkay2uErfGU/a4aSQARBZZuC4CVWehLZ+/0agPSHUrCofCQ7IQBFI81+ISHI@lists.infradead.org
X-Gm-Message-State: AOJu0YyITq9Q2yTk8ZkIw73G/4z/JkqwDU21zfqFMnig6So0WhES/8ss
	1gdoc2C0AZQ98iT1LXUAp72+pnTTELORhDVQ2HMgQiTNs2ZaU8qeOOQ9pHwQtgqSmEk=
X-Gm-Gg: ASbGnctY+zvvji8JulyjtxoC8xYXYoWHoYI9sDF4AE30DO3PJmcQBsD9k2ZkMtjzuQZ
	lXigzVLiUOYGNkEtew8Cqk9U2ik0B5pFGXX/+76K2ItmDVWgLhRjVcgziZwGeGlJfYCGD4g7xcK
	2E+ffju3TWBQs4a23GsQaTxx/1OcwajXVoiS+3mbGQQu+loknhKpMGvlSU/jBfhIr03+8he8zUA
	LfZ8edYDTVGBqU5H1l+Wyxh7z1+ZHbBO7rNnlDTbu0hn0+hEKsJeNcu4X43NUqmjBG5l94Xn2ZH
	Qi96+1uq1QYK4fs4L1gxLX37OWnmWeg20HSGq0VPHMjGwL/hercGc4rx5mtRoQwORNyeuKQxFgA
	uW3l21qeo/X72aKmPKM9zDPbyrhykeN+npYqHo83zFSo7JsolUewk+LpyI7tLwHP6s3BGhq5USB
	1tQ/MpOvDKqVh4C+y9nihNu/uIFhg4WbkFAQ==
X-Google-Smtp-Source: AGHT+IFD8CHpgTKYp8RFzQjUFrV5P/g6cRtnJMlYeMKwqO9XKKGl7WN6jCHnhXjaV11aIP/wrSJptA==
X-Received: by 2002:a05:7300:cc9c:b0:2a4:3644:4be3 with SMTP id 5a478bee46e88-2ab92ee527fmr4333722eec.27.1764871960337;
        Thu, 04 Dec 2025 10:12:40 -0800 (PST)
Received: from apollo.purestorage.com ([208.88.152.253])
        by smtp.googlemail.com with ESMTPSA id 5a478bee46e88-2aba8816ae9sm6998935eec.5.2025.12.04.10.12.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Dec 2025 10:12:39 -0800 (PST)
From: Mohamed Khalfella <mkhalfella@purestorage.com>
To: Chaitanya Kulkarni <kch@nvidia.com>,
	Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>,
	Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: Casey Chen <cachen@purestorage.com>,
	Yuanyuan Zhong <yzhong@purestorage.com>,
	Hannes Reinecke <hare@suse.de>,
	Ming Lei <ming.lei@redhat.com>,
	Waiman Long <llong@redhat.com>,
	Hillf Danton <hdanton@sina.com>,
	linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Mohamed Khalfella <mkhalfella@purestorage.com>
Subject: [PATCH 1/1] block: Use RCU in blk_mq_[un]quiesce_tagset() instead of set->tag_list_lock
Date: Thu,  4 Dec 2025 10:11:53 -0800
Message-ID: <20251204181212.1484066-2-mkhalfella@purestorage.com>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251204181212.1484066-1-mkhalfella@purestorage.com>
References: <20251204181212.1484066-1-mkhalfella@purestorage.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251204_101241_541989_71B980F8 
X-CRM114-Status: GOOD (  17.91  )
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

Given that [un]quescing queue is an operation that does not need to
sleep, update blk_mq_[un]quiesce_tagset() to use RCU instead of taking
set->tag_list_lock. Also update blk_mq_{add,del}_queue_tag_set() to use
RCU safe list operations. This should help avoid deadlock seen above.

Signed-off-by: Mohamed Khalfella <mkhalfella@purestorage.com>
---
 block/blk-mq.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index d626d32f6e57..ceb176ac154b 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -335,12 +335,12 @@ void blk_mq_quiesce_tagset(struct blk_mq_tag_set *set)
 {
 	struct request_queue *q;
 
-	mutex_lock(&set->tag_list_lock);
-	list_for_each_entry(q, &set->tag_list, tag_set_list) {
+	rcu_read_lock();
+	list_for_each_entry_rcu(q, &set->tag_list, tag_set_list) {
 		if (!blk_queue_skip_tagset_quiesce(q))
 			blk_mq_quiesce_queue_nowait(q);
 	}
-	mutex_unlock(&set->tag_list_lock);
+	rcu_read_unlock();
 
 	blk_mq_wait_quiesce_done(set);
 }
@@ -350,12 +350,12 @@ void blk_mq_unquiesce_tagset(struct blk_mq_tag_set *set)
 {
 	struct request_queue *q;
 
-	mutex_lock(&set->tag_list_lock);
-	list_for_each_entry(q, &set->tag_list, tag_set_list) {
+	rcu_read_lock();
+	list_for_each_entry_rcu(q, &set->tag_list, tag_set_list) {
 		if (!blk_queue_skip_tagset_quiesce(q))
 			blk_mq_unquiesce_queue(q);
 	}
-	mutex_unlock(&set->tag_list_lock);
+	rcu_read_unlock();
 }
 EXPORT_SYMBOL_GPL(blk_mq_unquiesce_tagset);
 
@@ -4294,7 +4294,7 @@ static void blk_mq_del_queue_tag_set(struct request_queue *q)
 	struct blk_mq_tag_set *set = q->tag_set;
 
 	mutex_lock(&set->tag_list_lock);
-	list_del(&q->tag_set_list);
+	list_del_rcu(&q->tag_set_list);
 	if (list_is_singular(&set->tag_list)) {
 		/* just transitioned to unshared */
 		set->flags &= ~BLK_MQ_F_TAG_QUEUE_SHARED;
@@ -4302,6 +4302,8 @@ static void blk_mq_del_queue_tag_set(struct request_queue *q)
 		blk_mq_update_tag_set_shared(set, false);
 	}
 	mutex_unlock(&set->tag_list_lock);
+
+	synchronize_rcu();
 	INIT_LIST_HEAD(&q->tag_set_list);
 }
 
@@ -4321,7 +4323,7 @@ static void blk_mq_add_queue_tag_set(struct blk_mq_tag_set *set,
 	}
 	if (set->flags & BLK_MQ_F_TAG_QUEUE_SHARED)
 		queue_set_hctx_shared(q, true);
-	list_add_tail(&q->tag_set_list, &set->tag_list);
+	list_add_tail_rcu(&q->tag_set_list, &set->tag_list);
 
 	mutex_unlock(&set->tag_list_lock);
 }
-- 
2.51.2


