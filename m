Return-Path: <SRS0=D3vR=ET=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE223C4742C
	for <linux-nvme@archiver.kernel.org>; Fri, 13 Nov 2020 21:56:20 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 52B96206C0
	for <linux-nvme@archiver.kernel.org>; Fri, 13 Nov 2020 21:56:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="hKNIHgDg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52B96206C0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=AkcIxkfJdPzJFr4zHcH8GHnU7VgrCCktLahRrH7/Gfc=; b=hKNIHgDgMdCBRxapMmRzydHne
	+hLmBJ7+kxQfCe2WJGA6dgwa5rVGsXjAlnOuIH/z9SyHtKrEs1M3mlpZggn4JnccdhwH7li5EB2v9
	7ryEB+1QPOndhWUzb8DIkDJCUka8Xy/yJ7e9Co/dyW389Nnr8FYCTC3FWpPF0B5SpnxBkICgM1PgZ
	/LM+O/NI3ywFAYpIbDahnvJi/YBfdU7xus7JmgV+JrTpwQLLz2Ujax5rq12hxpPkOyCHadRXvO6az
	MmIQNPMdQ1Cd46KSCeQNiMU48pflCytpiDs+nl9PBr71j11809biaT8hXN6n7xyJgcqCvh0bvP6vn
	m0euORI1g==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kdh3I-0006vV-5K; Fri, 13 Nov 2020 21:56:16 +0000
Received: from mail-pg1-f170.google.com ([209.85.215.170])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kdh3E-0006ur-OR
 for linux-nvme@lists.infradead.org; Fri, 13 Nov 2020 21:56:14 +0000
Received: by mail-pg1-f170.google.com with SMTP id 34so4914520pgp.10
 for <linux-nvme@lists.infradead.org>; Fri, 13 Nov 2020 13:56:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=SHSbzMcVfeIHaoE+yOJYMuqSia/Ry07Es4s6O7UdW3A=;
 b=Pbvk0tov4ZMRjxdL5IR62w0VE7vzBbKTrIRzA2ovj00ic0AV61LqbqP9BDxVo59kBd
 cDT292ex3Bk0bjI2o0ceneBU3kAL+rsCdfP17YHu3kPTkL/OVOWojbmHiOKsspM0dvV9
 vjnk8ojzuwSPVx71GM28039XEUJ4TGYBrFS8FhXvDVLWjASE++4rJvTnQ6ctf9yihH6Z
 ZgOfP7ziC3JLX3vyS00HWtjkB6jZFRI12OyULK0DbLJe+72vMhFUj616kjLDJQV4jArx
 t0pCxDjRXqqD/vFhnsWNzL/bZBW1yQs0PxsdlRnF7WFjJtZtFaMBmGYCSumg0LKfGrPo
 XhuQ==
X-Gm-Message-State: AOAM533he7kcns8MwrOdprFmj8jhKxzl9FdRTrSUndXqXCDSpzwE8Szq
 +aJYNCHd4h3zuxspG41JH3c=
X-Google-Smtp-Source: ABdhPJwTOoAtJr0iibtmigs2tAP2l7L6yRVJViK+rRXstuLrzMg8yCn899CSRJZaTSbCG6DVghICrw==
X-Received: by 2002:a62:1ccf:0:b029:18b:c80f:cf0c with SMTP id
 c198-20020a621ccf0000b029018bc80fcf0cmr3717378pfc.24.1605304571302; 
 Fri, 13 Nov 2020 13:56:11 -0800 (PST)
Received: from ?IPv6:2601:647:4802:9070:be97:ffd:339d:919c?
 ([2601:647:4802:9070:be97:ffd:339d:919c])
 by smtp.gmail.com with ESMTPSA id r73sm10903169pfc.20.2020.11.13.13.56.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 13 Nov 2020 13:56:10 -0800 (PST)
Subject: Re: [PATCH] iosched: Add i10 I/O Scheduler
To: Jens Axboe <axboe@kernel.dk>, Rachit Agarwal <rach4x0r@gmail.com>,
 Christoph Hellwig <hch@lst.de>
References: <20201112140752.1554-1-rach4x0r@gmail.com>
 <5a954c4e-aa84-834d-7d04-0ce3545d45c9@kernel.dk>
 <da0c7aea-d917-4f3a-5136-89c30d12ba1f@grimberg.me>
 <fd12993a-bcb7-7b45-5406-61da1979d49d@kernel.dk>
 <10993ce4-7048-a369-ea44-adf445acfca7@grimberg.me>
 <c4cb66f6-8a66-7973-dc03-0f4f61d0a1e4@kernel.dk>
 <cbe18a3d-8a6b-e775-81bb-3b3f11045183@grimberg.me>
 <26a1cd20-6b25-eaa6-7ab6-ba7f5afaf6dd@kernel.dk>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <81cdcb58-9a23-8192-6213-7f2408a3b8ee@grimberg.me>
Date: Fri, 13 Nov 2020 13:56:08 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <26a1cd20-6b25-eaa6-7ab6-ba7f5afaf6dd@kernel.dk>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201113_165612_864498_6B288EFE 
X-CRM114-Status: GOOD (  20.04  )
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
Cc: Qizhe Cai <qc228@cornell.edu>, Rachit Agarwal <ragarwal@cornell.edu>,
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 Ming Lei <ming.lei@redhat.com>, linux-block@vger.kernel.org,
 Midhul Vuppalapati <mvv25@cornell.edu>,
 Jaehyun Hwang <jaehyun.hwang@cornell.edu>,
 Rachit Agarwal <ragarwal@cs.cornell.edu>, Keith Busch <kbusch@kernel.org>,
 Sagi Grimberg <sagi@lightbitslabs.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


>>>> But if you think this has a better home, I'm assuming that the guys
>>>> will be open to that.
>>>
>>> Also see the reply from Ming. It's a balancing act - don't want to add
>>> extra overhead to the core, but also don't want to carry an extra
>>> scheduler if the main change is really just variable dispatch batching.
>>> And since we already have a notion of that, seems worthwhile to explore
>>> that venue.
>>
>> I agree,
>>
>> The main difference is that this balancing is not driven from device
>> resource pressure, but rather from an assumption of device specific
>> optimization (and also with a specific optimization target), hence a
>> scheduler a user would need to opt-in seemed like a good compromise.
>>
>> But maybe Ming has some good ideas on a different way to add it..
> 
> So here's another case - virtualized nvme. The commit overhead is
> suitably large there that performance suffers quite a bit, similarly to
> your remote storage case. If we had suitable logic in the core, then we
> could easily propagate this knowledge when setting up the queue. Then it
> could happen automatically, without needing a configuration to switch to
> a specific scheduler.

Yes, these use-cases share characteristics. I'm not at all opposed to
placing this in the core. I do think that in order to put something like
this in the core, the bar needs to be higher such that an optimization
target cannot be biased towards a workload (i.e. needs to be adaptive).

I'm still not sure how we would build this on top of what we already
have as it is really centered around device being busy (which is not
the case for nvme), but I didn't put enough thought into it yet.


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
