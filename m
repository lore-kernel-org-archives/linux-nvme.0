Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBD61C47258
	for <linux-nvme@archiver.kernel.org>; Wed, 31 Jan 2024 12:40:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fD9PGlR25ihwspdcrfowWodOY4SU/x6nnsgOREPjnfo=; b=G0shfqInazB0OExUC9ALbuO9Ha
	CtQh36zANe4fkAjaTB/L7szS2U6nBVFYNkEJFb2IP54kRjvVhJytNfBl9DEi7chItCHrEP5at8iqd
	cv0ZK3j/QkACwUPNKCgqiQUy2fwDABG8d5Uj9y9HKMujQeBnY0ntNPilOJbV1wFsVv+s0uzULe9D3
	wn+4VOXatr6MST/+954yidmrK74R0aTsRaag5BarzYMqt51bX2AIw00eCklX+q/UeLxp7BQWdgLTk
	r6sVr1ZqDgOWBQlcaXnZfchy1pij0rf6aKzGy7eeIpx2aI6jg6vu+7gAOaCHHAB5wY97VeocEYwtF
	OMyxMeGA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rV9t1-00000003OfS-2Koj;
	Wed, 31 Jan 2024 12:40:15 +0000
Received: from mail-wm1-f53.google.com ([209.85.128.53])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rV9sy-00000003OdI-3vdG
	for linux-nvme@lists.infradead.org;
	Wed, 31 Jan 2024 12:40:14 +0000
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-40f030bf978so2409615e9.0
        for <linux-nvme@lists.infradead.org>; Wed, 31 Jan 2024 04:40:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706704810; x=1707309610;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fD9PGlR25ihwspdcrfowWodOY4SU/x6nnsgOREPjnfo=;
        b=GTIqJEd/OIFwIDvX6LTAXcaBmgXmjOE7JHmk4s1m9YjRqWA26CxhwLOBMnrB58D9+4
         EGdkikqoykCdGQaxMyFd4XrsLyQXvvY77MxEnWuwwVdPgaaZRi/qVkuiIkJsrHTPzAPq
         uD0AXmhhFGZC8y8LCsAiBOYCeNgerYzvDHKoJylm6s0/mcV2TpuuyD0hunldPqPbHett
         zN3LbaiRxMasA/jUNQGqPQ/V+SqU4/JxE9c6KCbAuythFlmLY4WwKU3yvmx3+YL8S3f2
         FnQU3S2IrbpixjlCCGP563gPP2XH9mornTfarEQY6W/81pPI6LHdRDwdP1w/8xTA74I4
         7lqw==
X-Gm-Message-State: AOJu0YwDUKI//5Wg53SwDWx37qGziGQrUrUCV2sHu1JVYIJ6VD2XAYgA
	pvLRhTuv9vOFR240rh7+yYMqfEYOM4hLknmEmHOA81ccbBnQ6Dy1w5ve9jKE
X-Google-Smtp-Source: AGHT+IGDxaz3LhYQaN6TU5Xv6ECxez6iDgEVUh23W1wTp1peDai7mF6wFZx2AgnuE7HdukqJkhbqQg==
X-Received: by 2002:a05:600c:4e08:b0:40e:eadb:6c93 with SMTP id b8-20020a05600c4e0800b0040eeadb6c93mr1185845wmq.1.1706704809812;
        Wed, 31 Jan 2024 04:40:09 -0800 (PST)
Received: from [192.168.64.172] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id iv18-20020a05600c549200b0040e76b60235sm1516153wmb.8.2024.01.31.04.40.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Jan 2024 04:40:09 -0800 (PST)
Message-ID: <e1ae39e7-5c82-4cd4-aa7b-eb6718827d67@grimberg.me>
Date: Wed, 31 Jan 2024 14:40:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/8] nvme: sync the namespace scanning during ctrl start
Content-Language: en-US
To: Max Gurtovoy <mgurtovoy@nvidia.com>, Christoph Hellwig <hch@lst.de>
Cc: kbusch@kernel.org, linux-nvme@lists.infradead.org, oren@nvidia.com,
 israelr@nvidia.com, dwagner@suse.de, oevron@nvidia.com
References: <20240122145659.5574-1-mgurtovoy@nvidia.com>
 <20240122145659.5574-6-mgurtovoy@nvidia.com> <20240123090231.GD30773@lst.de>
 <f168e3d8-ddec-46cd-a032-2ca771b6cd23@nvidia.com>
 <20240124094832.GA31289@lst.de>
 <1315cf2b-038a-4830-87ac-5ac1fbd5a1e9@nvidia.com>
 <20240125144130.GA18804@lst.de>
 <d8f4c989-00a2-4545-87de-a70da312beff@nvidia.com>
 <c7b2670c-416e-4451-9c29-439595df5213@grimberg.me>
 <8d3c4f09-a1be-45b6-9452-7a14609a62d1@nvidia.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <8d3c4f09-a1be-45b6-9452-7a14609a62d1@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240131_044013_011497_AC4B72D1 
X-CRM114-Status: GOOD (  19.88  )
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



On 1/29/24 14:37, Max Gurtovoy wrote:
> 
> 
> On 29/01/2024 12:48, Sagi Grimberg wrote:
>>
>>>>> Even in this case of re-creation we must sync the namespace 
>>>>> identification.
>>>>
>>>> But a format is not a re-creation.
>>>>
>>>
>>> we currently don't support format in fabrics so maybe I didn't use 
>>> the correct word during my answer.
>>>
>>> because of the dynamic nature of controllers and namespaces we have 
>>> the identify ctrl/ns commands in the specification and we need to use 
>>> them.
>>
>> ns scanning has been notorious to cause issues when executing with
>> controller resets. So I don't think it is a good idea to make ctrl start
>> block until it completes, especially not for an esoteric case that
>> a ns that suddenly was reformatted between reconnects.
>>
> 
> I think that making sure that the namespace is active and validated is 
> not esoteric.

The use-case you describe is very niche and esoteric IMO.

> What is the concern ? is it the time it takes to validate a namespace ?

Max, I mentioned that I don't think it is a good idea to change the
existing behavior, because of time, because its preventing forward
progress, because it doesn't fix an existing issue, etc.
I also don't think its needed.

I think the original intent of this as made in discussions in the past 
was to simply fail upon PI mismatch when nvme_init_ns_head and
nvme_validate_ns.

> I think that AEN and reset flows are a bit different. The controller is 
> free to be modified at any time (even when no Admin queue is opened from 
> the host). It may have out-of-band management interface (for example the 
> nvmet cli) and may not have any association (AQ) to the host to notify 
> on changes.

Fundamentally things can change before the host knows about it, hence
I don't get the claim that somehow the host violates the spec.

Do others think that now namespace scanning should block
nvme_ctrl_start ? I personally don't but I'm open to justification
for why it is the right thing to do.

