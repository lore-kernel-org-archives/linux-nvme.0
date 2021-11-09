Return-Path: <SRS0=GOb3=P4=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F1F2C433F5
	for <linux-nvme@archiver.kernel.org>; Tue,  9 Nov 2021 15:54:52 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 63F8E6023F
	for <linux-nvme@archiver.kernel.org>; Tue,  9 Nov 2021 15:54:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 63F8E6023F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
	Subject:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kwCW/aTCmT5NDdXukIXV+fHPyJfdcVyAHw9VxpTrT0M=; b=mJJhjMcoBervC14lSt0OLKVsWf
	TeEcdIpV7MkFzgs95GQjQs0dZY2f3i+j/PePL8XPP1YQGlgp4k9etFbjV7PinpWHF03nmfSSZYHGL
	HVuQisZJrKF4/AgCrAwOQnAQSNRRNfUKNkvfQPij+5+A8SSFuqrPdzi2uKhge02Vm07H9/FywlRda
	0NhGt+o5a7zkatJyUCqVIBBxPF/Emy921GQJoKJOxBKppN06Ub/V1EYVnyUhCrZZOewpyWHNZ7uPC
	MFMUaxHsYqZkTLCMU9EXGfBO4u1aOMr2scVh+5DqZrZPLC6+MOauYMC2k+XEtmP6PEfQOn3OkYlDq
	3uSwBCoQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mkTSR-002cVs-1w; Tue, 09 Nov 2021 15:54:47 +0000
Received: from mail-pg1-f170.google.com ([209.85.215.170])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mkTSO-002cVD-6R
 for linux-nvme@lists.infradead.org; Tue, 09 Nov 2021 15:54:45 +0000
Received: by mail-pg1-f170.google.com with SMTP id q126so14925395pgq.13
 for <linux-nvme@lists.infradead.org>; Tue, 09 Nov 2021 07:54:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=kwCW/aTCmT5NDdXukIXV+fHPyJfdcVyAHw9VxpTrT0M=;
 b=mE5gkbh4YsCBdEjs1Q94EidQIUga63UWMwcnPyDuR4RkPdzdudHpoUqdGw5jq48br7
 rOGKMQMMr4MhAVBwj+2tQ3DY8OkJE+MkA/QZ6d2vdslgAsHJ/Ksj4h6+mj4xSq80Fpt2
 9bCOT6tRXtDeWTuyLjoENfddOS8fJ4Q6FZzTMOR7p252/PNz0Pacr8X0GSazpLCxWnGW
 KE9JmJXkwS2b8OaYI5uxZFqZZdqeBo60eygnSZJCrIbFMHibr9AVOrwKfFkII4cIyV1p
 zYY8APbMXiNQ+CJqTKW4bR16UdhLO3OJ0FsZ0pue+G97kBIoCosNnFZ8YO0XCxFXxSob
 BYJA==
X-Gm-Message-State: AOAM530Uyba0KsNfvS4ALOTdb6NoYNinukn0FOb9RGeQUNOUbygRDzLq
 xdPwv+o4392HtVIO/rY4Bn0=
X-Google-Smtp-Source: ABdhPJwgyKF2bZZeNfJIaRSg7qeVKa0taiDlelOJLVgm2sfYitScH6preSv++g6WiPGhVrm9pRj8JQ==
X-Received: by 2002:a05:6a00:2af:b0:49f:c4b0:879b with SMTP id
 q15-20020a056a0002af00b0049fc4b0879bmr8858600pfs.55.1636473282403; 
 Tue, 09 Nov 2021 07:54:42 -0800 (PST)
Received: from [10.0.3.224] ([12.1.36.164])
 by smtp.gmail.com with ESMTPSA id o16sm6467746pfu.72.2021.11.09.07.54.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 09 Nov 2021 07:54:41 -0800 (PST)
Subject: Re: [PATCH] nvme-tcp: fix memory leak when freeing a queue
To: Christoph Hellwig <hch@lst.de>, Maurizio Lombardi <mlombard@redhat.com>
Cc: linux-nvme@lists.infradead.org, kbusch@kernel.org, axboe@fb.com
References: <20211103081817.94820-1-mlombard@redhat.com>
 <a609e935-f529-d87e-a950-33367694aef5@grimberg.me>
 <20211103104516.GD4840@raketa> <20211103110310.GE4840@raketa>
 <20211109081303.GC28785@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <8aac779e-512e-d816-f6c8-133ad3979d8b@grimberg.me>
Date: Tue, 9 Nov 2021 07:54:40 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211109081303.GC28785@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211109_075444_290505_D2A1BA07 
X-CRM114-Status: GOOD (  13.93  )
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


>>>> Thanks Maurizio,
>>>>
>>>> Why do we need to the pf_cache.va protection? nvme_tcp_free_queue
>>>> is already protected against re-entry with the NVME_TCP_Q_ALLOCATED
>>>> bit.
>>>>
>>>
>>> It's not the re-entry what worried me, I thought that nvme_tcp_free_queue()
>>> might be called before page_frag_alloc() had the chance to initialize the pf_cache, triggering
>>> a NULL pointer dereference. I am doing some tests right now and it seems not to be
>>> possible so maybe we can drop the "if".
>>
>> Oh wait, if nvme_tcp_setup_ctrl() fails it could call nvme_tcp_destroy_io_queues() and
>> iI guess that in that case the pf_cache is not initialized, so the if(pf_cache.va) protection
>> is necessary.
> 
> Sagi, does this look good to you now?

Yes,

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

