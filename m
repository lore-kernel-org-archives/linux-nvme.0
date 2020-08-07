Return-Path: <SRS0=rw3x=BR=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E48FDC433DF
	for <linux-nvme@archiver.kernel.org>; Fri,  7 Aug 2020 17:50:11 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC36722D2A
	for <linux-nvme@archiver.kernel.org>; Fri,  7 Aug 2020 17:50:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="2vHUyIe8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC36722D2A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=nvQRbdMtg+zgybVMHyQjduCtqyx67A42UpGHElQRVlo=; b=2vHUyIe8x/r+N9b/++isL/Ovf
	SI9UXhvjw8eTBaoPc5wZXAPgwaPXCsq2UxzXHiLXGRaxFCMVM4N0hRql7TipmVRoeux+y1WIThRV/
	gudySdng9womUGwPXgZ0AHiRxnTqRU+bq8ZgyY6IcSXa0g0lPjSnhXLd3g1v3TSCHsKWT+uPUC70m
	oFCmqQWDmdv2CSSjC2AJfUsuFD7w1LFM8i+u2WzF/j1rWPppRF5kUcZ6qXMg1xvc7300qo5zwPeGV
	qauDWL9TNx+MA/GCdvVOrwJpxh5SI4QhpG7dx5XuMMbwjjbXDu7kIhH2ltX9Kos9ljUMobvOk5Vhc
	wK0hlxhvQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k46VL-0004yk-SK; Fri, 07 Aug 2020 17:50:07 +0000
Received: from mail-pl1-f194.google.com ([209.85.214.194])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k46VJ-0004xo-9V
 for linux-nvme@lists.infradead.org; Fri, 07 Aug 2020 17:50:06 +0000
Received: by mail-pl1-f194.google.com with SMTP id f10so1402246plj.8
 for <linux-nvme@lists.infradead.org>; Fri, 07 Aug 2020 10:50:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=kPqLvSjBtNhosmOzfD57lqo68y3MNqQVLpj1nOFbUS8=;
 b=mWcIr1CVGTN1bzGNs9HJsidQIooKrdVarlvdtgJS1wHPlCM5xmCV5EVma/C3qiqW/r
 agaYvLFpuLJVrNzcAeVFBic3x674rOQQxCPsiWFYRW+dGEgb+iNVNjQXuK5beENUfpKv
 hjfGqvnX9Su3jqCbUxvOEzYro/xZthVjZYJoUZN32XMUCOyEAkvm7KT7qwXFH2+WbrgN
 LRpmgZIU8Koum0DABJcV9RMocCLTQYBtS10t68aEguVoMS9Octgg55meWnhDTymifiLd
 r0BA6ylyJVEe729wwVXZd/nKo7hv79uMMOEaiuaKlK7xApkMc/Gb0tQhwBHu0z50F32c
 j/YA==
X-Gm-Message-State: AOAM533IHr5yKuwfSLQYqThLKnbUVEH25IjaDAPMD3gZNUTqWB5ygtcB
 awMhPLqspSSwHQQZNibc+og=
X-Google-Smtp-Source: ABdhPJwBbORYb2EeSyn0noJyl5KOZ6p5KfLV51EINNVNgwEFOlBMDV6kycSszn2fWuFV38dpMMCvNQ==
X-Received: by 2002:a17:90a:1fca:: with SMTP id
 z10mr14355771pjz.209.1596822604289; 
 Fri, 07 Aug 2020 10:50:04 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:3dec:a6f0:8cde:ad1c?
 ([2601:647:4802:9070:3dec:a6f0:8cde:ad1c])
 by smtp.gmail.com with ESMTPSA id w15sm9382517pjk.13.2020.08.07.10.50.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 07 Aug 2020 10:50:03 -0700 (PDT)
Subject: Re: [PATCH v2 6/7] common/multipath-over-rdma: don't retry module
 unload
To: Bart Van Assche <bvanassche@acm.org>, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, Omar Sandoval <osandov@osandov.com>
References: <20200806191518.593880-1-sagi@grimberg.me>
 <20200806191518.593880-7-sagi@grimberg.me>
 <925e1ac6-38fa-6fe9-c0b7-7e665559a989@acm.org>
 <155cb916-062f-e23f-9790-35dee850687b@grimberg.me>
 <b3ab660e-fd36-36da-fdff-f7582baf47fc@acm.org>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <083db343-9809-559a-9fa3-cb54a1c23b82@grimberg.me>
Date: Fri, 7 Aug 2020 10:50:02 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <b3ab660e-fd36-36da-fdff-f7582baf47fc@acm.org>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200807_135005_389968_74C41B14 
X-CRM114-Status: GOOD (  18.23  )
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
Cc: Keith Busch <kbusch@kernel.org>,
 Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
 Christoph Hellwig <hch@lst.de>,
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


>>>> There is no need to retry module unload for rdma_rxe
>>>> and siw. This also creates a dependency on
>>>> tests/nvmeof/rc which prevents it from using in
>>>> other test subsystems.
>>>
>>> If it wouldn't be necessary to retry module unload I wouldn't have
>>> introduced a loop.
>>
>> I thought it was to work-around a driver issue as these drivers
>> traditionally had plenty of stability issues.
>>
>> To be honest this retry loop to me indicated that either the
>> driver has a bug or the test. But maybe there is a need I
>> am not seeing.
> 
> That loop was introduced a long time ago. I haven't tried to root-cause
> it but my guess is that the loop is necessary because the module refcount
> only drops to zero a short time after the first attempt to unload these
> kernel modules.

Didn't see any of that in the nvme testing...

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
