Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86887C433F5
	for <linux-nvme@archiver.kernel.org>; Mon,  3 Oct 2022 08:02:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hVBNQ5c/KIbk2+4B3+qMf2aC9Bjz6M4lskTK/SNnjPA=; b=WBM/l2z4kXqTi2YzicPqGJxqQa
	nKcYGyRbHApT7uGfPVekL7eSywLlfODHoCjOKn4Ro9IUnVdrMjJRuczu397KNqm9L6toQOipb+K0B
	LfTrsYiDUTmvIuEAIJRYLX9qKez59fRWtuTiFcPpPfj2YcayTN+UyGZHSEXZPYDw4uZmrV1p5rIpj
	ouCWPtZMdB0OhJqW+yNs6LWtx5VFsl/1oZ5sULRZQOREmttD0vGztMXs0TpnW4Qp/YK/U3623H+T2
	ELajaCuh+wwO+btNpQjpOpKpgEYEA2Lzv9h8DFxNoJI4K4FiUxbbHvA3v+ZdihFTvvztROotAv9kU
	5aLVJ7kQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ofGPN-004ZFS-Tr; Mon, 03 Oct 2022 08:02:37 +0000
Received: from mail-wr1-f51.google.com ([209.85.221.51])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ofGPL-004ZE7-Fy
	for linux-nvme@lists.infradead.org; Mon, 03 Oct 2022 08:02:37 +0000
Received: by mail-wr1-f51.google.com with SMTP id f11so12809165wrm.6
        for <linux-nvme@lists.infradead.org>; Mon, 03 Oct 2022 01:02:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=hVBNQ5c/KIbk2+4B3+qMf2aC9Bjz6M4lskTK/SNnjPA=;
        b=Cs2URdOmyGdFk9wfjEqqXinUEUcFeHx271OljrPR67XK64yz/jEowMI/PZgi98cp5d
         JxMY56nVkh1nD7Rr4/DsbWA3nMXUM9MH5PJOrZOqVTMc5RnoKIU7ij7702/YGhoDVZln
         Y9qPQ36q8ejZIQpc8z2mm+cn5ee/k5PCmPxAyjlbKY7QPCPFArYKOKJnXsxfPValX3cl
         6pOyJ4Uv/pSRrnV2ss5hc8pAG8Iq9+cpQu3Vo/LqDXtdMUpjXPHkSHUm/NJzd2sYmCIb
         58pvKBrqNJdE1ftoEjWvVTYvfFSO8M9+PB8e7YwguUD4Wbydd+ik2Y6x/H9G8ttvQj7S
         Z13Q==
X-Gm-Message-State: ACrzQf3Yf4Aa9VRLYg3kjXu2KxiUFDDo7gm4NsJ8EDXxGdUbPN3LUQku
	CtmpiTObrZA6ftz399NID+k=
X-Google-Smtp-Source: AMsMyM6Xntuf0ZnDgCbmn571IIKvBlrQXrbOZepgknpJ4oagT39vJ+3j7uTee23pecwDYwg+s8CNVQ==
X-Received: by 2002:a5d:6b09:0:b0:225:37cf:fb8b with SMTP id v9-20020a5d6b09000000b0022537cffb8bmr12178760wrw.179.1664784152958;
        Mon, 03 Oct 2022 01:02:32 -0700 (PDT)
Received: from [192.168.64.53] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id d10-20020a5d6dca000000b0022917d58603sm9056820wrz.32.2022.10.03.01.02.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Oct 2022 01:02:32 -0700 (PDT)
Message-ID: <cef09c04-17d6-c588-be9f-b33e36dfce1a@grimberg.me>
Date: Mon, 3 Oct 2022 11:02:30 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH rfc] nvme: support io stats on the mpath device
Content-Language: en-US
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
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <YzcINzNpZ+4zkupd@kbusch-mbp.dhcp.thefacebook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221003_010235_558720_17B3B7E0 
X-CRM114-Status: GOOD (  12.32  )
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


>>>>> 3. Do you have some performance numbers (we're touching the fast path
>>>>> here) ?
>>>>
>>>> This is pretty light-weight, accounting is per-cpu and only wrapped by
>>>> preemption disable. This is a very small price to pay for what we gain.
>>>
>>> It does add up, though, and some environments disable stats to skip the
>>> overhead. At a minimum, you need to add a check for blk_queue_io_stat() before
>>> assuming you need to account for stats.
>>
>> But QUEUE_FLAG_IO_STAT is set by nvme-mpath itself?
>> You mean disable IO stats in runtime?
> 
> Yes, the user can disable it at any time. That actually makes things a bit
> tricky since it can be enabled at the start of an IO and disabled by the time
> it completes.

That is what blk_do_io_stat is for, we can definitely export that.

