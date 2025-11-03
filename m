Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FE56CCF9FE
	for <linux-nvme@archiver.kernel.org>; Mon,  3 Nov 2025 06:00:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MeShHwfYHsP0cN4Utw1bJyhFh9Za1pXuKjGddIu6RCA=; b=Zrr6WBWMcUyiuIwIwsZzMinvH2
	d4sTiv9Te8+rwTCVIHrslL3f6VIe9EuLh2IL0vXpBGNOYHxniHpb5xQgY//EcCEyx2uteqa3GTuaI
	W8XGY+I3A8y4PlGPt9YiqWI4I6/zzwnjCUBYjZwyaAEXX89PaYWVgR+BHS1dbNGFVuUbCF+CG16Aw
	+6S5Og5MkzvHgtaw0FN5eIRP9d6Gmqyg3SjQf3bWWPIbAQo9lk9W8Rklql7LqzkLboY55wp07SNWt
	FolZSPl+7ZHJ6S0D/M0Iiwm8M2FXa7mwxDU38M4D3VsrSEmDx21q2MIfCYOSEi9grGQo5/JCG1VOX
	PqpBg/RA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vFnc6-00000009GHd-2qLe;
	Mon, 03 Nov 2025 06:00:22 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vFnc4-00000009GHJ-2wOr
	for linux-nvme@lists.infradead.org;
	Mon, 03 Nov 2025 06:00:21 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id C0D9F40202;
	Mon,  3 Nov 2025 06:00:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43C97C4CEFD;
	Mon,  3 Nov 2025 06:00:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762149619;
	bh=p2Qn4po+ucZZpdF+4sraqP/e42fkPU8F3JmWnvC9xhE=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=cS1HFYsjpa1jSq5E899UEJI+QpjsxEPIS/p8PgTl5xhMRcfHXoVoGRgo08hFcggFZ
	 H3XF6d8yT2xLdjp6aUPAOIFS7brVlkAbJEnwUoT+vcPUWIRIcQscYaS3xczCy5dMQp
	 C9D87r7q59xQrjFrdziFaIhSjTajj2ngyBAJ0MRiALGeN+XMdA+GTrMFJXOOzHKseN
	 jERIRt/6sOFEB+jHsEjEe4z2Mwn4IF0UR3cvf9B76a8REvXl4w3jUgteZN0aIJ+7ZQ
	 +qbaNN+9OfoqyTvG1+4v+zQ0VMKgp0r6EQsY6rPRzGuNcSIpQayoORPVkJC8lxycX4
	 p7o/RjFCVs00Q==
Message-ID: <e899d483-200a-4900-b272-497ccf3be3bb@kernel.org>
Date: Mon, 3 Nov 2025 15:00:15 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/13] block: use zone condition to determine conventional
 zones
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
 <20251031061307.185513-7-dlemoal@kernel.org>
 <86891fd3-b850-4835-8a53-d1a2425c70e7@acm.org>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <86891fd3-b850-4835-8a53-d1a2425c70e7@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251102_220020_784396_2B7E02AF 
X-CRM114-Status: UNSURE (   9.84  )
X-CRM114-Notice: Please train this message.
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

On 11/1/25 06:04, Bart Van Assche wrote:
>>   static int disk_revalidate_zone_resources(struct gendisk *disk,
>> -					  unsigned int nr_zones)
>> +				struct blk_revalidate_zone_args *args)
>>   {
>>   	struct queue_limits *lim = &disk->queue->limits;
>>   	unsigned int pool_size;
>>   
>> +	args->disk = disk;
>> +	args->nr_zones =
>> +		DIV_ROUND_UP_ULL(get_capacity(disk), lim->chunk_sectors);
>> +
>> +	/* Cached zone conditions: 1 byte per zone */
>> +	args->zones_cond = kzalloc(args->nr_zones, GFP_NOIO);
>> +	if (!args->zones_cond)
>> +		return -ENOMEM;
> 
> Why args->nr_zones as array size instead of args->nr_conv_zones? The
> patch description says that this array is only used for conventional
> zones.

The bitmap before was of nr_zones bits, because conventional zones can be
anywhere in the LBA space. The same is still true using zone conditions. We need
one condition per zone for all zones.

-- 
Damien Le Moal
Western Digital Research

