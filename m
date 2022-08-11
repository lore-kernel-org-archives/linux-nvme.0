Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4076C25B0C
	for <linux-nvme@archiver.kernel.org>; Thu, 11 Aug 2022 13:13:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:CC:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=wVDcnmo85JOb/Wc3AoxiDTuKIhlC43tBAXn1wDhKCaY=; b=hhIALLCh3vsRKe
	EjuFJqUK/T+zLKT5v3urYAZLMDCsJxQU5ITtBKB6hd9mvvGDzeE6ayljPP7IovYCCqtBfcyYtWgWX
	iaFoXXa6IIy41La99U7ElMwE6nI2KoQS2lhijjB2Gw/62gTmo4H68bNg9rsi2r1bTjU3KOV6p6hip
	6TZkqg/rkY6l5wuu4PW8wUIoS/A/04a1chF4ULePJQq7Tu/iaBnGhCuZMf3VbIvCuBJ3Z3LfmMpnv
	B/RR31nAITtxz3+BybqugOL7OFwNUgW3OPAvWxb2KIH54YEo68WnH5s6s0knEjlc/iFoArKijv+kW
	H1NUhme6OYzWA/WYv7Kw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oM80T-00CVug-KS; Thu, 11 Aug 2022 13:13:49 +0000
Received: from mailout1.w1.samsung.com ([210.118.77.11])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oM80O-00CVo0-Fr
	for linux-nvme@lists.infradead.org; Thu, 11 Aug 2022 13:13:48 +0000
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20220811131335euoutp0119d6f81f5121d955f7edb6ba38aeab1a~KTJUdqZhQ0375403754euoutp01M
	for <linux-nvme@lists.infradead.org>; Thu, 11 Aug 2022 13:13:35 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20220811131335euoutp0119d6f81f5121d955f7edb6ba38aeab1a~KTJUdqZhQ0375403754euoutp01M
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1660223616;
	bh=wVDcnmo85JOb/Wc3AoxiDTuKIhlC43tBAXn1wDhKCaY=;
	h=Date:Subject:To:CC:From:In-Reply-To:References:From;
	b=vgBsGsEu4Un7u+QLyMfg/KBYT3OjKzD0fKTIWaJ6pEXPI8AYmDF1unMvIFh0dONW0
	 AQSv/5Cs53vhpHKUbzA138vJf5lN5bTl5XUEGsiG26MILwb7c8Qm0hthJVyIiyDHe1
	 JtkbITsxRX8FYutshQAbAMexNWVEWoEhX+PjYWWU=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20220811131335eucas1p242dba0f0e0c88975262e8c23b160356f~KTJUFxrcB2271122711eucas1p2u;
	Thu, 11 Aug 2022 13:13:35 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
	eusmges2new.samsung.com (EUCPMTA) with SMTP id C7.B0.10067.F7005F26; Thu, 11
	Aug 2022 14:13:35 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20220811131335eucas1p25e679d6235436c7c5667ae643564b30f~KTJTkZ9os3176231762eucas1p2a;
	Thu, 11 Aug 2022 13:13:35 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
	eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20220811131334eusmtrp2a1e02cccf7cfd18e8e53d72ffda981c4~KTJTjbneG2687626876eusmtrp2E;
	Thu, 11 Aug 2022 13:13:34 +0000 (GMT)
X-AuditID: cbfec7f4-dd7ff70000002753-45-62f5007f1b69
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
	eusmgms1.samsung.com (EUCPMTA) with SMTP id B0.83.09095.E7005F26; Thu, 11
	Aug 2022 14:13:34 +0100 (BST)
Received: from CAMSVWEXC01.scsc.local (unknown [106.1.227.71]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20220811131334eusmtip239fdf39b6646965cc9b55507ec32d343~KTJTXGUVV0541005410eusmtip2L;
	Thu, 11 Aug 2022 13:13:34 +0000 (GMT)
Received: from [192.168.8.130] (106.210.248.43) by CAMSVWEXC01.scsc.local
	(2002:6a01:e347::6a01:e347) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
	Thu, 11 Aug 2022 14:13:32 +0100
Message-ID: <5512a55d-8852-db6d-6a54-9b8bb3cf2e96@samsung.com>
Date: Thu, 11 Aug 2022 15:13:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
	Thunderbird/91.11.0
Subject: Re: [PATCH v9 03/13] block: allow blk-zoned devices to have
 non-power-of-2 zone size
Content-Language: en-US
To: Damien Le Moal <damien.lemoal@opensource.wdc.com>,
	<Johannes.Thumshirn@wdc.com>, <snitzer@kernel.org>, <axboe@kernel.dk>,
	<agk@redhat.com>, <hch@lst.de>
CC: <dm-devel@redhat.com>, <matias.bjorling@wdc.com>,
	<gost.dev@samsung.com>, <linux-kernel@vger.kernel.org>,
	<pankydev8@gmail.com>, <jaegeuk@kernel.org>, <hare@suse.de>,
	<linux-block@vger.kernel.org>, <linux-nvme@lists.infradead.org>,
	<bvanassche@acm.org>, Luis Chamberlain <mcgrof@kernel.org>
From: Pankaj Raghav <p.raghav@samsung.com>
In-Reply-To: <d7343e70-cbfa-4163-a78e-963fbf3bb38c@opensource.wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [106.210.248.43]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
	CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrGKsWRmVeSWpSXmKPExsWy7djPc7r1DF+TDOZtlbNYf+oYs8Xqu/1s
	FtM+/GS2+H32PLPF3nezWS32LJrEZLFy9VEmiyfrZzFb/O26x2Sx95a2xeVdc9gs5i97ym4x
	oe0rs8WNCU8ZLdbcfMpiceKWtIOAx+Ur3h47Z91l97h8ttRj06pONo/NS+o9dt9sYPPY2Xqf
	1eP9vqtAodPVHp83yXm0H+hmCuCO4rJJSc3JLEst0rdL4Mo4tf8le0Eje8XfOW1MDYyXWbsY
	OTkkBEwkDn/cyd7FyMUhJLCCUWLNs+nMEM4XRom5i79CZT4zSpybNI8JpmXWy98sEInljBIb
	Vn9mhat6/aEJqn8Xo8T8cz/AtvAK2EksuPqbHcRmEVCVeLFjJxNEXFDi5MwnLCC2qECkxJrd
	Z8FqhAXiJd4v+AVmMwuIS9x6Mp8JZKiIwAKgDQsawdYxC6xjktj7vImxi5GDg01AS6KxE6yB
	U8BN4n3vFSaIZk2J1u2/oQbJS2x/O4cZpFxCQEli4wR+iHdqJdYeOwP2p4TAK06JQ/172CAS
	LhKfnkyF+llY4tXxLewQtozE/53zoeLVEk9v/GaGaG5hlOjfuZ4NYoG1RN+ZHIgaR4mDJz6w
	QoT5JG68FYQ4h09i0rbpzBMYVWchBcUsJC/PQvLBLCQfLGBkWcUonlpanJueWmyUl1quV5yY
	W1yal66XnJ+7iRGYFE//O/5lB+PyVx/1DjEycTAeYpTgYFYS4S1b9DlJiDclsbIqtSg/vqg0
	J7X4EKM0B4uSOG9y5oZEIYH0xJLU7NTUgtQimCwTB6dUAxPP9YOmEezPYnl49b4cENZ0e9ex
	cmds/XKZqxUZqk+2R1x/d6dLPKLc3KnCWOv20WWJfZdazf/4vYtrm3J1X2HoYyf7ix9YFBk2
	x/tXe3xf6Pz23f5gieeZc1SWSTqzHzESvH/uWX91EWNU9ISCAEfbW2d0b87+5l3I1jSNYyt/
	NDuL44p31+6xJm8V273BuTWK2/ZWlZC8i7+udLKu3OZz5ovjl31btHK7fUr5LRdfxsXxauUN
	Cge2JD9dW+juw6t7QuF92ToTB9c70zsvBxcLVGh/9j/tU3s9zy4gUqLg4/yeY/+3Jd+5ZyuZ
	dXPB4kSRaRO9sn4EfL6b/oeJ9Ui5awf7pYlqee/X/TyToMRSnJFoqMVcVJwIADviSVL5AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprFKsWRmVeSWpSXmKPExsVy+t/xe7p1DF+TDPbdMLVYf+oYs8Xqu/1s
	FtM+/GS2+H32PLPF3nezWS32LJrEZLFy9VEmiyfrZzFb/O26x2Sx95a2xeVdc9gs5i97ym4x
	oe0rs8WNCU8ZLdbcfMpiceKWtIOAx+Ur3h47Z91l97h8ttRj06pONo/NS+o9dt9sYPPY2Xqf
	1eP9vqtAodPVHp83yXm0H+hmCuCO0rMpyi8tSVXIyC8usVWKNrQw0jO0tNAzMrHUMzQ2j7Uy
	MlXSt7NJSc3JLEst0rdL0Ms4tf8le0Eje8XfOW1MDYyXWbsYOTkkBEwkZr38zdLFyMUhJLCU
	UaLlVzNUQkbi05WP7BC2sMSfa11sEEUfGSW2vNvCCuHsYpSYd2A2I0gVr4CdxIKrv8E6WARU
	JV7s2MkEEReUODnzCQuILSoQKfFwWRNYXFggXuL9gl9g9cwC4hK3nsxnAhkqIrCAUeL1gkaw
	DcwC65gkHvVNB7tJSOA3o8T6z7pdjBwcbAJaEo2dYM2cAm4S73uvMEEM0pRo3f4baqi8xPa3
	c5hByiUElCQ2TuCH+KZW4tX93YwTGEVnITlvFpIzZiGZNAvJpAWMLKsYRVJLi3PTc4sN9YoT
	c4tL89L1kvNzNzECE8m2Yz8372Cc9+qj3iFGJg7GQ4wSHMxKIrxliz4nCfGmJFZWpRblxxeV
	5qQWH2I0BYbRRGYp0eR8YCrLK4k3NDMwNTQxszQwtTQzVhLn9SzoSBQSSE8sSc1OTS1ILYLp
	Y+LglGpg4ua0aQ+J11fhUgvMLTjzdkbYV+mXywz7hHeuDp5+/Azv0mZe1p2xrx7subKS14/7
	ncGVwFgBntVPRes8dQ+JHm0SDFh4Ylv706ORuiw104vXiz+TPb7SYeey+p7i/z4zNj3Yrd6t
	ZPK63pF312TDm7EWLrebnYXLxVwsrht5l8rkzG+ewLftkJEUF/MSt8N5/cIaelLNbbUc/Ebm
	yi1cvduSDRdmHam5vjjeSv2t7MmbCnM/zO0svtFk1Z95hjlfa8XVT29S+UxKQrvTXxp63633
	7+cV2VOc98mkek1p1tdpLROWmnH+9d5V9HHh9zVZxZ8YT5Y3vdRatE238zKzfTSXz7tdTo9F
	6rR/MiixFGckGmoxFxUnAgCWd3/orQMAAA==
X-CMS-MailID: 20220811131335eucas1p25e679d6235436c7c5667ae643564b30f
X-Msg-Generator: CA
X-RootMTR: 20220803094805eucas1p1c68ba40d319331c2c34059f966ba2d83
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220803094805eucas1p1c68ba40d319331c2c34059f966ba2d83
References: <20220803094801.177490-1-p.raghav@samsung.com>
	<CGME20220803094805eucas1p1c68ba40d319331c2c34059f966ba2d83@eucas1p1.samsung.com>
	<20220803094801.177490-4-p.raghav@samsung.com>
	<d7343e70-cbfa-4163-a78e-963fbf3bb38c@opensource.wdc.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220811_061345_074089_8EF17DA5 
X-CRM114-Status: GOOD (  13.83  )
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

>>  static inline bool disk_zone_is_seq(struct gendisk *disk, sector_t sector)
>>  {
>>  	if (!blk_queue_is_zoned(disk->queue))
>> @@ -753,6 +777,12 @@ static inline unsigned int disk_zone_no(struct gendisk *disk, sector_t sector)
>>  {
>>  	return 0;
>>  }
>> +
>> +static inline bool bdev_is_zone_start(struct block_device *bdev, sector_t sec)
>> +{
>> +	return false;
>> +}
> 
> Is this one really necessary ? Any caller of this would also depend on
> CONFIG_BLK_DEV_ZONED and not compiled if not enabled. So there should be no
> callers of this for the !CONFIG_BLK_DEV_ZONED case.
> 
We are using it in dm-table.c in device_area_is_invalid() function. So
it can be called without being compiled with CONFIG_BLK_DEV_ZONED like
bdev_is_zoned() in dm-table.c.
>> +
>>  static inline unsigned int bdev_max_open_zones(struct block_device *bdev)
>>  {
>>  	return 0;
> 
> 

