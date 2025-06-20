Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54382C71155
	for <linux-nvme@archiver.kernel.org>; Fri, 20 Jun 2025 04:10:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=EdQQ0Xm5m6gTs1w8wBQ33bJTMVOF6LPYcWeHIieM1c8=; b=FokLw2qTrt+JN5SgCP/r3aWsG2
	7NS9Wem+uG0wjWmW0QnpZbU4G/84NRkXSGr0i3f8B4mBEedWaFQGmNIttI2/WljpnFQKjDvxAVTcy
	yJWIU97zHR2swK3cwDCwmALwGAbu1HPrxIfrrDbA5Mr/63FY9Dxw30yLJrxLQrumcxn3yhYcQN5rU
	2Ca6F9Sb90CF16oSLiAfd/uy8qhFyfRZMzpMA9GZ5tj0skLiWFzW5is48TdP5WuyHltT+0Yc8iz4N
	S6dhagEDhh0fq+6p39EZCi+JPEhRyhmvaqZgXK+L9Fk514UbvxJKHFwAAM20Jet7NupT9SdHbZMl8
	yKaIKNyw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uST5V-0000000Eha6-3gLC;
	Fri, 20 Jun 2025 04:10:49 +0000
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uST5S-0000000EhZm-2NIy
	for linux-nvme@lists.infradead.org;
	Fri, 20 Jun 2025 04:10:48 +0000
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-23649faf69fso12776305ad.0
        for <linux-nvme@lists.infradead.org>; Thu, 19 Jun 2025 21:10:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=wbinvd.org; s=wbinvd; t=1750392646; x=1750997446; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EdQQ0Xm5m6gTs1w8wBQ33bJTMVOF6LPYcWeHIieM1c8=;
        b=JmkBLJ5Sz7v2BlOJvsa6s6EHw9KRiMHsc0E5bfNWapiaKm4UIL571XRnx+Ufgyc9NX
         WiOS69XSqmpvaUNGJ/3q6CknYLYCJL4TsJ2C2PML85s7fZeER6FqBcU5AuvQ1VFrKzw3
         wRhtgoJhRnXGfYH5iZJahuAO1I7sXVwg3A6wFC95IPtltvd1burOGDu4rC9ReTuipvTR
         75fH7Kv6TZSgyhv73A6Kbo043/DX+UzZc5gU+O57Rexs2aOwJqJchBt3nlwGVVN4UU9J
         7/+oHbu+k5EKusrT77m160A0fVuDVLxEdA7ux3WwCT+EqYfwOVGdM48cAnhTgx2bnVWy
         yKnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750392646; x=1750997446;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EdQQ0Xm5m6gTs1w8wBQ33bJTMVOF6LPYcWeHIieM1c8=;
        b=ZJm8D9FqSwLY76czmVCKfD/QeZ9vAV+5M6F/tkGTmcqjG8mkihIzyJjWSXOLGHf/ew
         V78tObCkIDBPevljLu7jWI8ZCO5z3USjJLgWmewKWnPn6JUxVuTVQvPleVuMZ5RlsL3U
         dByfUyz1secSjr3lav6dK5fSY4edqs5y1+NmOgswiru4B0kmDdRwDzqQeSFwsaEmtP91
         8ijJ2HPGdLaQTT8UEVpb9tOgPTlr7VkTeRHDRY92NhM0MzYJVV0TCg2Zf+yaDLzK0OJj
         ohthpRBvBpFy5G3WOM3PJaxVqDmq/x2hFaV87r31JYqtjR2vocBdntnCXBLknBEHYFUY
         SlvA==
X-Forwarded-Encrypted: i=1; AJvYcCWITX91lencmwgulqPbTViYKwcDREXM9fXguJN4a+nom+ZnEfQapl8tUhW4woDr7td9wyFNYx4erlG8@lists.infradead.org
X-Gm-Message-State: AOJu0YxN9TmohHaWsW6MbWkIbM3uTsW/WoORyzJCSl24wboT3kQrubcL
	E+0ioDiFaDQX/AHojsre/eWUUrVKSqBY16V8DE7GLj/tdLkRegVFNecuxjZB8dJsrJE=
X-Gm-Gg: ASbGnct8WH053bErNlXK5XzIuqmlpWfx/2nKe1fNEF0pGWa3f0l64BRdC/jVDGkNxqU
	IutGkjZLhKcluDdA+3b8Xt6sNiuNr90+aTuM1t4lAsITreJs/SWql10EJl+Wu8IKJ9IZBvma82r
	LZaak9QZvsCxy5L+fphz9Jw50e7TLiCK2XOf3LFrr0kZZRXLHnUK6+6eq/C5qWg3169MJxU9glx
	nXom+ihpUQ8NwsUpIg3MhJWTlj+7fl/Pu/ii9V411YqUTd9ZkcA3NOS/MaDYU5mGALuN41FhNtv
	qeDVVPNMCk7Fd7Aa2NjxYzAir5NoF0pSk51UgBGaVO7JHlQvMaDwFjX31K61ayhAfHbajhspGZZ
	duoSCcVLW17tIrvrhdmVQWmb+zSf/HrU=
X-Google-Smtp-Source: AGHT+IGNfnk1FSkR3MuMOosoicIh0ACWG3u0OqDq0tkfQyLzW4W+39VO4Rwpl5I2kXHIBvK7Wa64Ug==
X-Received: by 2002:a17:903:1c5:b0:235:eb71:a37b with SMTP id d9443c01a7336-237d9acf901mr18666605ad.46.1750392645572;
        Thu, 19 Jun 2025 21:10:45 -0700 (PDT)
Received: from mozart.vkv.me (192-184-162-253.fiber.dynamic.sonic.net. [192.184.162.253])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-237d86f7cb1sm7308765ad.222.2025.06.19.21.10.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jun 2025 21:10:45 -0700 (PDT)
Date: Thu, 19 Jun 2025 21:10:42 -0700
From: Calvin Owens <calvin@wbinvd.org>
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: Breno Leitao <leitao@debian.org>, Yi Zhang <yi.zhang@redhat.com>,
	linux-block <linux-block@vger.kernel.org>,
	"open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>,
	axboe@kernel.dk, "yukuai (C)" <yukuai3@huawei.com>
Subject: Re: [bug report] WARNING: CPU: 3 PID: 522 at block/genhd.c:144
 bdev_count_inflight_rw+0x26e/0x410
Message-ID: <aFTfQpsUiD1Hw3zU@mozart.vkv.me>
References: <CAHj4cs-uWZcgHLLkE8JeDpkd-ddkWiZCQC_HWObS5D3TAKE9ng@mail.gmail.com>
 <aEal7hIpLpQSMn8+@gmail.com>
 <738f680c-d0e8-b6c0-cfaa-5f420a592c4f@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <738f680c-d0e8-b6c0-cfaa-5f420a592c4f@huaweicloud.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250619_211046_620714_CEA80BBD 
X-CRM114-Status: GOOD (  15.78  )
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

On Tuesday 06/10 at 10:07 +0800, Yu Kuai wrote:
> So, this is blk-mq IO accounting, a different problem than nvme mpath.
>
> What kind of test you're running, can you reporduce ths problem? I don't
> have a clue yet after a quick code review.
>
> Thanks,
> Kuai

Hi all,

I've also been hitting this warning, I can reproduce it pretty
consistently within a few hours of running large Yocto builds. If I can
help test any patches, let me know.

A close approximation to what I'm doing is to clone Poky and build
core-image-weston: https://github.com/yoctoproject/poky

Using a higher than reasonable concurrency seems to help: I'm setting
BB_NUMBER_THREADS and PARALLEL_MAKE to 2x - 4x the number of CPUs. I'm
trying to narrow it down to a simpler reproducer, but haven't had any
luck yet.

I see this on three machines. One is btrfs/luks/nvme, the other two are
btrfs/luks/mdraid1/nvme*2. All three have a very large swapfile on the
rootfs. This is from the machine without mdraid:

    ------------[ cut here ]------------
    WARNING: CPU: 6 PID: 1768274 at block/genhd.c:144 bdev_count_inflight_rw+0x8a/0xc0
    CPU: 6 UID: 1000 PID: 1768274 Comm: cc1plus Not tainted 6.16.0-rc2-gcc-slubdebug-lockdep-00071-g74b4cc9b8780 #1 PREEMPT
    Hardware name: Gigabyte Technology Co., Ltd. A620I AX/A620I AX, BIOS F3 07/10/2023
    RIP: 0010:bdev_count_inflight_rw+0x8a/0xc0
    Code: 00 01 d7 89 3e 49 8b 50 20 4a 03 14 d5 c0 4b 76 82 48 8b 92 90 00 00 00 01 d1 48 63 d0 89 4e 04 48 83 fa 1f 76 92 85 ff 79 a7 <0f> 0b c7 06 00 00 00 00 85 c9 79 9f 0f 0b c7 46 04 00 00 00 00 48
    RSP: 0000:ffffc9002b027ab8 EFLAGS: 00010282
    RAX: 0000000000000020 RBX: ffff88810dec0000 RCX: 000000000000000a
    RDX: 0000000000000020 RSI: ffffc9002b027ac8 RDI: 00000000fffffffe
    RBP: ffff88810dec0000 R08: ffff888100660b40 R09: ffffffffffffffff
    R10: 000000000000001f R11: ffff888f3a30e9a8 R12: ffff8881098855d0
    R13: ffffc9002b027b90 R14: 0000000000000001 R15: ffffc9002b027e18
    FS:  00007fb394b48400(0000) GS:ffff888ccc9b9000(0000) knlGS:0000000000000000
    CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
    CR2: 00007fb3884a81c8 CR3: 00000013db708000 CR4: 0000000000350ef0
    Call Trace:
     <TASK>
     bdev_count_inflight+0x16/0x30
     update_io_ticks+0xb7/0xd0
     blk_account_io_start+0xe8/0x200
     blk_mq_submit_bio+0x34c/0x910
     __submit_bio+0x95/0x5a0
     ? submit_bio_noacct_nocheck+0x169/0x400
     submit_bio_noacct_nocheck+0x169/0x400
     swapin_readahead+0x18a/0x550
     ? __filemap_get_folio+0x26/0x400
     ? get_swap_device+0xe8/0x210
     ? lock_release+0xc3/0x2a0
     do_swap_page+0x1fa/0x1850
     ? __lock_acquire+0x46d/0x25c0
     ? wake_up_state+0x10/0x10
     __handle_mm_fault+0x5e5/0x880
     handle_mm_fault+0x70/0x2e0
     exc_page_fault+0x374/0x8a0
     asm_exc_page_fault+0x22/0x30
    RIP: 0033:0x915570
    Code: ff 01 0f 86 c4 05 00 00 41 56 41 55 41 54 55 48 89 fd 53 48 89 fb 0f 1f 40 00 48 89 df e8 98 c8 0b 00 84 c0 0f 85 90 05 00 00 <0f> b7 03 48 c1 e0 06 80 b8 99 24 d1 02 00 48 8d 90 80 24 d1 02 0f
    RSP: 002b:00007ffc9327dfd0 EFLAGS: 00010246
    RAX: 0000000000000000 RBX: 00007fb3884a81c8 RCX: 0000000000000008
    RDX: 0000000000000006 RSI: 0000000005dba008 RDI: 0000000000000000
    RBP: 00007fb3884a81c8 R08: 000000000000000c R09: 00000007fb3884a8
    R10: 0000000000000007 R11: 0000000000000206 R12: 0000000000000000
    R13: 0000000000000002 R14: 00007ffc9329cb90 R15: 00007fb36e5d2700
     </TASK>
    irq event stamp: 36649373
    hardirqs last  enabled at (36649387): [<ffffffff813cea2d>] __up_console_sem+0x4d/0x50
    hardirqs last disabled at (36649398): [<ffffffff813cea12>] __up_console_sem+0x32/0x50
    softirqs last  enabled at (36648786): [<ffffffff8136017f>] __irq_exit_rcu+0x8f/0xb0
    softirqs last disabled at (36648617): [<ffffffff8136017f>] __irq_exit_rcu+0x8f/0xb0
    ---[ end trace 0000000000000000 ]---

I dumped all the similar WARNs I've seen here (blk-warn-%d.txt):

    https://github.com/jcalvinowens/lkml-debug-616/tree/master

I don't have any evidence it's related, but I'm also hitting a rare OOPS
in futex with this same Yocto build workload. Sebastian has done some
analysis here:

    https://lore.kernel.org/lkml/20250618160333.PdGB89yt@linutronix.de/

I get this warning most of the time I get the oops, but not all of the
time. Curious if anyone else is seeing the oops?

Thanks,
Calvin

