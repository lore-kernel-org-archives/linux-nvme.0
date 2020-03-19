Return-Path: <SRS0=OxAA=5E=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B383C4332D
	for <linux-nvme@archiver.kernel.org>; Thu, 19 Mar 2020 01:12:44 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4695820767
	for <linux-nvme@archiver.kernel.org>; Thu, 19 Mar 2020 01:12:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="WQ3lLV6k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4695820767
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=M+rqYsyx7Jz0T785aRzutVOO2Y5/P3hWj451aYOiiyY=; b=WQ3lLV6kvIyELnUEMXezhSau/
	47tvzSOHlwqpyz6NOX4993z1SqlKkoSqtaVyx14m28mH1nZ+/iYTP+ewnaOE/sj16d3rjd3WWbwK3
	ejVawCXx8K0Q/K476YI5TkdRuJj6qFsm+tGzXAfbtzpsAfLJHESpzoNfbv8daMh4v+7clYzyH7AeR
	2b85TbMO+BbFdzaXpqJEwCoS4Cl9jZ4eycbvegT3Edqx9DVwyGFd7nZbU1Na7bRNxRVtkxr+Q80Na
	vV1/kcIVXbQIoHKzJZI3dGF4hkQfr3jcQSDdd+6oZbD1UL0QuOQraJ8S1bEYGMMfEGx6Ao0yVbIlY
	9VDzsXltg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jEjjj-0004Dv-Lj; Thu, 19 Mar 2020 01:12:39 +0000
Received: from mail-pl1-f194.google.com ([209.85.214.194])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jEjjg-0004Cz-6u
 for linux-nvme@lists.infradead.org; Thu, 19 Mar 2020 01:12:38 +0000
Received: by mail-pl1-f194.google.com with SMTP id r3so270640pls.13
 for <linux-nvme@lists.infradead.org>; Wed, 18 Mar 2020 18:12:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=meTjaMJwknerKtXARc6XOq7l3Gt7r6wHueAOQjp7VE8=;
 b=WU3I9oaDqCtj8TJ03KF9aCDL/8lx4gergnGwTdsiYGZzlk6o87iba1B4WZuSDO2qGD
 9e0VfRkkpoAED7PO3u3MOwB6HMJq9k+uB5PkwhKl8mI+u6iwr2/jKb4b0izxh84zICyo
 cOEJ3gHlfj02j+cGyU7WOf5p4M+BM+ZCDirBVwpiL7YagA7xGhFt/5J49smxyOMyq6Cb
 WG1R6kzW6JJrfoHixDNz4tP+K6EBkTTBij/RzFZ43sB9ltUBn5snb90a6livQtIOh6Bp
 fJtKZbrmd+6Mj4qxq0hwrIPhyr/Q6SG2PBHSrvmg90ljl+uoNWMOQu3PpLyfRWgrLHeX
 ZC1w==
X-Gm-Message-State: ANhLgQ1AYQRU/RYpqEfbGohQQiurJsFgymMPrHxugcRQEIRjztaKH4fY
 Y37F+IuSgcRxcnLtytvZc9ayiOIy
X-Google-Smtp-Source: ADFU+vvUAPaI0C4PoEnt+Dbpk2gX1cQowwUzj/rJ5vGIVOJSEDofjpLzKw4KGZw8kLmSzI62cXHehQ==
X-Received: by 2002:a17:902:9348:: with SMTP id
 g8mr1027937plp.112.1584580354788; 
 Wed, 18 Mar 2020 18:12:34 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:4c16:3659:1bcd:fcc1?
 ([2601:647:4802:9070:4c16:3659:1bcd:fcc1])
 by smtp.gmail.com with ESMTPSA id v123sm217943pfv.146.2020.03.18.18.12.33
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 18 Mar 2020 18:12:33 -0700 (PDT)
Subject: Re: Sighting: Kernel fault with large write (512k) and io_uring
To: "Wunderlich, Mark" <mark.wunderlich@intel.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
References: <MW3PR11MB4684AEE8587BFCC0A9F41DE4E5F70@MW3PR11MB4684.namprd11.prod.outlook.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <4eaa3e21-833d-f6ec-3b14-58dd2022a381@grimberg.me>
Date: Wed, 18 Mar 2020 18:12:32 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Firefox/60.0 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <MW3PR11MB4684AEE8587BFCC0A9F41DE4E5F70@MW3PR11MB4684.namprd11.prod.outlook.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200318_181236_255868_79553DE8 
X-CRM114-Status: GOOD (  15.83  )
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
Cc: Jens Axboe <axboe@kernel.dk>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Hey Mark, thanks for reporting

> Hope all are well out there - wash hands (mine are getting rather chapped) and keep a good social distance.

:)

> OK for my sighting.  Recently experienced a large write failure and so I retested after removing all development patches.
> I rebuilt initiator kernel removing all development patches, except the priority patch (but set to 0, making it a noop) and the three stability patches listed below I had to apply to correct a previous fault I had seen when using baseline branch nvme-5.5-rc.  With the FIO verify options turned on I see a different failure report (shown at bottom)  So, wondering if any one out there knows of some other lingering large write issue that may have been fixed?
> 
> Three stability patches added to tip of branch, suggested previously to fix an issue (list add corruption) I reported on linux-block list:
> - io-wq-re-add-io_wq_current_is_worker
> - io_uring-ensure-workqueue-offload-grabs-ring-mutex
> - io_uring-clear-req-result-always-before-issuing
> 
> The initiator host kernel fault details are the following:
> 
> [ 1907.415517] nvme nvme0: queue 5: timeout request 0x11 type 6
> [ 1907.415519] nvme nvme0: starting error recovery
> [ 1908.432805] BUG: kernel NULL pointer dereference, address: 00000000000000c8
> [ 1908.433229] #PF: supervisor read access in kernel mode
> [ 1908.433536] #PF: error_code(0x0000) - not-present page
> [ 1908.433844] PGD 8000001f8e7c2067 P4D 8000001f8e7c2067 PUD 202eab9067 PMD 0
> [ 1908.434292] Oops: 0000 [#1] SMP PTI
> [ 1908.434498] CPU: 3 PID: 5626 Comm: fio Tainted: G           O      5.5.0-rc2stable+ #56
> [ 1908.434967] Hardware name: Dell Inc. PowerEdge R740/00WGD1, BIOS 1.4.9 06/29/2018
> [ 1908.435408] RIP: 0010:nvme_tcp_try_recv+0x59/0x90 [nvme_tcp]

Can you run:
gdb drivers/nvme/host/nvme-tcp.ko
...
$ l *(nvme_tcp_try_recv+0x59)

But this looks like a use-after-free condition.

This is interesting, when we go ahead and do error recovery, I am
wandering what is supposed to stop/quiesce blk_poll before safely
tearing down and freeing stuff..

I suspect that this will be common to others that implement blk_poll?

> [ 1908.435739] Code: 24 20 31 c0 49 8b 5c 24 18 48 89 df e8 d0 c6 58 d9 c7 45 60 00 00 00 00 49 8b 44 24 20 48 c7 c2 40 c0 26 c0 48 89 e6 48 89 df <48> 8b 80 c8 00 00 00 e8 3b 67 99 d9 48 89 df 89 c5 e8 c1 e6 58 d9
> [ 1908.436838] RSP: 0018:ffffb5f309b7bcb0 EFLAGS: 00010286
> [ 1908.437144] RAX: 0000000000000000 RBX: ffff89164c076900 RCX: 0000000000000000
> [ 1908.437561] RDX: ffffffffc026c040 RSI: ffffb5f309b7bcb0 RDI: ffff89164c076900
> [ 1908.437978] RBP: ffff8915f63e0460 R08: 0000000000000000 R09: 0000000000000001
> [ 1908.438396] R10: 0000000000000024 R11: 071c71c71c71c71c R12: ffff8916624b2d80
> [ 1908.438813] R13: ffff89167045c000 R14: ffff8915f73e5230 R15: ffff8905f53c9800
> [ 1908.439231] FS:  00007f1d60ebc700(0000) GS:ffff89167f040000(0000) knlGS:0000000000000000
> [ 1908.439705] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ 1908.440041] CR2: 00000000000000c8 CR3: 000000201e2a2003 CR4: 00000000007606e0
> [ 1908.440458] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [ 1908.440875] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [ 1908.441292] PKRU: 55555554
> [ 1908.441450] Call Trace:
> [ 1908.441597]  nvme_tcp_poll+0x49/0x70 [nvme_tcp]
> [ 1908.441866]  blk_poll+0x25a/0x360
> [ 1908.442067]  io_iopoll_getevents+0xe8/0x360
> [ 1908.442315]  ? __switch_to_asm+0x40/0x70
> [ 1908.442546]  __io_iopoll_check+0x4b/0xa0
> [ 1908.442777]  __x64_sys_io_uring_enter+0x19c/0x600
> [ 1908.443055]  ? schedule+0x4a/0xb0
> [ 1908.443254]  do_syscall_64+0x5b/0x1b0
> [ 1908.443469]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> [ 1908.443765] RIP: 0033:0x7f1dd17ecec9
> [ 1908.443975] Code: 01 00 48 81 c4 80 00 00 00 e9 f1 fe ff ff 0f 1f 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 97 cf 2c 00 f7 d8 64 89 01 48
> [ 1908.445073] RSP: 002b:00007f1d60ebbac8 EFLAGS: 00000246 ORIG_RAX: 00000000000001aa
> [ 1908.445516] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f1dd17ecec9
> [ 1908.445933] RDX: 0000000000000001 RSI: 0000000000000000 RDI: 0000000000000005
> [ 1908.446350] RBP: 0000000000000020 R08: 0000000000000000 R09: 00007f1d00000000
> 
> If I turn on FIO verification options ( --do_verify=1 --verify=crc32c ) I see the following fault for same 512k write I/O pattern:
> 
> [ 4850.021884] BUG: stack guard page was hit at 00000000291034b3 (stack is 0000000040c9cc3e..00000000e65d9875)
> [ 4850.022471] kernel stack overflow (page fault): 0000 [#1] SMP PTI
> [ 4850.022829] CPU: 3 PID: 3744 Comm: fio Tainted: G           O      5.5.0-rc2stable+ #56
> [ 4850.023298] Hardware name: Dell Inc. PowerEdge R740/00WGD1, BIOS 1.4.9 06/29/2018
> [ 4850.023742] RIP: 0010:memcpy_erms+0x6/0x10
> [ 4850.023982] Code: cc cc cc cc eb 1e 0f 1f 00 48 89 f8 48 89 d1 48 c1 e9 03 83 e2 07 f3 48 a5 89 d1 f3 a4 c3 66 0f 1f 44 00 00 48 89 f8 48 89 d1 <f3> a4 c3 0f 1f 80 00 00 00 00 48 89 f8 48 83 fa 20 72 7e 40 38 fe
> [ 4850.025087] RSP: 0018:ffffb8ec09557b68 EFLAGS: 00010206
> [ 4850.025392] RAX: ffff943ef5c2d840 RBX: ffff943ee9216500 RCX: 00000000000003e0
> [ 4850.025808] RDX: 0000000000000800 RSI: ffffb8ec09558000 RDI: ffff943ef5c2dc60
> [ 4850.026225] RBP: 0000000000080000 R08: ffffb8ec09557bd8 R09: 0000000000000080
> [ 4850.026640] R10: ffffffffffffffc0 R11: 0000000000000000 R12: 0000000000000000
> [ 4850.027056] R13: ffffb8ec09557be0 R14: ffffb8ec09557bb8 R15: 0000000000080000
> [ 4850.027472] FS:  00007f5db8053700(0000) GS:ffff943eff040000(0000) knlGS:0000000000000000
> [ 4850.027944] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ 4850.028279] CR2: ffffb8ec09558000 CR3: 000000203a052006 CR4: 00000000007606e0
> [ 4850.028695] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [ 4850.029111] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [ 4850.029527] PKRU: 55555554
> [ 4850.029684] Call Trace:
> [ 4850.029834]  io_setup_async_io+0x51/0xc0
> [ 4850.030065]  io_write+0xe4/0x220
> [ 4850.030256]  ? get_page_from_freelist+0x43f/0x1220
> [ 4850.030538]  io_issue_sqe+0x419/0xac0
> [ 4850.030752]  io_queue_sqe+0x13b/0x620
> [ 4850.030967]  ? kmem_cache_alloc_bulk+0x32/0x230

This one looks related to io_uring and not nvme.

Jens?

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
