Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50599CCF9FE
	for <linux-nvme@archiver.kernel.org>; Mon,  3 Nov 2025 05:52:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6ZC0GIY8X4XV/gBCgHi7mlMYlMoZQSJZoeiQ8QC4oPY=; b=MYYX4xu0otVVHCJq0ZG7+Pc4Y/
	iI5wwOOEKfRVPLZC/K4a5/daPhknQIV0t7qBpRv0TB0pJd0p+DkHCA+9Wt8QtrVXJjbPkimCxfviZ
	1Hxc+pnqu8FWkf4uhquHJ1ZrD3bj5CX7go85ssplWwZP73RRVNu8YcwMBm+abgCcTHSN23T2KQamC
	1GLrj6qXHEn/Jz5Q3SXmvehAPfQ2HP605rR3woBuMUPCy4f7Zeefj2LNUmL050ZhLUTdWTtSDiFqq
	IvSmjXEMUwH51sn/7PfYX+uU8bsnvJHi9V7MRouds+TvYEZBGosd4huQb8iTyLX6++38VMdhGlMpp
	TXsTq1nA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vFnU4-00000009FXB-2vhV;
	Mon, 03 Nov 2025 05:52:04 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vFnU2-00000009FWa-1g7j
	for linux-nvme@lists.infradead.org;
	Mon, 03 Nov 2025 05:52:03 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 0C4A2429C5;
	Mon,  3 Nov 2025 05:52:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AADD5C4CEE7;
	Mon,  3 Nov 2025 05:51:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762149120;
	bh=oxQXBcHnc/6qR2epkavIMIgHRy691/rhW8NxiXt8CoI=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=jTVi7sYXkcHQhPjE/Buo3fxpB19O1VbODJ3EXpO8SGXi/OITbcTFvdjtKMvrtbm1O
	 4Ssd2IXFKo8l1cV3gMTphDB8noMJnfpi+6sN3XtuUYq5HqTVDuT/zB9/d5xj5EsHvT
	 omCSwnuC+7Vi0+/vLKfRUJhDnCxme3xxOwe3NgiQgy3NH+Zg5IOrITnIYZ36w37A7+
	 DlVr7F0lKNI1oDIB7AMFkkiqnYC6a+5V6txUA1NFnWtUZ0jg66PIyqB0zUHsFgD0pj
	 8aE8Ua1HS57b3aBY1JkluR7H7PgSvwANVrjTO/zkqg6rtBNKMbOlR+Nl/D8Nwfmlv8
	 hsKYmwhLwhShA==
Message-ID: <b675e291-c369-4c7e-8fa2-1470ce90f001@kernel.org>
Date: Mon, 3 Nov 2025 14:51:57 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/13] block: introduce BLKREPORTZONESV2 ioctl
To: Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>,
 linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
 Keith Busch <keith.busch@wdc.com>, Christoph Hellwig <hch@lst.de>,
 dm-devel@lists.linux.dev, Mike Snitzer <snitzer@kernel.org>,
 Mikulas Patocka <mpatocka@redhat.com>,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 linux-scsi@vger.kernel.org, linux-xfs@vger.kernel.org,
 Carlos Maiolino <cem@kernel.org>, linux-btrfs@vger.kernel.org,
 David Sterba <dsterba@suse.com>
References: <20251031061307.185513-1-dlemoal@kernel.org>
 <20251031061307.185513-11-dlemoal@kernel.org>
 <5ca96ffd-9e60-49d3-a136-c7a9eb7bce10@acm.org>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <5ca96ffd-9e60-49d3-a136-c7a9eb7bce10@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251102_215202_472298_1CA4E2A0 
X-CRM114-Status: GOOD (  13.45  )
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

On 11/1/25 01:52, Bart Van Assche wrote:
>> +	case BLKREPORTZONEV2:
>> +		if (rep.flags & ~BLK_ZONE_REPV2_INPUT_FLAGS)
>> +			return -EINVAL;
> 
> -EINVAL probably should be changed into something that indicates "not
> supported" rather than "invalid argument"?

Not supported could be confused with the cached report zones not being
supported. It is, but the user cannot specify input flags that are not defined.
This is to ensure that undefined flags are always 0 and that we can use these
going forward when we need to define a new flag.
So EINVAL seems appropriate to me.

> 
>> index dab5d9700898..1441d79a6173 100644
>> --- a/include/uapi/linux/blkzoned.h
>> +++ b/include/uapi/linux/blkzoned.h
>> @@ -82,10 +82,20 @@ enum blk_zone_cond {
>>   /**
>>    * enum blk_zone_report_flags - Feature flags of reported zone descriptors.
>>    *
>> - * @BLK_ZONE_REP_CAPACITY: Zone descriptor has capacity field.
>> + * @BLK_ZONE_REP_CAPACITY: Output only. Indicates that zone descriptors in a
>> + *			   zone report have a valid capacity field.
>> + * @BLK_ZONE_REP_CACHED: Input only. Indicates that the zone report should be
>> + *			 generated using cached zone information. In this case,
>> + *			 the implicit open, explicit open and closed zone
>> + *			 conditions are all reported with the
>> + *			 BLK_ZONE_COND_ACTIVE condition.
>>    */
>>   enum blk_zone_report_flags {
>> +	/* Output flags */
>>   	BLK_ZONE_REP_CAPACITY	= (1 << 0),
>> +
>> +	/* Input flags */
>> +	BLK_ZONE_REP_CACHED	= (1 << 31),
>>   };
> 
> Why 1 << 31 instead of 1 << 1?

Why not ? That separates input and output flags instead of mixing them in
tighter definition.



-- 
Damien Le Moal
Western Digital Research

