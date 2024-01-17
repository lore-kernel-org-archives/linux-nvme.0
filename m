Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D653FC47DA2
	for <linux-nvme@archiver.kernel.org>; Wed, 17 Jan 2024 14:16:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=uTjyhIfNKOIzZDL3R53ZyLUJvUHP8AzHTMPKLV0aqC4=; b=UoM8d9LMcgvXjX+fLPxXA8ctpb
	WBwmorXiSdHtvFwO+wzws1SRW6VDA2IJO9avKkBF5NPGNQrMx4tMfWtrnad3K0FsGkYPE1evl+NhP
	gK2aZcm03yl99IfZivjzuM6ACVKwURn+pSjAZNX9vXXy09NfjgWP9SpmeafrnoJY52kA+IP76am+O
	/tAycKUToDthBAn2M7RQoz1Bz3xe+ejmkbamSHwmtMq9E36wmwLq4NQGaWdGNA5jhI2BZNonXEaYT
	TqYKY3gmy/S99c8ao3Xz3TLTRs2CBJ7IzDwXtQyXW17EnharsW+n4wIkoJH78keVNTE2Wirfln7AH
	iemaQMMA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rQ6iC-00GzAA-2Z;
	Wed, 17 Jan 2024 14:16:12 +0000
Received: from mail-wr1-f44.google.com ([209.85.221.44])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rQ6i2-00Gyty-1K
	for linux-nvme@lists.infradead.org;
	Wed, 17 Jan 2024 14:16:10 +0000
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-33728f82a71so2370647f8f.1
        for <linux-nvme@lists.infradead.org>; Wed, 17 Jan 2024 06:15:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705500957; x=1706105757;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uTjyhIfNKOIzZDL3R53ZyLUJvUHP8AzHTMPKLV0aqC4=;
        b=Mrk8+7yyHBOTaaQJ7w+a32yTXoStNuMhJXGYzsv/kFu8rSeoRRNZQXFAt6seO4oWoB
         WlCiBPeE4ZN+Vx/4lWblJ8eMV94b+QZ0kjVDCOpedQePGDzK32P+f5JtuHUpT8KJLNZh
         tZHwJbKjQy+7aCD0LNcI/G83S1Nz1qre4t2i8aq//eKl5dXuo1wTlVXq7kSgHk4jjb+Y
         hSVixIxrUj053Jacyzl9doFHtdLmmlC4Z4vd7+0t/F3dSJ0H9Wli4CP01gbz9ekDRG47
         vyzL0NLFR9Y/7LMa2s1+8nWTfFWbKszSr2Ncx05W8xExqDlEkH7B8EcokXN46lhyN/LT
         yIdg==
X-Gm-Message-State: AOJu0YxrKNwWOJaKL5SkiTWFja78J8UzaG1LFhEayOi63IG/bxsR6EjH
	hPtJFw2P3weM0AKRwN0A4pc=
X-Google-Smtp-Source: AGHT+IFTyonW2nbHuSG92zem4mwib1KSa7A1dkGySlJexu+qsj6eAEwjb/jRyK2olDDa/V2kPLBXgA==
X-Received: by 2002:a5d:522b:0:b0:337:b74b:76ee with SMTP id i11-20020a5d522b000000b00337b74b76eemr3135624wra.7.1705500956952;
        Wed, 17 Jan 2024 06:15:56 -0800 (PST)
Received: from [192.168.64.172] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id cp32-20020a056000402000b00337c55d9a28sm836720wrb.93.2024.01.17.06.15.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jan 2024 06:15:56 -0800 (PST)
Message-ID: <3c4d77e9-922f-4cb4-b3d8-1c2c49fdcf4c@grimberg.me>
Date: Wed, 17 Jan 2024 16:15:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme_core: scan namespaces asynchronously
Content-Language: en-US
To: stuart hayes <stuart.w.hayes@gmail.com>,
 Max Gurtovoy <mgurtovoy@nvidia.com>, Keith Busch <kbusch@kernel.org>
Cc: linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
 Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org
References: <20240104163826.10561-1-stuart.w.hayes@gmail.com>
 <ZZbhKM0L8pFYX_zd@kbusch-mbp>
 <19075505-b1a6-48d3-9732-7277c4697cf6@nvidia.com>
 <6af7ec28-2114-47da-a5a6-b0b6357169eb@gmail.com>
 <54b5e83b-4b08-4c5e-afec-1c672561fa81@gmail.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <54b5e83b-4b08-4c5e-afec-1c672561fa81@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240117_061602_629172_6AD72736 
X-CRM114-Status: GOOD (  29.79  )
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



On 1/16/24 21:14, stuart hayes wrote:
> 
> 
> On 1/12/2024 1:36 PM, stuart hayes wrote:
>>
>>>
>>>
>>> On 04/01/2024 18:47, Keith Busch wrote:
>>>> On Thu, Jan 04, 2024 at 10:38:26AM -0600, Stuart Hayes wrote:
>>>>> Currently NVME namespaces are scanned serially, so it can take a 
>>>>> long time
>>>>> for all of a controller's namespaces to become available, 
>>>>> especially with a
>>>>> slower (fabrics) interface with large number (~1000) of namespaces.
>>>>>
>>>>> Use async function calls to make namespace scanning happen in 
>>>>> parallel,
>>>>> and add a (boolean) module parameter "async_ns_scan" to enable this.
>>>>
>>>> Hm, we're not doing a whole lot of blocking IO to bring up a namespace,
>>>> so I'm a little surprised it makes a noticable difference. How much 
>>>> time
>>>> improvement are you observing by parallelizing the scan? Is there a
>>>> tipping point in Number of Namespaces where inline scanning is better
>>>> than asynchronous? And if it is a meaningful gain, let's not introduce
>>>> another module parameter to disable it.
>>>
>>> I don't think it is a good idea since some of the namespace 
>>> characteristics must be validated during re-connection time for example.
>>> I actually prepared a patch that makes sure we sync the ns scanning 
>>> before kicking the ns blk queue to avoid that situations.
>>> for example, if for some reason ns1 change its uuid then we must 
>>> remove it and open a new bdev instead. We can't kick old request to 
>>> it...
>>>
>>
>>
>> Sorry for the delayed response--I thought I could get exact data on 
>> how long it takes with and
>> without the patch before I responded, it is taking a while (I'm having 
>> to rely on someone else
>> to do the testing).  I'll respond with the data as soon as I get 
>> it--hopefully it won't be too
>> much longer.  The time it takes to scan namespaces adds up when there 
>> are 1000 namespaces and
>> you have a fabrics controller on a network that isn't too fast.
>>
>> I don't expect there would be any reason to disable this.  I only put 
>> the module parameter to
>> disable it in case there was some unforeseen issue, but I can remove 
>> that.
>>
>> To Max Gurtovoy--this patch wouldn't change when or how namespaces are 
>> validated... it just
>> puts the actual scan work function on a workqueue so the scans can 
>> happen in parallel.  It will
>> do the same work to scan, at the same point, and it will wait for all 
>> the scanning to finish
>> before proceeding.  I don't understand how this patch would make the 
>> situation you mention any
>> worse.
>>
> 
> I have numbers for the namespace scan time improvement.  Below is the 
> amount of time it took for
> all of the namespaces to show up when connecting to a controller with 
> 1002 namespaces:
> 
> network latency   time without patch    time with patch
>    0                        6s                 1s
>   50                      210s                10s
> 100                      417s                18s


That is a big improvement. I wouldn't say that 1000+ namespaces
is a common requirement. But the improvement speaks for itself.

