Return-Path: <SRS0=HFDN=OT=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B4A6C433EF
	for <linux-nvme@archiver.kernel.org>; Wed, 29 Sep 2021 11:06:38 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DDCE361353
	for <linux-nvme@archiver.kernel.org>; Wed, 29 Sep 2021 11:06:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org DDCE361353
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=aCdFr5cuEFLisud2bK58vuv4rszlFUBBedDzHIg4l80=; b=zUVe09xtDgPeL663QistA6i9py
	oP1s8Lj8vcwzVxQ6T4gYVCEedFxKtzoM+NsuHu/MFdKY9IIb5hmBIn8qNJhqw4Q2m5WoLOjHTzmBm
	PPhAM+C3PFUIIwoUPk9NIhXpJ+xYUWsX5fJSUZOyJUWzG9hyt6lm8Fkk98ptJ08FKjMjcOBP1IHY8
	lVH32e3u6aqo4lQcf+/v0S5fkvLCrdKaY4sSqwI7hSDnUQegT8z2PjD9j+zBShN7w6i+bK8Y9oJ4r
	PHyj/azD76URvbSjMQ6H1IXKybaGY4V0vy1TZb+1Ey27FRWpv6JwH2jT9ULlSNz6jpG5zeEcH4xPX
	YJ+SfS/Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mVXPr-00Ao6g-5m; Wed, 29 Sep 2021 11:06:23 +0000
Received: from mail-wm1-f54.google.com ([209.85.128.54])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mVXPn-00Ao5i-I6
 for linux-nvme@lists.infradead.org; Wed, 29 Sep 2021 11:06:21 +0000
Received: by mail-wm1-f54.google.com with SMTP id
 f78-20020a1c1f51000000b0030cdb3d6079so1430199wmf.3
 for <linux-nvme@lists.infradead.org>; Wed, 29 Sep 2021 04:06:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=kPPbT2M8rFN/2yC5ZnsYsORRbO+PhuBYxC61fKLSnW0=;
 b=5GZFHcBsgo1SkSFraej4tgFdQ8KHtBeiEBwERSY8AJ0tP0Emm3RToFaQbNhc8kHu59
 HpNNzIRT3ewZxFQ/ZjNOe2MYkRF7iSJ0xsBloh39DZwGlOCcMKGhxKYuWH92i+QIBCXv
 xvwWiV//T1JC325laP3nnz6q9eOCpWMsE2flzU9sPZJhN/fjH0P815blC0tWG2J6XIAj
 0il4a+aJZhY4xHgLrj/GzihTawmZY88k8t7EYC5AsVVRFJUGylzr3gGVbiyRvFRfURRs
 zuAf2ekToCd2vxRydf1UjcuQg50byF16NH+up8vKd5LPpTP7er4kZp4YD7Sd70QadRSb
 atGg==
X-Gm-Message-State: AOAM530CmriDm4VzCUa7e8CycnBVuriuWQdPtOezpYxSrt6nrMl7fKPD
 PHJNaPvUsvkyQ02WgmiBbhag461Y3Do=
X-Google-Smtp-Source: ABdhPJxLGR8VZYUNSEZcwU304xUIJK7JmZ7v/jxMfzdZvOn2WOX0j6VsscUyPLjfv70DSyKMLnnVEA==
X-Received: by 2002:a05:600c:2201:: with SMTP id
 z1mr9675776wml.55.1632913577284; 
 Wed, 29 Sep 2021 04:06:17 -0700 (PDT)
Received: from [192.168.64.123] (bzq-219-42-90.isdn.bezeqint.net.
 [62.219.42.90])
 by smtp.gmail.com with ESMTPSA id y7sm1233130wmj.37.2021.09.29.04.06.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 Sep 2021 04:06:16 -0700 (PDT)
Subject: Re: [bug report] WARNING: possible circular locking dependency
 detected with blktests nvme-tcp nvme/013
To: Yi Zhang <yi.zhang@redhat.com>, linux-nvme@lists.infradead.org
References: <CAHj4cs9MDYLJ+q+2_GXUK9HxFizv2pxUryUR0toX974M040z7g@mail.gmail.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <71d184e9-503a-1dea-2881-c38f59849209@grimberg.me>
Date: Wed, 29 Sep 2021 14:06:15 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <CAHj4cs9MDYLJ+q+2_GXUK9HxFizv2pxUryUR0toX974M040z7g@mail.gmail.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210929_040619_651107_FACB09DB 
X-CRM114-Status: GOOD (  16.49  )
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


> Hello
> 
> Bellow warning was triggered with blktests nvme-tcp on latest
> 5.15.0-rc3, pls help check it.

Hey Yi, thanks for reporting..

I'm trying to understand the circular locking here. I'm trying to
understand if this is due to having an allocation in the
network send path that may cause a circular dependency.

> 
> [ 2153.718873] run blktests nvme/013 at 2021-09-28 07:14:57
> [ 2154.082894] nvmet: adding nsid 1 to subsystem blktests-subsystem-1
> [ 2154.116627] nvmet_tcp: enabling port 0 (127.0.0.1:4420)
> [ 2154.174352] nvmet: creating controller 1 for subsystem
> blktests-subsystem-1 for NQN
> nqn.2014-08.org.nvmexpress:uuid:c83e4244a1d04d318ced2447da679f67.
> [ 2154.196889] nvme nvme0: creating 40 I/O queues.
> [ 2154.222389] nvme nvme0: mapped 40/0/0 default/read/poll queues.
> [ 2154.275779] nvme nvme0: new ctrl: NQN "blktests-subsystem-1", addr
> 127.0.0.1:4420
> [ 2155.648483] XFS (nvme0n1): Mounting V5 Filesystem
> [ 2155.717630] XFS (nvme0n1): Ending clean mount
> [ 2155.734834] xfs filesystem being mounted at /mnt/blktests supports
> timestamps until 2038 (0x7fffffff)
> 
> [ 2155.932675] ======================================================
> [ 2155.939575] WARNING: possible circular locking dependency detected
> [ 2155.946467] 5.15.0-rc3 #1 Not tainted
> [ 2155.950551] ------------------------------------------------------
> [ 2155.957447] fio/1496 is trying to acquire lock:
> [ 2155.962504] ffff93d58ffe2470 (sk_lock-AF_INET){+.+.}-{0:0}, at:
> tcp_sendpage+0x23/0x80
> [ 2155.971355]
>                 but task is already holding lock:
> [ 2155.977866] ffff93d59bb7f8f0 (&xfs_dir_ilock_class/5){+.+.}-{3:3},
> at: xfs_ilock+0xcf/0x290 [xfs]
> [ 2155.987885]
>                 which lock already depends on the new lock.
> 
> [ 2155.997012]
>                 the existing dependency chain (in reverse order) is:
> [ 2156.005362]
>                 -> #3 (&xfs_dir_ilock_class/5){+.+.}-{3:3}:
> [ 2156.012843]        down_write_nested+0x49/0x120
> [ 2156.017904]        xfs_ilock+0xcf/0x290 [xfs]
> [ 2156.022850]        xfs_create+0x1e8/0x660 [xfs]
> [ 2156.027989]        xfs_generic_create+0xfa/0x340 [xfs]
> [ 2156.033805]        vfs_mkdir+0x12b/0x1e0
> [ 2156.038194]        do_mkdirat+0x10a/0x130
> [ 2156.042669]        __x64_sys_mkdir+0x48/0x70
> [ 2156.047434]        do_syscall_64+0x3b/0x90
> [ 2156.052013]        entry_SYSCALL_64_after_hwframe+0x44/0xae
> [ 2156.058238]
>                 -> #2 (sb_internal){.+.+}-{0:0}:
> [ 2156.064654]        xfs_trans_alloc+0x1a1/0x3c0 [xfs]
> [ 2156.070281]        xfs_vn_update_time+0xc6/0x260 [xfs]
> [ 2156.076097]        touch_atime+0x129/0x230
> [ 2156.080672]        xfs_file_mmap+0x84/0x90 [xfs]
> [ 2156.085906]        mmap_region+0x497/0x6b0
> [ 2156.090480]        do_mmap+0x362/0x560
> [ 2156.094663]        vm_mmap_pgoff+0xb8/0x150
> [ 2156.099330]        ksys_mmap_pgoff+0x198/0x1f0
> [ 2156.104288]        do_syscall_64+0x3b/0x90
> [ 2156.108860]        entry_SYSCALL_64_after_hwframe+0x44/0xae
> [ 2156.115078]
>                 -> #1 (&mm->mmap_lock#2){++++}-{3:3}:
> [ 2156.121978]        __might_fault+0x56/0x80
> [ 2156.126553]        _copy_from_user+0x20/0xa0
> [ 2156.131327]        ip_setsockopt+0x123d/0x15c0
> [ 2156.136287]        __sys_setsockopt+0xba/0x1a0
> [ 2156.141250]        __x64_sys_setsockopt+0x1b/0x20
> [ 2156.146499]        do_syscall_64+0x3b/0x90
> [ 2156.151069]        entry_SYSCALL_64_after_hwframe+0x44/0xae
> [ 2156.157289]
>                 -> #0 (sk_lock-AF_INET){+.+.}-{0:0}:
> [ 2156.164093]        __lock_acquire+0x11fe/0x1e00
> [ 2156.169154]        lock_acquire+0xc4/0x2e0
> [ 2156.173727]        lock_sock_nested+0x2e/0x80
> [ 2156.178593]        tcp_sendpage+0x23/0x80
> [ 2156.183068]        inet_sendpage+0x4f/0x80
> [ 2156.187645]        kernel_sendpage+0x62/0xf0
> [ 2156.192413]        nvme_tcp_try_send+0x128/0x810 [nvme_tcp]
> [ 2156.198633]        nvme_tcp_queue_rq+0x35a/0x380 [nvme_tcp]
> [ 2156.204853]        __blk_mq_try_issue_directly+0x120/0x1c0
> [ 2156.210983]        blk_mq_try_issue_list_directly+0x157/0x250
> [ 2156.217400]        blk_mq_sched_insert_requests+0x241/0x2a0
> [ 2156.223620]        blk_mq_flush_plug_list+0x114/0x210
> [ 2156.229256]        blk_finish_plug+0x21/0x30
> [ 2156.234028]        _xfs_buf_ioapply+0x30a/0x3c0 [xfs]
> [ 2156.239747]        __xfs_buf_submit+0x92/0x260 [xfs]
> [ 2156.245360]        xfs_buf_read_map+0xe9/0x2a0 [xfs]
> [ 2156.250969]        xfs_trans_read_buf_map+0x1bb/0x550 [xfs]
> [ 2156.257274]        xfs_btree_read_buf_block.constprop.0+0x75/0xb0 [xfs]
> [ 2156.264732]        xfs_btree_lookup_get_block+0x87/0x160 [xfs]
> [ 2156.271316]        xfs_btree_lookup+0x123/0x4d0 [xfs]
> [ 2156.277027]        xfs_dialloc_ag_update_inobt+0x3a/0x180 [xfs]
> [ 2156.283709]        xfs_dialloc+0x43f/0x800 [xfs]
> [ 2156.288938]        xfs_create+0x404/0x660 [xfs]
> [ 2156.294075]        xfs_generic_create+0xfa/0x340 [xfs]
> [ 2156.299891]        lookup_open.isra.0+0x537/0x670
> [ 2156.305141]        path_openat+0x2aa/0xa20
> [ 2156.309713]        do_filp_open+0x9f/0x130
> [ 2156.314290]        do_sys_openat2+0x7a/0x140
> [ 2156.319057]        __x64_sys_openat+0x45/0x70
> [ 2156.323918]        do_syscall_64+0x3b/0x90
> [ 2156.328491]        entry_SYSCALL_64_after_hwframe+0x44/0xae
> [ 2156.334712]
>                 other info that might help us debug this:
> 
> [ 2156.343644] Chain exists of:
>                   sk_lock-AF_INET --> sb_internal --> &xfs_dir_ilock_class/5
> 
> [ 2156.355972]  Possible unsafe locking scenario:
> 
> [ 2156.362579]        CPU0                    CPU1
> [ 2156.367632]        ----                    ----
> [ 2156.372685]   lock(&xfs_dir_ilock_class/5);
> [ 2156.377351]                                lock(sb_internal);
> [ 2156.383764]                                lock(&xfs_dir_ilock_class/5);
> [ 2156.391242]   lock(sk_lock-AF_INET);
> [ 2156.395230]
>                  *** DEADLOCK ***
> 
> [ 2156.401834] 6 locks held by fio/1496:
> [ 2156.405919]  #0: ffff93d584c36498 (sb_writers#13){.+.+}-{0:0}, at:
> path_openat+0x9fc/0xa20
> [ 2156.415147]  #1: ffff93d59bb7fb30
> (&inode->i_sb->s_type->i_mutex_dir_key){++++}-{3:3}, at:
> path_openat+0x296/0xa20
> [ 2156.426693]  #2: ffff93d584c366b8 (sb_internal){.+.+}-{0:0}, at:
> xfs_trans_alloc_icreate+0x41/0xd0 [xfs]
> [ 2156.437363]  #3: ffff93d59bb7f8f0
> (&xfs_dir_ilock_class/5){+.+.}-{3:3}, at: xfs_ilock+0xcf/0x290 [xfs]
> [ 2156.447838]  #4: ffff93d5d75f4c60 (hctx->srcu){....}-{0:0}, at:
> hctx_lock+0x51/0xd0
> [ 2156.456386]  #5: ffff93d59d7bc3f0 (&queue->send_mutex){+.+.}-{3:3},
> at: nvme_tcp_queue_rq+0x33e/0x380 [nvme_tcp]
> [ 2156.467748]
>                 stack backtrace:
> [ 2156.472612] CPU: 27 PID: 1496 Comm: fio Not tainted 5.15.0-rc3 #1
> [ 2156.479410] Hardware name: Intel Corporation S2600CP/S2600CP, BIOS
> RMLSDP.86I.R3.27.D685.1305151734 05/15/2013
> [ 2156.490578] Call Trace:
> [ 2156.493312]  dump_stack_lvl+0x57/0x72
> [ 2156.497404]  check_noncircular+0xdf/0x100
> [ 2156.501879]  ? usage_match+0x20/0x20
> [ 2156.505867]  ? __bfs+0xf5/0x230
> [ 2156.509373]  __lock_acquire+0x11fe/0x1e00
> [ 2156.513850]  lock_acquire+0xc4/0x2e0
> [ 2156.517829]  ? tcp_sendpage+0x23/0x80
> [ 2156.521917]  lock_sock_nested+0x2e/0x80
> [ 2156.526199]  ? tcp_sendpage+0x23/0x80
> [ 2156.530285]  tcp_sendpage+0x23/0x80
> [ 2156.534179]  inet_sendpage+0x4f/0x80
> [ 2156.538170]  kernel_sendpage+0x62/0xf0
> [ 2156.542355]  nvme_tcp_try_send+0x128/0x810 [nvme_tcp]
> [ 2156.547994]  ? mutex_trylock+0x13f/0x160
> [ 2156.552374]  ? nvme_tcp_queue_rq+0x33e/0x380 [nvme_tcp]
> [ 2156.558210]  nvme_tcp_queue_rq+0x35a/0x380 [nvme_tcp]
> [ 2156.563850]  __blk_mq_try_issue_directly+0x120/0x1c0
> [ 2156.569395]  blk_mq_try_issue_list_directly+0x157/0x250
> [ 2156.575230]  blk_mq_sched_insert_requests+0x241/0x2a0
> [ 2156.580869]  blk_mq_flush_plug_list+0x114/0x210
> [ 2156.585926]  blk_finish_plug+0x21/0x30
> [ 2156.590110]  _xfs_buf_ioapply+0x30a/0x3c0 [xfs]
> [ 2156.595252]  __xfs_buf_submit+0x92/0x260 [xfs]
> [ 2156.600295]  xfs_buf_read_map+0xe9/0x2a0 [xfs]
> [ 2156.605335]  xfs_trans_read_buf_map+0x1bb/0x550 [xfs]
> [ 2156.611060]  ? xfs_btree_read_buf_block.constprop.0+0x75/0xb0 [xfs]
> [ 2156.618129]  xfs_btree_read_buf_block.constprop.0+0x75/0xb0 [xfs]
> [ 2156.625006]  xfs_btree_lookup_get_block+0x87/0x160 [xfs]
> [ 2156.631008]  xfs_btree_lookup+0x123/0x4d0 [xfs]
> [ 2156.636137]  ? rcu_read_lock_sched_held+0x3f/0x80
> [ 2156.641395]  ? kmem_cache_alloc+0x28a/0x340
> [ 2156.646070]  xfs_dialloc_ag_update_inobt+0x3a/0x180 [xfs]
> [ 2156.652172]  xfs_dialloc+0x43f/0x800 [xfs]
> [ 2156.656822]  ? lock_acquired+0xbc/0x380
> [ 2156.661104]  xfs_create+0x404/0x660 [xfs]
> [ 2156.665663]  xfs_generic_create+0xfa/0x340 [xfs]
> [ 2156.670900]  lookup_open.isra.0+0x537/0x670
> [ 2156.675573]  path_openat+0x2aa/0xa20
> [ 2156.679564]  do_filp_open+0x9f/0x130
> [ 2156.683554]  ? lock_release+0x28a/0x400
> [ 2156.687840]  ? _raw_spin_unlock+0x1f/0x30
> [ 2156.692314]  ? alloc_fd+0x12f/0x1f0
> [ 2156.696210]  do_sys_openat2+0x7a/0x140
> [ 2156.700394]  __x64_sys_openat+0x45/0x70
> [ 2156.704676]  do_syscall_64+0x3b/0x90
> [ 2156.708658]  entry_SYSCALL_64_after_hwframe+0x44/0xae
> [ 2156.714297] RIP: 0033:0x7fcb40bc7584
> [ 2156.718290] Code: 24 20 eb 8f 66 90 44 89 54 24 0c e8 56 8b f8 ff
> 44 8b 54 24 0c 44 89 e2 48 89 ee 41 89 c0 bf 9c ff ff ff b8 01 01 00
> 00 0f 05 <48> 3d 00 f0 ff ff 77 34 44 89 c7 89 44 24 0c e8 98 8b f8 ff
> 8b 44
> [ 2156.739247] RSP: 002b:00007ffda2d2e600 EFLAGS: 00000293 ORIG_RAX:
> 0000000000000101
> [ 2156.747698] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007fcb40bc7584
> [ 2156.755660] RDX: 0000000000000041 RSI: 00007fcb3fad72b0 RDI: 00000000ffffff9c
> [ 2156.763626] RBP: 00007fcb3fad72b0 R08: 0000000000000000 R09: 0000000000000000
> [ 2156.771591] R10: 00000000000001a4 R11: 0000000000000293 R12: 0000000000000041
> [ 2156.779553] R13: 0000000000000000 R14: 00007fcb3fad7110 R15: 000000003b600000
> 

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
