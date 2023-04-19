Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD1C2C77B73
	for <linux-nvme@archiver.kernel.org>; Wed, 19 Apr 2023 10:46:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=V3x0k4rJnKaOmkvnCDjyE+jovLY1Kmv7i3ZtuK09oys=; b=0mzDNmB7trzbKz1VLADXpn0D4Y
	0dpDNNo7THbkquH17418jCS0KmJ7XGZNHuEupeMOaS1ShQKdrQQDgg6HYZhyBjoB39Uj9ttF2uYqu
	UNrVdM8BMGZcVkPTY3eVh9OtValeZK3MwQnoIsH8Exv6qCHC/m3ahKw+s3PODIFN7XPhv4Uk0R2ed
	clqvouTzJVY0Umkm/AjGuKkygKcmPwE+2YhFYYTD6/S3UjWs4pSYoEsyn1tkx/wuwIM+cGk00YR/r
	fcuZR86ICSLXQp0+09sqvPjnLr7htKTbHr4Q3GusePBxeGCbGnwbG+LCRzq2zJb9L5WWNk/8C10QP
	uM4Xz60g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pp5K1-00553l-1U;
	Wed, 19 Apr 2023 10:45:57 +0000
Received: from mail-wr1-f45.google.com ([209.85.221.45])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pp5Jx-00552K-0X
	for linux-nvme@lists.infradead.org;
	Wed, 19 Apr 2023 10:45:55 +0000
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-2f67111b2d0so747745f8f.0
        for <linux-nvme@lists.infradead.org>; Wed, 19 Apr 2023 03:45:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681901149; x=1684493149;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V3x0k4rJnKaOmkvnCDjyE+jovLY1Kmv7i3ZtuK09oys=;
        b=B5Su8KWrS3smGDUz8lFgKjRIdKiOEPIAmFFZXBeTserJ76UkWC5ftS3zAy7c4KrCTO
         Y1gFLWcfEcOkJxnRwocP2Bxi+9McLxzjlty7sdC+WdWNkOtCim08pDI6/H57EbWeHIAl
         U72aJM5xWDOWRwt5T5DrvXxwgQszySB0AW2UgMjSRuvODV/mmtypnVnOSykib21U/KEx
         eiG12Ndqs0KJG7YAekFtsJPVvRBtYXiEq1p6t1rmU8f/9RRATNsN7InGatyxyyYRSVNs
         KMwDrvyqZC8IsXLTff3LG7/sNh8P0TM7cUb7WBQU25IOZCh21y2AleveTnWjZLtHt/3o
         4c6A==
X-Gm-Message-State: AAQBX9eozIZB63JtFC5TR1E7ct2Y68T1niNTvvriMy15PNz9nhw4GLRh
	B/VlTcSjknPue2WgVxRQk4U=
X-Google-Smtp-Source: AKy350a455Yk+wWzCcfcpBQdd1niGJgBmD50m/H70Uo03NiG9EIf9Lo+fxiile8UcebRMBEQPqYUbg==
X-Received: by 2002:a5d:6352:0:b0:2f5:7487:7b3d with SMTP id b18-20020a5d6352000000b002f574877b3dmr10467874wrw.1.1681901148946;
        Wed, 19 Apr 2023 03:45:48 -0700 (PDT)
Received: from [192.168.64.192] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id q1-20020adfcd81000000b002ff77b033b1sm419188wrj.33.2023.04.19.03.45.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Apr 2023 03:45:48 -0700 (PDT)
Message-ID: <1b060988-fc63-4a86-33b8-88ba61c9358f@grimberg.me>
Date: Wed, 19 Apr 2023 13:45:47 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH blktests v2 2/2] nvme-rc: Cleanup fc resource before
 module unloading
Content-Language: en-US
To: Daniel Wagner <dwagner@suse.de>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-block@vger.kernel.org, Chaitanya Kulkarni <kch@nvidia.com>,
 Shin'ichiro Kawasaki <shinichiro@fastmail.com>
References: <20230419084757.24846-1-dwagner@suse.de>
 <20230419084757.24846-3-dwagner@suse.de>
 <3ec250a9-54c7-3e0d-2463-f8faf15cdb58@grimberg.me>
 <3euieyvxpsww5p4m457pzupfipbnbv3atxauh2lrp54gqmqcco@hs7ytoop5osf>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <3euieyvxpsww5p4m457pzupfipbnbv3atxauh2lrp54gqmqcco@hs7ytoop5osf>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230419_034553_201090_D857E733 
X-CRM114-Status: GOOD (  19.94  )
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


>>> Before we unload the module we should cleanup the fc resources first,
>>> basically reorder the shutdown sequence to be in reverse order of the
>>> setup path.
>>
>> If this triggers a bug, then I think it is a good idea to have a
>> dedicated test that reproduces it if we are changing the default
>> behavior.
> 
> Right, though I would like to tackle one problem after the other, first get fc
> working with the 'correct' order.
> 
>>> While at it also update the rdma stop_soft_rdma before the module
>>> unloading for the same reasoning.
>>
>> Why? it creates the wrong reverse ordering.
>>
>> 1. setup soft-rdma
>> 2. setup nvme-rdma
>>
>> 2. teardown nvme-rdma
>> 1. teardown soft-rdma
>>
>> I don't think we need this change. I mean it is a good test
>> to have that the rdma device goes away underneath nvme-rdma
>> but it is good for a dedicated test.
> 
> I was woried about this setup sequence here:
> 
> 	modprobe -q nvme-"${nvme_trtype}"
> 	if [[ "${nvme_trtype}" == "rdma" ]]; then
> 		start_soft_rdma
> 
> The module is loaded before start_soft_rdma is started, thus I thought we should
> do the reverse, first call stop_soft_rdma and the unload the module.

They should be unrelated. the safe route is to first remove the uld and
then the device.

