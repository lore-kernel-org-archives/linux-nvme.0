Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2155CD4F5E
	for <linux-nvme@archiver.kernel.org>; Wed, 20 May 2026 07:25:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:References:Cc:To:From:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3EXRf90F3NIf0vpzm2+B3zmIOv3+pIuhyTPmYpY2Fdg=; b=uULaYtNBlpWVQN6o7ZOQHFICYB
	QVPEOTYerVSA2LcvyWLaxv7LOBm2JpYixDIeeWhxezWQyS9PHHGEocyXfh//yXnh4KYkjvY1LO68k
	6myyxYl48/tt7IEtgiwBFJRjI4OwtwXrHRCJ30CO7i63FX7u2uxfjmS/kD/SYvfOsM4+v5muu4Xwj
	CRaMpa0D/t9wGTXcN7JWYRQyZb/1ue5Hl5gqQMj11uCPMumCabPuLIXstQBvIjpBo4xnyEjtaqUJM
	h4wvX35152HU0c0Ow5h98YGbjaL60YMfj/5dUBIT6MiGaExCJdKfDpUaXPEajcQFojn0QWxWrUd0f
	5SHWz17g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wPbIu-00000003n3a-1hI2;
	Wed, 20 May 2026 07:25:20 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wPbIr-00000003n2t-3MXr
	for linux-nvme@lists.infradead.org;
	Wed, 20 May 2026 07:25:19 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 54FF940448;
	Wed, 20 May 2026 07:25:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 554C31F000E9;
	Wed, 20 May 2026 07:25:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779261917;
	bh=3EXRf90F3NIf0vpzm2+B3zmIOv3+pIuhyTPmYpY2Fdg=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To;
	b=n4T1e26csx6yuaEDmSHKcAhcTnAZJtfAAMu4hkXy6fR+obFrkVXaU7x8v49Ocu8pa
	 /O6QkBYKz5swby9vZwlvMKHtKyc6ugzA3V8UDZucjalYCoCCsa4icKo+QyFEkiUOB7
	 mR0NiEv7kIpTIZZxRSIdhYPW3JB4IL2FDB5CmAZILmRZhqMo0v3xigkz6aYiX638FI
	 c7JdiO3/NbxZzEOT6d5EDAR4Yhe4w4e+lpGL4yLTxVJ+Fpmq2SjAwMpvui/i8i4XLp
	 0awV8+7MxoJd+s92oYaN0xYQ0fkY/TVFPFV/ehnYyq+WlpM+7cc1jm0jETWFINXeHB
	 9+evhWUl4qbQA==
Message-ID: <4a54185e-dbc2-454c-aad7-c64919bd5728@kernel.org>
Date: Wed, 20 May 2026 09:25:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 3/5] block: validate bio bounds in the queue entered
 context
From: Damien Le Moal <dlemoal@kernel.org>
To: Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org
Cc: axboe@kernel.dk, hch@lst.de, tom.leiming@gmail.com, coshi036@gmail.com,
 Igor.Achkinazi@dell.com, Keith Busch <kbusch@kernel.org>
References: <20260519172326.3462354-1-kbusch@meta.com>
 <20260519172326.3462354-4-kbusch@meta.com>
 <03564da7-661e-40ea-9a11-8b96972f1048@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <03564da7-661e-40ea-9a11-8b96972f1048@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260520_002517_937689_8A8F7D97 
X-CRM114-Status: GOOD (  22.73  )
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

On 2026/05/20 9:22, Damien Le Moal wrote:
> On 2026/05/19 19:23, Keith Busch wrote:
>> From: Keith Busch <kbusch@kernel.org>
>>
>> bio_check_eod() in submit_bio_noacct() validates that a bio does not
>> extend beyond the partition's available sectors. This check runs before
>> bio_queue_enter(), so it is not serialized against queue limit updates.
>> A driver that freezes the queue, updates limits, changes the capacity,
>> and unfreezes can race with a bio that passed the early check under the
>> old capacity.
>>
>> Remove bio_check_eod() and replace it with a bounds check in
>> __bio_split_to_limits(), which runs after the queue usage reference has
>> been acquired. The check uses partition-aware arithmetic to validate
>> both partition bounds and disk capacity in a single comparison that
>> works correctly on the post-remap sector values.
>>
>> Signed-off-by: Keith Busch <kbusch@kernel.org>
> 
> [...]
> 
>> @@ -423,6 +423,17 @@ static inline bool bio_may_need_split(struct bio *bio,
>>  static inline struct bio *__bio_split_to_limits(struct bio *bio,
>>  		const struct queue_limits *lim, unsigned int *nr_segs)
>>  {
>> +	if (unlikely(bio_end_sector(bio) > bdev_nr_sectors(bio->bi_bdev) +
>> +					   bio->bi_bdev->bd_start_sect)) {
>> +		pr_info_ratelimited("%s: attempt to access beyond end of device\n"
>> +				    "%pg: rw=%d, sector=%llu, nr_sectors = %u limit=%llu\n",
>> +				    current->comm, bio->bi_bdev, bio->bi_opf,
>> +				    bio->bi_iter.bi_sector, bio_sectors(bio),
>> +				    bdev_nr_sectors(bio->bi_bdev) +
>> +					bio->bi_bdev->bd_start_sect);
> 
> Should this be a pr_err_ratelimited() ?
> 
> Also, putting this check here means that we are going to redo the check for all
> the fragment of the large BIO being split, no ? It would be nice to be able to
> do this check only once when the large BIO is submitted.
> 
> Moving this check to a helper and calling this new helper higher in the
> submission path could avoid that. But I am not 100% sure if a higher placed call
> can be a problem.

Replying to myself: We do not yet have called queue enter higher up. So moving
this check defeats your goal. Please ignore this comment :)

>> +		goto ioerr;
>> +	}
>> +
>>  	switch (bio_op(bio)) {
>>  	case REQ_OP_READ:
>>  	case REQ_OP_WRITE:
>> @@ -442,6 +453,9 @@ static inline struct bio *__bio_split_to_limits(struct bio *bio,
>>  		*nr_segs = 0;
>>  		return bio;
>>  	}
>> +ioerr:
>> +	bio_io_error(bio);
>> +	return NULL;
>>  }
>>  
>>  /**
> 
> 


-- 
Damien Le Moal
Western Digital Research

