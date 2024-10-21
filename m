Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEF58D15DAD
	for <linux-nvme@archiver.kernel.org>; Mon, 21 Oct 2024 15:30:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nPNYpFd/xwLgKe8tmdP26yJlWnsjulWDdXDNr81wB04=; b=zPRAshhAycbgnwvzSKult4QUt7
	Gc1WbWJn97wxCRawZ9vjvxKsNErIlWNvcr56iHrTXRWbmSdAks/HvMiE4bvRaOtvkLsaQ6mYcMUic
	mmOy0IETeGgc7Sb2OmTOACUwvOXzxR8hvHBvUbhOGOSX4n37kVXmJ/CIwtEpLrk4cLyGCz4cEoCOY
	NZxUtajN5abEpbO+UXfaG5Ez0tj6pye9XibIszXrmTKvZXixobTVekbBWztxUkaQoBWzy+Fi4rqvU
	cG3f5n2mr5ZmuxVo68XFNUDbp0x05CnDwGdCENXi0159YdDwe1YyImmQ4HqKYpUmBC4rRfe9UH9vc
	y1elcwNg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t2uMg-00000007nKW-22PJ;
	Mon, 21 Oct 2024 15:30:38 +0000
Received: from mail-wm1-f47.google.com ([209.85.128.47])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t2uK3-00000007maf-2Ubr
	for linux-nvme@lists.infradead.org;
	Mon, 21 Oct 2024 15:27:57 +0000
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4315c1c7392so41633685e9.1
        for <linux-nvme@lists.infradead.org>; Mon, 21 Oct 2024 08:27:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729524474; x=1730129274;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nPNYpFd/xwLgKe8tmdP26yJlWnsjulWDdXDNr81wB04=;
        b=CI/FpfH1fZH/+jlztWGfzScadO9abTl6nzFhdgou9jO8hHsqmrrmFjdFJp7wndoR9u
         p1nTYRTtjhDc1szqL6n9F8WRkOElUX+eO5SEixmy42i4gxai7gV4WzSj0GSn81A1u9DM
         bBWr83uHHt/6azxjl7H11NGfVMTC8XvN1Dz861ZFvEyOduHvG6fiJgKPIli5suG70vQE
         IeBOyFN2VE4gIA0c5EQu3U0QuINtVglfqNG5Fi7YiWc50UEvmi3fdc8MGqq4Q0x/FcXG
         LHBtPbo3UFhso+VSfY0R/XyssY3lKv3kvALnmvQlNAO6V3OmFM1onvAX6KqzW/Z+3drr
         XfYw==
X-Forwarded-Encrypted: i=1; AJvYcCV5gvpGVBmrUt1dBrNey1hPs091T2D8nxBe2296cq64aaoqbnLghPX8mhjieQAr8gbVxedkQb1u+Vun@lists.infradead.org
X-Gm-Message-State: AOJu0YxHAA0p2hFpYFjXxrnsVsZFGtBUUZ6KBBvRTD2s8en0DSxXWKkf
	TnB3FkVifeYWspnvQup8Ynn+z1m/uTebVnrE0PUnc/GuBO5J0kbK3GrUvg==
X-Google-Smtp-Source: AGHT+IHxOPVkphc+4ylvQkg4yvf6bqARGxtQ8CDPo9/Vc1nfBMf6q+Zr8IupvM0DYrzPxucpArfPyg==
X-Received: by 2002:adf:f6d2:0:b0:37c:d299:b5f0 with SMTP id ffacd0b85a97d-37eab6ec6camr7295086f8f.59.1729524473533;
        Mon, 21 Oct 2024 08:27:53 -0700 (PDT)
Received: from [10.100.102.74] (89-138-78-158.bb.netvision.net.il. [89.138.78.158])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37ee0a487bdsm4611998f8f.32.2024.10.21.08.27.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Oct 2024 08:27:53 -0700 (PDT)
Message-ID: <6edb988e-2ec0-49b4-b859-e8346137ba68@grimberg.me>
Date: Mon, 21 Oct 2024 18:27:51 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] blk-mq: add one blk_mq_req_flags_t type to support mq
 ctx fallback
To: Ming Lei <ming.lei@redhat.com>
Cc: zhuxiaohui <zhuxiaohui400@gmail.com>, axboe@kernel.dk, kbusch@kernel.org,
 hch@lst.de, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, Zhu Xiaohui <zhuxiaohui.400@bytedance.com>
References: <20241020144041.15953-1-zhuxiaohui.400@bytedance.com>
 <ZxWwvF0Er-Aj-rtX@fedora> <064a6fb0-0cdb-4634-863d-a06574fcc0fa@grimberg.me>
 <ZxYRXvyxzlFP_NPl@fedora> <ab2ed574-5fb8-49d9-b6f3-5030566fc64a@grimberg.me>
 <ZxZm5HcsGCYoQ6Mv@fedora>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <ZxZm5HcsGCYoQ6Mv@fedora>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241021_082755_668180_64800C50 
X-CRM114-Status: GOOD (  22.53  )
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




On 21/10/2024 17:36, Ming Lei wrote:
> On Mon, Oct 21, 2024 at 02:30:01PM +0300, Sagi Grimberg wrote:
>>
>>
>> On 21/10/2024 11:31, Ming Lei wrote:
>>> On Mon, Oct 21, 2024 at 10:05:34AM +0300, Sagi Grimberg wrote:
>>>>
>>>> On 21/10/2024 4:39, Ming Lei wrote:
>>>>> On Sun, Oct 20, 2024 at 10:40:41PM +0800, zhuxiaohui wrote:
>>>>>> From: Zhu Xiaohui <zhuxiaohui.400@bytedance.com>
>>>>>>
>>>>>> It is observed that nvme connect to a nvme over fabric target will
>>>>>> always fail when 'nohz_full' is set.
>>>>>>
>>>>>> In commit a46c27026da1 ("blk-mq: don't schedule block kworker on
>>>>>> isolated CPUs"), it clears hctx->cpumask for all isolate CPUs,
>>>>>> and when nvme connect to a remote target, it may fails on this stack:
>>>>>>
>>>>>>            blk_mq_alloc_request_hctx+1
>>>>>>            __nvme_submit_sync_cmd+106
>>>>>>            nvmf_connect_io_queue+181
>>>>>>            nvme_tcp_start_queue+293
>>>>>>            nvme_tcp_setup_ctrl+948
>>>>>>            nvme_tcp_create_ctrl+735
>>>>>>            nvmf_dev_write+532
>>>>>>            vfs_write+237
>>>>>>            ksys_write+107
>>>>>>            do_syscall_64+128
>>>>>>            entry_SYSCALL_64_after_hwframe+118
>>>>>>
>>>>>> due to that the given blk_mq_hw_ctx->cpumask is cleared with no available
>>>>>> blk_mq_ctx on the hw queue.
>>>>>>
>>>>>> This patch introduce a new blk_mq_req_flags_t flag 'BLK_MQ_REQ_ARB_MQ'
>>>>>> as well as a nvme_submit_flags_t 'NVME_SUBMIT_ARB_MQ' which are used to
>>>>>> indicate that block layer can fallback to a  blk_mq_ctx whose cpu
>>>>>> is not isolated.
>>>>> blk_mq_alloc_request_hctx()
>>>>> 	...
>>>>> 	cpu = cpumask_first_and(data.hctx->cpumask, cpu_online_mask);
>>>>> 	...
>>>>>
>>>>> It can happen in case of non-cpu-isolation too, such as when this hctx hasn't
>>>>> online CPUs, both are same actually from this viewpoint.
>>>>>
>>>>> It is one long-time problem for nvme fc.
>>>> For what nvmf is using blk_mq_alloc_request_hctx() is not important. It just
>>>> needs a tag from that hctx. the request execution is running where
>>>> blk_mq_alloc_request_hctx() is running.
>>> I am afraid that just one tag from the specified hw queue isn't enough.
>>>
>>> The connection request needs to be issued to the hw queue & completed.
>>> Without any online CPU for this hw queue, the request can't be completed
>>> in case of managed-irq.
>> None of the consumers of this API use managed-irqs. the networking stack
>> takes care of steering irq vectors to online cpus.
> OK, it looks not necessary to AND with cpu_online_mask in
> blk_mq_alloc_request_hctx, and the behavior is actually from commit
> 20e4d8139319 ("blk-mq: simplify queue mapping & schedule with each possisble CPU").

it is a long time ago...

>
> But it is still too tricky as one API, please look at blk_mq_get_tag(), which may
> allocate tag from other hw queue, instead of the specified one.

I don't see how it can help here.

>
> It is just lucky for connection request because IO isn't started
> yet at that time, and the allocation always succeeds in the 1st try of
> __blk_mq_get_tag().

It's not lucky, we reserve a per-queue tag for exactly this flow 
(connect) so we
always have one available. And when the connect is running, the driver 
should
guarantee nothing else is running.

