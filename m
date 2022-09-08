Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FB95C54EE9
	for <linux-nvme@archiver.kernel.org>; Thu,  8 Sep 2022 15:00:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=eeIoDIdI2MvXvI2TC9JGJLL/O+kcb8qvz/17unZ7Ig8=; b=uZNG2UlUmbWUMS2yrI/6JOoXGJ
	TvOSiKqrZi5ulhLnrP3fc3Iz3tnAg0VMG3Q+AVA8o26x4Reg048n0PI+oK4InhBBd2rcjCeeKPwSj
	T+ugxIfB8ii2uBwCgCJD+I1Qf/V/oJqFkcp3POfL4nfvW8K/gCq6eE7tkKC6lNEkl+qd2mr6dfkrQ
	Tdj0JBNdXn/S3o6yeZGxRwOdFn/hGqq/nhpCWl5eEI4ZYJXiO+cqoOI5ebtulF0lBveiIRtTG6wGH
	MlLCFatnIreaE9t5lGZ6ZhHmabRKGvcCHMpCyBYPM2AMzJuysfAq/HwEtOZtNzOhrD3O3h8gSGlUS
	+FYdJ//Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oWJ17-004zsM-QT; Thu, 08 Sep 2022 15:00:34 +0000
Received: from mail-io1-xd2c.google.com ([2607:f8b0:4864:20::d2c])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oWInr-004s0J-0n
	for linux-nvme@lists.infradead.org; Thu, 08 Sep 2022 14:46:53 +0000
Received: by mail-io1-xd2c.google.com with SMTP id z191so138047iof.10
        for <linux-nvme@lists.infradead.org>; Thu, 08 Sep 2022 07:46:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=eeIoDIdI2MvXvI2TC9JGJLL/O+kcb8qvz/17unZ7Ig8=;
        b=kYwGkuEn2GEcHBJoQCTLhF3KAE4/UyLj2YgnRN/RU1YwtO3XeXbsdjsVG2x5AdpNRG
         FFF4HHdrcPldrYYc6VQHpYtHjK6ITDuDoW1N05Hxievx+F60QwFkTuk4KmSXs15rRPil
         Y6Oo07wLtMnhx5/m58K9lBoVBPg2t2YMrQem4jY6CdcYHAvV3kHOSviBnSKTjUhAEO1M
         wrKuNUdia5TmrgvgxJFsbGrK4hxcHirsYbwYuwsih9WqOHenoM8Oq6y/mCO0Lb8b0+g4
         f0vw213OKGZQCSWusFDlwbIPNpLA9IDNDO61GSMojuUUGUqCwTcb9DPpdjelakAkftT4
         WMbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=eeIoDIdI2MvXvI2TC9JGJLL/O+kcb8qvz/17unZ7Ig8=;
        b=mnc/gmJejvdM/fwQXsAjyeAHdYn1qTnVjoDiZZ7oov76bWS5mnn8V5UtEhF3r0X/Dq
         gqhAsQwZX7PhZ7SSfaTtjw+QeUSdbGPxTdnGoo9IJa2bWFaJPFTpBYNdXQgbKEkRloWS
         moJE6GOyL/nExL9cP3wECcg3W0/SoRw9R4zV9zxnlZKdu/jf3LIJuwL/490YMBhrGThW
         JiOxQTkRrpcc3o28AejzmHmC1J5uPYCIjknmRy3Ty+Pq3f6GzMAsPPWKvnvw6LXo3KYJ
         6DBAlFSi7jf+ioFKVfnx7RSISqaGpp+zyWpRZpyEHR1cd3bgm2BpaGUJ1+KxyUUsDCwV
         UiTQ==
X-Gm-Message-State: ACgBeo0s/Umrjj0sgoP3gDfynsJo/1OSNKTrgCZwXdQOYeXHGwVvejSm
	vBIyLkqAGnr9MxUOscjgDQX1kALtRkN3uQ==
X-Google-Smtp-Source: AA6agR4ZOEvaC1A6TbVZt917oBCLnnNKOZJ+ozZlUmQo/r0Et4a0Q9I2+0j+vUtVv6Pk95uDI4xftA==
X-Received: by 2002:a05:6638:3291:b0:350:bfe1:c724 with SMTP id f17-20020a056638329100b00350bfe1c724mr4826298jav.73.1662648407498;
        Thu, 08 Sep 2022 07:46:47 -0700 (PDT)
Received: from [192.168.1.94] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id h11-20020a056e020d4b00b002eb1c60db6csm937439ilj.63.2022.09.08.07.46.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Sep 2022 07:46:47 -0700 (PDT)
Message-ID: <5634d8c6-b4d3-1443-59d2-176fd7c258a5@kernel.dk>
Date: Thu, 8 Sep 2022 08:46:45 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: [PATCH for-next v5 3/4] block: add helper to map bvec iterator
 for passthrough
Content-Language: en-US
To: Kanchan Joshi <joshi.k@samsung.com>,
 Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc: "io-uring@vger.kernel.org" <io-uring@vger.kernel.org>,
 "asml.silence@gmail.com" <asml.silence@gmail.com>,
 "kbusch@kernel.org" <kbusch@kernel.org>, "hch@lst.de" <hch@lst.de>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "gost.dev@samsung.com" <gost.dev@samsung.com>,
 Anuj Gupta <anuj20.g@samsung.com>
References: <20220906062721.62630-1-joshi.k@samsung.com>
 <CGME20220906063729epcas5p1bf05e6873de0f7246234380d66c21fb9@epcas5p1.samsung.com>
 <20220906062721.62630-4-joshi.k@samsung.com>
 <81816f51-e720-4f9c-472f-17882f70b4f9@nvidia.com>
 <20220908105200.GB15034@test-zns>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20220908105200.GB15034@test-zns>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220908_074651_110923_D3C3D59B 
X-CRM114-Status: GOOD (  21.88  )
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

On 9/8/22 4:52 AM, Kanchan Joshi wrote:
> On Wed, Sep 07, 2022 at 03:32:26PM +0000, Chaitanya Kulkarni wrote:
>> On 9/5/22 23:27, Kanchan Joshi wrote:
>>> Add blk_rq_map_user_bvec which maps the bvec iterator into a bio and
>>> places that into the request. This helper will be used in nvme for
>>> uring-passthrough with fixed-buffer.
>>> While at it, create another helper bio_map_get to reduce the code
>>> duplication.
>>>
>>> Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>
>>> Signed-off-by: Anuj Gupta <anuj20.g@samsung.com>
>>> ---
>>>   block/blk-map.c        | 94 +++++++++++++++++++++++++++++++++++++-----
>>>   include/linux/blk-mq.h |  1 +
>>>   2 files changed, 85 insertions(+), 10 deletions(-)
>>>
>>> diff --git a/block/blk-map.c b/block/blk-map.c
>>> index f3768876d618..e2f268167342 100644
>>> --- a/block/blk-map.c
>>> +++ b/block/blk-map.c
>>> @@ -241,17 +241,10 @@ static void bio_map_put(struct bio *bio)
>>>       }
>>>   }
>>>
>>> -static int bio_map_user_iov(struct request *rq, struct iov_iter *iter,
>>> +static struct bio *bio_map_get(struct request *rq, unsigned int nr_vecs,
>>>           gfp_t gfp_mask)
>>>   {
>>> -    unsigned int max_sectors = queue_max_hw_sectors(rq->q);
>>> -    unsigned int nr_vecs = iov_iter_npages(iter, BIO_MAX_VECS);
>>>       struct bio *bio;
>>> -    int ret;
>>> -    int j;
>>> -
>>> -    if (!iov_iter_count(iter))
>>> -        return -EINVAL;
>>>
>>>       if (rq->cmd_flags & REQ_POLLED) {
>>>           blk_opf_t opf = rq->cmd_flags | REQ_ALLOC_CACHE;
>>> @@ -259,13 +252,31 @@ static int bio_map_user_iov(struct request *rq, struct iov_iter *iter,
>>>           bio = bio_alloc_bioset(NULL, nr_vecs, opf, gfp_mask,
>>>                       &fs_bio_set);
>>>           if (!bio)
>>> -            return -ENOMEM;
>>> +            return NULL;
>>>       } else {
>>>           bio = bio_kmalloc(nr_vecs, gfp_mask);
>>>           if (!bio)
>>> -            return -ENOMEM;
>>> +            return NULL;
>>>           bio_init(bio, NULL, bio->bi_inline_vecs, nr_vecs, req_op(rq));
>>>       }
>>> +    return bio;
>>> +}
>>> +
>>> +static int bio_map_user_iov(struct request *rq, struct iov_iter *iter,
>>> +        gfp_t gfp_mask)
>>> +{
>>> +    unsigned int max_sectors = queue_max_hw_sectors(rq->q);
>>> +    unsigned int nr_vecs = iov_iter_npages(iter, BIO_MAX_VECS);
>>> +    struct bio *bio;
>>> +    int ret;
>>> +    int j;
>>> +
>>> +    if (!iov_iter_count(iter))
>>> +        return -EINVAL;
>>> +
>>> +    bio = bio_map_get(rq, nr_vecs, gfp_mask);
>>> +    if (bio == NULL)
>>> +        return -ENOMEM;
>>>
>>>       while (iov_iter_count(iter)) {
>>>           struct page **pages, *stack_pages[UIO_FASTIOV];
>>> @@ -612,6 +623,69 @@ int blk_rq_map_user(struct request_queue *q, struct request *rq,
>>>   }
>>>   EXPORT_SYMBOL(blk_rq_map_user);
>>>
>>> +/* Prepare bio for passthrough IO given an existing bvec iter */
>>> +int blk_rq_map_user_bvec(struct request *rq, struct iov_iter *iter)
>>> +{
>>> +    struct request_queue *q = rq->q;
>>> +    size_t iter_count, nr_segs;
>>> +    struct bio *bio;
>>> +    struct bio_vec *bv, *bvec_arr, *bvprvp = NULL;
>>> +    struct queue_limits *lim = &q->limits;
>>> +    unsigned int nsegs = 0, bytes = 0;
>>> +    int ret, i;
>>> +
>>
>> consider this (untested), it also sets the variable i data type same
>> as it comparison variable in nr_segs the loop i.e. size_t :-
>>
>> +       struct bio_vec *bv, *bvec_arr, *bvprvp = NULL;
>> +       struct request_queue *q = rq->q;
>> +       struct queue_limits *lim = &q->limits;
>> +       unsigned int nsegs = 0, bytes = 0;
>> +       size_t iter_count, nr_segs, i;
>> +       struct bio *bio;
>> +       int ret;
>>
>>
>>> +    iter_count = iov_iter_count(iter);
>>> +    nr_segs = iter->nr_segs;
>>> +
>>> +    if (!iter_count || (iter_count >> 9) > queue_max_hw_sectors(q))
>>> +        return -EINVAL;
>>
>> can we remove braces for iter_count >> 9 without impacting the intended
>> functionality?
> 
> I think removing that make it hard to read.
> I will fold all other changes you mentioned in v6.

Agree - if you have to think about operator precedence, then that's a
sign that the code is less readable and more fragile.

-- 
Jens Axboe



