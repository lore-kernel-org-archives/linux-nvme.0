Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12B11C2BD09
	for <linux-nvme@archiver.kernel.org>; Wed,  3 Jul 2024 15:16:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2cKjAPslfU+gEQANG94XNdxzYtcyencD9ccp99pmATc=; b=rD2e47q1GFEZ7s3F9VPcAZtDMQ
	1jLKwU+OuTu0fhr59lVHomfEbWre74oHX7iCnp0rynzyjQpQvhAvcQ0CPSj8dS7bZkOiYG9KGNvPB
	8jVflmtsL5xROIfE58Inyeh1e0F+ccBjz0xD0vWG06cipNzxxexoUsHh7dEpVvp65iNrixjRKRRev
	hdYSLKtQAU+40p/couwKeW80KeLc9Fnhzc06D+bjRd98WpJNIHSQWhuKYPXpokgx9Afk/ktIyv3Eo
	o7VGpL5stuZ3UNzUXkr8dEC2vbFUAvnMN+aBL7Hwc2bFzBM9Zt5q3m4/vqR2QKM/U19kBG63BIM6+
	8moD26wA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sP1iq-0000000AeZp-30bz;
	Wed, 03 Jul 2024 15:16:40 +0000
Received: from mail-wr1-f45.google.com ([209.85.221.45])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sP1in-0000000AeWw-0TO9
	for linux-nvme@lists.infradead.org;
	Wed, 03 Jul 2024 15:16:38 +0000
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3679911df2aso5796f8f.3
        for <linux-nvme@lists.infradead.org>; Wed, 03 Jul 2024 08:16:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720019794; x=1720624594;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2cKjAPslfU+gEQANG94XNdxzYtcyencD9ccp99pmATc=;
        b=cqrHCKp4T2a/NeZ6eYhnUudQQHGGqw72S1hRAG9xqpfZvoEyJ6eT7N9uPBh3AT8ZbC
         YrfdQTEZ6+dZ9DVf/VA7r0wIZesl4vLiDJBaUTDzRLRo81JVUiEIRTTYAqCd8EYzgdHM
         9qfDGeUWjR7ybjR+YoGVlTFf72AXNcS1l4emWWhBUmn09Htm/IBdM+rpzJ2lEfoswTXA
         coFokpx/26sd0W7/LZS6/0xEhz6drC70+6uYFy8+P62MbSRebym7E66VUUil23wgPKiT
         rwPzv9qLzg/k/L8OjPUyQQ+WIjHlbfkfR9MSEwy87fsHf8CIY7xfRcQ0Y4qFYPsq7haD
         lItA==
X-Forwarded-Encrypted: i=1; AJvYcCXNyeQATM/opaoHkKZpCy9V/Xo34wv7/byVVbdkQtHgC5fkYpowh7FkVmnJJKVNUOlSvI+VBw7PmS1yLU/++48YCo3JdaIRIYgjDgSKK6I=
X-Gm-Message-State: AOJu0YxpDbCnCyeIkhzlWlD5AewykA4IweffG9D4NyyXw9i2mClYwRzC
	qHD+G+NrQitw0bfjBArR/tN9S98EpzUd+RtBs2IDMgd3omw/Y5/y
X-Google-Smtp-Source: AGHT+IG0367+jHY7iWsuvpOqmT3Ya6A3ozmbNA4Zqw4sKEzepEjUqqjERxGFSL2IT/8J9906wiDTHQ==
X-Received: by 2002:a05:600c:4fd3:b0:425:6dfa:c005 with SMTP id 5b1f17b1804b1-4257a07799dmr80482425e9.2.1720019793806;
        Wed, 03 Jul 2024 08:16:33 -0700 (PDT)
Received: from [10.50.4.202] (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4256af5b8e2sm241466435e9.16.2024.07.03.08.16.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Jul 2024 08:16:33 -0700 (PDT)
Message-ID: <ad15b94b-9414-4ec1-9acf-465a8b190fe5@grimberg.me>
Date: Wed, 3 Jul 2024 18:16:32 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] nvme-tcp: per-controller I/O workqueues
To: Hannes Reinecke <hare@suse.de>, Hannes Reinecke <hare@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
 linux-nvme@lists.infradead.org, Tejun Heo <tj@kernel.org>
References: <20240703135021.34143-1-hare@kernel.org>
 <20240703135021.34143-2-hare@kernel.org>
 <7e4444d0-f156-439e-9363-4beb86bb6248@grimberg.me>
 <c9f73300-9860-4965-88af-9a7b4d7b0e1b@suse.de>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <c9f73300-9860-4965-88af-9a7b4d7b0e1b@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240703_081637_202888_6E06CF30 
X-CRM114-Status: GOOD (  14.62  )
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


>>
>>
>> On 03/07/2024 16:50, Hannes Reinecke wrote:
>>> Implement per-controller I/O workqueues to reduce workqueue contention
>>> during I/O.
>>
>> OK, wonder what is the cost here. Is it in ALL conditions better than 
>> a single workqueue?
>
> Well, clearly not on memory-limited systems; a workqueue per 
> controller takes up more memory that a single one. And it's 
> questionable whether
> such a system isn't underprovisioned for nvme anyway.
> We will see a higher scheduler interaction as the scheduler needs to 
> switch between workqueues, but that was kinda the idea. And I doubt one
> can measure it; the overhead between switching workqueues should be 
> pretty much identical to the overhead switching between workqueue items.
>
> I could do some measurements, but really I don't think it'll yield any
> surprising results.

I'm just not used to seeing drivers create non-global workqueues. I've 
seen some filesystems have workqueues per-super, but
it's not a common pattern around the kernel.

Tejun,
Is this a pattern that we should pursue? Do multiple symmetric 
workqueues really work better (faster, with less overhead) than
a single global workqueues?

