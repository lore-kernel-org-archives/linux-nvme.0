Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CDBFC46CD2
	for <linux-nvme@archiver.kernel.org>; Wed, 24 Jan 2024 13:54:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=KcoGOdiT+XcmrIgOwYfnz7vgH0ZXH6cW64T/XPINCfE=; b=TWrHAwFxOnDhx1kaK5y8mh305K
	0mHvLPWq3iF+P20n3nvVGmPgmMt5MAAeXHOdC+ev1rW9iVvo0s/V1g0Ujun3BPnEJuL5QrlwQjN/m
	cjQgmZtg7Rcjktoroag1bxHYHQmmIwlorFxIwwy7wVclxkClSHUKEp+q7aKoK0XRAMJPsE/XtX0u6
	NwPKOc+N+UwAKDXkOXdPoSONCsNswVVke1RCTjNUIlehaClVulYCkq4FeGbaufu30IiK4hyBvKnmK
	UUNK21tZ3ry8R99nBbABq9P4YPQnR6uFKwC0V2n+HmYIu9jXSKVqndOLhoLSGi2QHczhSuUgkPV/h
	WhEqJtjg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rSdhr-003XrW-0a;
	Wed, 24 Jan 2024 13:54:19 +0000
Received: from mail-ed1-f45.google.com ([209.85.208.45])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rSdhn-003Xph-2R
	for linux-nvme@lists.infradead.org;
	Wed, 24 Jan 2024 13:54:17 +0000
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-55c8a40371bso399438a12.0
        for <linux-nvme@lists.infradead.org>; Wed, 24 Jan 2024 05:54:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706104453; x=1706709253;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KcoGOdiT+XcmrIgOwYfnz7vgH0ZXH6cW64T/XPINCfE=;
        b=W0arFEJbywXJdxNBePBM+HzmZad3uZm6E3Uf9U8F18OYMEOSB2OMfEvq8Z7XzKuPXQ
         627DKJ++KFN/53f10NjdtxekN3vIp4dbUnsAok5fZjp3dkQqhGF2HRpr0KitCoN0zuLq
         f0tqqa0u/SXVE/P5KkqCU6W16auh2N4VFmQFtZlN+tRMAPJFwHGY48Ys9V4xGnkOFuC/
         HCUKTwskXhy00r47PUrvXrlvr10+E3PvaKn3GTQmhne9ypTcuKuRifP4stuZG5k+kPtN
         DNZuRZ45GdveotxxsAWkgr2XuzPzLlT5FnJqEQDD9xxurvbNclZhIYiMMPj6APw5wwdx
         9JUw==
X-Gm-Message-State: AOJu0Yy5cyPNbul7NMY4zKjAXj+LCXKGdMQbzdDfaKE1Nc837P4untsj
	2Y8cb4mFwTcSlUD/OTCMO+x1hTgY5XUMQ9BjUQxSDhn+Fek9cskb
X-Google-Smtp-Source: AGHT+IGSGeTtD/iaX3IbpahbkffyrSlQzWBoGdKCbf76gG2h/szKTgJnJ+MQ05SXF2MrTadW80Rz9Q==
X-Received: by 2002:a17:906:3046:b0:a2e:8a6b:6904 with SMTP id d6-20020a170906304600b00a2e8a6b6904mr8467153ejd.0.1706104452845;
        Wed, 24 Jan 2024 05:54:12 -0800 (PST)
Received: from [192.168.64.172] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id cu15-20020a170906ba8f00b00a2ec877d3a6sm8516957ejd.167.2024.01.24.05.54.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Jan 2024 05:54:12 -0800 (PST)
Message-ID: <cac6959f-00e2-4b8a-b642-16dfe1a24383@grimberg.me>
Date: Wed, 24 Jan 2024 15:54:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/8] nvme: sync the namespace scanning during ctrl start
Content-Language: en-US
To: Max Gurtovoy <mgurtovoy@nvidia.com>, kbusch@kernel.org, hch@lst.de,
 linux-nvme@lists.infradead.org
Cc: oren@nvidia.com, israelr@nvidia.com, dwagner@suse.de, oevron@nvidia.com
References: <20240122145659.5574-1-mgurtovoy@nvidia.com>
 <20240122145659.5574-6-mgurtovoy@nvidia.com>
 <d964c7a4-9754-4f31-977e-68d5c08c6e6f@grimberg.me>
 <60f3e0d6-1fce-4f88-84f1-154a5cde4f7f@nvidia.com>
 <42fcd973-223a-4753-8b53-b4aa0b97f414@grimberg.me>
 <b5910af5-2978-47d7-a312-830398c1402f@nvidia.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <b5910af5-2978-47d7-a312-830398c1402f@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240124_055415_828694_47E7C689 
X-CRM114-Status: UNSURE (   9.18  )
X-CRM114-Notice: Please train this message.
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


>>>>> @@ -4537,9 +4536,10 @@ void nvme_start_ctrl(struct nvme_ctrl *ctrl)
>>>>>           nvme_change_uevent(ctrl, "NVME_EVENT=rediscover");
>>>>>       if (ctrl->queue_count > 1) {
>>>>> -        nvme_queue_scan(ctrl);
>>>>> +        nvme_queue_scan_sync(ctrl);
>>>>>           nvme_unquiesce_io_queues(ctrl);
>>>>>           nvme_mpath_update(ctrl);
>>>>> +        nvme_kick_requeue_lists(ctrl);
>>>>>       }
>>>>
>>>> I really don't think its a good idea to block ctrl start
>>>> like that.
>>>
>>> like how ? scan_sync ?
>>
>> Yes
> 
> why not ? this is control path..

Because in the real world, namespaces (or HCAs) will not change their
attributes in 99.999999% of the cases, and when they do, in 99.999999%
of the cases the inflight IO has already failed over to a different
path.

So no, I don't think that preventing the ctrl start from making forward
progress until a full namespaces scan completes makes any sense.

> we have to make sure we issue commands to a validated namespace.

I think we should simply refuse to create the ns when it differs between
paths, or remove it in the highly unlikely case where it suddenly
changes its attributes when reconnecting.

