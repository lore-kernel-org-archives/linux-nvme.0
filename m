Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55155C5ACB3
	for <linux-nvme@archiver.kernel.org>; Tue, 21 Nov 2023 09:27:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+HwHZNk1hx/S4I3odtRaE1Y7YOia/lUS67WfyzACR8w=; b=0mN3Q4fiSnw37hcQ4zQfPLlcdM
	pBTs1O9XldSs+KovuUZUcQ1SvA1Gy44bp+PYMB6EinfWbpXPAhWwu1kM74CXnH+lV6LQvuXiM5qjC
	2Mxrb7ovOHv3B/IT+jKGwcYaAdBhN70d5MHJtBHiQatqZl8yIk87g6tdqeIYvPcPCDlPwUUQ5wFur
	4eBON35xIp6FmK/I7zWw13lVusulA6MC9ipegKBsJmlow9rNhLAKh5MEscRZ8+PUOBHHB0rnkpKaa
	+flQl4u9AW7FqoO2HZRT17+pZJD3H8vJNylmx/SYdGboDRmfAld2yRPgMkv/cEgCgtfkvyFCIBuYZ
	IWLLJjMA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r5N22-00G82O-39;
	Tue, 21 Nov 2023 09:26:58 +0000
Received: from mail-wr1-f53.google.com ([209.85.221.53])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r5N1y-00G80G-2j
	for linux-nvme@lists.infradead.org;
	Tue, 21 Nov 2023 09:26:56 +0000
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-32fc2720c47so1210112f8f.0
        for <linux-nvme@lists.infradead.org>; Tue, 21 Nov 2023 01:26:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700558812; x=1701163612;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+HwHZNk1hx/S4I3odtRaE1Y7YOia/lUS67WfyzACR8w=;
        b=qmBx5ZQCfWXBk2WB/Hwqj7mEyzbYC5NBM4Y4nS1tIEwqM+hjq/FI7EGIvUrRhTzAvW
         GH2aCYjdaGwYvV/zY1QEnIJ4E4bx2exbzNfpKF3Me4M9PnwWtycMcLAWjWVK6ZmM6tqQ
         VkUCvbXKryZeOJ71U1UNxBy33YzJk1QYCq1QxGWVi2P+Zch+n51wLSWui1ZyOSAedJ0H
         /QeeVOItXIEkMnIu0JM/AtoVQWhgstV0Z/3rBVWMkDOIEuN+lk1pZ1lci8Dp8YDk6UOu
         /8d1bmYJLJLAudXIMeKWzbAS/UrC0PN7AtkYpXYLNBq9GvjF1E1BXeWZCxkCyUR98fkG
         Sw/A==
X-Gm-Message-State: AOJu0YzFkMR/itvF96tFjhNo8S+vogcgHRnfSGbUwiZ45TX6v2SIhMUV
	S7vR4u1gD3/vpbEkdmzGxHpv48OJQ7c=
X-Google-Smtp-Source: AGHT+IEWZuQmI1RbNUhHe+mWuW2qG4bAyBWLrVTFpcuyKg0Aeo+U4tSxWsIYs9cpLIUSsCImj6pfKA==
X-Received: by 2002:a05:600c:1ca4:b0:405:1ba2:4fcf with SMTP id k36-20020a05600c1ca400b004051ba24fcfmr8162560wms.4.1700558811898;
        Tue, 21 Nov 2023 01:26:51 -0800 (PST)
Received: from [192.168.64.177] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id q16-20020adfcd90000000b0032d9caeab0fsm13907759wrj.77.2023.11.21.01.26.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Nov 2023 01:26:51 -0800 (PST)
Message-ID: <a1556159-5224-4cf1-b6bd-81875dba9b6e@grimberg.me>
Date: Tue, 21 Nov 2023 11:26:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Bug Report] NVMe-oF/TCP - NULL Pointer Dereference in
 `nvmet_tcp_build_iovec`
Content-Language: en-US
To: Alon Zahavi <zahavi.alon@gmail.com>
Cc: linux-nvme@lists.infradead.org, Chaitanya Kulkarni
 <chaitanyak@nvidia.com>, Christoph Hellwig <hch@lst.de>
References: <CAK5usQv0opo1n6VyysRD28VnML-V8tMD1YbZPUSJxth0gXR=SQ@mail.gmail.com>
 <CAK5usQtW2SNSjQpMWyvGVhVjU-y4cdjEn4DrA5xx2R-hjscn5g@mail.gmail.com>
 <d972c5e5-523a-4b9a-83d5-ff8a1604139f@grimberg.me>
 <CAK5usQvU67+NugSh-mr3PVQWLxSv8Du=CLZueDk4r4tgNAXGDw@mail.gmail.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <CAK5usQvU67+NugSh-mr3PVQWLxSv8Du=CLZueDk4r4tgNAXGDw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231121_012654_893237_4A391508 
X-CRM114-Status: GOOD (  26.54  )
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



On 11/20/23 17:29, Alon Zahavi wrote:
> On Mon, 20 Nov 2023 at 12:50, Sagi Grimberg <sagi@grimberg.me> wrote:
>>
>>
>>
>> On 11/15/23 11:35, Alon Zahavi wrote:
>>> Just sending another reminder for this issue.
>>> Until a fix for this there is a remote DoS that can be triggered.
>>>
>>> On Mon, 6 Nov 2023 at 15:40, Alon Zahavi <zahavi.alon@gmail.com> wrote:
>>>>
>>>> # Bug Overview
>>>>
>>>> ## The Bug
>>>> A null-ptr-deref in `nvmet_tcp_build_iovec`.
>>>>
>>>> ## Bug Location
>>>> `drivers/nvme/target/tcp.c` in the function `nvmet_tcp_build_iovec`.
>>>>
>>>> ## Bug Class
>>>> Remote Denial of Service
>>>>
>>>> ## Disclaimer:
>>>> This bug was found using Syzkaller with NVMe-oF/TCP added support.
>>>>
>>
>> Hey Alon, thanks for the report.
>>
>>>> # Technical Details
>>>>
>>>> ## Kernel Report - NULL Pointer Dereference
>>>> ```
>>>> [  157.833470] BUG: kernel NULL pointer dereference, address:
>>>> 000000000000000c
>>>> [  157.833478] #PF: supervisor read access in kernel mode
>>>> [  157.833484] #PF: error_code(0x0000) - not-present page
>>>> [  157.833490] PGD 126e40067 P4D 126e40067 PUD 130d16067 PMD 0
>>>> [  157.833506] Oops: 0000 [#1] PREEMPT SMP NOPTI
>>>> [  157.833515] CPU: 3 PID: 3067 Comm: kworker/3:3H Kdump: loaded Not
>>>> tainted 6.5.0-rc1+ #5
>>>> [  157.833525] Hardware name: VMware, Inc. VMware Virtual
>>>> Platform/440BX Desktop Reference Platform, BIOS 6.00 11/12/2020
>>>> [  157.833532] Workqueue: nvmet_tcp_wq nvmet_tcp_io_work
>>>> [  157.833546] RIP: 0010:nvmet_tcp_build_pdu_iovec+0x7a/0x120
>>>> [  157.833558] Code: fe 44 89 a3 20 02 00 00 49 c1 e4 05 4c 03 63 30
>>>> 4c 89 75 d0 41 89 c6 e8 34 b8 18 ff 45 85 ff 0f 84 99 00 00 00 e8 06
>>>> bd 18 ff <41> 8b 74 24 0c 41 8b 44 24 08 4c 89 e7 49 8b 0c 24 89 f2 41
>>>> 89 75
>>>> [  157.833568] RSP: 0018:ffffc9001ab83c28 EFLAGS: 00010293
>>>> [  157.833576] RAX: 0000000000000000 RBX: ffff88812b9583e0 RCX: 0000000000000000
>>>> [  157.833584] RDX: ffff888131b10000 RSI: ffffffff82191dda RDI: ffffffff82191dcc
>>>> [  157.833591] RBP: ffffc9001ab83c58 R08: 0000000000000005 R09: 0000000000000000
>>>> [  157.833598] R10: 0000000000000007 R11: 0000000000000000 R12: 0000000000000000
>>>> [  157.833605] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000007
>>>> [  157.833612] FS:  0000000000000000(0000) GS:ffff888233f80000(0000)
>>>> knlGS:0000000000000000
>>>> [  157.833630] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>>> [  157.833638] CR2: 000000000000000c CR3: 0000000122dd4002 CR4: 00000000007706e0
>>>> [  157.833659] PKRU: 55555554
>>>> [  157.833686] Call Trace:
>>>> [  157.833691]  <TASK>
>>>> [  157.833712]  ? show_regs+0x6e/0x80
>>>> [  157.833745]  ? __die+0x29/0x70
>>>> [  157.833757]  ? page_fault_oops+0x278/0x740
>>>> [  157.833784]  ? up+0x3b/0x70
>>>> [  157.833835]  ? do_user_addr_fault+0x63b/0x1040
>>>> [  157.833846]  ? __sanitizer_cov_trace_const_cmp4+0x1a/0x20
>>>> [  157.833862]  ? irq_work_queue+0x95/0xc0
>>>> [  157.833874]  ? exc_page_fault+0xcf/0x390
>>>> [  157.833889]  ? asm_exc_page_fault+0x2b/0x30
>>>> [  157.833925]  ? nvmet_tcp_build_pdu_iovec+0x7a/0x120
>>>> [  157.833958]  ? nvmet_tcp_build_pdu_iovec+0x6c/0x120
>>>> [  157.833971]  ? nvmet_tcp_build_pdu_iovec+0x7a/0x120
>>>> [  157.833998]  ? nvmet_tcp_build_pdu_iovec+0x7a/0x120
>>>> [  157.834011]  nvmet_tcp_try_recv_pdu+0x995/0x1310
>>>> [  157.834066]  nvmet_tcp_io_work+0xe6/0xd90
>>>> [  157.834081]  process_one_work+0x3da/0x870
>>>> [  157.834112]  worker_thread+0x67/0x640
>>>> [  157.834124]  kthread+0x164/0x1b0
>>>> [  157.834138]  ? __pfx_worker_thread+0x10/0x10
>>>> [  157.834148]  ? __pfx_kthread+0x10/0x10
>>>> [  157.834162]  ret_from_fork+0x29/0x50
>>>> [  157.834180]  </TASK>
>>>> ```
>>>>
>>>> ## Description
>>>>
>>>> ### Tracing The Bug
>>>> As written above, the bug occurs during the execution of
>>>> nvmet_tcp_build_iovec. Looking at the kernel logs report we can see
>>>> the exact line of code that triggers the bug.
>>>>
>>>> Code Block 1:
>>>> ```
>>>> static void nvmet_tcp_build_pdu_iovec(struct nvmet_tcp_cmd *cmd)
>>>> {
>>>>     ...
>>>>     sg = &cmd->req.sg[cmd->sg_idx]; // #1
>>>>
>>>>     while (length) {
>>>>       u32 iov_len = min_t(u32, length, sg->length - sg_offset); // #2
>>>>     ...
>>>>     }
>>>> ...
>>>> }
>>>> ```
>>>> Breakdown:
>>>>
>>>> 1. The variable `sg` is getting the value of  `&cmd->req.sg[cmd->sg_idx]`.
>>>> At the assembly level (intel flavor):
>>>> ```
>>>> mov    DWORD PTR [rbx+0x220], r12d     ; r12 holds the `cmd` address
>>>> add    r12, QWORD PTR [rbx+0x30]          ; adding the value of
>>>> `req.sg[cmd->sg_idx]`
>>>> ```
>>>>
>>>> However, `cmd->req.sg` is NULL at this point of execution thus `sg`
>>>> will point to `0 + cmd->sg_idx`, which will most likely be either 0x0
>>>> or 0x1, a non-accessible memory addresses.
>>>>
>>>> 2. After moving the address into `sg` the driver will dereference it
>>>> later, inside the while loop.
>>>> ```
>>>> mov    esi, DWORD PTR [r12+0xc]
>>>> ```
>>>> When getting here, `r12` will point into (probably) 0x0. This means
>>>> that the CPU will try to access the memory address 0xC and will
>>>> trigger a NULL pointer dereference.
>>>>
>>>>
>>>> ## Root Cause
>>>> `req` is initialized during `nvmet_req_init`. However, the sequence
>>>> that leads into `nvmet_tcp_build_iovec` does not contain any call for
>>>> `nvmet_req_init`, thus crashing the kernel with NULL pointer
>>>> dereference. This flow of execution can also create a situation where
>>>> an uninitialized memory address will be dereferenced, which has
>>>> undefined behaviour.
>>
>> If req->sg was not allocated, we shouldn't build a corresponding iovec.
>> There is a case where we encounter a failure where nvmet_req_init is
>> not called, but instead nvmet_tcp_handle_req_failure is called and
>> should properly initialize req->sg and the corresponding iovec.
>>
>> The intention is to drain the error request from the socket, or at
>> least attempt to do so so the connection recovers.
>>
>> I'd be interested to know if this path (nvmet_tcp_handle_req_failure)
>> is taken or there is something else going on....
>>
> 
> Looking at some other kernel reports (an example below) for the same
> issue I can see that the call for `nvmet_tcp_build_pdu_iovec` is
> executed during `nvmet_tcp_handle_h2c_data_pdu`.
> The call for `nvmet_tcp_handle_h2c_data_pdu` is just too early, and
> does not have the required checks before calling
> `nvmet_tcp_build_pdu_iovec` later.

Yes, as Chaitnaya pointed out, we are missing proper error handling when
the host sends a malformed h2cdata pdu.

> 
> ```
> Call Trace:
>   <TASK>
>   nvmet_tcp_handle_h2c_data_pdu drivers/nvme/target/tcp.c:988 [inline]
>   nvmet_tcp_done_recv_pdu drivers/nvme/target/tcp.c:1020 [inline]
>   nvmet_tcp_try_recv_pdu+0xddf/0x1cb0 drivers/nvme/target/tcp.c:1182
>   nvmet_tcp_try_recv_one drivers/nvme/target/tcp.c:1306 [inline]
>   nvmet_tcp_try_recv drivers/nvme/target/tcp.c:1338 [inline]
>   nvmet_tcp_io_work+0x109/0x1510 drivers/nvme/target/tcp.c:1388
>   process_one_work+0x725/0xdc0 kernel/workqueue.c:2597
>   worker_thread+0x3e2/0x9f0 kernel/workqueue.c:2748
>   kthread+0x201/0x250 kernel/kthread.c:389
>   ret_from_fork+0x29/0x50 arch/x86/entry/entry_64.S:308
>   </TASK>
> ```
> BTW this is the same root cause of another bug I reported -
> NVMe-oF/TCP - NULL Pointer Dereference in `__nvmet_req_complete`
> (https://lore.kernel.org/linux-nvme/CAK5usQuk-R1auf3_WSgKK6UAO5qeo9zjeWxEB-Wxs2JvFhgLVA@mail.gmail.com/T/#t)

So I take it as this issue covers all the outstanding reports? I've lost
a bit of track catching up on a long backlog of threads.

