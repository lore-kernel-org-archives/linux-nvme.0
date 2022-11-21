Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95A04C4332F
	for <linux-nvme@archiver.kernel.org>; Mon, 21 Nov 2022 20:45:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ynEOY2Xr4EUpo4nmjnaFyeWf0VKJr1UGA8/EcPJXClM=; b=ITT5cwQjVMryHIDKAXPsS9G3S/
	B/Ad+/Ilfgo8PhE96fg+u3eDlovL7uSlWm+omd8YBn4ggqbVZsLAxDLUgSiRG5/kzR5GTOW/UiVeT
	a9aNN/lV4W5YjFoqE9SvpRwmUajEb5LtGU3ZqMf2wgdfmg1exOokiOCzaRdK8Yp6V5GpieP8+tBIv
	zq5GCdgcRKopw9oXWFzvF+7AFZh+abNHhmERFg0LAyB++j8EZEH7p+B0hqTieKhbIhWCJ2xDEhuN7
	XOEomu53N8oV2d7LlOm89VxHEmeETK0fZWA4bd2tqfex+cQCM4MMoHZVRXqPu9AG5WHwJTFfjYStT
	XNexIM/Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oxDf1-000IAG-Og; Mon, 21 Nov 2022 20:44:59 +0000
Received: from mail-pg1-x549.google.com ([2607:f8b0:4864:20::549])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oxDew-000I8d-Mq
	for linux-nvme@lists.infradead.org; Mon, 21 Nov 2022 20:44:58 +0000
Received: by mail-pg1-x549.google.com with SMTP id 186-20020a6301c3000000b0046fa202f720so7483536pgb.20
        for <linux-nvme@lists.infradead.org>; Mon, 21 Nov 2022 12:44:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ynEOY2Xr4EUpo4nmjnaFyeWf0VKJr1UGA8/EcPJXClM=;
        b=n8YC0eNGl7sypgoOruYb9vkibq4vMyGPQJI112suJz3F7rCauvG0sJFY37LqtFspdM
         B1spEmE+2UFablbnvbH+ZxGyq58mCBYYCup0GEaCUhOKOBboqi2h++98uVRI/pnb4ixY
         PEMwHkVZgjn2uKDnJ/BO+y63qXHFJg3xLIOwSZDcMR213EbbzdbfChVyEi6hM1J7H4hP
         p+8EQ+QbsKWlwb4i9k0q9TC3eahR1jklI37dqi5QMDMgU43ULih91phvVK2lWAPUSJIo
         gw+sX2n1rQOuc/XwCkgWZ0GFwhFjIMKCv7vErhUb/aWjLq0aZ5TIsBj87hxSse6LZl3Y
         tYXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ynEOY2Xr4EUpo4nmjnaFyeWf0VKJr1UGA8/EcPJXClM=;
        b=IrcE97rbAioFF1eJbE14kNdN7OpjaUxCD/livXp3CT41B93hexB18Z794azgHLf3Go
         +oV6FQTFOzMjVZ/nn+wam60GC3keIAHAlplprYEtwifFh97dH5+jGIv9pWtuJaeHA+5x
         0b5jrPDgtCCxyMWAY/6uPqiO1Zsypm1hYVn/m4AKQGv/NM8BMGDWxhoDql8BEVuEbHJ5
         VivOm0ypoq1gVLmU6mAmVlqMBq+aAcH1QJaeFQFcElZeiA9bgHxe9dinREN5oaDDv8Wy
         xqZeqmHoaFrNzFyXG9h0+xPaP9X2riep7Lu9Ff4wb2Fiq7guA+P6ucMNyoGnGIYbU5C5
         ZzUg==
X-Gm-Message-State: ANoB5pn2l9jchG2go5xL9eajLcDTuyoVxzh+y4qQdXPdJ44emWm28NJx
	dO9/LPdvTmBTlg/UbSQI6kGJ1xyQG4ARJg==
X-Google-Smtp-Source: AA0mqf4aMSY7Z6m/WfGTKjhxYs7Q8Ba42eJDG/u6MdC3FSvh5X7IlweoKeb9vhuatTemeULPj0C2n7JMgeZQqA==
X-Received: from shakeelb.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:262e])
 (user=shakeelb job=sendgmr) by 2002:a17:90a:294f:b0:213:d04:7529 with SMTP id
 x15-20020a17090a294f00b002130d047529mr27563387pjf.181.1669063492467; Mon, 21
 Nov 2022 12:44:52 -0800 (PST)
Date: Mon, 21 Nov 2022 20:44:50 +0000
In-Reply-To: <20221101150050.3510-15-hch@lst.de>
Mime-Version: 1.0
References: <20221101150050.3510-1-hch@lst.de> <20221101150050.3510-15-hch@lst.de>
Message-ID: <20221121204450.6vyg6gixsz4unpaz@google.com>
Subject: Re: [PATCH 14/14] nvme: use blk_mq_[un]quiesce_tagset
From: Shakeel Butt <shakeelb@google.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>, 
	Chao Leng <lengchao@huawei.com>, Ming Lei <ming.lei@redhat.com>, 
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org, 
	Hannes Reinecke <hare@suse.de>
Content-Type: text/plain; charset="us-ascii"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221121_124454_781548_BDC0C26C 
X-CRM114-Status: GOOD (  19.07  )
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

On Tue, Nov 01, 2022 at 04:00:50PM +0100, Christoph Hellwig wrote:
> From: Chao Leng <lengchao@huawei.com>
> 
> All controller namespaces share the same tagset, so we can use this
> interface which does the optimal operation for parallel quiesce based on
> the tagset type(e.g. blocking tagsets and non-blocking tagsets).
> 
> nvme connect_q should not be quiesced when quiesce tagset, so set the
> QUEUE_FLAG_SKIP_TAGSET_QUIESCE to skip it when init connect_q.
> 
> Currently we use NVME_NS_STOPPED to ensure pairing quiescing and
> unquiescing. If use blk_mq_[un]quiesce_tagset, NVME_NS_STOPPED will be
> invalided, so introduce NVME_CTRL_STOPPED to replace NVME_NS_STOPPED.
> In addition, we never really quiesce a single namespace. It is a better
> choice to move the flag from ns to ctrl.
> 
> Signed-off-by: Chao Leng <lengchao@huawei.com>
> [hch: rebased on top of prep patches]
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Keith Busch <kbusch@kernel.org>
> Reviewed-by: Chao Leng <lengchao@huawei.com>
> Reviewed-by: Hannes Reinecke <hare@suse.de>
> Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

This patch is causing the following crash at the boot and reverting it
fixes the issue. This is next-20221121 kernel.

[   19.781883] BUG: kernel NULL pointer dereference, address: 0000000000000078
[   19.788761] #PF: supervisor write access in kernel mode
[   19.793924] #PF: error_code(0x0002) - not-present page
[   19.799006] PGD 0 P4D 0
[   19.801510] Oops: 0002 [#1] SMP PTI
[   19.804955] CPU: 54 PID: 110 Comm: kworker/u146:0 Tainted: G          I        6.1.0-next-20221121-smp-DEV #1
[   19.814753] Hardware name: ...
[   19.822662] Workqueue: nvme-reset-wq nvme_reset_work
[   19.827571] RIP: 0010:mutex_lock+0x13/0x30
[   19.831617] Code: 07 00 00 f7 c1 00 01 00 00 75 02 31 c0 5b 5d c3 00 00 cc cc 00 00 cc 0f 1f 44 00 00 55 48 89 e5 65 48 8b 0d 7f 9a c2 52 31 c0 <f0> 48 0f b1 0f 74 05 e8 11 00 00 00 5d c3 66 66 66 66 66 66 2e 0f
[   19.850172] RSP: 0000:ffff96624651bcb0 EFLAGS: 00010246
[   19.855339] RAX: 0000000000000000 RBX: 0000000000000003 RCX: ffff966246530000
[   19.862388] RDX: 0000000000000000 RSI: 0000000000000286 RDI: 0000000000000078
[   19.869442] RBP: ffff96624651bcb0 R08: 0000000000000004 R09: ffff96624651bc74
[   19.876495] R10: 0000000000000000 R11: 0000000000000000 R12: ffff966246570000
[   19.883547] R13: ffff966246570000 R14: ffff966249f330b0 R15: 0000000000000000
[   19.890599] FS:  0000000000000000(0000) GS:ffff9681bf880000(0000) knlGS:0000000000000000
[   19.898594] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   19.904273] CR2: 0000000000000078 CR3: 0000003c40e0a001 CR4: 00000000001706e0
[   19.911323] Call Trace:
[   19.913743]  <TASK>
[   19.915818]  blk_mq_quiesce_tagset+0x23/0xc0
[   19.920039]  nvme_stop_queues+0x1e/0x30
[   19.923829]  nvme_dev_disable+0xe1/0x3a0
[   19.927702]  nvme_reset_work+0x14cb/0x1600
[   19.931751]  ? ttwu_queue_wakelist+0xc4/0xd0
[   19.935970]  ? try_to_wake_up+0x1b4/0x2d0
[   19.939933]  process_one_work+0x1a4/0x320
[   19.943895]  worker_thread+0x241/0x3f0
[   19.947597]  ? worker_clr_flags+0x50/0x50
[   19.951560]  kthread+0x10d/0x120
[   19.954748]  ? kthread_blkcg+0x30/0x30
[   19.958453]  ret_from_fork+0x1f/0x30
[   19.961987]  </TASK>
[   19.964145] Modules linked in:
[   19.967655] gsmi: Log Shutdown Reason 0x03
[   19.971700] CR2: 0000000000000078
[   19.974978] ---[ end trace 0000000000000000 ]---
[   20.513708] RIP: 0010:mutex_lock+0x13/0x30
[   20.517757] Code: 07 00 00 f7 c1 00 01 00 00 75 02 31 c0 5b 5d c3 00 00 cc cc 00 00 cc 0f 1f 44 00 00 55 48 89 e5 65 48 8b 0d 7f 9a c2 52 31 c0 <f0> 48 0f b1 0f 74 05 e8 11 00 00 00 5d c3 66 66 66 66 66 66 2e 0f
[   20.536308] RSP: 0000:ffff96624651bcb0 EFLAGS: 00010246
[   20.541469] RAX: 0000000000000000 RBX: 0000000000000003 RCX: ffff966246530000
[   20.548519] RDX: 0000000000000000 RSI: 0000000000000286 RDI: 0000000000000078
[   20.555568] RBP: ffff96624651bcb0 R08: 0000000000000004 R09: ffff96624651bc74
[   20.562614] R10: 0000000000000000 R11: 0000000000000000 R12: ffff966246570000
[   20.569663] R13: ffff966246570000 R14: ffff966249f330b0 R15: 0000000000000000
[   20.576713] FS:  0000000000000000(0000) GS:ffff9681bf880000(0000) knlGS:0000000000000000
[   20.584704] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   20.590380] CR2: 0000000000000078 CR3: 0000003c40e0a001 CR4: 00000000001706e0
[   20.597432] Kernel panic - not syncing: Fatal exception
[   20.602654] Kernel Offset: 0x2b800000 from 0xffffffff81000000 (relocation range: 0xffffffff80000000-0xffffffffbfffffff)
[   20.613747] gsmi: Log Shutdown Reason 0x02


