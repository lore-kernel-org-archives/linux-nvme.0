Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD7D2EE14D6
	for <linux-nvme@archiver.kernel.org>; Thu,  7 Sep 2023 08:12:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=w100yaLBvwNH+WVfbjpN8T5H4OviHRTR+lJmQJEyilA=; b=QuYAgXPR9RwBYWWOf3/g9S4LoU
	QnR/zJsynbNojTzjNO/DQVBPwsbDsgTZ81wzymUdl5PNqKptui6J0RdSTzsFSO5gB0WVvu3fmQ6sP
	PZmC7fYhMqmzcqEPgQGB9aTJML4ZkJl6rXxsrIKgys5cAl5EFZHtNqo0kP1YmQF3mpiSUFKogIK+K
	qMKd6Kinug0rMPL6pl8cc974LBxc1hSP/FRFgxdY8LodU+VrIhvXOTA+U8fPYyF6Dki1w33aHMHR8
	dd89iHaTmEIjduKugrV5ykwrO5CKeH8ET8Z8c/fMf+oKEPW1c1GXWOfPH7uoF925qluqV6xMWmP9p
	NQYBXVnQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qeA7z-00BYy3-19;
	Thu, 07 Sep 2023 08:12:39 +0000
Received: from out-222.mta0.migadu.com ([2001:41d0:1004:224b::de])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qeA7u-00BYwm-3A
	for linux-nvme@lists.infradead.org;
	Thu, 07 Sep 2023 08:12:37 +0000
Message-ID: <a403c942-5b1c-c7f7-243b-81545f7f83ad@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1694074351;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=w100yaLBvwNH+WVfbjpN8T5H4OviHRTR+lJmQJEyilA=;
	b=FG9s9/vAhtMIH5kleuUh8B4JZPQUOwicxxS6HsmU1hIpkiN8n4F+QSU1poNq1Ah1cREvGr
	qmapYbEOKn4NfKUEHDIsAUq/jDSVsb6cTiLq7AT8loxFLneB1Tzm9oQk6Q31+rILwq8JbF
	J1tznL52BG06IphVpRAhxawxKrIip7Q=
Date: Thu, 7 Sep 2023 16:12:18 +0800
MIME-Version: 1.0
Subject: Re: [PATCH RFC] nvmet-tcp: add new workqueue to surpress lockdep
 warning
Content-Language: en-US
To: Yi Zhang <yi.zhang@redhat.com>
Cc: hch@lst.de, sagi@grimberg.me, kch@nvidia.com,
 linux-nvme@lists.infradead.org
References: <20230726142939.10062-1-guoqing.jiang@linux.dev>
 <CAHj4cs9LppxseFzZe-fj7tDaeKd0x8t8Wr-aYcjXAU-8FyfoiQ@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Guoqing Jiang <guoqing.jiang@linux.dev>
In-Reply-To: <CAHj4cs9LppxseFzZe-fj7tDaeKd0x8t8Wr-aYcjXAU-8FyfoiQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230907_011235_443516_F64D9FDC 
X-CRM114-Status: UNSURE (   9.09  )
X-CRM114-Notice: Please train this message.
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

Hi Yi,

On 9/7/23 14:41, Yi Zhang wrote:
> Tested-by: Yi Zhang <yi.zhang@redhat.com>
>
> Confirmed below issue was fixed by this patch:

Thanks a lot for the test!

And I had got another similar lockdep warning about nvmet-rdma.


[ 1218.508847] ======================================================
[ 1218.508849] WARNING: possible circular locking dependency detected
[ 1218.508852] 6.5.0-rc3+ #16 Tainted: G           OE
[ 1218.508854] ------------------------------------------------------
[ 1218.508856] kworker/1:3/357 is trying to acquire lock:
[ 1218.508858] ffff8e32b919fc20 (&id_priv->handler_mutex){+.+.}-{3:3}, 
at: rdma_destroy_id+0x1c/0x40 [rdma_cm]
[ 1218.508877]
                but task is already holding lock:
[ 1218.508878] ffffb5dbc0c67e40 
((work_completion)(&queue->release_work)){+.+.}-{0:0}, at: 
process_one_work+0x236/0x590
[ 1218.508887]
                which lock already depends on the new lock.

[ 1218.508888]
                the existing dependency chain (in reverse order) is:
[ 1218.508890]
                -> #3 ((work_completion)(&queue->release_work)){+.+.}-{0:0}:
[ 1218.508894]        process_one_work+0x28c/0x590
[ 1218.508898]        worker_thread+0x52/0x3f0
[ 1218.508901]        kthread+0x109/0x140
[ 1218.508904]        ret_from_fork+0x46/0x70
[ 1218.508908]        ret_from_fork_asm+0x1b/0x30
[ 1218.508911]
                -> #2 ((wq_completion)nvmet-wq){+.+.}-{0:0}:
[ 1218.508915]        __flush_workqueue+0xc5/0x4f0
[ 1218.508917]        nvmet_rdma_cm_handler+0xa50/0x1080 [nvmet_rdma]
[ 1218.508924]        cma_cm_event_handler+0x4f/0x170 [rdma_cm]
[ 1218.508933]        iw_conn_req_handler+0x2ad/0x3f0 [rdma_cm]
[ 1218.508942]        cm_work_handler+0xbe2/0xe80 [iw_cm]
[ 1218.508948]        process_one_work+0x2bd/0x590
[ 1218.508951]        worker_thread+0x52/0x3f0
[ 1218.508954]        kthread+0x109/0x140
[ 1218.508956]        ret_from_fork+0x46/0x70
[ 1218.508959]        ret_from_fork_asm+0x1b/0x30
[ 1218.508961]
                -> #1 (&id_priv->handler_mutex/1){+.+.}-{3:3}:
[ 1218.508966]        __mutex_lock+0x8d/0xd20
[ 1218.508969]        mutex_lock_nested+0x1b/0x30
[ 1218.508971]        iw_conn_req_handler+0x137/0x3f0 [rdma_cm]
[ 1218.508980]        cm_work_handler+0xbe2/0xe80 [iw_cm]
[ 1218.508986]        process_one_work+0x2bd/0x590
[ 1218.508989]        worker_thread+0x52/0x3f0
[ 1218.508991]        kthread+0x109/0x140
[ 1218.508993]        ret_from_fork+0x46/0x70
[ 1218.508996]        ret_from_fork_asm+0x1b/0x30
[ 1218.508998]
                -> #0 (&id_priv->handler_mutex){+.+.}-{3:3}:
[ 1218.509002]        __lock_acquire+0x1523/0x2590
[ 1218.509007]        lock_acquire+0xd6/0x2f0
[ 1218.509009]        __mutex_lock+0x8d/0xd20
[ 1218.509011]        mutex_lock_nested+0x1b/0x30
[ 1218.509013]        rdma_destroy_id+0x1c/0x40 [rdma_cm]
[ 1218.509022]        nvmet_rdma_free_queue+0x38/0xf0 [nvmet_rdma]
[ 1218.509028]        nvmet_rdma_release_queue_work+0x1a/0x70 [nvmet_rdma]
[ 1218.509033]        process_one_work+0x2bd/0x590
[ 1218.509036]        worker_thread+0x52/0x3f0
[ 1218.509039]        kthread+0x109/0x140
[ 1218.509040]        ret_from_fork+0x46/0x70
[ 1218.509043]        ret_from_fork_asm+0x1b/0x30
[ 1218.509045]
                other info that might help us debug this:

[ 1218.509046] Chain exists of:
                  &id_priv->handler_mutex --> (wq_completion)nvmet-wq 
--> (work_completion)(&queue->release_work)

[ 1218.509052]  Possible unsafe locking scenario:

[ 1218.509053]        CPU0                    CPU1
[ 1218.509055]        ----                    ----
[ 1218.509056] lock((work_completion)(&queue->release_work));
[ 1218.509058] lock((wq_completion)nvmet-wq);
[ 1218.509061] lock((work_completion)(&queue->release_work));
[ 1218.509063]   lock(&id_priv->handler_mutex);
[ 1218.509065]
                 *** DEADLOCK ***

The happens because nvmet_rdma_cm_handler receives 
RDMA_CM_EVENT_DISCONNECTED
event then the call chain is triggered.

1. nvmet_rdma_queue_disconnect -> __nvmet_rdma_queue_disconnect
2.                                                             -> 
queue_work(nvmet_wq, &queue->release_work)
3. -> nvmet_rdma_release_queue_work
4.      -> nvmet_rdma_free_queue
5.          -> nvmet_rdma_destroy_queue_ib
6.              -> rdma_destroy_id

If cm_handler receives RDMA_CM_EVENT_CONNECT_REQUEST event at the same 
time, which
means the path nvmet_rdma_queue_connect -> flush_workqueue(nvmet_wq) can 
happen
between 1 and 6.

Besides make similar change like this patch, another option might be 
check queue state before
flush workqueue. Thoughts?

--- a/drivers/nvme/target/rdma.c
+++ b/drivers/nvme/target/rdma.c
@@ -1582,7 +1582,8 @@ static int nvmet_rdma_queue_connect(struct 
rdma_cm_id *cm_id,
                 goto put_device;
         }

-       if (queue->host_qid == 0) {
+       if (queue->state == NVMET_RDMA_Q_LIVE &&
+           queue->host_qid == 0) {
                 /* Let inflight controller teardown complete */
                 flush_workqueue(nvmet_wq);
         }

Thanks,
Guoqing

