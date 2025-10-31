Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90F28CCF9F8
	for <linux-nvme@archiver.kernel.org>; Fri, 31 Oct 2025 17:48:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nL551B3V05vqyW+XimcHYYij1ibWq2M2wbELFVqT4RY=; b=XFI0dwOBUfjEXUjc2M+Th0ulM1
	wk8m++5lyMMtdltf13mnQNHVJSdVe+MmQmDGzz6LjDoJttdqfYl9pTBO/mrLQRqlS9bAcjMiLboiK
	uilBSNmzQdC/IBvN09p9MhPW7EvG5r+nvibn4xNduIQe++hsvGfh6SC0ZZ9slKaXUeUggCySsM1dR
	d16anWR3yNys7+0d952cnY++k/KwuzIvzTSq+VpljOl+UbseMz2m4pCpCEQPbjdTOUilDhwVjvlYe
	HT3NuFgY5OyLbOWkd2V+qudJqVrH5aj0xCUJHpQGNeUFXbeYv2s5024B5nYtMTqq/mcVetYV+ZRB6
	rttZzxJw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vEtEb-00000006a1C-21YS;
	Fri, 31 Oct 2025 17:48:21 +0000
Received: from 003.mia.mailroute.net ([199.89.3.6])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vEtEX-00000006a0W-49yv
	for linux-nvme@lists.infradead.org;
	Fri, 31 Oct 2025 17:48:20 +0000
Received: from localhost (localhost [127.0.0.1])
	by 003.mia.mailroute.net (Postfix) with ESMTP id 4cypNw6qsGzlvq50;
	Fri, 31 Oct 2025 17:48:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1761932894; x=1764524895; bh=nL551B3V05vqyW+XimcHYYij
	1ibWq2M2wbELFVqT4RY=; b=mvnNsEhs1PPWUDvDh1SX4Y+85yPIV55ftsmKpUtx
	KVnPMtra7jXYM48vO8spgPf8PYvKVtDKtRs/W2vjRpaI3tPBqSwDA8sg0mU5GLoP
	+A2WlsZJ0L3olpHgjZY+hi8m/r9bfFHbBC6cmaaK57KjkKDXHGqnTpox8N0j3f2w
	Kv7FROAYchc9W4NAXiiRex4Tp4aFI38ASM4HaiuDVE6YQVnmc3YfBEfvbgFLLYyt
	nNIe18PmEAOOot6mCPZXgnniKmDOCwFblrpa/9FPFORTQXwBN/H6S6CqtDRHqieF
	/aM4eDxaxKcoyaz2Yt7riOOV4J4R1Cn3DmQ/3Gz/8gabtg==
X-Virus-Scanned: by MailRoute
Received: from 003.mia.mailroute.net ([127.0.0.1])
 by localhost (003.mia [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id taZA1Dyqq5Qm; Fri, 31 Oct 2025 17:48:14 +0000 (UTC)
Received: from [100.119.48.131] (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 003.mia.mailroute.net (Postfix) with ESMTPSA id 4cypNg6Wm3zltP0b;
	Fri, 31 Oct 2025 17:48:02 +0000 (UTC)
Message-ID: <55887a39-21ee-4e6c-a6f3-19d75af6395a@acm.org>
Date: Fri, 31 Oct 2025 10:48:01 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/13] block: freeze queue when updating zone resources
To: Damien Le Moal <dlemoal@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
 Keith Busch <keith.busch@wdc.com>, Christoph Hellwig <hch@lst.de>,
 dm-devel@lists.linux.dev, Mike Snitzer <snitzer@kernel.org>,
 Mikulas Patocka <mpatocka@redhat.com>,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 linux-scsi@vger.kernel.org, linux-xfs@vger.kernel.org,
 Carlos Maiolino <cem@kernel.org>, linux-btrfs@vger.kernel.org,
 David Sterba <dsterba@suse.com>
References: <20251031061307.185513-1-dlemoal@kernel.org>
 <20251031061307.185513-2-dlemoal@kernel.org>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20251031061307.185513-2-dlemoal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251031_104818_115345_DC9C5DB0 
X-CRM114-Status: GOOD (  22.43  )
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

On 10/30/25 11:12 PM, Damien Le Moal wrote:
> Modify disk_update_zone_resources() to freeze the device queue before
> updating the number of zones, zone capacity and other zone related
> resources. The locking order resulting from the call to
> queue_limits_commit_update_frozen() is preserved, that is, the queue
> limits lock is first taken by calling queue_limits_start_update() before
> freezing the queue, and the queue is unfrozen after executing
> queue_limits_commit_update(), which replaces the call to
> queue_limits_commit_update_frozen().
> 
> This change ensures that there are no in-flights I/Os when the zone
> resources are updated due to a zone revalidation.
> 
> Fixes: 0b83c86b444a ("block: Prevent potential deadlock in blk_revalidate_disk_zones()")
> Cc: stable@vger.kernel.org
> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
> ---
>   block/blk-zoned.c | 19 ++++++++++++++-----
>   1 file changed, 14 insertions(+), 5 deletions(-)
> 
> diff --git a/block/blk-zoned.c b/block/blk-zoned.c
> index 5e2a5788dc3b..f3b371056df4 100644
> --- a/block/blk-zoned.c
> +++ b/block/blk-zoned.c
> @@ -1516,8 +1516,13 @@ static int disk_update_zone_resources(struct gendisk *disk,
>   {
>   	struct request_queue *q = disk->queue;
>   	unsigned int nr_seq_zones, nr_conv_zones;
> -	unsigned int pool_size;
> +	unsigned int pool_size, memflags;
>   	struct queue_limits lim;
> +	int ret;
> +
> +	lim = queue_limits_start_update(q);
> +
> +	memflags = blk_mq_freeze_queue(q);
>   
>   	disk->nr_zones = args->nr_zones;
>   	disk->zone_capacity = args->zone_capacity;
> @@ -1527,11 +1532,10 @@ static int disk_update_zone_resources(struct gendisk *disk,
>   	if (nr_conv_zones >= disk->nr_zones) {
>   		pr_warn("%s: Invalid number of conventional zones %u / %u\n",
>   			disk->disk_name, nr_conv_zones, disk->nr_zones);
> -		return -ENODEV;
> +		ret = -ENODEV;
> +		goto unfreeze;
>   	}
>   
> -	lim = queue_limits_start_update(q);
> -
>   	/*
>   	 * Some devices can advertize zone resource limits that are larger than
>   	 * the number of sequential zones of the zoned block device, e.g. a
> @@ -1568,7 +1572,12 @@ static int disk_update_zone_resources(struct gendisk *disk,
>   	}
>   
>   commit:
> -	return queue_limits_commit_update_frozen(q, &lim);
> +	ret = queue_limits_commit_update(q, &lim);
> +
> +unfreeze:
> +	blk_mq_unfreeze_queue(q, memflags);
> +
> +	return ret;
>   }
>   
>   static int blk_revalidate_conv_zone(struct blk_zone *zone, unsigned int idx,

Hi Damien,

disk_update_zone_resources() only has a single caller and just below the
only call of this function the following code is present:

	if (ret) {
		unsigned int memflags = blk_mq_freeze_queue(q);

		disk_free_zone_resources(disk);
		blk_mq_unfreeze_queue(q, memflags);
	}

Shouldn't this code be moved into disk_update_zone_resources() such that
error handling happens without unfreezing and refreezing the request
queue?

Thanks,

Bart.

