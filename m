Return-Path: <SRS0=a62X=FU=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0483CC4361B
	for <linux-nvme@archiver.kernel.org>; Wed, 16 Dec 2020 05:10:07 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5618A23130
	for <linux-nvme@archiver.kernel.org>; Wed, 16 Dec 2020 05:10:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5618A23130
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:To:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=XVmMtXSyHFkx1M1Bd8dLmGs0ELmJS3KmFdkik60Tpew=; b=xgZ1Bx8edEEz6Gc4EubBTHqil
	BEhZ5lhtVHhyTX12xqWGEStTy2/GaSWrssALM7LZIsupgP3trNGus9S0nwLJVHZjW71mFBX/3XO6j
	yz0DZEwO89YTJA7ijlw9inxGHouAEOg1+k0oX5aO0Q9WXRrw3y5q3bfg4K2pUC1zrd9+FTC53SDt5
	zPYHCCMSyasKH2wcxTCxPSST6xskRbqtKCO5Btmk0CrFUreIUewCcU8h1hmfIACXH8+azRfixaRbN
	gEPPVNwVMmAflISk0VdFiA9jsmYfpPpLIdePjQlt8jDzPtCveJRIeH3P4umqdX2nSAmA/Ty2pfQ/3
	QHh6YVAMw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kpP4Y-0005A9-7q; Wed, 16 Dec 2020 05:09:58 +0000
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kpP4W-00059k-Qu
 for linux-nvme@lists.infradead.org; Wed, 16 Dec 2020 05:09:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1608095907; x=1639631907;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=ic9RiBjPpF2iayitjSm+Q5lbmTJo2dHWpx2rxBUEdEw=;
 b=d9dq3pgTvWOw4Q66hOBYycvRp4KX8A8qTquY9wR/mmlVvsSDNrTQieKP
 SxZdXARuLng9PC/MivVyB1pBYxOtL/p5DRLtnuOegUlLTmArhbx8DQh5u
 y5d8II1YipPLUTkot2qIuK0M2exSGVxMCtZ1tM11A5kWQJGf8hORsh/Tm
 bWSBmQcCnyW2ZSEg4h7SLqeyh4yIsXZbbvQJPKiUFLnDCjMlyLOoXlM9P
 lJsDOYhhC5Trzq65Qm7nVTpqtBMJa/jCyLQf52Majr1HparOyYb3BDbyt
 HJm1+m96/MgCwgQEgB6R9XsNX3kopRsGLlJVoXHvg33msiJ8RFtmTcjVz A==;
IronPort-SDR: o+P7PXCkyLk/H7UxzaL2iJ47AQyAyjuWt+n9dPynQrg6azsGsPUav1DFyzB8eZo6vYwIY532/0
 SSRfBVwmYOA3rx/CZ2BqTw/+8av2RXlUg+V6kMX7dx6Kjcka9RGubK7Ovfbk3hVQWHn68cIMmY
 7GNBfqO8Ai7EdbIcWgE8c/kmCFZAef1QGy/whk0t7/LXWlDzKDKiGwuDfY/ubBnJu95qtXHbMC
 rtKx43EZ0XgorUGTnwa6HEXXej7pxQgq+ppw60wOgAH5GBJVN65vj+ZZ2LLryAx9v8ewQ9vwQz
 Hgc=
X-IronPort-AV: E=Sophos;i="5.78,423,1599494400"; d="scan'208";a="259025095"
Received: from mail-bn8nam11lp2174.outbound.protection.outlook.com (HELO
 NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.174])
 by ob1.hgst.iphmx.com with ESMTP; 16 Dec 2020 13:18:25 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q2HGTuHnAePsAk3L7U9c0DeKkDYkZMtE+SBV5h2go5X5Vy43Lo9ZjrJe1tKOKS68gzvnpmQAW8xZtkayJn6XiS3G28fZyBN7FFkj09g4oE/J/XbB8wKWvVK1C/EzMOTpFsnAEeccj5vYkq8CPgC7Fp07xI9cFJqWT1yYpJijA+eXkmiwEB/v5i1hNdJJDAQ8itNo9MPLbHdzpDNkvnEXxhBdq0GEqBqj2oK/XJ0CgoJV55oA8jZRtHRWh1XCTbRr/CArscCVhLrBSOGm5/L9+J7C8fLY/ymzvdTFJfbwc6ztrNhSgB+VpyCdBOONAvz1f8gN7Ufd+7rkr05IXwO2wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mHraP1z+Z+6RMC+tsN+ZLPeXba/61qWzpfgB9Nx2sng=;
 b=MMu2k+ON/zQ1hZt/fMhtqiT9qEN3hxhQTWZj/rBkMv9PBOOXO7Y0xh1eoohZbbTaJz72/EvCxgv5U51PIHVelrBHdJKpBfkhtcNbjIUjlt2KHcRcrELLz0flfkw0M/Wt4+a7R8dC5YJf0m95cDiyeeATEF/xGincygX9vfVGVTdHLsKLvJjLEg/yD4JV1zf21tAQfhclz44rvX42M2f64vXGrsHw7MGEClVJlWDYDW6kBsl+5CMcbVpaPQwBNcdbjvDW9ulzTDS4tSmfc0zCbX876ULmciQRi+qBnxrmGnqz30s73nVfcS/o5F3/zPJj8XDrBRz+J+Pur0gZqZ59mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mHraP1z+Z+6RMC+tsN+ZLPeXba/61qWzpfgB9Nx2sng=;
 b=wazIJU9H4WOYPRihOGhcAmWaTHoFVExVxFu6DjK1W906UE0oBaWSxZDRXTl9TN14InLlJ/7/V9KiZmi4bfXf3Qxw9Mvd11udRO6wyKzNndU3Oso1f0XfWbT55nWFvaOu2tyOT4qeieLq4yHGYz8t2uf9wraJq4ZLdBiuVHm9Uw4=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB4232.namprd04.prod.outlook.com (2603:10b6:a02:fd::29)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.12; Wed, 16 Dec
 2020 05:09:53 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::716c:4e0c:c6d1:298a]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::716c:4e0c:c6d1:298a%6]) with mapi id 15.20.3654.020; Wed, 16 Dec 2020
 05:09:53 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Damien Le Moal <Damien.LeMoal@wdc.com>, "linux-block@vger.kernel.org"
 <linux-block@vger.kernel.org>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH V7 4/6] nvmet: add ZBD over ZNS backend support
Thread-Topic: [PATCH V7 4/6] nvmet: add ZBD over ZNS backend support
Thread-Index: AQHW0qgRNy69mNMtIEqLi2NUVHmAXg==
Date: Wed, 16 Dec 2020 05:09:53 +0000
Message-ID: <BYAPR04MB4965D34BAA03BF277FDD657086C50@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20201215060305.28141-1-chaitanya.kulkarni@wdc.com>
 <20201215060305.28141-5-chaitanya.kulkarni@wdc.com>
 <CH2PR04MB6522AC040C900B2574125884E7C60@CH2PR04MB6522.namprd04.prod.outlook.com>
 <BYAPR04MB49659C0D80D3D3EA2F2D24E886C60@BYAPR04MB4965.namprd04.prod.outlook.com>
 <CH2PR04MB6522763AB222AD6F6CBD3321E7C60@CH2PR04MB6522.namprd04.prod.outlook.com>
 <BYAPR04MB49655C8106D1B958D12CBF5886C50@BYAPR04MB4965.namprd04.prod.outlook.com>
 <CH2PR04MB65223C252505792FEC4B8734E7C50@CH2PR04MB6522.namprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2600:1700:31ee:290:21e3:a067:48d4:8fdf]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 672ddf93-49bc-4b43-ae9e-08d8a180d283
x-ms-traffictypediagnostic: BYAPR04MB4232:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR04MB423246FB6CC2AEA5C36666D086C50@BYAPR04MB4232.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IhUX2ABZr/X9owsgad5/gfdcdW9qFQmxuyXffzTGsmhhK43eXeHII6KliTdD3Lk+5q2BK+w3jBUuqQ0GAVSmAKQNNT9hPuGvU/Ky0hyxpE2Vg70EsbtTDAQrP9Of5VdtWi94yaKO0Mmltf+Z6tQMyQ2wRv79CKDYjlHgK44qjb2tWxTjnE9x6yGVr8OjyHF6wNnReiy3W0u+bBtLXuL+ZtsfKyzrr+ksffUw+NWFRsSEItMQFcdWjqvuDcn9Wx9LgW5IuxswvMw9qqhngzpnrP3JzUe4v0UIAINvSm5mn5eAMuoESuRKQIiP+Q3QICZ9b/Bm/hfQIehlHp3xKiR/Xw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(136003)(366004)(376002)(396003)(346002)(2906002)(7696005)(55016002)(6506007)(8936002)(33656002)(53546011)(64756008)(66446008)(66476007)(76116006)(478600001)(66556008)(66946007)(4326008)(186003)(9686003)(316002)(71200400001)(52536014)(8676002)(5660300002)(110136005)(54906003)(86362001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?VQAOoErqMJtfftZWXka2m/ae/e3F6facKpZeF2rEsqCyjUx1Wyzm8TTixHxm?=
 =?us-ascii?Q?cuvFjMTXSgWlKjoUVc6Ob4ZZg1dp4SNY+asH5dV1L+EMSQcFW5esg2Pt0VED?=
 =?us-ascii?Q?JB5QFWmLLRdu/gitIpKwlR5BK4VZlS2k0WfCKcZyJLiqPIuWerpNja+DXK2r?=
 =?us-ascii?Q?aEyScKn+OL4dKIdAbPlRyiTatm5o/XheI+DAkH8rFYZDu56jez6aKUgnasbR?=
 =?us-ascii?Q?EezXzb6QPboJhsZa1LgyNtP9HKmbrA+bgMXNRcmrhYIqxBgpbljZ4cTnyxg5?=
 =?us-ascii?Q?Pj1VV8F6T49WMRaU5PwWUGxa3oX4Rz11EUhy8W0alPVdPlA5poE1NFH7khZY?=
 =?us-ascii?Q?xxnk06gD6X801BSZqxICx5P0ISFCyi/AacBmEFapLQMq2X0Zm5ZfJceCzUcL?=
 =?us-ascii?Q?o61ztkbyOGAUrudhkvohxdFg+hd8XYLM84WTA8dnnDVJ4ygxVyD6gP9g9KWx?=
 =?us-ascii?Q?D06clahX5wMkRB3K6lVfOwa3gdCxtH8t6zLpfOA/ztNHjTFoa06hSwrKcrfj?=
 =?us-ascii?Q?COwj6Pds1lrJg1W5AqgvEaje+m2oGEc37Sf5dIzaGJQ7znaAsMmAa0GgMOcH?=
 =?us-ascii?Q?1ge2NXe8D4BFkF1ro0ePBV6CrwXWlrGS2X016CGFCNF4vmFBWEYaIQ24Rfpp?=
 =?us-ascii?Q?KE/8x8itNvNUfewWYCs1G221ZuaIkrhdOegSHidQFXorNoerVTxJPLLWaXsA?=
 =?us-ascii?Q?Ck1TK8Evgqpmzo3X00k8oWFrWzxNZCDIvXP8otBxDgxPnaF2uC6XVkk3o0UI?=
 =?us-ascii?Q?X5TOKJNfUs41KUQFYvj+oszYD/t0chNTBmAfRnFGUWcYCXq9Ly2J4yAANcKL?=
 =?us-ascii?Q?zbWWmxRYBUqBZgOMvctKQBI6cyXsAbmuGknYA4ZfLLcAYnGvDaTeDyRIZKN+?=
 =?us-ascii?Q?ii5QGyoZQPC390L21CSnp+/3sn2rktzjKays0Qk9jpKscHVCB9zGflHiLvXS?=
 =?us-ascii?Q?rNiV6u0sYPmpg3nHAnFjj9yom4AHxY+g9YQp5Fou9FOK6wo7KGlUPZ3mx8o3?=
 =?us-ascii?Q?j5x9QtTyTt/ttdf5M9rJ02bDRA5CgPFKK3VKuoCWtEapz+dnp5hZ9nJy6HDw?=
 =?us-ascii?Q?Zdwcb5uK?=
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 672ddf93-49bc-4b43-ae9e-08d8a180d283
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Dec 2020 05:09:53.1107 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: h7NPPdcPf1A1ISr0w6pL+kqw560Zb+ru6+yvt55Tj3JgJCV1oBfdyae/m9DaP4BcS0iQytTt0I0CJaN/hvNKFy3c52nB6rgQ7vQ+k/SAzWA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4232
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201216_000957_090995_CBEDF64C 
X-CRM114-Status: GOOD (  16.64  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: "sagi@grimberg.me" <sagi@grimberg.me>, "hch@lst.de" <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 12/15/20 7:43 PM, Damien Le Moal wrote:
> On 2020/12/16 12:13, Chaitanya Kulkarni wrote:
>> On 12/15/20 15:13, Damien Le Moal wrote:
>>> On 2020/12/16 8:06, Chaitanya Kulkarni wrote:
>>> [...]
>>>>>> +void nvmet_bdev_execute_zone_mgmt_recv(struct nvmet_req *req)
>>>>>> +{
>>>>>> +	sector_t sect = nvmet_lba_to_sect(req->ns, req->cmd->zmr.slba);
>>>>>> +	u32 bufsize = (le32_to_cpu(req->cmd->zmr.numd) + 1) << 2;
>>>>>> +	struct nvmet_report_zone_data data = { .ns = req->ns };
>>>>>> +	unsigned int nr_zones;
>>>>>> +	int reported_zones;
>>>>>> +	u16 status;
>>>>>> +
>>>>>> +	nr_zones = (bufsize - sizeof(struct nvme_zone_report)) /
>>>>>> +			sizeof(struct nvme_zone_descriptor);
>>>>> You could move this right before the vmalloc call since it is first used there.
>>>> There are only three lines between the this and the vmalloc, does that
>>>> really
>>>> going to make any difference ?
>>> It makes the code far easier to read and understand at a quick glance without
>>> having to go up and down reading to be reminded what nr_zones was. That also
>>> would avoid changes to sneak in between these related statements, making things
>>> even harder to read.
>>>
>>> I personally like to think of code as a natural language text: if statements
>>> related to each other are not grouped in a single paragraph, the text is really
>>> hard to understand...
>>>
>> hmmm, why can't we use a macro and like everywhere else in zns.c
>> we can declare-init the nr_zones which will make nr_zones initialization
>> uniform withall the code with a meaningful name.
>>
>> How about following (untested) ?
>>
>> diff --git a/drivers/nvme/target/zns.c b/drivers/nvme/target/zns.c
>> index 149bc8ce7010..6c497b60cd98 100644
>> --- a/drivers/nvme/target/zns.c
>> +++ b/drivers/nvme/target/zns.c
>> @@ -201,18 +201,19 @@ static int nvmet_bdev_report_zone_cb(struct
>> blk_zone *z, unsigned int idx,
>>         return 0;
>>  }
>>  
>> +#define NVMET_NR_ZONES_FROM_BUFSIZE(bufsize) \
>> +       ((bufsize - sizeof(struct nvme_zone_report)) / \
>> +                       sizeof(struct nvme_zone_descriptor))
>> +
>>  void nvmet_bdev_execute_zone_mgmt_recv(struct nvmet_req *req)
>>  {
>>         sector_t sect = nvmet_lba_to_sect(req->ns, req->cmd->zmr.slba);
>>         u32 bufsize = (le32_to_cpu(req->cmd->zmr.numd) + 1) << 2;
>>         struct nvmet_report_zone_data data = { .ns = req->ns };
>> -       unsigned int nr_zones;
>> +       unsigned int nr_zones = NVMET_NR_ZONES_FROM_BUFSIZE(bufsize);
> Hiding calculations in a macro does not help readability. And I do not see the
> point since this is used in one place only. If you want to isolate the report
> buffer allocation & nr zones calculation, then something like what scsi does in
> sd_zbc_alloc_report_buffer() (in drivers/scsi/sd_zbc.c) is in my opinion much
> cleaner.

This is what I was thinking about it since we also do similar buffer
allocation calculation

on the host side. Let me see if I can add that to V8.

>>         int reported_zones;
>>         u16 status;
>>  
>> -       nr_zones = (bufsize - sizeof(struct nvme_zone_report)) /
>> -                       sizeof(struct nvme_zone_descriptor);
>> -
>>         status = nvmet_bdev_zns_checks(req);
>>         if (status)
>>                 goto out;
>>
>>> -- Damien Le Moal Western Digital Research
>>
>


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
