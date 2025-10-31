Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79D6ECCF9F8
	for <linux-nvme@archiver.kernel.org>; Fri, 31 Oct 2025 21:04:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/c16dfflmy6RT66JO+WNLJvbpbI4XJjSz2VckP1AEkA=; b=hUinG5MSLHDODwY+nbFai7SOv1
	SUr3RfU3uhVj5dTNOSiMQoclHnighDXB4XIjdCmz1IWLPVpUqX7cO7VG8OIjNmKWy3KIGHNMEK1qS
	CU5g5Xain44ZR7IxMGNqr2C4wB18fwAiiayMr7r2pFnE8zH0SxUjBhGf0gtxjpueqNegRAkj9+/fK
	CIfmL+VkrV6VnyjSMc2kOTnhykLfSjwDYPyBSjtl2G1t57nLKFjnF19f6uW2UiuIrXzlbrs0UorXc
	gbOZEEDkalgxvUVHJz7RcNjSmzC0tx/Z1e1ouN7V2bcpmXNbtWTX7xydhpcUS4ukebQCb12zvAjVu
	c89w9+vQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vEwIc-00000006oFA-35hH;
	Fri, 31 Oct 2025 21:04:42 +0000
Received: from 003.mia.mailroute.net ([199.89.3.6])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vEwIZ-00000006oEj-3bPF
	for linux-nvme@lists.infradead.org;
	Fri, 31 Oct 2025 21:04:41 +0000
Received: from localhost (localhost [127.0.0.1])
	by 003.mia.mailroute.net (Postfix) with ESMTP id 4cytlV600FzlvRxT;
	Fri, 31 Oct 2025 21:04:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1761944676; x=1764536677; bh=/c16dfflmy6RT66JO+WNLJvb
	pbI4XJjSz2VckP1AEkA=; b=lPApnpsVizIyhtRM8VRTmGlURuDIpT+Gac5CISyG
	wM1+kvE6tEcQUSuBFEcV/3mxhBEKErljRSh8C1J8uH/UM5x3+braVwiZi9DTet4f
	P5oocPTKp5xtxUWzA/sDBeJrEUbAbDWetZWYOMkRZwyiZpNDYNT2MNue8H3txL8h
	jZb51wqP2UDMyeD/f8XB9l5kx2pJUXAPDxY2nQwXOJrB0GHhMDqAsOMITXYrUwjD
	b0qJDRA5xY/Z1e6LDNWbrXiJqvX5t3HZ3WFjmnFzY8AN2dgfthK8OBuT82tYOJ/5
	gQ0IyyIafjPgpIBp+EcrP7yCj1X5Jk0TXA45BnZDyPFGeA==
X-Virus-Scanned: by MailRoute
Received: from 003.mia.mailroute.net ([127.0.0.1])
 by localhost (003.mia [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id AEPnnxVFG9zL; Fri, 31 Oct 2025 21:04:36 +0000 (UTC)
Received: from [100.119.48.131] (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 003.mia.mailroute.net (Postfix) with ESMTPSA id 4cytlF0jSlzlvm7K;
	Fri, 31 Oct 2025 21:04:24 +0000 (UTC)
Message-ID: <86891fd3-b850-4835-8a53-d1a2425c70e7@acm.org>
Date: Fri, 31 Oct 2025 14:04:23 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/13] block: use zone condition to determine conventional
 zones
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
 <20251031061307.185513-7-dlemoal@kernel.org>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20251031061307.185513-7-dlemoal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251031_140440_138746_7E97AB2E 
X-CRM114-Status: GOOD (  13.88  )
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

On 10/30/25 11:13 PM, Damien Le Moal wrote:
> zone. This increases the memory usage from 1 bit per zone to 1 bytes per

1 bytes -> 1 byte

> +bool bdev_zone_is_seq(struct block_device *bdev, sector_t sector)
> +{
> +	struct gendisk *disk = bdev->bd_disk;
> +	unsigned int zno = disk_zone_no(disk, sector);
> +	bool is_seq = false;
> +	u8 *zones_cond;
> +
> +	if (!bdev_is_zoned(bdev))
> +		return false;
> +
> +	rcu_read_lock();
> +	zones_cond = rcu_dereference(disk->zones_cond);
> +	if (zones_cond)
> +		is_seq = zones_cond[zno] != BLK_ZONE_COND_NOT_WP;
> +	rcu_read_unlock();
> +
> +	return is_seq;
> +}
> +EXPORT_SYMBOL_GPL(bdev_zone_is_seq);

'zno' should be compared to the size of the zones_cond[] array before
using 'zno' as an array index.

>   static int disk_revalidate_zone_resources(struct gendisk *disk,
> -					  unsigned int nr_zones)
> +				struct blk_revalidate_zone_args *args)
>   {
>   	struct queue_limits *lim = &disk->queue->limits;
>   	unsigned int pool_size;
>   
> +	args->disk = disk;
> +	args->nr_zones =
> +		DIV_ROUND_UP_ULL(get_capacity(disk), lim->chunk_sectors);
> +
> +	/* Cached zone conditions: 1 byte per zone */
> +	args->zones_cond = kzalloc(args->nr_zones, GFP_NOIO);
> +	if (!args->zones_cond)
> +		return -ENOMEM;

Why args->nr_zones as array size instead of args->nr_conv_zones? The
patch description says that this array is only used for conventional
zones.

>   	/*
>   	 * Some devices can advertize zone resource limits that are larger than

advertize -> advertise

Thanks,

Bart.

