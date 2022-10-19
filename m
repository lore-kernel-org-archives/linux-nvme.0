Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B95FC433FE
	for <linux-nvme@archiver.kernel.org>; Wed, 19 Oct 2022 11:35:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=CmlJsy56cj7/Duaau+83u2vzMrm9cISK3cANFBlUf7Q=; b=QEWrfe9w8jsp9ZZzCTDRBpxRqC
	NQmCIvARf9KZB++PE9pyZ1pfGBZwIyiceMeOgUCbN60cWQIMYYAkkqbrlshV9sWNTAXAR4O0r5UHT
	F/W/ouCFyw4OudnQBoq1Mbvm6LeKRP22r4e4YZG7D8jYTwRchviCo3QFfxKexl2gd6dKiHRlEhODQ
	eFWLNBQZQ+doT7hnmGiiFxZO/CVgQa7fKzGVeQZm3Kmx05w3VenLvwhXdptgeG3pXE9UCy4VBAscy
	iFgm8cJR7lg1/SxvXNkv/RCu4xqBjOI7Vj+lBm+TIY2YMGWsmnRvJDd0Ag5zxqA/o/v4ngqgPdns6
	fqOW7EcA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ol7M2-000uyY-T7; Wed, 19 Oct 2022 11:35:22 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ol7Lz-000uy6-Lf
	for linux-nvme@lists.infradead.org; Wed, 19 Oct 2022 11:35:21 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E521120466;
	Wed, 19 Oct 2022 11:35:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1666179317; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CmlJsy56cj7/Duaau+83u2vzMrm9cISK3cANFBlUf7Q=;
	b=wHkhi9lifw6HGZVPjQlSC6uv/aNs7P4QG7oStD85lCBn/4ED1eVo2mGkFtkENcmVqQcUBb
	SN+rP39Q2e0QJDhJzytvuL+Bz62+ptrPYqRNZspLP/A2K7IinrwMtAusS5WWQ7UHlvYgd0
	2Y0zrMlr5FAyYDJp9KXRfmd1NRBxSjg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1666179317;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CmlJsy56cj7/Duaau+83u2vzMrm9cISK3cANFBlUf7Q=;
	b=gspf4mNauiYuiCt/qJyyryuruu+WeUd0AH8vDM9lpgUcLjUQC3MuC7GV6UroN5WzRk3Ff7
	e3MRG2kfvnx1vvDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D6BA313A36;
	Wed, 19 Oct 2022 11:35:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id TN1kNPXgT2OkSQAAMHmgww
	(envelope-from <dwagner@suse.de>); Wed, 19 Oct 2022 11:35:17 +0000
Date: Wed, 19 Oct 2022 13:35:17 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org
Subject: Re: lockdep warning: fs_reclaim_acquire vs tcp_sendpage
Message-ID: <20221019113517.wv27jqp7lyskfbqb@carbon.lan>
References: <20221019075138.ff2sfahovionh72v@carbon.lan>
 <c30b24b9-e80f-9e8a-5754-caa7dc7bfe8b@grimberg.me>
 <20221019093712.2d2g36wcwwcl7zat@carbon.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221019093712.2d2g36wcwwcl7zat@carbon.lan>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221019_043519_901043_7F749236 
X-CRM114-Status: GOOD (  17.80  )
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

On Wed, Oct 19, 2022 at 11:37:13AM +0200, Daniel Wagner wrote:
> > >    Possible unsafe locking scenario:
> > > 
> > >          CPU0                    CPU1
> > >          ----                    ----
> > >     lock(fs_reclaim);
> > >                                  lock(sk_lock-AF_INET-NVME);
> > >                                  lock(fs_reclaim);
> > >     lock(sk_lock-AF_INET-NVME);
> > 
> > Indeed. I see the issue.
> > kswapd is trying to swap out pages, but if someone were to delete
> > the controller (like in this case), sock_release -> tcp_disconnect
> > will alloc skb that may need to reclaim pages.
> > 
> > Two questions, the stack trace suggests that you are not using
> > nvme-mpath? is that the case?
> 
> This is with a multipath setup. The fio settings are pushing the limits
> of the VM (memory size) hence the kswap process kicking in.
> 
> > Given that we fail all inflight requests before we free the socket,
> > I don't expect for this to be truly circular...
> > 
> > I'm assuming that we'll need the below similar to nbd/iscsi:
> 
> Let me try this.

Still able to trigger though I figured out how I am able to
reproduce it:

 VM 4M memory, 8 vCPUs
 nvme target with at least 2 namespaces
 ns 1: fio read/write
 ns 2: swap space

 1) nvme connect-all
 2) nvme disconnect-all
 3) nvme connect-all
 4) swapon /dev/nvme0n4
 4) fio --rw=rw --name=test --filename=/dev/nvme1n1 --size=1G --direct=1 \
        --iodepth=32 --blocksize_range=4k-4M --numjobs=32 \
        --group_reporting --runtime=2m --time_based

 ======================================================
 WARNING: possible circular locking dependency detected
 6.0.0-rc2+ #27 Tainted: G        W         
 ------------------------------------------------------
 fio/1749 is trying to acquire lock:
 ffff888120b38140 (sk_lock-AF_INET-NVME){+.+.}-{0:0}, at: tcp_sendpage+0x23/0xa0
 
 but task is already holding lock:
 ffffffff93695b20 (fs_reclaim){+.+.}-{0:0}, at: __alloc_pages_slowpath.constprop.0+0x6a3/0x22f0
 
 which lock already depends on the new lock.

 
 the existing dependency chain (in reverse order) is:
 
 -> #1 (fs_reclaim){+.+.}-{0:0}:
        fs_reclaim_acquire+0x11e/0x160
        kmem_cache_alloc_node+0x44/0x530
        __alloc_skb+0x158/0x230
        tcp_send_active_reset+0x7e/0x730
        tcp_disconnect+0x1272/0x1ae0
        __tcp_close+0x707/0xd90
        tcp_close+0x26/0x80
        inet_release+0xfa/0x220
        sock_release+0x85/0x1a0
        nvme_tcp_free_queue+0x1fd/0x470 [nvme_tcp]
        nvme_do_delete_ctrl+0x130/0x13d [nvme_core]
        nvme_sysfs_delete.cold+0x8/0xd [nvme_core]
        kernfs_fop_write_iter+0x356/0x530
        vfs_write+0x4e8/0xce0
        ksys_write+0xfd/0x1d0
        do_syscall_64+0x58/0x80
        entry_SYSCALL_64_after_hwframe+0x63/0xcd
 
 -> #0 (sk_lock-AF_INET-NVME){+.+.}-{0:0}:
        __lock_acquire+0x2a0c/0x5690
        lock_acquire+0x18e/0x4f0
        lock_sock_nested+0x37/0xc0
        tcp_sendpage+0x23/0xa0
        inet_sendpage+0xad/0x120
        kernel_sendpage+0x156/0x440
        nvme_tcp_try_send+0x59e/0x27a0 [nvme_tcp]
        nvme_tcp_queue_rq+0xf5e/0x1870 [nvme_tcp]
        __blk_mq_try_issue_directly+0x452/0x660
        blk_mq_plug_issue_direct.constprop.0+0x207/0x700
        blk_mq_flush_plug_list+0x6f5/0xc70
        __blk_flush_plug+0x264/0x410
        blk_finish_plug+0x4b/0xa0
        shrink_lruvec+0x1263/0x1ea0
        shrink_node+0x736/0x1a80
        do_try_to_free_pages+0x2ba/0x15e0
        try_to_free_pages+0x20b/0x580
        __alloc_pages_slowpath.constprop.0+0x744/0x22f0
        __alloc_pages+0x42a/0x500
        __folio_alloc+0x17/0x50
        vma_alloc_folio+0xbd/0x4d0
        __handle_mm_fault+0x1170/0x2380
        handle_mm_fault+0x1d6/0x710
        do_user_addr_fault+0x320/0xdc0
        exc_page_fault+0x61/0xf0
        asm_exc_page_fault+0x22/0x30
 
 other info that might help us debug this:

  Possible unsafe locking scenario:

        CPU0                    CPU1
        ----                    ----
   lock(fs_reclaim);
                                lock(sk_lock-AF_INET-NVME);
                                lock(fs_reclaim);
   lock(sk_lock-AF_INET-NVME);
 
  *** DEADLOCK ***

 4 locks held by fio/1749:
  #0: ffff8881251f62b8 (&mm->mmap_lock#2){++++}-{3:3}, at: do_user_addr_fault+0x1e3/0xdc0
  #1: ffffffff93695b20 (fs_reclaim){+.+.}-{0:0}, at: __alloc_pages_slowpath.constprop.0+0x6a3/0x22f0
  #2: ffff8881087cb0b0 (q->srcu){....}-{0:0}, at: blk_mq_flush_plug_list+0x6b3/0xc70
  #3: ffff888124e543d0 (&queue->send_mutex){+.+.}-{3:3}, at: nvme_tcp_queue_rq+0xec1/0x1870 [nvme_tcp]
 
 stack backtrace:
 CPU: 0 PID: 1749 Comm: fio Tainted: G        W          6.0.0-rc2+ #27 f927f62e1062089b9e698ced355fcf5ecf276cb2
 Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 0.0.0 02/06/2015
 Call Trace:
  <TASK>
  dump_stack_lvl+0x5b/0x77
  check_noncircular+0x26e/0x320
  ? print_circular_bug+0x1e0/0x1e0
  ? kvm_sched_clock_read+0x14/0x40
  ? sched_clock_cpu+0x69/0x240
  ? lockdep_lock+0x18a/0x1c0
  ? call_rcu_zapped+0xc0/0xc0
  __lock_acquire+0x2a0c/0x5690
  ? lockdep_hardirqs_on_prepare+0x3f0/0x3f0
  ? lock_chain_count+0x20/0x20
  ? mark_lock+0x101/0x1650
  lock_acquire+0x18e/0x4f0
  ? tcp_sendpage+0x23/0xa0
  ? sched_clock_cpu+0x69/0x240
  ? lock_downgrade+0x6c0/0x6c0
  ? __lock_acquire+0xd3f/0x5690
  lock_sock_nested+0x37/0xc0
  ? tcp_sendpage+0x23/0xa0
  tcp_sendpage+0x23/0xa0
  inet_sendpage+0xad/0x120
  kernel_sendpage+0x156/0x440
  nvme_tcp_try_send+0x59e/0x27a0 [nvme_tcp 154cb4fe55d74667e1ca60e2a90f260935f9e2bd]
  ? lock_downgrade+0x6c0/0x6c0
  ? lock_release+0x6cd/0xd30
  ? nvme_tcp_state_change+0x150/0x150 [nvme_tcp 154cb4fe55d74667e1ca60e2a90f260935f9e2bd]
  ? mutex_trylock+0x204/0x330
  ? nvme_tcp_queue_rq+0xec1/0x1870 [nvme_tcp 154cb4fe55d74667e1ca60e2a90f260935f9e2bd]
  ? ww_mutex_unlock+0x270/0x270
  nvme_tcp_queue_rq+0xf5e/0x1870 [nvme_tcp 154cb4fe55d74667e1ca60e2a90f260935f9e2bd]
  __blk_mq_try_issue_directly+0x452/0x660
  ? __blk_mq_get_driver_tag+0x980/0x980
  ? lock_downgrade+0x6c0/0x6c0
  blk_mq_plug_issue_direct.constprop.0+0x207/0x700
  blk_mq_flush_plug_list+0x6f5/0xc70
  ? blk_mq_flush_plug_list+0x6b3/0xc70
  ? set_next_task_stop+0x1c0/0x1c0
  ? blk_mq_insert_requests+0x450/0x450
  ? lock_release+0x6cd/0xd30
  __blk_flush_plug+0x264/0x410
  ? memset+0x1f/0x40
  ? __mem_cgroup_uncharge_list+0x84/0x150
  ? __mem_cgroup_uncharge+0x140/0x140
  ? blk_start_plug_nr_ios+0x280/0x280
  blk_finish_plug+0x4b/0xa0
  shrink_lruvec+0x1263/0x1ea0
  ? reclaim_throttle+0x790/0x790
  ? sched_clock_cpu+0x69/0x240
  ? lockdep_hardirqs_on_prepare+0x3f0/0x3f0
  ? lock_is_held_type+0xa9/0x120
  ? mem_cgroup_iter+0x2b2/0x780
  shrink_node+0x736/0x1a80
  do_try_to_free_pages+0x2ba/0x15e0
  ? __node_reclaim+0x7c0/0x7c0
  ? lock_is_held_type+0xa9/0x120
  ? lock_is_held_type+0xa9/0x120
  try_to_free_pages+0x20b/0x580
  ? reclaim_pages+0x5b0/0x5b0
  ? psi_task_change+0x2f0/0x2f0
  __alloc_pages_slowpath.constprop.0+0x744/0x22f0
  ? get_page_from_freelist+0x3bf/0x3920
  ? warn_alloc+0x190/0x190
  ? io_schedule_timeout+0x160/0x160
  ? __zone_watermark_ok+0x420/0x420
  ? preempt_schedule_common+0x44/0x70
  ? __cond_resched+0x1c/0x30
  ? prepare_alloc_pages.constprop.0+0x150/0x4c0
  ? lock_chain_count+0x20/0x20
  __alloc_pages+0x42a/0x500
  ? __alloc_pages_slowpath.constprop.0+0x22f0/0x22f0
  ? set_next_task_stop+0x1c0/0x1c0
  __folio_alloc+0x17/0x50
  vma_alloc_folio+0xbd/0x4d0
  ? sched_clock_cpu+0x69/0x240
  __handle_mm_fault+0x1170/0x2380
  ? copy_page_range+0x2ae0/0x2ae0
  ? lockdep_hardirqs_on_prepare+0x27b/0x3f0
  ? count_memcg_events.constprop.0+0x40/0x50
  handle_mm_fault+0x1d6/0x710
  do_user_addr_fault+0x320/0xdc0
  exc_page_fault+0x61/0xf0
  asm_exc_page_fault+0x22/0x30
 RIP: 0033:0x55d6818eee0e
 Code: 48 89 54 24 18 48 01 c2 48 89 54 24 20 48 8d 14 80 48 89 54 24 28 48 39 f1 74 38 90 66 41 0f 6f 01 66 41 0f 6f 49 10 4c 89 c8 <0f> 11 01 0f 11 49 10 48 8b 10 48 83 c0 08 48 0f af d7 48 89 50 f8
 RSP: 002b:00007ffdc1100e30 EFLAGS: 00010206
 RAX: 00007ffdc1100e40 RBX: 81b4c40bf7ec8b20 RCX: 00007f16bb429000
 RDX: 5709bcafa91b77a0 RSI: 00007f16bb6d4000 RDI: 61c8864680b583eb
 RBP: 0000000000000013 R08: 00007ffdc1100e60 R09: 00007ffdc1100e40
 R10: 0000000000400000 R11: 0000000000000246 R12: 0000000000400000
 R13: 0000000000000001 R14: 000055d681d52540 R15: 00007f16bb2d4000
  </TASK>

