Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45606CD11C2
	for <linux-nvme@archiver.kernel.org>; Wed,  3 Apr 2024 01:02:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Xs+ZNU5ksPAxzvlqgJG7ICW8uqpYZcJuYGNCqEvIq4c=; b=PcmlWfRY8zncw8lyRoBB8wjF72
	DFL4t++C4zXkAtmO6ZDjnTGcfhNbL1c3PiIp9otBLQYP9HGc9C33c3EtWM0Wj59p7ufrXvT7i8SKd
	LHc0p3v83OKueZl6+04i0BbTMiKb2EKFzgSIM8Jq+0LjKCL+yjEl28OkPENEcWXKZ2cnZtFUV2/3Y
	ft1WX10POsig3gdEDnvexKlt7HGipiiGnCN7SMvoRwMNheu2A803kvXTN+F7n9XmB81UX7A/D7/Xt
	8MhM3FbDhUbXDpE9+zMBMeWUld/hjTCwrShCIJuOqY//Iw8myvfLtENb/jO4ecYSVZE7aTbSNi24T
	CuB4RFBA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rrp1R-0000000DRq0-3ukc;
	Wed, 03 Apr 2024 01:02:37 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rrp1Q-0000000DRpP-0OlB
	for linux-nvme@lists.infradead.org;
	Wed, 03 Apr 2024 01:02:37 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 7E06560180;
	Wed,  3 Apr 2024 01:02:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A71CEC433C7;
	Wed,  3 Apr 2024 01:02:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712106155;
	bh=kzgwLdsL4OudUwPrRRSPRtFvw3mEHVc9aO/Nux6tJOs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=j/WsTKmGI70YaCEBXfrg3yAAQyr/QbNeES4W3bPqzfs9wnji+dRQOlTQD4J9k7sRY
	 nwlo+vB34Za3Oo5kUbWjbf8xQGMBV8PlGB+2HQLqLQnuJlnWFjJH7UVFJRigzc+9BS
	 zFtRiDHycscQNh6GCixrP5TOx/ezsYoLPxoYdi4MYfXf5OikeDpWNr2AO2WJzLMQak
	 LXAC3824kBL9t6F/UcWVng3ePi1HK6RrbKEmVN8OpB3VbcxLjME1FPMtZnf4mOvjD4
	 c9huh4rdbqqgwyl4EUlZDwfQfuZfEMpe6txECbCWhxO2/mQqqMHouksQ3V9qQetZYe
	 rgBlfwhN8sO2A==
Message-ID: <084cc8bd-bbc7-491f-b196-51ccd3d97620@kernel.org>
Date: Wed, 3 Apr 2024 10:02:32 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 07/28] block: Introduce zone write plugging
To: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>
Cc: linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 dm-devel@lists.linux.dev, Mike Snitzer <snitzer@redhat.com>,
 linux-nvme@lists.infradead.org, Keith Busch <kbusch@kernel.org>
References: <20240402123907.512027-1-dlemoal@kernel.org>
 <20240402123907.512027-8-dlemoal@kernel.org> <20240402161213.GB3527@lst.de>
 <e923b1cf-9683-4029-8a39-c66aa8fb2647@kernel.org>
 <a68d7e70-d82f-4a09-8b9c-db5e902a3663@kernel.dk>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <a68d7e70-d82f-4a09-8b9c-db5e902a3663@kernel.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240402_180236_257531_7BCE9A00 
X-CRM114-Status: GOOD (  19.47  )
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

On 4/3/24 10:01, Jens Axboe wrote:
> On 4/2/24 5:38 PM, Damien Le Moal wrote:
>> On 4/3/24 01:12, Christoph Hellwig wrote:
>>>> +static inline struct blk_zone_wplug *
>>>> +disk_lookup_zone_wplug(struct gendisk *disk, sector_t sector)
>>>> +{
>>>> +	unsigned int zno = disk_zone_no(disk, sector);
>>>> +	unsigned int idx = hash_32(zno, disk->zone_wplugs_hash_bits);
>>>> +	struct blk_zone_wplug *zwplug;
>>>> +
>>>> +	rcu_read_lock();
>>>> +	hlist_for_each_entry_rcu(zwplug, &disk->zone_wplugs_hash[idx], node) {
>>>> +		if (zwplug->zone_no == zno)
>>>> +			goto unlock;
>>>> +	}
>>>> +	zwplug = NULL;
>>>> +
>>>> +unlock:
>>>> +	rcu_read_unlock();
>>>> +	return zwplug;
>>>> +}
>>>
>>> Did we lose an atomic_inc_unless_zero here?  This now just does a lookup
>>> under RCU, but nothing to prevent the zwplug from beeing freed?
>>
>> Nope. When disk_lookup_zone_wplug() is called directly, it is always
>> for handling requests/bios which are holding a reference on the plug
>> and because there are requests/BIOs in-flight, the plug is marked as
>> busy (BLK_ZONE_WPLUG_PLUGGED or BLK_ZONE_WPLUG_ERROR are set). In such
>> state, the plug is always hashed given that
>> disk_should_remove_zone_wplug() retturns false for busy plugs. So
>> there is no reference increase here. The atomic_inc_not_zero() is in
>> disk_get_zone_wplug() which calls disk_lookup_zone_wplug() +
>> atomic_inc_not_zero() within an rcu_read_lock()/rcu_read_unlock()
>> section.
> 
> But doing a lookup under rcu, dropping it, and then returning the unit
> without an increment is just a horrible pattern. Regardless of whether
> it's safe or not. And as most callers do the atomic_inc anyway, some of
> then outside rcu lock, this looks horrible buggy.
> 
> Please just unify it all and have it follow the idiomatic rcu lookup
> pattern, which is:
> 
> rcu_read_lock();
> item = lookup();
> if (atomic_inc_not_zero(item->ref)) {
> 	rcu_read_unlock();
> 	return item;
> }
> 
> rcu_read_unlock();
> return NULL;
> 
> as that is well understood, and your code most certainly does not look
> safe nor sane in that regard.
> 
> And probably kill that atomic_inc() helper you have as well while at it.

OK.

> 

-- 
Damien Le Moal
Western Digital Research


