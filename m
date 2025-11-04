Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BB98CCF9E3
	for <linux-nvme@archiver.kernel.org>; Tue,  4 Nov 2025 07:38:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=EttuD9azZWcrEmtnHDOKj7x55j+RI5ri09ddmKXMblY=; b=1m1YRRtml3oEIImOGzpr2oqQ5W
	7ciBUl6t4rHZvieLuYKzcLLeoAwI1NaOa+JWJb496qijJaKDmxvvgMXmvgUnHbPaJb/hlPI5er5S6
	DiRJmzRZyuSgc1z3RMJ79AI89oMLNVFVIsByVNfJhDfud54LrJO7mofGe61VsYH2ZpvyArRBC5eGn
	LOqkH6tDm/Jpha89mHP8LQ3ZWHlqLOspg2AZK5EFeXTHbsi44qkBSZmsRj688vCNpw0ZuXSJZvLTG
	ONAXBJC7GoV5hRcA1dQNrVVOPtnJaFUI6lMhUgBvA40LQ/gT9ueLgPkQMWUJEldyGtylQ1kGiq+K8
	RlLs7+fQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vGBcv-0000000BLTv-1S8d;
	Tue, 04 Nov 2025 07:38:49 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vGBcu-0000000BLTb-0qQL
	for linux-nvme@lists.infradead.org;
	Tue, 04 Nov 2025 07:38:48 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 453FA600B0;
	Tue,  4 Nov 2025 07:38:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 166CFC4CEF7;
	Tue,  4 Nov 2025 07:38:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762241926;
	bh=POLqaQ94dh/t6J0gDfAv8qWZd1iCMjPLAZedaVguceE=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=Axyt6UGg5x6PGMQG7ZOVMKFrpxvXwFDDylFW2fjveB6lK7jF1SA/pmq//ghwx4V1d
	 W1MCAkzVn0rQ41EblL1QQxkn5+tLuzehDAFs9yjy+QCjPxTpaBS3/lRZpJb/YrxKJ/
	 ky4P4XTsqB7OK7fnjDBLIhm5ebHBh5NdYyVAeryN6v3BIuKhWR//b363O5C596bvGr
	 BldM+8IDv/ETGFZ2RRmsJ2x/aq68EvWGAdYHOa93bboU1FvQJ3mKk7kGv4bIQY375a
	 8ZJwn9MSvin17zPZzwAL0mtluwI5ehmY1zeInEjpM2wvpUPgKctfV5LsFS+uSGA9Fs
	 9yjPorGvg8NJQ==
Message-ID: <de15eadd-98fc-4456-8263-712e9d519adf@kernel.org>
Date: Tue, 4 Nov 2025 16:38:43 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 11/15] block: introduce BLKREPORTZONESV2 ioctl
To: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
 Jens Axboe <axboe@kernel.dk>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Keith Busch <keith.busch@wdc.com>, hch <hch@lst.de>,
 "dm-devel@lists.linux.dev" <dm-devel@lists.linux.dev>,
 Mike Snitzer <snitzer@kernel.org>, Mikulas Patocka <mpatocka@redhat.com>,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
 "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
 Carlos Maiolino <cem@kernel.org>,
 "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
 David Sterba <dsterba@suse.com>
References: <20251103133123.645038-1-dlemoal@kernel.org>
 <20251103133123.645038-12-dlemoal@kernel.org>
 <982ed7d8-e818-4d9c-a734-64ab8b21a7e3@wdc.com>
 <0154c2a8-a3ed-45d3-8f8a-1581106212fb@kernel.org>
 <f7025e4f-3205-4bae-93c0-68e02dd11ca9@wdc.com>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <f7025e4f-3205-4bae-93c0-68e02dd11ca9@wdc.com>
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

On 11/4/25 16:23, Johannes Thumshirn wrote:
> On 11/4/25 1:15 AM, Damien Le Moal wrote:
>> On 11/4/25 00:17, Johannes Thumshirn wrote:
>>> On 11/3/25 2:38 PM, Damien Le Moal wrote:
>>>> Introduce the new BLKREPORTZONESV2 ioctl command to allow user
>>>> applications access to the fast zone report implemented by
>>>> blkdev_report_zones_cached(). This new ioctl is defined as number 142
>>>> and is documented in include/uapi/linux/fs.h.
>>>>
>>>> Unlike the existing BLKREPORTZONES ioctl, this new ioctl uses the flags
>>>> field of struct blk_zone_report also as an input. If the user sets the
>>>> BLK_ZONE_REP_CACHED flag as an input, then blkdev_report_zones_cached()
>>>> is used to generate the zone report using cached zone information. If
>>>> this flag is not set, then BLKREPORTZONESV2 behaves in the same manner
>>>> as BLKREPORTZONES and the zone report is generated by accessing the
>>>> zoned device.
>>>
>>> Is there a downside to always do the caching? A.k.a do we need the new
>>> ioctl or can we keep using the old one and cache the report zones reply?
>> The old one is needed to allow getting the precise imp open, exp open, closed
>> conditions, if the user cares about these. E.g. Zonefs does because of the
>> (optional) explicit zone open done on file open.
>>
>> And we cannot break existing user space anyway (e.g. sysutils blkzone), so we
>> must return the "legacy" report unless asked otherwise.
> 
> 
> OK, let me read the patches again, but why can't we do a "write-through" 
> style caching? I.e. something in the system is executing
> 
> blkdev_report_zones(), the cache will be populated as well.

The cache is initialized with zone revalidation and maintained as IOs and zone
management operations are executeds. No need to involve blkdev_report_zones()
for maintaining the zone information. Not to mention that it would be impossible
to correctly do it without guaranteeing that report zones is the *only* command
being executed. Otherwise, by the time you process a zone report,
write/reset/finish IOs to that zone may already have changed it.

-- 
Damien Le Moal
Western Digital Research

