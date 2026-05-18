Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF65ECD4F52
	for <linux-nvme@archiver.kernel.org>; Mon, 18 May 2026 10:30:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:References:Cc:To:Subject:From:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=yBM/MqSlhfscJgewJTDJnR/WZOfF3ZaH9qUvK+mYr0I=; b=gm7yhTXpalBin7j4Nzh6XMfNNO
	c0e2PujvqYmQqh0zw4KCS1ndmL2hCNMlmjky/CE2ILBKKzncCiRJ0Om1w9o3MWj10yuLVwhOfsXR6
	1yTcz82ivaRRtFSjvW8os3Nkq2OZCh0ulnBwmOZfEFEEGHQ8LGxDws2SUhHXawBn87q48E9N1v92o
	lZziiwxEeZ/rxNRUAV72vNLzryM/+7wxdrzyaB5ltQqoRDDPuamtEDDj/LPhi2gQDlkz0w+B65Ib1
	eIgS1O43jfBa3o+qpKnx0tsoJqLQIf7BgRiN8j6qag2Y3G7WhqcYbmMIBU8Sw2XP/mXQi21Io9AmR
	37ecCJEQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wOvEZ-0000000FETC-05Na;
	Mon, 18 May 2026 10:30:03 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wOvEW-0000000FERv-3xRA
	for linux-nvme@bombadil.infradead.org;
	Mon, 18 May 2026 10:30:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:In-Reply-To:References:Cc:To:Subject:From:MIME-Version:Date:Message-ID:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=yBM/MqSlhfscJgewJTDJnR/WZOfF3ZaH9qUvK+mYr0I=; b=N7gI/AWKAZyQVqT7BIn0B5l84d
	Yo7jFjLCIIT5dRVu5fdbSSaofV/tbF2bqPHUmbe3JOEUum+5Gqb2rq7EsKmeGzNHIqzpC+yAesbO1
	wMTZS3PnqLGKVApre0Uqovk05L9MXy2ffbJB8c5ovsmKaoTLRynOZvF6a8xl9MIS6SAJ/VG+ZiJJR
	VihSAx1T83EfHL8pu/CgKevTxDPzIb/5774bIGkKaAJ3XmOwCF/Y5u4/fGJKBOEmZQG214dvAyQay
	dnOiJX1QHW9BFMQIR3qdaRQXlUsa0XdygCFqqh9Ur0h30bs2hkKm3ARRtb+Yz4k6jEyk5W5ffVAjS
	QNc3w0YQ==;
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
	by desiato.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wOvET-0000000AldJ-2NMG
	for linux-nvme@lists.infradead.org;
	Mon, 18 May 2026 10:29:59 +0000
Received: by mail-wr1-x42c.google.com with SMTP id ffacd0b85a97d-43eb05b1875so1060793f8f.3
        for <linux-nvme@lists.infradead.org>; Mon, 18 May 2026 03:29:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779100196; x=1779704996; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=yBM/MqSlhfscJgewJTDJnR/WZOfF3ZaH9qUvK+mYr0I=;
        b=grJFjG4Zcwyz4jcfSlpbilZVoaR3sTCeIrIfai0Rrk8oxUicD0LSsZU5B2HQ4oR2Lx
         l2KQvz/sg+6LAzcRj3mWzjMU2kMe2/fT0gLmw0VVHQ9aXml3x5lOHCdBHxLi2XPOVd+W
         FHXssnPftrLxHkEJuhV2zLJ8wiPgMb1glVEBvi1LXOEN9r45kiS9r6OuJDCndJM+frl4
         mPMblLdI1dJhS8Y0JqrR3bolRmNsKZt3Mb8dTJo+9Ln8CcBLmdbSIlUOEnDDUMXrx5vT
         2GoNeaYzN35EI61hGwnaQmxps0Sh4IND6VWqCHh9eOLwpiyb72i8ZUxJqkAXuXJmkKf/
         pkEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779100196; x=1779704996;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yBM/MqSlhfscJgewJTDJnR/WZOfF3ZaH9qUvK+mYr0I=;
        b=rwER/UPssjk2GtpblxJ4k9q3MAcVEwjOTHMLPziDM7OVjiKQ1nqkJOvM+eLzfX3T9p
         fXWZtphVvZ42R41qB019LF6q/7Won5r138PZnPeZ6IvSTe4gh18Mb1Rxe38vX4zWbvbz
         W5tiWB1evxRlYTGIrvO72hnCEYULD0LUsX6nrAzO6w7vdf3SGP8GroSmuuefdqI7dzIX
         tAh0aEvA+0SZRwkbcl26+nnuky/SEXaUYF5HhEnH8vQHFaQn3b+ACPt0uD52i7++rIKc
         ZiDL1/hTY+S1AK+oWPogqD6HsxxXb11QOM2b3VvCYGUdcnH6sgFF2Ph9eWFqJbh6lOPQ
         8XGA==
X-Forwarded-Encrypted: i=1; AFNElJ81fo78O3YeVIPolgaZJmtoA1qMCJARd/9z2aPyKypz/Wu6h86XK/kCPla0ld5oVdpHxxmzQ5mFBOli@lists.infradead.org
X-Gm-Message-State: AOJu0YyOU1RFKDHgQOVhcGSGQuruxScYGEbsoNXSqf+6kTT/fLr/3GGA
	fcwQKTMN1GLoWXoWvnKoP5F3+JrO/NXKopWxLIa2FmIuefBBeqeUW2wr
X-Gm-Gg: Acq92OGRiqmKP11OogUJESis6f7QUB7nKgi1uby7fpLoxDsJElUeuNDln4iFzUDYLNg
	Bw7+BoDGb0FYt51xzKSHY2P4VuW6ePqBpPBHw0IosgIYhozkmTlNqxN+8YcOUlUwQHxD5R92+C6
	Aak/qiIrQ7+WFblxY08bmAiQ/UCEhC8e25CTwf97DzZLw78BC53uiyKjxxwKxbJpt7uchb7nAHy
	rkHm0gY/QwYTS5IpT+DsiWhT5qKxNkvyesZdtUB2vuxxuDfmggzZ0bcnZ9111pvl+c4K7xwRK+9
	z7Mn0M2uy16Sa902WRDUePRNUFKjgPRZ9lHzZnZc/FW5Lyh2AK1ZuPV+vB4JDB5REon3VHrxKFw
	I7Bi+JNxuiThQIeaNiJKdJ+ED26OZtxy6btCZaSrbNCyNWFqrrvgAseF8yJSH+xq3KE8qTybPlJ
	Ed9PsMlt/JMahFiE1gW7mSWof9l676Z7ABEehyyGjgZNm5P/IKPKg7YdnxcbepEEnyZwi+1FxDW
	HPoTAckorA3JpGhsplhGgtKQfwBDH1uAd6Fp8zEeEYaUZ5X6Kof/1C4Z8w=
X-Received: by 2002:a5d:5885:0:b0:43c:f7e5:817b with SMTP id ffacd0b85a97d-45e5c5cc2b5mr22613508f8f.19.1779100196106;
        Mon, 18 May 2026 03:29:56 -0700 (PDT)
Received: from ?IPV6:2620:10d:c096:325:77fd:1068:74c8:af87? ([2620:10d:c092:600::1:ec20])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45da15a6454sm36537426f8f.34.2026.05.18.03.29.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 May 2026 03:29:55 -0700 (PDT)
Message-ID: <24833f76-2289-4859-86d1-9215b11a1258@gmail.com>
Date: Mon, 18 May 2026 11:29:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Pavel Begunkov <asml.silence@gmail.com>
Subject: Re: [PATCH v3 04/10] block: introduce dma map backed bio type
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
 Sagi Grimberg <sagi@grimberg.me>, Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org,
 io-uring@vger.kernel.org, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
 Nitesh Shetty <nj.shetty@samsung.com>, Kanchan Joshi <joshi.k@samsung.com>,
 Anuj Gupta <anuj20.g@samsung.com>, Tushar Gohad <tushar.gohad@intel.com>,
 William Power <william.power@intel.com>, Phil Cayton
 <phil.cayton@intel.com>, Jason Gunthorpe <jgg@nvidia.com>
References: <cover.1777475843.git.asml.silence@gmail.com>
 <646ecd6fde8d9e146cb051efb514deb27ce3883e.1777475843.git.asml.silence@gmail.com>
 <20260513081929.GD5477@lst.de>
Content-Language: en-US
In-Reply-To: <20260513081929.GD5477@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260518_112958_169880_BD10AFC9 
X-CRM114-Status: GOOD (  35.42  )
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

On 5/13/26 09:19, Christoph Hellwig wrote:
>> +	if (!bio_flagged(bio_src, BIO_DMABUF_MAP)) {
>> +		bio->bi_io_vec = bio_src->bi_io_vec;
>> +	} else {
>> +		bio->dmabuf_map = bio_src->dmabuf_map;
>> +		bio_set_flag(bio, BIO_DMABUF_MAP);
>> +	}
> 
> This is backwards, please avoid pointless negations:

I can flip it, but compilers tend to prefer the true branch. E.g. this

if (cond) A; else B;
C;

can get compiled into:

jmpcc cond B
A: ...
C:
return;
B: ...
jmp C;
  

> 
> 	if (bio_flagged(bio_src, BIO_DMABUF_MAP)) {
> 		bio->dmabuf_map = bio_src->dmabuf_map;
> 		bio_set_flag(bio, BIO_DMABUF_MAP);
> 	} else {
> 		bio->bi_io_vec = bio_src->bi_io_vec;
> 	}
> 
>> +	if (bio_flagged(bio, BIO_DMABUF_MAP)) {
>> +		nsegs = 1;
>> +
>> +		if ((bio->bi_iter.bi_bvec_done & lim->dma_alignment) ||
>> +		    (bio->bi_iter.bi_size & len_align_mask))
>> +			return -EINVAL;
>> +		if (bio->bi_iter.bi_size > max_bytes) {
>> +			bytes = max_bytes;
>> +			goto split;
>> +		}
> 
> Please add a comment explaining why nsegs is always 1 here.



> 
>> @@ -424,7 +424,8 @@ static inline struct bio *__bio_split_to_limits(struct bio *bio,
>>   	switch (bio_op(bio)) {
>>   	case REQ_OP_READ:
>>   	case REQ_OP_WRITE:
>> -		if (bio_may_need_split(bio, lim))
>> +		if (bio_may_need_split(bio, lim) ||
>> +		    bio_flagged(bio, BIO_DMABUF_MAP))
>>   			return bio_split_rw(bio, lim, nr_segs);
> 
> The BIO_DMABUF_MAP check should go into bio_may_need_split.

Ok
>> +static inline void bio_advance_iter_dmabuf_map(struct bvec_iter *iter,
>> +					       unsigned int bytes)
>> +{
>> +	iter->bi_bvec_done += bytes;
>> +	iter->bi_size -= bytes;
>> +}
>> +
>>   static inline void bio_advance_iter(const struct bio *bio,
>>   				    struct bvec_iter *iter, unsigned int bytes)
>>   {
>>   	iter->bi_sector += bytes >> 9;
>>   
>> -	if (bio_no_advance_iter(bio))
>> +	if (bio_no_advance_iter(bio)) {
>>   		iter->bi_size -= bytes;
>> -	else
>> +	} else if (bio_flagged(bio, BIO_DMABUF_MAP)) {
>> +		bio_advance_iter_dmabuf_map(iter, bytes);
> 
> This is a bit of a mess.  You're using bi_bvec_done for something that
> is not bvec_done, which makes the naming very confusing.  That is even
> more confusing than the existing usage, which isn't great.  Also we
> add yet another conditional to heavily inlined code.  I'd suggest
> the following:
> 
>   - add a prep patch to rename bi_bvec_done to bi_offset, as even for
>     the existing usage it is the offset into the current bio_vec as
>     much as it is the count of byes done, as those must be the same
>     and it is used both ways
>   - add a prep patch to also increase bi_offset for bio_no_advance_iter.
>     It is not actually use there, but incrementing it is harmless and
>     this will avoid a new special case
>   - please also documet this new usage in the commet in struct bvec_iter.
>   - then just add the dma buf mapping to the bio_no_advance_iter condition

I'll take a look

>   - figure out what to do about dm_bio_rewind_iter, which pokes into these
>     things that really should be block layer internal

Need to check what that is, but doesn't implement the interface and
is not supposed to ever see the dmabuf iterator.

>>   }
>> @@ -391,7 +403,7 @@ static inline void bio_wouldblock_error(struct bio *bio)
>>    */
>>   static inline int bio_iov_vecs_to_alloc(struct iov_iter *iter, int max_segs)
>>   {
>> -	if (iov_iter_is_bvec(iter))
>> +	if (iov_iter_is_bvec(iter) || iov_iter_is_dmabuf_map(iter))
>>   		return 0;
>>   	return iov_iter_npages(iter, max_segs);
>>   }
> 
> Please update the comment for this helper.
> 
>> @@ -322,6 +327,7 @@ enum {
>>   	BIO_REMAPPED,
>>   	BIO_ZONE_WRITE_PLUGGING, /* bio handled through zone write plugging */
>>   	BIO_EMULATES_ZONE_APPEND, /* bio emulates a zone append operation */
>> +	BIO_DMABUF_MAP, /* Using premmaped dma buffers */
> 
> Shouldn't this be a REQ_ flag as we should never mix and match bios with
> and without this flag in a single request?

Do you mean adding both and propagating it from bio to req? submit_bio()
takes a bio, so we still need to set it there before it reaches blk-mq.
And there might be bio-based drivers using it in the future.

-- 
Pavel Begunkov


