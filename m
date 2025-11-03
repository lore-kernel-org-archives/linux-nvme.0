Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58600CCF9F8
	for <linux-nvme@archiver.kernel.org>; Mon,  3 Nov 2025 22:53:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=coUsPbwKjlFAMkCnrfzukzqyiIB4MmAIoKQNm/u+dq8=; b=RpFj1HV+E7UsaX81hcHAcYt4BN
	dNOVP2AcC9zQP5jS3hGm85VGyWh4B2gIEppI5/0YQrYy3TvK8RD3NSA+fQqNkvRAFyFPhGjrgImFP
	wH+xwUcyzT9a3a8mZpRVB4E3eZ3nGuCZf4GhMfv+yFLZiGM3MwLqhb4W0JkxarY14/UXzBu0czG6P
	xRH+XfE/oxZrOBuYYDw8QxoAi0qFAo2RcQnjnFtWou9r/OQgACis7Ztj1/9ON8B9kz8U21zwQ3TdP
	MMxObxbJFPlwQenn1IvCSBDvpKTiAHr9ZANUN3EGtnJx+VLEf2oKUXIyHX9rnNBEtKHHSkdtUKR5K
	6iSZSW6w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vG3QG-0000000AkV5-25bm;
	Mon, 03 Nov 2025 22:53:12 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vG3QF-0000000AkUs-2VSe
	for linux-nvme@lists.infradead.org;
	Mon, 03 Nov 2025 22:53:11 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id B620A601D8;
	Mon,  3 Nov 2025 22:53:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6ADADC113D0;
	Mon,  3 Nov 2025 22:53:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762210390;
	bh=WBARSNQ3hEr+eRuvUGl99YKoORdWOJ7tKJ/JcvFjW9U=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=FfL7WxQUONNlpa4nEEOXvIhPEK0lBNXlpobuGYqGSsSI1z4jeDdjk2KYJbNGZ3NpD
	 ob6S+2ECZP8KGF0zPzUYND+Zn3Z4EXHcxH2AMU5gzr0vcfnrdhYztxSQyveFbmZm7A
	 HX58Z6PSx92EksOvIDwz1TJ/tleVhPfFbW269buZ/US3nfkZEjhnfIUF9olXtJaNMU
	 VoEGdOf4+rj+YIYsmRh4ZqtElLP0FS32u9xyxzaSgrO/9Ba2HKZz9Y1OS6BuKb/CwV
	 85rsZFrcHMVD+66BJHwY2UfevZyV/+t+I96bj3IUdj9tN3AQywDx1TZkJY61efArra
	 OUBKzxVfk0MXg==
Message-ID: <83b60505-64a4-40fe-aa50-02a56ca7ad8c@kernel.org>
Date: Tue, 4 Nov 2025 07:53:07 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/13] block: track zone conditions
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>,
 Bart Van Assche <bvanassche@acm.org>
Cc: Jens Axboe <axboe@kernel.dk>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Christoph Hellwig <hch@lst.de>,
 "dm-devel@lists.linux.dev" <dm-devel@lists.linux.dev>,
 Mike Snitzer <snitzer@kernel.org>,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 Mikulas Patocka <mpatocka@redhat.com>,
 "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
 Carlos Maiolino <cem@kernel.org>,
 "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
 David Sterba <dsterba@suse.com>,
 "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
 Keith Busch <kbusch@kernel.org>
References: <20251031061307.185513-1-dlemoal@kernel.org>
 <20251031061307.185513-8-dlemoal@kernel.org>
 <40c87475-7d5a-4792-b2a6-3eeb8406f9be@acm.org>
 <93215b7c-80bd-4860-8a77-42cdd4db1ec6@kernel.org>
 <95c729d6-fd73-4480-af1c-68075b31cd1d@acm.org>
 <6008fbc8-b556-46d9-98a5-a4622731d206@nvidia.com>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <6008fbc8-b556-46d9-98a5-a4622731d206@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

On 11/4/25 01:34, Chaitanya Kulkarni wrote:
> Adding Keith's current email address :
> 's/Keith Busch <keith.busch@wdc.com>/kbusch@kernel.org/g'
> 
> On 11/3/25 7:48 AM, Bart Van Assche wrote:
>> On 11/2/25 10:05 PM, Damien Le Moal wrote:
>>> On 11/1/25 06:17, Bart Van Assche wrote:
>>>> On 10/30/25 11:13 PM, Damien Le Moal wrote:
>>>>> Implement tracking of the runtime changes to zone conditions using
>>>>> the new cond field in struct blk_zone_wplug. The size of this 
>>>>> structure
>>>>> remains 112 Bytes as the new field replaces the 4 Bytes padding at the
>>>>> end of the structure. For zones that do not have a zone write plug, 
>>>>> the
>>>>> zones_cond array of a disk is used to track changes to zone 
>>>>> conditions,
>>>>> e.g. when a zone reset, reset all or finish operation is executed.
>>>>
>>>> Why is it necessary to track the condition of sequential zones that do
>>>> not have a zone write plug? Please explain what the use cases are.
>>>
>>> Because zones that do not have a zone write plug can be empty OR full.
>>
>> Why does the block layer have to track this information? Filesystems can
>> easily derive this information from the filesystem metadata information,
>> isn't it?
>>
>> Thanks,
>>
>> Bart.
>>
> 
> In case current file systems store this, isn't that a code duplication for each
> fs ? perhaps having a central interface at block layer should help remove the
> code duplication ?

catch 22: You cannot ask the file system without first knowing the zone layout
and conditions of zone to check the file system metadata.


-- 
Damien Le Moal
Western Digital Research

