Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1EF7C433F5
	for <linux-nvme@archiver.kernel.org>; Mon,  3 Oct 2022 09:32:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:References:Cc:To:From:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=iuAFOrGO0x1a74yJsh51r5/pnODrj5Z9lxoSgcX0Www=; b=las3KCEIsIbxJtD/wGjDQR9Cml
	PU0UUOWp3ytC3tbjdjx2nhBaBb1lvsM5MblZfgVkA9UII6r8R6q5tBgXn9fRVYfLpNXfopHcdERwI
	fAsAXNjz4VEo66r3DzFkEMrvM67l1e7BHq3BdEq+py7vgTHhnPJsVzxaOE5sv5VOnq1J4hPmIWt4J
	EDZhbELxUYPSg2TXOFObRGxFIDhvjmupfH2TQqGYT7dHrJx5x8vOwD+u4HUbDRyonmsIeTD7GizSh
	TCGjxifwY2CMY7br/cSmKlbG+afr6lfMz8mriXaY2SI1ItrkNX9ffM7jO24+3e3pkF2YPOLw7z649
	HJPxydXg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ofHoZ-0053si-0m; Mon, 03 Oct 2022 09:32:43 +0000
Received: from mail-wr1-f51.google.com ([209.85.221.51])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ofHoW-0053qN-El
	for linux-nvme@lists.infradead.org; Mon, 03 Oct 2022 09:32:41 +0000
Received: by mail-wr1-f51.google.com with SMTP id bk15so15792374wrb.13
        for <linux-nvme@lists.infradead.org>; Mon, 03 Oct 2022 02:32:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=iuAFOrGO0x1a74yJsh51r5/pnODrj5Z9lxoSgcX0Www=;
        b=vNphH5w2pDqMofJTegpfE04lKSJcRnnpGE748bpZJ/m+hvEqbtKoeXSxyVDeboQxjX
         0mb1SVqXvc+RkR9HQ2x4FpTPtjVuECv3YPcumJk4PoFPMuF1Bu4D3lrUwt/RdiUmzIsQ
         UI63mdYscg0vRs71JbsBcZSmP0EjZrpz1xtse/NxJNL0noB/cKRHly1rzMRxgC0V8pwT
         URoHytdP8BGTrLp12v4P/Xz3YcmANW9jknFo9mXMyN5+ETcWA3LpdLxG3JMXnvBA0CRQ
         P1XXEnFjx9Zc+r13In941yOlF+UNusT8+aAopRsMOaxIrM2KdlJXIhSyc8cxtqB3YQut
         vtBg==
X-Gm-Message-State: ACrzQf3P6RmOMYWDtisimelW6zeiuqTDwqJdsAM7bQd4vA7SB3ZnXcef
	mtpWXXrtOuXZ153zPTsIzK4=
X-Google-Smtp-Source: AMsMyM4tbT7tRLGC/xMWM7isBXOpX9K3M1K9MYMrL0fahfaOfjd+IKul0xAFAxxmyGyu2crmfkXawg==
X-Received: by 2002:a5d:62d2:0:b0:22e:4a7:1ab6 with SMTP id o18-20020a5d62d2000000b0022e04a71ab6mr7751475wrv.334.1664789556529;
        Mon, 03 Oct 2022 02:32:36 -0700 (PDT)
Received: from [192.168.64.53] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id m7-20020a05600c3b0700b003a1980d55c4sm17154501wms.47.2022.10.03.02.32.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Oct 2022 02:32:35 -0700 (PDT)
Message-ID: <60a07961-0311-3c11-26b4-efa8da43d9d7@grimberg.me>
Date: Mon, 3 Oct 2022 12:32:34 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH rfc] nvme: support io stats on the mpath device
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
To: Keith Busch <kbusch@kernel.org>
Cc: Max Gurtovoy <mgurtovoy@nvidia.com>, linux-nvme@lists.infradead.org,
 Christoph Hellwig <hch@lst.de>,
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
 linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
 Hannes Reinecke <hare@suse.de>
References: <20220928195510.165062-1-sagi@grimberg.me>
 <20220928195510.165062-2-sagi@grimberg.me>
 <760a7129-945c-35fa-6bd6-aa315d717bc5@nvidia.com>
 <a3d619a3-ccae-69ea-3e2c-9acff7b97d92@grimberg.me>
 <YzWzvOKgoAqltAA0@kbusch-mbp.dhcp.thefacebook.com>
 <e5299b5e-5e9a-5a2a-b7dc-30de2bf43adc@grimberg.me>
 <YzcINzNpZ+4zkupd@kbusch-mbp.dhcp.thefacebook.com>
 <cef09c04-17d6-c588-be9f-b33e36dfce1a@grimberg.me>
In-Reply-To: <cef09c04-17d6-c588-be9f-b33e36dfce1a@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221003_023240_526078_4E478190 
X-CRM114-Status: GOOD (  13.50  )
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



On 10/3/22 11:02, Sagi Grimberg wrote:
> 
>>>>>> 3. Do you have some performance numbers (we're touching the fast path
>>>>>> here) ?
>>>>>
>>>>> This is pretty light-weight, accounting is per-cpu and only wrapped by
>>>>> preemption disable. This is a very small price to pay for what we 
>>>>> gain.
>>>>
>>>> It does add up, though, and some environments disable stats to skip the
>>>> overhead. At a minimum, you need to add a check for 
>>>> blk_queue_io_stat() before
>>>> assuming you need to account for stats.
>>>
>>> But QUEUE_FLAG_IO_STAT is set by nvme-mpath itself?
>>> You mean disable IO stats in runtime?
>>
>> Yes, the user can disable it at any time. That actually makes things a 
>> bit
>> tricky since it can be enabled at the start of an IO and disabled by 
>> the time
>> it completes.
> 
> That is what blk_do_io_stat is for, we can definitely export that.

Actually, blk_do_io_stat refers to the bottom request queue. you're
right, we can do the same trick for nvme.

