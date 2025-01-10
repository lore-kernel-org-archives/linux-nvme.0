Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E8F5E7719C
	for <linux-nvme@archiver.kernel.org>; Fri, 10 Jan 2025 10:00:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jOZgEjWV1TP6jYXRn+RNcJWdu046GUntYBhc7e0VB9I=; b=V6yHLVoGyqBV2mXgjO46v5wQav
	AaCzNFiwid7PWi8YbPGne+CBxwO+BGFvCN5DgFBSVLmQsLvocyIvzZT0gj9XhrTGawfrqUz2EHc9K
	jnLwTQKASmxNLnxsg2SjNvAKnL07AP0CLfg3QCB4tGR7dpfsBHC734nSYwmFWNqHIhIcsXYtJS1kx
	ovKMpI+T+LpsG7LkrGqu/Y8l0CGkIte0YRQH1HunKyrms83mSdZTJLuMv16mEdOGIaeW4HF7JzcI6
	w+Q9swiv4Y9kPtnDdITePdcLexFc3lTws6X1as4fbW0PAxMHqAze4tUocsVXjzl0g0QqbtbkoXlMe
	Bh2HtbTg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tWBoU-0000000Eqv1-2LlH;
	Fri, 10 Jan 2025 10:00:22 +0000
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tWBm5-0000000EqZe-185E
	for linux-nvme@lists.infradead.org;
	Fri, 10 Jan 2025 09:57:54 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 10E31A41C38;
	Fri, 10 Jan 2025 09:56:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BE57C4CED6;
	Fri, 10 Jan 2025 09:57:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736503072;
	bh=Ahu3Dj96KxIjB1xjdFeJU1rYT88XOcVzEVQ7DyN66M8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=nNFYg8qjo580eFZxxDoYZpxhYQGkf0D87WqqbLMa5KZ13hqmud4O3xBZb50SKG4ec
	 gDh3vn734bXAldYZFUP3PUBXTMPWHs7X9oDJp1PKnw9SJX8J3gSDYlRRntLbGUQBhM
	 4ZTf9aQW1+ql/1pDuuzP3ZhfU11nDXoeAJxewVFwrGXq/vaTS08CZ6dnFBm/g5gLxM
	 aD0+wO+1sbAx8Z6cKTkHriQfBH+WqXzPY1w1nRNPiZnBOwiJbpKLjnB3ZkGx0yfghc
	 sGj4kRcDO5VHKtBxxWVoYpb63rwtJJzMlkr/4Ulz8CzQ8AJNae9MioAuBGr4Qx4U/H
	 hu72t/BZ5t8gw==
Message-ID: <d7db7620-1f2e-4216-8929-2cfd4d847447@kernel.org>
Date: Fri, 10 Jan 2025 18:57:48 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/11] block: add a store_limit operations for sysfs
 entries
To: John Garry <john.g.garry@oracle.com>, Christoph Hellwig <hch@lst.de>,
 Jens Axboe <axboe@kernel.dk>
Cc: Ming Lei <ming.lei@redhat.com>, Nilay Shroff <nilay@linux.ibm.com>,
 linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
 nbd@other.debian.org, linux-scsi@vger.kernel.org,
 usb-storage@lists.one-eyed-alien.net,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 Johannes Thumshirn <johannes.thumshirn@wdc.com>
References: <20250110054726.1499538-1-hch@lst.de>
 <20250110054726.1499538-6-hch@lst.de>
 <79d85a4e-57c3-454e-a65b-d2a3764eaf0c@oracle.com>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <79d85a4e-57c3-454e-a65b-d2a3764eaf0c@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250110_015753_372649_78287DAD 
X-CRM114-Status: GOOD (  12.55  )
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

On 2025/01/10 18:56, John Garry wrote:
> On 10/01/2025 05:47, Christoph Hellwig wrote:
>> -static ssize_t queue_iostats_passthrough_store(struct gendisk *disk,
>> -					       const char *page, size_t count)
>> +static int queue_iostats_passthrough_store(struct gendisk *disk,
>> +		const char *page, size_t count, struct queue_limits *lim)
>>   {
>> -	struct queue_limits lim;
>>   	unsigned long ios;
>>   	ssize_t ret;
>>   
>> @@ -284,18 +269,13 @@ static ssize_t queue_iostats_passthrough_store(struct gendisk *disk,
>>   	if (ret < 0)
>>   		return ret;
>>   
>> -	lim = queue_limits_start_update(disk->queue);
>>   	if (ios)
>> -		lim.flags |= BLK_FLAG_IOSTATS_PASSTHROUGH;
>> +		lim->flags |= BLK_FLAG_IOSTATS_PASSTHROUGH;
>>   	else
>> -		lim.flags &= ~BLK_FLAG_IOSTATS_PASSTHROUGH;
>> -
>> -	ret = queue_limits_commit_update(disk->queue, &lim);
>> -	if (ret)
>> -		return ret;
>> -
>> -	return count;
>> +		lim->flags &= ~BLK_FLAG_IOSTATS_PASSTHROUGH;
>> +	return 0;
>>   }
> 
> BTW, this function seems to duplicate queue_feature_store(), no?
> 
> I mean, why not:
> 
> static int queue_iostats_passthrough_store(struct gendisk *disk,
> const char *page, size_t count, struct queue_limits *lim)
> {
> 	return queue_feature_store(disk, page, count, lim,
> 		BLK_FLAG_IOSTATS_PASSTHROUGH);
> }
> 
> I think that there is even a macro for this.

Another cleanup to add to the pile I guess :)

-- 
Damien Le Moal
Western Digital Research

