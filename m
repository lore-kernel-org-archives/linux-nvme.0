Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 902EAD3C937
	for <linux-nvme@archiver.kernel.org>; Mon, 21 Oct 2024 07:18:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=UuyasMgkP9ACihQpzbrksqcPeP7uWQUhYgegjJyc8I8=; b=Aay/akUkyLA8h+ED+T5yi+Qym/
	ZQP7JIadlP/o3uyyiIu7A7vxLLNpzMM7zrVtBQX1yESxD+FLjLTTGgOPhnanOggU6QGxBCgSL068d
	jOs/Fxw9XGtEc6h7kwtj3hx2cH+95cM6DaGbXidpoUbtPl+uJMLoy/IylKgoT0aCrvtU3AVatR6oD
	2kFaQjw+exIvNMHX1aYccvg6vIe5Qgbm6DS2ljnRlAlMvTe41AKMJwMNubyLngsE1E0vlPlYFjnaC
	KoTFjJ39w0VFfhFmhu/U0naPHBItLSoV9I03biVDF4YQ8EcSfJa//eD7w0p4cyow+6lsi2HxwnOZW
	TTJds7LA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t2mgE-00000006L5t-0Rn2;
	Mon, 21 Oct 2024 07:18:18 +0000
Received: from mail-wm1-f52.google.com ([209.85.128.52])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t2mTz-00000006J7o-0S0p
	for linux-nvme@lists.infradead.org;
	Mon, 21 Oct 2024 07:05:40 +0000
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-43152b79d25so39345645e9.1
        for <linux-nvme@lists.infradead.org>; Mon, 21 Oct 2024 00:05:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729494337; x=1730099137;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UuyasMgkP9ACihQpzbrksqcPeP7uWQUhYgegjJyc8I8=;
        b=O7rATrh2qMn2XlHnQrDcPW/4WqkXBMwlXecQJZY72xka2ras4uNA4c6peaKuXJQ0eU
         6oo6bl5Hxx4bvXdYqe21BFa/ci7j0k84ZS5c/3OUrlruP0ExmFUfhXasbPklOYhJFAfM
         S+ptuEmBGatqDio1ntK81oz5NWxfsOaB2/kPHZt23SJ26gagWBcncM0Z/E/Tt+zf/eE5
         18JWNzREblbj10ku6FvNBuVnVLOK6fk/UCkTiRnO0hIz4ARGCDB/2CCfQPiCejhIwkFu
         sVYK8fkmZlBaGoU7tWm++S2vgtiHeqcGCm3/ovknz5QnF2mvZ9YcDUBlRszacSbnwqbK
         cSAA==
X-Forwarded-Encrypted: i=1; AJvYcCUrlmS+4ijgQVrXeYofx9pIBOcrZKDpU6IJzA39K9UBWo1klwwyeQYdyVx66yDoECZkeWToohJ46Avh@lists.infradead.org
X-Gm-Message-State: AOJu0YxoNZV4YZYedqdsH4zZJmUVXR87A6OcC53l0q1MWfhsFDxR62qI
	m7I/+uuQOWBhdbM55NqtSIoNi4lcmeXVZvH69536WwiZ8MGLudEZ
X-Google-Smtp-Source: AGHT+IG8O0M5kVa+Y0zMRDEF4giA3frmfFmV6DY0Rv6ItTOkBc3uE4a++W6C/asLcaygteal3Y9uQA==
X-Received: by 2002:a05:600c:1d09:b0:430:57f2:bae5 with SMTP id 5b1f17b1804b1-4316169a968mr69435105e9.27.1729494337054;
        Mon, 21 Oct 2024 00:05:37 -0700 (PDT)
Received: from [10.50.4.202] (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4316f570c79sm46756225e9.3.2024.10.21.00.05.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Oct 2024 00:05:36 -0700 (PDT)
Message-ID: <064a6fb0-0cdb-4634-863d-a06574fcc0fa@grimberg.me>
Date: Mon, 21 Oct 2024 10:05:34 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] blk-mq: add one blk_mq_req_flags_t type to support mq
 ctx fallback
To: Ming Lei <ming.lei@redhat.com>, zhuxiaohui <zhuxiaohui400@gmail.com>
Cc: axboe@kernel.dk, kbusch@kernel.org, hch@lst.de,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, Zhu Xiaohui <zhuxiaohui.400@bytedance.com>
References: <20241020144041.15953-1-zhuxiaohui.400@bytedance.com>
 <ZxWwvF0Er-Aj-rtX@fedora>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <ZxWwvF0Er-Aj-rtX@fedora>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241021_000539_180457_23BA86D3 
X-CRM114-Status: GOOD (  15.86  )
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




On 21/10/2024 4:39, Ming Lei wrote:
> On Sun, Oct 20, 2024 at 10:40:41PM +0800, zhuxiaohui wrote:
>> From: Zhu Xiaohui <zhuxiaohui.400@bytedance.com>
>>
>> It is observed that nvme connect to a nvme over fabric target will
>> always fail when 'nohz_full' is set.
>>
>> In commit a46c27026da1 ("blk-mq: don't schedule block kworker on
>> isolated CPUs"), it clears hctx->cpumask for all isolate CPUs,
>> and when nvme connect to a remote target, it may fails on this stack:
>>
>>          blk_mq_alloc_request_hctx+1
>>          __nvme_submit_sync_cmd+106
>>          nvmf_connect_io_queue+181
>>          nvme_tcp_start_queue+293
>>          nvme_tcp_setup_ctrl+948
>>          nvme_tcp_create_ctrl+735
>>          nvmf_dev_write+532
>>          vfs_write+237
>>          ksys_write+107
>>          do_syscall_64+128
>>          entry_SYSCALL_64_after_hwframe+118
>>
>> due to that the given blk_mq_hw_ctx->cpumask is cleared with no available
>> blk_mq_ctx on the hw queue.
>>
>> This patch introduce a new blk_mq_req_flags_t flag 'BLK_MQ_REQ_ARB_MQ'
>> as well as a nvme_submit_flags_t 'NVME_SUBMIT_ARB_MQ' which are used to
>> indicate that block layer can fallback to a  blk_mq_ctx whose cpu
>> is not isolated.
> blk_mq_alloc_request_hctx()
> 	...
> 	cpu = cpumask_first_and(data.hctx->cpumask, cpu_online_mask);
> 	...
>
> It can happen in case of non-cpu-isolation too, such as when this hctx hasn't
> online CPUs, both are same actually from this viewpoint.
>
> It is one long-time problem for nvme fc.

For what nvmf is using blk_mq_alloc_request_hctx() is not important. It 
just needs a tag from that hctx. the request execution is running where 
blk_mq_alloc_request_hctx() is running.

