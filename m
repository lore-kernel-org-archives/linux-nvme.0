Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A4CAC433F5
	for <linux-nvme@archiver.kernel.org>; Fri, 11 Feb 2022 05:41:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=PDpO9/39pW7wxxJkWWKCTwSRdZuXNg8feYmMoJKVrKg=; b=arU7t8YB4Z7uQfftpbi4I/LYy6
	OZKeqN/FbRBXUf3ph+X1wySZZ2hs1c/wc9RLXGqXBMOdNTioWC/xDr7Sy4rtxynFXVPL0YED5Ekmy
	9sEJ+K8mlABasAJ7Zzt1bQ0RrVVqQ51VeYTZiZjBIc+YLBRi3ANIREgnv6CpnStobK5NCzw1lvsw1
	WW6Bz9V22u8aFRVwu5uSrUc582cPjg6fRYA/5aDRclceSQ6WmVGPXbFr5oi065ynOBHIaRdqcODQC
	KznXp3p301yjfeRQQNR21mrSU7ybaO2OLm7TApfHYG0fMUYFuD3HPIctpmmmuPrbkYf3kpJkho6qy
	SVCkHqaQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nIOg8-005sGK-1S; Fri, 11 Feb 2022 05:41:08 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nIOg3-005sFZ-P9
 for linux-nvme@lists.infradead.org; Fri, 11 Feb 2022 05:41:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1644558061;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PDpO9/39pW7wxxJkWWKCTwSRdZuXNg8feYmMoJKVrKg=;
 b=G/ubTY6q2HLv853coeqSgs1SDCC/jyQQJaakHSFpywGZTN+4ofQHd+yZChqg/pOKRbkaOh
 b5INxiJ2INvTXvqxQd+/hx/V2u6nYBYhZcjt02wQxt9ZaeCpflz7f86NLDkfkNdrCnuOT9
 Z9HR4SzQbvL9pFdvLW6YsFuxrn27MG0=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-101-Pfm5-q_AMDy00hXKnX9ZlA-1; Fri, 11 Feb 2022 00:38:54 -0500
X-MC-Unique: Pfm5-q_AMDy00hXKnX9ZlA-1
Received: by mail-pj1-f71.google.com with SMTP id
 iy10-20020a17090b16ca00b001b8a7ed5b2cso7629640pjb.7
 for <linux-nvme@lists.infradead.org>; Thu, 10 Feb 2022 21:38:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=PDpO9/39pW7wxxJkWWKCTwSRdZuXNg8feYmMoJKVrKg=;
 b=c1RBiudX5I1m1jQenpIFhJO0M1KlRV5gVSyts9XO75LK2cfTRdM65S4+lcNiCYUAM0
 BzUZ+YxhGUYA+yB271U4VLjCmcc5pEwImvMyipSKKETh9nKooitpl99LGyE9+BD1yR7n
 pptAzqKrrWltQ640+yaUskND1HlYRspUz0f5yX+CcIA8P63BafRpWJRK5SaeDNNQw3+f
 6XogmmY3wUseS206vlOMUeUcHN8pexiwuNSAN2/NYgxIZFDg5yBJz5c1OEbaYlI28kYX
 gKjGIyQxpOCUiPUV7h8bFHj9GN7fRUwBQOjbNlur1OdXI2XT/z2Obo8EwzmiX9n14NP8
 0bkw==
X-Gm-Message-State: AOAM530Clv1Pq+v5WWEhVzJPNL9m0/6kmi2g/Xn5dOztt7P0xpVfQdA0
 cVF7Kx8V8O8giZm1A3hyrzQBAj7zCliNix1u541UgjDIO5mE82TRwnKDw6GjjX368tbQCoZaac6
 kABghlAuKahLQTcYVTPFSIZ+kijNXrJ8UcUF0dwraYeI=
X-Received: by 2002:a17:903:20c4:: with SMTP id i4mr179458plb.68.1644557932502; 
 Thu, 10 Feb 2022 21:38:52 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxVkov2cE+fVcagWUUac35IUqoXoKvTczySVctXRlzoV48ZUgRvaxRNBOpZ4ftGuiibb6znmlsbm3rGvMPMb2M=
X-Received: by 2002:a17:903:20c4:: with SMTP id i4mr179441plb.68.1644557932021; 
 Thu, 10 Feb 2022 21:38:52 -0800 (PST)
MIME-Version: 1.0
References: <CAHj4cs9MDYLJ+q+2_GXUK9HxFizv2pxUryUR0toX974M040z7g@mail.gmail.com>
 <71d184e9-503a-1dea-2881-c38f59849209@grimberg.me>
In-Reply-To: <71d184e9-503a-1dea-2881-c38f59849209@grimberg.me>
From: Yi Zhang <yi.zhang@redhat.com>
Date: Fri, 11 Feb 2022 13:38:40 +0800
Message-ID: <CAHj4cs_vzomLUC1WGYEC+_dGyjdqfopqoALhkAqiR4TdM2FPSw@mail.gmail.com>
Subject: Re: [bug report] WARNING: possible circular locking dependency
 detected with blktests nvme-tcp nvme/013
To: Sagi Grimberg <sagi@grimberg.me>
Cc: "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=yizhan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220210_214104_088157_4824A058 
X-CRM114-Status: GOOD (  15.55  )
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

On Wed, Sep 29, 2021 at 7:06 PM Sagi Grimberg <sagi@grimberg.me> wrote:
>
>
> > Hello
> >
> > Bellow warning was triggered with blktests nvme-tcp on latest
> > 5.15.0-rc3, pls help check it.
>
> Hey Yi, thanks for reporting..
>
> I'm trying to understand the circular locking here. I'm trying to
> understand if this is due to having an allocation in the
> network send path that may cause a circular dependency.
>
> >

Hi Sagi
This issue is still reproducible on the latest 5.17.0-rc3, fee free to
let me know if you need any testing for it. :)

[ 5960.130892] run blktests nvme/013 at 2022-02-11 00:31:51
[ 5960.456011] nvmet: adding nsid 1 to subsystem blktests-subsystem-1
[ 5960.483756] nvmet_tcp: enabling port 0 (127.0.0.1:4420)
[ 5960.511578] nvmet: creating nvm controller 1 for subsystem
blktests-subsystem-1 for NQN
nqn.2014-08.org.nvmexpress:uuid:4c4c4544-0035-4b10-8044-b9c04f463333.
[ 5960.515933] nvme nvme0: creating 32 I/O queues.
[ 5960.536234] nvme nvme0: mapped 32/0/0 default/read/poll queues.
[ 5960.551779] nvme nvme0: new ctrl: NQN "blktests-subsystem-1", addr
127.0.0.1:4420
[ 5961.788277] XFS (nvme0n1): Mounting V5 Filesystem
[ 5961.820057] XFS (nvme0n1): Ending clean mount
[ 5961.826643] xfs filesystem being mounted at /mnt/blktests supports
timestamps until 2038 (0x7fffffff)

[ 5966.115175] ======================================================
[ 5966.121352] WARNING: possible circular locking dependency detected
[ 5966.127533] 5.17.0-rc3 #2 Tainted: G S        I
[ 5966.132585] ------------------------------------------------------
[ 5966.138763] fio/5034 is trying to acquire lock:
[ 5966.143295] ffff8882ad9158c0 (sk_lock-AF_INET){+.+.}-{0:0}, at:
tcp_sendpage+0x23/0x50
[ 5966.151218]
               but task is already holding lock:
[ 5966.157050] ffff8881d51246b0 (&xfs_dir_ilock_class/5){+.+.}-{3:3},
at: xfs_ilock+0x166/0x4a0 [xfs]
[ 5966.166149]
               which lock already depends on the new lock.

[ 5966.174321]
               the existing dependency chain (in reverse order) is:
[ 5966.181801]
               -> #3 (&xfs_dir_ilock_class/5){+.+.}-{3:3}:
[ 5966.188509]        lock_acquire+0x1d2/0x5a0
[ 5966.192695]        down_write_nested+0xa2/0x3b0
[ 5966.197227]        xfs_ilock+0x166/0x4a0 [xfs]
[ 5966.201793]        xfs_create+0x64b/0x12e0 [xfs]
[ 5966.206524]        xfs_generic_create+0x25b/0x5a0 [xfs]
[ 5966.211863]        lookup_open+0xea8/0x1850
[ 5966.216049]        path_openat+0x705/0x2370
[ 5966.220235]        do_filp_open+0x1a4/0x280
[ 5966.224421]        do_sys_openat2+0x30d/0x670
[ 5966.228779]        do_sys_open+0x8a/0xd0
[ 5966.232706]        do_syscall_64+0x37/0x80
[ 5966.236805]        entry_SYSCALL_64_after_hwframe+0x44/0xae
[ 5966.242379]
               -> #2 (sb_internal){.+.+}-{0:0}:
[ 5966.248125]        lock_acquire+0x1d2/0x5a0
[ 5966.252309]        xfs_trans_alloc+0x3b1/0x980 [xfs]
[ 5966.257388]        xfs_vn_update_time+0x201/0x610 [xfs]
[ 5966.262728]        touch_atime+0x2fa/0x490
[ 5966.266824]        xfs_file_mmap+0x244/0x2d0 [xfs]
[ 5966.271732]        mmap_region+0x87f/0x11c0
[ 5966.275917]        do_mmap+0x58c/0xc00
[ 5966.279670]        vm_mmap_pgoff+0x178/0x220
[ 5966.283942]        ksys_mmap_pgoff+0x2f3/0x470
[ 5966.288387]        do_syscall_64+0x37/0x80
[ 5966.292488]        entry_SYSCALL_64_after_hwframe+0x44/0xae
[ 5966.298060]
               -> #1 (&mm->mmap_lock#2){++++}-{3:3}:
[ 5966.304246]        lock_acquire+0x1d2/0x5a0
[ 5966.308433]        __might_fault+0xe2/0x160
[ 5966.312617]        _copy_from_user+0x20/0xd0
[ 5966.316893]        copy_bpf_fprog_from_user+0x16f/0x1f0
[ 5966.322118]        sock_setsockopt+0x663/0x25b0
[ 5966.326649]        __sys_setsockopt+0x39e/0x4e0
[ 5966.331183]        __x64_sys_setsockopt+0xba/0x150
[ 5966.335974]        do_syscall_64+0x37/0x80
[ 5966.340074]        entry_SYSCALL_64_after_hwframe+0x44/0xae
[ 5966.345647]
               -> #0 (sk_lock-AF_INET){+.+.}-{0:0}:
[ 5966.351738]        check_prevs_add+0x3fd/0x2480
[ 5966.356271]        __lock_acquire+0x2402/0x2fa0
[ 5966.360803]        lock_acquire+0x1d2/0x5a0
[ 5966.364990]        lock_sock_nested+0x37/0xd0
[ 5966.369350]        tcp_sendpage+0x23/0x50
[ 5966.373362]        inet_sendpage+0xb3/0x130
[ 5966.377547]        kernel_sendpage+0x1c0/0x2f0
[ 5966.381992]        nvme_tcp_try_send+0x552/0x2250 [nvme_tcp]
[ 5966.387651]        nvme_tcp_queue_rq+0xf3b/0x17b0 [nvme_tcp]
[ 5966.393312]        __blk_mq_try_issue_directly+0x448/0x660
[ 5966.398797]        blk_mq_plug_issue_direct.constprop.75+0x13a/0x210
[ 5966.405149]        blk_mq_flush_plug_list+0x828/0xfd0
[ 5966.410201]        blk_flush_plug+0x2b8/0x4c0
[ 5966.414561]        blk_finish_plug+0x47/0x90
[ 5966.418834]        _xfs_buf_ioapply+0x6ed/0xb70 [xfs]
[ 5966.423998]        __xfs_buf_submit+0x228/0x650 [xfs]
[ 5966.429155]        xfs_buf_read_map+0x365/0x970 [xfs]
[ 5966.434320]        xfs_trans_read_buf_map+0x694/0x11b0 [xfs]
[ 5966.440101]        xfs_btree_read_buf_block.constprop.28+0x1dc/0x340 [xfs]
[ 5966.447076]        xfs_btree_lookup_get_block+0x1a6/0x630 [xfs]
[ 5966.453092]        xfs_btree_lookup+0x39f/0xf20 [xfs]
[ 5966.458240]        xfs_dialloc_ag_update_inobt+0x19d/0x4e0 [xfs]
[ 5966.464350]        xfs_dialloc+0x8a7/0x11c0 [xfs]
[ 5966.469161]        xfs_create+0xb85/0x12e0 [xfs]
[ 5966.473891]        xfs_generic_create+0x25b/0x5a0 [xfs]
[ 5966.479228]        lookup_open+0xea8/0x1850
[ 5966.483416]        path_openat+0x705/0x2370
[ 5966.487601]        do_filp_open+0x1a4/0x280
[ 5966.491787]        do_sys_openat2+0x30d/0x670
[ 5966.496145]        do_sys_open+0x8a/0xd0
[ 5966.500072]        do_syscall_64+0x37/0x80
[ 5966.504172]        entry_SYSCALL_64_after_hwframe+0x44/0xae
[ 5966.509742]
               other info that might help us debug this:

[ 5966.517744] Chain exists of:
                 sk_lock-AF_INET --> sb_internal --> &xfs_dir_ilock_class/5

[ 5966.528784]  Possible unsafe locking scenario:

[ 5966.534703]        CPU0                    CPU1
[ 5966.539235]        ----                    ----
[ 5966.543768]   lock(&xfs_dir_ilock_class/5);
[ 5966.547954]                                lock(sb_internal);
[ 5966.553701]                                lock(&xfs_dir_ilock_class/5);
[ 5966.560397]   lock(sk_lock-AF_INET);
[ 5966.563978]
                *** DEADLOCK ***

[ 5966.569897] 6 locks held by fio/5034:
[ 5966.573562]  #0: ffff88829c044470 (sb_writers#14){.+.+}-{0:0}, at:
path_openat+0x2182/0x2370
[ 5966.582004]  #1: ffff8881d51248f0
(&inode->i_sb->s_type->i_mutex_dir_key){++++}-{3:3}, at:
path_openat+0x6f2/0x2370
[ 5966.592439]  #2: ffff88829c044690 (sb_internal){.+.+}-{0:0}, at:
xfs_trans_alloc_icreate+0xa4/0x180 [xfs]
[ 5966.602118]  #3: ffff8881d51246b0
(&xfs_dir_ilock_class/5){+.+.}-{3:3}, at: xfs_ilock+0x166/0x4a0 [xfs]
[ 5966.611626]  #4: ffff88829c0154d0 (q->srcu){....}-{0:0}, at:
blk_mq_flush_plug_list+0x7d2/0xfd0
[ 5966.620327]  #5: ffff888e2e7dbcd0 (&queue->send_mutex){+.+.}-{3:3},
at: nvme_tcp_queue_rq+0xef5/0x17b0 [nvme_tcp]
[ 5966.630588]
               stack backtrace:
[ 5966.634948] CPU: 24 PID: 5034 Comm: fio Tainted: G S        I
5.17.0-rc3 #2
[ 5966.642425] Hardware name: Dell Inc. PowerEdge R640/06NR82, BIOS
2.11.2 004/21/2021
[ 5966.650078] Call Trace:
[ 5966.652532]  <TASK>
[ 5966.654637]  dump_stack_lvl+0x44/0x57
[ 5966.658303]  check_noncircular+0x280/0x320
[ 5966.662403]  ? print_circular_bug.isra.47+0x430/0x430
[ 5966.667455]  ? mark_lock.part.52+0x107/0x1210
[ 5966.671814]  ? mark_lock.part.52+0x107/0x1210
[ 5966.676175]  ? lock_chain_count+0x20/0x20
[ 5966.680186]  check_prevs_add+0x3fd/0x2480
[ 5966.684202]  ? check_irq_usage+0xb50/0xb50
[ 5966.688296]  ? lockdep_lock+0xcb/0x1c0
[ 5966.692051]  ? static_obj+0xc0/0xc0
[ 5966.695542]  ? sched_clock_cpu+0x15/0x200
[ 5966.699555]  __lock_acquire+0x2402/0x2fa0
[ 5966.703570]  ? rcu_read_lock_bh_held+0xc0/0xc0
[ 5966.708012]  lock_acquire+0x1d2/0x5a0
[ 5966.711679]  ? tcp_sendpage+0x23/0x50
[ 5966.715347]  ? rcu_read_unlock+0x50/0x50
[ 5966.719272]  ? sched_clock_cpu+0x15/0x200
[ 5966.723284]  lock_sock_nested+0x37/0xd0
[ 5966.727121]  ? tcp_sendpage+0x23/0x50
[ 5966.730789]  tcp_sendpage+0x23/0x50
[ 5966.734281]  inet_sendpage+0xb3/0x130
[ 5966.737946]  kernel_sendpage+0x1c0/0x2f0
[ 5966.741873]  nvme_tcp_try_send+0x552/0x2250 [nvme_tcp]
[ 5966.747012]  ? lock_is_held_type+0xd9/0x130
[ 5966.751199]  ? nvme_tcp_try_send_ddgst+0x330/0x330 [nvme_tcp]
[ 5966.756944]  ? ww_mutex_unlock+0x2f0/0x2f0
[ 5966.761044]  ? __rq_qos_issue+0x4f/0x90
[ 5966.764885]  nvme_tcp_queue_rq+0xf3b/0x17b0 [nvme_tcp]
[ 5966.770021]  ? __lock_acquire+0xc31/0x2fa0
[ 5966.774120]  __blk_mq_try_issue_directly+0x448/0x660
[ 5966.779086]  ? __blk_mq_get_driver_tag+0xa70/0xa70
[ 5966.783877]  ? rcu_read_lock_bh_held+0xc0/0xc0
[ 5966.788325]  blk_mq_plug_issue_direct.constprop.75+0x13a/0x210
[ 5966.794158]  ? blk_mq_requeue_work+0x6c0/0x6c0
[ 5966.798601]  ? lock_is_held_type+0xd9/0x130
[ 5966.802789]  blk_mq_flush_plug_list+0x828/0xfd0
[ 5966.807321]  ? blk_mq_flush_plug_list+0x7d2/0xfd0
[ 5966.812028]  ? submit_bio_noacct+0x31d/0x840
[ 5966.816299]  ? blk_mq_insert_requests+0x590/0x590
[ 5966.821003]  ? find_held_lock+0x3a/0x1c0
[ 5966.824932]  blk_flush_plug+0x2b8/0x4c0
[ 5966.828771]  ? blk_start_plug_nr_ios+0x270/0x270
[ 5966.833390]  ? submit_bio_noacct+0x840/0x840
[ 5966.837663]  blk_finish_plug+0x47/0x90
[ 5966.841413]  _xfs_buf_ioapply+0x6ed/0xb70 [xfs]
[ 5966.846064]  ? __xfs_buf_submit+0x134/0x650 [xfs]
[ 5966.850878]  ? xfs_buf_get_map+0xbc0/0xbc0 [xfs]
[ 5966.855602]  ? rcu_read_lock_bh_held+0xc0/0xc0
[ 5966.860049]  __xfs_buf_submit+0x228/0x650 [xfs]
[ 5966.864693]  xfs_buf_read_map+0x365/0x970 [xfs]
[ 5966.869338]  ? xfs_btree_read_buf_block.constprop.28+0x1dc/0x340 [xfs]
[ 5966.875957]  ? find_held_lock+0x3a/0x1c0
[ 5966.879885]  ? _xfs_buf_read+0x110/0x110 [xfs]
[ 5966.884443]  ? lock_release+0x42f/0xc90
[ 5966.888285]  xfs_trans_read_buf_map+0x694/0x11b0 [xfs]
[ 5966.893542]  ? xfs_btree_read_buf_block.constprop.28+0x1dc/0x340 [xfs]
[ 5966.900163]  ? xfs_trans_getsb+0x690/0x690 [xfs]
[ 5966.904904]  ? __kasan_slab_alloc+0x6d/0x90
[ 5966.909091]  ? xfs_btree_ptr_to_daddr+0x24f/0x6b0 [xfs]
[ 5966.914422]  xfs_btree_read_buf_block.constprop.28+0x1dc/0x340 [xfs]
[ 5966.920867]  ? __kernel_text_address+0xe/0x30
[ 5966.925228]  ? xfs_btree_readahead_ptr.constprop.27+0x1f0/0x1f0 [xfs]
[ 5966.931765]  ? xfs_btree_ptr_to_daddr+0x24f/0x6b0 [xfs]
[ 5966.937083]  xfs_btree_lookup_get_block+0x1a6/0x630 [xfs]
[ 5966.942586]  ? filter_irq_stacks+0xa0/0xa0
[ 5966.946682]  ? xfs_btree_get_leaf_keys+0xdf/0x480 [xfs]
[ 5966.952004]  ? xfs_btree_dec_cursor+0xe0/0xe0 [xfs]
[ 5966.956979]  ? kasan_save_stack+0x2b/0x40
[ 5966.960992]  ? kasan_save_stack+0x1c/0x40
[ 5966.965005]  ? __kasan_slab_alloc+0x6d/0x90
[ 5966.969189]  ? kmem_cache_alloc+0x105/0x2d0
[ 5966.973377]  ? xfs_inobt_init_common+0x6e/0x300 [xfs]
[ 5966.978531]  ? xfs_inobt_init_cursor+0x4f/0x170 [xfs]
[ 5966.983688]  ? xfs_dialloc+0x893/0x11c0 [xfs]
[ 5966.988144]  ? xfs_create+0xb85/0x12e0 [xfs]
[ 5966.992529]  ? xfs_generic_create+0x25b/0x5a0 [xfs]
[ 5966.997524]  xfs_btree_lookup+0x39f/0xf20 [xfs]
[ 5967.002162]  ? xfs_btree_overlapped_query_range+0xfd0/0xfd0 [xfs]
[ 5967.008355]  ? find_held_lock+0x3a/0x1c0
[ 5967.012281]  ? lock_downgrade+0x6b0/0x6b0
[ 5967.016294]  ? lock_is_held_type+0xd9/0x130
[ 5967.020480]  ? xfs_inobt_init_common+0x6e/0x300 [xfs]
[ 5967.025634]  ? rcu_read_lock_sched_held+0xaf/0xe0
[ 5967.030340]  ? rcu_read_lock_bh_held+0xc0/0xc0
[ 5967.034788]  xfs_dialloc_ag_update_inobt+0x19d/0x4e0 [xfs]
[ 5967.040378]  ? xfs_dialloc_ag_finobt_newino.isra.19+0x550/0x550 [xfs]
[ 5967.046919]  ? xfs_inobt_init_common+0x203/0x300 [xfs]
[ 5967.052165]  xfs_dialloc+0x8a7/0x11c0 [xfs]
[ 5967.056458]  ? xfs_ialloc_pagi_init+0xc0/0xc0 [xfs]
[ 5967.061437]  ? down_write_nested+0x185/0x3b0
[ 5967.065708]  ? _down_write_nest_lock+0x3b0/0x3b0
[ 5967.070328]  ? rcu_read_lock_bh_held+0xc0/0xc0
[ 5967.074771]  ? xfs_trans_alloc_inode+0x2c0/0x2c0 [xfs]
[ 5967.080026]  ? xfs_create+0x64b/0x12e0 [xfs]
[ 5967.084420]  xfs_create+0xb85/0x12e0 [xfs]
[ 5967.088634]  ? xfs_init_new_inode+0x18a0/0x18a0 [xfs]
[ 5967.093806]  ? get_cached_acl+0x185/0x390
[ 5967.097817]  ? rcu_read_lock_held+0xaf/0xc0
[ 5967.102003]  ? rcu_read_lock_sched_held+0xe0/0xe0
[ 5967.106709]  ? _raw_spin_unlock_irqrestore+0x30/0x50
[ 5967.111675]  ? get_cached_acl+0x185/0x390
[ 5967.115686]  ? get_cached_acl+0x272/0x390
[ 5967.119699]  ? posix_acl_fix_xattr_userns+0x290/0x290
[ 5967.124756]  ? get_acl+0x18/0x260
[ 5967.128082]  xfs_generic_create+0x25b/0x5a0 [xfs]
[ 5967.132909]  ? xfs_setup_iops+0x3b0/0x3b0 [xfs]
[ 5967.137553]  ? may_create+0x2ef/0x370
[ 5967.141217]  ? selinux_inode_init_security+0x730/0x730
[ 5967.146359]  ? selinux_inode_permission+0x288/0x3b0
[ 5967.151238]  ? selinux_sk_alloc_security+0x1d0/0x1d0
[ 5967.156202]  ? from_kgid+0x83/0xc0
[ 5967.159610]  lookup_open+0xea8/0x1850
[ 5967.163277]  ? lock_acquired+0x262/0xb10
[ 5967.167198]  ? lookup_positive_unlocked+0x70/0x70
[ 5967.171910]  ? __mnt_want_write+0x15b/0x240
[ 5967.176101]  path_openat+0x705/0x2370
[ 5967.179766]  ? do_syscall_64+0x27/0x80
[ 5967.183521]  ? filename_lookup.part.60+0x390/0x390
[ 5967.188312]  ? lock_is_held_type+0xd9/0x130
[ 5967.192497]  ? alloc_fd+0x234/0x570
[ 5967.195991]  ? sched_clock_cpu+0x15/0x200
[ 5967.200002]  do_filp_open+0x1a4/0x280
[ 5967.203668]  ? lock_release+0x42f/0xc90
[ 5967.207508]  ? may_open_dev+0xc0/0xc0
[ 5967.211177]  ? do_raw_spin_unlock+0x54/0x230
[ 5967.215459]  do_sys_openat2+0x30d/0x670
[ 5967.219302]  ? file_open_root+0x200/0x200
[ 5967.223316]  ? ktime_get_coarse_real_ts64+0x11c/0x160
[ 5967.228367]  do_sys_open+0x8a/0xd0
[ 5967.231772]  ? filp_open+0x50/0x50
[ 5967.235178]  ? syscall_trace_enter.isra.15+0x190/0x270
[ 5967.240319]  do_syscall_64+0x37/0x80
[ 5967.243896]  entry_SYSCALL_64_after_hwframe+0x44/0xae
[ 5967.248948] RIP: 0033:0x7ff075c3f296
[ 5967.252527] Code: 89 54 24 08 e8 9b f4 ff ff 8b 74 24 0c 48 8b 3c
24 41 89 c0 44 8b 54 24 08 b8 01 01 00 00 89 f2 48 89 fe bf 9c ff ff
ff 0f 05 <48> 3d 00 f0 ff ff 77 30 44 89 c7 89 44 24 08 e8 c6 f4 ff ff
8b 44
[ 5967.271273] RSP: 002b:00007ffc916b0af0 EFLAGS: 00000293 ORIG_RAX:
0000000000000101
[ 5967.278839] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007ff075c3f296
[ 5967.285971] RDX: 0000000000000041 RSI: 00007ff0640ff290 RDI: 00000000ffffff9c
[ 5967.293103] RBP: 0000000000000000 R08: 0000000000000000 R09: 00007ff0754627e0
[ 5967.300235] R10: 00000000000001a4 R11: 0000000000000293 R12: 000000003b600000
[ 5967.307370] R13: 0000000000000000 R14: 00007ff0640ff110 R15: 00007ff00b494000
[ 5967.314507]  </TASK>
[ 6105.703881] XFS (nvme0n1): Unmounting Filesystem
[ 6105.765404] nvme nvme0: Removing ctrl: NQN "blktests-subsystem-1"
-- 
Best Regards,
  Yi Zhang


