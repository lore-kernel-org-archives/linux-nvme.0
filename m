Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6337AC433FE
	for <linux-nvme@archiver.kernel.org>; Wed, 19 Oct 2022 07:51:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=izzM/K6+fk877BXN5BzVreaxWiJwRnIbOMmJoge1rxs=; b=AoluhGRFbkOQo+3j6iX2R0UTcL
	E7+3b+QTOTVn41tyHxPooOgz2is3eJ0lUXHcF0AhOoUh0DiRmlTTkIkz4sXdSOHUm2XAZ8Ilp81DH
	EjOKIYEWNlDIN33ewQnLjQrAN7FkJmIBgHX53bxsvaiIgg/7ToMMm1/lrlufOdsAcjBNVjZgvupZJ
	b4gNhmq/WTO/hpyLFRO/ZPs+vgyUEMslqk5RuTUYNrSMjrA+90kNxLmxlFuek7ugdhWtu4x5qs/XQ
	v+b3lWGouLyFNBbfrb5U10CAT42OlZWKv5aMXvz/VgSJJvk+JX9oNhrAOe8kuyUqwMpbnFvjVJXWY
	p/jcfF3w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ol3rg-00GHag-Tl; Wed, 19 Oct 2022 07:51:49 +0000
Received: from smtp-out1.suse.de ([2001:67c:2178:6::1c])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ol3rZ-00GHZp-AZ
	for linux-nvme@lists.infradead.org; Wed, 19 Oct 2022 07:51:47 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 3685733995;
	Wed, 19 Oct 2022 07:51:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1666165899; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=izzM/K6+fk877BXN5BzVreaxWiJwRnIbOMmJoge1rxs=;
	b=rF4CG8QtK4y3sHCAXPqPbnd5cxR1dIjNMY/eT25WN39GQqk78LeeY3EJTvcZOqcoiDQYaf
	Dg3ktIKLvUphzVi9KMM2JpYQNXBcWTmo7rv60jrc2CY/GH0io4VCVXMNHMl3jilS/2cciP
	8idpAPhxyFJv87OWoakFZxIcwoe607Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1666165899;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=izzM/K6+fk877BXN5BzVreaxWiJwRnIbOMmJoge1rxs=;
	b=8L9HhV61p3hPt40K12zsd0hF9iNQHwYAUbp8XAmpvm6DBJ9d8odzJ08+L3e63yVA2XqyqO
	XG0pvzEH7noRfxDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 28E9513A36;
	Wed, 19 Oct 2022 07:51:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id 29XyCYusT2PdSQAAMHmgww
	(envelope-from <dwagner@suse.de>); Wed, 19 Oct 2022 07:51:39 +0000
Date: Wed, 19 Oct 2022 09:51:38 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org
Subject: lockdep warning: fs_reclaim_acquire vs tcp_sendpage
Message-ID: <20221019075138.ff2sfahovionh72v@carbon.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221019_005145_909650_16C60B8C 
X-CRM114-Status: UNSURE (   8.56  )
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

Hi Sagi,

While working on something else I got the lockdep splat below. As this
is a dirty tree and not latest greatest it might be a false alarm.

I haven't really looked into yet, this is just to let you know that
there might be something going on.

Cheers,
Daniel

 ======================================================
 WARNING: possible circular locking dependency detected
 6.0.0-rc2+ #25 Tainted: G        W         
 ------------------------------------------------------
 kswapd0/92 is trying to acquire lock:
 ffff888114003240 (sk_lock-AF_INET-NVME){+.+.}-{0:0}, at: tcp_sendpage+0x23/0xa0
 
 but task is already holding lock:
 ffffffff97e95ca0 (fs_reclaim){+.+.}-{0:0}, at: balance_pgdat+0x987/0x10d0
 
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
        nvme_tcp_try_send+0x48a/0x2630 [nvme_tcp]
        nvme_tcp_queue_rq+0xefb/0x17e0 [nvme_tcp]
        __blk_mq_try_issue_directly+0x452/0x660
        blk_mq_plug_issue_direct.constprop.0+0x207/0x700
        blk_mq_flush_plug_list+0x6f5/0xc70
        __blk_flush_plug+0x264/0x410
        blk_finish_plug+0x4b/0xa0
        shrink_lruvec+0x1263/0x1ea0
        shrink_node+0x736/0x1a80
        balance_pgdat+0x740/0x10d0
        kswapd+0x5f2/0xaf0
        kthread+0x256/0x2f0
        ret_from_fork+0x1f/0x30
 
 other info that might help us debug this:

  Possible unsafe locking scenario:

        CPU0                    CPU1
        ----                    ----
   lock(fs_reclaim);
                                lock(sk_lock-AF_INET-NVME);
                                lock(fs_reclaim);
   lock(sk_lock-AF_INET-NVME);
 
  *** DEADLOCK ***

 3 locks held by kswapd0/92:
  #0: ffffffff97e95ca0 (fs_reclaim){+.+.}-{0:0}, at: balance_pgdat+0x987/0x10d0
  #1: ffff88811f21b0b0 (q->srcu){....}-{0:0}, at: blk_mq_flush_plug_list+0x6b3/0xc70
  #2: ffff888170b11470 (&queue->send_mutex){+.+.}-{3:3}, at: nvme_tcp_queue_rq+0xeb9/0x17e0 [nvme_tcp]
 
 stack backtrace:
 CPU: 7 PID: 92 Comm: kswapd0 Tainted: G        W          6.0.0-rc2+ #25 910779b354c48f37d01f55ab57fbca0c616a47fd
 Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 0.0.0 02/06/2015
 Call Trace:
  <TASK>
  dump_stack_lvl+0x5b/0x77
  check_noncircular+0x26e/0x320
  ? lock_chain_count+0x20/0x20
  ? print_circular_bug+0x1e0/0x1e0
  ? kvm_sched_clock_read+0x14/0x40
  ? sched_clock_cpu+0x69/0x240
  ? __bfs+0x317/0x6f0
  ? usage_match+0x110/0x110
  ? lockdep_lock+0xbe/0x1c0
  ? call_rcu_zapped+0xc0/0xc0
  __lock_acquire+0x2a0c/0x5690
  ? lockdep_hardirqs_on_prepare+0x3f0/0x3f0
  ? lock_chain_count+0x20/0x20
  lock_acquire+0x18e/0x4f0
  ? tcp_sendpage+0x23/0xa0
  ? lock_downgrade+0x6c0/0x6c0
  ? __lock_acquire+0xd3f/0x5690
  lock_sock_nested+0x37/0xc0
  ? tcp_sendpage+0x23/0xa0
  tcp_sendpage+0x23/0xa0
  inet_sendpage+0xad/0x120
  kernel_sendpage+0x156/0x440
  nvme_tcp_try_send+0x48a/0x2630 [nvme_tcp 9175a0e5b6247ff4e2c0da5432ec9d6d589fc288]
  ? lock_downgrade+0x6c0/0x6c0
  ? lock_release+0x6cd/0xd30
  ? nvme_tcp_state_change+0x150/0x150 [nvme_tcp 9175a0e5b6247ff4e2c0da5432ec9d6d589fc288]
  ? mutex_trylock+0x204/0x330
  ? nvme_tcp_queue_rq+0xeb9/0x17e0 [nvme_tcp 9175a0e5b6247ff4e2c0da5432ec9d6d589fc288]
  ? ww_mutex_unlock+0x270/0x270
  nvme_tcp_queue_rq+0xefb/0x17e0 [nvme_tcp 9175a0e5b6247ff4e2c0da5432ec9d6d589fc288]
  ? kvm_sched_clock_read+0x14/0x40
  __blk_mq_try_issue_directly+0x452/0x660
  ? __blk_mq_get_driver_tag+0x980/0x980
  ? lock_downgrade+0x6c0/0x6c0
  blk_mq_plug_issue_direct.constprop.0+0x207/0x700
  ? __mem_cgroup_uncharge+0x140/0x140
  blk_mq_flush_plug_list+0x6f5/0xc70
  ? blk_mq_flush_plug_list+0x6b3/0xc70
  ? blk_mq_insert_requests+0x450/0x450
  __blk_flush_plug+0x264/0x410
  ? memset+0x1f/0x40
  ? __mem_cgroup_uncharge_list+0x84/0x150
  ? blk_start_plug_nr_ios+0x280/0x280
  blk_finish_plug+0x4b/0xa0
  shrink_lruvec+0x1263/0x1ea0
  ? reclaim_throttle+0x790/0x790
  ? sched_clock_cpu+0x69/0x240
  ? lockdep_hardirqs_on_prepare+0x3f0/0x3f0
  ? lock_is_held_type+0xa9/0x120
  ? mem_cgroup_iter+0x2b2/0x780
  shrink_node+0x736/0x1a80
  balance_pgdat+0x740/0x10d0
  ? shrink_node+0x1a80/0x1a80
  ? lock_is_held_type+0xa9/0x120
  ? find_held_lock+0x34/0x120
  ? lock_is_held_type+0xa9/0x120
  ? reacquire_held_locks+0x4f0/0x4f0
  kswapd+0x5f2/0xaf0
  ? balance_pgdat+0x10d0/0x10d0
  ? destroy_sched_domains_rcu+0x60/0x60
  ? trace_hardirqs_on+0x2d/0x110
  ? __kthread_parkme+0x83/0x140
  ? balance_pgdat+0x10d0/0x10d0
  kthread+0x256/0x2f0
  ? kthread_complete_and_exit+0x20/0x20
  ret_from_fork+0x1f/0x30
  </TASK>

