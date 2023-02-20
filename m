Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08D4CC636CC
	for <linux-nvme@archiver.kernel.org>; Mon, 20 Feb 2023 16:04:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+vGeogeyY89Vv4e7/xL3WBE9wqCTwOc2OZ6Xph1PLlg=; b=Ujm8nPWcjCNl8RcW0OhYka/3Wd
	u5SIwjbPxeF6X9ym7KOWSeWVJcr7eiA7GVyKJSIl9XZt0YLc2albBxOqghhBx4F0GjyCyJa9GOZEm
	V1dkh021o4DarDB6d/u3jhP2tLGdNyZbm87/HFx71F9REr48T9sgGW5g3VW35Sfem65Zjj4mFerlV
	t5G9sKFZ4W2Np4p7VTyuSI29WE6W45ndi+5yLejqa9rWjsymXDLHns7BBNap3qgqEiril4a/9ae8I
	w98WgTmJUiWHnM9Zcj7CV45r98h3DSMP2MiEJx1Ni0qk8DkMXjnpSe2ExsaTW+jC3K9zJKmh7lvvr
	NX/DWCaA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pU8eN-004pXf-Uc; Mon, 20 Feb 2023 16:04:23 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pU8eL-004pWM-5V
	for linux-nvme@lists.infradead.org; Mon, 20 Feb 2023 16:04:22 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 4EC4F22A0D;
	Mon, 20 Feb 2023 16:04:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1676909056; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+vGeogeyY89Vv4e7/xL3WBE9wqCTwOc2OZ6Xph1PLlg=;
	b=vWo9X4etCGUiV8PuPUIdrbJ6dfL3ye9QHmYREMbL4qWiqznDNcSkRnqJe9oT6aetxXAMmS
	r4lkH0mRnEJpbDiAKGClh2OLDktQSoOHt+UXsVE4abR6MGj5Jk2YifVCgBLycOVHOegQG0
	2GT2pTSg5Uy1pEmodoAk9Op+Tg3SrEY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1676909056;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+vGeogeyY89Vv4e7/xL3WBE9wqCTwOc2OZ6Xph1PLlg=;
	b=BygNKfoZQD9n5Pqw78I35sBhKzPvAzUWOrIblFZpmuXqCADPU9kElBhAbFLqxMB8Hjq4ti
	qk2t2xCGdIPB+cAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 406C1139DB;
	Mon, 20 Feb 2023 16:04:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id S72zDwCa82OTZwAAMHmgww
	(envelope-from <dwagner@suse.de>); Mon, 20 Feb 2023 16:04:16 +0000
Date: Mon, 20 Feb 2023 17:04:15 +0100
From: Daniel Wagner <dwagner@suse.de>
To: James Smart <jsmart2021@gmail.com>
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	Hannes Reinecke <hare@suse.de>, Ming Lei <ming.lei@redhat.com>
Subject: Re: nvme-6.3: blktests nvme/003 null pointer for fc transport
Message-ID: <20230220160415.q6y5hnr44skx6lbo@carbon.lan>
References: <20230130111532.ez63iip4qxrh42ga@carbon.lan>
 <40b14fe4-7d7f-b4ee-b058-d0d39b9fa6d4@gmail.com>
 <20230201081003.a6l22z3rnl6snkds@carbon.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230201081003.a6l22z3rnl6snkds@carbon.lan>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230220_080421_393176_54105A8E 
X-CRM114-Status: GOOD (  12.14  )
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

On Wed, Feb 01, 2023 at 09:10:03AM +0100, Daniel Wagner wrote:
> nvme_fcloop: fcloop_exit: Failed deleting target port
> nvme_fcloop: fcloop_exit: Failed deleting remote port
> nvme_fcloop: fcloop_exit: Failed deleting target port
> nvme_fcloop: fcloop_exit: Failed deleting remote port
> nvme_fcloop: fcloop_exit: Failed deleting target port
> nvme_fcloop: fcloop_exit: Failed deleting remote port

I've retested with v6.2.0 with

--- a/drivers/nvme/target/fcloop.c
+++ b/drivers/nvme/target/fcloop.c
@@ -1607,6 +1607,11 @@ static void __exit fcloop_exit(void)
                tport = __unlink_target_port(nport);
                rport = __unlink_remote_port(nport);

+                if (!tport && !rport) {
+                        pr_warn("%s: target port and remote port have already been freed\n", __func__);
+                        break;
+                }
+
                spin_unlock_irqrestore(&fcloop_lock, flags);

                ret = __targetport_unreg(nport, tport);

but I was not able to trigger it anymore. My guess is

0cab4404874f ("nvme-fc: fix a missing queue put in nvmet_fc_ls_create_association")

fixed the problem.

Though I run into a lockdep warning:


 ================================
 WARNING: inconsistent lock state
 6.2.0+ #4 Not tainted
 --------------------------------
 inconsistent {IN-HARDIRQ-W} -> {HARDIRQ-ON-W} usage.
 ksoftirqd/1/23 [HC0[0]:SC1[1]:HE0:SE0] takes:
 ffff88817e63a160 (&fq->mq_flush_lock){?.-.}-{2:2}, at: flush_end_io+0x69/0x460
 {IN-HARDIRQ-W} state was registered at:
   lock_acquire+0x128/0x270
   _raw_spin_lock_irqsave+0x55/0x90
   flush_end_io+0x69/0x460
   __blk_mq_end_request+0x16c/0x190
   virtblk_done+0x12e/0x220 [virtio_blk]
   vring_interrupt+0xc0/0x140
   __handle_irq_event_percpu+0x10c/0x230
   handle_irq_event+0x4e/0xb0
   handle_edge_irq+0x14a/0x3f0
   __common_interrupt+0x8a/0x120
   common_interrupt+0x7b/0x90
   asm_common_interrupt+0x22/0x40
   native_safe_halt+0xb/0x10
   default_idle+0xa/0x10
   default_idle_call+0x70/0xc0
   do_idle+0x185/0x450
   cpu_startup_entry+0x25/0x30
   start_secondary+0xbd/0xc0
   secondary_startup_64_no_verify+0xe6/0xeb
 irq event stamp: 781843
 hardirqs last  enabled at (781842): [<ffffffff8e69f6a1>] seqcount_lockdep_reader_access+0x91/0xa0
 hardirqs last disabled at (781843): [<ffffffff8f99ca0c>] _raw_spin_lock_irqsave+0x2c/0x90
 softirqs last  enabled at (781834): [<ffffffff8e52b143>] run_ksoftirqd+0x33/0x70
 softirqs last disabled at (781839): [<ffffffff8e52b143>] run_ksoftirqd+0x33/0x70

 other info that might help us debug this:
  Possible unsafe locking scenario:

        CPU0
        ----
   lock(&fq->mq_flush_lock);
   <Interrupt>
     lock(&fq->mq_flush_lock);

  *** DEADLOCK ***

 1 lock held by ksoftirqd/1/23:
  #0: ffff88817e63a160 (&fq->mq_flush_lock){?.-.}-{2:2}, at: flush_end_io+0x69/0x460

 stack backtrace:
 CPU: 1 PID: 23 Comm: ksoftirqd/1 Kdump: loaded Not tainted 6.2.0+ #4 7ac3eece8c11633fa2815efb5a20b1c5b55011f5
 Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 0.0.0 02/06/2015
 Call Trace:
  <TASK>
  dump_stack_lvl+0x5a/0x80
  print_usage_bug+0x6db/0x6f0
  ? print_lockdep_off+0x30/0x30
  ? pvclock_clocksource_read+0xec/0x180
  ? kvm_sched_clock_read+0x14/0x40
  ? sched_clock_cpu+0x6f/0x1f0
  ? rcu_read_lock_sched_held+0x34/0x70
  ? trace_irq_disable+0x47/0x110
  ? lockdep_hardirqs_on_prepare+0x17e/0x2e0
  ? mod_find+0x100/0x120
  ? nvmet_bio_done+0x37/0x180 [nvmet b6cfd0efddc3f6e687219ea59b5a92b951bb0ddd]
  ? nvmet_bio_done+0x37/0x180 [nvmet b6cfd0efddc3f6e687219ea59b5a92b951bb0ddd]
  ? __module_address+0xe1/0x100
  ? ftrace_graph_ret_addr+0x1d/0xa0
  ? orc_find+0x164/0x4f0
  ? pvclock_clocksource_read+0xec/0x180
  ? __update_load_avg_cfs_rq+0x34a/0x500
  ? kvm_sched_clock_read+0x14/0x40
  ? pvclock_clocksource_read+0xec/0x180
  ? kvm_sched_clock_read+0x14/0x40
  ? sched_clock_cpu+0x6f/0x1f0
  ? pvclock_clocksource_read+0xec/0x180
  ? mod_find+0x100/0x120
  ? nvmet_bio_done+0x37/0x180 [nvmet b6cfd0efddc3f6e687219ea59b5a92b951bb0ddd]
  ? nvmet_bio_done+0x37/0x180 [nvmet b6cfd0efddc3f6e687219ea59b5a92b951bb0ddd]
  ? __module_address+0xe1/0x100
  ? ftrace_graph_ret_addr+0x1d/0xa0
  ? orc_find+0x164/0x4f0
  ? unwind_next_frame+0xd55/0xd90
  ? ret_from_fork+0x1f/0x30
  ? stack_trace_save+0x130/0x130
  mark_lock_irq+0x7d0/0x7e0
  ? save_trace+0x4c0/0x4c0
  ? stack_trace_save+0xe0/0x130
  ? stack_trace_snprint+0xe0/0xe0
  ? lock_is_held_type+0x8b/0x110
  ? fcloop_fcp_op+0x92/0x310 [nvme_fcloop 103a43b51b136ed1b9f0be7fbf6a4787d9fa52e2]
  ? save_trace+0x447/0x4c0
  mark_lock+0x19c/0x220
  lockdep_hardirqs_on_prepare+0x169/0x2e0
  trace_hardirqs_on+0x34/0x40
  _raw_spin_unlock_irq+0x24/0x40
  fcloop_fcp_op+0x92/0x310 [nvme_fcloop 103a43b51b136ed1b9f0be7fbf6a4787d9fa52e2]
  ? fcloop_h2t_xmt_ls_rsp+0x150/0x150 [nvme_fcloop 103a43b51b136ed1b9f0be7fbf6a4787d9fa52e2]
  nvmet_fc_fcp_nvme_cmd_done+0x325/0x480 [nvmet_fc 14b6afa92b89f97b59495a77b43c19ce2c6642ff]
  __nvmet_req_complete+0x20e/0x270 [nvmet b6cfd0efddc3f6e687219ea59b5a92b951bb0ddd]
  ? nvmet_req_complete+0x30/0x30 [nvmet b6cfd0efddc3f6e687219ea59b5a92b951bb0ddd]
  nvmet_req_complete+0xe/0x30 [nvmet b6cfd0efddc3f6e687219ea59b5a92b951bb0ddd]
  nvmet_bio_done+0x38/0x180 [nvmet b6cfd0efddc3f6e687219ea59b5a92b951bb0ddd]
  blk_update_request+0x343/0x6a0
  blk_mq_end_request+0x22/0x40
  blk_flush_complete_seq+0x22b/0x530
  flush_end_io+0x424/0x460
  __blk_mq_end_request+0x16c/0x190
  blk_done_softirq+0x95/0xb0
  __do_softirq+0x14b/0x369
  ? run_ksoftirqd+0x33/0x70
  ? ksoftirqd_should_run+0x20/0x20
  run_ksoftirqd+0x33/0x70
  smpboot_thread_fn+0x294/0x390
  ? cpu_report_death+0x170/0x170
  kthread+0x16d/0x190
  ? kthread_blkcg+0x60/0x60
  ret_from_fork+0x1f/0x30
  </TASK>

It looks similar to the reports/fixes from here:

b3c6a5997541 ("block: Fix a lockdep complaint triggered by request queue flushing")
fb01a2932e81 ("blk-mq: add new API of blk_mq_hctx_set_fq_lock_class")

Daniel

