Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 036FCD10399
	for <linux-nvme@archiver.kernel.org>; Wed, 26 Nov 2025 09:48:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8uMB3N5rvsdxpxdbhQ4/rwp3UTr0eB1Bcl9iSw80eIw=; b=M1OmeorSWH3BlUxGZrmj/54qvP
	HDkLMZ9NI3B9mC95NRbeMta4sVsqZh1xjYCw+EbpLHlJ1Wes7pwxZbaLyd2Ri5XXcORYpb4Nz0rvb
	9QNTWwuC02iWGEsaSdj3Y84XkFEAGvCpWDfeCxbOYZkVj/R/4EdIClMRd0x7bHI6en/JASGtnV6Q9
	AlAWA54A5heSjNZgwEX9ofOFyO24lokPpqUZ4awQ6Yz1sFBAoYCusB+rihG6dXXib0CoGKl2zheUw
	+SqvgcsYMFb1x5mhjdhf8/vZKH5AtN0sZwerAhUszxh7lmo60xw/wlAIp2/Fdq+A4pYaO0b3Ss67M
	g5Af/Uuw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vOC8d-0000000EjsL-0fdo;
	Wed, 26 Nov 2025 09:48:39 +0000
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vOC8Z-0000000Ejrx-2qgw
	for linux-nvme@lists.infradead.org;
	Wed, 26 Nov 2025 09:48:36 +0000
Received: by mail-pj1-x102d.google.com with SMTP id 98e67ed59e1d1-343dd5aa6e7so6871140a91.0
        for <linux-nvme@lists.infradead.org>; Wed, 26 Nov 2025 01:48:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764150515; x=1764755315; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8uMB3N5rvsdxpxdbhQ4/rwp3UTr0eB1Bcl9iSw80eIw=;
        b=DreVqx8+XIVWHoZlFfnVYEUv05TgoHR0XUzYcddzeLmbkEX8LUBEVd+dHevjyjriHL
         dhsBFIPjZTbp9xY1LZIQ1g9cSvrIt/d4+TAvmFyxngJ3YQTzxhQOJAEO9v5411WvHQSN
         JOL4LNuu4eCR3SCWu0j1N1sSzhdsEBNP/c+tfyC4VswspIvleuTYBS5lviTAIQyehSkn
         05SNPCJqxkFkCPnjsjbugrkcvoHDW1XC3xDpUT5fQJ8tDDHdFR1uGZvWcI70rUFBjsGd
         3fw5ltYGPoqhCF0LQifjh8Ydx6NRPca1CtvQIO3HhwQC99DTyNhexHVlREwt8FaPaXTp
         KfOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764150515; x=1764755315;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8uMB3N5rvsdxpxdbhQ4/rwp3UTr0eB1Bcl9iSw80eIw=;
        b=I2p0n2Urj9AMrme3UE1caG+DvP3Mkme4DhnkSNc8pE7ySzq6Uh1GCQCbTyk5/ygH+Z
         f9G1VZZ2JpRpvv1ijsiq4HYWKf8VNxqtZhvrr13C9dmMRpl0hX9ECFOpREolaMzJvhBA
         HPubSrhsBx4VP1IlVgESlkfpSDbWO3kJZopAz7FolMh9DE6e4eTAdCLBPaxc6NRpibgt
         QPozLPGCwfiQ9YIc1Mbpn0jFJRMkhzP09d4v/0Z/8us3ZzF/4ZVOh5scpf8xoq52LlBG
         1PGpwZw+cRAc0CfklBfJlUWi5LBG2dDEURJmP6u/hCBCYdm6cZg03kt1lR5P6WQr/j3B
         tnLQ==
X-Forwarded-Encrypted: i=1; AJvYcCWijBIr8j6IJkdbohSigSOQbROlcwDzNvMZEhX6qIFoL486L91iElIva4uBSj98tlssUblTaDY1EELD@lists.infradead.org
X-Gm-Message-State: AOJu0YwVGMk6KEV/jRlR5fF/c+uPHMlWi4CXvI4Y2B7DQbKIvVYIDNIV
	LHaKFBTXCZ4EkH5Xp+3Gitxhd5YREnnCZHM5oKZHzzPUxEkCST6McQSo
X-Gm-Gg: ASbGncv17m8CaUNbykMHx6DQeZc0V5BbhQHg6TGRl7s7EhSk5Wtu/gaaXLcOQ+RtcWu
	V4DCBFiY7uT4fcTrP0THVnjEztbK9Cb5chvv3XdYiyElFnxUf5itFYC97luwV+95S3+9eH/7nt9
	fsGgwXVzvJfQKLX8uf36nV/IAM/fqzMEcwMpwHT5OFg6AcO+rONNeRuWi2chX9c+dCFd0pOLDnF
	LMHVX5kUv3lFTn3UwYRVqBSaObSQ41dD8kcgiVKeXFviAGcpBKT3IgvVvhRxstKAeKen2F7LbvO
	pkczQGZLYfp9NWeCgG2vIJob4iGoN1QlvUeMwyuXf4QzYGJr/QumZIQcF3AqYVszdnuZUMnEZyR
	PW5f7WE4r2oaUy0lztg6rpp2VWcRhyixJtMyZCtR16hoPSC2kOzhMxN8XnmgUCBaYSQ4gXQD1Kx
	XXgVoY85Pa4tzKLKJ5Aedcdalpfra4u46uSCz1lZmJ
X-Google-Smtp-Source: AGHT+IF+9FtF7ayQC3G69Yp8vRWGltdYla+KBkYnRAEC4rmaUkKIhqBtAVHy/WEEjGIFeEh9j7Z8hw==
X-Received: by 2002:a17:90b:2ccc:b0:340:299f:130d with SMTP id 98e67ed59e1d1-34733e60971mr18027499a91.13.1764150514677;
        Wed, 26 Nov 2025 01:48:34 -0800 (PST)
Received: from [10.189.138.37] ([43.224.245.241])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3476004dc3dsm1931007a91.9.2025.11.26.01.48.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Nov 2025 01:48:34 -0800 (PST)
Message-ID: <5a1387fd-4952-42e0-b7a9-e614f7b20325@gmail.com>
Date: Wed, 26 Nov 2025 17:48:28 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [f2fs-dev] [PATCH V3 6/6] xfs: ignore discard return value
To: Yongpeng Yang <yangyongpeng.storage@gmail.com>,
 Chaitanya Kulkarni <chaitanyak@nvidia.com>,
 Chaitanya Kulkarni <ckulkarnilinux@gmail.com>,
 "axboe@kernel.dk" <axboe@kernel.dk>, "agk@redhat.com" <agk@redhat.com>,
 "snitzer@kernel.org" <snitzer@kernel.org>,
 "mpatocka@redhat.com" <mpatocka@redhat.com>,
 "song@kernel.org" <song@kernel.org>, "yukuai@fnnas.com" <yukuai@fnnas.com>,
 "hch@lst.de" <hch@lst.de>, "sagi@grimberg.me" <sagi@grimberg.me>,
 "jaegeuk@kernel.org" <jaegeuk@kernel.org>, "chao@kernel.org"
 <chao@kernel.org>, "cem@kernel.org" <cem@kernel.org>
Cc: "dm-devel@lists.linux.dev" <dm-devel@lists.linux.dev>,
 "linux-raid@vger.kernel.org" <linux-raid@vger.kernel.org>,
 Johannes Thumshirn <johannes.thumshirn@wdc.com>,
 Yongpeng Yang <yangyongpeng@xiaomi.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "linux-f2fs-devel@lists.sourceforge.net"
 <linux-f2fs-devel@lists.sourceforge.net>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
 "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>
References: <20251124234806.75216-1-ckulkarnilinux@gmail.com>
 <20251124234806.75216-7-ckulkarnilinux@gmail.com>
 <b18c489f-d6ee-4986-94be-a9aade7d3a47@gmail.com>
 <218f0cd0-61bf-4afa-afb0-a559cd085d4a@nvidia.com>
 <2da95607-9b21-4d21-8926-9463021a6f33@gmail.com>
Content-Language: en-US
From: Yongpeng Yang <yangyongpeng.storage@gmail.com>
In-Reply-To: <2da95607-9b21-4d21-8926-9463021a6f33@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251126_014835_736943_C8167EBA 
X-CRM114-Status: GOOD (  27.51  )
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

On 11/26/25 17:14, Yongpeng Yang wrote:
> On 11/26/25 16:07, Chaitanya Kulkarni via Linux-f2fs-devel wrote:
>> On 11/25/25 18:37, Yongpeng Yang wrote:
>>>> diff --git a/fs/xfs/xfs_discard.c b/fs/xfs/xfs_discard.c
>>>> index 6917de832191..b6ffe4807a11 100644
>>>> --- a/fs/xfs/xfs_discard.c
>>>> +++ b/fs/xfs/xfs_discard.c
>>>> @@ -108,7 +108,7 @@ xfs_discard_endio(
>>>>     * list. We plug and chain the bios so that we only need a single
>>>> completion
>>>>     * call to clear all the busy extents once the discards are 
>>>> complete.
>>>>     */
>>>> -int
>>>> +void
>>>>    xfs_discard_extents(
>>>>        struct xfs_mount    *mp,
>>>>        struct xfs_busy_extents    *extents)
>>>> @@ -116,7 +116,6 @@ xfs_discard_extents(
>>>>        struct xfs_extent_busy    *busyp;
>>>>        struct bio        *bio = NULL;
>>>>        struct blk_plug        plug;
>>>> -    int            error = 0;
>>>>          blk_start_plug(&plug);
>>>>        list_for_each_entry(busyp, &extents->extent_list, list) {
>>>> @@ -126,18 +125,10 @@ xfs_discard_extents(
>>>>              trace_xfs_discard_extent(xg, busyp->bno, busyp->length);
>>>>    -        error = __blkdev_issue_discard(btp->bt_bdev,
>>>> +        __blkdev_issue_discard(btp->bt_bdev,
>>>>                    xfs_gbno_to_daddr(xg, busyp->bno),
>>>>                    XFS_FSB_TO_BB(mp, busyp->length),
>>>>                    GFP_KERNEL, &bio);
>>>
>>> If blk_alloc_discard_bio() fails to allocate a bio inside
>>> __blkdev_issue_discard(), this may lead to an invalid loop in
>>> list_for_each_entry{}. Instead of using __blkdev_issue_discard(), how
>>> about allocate and submit the discard bios explicitly in
>>> list_for_each_entry{}?
>>>
>>> Yongpeng,
>>
>>
>> Calling __blkdev_issue_discard() keeps managing all the bio with the
>> appropriate GFP mask, so the semantics stay the same. You are just
>> moving memory allocation to the caller and potentially looking at
>> implementing retry on bio allocation failure.
>>
>> The retry for discard bio memory allocation is not desired I think,
>> since it's only a hint to the controller.
> 
> Agreed. I'm not trying to retry bio allocation inside the
> list_for_each_entry{} loop. Instead, since blk_alloc_discard_bio()
> returning NULL cannot reliably indicate whether the failure is due to
> bio allocation failure, it could also be caused by 'bio_sects == 0', I'd
> like to allocate the bio explicitly.
> 
>>
>> This patch is simply cleaning up dead error-handling branches at the
>> callers no behavioral changes intended.
>>
>> What maybe useful is to stop iterating once we fail to allocate the
>> bio [1].
>>
>> -ck
>>
>> [1] Potential addition on the top of this to exit early in discard loop
>>       on bio allocation failure.
>>
>> diff --git a/fs/xfs/xfs_discard.c b/fs/xfs/xfs_discard.c
>> index b6ffe4807a11..1519f708bb79 100644
>> --- a/fs/xfs/xfs_discard.c
>> +++ b/fs/xfs/xfs_discard.c
>> @@ -129,6 +129,13 @@ xfs_discard_extents(
>>                                   xfs_gbno_to_daddr(xg, busyp->bno),
>>                                   XFS_FSB_TO_BB(mp, busyp->length),
>>                                   GFP_KERNEL, &bio);
>> +               /*
>> +                * We failed to allocate bio instead of continuing the 
>> loop
>> +                * so it will lead to inconsistent discards to the disk
>> +                * exit early and jump into xfs_discard_busy_clear().
>> +                */
>> +               if (!bio)
>> +                       break;
> 
> I noticed that as long as XFS_FSB_TO_BB(mp, busyp->length) is greater
> than 0 and there is no bio allocation failure, __blkdev_issue_discard()
> will never return NULL. I'm not familiar with this part of the xfs, so
> I'm not sure whether there are cases where 'XFS_FSB_TO_BB(mp,
> busyp->length)' could be 0. If such cases do not exist, then
> checking whether the bio is NULL should be sufficient.
> 
> Yongpeng,

If __blkdev_issue_discard() requires multiple calls to
blk_alloc_discard_bio(), once the first bio allocation succeeds, it will
never result in bio == NULL, meaning that any subsequent bio allocation
failures cannot be detected.

Yongpeng,

> 
>>           }
>>           if (bio) {
>> > If we keep looping after the first bio == NULL, the rest of the 
>> range is
>> guaranteed to be inconsistent anyways, because every subsequent iteration
>> will fall into one of three cases:
>>
>> - The allocator keeps returning NULL, so none of the remaining LBAs 
>> receive
>>     discard.
>> - Rest of the allocator succeeds, but we’ve already skipped a chunk, 
>> leaving
>>     a hole in the discard range.
>> - We get intermittent successes, which produces alternating chunks of
>>     discarded and undiscarded blocks.
>>
>> In each of those scenarios, the disk ends up with a partially discarded
>> range, so the correct fix is to break out of the loop immediately and
>> proceed to xfs_discard_busy_clear() once the very first allocation fails.

