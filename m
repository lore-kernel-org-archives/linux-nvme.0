Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50B80C67861
	for <linux-nvme@archiver.kernel.org>; Mon,  8 Apr 2024 21:07:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=cfvDf/p/1Ug3LlJDgT+jo4/hk6WbfuEDOO8siZOBFgI=; b=H0CMXiV6d1AdEPnx05ZFytUDM6
	RTQUvcE2ljyHsA5iE1O6agKODQ+e/00ktGc7326qpG7FPw6AtUGPyHOOSfLDpm8PBE7yjWjQHthng
	i2ginkRBhzfinN9yGDqcVtTl2aJaGbPQ7jd0Agsi6oE+ssnoRVwxMOvSIK5zAYpzNFver7T5T26TW
	E/MB0/64voSsRGw+BQR7WbgbVw3nOSm+G4gO9yWf75gkD1sGACpLzjcK4qAWa1jyQ7Q2XTMgPKPN6
	5eR0TmWJ0vh2DtiobAktwYIrq8gXoYtWSUZ6V66K9AIA4Rqdp9Epuk1K5abV+PvhY8MyyT2nR6tBw
	uKtJRL/Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rtwDA-0000000GqW1-3PH5;
	Mon, 08 Apr 2024 21:07:28 +0000
Received: from mail-wm1-f52.google.com ([209.85.128.52])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rtwD7-0000000GqUj-3h7S
	for linux-nvme@lists.infradead.org;
	Mon, 08 Apr 2024 21:07:27 +0000
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-416463e82fbso2820185e9.1
        for <linux-nvme@lists.infradead.org>; Mon, 08 Apr 2024 14:07:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712610443; x=1713215243;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cfvDf/p/1Ug3LlJDgT+jo4/hk6WbfuEDOO8siZOBFgI=;
        b=Am1FOPYpXWWoqxbkbnvgTV3gigEopJbEhyFWV82STtq+gmQGNfRTe4LmSUAbiOA7A+
         dJB99CGZveJXH1/Z9cqB51eOOC5sIJXclNBvHDZQAHx+k7OUnsI/NYTkfwRDyVzIA54u
         EbfM6IlsSX1akdrInPqNSVgg0ztXjmQ9wryWz1qVcfrPzy1NptiJy8x0ffnF4EDxt8dx
         lkKM4fRot+Ft0gfilUc3hG1aoYyfF9V4ejqA9qTadECTtsfILc8fipzd1zcdOXzH/MPN
         0Q1MFHR+gETRz3lu1jLyiIi+QJuAOD6JYmRGkIgyPx6Edg3L/2nUI8W4p8z6Zl2z6LMg
         WsRA==
X-Forwarded-Encrypted: i=1; AJvYcCUlFU8A6Xwzp7r5WAo1Ni0aEPP0YnjQ1pjrgcsp7oWOLZjT1hPCWAEjjmKbgh1p19D+upOt7vRipCt7tFsf2SLlqosX0R16gIiC5HlQy98=
X-Gm-Message-State: AOJu0YxtH76YKnS12hyLqnB8E82EhKPoiZJLcq3OxZOjKrJR0vUtz7bC
	lseQj7SpYODOSvKc/rESuq11Csz+nSmJioKAPjppwGCJNaSDVfro
X-Google-Smtp-Source: AGHT+IFO7wXvbd9ULwfMutOnbTsn4nHXzuVaSWOIyGIKwQThyPCwTahZwRR+Yc9NMBfSEEtBFr5Qkg==
X-Received: by 2002:a05:600c:1c18:b0:416:5e24:8259 with SMTP id j24-20020a05600c1c1800b004165e248259mr3858482wms.4.1712610442614;
        Mon, 08 Apr 2024 14:07:22 -0700 (PDT)
Received: from [10.100.102.74] (85.65.192.64.dynamic.barak-online.net. [85.65.192.64])
        by smtp.gmail.com with ESMTPSA id bi9-20020a05600c3d8900b004169f8db5f6sm543463wmb.4.2024.04.08.14.07.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Apr 2024 14:07:22 -0700 (PDT)
Message-ID: <bcc7ed23-5ee4-4ce0-981b-bedce0af7984@grimberg.me>
Date: Tue, 9 Apr 2024 00:07:20 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/17] nvme-tcp: sanitize TLS key handling
To: Hannes Reinecke <hare@suse.de>, Hannes Reinecke <hare@kernel.org>,
 Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
References: <20240318150316.138501-1-hare@kernel.org>
 <20240318150316.138501-9-hare@kernel.org>
 <e7200e48-7c86-4cd0-9fa8-4a3d62578a12@grimberg.me>
 <8afbaa30-ae8c-4816-9ba1-59597838184b@suse.de>
Content-Language: he-IL, en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <8afbaa30-ae8c-4816-9ba1-59597838184b@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240408_140726_101621_D44E08BA 
X-CRM114-Status: GOOD (  14.80  )
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



On 08/04/2024 9:48, Hannes Reinecke wrote:
> On 4/7/24 23:15, Sagi Grimberg wrote:
>>
>>
>> On 18/03/2024 17:03, Hannes Reinecke wrote:
>>> From: Hannes Reinecke <hare@suse.de>
>>>
>>> There is a difference between TLS configured (ie the user has
>>> provisioned/requested a key) and TLS enabled (ie the connection
>>> is encrypted with TLS). This becomes important for secure 
>>> concatenation,
>>> where the initial authentication is run unencrypted (ie with
>>> TLS configured, but not enabled), and then the queue is reset to
>>> run over TLS (ie TLS configured _and_ enabled).
>>
>> 1. configured/enabled confuse (me at least) in this context.
>> 2. What does "queue is reset" mean?

Can you answer this?

>>
>>> So to differentiate between those two states store the provisioned
>>> key in opts->tls_key (as we're using the same TLS key for all queues)
>>> and only the key serial of the key negotiated by the TLS handshake
>>> in queue->tls_pskid.
>>
>> I have some recollection of asking about it, but can you explain why is
>> a tls_pskid now stored per-queue? What do we lose if tls_pskid moves 
>> from
>> nvme_tcp_queue to nvme_tcp_ctrl ?
>>
> We need to have a distinction between 'the queue is TLS enabled' (ie TLS
> handshake should be started on that queue) and 'the queue is tls 
> encrypted' (ie TLS handshake has completed on that queue).
> The former indeed can be derived from controller settings, and for the
> latter we use the 'tls_pskid' setting.
> Additionally it's the value for the tls_key sysfs attribute.
> I could have used a per-queue flag, but using the tls_pskid was just
> too easy here :-)

I think a flag would be clearer, because a per-queue pskid suggest that 
it is
unique per queue while you concur that it isn't.

