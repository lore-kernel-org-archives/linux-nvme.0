Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE1E6C07E9D
	for <linux-nvme@archiver.kernel.org>; Sat, 24 Sep 2022 01:00:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=V6zzdR8UjJc6m5+SfMXViwXX18a1T6SipIbCTX3oR/8=; b=mzbSRWwFRiGYu5+dytyuNFa+Zt
	raGvu5zCmOkFnmx4v5gHsTmRYHgWk8oM8oOhaTZ/HBTE4we+TNztLvHyh5taEirJoZMCfGNfylSEa
	WC1SfShxZOBFPq89Orud/oJmxbLDlhwh1IM2sDSHP47PwiGTD8DMnz4etiYd/Ij0/nBcohJ3Y3VVf
	mrew+D3yTdMlBoBdD95Il/mURzAaAFHYYdrFddMMSwRkHvSEEC+KJs2lHIl5I2uPdW1GGJmmrrJ02
	DoMGd4k1S51f0R/5NeVnPk/GuZdk9NZemNqqFILo9Eo7w6XnsKrLXgMvyLHQH8XGePiTC3K9oBOJc
	PCqNJEcQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1obtWR-0063d1-Qy; Sat, 24 Sep 2022 00:59:59 +0000
Received: from esa3.hgst.iphmx.com ([216.71.153.141])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1obtWO-0063cN-TS
	for linux-nvme@lists.infradead.org; Sat, 24 Sep 2022 00:59:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1663981196; x=1695517196;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=H7T05O47XpwCtajDZM5zYG5x8fGP2AaZXpX62UZ1rNk=;
  b=mJb3AjK4KP1pxIDv2OP6HfqALcIBIjFnkEAutpKqTzYwQ5wm8baNk906
   RKzk7Awmz3+TwgDJvz3eFQ2Ry/HkjjPTKD76vWoUbDCXK1RZbpaPDWsVb
   cB/mFPVZsJgQRrCkAjfmM1VwozqyQq9xJnhQZsCJ4LnBI9PLTG0Ze5761
   p8FxEDeBcYhF92Gn42AhSvHHdBCPtyL1HuJF+xKfjW7WvZi+NQ0PWFIRA
   Qsx4g4TUozNPcRzuIcbLJ2hSCTn8y3SBWZXHViiRpmer6YzeP68lSoIhc
   JuVAB92RtR6p6ciBPomDAzDyvjfFT1fvKvLV2eAHPKiVofj5i/WJdxPIC
   g==;
X-IronPort-AV: E=Sophos;i="5.93,340,1654531200"; 
   d="scan'208";a="217336184"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 24 Sep 2022 08:59:53 +0800
IronPort-SDR: nDWl9Pp3p48cVhBq+X/jKROSTcV/Yr6Jlz80e0yUzvN5aK8heMyEzfxIyEIKYAPb+nkX1SImXs
 IKGijlWkuuPEm1Hg5HmVWNDHQCKvJRQ4/+xEMq7d0zXqvQOnKXzDDJP+SfeUyVfalUl/Ip4bpC
 M10IQqibtOGdqXjir7FXf+B5uGsyO8nna6mNCMTd2MMx2p4g5vJTbmMK3bWUUDz43zlLeGIeFC
 3orKUo7e0poPlzdNc1QpBEsp2trMnbXU8iQ/tjlq6wAA4djET/bbZExOvqZnl3XgLN1J2l8U9P
 ySKTjMT9IRvmfgJhf4VsT9k+
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 23 Sep 2022 17:14:24 -0700
IronPort-SDR: jNXrqaj3ZHWGRWXuhsWFwrmYet4lWuKLiLpyDHG8eWgQHx/yqCB3RM2brh/AOluXPaTHzgW0T8
 eiusq9e0KKU3tpN2eHI0+Yy/E4cSnU/+19xEHBH9YhjeNKTnXqPib9DBP3SmBaMcigQa9dKdd4
 xBpxCdCXiZKhyCw+AUdJHRWJzzHj/f5zxQvCO1OzsxwHQZizIcCWX4Qyty6DD2EkQsMPX4S++h
 Lq/uh0zG84e52uS6ai2TEb/IXo0qEYkuC352dwRM7qXOMyUCtdKC0IMxo9Ysef9x60cFgC+AGl
 dms=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 23 Sep 2022 17:59:54 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
	by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4MZ9fK14J4z1Rwtl
	for <linux-nvme@lists.infradead.org>; Fri, 23 Sep 2022 17:59:53 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
	reason="pass (just generated, assumed good)"
	header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
	opensource.wdc.com; h=content-transfer-encoding:content-type
	:in-reply-to:organization:from:references:to:content-language
	:subject:user-agent:mime-version:date:message-id; s=dkim; t=
	1663981192; x=1666573193; bh=H7T05O47XpwCtajDZM5zYG5x8fGP2AaZXpX
	62UZ1rNk=; b=hpOSGwBu3+pGwvslvSOU82CjqOVm+828jdvQKOAZABYd3fzCvQY
	ouLJ/WGwyxeIeFP0C8Rput+7taAjNJlRPtjcwC3puYtjgrU1Rxq4mYbrQw64z2cq
	gdvj9h7eBYnkc+2JfgjyEs2yrljdBEOveeH0xBmS5TSRqhoHRj0wwSpqxcMWKYYH
	CgynmOIrOQyHTFQOrPjk1Wc1sF+s6N2jZNCEla7W6jcmQC9H72pmIJupLqEaI5gb
	bzYRyBXVOdmqXfUZWEbY+iu2YsSIRvD2RpAvQCUO/drepsrNZMK+boSyBHjKv3Bv
	bUX3/70Ag45jGKnIx/GffRovaLeHs7U5g3w==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
	by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id M7YwEkKJZPrw for <linux-nvme@lists.infradead.org>;
	Fri, 23 Sep 2022 17:59:52 -0700 (PDT)
Received: from [10.225.163.88] (unknown [10.225.163.88])
	by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4MZ9fH0Vlsz1RvLy;
	Fri, 23 Sep 2022 17:59:50 -0700 (PDT)
Message-ID: <a06df4ba-a968-0ee1-f8ff-062def0ec031@opensource.wdc.com>
Date: Sat, 24 Sep 2022 09:59:49 +0900
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
From: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <2e484ccb-b65b-2991-e259-d3f7be6ad1a6@kernel.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220923_175957_047976_1D030661 
X-CRM114-Status: GOOD (  19.91  )
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

On 9/24/22 05:54, Jens Axboe wrote:
> On 9/23/22 9:13 AM, Pankaj Raghav wrote:
>> On 2022-09-23 16:52, Pankaj Raghav wrote:
>>> On Thu, Sep 22, 2022 at 12:28:01PM -0600, Jens Axboe wrote:
>>>> The filesystem IO path can take advantage of allocating batches of
>>>> requests, if the underlying submitter tells the block layer about it
>>>> through the blk_plug. For passthrough IO, the exported API is the
>>>> blk_mq_alloc_request() helper, and that one does not allow for
>>>> request caching.
>>>>
>>>> Wire up request caching for blk_mq_alloc_request(), which is generally
>>>> done without having a bio available upfront.
>>>>
>>>> Signed-off-by: Jens Axboe <axboe@kernel.dk>
>>>> ---
>>>>  block/blk-mq.c | 80 ++++++++++++++++++++++++++++++++++++++++++++------
>>>>  1 file changed, 71 insertions(+), 9 deletions(-)
>>>>
>>> I think we need this patch to ensure correct behaviour for passthrough:
>>>
>>> diff --git a/block/blk-mq.c b/block/blk-mq.c
>>> index c11949d66163..840541c1ab40 100644
>>> --- a/block/blk-mq.c
>>> +++ b/block/blk-mq.c
>>> @@ -1213,7 +1213,7 @@ void blk_execute_rq_nowait(struct request *rq, bool at_head)
>>>         WARN_ON(!blk_rq_is_passthrough(rq));
>>>  
>>>         blk_account_io_start(rq);
>>> -       if (current->plug)
>>> +       if (blk_mq_plug(rq->bio))
>>>                 blk_add_rq_to_plug(current->plug, rq);
>>>         else
>>>                 blk_mq_sched_insert_request(rq, at_head, true, false);
>>>
>>> As the passthrough path can now support request caching via blk_mq_alloc_request(),
>>> and it uses blk_execute_rq_nowait(), bad things can happen at least for zoned
>>> devices:
>>>
>>> static inline struct blk_plug *blk_mq_plug( struct bio *bio)
>>> {
>>> 	/* Zoned block device write operation case: do not plug the BIO */
>>> 	if (bdev_is_zoned(bio->bi_bdev) && op_is_write(bio_op(bio)))
>>> 		return NULL;
>>> ..
>>
>> Thinking more about it, even this will not fix it because op is
>> REQ_OP_DRV_OUT if it is a NVMe write for passthrough requests.
>>
>> @Damien Should the condition in blk_mq_plug() be changed to:
>>
>> static inline struct blk_plug *blk_mq_plug( struct bio *bio)
>> {
>> 	/* Zoned block device write operation case: do not plug the BIO */
>> 	if (bdev_is_zoned(bio->bi_bdev) && !op_is_read(bio_op(bio)))
>> 		return NULL;
> 
> That looks reasonable to me. It'll prevent plug optimizations even
> for passthrough on zoned devices, but that's probably fine.

Could do:

	if (blk_op_is_passthrough(bio_op(bio)) ||
	    (bdev_is_zoned(bio->bi_bdev) && op_is_write(bio_op(bio))))
		return NULL;

Which I think is way cleaner. No ?
Unless you want to preserve plugging with passthrough commands on regular
(not zoned) drives ?

-- 
Damien Le Moal
Western Digital Research


