Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA3F9CD5BC8
	for <linux-nvme@archiver.kernel.org>; Tue, 26 May 2026 21:51:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=RA7cD0bS7vuj5BqYOqhUb3Pso3HctOE2AcDFDnLY8ug=; b=0XeKckip24CvFS4JkY93amsQsG
	WcWA5GkekhiSPC9M8ItINQCjbWyFiZlnFfavrHgdTY3p82t+Wiy7H3ZDN+SMHgV+PKjOWxlYxBt7w
	/AY8lleYjqzzF7mEP+162PaQhp9wwq2w3nOkL4H3u6dpJUBSDIUwRP3WPZdjTvyNf9gGQxa9Vj/mL
	18TddmTE+JYQBTyBtcWYo/tqK3NDKeJvLSaC8jG9JauD0mpwMpktz7/o9yrPCo2Kcjsx325VXZgt0
	TPD8YA5KNBLY3R3I3eBfWf6Yh3qjsvyVyxtSfDN/e5d0wz5bNb/XkDXEqT/bV+wxJjyK/5abPSq43
	UArwzGWg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wRzgi-00000002zvQ-2cXO;
	Tue, 26 May 2026 21:51:48 +0000
Received: from mail-oo1-xc2a.google.com ([2607:f8b0:4864:20::c2a])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wRzgc-00000002zv5-1MDJ
	for linux-nvme@lists.infradead.org;
	Tue, 26 May 2026 21:51:43 +0000
Received: by mail-oo1-xc2a.google.com with SMTP id 006d021491bc7-69d7cdd3b8eso1798247eaf.2
        for <linux-nvme@lists.infradead.org>; Tue, 26 May 2026 14:51:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1779832301; x=1780437101; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RA7cD0bS7vuj5BqYOqhUb3Pso3HctOE2AcDFDnLY8ug=;
        b=GXllYjXLs82JlhXHo0qr+6ri+K20As0emMWkVCyc8fTc46jzCCTwYfDRvvgnJq/323
         FzrzqinbMcgC+x3M/3uGqTMBGUhIvH8nfpaOJMfsfZ3y1p5rnzH6L/GAs2jJrSDw+cs1
         Kz6gITcgasrjcGs9tn0s9GUTa9rN2Ox1e3qNoQbLQcG7Xovm6GWx4Shhv1SCe/dna5fh
         xM7D18BFbFwO46WRbVkWOJ23jZ3tbwmWSOniyYaHPvRN/dDv6O6jB6h/XkcoPu2YCp3M
         3rXS8ypvPMKu+BQN9vUOlKk47G6D2lMo/LgYsSpNBXYbBAEI3uLRR24IeG37yTkbgsdh
         IL8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779832301; x=1780437101;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RA7cD0bS7vuj5BqYOqhUb3Pso3HctOE2AcDFDnLY8ug=;
        b=bLskbhDKBtBA57iMOIXqWqxylkwANqWB8VoQFzi9XA++cGWf/K/UFVGo2nXjRV02iu
         OC4pdLXXif3Z2gpRrVjoKDk4NnSiwGhw3/l4bMCxQdxdBA+t90LYklA2Zqo0GlGAF2qN
         QxFhawKtC6nEfZfupl55acQyu2VXaaMQ46DraUY1KQa7Jrw+0lda4KvUOp1p+CLjqBs4
         VrI4oNHB23bEd0W32bra26ySAjD38u918u4TuwYXq+xec8pIfb9cnn2BgUcowMTU30dL
         g9Xlv4HQYNyr4nE0UsYGL1VznVNQQ8DlpSxoQLRGPLCSX9LrBq3GmCE7aRgY/6cWlLu8
         zUMw==
X-Forwarded-Encrypted: i=1; AFNElJ+8UMHqZtCtsDuJ6PHByHnalWDH/nyJRPMrtVwyFrBZSEF3KL9hdTrc7zxcWn8Zbjb0gvPGHxRS9UyZ@lists.infradead.org
X-Gm-Message-State: AOJu0YwRoRExnXePCnb0Oz3J4hk1BdjNbZLzuopna0FnVBVcqSyQiheg
	Ps3ZAG/DPEp1lGRrf8aq/iYZoMHWob6tZ+rGGjtajBEB2R1V8rq74mP3rGC5eW/Jh+M=
X-Gm-Gg: Acq92OG+nBNseswQWD/HYoJpmkmXgzZBhlrNQhxgRH1YJZzcsKp73z2C0N7G/ktE1QT
	VPMVjyBDYR3Qtc3vH1LFHS6zEMwQeYULKiBrMV3eBOoJP7LiAhsB/uIUdDjCgAPcGPCu3vQsw9A
	gNQ0r0FV8X8TA6NyfMoue3yazB+BMuhj2HFt1c2wU1k6Kd15q1Ogo8pfHw8TNXxoXvZdE4wO2r4
	LFV6JJlnMypfsvyvsWf6h8R1yCcvYmseBeMITSkZgmb+KmLRLpl2Xan2rSAtoDQ/tLGU80AVuop
	QXZj/nAnSODRk3gSujstMWb5EiXEptxZaCK0GMyGsz+kuTi5UiT8tej+FQq1RfqgbH0PQtjScou
	Z9NVCTukTIM1XCJ6eUe7G4JLLrVKWJe4IRVNbxzd0ocQYwoNnbXfcQvrEKQwrnPuXAIEpS8+lr+
	Rkoim6mhz10/OWruJuCeL3ndH/PAgAjrECT/mZko4etf+hvfHZC49WYIcZwCaUwWYkEDzusU8mV
	safhyajgn49rQ9VWoE=
X-Received: by 2002:a05:6820:1995:b0:69b:bf80:2db5 with SMTP id 006d021491bc7-69d7ecbfda4mr11748930eaf.52.1779832301111;
        Tue, 26 May 2026 14:51:41 -0700 (PDT)
Received: from [192.168.1.102] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-69d83aa422fsm6396077eaf.14.2026.05.26.14.51.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 May 2026 14:51:40 -0700 (PDT)
Message-ID: <b89e372e-3068-4c26-9552-13e6853ba000@kernel.dk>
Date: Tue, 26 May 2026 15:51:39 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4 0/3] md/nvme: Enable PCI P2PDMA support for RAID0 and
 NVMe Multipath
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc: "song@kernel.org" <song@kernel.org>, "yukuai@fnnas.com"
 <yukuai@fnnas.com>, Christoph Hellwig <hch@lst.de>,
 "linan122@huawei.com" <linan122@huawei.com>,
 "kbusch@kernel.org" <kbusch@kernel.org>, "sagi@grimberg.me"
 <sagi@grimberg.me>, "linux-block@vger.kernel.org"
 <linux-block@vger.kernel.org>,
 "linux-raid@vger.kernel.org" <linux-raid@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Kiran Modukuri <kmodukuri@nvidia.com>
References: <20260513185153.95552-1-kch@nvidia.com>
 <20260515043535.GB3756@lst.de>
 <4ed83782-04cf-45b5-93a0-05a08e61b82e@nvidia.com>
 <053b99b2-c994-42ff-af63-6e63ab468557@nvidia.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <053b99b2-c994-42ff-af63-6e63ab468557@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260526_145142_370915_DEA3AAF9 
X-CRM114-Status: GOOD (  11.73  )
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

On 5/26/26 11:09 AM, Chaitanya Kulkarni wrote:
> Jens,
> 
> On 5/19/26 17:11, Chaitanya Kulkarni wrote:
>> Jens,
>>
>>
>> On 5/14/26 9:35 PM, Christoph Hellwig wrote:
>>> Still looks good to me as per the reviews.
>>>
>> If there no objection, can we merge this ?
>>
>> -Chaitanya
>>
>>
> There is outstanding work I want to send out based on this one.

Out standing, outstanding, or both? :-)

> May I please request you to merge this patch series ?

Was waiting on the md parts to get reviewed, by I missed that Xiao Ni
already did. I'll queue it up.

-- 
Jens Axboe

