Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9B84CD11DD
	for <linux-nvme@archiver.kernel.org>; Thu, 28 Mar 2024 22:38:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fwzIBQsEcpAnwxj9HHAF+XpeLX4aelSFOmc4pM890mI=; b=RnJieqqJn8/tm28bbQsG7Aziiu
	2f+Du0IDJ//XYMtFbpLT7l1tbaq1C3ByrVGERhWQk+kU3fYAwOlBv9xQpZIYwPbWXZRkRCATS7txJ
	gx1n4kJ8ysiVQz8zGIs0IqsGnPIWoLhtfRc9LUSrnpxZoIorrdcuQyxJMkccznDgJksd7pUzAd8x5
	aH551JHzBfP6Ox3NiTC73addMWpwAOLMOncYTzzckVftNCzS/QKJeiZt0QZnAE6FjDJlAF6tph/29
	4+O75rEmA0zcoXRvffxlrcbacPh7tuWRuX0Kb3c8+VkeRujPJXQ4B+GYJL/RX/ittkARmSe9S8b+w
	PI3HrQBw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rpyOU-0000000Fy4I-0yNm;
	Thu, 28 Mar 2024 22:38:46 +0000
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rpyOQ-0000000Fy3G-2USf
	for linux-nvme@lists.infradead.org;
	Thu, 28 Mar 2024 22:38:44 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 048F6CE26D6;
	Thu, 28 Mar 2024 22:38:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C58E2C433F1;
	Thu, 28 Mar 2024 22:38:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711665520;
	bh=VmmipSPvKCh4HSGbBCJ49hCyh1IaCoVaMfEsMghh+ts=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=cpqrxBLld5KuuWt+1Jeok7tuSZMfX+iVDt6cYmfC4YiIiSelqAYl2+xicbIzHddhC
	 t+o+20xk2p4IxiCV+uOkvkD8aKz/+/A/53LJZJ7muz+82dIj+6w9YOQxnbdBNhJd+S
	 m0RNYVtCAfMnTTFbQK0BGQ4TIPG0oHVxD6Jnk2CsiT9cAKQHUjTlHfX2zwqqxwNn7t
	 MVq6BTF9Q69b/FWK8gh5SrwnGmTiys4ZnQZO3V4t9fztoAJ6yje0B+nHbtdddkp3pD
	 hpxy39ohw+4XFbkWStrXwXOI/wYqm/6t6Alh1DDToZtuj2pdJXE4GD3KdWvF42EC8Z
	 R7FEjFkp2P35g==
Message-ID: <caf50c25-8f3d-4eb1-85bc-cc3499d5b107@kernel.org>
Date: Fri, 29 Mar 2024 07:38:37 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 08/30] block: Introduce zone write plugging
To: Bart Van Assche <bvanassche@acm.org>, linux-block@vger.kernel.org,
 Jens Axboe <axboe@kernel.dk>, linux-scsi@vger.kernel.org,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 dm-devel@lists.linux.dev, Mike Snitzer <snitzer@redhat.com>,
 linux-nvme@lists.infradead.org, Keith Busch <kbusch@kernel.org>,
 Christoph Hellwig <hch@lst.de>
References: <20240328004409.594888-1-dlemoal@kernel.org>
 <20240328004409.594888-9-dlemoal@kernel.org>
 <688607d9-6dfe-4c37-81e8-4fea91ec8da8@acm.org>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <688607d9-6dfe-4c37-81e8-4fea91ec8da8@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240328_153843_090622_ECBE9925 
X-CRM114-Status: GOOD (  18.01  )
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

On 3/29/24 07:20, Bart Van Assche wrote:
>> +static void disk_zone_wplugs_work(struct work_struct *work)
>> +{
>> +	struct gendisk *disk =
>> +		container_of(work, struct gendisk, zone_wplugs_work);
>> +	struct blk_zone_wplug *zwplug;
>> +	unsigned long flags;
>> +
>> +	spin_lock_irqsave(&disk->zone_wplugs_lock, flags);
>> +
>> +	while (!list_empty(&disk->zone_wplugs_err_list)) {
>> +		zwplug = list_first_entry(&disk->zone_wplugs_err_list,
>> +					  struct blk_zone_wplug, link);
>> +		list_del_init(&zwplug->link);
>> +		blk_get_zone_wplug(zwplug);
>> +		spin_unlock_irqrestore(&disk->zone_wplugs_lock, flags);
>> +
>> +		disk_zone_wplug_handle_error(disk, zwplug);
>> +		disk_put_zone_wplug(zwplug);
>> +
>> +		spin_lock_irqsave(&disk->zone_wplugs_lock, flags);
>> +	}
>> +
>> +	spin_unlock_irqrestore(&disk->zone_wplugs_lock, flags);
>> +}
> 
> What is the maximum number of iterations the above while loop can 
> perform? I'm wondering whether a cond_resched() call should be added.

The loop will go on as long as there are plugged BIOs and they can be merged,
that is, as long as the request does not exceed the queue limits. So this is all
limited naturally by the queue limits.

>> +	/* Wait for the zone write plugs to be RCU-freed. */
>> +	rcu_barrier();
>> +}
> 
> It is not clear to me why the above rcu_barrier() call is necessary? I'm
> not aware of any other kernel code where kfree_rcu() is followed by an
> rcu_barrier() call.

Right after that, the mempool (in v4, free list here) is destroyed. So the
rcu_barrier() is needed to ensure that the grace period is past and that all
plugs are back in the pool/freelist. Without this, I saw problems/crashes when
removing devices.

>> +static int disk_alloc_zone_resources(struct gendisk *disk,
>> +				     unsigned int max_nr_zwplugs)
>> +{
>> +	unsigned int i;
>> +
>> +	disk->zone_wplugs_hash_bits =
>> +		min(ilog2(max_nr_zwplugs) + 1, BLK_ZONE_MAX_WPLUG_HASH_BITS);
> 
> If max_nr_zwplugs is a power of two, the above formula will result in a
> hash table with a size that is twice the size of max_nr_zwplugs.

Yes, that is in purpose, to avoid hash collisions as much as possible.

> Shouldn't ilog2(max_nr_zwplugs) + 1 be changed into
> ilog2(roundup_pow_of_two(max_nr_zwplugs))?

I think it should be:

ilog2(roundup_pow_of_two(max_nr_zwplugs)) + 1

-- 
Damien Le Moal
Western Digital Research


