Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4528C001B0
	for <linux-nvme@archiver.kernel.org>; Wed, 26 Jul 2023 14:30:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=lH3i/5MHaICLg51BeqksBGNc0GofeOg+XxYJ4iJaaUk=; b=otVCCLI77RMNZU9h/dH+bMv3s1
	tSf4Fgaqrkg7/stVR92JIEBuOF7or1oRFe2nGj7ZNG7js4ph02DsMea0JWvoySCcjG4o/ym+Asoqu
	gU83RXM8st1ZA1m4evQaqFqXiyZrsbs1tbWZCRAMyAhltDokeRMwas6cRIu/CYe44I14RqyznppJo
	xcL0HujvcqBK+bXhkfPWviAwIW7ANjAgyh1PawCtiB+slArV2R3l465bx3m/dIQwE9/Amon1JhrC9
	7WOdFEindJOk+I8qjyPxCrt95gkZ5Tc6ciWkrlfJvDaVWO/IhEbluJ9Emjz3CoOdQG5Ih7DQANzmO
	nk2ctXhg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qOfWa-00Ag0g-0t;
	Wed, 26 Jul 2023 14:30:00 +0000
Received: from out-39.mta1.migadu.com ([2001:41d0:203:375::27])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qOfWV-00Afz9-1Y
	for linux-nvme@lists.infradead.org;
	Wed, 26 Jul 2023 14:29:58 +0000
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1690381786;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=lH3i/5MHaICLg51BeqksBGNc0GofeOg+XxYJ4iJaaUk=;
	b=JYsvELywi0tkPp6wzttatVLF59HGT8BzITCcuiClhBXswuBZi7u0Duzub/Ci7zkMKjcuYm
	VCSbLeIguNd/bRvuu+XO9KBc1TEA2DoTSitkSKGmF2rcZPLQrknrbJp9xdhMK4NFRKtwHU
	PxkqiT22DSFrwE980FtLrTsjQ+j/0MI=
From: Guoqing Jiang <guoqing.jiang@linux.dev>
To: hch@lst.de,
	sagi@grimberg.me,
	kch@nvidia.com
Cc: linux-nvme@lists.infradead.org
Subject: [PATCH RFC] nvmet-tcp: add new workqueue to surpress lockdep warning
Date: Wed, 26 Jul 2023 22:29:39 +0800
Message-Id: <20230726142939.10062-1-guoqing.jiang@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230726_072956_327517_E5415BF2 
X-CRM114-Status: GOOD (  15.46  )
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

During the test of nvme-tcp, lockdep complains when discover local
nvme tcp device.

[   87.699136] ======================================================
[   87.699137] WARNING: possible circular locking dependency detected
[   87.699138] 6.5.0-rc3+ #16 Tainted: G            E
[   87.699139] ------------------------------------------------------
[   87.699140] kworker/0:4H/1522 is trying to acquire lock:
[   87.699141] ffff93c4df45f538 ((wq_completion)nvmet-wq){+.+.}-{0:0}, at: __flush_workqueue+0x99/0x4f0
[   87.699147]
               but task is already holding lock:
[   87.699148] ffffafb40272fe40 ((work_completion)(&queue->io_work)){+.+.}-{0:0}, at: process_one_work+0x236/0x590
[   87.699151]
               which lock already depends on the new lock.
[   87.699152]
               the existing dependency chain (in reverse order) is:
[   87.699153]
               -> #2 ((work_completion)(&queue->io_work)){+.+.}-{0:0}:
[   87.699155]        __flush_work+0x7a/0x5c0
[   87.699157]        __cancel_work_timer+0x155/0x1e0
[   87.699158]        cancel_work_sync+0x10/0x20
[   87.699160]        nvmet_tcp_release_queue_work+0xcf/0x490 [nvmet_tcp]
[   87.699163]        process_one_work+0x2bd/0x590
[   87.699165]        worker_thread+0x52/0x3f0
[   87.699166]        kthread+0x109/0x140
[   87.699168]        ret_from_fork+0x46/0x70
[   87.699170]        ret_from_fork_asm+0x1b/0x30
[   87.699172]
               -> #1 ((work_completion)(&queue->release_work)){+.+.}-{0:0}:
[   87.699174]        process_one_work+0x28c/0x590
[   87.699175]        worker_thread+0x52/0x3f0
[   87.699177]        kthread+0x109/0x140
[   87.699177]        ret_from_fork+0x46/0x70
[   87.699179]        ret_from_fork_asm+0x1b/0x30
[   87.699180]
               -> #0 ((wq_completion)nvmet-wq){+.+.}-{0:0}:
[   87.699182]        __lock_acquire+0x1523/0x2590
[   87.699184]        lock_acquire+0xd6/0x2f0
[   87.699185]        __flush_workqueue+0xc5/0x4f0
[   87.699187]        nvmet_tcp_install_queue+0x30/0x160 [nvmet_tcp]
[   87.699189]        nvmet_install_queue+0xbf/0x200 [nvmet]
[   87.699196]        nvmet_execute_admin_connect+0x18b/0x2f0 [nvmet]
[   87.699200]        nvmet_tcp_io_work+0x7e3/0x850 [nvmet_tcp]
[   87.699203]        process_one_work+0x2bd/0x590
[   87.699204]        worker_thread+0x52/0x3f0
[   87.699206]        kthread+0x109/0x140
[   87.699207]        ret_from_fork+0x46/0x70
[   87.699208]        ret_from_fork_asm+0x1b/0x30
[   87.699209]
               other info that might help us debug this:
[   87.699210] Chain exists of:
                 (wq_completion)nvmet-wq --> (work_completion)(&queue->release_work) --> (work_completion)(&queue->io_work)
[   87.699212]  Possible unsafe locking scenario:
[   87.699213]        CPU0                    CPU1
[   87.699214]        ----                    ----
[   87.699214]   lock((work_completion)(&queue->io_work));
[   87.699215]                                lock((work_completion)(&queue->release_work));
[   87.699217]                                lock((work_completion)(&queue->io_work));
[   87.699218]   lock((wq_completion)nvmet-wq);
                        -> need to hold release_work since queue_work(nvmet_wq, &queue->release_work)
[   87.699219]
                *** DEADLOCK ***
[   87.699220] 2 locks held by kworker/0:4H/1522:
[   87.699221]  #0: ffff93c4df45f338 ((wq_completion)nvmet_tcp_wq){+.+.}-{0:0}, at: process_one_work+0x236/0x590
[   87.699224]  #1: ffffafb40272fe40 ((work_completion)(&queue->io_work)){+.+.}-{0:0}, at: process_one_work+0x236/0x590
[   87.699227]
               stack backtrace:
[   87.699229] CPU: 0 PID: 1522 Comm: kworker/0:4H Tainted: G            E      6.5.0-rc3+ #16
[   87.699230] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.16.0-0-gd239552c-rebuilt.opensuse.org 04/01/2014
[   87.699231] Workqueue: nvmet_tcp_wq nvmet_tcp_io_work [nvmet_tcp]

The above happens because nvmet_tcp_io_work can trigger below path

	-> nvmet_tcp_try_recv
	 -> nvmet_tcp_try_recv_one
	  -> nvmet_tcp_try_recv_data
	   -> nvmet_tcp_execute_request
	    -> cmd->req.execute = nvmet_execute_admin_connect
	     -> nvmet_install_queue
	      -> ctrl->ops->install_queue = nvmet_install_queue
	       -> nvmet_tcp_install_queue
	        -> flush_workqueue(nvmet_wq)

And release_work (nvmet_tcp_release_queue_work) is also queued in
nvmet_wq, which need to flush io_work (nvmet_tcp_io_work) due to
cancel_work_sync(&queue->io_work).

We can surpress the lockdep warning by checking if the relevant work
is pending. So the simplest might be just add the checking before
flush_workqueue(nvmet_wq). However, there are other works are also
queued on the same queue, I am not sure if we should flush other
works unconditionally, so a new dedicated workqueue is added.

Signed-off-by: Guoqing Jiang <guoqing.jiang@linux.dev>
---
 drivers/nvme/target/tcp.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index 868aa4de2e4c..ac611cb299a8 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -189,6 +189,7 @@ static LIST_HEAD(nvmet_tcp_queue_list);
 static DEFINE_MUTEX(nvmet_tcp_queue_mutex);
 
 static struct workqueue_struct *nvmet_tcp_wq;
+static struct workqueue_struct *nvmet_tcp_release_wq;
 static const struct nvmet_fabrics_ops nvmet_tcp_ops;
 static void nvmet_tcp_free_cmd(struct nvmet_tcp_cmd *c);
 static void nvmet_tcp_free_cmd_buffers(struct nvmet_tcp_cmd *cmd);
@@ -1288,7 +1289,7 @@ static void nvmet_tcp_schedule_release_queue(struct nvmet_tcp_queue *queue)
 	spin_lock(&queue->state_lock);
 	if (queue->state != NVMET_TCP_Q_DISCONNECTING) {
 		queue->state = NVMET_TCP_Q_DISCONNECTING;
-		queue_work(nvmet_wq, &queue->release_work);
+		queue_work(nvmet_tcp_release_wq, &queue->release_work);
 	}
 	spin_unlock(&queue->state_lock);
 }
@@ -1847,6 +1848,8 @@ static u16 nvmet_tcp_install_queue(struct nvmet_sq *sq)
 	if (sq->qid == 0) {
 		/* Let inflight controller teardown complete */
 		flush_workqueue(nvmet_wq);
+		if (work_pending(&queue->release_work))
+			flush_workqueue(nvmet_tcp_release_wq);
 	}
 
 	queue->nr_cmds = sq->size * 2;
@@ -1892,12 +1895,20 @@ static int __init nvmet_tcp_init(void)
 	if (!nvmet_tcp_wq)
 		return -ENOMEM;
 
+	nvmet_tcp_release_wq = alloc_workqueue("nvmet_tcp_release_wq",
+				WQ_MEM_RECLAIM, 0);
+	if (!nvmet_tcp_release_wq) {
+		destroy_workqueue(nvmet_tcp_wq);
+		return -ENOMEM;
+	}
+
 	ret = nvmet_register_transport(&nvmet_tcp_ops);
 	if (ret)
 		goto err;
 
 	return 0;
 err:
+	destroy_workqueue(nvmet_tcp_release_wq);
 	destroy_workqueue(nvmet_tcp_wq);
 	return ret;
 }
@@ -1915,6 +1926,7 @@ static void __exit nvmet_tcp_exit(void)
 	mutex_unlock(&nvmet_tcp_queue_mutex);
 	flush_workqueue(nvmet_wq);
 
+	destroy_workqueue(nvmet_tcp_release_wq);
 	destroy_workqueue(nvmet_tcp_wq);
 }
 
-- 
2.34.1


