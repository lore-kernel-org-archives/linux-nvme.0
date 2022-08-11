Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B7EDC19F2A
	for <linux-nvme@archiver.kernel.org>; Thu, 11 Aug 2022 13:18:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:CC:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Vun+gxn/6GGUdv/MRPXNdrbElNQFCuft36lThciOU28=; b=pgUCwHrFQlbvht
	1S6Do7FGK3xa/DXEcNRf6kvQ+iBCtY/5syqfC6aRekysgBBpKyq1CXHa7mvoyLUqjmMqoSUsWw+Cw
	fuAscf7p/C1XG/pDMgAsJrb94oqUlfUO8C4A8fo5+m1BQzxOgVgIs1yhs/tCRVnjpxTK6PCjYzmsl
	HPJJnhwu6HGUpKwqia9AqTZ7dnAKj0dx1K3Z/G+Dv8DbFbr5b60e1AMbYaU02jgHjOegEeWQo2a/o
	tBeXV7l5Kp3wbAqysU/KYBh7tes4oLSsMDCWKvfcC8XrG9PFaDq+okbp1sdJiGIWCTYyN1sUHJghm
	HhVQmdCUwd2L6VQz8i0Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oM84T-00CYLR-Bt; Thu, 11 Aug 2022 13:17:57 +0000
Received: from mailout2.w1.samsung.com ([210.118.77.12])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oM84P-00CYJM-Ru
	for linux-nvme@lists.infradead.org; Thu, 11 Aug 2022 13:17:55 +0000
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20220811131750euoutp02fe0957688235e4006f96a84ee75c13c1~KTNBff3UD3153131531euoutp02i
	for <linux-nvme@lists.infradead.org>; Thu, 11 Aug 2022 13:17:50 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20220811131750euoutp02fe0957688235e4006f96a84ee75c13c1~KTNBff3UD3153131531euoutp02i
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1660223870;
	bh=Vun+gxn/6GGUdv/MRPXNdrbElNQFCuft36lThciOU28=;
	h=Date:Subject:To:CC:From:In-Reply-To:References:From;
	b=O4xsWJm4cyq/4Yh0kN11fAjkgj2cpSM80dFLSBVBOmoH2STNgkj2OPqTg8iAx4FJF
	 l9dpnOldbBRSZjldGISht50wjzAusMdLbEjOcqpp+FfoKGNU0sexa4LuKrinANrVWT
	 JOQhMSV5f/BFc6lCfZceV3BjdlgZebPN6h0hqHcc=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTP id
	20220811131750eucas1p198d4a2f1cdb759f30a96e801edc14992~KTNBNGQux1197711977eucas1p1s;
	Thu, 11 Aug 2022 13:17:50 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
	eusmges2new.samsung.com (EUCPMTA) with SMTP id 2E.91.10067.E7105F26; Thu, 11
	Aug 2022 14:17:50 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20220811131749eucas1p2456bbf8f8a2538b9ecf9f5be0092b643~KTNA0jRaH1732617326eucas1p2I;
	Thu, 11 Aug 2022 13:17:49 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20220811131749eusmtrp1716c41bc4995b31c4e4725050f35189a~KTNAzmNiZ0860708607eusmtrp14;
	Thu, 11 Aug 2022 13:17:49 +0000 (GMT)
X-AuditID: cbfec7f4-dd7ff70000002753-ba-62f5017e867f
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id E4.A4.09038.D7105F26; Thu, 11
	Aug 2022 14:17:49 +0100 (BST)
Received: from CAMSVWEXC01.scsc.local (unknown [106.1.227.71]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20220811131749eusmtip1985b7f25892c387e44680c1d52d0068c~KTNAppwLl1773117731eusmtip1y;
	Thu, 11 Aug 2022 13:17:49 +0000 (GMT)
Received: from [192.168.8.130] (106.210.248.43) by CAMSVWEXC01.scsc.local
	(2002:6a01:e347::6a01:e347) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
	Thu, 11 Aug 2022 14:17:47 +0100
Message-ID: <f3ec55d3-f1fe-1875-f8e7-f7c46d89b065@samsung.com>
Date: Thu, 11 Aug 2022 15:17:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
	Thunderbird/91.11.0
Subject: Re: [PATCH v9 13/13] dm: add power-of-2 target for zoned devices
 with non power-of-2 zone sizes
Content-Language: en-US
To: Damien Le Moal <damien.lemoal@opensource.wdc.com>,
	<Johannes.Thumshirn@wdc.com>, <snitzer@kernel.org>, <axboe@kernel.dk>,
	<agk@redhat.com>, <hch@lst.de>
CC: <dm-devel@redhat.com>, <matias.bjorling@wdc.com>,
	<gost.dev@samsung.com>, <linux-kernel@vger.kernel.org>,
	<pankydev8@gmail.com>, <jaegeuk@kernel.org>, <hare@suse.de>,
	<linux-block@vger.kernel.org>, <linux-nvme@lists.infradead.org>,
	<bvanassche@acm.org>, Damien Le Moal <damien.lemoal@wdc.com>
From: Pankaj Raghav <p.raghav@samsung.com>
In-Reply-To: <b73143fd-107d-177d-d647-f17a32b9423e@opensource.wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [106.210.248.43]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
	CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrCKsWRmVeSWpSXmKPExsWy7djPc7p1jF+TDG5MYbdYf+oYs8Xqu/1s
	FtM+/GS2+H32PLNFa/s3Jou972azWuxZNInJYuXqo0wWT9bPYrb423UPKHFL2+LyrjlsFvOX
	PWW3mND2ldlizc2nLBYnbkk7CHhcvuLtsXPWXXaPy2dLPTat6mTz2Lyk3mP3zQY2j52t91k9
	3u+7ChQ6Xe3xeZOcR/uBbqYA7igum5TUnMyy1CJ9uwSujCcb57EWvBKsOHBEtoFxH08XIyeH
	hICJxITrn9m6GLk4hARWMEq0HrwG5XxhlNi2+Cg7hPOZUeLS3kmMMC0zfi5jhUgsZ5T4dXM+
	G1xV76UzUM4uRok3fVeZQVp4BewkJh+/ywJiswioSjQ0z2eFiAtKnJz5BCwuKhApsWb3WaB9
	HBzCAlkSL5/KgISZBcQlbj2ZzwQyU0RgAaPE6wWNYKuZBTYwSXz8384C0sAmoCXR2MkO0sAp
	4CYx7ed2JohmTYnW7b/ZIWx5ie1v5zCDlEsIKElsnMAP8U2txNpjZ8DelBB4xSlx5OFZdoiE
	i8Sz1zvZIGxhiVfHt0DFZSROT+5hgbCrJZ7e+M0M0dzCKNG/cz0bxAJrib4zORA1jhILT/ey
	Q4T5JG68FYQ4h09i0rbpzBMYVWchhcQsJC/PQvLBLCQfLGBkWcUonlpanJueWmyUl1quV5yY
	W1yal66XnJ+7iRGYEE//O/5lB+PyVx/1DjEycTAeYpTgYFYS4S1b9DlJiDclsbIqtSg/vqg0
	J7X4EKM0B4uSOG9y5oZEIYH0xJLU7NTUgtQimCwTB6dUA1NX/kPnfwXv2oyrF7ldvhs758xj
	hs6555Zmcsae9zmWY/XRw+DeMoWrZillB//kSbd94XyqqZ2mFlTPekWGpWbe2n3tgsGWZ4TY
	J3TOdJnwx1Jrx5XijjsTbgr2tW03Pabftrxi4i6hgqiiDLUJlavar1f95/kza+viFUsWNiWu
	erZM7G6u0kWhydV1emffbH0Rvbv006Smtmk+hXxTV3xi2+Qp9/d2ZXLY086PdWWHN1VX7dBd
	vWZ359wXBT3bp6utUUv4MK08znQun2qDq4Lu9p1u988fYMiXPtIUmvWyaf6GR8Z7cx9ICWx/
	JhBYsfTENYNJP3LjzC5J7lo2zTCaTZXJWntVssa21ENTn6sosRRnJBpqMRcVJwIAK5QPuvcD
	AAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprJKsWRmVeSWpSXmKPExsVy+t/xu7q1jF+TDN690rBYf+oYs8Xqu/1s
	FtM+/GS2+H32PLNFa/s3Jou972azWuxZNInJYuXqo0wWT9bPYrb423UPKHFL2+LyrjlsFvOX
	PWW3mND2ldlizc2nLBYnbkk7CHhcvuLtsXPWXXaPy2dLPTat6mTz2Lyk3mP3zQY2j52t91k9
	3u+7ChQ6Xe3xeZOcR/uBbqYA7ig9m6L80pJUhYz84hJbpWhDCyM9Q0sLPSMTSz1DY/NYKyNT
	JX07m5TUnMyy1CJ9uwS9jCcb57EWvBKsOHBEtoFxH08XIyeHhICJxIyfy1i7GLk4hASWMkp0
	nLzEApGQkfh05SM7hC0s8edaFxtE0UdGidVH1jBBOLsYJbZM7mMGqeIVsJOYfPwuWDeLgKpE
	Q/N8Voi4oMTJmU/A4qICkRIPlzUxgdjCAlkS635OAYszC4hL3HoyH2yoiMACRonXCxrBbmIW
	2MAkcXryTTaQKiGBP4wSk+9rdzFycLAJaEk0doKdxyngJjHt53YmiEGaEq3bf7ND2PIS29/O
	YQYplxBQktg4gR/im1qJV/d3M05gFJ2F5LxZSM6YhWTSLCSTFjCyrGIUSS0tzk3PLTbSK07M
	LS7NS9dLzs/dxAhMI9uO/dyyg3Hlq496hxiZOBgPMUpwMCuJ8JYt+pwkxJuSWFmVWpQfX1Sa
	k1p8iNEUGEYTmaVEk/OBiSyvJN7QzMDU0MTM0sDU0sxYSZzXs6AjUUggPbEkNTs1tSC1CKaP
	iYNTqoEpq2F2332RUgvfr/IOz9tf/nnptPtgm3t/QNwJ0WsdEi2m/C8jMisvsga8uHjKKrJJ
	bpPOggnnj/UtXV5Vbm2r37/3+w4R8Wf7Fzp8/b6epy0y+c3E6BnSaxqMK748lHskE7xM+PV9
	dnumjjsi75a9mPTNvMv6OHf4E+0n2SwCDq9mukTMOnNCN2penCn7hh+Tfmw7HF/cdq9TqnrO
	ZfWpYYVPQ64q8DgsvbW06XucUNzvlGMGDA0FUwtSnxq7OjcvPrJmi9zxuT7MglFbfvxe//B8
	R1Vc42XFVDMtxQXTDc5wMprwxK38P7Vi1dmrezYUuucqxPVV+63iLmVLKrFaPZvTnVfnQ5KO
	+VkvhelKLMUZiYZazEXFiQDruVpsrAMAAA==
X-CMS-MailID: 20220811131749eucas1p2456bbf8f8a2538b9ecf9f5be0092b643
X-Msg-Generator: CA
X-RootMTR: 20220803094816eucas1p1890ceb4faebaf4f0cdbc9581d1308672
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220803094816eucas1p1890ceb4faebaf4f0cdbc9581d1308672
References: <20220803094801.177490-1-p.raghav@samsung.com>
	<CGME20220803094816eucas1p1890ceb4faebaf4f0cdbc9581d1308672@eucas1p1.samsung.com>
	<20220803094801.177490-14-p.raghav@samsung.com>
	<b73143fd-107d-177d-d647-f17a32b9423e@opensource.wdc.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220811_061754_204871_EB8F9692 
X-CRM114-Status: GOOD (  19.71  )
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


>> +==========
>> +dm-po2zone
>> +==========
>> +The dm-po2zone device mapper target exposes a zoned block device with a
>> +non-power-of-2(npo2) zone number of sectors as a power-of-2(po2) zone number
> 
> s/zone number of sectors/number of sectors per zone (zone size)
> 
>> +of sectors.
>> +The filesystems that support zoned block devices such as F2FS and BTRFS
>> +assume po2 zone size sectors as the kernel has traditionally only supported
>> +those devices. However, as the kernel now supports zoned block devices with
>> +npo2 zone size sectors, the dm-po2zone target can be used by the filesystems
>> +before adding native support.
> 
> filesystems will not "use" the target. The user has to set up the target first
> and the filesystem will run on top of it. Detail, but rewording this make it
> clear that this is not an automatic thing magically happening.
> 
> Not that your patch series is lacking f2fs and btrfs patches to check for the
> power of 2 zone size of the zoned device. Unless these checks are already in place ?
> 
btrfs already had these checks in place and f2fs patch to allow only po2
zone size was already merged by Jaegeuk.

7f262f737502 ("f2fs: ensure only power of 2 zone sizes are allowed")
>> +
>> +Partial mapping of the underlying device is not supported by this target.
>> +
>> +Algorithm
>> +=========
>> +The device mapper target maps the underlying device's zone size to the
>> +zone capacity and changes the zone size to the nearest po2 number of sectors.
>> +The gap between the zone capacity and the zone size is emulated in the target.
>> +E.g., a zoned block device with a zone size (and capacity) of 3M will have an
>> +equivalent target layout with mapping as follows:
>> +
>> +::
>> +
>> +  0M           3M  4M        6M 8M
>> +  |             |  |          |  |
>> +  +x------------+--+x---------+--+x-------  Target
>> +  |x            |  |x         |  |x
>> +   x               x             x
>> +   x               x             x
>> +   x              x             x
>> +   x             x             x
>> +  |x            |x            |x
>> +  +x------------+x------------+x----------  Device
>> +  |             |             |
>> +  0M           3M            6M
>> +

