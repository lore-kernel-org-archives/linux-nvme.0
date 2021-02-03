Return-Path: <SRS0=tyWw=HF=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29438C433E6
	for <linux-nvme@archiver.kernel.org>; Wed,  3 Feb 2021 10:21:23 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B142F64DE7
	for <linux-nvme@archiver.kernel.org>; Wed,  3 Feb 2021 10:21:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B142F64DE7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=WYBHj+ziXPvD4FDKFWkT2e+yFsJRBXpxtcbUGRKw/QA=; b=W9xHZk4v70suwcJcPb1LKaYou
	2ncefg+uirVjjeWfbI/lomxlW2Yp/rXTfQN8S7vd04mSeEKVK03rkVeLGgHS7rpCA9HhmfwoiS6tc
	GfyJTShg4QJ0JIu/mZrnWXRDZKAMVCFnLS6d6WCpCJjBhp4EDx+TPUPRO78wdsWnK6k/QqtBApRPZ
	wjaNAjLqXio+Lsc9sr+/yDemElq+uHLfRwY+6nOli8MamF+bk75QENJoXseT0/WuN0qmIrA5bRKZc
	t9FMwWaPC0lKzBuA3UvTp0OF2xagFMJCNAZhHK5YCWxarCxX0vTF4ym1Rl18LCBum4uGonS3pd3eh
	K+5MHeMuQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l7FHd-0002Ki-6L; Wed, 03 Feb 2021 10:21:13 +0000
Received: from mail-wr1-f50.google.com ([209.85.221.50])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l7FHZ-0002K2-Ne
 for linux-nvme@lists.infradead.org; Wed, 03 Feb 2021 10:21:11 +0000
Received: by mail-wr1-f50.google.com with SMTP id m13so23528182wro.12
 for <linux-nvme@lists.infradead.org>; Wed, 03 Feb 2021 02:21:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=dcAFChpuSmTlzebnnafCrrA6mJXj3u07ZSxpvEJDfBw=;
 b=gmf+UIp7HngwEmExbOcEcw4RTpt5a/UwGrxZ3I01ntwmTf1mZZXF3ohkkPsexaqHz3
 pCoxacfklAqEMJV9W9DlGtjSy186pnRYp0OPHmxhJV6TIA6CoWB75Um+7I2KhAi7O/sd
 4pAGnWqUHAT4jZ9eKYkp0mU2/Ol0QPBeCuldJDJSeRif0352Yn1zmsKlj8pbDl8H8Qlw
 8zHuazb9dMcP1VqikpoIJn083/dqpIgCwg98mVscjIVd7bgB20rokHAeKg5U3iQOx/ja
 PzqOEjMvzkUvhaxFzuo53q2h20x/Kds3/I3+f2IVJroCxT71wXp63GFDIWy1964BHA2X
 IIQQ==
X-Gm-Message-State: AOAM5312cW21zLV66rtp4/j6F2Z0rafxGCXPraob+kTpC0dHPg/a2C0E
 uo8Fopomz69PvO2dcpvuz9Y=
X-Google-Smtp-Source: ABdhPJwRbTrOG1hx01WoAIg58wIOBVjWZTMw68z7t1C36+if2Bp9OVKLC9/MfDKWlPqlyqHRKZFGcw==
X-Received: by 2002:a5d:6712:: with SMTP id o18mr2564033wru.375.1612347668578; 
 Wed, 03 Feb 2021 02:21:08 -0800 (PST)
Received: from ?IPv6:2601:647:4802:9070:819b:e1e8:19a6:9008?
 ([2601:647:4802:9070:819b:e1e8:19a6:9008])
 by smtp.gmail.com with ESMTPSA id s4sm2276859wme.38.2021.02.03.02.21.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 03 Feb 2021 02:21:08 -0800 (PST)
Subject: Re: [PATCH v3 net-next 07/21] nvme-tcp: Add DDP data-path
To: Christoph Hellwig <hch@lst.de>
References: <20210201100509.27351-1-borisp@mellanox.com>
 <20210201100509.27351-8-borisp@mellanox.com> <20210201173744.GC12960@lst.de>
 <CAJ3xEMhninJE5zw7=QFL4gBVkH=1tAmQHyq7tKMqcSJ_KkDsWQ@mail.gmail.com>
 <80074375-2d37-d9b9-afbe-1f3d1db4a41f@grimberg.me>
 <20210203100234.GA9050@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <12247db9-5847-b791-c9e2-ce9993abc4d4@grimberg.me>
Date: Wed, 3 Feb 2021 02:21:01 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210203100234.GA9050@lst.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210203_052109_814474_05E5B3C6 
X-CRM114-Status: GOOD (  18.79  )
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
Cc: smalin@marvell.com, David Ahern <dsahern@gmail.com>,
 Boris Pismenny <borisp@mellanox.com>, yorayz@nvidia.com,
 boris.pismenny@gmail.com, Ben Ben-Ishay <benishay@mellanox.com>,
 Yoray Zack <yorayz@mellanox.com>, linux-nvme@lists.infradead.org,
 David Miller <davem@davemloft.net>, axboe@fb.com,
 Eric Dumazet <edumazet@google.com>, Alexander Viro <viro@zeniv.linux.org.uk>,
 Linux Netdev List <netdev@vger.kernel.org>, Keith Busch <kbusch@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Or Gerlitz <ogerlitz@mellanox.com>,
 benishay@nvidia.com, Saeed Mahameed <saeedm@nvidia.com>,
 Or Gerlitz <gerlitz.or@gmail.com>, Or Gerlitz <ogerlitz@nvidia.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


>>>> Given how much ddp code there is can you split it into a separate file?
>>>
>>> mmm, do we need to check the preferences or get to a consensus among
>>> the maintainers for that one?
>>
>> Not sure if moving it would be better here. Given that the ddp code is
>> working directly on nvme-tcp structs we'll need a new shared header
>> file..
>>
>> Its possible to do, but I'm not sure the end result will be better..
> 
> In the end its your code base.  But I hate having all this offload
> cruft all over the place.

I know, I think that the folks did a solid job consolidating it
given the complexity. But looking at the code again, it is sprinkled
more than I'd like it to be. I think it can be better with a little
more work.

If we can get to a point where we have all the specific logic
moved to dedicated routines and just a few interceptions on
the main flows we should be ok.

> Just saying no to offloads might be an even better position, though.

:)

I've heard complaints about nvme-tcp taking more cpu cycles than
nvme-rdma (well duh..) so I'm not opposed to having mainstream devices
offering offload capabilities to help out with that, not at all.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
