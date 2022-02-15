Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CB2AC433EF
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Feb 2022 04:21:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=JboJ8whtxOkSC1LI9kF95MXaueYec2fA9D8kxif53H0=; b=K5BoqTwPc0d/H2M1m+arvhrP4j
	txr5LyFWEDgOEc7OvXTAmoSMFMWt7cNksSN4HwffEl3E/Xbp4U7jXI9U3zUUgtq/NUL78LaI8hCLs
	G/FH9M8ffI4VjS06psv7Ljnx95rSaw3LS0a6NUrErn2RIo5XkHwl16ocDkdsJrfFmMLdiIoK5fS5t
	krXxdLETqXKl+A1aaROLEKVphjVNCGDdkITLv1nZN55ZIfAaF7tniPfawC1X0vhwotB7f0zMfhRnE
	sCaiSsDEN2qfi3eTAAeudAFhJaldOsaeG40xirY13dQJZ9AbIijqbSp029zaLGI2pHjab5ZdfMSpT
	HfpVyy+Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nJpL7-000BpZ-Gc; Tue, 15 Feb 2022 04:21:21 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nJpL2-000BpC-7Q
 for linux-nvme@lists.infradead.org; Tue, 15 Feb 2022 04:21:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1644898872;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JboJ8whtxOkSC1LI9kF95MXaueYec2fA9D8kxif53H0=;
 b=SEZmiYmjC5EirNoDls6xEfXrY1MlEy2BNBIsyb+Z9hsTNjFgrpBfE1PhacDwMDrqnZ4Jmx
 WLxRLwwa3rNwJf6HBlI3M9THPhKuayou6aj/i3IO1PztYnP9GS3aMLuODlMNWTrtn9iP2o
 gsh0zE+RZvF0on8UTylFbXG9U9B2jS0=
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com
 [209.85.161.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-491-yP3qjgHINCOt2m2NIHH0tg-1; Mon, 14 Feb 2022 23:21:09 -0500
X-MC-Unique: yP3qjgHINCOt2m2NIHH0tg-1
Received: by mail-oo1-f71.google.com with SMTP id
 f8-20020a4aa688000000b002ede70d37dbso11823694oom.16
 for <linux-nvme@lists.infradead.org>; Mon, 14 Feb 2022 20:21:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:references:from:in-reply-to
 :content-transfer-encoding;
 bh=JboJ8whtxOkSC1LI9kF95MXaueYec2fA9D8kxif53H0=;
 b=AjEFAMzWNPdRqB/fneCOzaqeHtn+popyblHwsOW26O49ehNeR20M//0GCZ/jPWvEWm
 g5XlkpC1FDN4wa5s6CdmIbvBPuCT2/mPwCW/pgtT4DjcfPG4vXAlLkn5xZ8jPS2XE0dR
 awjz2AyGP+8coKlNZZf77qVw6KHG5xZTPGHfPcgTmZPk1+nMy9GatUyPEMz9btUM2efl
 WszTh5i7FryyaIg9u/SOkEQ9/5UJF7/oNeKSPPmuQABphSD+owdvRwoJEzsRjtqvZtWp
 FKGBGryVT616XZ3V1LB56oSGwu4x6dWcG5SC4XjGbZkhzLWhXD5zjhT52vEjIJILdluV
 m5JA==
X-Gm-Message-State: AOAM532GjEjgCcW1k9kPEd0lJ8Sxs9nwwL8joPgD/ykGvm8/3eu4wsVa
 yaFVQDD9fcp2OrDqB3aJy7Zq1reU8MgeAm4aIkVc4+0/pHjaBNk9LjZ7yI9FNM9MQsUyWSQMQ89
 K5jix6UidkyK0bWI8e0/k1+U7TYQ=
X-Received: by 2002:a05:6830:4407:: with SMTP id
 q7mr767467otv.76.1644898867950; 
 Mon, 14 Feb 2022 20:21:07 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyuh5scUJ7ZO1VvIaDnXHWjirzcI14qZKv8Kj0WPqcXl/HelyQ/gTkKzCP0EI9anckG5LDyLA==
X-Received: by 2002:a05:6830:4407:: with SMTP id
 q7mr767458otv.76.1644898867554; 
 Mon, 14 Feb 2022 20:21:07 -0800 (PST)
Received: from [192.168.0.14] (97-120-62-247.ptld.qwest.net. [97.120.62.247])
 by smtp.gmail.com with ESMTPSA id
 m14sm14434088ooj.22.2022.02.14.20.21.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 14 Feb 2022 20:21:06 -0800 (PST)
Message-ID: <e6062357-beb7-7150-1e88-1109babcb86a@redhat.com>
Date: Mon, 14 Feb 2022 20:21:03 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [bug report] WARNING: possible circular locking dependency
 detected with blktests nvme-tcp nvme/013
To: Sagi Grimberg <sagi@grimberg.me>, Yi Zhang <yi.zhang@redhat.com>,
 linux-nvme@lists.infradead.org
References: <CAHj4cs9MDYLJ+q+2_GXUK9HxFizv2pxUryUR0toX974M040z7g@mail.gmail.com>
 <71d184e9-503a-1dea-2881-c38f59849209@grimberg.me>
From: Chris Leech <cleech@redhat.com>
In-Reply-To: <71d184e9-503a-1dea-2881-c38f59849209@grimberg.me>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=cleech@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220214_202116_608962_D2FE03A4 
X-CRM114-Status: GOOD (  28.70  )
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

On 9/29/21 4:06 AM, Sagi Grimberg wrote:
>> Hello
>>
>> Bellow warning was triggered with blktests nvme-tcp on latest
>> 5.15.0-rc3, pls help check it.
> 
> Hey Yi, thanks for reporting..
> 
> I'm trying to understand the circular locking here. I'm trying to
> understand if this is due to having an allocation in the
> network send path that may cause a circular dependency.

Hi.  I've spent a bit of time trying to make sense of this lockdep
complaint, and I have a few observations and a few experiments.

First, the stack trace to where lockdep complains is a direct send
from nvme_tcp_queue_request, and holds an impresive number of locks as
you'd expect from a single stack trace that goes from a vfs syscall,
through XFS, the block_mq layers, the nvme driver, and finally into
the tcp code for a sendpage call.

Second, the hypothetical conflicting lock chain involves a setsockopt
syscall which could cause a page fault during a copy_from_user while
holding the sk_lock.  This seems, to me, to be the key to how lockdep
thinks the sk_lock could be held before the various xfs locks.

If that could happen, I suppose that holding a sk_lock waiting for a
page fault to be handled, while that same socket was the transport
path to the storage that needed to be accessed, would be a very bad
thing indeed.  But the socket used by nvme-tcp is never exposed to
userspace, so this looks like a false positive.  And lockdep isn't
complaining about the lock recursing, but a circular dependancy with
the xfs locks.

Experiment #1, disable the direct mode to always send from workqueue
context.  This seperates the sk_lock hold by kernel_sendpage from the
filesystem locks. A quick hack, but it confirms that this breaks the
lockdep cycle.

--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -294,7 +294,7 @@ static inline void nvme_tcp_queue_request(struct
nvme_tcp_request *req,
 	 * directly, otherwise queue io_work. Also, only do that if we
 	 * are on the same cpu, so we don't introduce contention.
 	 */
-	if (queue->io_cpu == raw_smp_processor_id() &&
+	if (false && queue->io_cpu == raw_smp_processor_id() &&
 	    sync && empty && mutex_trylock(&queue->send_mutex)) {
 		queue->more_requests = !last;
 		nvme_tcp_send_all(queue);


Experiment #2, create a dedicated lock_class_key for the socket used
by nvme-tcp.  This seperates lockdep analysis from general AF_INET
socket use.  Becuase the socket used by nvme-tcp is only used from the
kernel interfaces, there's never a copy_from_user with the sk_lock
held.  As an example, the same thing is done by the ceph networking
code for similar reasons.

--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -14,12 +14,17 @@
 #include <linux/blk-mq.h>
 #include <crypto/hash.h>
 #include <net/busy_poll.h>
+#include <linux/lockdep.h>

 #include "nvme.h"
 #include "fabrics.h"

 struct nvme_tcp_queue;

+#ifdef CONFIG_LOCKDEP
+static struct lock_class_key nvme_tcp_socket_class;
+#endif
+
 /* Define the socket priority to use for connections were it is desirable
  * that the NIC consider performing optimized packet processing or
filtering.
  * A non-zero value being sufficient to indicate general
consideration of any
@@ -1427,6 +1432,10 @@ static int nvme_tcp_alloc_queue(struct
nvme_ctrl *nctrl,
 		goto err_destroy_mutex;
 	}

+#ifdef CONFIG_LOCKDEP
+	lockdep_set_class(&queue->sock->sk->sk_lock, &nvme_tcp_socket_class);
+#endif
+
 	/* Single syn retry */
 	tcp_sock_set_syncnt(queue->sock->sk, 1);


I'm not sure why I can't reproduce this with ext4 as the filesystem.

Also, I might have a sleeping function called in atomic context report
with a similar enough call trace to take a closer look at the direct send.

- Chris Leech


>> [ 2153.718873] run blktests nvme/013 at 2021-09-28 07:14:57
>> [ 2154.082894] nvmet: adding nsid 1 to subsystem blktests-subsystem-1
>> [ 2154.116627] nvmet_tcp: enabling port 0 (127.0.0.1:4420)
>> [ 2154.174352] nvmet: creating controller 1 for subsystem
>> blktests-subsystem-1 for NQN
>> nqn.2014-08.org.nvmexpress:uuid:c83e4244a1d04d318ced2447da679f67.
>> [ 2154.196889] nvme nvme0: creating 40 I/O queues.
>> [ 2154.222389] nvme nvme0: mapped 40/0/0 default/read/poll queues.
>> [ 2154.275779] nvme nvme0: new ctrl: NQN "blktests-subsystem-1", addr
>> 127.0.0.1:4420
>> [ 2155.648483] XFS (nvme0n1): Mounting V5 Filesystem
>> [ 2155.717630] XFS (nvme0n1): Ending clean mount
>> [ 2155.734834] xfs filesystem being mounted at /mnt/blktests supports
>> timestamps until 2038 (0x7fffffff)
>>
>> [ 2155.932675] ======================================================
>> [ 2155.939575] WARNING: possible circular locking dependency detected
>> [ 2155.946467] 5.15.0-rc3 #1 Not tainted
>> [ 2155.950551] ------------------------------------------------------
>> [ 2155.957447] fio/1496 is trying to acquire lock:
>> [ 2155.962504] ffff93d58ffe2470 (sk_lock-AF_INET){+.+.}-{0:0}, at:
>> tcp_sendpage+0x23/0x80
>> [ 2155.971355]
>>                 but task is already holding lock:
>> [ 2155.977866] ffff93d59bb7f8f0 (&xfs_dir_ilock_class/5){+.+.}-{3:3},
>> at: xfs_ilock+0xcf/0x290 [xfs]
>> [ 2155.987885]
>>                 which lock already depends on the new lock.
>>
>> [ 2155.997012]
>>                 the existing dependency chain (in reverse order) is:
>> [ 2156.005362]
>>                 -> #3 (&xfs_dir_ilock_class/5){+.+.}-{3:3}:
>> [ 2156.012843]        down_write_nested+0x49/0x120
>> [ 2156.017904]        xfs_ilock+0xcf/0x290 [xfs]
>> [ 2156.022850]        xfs_create+0x1e8/0x660 [xfs]
>> [ 2156.027989]        xfs_generic_create+0xfa/0x340 [xfs]
>> [ 2156.033805]        vfs_mkdir+0x12b/0x1e0
>> [ 2156.038194]        do_mkdirat+0x10a/0x130
>> [ 2156.042669]        __x64_sys_mkdir+0x48/0x70
>> [ 2156.047434]        do_syscall_64+0x3b/0x90
>> [ 2156.052013]        entry_SYSCALL_64_after_hwframe+0x44/0xae
>> [ 2156.058238]
>>                 -> #2 (sb_internal){.+.+}-{0:0}:
>> [ 2156.064654]        xfs_trans_alloc+0x1a1/0x3c0 [xfs]
>> [ 2156.070281]        xfs_vn_update_time+0xc6/0x260 [xfs]
>> [ 2156.076097]        touch_atime+0x129/0x230
>> [ 2156.080672]        xfs_file_mmap+0x84/0x90 [xfs]
>> [ 2156.085906]        mmap_region+0x497/0x6b0
>> [ 2156.090480]        do_mmap+0x362/0x560
>> [ 2156.094663]        vm_mmap_pgoff+0xb8/0x150
>> [ 2156.099330]        ksys_mmap_pgoff+0x198/0x1f0
>> [ 2156.104288]        do_syscall_64+0x3b/0x90
>> [ 2156.108860]        entry_SYSCALL_64_after_hwframe+0x44/0xae
>> [ 2156.115078]
>>                 -> #1 (&mm->mmap_lock#2){++++}-{3:3}:
>> [ 2156.121978]        __might_fault+0x56/0x80
>> [ 2156.126553]        _copy_from_user+0x20/0xa0
>> [ 2156.131327]        ip_setsockopt+0x123d/0x15c0
>> [ 2156.136287]        __sys_setsockopt+0xba/0x1a0
>> [ 2156.141250]        __x64_sys_setsockopt+0x1b/0x20
>> [ 2156.146499]        do_syscall_64+0x3b/0x90
>> [ 2156.151069]        entry_SYSCALL_64_after_hwframe+0x44/0xae
>> [ 2156.157289]
>>                 -> #0 (sk_lock-AF_INET){+.+.}-{0:0}:
>> [ 2156.164093]        __lock_acquire+0x11fe/0x1e00
>> [ 2156.169154]        lock_acquire+0xc4/0x2e0
>> [ 2156.173727]        lock_sock_nested+0x2e/0x80
>> [ 2156.178593]        tcp_sendpage+0x23/0x80
>> [ 2156.183068]        inet_sendpage+0x4f/0x80
>> [ 2156.187645]        kernel_sendpage+0x62/0xf0
>> [ 2156.192413]        nvme_tcp_try_send+0x128/0x810 [nvme_tcp]
>> [ 2156.198633]        nvme_tcp_queue_rq+0x35a/0x380 [nvme_tcp]
>> [ 2156.204853]        __blk_mq_try_issue_directly+0x120/0x1c0
>> [ 2156.210983]        blk_mq_try_issue_list_directly+0x157/0x250
>> [ 2156.217400]        blk_mq_sched_insert_requests+0x241/0x2a0
>> [ 2156.223620]        blk_mq_flush_plug_list+0x114/0x210
>> [ 2156.229256]        blk_finish_plug+0x21/0x30
>> [ 2156.234028]        _xfs_buf_ioapply+0x30a/0x3c0 [xfs]
>> [ 2156.239747]        __xfs_buf_submit+0x92/0x260 [xfs]
>> [ 2156.245360]        xfs_buf_read_map+0xe9/0x2a0 [xfs]
>> [ 2156.250969]        xfs_trans_read_buf_map+0x1bb/0x550 [xfs]
>> [ 2156.257274]        xfs_btree_read_buf_block.constprop.0+0x75/0xb0
>> [xfs]
>> [ 2156.264732]        xfs_btree_lookup_get_block+0x87/0x160 [xfs]
>> [ 2156.271316]        xfs_btree_lookup+0x123/0x4d0 [xfs]
>> [ 2156.277027]        xfs_dialloc_ag_update_inobt+0x3a/0x180 [xfs]
>> [ 2156.283709]        xfs_dialloc+0x43f/0x800 [xfs]
>> [ 2156.288938]        xfs_create+0x404/0x660 [xfs]
>> [ 2156.294075]        xfs_generic_create+0xfa/0x340 [xfs]
>> [ 2156.299891]        lookup_open.isra.0+0x537/0x670
>> [ 2156.305141]        path_openat+0x2aa/0xa20
>> [ 2156.309713]        do_filp_open+0x9f/0x130
>> [ 2156.314290]        do_sys_openat2+0x7a/0x140
>> [ 2156.319057]        __x64_sys_openat+0x45/0x70
>> [ 2156.323918]        do_syscall_64+0x3b/0x90
>> [ 2156.328491]        entry_SYSCALL_64_after_hwframe+0x44/0xae
>> [ 2156.334712]
>>                 other info that might help us debug this:
>>
>> [ 2156.343644] Chain exists of:
>>                   sk_lock-AF_INET --> sb_internal -->
>> &xfs_dir_ilock_class/5
>>
>> [ 2156.355972]  Possible unsafe locking scenario:
>>
>> [ 2156.362579]        CPU0                    CPU1
>> [ 2156.367632]        ----                    ----
>> [ 2156.372685]   lock(&xfs_dir_ilock_class/5);
>> [ 2156.377351]                                lock(sb_internal);
>> [ 2156.383764]                               
>> lock(&xfs_dir_ilock_class/5);
>> [ 2156.391242]   lock(sk_lock-AF_INET);
>> [ 2156.395230]
>>                  *** DEADLOCK ***
>>
>> [ 2156.401834] 6 locks held by fio/1496:
>> [ 2156.405919]  #0: ffff93d584c36498 (sb_writers#13){.+.+}-{0:0}, at:
>> path_openat+0x9fc/0xa20
>> [ 2156.415147]  #1: ffff93d59bb7fb30
>> (&inode->i_sb->s_type->i_mutex_dir_key){++++}-{3:3}, at:
>> path_openat+0x296/0xa20
>> [ 2156.426693]  #2: ffff93d584c366b8 (sb_internal){.+.+}-{0:0}, at:
>> xfs_trans_alloc_icreate+0x41/0xd0 [xfs]
>> [ 2156.437363]  #3: ffff93d59bb7f8f0
>> (&xfs_dir_ilock_class/5){+.+.}-{3:3}, at: xfs_ilock+0xcf/0x290 [xfs]
>> [ 2156.447838]  #4: ffff93d5d75f4c60 (hctx->srcu){....}-{0:0}, at:
>> hctx_lock+0x51/0xd0
>> [ 2156.456386]  #5: ffff93d59d7bc3f0 (&queue->send_mutex){+.+.}-{3:3},
>> at: nvme_tcp_queue_rq+0x33e/0x380 [nvme_tcp]
>> [ 2156.467748]
>>                 stack backtrace:
>> [ 2156.472612] CPU: 27 PID: 1496 Comm: fio Not tainted 5.15.0-rc3 #1
>> [ 2156.479410] Hardware name: Intel Corporation S2600CP/S2600CP, BIOS
>> RMLSDP.86I.R3.27.D685.1305151734 05/15/2013
>> [ 2156.490578] Call Trace:
>> [ 2156.493312]  dump_stack_lvl+0x57/0x72
>> [ 2156.497404]  check_noncircular+0xdf/0x100
>> [ 2156.501879]  ? usage_match+0x20/0x20
>> [ 2156.505867]  ? __bfs+0xf5/0x230
>> [ 2156.509373]  __lock_acquire+0x11fe/0x1e00
>> [ 2156.513850]  lock_acquire+0xc4/0x2e0
>> [ 2156.517829]  ? tcp_sendpage+0x23/0x80
>> [ 2156.521917]  lock_sock_nested+0x2e/0x80
>> [ 2156.526199]  ? tcp_sendpage+0x23/0x80
>> [ 2156.530285]  tcp_sendpage+0x23/0x80
>> [ 2156.534179]  inet_sendpage+0x4f/0x80
>> [ 2156.538170]  kernel_sendpage+0x62/0xf0
>> [ 2156.542355]  nvme_tcp_try_send+0x128/0x810 [nvme_tcp]
>> [ 2156.547994]  ? mutex_trylock+0x13f/0x160
>> [ 2156.552374]  ? nvme_tcp_queue_rq+0x33e/0x380 [nvme_tcp]
>> [ 2156.558210]  nvme_tcp_queue_rq+0x35a/0x380 [nvme_tcp]
>> [ 2156.563850]  __blk_mq_try_issue_directly+0x120/0x1c0
>> [ 2156.569395]  blk_mq_try_issue_list_directly+0x157/0x250
>> [ 2156.575230]  blk_mq_sched_insert_requests+0x241/0x2a0
>> [ 2156.580869]  blk_mq_flush_plug_list+0x114/0x210
>> [ 2156.585926]  blk_finish_plug+0x21/0x30
>> [ 2156.590110]  _xfs_buf_ioapply+0x30a/0x3c0 [xfs]
>> [ 2156.595252]  __xfs_buf_submit+0x92/0x260 [xfs]
>> [ 2156.600295]  xfs_buf_read_map+0xe9/0x2a0 [xfs]
>> [ 2156.605335]  xfs_trans_read_buf_map+0x1bb/0x550 [xfs]
>> [ 2156.611060]  ? xfs_btree_read_buf_block.constprop.0+0x75/0xb0 [xfs]
>> [ 2156.618129]  xfs_btree_read_buf_block.constprop.0+0x75/0xb0 [xfs]
>> [ 2156.625006]  xfs_btree_lookup_get_block+0x87/0x160 [xfs]
>> [ 2156.631008]  xfs_btree_lookup+0x123/0x4d0 [xfs]
>> [ 2156.636137]  ? rcu_read_lock_sched_held+0x3f/0x80
>> [ 2156.641395]  ? kmem_cache_alloc+0x28a/0x340
>> [ 2156.646070]  xfs_dialloc_ag_update_inobt+0x3a/0x180 [xfs]
>> [ 2156.652172]  xfs_dialloc+0x43f/0x800 [xfs]
>> [ 2156.656822]  ? lock_acquired+0xbc/0x380
>> [ 2156.661104]  xfs_create+0x404/0x660 [xfs]
>> [ 2156.665663]  xfs_generic_create+0xfa/0x340 [xfs]
>> [ 2156.670900]  lookup_open.isra.0+0x537/0x670
>> [ 2156.675573]  path_openat+0x2aa/0xa20
>> [ 2156.679564]  do_filp_open+0x9f/0x130
>> [ 2156.683554]  ? lock_release+0x28a/0x400
>> [ 2156.687840]  ? _raw_spin_unlock+0x1f/0x30
>> [ 2156.692314]  ? alloc_fd+0x12f/0x1f0
>> [ 2156.696210]  do_sys_openat2+0x7a/0x140
>> [ 2156.700394]  __x64_sys_openat+0x45/0x70
>> [ 2156.704676]  do_syscall_64+0x3b/0x90
>> [ 2156.708658]  entry_SYSCALL_64_after_hwframe+0x44/0xae
>> [ 2156.714297] RIP: 0033:0x7fcb40bc7584
>> [ 2156.718290] Code: 24 20 eb 8f 66 90 44 89 54 24 0c e8 56 8b f8 ff
>> 44 8b 54 24 0c 44 89 e2 48 89 ee 41 89 c0 bf 9c ff ff ff b8 01 01 00
>> 00 0f 05 <48> 3d 00 f0 ff ff 77 34 44 89 c7 89 44 24 0c e8 98 8b f8 ff
>> 8b 44
>> [ 2156.739247] RSP: 002b:00007ffda2d2e600 EFLAGS: 00000293 ORIG_RAX:
>> 0000000000000101
>> [ 2156.747698] RAX: ffffffffffffffda RBX: 0000000000000000 RCX:
>> 00007fcb40bc7584
>> [ 2156.755660] RDX: 0000000000000041 RSI: 00007fcb3fad72b0 RDI:
>> 00000000ffffff9c
>> [ 2156.763626] RBP: 00007fcb3fad72b0 R08: 0000000000000000 R09:
>> 0000000000000000
>> [ 2156.771591] R10: 00000000000001a4 R11: 0000000000000293 R12:
>> 0000000000000041
>> [ 2156.779553] R13: 0000000000000000 R14: 00007fcb3fad7110 R15:
>> 000000003b600000
>>
> 
> _______________________________________________
> Linux-nvme mailing list
> Linux-nvme@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-nvme
> 


