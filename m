Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0241CC4332F
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Nov 2022 11:29:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2dvdzn09oockNUMQufqCO3Lg35Gyue4fAqX8niEOtc4=; b=xN2+HqcTdTeTms3ReyTF7uO80T
	YKm5GXJ4AbQF7LJ8ppb21vmGdCva62zpJB9hWCgb8Puhg5BY2RHwN1hkgeQ0t7SRx6smsiHzZkQgW
	LjDQDAvmNO+iXbsAypfCmdhtJ9SUmx5Z1yXFbGDOifO+C5KWZGERd+WGshOXeuDaxAfp5OjUM4NM1
	RHIpqKLuTIPbVtc6xXlFp8ts6EkEHkf/zDGU4FRIewqvwSe+tx/ncWJZwmHk2zPzxQiUIQAxOH/iH
	RORcnB9t0HklLz9kd5gO0he5UNOeSXXeyCXWPTrbpgIizCYbsXZ1FHYVzDxMyiN3oSLCSdstyxKDJ
	3f/54wDw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1osMn9-004roj-Kb; Tue, 08 Nov 2022 11:29:19 +0000
Received: from mail3-166.sinamail.sina.com.cn ([202.108.3.166])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1osMmz-004rlJ-CZ
	for linux-nvme@lists.infradead.org; Tue, 08 Nov 2022 11:29:13 +0000
Received: from unknown (HELO localhost.localdomain)([114.249.57.238])
	by sina.com (172.16.97.23) with ESMTP
	id 636A3D01000371CF; Tue, 8 Nov 2022 19:26:59 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
X-SMAIL-MID: 55870954919314
From: Hillf Danton <hdanton@sina.com>
To: fruggeri@arista.com
Cc: linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	hch@lst.de
Subject: Re: nvme: hung task in blk_mq_freeze_queue_wait
Date: Tue,  8 Nov 2022 19:28:48 +0800
Message-Id: <20221108112848.1085-1-hdanton@sina.com>
In-Reply-To: <20221108025602.E48005EC04F9@us226.sjc.aristanetworks.com>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221108_032909_655345_E712B2FC 
X-CRM114-Status: GOOD (  18.45  )
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

On 07 Nov 2022 18:56:02 -0800 Francesco Ruggeri <fruggeri@arista.com> 
> We are running into hung tasks in blk_mq_freeze_queue_wait, sometimes
> in nvme_reset_work and sometimes in nvme_scan_work.
> In some cases we also see a warning in blk_mq_unfreeze_queue
> (WARN_ON_ONCE(q->mq_freeze_depth < 0)):

Evidence for hang after double wakeup.

> WARNING: CPU: 10 PID: 152 at block/blk-mq.c:199 blk_mq_unfreeze_queue+0x26/0x5a
> The hung tasks are preceded by two instances of nvme_timeout racing in
> nvme_dev_disable after a device becomes unresponsive.
> The first nvme_dev_disable blocks in wait_for_completion_io_timeout, and
> a while later a second instance blocks in mutex_lock(&dev->shutdown_lock).
> When the timeout expires and the first instance releases the mutex,
> the two instances start racing.
> We have seen the hung tasks in 4.19, but from a quick look at the
> latest 6.1 code the issue is probably there as well.
> There seem to be two different scenarios where unbalanced
> blk_freeze_queue_start/blk_mq_unfreeze_queue could be the cause.
> 
> 1) In this case we have an unfreeze without a corresponding freeze
> preceding it.
> 
> TIMEOUT 1	TIMEOUT 2	RESET WORK 1	RESET WORK 2
> 
> state = NVME_CTRL_LIVE
> nvme_timeout
> nvme_dev_disable
> mutex_lock
> nvme_start_freeze
> blk_freeze_queue_start
> nvme_disable_io_queues
> wait_for_completion_io_timeout
> 		nvme_timeout
> 		nvme_dev_disable
> 		mutex_lock
> mutex_unlock
> nvme_reset_ctrl
> state = NVME_CTRL_RESETTING
> queue_work(nvme_reset_work)
> 				nvme_reset_work
> 				state = NVME_CTRL_CONNECTING
> 		(state != NVME_CTRL_LIVE and
> 		state != NVME_CTRL_RESETTING)
> 		skips nvme_start_freeze
> 		mutex_unlock
> 		nvme_reset_ctrl
> 		state = NVME_CTRL_RESETTING
> 		queue_work(nvme_reset_work)
> 				nvme_unfreeze (matches
> 				nvme_start_freeze in
> 				TIMEOUT 1)
> 						nvme_reset_work
> 						nvme_unfreeze (no
> 						match in TIMEOUT 2)
> 
> 
> 2) In this case a freeze has no corresponding unfreeze following it.
> TIMEOUT 2 cannot schedule nvme_reset_work because TIMEOUT 1's is already
> scheduled but not yet running.
> 
> TIMEOUT 1	TIMEOUT 2	RESET WORK 1	RESET WORK 2
> 
> state = NVME_CTRL_LIVE
> nvme_timeout
> nvme_dev_disable
> mutex_lock
> nvme_start_freeze
> blk_freeze_queue_start
> nvme_disable_io_queues
> wait_for_completion_io_timeout
> 		nvme_timeout
> 		nvme_dev_disable
> 		mutex_lock
> mutex_unlock
> nvme_reset_ctrl
> state = NVME_CTRL_RESETTING
> queue_work(nvme_reset_work)
> 		(state == NVME_CTRL_LIVE or
> 		state == NVME_CTRL_RESETTING)
> 		nvme_start_freeze
> 		blk_freeze_queue_start
> 		mutex_unlock
> 		nvme_reset_ctrl
> 		state = NVME_CTRL_RESETTING
> 		queue_work(nvme_reset_work)
> 		fails because nvme_reset_work
> 		is not running yet
> 				nvme_reset_work
> 				nvme_unfreeze (matches
> 				nvme_start_freeze in
> 				TIMEOUT 1)
> 						It gets never
> 						scheduled.
> 
> 
> Following is one such backtrace.
> 
> [ 4390.119745] INFO: task kworker/u80:2:8279 blocked for more than 300 seconds.
> [ 4390.471456]       Tainted: P           O      4.19.142.Ar-29007847.buytenhb7335070 #1
> [ 4390.832568] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> [ 4391.193663] kworker/u80:2   D    0  8279      2 0x80000000
> [ 4391.526603] Workqueue: nvme-reset-wq nvme_reset_work
> [ 4391.853272] Call Trace:
> [ 4392.149696]  __schedule+0x75b/0x7c2
> [ 4392.458627]  schedule+0x78/0x8c
> [ 4392.763399]  blk_mq_freeze_queue_wait+0x8b/0xb6
> [ 4393.084849]  ? wait_woken+0x92/0x92
> [ 4393.393791]  nvme_wait_freeze+0x39/0x4e
> [ 4393.706900]  nvme_reset_work+0x1464/0x1665
> [ 4394.023142]  ? dequeue_entity+0x694/0x6a3
> [ 4394.338340]  process_one_work+0x1c2/0x30f
> [ 4394.511642]  worker_thread+0x1e9/0x2cc
> [ 4394.556626]  ? rescuer_thread+0x2b7/0x2b7
> [ 4394.604738]  kthread+0x15d/0x165
> [ 4394.643460]  ? kthread_park+0x98/0x98
> [ 4394.687396]  ret_from_fork+0x1f/0x30

Given blk_mq_freeze_queue_wait() in the call trace, another explanation
may be percpu refcount [1], which can be tested with the diff attached.

Only for thoughts.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/block/blk-mq.c?h=next-20221104#n228

Hillf

+++ next-20221104/block/blk-mq.c
@@ -175,9 +175,20 @@ void blk_freeze_queue_start(struct reque
 }
 EXPORT_SYMBOL_GPL(blk_freeze_queue_start);
 
+static bool blk_mq_zero_freeze_depth(struct request_queue *q)
+{
+	bool ret;
+
+	mutex_lock(&q->mq_freeze_lock);
+	ret = !q->mq_freeze_depth;
+	mutex_unlock(&q->mq_freeze_lock);
+
+	return ret;
+}
+
 void blk_mq_freeze_queue_wait(struct request_queue *q)
 {
-	wait_event(q->mq_freeze_wq, percpu_ref_is_zero(&q->q_usage_counter));
+	wait_event(q->mq_freeze_wq, blk_mq_zero_freeze_depth(q));
 }
 EXPORT_SYMBOL_GPL(blk_mq_freeze_queue_wait);
 
@@ -185,7 +196,7 @@ int blk_mq_freeze_queue_wait_timeout(str
 				     unsigned long timeout)
 {
 	return wait_event_timeout(q->mq_freeze_wq,
-					percpu_ref_is_zero(&q->q_usage_counter),
+					blk_mq_zero_freeze_depth(q),
 					timeout);
 }
 EXPORT_SYMBOL_GPL(blk_mq_freeze_queue_wait_timeout);

