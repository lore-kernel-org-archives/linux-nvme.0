Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9B31D374A2
	for <linux-nvme@archiver.kernel.org>; Fri,  5 Dec 2025 21:18:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=IxVHZtEpvAb0wwOXSSvRmivBfSUpUQhbLwoJPmBuAUM=; b=B+vTDYa1tVYRRLx++Ng+zy5hcK
	fcDEpF2N0XJ2gILHxce7t9U8pcZoaicpxDtp8E8E8I4IAMVpd0cd4Jeqt/cNX9efy4uxuaCxRHp4K
	1g/nM5OP3/Tfo5dndcrwRUndoPWcC4J/m5PmzkcKcjyPewEDtLLhg8js1DIUS7hPe56Dq7LomoXhW
	YILU5n3VuEnDfVqYaeMWtGqpmGE6n8JTD8ptz56SrlGcZfEjcs7v++dH+Kt0pM6BU2cxRl4ygNEpa
	FtIGGrUudszfDWDP6QOjOx5tn5TXZhj1J5Q+TtWsBpD6VdjXPY4Pw1NAkkX/p7imB6EGqDAc0qrv+
	093oxWeQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vRdBq-0000000A3dZ-3Rpm;
	Fri, 05 Dec 2025 21:18:10 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vRdBp-0000000A3cw-1LYB
	for linux-nvme@bombadil.infradead.org;
	Fri, 05 Dec 2025 21:18:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=IxVHZtEpvAb0wwOXSSvRmivBfSUpUQhbLwoJPmBuAUM=; b=GL9i/S/oReFKxk/xGoZBrH4bD2
	vKOhiLjY2xYTR2HSy2du7VBqsoGt5c6WhprIcdBkHvxQQ1AFnsQJP+7FAhOrrI2/Is6B7OQLPIQqT
	8MXh2XLyS66titXX692ua9ncIpzK0AgGJ95zwjU/nNNNZe2dccpGN6CpdaHSAhcNK5i/v9nluQl2m
	u+IO94E6PvGZk7Cx9xZFEFNrHfEo6oUBe8C3udpnJobDKTWDh3r3kOfa0eg4WJNZr1SorrUoSqboE
	+RxpamQyPOwWrS0zHwWiczGD4Ec+9E5YKnNMxBPax1MdouArmmb65vl+vqcD3yrbA35UQs639poWf
	UDoYD8tg==;
Received: from mail-dy1-x132c.google.com ([2607:f8b0:4864:20::132c])
	by desiato.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vRcKE-00000006q5R-2CWL
	for linux-nvme@lists.infradead.org;
	Fri, 05 Dec 2025 20:22:48 +0000
Received: by mail-dy1-x132c.google.com with SMTP id 5a478bee46e88-2a45877bd5eso4746462eec.0
        for <linux-nvme@lists.infradead.org>; Fri, 05 Dec 2025 13:18:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1764969483; x=1765574283; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IxVHZtEpvAb0wwOXSSvRmivBfSUpUQhbLwoJPmBuAUM=;
        b=cT9IOFsRoR9GLH8NBDlWsurV+vQrujIZgY+H01Fk9/b5YD9/tpS/8GE0Le2CUaokoP
         /p9erFg30UbqrW3nzA6lnGioIDtxvHo+MpjQxVO6Lif9LL0vFI7SAwT9AMawL9EyY5QD
         OYLOwz5qovKYUqKTqz4P3b1grrFTWDbUtELEz2tpyE4dqR5/CU4KfX/OTX6vh42BmT9f
         TGDvbRTaStHjZ0Ga3CL6wCHjgh501nGO86AtmRLC/Yqbuioc/WvbdSMCKJD2a/j9krFh
         ub9Ib9mNT/MifJBAlsi6oaKmd9z3a6aUC47Hjo6ur3fbztUyD1+sbbCzFlZKms8ZCfgA
         HFzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764969483; x=1765574283;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IxVHZtEpvAb0wwOXSSvRmivBfSUpUQhbLwoJPmBuAUM=;
        b=vJICUOIXcUWWtyq1JTQ8EQovOUd2eknn5fE9afUhohfbcahajpw259ab4kz8trRySx
         MWbIzOk/sZ/XGNYX3OA8hnR2bnqcaY4dVtndk+CW0NpXEAXgh+CnzjqWTfhCprXjEvq5
         7ovvJDTbbI7X/b54ZcU9JS6Rc4VR1gTTWUal8t+96R+l4piXND3QZR+P+zE4LUFc7GN0
         /LKkNQOOy4uTZw1vuGvVeh8QGJkOvq7ikbrIUhzDm15nhy5Ysnm2jdnDRBhtjXprjUPb
         9jaEmvSTvFI213bxUbsaNd2He9KeWlGjoFUSDsO0JUOKrFTZJVvrKC371/E7bVWdXEZu
         dsow==
X-Forwarded-Encrypted: i=1; AJvYcCV0sGeOiAXXhkygLSNL83lV6PabgbLNeGD8TqwNpXOXeyvkuq4BxKFwm93dpaVHDG3jmVq8WCzp/Cki@lists.infradead.org
X-Gm-Message-State: AOJu0YxUI3eC3WIPZRotOgmza/Ysu9VnSrGI4v19otwA/P6AjG3SRihS
	ND43GcSgggrrgb55ThPYXuxHnqVo5WRPSZFDYMgZdoE2SWFEyWhioTtkU/Egrwv+UHg=
X-Gm-Gg: ASbGncsMctQ9fLuAVl0376xjw0OSSH7DfA55NEKwJiJyvLjApeLuiikONkbPwCEjPMs
	nlxTCO8fW/Ct/VRfUvRkVcCjaIecTwjIO/t228ysjdNfkEurVPbdVuakduX7KAuBWh5YTfc4BBn
	Rc6/2meNIEB+yGiIpVLoq8/DxgsSc7h1b6hozC5bRQQG95yxdTstOrWPggLLNb+HZXvT4STDiFx
	uQprCHNQXOqBGRW7DFJ/pmbshtdrbnBFMpHmEuDhQMccETtYCNSByWMKk0TVwLZqn7f0ofN/pMb
	3/R9hXqAfLfRCMUh0OqXPwzOhffdQcO64D3HLovU8lP+Rd4ABV1y3WRTAE0GYJhMozKgPy9IwCI
	My9Q0tWI276Q7wHfWqbSvJbp/TMGCv7M/Uw7plGyTCPq/f4sP1DK+oOBNegtVduHnodmQK/nc+Y
	6Kk62GcU0of2A/6XaJMC9uLubRa4rb/2lkaw==
X-Google-Smtp-Source: AGHT+IE9alKhA0GP6tatt4dkrUemaxM+deut5b3WMkwd/ve3r17ojkqfkIKKJ7dvVUDgZlXRSMLV6A==
X-Received: by 2002:a05:7300:5711:b0:2a4:626d:5c38 with SMTP id 5a478bee46e88-2aba34e59e6mr5875926eec.17.1764969482731;
        Fri, 05 Dec 2025 13:18:02 -0800 (PST)
Received: from apollo.purestorage.com ([208.88.152.253])
        by smtp.googlemail.com with ESMTPSA id 5a478bee46e88-2aba8395d99sm25546318eec.1.2025.12.05.13.18.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Dec 2025 13:18:02 -0800 (PST)
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
Subject: [PATCH v4 1/1] block: Use RCU in blk_mq_[un]quiesce_tagset() instead of set->tag_list_lock
Date: Fri,  5 Dec 2025 13:17:02 -0800
Message-ID: <20251205211738.1872244-2-mkhalfella@purestorage.com>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251205211738.1872244-1-mkhalfella@purestorage.com>
References: <20251205211738.1872244-1-mkhalfella@purestorage.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251205_202246_840483_4DC19EC7 
X-CRM114-Status: GOOD (  18.38  )
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

  __schedule+0x47c/0xbb0
  ? timerqueue_add+0x66/0xb0
  schedule+0x1c/0xa0
  schedule_preempt_disabled+0xa/0x10
  __mutex_lock.constprop.0+0x271/0x600
  blk_mq_quiesce_tagset+0x25/0xc0
  nvme_dev_disable+0x9c/0x250
  nvme_timeout+0x1fc/0x520
  blk_mq_handle_expired+0x5c/0x90
  bt_iter+0x7e/0x90
  blk_mq_queue_tag_busy_iter+0x27e/0x550
  ? __blk_mq_complete_request_remote+0x10/0x10
  ? __blk_mq_complete_request_remote+0x10/0x10
  ? __call_rcu_common.constprop.0+0x1c0/0x210
  blk_mq_timeout_work+0x12d/0x170
  process_one_work+0x12e/0x2d0
  worker_thread+0x288/0x3a0
  ? rescuer_thread+0x480/0x480
  kthread+0xb8/0xe0
  ? kthread_park+0x80/0x80
  ret_from_fork+0x2d/0x50
  ? kthread_park+0x80/0x80
  ret_from_fork_asm+0x11/0x20

  __schedule+0x47c/0xbb0
  ? xas_find+0x161/0x1a0
  schedule+0x1c/0xa0
  blk_mq_freeze_queue_wait+0x3d/0x70
  ? destroy_sched_domains_rcu+0x30/0x30
  blk_mq_update_tag_set_shared+0x44/0x80
  blk_mq_exit_queue+0x141/0x150
  del_gendisk+0x25a/0x2d0
  nvme_ns_remove+0xc9/0x170
  nvme_remove_namespaces+0xc7/0x100
  nvme_remove+0x62/0x150
  pci_device_remove+0x23/0x60
  device_release_driver_internal+0x159/0x200
  unbind_store+0x99/0xa0
  kernfs_fop_write_iter+0x112/0x1e0
  vfs_write+0x2b1/0x3d0
  ksys_write+0x4e/0xb0
  do_syscall_64+0x5b/0x160
  entry_SYSCALL_64_after_hwframe+0x4b/0x53

The top stacktrace is showing nvme_timeout() called to handle nvme
command timeout. timeout handler is trying to disable the controller and
as a first step, it needs to blk_mq_quiesce_tagset() to tell blk-mq not
to call queue callback handlers. The thread is stuck waiting for
set->tag_list_lock as it tries to walk the queues in set->tag_list.

The lock is held by the second thread in the bottom stack which is
waiting for one of queues to be frozen. The queue usage counter will
drop to zero after nvme_timeout() finishes, and this will not happen
because the thread will wait for this mutex forever.

Given that [un]quiescing queue is an operation that does not need to
sleep, update blk_mq_[un]quiesce_tagset() to use RCU instead of taking
set->tag_list_lock, update blk_mq_{add,del}_queue_tag_set() to use RCU
safe list operations. Also, delete INIT_LIST_HEAD(&q->tag_set_list)
in blk_mq_del_queue_tag_set() because we can not re-initialize it while
the list is being traversed under RCU. The deleted queue will not be
added/deleted to/from a tagset and it will be freed in blk_free_queue()
after the end of RCU grace period.

Signed-off-by: Mohamed Khalfella <mkhalfella@purestorage.com>
Fixes: 98d81f0df70c ("nvme: use blk_mq_[un]quiesce_tagset")
---
 block/blk-mq.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index d626d32f6e57..05db3d20783f 100644
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
@@ -4302,7 +4302,6 @@ static void blk_mq_del_queue_tag_set(struct request_queue *q)
 		blk_mq_update_tag_set_shared(set, false);
 	}
 	mutex_unlock(&set->tag_list_lock);
-	INIT_LIST_HEAD(&q->tag_set_list);
 }
 
 static void blk_mq_add_queue_tag_set(struct blk_mq_tag_set *set,
@@ -4321,7 +4320,7 @@ static void blk_mq_add_queue_tag_set(struct blk_mq_tag_set *set,
 	}
 	if (set->flags & BLK_MQ_F_TAG_QUEUE_SHARED)
 		queue_set_hctx_shared(q, true);
-	list_add_tail(&q->tag_set_list, &set->tag_list);
+	list_add_tail_rcu(&q->tag_set_list, &set->tag_list);
 
 	mutex_unlock(&set->tag_list_lock);
 }
-- 
2.51.2


