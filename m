Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA089C5B553
	for <linux-nvme@archiver.kernel.org>; Thu, 29 May 2025 13:00:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:MIME-Version:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=5/awe91XIL6G8G2AQj2qhaL6dTsLYqBBYXdUY/V/DKI=; b=OBlXCNT/MH2ILeJVDaaJ5ahXYe
	Xpgl+Hkat6hZ+VB+3EDAkz7qN9jhwK4Fw1FmFimq2BOxha1xTt6U+3whsFYBFnODBcXfthiPHO6VN
	9Uqh8malwcIbYZbelCPXqLk2Zyu4GfvZBadpR3bVQFjbZ0kmgoVavl1eDGEDcu30013VAlMI9VugV
	pIDn6511atHF1l9zhsRC46ZN1g86k0jnmlP9Sje1RR7iJurkFKWHOPGg1r5AmfklCw1NYaLY/ia2O
	G17E3ITaDHwVjbZUnXeJ7mTT6pj/O6l131/oSI7P6FrJBasF9ZiB96/OWLeFJd1PGRTcKRBzQD2dI
	ahtd3FFQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uKcrw-0000000FoAa-2RyD;
	Thu, 29 May 2025 13:00:24 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uKca4-0000000Fkew-0ARd
	for linux-nvme@lists.infradead.org;
	Thu, 29 May 2025 12:41:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748522513;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=5/awe91XIL6G8G2AQj2qhaL6dTsLYqBBYXdUY/V/DKI=;
	b=QZcEGTCbZd0e2gbZbuHr4WVnoVK+nO3UOZACjHdg0l28BWm9yu7U/CuHjtPnAo/ubIjakU
	Tt2ELPo6SWue79C/Te6FWKPHz/QarhALD8qCxMNqd0D4WUUNfgOAs7PYY+lmHks8+yCzh1
	7l8xx0tgx/4hZdm+RK60HCesuJd5QLw=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-84-cfeNdh1OODud9R0qFD3eiQ-1; Thu, 29 May 2025 08:41:52 -0400
X-MC-Unique: cfeNdh1OODud9R0qFD3eiQ-1
X-Mimecast-MFC-AGG-ID: cfeNdh1OODud9R0qFD3eiQ_1748522511
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-32a74ba6e01so4536851fa.1
        for <linux-nvme@lists.infradead.org>; Thu, 29 May 2025 05:41:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748522509; x=1749127309;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5/awe91XIL6G8G2AQj2qhaL6dTsLYqBBYXdUY/V/DKI=;
        b=NeRyM3YUoZcZfwv/TdFX2KH+d//YduiaPJa1iqUjOxPukgMoEmzFBHwfJ6N1/ypVz/
         AvidwlPNbW4lzlYTege/3qusNS+nWkACDg9P25dPHFMPbk/T3TIxzCFeMwuV/YKwx0Kn
         Sn9JjuebxNjhD05GqxaLabm0hDGubmfVqVvIfze6jphHdUe/GR5gP+CwCz4iv9ENGG5R
         sQKO3D46HR8mb+P0mbwymGOwO9kWAyGOEnme5Nr18rsO0Hf8j0HWURdFjs38LJFvt21n
         mUPyH28bzyWXae6+eIMgFM1JaJjN6Oh+kcHz10J5s3K1dwx6uYeDtA8waxMHFEycZKsi
         g4JQ==
X-Gm-Message-State: AOJu0Yxc3N3iBLOsTPR/SA8nSORuQeLBnMpnHCKDoaNCaKc80Icbw4p3
	aaJUkDpQIAIxThs7Mu7y4GuONZroYBWzS/znLTrpFpiaiLDy4t5bNTjyqNbqf2uoqsv3f7Kk93U
	eUr5R5w7P3mpXkhfp4GM0SaApBtdmwjsHFpCsfCBDN+doZv5OEoRUiLZq0j1emZaePx2CTcy/r5
	bCMRqYusQRdYD9TinLjPTFhNk9SLBM1LY4qNKC05yGbUoq/LqcKTUfZ3Dj
X-Gm-Gg: ASbGnctU3suvbHW7+avw6gtqYhYUYwOiL/zsrmZooLEpm75VA5JWvXd5Wybu/aG5okg
	pqfwydKpWl4oUM4POo3DRZevWRsfLAUUqCJrPpZEJHsdJSMCQrSMKTDfbbVm43/YKyjq+jA==
X-Received: by 2002:a05:651c:18cb:b0:32a:689a:e9a9 with SMTP id 38308e7fff4ca-32a689aec90mr43048331fa.20.1748522509128;
        Thu, 29 May 2025 05:41:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGs0JRG/7YBqJD8wZXgkdqk+yPA0s+8F2BIwf/Qmmb+gveufz4x1L0C8H+L5RqNuJzL7BGJLouXeNnvxmVuXow=
X-Received: by 2002:a05:651c:18cb:b0:32a:689a:e9a9 with SMTP id
 38308e7fff4ca-32a689aec90mr43048171fa.20.1748522508549; Thu, 29 May 2025
 05:41:48 -0700 (PDT)
MIME-Version: 1.0
From: Yi Zhang <yi.zhang@redhat.com>
Date: Thu, 29 May 2025 20:41:36 +0800
X-Gm-Features: AX0GCFsb1hDsfWb1ZgQMcqxl1T_aUnX7dIGRp75vyW5a1GIZmm-Cbmyt-lIHMEU
Message-ID: <CAHj4cs93WutyoPLFMr0JidHhRAxHC1ZDcj-RvdnX=R7OaV5ejg@mail.gmail.com>
Subject: [bug report]BUG: workqueue leaked atomic, lock or RCU:
 kworker/u67:3[365] observed from v6.15-rc7
To: "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: hjuNHIZJ73cpqgrqLS6oas8WHQ2ScLfFDLbm1J3kLD0_1748522511
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250529_054156_233028_27047073 
X-CRM114-Status: UNSURE (   6.28  )
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

Hi

My regression test found this issue from v6.15-rc7, please help check
it and let me know if you need any infor/test for it, thanks.

[ 2313.264089] nvme nvme2: resetting controller
[ 2317.125038] nvme nvme2: D3 entry latency set to 10 seconds
[ 2317.201142] nvme nvme2: 16/0/0 default/read/poll queues
[ 2319.450561] nvme nvme2: nvme2n1: Inconsistent Atomic Write Size,
Namespace will not be added: Subsystem=4096 bytes,
Controller/Namespace=512 bytes
[ 2319.467732] nvme 0000:44:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT
domain=0x0033 address=0x0 flags=0x0020]
[ 2319.477555] nvme 0000:44:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT
domain=0x0033 address=0x0 flags=0x0020]
[ 2319.487377] nvme 0000:44:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT
domain=0x0033 address=0x0 flags=0x0020]
[ 2319.497214] nvme 0000:44:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT
domain=0x0033 address=0x0 flags=0x0020]
[ 2319.507026] nvme 0000:44:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT
domain=0x0033 address=0x600 flags=0x0020]
[ 2319.516999] nvme 0000:44:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT
domain=0x0033 address=0x0 flags=0x0020]
[ 2319.526790] nvme 0000:44:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT
domain=0x0033 address=0x500 flags=0x0020]
[ 2319.536765] nvme 0000:44:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT
domain=0x0033 address=0x0 flags=0x0020]
[ 2319.546560] nvme 0000:44:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT
domain=0x0033 address=0x600 flags=0x0020]
[ 2319.556524] nvme 0000:44:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT
domain=0x0033 address=0x0 flags=0x0020]
[ 2319.881675] nvme nvme3: rescanning namespaces.
[ 2320.163354] nvme nvme3: nvme3n1: Inconsistent Atomic Write Size,
Namespace will not be added: Subsystem=4096 bytes,
Controller/Namespace=32768 bytes
[ 2320.177588] BUG: workqueue leaked atomic, lock or RCU: kworker/u67:3[365]
                    preempt=0x00000000 lock=0->1 RCU=0->0
workfn=async_run_entry_fn
[ 2320.191968] 1 lock held by kworker/u67:3/365:
[ 2320.196395]  #0: ffff8881a06b11f0 (&q->limits_lock){+.+.}-{4:4},
at: nvme_update_ns_info_block+0x2b0/0x19a0 [nvme_core]
[ 2320.207301] CPU: 5 UID: 0 PID: 365 Comm: kworker/u67:3 Not tainted
6.15.0 #1 PREEMPT(voluntary)
[ 2320.207309] Hardware name: Dell Inc. PowerEdge R6515/07PXPY, BIOS
2.17.0 12/04/2024
[ 2320.207313] Workqueue: async async_run_entry_fn
[ 2320.207320] Call Trace:
[ 2320.207325]  <TASK>
[ 2320.207331]  dump_stack_lvl+0xac/0xc0
[ 2320.207343]  process_one_work+0xfc8/0x1950
[ 2320.207355]  ? __pfx_async_run_entry_fn+0x10/0x10
[ 2320.207398]  ? __pfx_process_one_work+0x10/0x10
[ 2320.207407]  ? srso_return_thunk+0x5/0x5f
[ 2320.207433]  ? srso_return_thunk+0x5/0x5f
[ 2320.207437]  ? assign_work+0x16c/0x240
[ 2320.207458]  worker_thread+0x58d/0xcf0
[ 2320.207493]  ? __pfx_worker_thread+0x10/0x10
[ 2320.207508]  kthread+0x3d8/0x7a0
[ 2320.207519]  ? __pfx_kthread+0x10/0x10
[ 2320.207532]  ? srso_return_thunk+0x5/0x5f
[ 2320.207536]  ? rcu_is_watching+0x11/0xb0
[ 2320.207548]  ? __pfx_kthread+0x10/0x10
[ 2320.207562]  ret_from_fork+0x30/0x70
[ 2320.207569]  ? __pfx_kthread+0x10/0x10
[ 2320.207577]  ret_from_fork_asm+0x1a/0x30
[ 2320.207625]  </TASK>
[ 2458.962206] INFO: task kworker/u67:0:1471 blocked for more than 122 seconds.
[ 2458.969586]       Not tainted 6.15.0 #1
[ 2458.973464] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
disables this message.
[ 2458.981344] task:kworker/u67:0   state:D stack:25400 pid:1471
tgid:1471  ppid:2      task_flags:0x4208060 flags:0x00004000
[ 2458.981370] Workqueue: async async_run_entry_fn
[ 2458.981393] Call Trace:
[ 2458.981401]  <TASK>
[ 2458.981423]  __schedule+0x8fa/0x1c70
[ 2458.981460]  ? __pfx___schedule+0x10/0x10
[ 2458.981479]  ? srso_return_thunk+0x5/0x5f
[ 2458.981495]  ? find_held_lock+0x32/0x90
[ 2458.981515]  ? srso_return_thunk+0x5/0x5f
[ 2458.981525]  ? __lock_release+0x1a2/0x2c0
[ 2458.981535]  ? srso_return_thunk+0x5/0x5f
[ 2458.981554]  ? schedule+0x1e8/0x270
[ 2458.981579]  schedule+0xdc/0x270
[ 2458.981596]  schedule_preempt_disabled+0x14/0x30
[ 2458.981608]  __mutex_lock+0xbf1/0x1690
[ 2458.981633]  ? nvme_update_ns_info_block+0x2b0/0x19a0 [nvme_core]
[ 2458.981721]  ? __pfx___mutex_lock+0x10/0x10
[ 2458.981731]  ? srso_return_thunk+0x5/0x5f
[ 2458.981751]  ? srso_return_thunk+0x5/0x5f
[ 2458.981794]  ? srso_return_thunk+0x5/0x5f
[ 2458.981821]  ? nvme_update_ns_info_block+0x2b0/0x19a0 [nvme_core]
[ 2458.981851]  ? srso_return_thunk+0x5/0x5f
[ 2458.981861]  nvme_update_ns_info_block+0x2b0/0x19a0 [nvme_core]
[ 2458.981928]  ? unwind_next_frame+0x453/0x20c0
[ 2458.981945]  ? srso_return_thunk+0x5/0x5f
[ 2458.981961]  ? srso_return_thunk+0x5/0x5f
[ 2458.981971]  ? unwind_next_frame+0x45d/0x20c0
[ 2458.981981]  ? ret_from_fork_asm+0x1a/0x30
[ 2458.981999]  ? srso_return_thunk+0x5/0x5f
[ 2458.982008]  ? kernel_text_address+0x13/0xd0
[ 2458.982022]  ? ret_from_fork_asm+0x1a/0x30
[ 2458.982032]  ? __pfx_stack_trace_consume_entry+0x10/0x10
[ 2458.982052]  ? srso_return_thunk+0x5/0x5f
[ 2458.982062]  ? arch_stack_walk+0x87/0xf0
[ 2458.982088]  ? __pfx_nvme_update_ns_info_block+0x10/0x10 [nvme_core]
[ 2458.982126]  ? ret_from_fork_asm+0x1a/0x30
[ 2458.982150]  ? srso_return_thunk+0x5/0x5f
[ 2458.982160]  ? stack_trace_save+0x8f/0xc0
[ 2458.982174]  ? srso_return_thunk+0x5/0x5f
[ 2458.982184]  ? stack_depot_save_flags+0x41/0x6c0
[ 2458.982221]  ? srso_return_thunk+0x5/0x5f
[ 2458.982231]  ? kasan_save_stack+0x30/0x40
[ 2458.982244]  ? kasan_save_stack+0x20/0x40
[ 2458.982254]  ? kasan_save_track+0x10/0x30
[ 2458.982265]  ? kasan_save_free_info+0x37/0x60
[ 2458.982275]  ? __kasan_slab_free+0x34/0x50
[ 2458.982286]  ? kfree+0x29d/0x4c0
[ 2458.982298]  ? nvme_ns_info_from_identify+0x312/0x4d0 [nvme_core]
[ 2458.982328]  ? nvme_scan_ns+0x12f/0x4b0 [nvme_core]
[ 2458.982358]  ? async_run_entry_fn+0x96/0x4f0
[ 2458.982369]  ? process_one_work+0x8cd/0x1950
[ 2458.982379]  ? worker_thread+0x58d/0xcf0
[ 2458.982389]  ? kthread+0x3d8/0x7a0
[ 2458.982399]  ? ret_from_fork+0x30/0x70
[ 2458.982410]  ? ret_from_fork_asm+0x1a/0x30
[ 2458.982420]  ? srso_return_thunk+0x5/0x5f
[ 2458.982430]  ? local_clock_noinstr+0x9/0xc0
[ 2458.982445]  ? srso_return_thunk+0x5/0x5f
[ 2458.982455]  ? __lock_release+0x1a2/0x2c0
[ 2458.982473]  ? srso_return_thunk+0x5/0x5f
[ 2458.982496]  ? __pfx_nvme_scan_ns_async+0x10/0x10 [nvme_core]
[ 2458.982526]  nvme_update_ns_info+0x1d9/0xbe0 [nvme_core]
[ 2458.982561]  ? srso_return_thunk+0x5/0x5f
[ 2458.982571]  ? __debug_check_no_obj_freed+0x252/0x510
[ 2458.982605]  ? srso_return_thunk+0x5/0x5f
[ 2458.982615]  ? __lock_acquire+0x573/0xc00
[ 2458.982650]  ? __pfx_nvme_update_ns_info+0x10/0x10 [nvme_core]
[ 2458.982679]  ? find_held_lock+0x32/0x90
[ 2458.982692]  ? local_clock_noinstr+0x9/0xc0
[ 2458.982706]  ? srso_return_thunk+0x5/0x5f
[ 2458.982716]  ? __lock_release+0x1a2/0x2c0
[ 2458.982726]  ? srso_return_thunk+0x5/0x5f
[ 2458.982744]  ? nvme_find_get_ns+0x221/0x2f0 [nvme_core]
[ 2458.982779]  ? srso_return_thunk+0x5/0x5f
[ 2458.982795]  ? srso_return_thunk+0x5/0x5f
[ 2458.982806]  ? nvme_find_get_ns+0x232/0x2f0 [nvme_core]
[ 2458.982848]  ? __pfx_nvme_find_get_ns+0x10/0x10 [nvme_core]
[ 2458.982905]  ? __lock_acquire+0x573/0xc00
[ 2458.982938]  ? __pfx_nvme_scan_ns_async+0x10/0x10 [nvme_core]
[ 2458.982968]  nvme_scan_ns+0x26a/0x4b0 [nvme_core]
[ 2458.983006]  ? __pfx_nvme_scan_ns+0x10/0x10 [nvme_core]
[ 2458.983036]  ? srso_return_thunk+0x5/0x5f
[ 2458.983064]  ? ktime_get+0x16b/0x1f0
[ 2458.983075]  ? srso_return_thunk+0x5/0x5f
[ 2458.983085]  ? lockdep_hardirqs_on+0x78/0x100
[ 2458.983097]  ? srso_return_thunk+0x5/0x5f
[ 2458.983107]  ? srso_return_thunk+0x5/0x5f
[ 2458.983130]  ? __pfx_nvme_scan_ns_async+0x10/0x10 [nvme_core]
[ 2458.983159]  async_run_entry_fn+0x96/0x4f0
[ 2458.983187]  process_one_work+0x8cd/0x1950
[ 2458.983230]  ? srso_return_thunk+0x5/0x5f
[ 2458.983244]  ? __pfx_process_one_work+0x10/0x10
[ 2458.983258]  ? srso_return_thunk+0x5/0x5f
[ 2458.983288]  ? srso_return_thunk+0x5/0x5f
[ 2458.983298]  ? assign_work+0x16c/0x240
[ 2458.983324]  worker_thread+0x58d/0xcf0
[ 2458.983365]  ? __pfx_worker_thread+0x10/0x10
[ 2458.983385]  kthread+0x3d8/0x7a0
[ 2458.983401]  ? __pfx_kthread+0x10/0x10
[ 2458.983419]  ? srso_return_thunk+0x5/0x5f
[ 2458.983429]  ? rcu_is_watching+0x11/0xb0
[ 2458.983446]  ? __pfx_kthread+0x10/0x10
[ 2458.983466]  ret_from_fork+0x30/0x70
[ 2458.983477]  ? __pfx_kthread+0x10/0x10
[ 2458.983491]  ret_from_fork_asm+0x1a/0x30
[ 2458.983544]  </TASK>
[ 2458.983563] INFO: task kworker/u67:0:1471 is blocked on a mutex
likely owned by task kworker/u67:3:365.
[ 2458.992991] task:kworker/u67:3   state:I stack:23576 pid:365
tgid:365   ppid:2      task_flags:0x4208060 flags:0x00004000
[ 2458.993013] Workqueue:  0x0 (events_unbound)
[ 2458.993037] Call Trace:
[ 2458.993045]  <TASK>
[ 2458.993065]  __schedule+0x8fa/0x1c70
[ 2458.993095]  ? __pfx___schedule+0x10/0x10
[ 2458.993114]  ? srso_return_thunk+0x5/0x5f
[ 2458.993128]  ? find_held_lock+0x32/0x90
[ 2458.993147]  ? srso_return_thunk+0x5/0x5f
[ 2458.993156]  ? __lock_release+0x1a2/0x2c0
[ 2458.993166]  ? srso_return_thunk+0x5/0x5f
[ 2458.993184]  ? schedule+0x1e8/0x270
[ 2458.993209]  schedule+0xdc/0x270
[ 2458.993222]  ? worker_thread+0xfb/0xcf0
[ 2458.993234]  worker_thread+0x14f/0xcf0
[ 2458.993275]  ? __pfx_worker_thread+0x10/0x10
[ 2458.993296]  kthread+0x3d8/0x7a0
[ 2458.993312]  ? __pfx_kthread+0x10/0x10
[ 2458.993330]  ? srso_return_thunk+0x5/0x5f
[ 2458.993340]  ? rcu_is_watching+0x11/0xb0
[ 2458.993356]  ? __pfx_kthread+0x10/0x10
[ 2458.993376]  ret_from_fork+0x30/0x70
[ 2458.993387]  ? __pfx_kthread+0x10/0x10
[ 2458.993401]  ret_from_fork_asm+0x1a/0x30
[ 2458.993455]  </TASK>
[ 2458.993463] INFO: task kworker/u67:1:1480 blocked for more than 122 seconds.
[ 2459.000541]       Not tainted 6.15.0 #1
[ 2459.004412] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
disables this message.
[ 2459.012264] task:kworker/u67:1   state:D stack:23416 pid:1480
tgid:1480  ppid:2      task_flags:0x4208060 flags:0x00004000
[ 2459.012286] Workqueue: nvme-wq nvme_scan_work [nvme_core]
[ 2459.012321] Call Trace:
[ 2459.012329]  <TASK>
[ 2459.012350]  __schedule+0x8fa/0x1c70
[ 2459.012380]  ? __pfx___schedule+0x10/0x10
[ 2459.012399]  ? srso_return_thunk+0x5/0x5f
[ 2459.012413]  ? find_held_lock+0x32/0x90
[ 2459.012431]  ? srso_return_thunk+0x5/0x5f
[ 2459.012441]  ? __lock_release+0x1a2/0x2c0
[ 2459.012451]  ? srso_return_thunk+0x5/0x5f
[ 2459.012469]  ? schedule+0x1e8/0x270
[ 2459.012493]  schedule+0xdc/0x270
[ 2459.012511]  async_synchronize_cookie_domain+0x1b8/0x220
[ 2459.012523]  ? nvme_remove_invalid_namespaces+0x289/0x470 [nvme_core]
[ 2459.012558]  ? __pfx_async_synchronize_cookie_domain+0x10/0x10
[ 2459.012579]  ? __pfx_autoremove_wake_function+0x10/0x10
[ 2459.012598]  ? __async_schedule_node_domain+0x362/0x550
[ 2459.012609]  ? __kasan_kmalloc+0x7b/0x90
[ 2459.012641]  nvme_scan_ns_list+0x519/0x6a0 [nvme_core]
[ 2459.012672]  ? trace_contention_end+0x150/0x1c0
[ 2459.012711]  ? __pfx_nvme_scan_ns_list+0x10/0x10 [nvme_core]
[ 2459.012756]  ? __pfx___mutex_lock+0x10/0x10
[ 2459.012776]  ? srso_return_thunk+0x5/0x5f
[ 2459.012787]  ? nvme_init_non_mdts_limits+0x24c/0x570 [nvme_core]
[ 2459.012868]  ? nvme_scan_work+0x285/0x540 [nvme_core]
[ 2459.012920]  nvme_scan_work+0x285/0x540 [nvme_core]
[ 2459.012962]  ? __pfx_nvme_scan_work+0x10/0x10 [nvme_core]
[ 2459.012992]  ? srso_return_thunk+0x5/0x5f
[ 2459.013010]  ? srso_return_thunk+0x5/0x5f
[ 2459.013028]  ? srso_return_thunk+0x5/0x5f
[ 2459.013038]  ? rcu_is_watching+0x11/0xb0
[ 2459.013048]  ? srso_return_thunk+0x5/0x5f
[ 2459.013058]  ? srso_return_thunk+0x5/0x5f
[ 2459.013067]  ? lock_acquire+0x10e/0x160
[ 2459.013094]  process_one_work+0x8cd/0x1950
[ 2459.013143]  ? __pfx_process_one_work+0x10/0x10
[ 2459.013158]  ? srso_return_thunk+0x5/0x5f
[ 2459.013188]  ? srso_return_thunk+0x5/0x5f
[ 2459.013198]  ? assign_work+0x16c/0x240
[ 2459.013224]  worker_thread+0x58d/0xcf0
[ 2459.013241]  ? srso_return_thunk+0x5/0x5f
[ 2459.013273]  ? __pfx_worker_thread+0x10/0x10
[ 2459.013294]  kthread+0x3d8/0x7a0
[ 2459.013310]  ? __pfx_kthread+0x10/0x10
[ 2459.013328]  ? srso_return_thunk+0x5/0x5f
[ 2459.013338]  ? rcu_is_watching+0x11/0xb0
[ 2459.013354]  ? __pfx_kthread+0x10/0x10
[ 2459.013374]  ret_from_fork+0x30/0x70
[ 2459.013385]  ? __pfx_kthread+0x10/0x10
[ 2459.013398]  ret_from_fork_asm+0x1a/0x30
[ 2459.013452]  </TASK>
[ 2459.013463] INFO: task nvme:2310 blocked for more than 122 seconds.
[ 2459.019757]       Not tainted 6.15.0 #1
[ 2459.023631] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
disables this message.
[ 2459.031497] task:nvme            state:D stack:25296 pid:2310
tgid:2310  ppid:2309   task_flags:0x400100 flags:0x00004002
[ 2459.031519] Call Trace:
[ 2459.031527]  <TASK>
[ 2459.031548]  __schedule+0x8fa/0x1c70
[ 2459.031578]  ? __pfx___schedule+0x10/0x10
[ 2459.031596]  ? srso_return_thunk+0x5/0x5f
[ 2459.031610]  ? find_held_lock+0x32/0x90
[ 2459.031629]  ? srso_return_thunk+0x5/0x5f
[ 2459.031639]  ? __lock_release+0x1a2/0x2c0
[ 2459.031648]  ? srso_return_thunk+0x5/0x5f
[ 2459.031666]  ? schedule+0x1e8/0x270
[ 2459.031691]  schedule+0xdc/0x270
[ 2459.031708]  schedule_timeout+0x1fe/0x240
[ 2459.031724]  ? __pfx_schedule_timeout+0x10/0x10
[ 2459.031735]  ? lock_acquire.part.0+0xb6/0x240
[ 2459.031747]  ? srso_return_thunk+0x5/0x5f
[ 2459.031756]  ? find_held_lock+0x32/0x90
[ 2459.031766]  ? srso_return_thunk+0x5/0x5f
[ 2459.031776]  ? local_clock_noinstr+0x9/0xc0
[ 2459.031791]  ? srso_return_thunk+0x5/0x5f
[ 2459.031800]  ? __lock_release+0x1a2/0x2c0
[ 2459.031810]  ? srso_return_thunk+0x5/0x5f
[ 2459.031826]  ? srso_return_thunk+0x5/0x5f
[ 2459.031836]  ? rcu_is_watching+0x11/0xb0
[ 2459.031850]  ? _raw_spin_unlock_irq+0x24/0x50
[ 2459.031861]  ? srso_return_thunk+0x5/0x5f
[ 2459.031899]  __wait_for_common+0x1d3/0x4e0
[ 2459.031913]  ? __pfx_schedule_timeout+0x10/0x10
[ 2459.031940]  ? __pfx___wait_for_common+0x10/0x10
[ 2459.031951]  ? start_flush_work+0x4d5/0x9b0
[ 2459.031973]  ? srso_return_thunk+0x5/0x5f
[ 2459.031983]  ? start_flush_work+0x4df/0x9b0
[ 2459.032014]  __flush_work+0x103/0x1a0
[ 2459.032029]  ? __pfx___flush_work+0x10/0x10
[ 2459.032048]  ? __pfx_wq_barrier_func+0x10/0x10
[ 2459.032090]  ? __wait_for_common+0x9d/0x4e0
[ 2459.032121]  ? srso_return_thunk+0x5/0x5f
[ 2459.032133]  ? srso_return_thunk+0x5/0x5f
[ 2459.032143]  ? lockdep_hardirqs_on+0x78/0x100
[ 2459.032169]  nvme_passthru_end+0x24a/0x400 [nvme_core]
[ 2459.032216]  nvme_submit_user_cmd+0x260/0x320 [nvme_core]
[ 2459.032265]  nvme_user_cmd.constprop.0+0x246/0x450 [nvme_core]
[ 2459.032315]  ? __pfx_nvme_user_cmd.constprop.0+0x10/0x10 [nvme_core]
[ 2459.032380]  ? srso_return_thunk+0x5/0x5f
[ 2459.032390]  ? ioctl_has_perm.constprop.0.isra.0+0x27a/0x420
[ 2459.032429]  ? srso_return_thunk+0x5/0x5f
[ 2459.032442]  ? srso_return_thunk+0x5/0x5f
[ 2459.032467]  blkdev_ioctl+0x235/0x5c0
[ 2459.032484]  ? __pfx_blkdev_ioctl+0x10/0x10
[ 2459.032526]  __x64_sys_ioctl+0x132/0x190
[ 2459.032549]  do_syscall_64+0x8c/0x180
[ 2459.032566]  ? srso_return_thunk+0x5/0x5f
[ 2459.032575]  ? __lock_release+0x1a2/0x2c0
[ 2459.032595]  ? count_memcg_events_mm.constprop.0+0xd4/0x200
[ 2459.032609]  ? srso_return_thunk+0x5/0x5f
[ 2459.032619]  ? find_held_lock+0x32/0x90
[ 2459.032631]  ? local_clock_noinstr+0x9/0xc0
[ 2459.032646]  ? srso_return_thunk+0x5/0x5f
[ 2459.032655]  ? __lock_release+0x1a2/0x2c0
[ 2459.032675]  ? exc_page_fault+0x59/0xe0
[ 2459.032690]  ? srso_return_thunk+0x5/0x5f
[ 2459.032706]  ? srso_return_thunk+0x5/0x5f
[ 2459.032716]  ? do_user_addr_fault+0x489/0xb10
[ 2459.032731]  ? srso_return_thunk+0x5/0x5f
[ 2459.032741]  ? rcu_is_watching+0x11/0xb0
[ 2459.032753]  ? srso_return_thunk+0x5/0x5f
[ 2459.032767]  ? srso_return_thunk+0x5/0x5f
[ 2459.032789]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[ 2459.032800] RIP: 0033:0x7faaddb03a8b
[ 2459.032812] RSP: 002b:00007ffd9c90e418 EFLAGS: 00000246 ORIG_RAX:
0000000000000010
[ 2459.032828] RAX: ffffffffffffffda RBX: 00007ffd9c90e480 RCX: 00007faaddb03a8b
[ 2459.032837] RDX: 00007ffd9c90e480 RSI: 00000000c0484e41 RDI: 0000000000000003
[ 2459.032846] RBP: 0000000000000000 R08: 0000000000000001 R09: 0000000000000000
[ 2459.032855] R10: 0000000000008000 R11: 0000000000000246 R12: 0000000000000003
[ 2459.032863] R13: 00000000c0484e41 R14: 0000000000000000 R15: 0000000000000001
[ 2459.032936]  </TASK>
[ 2459.032945]
               Showing all locks held in the system:
[ 2459.039161] 1 lock held by khungtaskd/141:
[ 2459.043289]  #0: ffffffffa1330220 (rcu_read_lock){....}-{1:3}, at:
debug_show_all_locks+0x32/0x1c0
[ 2459.052305] 1 lock held by kworker/u67:3/365:
[ 2459.056695]  #0: ffff8881a06b11f0 (&q->limits_lock){+.+.}-{4:4},
at: nvme_update_ns_info_block+0x2b0/0x19a0 [nvme_core]
[ 2459.067582] 1 lock held by systemd-journal/878:
[ 2459.072155] 4 locks held by in:imjournal/1245:
[ 2459.076638] 3 locks held by kworker/u67:0/1471:
[ 2459.081197]  #0: ffff88810192e958
((wq_completion)async){+.+.}-{0:0}, at: process_one_work+0x1109/0x1950
[ 2459.090736]  #1: ffffc900097efd40
((work_completion)(&entry->work)){+.+.}-{0:0}, at:
process_one_work+0x814/0x1950
[ 2459.101140]  #2: ffff8881a06b11f0 (&q->limits_lock){+.+.}-{4:4},
at: nvme_update_ns_info_block+0x2b0/0x19a0 [nvme_core]
[ 2459.112025] 3 locks held by kworker/u67:1/1480:
[ 2459.116590]  #0: ffff888231b52958
((wq_completion)nvme-wq){+.+.}-{0:0}, at:
process_one_work+0x1109/0x1950
[ 2459.126299]  #1: ffffc9000988fd40
((work_completion)(&ctrl->scan_work)){+.+.}-{0:0}, at:
process_one_work+0x814/0x1950
[ 2459.137046]  #2: ffff888100f20430 (&ctrl->scan_lock){+.+.}-{4:4},
at: nvme_scan_work+0x12a/0x540 [nvme_core]
[ 2459.148490] =============================================


-- 
Best Regards,
  Yi Zhang


