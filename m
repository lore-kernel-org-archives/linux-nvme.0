Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEECFC04A95
	for <linux-nvme@archiver.kernel.org>; Sat, 24 Sep 2022 01:22:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=EnlYMyuUkAmBAdKVa6xjoeB29JVES9HqOZH1iOtlyqk=; b=II7zUDKaxCAXYQkiHnQuXxD8x5
	+kBbCpIqsQnkM/ytlq6XtaCWl3dIwjXzuM3SFD+tD2qxAVbe7mfpDCWVZmY4WBbJqLodrwrtjNghQ
	LvawhM/9N+Sji9eh3sDGT7ERjsW1rNQGmAzu2aylL/Q9kyRe34pw6Jlw9lQuU3PxxWLH5B8pLkmtY
	+C3lZpz1RpcmOEHJVqgTjp5JBnGR/PFV0aDriiVgHtZh916SqHVFOmVkC40SCmkIQNYmEqiJARmgF
	6YNPXs9ZVTAsOhksulBtUMSixqesD+ATK3o3MapaLbg8X5laeqdKSGKmJjjA9jY95dYT1V/NT0r6h
	A7NRfZZQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1obtsH-0064j2-3W; Sat, 24 Sep 2022 01:22:33 +0000
Received: from esa1.hgst.iphmx.com ([68.232.141.245])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1obtsD-0064iN-60
	for linux-nvme@lists.infradead.org; Sat, 24 Sep 2022 01:22:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1663982548; x=1695518548;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=j0figFZxEreBSY1Cx+kndYnHpnAJ/z2W8eA8gokM7Is=;
  b=lCvaF/WGP/vZF4a2Vk4xxMIAyiMOgl4Q1FB98oWDINq/FweVEh/dzp0r
   Ge7QVipPuzL9KPoxINcWZQH3/ZgZdJeywE+Yy0dseepeald4w0sHXMj7z
   OoZb4fSw5GlJzhtYX751GcwjllPdL5t27VYy7z/kEGVbu/3AresHHeZzR
   YaEmsBhNTUM96YtazF3wdZEylq1edla+HvGGcZaO8CHMBYeLnpI33u7Cw
   IjuD7dwUXIV+MrA7HQDCQvq7yFz7YxJW5F1C30xCgo4Ehl1I2/1OExrvM
   tJNWfS7j6uM5ChhHyywlap8Ipcg6ledSOU8mqq4XZGQmSwKSr4rcqjLJj
   Q==;
X-IronPort-AV: E=Sophos;i="5.93,340,1654531200"; 
   d="scan'208";a="324260785"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 24 Sep 2022 09:22:21 +0800
IronPort-SDR: 1GtgGNH0zLWDZD6ShVT0hpGXGgcJVmvovpC89phZaPQn0VvjpbjeBXfuIXmZPJPeonpc5r70Ya
 PmCj2uxGE5YDCH2UrXjHQNOZABBEaxA39HagYsY2TTBeiEhCtZryuWzWWdDxTelmqPiDygsaca
 HOk4EjDxkKLP1jUFrsB7YUgBmSbKlgy29NOD+NaOzIQvKJjCvVOiT65zTJTCLD2y05djuUr61W
 +g0xHPB7uOHLf+dlwG+LKSed2njmF+vWCxQ1rlIC2uLVj4PHFmGsUkyRFWi2afmRBkrpNwAzQl
 TBU1+yCDtgVE9qDNYjsEO7Lb
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 23 Sep 2022 17:36:53 -0700
IronPort-SDR: smJztiTlGIZlpP6WATgMtpJRiV1CLrtFU5hFrGlPo9KFuqaQsBkpiv838rRcQaatEqlpEQfsIu
 aW4gIt7S/cpL7c8Wae9pyboBu6MJJ8ZjicWg/ExcqbywTbZgvReZfmFm1oYIQhAQN5wDjDv+CA
 ULLokekUF66Mv8Fm+ouj5AeBlB9Aw8+1NWVmYch1cc+0XjO2CANXolR4720iBNpGZCbGXEt2EL
 pQ6m6pRQgFhAobKyLgA9kQdHjdOghhnVmn+zhvIeDeBTosU3D13YVfzzBsYkvION3KQa148mVu
 xL0=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 23 Sep 2022 18:22:21 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
	by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4MZB8F39XXz1RvTr
	for <linux-nvme@lists.infradead.org>; Fri, 23 Sep 2022 18:22:21 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
	reason="pass (just generated, assumed good)"
	header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
	opensource.wdc.com; h=content-transfer-encoding:content-type
	:in-reply-to:organization:from:references:to:content-language
	:subject:user-agent:mime-version:date:message-id; s=dkim; t=
	1663982540; x=1666574541; bh=j0figFZxEreBSY1Cx+kndYnHpnAJ/z2W8eA
	8gokM7Is=; b=HE3yobUHVvBYIlWMJ/QWkRq7tLCgWTCTLvjkMMdZw+WB95AjRX+
	5sh8hJ0XRIeZz765wODHqKzd3pThIGJ7h1DaqQzRukFBMavLfuqXKOv+O+jlDNKz
	cUwrBr7wSdN7I3nWPAgvo0EIgrYx9PxBSnQzKVVHhjKajrLzZxq4d51PuXGVlvZb
	fPDuUQFbAucGQEz3lEkuUYiytF+/PRJhF7nlPEfFmntVHZqc/f7q/p3waEn4uU5r
	Gw1i99kYUKzJctqq850WK0XhGTMv1O+WANuDie1uSq5GDupaNm7Ztj7WBczZj+RK
	ln0qmS/sa+8+6ciIf7J4CouDdkZ82J6XEpg==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
	by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id PrTdLTGNioOh for <linux-nvme@lists.infradead.org>;
	Fri, 23 Sep 2022 18:22:20 -0700 (PDT)
Received: from [10.225.163.88] (unknown [10.225.163.88])
	by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4MZB8C3xM5z1RvLy;
	Fri, 23 Sep 2022 18:22:19 -0700 (PDT)
Message-ID: <4e9ae1d2-1db4-aff6-e280-6ea282161b7b@opensource.wdc.com>
Date: Sat, 24 Sep 2022 10:22:18 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH 1/5] block: enable batched allocation for
 blk_mq_alloc_request()
Content-Language: en-US
To: Jens Axboe <axboe@kernel.dk>, Pankaj Raghav <p.raghav@samsung.com>
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
 <ba0b3ae4-7001-af42-3549-cc52049ccccb@kernel.dk>
From: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <ba0b3ae4-7001-af42-3549-cc52049ccccb@kernel.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220923_182229_263232_9BE84AEB 
X-CRM114-Status: GOOD (  20.14  )
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

On 9/24/22 10:01, Jens Axboe wrote:
> On 9/23/22 6:59 PM, Damien Le Moal wrote:
>> On 9/24/22 05:54, Jens Axboe wrote:
>>> On 9/23/22 9:13 AM, Pankaj Raghav wrote:
>>>> On 2022-09-23 16:52, Pankaj Raghav wrote:
>>>>> On Thu, Sep 22, 2022 at 12:28:01PM -0600, Jens Axboe wrote:
>>>>>> The filesystem IO path can take advantage of allocating batches of
>>>>>> requests, if the underlying submitter tells the block layer about it
>>>>>> through the blk_plug. For passthrough IO, the exported API is the
>>>>>> blk_mq_alloc_request() helper, and that one does not allow for
>>>>>> request caching.
>>>>>>
>>>>>> Wire up request caching for blk_mq_alloc_request(), which is generally
>>>>>> done without having a bio available upfront.
>>>>>>
>>>>>> Signed-off-by: Jens Axboe <axboe@kernel.dk>
>>>>>> ---
>>>>>>  block/blk-mq.c | 80 ++++++++++++++++++++++++++++++++++++++++++++------
>>>>>>  1 file changed, 71 insertions(+), 9 deletions(-)
>>>>>>
>>>>> I think we need this patch to ensure correct behaviour for passthrough:
>>>>>
>>>>> diff --git a/block/blk-mq.c b/block/blk-mq.c
>>>>> index c11949d66163..840541c1ab40 100644
>>>>> --- a/block/blk-mq.c
>>>>> +++ b/block/blk-mq.c
>>>>> @@ -1213,7 +1213,7 @@ void blk_execute_rq_nowait(struct request *rq, bool at_head)
>>>>>         WARN_ON(!blk_rq_is_passthrough(rq));
>>>>>  
>>>>>         blk_account_io_start(rq);
>>>>> -       if (current->plug)
>>>>> +       if (blk_mq_plug(rq->bio))
>>>>>                 blk_add_rq_to_plug(current->plug, rq);
>>>>>         else
>>>>>                 blk_mq_sched_insert_request(rq, at_head, true, false);
>>>>>
>>>>> As the passthrough path can now support request caching via blk_mq_alloc_request(),
>>>>> and it uses blk_execute_rq_nowait(), bad things can happen at least for zoned
>>>>> devices:
>>>>>
>>>>> static inline struct blk_plug *blk_mq_plug( struct bio *bio)
>>>>> {
>>>>> 	/* Zoned block device write operation case: do not plug the BIO */
>>>>> 	if (bdev_is_zoned(bio->bi_bdev) && op_is_write(bio_op(bio)))
>>>>> 		return NULL;
>>>>> ..
>>>>
>>>> Thinking more about it, even this will not fix it because op is
>>>> REQ_OP_DRV_OUT if it is a NVMe write for passthrough requests.
>>>>
>>>> @Damien Should the condition in blk_mq_plug() be changed to:
>>>>
>>>> static inline struct blk_plug *blk_mq_plug( struct bio *bio)
>>>> {
>>>> 	/* Zoned block device write operation case: do not plug the BIO */
>>>> 	if (bdev_is_zoned(bio->bi_bdev) && !op_is_read(bio_op(bio)))
>>>> 		return NULL;
>>>
>>> That looks reasonable to me. It'll prevent plug optimizations even
>>> for passthrough on zoned devices, but that's probably fine.
>>
>> Could do:
>>
>> 	if (blk_op_is_passthrough(bio_op(bio)) ||
>> 	    (bdev_is_zoned(bio->bi_bdev) && op_is_write(bio_op(bio))))
>> 		return NULL;
>>
>> Which I think is way cleaner. No ?
>> Unless you want to preserve plugging with passthrough commands on regular
>> (not zoned) drives ?
> 
> We most certainly do, without plugging this whole patchset is not
> functional. Nor is batched dispatch, for example.

OK. Then the change to !op_is_read() is fine then.

> 

-- 
Damien Le Moal
Western Digital Research


