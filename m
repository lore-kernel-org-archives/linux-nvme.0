Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 282F7ECAAD8
	for <linux-nvme@archiver.kernel.org>; Tue, 20 Sep 2022 15:34:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=EgvGrc7uFwyZpQCtIPUuCJ8XPMVMcqHNXt6gEKSa27U=; b=YgSmeLQKY5xvU8244cvyERzxmx
	Q8yfKIdWrtAkQEyQe7CQBOt8nLoTNaUNZTT8EucrI29hb1fcyuun4fwWe7Au04JOkZoJcC2pUlgR1
	4u4+LERrGJgDbt3aB1rRJ+ohSTZ6iw4vHyfU8RrEbmqF7mRajfNh+gRviGatCyxAa6esXHfuNU5Ir
	XNtPl7yNtnWEnnZnfU8AGEAz5TTPNU7oa+mCQ92Cm+uROyM54cyEJZP80PmjYPMR7QJ6YOsR2RgMk
	PlxVGr0mxILBkYqDrORlYGw8y9RCc9PDYwRTA70tLWXsfNxkyD7IzP8DPbhaCnlzfmNuXdqCpAJ9P
	WcvsLsKg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oafGj-004uK0-3d; Tue, 20 Sep 2022 15:34:42 +0000
Received: from mail-wm1-f50.google.com ([209.85.128.50])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oafGf-004uEx-NH
	for linux-nvme@lists.infradead.org; Tue, 20 Sep 2022 15:34:39 +0000
Received: by mail-wm1-f50.google.com with SMTP id az6so2215354wmb.4
        for <linux-nvme@lists.infradead.org>; Tue, 20 Sep 2022 08:34:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=EgvGrc7uFwyZpQCtIPUuCJ8XPMVMcqHNXt6gEKSa27U=;
        b=fKsXqci9SFHd9CdvmjNTi9x5FtyfcNJfJFuBIhCIC0f7DuFK9FSrEr4u10q8012ts1
         uwyLiFfB58M5ATIujHnj4i7yg7Bx6SXl6Srfpt/N+J2NF3SN0Mtcvcw9J9Vy8jRFetIY
         a5+RILeBe4XbgDDGDFWSkCxTnD0eQ/iqR2pbfd4yleVn9M0hnv4u2gl/f4LeZfgu4KH9
         STCH6zOBKU6sdsyzC0SFqnfiwRg2C6lJ/K8u639qKPHEZCBk7N3gB/yJgFKbTo7BHDBe
         ac0aP3hQzC4aY+Hmu+0d3llzwibXO+BOt2Pg+porentFkIXDjoxE8K6SrFXSJ9f/iCGR
         wjhA==
X-Gm-Message-State: ACrzQf0sLMHyhTG5y/26LG+Eg3GPb7QVMcvTGBfvo4LtQDsbq1shEPhs
	N4T0TEa3/0aPYMWEMvrhLsGw259ZWJ0=
X-Google-Smtp-Source: AMsMyM5zBp3CeTPiQl6qw371jYWYxxIgBnszBw7oeE0WR9CNw4Kkq6AGRvUgjRfsuVyYlz8NWKmJZA==
X-Received: by 2002:a05:600c:3d15:b0:3b4:8bd9:3905 with SMTP id bh21-20020a05600c3d1500b003b48bd93905mr2875459wmb.173.1663688074995;
        Tue, 20 Sep 2022 08:34:34 -0700 (PDT)
Received: from [10.100.102.14] (46-116-236-159.bb.netvision.net.il. [46.116.236.159])
        by smtp.gmail.com with ESMTPSA id w8-20020a1cf608000000b003a5fa79007fsm139919wmc.7.2022.09.20.08.34.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Sep 2022 08:34:34 -0700 (PDT)
Message-ID: <325841d0-16a5-a8dd-fb06-332e7b37721e@grimberg.me>
Date: Tue, 20 Sep 2022 18:34:32 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [RESEND for nvme-6.1] nvmet-tcp: Fix NULL pointer dereference
 during release
Content-Language: en-US
To: zhenwei pi <pizhenwei@bytedance.com>, hch@lst.de
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220920131617.63540-1-pizhenwei@bytedance.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20220920131617.63540-1-pizhenwei@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220920_083437_791084_1FF61FE7 
X-CRM114-Status: GOOD (  20.38  )
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



On 9/20/22 16:16, zhenwei pi wrote:
> nvmet-tcp frees CMD buffers in nvmet_tcp_uninit_data_in_cmds(),
> and waits the inflight IO requests in nvmet_sq_destroy(). During wait
> the inflight IO requests, the callback nvmet_tcp_queue_response()
> is called from backend after IO complete, this leads a typical
> Use-After-Free issue like this:
> 
>   BUG: kernel NULL pointer dereference, address: 0000000000000008
>   #PF: supervisor read access in kernel mode
>   #PF: error_code(0x0000) - not-present page
>   PGD 107f80067 P4D 107f80067 PUD 10789e067 PMD 0
>   Oops: 0000 [#1] PREEMPT SMP NOPTI
>   CPU: 1 PID: 123 Comm: kworker/1:1H Kdump: loaded Tainted: G            E      6.0.0-rc2.bm.1-amd64 #15
>   Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
>   Workqueue: nvmet_tcp_wq nvmet_tcp_io_work [nvmet_tcp]
>   RIP: 0010:shash_ahash_digest+0x2b/0x110
>   Code: 1f 44 00 00 41 57 41 56 41 55 41 54 55 48 89 fd 53 48 89 f3 48 83 ec 08 44 8b 67 30 45 85 e4 74 1c 48 8b 57 38 b8 00 10 00 00 <44> 8b 7a 08 44 29 f8 39 42 0c 0f 46 42 0c 41 39 c4 76 43 48 8b 03
>   RSP: 0018:ffffc9000051bdd8 EFLAGS: 00010206
>   RAX: 0000000000001000 RBX: ffff888100ab5470 RCX: 0000000000000000
>   RDX: 0000000000000000 RSI: ffff888100ab5470 RDI: ffff888100ab5420
>   RBP: ffff888100ab5420 R08: ffff8881024d08c8 R09: ffff888103e1b4b8
>   R10: 8080808080808080 R11: 0000000000000000 R12: 0000000000001000
>   R13: 0000000000000000 R14: ffff88813412bd4c R15: ffff8881024d0800
>   FS:  0000000000000000(0000) GS:ffff88883fa40000(0000) knlGS:0000000000000000
>   CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>   CR2: 0000000000000008 CR3: 0000000104b48000 CR4: 0000000000350ee0
>   Call Trace:
>    <TASK>
>    nvmet_tcp_io_work+0xa52/0xb52 [nvmet_tcp]
>    ? __switch_to+0x106/0x420
>    process_one_work+0x1ae/0x380
>    ? process_one_work+0x380/0x380
>    worker_thread+0x30/0x360
>    ? process_one_work+0x380/0x380
>    kthread+0xe6/0x110
>    ? kthread_complete_and_exit+0x20/0x20
>    ret_from_fork+0x1f/0x30
> 
> Suggested by Sagi, separate nvmet_tcp_uninit_data_in_cmds() into two
> steps:
>    uninit data in cmds                  <- new step 1
>    nvmet_sq_destroy();
>    cancel_work_sync(&queue->io_work);
>    free CMD buffers                     <- new step 2
> 
> Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
> ---
>   drivers/nvme/target/tcp.c | 19 ++++++++++++++++---
>   1 file changed, 16 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
> index c07de4f4f719..70baeab6af30 100644
> --- a/drivers/nvme/target/tcp.c
> +++ b/drivers/nvme/target/tcp.c
> @@ -1406,14 +1406,26 @@ static void nvmet_tcp_uninit_data_in_cmds(struct nvmet_tcp_queue *queue)
>   	for (i = 0; i < queue->nr_cmds; i++, cmd++) {
>   		if (nvmet_tcp_need_data_in(cmd))
>   			nvmet_req_uninit(&cmd->req);
> -
> -		nvmet_tcp_free_cmd_buffers(cmd);
>   	}
>   
>   	if (!queue->nr_cmds && nvmet_tcp_need_data_in(&queue->connect)) {
>   		/* failed in connect */
> -		nvmet_tcp_finish_cmd(&queue->connect);

I think that nvmet_tcp_finish_cmd is now redundant and can be removed
if we fold it to its single remaining call-site.

Other than that,
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

