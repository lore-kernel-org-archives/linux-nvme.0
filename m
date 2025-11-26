Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93F16D1037A
	for <linux-nvme@archiver.kernel.org>; Wed, 26 Nov 2025 03:58:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:Cc:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=J9e365EuQIdGF1Cb/P5/9j5ZadllQzJDOup6lONlHq0=; b=rAbThxIeDJd8L4kzAJz5IgCrz7
	77D4FK9yGOI/YBCay4LzmeCKNOl/YaNHQSOQ5t4DgbZqYYIGJUahdYZKsZczIyjUQEjXmSKlnMif8
	dzspbJ1N10CyF3HtWjBx6NIy+h+zV3tp5w8FMdbCJ4X6E6hZiztfeaSHSxTVSOrWasncMBtGFjYh6
	HXx/fABQWhjSyIj7pQRnNuwCi6vzmvj1HUT0RqxgDSQiNzpAz1sWoETLSRRN+RFTZUdezhMO+pyGL
	ur6k2sw1eBO6EJ4gChVY5P5mCSdc6HPgvFdOCp60BF3jHU3JRuDcZGruYsycGS+hzgnXufxb5wMYD
	KTCKt7ug==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vO6fv-0000000EK76-2uLP;
	Wed, 26 Nov 2025 03:58:39 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vO6fs-0000000EK6i-44X4
	for linux-nvme@lists.infradead.org;
	Wed, 26 Nov 2025 03:58:38 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id BB9CF41966;
	Wed, 26 Nov 2025 03:58:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A09B0C113D0;
	Wed, 26 Nov 2025 03:58:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764129515;
	bh=KdLpd3BCuvaHXYnuSJAbmb1GBZZRwfUT2tS8l4PNC9s=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=EI/8poQlKmZbCCoEeSJA01JZSZicswrBMCQ89iVxK+isXC/HcIMwn6Q1zvZv/jngg
	 Q9Usm8mf3V6RejWap0iav0EnrhYkC1NXND2m5cMEdSxUMndC5Ka78RidgwO5Mt2P4L
	 DTVLhROyox1pkRb5RDF/z6dQkoEq341p2F8d0zJxWlJYkBkMMknFQrce2Zy76Ptn9E
	 688f3CQxKN47semLWexiSKvInNtg9CQ4HA/vvwumRco7RjXp9lt5p8AlNCKswctOYq
	 t6g/Nbg5iYAJrVN29ePmnyKMCBQpV2L7mzZp5WREnyFEj/E4RGtxkac3Tqbqy9gpEA
	 BYOQQntNmr40A==
Message-ID: <9079ffb8-3b66-415f-bb2a-4d3f79dc9cb4@kernel.org>
Date: Wed, 26 Nov 2025 11:58:29 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: chao@kernel.org, "linux-block@vger.kernel.org"
 <linux-block@vger.kernel.org>, "jaegeuk@kernel.org" <jaegeuk@kernel.org>,
 "hch@lst.de" <hch@lst.de>, "song@kernel.org" <song@kernel.org>,
 "axboe@kernel.dk" <axboe@kernel.dk>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "dm-devel@lists.linux.dev" <dm-devel@lists.linux.dev>,
 "linux-raid@vger.kernel.org" <linux-raid@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "linux-f2fs-devel@lists.sourceforge.net"
 <linux-f2fs-devel@lists.sourceforge.net>, "cem@kernel.org" <cem@kernel.org>,
 "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
 "sagi@grimberg.me" <sagi@grimberg.me>, "yukuai@fnnas.com"
 <yukuai@fnnas.com>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
 "mpatocka@redhat.com" <mpatocka@redhat.com>,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 "agk@redhat.com" <agk@redhat.com>,
 Johannes Thumshirn <johannes.thumshirn@wdc.com>,
 Chaitanya Kulkarni <ckulkarnilinux@gmail.com>,
 "snitzer@kernel.org" <snitzer@kernel.org>
Subject: Re: [PATCH V3 5/6] f2fs: ignore discard return value
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>
References: <20251124234806.75216-1-ckulkarnilinux@gmail.com>
 <20251124234806.75216-6-ckulkarnilinux@gmail.com>
 <09e48eba-6f00-455a-8299-8b8bb4122c7e@kernel.org>
 <820ffbc8-56cb-4f47-9112-2f4a79524025@nvidia.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <820ffbc8-56cb-4f47-9112-2f4a79524025@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251125_195837_055885_AB1BA0BE 
X-CRM114-Status: GOOD (  22.00  )
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

On 11/26/25 11:37, Chaitanya Kulkarni wrote:
> On 11/25/25 18:47, Chao Yu wrote:
>> On 11/25/25 07:48, Chaitanya Kulkarni wrote:
>>> __blkdev_issue_discard() always returns 0, making the error assignment
>>> in __submit_discard_cmd() dead code.
>>>
>>> Initialize err to 0 and remove the error assignment from the
>>> __blkdev_issue_discard() call to err. Move fault injection code into
>>> already present if branch where err is set to -EIO.
>>>
>>> This preserves the fault injection behavior while removing dead error
>>> handling.
>>>
>>> Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
>>> Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
>>> Reviewed-by: Christoph Hellwig <hch@lst.de>
>>> Signed-off-by: Chaitanya Kulkarni <ckulkarnilinux@gmail.com>
>>> ---
>>>   fs/f2fs/segment.c | 10 +++-------
>>>   1 file changed, 3 insertions(+), 7 deletions(-)
>>>
>>> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
>>> index b45eace879d7..22b736ec9c51 100644
>>> --- a/fs/f2fs/segment.c
>>> +++ b/fs/f2fs/segment.c
>>> @@ -1343,15 +1343,9 @@ static int __submit_discard_cmd(struct f2fs_sb_info *sbi,
>>>   
>>>   		dc->di.len += len;
>>>   
>>> +		err = 0;
>>>   		if (time_to_inject(sbi, FAULT_DISCARD)) {
>>>   			err = -EIO;
>>> -		} else {
>>> -			err = __blkdev_issue_discard(bdev,
>>> -					SECTOR_FROM_BLOCK(start),
>>> -					SECTOR_FROM_BLOCK(len),
>>> -					GFP_NOFS, &bio);
>>> -		}
>>> -		if (err) {
>>>   			spin_lock_irqsave(&dc->lock, flags);
>>>   			if (dc->state == D_PARTIAL)
>>>   				dc->state = D_SUBMIT;
>>> @@ -1360,6 +1354,8 @@ static int __submit_discard_cmd(struct f2fs_sb_info *sbi,
>>>   			break;
>>>   		}
>>>   
>>> +		__blkdev_issue_discard(bdev, SECTOR_FROM_BLOCK(start),
>>> +				SECTOR_FROM_BLOCK(len), GFP_NOFS, &bio);
>> Oh, wait, bio can be NULL? Then below f2fs_bug_on() will trigger panic or warning.
>>
>> Thanks,
> 
> That will happen without this patch also or not ?
> 
> Since __blkdev_issue_discard() is always returning 0 irrespective of bio
> is null or not.
> 
> The following condition in original code will only execute when err is set to
> -EIO and that will only happen when time_to_inject() -> true.
> Original call to __blkdev_issue_discard() without this patch will always
> return 0 even for bio == NULL after __blkdev_issue_discard().
> 
> This is what we are trying to fix so caller should not rely on
> __blkdev_issue_discard() return value  :-
> 
> 354                 if (err) {
> 1355                         spin_lock_irqsave(&dc->lock, flags);
> 1356                         if (dc->state == D_PARTIAL)
> 1357                                 dc->state = D_SUBMIT;
> 1358                         spin_unlock_irqrestore(&dc->lock, flags);
> 1359
> 1360                         break;
> 1361                 }
> 
> which will lead f2fs_bug_on() for bio == NULL even without this patch.
> 
> This patch is not changing exiting behavior, correct me if I'm wrong.

Yes, I think you're right, thanks for the explanation.

So it's fine to leave this cleanup patch as it is, and let's fix this bug in
a separated patch.

Thanks,

> 
> 
>>
>>>   		f2fs_bug_on(sbi, !bio);
>>>   
>>>   		/*
> 
> -ck
> 
> 


