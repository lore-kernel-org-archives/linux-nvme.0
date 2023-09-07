Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05D48EE14D4
	for <linux-nvme@archiver.kernel.org>; Thu,  7 Sep 2023 06:41:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/DYWpmm5mh8+SC+J6EVvhKyCbDMTDPlOWZLMJWDMRJw=; b=aHF6Ve2nNy50Lw26S85wNcV5W2
	81PD3ZYJRnUo3IqLrhQ35PdmWQx41MTuvrjWovgRabA6Nz8EKadGOsZrI6Da3NfSCkTt1I3b7t4X+
	mYbIr4mqOqEA4auyfWIgTsf1izKuOoTz8WAOX/UUXdj3wRHk9wVBqOS/Wxbg1iK6xESZ+Cry3TbpO
	RslAkevbsZ0x2RCYHYDCgpNdJX7CR+HFQA/nZMpXZWJPCjlj7xYJOmZTqDqyBtTOmUQB5+h9xSmud
	OgCBmziShVM0EupB+A8V4ScprAvc0ws0urrwiy0cwg0/gi88ygaivBGi2sXdxjKixuOF4+zsBmmwc
	/x6ntjOg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qe8hw-00BRiR-3C;
	Thu, 07 Sep 2023 06:41:40 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qe8ht-00BRi1-1N
	for linux-nvme@lists.infradead.org;
	Thu, 07 Sep 2023 06:41:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1694068895;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/DYWpmm5mh8+SC+J6EVvhKyCbDMTDPlOWZLMJWDMRJw=;
	b=OF3lmFszFIOgFmtPZqTy/9dd7Pa8P7dIK9yF1QVsHnrRVQosLKwb66n7+ttrRC0wftCHva
	0UKi5CBmmLCtAa6Vtv1hafVEmMLGAn6j2Bg7Om+moLAuStW5VDN4Qk4LTfEwhcVnC8ymZC
	qwsTB/GfwonOKiKYNaCxqBlpOvH4uys=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-681-Xvny-dq6MJyLFCvStnZCMg-1; Thu, 07 Sep 2023 02:41:34 -0400
X-MC-Unique: Xvny-dq6MJyLFCvStnZCMg-1
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-26d52dc97e3so810130a91.2
        for <linux-nvme@lists.infradead.org>; Wed, 06 Sep 2023 23:41:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694068893; x=1694673693;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/DYWpmm5mh8+SC+J6EVvhKyCbDMTDPlOWZLMJWDMRJw=;
        b=bW02ow9rNAsLw4BiztNBpW9Vt1w2KZzOdcy57ASb9g4Xsu6zNojtNjiDsrE+BAUUB+
         RBoB3DQg4BNeeU38nzvMrT5uK4Lio4Bqwm0qZN3quhwuGKAbqJ4OSjAx1DVYFU5L+a6A
         Dqec4G7pDq13JPv5vEeUaQ7dUaCoQ5O4pBjDOUWHNoJXlvExL+Vsnv0HN7+hYCq3iI9h
         lHsXIY2w8oF0U51i70VRoA111KngXmf4RTHXBtkIvOGT0k2+uhrEzHKgzC646gMrKLU1
         IGYnEwde8JzuwaUWm/3xICTEfZl8IKlmJkVdQSv4iROZLRxPhJLJ8DY9kUtf8Pr/nQKA
         JZbw==
X-Gm-Message-State: AOJu0YwKxYaJ0yMee9qoz2UwulR+//PQ0KzE/1sPUfwBenaIRb3Mc3LN
	naV6JL+HOBBuOXC7XKK04dh5E2Ix7Tdl2DFhxUGPwqizh1Dxww8mwhC0jpupxhkgu1UYauEp/Ub
	HAljkb7/jEfJdNuOxjFUsVN17tLVYr8naT+gL4AXBsS4=
X-Received: by 2002:a17:90b:38c1:b0:26b:4e40:7be8 with SMTP id nn1-20020a17090b38c100b0026b4e407be8mr15336842pjb.12.1694068892922;
        Wed, 06 Sep 2023 23:41:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF+5rV/zuI2wu5eJ+L05b9to+On9mhbd/zAU4Luaj8vftoasdufxI2KjUnLo2lWELQM6YTSWYTmvpH0Ms06T/k=
X-Received: by 2002:a17:90b:38c1:b0:26b:4e40:7be8 with SMTP id
 nn1-20020a17090b38c100b0026b4e407be8mr15336825pjb.12.1694068892514; Wed, 06
 Sep 2023 23:41:32 -0700 (PDT)
MIME-Version: 1.0
References: <20230726142939.10062-1-guoqing.jiang@linux.dev>
In-Reply-To: <20230726142939.10062-1-guoqing.jiang@linux.dev>
From: Yi Zhang <yi.zhang@redhat.com>
Date: Thu, 7 Sep 2023 14:41:20 +0800
Message-ID: <CAHj4cs9LppxseFzZe-fj7tDaeKd0x8t8Wr-aYcjXAU-8FyfoiQ@mail.gmail.com>
Subject: Re: [PATCH RFC] nvmet-tcp: add new workqueue to surpress lockdep warning
To: Guoqing Jiang <guoqing.jiang@linux.dev>
Cc: hch@lst.de, sagi@grimberg.me, kch@nvidia.com, 
	linux-nvme@lists.infradead.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230906_234137_630667_A9D820E0 
X-CRM114-Status: GOOD (  13.52  )
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

Tested-by: Yi Zhang <yi.zhang@redhat.com>

Confirmed below issue was fixed by this patch:

[ 2339.107020] run blktests nvme/003 at 2023-09-06 02:59:42
[ 2339.329435] loop0: detected capacity change from 0 to 2097152
[ 2339.390344] nvmet: adding nsid 1 to subsystem blktests-subsystem-1
[ 2339.464673] nvmet_tcp: enabling port 0 (127.0.0.1:4420)
[ 2339.614626] nvmet: creating discovery controller 1 for subsystem
nqn.2014-08.org.nvmexpress.discovery for NQN
nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349.
[ 2339.638614] nvme nvme2: new ctrl: NQN
"nqn.2014-08.org.nvmexpress.discovery", addr 127.0.0.1:4420
[ 2352.871974] nvme nvme2: Removing ctrl: NQN
"nqn.2014-08.org.nvmexpress.discovery"

[ 2352.885895] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
[ 2352.892073] WARNING: possible circular locking dependency detected
[ 2352.898253] 6.5.0+ #1 Not tainted
[ 2352.901572] ------------------------------------------------------
[ 2352.907753] kworker/13:1/12602 is trying to acquire lock:
[ 2352.913151] ffff888188a07030
((work_completion)(&queue->io_work)){+.+.}-{0:0}, at:
__flush_work+0xb3/0x190
[ 2352.922812]
               but task is already holding lock:
[ 2352.928647] ffffc90007587da0
((work_completion)(&queue->release_work)){+.+.}-{0:0}, at:
process_one_work+0x83a/0x1660
[ 2352.939262]
               which lock already depends on the new lock.

[ 2352.947436]
               the existing dependency chain (in reverse order) is:
[ 2352.954914]
               -> #2 ((work_completion)(&queue->release_work)){+.+.}-{0:0}:
[ 2352.963095]        __lock_acquire+0xbd6/0x1c00
[ 2352.967550]        lock_acquire+0x1da/0x5e0
[ 2352.971737]        process_one_work+0x884/0x1660
[ 2352.976355]        worker_thread+0x5be/0xef0
[ 2352.980626]        kthread+0x2f4/0x3d0
[ 2352.984379]        ret_from_fork+0x30/0x70
[ 2352.988478]        ret_from_fork_asm+0x1b/0x30
[ 2352.992924]
               -> #1 ((wq_completion)nvmet-wq){+.+.}-{0:0}:
[ 2352.999719]        __lock_acquire+0xbd6/0x1c00
[ 2353.004166]        lock_acquire+0x1da/0x5e0
[ 2353.008352]        __flush_workqueue+0x101/0x1230
[ 2353.013056]        nvmet_tcp_install_queue+0x6e/0x2a0 [nvmet_tcp]
[ 2353.019160]        nvmet_install_queue+0x331/0x830 [nvmet]
[ 2353.024662]        nvmet_execute_admin_connect+0x348/0x7f0 [nvmet]
[ 2353.030859]        nvmet_tcp_try_recv.constprop.0+0x689/0x870 [nvmet_tcp=
]
[ 2353.037652]        nvmet_tcp_io_work+0xb4/0x19d0 [nvmet_tcp]
[ 2353.043322]        process_one_work+0x955/0x1660
[ 2353.047938]        worker_thread+0x5be/0xef0
[ 2353.052214]        kthread+0x2f4/0x3d0
[ 2353.055965]        ret_from_fork+0x30/0x70
[ 2353.060063]        ret_from_fork_asm+0x1b/0x30
[ 2353.064510]
               -> #0 ((work_completion)(&queue->io_work)){+.+.}-{0:0}:
[ 2353.072259]        check_prev_add+0x1bd/0x23a0
[ 2353.076704]        validate_chain+0xb02/0xf30
[ 2353.081062]        __lock_acquire+0xbd6/0x1c00
[ 2353.085508]        lock_acquire+0x1da/0x5e0
[ 2353.089694]        __flush_work+0xd3/0x190
[ 2353.093793]        __cancel_work_timer+0x31a/0x460
[ 2353.098585]        nvmet_tcp_release_queue_work+0x2e3/0x1310 [nvmet_tcp]
[ 2353.105296]        process_one_work+0x955/0x1660
[ 2353.109913]        worker_thread+0x5be/0xef0
[ 2353.114186]        kthread+0x2f4/0x3d0
[ 2353.117938]        ret_from_fork+0x30/0x70
[ 2353.122039]        ret_from_fork_asm+0x1b/0x30
[ 2353.126483]
               other info that might help us debug this:

[ 2353.134483] Chain exists of:
                 (work_completion)(&queue->io_work) -->
(wq_completion)nvmet-wq --> (work_completion)(&queue->release_work)

[ 2353.149691]  Possible unsafe locking scenario:

[ 2353.155613]        CPU0                    CPU1
[ 2353.160144]        ----                    ----
[ 2353.164676]   lock((work_completion)(&queue->release_work));
[ 2353.170337]                                lock((wq_completion)nvmet-wq)=
;
[ 2353.177132]
lock((work_completion)(&queue->release_work));
[ 2353.185311]   lock((work_completion)(&queue->io_work));
[ 2353.190538]
                *** DEADLOCK ***

[ 2353.196458] 2 locks held by kworker/13:1/12602:
[ 2353.200989]  #0: ffff8882403be548
((wq_completion)nvmet-wq){+.+.}-{0:0}, at:
process_one_work+0x80c/0x1660
[ 2353.210651]  #1: ffffc90007587da0
((work_completion)(&queue->release_work)){+.+.}-{0:0}, at:
process_one_work+0x83a/0x1660
[ 2353.221702]
               stack backtrace:
[ 2353.226061] CPU: 13 PID: 12602 Comm: kworker/13:1 Not tainted 6.5.0+ #1
[ 2353.232675] Hardware name: Dell Inc. PowerEdge R6515/07PXPY, BIOS
2.11.4 03/22/2023
[ 2353.240328] Workqueue: nvmet-wq nvmet_tcp_release_queue_work [nvmet_tcp]
[ 2353.247035] Call Trace:
[ 2353.249487]  <TASK>
[ 2353.251594]  dump_stack_lvl+0x60/0xb0
[ 2353.255270]  check_noncircular+0x2f9/0x3e0
[ 2353.259376]  ? srso_return_thunk+0x5/0x10
[ 2353.263398]  ? check_path.constprop.0+0x24/0x50
[ 2353.267933]  ? __pfx_check_noncircular+0x10/0x10
[ 2353.272559]  ? __pfx_check_noncircular+0x10/0x10
[ 2353.277175]  ? ret_from_fork_asm+0x1b/0x30
[ 2353.281275]  ? __pfx_stack_trace_consume_entry+0x10/0x10
[ 2353.286597]  ? srso_return_thunk+0x5/0x10
[ 2353.290616]  check_prev_add+0x1bd/0x23a0
[ 2353.294554]  validate_chain+0xb02/0xf30
[ 2353.298402]  ? __pfx_validate_chain+0x10/0x10
[ 2353.302759]  ? __pfx_validate_chain+0x10/0x10
[ 2353.307120]  ? srso_return_thunk+0x5/0x10
[ 2353.311141]  __lock_acquire+0xbd6/0x1c00
[ 2353.315080]  lock_acquire+0x1da/0x5e0
[ 2353.318749]  ? __flush_work+0xb3/0x190
[ 2353.322504]  ? srso_return_thunk+0x5/0x10
[ 2353.326516]  ? __pfx_lock_acquire+0x10/0x10
[ 2353.330710]  ? __lock_acquired+0x207/0x7b0
[ 2353.334810]  ? __pfx___lock_release+0x10/0x10
[ 2353.339169]  ? __pfx___lock_acquired+0x10/0x10
[ 2353.343616]  ? do_raw_spin_trylock+0xb5/0x180
[ 2353.347983]  ? __pfx_do_raw_spin_trylock+0x10/0x10
[ 2353.352780]  __flush_work+0xd3/0x190
[ 2353.356360]  ? __flush_work+0xb3/0x190
[ 2353.360115]  ? find_held_lock+0x33/0x120
[ 2353.364040]  ? __pfx___flush_work+0x10/0x10
[ 2353.368229]  ? srso_return_thunk+0x5/0x10
[ 2353.372246]  ? __lock_release+0x48a/0x960
[ 2353.376263]  ? srso_return_thunk+0x5/0x10
[ 2353.380281]  ? mark_lock.part.0+0xca/0xab0
[ 2353.384384]  ? __pfx_mark_lock.part.0+0x10/0x10
[ 2353.388920]  ? __pfx_do_raw_spin_trylock+0x10/0x10
[ 2353.393723]  ? srso_return_thunk+0x5/0x10
[ 2353.397735]  ? mark_held_locks+0xa5/0xf0
[ 2353.401669]  __cancel_work_timer+0x31a/0x460
[ 2353.405944]  ? __pfx___cancel_work_timer+0x10/0x10
[ 2353.410734]  ? __pfx___lock_release+0x10/0x10
[ 2353.415101]  ? srso_return_thunk+0x5/0x10
[ 2353.419114]  ? mark_held_locks+0xa5/0xf0
[ 2353.423043]  ? __local_bh_enable_ip+0xa5/0x120
[ 2353.427498]  ? __pfx_sk_stream_write_space+0x10/0x10
[ 2353.432474]  nvmet_tcp_release_queue_work+0x2e3/0x1310 [nvmet_tcp]
[ 2353.438666]  process_one_work+0x955/0x1660
[ 2353.442775]  ? __lock_acquired+0x207/0x7b0
[ 2353.446874]  ? __pfx_process_one_work+0x10/0x10
[ 2353.451409]  ? __pfx___lock_acquired+0x10/0x10
[ 2353.455869]  ? worker_thread+0x15a/0xef0
[ 2353.459801]  worker_thread+0x5be/0xef0
[ 2353.463568]  ? srso_return_thunk+0x5/0x10
[ 2353.467587]  ? __pfx_worker_thread+0x10/0x10
[ 2353.471864]  kthread+0x2f4/0x3d0
[ 2353.475102]  ? __pfx_kthread+0x10/0x10
[ 2353.478856]  ret_from_fork+0x30/0x70
[ 2353.482441]  ? __pfx_kthread+0x10/0x10
[ 2353.486195]  ret_from_fork_asm+0x1b/0x30
[ 2353.490135]  </TASK>



On Wed, Jul 26, 2023 at 10:33=E2=80=AFPM Guoqing Jiang <guoqing.jiang@linux=
.dev> wrote:
>
> During the test of nvme-tcp, lockdep complains when discover local
> nvme tcp device.
>
> [   87.699136] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> [   87.699137] WARNING: possible circular locking dependency detected
> [   87.699138] 6.5.0-rc3+ #16 Tainted: G            E
> [   87.699139] ------------------------------------------------------
> [   87.699140] kworker/0:4H/1522 is trying to acquire lock:
> [   87.699141] ffff93c4df45f538 ((wq_completion)nvmet-wq){+.+.}-{0:0}, at=
: __flush_workqueue+0x99/0x4f0
> [   87.699147]
>                but task is already holding lock:
> [   87.699148] ffffafb40272fe40 ((work_completion)(&queue->io_work)){+.+.=
}-{0:0}, at: process_one_work+0x236/0x590
> [   87.699151]
>                which lock already depends on the new lock.
> [   87.699152]
>                the existing dependency chain (in reverse order) is:
> [   87.699153]
>                -> #2 ((work_completion)(&queue->io_work)){+.+.}-{0:0}:
> [   87.699155]        __flush_work+0x7a/0x5c0
> [   87.699157]        __cancel_work_timer+0x155/0x1e0
> [   87.699158]        cancel_work_sync+0x10/0x20
> [   87.699160]        nvmet_tcp_release_queue_work+0xcf/0x490 [nvmet_tcp]
> [   87.699163]        process_one_work+0x2bd/0x590
> [   87.699165]        worker_thread+0x52/0x3f0
> [   87.699166]        kthread+0x109/0x140
> [   87.699168]        ret_from_fork+0x46/0x70
> [   87.699170]        ret_from_fork_asm+0x1b/0x30
> [   87.699172]
>                -> #1 ((work_completion)(&queue->release_work)){+.+.}-{0:0=
}:
> [   87.699174]        process_one_work+0x28c/0x590
> [   87.699175]        worker_thread+0x52/0x3f0
> [   87.699177]        kthread+0x109/0x140
> [   87.699177]        ret_from_fork+0x46/0x70
> [   87.699179]        ret_from_fork_asm+0x1b/0x30
> [   87.699180]
>                -> #0 ((wq_completion)nvmet-wq){+.+.}-{0:0}:
> [   87.699182]        __lock_acquire+0x1523/0x2590
> [   87.699184]        lock_acquire+0xd6/0x2f0
> [   87.699185]        __flush_workqueue+0xc5/0x4f0
> [   87.699187]        nvmet_tcp_install_queue+0x30/0x160 [nvmet_tcp]
> [   87.699189]        nvmet_install_queue+0xbf/0x200 [nvmet]
> [   87.699196]        nvmet_execute_admin_connect+0x18b/0x2f0 [nvmet]
> [   87.699200]        nvmet_tcp_io_work+0x7e3/0x850 [nvmet_tcp]
> [   87.699203]        process_one_work+0x2bd/0x590
> [   87.699204]        worker_thread+0x52/0x3f0
> [   87.699206]        kthread+0x109/0x140
> [   87.699207]        ret_from_fork+0x46/0x70
> [   87.699208]        ret_from_fork_asm+0x1b/0x30
> [   87.699209]
>                other info that might help us debug this:
> [   87.699210] Chain exists of:
>                  (wq_completion)nvmet-wq --> (work_completion)(&queue->re=
lease_work) --> (work_completion)(&queue->io_work)
> [   87.699212]  Possible unsafe locking scenario:
> [   87.699213]        CPU0                    CPU1
> [   87.699214]        ----                    ----
> [   87.699214]   lock((work_completion)(&queue->io_work));
> [   87.699215]                                lock((work_completion)(&que=
ue->release_work));
> [   87.699217]                                lock((work_completion)(&que=
ue->io_work));
> [   87.699218]   lock((wq_completion)nvmet-wq);
>                         -> need to hold release_work since queue_work(nvm=
et_wq, &queue->release_work)
> [   87.699219]
>                 *** DEADLOCK ***
> [   87.699220] 2 locks held by kworker/0:4H/1522:
> [   87.699221]  #0: ffff93c4df45f338 ((wq_completion)nvmet_tcp_wq){+.+.}-=
{0:0}, at: process_one_work+0x236/0x590
> [   87.699224]  #1: ffffafb40272fe40 ((work_completion)(&queue->io_work))=
{+.+.}-{0:0}, at: process_one_work+0x236/0x590
> [   87.699227]
>                stack backtrace:
> [   87.699229] CPU: 0 PID: 1522 Comm: kworker/0:4H Tainted: G            =
E      6.5.0-rc3+ #16
> [   87.699230] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS r=
el-1.16.0-0-gd239552c-rebuilt.opensuse.org 04/01/2014
> [   87.699231] Workqueue: nvmet_tcp_wq nvmet_tcp_io_work [nvmet_tcp]
>
> The above happens because nvmet_tcp_io_work can trigger below path
>
>         -> nvmet_tcp_try_recv
>          -> nvmet_tcp_try_recv_one
>           -> nvmet_tcp_try_recv_data
>            -> nvmet_tcp_execute_request
>             -> cmd->req.execute =3D nvmet_execute_admin_connect
>              -> nvmet_install_queue
>               -> ctrl->ops->install_queue =3D nvmet_install_queue
>                -> nvmet_tcp_install_queue
>                 -> flush_workqueue(nvmet_wq)
>
> And release_work (nvmet_tcp_release_queue_work) is also queued in
> nvmet_wq, which need to flush io_work (nvmet_tcp_io_work) due to
> cancel_work_sync(&queue->io_work).
>
> We can surpress the lockdep warning by checking if the relevant work
> is pending. So the simplest might be just add the checking before
> flush_workqueue(nvmet_wq). However, there are other works are also
> queued on the same queue, I am not sure if we should flush other
> works unconditionally, so a new dedicated workqueue is added.
>
> Signed-off-by: Guoqing Jiang <guoqing.jiang@linux.dev>
> ---
>  drivers/nvme/target/tcp.c | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
> index 868aa4de2e4c..ac611cb299a8 100644
> --- a/drivers/nvme/target/tcp.c
> +++ b/drivers/nvme/target/tcp.c
> @@ -189,6 +189,7 @@ static LIST_HEAD(nvmet_tcp_queue_list);
>  static DEFINE_MUTEX(nvmet_tcp_queue_mutex);
>
>  static struct workqueue_struct *nvmet_tcp_wq;
> +static struct workqueue_struct *nvmet_tcp_release_wq;
>  static const struct nvmet_fabrics_ops nvmet_tcp_ops;
>  static void nvmet_tcp_free_cmd(struct nvmet_tcp_cmd *c);
>  static void nvmet_tcp_free_cmd_buffers(struct nvmet_tcp_cmd *cmd);
> @@ -1288,7 +1289,7 @@ static void nvmet_tcp_schedule_release_queue(struct=
 nvmet_tcp_queue *queue)
>         spin_lock(&queue->state_lock);
>         if (queue->state !=3D NVMET_TCP_Q_DISCONNECTING) {
>                 queue->state =3D NVMET_TCP_Q_DISCONNECTING;
> -               queue_work(nvmet_wq, &queue->release_work);
> +               queue_work(nvmet_tcp_release_wq, &queue->release_work);
>         }
>         spin_unlock(&queue->state_lock);
>  }
> @@ -1847,6 +1848,8 @@ static u16 nvmet_tcp_install_queue(struct nvmet_sq =
*sq)
>         if (sq->qid =3D=3D 0) {
>                 /* Let inflight controller teardown complete */
>                 flush_workqueue(nvmet_wq);
> +               if (work_pending(&queue->release_work))
> +                       flush_workqueue(nvmet_tcp_release_wq);
>         }
>
>         queue->nr_cmds =3D sq->size * 2;
> @@ -1892,12 +1895,20 @@ static int __init nvmet_tcp_init(void)
>         if (!nvmet_tcp_wq)
>                 return -ENOMEM;
>
> +       nvmet_tcp_release_wq =3D alloc_workqueue("nvmet_tcp_release_wq",
> +                               WQ_MEM_RECLAIM, 0);
> +       if (!nvmet_tcp_release_wq) {
> +               destroy_workqueue(nvmet_tcp_wq);
> +               return -ENOMEM;
> +       }
> +
>         ret =3D nvmet_register_transport(&nvmet_tcp_ops);
>         if (ret)
>                 goto err;
>
>         return 0;
>  err:
> +       destroy_workqueue(nvmet_tcp_release_wq);
>         destroy_workqueue(nvmet_tcp_wq);
>         return ret;
>  }
> @@ -1915,6 +1926,7 @@ static void __exit nvmet_tcp_exit(void)
>         mutex_unlock(&nvmet_tcp_queue_mutex);
>         flush_workqueue(nvmet_wq);
>
> +       destroy_workqueue(nvmet_tcp_release_wq);
>         destroy_workqueue(nvmet_tcp_wq);
>  }
>
> --
> 2.34.1
>
>


--=20
Best Regards,
  Yi Zhang


