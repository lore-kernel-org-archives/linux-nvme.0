Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FDD2D2C55D
	for <linux-nvme@archiver.kernel.org>; Tue, 22 Oct 2024 14:18:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:References:Cc:To:From:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8MPpcQr03RIPXKnqNT1s68QdNsjE0273ya2fVOsynZE=; b=UyCR5LD9tbmir0ixhU8uHUDbGs
	2VvFXC0cERL4tTOf1AGdW9dmHk/JCmkQ06mOfvIv4YtpMin3mMGIhsX88QrFVx76eRJuWCL+eSlpn
	PsHGRVLOtgAseeVkFfjJtDOzdfqsSJ/pIjE7Y2QV6vRUBG85VGUa/O5W5vousVGSr0kA1fdf66eck
	qErn0Tf3yrqAd5LodaigXNpo6ym/2YZIs9u+xJ37PusKpncSSznCmgIaGhmBB04o/GqBVsV8L8VdR
	KYJAwYTx/YIgVKIBV9n/CH9y1MeWC+9HLiGJNPmxWbjNBj1Ma0uG91a+wsNt0UEhC+kqibm3Kzgm0
	8hF9n3wg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t3Fik-0000000B4q7-2YNS;
	Tue, 22 Oct 2024 14:18:50 +0000
Received: from mail-il1-x12f.google.com ([2607:f8b0:4864:20::12f])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t3Fi9-0000000B4nV-2eBm
	for linux-nvme@lists.infradead.org;
	Tue, 22 Oct 2024 14:18:15 +0000
Received: by mail-il1-x12f.google.com with SMTP id e9e14a558f8ab-3a3a3075af2so22514745ab.3
        for <linux-nvme@lists.infradead.org>; Tue, 22 Oct 2024 07:18:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1729606692; x=1730211492; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=8MPpcQr03RIPXKnqNT1s68QdNsjE0273ya2fVOsynZE=;
        b=1UZ2oH0WaI/H0q1c6Jb3p+PjmcHOdo9+xJxzmOJucGcP4m0AkmB+VsS7eAsAuU+3QK
         KWXGDVRDuupDR1V6booMz6mToP8Wn3dIUfulOdBI2LTPKRgQL77+8imPXCL5usgBXgLw
         SJwLocmeaoHUfv5m3QQHjN2eddlozi/s3EGHyC1tnn6IcwlULBU+OlNBq6Xv1vCgs8d6
         jX0frmyo3jALU1feA0N+hU54iMCZ72ikBtguQxLAbV5zheq2jjBtUctQoV9s/7WoGPQz
         8Uy4zT3iHL15OsCBTC+Ae5e+uLG4fE+entf64txPGqQVwQMtATGiCED0Evyrufb2SycB
         tqZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729606692; x=1730211492;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8MPpcQr03RIPXKnqNT1s68QdNsjE0273ya2fVOsynZE=;
        b=PhoqlrQIB85NqfSHBybl8N26RhrRy3Vh4iA0fJnnOr5Y1PDeQkY5LevLUK6YkEQ8gX
         zC9mkRsD/kCkEPSIx2cJKeVxaDLIsIceR140138OmG1Qqabzprqz++WFd5/gIct9B8TP
         7bMAtIdj5b++N6KFrB3Y9deoY7KyVV547m6ByFCGWiwfFd8dc7m9xgwWB76dmvrnngsF
         H5dqyhQoI3GNfdCTCAxRHffoCnSIRSi5wRKcK1SzQkItO0TNoJHXy6OjVNj5ABep9iT9
         NXGUA31H5KnnXr71UcJv5vcf6ZAgUZD/yj8xQ6iZdTMRlNJmmhcOcYxmKlBhIFZAbXyT
         UILA==
X-Forwarded-Encrypted: i=1; AJvYcCUQtWu9t0cYjT/kV174iOxNOxBBfqia1vIFGKymng1n5q6fL8AiSPf7n6yhkFrDvFyp9BShnXhEr5de@lists.infradead.org
X-Gm-Message-State: AOJu0YyJAXy/Nj7sGXI0KDhUcAtfZ+nUB+XZ1Yv3JrFePjlmAvL2HYlb
	r0VSQ+UsxHk8tv04mq5S1gwpi6k83FMK4Vf1Zj0/fJFlOE1MQ7BbDUP8FxVLR07C3QoxSDKttDm
	A
X-Google-Smtp-Source: AGHT+IGkIDQZd4OaUVRLtDfE709h1r84qITcLdydl7N/NiqCpLTfeujEYls0gCRv225ydOwsuWBdvA==
X-Received: by 2002:a05:6e02:1c2b:b0:3a3:b240:ff71 with SMTP id e9e14a558f8ab-3a3f4046bf2mr133515355ab.4.1729606692238;
        Tue, 22 Oct 2024 07:18:12 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3a400b7d382sm18085075ab.75.2024.10.22.07.18.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Oct 2024 07:18:11 -0700 (PDT)
Message-ID: <9f42c09f-4082-4578-812f-62ba006c1c05@kernel.dk>
Date: Tue, 22 Oct 2024 08:18:10 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v17 2/2] nvmet: support reservation feature
From: Jens Axboe <axboe@kernel.dk>
To: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>
Cc: Guixin Liu <kanie@linux.alibaba.com>, sagi@grimberg.me, kch@nvidia.com,
 shinichiro.kawasaki@wdc.com, d.bogdanov@yadro.com,
 linux-nvme@lists.infradead.org
References: <20241021110331.125962-1-kanie@linux.alibaba.com>
 <20241021110331.125962-3-kanie@linux.alibaba.com>
 <ZxbWxuzH3u6hAezr@kbusch-mbp>
 <b4bde72c-7123-4594-a064-a39aef7fa7ec@linux.alibaba.com>
 <ZxcIxhQMYt2fsPiY@kbusch-mbp> <20241022060639.GA10510@lst.de>
 <7e573e58-39b3-45c3-afde-0cfec3911326@kernel.dk>
Content-Language: en-US
In-Reply-To: <7e573e58-39b3-45c3-afde-0cfec3911326@kernel.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241022_071813_963758_A45A6E86 
X-CRM114-Status: GOOD (  15.29  )
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

On 10/22/24 8:13 AM, Jens Axboe wrote:
> On 10/22/24 12:06 AM, Christoph Hellwig wrote:
>> On Mon, Oct 21, 2024 at 08:07:02PM -0600, Keith Busch wrote:
>>> I see, thank you for the clarification. I hadn't been paying close
>>> enough attention at that discussion.
>>>
>>> So, minor problem here. This new feature is 6.13 material, but our
>>> upstream block branch has forked before that commit. IMO, I feel
>>> introducing that header movement after the merge window is poorly
>>> timed...
>>>
>>> Anyway, I don't think I can get away with something this large in 6.12,
>>> so it's going to have to be in our second 6.13 nvme pull request after
>>> the next rebase. I've set myself a reminder to merge this when that
>>> happens.
>>
>> This absolutely is not 6.12 material obviously.  But having the
>> block tree branched of before -rc2 seems a bit unusual and potentially
>> problematic anyway.  Jens, can you rebase or full a recent rc in?
> 
> I can rebase it, no pull in there yet.

It's on 6.12-rc4 now.

-- 
Jens Axboe


