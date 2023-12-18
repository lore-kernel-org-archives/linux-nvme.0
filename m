Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FF6FC35274
	for <linux-nvme@archiver.kernel.org>; Mon, 18 Dec 2023 09:33:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9hO+OMQiyml93i1r89vC6c2cYabxC7l3iapV2ElYsAA=; b=IPIMhuscJRCOvDJptGbh8kkxwe
	hklKR6cyVZwGvndbig/T2aIM0ImEJ+rpS6RqJIND9Zfl+Lnd9qza+q5GC2Lw1JLe4/fqiYuNa/LQP
	yeXTiLau2B32CkM1f8gEORZw3EVV/Pzm2ZHVpB2nK0Q6+StOFfNvPmW4yJKkRIpREhnse08nnOBwY
	gaZqPDGeh9V70NxnCE+h+YWNM9opkMRDWPoc33SGEhp1nvJlNUQwXr6Ih2YkU1Jdz01GHejQktfdg
	3WO2zrjiAQrWPSiMURKwbWSckYw9+/+tkorgK8/x2unV4TV2i5QI4cyWnmBty1SwJFn6HoSmJ5Syy
	HcBPhXRw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rFA0M-009fyH-2b;
	Mon, 18 Dec 2023 09:33:42 +0000
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rFA0K-009fxO-1R
	for linux-nvme@lists.infradead.org;
	Mon, 18 Dec 2023 09:33:42 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id A1A38CE0F7B;
	Mon, 18 Dec 2023 09:33:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50C5DC433C7;
	Mon, 18 Dec 2023 09:33:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702892016;
	bh=xCrMPR/698dLE7PHRiGMnC3JzwZkeI7Ei5UdX6bBtCM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Bp/Jjjv+1tWyROtfJwL8AGcvFXDQKD/sJdR2PFp73c6V7l2cEIJKpqk3pJp2BPjXu
	 moHv0yPKeSSofgJShwctlIcl5l/zbI3j5p4aWOnIy9AW83jipkSsXMJ5f9WrUyTQIF
	 uCt/Iyrpf2hw26o3J6YUrFkT3RsdwqLblCkXAK6tbUDsdn8CJIjYs9pIXUc14pboxB
	 w5xOOFVYTRT0z0NcUNYZoXRsVktXzXvEfLdgI1jEFOuBM2+Z+VjiCYgmjdUXmekLa2
	 zj3LvcLMziNj1T57aZCGemPrnpORfSOYS1ZwRpoLYoljGh3zE555+rL+a4HyMj3O/e
	 vDJ6NpYW+0n1w==
Message-ID: <5d315435-d41f-4cbe-98f6-4e0e2612763a@kernel.org>
Date: Mon, 18 Dec 2023 18:33:33 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] block: remove support for the host aware zone model
Content-Language: en-US
To: =?UTF-8?B?RWQgVHNhaSAo6JSh5a6X6LuSKQ==?= <Ed.Tsai@mediatek.com>,
 "hch@lst.de" <hch@lst.de>, "axboe@kernel.dk" <axboe@kernel.dk>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "virtualization@lists.linux.dev" <virtualization@lists.linux.dev>,
 "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
 =?UTF-8?B?Q2h1bi1IdW5nIFd1ICjlt6vpp7/lro8p?= <Chun-hung.Wu@mediatek.com>,
 "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
 "dm-devel@lists.linux.dev" <dm-devel@lists.linux.dev>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
 "linux-f2fs-devel@lists.sourceforge.net"
 <linux-f2fs-devel@lists.sourceforge.net>,
 "stefanha@redhat.com" <stefanha@redhat.com>
References: <20231217165359.604246-1-hch@lst.de>
 <20231217165359.604246-4-hch@lst.de>
 <b4d33dc359495c6227a3f20285566eed27718a14.camel@mediatek.com>
 <190f58f7-2ed6-46f8-af59-5e167a0bddeb@kernel.org>
 <f19c41b9ea990e6da734b6c81caeebb73fb60b29.camel@mediatek.com>
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <f19c41b9ea990e6da734b6c81caeebb73fb60b29.camel@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231218_013340_858600_E927D7AB 
X-CRM114-Status: GOOD (  14.99  )
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

On 12/18/23 17:21, Ed Tsai (蔡宗軒) wrote:
> On Mon, 2023-12-18 at 15:53 +0900, Damien Le Moal wrote:
>>  On 2023/12/18 15:15, Ed Tsai (蔡宗軒) wrote:
>>> Hi Christoph,
>>>
>>> some minor suggestions:
>>>
>>> On Sun, 2023-12-17 at 17:53 +0100, Christoph Hellwig wrote:
>>>>
>>>> diff --git a/drivers/md/dm-table.c b/drivers/md/dm-table.c
>>>> index 198d38b53322c1..260b5b8f2b0d7e 100644
>>>> --- a/drivers/md/dm-table.c
>>>> +++ b/drivers/md/dm-table.c
>>>> @@ -1579,21 +1579,18 @@ bool dm_table_has_no_data_devices(struct
>>>> dm_table *t)
>>>>  return true;
>>>>  }
>>>>  
>>>> -static int device_not_zoned_model(struct dm_target *ti, struct
>>>> dm_dev *dev,
>>>> -  sector_t start, sector_t len, void
>>>> *data)
>>>> +static int device_not_zoned(struct dm_target *ti, struct dm_dev
>>>> *dev,
>>>> +    sector_t start, sector_t len, void *data)
>>>>  {
>>>> -struct request_queue *q = bdev_get_queue(dev->bdev);
>>>> -enum blk_zoned_model *zoned_model = data;
>>>> +bool *zoned = data;
>>>>  
>>>> -return blk_queue_zoned_model(q) != *zoned_model;
>>>> +return bdev_is_zoned(dev->bdev) != *zoned;
>>>>  }
>>>>  
>>>>  static int device_is_zoned_model(struct dm_target *ti, struct
>> dm_dev
>>>> *dev,
>>>>   sector_t start, sector_t len, void
>>>> *data)
>>>
>>> Seems like the word "model" should also be remove here.
>>>
>>>>  {
>>>> -struct request_queue *q = bdev_get_queue(dev->bdev);
>>>> -
>>>> -return blk_queue_zoned_model(q) != BLK_ZONED_NONE;
>>>> +return bdev_is_zoned(dev->bdev);
>>>>  }
>>>>  
>>>>  /*
>>>> @@ -1603,8 +1600,7 @@ static int device_is_zoned_model(struct
>>>> dm_target *ti, struct dm_dev *dev,
>>>>   * has the DM_TARGET_MIXED_ZONED_MODEL feature set, the devices
>> can
>>>> have any
>>>>   * zoned model with all zoned devices having the same zone size.
>>>>   */
>>>> -static bool dm_table_supports_zoned_model(struct dm_table *t,
>>>> -  enum blk_zoned_model
>>>> zoned_model)
>>>> +static bool dm_table_supports_zoned(struct dm_table *t, bool
>> zoned)
>>>>  {
>>>>  for (unsigned int i = 0; i < t->num_targets; i++) {
>>>>  struct dm_target *ti = dm_table_get_target(t, i);
>>>> @@ -1623,11 +1619,11 @@ static bool
>>>> dm_table_supports_zoned_model(struct dm_table *t,
>>>>  
>>>>  if (dm_target_supports_zoned_hm(ti->type)) {
>>>>  if (!ti->type->iterate_devices ||
>>>> -    ti->type->iterate_devices(ti,
>>>> device_not_zoned_model,
>>>> -      &zoned_model))
>>>> +    ti->type->iterate_devices(ti,
>>>> device_not_zoned,
>>>> +      &zoned))
>>>>  return false;
>>>>  } else if (!dm_target_supports_mixed_zoned_model(ti-
>>>>> type)) {
>>>> -if (zoned_model == BLK_ZONED_HM)
>>>> +if (zoned)
>>>>  return false;
>>>>  }
>>>>  }
>>>
>>> The parameter "bool zoned" is redundant. It should be removed from
>> the
>>> above 3 functions
> 
> The two func, is zoned and not zoned, are essentially the same. They
> can be simplified into one function.

Maybe... But that needs testing/checking. I added the one because I could not
reuse the other given what is being tested.

> 
>>>
>>> Additionally, because we no longer need to distinguish the zoned
>> model
>>> here, DM_TARGET_MIXED_ZONED_MODEL is meaningless. We can also clean
>> up
>>> its related code.
>>
>> Nope. The mixed thing is for mixing up non-zoned with zoned models.
>> For the entire DM code, HM and HA are both treated as HM-like zoned.
>>
>> -- 
>> Damien Le Moal
>> Western Digital Research
> 
> Thank you. I have some misunderstanding. Please disregard it.

-- 
Damien Le Moal
Western Digital Research


