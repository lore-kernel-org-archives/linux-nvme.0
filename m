Return-Path: <SRS0=LBLG=7C=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFB75C433E0
	for <linux-nvme@archiver.kernel.org>; Wed, 20 May 2020 22:56:05 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8861820708
	for <linux-nvme@archiver.kernel.org>; Wed, 20 May 2020 22:56:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="g+D8ifkJ";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JnsjJ3d0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8861820708
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=MWB/aDNCwUOgck1dgbBKydP6IV6keO1cmgThXc3d84A=; b=g+D8ifkJ55L8lBy4M3n0gmQC3
	/vlqdh+lLvK5yq0vsxMA1cyj/xZPCVuUkNEiyqluIfefwkUshm20OTmW978khywi1vHQasHdiJtQR
	pWNX7N7Yhrx2oXzJdmF45zQCi85fkx53QCN28V3KZqMFQnZckp7EvCsazohW/r4vQkD6pwi36DUJ/
	0o9baqXQJhRt2eazFx9w+hTQfj2t2sdRixidnJ7v7ULpvWzf1gLR0g8dzMRbe+KveLpQCRlwnPBGc
	U2/xT01lgs21X2FHtY/3Yf0p4X1O4Ya0o0CGjnCf1OAYd+zA76C2Fs8BnsYX/OgkBR7rrtDDzgQMy
	RQLi77I4g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jbXd1-0000cm-OC; Wed, 20 May 2020 22:55:59 +0000
Received: from us-smtp-1.mimecast.com ([205.139.110.61]
 helo=us-smtp-delivery-1.mimecast.com)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jbXcx-0000bm-E8
 for linux-nvme@lists.infradead.org; Wed, 20 May 2020 22:55:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590015352;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aMLIFdit9hMtWPO7HweD5JmBa1YVxtewJ9pp2ENebTI=;
 b=JnsjJ3d01bPGKTE0PNWliRZbZXZnnJnvid1joD+xeiWICmNioULu+jyhEBCpPYIvzgne33
 UKWzIFUByVMWuPLxELV25ZZ2SEacyN7B564yFBrlBGs9NNWHnFFP6lj/qHeCHI3hmJ9ldl
 4rXrr2KVIiBvb5v6Ogl6Q4s8T//CIQY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-418-_VslVg_BPtWVae8s-uHd_Q-1; Wed, 20 May 2020 18:55:48 -0400
X-MC-Unique: _VslVg_BPtWVae8s-uHd_Q-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 17CA9800688;
 Wed, 20 May 2020 22:55:47 +0000 (UTC)
Received: from [10.3.112.120] (ovpn-112-120.phx2.redhat.com [10.3.112.120])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 306B85D9CA;
 Wed, 20 May 2020 22:55:46 +0000 (UTC)
Subject: Re: [PATCH] nvmet: fix memory leak when removing namespaces and
 controllers concurrently
To: Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
 Christoph Hellwig <hch@lst.de>
References: <20200520194812.73876-1-sagi@grimberg.me>
From: David Milburn <dmilburn@redhat.com>
Message-ID: <396c0e62-fac2-2236-5f2d-40ee542e4814@redhat.com>
Date: Wed, 20 May 2020 17:55:45 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20200520194812.73876-1-sagi@grimberg.me>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200520_155555_772742_308DF4A9 
X-CRM114-Status: GOOD (  18.94  )
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
Cc: Keith Busch <kbusch@kernel.org>,
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Hi Sagi,

On 05/20/2020 02:48 PM, Sagi Grimberg wrote:
> When removing a namespace, we add an NS_CHANGE async event, however if
> the controller admin queue is removed after the event was added but not
> yet processed, we won't free the aens, resulting in the below memory
> leak [1].
> 
> Fix that by moving nvmet_async_event_free to the final controller
> release after it is detached from subsys->ctrls ensuring no async
> events are added, and modify it to simply remove all pending aens.
> 
> --
> $ cat /sys/kernel/debug/kmemleak
> unreferenced object 0xffff888c1af2c000 (size 32):
>    comm "nvmetcli", pid 5164, jiffies 4295220864 (age 6829.924s)
>    hex dump (first 32 bytes):
>      28 01 82 3b 8b 88 ff ff 28 01 82 3b 8b 88 ff ff  (..;....(..;....
>      02 00 04 65 76 65 6e 74 5f 66 69 6c 65 00 00 00  ...event_file...
>    backtrace:
>      [<00000000217ae580>] nvmet_add_async_event+0x57/0x290 [nvmet]
>      [<0000000012aa2ea9>] nvmet_ns_changed+0x206/0x300 [nvmet]
>      [<00000000bb3fd52e>] nvmet_ns_disable+0x367/0x4f0 [nvmet]
>      [<00000000e91ca9ec>] nvmet_ns_free+0x15/0x180 [nvmet]
>      [<00000000a15deb52>] config_item_release+0xf1/0x1c0
>      [<000000007e148432>] configfs_rmdir+0x555/0x7c0
>      [<00000000f4506ea6>] vfs_rmdir+0x142/0x3c0
>      [<0000000000acaaf0>] do_rmdir+0x2b2/0x340
>      [<0000000034d1aa52>] do_syscall_64+0xa5/0x4d0
>      [<00000000211f13bc>] entry_SYSCALL_64_after_hwframe+0x6a/0xdf
> 
> Fixes: a07b4970f464 ("nvmet: add a generic NVMe target")
> Reported-by: David Milburn <dmilburn@redhat.com>
> Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
> ---
> David, it would be great to get your Tested-by tag.

This takes care of the memory leak, though we did see a warning from
the mlx5 code when we rebooted the target:

[ 3109.755246] ib_srpt received unrecognized IB event 8
[ 3109.761400] mlx5_core 0000:04:00.1: 
mlx5_cmd_fast_teardown_hca:339:(pid 5135): teardown with fast mode failed
[ 3109.773399] mlx5_core 0000:04:00.1: 
mlx5_cmd_force_teardown_hca:308:(pid 5135): teardown with force mode 
failed, doing normal n
[ 3113.147598] mlx5_core 0000:04:00.0: 
mlx5_cmd_fast_teardown_hca:339:(pid 5135): teardown with fast mode failed
[ 3113.159330] mlx5_core 0000:04:00.0: 
mlx5_cmd_force_teardown_hca:308:(pid 5135): teardown with force mode 
failed, doing normal n
[ 3139.203383] nvmet: ctrl 1 keep-alive timer (15 seconds) expired!
[ 3139.228137] nvmet: ctrl 1 fatal error occurred!
[ 3197.571533] ------------[ cut here ]------------
[ 3197.577286] WARNING: CPU: 2 PID: 0 at net/sched/sch_generic.c:443 
dev_watchdog+0x258/0x260
[ 3197.587074] Modules linked in: null_blk nvme_rdma nvme_fabrics 
nvme_core nvmet_rdma nvmet 8021q garp mrp bonding bridge stp lld
[ 3197.684124] CPU: 2 PID: 0 Comm: swapper/2 Not tainted 5.7.0-rc6+ #2
[ 3197.691806] Hardware name: Dell Inc. PowerEdge R430/03XKDV, BIOS 
1.6.2 01/08/2016
[ 3197.700856] RIP: 0010:dev_watchdog+0x258/0x260
[ 3197.706512] Code: 48 85 c0 75 e4 eb 9b 4c 89 ef c6 05 ea da dd 00 01 
e8 2c 26 fb ff 89 d9 4c 89 ee 48 c7 c7 a8 cd dc 91 48 89 5
[ 3197.728930] RSP: 0000:ffffa68606550e80 EFLAGS: 00010282
[ 3197.735495] RAX: 0000000000000000 RBX: 000000000000000c RCX: 
ffffffff9205e228
[ 3197.744201] RDX: 0000000000000001 RSI: 0000000000000092 RDI: 
ffffffff92896d8c
[ 3197.752906] RBP: ffff8ab814c003dc R08: 00000000000007a6 R09: 
0000000000000005
[ 3197.761613] R10: 0000000000000000 R11: 0000000000000001 R12: 
ffff8ab8232f8f40
[ 3197.770329] R13: ffff8ab814c00000 R14: ffff8ab814c00480 R15: 
0000000000000140
[ 3197.779052] FS:  0000000000000000(0000) GS:ffff8ab83f840000(0000) 
knlGS:0000000000000000
[ 3197.788855] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 3197.796041] CR2: 00007fb509690800 CR3: 0000001000d68004 CR4: 
00000000001606e0
[ 3197.804789] Call Trace:
[ 3197.808291]  <IRQ>
[ 3197.811290]  ? pfifo_fast_enqueue+0x140/0x140
[ 3197.816919]  call_timer_fn+0x2d/0x130
[ 3197.821765]  run_timer_softirq+0x1a0/0x410
[ 3197.827090]  ? tick_sched_timer+0x37/0x70
[ 3197.832321]  ? __hrtimer_run_queues+0x110/0x280
[ 3197.838136]  __do_softirq+0xde/0x2ec
[ 3197.842879]  ? ktime_get+0x36/0xa0
[ 3197.847419]  irq_exit+0xe3/0xf0
[ 3197.851657]  smp_apic_timer_interrupt+0x74/0x130
[ 3197.857542]  apic_timer_interrupt+0xf/0x20
[ 3197.862835]  </IRQ>
[ 3197.865889] RIP: 0010:mwait_idle+0x94/0x1c0
[ 3197.871273] Code: 40 7f 01 00 48 89 d1 0f 01 c8 48 8b 00 a8 08 0f 85 
a3 00 00 00 e9 07 00 00 00 0f 00 2d 37 dc 4b 00 31 c0 48 8
[ 3197.893717] RSP: 0000:ffffa686000ebeb8 EFLAGS: 00000246 ORIG_RAX: 
ffffffffffffff13
[ 3197.902905] RAX: 0000000000000000 RBX: 0000000000000002 RCX: 
0000000000000000
[ 3197.911597] RDX: 0000000000000000 RSI: 0000000000000002 RDI: 
ffff8ab83f85fbe0
[ 3197.920270] RBP: 0000000000000002 R08: 0000000000000000 R09: 
0000000000000000
[ 3197.928934] R10: 000009a747fa1ff4 R11: 0000000000000000 R12: 
ffffffffffffffff
[ 3197.937581] R13: 0000000000000000 R14: 0000000000000000 R15: 
0000000000000000
[ 3197.946225]  ? tick_nohz_idle_stop_tick+0x5e/0xc0
[ 3197.952154]  do_idle+0x1bd/0x240
[ 3197.956429]  cpu_startup_entry+0x19/0x20
[ 3197.961473]  start_secondary+0x15f/0x1b0
[ 3197.966499]  secondary_startup_64+0xb6/0xc0
[ 3197.971798] ---[ end trace 95e950eb607e4843 ]---
[ 3197.977567] mlx5_core 0000:05:00.0 mlx5_slave1: TX timeout detected
[ 3197.985175] mlx5_core 0000:05:00.0 mlx5_slave1: TX timeout on queue: 
12, SQ: 0x1278, CQ: 0xf2, SQ Cons: 0x8 SQ Prod: 0xa, usec0
[ 3198.002627] mlx5_core 0000:05:00.0: mlx5_rsc_dump_trigger:95:(pid 
3203): Resource dump: Failed to access err -5
[ 3198.014897] mlx5_core 0000:05:00.0: mlx5_rsc_dump_next:150:(pid 
3203): Resource dump: Failed to trigger dump, -5
[ 3198.027229] mlx5_core 0000:05:00.0 mlx5_slave1: EQ 0x13: Cons = 0xd, 
irqn = 0x87
[ 3198.037669] mlx5_core 0000:05:00.0 mlx5_slave1: 
mlx5e_safe_reopen_channels failed recovering from a tx_timeout, err(-5).
[ 3213.443565] mlx5_core 0000:05:00.0 mlx5_slave1: TX timeout detected
[ 3213.451158] mlx5_core 0000:05:00.0 mlx5_slave1: TX timeout on queue: 
12, SQ: 0x1278, CQ: 0xf2, SQ Cons: 0x8 SQ Prod: 0xa, usec0
[ 3213.503496] mlx5_core 0000:05:00.0 mlx5_slave1: 
mlx5e_safe_reopen_channels failed recovering from a tx_timeout, err(-5).
[ 3214.467566] mlx5_core 0000:05:00.1 mlx5_slave2: TX timeout detected
[ 3214.475169] mlx5_core 0000:05:00.1 mlx5_slave2: TX timeout on queue: 
11, SQ: 0x1a74, CQ: 0x8c0, SQ Cons: 0x5 SQ Prod: 0x7, use0
[ 3214.492699] mlx5_core 0000:05:00.1: mlx5_rsc_dump_trigger:95:(pid 
3615): Resource dump: Failed to access err -5
[ 3214.505046] mlx5_core 0000:05:00.1: mlx5_rsc_dump_next:150:(pid 
3615): Resource dump: Failed to trigger dump, -5
[ 3214.517502] mlx5_core 0000:05:00.1 mlx5_slave2: EQ 0x12: Cons = 0xa, 
irqn = 0xb0
[ 3214.526795] mlx5_core 0000:05:00.1 mlx5_slave2: TX timeout on queue: 
12, SQ: 0x1a78, CQ: 0x8c4, SQ Cons: 0x6 SQ Prod: 0x8, use0
[ 3214.544974] mlx5_core 0000:05:00.1 mlx5_slave2: 
mlx5e_safe_reopen_channels failed recovering from a tx_timeout, err(-5).
[ 3228.803601] mlx5_core 0000:05:00.0 mlx5_slave1: TX timeout detected
[ 3228.811280] mlx5_core 0000:05:00.0 mlx5_slave1: TX timeout on queue: 
12, SQ: 0x1278, CQ: 0xf2, SQ Cons: 0x8 SQ Prod: 0xa, usec0
[ 3228.846174] mlx5_core 0000:05:00.0 mlx5_slave1: 
mlx5e_safe_reopen_channels failed recovering from a tx_timeout, err(-5).
[ 3229.315601] mlx5_core 0000:05:00.1 mlx5_slave2: TX timeout detected
[ 3229.323333] mlx5_core 0000:05:00.1 mlx5_slave2: TX timeout on queue: 
10, SQ: 0x1a70, CQ: 0x8dc, SQ Cons: 0x8 SQ Prod: 0xa, use0
[ 3229.341177] mlx5_core 0000:05:00.1 mlx5_slave2: TX timeout on queue: 
11, SQ: 0x1a74, CQ: 0x8c0, SQ Cons: 0x5 SQ Prod: 0x7, use0
[ 3229.359106] mlx5_core 0000:05:00.1 mlx5_slave2: TX timeout on queue: 
12, SQ: 0x1a78, CQ: 0x8c4, SQ Cons: 0x6 SQ Prod: 0x8, use0
[ 3229.393142] mlx5_core 0000:05:00.1 mlx5_slave2: 
mlx5e_safe_reopen_channels failed recovering from a tx_timeout, err(-5).
[ 3244.675638] mlx5_core 0000:05:00.1 mlx5_slave2: TX timeout detected
[ 3244.675639] mlx5_core 0000:05:00.0 mlx5_slave1: TX timeout detected
[ 3244.683486] mlx5_core 0000:05:00.1 mlx5_slave2: TX timeout on queue: 
10, SQ: 0x1a70, CQ: 0x8dc, SQ Cons: 0x8 SQ Prod: 0xa, use0
[ 3244.710638] mlx5_core 0000:05:00.1 mlx5_slave2: TX timeout on queue: 
11, SQ: 0x1a74, CQ: 0x8c0, SQ Cons: 0x5 SQ Prod: 0x7, use0
[ 3244.728732] mlx5_core 0000:05:00.1 mlx5_slave2: TX timeout on queue: 
12, SQ: 0x1a78, CQ: 0x8c4, SQ Cons: 0x6 SQ Prod: 0x8, use0
[ 3244.753172] mlx5_core 0000:05:00.1 mlx5_slave2: 
mlx5e_safe_reopen_channels failed recovering from a tx_timeout, err(-5).
[ 3244.766798] mlx5_core 0000:05:00.0 mlx5_slave1: TX timeout on queue: 
12, SQ: 0x1278, CQ: 0xf2, SQ Cons: 0x8 SQ Prod: 0xa, usec0
[ 3244.823195] mlx5_core 0000:05:00.0 mlx5_slave1: 
mlx5e_safe_reopen_channels failed recovering from a tx_timeout, err(-5).
[ 3260.547675] mlx5_core 0000:05:00.0 mlx5_slave1: TX timeout detected
[ 3260.547676] mlx5_core 0000:05:00.1 mlx5_slave2: TX timeout detected
[ 3260.547683] mlx5_core 0000:05:00.1 mlx5_slave2: TX timeout on queue: 
10, SQ: 0x1a70, CQ: 0x8dc, SQ Cons: 0x8 SQ Prod: 0xa, use0
[ 3260.582542] mlx5_core 0000:05:00.1 mlx5_slave2: TX timeout on queue: 
11, SQ: 0x1a74, CQ: 0x8c0, SQ Cons: 0x5 SQ Prod: 0x7, use0
[ 3260.601189] mlx5_core 0000:05:00.1 mlx5_slave2: TX timeout on queue: 
12, SQ: 0x1a78, CQ: 0x8c4, SQ Cons: 0x6 SQ Prod: 0x8, use0
[ 3260.625671] mlx5_core 0000:05:00.1 mlx5_slave2: 
mlx5e_safe_reopen_channels failed recovering from a tx_timeout, err(-5).
[ 3260.639449] mlx5_core 0000:05:00.0 mlx5_slave1: TX timeout on queue: 
11, SQ: 0x1274, CQ: 0xce, SQ Cons: 0x7 SQ Prod: 0x9, usec0
[ 3260.657873] mlx5_core 0000:05:00.0 mlx5_slave1: TX timeout on queue: 
12, SQ: 0x1278, CQ: 0xf2, SQ Cons: 0x8 SQ Prod: 0xa, usec0
[ 3260.678095] mlx5_core 0000:05:00.0 mlx5_slave1: 
mlx5e_safe_reopen_channels failed recovering from a tx_timeout, err(-5).
[ 3275.395712] mlx5_core 0000:05:00.0 mlx5_slave1: TX timeout detected
[ 3275.403736] mlx5_core 0000:05:00.0 mlx5_slave1: TX timeout on queue: 
11, SQ: 0x1274, CQ: 0xce, SQ Cons: 0x7 SQ Prod: 0x9, usec0
[ 3275.451159] mlx5_core 0000:05:00.0 mlx5_slave1: TX timeout on queue: 
12, SQ: 0x1278, CQ: 0xf2, SQ Cons: 0x8 SQ Prod: 0xa, usec0
[ 3275.504724] mlx5_core 0000:05:00.0 mlx5_slave1: 
mlx5e_safe_reopen_channels failed recovering from a tx_timeout, err(-5).
[ 3276.419712] mlx5_core 0000:05:00.1 mlx5_slave2: TX timeout detected
[ 3276.427760] mlx5_core 0000:05:00.1 mlx5_slave2: TX timeout on queue: 
10, SQ: 0x1a70, CQ: 0x8dc, SQ Cons: 0x8 SQ Prod: 0xa, use0
[ 3276.446435] mlx5_core 0000:05:00.1 mlx5_slave2: TX timeout on queue: 
11, SQ: 0x1a74, CQ: 0x8c0, SQ Cons: 0x5 SQ Prod: 0x7, use0
[ 3276.465180] mlx5_core 0000:05:00.1 mlx5_slave2: TX timeout on queue: 
12, SQ: 0x1a78, CQ: 0x8c4, SQ Cons: 0x6 SQ Prod: 0x8, use0
[ 3276.497511] mlx5_core 0000:05:00.1 mlx5_slave2: 
mlx5e_safe_reopen_channels failed recovering from a tx_timeout, err(-5).
[ 3290.755746] mlx5_core 0000:05:00.0 mlx5_slave1: TX timeout detected
[ 3290.763803] mlx5_core 0000:05:00.0 mlx5_slave1: TX timeout on queue: 
11, SQ: 0x1274, CQ: 0xce, SQ Cons: 0x7 SQ Prod: 0x9, usec0
[ 3290.782450] mlx5_core 0000:05:00.0 mlx5_slave1: TX timeout on queue: 
12, SQ: 0x1278, CQ: 0xf2, SQ Cons: 0x8 SQ Prod: 0xa, usec0
[ 3290.801156] mlx5_core 0000:05:00.0 mlx5_slave1: TX timeout on queue: 
19, SQ: 0x1294, CQ: 0xee, SQ Cons: 0x2 SQ Prod: 0x4, usec0
[ 3290.834065] mlx5_core 0000:05:00.0 mlx5_slave1: 
mlx5e_safe_reopen_channels failed recovering from a tx_timeout, err(-5).
[ 3291.779748] mlx5_core 0000:05:00.1 mlx5_slave2: TX timeout detected
[ 3291.787825] mlx5_core 0000:05:00.1 mlx5_slave2: TX timeout on queue: 
10, SQ: 0x1a70, CQ: 0x8dc, SQ Cons: 0x8 SQ Prod: 0xa, use0
[ 3291.806619] mlx5_core 0000:05:00.1 mlx5_slave2: TX timeout on queue: 
11, SQ: 0x1a74, CQ: 0x8c0, SQ Cons: 0x5 SQ Prod: 0x7, use0
[ 3291.825602] mlx5_core 0000:05:00.1 mlx5_slave2: TX timeout on queue: 
12, SQ: 0x1a78, CQ: 0x8c4, SQ Cons: 0x6 SQ Prod: 0x8, use0
[ 3291.844466] mlx5_core 0000:05:00.1 mlx5_slave2: TX timeout on queue: 
14, SQ: 0x1a80, CQ: 0x8cc, SQ Cons: 0x5 SQ Prod: 0x7, use0
[ 3291.875065] mlx5_core 0000:05:00.1 mlx5_slave2: 
mlx5e_safe_reopen_channels failed recovering from a tx_timeout, err(-5).
[ 3306.627784] mlx5_core 0000:05:00.0 mlx5_slave1: TX timeout detected
[ 3306.635862] mlx5_core 0000:05:00.0 mlx5_slave1: TX timeout on queue: 
11, SQ: 0x1274, CQ: 0xce, SQ Cons: 0x7 SQ Prod: 0x9, usec0
[ 3306.654708] mlx5_core 0000:05:00.0 mlx5_slave1: TX timeout on queue: 
12, SQ: 0x1278, CQ: 0xf2, SQ Cons: 0x8 SQ Prod: 0xa, usec0
[ 3306.673537] mlx5_core 0000:05:00.0 mlx5_slave1: TX timeout on queue: 
19, SQ: 0x1294, CQ: 0xee, SQ Cons: 0x2 SQ Prod: 0x4, usec0
[ 3306.705696] mlx5_core 0000:05:00.0 mlx5_slave1: 
mlx5e_safe_reopen_channels failed recovering from a tx_timeout, err(-5).
[ 3307.651786] mlx5_core 0000:05:00.1 mlx5_slave2: TX timeout detected
[ 3307.659884] mlx5_core 0000:05:00.1 mlx5_slave2: TX timeout on queue: 
10, SQ: 0x1a70, CQ: 0x8dc, SQ Cons: 0x8 SQ Prod: 0xa, use0
[ 3307.678633] mlx5_core 0000:05:00.1 mlx5_slave2: TX timeout on queue: 
11, SQ: 0x1a74, CQ: 0x8c0, SQ Cons: 0x5 SQ Prod: 0x7, use0
[ 3307.697642] mlx5_core 0000:05:00.1 mlx5_slave2: TX timeout on queue: 
12, SQ: 0x1a78, CQ: 0x8c4, SQ Cons: 0x6 SQ Prod: 0x8, use0
[ 3307.716531] mlx5_core 0000:05:00.1 mlx5_slave2: TX timeout on queue: 
14, SQ: 0x1a80, CQ: 0x8cc, SQ Cons: 0x5 SQ Prod: 0x7, use0
[ 3307.747161] mlx5_core 0000:05:00.1 mlx5_slave2: 
mlx5e_safe_reopen_channels failed recovering from a tx_timeout, err(-5).
[ 3319.427821] INFO: task kworker/2:3:1640 blocked for more than 122 
seconds.
[ 3319.436618]       Tainted: G        W         5.7.0-rc6+ #2
[ 3319.443934] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" 
disables this message.
[ 3319.453774] Call Trace:
[ 3319.457583]  ? __schedule+0x262/0x6e0
[ 3319.462744]  ? __switch_to_asm+0x40/0x70
[ 3319.468177]  ? schedule+0x40/0xb0
[ 3319.472913]  ? schedule_timeout+0x21e/0x310
[ 3319.478604]  ? nvmet_destroy_namespace+0x20/0x20 [nvmet]
[ 3319.485539]  ? wait_for_completion+0x8d/0xf0
[ 3319.491293]  ? nvmet_sq_destroy+0x51/0xb0 [nvmet]
[ 3319.497515]  ? nvmet_rdma_free_queue+0x17/0xb0 [nvmet_rdma]
[ 3319.504692]  ? nvmet_rdma_release_queue_work+0x19/0x50 [nvmet_rdma]
[ 3319.512650]  ? process_one_work+0x1a7/0x370
[ 3319.518263]  ? worker_thread+0x30/0x380
[ 3319.523468]  ? process_one_work+0x370/0x370
[ 3319.529048]  ? kthread+0x10c/0x130
[ 3319.533732]  ? kthread_park+0x80/0x80
[ 3319.538687]  ? ret_from_fork+0x35/0x40

Thanks,
David


> 
>   drivers/nvme/target/core.c | 15 ++++++---------
>   1 file changed, 6 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
> index edf54d9957b7..48f5123d875b 100644
> --- a/drivers/nvme/target/core.c
> +++ b/drivers/nvme/target/core.c
> @@ -158,14 +158,12 @@ static void nvmet_async_events_process(struct nvmet_ctrl *ctrl, u16 status)
>   
>   static void nvmet_async_events_free(struct nvmet_ctrl *ctrl)
>   {
> -	struct nvmet_req *req;
> +	struct nvmet_async_event *aen, *tmp;
>   
>   	mutex_lock(&ctrl->lock);
> -	while (ctrl->nr_async_event_cmds) {
> -		req = ctrl->async_event_cmds[--ctrl->nr_async_event_cmds];
> -		mutex_unlock(&ctrl->lock);
> -		nvmet_req_complete(req, NVME_SC_INTERNAL | NVME_SC_DNR);
> -		mutex_lock(&ctrl->lock);
> +	list_for_each_entry_safe(aen, tmp, &ctrl->async_events, entry) {
> +		list_del(&aen->entry);
> +		kfree(aen);
>   	}
>   	mutex_unlock(&ctrl->lock);
>   }
> @@ -791,10 +789,8 @@ void nvmet_sq_destroy(struct nvmet_sq *sq)
>   	 * If this is the admin queue, complete all AERs so that our
>   	 * queue doesn't have outstanding requests on it.
>   	 */
> -	if (ctrl && ctrl->sqs && ctrl->sqs[0] == sq) {
> +	if (ctrl && ctrl->sqs && ctrl->sqs[0] == sq)
>   		nvmet_async_events_process(ctrl, status);
> -		nvmet_async_events_free(ctrl);
> -	}
>   	percpu_ref_kill_and_confirm(&sq->ref, nvmet_confirm_sq);
>   	wait_for_completion(&sq->confirm_done);
>   	wait_for_completion(&sq->free_done);
> @@ -1427,6 +1423,7 @@ static void nvmet_ctrl_free(struct kref *ref)
>   
>   	ida_simple_remove(&cntlid_ida, ctrl->cntlid);
>   
> +	nvmet_async_events_free(ctrl);
>   	kfree(ctrl->sqs);
>   	kfree(ctrl->cqs);
>   	kfree(ctrl->changed_ns_list);
> 


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
