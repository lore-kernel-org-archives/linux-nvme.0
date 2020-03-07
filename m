Return-Path: <SRS0=WUld=4Y=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A538C10F00
	for <linux-nvme@archiver.kernel.org>; Sat,  7 Mar 2020 08:27:09 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 11436206D5
	for <linux-nvme@archiver.kernel.org>; Sat,  7 Mar 2020 08:27:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ZWay8Neh";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M4oFRZjU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11436206D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Subject:In-Reply-To:
	Message-ID:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
	List-Owner; bh=hpuie3OU30zf4qXGa4LfXaL2H/wtlbioAojaxAE0TXw=; b=ZWay8Nehi5CwkQ
	NasxFAdzUQEkOWSXX4rHiJ/nXvs4FnTgD74b1Fb+D4sRQVg1Y5RASCU5FmJWqGfs++0BFxStOWORk
	0dkXuMzH/uJdPljsUD7qpWI0W6oqIVD9oBzxSmEmOwm9MOMJUztSk4gUKFx522kHnCT8gv2w4SL4b
	7Vq0BJ1Ip+MP2oXwBHJEWzQzdOIjQEjeyE7o/yK2Z4fxb+qMSI6rAuFcIVSjuRFQYlMMavGAMiedw
	1Y5/ha5iV8Q9PSmdhkNF918nqPmTdiGpfj7RNkVdy2KmZf21ZpakOCbcCcQrkw+OUwJ0xH9QxNvfJ
	jxQU1vXL3KC8ec4ZiONQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jAUnX-00066Q-2h; Sat, 07 Mar 2020 08:27:03 +0000
Received: from us-smtp-2.mimecast.com ([207.211.31.81]
 helo=us-smtp-delivery-1.mimecast.com)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jAUnT-00065p-AS
 for linux-nvme@lists.infradead.org; Sat, 07 Mar 2020 08:27:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583569616;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:  in-reply-to:in-reply-to; 
 bh=jXyl9h+h5T7Zb10n00L9767/gse7R2Y42DIy9JsZaxY=;
 b=M4oFRZjU7EYS1XNlBFcmmKMwvr/KngP6au1M4cd/AdP1eKAfkcsXD5nrXf2LO1HxnMj3Pw
 SVZvtc/2X/wc1IPtmJ0qxkIaYfear+ArDFkzvCvqWODnfw65DaiGpUfHXkj8+YwPZTpi5R
 QXHUvRpUocHs8g9AMV8DlRu5j7HDxqE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-469-bMMT6yW5NKayFKQY0NrRTg-1; Sat, 07 Mar 2020 03:26:38 -0500
X-MC-Unique: bMMT6yW5NKayFKQY0NrRTg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 87104800053;
 Sat,  7 Mar 2020 08:26:37 +0000 (UTC)
Received: from colo-mx.corp.redhat.com
 (colo-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.21])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 76FFC1BC6D;
 Sat,  7 Mar 2020 08:26:37 +0000 (UTC)
Received: from zmail25.collab.prod.int.phx2.redhat.com
 (zmail25.collab.prod.int.phx2.redhat.com [10.5.83.31])
 by colo-mx.corp.redhat.com (Postfix) with ESMTP id 64F8184477;
 Sat,  7 Mar 2020 08:26:37 +0000 (UTC)
Date: Sat, 7 Mar 2020 03:26:37 -0500 (EST)
From: Yi Zhang <yi.zhang@redhat.com>
To: lilinux-rdma@vger.kernel.org
Message-ID: <1955100504.15716600.1583569597057.JavaMail.zimbra@redhat.com>
In-Reply-To: <2005122746.15716557.1583568954926.JavaMail.zimbra@redhat.com>
Subject: [bug report] BUG: KASAN: use-after-free in
 qed_chain_free+0x6d2/0x7f0 [qed]
MIME-Version: 1.0
X-Originating-IP: [10.68.5.41, 10.4.195.19]
Thread-Topic: KASAN: use-after-free in qed_chain_free+0x6d2/0x7f0 [qed]
Thread-Index: p6r0kXTRxM6MSmlwIT4pZLclyZ2Hlw==
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Bad-Reply: In-Reply-To but no 'Re:' in Subject.
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200307_002659_575003_75C060BF 
X-CRM114-Status: GOOD (  11.91  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: skalluru@marvell.com, linux-nvme@lists.infradead.org,
 michal.kalderon@marvell.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Hello

On my NVMe RDMA qedr iWARP environment, reset_controller will lead bellow BUG, could anyone help check this issue.

Steps:
nvme connect -t rdma -a 172.31.50.102 -s 4420 -n testnqn
sleep 1
echo 1 >/sys/block/nvme0c0n1/device/reset_controller

HW:
# lspci | grep -i ql
08:00.0 Ethernet controller: QLogic Corp. FastLinQ QL45000 Series 25GbE Controller (rev 10)
08:00.1 Ethernet controller: QLogic Corp. FastLinQ QL45000 Series 25GbE Controller (rev 10)


dmesg:
client:
[  153.609662] iwpm_register_pid: Unable to send a nlmsg (client = 2)
[  153.679142] nvme nvme0: creating 12 I/O queues.
[  154.447885] nvme nvme0: mapped 12/0/0 default/read/poll queues.
[  154.527204] nvme nvme0: new ctrl: NQN "testnqn", addr 172.31.50.102:4420
[  154.554852] nvme0n1: detected capacity change from 0 to 268435456000
[  173.337907] ==================================================================
[  173.346307] BUG: KASAN: use-after-free in qed_chain_free+0x6d2/0x7f0 [qed]
[  173.354065] Read of size 8 at addr ffff888242305000 by task kworker/u96:5/574
[  173.363795] CPU: 3 PID: 574 Comm: kworker/u96:5 Not tainted 5.6.0-rc4 #1
[  173.371350] Hardware name: Dell Inc. PowerEdge R320/0KM5PX, BIOS 2.7.0 08/19/2019
[  173.379787] Workqueue: nvme-reset-wq nvme_rdma_reset_ctrl_work [nvme_rdma]
[  173.387537] Call Trace:
[  173.390305]  dump_stack+0x96/0xe0
[  173.394062]  ? qed_chain_free+0x6d2/0x7f0 [qed]
[  173.399175]  print_address_description.constprop.6+0x1b/0x220
[  173.405667]  ? qed_chain_free+0x6d2/0x7f0 [qed]
[  173.410790]  ? qed_chain_free+0x6d2/0x7f0 [qed]
[  173.415915]  __kasan_report.cold.9+0x37/0x77
[  173.420737]  ? quarantine_put+0x10/0x160
[  173.425174]  ? qed_chain_free+0x6d2/0x7f0 [qed]
[  173.430290]  kasan_report+0xe/0x20
[  173.434141]  qed_chain_free+0x6d2/0x7f0 [qed]
[  173.439067]  ? __kasan_slab_free+0x13a/0x170
[  173.443915]  ? qed_hw_remove+0x2b0/0x2b0 [qed]
[  173.448947]  qedr_cleanup_kernel+0xbf/0x420 [qedr]
[  173.454367]  ? qed_rdma_modify_srq+0x3c0/0x3c0 [qed]
[  173.459991]  ? qed_rdma_modify_srq+0x3c0/0x3c0 [qed]
[  173.465595]  qedr_destroy_qp+0x2b0/0x670 [qedr]
[  173.470703]  ? qedr_query_qp+0x1300/0x1300 [qedr]
[  173.476015]  ? _raw_spin_unlock_irq+0x24/0x30
[  173.480944]  ? wait_for_completion+0xc2/0x3d0
[  173.485861]  ? wait_for_completion_interruptible+0x440/0x440
[  173.492258]  ? mark_held_locks+0x78/0x130
[  173.496784]  ? _raw_spin_unlock_irqrestore+0x3e/0x50
[  173.502385]  ? lockdep_hardirqs_on+0x388/0x570
[  173.507432]  ib_destroy_qp_user+0x2ba/0x6c0 [ib_core]
[  173.513148]  nvme_rdma_destroy_queue_ib+0xc8/0x1a0 [nvme_rdma]
[  173.519732]  nvme_rdma_free_queue+0x2a/0x60 [nvme_rdma]
[  173.525626]  nvme_rdma_destroy_io_queues+0xb1/0x170 [nvme_rdma]
[  173.532321]  nvme_rdma_shutdown_ctrl+0x62/0xd0 [nvme_rdma]
[  173.538510]  nvme_rdma_reset_ctrl_work+0x2c/0xa0 [nvme_rdma]
[  173.544908]  process_one_work+0x920/0x1740
[  173.549546]  ? pwq_dec_nr_in_flight+0x2d0/0x2d0
[  173.556213]  worker_thread+0x87/0xb40
[  173.561852]  ? process_one_work+0x1740/0x1740
[  173.568315]  kthread+0x333/0x400
[  173.573492]  ? kthread_create_on_node+0xc0/0xc0
[  173.580094]  ret_from_fork+0x3a/0x50
[  173.588720] The buggy address belongs to the page:
[  173.595559] page:ffffea000908c140 refcount:0 mapcount:0 mapping:0000000000000000 index:0x0
[  173.606353] flags: 0x17ffffc0000000()
[  173.611933] raw: 0017ffffc0000000 0000000000000000 ffffea000908c108 0000000000000000
[  173.622111] raw: 0000000000000000 0000000000000000 00000000ffffffff 0000000000000000
[  173.632309] page dumped because: kasan: bad access detected
[  173.643129] Memory state around the buggy address:
[  173.649935]  ffff888242304f00: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
[  173.659491]  ffff888242304f80: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
[  173.669005] >ffff888242305000: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
[  173.678511]                    ^
[  173.683535]  ffff888242305080: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
[  173.693079]  ffff888242305100: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
[  173.702578] ==================================================================
[  173.712132] Disabling lock debugging due to kernel taint
[  174.480153] nvme nvme0: creating 12 I/O queues.


target: 
[  105.823713] null_blk: module loaded
[  106.188952] nvmet: adding nsid 1 to subsystem testnqn
[  106.209393] iwpm_register_pid: Unable to send a nlmsg (client = 2)
[  106.217135] nvmet_rdma: enabling port 2 (172.31.50.102:4420)
[  148.399402] nvmet: creating controller 1 for subsystem testnqn for NQN nqn.2014-08.org.nvmexpress:uuid:5cf10916-b4ca-45cd-956c-ab680ec3e636.
[  167.842446] 
[  167.844133] ======================================================
[  167.851087] WARNING: possible circular locking dependency detected
[  167.858037] 5.6.0-rc4 #2 Not tainted
[  167.862070] ------------------------------------------------------
[  167.869018] kworker/2:1/141 is trying to acquire lock:
[  167.874794] ffff8882581573e0 (&id_priv->handler_mutex){+.+.}, at: rdma_destroy_id+0x108/0xc70 [rdma_cm]
[  167.885361] 
[  167.885361] but task is already holding lock:
[  167.891918] ffffc9000403fe00 ((work_completion)(&queue->release_work)){+.+.}, at: process_one_work+0x82d/0x1740
[  167.903261] 
[  167.903261] which lock already depends on the new lock.
[  167.903261] 
[  167.912449] 
[  167.912449] the existing dependency chain (in reverse order) is:
[  167.920861] 
[  167.920861] -> #3 ((work_completion)(&queue->release_work)){+.+.}:
[  167.929468]        process_one_work+0x87f/0x1740
[  167.934656]        worker_thread+0x87/0xb40
[  167.939356]        kthread+0x333/0x400
[  167.943569]        ret_from_fork+0x3a/0x50
[  167.948172] 
[  167.948172] -> #2 ((wq_completion)events){+.+.}:
[  167.955038]        flush_workqueue+0xf7/0x13c0
[  167.960028]        nvmet_rdma_queue_connect+0x15e0/0x1d60 [nvmet_rdma]
[  167.967368]        cma_cm_event_handler+0xb7/0x550 [rdma_cm]
[  167.973743]        iw_conn_req_handler+0x93c/0xdb0 [rdma_cm]
[  167.980104]        cm_work_handler+0x12d2/0x1920 [iw_cm]
[  167.986093]        process_one_work+0x920/0x1740
[  167.991280]        worker_thread+0x87/0xb40
[  167.995984]        kthread+0x333/0x400
[  168.000199]        ret_from_fork+0x3a/0x50
[  168.004804] 
[  168.004804] -> #1 (&id_priv->handler_mutex/1){+.+.}:
[  168.012051]        __mutex_lock+0x13e/0x1420
[  168.016857]        iw_conn_req_handler+0x369/0xdb0 [rdma_cm]
[  168.023217]        cm_work_handler+0x12d2/0x1920 [iw_cm]
[  168.030777]        process_one_work+0x920/0x1740
[  168.037564]        worker_thread+0x87/0xb40
[  168.043852]        kthread+0x333/0x400
[  168.049681]        ret_from_fork+0x3a/0x50
[  168.055836] 
[  168.055836] -> #0 (&id_priv->handler_mutex){+.+.}:
[  168.065925]        __lock_acquire+0x2313/0x3d90
[  168.072505]        lock_acquire+0x15a/0x3c0
[  168.078664]        __mutex_lock+0x13e/0x1420
[  168.084907]        rdma_destroy_id+0x108/0xc70 [rdma_cm]
[  168.092257]        nvmet_rdma_release_queue_work+0xcc/0x390 [nvmet_rdma]
[  168.101213]        process_one_work+0x920/0x1740
[  168.107798]        worker_thread+0x87/0xb40
[  168.113875]        kthread+0x333/0x400
[  168.119461]        ret_from_fork+0x3a/0x50
[  168.125397] 
[  168.125397] other info that might help us debug this:
[  168.125397] 
[  168.138272] Chain exists of:
[  168.138272]   &id_priv->handler_mutex --> (wq_completion)events --> (work_completion)(&queue->release_work)
[  168.138272] 
[  168.157850]  Possible unsafe locking scenario:
[  168.157850] 
[  168.166962]        CPU0                    CPU1
[  168.173311]        ----                    ----
[  168.179615]   lock((work_completion)(&queue->release_work));
[  168.187210]                                lock((wq_completion)events);
[  168.195872]                                lock((work_completion)(&queue->release_work));
[  168.206278]   lock(&id_priv->handler_mutex);
[  168.212326] 
[  168.212326]  *** DEADLOCK ***
[  168.212326] 
[  168.222662] 2 locks held by kworker/2:1/141:
[  168.228688]  #0: ffff888107c23148 ((wq_completion)events){+.+.}, at: process_one_work+0x7f9/0x1740
[  168.240058]  #1: ffffc9000403fe00 ((work_completion)(&queue->release_work)){+.+.}, at: process_one_work+0x82d/0x1740
[  168.253205] 
[  168.253205] stack backtrace:
[  168.260685] CPU: 2 PID: 141 Comm: kworker/2:1 Not tainted 5.6.0-rc4 #2
[  168.269346] Hardware name: Dell Inc. PowerEdge R320/0KM5PX, BIOS 2.7.0 08/19/2019
[  168.279143] Workqueue: events nvmet_rdma_release_queue_work [nvmet_rdma]
[  168.288059] Call Trace:
[  168.292229]  dump_stack+0x96/0xe0
[  168.297373]  check_noncircular+0x356/0x410
[  168.303372]  ? ftrace_caller_op_ptr+0xe/0xe
[  168.309444]  ? print_circular_bug.isra.40+0x1e0/0x1e0
[  168.316482]  ? unwind_next_frame+0x1c5/0x1bb0
[  168.322765]  ? ret_from_fork+0x3a/0x50
[  168.328372]  ? perf_trace_lock_acquire+0x630/0x630
[  168.335165]  ? mark_lock+0xbe/0x1130
[  168.340545]  ? nvmet_rdma_release_queue_work+0xcc/0x390 [nvmet_rdma]
[  168.349120]  __lock_acquire+0x2313/0x3d90
[  168.355086]  ? ret_from_fork+0x3a/0x50
[  168.360701]  ? lockdep_hardirqs_on+0x570/0x570
[  168.367151]  ? stack_trace_save+0x8a/0xb0
[  168.373093]  ? stack_trace_consume_entry+0x160/0x160
[  168.380122]  lock_acquire+0x15a/0x3c0
[  168.385648]  ? rdma_destroy_id+0x108/0xc70 [rdma_cm]
[  168.392633]  __mutex_lock+0x13e/0x1420
[  168.398287]  ? rdma_destroy_id+0x108/0xc70 [rdma_cm]
[  168.405298]  ? sched_clock+0x5/0x10
[  168.410614]  ? rdma_destroy_id+0x108/0xc70 [rdma_cm]
[  168.417582]  ? find_held_lock+0x3a/0x1c0
[  168.423452]  ? mutex_lock_io_nested+0x12a0/0x12a0
[  168.430200]  ? mark_lock+0xbe/0x1130
[  168.435644]  ? mark_held_locks+0x78/0x130
[  168.441569]  ? _raw_spin_unlock_irqrestore+0x3e/0x50
[  168.448574]  ? rdma_destroy_id+0x108/0xc70 [rdma_cm]
[  168.455564]  rdma_destroy_id+0x108/0xc70 [rdma_cm]
[  168.462344]  nvmet_rdma_release_queue_work+0xcc/0x390 [nvmet_rdma]
[  168.470665]  process_one_work+0x920/0x1740
[  168.476651]  ? pwq_dec_nr_in_flight+0x2d0/0x2d0
[  168.483200]  worker_thread+0x87/0xb40
[  168.488751]  ? __kthread_parkme+0xc3/0x190
[  168.494769]  ? process_one_work+0x1740/0x1740
[  168.501104]  kthread+0x333/0x400
[  168.506157]  ? kthread_create_on_node+0xc0/0xc0
[  168.512619]  ret_from_fork+0x3a/0x50
[  168.523833] ==================================================================
[  168.533446] BUG: KASAN: use-after-free in qed_chain_free+0x6d2/0x7f0 [qed]
[  168.542658] Read of size 8 at addr ffff88823b8dd000 by task kworker/2:1/141
[  168.551970] 
[  168.555135] CPU: 2 PID: 141 Comm: kworker/2:1 Not tainted 5.6.0-rc4 #2
[  168.563922] Hardware name: Dell Inc. PowerEdge R320/0KM5PX, BIOS 2.7.0 08/19/2019
[  168.573747] Workqueue: events nvmet_rdma_release_queue_work [nvmet_rdma]
[  168.582718] Call Trace:
[  168.586936]  dump_stack+0x96/0xe0
[  168.592134]  ? qed_chain_free+0x6d2/0x7f0 [qed]
[  168.598635]  print_address_description.constprop.6+0x1b/0x220
[  168.606500]  ? qed_chain_free+0x6d2/0x7f0 [qed]
[  168.613049]  ? qed_chain_free+0x6d2/0x7f0 [qed]
[  168.619527]  __kasan_report.cold.9+0x37/0x77
[  168.625793]  ? qed_chain_free+0x6d2/0x7f0 [qed]
[  168.632309]  kasan_report+0xe/0x20
[  168.637576]  qed_chain_free+0x6d2/0x7f0 [qed]
[  168.643913]  ? __kasan_slab_free+0x13a/0x170
[  168.650140]  ? qed_hw_remove+0x2b0/0x2b0 [qed]
[  168.656527]  qedr_cleanup_kernel+0xbf/0x420 [qedr]
[  168.663339]  ? qed_rdma_modify_srq+0x3c0/0x3c0 [qed]
[  168.670321]  ? qed_rdma_modify_srq+0x3c0/0x3c0 [qed]
[  168.677273]  qedr_destroy_qp+0x2b0/0x670 [qedr]
[  168.683714]  ? qedr_query_qp+0x1300/0x1300 [qedr]
[  168.690368]  ? _raw_spin_unlock_irq+0x24/0x30
[  168.696614]  ? wait_for_completion+0xc2/0x3d0
[  168.702877]  ? wait_for_completion_interruptible+0x440/0x440
[  168.710616]  ib_destroy_qp_user+0x2ba/0x6c0 [ib_core]
[  168.717630]  ? nvmet_rdma_release_queue_work+0xcc/0x390 [nvmet_rdma]
[  168.726186]  nvmet_rdma_release_queue_work+0xd6/0x390 [nvmet_rdma]
[  168.734511]  process_one_work+0x920/0x1740
[  168.740492]  ? pwq_dec_nr_in_flight+0x2d0/0x2d0
[  168.746992]  worker_thread+0x87/0xb40
[  168.752524]  ? __kthread_parkme+0xc3/0x190
[  168.758547]  ? process_one_work+0x1740/0x1740
[  168.764890]  kthread+0x333/0x400
[  168.769952]  ? kthread_create_on_node+0xc0/0xc0
[  168.776445]  ret_from_fork+0x3a/0x50
[  168.781870] 
[  168.784929] Allocated by task 802:
[  168.790166]  save_stack+0x19/0x80
[  168.795248]  __kasan_kmalloc.constprop.11+0xc1/0xd0
[  168.802127]  kmem_cache_alloc+0xf9/0x370
[  168.807931]  getname_flags+0xba/0x510
[  168.813388]  user_path_at_empty+0x1d/0x40
[  168.819250]  do_faccessat+0x21f/0x610
[  168.824700]  do_syscall_64+0x9f/0x4f0
[  168.830184]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
[  168.837191] 
[  168.840197] Freed by task 802:
[  168.844919]  save_stack+0x19/0x80
[  168.849914]  __kasan_slab_free+0x125/0x170
[  168.855758]  kmem_cache_free+0xcd/0x3c0
[  168.861291]  filename_lookup.part.63+0x1e7/0x330
[  168.867662]  do_faccessat+0x21f/0x610
[  168.872961]  do_syscall_64+0x9f/0x4f0
[  168.878246]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
[  168.885124] 
[  168.887977] The buggy address belongs to the object at ffff88823b8dc400
[  168.887977]  which belongs to the cache names_cache of size 4096
[  168.904533] The buggy address is located 3072 bytes inside of
[  168.904533]  4096-byte region [ffff88823b8dc400, ffff88823b8dd400)
[  168.920388] The buggy address belongs to the page:
[  168.927046] page:ffffea0008ee3600 refcount:1 mapcount:0 mapping:ffff888107fe5280 index:0x0 compound_mapcount: 0
[  168.939650] flags: 0x17ffffc0010200(slab|head)
[  168.945986] raw: 0017ffffc0010200 dead000000000100 dead000000000122 ffff888107fe5280
[  168.956074] raw: 0000000000000000 0000000000070007 00000001ffffffff 0000000000000000
[  168.966185] page dumped because: kasan: bad access detected
[  168.973835] 
[  168.976923] Memory state around the buggy address:
[  168.983705]  ffff88823b8dcf00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
[  168.993270]  ffff88823b8dcf80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
[  169.002799] >ffff88823b8dd000: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
[  169.012337]                    ^
[  169.017384]  ffff88823b8dd080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
[  169.026938]  ffff88823b8dd100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
[  169.036457] ==================================================================
[  169.183961] nvmet: creating controller 1 for subsystem testnqn for NQN nqn.2014-08.org.nvmexpress:uuid:5cf10916-b4ca-45cd-956c-ab680ec3e636.


Best Regards,
  Yi Zhang



_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
