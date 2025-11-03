Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E9F1CCF9F8
	for <linux-nvme@archiver.kernel.org>; Mon,  3 Nov 2025 06:13:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gJmuXVnUo9+0gPFoaRx8vcQ3oLCwkJD/KvkAlDJhpuk=; b=ryYWS8/djCyZFgZG5dY1Dp6JNd
	eCpqBgJlw/jppyMyXV0/sJ9wqcD8LWsZ6IuSGwffwlBJmgFZoqh4gA3/5tXBqFMYreSQR6j02FxK3
	sbV1fG9wgcf7QrHqV0o6YBzUV94w8wTvQw+7L5POoWCihfL/1Env/7tXvFOriWdTS4QeezLmKFusS
	5WhW2ugLJdxh8mxjYE8ymyHWVw7b3YGUD+ShVdBKt/qbqV2qun9pPctXREvKwCAwK5YabdRsuEht/
	eQtY5TGxZ+7mjtzImka+VNi3L4Vc44m6Q/R6cfpw+AO9VnIYN5vm/1eFR4OIF/y0SxAJK34qW2agi
	iSCBxsqw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vFnoN-00000009HGh-0tG6;
	Mon, 03 Nov 2025 06:13:03 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vFnoL-00000009HGX-3HTd
	for linux-nvme@lists.infradead.org;
	Mon, 03 Nov 2025 06:13:01 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 09C3B601A6;
	Mon,  3 Nov 2025 06:13:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD7C8C4CEFD;
	Mon,  3 Nov 2025 06:12:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762150380;
	bh=n6EN2P2gP5X9cBVibE23fs0PdgP3/6dDNF9i/yYXrDU=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=ZKSXU+2KlmgkRvdjhyKMf91LpddVvRgJbcftB10f8mk2CYDCx1MwZG0Q7KJrBq7nB
	 gjo80h0H9U8U/gXeiMAoHddLhgD44D53a25UU3gg1ovFXZ0qSvvXaAtbWCmV00eR1n
	 jhVEQHGazUPtk998upWx+xW/DzK0uHNzaHeecj45g8gGS3TN9vp4YcA/VZxeyoO+7o
	 p/9aV7KduLZeNnf07QwACpqeq+Zvb534q4xsqRYPBAqIWMcwdmJRXXOlj+SZ35ohp0
	 IgL+DCCNg6RimK/WOvNedKg8AQdbodMqmKJ7CVNh5hHJRNHJczweBCEcy1pjbe226p
	 g2ZLsG9OgUN/A==
Message-ID: <02990d98-060e-44b9-8800-b6787449855d@kernel.org>
Date: Mon, 3 Nov 2025 15:12:56 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/13] block: introduce blkdev_report_zones_cached()
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
 <20251031061307.185513-10-dlemoal@kernel.org>
 <4287484a-3a3d-4f50-9c5b-7a901458bfbc@acm.org>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <4287484a-3a3d-4f50-9c5b-7a901458bfbc@acm.org>
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

On 11/1/25 06:53, Bart Van Assche wrote:
>> +	for (sector = ALIGN(sector, zone_sectors);
>> +	     sector < capacity && idx < nr_zones;
>> +	     sector += zone_sectors, idx++) {
> 
> Please change "sector = ALIGN(sector, zone_sectors)" into an something
> based on bdev_offset_from_zone_start(), e.g. the following code:
> 
> 	sector += zone_sectors - 1;
> 	sector -= bdev_offset_from_zone_start(bdev, sector);

Why ? That is a lot harder to understand that what we are doing is align to the
zone start. And your proposed code is not correct anyway as we would miss one
zone (the zone containing sector) if sector is not already aligned to the zone
start.

-- 
Damien Le Moal
Western Digital Research

