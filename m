Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9FFDC25B06
	for <linux-nvme@archiver.kernel.org>; Sun, 14 Aug 2022 11:45:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=oJkvmKunXVSksj7R/HAFL2ci6t3b+CqKjsYz3hT1qLU=; b=El/nBIWuqCdHs9icEwQHHcH61x
	fJ2NeJXLrJeLxxVhQdt5Xx3kTOMxD2UBFXRqT6IeT5+4lNemBnbMfBLdQIDEw8yviebMl/bkpXs5S
	zq3/Xnbm1iW48mMKlcqQ3t7w4DYhnm0+Lq6QaKbWtcHtzKwvH8HE5zjjNWE8wBEED0m5jBTCl0dNc
	hBbj+YyZQ51Gb6fFJl1LS5Guhtn74uSUC0i7me3JD4vxxbhYF9bpNAie+sol6PPfKLX9219qzx30V
	UOe5+F1a1VuMC4jnG7brYgSsAqLwm3ZLg7FJbgWL7EwRwo5mStgGBx/G6ZxfgPHCdlMISyYkvo/Hv
	0KqV1vmw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oNC3N-006GX2-4e; Sun, 14 Aug 2022 11:45:13 +0000
Received: from mail-wm1-f42.google.com ([209.85.128.42])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oNC3F-006GTn-Lg
	for linux-nvme@lists.infradead.org; Sun, 14 Aug 2022 11:45:07 +0000
Received: by mail-wm1-f42.google.com with SMTP id s11-20020a1cf20b000000b003a52a0945e8so2668304wmc.1
        for <linux-nvme@lists.infradead.org>; Sun, 14 Aug 2022 04:45:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=oJkvmKunXVSksj7R/HAFL2ci6t3b+CqKjsYz3hT1qLU=;
        b=hQBcaQN3i0paTf2aBT/Iq2v4WYj6Vug9aOwVD9/LCsDWvEhzby14uPFt6W3Buf04Gx
         RPV92gL25SZdYkVpaDq3QdxNKBjEaIG0r0vVLVmqbXPU7HHcKk2iuVr21mYpf4g/TZYO
         p+MjRbwmUoWdW2AV/hveSNm1wxcFd3cV91/pc5RxAGcIgB68E7oMxh2EnY0CxqNA9unP
         rb8ILlMARInqAZn/1ksIZqFVx+1j7tAUc/miKmzPFWRWVcMegYxbWQBgddxnuF2OHjg/
         kJMsp17sa5hqSG0zsjBsB6zMpXEd5yAP0LMlYJOnxS73nqIEkkjqqlGemruLZJonC8E3
         WGjQ==
X-Gm-Message-State: ACgBeo0UV2WO/90Ny1K+N8x6blx22CRHNLsPgSJzBKjJOi0jXLsQzcj0
	YNtc8+Nf5W3gCi9JRJnt7gnchJW8KeA=
X-Google-Smtp-Source: AA6agR4ltvGkupz/rqsMcjKS9QULwEmIOcUbz7a2Fn3N13hKX94gQ6EKU6V45IHb5hVDxTdqUIAQ8Q==
X-Received: by 2002:a05:600c:35d5:b0:3a3:2490:c984 with SMTP id r21-20020a05600c35d500b003a32490c984mr14257898wmq.162.1660477501979;
        Sun, 14 Aug 2022 04:45:01 -0700 (PDT)
Received: from [10.100.102.14] (85.65.248.193.dynamic.barak-online.net. [85.65.248.193])
        by smtp.gmail.com with ESMTPSA id h3-20020a05600c2ca300b003a5ea1cc63csm2448159wmc.39.2022.08.14.04.45.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 14 Aug 2022 04:45:01 -0700 (PDT)
Message-ID: <cd2189da-59b3-c01e-9bd3-5f838258c7bc@grimberg.me>
Date: Sun, 14 Aug 2022 14:45:00 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] nvmet: Fix a use-after-free
Content-Language: en-US
To: Bart Van Assche <bvanassche@acm.org>, Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org,
 stable@vger.kernel.org
References: <20220812210317.2252051-1-bvanassche@acm.org>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20220812210317.2252051-1-bvanassche@acm.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220814_044505_742154_EDDD76B1 
X-CRM114-Status: GOOD (  18.13  )
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



On 8/13/22 00:03, Bart Van Assche wrote:
> Fix the following use-after-free complaint triggered by blktests nvme/004:
> 
> BUG: KASAN: user-memory-access in blk_mq_complete_request_remote+0xac/0x350
> Read of size 4 at addr 0000607bd1835943 by task kworker/13:1/460
> Workqueue: nvmet-wq nvme_loop_execute_work [nvme_loop]
> Call Trace:
>   show_stack+0x52/0x58
>   dump_stack_lvl+0x49/0x5e
>   print_report.cold+0x36/0x1e2
>   kasan_report+0xb9/0xf0
>   __asan_load4+0x6b/0x80
>   blk_mq_complete_request_remote+0xac/0x350
>   nvme_loop_queue_response+0x1df/0x275 [nvme_loop]
>   __nvmet_req_complete+0x132/0x4f0 [nvmet]
>   nvmet_req_complete+0x15/0x40 [nvmet]
>   nvmet_execute_io_connect+0x18a/0x1f0 [nvmet]
>   nvme_loop_execute_work+0x20/0x30 [nvme_loop]
>   process_one_work+0x56e/0xa70
>   worker_thread+0x2d1/0x640
>   kthread+0x183/0x1c0
>   ret_from_fork+0x1f/0x30
> 
> Cc: stable@vger.kernel.org
> Fixes: a07b4970f464 ("nvmet: add a generic NVMe target")
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> ---
>   drivers/nvme/target/core.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
> index a1345790005f..7f4083cf953a 100644
> --- a/drivers/nvme/target/core.c
> +++ b/drivers/nvme/target/core.c
> @@ -735,6 +735,8 @@ static void nvmet_set_error(struct nvmet_req *req, u16 status)
>   
>   static void __nvmet_req_complete(struct nvmet_req *req, u16 status)
>   {
> +	struct nvmet_ns *ns = req->ns;
> +
>   	if (!req->sq->sqhd_disabled)
>   		nvmet_update_sq_head(req);
>   	req->cqe->sq_id = cpu_to_le16(req->sq->qid);
> @@ -745,9 +747,9 @@ static void __nvmet_req_complete(struct nvmet_req *req, u16 status)
>   
>   	trace_nvmet_req_complete(req);
>   
> -	if (req->ns)
> -		nvmet_put_namespace(req->ns);
>   	req->ops->queue_response(req);
> +	if (ns)
> +		nvmet_put_namespace(ns);

Why did the put change position?
I'm not exactly clear what was used-after-free here..

>   }
>   
>   void nvmet_req_complete(struct nvmet_req *req, u16 status)

