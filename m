Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 462BDECAAD1
	for <linux-nvme@archiver.kernel.org>; Wed, 31 Aug 2022 09:21:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=bIvDoq3XyZfHM3iEW7Cnp9MYBD396C1ne8K2ufHuQOQ=; b=klI7VT7kY3zF009vRSBCI6f/ww
	ONdUY8B9TYkS/Qz71OAHxTWdq+N8gBR2nQIpz4vZxbWkLe6NvVrEprqG6SqrJgrgMqEdsZvsWP90S
	JaILTsvGTRVXwq2gX5DIQyBWfxrmAp8Tqo3cfsA76haIAjbh+bmXePm7Q0K9mby+QyosfR//6BZRj
	nrtbTZ0mhBcSJqDvFkKi/pPyP/MjWmXR/0olzg3nfRY/qOoIxxWfw3/uX8yokXpRyEVaMSNJOhvJa
	clVqyFQUYq5+jU85nNh/1D7mws3qRAr65CJCYHjCEBbAEVysqZzo9c/aTlzt4elqM3AVuC8PK5juT
	vr9j9g0w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oTJuY-005EQw-Go; Wed, 31 Aug 2022 09:21:26 +0000
Received: from mail-wm1-f48.google.com ([209.85.128.48])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oTJuU-005EOT-Se
	for linux-nvme@lists.infradead.org; Wed, 31 Aug 2022 09:21:24 +0000
Received: by mail-wm1-f48.google.com with SMTP id ay39-20020a05600c1e2700b003a5503a80cfso7591055wmb.2
        for <linux-nvme@lists.infradead.org>; Wed, 31 Aug 2022 02:21:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=bIvDoq3XyZfHM3iEW7Cnp9MYBD396C1ne8K2ufHuQOQ=;
        b=xLpmlmwFHlYLiNUmiCdZyjl9ewBhbgCGwK94wOQBJ7HJ1Goa6hBLpRhEOwvdMIXCDs
         o1wsIHLMSq/FU1YH/7p6FcM90Ofk+HXHn9NxvSd0xeyLemAT4y8Nt4bpg+UmNGhDXJYX
         MqBsRHniZhCYZBeUyDgs2sBP48+/SNRlf73oEjmm6DLegJ7rz9J2wX5PCICn3QBhXNDz
         61kNEBCo5l7lGAn0tJFCBH0z3ukYJqY+d6KjJznAKPY91DpdqV+3NtLu+qERTo73k6nd
         mNqIKFhmoaCQv9JDiYOkQVxOHoNrGEHBcV+ma6mdUKs4qC6nVPj+p+PtvkrxWnuSan4u
         fcpQ==
X-Gm-Message-State: ACgBeo23CJX/HdlD1FPUgOIWkcvwfv/i71d4OgNxFCGRGp3wkcJzvHGT
	gEb2PwfL6FJAiRRpSp3C2dA=
X-Google-Smtp-Source: AA6agR70s/3uW7IVp0if83aaZwpwzndLc2myCrg6s/jXc/5klLYB8OCrFtgOYgMQGFEssx5q1J1R7A==
X-Received: by 2002:a05:600c:20f:b0:3a5:a785:7f2a with SMTP id 15-20020a05600c020f00b003a5a7857f2amr1355720wmi.94.1661937681116;
        Wed, 31 Aug 2022 02:21:21 -0700 (PDT)
Received: from [10.100.102.14] (46-116-236-159.bb.netvision.net.il. [46.116.236.159])
        by smtp.gmail.com with ESMTPSA id j6-20020a056000124600b002258956f373sm11524931wrx.95.2022.08.31.02.21.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Aug 2022 02:21:20 -0700 (PDT)
Message-ID: <c12677fe-a4b9-0ee4-546d-69bfd482e13a@grimberg.me>
Date: Wed, 31 Aug 2022 12:21:18 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 1/1] nvmet-tcp: Fix NULL pointer dereference during
 release
Content-Language: en-US
To: zhenwei pi <pizhenwei@bytedance.com>, hch@lst.de
Cc: kch@nvidia.com, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20220831013402.514055-1-pizhenwei@bytedance.com>
 <20220831013402.514055-2-pizhenwei@bytedance.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20220831013402.514055-2-pizhenwei@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220831_022122_955315_E28D5BD6 
X-CRM114-Status: GOOD (  25.19  )
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



On 8/31/22 04:34, zhenwei pi wrote:
> nvmet-tcp frees CMD buffers in nvmet_tcp_uninit_data_in_cmds(),
> and waits the inflight IO requests in nvmet_sq_destroy(). During wait
> the inflight IO requests, the callback nvmet_tcp_queue_response()
> is called from backend after IO complete, this leads a typical
> Use-After-Free issue like this:
> 
>   BUG: kernel NULL pointer dereference, address: 0000000000000008
>   #PF: supervisor read access in kernel mode
>   #PF: error_code(0x0000) - not-present page
>   PGD 0 P4D 0
>   Oops: 0000 [#1] PREEMPT SMP NOPTI
>   CPU: 14 PID: 207 Comm: kworker/14:1H Kdump: loaded Tainted: G            E      6.0.0-rc2.bm.1-amd64 #12
>   Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
>   Workqueue: nvmet_tcp_wq nvmet_tcp_io_work [nvmet_tcp]
>   RIP: 0010:shash_ahash_digest+0x2b/0x110
>   Code: 1f 44 00 00 41 57 41 56 41 55 41 54 55 48 89 fd 53 48 89 f3 48 83 ec 08 44 8b 67 30 45 85 e4 74 1c 48 8b 57 38 b8 00 10 00 00 <44> 8b 7a 08 44 29 f8 39 42 0c 0f 46 42 0c 41 39 c4 76 43 48 8b 03
>   RSP: 0018:ffffc900006e3dd8 EFLAGS: 00010206
>   RAX: 0000000000001000 RBX: ffff888104ac1650 RCX: 0000000000000000
>   RDX: 0000000000000000 RSI: ffff888104ac1650 RDI: ffff888104ac1600
>   RBP: ffff888104ac1600 R08: ffff8881073980c8 R09: ffff8881057798b8
>   R10: 8080808080808080 R11: 0000000000000000 R12: 0000000000001000
>   R13: 0000000000000000 R14: ffff88810601a1cc R15: ffff888107398000
>   FS:  0000000000000000(0000) GS:ffff88823fd80000(0000) knlGS:0000000000000000
>   CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>   CR2: 0000000000000008 CR3: 000000010a8e8000 CR4: 0000000000350ee0
>   Call Trace:
>    <TASK>
>    nvmet_tcp_io_work+0xa1c/0xb1c [nvmet_tcp]
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
>    uninit req          <- new step 1
>    nvmet_sq_destroy();
>    free CMD buffers    <- new step 2
> 
> Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
> ---
>   drivers/nvme/target/tcp.c | 22 ++++++++++++++++++----
>   1 file changed, 18 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
> index dc3b4dc8fe08..3bfd139b1434 100644
> --- a/drivers/nvme/target/tcp.c
> +++ b/drivers/nvme/target/tcp.c
> @@ -1415,7 +1415,7 @@ static void nvmet_tcp_finish_cmd(struct nvmet_tcp_cmd *cmd)
>   	nvmet_tcp_free_cmd_buffers(cmd);
>   }
>   
> -static void nvmet_tcp_uninit_data_in_cmds(struct nvmet_tcp_queue *queue)
> +static void nvmet_tcp_uninit_req(struct nvmet_tcp_queue *queue)

The name should reflect what it is doing, so keep it
nvmet_tcp_uninit_data_in_cmds()

>   {
>   	struct nvmet_tcp_cmd *cmd = queue->cmds;
>   	int i;
> @@ -1423,14 +1423,27 @@ static void nvmet_tcp_uninit_data_in_cmds(struct nvmet_tcp_queue *queue)
>   	for (i = 0; i < queue->nr_cmds; i++, cmd++) {
>   		if (nvmet_tcp_need_data_in(cmd))
>   			nvmet_req_uninit(&cmd->req);
> +	}
> +
> +	if (!queue->nr_cmds && nvmet_tcp_need_data_in(&queue->connect)) {
> +		/* failed in connect */
> +		nvmet_req_uninit(&queue->connect.req);
> +	}
> +}
> +
> +static void nvmet_tcp_uninit_data_in_cmds(struct nvmet_tcp_queue *queue)

Maybe name this nvmet_tcp_free_cmd_data_in_buffers()

> +{
> +	struct nvmet_tcp_cmd *cmd = queue->cmds;
> +	int i;
>   
> +	for (i = 0; i < queue->nr_cmds; i++, cmd++) {

Lets not sweep and call this unconditionally on all cmds,
lets just use the commands that are still waiting for
data from the wire, other commands should complete and
free normally.

>   		nvmet_tcp_unmap_pdu_iovec(cmd);

You should rebase against the latest nvme tree for 6.0, this
function no longer exists.

>   		nvmet_tcp_free_cmd_buffers(cmd);
>   	}
>   
>   	if (!queue->nr_cmds && nvmet_tcp_need_data_in(&queue->connect)) {
> -		/* failed in connect */
> -		nvmet_tcp_finish_cmd(&queue->connect);
> +		nvmet_tcp_unmap_pdu_iovec(&queue->connect);
> +		nvmet_tcp_free_cmd_buffers(&queue->connect);
>   	}
>   }
>   
> @@ -1449,8 +1462,9 @@ static void nvmet_tcp_release_queue_work(struct work_struct *w)
>   	/* stop accepting incoming data */
>   	queue->rcv_state = NVMET_TCP_RECV_ERR;
>   
> -	nvmet_tcp_uninit_data_in_cmds(queue);
> +	nvmet_tcp_uninit_req(queue);
>   	nvmet_sq_destroy(&queue->nvme_sq);
> +	nvmet_tcp_uninit_data_in_cmds(queue);
>   	cancel_work_sync(&queue->io_work);
>   	sock_release(queue->sock);
>   	nvmet_tcp_free_cmds(queue);

