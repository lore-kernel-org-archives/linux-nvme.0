Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45D84C433EF
	for <linux-nvme@archiver.kernel.org>; Thu,  7 Jul 2022 07:15:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=uMBR/1n6+7of4pvpSPD8Cp/0RPv7bL/BlObOQsHmsEI=; b=rZ3mDGhCjp2aG25wW6h9ZUWiDS
	yGKsqlDkN6bKFduZCp02+x6vWbnYhe8vT19Iiebh7LNYeyhb7vG0KxtMQZk86vPNDEn/aInzNUbzE
	ibrEh42yfc+hhVsnWJPnLsPAUK3KDXGzSWoKf07WVZFylP9dRW1kAJQa5bITt/BH31LKYxn4Kql88
	BEB6i5DPFJTXKCtmJ/fMdbbUZfblRAx6oDm8javvC/TP+nLyiufprmvj6vTpLeUyObF3U19+T6Uc5
	CRHZ+M+wTZ8zv7fZRm4u4Re+a7HTiCfj6138XZ8G9GsFn/qJDWqwSt/SCmHIDKAhQJlJlDvqGr/Ec
	lXOY9Ecg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o9Lin-00ETHO-IX; Thu, 07 Jul 2022 07:14:45 +0000
Received: from mail-wm1-f44.google.com ([209.85.128.44])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o9Lih-00ETFv-OJ
	for linux-nvme@lists.infradead.org; Thu, 07 Jul 2022 07:14:41 +0000
Received: by mail-wm1-f44.google.com with SMTP id i128-20020a1c3b86000000b003a2ce31b4f8so522065wma.1
        for <linux-nvme@lists.infradead.org>; Thu, 07 Jul 2022 00:14:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=uMBR/1n6+7of4pvpSPD8Cp/0RPv7bL/BlObOQsHmsEI=;
        b=7vSXIyI/ukEqxaaZHhFb0tPwX6s9Qt7S+20GDGFplIkKYHOXh0+m5n+9YpCLLeu94K
         s6qUquR7MGgeNwKxgmJGSsuJCAxQbHzRgRLbjrv+dWCk6XfVq0bqzMvaiqbzdmpsObgN
         lc7WGj7f6BwPRsfZGyu+WC0ERB3VJpJJ0cBUvXG/QudSrIVU932U1vEXkuQs6patESPz
         kXXaLfM1PNCS3xaLkTsX54LuH16JgBH9cRMmHwiROlVMSsUPDPSayhTKGkDU6FpKduqU
         D9uh5S5VhiNYfxXlur0Ybx30/ARXn4OLWIZBVZ0Icyp/85WA0DEmpWN4fgLoJdic2xFy
         3lUg==
X-Gm-Message-State: AJIora9Ww8wx1Ymco2vayyiEgS0wCOpXQPvlUOYc4PaFk+OgeItZDFvj
	Lq8x2krcbbiY+bMXra1uZ1Y=
X-Google-Smtp-Source: AGRyM1usabzygiv7LiyPnpsYZWxJLt+AXDMhWFqoA6X2CP5mbcEsRcu/+KoXRpBruz8QpzUatL7szA==
X-Received: by 2002:a05:600c:1d25:b0:3a0:4cc8:f644 with SMTP id l37-20020a05600c1d2500b003a04cc8f644mr2713885wms.121.1657178077891;
        Thu, 07 Jul 2022 00:14:37 -0700 (PDT)
Received: from [10.100.102.14] (46-117-125-14.bb.netvision.net.il. [46.117.125.14])
        by smtp.gmail.com with ESMTPSA id m16-20020adfe950000000b0021d70a871cbsm6880532wrn.32.2022.07.07.00.14.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Jul 2022 00:14:37 -0700 (PDT)
Message-ID: <4c43f94f-f300-616b-0b82-f47a5ed1a565@grimberg.me>
Date: Thu, 7 Jul 2022 10:14:36 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] nvme-rdma: Remove timeout for getting RDMA-CM established
 event
Content-Language: en-US
To: Israel Rukshin <israelr@nvidia.com>,
 Linux-nvme <linux-nvme@lists.infradead.org>, Christoph Hellwig <hch@lst.de>
Cc: Nitzan Carmi <nitzanc@nvidia.com>, Max Gurtovoy <mgurtovoy@nvidia.com>
References: <1652627080-42045-1-git-send-email-israelr@nvidia.com>
 <65ee2faf-b916-8905-cde5-c31b84b9350c@grimberg.me>
 <55da512f-03af-aa15-3e5a-754cebbde4d6@nvidia.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <55da512f-03af-aa15-3e5a-754cebbde4d6@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220707_001439_839176_2FDCF4A6 
X-CRM114-Status: GOOD (  20.95  )
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


> Hi Sagi
> 
> On 5/17/2022 1:11 PM, Sagi Grimberg wrote:
>>
>>> In case many controllers start error recovery at the same time (i.e.,
>>> when port is down and up), they may never succeed to reconnect again.
>>> This is because the target can't handle all the connect requests at
>>> three seconds (the arbitrary value set today). Even if some of the
>>> connections are established, when a single queue fails to connect,
>>> all the controller's queues are destroyed as well. So, on the
>>> following reconnection attempts the number of connect requests may
>>> remain the same. To fix this, remove the timeout and wait for RDMA-CM
>>> event to abort/complete the connect request. RDMA-CM sends unreachable
>>> event when a timeout of ~90 seconds is expired. This approach is used
>>> at other RDMA-CM users like SRP and iSER at blocking mode.

If we are aligning to srp/iser, we can also align to their cm timeout
as well (1s). Given that it is not the full connection establishment.

>>
>> So with this connecting to an unreachable controller will take 90
>> seconds?
> The answer is yes.
> An unreachable controller is only when adders/route resolve passed 
> successfully, so bad IP will fail immediately.
> When running nvme connect, the user can press (Ctrl + C) to fail the 
> connection immediately. On error recovery
> it is not possible to fail it by pressing (Ctrl + C), but it doesn't 
> block others.
> I ran "nvme connect" with and without this patch and you can see the 
> results at the table below:
> Test
>      With Patch
>      Without patch
> Target is busy with other connections/disconnections     succeed     
> Fail after 3 seconds
> Kill target after successful resolve address and boot after 30 seconds 
> Get reject when target machine is up (30 seconds)     Fail after 3 seconds
> Kill target after successful resolve address and boot after 120 seconds 
> Get unreachable event after ~90 seconds     Fail after 3 seconds
> Port down after successful resolve address and up after 30 seconds 
> succeed     Fail after 3 seconds
> Port down after successful resolve address and up after 120 seconds     
> Get unreachable event after ~90 seconds     Fail after 3 seconds
> At error recovery, one reconnect attempt time is     Up to 90 seconds 
> per controller.     Up to 3 seconds per controller
> Error recovery with many connections     succeed     Never
> 
> Israel
> 


I think its a bit problematic that a (re)connect may take 90 seconds
just to fail, that will block the reconnect_work thread for 90+ seconds...

But I guess its fine for now, and it happens with other transports for
years and was never a concern, so I guess I'm fine with it:

Acked-by: Sagi Grimberg <sagi@grimberg.me>

