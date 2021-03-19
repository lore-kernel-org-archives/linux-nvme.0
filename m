Return-Path: <SRS0=D92Q=IR=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC7F8C433DB
	for <linux-nvme@archiver.kernel.org>; Fri, 19 Mar 2021 16:19:28 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A63661963
	for <linux-nvme@archiver.kernel.org>; Fri, 19 Mar 2021 16:19:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A63661963
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Subject:In-Reply-To:Message-ID:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:List-Owner;
	 bh=NJgDKJN7noUQNMSNo2p7spr5ODXEyMLD3P1a2Q3hlRE=; b=hCdXDb3wCrDBPYBJ4bZPlMDoI
	n1zSWBZjRX2ptJFuK132PT1/j3hZS9pRxWdicbhQP++VY+tIDjMoLrNRIzIQA3wVKJAYyJW8DjTIc
	Oy4iSpvegfGiCUp/qdVDYrgFSAYH9T7n4m1G0zTrQyuf+FO5bx3yTt6TptCXrrWkJWPasnwb2ijcO
	PGjxkTCtMUbnAXZ1ivn2Nix9mRQ8qI0hpiNmpuhjdWkLlJlWBTXUiaSbWqoeYTxFXM2YUk5i94Bjf
	eWX0akje++Dmg5AkWOiIndxapN3c5PvTgIKexnAkK2FI4zSnTzYwHbM/b+k96o5XTlWrjcYp2URR/
	PUPRLoAVQ==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lNHq8-007gKC-Py; Fri, 19 Mar 2021 16:19:08 +0000
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lNHpZ-007g95-LD
 for linux-nvme@lists.infradead.org; Fri, 19 Mar 2021 16:18:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1616170710;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:  in-reply-to:in-reply-to; 
 bh=COevceacjTqy12pGUpSi0ICcIlUjN4UMIhb1csDFEUs=;
 b=NeDWGSYQNWd23OXfm4hF3N6k5/PW3vFmZlC+3tiAEL+jE498jDKAuaN9d3GLaWQ7VSFwOP
 q8VZzAdRedp5yv2R5J0dI0zJlJ6HzPivPDyA9yEvPF0Efi/c/CubQ6MvsbYEcKwO7o5Y1R
 t97uVBQ9sYF597nJM+0JVXC57s5d/Pw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-9-HNicOsukPIKvObpkIMuq3Q-1; Fri, 19 Mar 2021 12:18:28 -0400
X-MC-Unique: HNicOsukPIKvObpkIMuq3Q-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 400E981744F;
 Fri, 19 Mar 2021 16:18:27 +0000 (UTC)
Received: from colo-mx.corp.redhat.com
 (colo-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.20])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 34B155D6D5;
 Fri, 19 Mar 2021 16:18:27 +0000 (UTC)
Received: from zmail25.collab.prod.int.phx2.redhat.com
 (zmail25.collab.prod.int.phx2.redhat.com [10.5.83.31])
 by colo-mx.corp.redhat.com (Postfix) with ESMTP id D57BE1809C81;
 Fri, 19 Mar 2021 16:18:26 +0000 (UTC)
Date: Fri, 19 Mar 2021 12:18:26 -0400 (EDT)
From: Yi Zhang <yi.zhang@redhat.com>
To: linux-nvme@lists.infradead.org
Cc: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <1378655048.19877042.1616170706639.JavaMail.zimbra@redhat.com>
In-Reply-To: <1608490616.19876870.1616170480157.JavaMail.zimbra@redhat.com>
Subject: [bug report] WARNING: inconsistent lock state observed with
 blktests nvme-tcp/003
MIME-Version: 1.0
X-Originating-IP: [10.68.5.41, 10.4.195.29]
Thread-Topic: WARNING: inconsistent lock state observed with blktests
 nvme-tcp/003
Thread-Index: nJ7akOGFpMzGgMBkFOtMZ8LbE3eyhw==
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=yizhan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Bad-Reply: In-Reply-To but no 'Re:' in Subject.
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210319_161833_847002_6C9D897F 
X-CRM114-Status: UNSURE (   7.78  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Hello

I met this inconsistent lock state issue with blktests nvme-tcp/003 on 5.12.0-rc3, pls help check it and let me know if you need any testing for it, thanks.

[  535.237592] run blktests nvme/003 at 2021-03-19 12:11:33
[  535.486784] loop: module loaded
[  535.520486] nvmet: adding nsid 1 to subsystem blktests-subsystem-1
[  535.528876] nvmet_tcp: enabling port 0 (127.0.0.1:4420)
[  535.576817] nvmet: creating controller 1 for subsystem nqn.2014-08.org.nvmexpress.discovery for NQN nqn.2014-08.org.nvmexpress:uuid:412ffcdbdfc94223bfc4a0d0d3746043.
[  535.579762] nvme nvme0: new ctrl: NQN "nqn.2014-08.org.nvmexpress.discovery", addr 127.0.0.1:4420
[  545.629877] nvme nvme0: Removing ctrl: NQN "nqn.2014-08.org.nvmexpress.discovery"

[  545.633180] ================================
[  545.637451] WARNING: inconsistent lock state
[  545.641726] 5.12.0-rc3 #1 Tainted: G          I      
[  545.646776] --------------------------------
[  545.651051] inconsistent {IN-SOFTIRQ-W} -> {SOFTIRQ-ON-R} usage.
[  545.657057] nvme/1324 [HC0[0]:SC0[0]:HE1:SE1] takes:
[  545.662021] ffff888363151000 (clock-AF_INET){++-?}-{2:2}, at: nvme_tcp_state_change+0x21/0x150 [nvme_tcp]
[  545.671588] {IN-SOFTIRQ-W} state was registered at:
[  545.676469]   __lock_acquire+0x79b/0x18d0
[  545.680479]   lock_acquire+0x1ca/0x480
[  545.684233]   _raw_write_lock_bh+0x39/0x80
[  545.688333]   nvmet_tcp_state_change+0x21/0x170 [nvmet_tcp]
[  545.693905]   tcp_fin+0x2a8/0x780
[  545.697223]   tcp_data_queue+0xf94/0x1f20
[  545.701237]   tcp_rcv_established+0x6ba/0x1f00
[  545.705683]   tcp_v4_do_rcv+0x502/0x760
[  545.709522]   tcp_v4_rcv+0x257e/0x3430
[  545.713274]   ip_protocol_deliver_rcu+0x69/0x6a0
[  545.717894]   ip_local_deliver_finish+0x1e2/0x2f0
[  545.722598]   ip_local_deliver+0x1a2/0x420
[  545.726699]   ip_rcv+0x4fb/0x6b0
[  545.729932]   __netif_receive_skb_one_core+0x162/0x1b0
[  545.735068]   process_backlog+0x1ff/0x770
[  545.739084]   __napi_poll.constprop.0+0xa9/0x5c0
[  545.743703]   net_rx_action+0x7b3/0xb30
[  545.747541]   __do_softirq+0x1f0/0x940
[  545.751293]   do_softirq+0xa1/0xd0
[  545.754699]   __local_bh_enable_ip+0xd8/0x100
[  545.759057]   ip_finish_output2+0x6b7/0x18a0
[  545.763331]   __ip_queue_xmit+0x706/0x1aa0
[  545.767432]   __tcp_transmit_skb+0x2068/0x2e20
[  545.771875]   tcp_write_xmit+0xc9e/0x2bb0
[  545.775888]   __tcp_push_pending_frames+0x92/0x310
[  545.780681]   inet_shutdown+0x158/0x300
[  545.784520]   __nvme_tcp_stop_queue+0x36/0x270 [nvme_tcp]
[  545.789918]   nvme_tcp_stop_queue+0x87/0xb0 [nvme_tcp]
[  545.795058]   nvme_tcp_teardown_admin_queue+0x69/0xe0 [nvme_tcp]
[  545.801066]   nvme_do_delete_ctrl+0x100/0x10c [nvme_core]
[  545.806472]   nvme_sysfs_delete.cold+0x8/0xd [nvme_core]
[  545.811793]   kernfs_fop_write_iter+0x2c7/0x460
[  545.816326]   new_sync_write+0x36c/0x610
[  545.820250]   vfs_write+0x5c0/0x870
[  545.823744]   ksys_write+0xf9/0x1d0
[  545.827236]   do_syscall_64+0x33/0x40
[  545.830902]   entry_SYSCALL_64_after_hwframe+0x44/0xae
[  545.836041] irq event stamp: 10687
[  545.839448] hardirqs last  enabled at (10687): [<ffffffff9ec376bd>] _raw_spin_unlock_irqrestore+0x2d/0x40
[  545.849008] hardirqs last disabled at (10686): [<ffffffff9ec374d8>] _raw_spin_lock_irqsave+0x68/0x90
[  545.858132] softirqs last  enabled at (10684): [<ffffffff9f000608>] __do_softirq+0x608/0x940
[  545.866565] softirqs last disabled at (10649): [<ffffffff9cdedd31>] do_softirq+0xa1/0xd0
[  545.874650] 
               other info that might help us debug this:
[  545.881176]  Possible unsafe locking scenario:

[  545.887094]        CPU0
[  545.889547]        ----
[  545.891999]   lock(clock-AF_INET);
[  545.895407]   <Interrupt>
[  545.898031]     lock(clock-AF_INET);
[  545.901612] 
                *** DEADLOCK ***

[  545.907531] 5 locks held by nvme/1324:
[  545.911282]  #0: ffff8884a01fe470 (sb_writers#4){.+.+}-{0:0}, at: ksys_write+0xf9/0x1d0
[  545.919292]  #1: ffff8886e435c090 (&of->mutex){+.+.}-{3:3}, at: kernfs_fop_write_iter+0x216/0x460
[  545.928165]  #2: ffff888104d90c38 (kn->active#255){++++}-{0:0}, at: kernfs_remove_self+0x22d/0x330
[  545.937126]  #3: ffff8884634538d0 (&queue->queue_lock){+.+.}-{3:3}, at: nvme_tcp_stop_queue+0x52/0xb0 [nvme_tcp]
[  545.947301]  #4: ffff888363150d30 (sk_lock-AF_INET){+.+.}-{0:0}, at: inet_shutdown+0x59/0x300
[  545.955827] 
               stack backtrace:
[  545.960188] CPU: 26 PID: 1324 Comm: nvme Tainted: G          I       5.12.0-rc3 #1
[  545.967752] Hardware name: Dell Inc. PowerEdge R640/06NR82, BIOS 2.10.0 11/12/2020
[  545.975320] Call Trace:
[  545.977773]  dump_stack+0x93/0xc2
[  545.981093]  mark_lock_irq.cold+0x2c/0xb3
[  545.985105]  ? verify_lock_unused+0x390/0x390
[  545.989463]  ? stack_trace_consume_entry+0x160/0x160
[  545.994427]  ? lock_downgrade+0x100/0x100
[  545.998443]  ? save_trace+0x88/0x5e0
[  546.002021]  ? _raw_spin_unlock_irqrestore+0x2d/0x40
[  546.006987]  mark_lock+0x530/0x1470
[  546.010478]  ? mark_lock_irq+0x1d10/0x1d10
[  546.014579]  ? enqueue_timer+0x660/0x660
[  546.018506]  mark_usage+0x215/0x2a0
[  546.021996]  __lock_acquire+0x79b/0x18d0
[  546.025925]  ? tcp_schedule_loss_probe.part.0+0x38c/0x520
[  546.031321]  lock_acquire+0x1ca/0x480
[  546.034987]  ? nvme_tcp_state_change+0x21/0x150 [nvme_tcp]
[  546.040475]  ? rcu_read_unlock+0x40/0x40
[  546.044400]  ? tcp_mtu_probe+0x1ae0/0x1ae0
[  546.048499]  ? kmalloc_reserve+0xa0/0xa0
[  546.052425]  ? sysfs_file_ops+0x170/0x170
[  546.056436]  _raw_read_lock+0x3d/0xa0
[  546.060101]  ? nvme_tcp_state_change+0x21/0x150 [nvme_tcp]
[  546.065587]  nvme_tcp_state_change+0x21/0x150 [nvme_tcp]
[  546.070901]  ? sysfs_file_ops+0x170/0x170
[  546.074911]  inet_shutdown+0x189/0x300
[  546.078665]  __nvme_tcp_stop_queue+0x36/0x270 [nvme_tcp]
[  546.083980]  nvme_tcp_stop_queue+0x87/0xb0 [nvme_tcp]
[  546.089032]  nvme_tcp_teardown_admin_queue+0x69/0xe0 [nvme_tcp]
[  546.094950]  nvme_do_delete_ctrl+0x100/0x10c [nvme_core]
[  546.100270]  nvme_sysfs_delete.cold+0x8/0xd [nvme_core]
[  546.105506]  kernfs_fop_write_iter+0x2c7/0x460
[  546.109952]  new_sync_write+0x36c/0x610
[  546.113790]  ? new_sync_read+0x600/0x600
[  546.117716]  ? lock_acquire+0x1ca/0x480
[  546.121556]  ? rcu_read_unlock+0x40/0x40
[  546.125484]  ? lock_is_held_type+0x9a/0x110
[  546.129668]  vfs_write+0x5c0/0x870
[  546.133073]  ksys_write+0xf9/0x1d0
[  546.136480]  ? __ia32_sys_read+0xa0/0xa0
[  546.140404]  ? lockdep_hardirqs_on_prepare.part.0+0x198/0x340
[  546.146150]  ? syscall_enter_from_user_mode+0x27/0x70
[  546.151203]  do_syscall_64+0x33/0x40
[  546.154782]  entry_SYSCALL_64_after_hwframe+0x44/0xae
[  546.159834] RIP: 0033:0x7f378d530917
[  546.163413] Code: 0d 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b7 0f 1f 00 f3 0f 1e fa 64 8b 04 25 18 00 00 00 85 c0 75 10 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 51 c3 48 83 ec 28 48 89 54 24 18 48 89 74 24
[  546.182159] RSP: 002b:00007ffea3704d58 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
[  546.189725] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f378d530917
[  546.196856] RDX: 0000000000000001 RSI: 000055b42515daef RDI: 0000000000000004
[  546.203991] RBP: 0000000000000004 R08: 000055b42515b530 R09: 00007ffea3704e80
[  546.211120] R10: 0000000000000000 R11: 0000000000000246 R12: 000055b425398f40
[  546.218253] R13: 000055b42515d31e R14: 000055b42515eca2 R15: 00007ffea3704dc0



Best Regards,
  Yi Zhang



_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
