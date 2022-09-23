Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26F3EC04A95
	for <linux-nvme@archiver.kernel.org>; Fri, 23 Sep 2022 20:54:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/K/GOu02xfTZ/9xI05vqPiDNx5hkxNdjNt0qyrC4Qyw=; b=Ks0m7ZAyGjyPUoX1opuU5/I/T1
	p/N39mcMYSnojBkbMguxu5aRGHR4PkfRT5hVr6TRjam+uO67ST3tcQtLIkmh+US0UeSuieho6bU4Q
	yfzZZlBVs3jfiPC93qR3X0BiJhb0sZD9E000LJ4wqJsaAtZaaJIAgHkySUG4E6xpd7h2G4igRszlI
	bvt4oBWAQ4i6Mv4b8caI3vVZKRFk6CYSuSNecD4Ut/0hZQ9wJ6ulvD5qvcMdyGAniW3e/4UQETXII
	wWBIl4MmwaI5/Dyc8mMHDvb29SujE78+FtdyE96oWXMqpiVrBlIuzGMqJ6RwcwGgDfC+l0TI+LAhm
	lNt28txg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1obpgg-005h5D-5k; Fri, 23 Sep 2022 20:54:18 +0000
Received: from mail-io1-xd32.google.com ([2607:f8b0:4864:20::d32])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1obpgd-005h4V-CH
	for linux-nvme@lists.infradead.org; Fri, 23 Sep 2022 20:54:16 +0000
Received: by mail-io1-xd32.google.com with SMTP id h194so897870iof.4
        for <linux-nvme@lists.infradead.org>; Fri, 23 Sep 2022 13:54:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=/K/GOu02xfTZ/9xI05vqPiDNx5hkxNdjNt0qyrC4Qyw=;
        b=nvLIB0RJXe73WL+xXeF3BnfdKLnrKGY8ZDslI6lmL0cQeakLC6BCZhPiuK243GoOB4
         4c8WWHLlshW3gZOfu4mYXdYgFCEVijcufrrV3yk7klbW+ebOtX34BSloqb33h3lWwgDj
         BZ3lJ/bXZbnQnIMovtT87ZG0Y4Aii4Xf4atHWFoRryKMtvYl6VJHhJ9dkNRPfjF/UrDU
         xCpD2eFIQIb6Qb+lUeMaAAl4IgolpacRuJSWRKROeEWNyrB8gwl/OZzwwc2/GFVRH3SY
         YT/Xan5f47fBd5dlECLqU4y8pUy5sIlubvt0nLaLlHI80v8k25j3U+KF5sKm24pBmCGc
         r9Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=/K/GOu02xfTZ/9xI05vqPiDNx5hkxNdjNt0qyrC4Qyw=;
        b=L1Az6IHZUegGNk9o1ogh0hjnpW78x7gBrIKYxAxj1qeheA1m7MkKtCj83mI6ZV7h5c
         SAazVas/o6WQSMhQP/4bhtX5Bfetyz0tltzPhohwa0mfmesm9TCQU3snd0I7xc7TJ0Ax
         2jgXVXpWZsxEXhIAF5v4HYF/FRbtWw2xJbJl0IHnRIdrttVzpy3XZzX7Hrbl0E8LwsGw
         y1IvScBs0ytQp9ESXAgFPYuZKtyqSmiuhAUcQ4LOm31gtIMU8eJ/tjaX0SyQAnZWuPLw
         M2NUpPVFTk1lGwEj8y2XY4gq57NtR7bMMeoXyDD8XZ2OKInMVdNRazUZz7pcR5T4CYZn
         LYwg==
X-Gm-Message-State: ACrzQf2pgmyML131Fh68irJTnn3R0JypLugUIE/TtHyr8zBfrQR9O6N5
	mBG+8o+KjMHkAIwEYMN8S6xHjg==
X-Google-Smtp-Source: AMsMyM7fQ9X8DI4XxBLuNaKvje1XDwW71d2cJffEU6cwqjPF4VEwKC+YAJvorV6dYRuBCbuSX+CV7Q==
X-Received: by 2002:a6b:1c7:0:b0:6a3:2e71:2a91 with SMTP id 190-20020a6b01c7000000b006a32e712a91mr4959223iob.158.1663966452346;
        Fri, 23 Sep 2022 13:54:12 -0700 (PDT)
Received: from [192.168.1.94] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id d194-20020a0262cb000000b0035a42c43e3bsm3820406jac.81.2022.09.23.13.54.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Sep 2022 13:54:11 -0700 (PDT)
Message-ID: <2e484ccb-b65b-2991-e259-d3f7be6ad1a6@kernel.dk>
Date: Fri, 23 Sep 2022 14:54:11 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 1/5] block: enable batched allocation for
 blk_mq_alloc_request()
Content-Language: en-US
To: Pankaj Raghav <p.raghav@samsung.com>,
 Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc: linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
 linux-nvme@lists.infradead.org, joshi.k@samsung.com,
 Pankaj Raghav <pankydev8@gmail.com>, Bart Van Assche <bvanassche@acm.org>
References: <20220922182805.96173-1-axboe@kernel.dk>
 <20220922182805.96173-2-axboe@kernel.dk>
 <CGME20220923145245eucas1p107655755f446bb1e1318539a3f82d301@eucas1p1.samsung.com>
 <20220923145236.pr7ssckko4okklo2@quentin>
 <c7b76fa1-f7e3-3ac6-c92d-35baa0d9a40a@samsung.com>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <c7b76fa1-f7e3-3ac6-c92d-35baa0d9a40a@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220923_135415_447550_CA36DF76 
X-CRM114-Status: GOOD (  18.58  )
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

On 9/23/22 9:13 AM, Pankaj Raghav wrote:
> On 2022-09-23 16:52, Pankaj Raghav wrote:
>> On Thu, Sep 22, 2022 at 12:28:01PM -0600, Jens Axboe wrote:
>>> The filesystem IO path can take advantage of allocating batches of
>>> requests, if the underlying submitter tells the block layer about it
>>> through the blk_plug. For passthrough IO, the exported API is the
>>> blk_mq_alloc_request() helper, and that one does not allow for
>>> request caching.
>>>
>>> Wire up request caching for blk_mq_alloc_request(), which is generally
>>> done without having a bio available upfront.
>>>
>>> Signed-off-by: Jens Axboe <axboe@kernel.dk>
>>> ---
>>>  block/blk-mq.c | 80 ++++++++++++++++++++++++++++++++++++++++++++------
>>>  1 file changed, 71 insertions(+), 9 deletions(-)
>>>
>> I think we need this patch to ensure correct behaviour for passthrough:
>>
>> diff --git a/block/blk-mq.c b/block/blk-mq.c
>> index c11949d66163..840541c1ab40 100644
>> --- a/block/blk-mq.c
>> +++ b/block/blk-mq.c
>> @@ -1213,7 +1213,7 @@ void blk_execute_rq_nowait(struct request *rq, bool at_head)
>>         WARN_ON(!blk_rq_is_passthrough(rq));
>>  
>>         blk_account_io_start(rq);
>> -       if (current->plug)
>> +       if (blk_mq_plug(rq->bio))
>>                 blk_add_rq_to_plug(current->plug, rq);
>>         else
>>                 blk_mq_sched_insert_request(rq, at_head, true, false);
>>
>> As the passthrough path can now support request caching via blk_mq_alloc_request(),
>> and it uses blk_execute_rq_nowait(), bad things can happen at least for zoned
>> devices:
>>
>> static inline struct blk_plug *blk_mq_plug( struct bio *bio)
>> {
>> 	/* Zoned block device write operation case: do not plug the BIO */
>> 	if (bdev_is_zoned(bio->bi_bdev) && op_is_write(bio_op(bio)))
>> 		return NULL;
>> ..
> 
> Thinking more about it, even this will not fix it because op is
> REQ_OP_DRV_OUT if it is a NVMe write for passthrough requests.
> 
> @Damien Should the condition in blk_mq_plug() be changed to:
> 
> static inline struct blk_plug *blk_mq_plug( struct bio *bio)
> {
> 	/* Zoned block device write operation case: do not plug the BIO */
> 	if (bdev_is_zoned(bio->bi_bdev) && !op_is_read(bio_op(bio)))
> 		return NULL;

That looks reasonable to me. It'll prevent plug optimizations even
for passthrough on zoned devices, but that's probably fine.

-- 
Jens Axboe



