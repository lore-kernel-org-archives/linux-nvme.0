Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8512C4345F
	for <linux-nvme@archiver.kernel.org>; Fri,  3 May 2024 07:32:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mLjZ4XBNoYrG2AfbHtnwrbcCvSNKrmnJot9LbQr1gQA=; b=ADus3MlyymDWqa4D7ozIR+WCte
	es6yWr5R5drtjyKWCKb6uPrUxUXPyr+189PgpgPlPnpcD0+YnV7XjD0iSqtIidKG0leAhZ6LXJUI1
	8BElh9/pMz299O9y6V4zvDVzv7L2Yxk/+kofiML9rdP3XMyQ3d3f8aWaiS6UJ+2civYheskUmhUME
	DS3MuclYTuFcMsN+E9b2bdtcHxSu4dEoPRRcWdrffXcl2uMCdyr9ooUOX8HFQzWzOSjoznj6VXNSw
	+F7FJ/DdMv7PB7b5iJjXLG4pfDPLbS0SfA6TItOTnVfW+wjzM6nX4mk7jp04RXlYO6dTQe3tktIEn
	5yp1Qq/w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s2nOj-0000000FTco-3keM;
	Fri, 03 May 2024 07:32:01 +0000
Received: from mail-lj1-f171.google.com ([209.85.208.171])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s2nOh-0000000FTaj-1JeK
	for linux-nvme@lists.infradead.org;
	Fri, 03 May 2024 07:32:00 +0000
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2e20088184cso2766551fa.1
        for <linux-nvme@lists.infradead.org>; Fri, 03 May 2024 00:31:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714721516; x=1715326316;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mLjZ4XBNoYrG2AfbHtnwrbcCvSNKrmnJot9LbQr1gQA=;
        b=PlEWzR9Se99/cozn12aB4IHp10CzD3RqTXj/lN51ezOwdFoVQ7UnL5eZzWV138Qc58
         8Aq9Bv1YJu99SpRrHNfPrQWmHOOWVrGKieeZJt0/WtMNdSOMo7oDKUqu9WSpnlomsiLZ
         UEJYKcPbKOUL8wXrXLNDwveyeACy7R1ErsqHYEs766Uca+eCPNlPxdA5JGSo2DA3MQN1
         mnP1M4TfWthctTCW6jZ5UdzqR//vzPcML+rQwKfTX4yS9myssFvh38MvD2a/l9ErUgnw
         EYnByzzMsOdcicTwW7GOJiyE4FIg3Jd6SEFseUr+s4BOvPqYyp/gfyaQRw2olKAE9qp1
         0VTw==
X-Forwarded-Encrypted: i=1; AJvYcCVtNFKm3MBMODw7OvDaU6BFiPHZ3uvr4fA9/Kt/rfMCKh9pf3G/5JlECy8+n5XNqt6WQnZUmAG+9zrPzkxvFN1CCD8y6ff4Lc5YcMJF324=
X-Gm-Message-State: AOJu0Yyu+0N1/Um28KyfqTJ75tX7t8e9wyJPiafDyZr2zdBYvD16tGrV
	ixPMlJI0yQcc1kHX36/20qifikhlS4lujLdq8LB0ILcsZ+s6Q7mE
X-Google-Smtp-Source: AGHT+IEEbbGP4318UVGteGjHsF5YUKEwa1jSIC9b8Ajd7I4cQyPZMFhGIFgNLu7U70PFB+9PBRW1JA==
X-Received: by 2002:a19:ca4d:0:b0:513:ec32:aa89 with SMTP id h13-20020a19ca4d000000b00513ec32aa89mr1323536lfj.2.1714721515704;
        Fri, 03 May 2024 00:31:55 -0700 (PDT)
Received: from [10.100.102.67] (85.65.192.64.dynamic.barak-online.net. [85.65.192.64])
        by smtp.gmail.com with ESMTPSA id k7-20020a7bc407000000b0041674bf7d4csm8285498wmi.48.2024.05.03.00.31.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 May 2024 00:31:55 -0700 (PDT)
Message-ID: <29655a73-5d4c-4773-a425-e16628b8ba7a@grimberg.me>
Date: Fri, 3 May 2024 10:31:50 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v24 01/20] net: Introduce direct data placement tcp
 offload
To: Aurelien Aptel <aaptel@nvidia.com>, linux-nvme@lists.infradead.org,
 netdev@vger.kernel.org, hch@lst.de, kbusch@kernel.org, axboe@fb.com,
 chaitanyak@nvidia.com, davem@davemloft.net, kuba@kernel.org
Cc: Boris Pismenny <borisp@nvidia.com>, aurelien.aptel@gmail.com,
 smalin@nvidia.com, malin1024@gmail.com, ogerlitz@nvidia.com,
 yorayz@nvidia.com, galshalom@nvidia.com, mgurtovoy@nvidia.com,
 edumazet@google.com, pabeni@redhat.com, dsahern@kernel.org, ast@kernel.org,
 jacob.e.keller@intel.com
References: <20240404123717.11857-1-aaptel@nvidia.com>
 <20240404123717.11857-2-aaptel@nvidia.com>
 <3ab22e14-35eb-473e-a821-6dbddea96254@grimberg.me>
 <253o79wr3lh.fsf@mtr-vdi-124.i-did-not-set--mail-host-address--so-tickle-me>
 <9a38f4db-bff5-4f0f-ac54-6ac23f748441@grimberg.me>
 <253le4wqu4a.fsf@nvidia.com>
 <2d4f4468-343a-4706-8469-56990c287dba@grimberg.me>
 <253frv0r8yc.fsf@nvidia.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <253frv0r8yc.fsf@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240503_003159_397077_BEDA5620 
X-CRM114-Status: GOOD (  22.33  )
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



On 5/2/24 10:04, Aurelien Aptel wrote:
> Sagi Grimberg <sagi@grimberg.me> writes:
>> Well, you cannot rely on the fact that the application will be pinned to a
>> specific cpu core. That may be the case by accident, but you must not and
>> cannot assume it.
> Just to be clear, any CPU can read from the socket and benefit from the
> offload but there will be an extra cost if the queue CPU is different
> from the offload CPU. We use cfg->io_cpu as a hint.

Understood. It is usually the case as io threads are not aligned to the 
rss steering rules (unless
arfs is used).

>
>> Even today, nvme-tcp has an option to run from an unbound wq context,
>> where queue->io_cpu is set to WORK_CPU_UNBOUND. What are you going to
>> do there?
> When the CPU is not bound to a specific core, we will most likely always
> have CPU misalignment and the extra cost that goes with it.

Yes, as done today.

>
> But when it is bound, which is still the default common case, we will
> benefit from the alignment. To not lose that benefit for the default
> most common case, we would like to keep cfg->io_cpu.

Well, this explanation is much more reasonable. Setting .affinity_hint 
argument
seems like a proper argument to the interface and nvme-tcp can set it to 
queue->io_cpu.

>
> Could you clarify what are the advantages of running unbounded queues,
> or to handle RX on a different cpu than the current io_cpu?

See the discussion related to the patch from Li Feng:
https://lore.kernel.org/lkml/20230413062339.2454616-1-fengli@smartx.com/

>
>> nvme-tcp may handle rx side directly from .data_ready() in the future, what
>> will the offload do in that case?
> It is not clear to us what the benefit of handling rx in .data_ready()
> will achieve. From our experiment, ->sk_data_ready() is called either
> from queue->io_cpu, or sk->sk_incoming_cpu. Unless you enable aRFS,
> sk_incoming_cpu will be constant for the whole connection. Can you
> clarify would handling RX from data_ready() provide?

Save the context switching to a kthread from softirq, can reduce latency 
substantially
for some workloads.

