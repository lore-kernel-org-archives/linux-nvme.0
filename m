Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D035AC61DA4
	for <linux-nvme@archiver.kernel.org>; Tue, 14 Feb 2023 10:01:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1+4q5IkASDXEOzqDRgEB04f5mJrlc9Cp/e1e4SAOKD0=; b=SZs3hukUgczkxfngKhrJl0CxAC
	lX37OecW8lsuo28/gih89yn6dCzIE8O6NuzunGev2D3WZvoN3yM3TgVuJEGc8NoetECNPXRyaDmTM
	aEl7cVoy3S+q0vQJRWY/66qe4Y4lTfQDs05e3OLg3ZUh0Oq8bEw0CbLCmWMsHJxv+xOAM8969ZgRs
	do8H9mXHBdGvsDwL5gPWr9Ol7gqBgqxt3B4KwKrpQea+B4dh6SdJlLFNhCHHH77RXJBXb3UMsZs8y
	w10n5rp6loX7iDPB/9ntvIQmydWfeSiu+YFWeNnb49CT+iE9MUjtPsj7hfJguJraQLo7swd/A19uc
	rdQ0fszA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pRs7q-000rVY-Cf; Tue, 14 Feb 2023 10:01:26 +0000
Received: from mail-wr1-f53.google.com ([209.85.221.53])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pRs7n-000rSD-Dg
	for linux-nvme@lists.infradead.org; Tue, 14 Feb 2023 10:01:24 +0000
Received: by mail-wr1-f53.google.com with SMTP id o15so11708495wrc.9
        for <linux-nvme@lists.infradead.org>; Tue, 14 Feb 2023 02:01:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1+4q5IkASDXEOzqDRgEB04f5mJrlc9Cp/e1e4SAOKD0=;
        b=JJpg8u1oC2Sf0sstYAw1aI2cXC7s7bujhUBmxrzrTsw9M18OVUZCoSL/Pq8ZCXR7sc
         ra2H6YpWx3TZrkKgNy0uN+rLESgl4b0rvi+0MeOcSkMTjAC67OfJFayPOUEAlK8SZFxN
         6djNh2YaXzqYrkskm0PAjSDEb5YBusLJT5nsrSb/qHylJOys2jHrtGiAf6Dx2Km9r+7k
         f/X2W0wPzwvOf50fsbdW7Oml7uZsi5egavw5kQ5bJ3IglDgVLlfVDP8GcjkYAqz5322y
         n5dui1JkPIfdca9VK1DFY0BlRqlmMqMlgD1A7s1wn4eTJHDDndJKKrzcDemkiS/8CxjE
         vaxw==
X-Gm-Message-State: AO0yUKUxisQBp3oqBwFXCq2tTs1gIs7L2ACnbG8Vdmeoyvjl8gk6JGh5
	f1W6uWxQTxb1ARUZlkN9Jso=
X-Google-Smtp-Source: AK7set/Xt318zL6GpRHvNDie0q0HDZBwJM0D3FvTdggCnwo+e1rq7L2KeAk+JzfimJ/dU2UHVJJwgA==
X-Received: by 2002:a5d:6045:0:b0:2c5:60e2:ed68 with SMTP id j5-20020a5d6045000000b002c560e2ed68mr1150417wrt.0.1676368878424;
        Tue, 14 Feb 2023 02:01:18 -0800 (PST)
Received: from [192.168.64.80] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id x8-20020adfdd88000000b002c5691f13eesm634637wrl.50.2023.02.14.02.01.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Feb 2023 02:01:17 -0800 (PST)
Message-ID: <c3c636b4-b46b-ddab-6446-bc55349a96e3@grimberg.me>
Date: Tue, 14 Feb 2023 12:01:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH rdma-next 00/13] Add RDMA inline crypto support
Content-Language: en-US
To: Max Gurtovoy <mgurtovoy@nvidia.com>, Christoph Hellwig <hch@lst.de>
Cc: Leon Romanovsky <leon@kernel.org>, Jason Gunthorpe <jgg@nvidia.com>,
 Bryan Tan <bryantan@vmware.com>, Eric Dumazet <edumazet@google.com>,
 Israel Rukshin <israelr@nvidia.com>, Jakub Kicinski <kuba@kernel.org>,
 Jens Axboe <axboe@fb.com>, Keith Busch <kbusch@kernel.org>,
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-rdma@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 Masami Hiramatsu <mhiramat@kernel.org>, netdev@vger.kernel.org,
 Paolo Abeni <pabeni@redhat.com>, Saeed Mahameed <saeedm@nvidia.com>,
 Selvin Xavier <selvin.xavier@broadcom.com>,
 Steven Rostedt <rostedt@goodmis.org>, Vishnu Dasa <vdasa@vmware.com>,
 Yishai Hadas <yishaih@nvidia.com>
References: <cover.1673873422.git.leon@kernel.org>
 <20230118073654.GC27048@lst.de>
 <ac48766a-b861-4fc0-3171-7b23f175c672@nvidia.com>
 <20230130123505.GA19948@lst.de>
 <e8c35d5d-d855-a38c-2f3b-6887df208360@nvidia.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <e8c35d5d-d855-a38c-2f3b-6887df208360@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230214_020123_488609_CFE5497C 
X-CRM114-Status: GOOD (  13.42  )
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


>>> Today, if one would like to run both features using a capable device 
>>> then
>>> the PI will be offloaded (no SW fallback) and the Encryption will be 
>>> using
>>> SW fallback.
>> It's not just running both - it's offering both as currently registering
>> these fatures is mutally incompatible.
> 
> For sure we would like to offer both, but as mentioned before, this will 
> require blk layer instrumentation and ib_core instrumentation to some 
> pipeline_mr or something like that.

Can you explain what is needed in the block layer that prevents queueing
a request that has PI and crypto ctx?

As for the rdma portion, I don't know enough if this is something
that is supported by the HW and lacks a SW interface, or inherently
unsupported in HW...

