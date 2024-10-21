Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AF6CD0E6F4
	for <linux-nvme@archiver.kernel.org>; Mon, 21 Oct 2024 11:30:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=LTJfKmuI0AsDNtueSvfDv1B8tVY2xfxReUx3Zx8L+Is=; b=V5ZfG6+lwBYZC5Id+ChxcYKOEm
	G85riXrhEm8Gi8L3GDUoELZzeXMzSJUD03HPV1a6JxYEOPFRi8sJc1iKK7uEcmhQIUYkN1VS0yKm8
	EwVMldASwRjL7DAL68NrbMP8mKcByzTkjbjMqGBomJIAX6J1ErjGe5wzFMYgHCTsfxygGEsULbOHQ
	um9olNTbyb+m/tURUotDqB5+F8HPbkMKp6dQUFP4JSfTB+RzQ1Qcd3XwInOHAhylsgdpu/CWci1Gk
	lxJpOSktPIxbbRin03VAAGim/dj8NmQHqCboFLIryBRXoL+V/YWNt003bnVjrt6DnAk2k43mScfV2
	IUafQ6fw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t2qbw-000000073JE-0QpL;
	Mon, 21 Oct 2024 11:30:08 +0000
Received: from mail-wr1-f45.google.com ([209.85.221.45])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t2qbt-000000073Ii-0hVH
	for linux-nvme@lists.infradead.org;
	Mon, 21 Oct 2024 11:30:06 +0000
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-37d4c1b1455so2937030f8f.3
        for <linux-nvme@lists.infradead.org>; Mon, 21 Oct 2024 04:30:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729510203; x=1730115003;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LTJfKmuI0AsDNtueSvfDv1B8tVY2xfxReUx3Zx8L+Is=;
        b=iG2LXZXtNhs7bX6IH5TifPEvQPsWLRKeUyTCP1hbeMb9N42IguxPOThdaYioXQ9l4R
         efVscHFSBdR9V87XHTxYSRxTLKZLeNKQrHXUuh1mvnoxvKMC00p6XEkjbAxZ6aMR8mRA
         4rDQz8Snos/gZA3bTuvwnJe1SkirqpPtx1hwE1Lbj8l8jFBvpF/X6+rdXERqKNMfqmJE
         fpHZCpFg1lyT+apVmxWworzkijDMaF5iMwjujMjaQckKMYKRu8YFxjcTfBrYOeomwhFJ
         UAFK8/3qH7Ema6bc+3fCjJPk8OgLlUclhlbWWhEDaF1aIS4tBrknPi0yexf8pIhyOPmp
         KnGA==
X-Forwarded-Encrypted: i=1; AJvYcCW6OAEAC/UL2QtvrAZ9Pi9fGzLgV5hd5FnrHvGT2QLHnXqWrzgRaNomtmEyGgQapb/seCodGtB8Kfh+@lists.infradead.org
X-Gm-Message-State: AOJu0YyV1MHFR2tJTLvKEMpbvp+VGJdAu9bn4fgZlHdw7fxp1/8+feyd
	AC/A5uGLbWBj/nDL8aJMwDGzcylcbUkIKEMNWo444xGh5DbqtyR+zpm50g==
X-Google-Smtp-Source: AGHT+IHbayAJI3QNFHIobPOQHH8sUh2FU4OTF56IrfvdfLiWAa5xFFH0sEWOcjkLHMaJUaVVOZyUtg==
X-Received: by 2002:adf:e40a:0:b0:37d:39f8:a77a with SMTP id ffacd0b85a97d-37eab0faa93mr6301280f8f.8.1729510203166;
        Mon, 21 Oct 2024 04:30:03 -0700 (PDT)
Received: from [10.50.4.202] (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37ee0b944fbsm4129957f8f.72.2024.10.21.04.30.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Oct 2024 04:30:02 -0700 (PDT)
Message-ID: <ab2ed574-5fb8-49d9-b6f3-5030566fc64a@grimberg.me>
Date: Mon, 21 Oct 2024 14:30:01 +0300
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
 <ZxYRXvyxzlFP_NPl@fedora>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <ZxYRXvyxzlFP_NPl@fedora>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241021_043005_239990_8F352F25 
X-CRM114-Status: GOOD (  16.21  )
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




On 21/10/2024 11:31, Ming Lei wrote:
> On Mon, Oct 21, 2024 at 10:05:34AM +0300, Sagi Grimberg wrote:
>>
>>
>> On 21/10/2024 4:39, Ming Lei wrote:
>>> On Sun, Oct 20, 2024 at 10:40:41PM +0800, zhuxiaohui wrote:
>>>> From: Zhu Xiaohui <zhuxiaohui.400@bytedance.com>
>>>>
>>>> It is observed that nvme connect to a nvme over fabric target will
>>>> always fail when 'nohz_full' is set.
>>>>
>>>> In commit a46c27026da1 ("blk-mq: don't schedule block kworker on
>>>> isolated CPUs"), it clears hctx->cpumask for all isolate CPUs,
>>>> and when nvme connect to a remote target, it may fails on this stack:
>>>>
>>>>           blk_mq_alloc_request_hctx+1
>>>>           __nvme_submit_sync_cmd+106
>>>>           nvmf_connect_io_queue+181
>>>>           nvme_tcp_start_queue+293
>>>>           nvme_tcp_setup_ctrl+948
>>>>           nvme_tcp_create_ctrl+735
>>>>           nvmf_dev_write+532
>>>>           vfs_write+237
>>>>           ksys_write+107
>>>>           do_syscall_64+128
>>>>           entry_SYSCALL_64_after_hwframe+118
>>>>
>>>> due to that the given blk_mq_hw_ctx->cpumask is cleared with no available
>>>> blk_mq_ctx on the hw queue.
>>>>
>>>> This patch introduce a new blk_mq_req_flags_t flag 'BLK_MQ_REQ_ARB_MQ'
>>>> as well as a nvme_submit_flags_t 'NVME_SUBMIT_ARB_MQ' which are used to
>>>> indicate that block layer can fallback to a  blk_mq_ctx whose cpu
>>>> is not isolated.
>>> blk_mq_alloc_request_hctx()
>>> 	...
>>> 	cpu = cpumask_first_and(data.hctx->cpumask, cpu_online_mask);
>>> 	...
>>>
>>> It can happen in case of non-cpu-isolation too, such as when this hctx hasn't
>>> online CPUs, both are same actually from this viewpoint.
>>>
>>> It is one long-time problem for nvme fc.
>> For what nvmf is using blk_mq_alloc_request_hctx() is not important. It just
>> needs a tag from that hctx. the request execution is running where
>> blk_mq_alloc_request_hctx() is running.
> I am afraid that just one tag from the specified hw queue isn't enough.
>
> The connection request needs to be issued to the hw queue & completed.
> Without any online CPU for this hw queue, the request can't be completed
> in case of managed-irq.

None of the consumers of this API use managed-irqs. the networking stack
takes care of steering irq vectors to online cpus.

