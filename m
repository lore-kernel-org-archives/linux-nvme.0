Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 775F5CA5FA2
	for <linux-nvme@archiver.kernel.org>; Mon, 28 Sep 2026 20:42:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BumfOEQEDSO8N/gUoukVcmv0dR7aJeOAZO71bPtzAgc=; b=OVvBqe1ZxZ4PWYqRJgAe6fTLCb
	ZJHr7YfXcmKltrW3yO4RH6eHaB74XrzFNhUHYIhRW7dh62Aceh/bDdgdp8esWWJGEYhy8i6Yu8oNm
	p97hhmTL2Tp8VX96+B2vAmI55Grqo3t4lQklfFKs8H1BdJA9XqAK8R9lSzZMUdA0hpCnIW+8kDMst
	p5Y6Pa5YXV/SsM8vNZI18j+s45M1qifFJP4p5zNai7O7kipNFeKQHH5p8vW5j7Pg7zzcD2q3tVDpr
	bz0enZS5B4QhoED7kF0/pDpwrL8/Dp7Mn1QkWJGhBtld+pP2i766QSntyOvEG8zs6kSW6QHvrSQVY
	cdsimMzg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xBIBX-00000001azB-3i47;
	Mon, 28 Sep 2026 20:42:51 +0000
Received: from 011.lax.mailroute.net ([199.89.1.14])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xBIBU-00000001aye-1zSQ
	for linux-nvme@lists.infradead.org;
	Mon, 28 Sep 2026 20:42:50 +0000
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4httY14yHrz1XM4TB;
	Mon, 28 Sep 2026 20:42:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1790628161; x=1793220162; bh=BumfOEQEDSO8N/gUoukVcmv0
	dR7aJeOAZO71bPtzAgc=; b=airYkCv7cWfUxSLvkgwl7ngr358vfoNx0znueOOG
	MU3BwVcSYBhAtuc2XiXnAommAg+jZ/j0gS+sbr9bM3fuKUbYyu3R6J9F388ZjPDW
	k9NzDpXpL4Q7Qt2/LqnADd7bcKy92gV1RzcsWZz06KT/iHXCpISUFEw8oQRI4sno
	GE7rhqRoEkPyFppvo/zkIXgl8ShIhgmCP6lUfB47V+IWu9dRKrION/DxR+6nIHzi
	NjrHuCgou9gpio9gsv2kPBhBPp1Wxd1ZkeHGXQmethFR5vE9p4itLmBKLFJtiwZv
	LsbiERyiEwy8M/MzE8VfXa2xyK4ePaS+0b6DLtbyLNuIMA==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id 1LizgNKyS4TW; Mon, 28 Sep 2026 20:42:41 +0000 (UTC)
Received: from [IPV6:2a00:79e0:2ed2:d:334e:163d:7b65:8f42] (unknown [104.135.182.42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4httXv2Pghz1XM4Sx;
	Mon, 28 Sep 2026 20:42:39 +0000 (UTC)
Message-ID: <2bfc96f2-7d0d-47e0-936e-8810abb31a9f@acm.org>
Date: Mon, 28 Sep 2026 13:42:38 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] nvme-multipath: revalidate zones for namespace heads
To: Yao Sang <sangyao@kylinos.cn>, linux-nvme@lists.infradead.org,
 dlemoal@kernel.org
Cc: kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me
References: <20260610032846.54044-1-sangyao@kylinos.cn>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20260610032846.54044-1-sangyao@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260928_134248_556953_9F40F598 
X-CRM114-Status: UNSURE (   8.28  )
X-CRM114-Notice: Please train this message.
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

On 6/9/26 8:28 PM, Yao Sang wrote:
>   		set_capacity_and_notify(ns->head->disk, get_capacity(ns->disk));
>   		set_disk_ro(ns->head->disk, nvme_ns_is_readonly(ns, info));
>   		nvme_mpath_revalidate_paths(ns->head);
> +		ret = nvme_mpath_revalidate_zones(ns->head);
>   
> +unfreeze_head_queue:
>   		blk_mq_unfreeze_queue(ns->head->disk->queue, memflags);

Does the above nvme_mpath_revalidate_zones() submit I/O while the
request queue is frozen? If so, is this guaranteed to trigger a
deadlock? I'm wondering whether the above changes are the changes that
introduced this syzbot report:
https://lore.kernel.org/linux-block/6ab26c90.c68e76dc.23da29.00ab.GAE@google.com/

 From that report:

-> #2 (&q->limits_lock){+.+.}-{4:4}:
        __mutex_lock_common kernel/locking/mutex.c:646 [inline]
        __mutex_lock+0x197/0x15a0 kernel/locking/mutex.c:821
        queue_limits_start_update include/linux/blkdev.h:1101 [inline]
        disk_update_zone_resources block/blk-zoned.c:2067 [inline]
        blk_revalidate_disk_zones+0xad9/0x12e0 block/blk-zoned.c:2375
        nvme_mpath_revalidate_zones+0x106/0x1c0 
drivers/nvme/host/multipath.c:301
        nvme_update_ns_info+0x984/0x1200 drivers/nvme/host/core.c:2622
        nvme_alloc_ns drivers/nvme/host/core.c:4284 [inline]
        nvme_scan_ns+0x2563/0x3640 drivers/nvme/host/core.c:4471
        async_run_entry_fn+0x9d/0x430 kernel/async.c:129
        process_one_work kernel/workqueue.c:3399 [inline]
        process_scheduled_works+0xc3d/0x1630 kernel/workqueue.c:3482
        worker_thread+0xa47/0xfb0 kernel/workqueue.c:3563
        kthread+0x38b/0x480 kernel/kthread.c:436
        ret_from_fork+0x514/0xb70 arch/x86/kernel/process.c:158
        ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

Thanks,

Bart.

