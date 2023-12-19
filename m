Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE549C46CA2
	for <linux-nvme@archiver.kernel.org>; Tue, 19 Dec 2023 08:12:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mSpl0XziOOcW7rQJz5brCnkr+eSxTc9VyEdx3B6X0gk=; b=Xu+SoR1IOCw+/L6RGVD5gncaTg
	dqqNbe/313z2a58M0smW04agmvkc2GQ2esObOmpT4Vd47C6fnEAjriW1NXMZdoeQ7HKk0oxG/ZKHB
	ki5lp2y3eEY5SVCBr1zZpd0cld5ZNxGCV2ngLf4AZ1qt6yWr4CT6uxRJNJ3KiWrHkxR4mCYQ/scx4
	zRDbAVrE7lYj2zL7R+fqMpTiwp1V9UpV3kQiU/fDNVai/s+TKqM3YfhKQqOb6/YOpyg9U0mma06gJ
	VdJ+Oxl2AhvCVXPPGZ0XjZXd3btC2O2yEY/Zwi2jObjYMQCOUS4ZrU6juvHNqM5pLnjIiRRja+ZN9
	5Mlb5aRA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rFVDh-00DGWm-1q;
	Tue, 19 Dec 2023 08:12:53 +0000
Received: from ams.source.kernel.org ([2604:1380:4601:e00::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rFVDe-00DGTK-2C
	for linux-nvme@lists.infradead.org;
	Tue, 19 Dec 2023 08:12:52 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by ams.source.kernel.org (Postfix) with ESMTP id 38986B815C2;
	Tue, 19 Dec 2023 08:12:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74951C433C7;
	Tue, 19 Dec 2023 08:12:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702973565;
	bh=U+ZkdTcXjXKG5X1r3LNQSaeJXFjIgFWiM3F9bcVebOk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ttJ037TujCI0HIp63zwRjkVY8HhZNnpxq1+lUfykle8H3F3xExXvUURAumQu/RDLq
	 FgkPzT9OSV0ajVnmxU7/8a1j0L7G68hVpnyEexW0cWzW4A1lE8g5PZthfSqyK5nhIo
	 6jHEpCaAkl7xku33ttbZTZIqMx/suFdVZApNXCCuCxTKO/E1EvEIf0Dw5npyU9m6NA
	 u7ADjgeag9TWY81V1O4RAuRnj1jEYnEnjLPmdqJmpHBqLPVrdiONH0U/aTjxm6TY0u
	 iKxQnlGZ6oBIlEu4dqQGCauvJMF1JllG2d+UsYuHSwkp2Yv5y+UyBhdeOS5wyMS/97
	 9kE/SUUW3UjSQ==
Message-ID: <0a329050-0010-47cb-8c7b-a2f0863a21e8@kernel.org>
Date: Tue, 19 Dec 2023 17:12:41 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] block: remove support for the host aware zone model
To: =?UTF-8?B?RWQgVHNhaSAo6JSh5a6X6LuSKQ==?= <Ed.Tsai@mediatek.com>,
 "Naohiro.Aota@wdc.com" <Naohiro.Aota@wdc.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "virtualization@lists.linux.dev" <virtualization@lists.linux.dev>,
 "hch@lst.de" <hch@lst.de>,
 "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
 "axboe@kernel.dk" <axboe@kernel.dk>,
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
 <do3ekgymdpa4skyz5p3dp6qcqq7zuty73qrpmftszmffunnxpm@fyswyalaxzfq>
 <dbc4a5b4296effd88ba0ef939aa324df0969545c.camel@mediatek.com>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <dbc4a5b4296effd88ba0ef939aa324df0969545c.camel@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231219_001251_026679_27988F05 
X-CRM114-Status: GOOD (  19.70  )
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

On 12/19/23 17:08, Ed Tsai (蔡宗軒) wrote:
> On Tue, 2023-12-19 at 07:16 +0000, Naohiro Aota wrote:
>>  	 
>> External email : Please do not click links or open attachments until
>> you have verified the sender or the content.
>>  On Mon, Dec 18, 2023 at 08:21:22AM +0000, Ed Tsai (蔡宗軒) wrote:
>>> On Mon, 2023-12-18 at 15:53 +0900, Damien Le Moal wrote:
>>>>  On 2023/12/18 15:15, Ed Tsai (蔡宗軒) wrote:
>>>>> Hi Christoph,
>>>>>
>>>>> some minor suggestions:
>>>>>
>>>>> On Sun, 2023-12-17 at 17:53 +0100, Christoph Hellwig wrote:
>>>>>>
>>>>>> diff --git a/drivers/md/dm-table.c b/drivers/md/dm-table.c
>>>>>> index 198d38b53322c1..260b5b8f2b0d7e 100644
>>>>>> --- a/drivers/md/dm-table.c
>>>>>> +++ b/drivers/md/dm-table.c
>>>>>> @@ -1579,21 +1579,18 @@ bool
>> dm_table_has_no_data_devices(struct
>>>>>> dm_table *t)
>>>>>>  return true;
>>>>>>  }
>>>>>>  
>>>>>> -static int device_not_zoned_model(struct dm_target *ti,
>> struct
>>>>>> dm_dev *dev,
>>>>>> -  sector_t start, sector_t len, void
>>>>>> *data)
>>>>>> +static int device_not_zoned(struct dm_target *ti, struct
>> dm_dev
>>>>>> *dev,
>>>>>> +    sector_t start, sector_t len, void *data)
>>>>>>  {
>>>>>> -struct request_queue *q = bdev_get_queue(dev->bdev);
>>>>>> -enum blk_zoned_model *zoned_model = data;
>>>>>> +bool *zoned = data;
>>>>>>  
>>>>>> -return blk_queue_zoned_model(q) != *zoned_model;
>>>>>> +return bdev_is_zoned(dev->bdev) != *zoned;
>>>>>>  }
>>>>>>  
>>>>>>  static int device_is_zoned_model(struct dm_target *ti, struct
>>>> dm_dev
>>>>>> *dev,
>>>>>>   sector_t start, sector_t len, void
>>>>>> *data)
>>>>>
>>>>> Seems like the word "model" should also be remove here.
>>>>>
>>>>>>  {
>>>>>> -struct request_queue *q = bdev_get_queue(dev->bdev);
>>>>>> -
>>>>>> -return blk_queue_zoned_model(q) != BLK_ZONED_NONE;
>>>>>> +return bdev_is_zoned(dev->bdev);
>>>>>>  }
>>>>>>  
>>>>>>  /*
>>>>>> @@ -1603,8 +1600,7 @@ static int device_is_zoned_model(struct
>>>>>> dm_target *ti, struct dm_dev *dev,
>>>>>>   * has the DM_TARGET_MIXED_ZONED_MODEL feature set, the
>> devices
>>>> can
>>>>>> have any
>>>>>>   * zoned model with all zoned devices having the same zone
>> size.
>>>>>>   */
>>>>>> -static bool dm_table_supports_zoned_model(struct dm_table *t,
>>>>>> -  enum blk_zoned_model
>>>>>> zoned_model)
>>>>>> +static bool dm_table_supports_zoned(struct dm_table *t, bool
>>>> zoned)
>>>>>>  {
>>>>>>  for (unsigned int i = 0; i < t->num_targets; i++) {
>>>>>>  struct dm_target *ti = dm_table_get_target(t, i);
>>>>>> @@ -1623,11 +1619,11 @@ static bool
>>>>>> dm_table_supports_zoned_model(struct dm_table *t,
>>>>>>  
>>>>>>  if (dm_target_supports_zoned_hm(ti->type)) {
>>>>>>  if (!ti->type->iterate_devices ||
>>>>>> -    ti->type->iterate_devices(ti,
>>>>>> device_not_zoned_model,
>>>>>> -      &zoned_model))
>>>>>> +    ti->type->iterate_devices(ti,
>>>>>> device_not_zoned,
>>>>>> +      &zoned))
>>>>>>  return false;
>>>>>>  } else if (!dm_target_supports_mixed_zoned_model(ti-
>>>>>>> type)) {
>>>>>> -if (zoned_model == BLK_ZONED_HM)
>>>>>> +if (zoned)
>>>>>>  return false;
>>>>>>  }
>>>>>>  }
>>>>>
>>>>> The parameter "bool zoned" is redundant. It should be removed
>> from
>>>> the
>>>>> above 3 functions
>>>
>>> The two func, is zoned and not zoned, are essentially the same.
>> They
>>> can be simplified into one function.
>>
>> Both functions are used for iterate_devices's callback in
>> dm_table_supports_zoned_model(). As shown in raid_iterate_devices(),
>> iterate_devices() returns 0 if the callback func calls on all the
>> devices
>> returns 0, or returns a non-zero result early otherwise. So, the
>> iterate_devices() call returns "true" if any one of the underlying
>> devices
>> is (zoned|not zoned).
>>
>> Since we cannot create lambda as in other fancy languages, we need
>> two
>> functions...
> 
> Not really, there is a "void *data" can be used.
> 
> The device_is_zoned_model() is just the same as the device_not_zoned()
> with (bool *)data = false.
> 
> It's very minor, so is okay to ignore my preference.

Send a patch on top of Christoph's series if you want to clean this up.

-- 
Damien Le Moal
Western Digital Research


