Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6423E77198
	for <linux-nvme@archiver.kernel.org>; Mon,  6 Jan 2025 10:47:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=k2K3X6sigu55xL8acrs374nEKXrh84KNRiSg+bvqjgM=; b=fI4EJVpobQ7+4HbJOU0FFA6L7N
	3VuhTFMlERK+E/ijZbgzgvdaKl1iqn+pn1REPFRJEDAX/vYSwjKCEDor/u1MHiVZ+7zWgbikdz/6g
	BG59WXpY+ebkGbPze5hmRvmR6YEjJZtAdM8pIlEsEpk4gTzgggcCdXe2vkUfwwW0eR6IPtREzeX8r
	JFoXXz8gBeZ+XOGr665kgFED7VWVZisXjZU3yplh/Oo6uexUFfgSLd9U2rQ6iZKxoboKnqDDBpjgw
	TZBc4qQbqjlewHLgbISl/K9bHQk25b/4AdQ840zY0ogWNIgwpa7Tp3xfhwiY6FPWPUk0LY98jpldl
	jwnrC1jA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tUkdY-00000000uXE-2euG;
	Mon, 06 Jan 2025 10:47:08 +0000
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tUkdW-00000000uWF-2IlU
	for linux-nvme@lists.infradead.org;
	Mon, 06 Jan 2025 10:47:07 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id DEA38A41477;
	Mon,  6 Jan 2025 10:45:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D402C4CEDD;
	Mon,  6 Jan 2025 10:47:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736160425;
	bh=wej234ibZ1R8OLTpkTc9rxS5V8U0eLOGtXxAG8f0G9Q=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=QtMzyfuDr2WNgnvsHFz2I+5Ou4y6rqsWJjZ/PHVKqnL013v7PDKnnIUaTpUxxBneH
	 bb6oZLKYhNfPUaCgUIofZ+nJZAKLILSD41nmIXtic/DvtGzLHz5cIBWRcYtKermD8J
	 ZzjiokHMuU2Q7TTVFQmG9aOuuzCC5Vp8ePniWkR3PwEpBHGNPZi+r48oP0x7LOQAxK
	 2S4KCGRdrNmKdImmai72QHvLxq+PQah2S8cMd4tXmZWJ72b0Sgq3yR1wj4EB8Vf32P
	 Bo+ibYFAdtZVy7+36citiVsHaS1FduSGAwv+aZk06ZWiyGRuvIdEE9tExdorHxco5s
	 qEUq74Bc6OqpQ==
Message-ID: <a461bbbc-f251-4f44-89c7-f80f72e6e96d@kernel.org>
Date: Mon, 6 Jan 2025 19:46:19 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/10] block: add a store_limit operations for sysfs
 entries
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: Ming Lei <ming.lei@redhat.com>, Nilay Shroff <nilay@linux.ibm.com>,
 linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
 nbd@other.debian.org, virtualization@lists.linux.dev,
 linux-scsi@vger.kernel.org, usb-storage@lists.one-eyed-alien.net
References: <20250106100645.850445-1-hch@lst.de>
 <20250106100645.850445-4-hch@lst.de>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20250106100645.850445-4-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250106_024706_666277_44AA367A 
X-CRM114-Status: GOOD (  15.43  )
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

On 1/6/25 7:06 PM, Christoph Hellwig wrote:
> De-duplicate the code for updating queue limits by adding a store_limit
> method that allows having common code handle the actual queue limits
> update.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

[...]

> @@ -706,11 +687,24 @@ queue_attr_store(struct kobject *kobj, struct attribute *attr,
>  	if (entry->load_module)
>  		entry->load_module(disk, page, length);
>  
> -	blk_mq_freeze_queue(q);
>  	mutex_lock(&q->sysfs_lock);
> -	res = entry->store(disk, page, length);
> -	mutex_unlock(&q->sysfs_lock);
> +	blk_mq_freeze_queue(q);

The freeze must NOT be done for the "if (entry->store_limit)" case. So this
needs to go int the "else". Otherwise, you still have freeze the take limit
lock order which can cause the ABBA deadlocks in SCSI sd.

> +	if (entry->store_limit) {
> +		struct queue_limits lim = queue_limits_start_update(q);
> +
> +		res = entry->store_limit(disk, page, length, &lim);
> +		if (res < 0) {
> +			queue_limits_cancel_update(q);
> +		} else {
> +			res = queue_limits_commit_update(q, &lim);

Here you must use queue_limits_commit_update_frozen().

> +			if (!res)
> +				res = length;
> +		}
> +	} else {
> +		res = entry->store(disk, page, length);
> +	}
>  	blk_mq_unfreeze_queue(q);

And this one needs to go in the else after the call to entry->store().

> +	mutex_unlock(&q->sysfs_lock);
>  	return res;
>  }
>  


-- 
Damien Le Moal
Western Digital Research

