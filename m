Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C5AEC04A68
	for <linux-nvme@archiver.kernel.org>; Thu, 28 Jul 2022 12:25:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:CC:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=g0vMwBQ5DlDPVBGww017YlLtDSeGsxi+kmLcc7euZTI=; b=0G3Dhm60dGkh1h
	jb4Pivyy83tfILWf7x4C4gm3ED/luFukxE/K+EI+7odHXattTgKiTraC4snFlIo3yIx+aQL+O2x+9
	EUIFcSc4vNsOb0xtVToDlMSp5KpRKMSUcn+ccHX4KMcxiBUkqelByOdTzq0N6mWaATHFBWnjU2+nY
	GFcA/rQchzIO3ZKIXSo/wta3x43j5DSLCqdpibDs5t1x5zit/0MjL1VyVhCvCATPGVULEbvEJI4BH
	5v8qwN6FU3XPD/jOF2p/liVfvfhbD+EXcFVXWIyiI2KOBQLNnBlRpIXDh5+Jl25l+9trln1Ntf+IP
	K2rFazLr38bVMYFiO3XQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oH2Zc-009D3U-Qq; Thu, 28 Jul 2022 12:25:04 +0000
Received: from mailout1.w1.samsung.com ([210.118.77.11])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oH2ZY-009CyG-UU
	for linux-nvme@lists.infradead.org; Thu, 28 Jul 2022 12:25:02 +0000
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20220728122458euoutp013f45cd88b25baaa5235e3bf1f971f60a~F-c3xF3Th1569815698euoutp01p
	for <linux-nvme@lists.infradead.org>; Thu, 28 Jul 2022 12:24:58 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20220728122458euoutp013f45cd88b25baaa5235e3bf1f971f60a~F-c3xF3Th1569815698euoutp01p
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1659011098;
	bh=g0vMwBQ5DlDPVBGww017YlLtDSeGsxi+kmLcc7euZTI=;
	h=Date:Subject:To:CC:From:In-Reply-To:References:From;
	b=Y1KyDvGrPXYfyK6XC/M4x/JkwIhu4aXUyQHYtZUWXm8d/Zecf5vj3d7ZmDOMFmhHS
	 B3rfiFXKxHGpQ/nzxj5GGdkkc4fY7ZR09vIuy3d0qgvpFDlp7YZc+6fwTJSjOSaGSO
	 7o25aYDR9VoWJAHmTdWl1W4gVLtDoudAGTZghaGE=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20220728122458eucas1p2f6a3dc82c8874299cf12738d9323f961~F-c3fPVm81954419544eucas1p2e;
	Thu, 28 Jul 2022 12:24:58 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
	eusmges1new.samsung.com (EUCPMTA) with SMTP id 6C.41.09664.A1082E26; Thu, 28
	Jul 2022 13:24:58 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20220728122457eucas1p29f23e1181e0083319bf787dcbd10d36d~F-c3A2Q3O1768117681eucas1p2K;
	Thu, 28 Jul 2022 12:24:57 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
	eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20220728122457eusmtrp2effe5a2c79b67ca0f811eea703074aba~F-c2-2PWw0151001510eusmtrp2L;
	Thu, 28 Jul 2022 12:24:57 +0000 (GMT)
X-AuditID: cbfec7f2-d97ff700000025c0-8e-62e2801ae01f
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
	eusmgms1.samsung.com (EUCPMTA) with SMTP id DE.F6.09095.91082E26; Thu, 28
	Jul 2022 13:24:57 +0100 (BST)
Received: from CAMSVWEXC01.scsc.local (unknown [106.1.227.71]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20220728122457eusmtip208fb9038b74b0c501bf5a1b6918fc63c~F-c20eKYb3102831028eusmtip2h;
	Thu, 28 Jul 2022 12:24:57 +0000 (GMT)
Received: from [106.110.32.100] (106.110.32.100) by CAMSVWEXC01.scsc.local
	(2002:6a01:e347::6a01:e347) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
	Thu, 28 Jul 2022 13:24:56 +0100
Message-ID: <9eed99b8-7e35-841c-5ec1-97b7107f328f@samsung.com>
Date: Thu, 28 Jul 2022 14:24:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
	Thunderbird/91.11.0
Subject: Re: [PATCH v8 02/11] block: allow blk-zoned devices to have
 non-power-of-2 zone size
Content-Language: en-US
To: Damien Le Moal <damien.lemoal@opensource.wdc.com>, <hch@lst.de>,
	<axboe@kernel.dk>, <snitzer@kernel.org>, <Johannes.Thumshirn@wdc.com>
CC: <matias.bjorling@wdc.com>, <gost.dev@samsung.com>,
	<linux-kernel@vger.kernel.org>, <hare@suse.de>,
	<linux-block@vger.kernel.org>, <pankydev8@gmail.com>, <bvanassche@acm.org>,
	<jaegeuk@kernel.org>, <dm-devel@redhat.com>,
	<linux-nvme@lists.infradead.org>, Luis Chamberlain <mcgrof@kernel.org>
From: Pankaj Raghav <p.raghav@samsung.com>
In-Reply-To: <e9663c20-65d5-48f5-3fe1-e3a8f5ab3214@opensource.wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [106.110.32.100]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
	CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrLKsWRmVeSWpSXmKPExsWy7djPc7pSDY+SDPY8FbFYfbefzWLah5/M
	Fr/Pnme22PtuNqvFnkWTmCxWrj7KZPFk/Sxmi79d95gs9t7Stri8aw6bxfxlT9ktJrR9Zba4
	MeEpo8Wam09ZLE7cknbg97h8xdtj56y77B6Xz5Z6bFrVyeaxeUm9x+6bDWweO1vvs3q833cV
	KHS62uPzJjmP9gPdTAHcUVw2Kak5mWWpRfp2CVwZJ6+sYi6YpVDx+uQXpgbGN5JdjJwcEgIm
	Egvaetm6GLk4hARWMEosufqEHcL5wiixae1hVgjnM6PEhZcnGWFa9l2dywZiCwksZ5T48ywD
	wgYq2vtfE6JhN6PEqe1LmEASvAJ2Erv3fWfuYuTgYBFQlVj1Ng4iLChxcuYTFhBbVCBSYs3u
	s+wgtrBAvMSP44vA5jMLiEvcejIfbIyIQA+jxN/djCDzmQXWMUm0Hr3OBjKTTUBLorGTHcTk
	FHCTOLeNFaJVU6J1+292CFteYvvbOcwQ5ytJTJh3nw3CrpVYe+wM2MMSAvc4JVY2PIRKuEg0
	zvnKBGELS7w6voUdwpaR+L9zPlS8WuLpjd/MEM0tjBL9O9eD3SMhYC3RdyYHosZRYsHr54wQ
	YT6JG28FIe7hk5i0bTrzBEbVWUghMQvJx7OQvDALyQsLGFlWMYqnlhbnpqcWG+allusVJ+YW
	l+al6yXn525iBKbA0/+Of9rBOPfVR71DjEwcjIcYJTiYlUR4E6LvJwnxpiRWVqUW5ccXleak
	Fh9ilOZgURLnTc7ckCgkkJ5YkpqdmlqQWgSTZeLglGpg0vKb8lt8Sf1t8aPbq/M3XDjVf8FA
	LCHzd76nTbZW8wXRn76z61/Eaz96LDKj/eRCa419L4vFnesibj5q6nwXuFXBzKvCKOBAMZdV
	S+Dr3MKSq8GhDnlHb/FaJh2a0up9Y+Mtiasbz/ELtR08n9r/UHSukU2jJ1fHRLl/T65Vlkh9
	P7jvs3FC7dF3WR8kKoSnvKi7KP/eKz91ov2i92d/rpOcHs3xbrqrWtXnbx2NKgUtebPeXaxd
	HdCxO+Gh3LzTPA1ncu4ZeG3Zrz+1amqV1a/tDg7nuczk7u1Vfy/IE7tlTS+j/jb1Kd8jvrY9
	YfESL3UW3u0cwaBy9YvG1LPMhn12Ls18FxYKZWyo3BCnxFKckWioxVxUnAgASqZ/z/ADAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprMKsWRmVeSWpSXmKPExsVy+t/xe7qSDY+SDNrXG1isvtvPZjHtw09m
	i99nzzNb7H03m9Viz6JJTBYrVx9lsniyfhazxd+ue0wWe29pW1zeNYfNYv6yp+wWE9q+Mlvc
	mPCU0WLNzacsFiduSTvwe1y+4u2xc9Zddo/LZ0s9Nq3qZPPYvKTeY/fNBjaPna33WT3e77sK
	FDpd7fF5k5xH+4FupgDuKD2bovzSklSFjPziElulaEMLIz1DSws9IxNLPUNj81grI1MlfTub
	lNSczLLUIn27BL2Mk1dWMRfMUqh4ffILUwPjG8kuRk4OCQETiX1X57J1MXJxCAksZZR41fmG
	ESIhI/Hpykd2CFtY4s+1Lqiij4wSH++eYoZwdjNK3Dn0igmkilfATmL3vu9ACQ4OFgFViVVv
	4yDCghInZz5hAbFFBSIlHi5rAisXFoiX+HF8ERuIzSwgLnHryXywuIhAD6PE392MIPOZBdYx
	SbQevQ5WJCTwm1Hixl8bkPlsAloSjZ3sICangJvEuW2sEGM0JVq3/2aHsOUltr+dwwxxv5LE
	hHn32SDsWolX93czTmAUnYXkullIrpiFZNQsJKMWMLKsYhRJLS3OTc8tNtQrTswtLs1L10vO
	z93ECEwd24793LyDcd6rj3qHGJk4GA8xSnAwK4nwJkTfTxLiTUmsrEotyo8vKs1JLT7EaAoM
	oYnMUqLJ+cDklVcSb2hmYGpoYmZpYGppZqwkzutZ0JEoJJCeWJKanZpakFoE08fEwSnVwGTj
	Vr3nVcDmZ3FPMstymM4kzrpaJtmwSWXxypzSOobkY0L/lt1Z/+3ejMOPnF5wGOXdu7g3aMmX
	l/k5LDl3AtU9NKabhXySuDHfQrxFuHz3/T9O/Af7Iha1rsg8sYtdzVV499t7+0+5ZygHi+8o
	mN+/9VvsvG/tkdyFB3d9uyfQeb1YgDXFxvHF2lu5fSG2le8s+SP61TdoiDw6VWUzq/bXCqXn
	TLs40g5leaxp9/p5I4Uz2nRC0M6pphuMtbXyvZin691mDK29elLU+/zmqNSrBU2K5lwtm68I
	XGeXqUja2y+ru+T106YvbGu+eLRUcgcLPjJq8XjxUu7usqX657JCD7MH7nqernNa/fDsaUos
	xRmJhlrMRcWJAHz0XuCmAwAA
X-CMS-MailID: 20220728122457eucas1p29f23e1181e0083319bf787dcbd10d36d
X-Msg-Generator: CA
X-RootMTR: 20220727162248eucas1p2ff8c3c2b021bedcae3960024b4e269e9
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220727162248eucas1p2ff8c3c2b021bedcae3960024b4e269e9
References: <20220727162245.209794-1-p.raghav@samsung.com>
	<CGME20220727162248eucas1p2ff8c3c2b021bedcae3960024b4e269e9@eucas1p2.samsung.com>
	<20220727162245.209794-3-p.raghav@samsung.com>
	<e9663c20-65d5-48f5-3fe1-e3a8f5ab3214@opensource.wdc.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220728_052501_289509_1F2E7BDA 
X-CRM114-Status: GOOD (  25.06  )
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

On 2022-07-28 05:07, Damien Le Moal wrote:
> On 7/28/22 01:22, Pankaj Raghav wrote:
>> Checking if a given sector is aligned to a zone is a common
>> operation that is performed for zoned devices. Add
>> bdev_is_zone_start helper to check for this instead of opencoding it
> 
> The patch actually introduces bdev_is_zone_aligned(). I agree with Bart
> that bdev_is_zone_start() is a better name.
I have posted my rationale behind this change in my reply to Bart. Let
me know what you think.
>

<snip>
>>  		args->zone_sectors = zone->len;
>> -		args->nr_zones = (capacity + zone->len - 1) >> ilog2(zone->len);
>> +		args->nr_zones = div64_u64(capacity + zone->len - 1, zone->len);
> 
> 		args->nr_zones = disk_zone_no(disk, capacity);
> 
We are doing a round up with a division here mainly to take into account
the last unequal zone if present. disk_zone_no does just a division so
it won't account for the unequal last zone.

>>  	} else if (zone->start + args->zone_sectors < capacity) {
>>  		if (zone->len != args->zone_sectors) {
>>  			pr_warn("%s: Invalid zoned device with non constant zone size\n",
>> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
>> index 85b832908f28..1be805223026 100644
>> --- a/include/linux/blkdev.h
>> +++ b/include/linux/blkdev.h
>> @@ -634,6 +634,11 @@ static inline bool queue_is_mq(struct request_queue *q)
>>  	return q->mq_ops;
>>  }
>>  
>> +static inline struct request_queue *bdev_get_queue(struct block_device *bdev)
>> +{
>> +	return bdev->bd_queue;	/* this is never NULL */
>> +}
>> +
>>  #ifdef CONFIG_PM
>>  static inline enum rpm_status queue_rpm_status(struct request_queue *q)
>>  {
>> @@ -665,6 +670,25 @@ static inline bool blk_queue_is_zoned(struct request_queue *q)
>>  	}
>>  }
>>  
>> +static inline bool bdev_is_zoned(struct block_device *bdev)
>> +{
>> +	struct request_queue *q = bdev_get_queue(bdev);
>> +
>> +	if (q)
>> +		return blk_queue_is_zoned(q);
>> +
>> +	return false;
>> +}
>> +
>> +static inline sector_t bdev_zone_sectors(struct block_device *bdev)
>> +{
>> +	struct request_queue *q = bdev_get_queue(bdev);
>> +
>> +	if (!blk_queue_is_zoned(q))
>> +		return 0;
>> +	return q->limits.chunk_sectors;
>> +}
>> +
>>  #ifdef CONFIG_BLK_DEV_ZONED
>>  static inline unsigned int disk_nr_zones(struct gendisk *disk)
>>  {
>> @@ -684,6 +708,30 @@ static inline unsigned int disk_zone_no(struct gendisk *disk, sector_t sector)
>>  	return div64_u64(sector, zone_sectors);
>>  }
>>  
>> +static inline sector_t bdev_offset_from_zone_start(struct block_device *bdev,
>> +						   sector_t sec)
>> +{
>> +	sector_t zone_sectors = bdev_zone_sectors(bdev);
>> +	u64 remainder = 0;
>> +
>> +	if (!bdev_is_zoned(bdev))
>> +		return 0;
>> +
>> +	if (is_power_of_2(zone_sectors))
>> +		return sec & (zone_sectors - 1);
>> +
>> +	div64_u64_rem(sec, zone_sectors, &remainder);
>> +	return remainder;
>> +}
>> +
>> +static inline bool bdev_is_zone_aligned(struct block_device *bdev, sector_t sec)
>> +{
>> +	if (!bdev_is_zoned(bdev))
>> +		return false;
> 
> This is checked in bdev_offset_from_zone_start(). No need to add it again
> here.
> 
bdev_offset_from_zone_start returns 0 if the device is not zoned, and
the below check will then return `true`. That is why I explicitly return
a false if the device is not zoned.
>> +
>> +	return bdev_offset_from_zone_start(bdev, sec) == 0;
>> +}
>> +
>>  static inline bool disk_zone_is_seq(struct gendisk *disk, sector_t sector)
>>  {
>>  	if (!blk_queue_is_zoned(disk->queue))
>> @@ -728,6 +776,18 @@ static inline unsigned int disk_zone_no(struct gendisk *disk, sector_t sector)
>>  {
>>  	return 0;
>>  }
>> +
>> +static inline sector_t bdev_offset_from_zone_start(struct block_device *bdev,
>> +						   sector_t sec)
>> +{
>> +	return 0;
>> +}
> 
> This one is not used when CONFIG_BLK_DEV_ZONED is not set. No need to
> define it.
> 
Ok. I will remove it if it is not required.
>> +
>> +static inline bool bdev_is_zone_aligned(struct block_device *bdev, sector_t sec)
>> +{

> 

