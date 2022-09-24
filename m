Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEC88C07E9D
	for <linux-nvme@archiver.kernel.org>; Sat, 24 Sep 2022 01:01:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jM/NFW+dzaacI3soZGyv7jPWC6pA1pw7cDCJhuL2E/8=; b=KmWHHFL+OvG0Rq+1t0jNunbG3m
	PMZTOzvWG/2c4s5YnZ1OidSl+vpyEroROg66TVVzsdvBbGnKF04YjCsaYEU/xw/D3hHZPPYqvbjAC
	2T6GAp4WIkV4EELA70X4s/j8v7P21FDAD0J59SGT3377m0ju2SZR4V6iRuIUV+xF5duHl0OXHR2zM
	AbbCzESORjkJMPSqwEhOVx7sdOomttZolafouHAOFcUNrnCNawyFPDip750qimmpUHP1rzrTla1HC
	S4a1zI2m9jQ2LvAVtX5iSk/wQ6OnNg9sKk5HuM0aeG7drch2IWYR5t+r3KWmwnMgAKZWgUVusw9Ka
	YWtSSD5w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1obtXn-0063jw-D6; Sat, 24 Sep 2022 01:01:23 +0000
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1obtXk-0063jN-8L
	for linux-nvme@lists.infradead.org; Sat, 24 Sep 2022 01:01:21 +0000
Received: by mail-pl1-x634.google.com with SMTP id b21so1571916plz.7
        for <linux-nvme@lists.infradead.org>; Fri, 23 Sep 2022 18:01:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=jM/NFW+dzaacI3soZGyv7jPWC6pA1pw7cDCJhuL2E/8=;
        b=19NqT5W8oYJqWXv7sK7tkZgw39YSavL6E7bqfJ9W9KMEmQx3kAR99oSffuNcIST7zT
         Zk+EjQ0KoBTA3bP/Wlle4apJAXhuM9VXeSUp8Pca9Q0iBaKpdx8VC7m/SbCksnS6KAxt
         q1PtKeeStJt49FozhjDpPV/jqIgJgPmcFt0LwS7JdfoPws44U6DDHa5yYgWtLgdDc35G
         /4odI4rVtHwgTVC1k/sdl6DImwC/QXLL9zQI87xkcJuEivVAeUO1IcyH/1+NbGk/sxFT
         yxn4qlYjBsLKLqZG2IbYOubTheMoS15IJPe9enN+tmIU9Mpn+VMdRBmjzpeisMRi1lch
         kGww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=jM/NFW+dzaacI3soZGyv7jPWC6pA1pw7cDCJhuL2E/8=;
        b=b/AtTLwS0sKtFodJsuCg8q43sY2REu4Ix2xFfOECzUPhA5LhCtnN0sHjGh+fe1fmuE
         CFNsiqxjLFX+X/TGEXmKX81lH+omV/AlnlZNYqvBY5bHddGeXUxkUwPQoSTfhDrq6ff7
         TeeMwNQaV0/0AQzs60ym9pXqTer57VL9kB/w/gIn54f8x5GXZsSVvKQYlOnPSmT6mhuz
         yNxQop9LmMTi5V6oUpVSnv/TT0/DUuiIeQLVsWiG6HFBbJK8lohWMf/4hfeURjY01S15
         DdjFTOs12CVuUQE5pCCmwbHhU0+XjbOBNv71RG4nTEjG4gQBDYjr796kwpjQOl/6i6LB
         scAA==
X-Gm-Message-State: ACrzQf0DYicoGuANKH5G9xo2XbG1dPFoIZLK3uqpfg1QBqzzQtydPlTl
	pCW/aokIz+qfVRO4zxYGKcZb9w==
X-Google-Smtp-Source: AMsMyM6PjtMQW7Bi+dRsT6bCwYk/CGUTy4KNjBaElrFqSDHtnOFOVbl4Bxk2w4yKvUFJjESeMIldcA==
X-Received: by 2002:a17:90a:cf92:b0:202:ae52:43a4 with SMTP id i18-20020a17090acf9200b00202ae5243a4mr12298778pju.141.1663981279032;
        Fri, 23 Sep 2022 18:01:19 -0700 (PDT)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id f22-20020a635116000000b004308422060csm6157835pgb.69.2022.09.23.18.01.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Sep 2022 18:01:18 -0700 (PDT)
Message-ID: <ba0b3ae4-7001-af42-3549-cc52049ccccb@kernel.dk>
Date: Fri, 23 Sep 2022 19:01:16 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 1/5] block: enable batched allocation for
 blk_mq_alloc_request()
Content-Language: en-US
To: Damien Le Moal <damien.lemoal@opensource.wdc.com>,
 Pankaj Raghav <p.raghav@samsung.com>
Cc: linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
 linux-nvme@lists.infradead.org, joshi.k@samsung.com,
 Pankaj Raghav <pankydev8@gmail.com>, Bart Van Assche <bvanassche@acm.org>
References: <20220922182805.96173-1-axboe@kernel.dk>
 <20220922182805.96173-2-axboe@kernel.dk>
 <CGME20220923145245eucas1p107655755f446bb1e1318539a3f82d301@eucas1p1.samsung.com>
 <20220923145236.pr7ssckko4okklo2@quentin>
 <c7b76fa1-f7e3-3ac6-c92d-35baa0d9a40a@samsung.com>
 <2e484ccb-b65b-2991-e259-d3f7be6ad1a6@kernel.dk>
 <a06df4ba-a968-0ee1-f8ff-062def0ec031@opensource.wdc.com>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <a06df4ba-a968-0ee1-f8ff-062def0ec031@opensource.wdc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220923_180120_330907_A6145191 
X-CRM114-Status: GOOD (  17.41  )
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

On 9/23/22 6:59 PM, Damien Le Moal wrote:
> On 9/24/22 05:54, Jens Axboe wrote:
>> On 9/23/22 9:13 AM, Pankaj Raghav wrote:
>>> On 2022-09-23 16:52, Pankaj Raghav wrote:
>>>> On Thu, Sep 22, 2022 at 12:28:01PM -0600, Jens Axboe wrote:
>>>>> The filesystem IO path can take advantage of allocating batches of
>>>>> requests, if the underlying submitter tells the block layer about it
>>>>> through the blk_plug. For passthrough IO, the exported API is the
>>>>> blk_mq_alloc_request() helper, and that one does not allow for
>>>>> request caching.
>>>>>
>>>>> Wire up request caching for blk_mq_alloc_request(), which is generally
>>>>> done without having a bio available upfront.
>>>>>
>>>>> Signed-off-by: Jens Axboe <axboe@kernel.dk>
>>>>> ---
>>>>>  block/blk-mq.c | 80 ++++++++++++++++++++++++++++++++++++++++++++------
>>>>>  1 file changed, 71 insertions(+), 9 deletions(-)
>>>>>
>>>> I think we need this patch to ensure correct behaviour for passthrough:
>>>>
>>>> diff --git a/block/blk-mq.c b/block/blk-mq.c
>>>> index c11949d66163..840541c1ab40 100644
>>>> --- a/block/blk-mq.c
>>>> +++ b/block/blk-mq.c
>>>> @@ -1213,7 +1213,7 @@ void blk_execute_rq_nowait(struct request *rq, bool at_head)
>>>>         WARN_ON(!blk_rq_is_passthrough(rq));
>>>>  
>>>>         blk_account_io_start(rq);
>>>> -       if (current->plug)
>>>> +       if (blk_mq_plug(rq->bio))
>>>>                 blk_add_rq_to_plug(current->plug, rq);
>>>>         else
>>>>                 blk_mq_sched_insert_request(rq, at_head, true, false);
>>>>
>>>> As the passthrough path can now support request caching via blk_mq_alloc_request(),
>>>> and it uses blk_execute_rq_nowait(), bad things can happen at least for zoned
>>>> devices:
>>>>
>>>> static inline struct blk_plug *blk_mq_plug( struct bio *bio)
>>>> {
>>>> 	/* Zoned block device write operation case: do not plug the BIO */
>>>> 	if (bdev_is_zoned(bio->bi_bdev) && op_is_write(bio_op(bio)))
>>>> 		return NULL;
>>>> ..
>>>
>>> Thinking more about it, even this will not fix it because op is
>>> REQ_OP_DRV_OUT if it is a NVMe write for passthrough requests.
>>>
>>> @Damien Should the condition in blk_mq_plug() be changed to:
>>>
>>> static inline struct blk_plug *blk_mq_plug( struct bio *bio)
>>> {
>>> 	/* Zoned block device write operation case: do not plug the BIO */
>>> 	if (bdev_is_zoned(bio->bi_bdev) && !op_is_read(bio_op(bio)))
>>> 		return NULL;
>>
>> That looks reasonable to me. It'll prevent plug optimizations even
>> for passthrough on zoned devices, but that's probably fine.
> 
> Could do:
> 
> 	if (blk_op_is_passthrough(bio_op(bio)) ||
> 	    (bdev_is_zoned(bio->bi_bdev) && op_is_write(bio_op(bio))))
> 		return NULL;
> 
> Which I think is way cleaner. No ?
> Unless you want to preserve plugging with passthrough commands on regular
> (not zoned) drives ?

We most certainly do, without plugging this whole patchset is not
functional. Nor is batched dispatch, for example.

-- 
Jens Axboe

