Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E6AFD10397
	for <linux-nvme@archiver.kernel.org>; Wed, 26 Nov 2025 09:14:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FsAxxdgt6IXuSxrdWBozCg8XdMM7lBgDlsl70F68Y1Y=; b=VQLEvSIcw0K0udVYtL73lg+s8A
	1A+k9U+Zo/uUaYUFgTzxIx7hK2wUITYJrB6mkvbmLcgaeddf2b8+qKOhEZcOjrR1T9ZynILeyYuJm
	mf/SoctQ2T6zqS1xnF0NJQfxLH5TVJ0lv6OTcvPNRpQUc6u9ni+5cYmuLPfAjTGqn63ZJs4q7Sc2s
	VEL9ysvq7666+74PKEYf6UD0u084AOYfHqPlXjegePrpmwkxUCK3n5VuKGp++8Y8VD91dUny2ZgOq
	h7nZrqWq7OTMtlMB4gSwUk0nTM/vQS6n3lks2BZj9dT3X0osO+/8YTHrzmKM+HRm9dmMX3ejPxKHy
	4wq5GECA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vOBby-0000000Eh5e-2BHZ;
	Wed, 26 Nov 2025 09:14:54 +0000
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vOBbv-0000000Eh5F-44vk
	for linux-nvme@lists.infradead.org;
	Wed, 26 Nov 2025 09:14:53 +0000
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-7bc0cd6a13aso435668b3a.0
        for <linux-nvme@lists.infradead.org>; Wed, 26 Nov 2025 01:14:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764148491; x=1764753291; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FsAxxdgt6IXuSxrdWBozCg8XdMM7lBgDlsl70F68Y1Y=;
        b=E5v39s4f1K0AfUdJGYKoEQYKVHxTs3UGmaZ0v2s9AIDkBUWejQ5tC25ZakZ7pxv9/O
         zCprdVKjTmRQ2lGcfHP2mHn6zqCAMkA3rl/u7d//TcCXHF5osTvEyEZMdkT7GUTtfoEg
         2u0ifeec5jMlg8PYJsFh4Tae4p/B129HIPqW0jZKaJE+6z/5hOwPL93tTOA+e2TO88Fy
         sWnKRw5HzQ9nspK7nc779ThjoxioihddhTg95BhFTU21oAFfSORwRlQ/YiHV5V9zJXSA
         emDjz8uwnuIVxCgDop2yWlQJRRfWhtSHuAwMNC7zDORiB3jlMt6sR3WqFw70/2I86GnD
         ijbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764148491; x=1764753291;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FsAxxdgt6IXuSxrdWBozCg8XdMM7lBgDlsl70F68Y1Y=;
        b=FQHojJdc3xytoIZyCqRwSZruRH8Opb1xmXIWbgVa4HfuMOQJzUBXar6izNzz9wk0ZA
         ME1cWiyye7mPgHTP88sUWj5SiJXfsaX2nXF8sm03sCSFlhTPykutasApHrbuPldpY5yH
         xAMcGE4E4Es6OiSwwPv2TCnHVX7OMJv0DQ4u3P5i/RFUPFPtihYMt9BFRXV4+UK1I6dE
         JFedE/zvFcX1nSQGEpWCxlLagVtF/KxG/pZKHrGiwOdeX1TLqZjgKoXllnwHa2arUy5v
         zoYSFxbSJ0A5KMWGIhmV6Vg8f93BU3OOciaHxcj3njOn3DepYDOlkGyIvYev0gWtLfDD
         kYBg==
X-Forwarded-Encrypted: i=1; AJvYcCWSNgdZYOV1m/yDFQeaR+BClyMwF4khWvVXtEL2fEYbdnO8z23bVJFPWA4JueZj+lWfQO8JpP5wCDj6@lists.infradead.org
X-Gm-Message-State: AOJu0YzUpodGJ0y8mxPgsr6wD9dSqNsG/U6Qehb9+0oxohiTDlekX+5t
	9nnSs/4FMmC8ZmhkEhQSszJrqy8RWY65t3+71XcxhmmGMCsSqFTH7Ln4
X-Gm-Gg: ASbGnctVoHbCD0jQ3JSIm6pG6CGY9ai3E9/afnMmCLM348WqX/fWtK8UveYCA6OzPUB
	8+cTwUaioqioRhbQpK43Biaoo7yeup0b1i7ViSkfDmSWyr+AWewLHyHfhFZrFU1R4ZWlqtZ7IAB
	zEjW1KPynXA9lolTcNEwNxrSOSELw/spfiAhLQOgprM6cs1B8an2NrzRIBwyT3sSH2zznZ0iy6L
	ZaZcx9q+3PL5nc5Y6m5TtKlR1U6oVmGB8lTtMSKRKpZ7vuodoqUUeD/i6yHFWrTInPJrESF7RB4
	Lwe/1aZnGWcOYCti3cD2xn028N+Udeg/qycRLluiZVVf1R6U3vjDJj0rBZIvpbWtf3GjtU/RIde
	4stfojWLKV44twRaoaJJmiOK7Er5fo6OmrGPo5x43u53rXCgydunfKz6W5rU+W3DyEeI/TlE/Jn
	qJw2p730NMoxEs8g2WNTRS0eyI5r5LCg==
X-Google-Smtp-Source: AGHT+IGT8gd70TCQi63rsPWx+UIJ4mcNla5iKtS6p8pWOc51DUh5MCPHup9N3N3lGRYqyvIBZTUYDg==
X-Received: by 2002:a05:6a20:a114:b0:342:fa5:8b20 with SMTP id adf61e73a8af0-3614f5aec2cmr19183971637.30.1764148490926;
        Wed, 26 Nov 2025 01:14:50 -0800 (PST)
Received: from [10.189.138.37] ([43.224.245.241])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7c3ecf7d849sm20690335b3a.14.2025.11.26.01.14.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Nov 2025 01:14:50 -0800 (PST)
Message-ID: <2da95607-9b21-4d21-8926-9463021a6f33@gmail.com>
Date: Wed, 26 Nov 2025 17:14:44 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [f2fs-dev] [PATCH V3 6/6] xfs: ignore discard return value
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>,
 Yongpeng Yang <yangyongpeng.storage@gmail.com>,
 Chaitanya Kulkarni <ckulkarnilinux@gmail.com>,
 "axboe@kernel.dk" <axboe@kernel.dk>, "agk@redhat.com" <agk@redhat.com>,
 "snitzer@kernel.org" <snitzer@kernel.org>,
 "mpatocka@redhat.com" <mpatocka@redhat.com>,
 "song@kernel.org" <song@kernel.org>, "yukuai@fnnas.com" <yukuai@fnnas.com>,
 "hch@lst.de" <hch@lst.de>, "sagi@grimberg.me" <sagi@grimberg.me>,
 "jaegeuk@kernel.org" <jaegeuk@kernel.org>, "chao@kernel.org"
 <chao@kernel.org>, "cem@kernel.org" <cem@kernel.org>
Cc: "dm-devel@lists.linux.dev" <dm-devel@lists.linux.dev>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 Johannes Thumshirn <johannes.thumshirn@wdc.com>,
 Yongpeng Yang <yangyongpeng@xiaomi.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "linux-f2fs-devel@lists.sourceforge.net"
 <linux-f2fs-devel@lists.sourceforge.net>,
 "linux-raid@vger.kernel.org" <linux-raid@vger.kernel.org>,
 "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
 "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>
References: <20251124234806.75216-1-ckulkarnilinux@gmail.com>
 <20251124234806.75216-7-ckulkarnilinux@gmail.com>
 <b18c489f-d6ee-4986-94be-a9aade7d3a47@gmail.com>
 <218f0cd0-61bf-4afa-afb0-a559cd085d4a@nvidia.com>
Content-Language: en-US
From: Yongpeng Yang <yangyongpeng.storage@gmail.com>
In-Reply-To: <218f0cd0-61bf-4afa-afb0-a559cd085d4a@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251126_011452_018453_A3F8C0BE 
X-CRM114-Status: GOOD (  28.76  )
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

On 11/26/25 16:07, Chaitanya Kulkarni via Linux-f2fs-devel wrote:
> On 11/25/25 18:37, Yongpeng Yang wrote:
>>> diff --git a/fs/xfs/xfs_discard.c b/fs/xfs/xfs_discard.c
>>> index 6917de832191..b6ffe4807a11 100644
>>> --- a/fs/xfs/xfs_discard.c
>>> +++ b/fs/xfs/xfs_discard.c
>>> @@ -108,7 +108,7 @@ xfs_discard_endio(
>>>     * list. We plug and chain the bios so that we only need a single
>>> completion
>>>     * call to clear all the busy extents once the discards are complete.
>>>     */
>>> -int
>>> +void
>>>    xfs_discard_extents(
>>>        struct xfs_mount    *mp,
>>>        struct xfs_busy_extents    *extents)
>>> @@ -116,7 +116,6 @@ xfs_discard_extents(
>>>        struct xfs_extent_busy    *busyp;
>>>        struct bio        *bio = NULL;
>>>        struct blk_plug        plug;
>>> -    int            error = 0;
>>>          blk_start_plug(&plug);
>>>        list_for_each_entry(busyp, &extents->extent_list, list) {
>>> @@ -126,18 +125,10 @@ xfs_discard_extents(
>>>              trace_xfs_discard_extent(xg, busyp->bno, busyp->length);
>>>    -        error = __blkdev_issue_discard(btp->bt_bdev,
>>> +        __blkdev_issue_discard(btp->bt_bdev,
>>>                    xfs_gbno_to_daddr(xg, busyp->bno),
>>>                    XFS_FSB_TO_BB(mp, busyp->length),
>>>                    GFP_KERNEL, &bio);
>>
>> If blk_alloc_discard_bio() fails to allocate a bio inside
>> __blkdev_issue_discard(), this may lead to an invalid loop in
>> list_for_each_entry{}. Instead of using __blkdev_issue_discard(), how
>> about allocate and submit the discard bios explicitly in
>> list_for_each_entry{}?
>>
>> Yongpeng,
> 
> 
> Calling __blkdev_issue_discard() keeps managing all the bio with the
> appropriate GFP mask, so the semantics stay the same. You are just
> moving memory allocation to the caller and potentially looking at
> implementing retry on bio allocation failure.
> 
> The retry for discard bio memory allocation is not desired I think,
> since it's only a hint to the controller.

Agreed. I'm not trying to retry bio allocation inside the
list_for_each_entry{} loop. Instead, since blk_alloc_discard_bio()
returning NULL cannot reliably indicate whether the failure is due to
bio allocation failure, it could also be caused by 'bio_sects == 0', I'd
like to allocate the bio explicitly.

> 
> This patch is simply cleaning up dead error-handling branches at the
> callers no behavioral changes intended.
> 
> What maybe useful is to stop iterating once we fail to allocate the
> bio [1].
> 
> -ck
> 
> [1] Potential addition on the top of this to exit early in discard loop
>       on bio allocation failure.
> 
> diff --git a/fs/xfs/xfs_discard.c b/fs/xfs/xfs_discard.c
> index b6ffe4807a11..1519f708bb79 100644
> --- a/fs/xfs/xfs_discard.c
> +++ b/fs/xfs/xfs_discard.c
> @@ -129,6 +129,13 @@ xfs_discard_extents(
>                                   xfs_gbno_to_daddr(xg, busyp->bno),
>                                   XFS_FSB_TO_BB(mp, busyp->length),
>                                   GFP_KERNEL, &bio);
> +               /*
> +                * We failed to allocate bio instead of continuing the loop
> +                * so it will lead to inconsistent discards to the disk
> +                * exit early and jump into xfs_discard_busy_clear().
> +                */
> +               if (!bio)
> +                       break;

I noticed that as long as XFS_FSB_TO_BB(mp, busyp->length) is greater
than 0 and there is no bio allocation failure, __blkdev_issue_discard()
will never return NULL. I'm not familiar with this part of the xfs, so
I'm not sure whether there are cases where 'XFS_FSB_TO_BB(mp,
busyp->length)' could be 0. If such cases do not exist, then
checking whether the bio is NULL should be sufficient.

Yongpeng,

>           }
>    
>           if (bio) {
> > If we keep looping after the first bio == NULL, the rest of the range is
> guaranteed to be inconsistent anyways, because every subsequent iteration
> will fall into one of three cases:
> 
> - The allocator keeps returning NULL, so none of the remaining LBAs receive
>     discard.
> - Rest of the allocator succeeds, but we’ve already skipped a chunk, leaving
>     a hole in the discard range.
> - We get intermittent successes, which produces alternating chunks of
>     discarded and undiscarded blocks.
> 
> In each of those scenarios, the disk ends up with a partially discarded
> range, so the correct fix is to break out of the loop immediately and
> proceed to xfs_discard_busy_clear() once the very first allocation fails.



