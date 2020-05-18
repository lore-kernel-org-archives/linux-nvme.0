Return-Path: <SRS0=Nwsb=7A=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53B91C433E0
	for <linux-nvme@archiver.kernel.org>; Mon, 18 May 2020 07:51:46 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 09F5C207ED
	for <linux-nvme@archiver.kernel.org>; Mon, 18 May 2020 07:51:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="sPTA5zmT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09F5C207ED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=QOFepsjxfxBLGSL8xEFrrwUGaH3L7CPEi8IqEf+GAFw=; b=sPTA5zmT/04A8TgjGNQ10jR0U
	5JjxyetabWVOcJKs004qKaO/48e8qFilxTMnfoICNXGZT56T8hOzI2l/BBpyLuuk1bQ2AVpS/3SfV
	j5KX8T54laay2e1AyZH+NVtLGjKKxRV2UI7D9C26pCAnJy8TX+DZ1k5ovT7K/a/Fj+QIQ3Uls5NLs
	xqw3BsYQF+my1Oh/0V3fnFu3MwDcJFqd1kDfrq5OIT1ccA3ylggNAKiQOtWVD+/BvHb5asNdAyjqI
	/wN7MHDD9LzhqnWqkbgWhQgOPkQxhbU/B4rlKNjeiiFmH41Av6elmdtwCfuBAr2UQWjQnQcE3BgYj
	ljKlZsKig==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jaaYp-0007A1-78; Mon, 18 May 2020 07:51:43 +0000
Received: from mail-pg1-f193.google.com ([209.85.215.193])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jaaYm-00078p-3C
 for linux-nvme@lists.infradead.org; Mon, 18 May 2020 07:51:41 +0000
Received: by mail-pg1-f193.google.com with SMTP id t11so4445397pgg.2
 for <linux-nvme@lists.infradead.org>; Mon, 18 May 2020 00:51:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=PJqN3nxx9g+qir2vKLIX0oymMMJKUjbkre+FyPBxLpk=;
 b=Qt+z65kk0v4t/FkNJQD9ZxGY2VzJBOduFza/tc0s6btHaEklFS3d2ajrh7U+FOpj8n
 KngiYtUAjtAzkKi8H/PeXk3a8LvkGfv6gW99zCyisYmcUBaG3RH265JQwFhpXWqgsJVD
 lx7qtBkLwCmXK4ivZjXCLwq0krdJPfac0B32C7vsjv7ykA4hCurueOY7WQtKv1Od1yHK
 KcyfposeAqMGxK6ryUsMHOHJ6dAzFHeIM7zT2N/CWZ9TIeLbvwYNNnoirC+L+ZHxd14I
 8YQ9cgTqUs6a+eoYa7/R1/C+i4gE0mo6S43NE4ghvbp+AOearWQ2MDLA4lRL5LdexBpP
 s0WQ==
X-Gm-Message-State: AOAM533Bf6sC66jmhtkbxx3PTmf/sqvsgmGd29MjJATUnwbT+3zODUeY
 rNUIZw+E3yXQUA3TesjCud04m5hgJAs=
X-Google-Smtp-Source: ABdhPJzCsVYft7ZWtjKbZIF3JaX9bXCkAo0e4Eg1m9/9RBwULLEKtIDOWFVbXwHuFLeNf+2Aec+TaA==
X-Received: by 2002:a63:6e8a:: with SMTP id
 j132mr12246805pgc.301.1589788298843; 
 Mon, 18 May 2020 00:51:38 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:9584:7115:351c:7013?
 ([2601:647:4802:9070:9584:7115:351c:7013])
 by smtp.gmail.com with ESMTPSA id b15sm6923382pgh.47.2020.05.18.00.51.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 18 May 2020 00:51:38 -0700 (PDT)
Subject: Re: nvme double __blk_mq_complete_request() bugs
To: Dongli Zhang <dongli.zhang@oracle.com>, linux-nvme@lists.infradead.org
References: <c77b0998-5112-4d6b-b51c-41d2b901009d@default>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <86a0321e-d260-ef8c-db9f-b804fc92c670@grimberg.me>
Date: Mon, 18 May 2020 00:51:36 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <c77b0998-5112-4d6b-b51c-41d2b901009d@default>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200518_005140_140027_5D75C175 
X-CRM114-Status: GOOD (  18.64  )
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
Cc: linux-block@vger.kernel.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org



On 5/17/20 9:30 PM, Dongli Zhang wrote:
> Hi,
>
> This is to report the below page fault issue for nvme-loop.
>
> [  235.223975] ==================================================================
> [  235.224878] BUG: KASAN: null-ptr-deref in blk_mq_free_request+0x363/0x510
> [  235.225674] Write of size 4 at addr 0000000000000198 by task swapper/3/0
> [  235.226456]
> [  235.226772] ==================================================================
> [  235.227633] BUG: kernel NULL pointer dereference, address: 0000000000000198
> [  235.228447] #PF: supervisor write access in kernel mode
> [  235.229062] #PF: error_code(0x0002) - not-present page
> [  235.229667] PGD 0 P4D 0
> [  235.229976] Oops: 0002 [#1] SMP KASAN PTI
> [  235.230451] CPU: 3 PID: 0 Comm: swapper/3 Tainted: G    B             5.7.0-rc5+ #1
> [  235.231347] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.12.0-59-gc9ba5276e321-prebuilt.qemu.org 04/01/2014
> [  235.232692] RIP: 0010:blk_mq_free_request+0x367/0x510
> [  235.233286] Code: 89 df 5b 5d 41 5c 41 5d 41 5e 41 5f e9 a2 dc ff ff 48 8d ba 98 01 00 00 be 04 00 00 00 48 89 14 24 e8 fd 69 9a ff 48 8b 14 24 <f0> ff 8a 98 01 00 00 e9 e2 fe ff ff 48 83 c4 08 48 89 ef be 03 00
> [  235.235503] RSP: 0018:ffff8881f7389be0 EFLAGS: 00010046
> [  235.236114] RAX: 0000000000000000 RBX: ffff8881f21b9680 RCX: ffffffff816e05b1
> [  235.236941] RDX: 0000000000000000 RSI: 0000000000000046 RDI: 0000000000000046
> [  235.237770] RBP: 0000000000000001 R08: fffffbfff0af5869 R09: fffffbfff0af5869
> [  235.238598] R10: ffffffff857ac347 R11: fffffbfff0af5868 R12: ffff8881f21b969c
> [  235.239424] R13: ffff8881f0f62738 R14: ffffe8ffffd884c0 R15: ffff8881f21b9698
> [  235.240255] FS:  0000000000000000(0000) GS:ffff8881f7380000(0000) knlGS:0000000000000000
> [  235.241192] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  235.241863] CR2: 0000000000000198 CR3: 00000001eb886004 CR4: 0000000000360ee0
> [  235.242695] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [  235.243523] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [  235.244349] Call Trace:
> [  235.244645]  <IRQ>
> [  235.244890]  blk_mq_complete_request+0x266/0x460
> [  235.245432]  nvmet_req_complete+0xd/0xb0
> [  235.245898]  iomap_dio_bio_end_io+0x336/0x480
> [  235.246409]  blk_update_request+0x320/0x960
> [  235.246904]  blk_mq_end_request+0x4e/0x4d0
> [  235.247391]  blk_mq_complete_request+0x266/0x460
> [  235.247937]  virtblk_done+0x164/0x300
> [  235.248372]  ? loop_queue_work.cold.44+0x5e/0x5e
> [  235.248915]  ? rcu_accelerate_cbs+0x5d/0x1a70
> [  235.249429]  ? virtqueue_get_used_addr+0x140/0x140
> [  235.249990]  vring_interrupt+0x16d/0x280
> [  235.250454]  __handle_irq_event_percpu+0xdd/0x470
> [  235.251010]  handle_irq_event_percpu+0x6e/0x130
> [  235.251544]  ? rcu_accelerate_cbs_unlocked+0x110/0x110
> [  235.252145]  ? __handle_irq_event_percpu+0x470/0x470
> [  235.252729]  ? _raw_spin_lock+0x75/0xd0
> [  235.253181]  ? _raw_write_lock+0xd0/0xd0
> [  235.253645]  handle_irq_event+0xc2/0x158
> [  235.254107]  handle_edge_irq+0x1e9/0x7a0
> [  235.254572]  do_IRQ+0x94/0x1e0
> [  235.254936]  common_interrupt+0xf/0xf
> [  235.255368]  </IRQ>
> [  235.255629] RIP: 0010:native_safe_halt+0xe/0x10
> [  235.256162] Code: e9 f2 fe ff ff 48 89 df e8 2f dc f8 fd eb a4 cc cc cc cc cc cc cc cc cc cc cc cc cc e9 07 00 00 00 0f 00 2d a4 7d 4a 00 fb f4 <c3> 90 e9 07 00 00 00 0f 00 2d 94 7d 4a 00 f4 c3 cc cc 41 56 41 55
> [  235.258314] RSP: 0018:ffff8881f61ffdd8 EFLAGS: 00000246 ORIG_RAX: ffffffffffffffde
> [  235.259194] RAX: ffffffff83bc59f0 RBX: dffffc0000000000 RCX: ffffffff83bc6639
> [  235.260022] RDX: 1ffff1103ec398e8 RSI: 0000000000000008 RDI: ffff8881f61cc740
> [  235.260850] RBP: 0000000000000003 R08: ffffed103ec398e9 R09: ffffed103ec398e9
> [  235.261681] R10: ffff8881f61cc747 R11: ffffed103ec398e8 R12: ffffffff84e5c4c0
> [  235.262508] R13: 0000000000000003 R14: 1ffff1103ec3ffc4 R15: 0000000000000000
> [  235.263338]  ? __cpuidle_text_start+0x8/0x8
> [  235.263832]  ? default_idle_call+0x29/0x60
> [  235.264315]  ? tsc_verify_tsc_adjust+0x68/0x1f0
> [  235.264849]  default_idle+0x1a/0x2b0
> [  235.265273]  do_idle+0x2fd/0x3b0
> [  235.265658]  ? arch_cpu_idle_exit+0x40/0x40
> [  235.266151]  ? schedule_idle+0x56/0x90
> [  235.266595]  cpu_startup_entry+0x14/0x20
> [  235.267057]  start_secondary+0x2a6/0x340
> [  235.267522]  ? set_cpu_sibling_map+0x1fb0/0x1fb0
> [  235.268066]  secondary_startup_64+0xb6/0xc0
> [  235.268561] Modules linked in:
> [  235.268929] CR2: 0000000000000198
> [  235.269330] ---[ end trace f8fa823705a3dbe7 ]---
> [  235.269875] RIP: 0010:blk_mq_free_request+0x367/0x510
> [  235.270466] Code: 89 df 5b 5d 41 5c 41 5d 41 5e 41 5f e9 a2 dc ff ff 48 8d ba 98 01 00 00 be 04 00 00 00 48 89 14 24 e8 fd 69 9a ff 48 8b 14 24 <f0> ff 8a 98 01 00 00 e9 e2 fe ff ff 48 83 c4 08 48 89 ef be 03 00
> [  235.272622] RSP: 0018:ffff8881f7389be0 EFLAGS: 00010046
> [  235.273230] RAX: 0000000000000000 RBX: ffff8881f21b9680 RCX: ffffffff816e05b1
> [  235.274063] RDX: 0000000000000000 RSI: 0000000000000046 RDI: 0000000000000046
> [  235.274890] RBP: 0000000000000001 R08: fffffbfff0af5869 R09: fffffbfff0af5869
> [  235.275717] R10: ffffffff857ac347 R11: fffffbfff0af5868 R12: ffff8881f21b969c
> [  235.276545] R13: ffff8881f0f62738 R14: ffffe8ffffd884c0 R15: ffff8881f21b9698
> [  235.277371] FS:  0000000000000000(0000) GS:ffff8881f7380000(0000) knlGS:0000000000000000
> [  235.278307] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  235.278977] CR2: 0000000000000198 CR3: 00000001eb886004 CR4: 0000000000360ee0
> [  235.279805] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [  235.280632] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [  235.281459] Kernel panic - not syncing: Fatal exception in interrupt
> [  235.282474] Kernel Offset: 0x400000 from 0xffffffff81000000 (relocation range: 0xffffffff80000000-0xffffffffbfffffff)
> [  235.283695] ---[ end Kernel panic - not syncing: Fatal exception in interrupt ]---
>
>
> This is because of double __blk_mq_complete_request() when resetting nvme-loop.
>
> # echo 1 > /sys/block/nvme1n1/device/nvme1/reset_controller
>
>
>                                                  nvme_loop_queue_response()
>                                                  -> nvme_end_request()
>                                                     -> blk_mq_complete_request()
> nvme_loop_reset_ctrl_work()
> -> nvme_stop_queues(&ctrl->ctrl)
>     -> blk_mq_tagset_busy_iter(&ctrl->tag_set,
>              nvme_cancel_request, &ctrl->ctrl);
>        -> nvme_cancel_request(): state is not MQ_RQ_COMPLETE()
>           -> blk_mq_complete_request()
>              -> WRITE_ONCE(rq->state, MQ_RQ_COMPLETE);
>                                                        -> __blk_mq_complete_request()
>                                                           -> WRITE_ONCE(rq->state, MQ_RQ_COMPLETE);

Yes, your analysis is correct, we should destroy the nvmet_sq before 
calling the cancel tag iter..

>
>
>
> After code analysis, I think this is for nvme-pci as well.
>
>                                         nvme_process_cq()
>                                         -> nvme_handle_cqe()
>                                            -> nvme_end_request()
>                                               -> blk_mq_complete_request()
> nvme_reset_work()
> -> nvme_dev_disable()
>     -> nvme_reap_pending_cqes()
>        -> nvme_process_cq()
>           -> nvme_handle_cqe()
>              -> nvme_end_request()
>                 -> blk_mq_complete_request()
>                    -> __blk_mq_complete_request()
>                                                  -> __blk_mq_complete_request()

nvme_dev_disable will first disable the queues before reaping the 
pending cqes so
it shouldn't have this issue.

>
>
> I did not check if nvme-tcp/nvme-fc/nvme-rdma would have the similar issue. Was
> there already any fix or discussion for above issue? That is, when resetting
> the device, a blk_mq_complete_request() is already in progress.

Also nvme-tcp and nvme-rdma will stop the transport queues (assuring 
there will be no completion
pending) prior to canceling the pending requests. So unless there is a 
bug hidden there it shouldn't
happen.

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
