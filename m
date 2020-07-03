Return-Path: <SRS0=BHMv=AO=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E80FFC433E0
	for <linux-nvme@archiver.kernel.org>; Fri,  3 Jul 2020 08:36:00 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A8437206DF
	for <linux-nvme@archiver.kernel.org>; Fri,  3 Jul 2020 08:36:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="QWju1iYR";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Fq6EalpT";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="i7XiW8RR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8437206DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:To:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=nvFLf8zQSEjLsOcZHqgPV3ipUff/b1OnzEAkv0YwGFY=; b=QWju1iYRDFliCglfEOpyswqvf
	uD5BNdK7xaTwFPoeBMICD2Bib8pj8PqaZB2KaqZpT1pheV/Qt7ZloyoQDeV/k6HfOymWdCnmoakI2
	/nBhgvwIJ1qHzgtRd0dSsHzEt3KXyyzUEnooRtP3vq6zc/yizkIWAkj0QAEAndwWQ+IjlNshAQBMf
	LMKcMLui4pE04uB5XISkQrQ97GZhbVMRKE/gp0sq6Hvoz9frNsJuFkvzWiw4+eUXYX6vWoPxxhtsu
	ZBpmqI66SnnMYK72xIm1c93Fftm/wfca77BIoWtzwxRcaPLeAtfjYz/QE2DJk9RFuP6XeUkPe1lF+
	QVUnGJTyw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jrHAq-0000YS-Fl; Fri, 03 Jul 2020 08:35:56 +0000
Received: from esa1.hgst.iphmx.com ([68.232.141.245])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jrHAn-0000Wv-Ih
 for linux-nvme@lists.infradead.org; Fri, 03 Jul 2020 08:35:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1593765353; x=1625301353;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=UdhxYqoXNFymH2taaXaow1fKkDP/Y5TtDNqjca6rW1I=;
 b=Fq6EalpTCm9boBBkFTyjgcm65mA3tk+zreDZpoKYJUykrg4a3qqyOnf3
 r9T20NDCghqHbuCIxBuJRb8yQuxwhJ94qDnDifApHxtLoTDbiUAsa1BJL
 8DEFOap3W1k7e3lHK2KoqSWL1NBeDWFVVx2HyUjknjH0Jx+Er/aUlR3pv
 f0PNUsJdTB/435xSksEGxri8l4NqGUVwwgnc4ZGhWzIdY4hUmwpZah11c
 dfg9cGRURanf5ny7Rncaq33TteSFoxsBnMUndsIKcdZreS2WlWOPo3LSx
 uFc2bCediHMF2PtOGMIffqACFibuQfxE6rQX9IWvTD74DgSBOUv7Mo9uJ g==;
IronPort-SDR: OEGNoiowuIEfxw98RNX7mgefr4RX025NRIK+Vf7AqVnSf5625CiTTM7dxXjuYhZhLYIvE93Bcf
 rCjDKAWhz3EM4sI1UOkWV1Oyc2djdCE2ngtF1VLjlHAbA3rkrK9MVwnPoBj6fbL/BuB5Ks5fye
 0TXrfEKBbG1iymbiZQiCy1Ys99ZjEUSuld3dhcPo0/ofnYxhdf5aD9u9eP1rf5052qWWn0al9E
 WNjqfQHYdMXSXm2tUwN1QAnk9P4Uhey6d9dbxCWxUiSqjKxPhq2fomIESJV6TT/3PQbb6EvYDV
 RaI=
X-IronPort-AV: E=Sophos;i="5.75,307,1589212800"; d="scan'208";a="250799897"
Received: from mail-bn8nam12lp2171.outbound.protection.outlook.com (HELO
 NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.171])
 by ob1.hgst.iphmx.com with ESMTP; 03 Jul 2020 16:35:50 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WCEEQA7pGsg4Z66cBZZEUbeh8i2hgr4ekEEryvIbacpdSBfLeJb6W9To7QB8/tW12BgNVqZ+XD0mjl7lFRF6/gDBTuKVgOQ05681NvFoGMSNJGOP5bS6DYphkjBVfnIRXhannuPeJ6NmMcvA+xg40UxpXHTcDtLzWLwIf3wV7YsCpzAwGmEYuaCU/i7qAd4SZvi6FVOPUVjB9QN1PUBc7jUhgf42D/RGpHNIUDgpF5Ecxj1J/43Vvj2iKIwRu10AqqkGVx9SeoP+P3Lp/2DbrdtM3RlOXChUwxgYL0ZuXrQqNFtZagqjuRhWDfQ/qEVyhyV3+ZBLQ7PKUzPiXOuDYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eBPs77Zo62e7OIlyfmTx1N7Rj0Du7vjkHeGzZzXtnbI=;
 b=CP9DTzk/iRM1AtjGdKaCzl1qtfZK9jK1mmUZFXz7rBi/B4DFdPnGao3cZD/J5EgsUzyTKmlaP+m3sCsStAYinSnFU8wtawSTeu3Xu9GG45Ykc/JW5mg/2qhxyAPgp1sfxFLpGOkdKydzYk53Rot0qH4u4vjgEhB69MMQbAgDudS+AyTTiXo4BkaqnWowsa016pt+dy4NGy6IF2wbnAIThm+WnDl/3WJpHhj1d+wz9BADlEDMBmpZpShNqKy+39EvhIUeFhWeQbgQFdFrXVmkNK3+P2ei1oVMyw/b+UOerX75qYjkglFEG7Y79K6EUx3mizwWoPfaGWInbH2AsTDpfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eBPs77Zo62e7OIlyfmTx1N7Rj0Du7vjkHeGzZzXtnbI=;
 b=i7XiW8RRfL+HLOxFdkQtAZNtStb0JUD5RdtLCXJT/OOAetwXfQPWwqul0s8ru/fx+QcHE/zQSWyBTqpEc/tKkaOX78jOKHcoIPigNaWHT/2+OZGIGSMFGqAmhCRi9ZVoxWR+KIN4fk9dtmKpWTxzvkJbrl7b62w+q5E9xxr8XuQ=
Received: from CY4PR04MB3751.namprd04.prod.outlook.com (2603:10b6:903:ec::14)
 by CY4PR04MB0726.namprd04.prod.outlook.com (2603:10b6:903:e3::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.25; Fri, 3 Jul
 2020 08:35:48 +0000
Received: from CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::c593:f271:eebe:ac7]) by CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::c593:f271:eebe:ac7%9]) with mapi id 15.20.3153.022; Fri, 3 Jul 2020
 08:35:48 +0000
From: Damien Le Moal <Damien.LeMoal@wdc.com>
To: =?iso-8859-1?Q?Javier_Gonz=E1lez?= <javier@javigon.com>
Subject: Re: [PATCH 1/4] block: Add zone flags to queue zone prop.
Thread-Topic: [PATCH 1/4] block: Add zone flags to queue zone prop.
Thread-Index: AQHWUD25/vKGWWSejEep48tajSAGnw==
Date: Fri, 3 Jul 2020 08:35:48 +0000
Message-ID: <CY4PR04MB3751C8F2A0ECAFD045B30AA7E76A0@CY4PR04MB3751.namprd04.prod.outlook.com>
References: <20200702065438.46350-1-javier@javigon.com>
 <20200702065438.46350-2-javier@javigon.com>
 <CY4PR04MB37511008EEBF1A77DB4F423BE76D0@CY4PR04MB3751.namprd04.prod.outlook.com>
 <20200702083430.miax2cd44mkhc5fb@mpHalley.local>
 <CY4PR04MB375100663B25D1E1D8490758E76D0@CY4PR04MB3751.namprd04.prod.outlook.com>
 <20200702102714.d5igoqcvcavlunmv@mpHalley.local>
 <CY4PR04MB3751F621B2D32B5A47332644E76A0@CY4PR04MB3751.namprd04.prod.outlook.com>
 <20200703062815.qfo7tvonmgqqfcha@mpHalley.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: javigon.com; dkim=none (message not signed)
 header.d=none;javigon.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.182.57]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 595c59d3-4bff-419e-803e-08d81f2c162f
x-ms-traffictypediagnostic: CY4PR04MB0726:
x-microsoft-antispam-prvs: <CY4PR04MB0726144B4201E9484E54BFB8E76A0@CY4PR04MB0726.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 045315E1EE
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: M857AIYTb6hL4e1FI8LZ0S/9hHYvla+N/XMA+e+uvyaGa3nAVPrsOjeLd22scS6wqPSMu7+sTxI/mx9SJRqspMvHiG3JFC0mgkzff07Jb+X7u2FJu8K3/8jnUb3yVVYBzq+xPMTrNPr7evL/Qj2sE8Qv4XY70VeFy+YCwv871gqNqAxz7IAcCWafQDkeUzMWoSnfCUxyMkbLCCm/Qrk/R3g3sH2Kv3tNfXeBpUo5zVLgwkwz7PeOyKlMmkKOCcfhaLUXuZrTI0ZAshqP6ZV+qFaSjflWuCj84Km7SuQQM9xNcSxDaiw3oKoZpG1aCtSrCewdHji+da/EhvYrG0biLg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR04MB3751.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(346002)(396003)(376002)(39860400002)(136003)(66946007)(33656002)(52536014)(55016002)(66556008)(66476007)(5660300002)(9686003)(26005)(186003)(53546011)(64756008)(86362001)(8936002)(7416002)(7696005)(6506007)(91956017)(2906002)(83380400001)(66446008)(4326008)(6916009)(478600001)(71200400001)(316002)(76116006)(54906003)(8676002)(66574015);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: PROHB+0JOC7zJGgxQ82oTZEDBZD7i57DE/Z+u79KNPqybxLRD2KDP2tADoi3QQ9fRVV0FJ86pboNtKCfwW08rXiDnC9mtroxzJ0fJiXW9flSIUB4GECmVU8anUB3XuZ1nAE4asYA6BYL0oySP6Rv1TzoAEHSP+SjcCzM4VTuxJoN2iznwKxAltKWdKcRISSfmlbO5bQWbWWnsam5GSmWYDvE0CeEGOZfql60IohAGqDf4R4uipPJkKmGL5VWHCuG+4JnooSjco0D1V7Tu9WWwspLAYkgaXBO1BWw+78FKq4ofIAbmg4/lI074DvsnjN6zkTremXBtbg8zbJmFiBrgFL2UtOaDlp/ERxZV4Tk1oYgoB0lwU0C590Jm1NCAD5OP5XZJB5DUwd7QSm8RTFvl/FpSUqMr1DbrCncMwvVsc9sR644f7Z2w9QxKgwckq1ZbpB0eVPFy+PVJ0qy3iBl/xzg7+vtpYCnJ5ufobuH68lkVp2UUlyoD9Xrt8VvK6AQ
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR04MB3751.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 595c59d3-4bff-419e-803e-08d81f2c162f
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jul 2020 08:35:48.2869 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qr57P60q27fpgHO3rhUXxKrlfJr9pDiesufmHCgsy8UKCleicL25GaZxTx5zIZ/W03Wji6Y2NYqSIngl6c7jJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR04MB0726
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200703_043553_899748_372D407D 
X-CRM114-Status: GOOD (  32.85  )
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
Cc: "axboe@kernel.dk" <axboe@kernel.dk>,
 SelvaKumar S <selvakuma.s1@samsung.com>, "sagi@grimberg.me" <sagi@grimberg.me>,
 Kanchan Joshi <joshi.k@samsung.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Nitesh Shetty <nj.shetty@samsung.com>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "kbusch@kernel.org" <kbusch@kernel.org>, "mb@lightnvm.io" <mb@lightnvm.io>,
 "hch@lst.de" <hch@lst.de>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 2020/07/03 15:28, Javier Gonz=E1lez wrote:
> On 03.07.2020 05:20, Damien Le Moal wrote:
>> On 2020/07/02 19:27, Javier Gonz=E1lez wrote:
>>> On 02.07.2020 08:49, Damien Le Moal wrote:
>>>> On 2020/07/02 17:34, Javier Gonz=E1lez wrote:
>>>>> On 02.07.2020 07:54, Damien Le Moal wrote:
>>>>>> On 2020/07/02 15:55, Javier Gonz=E1lez wrote:
>>>>>>> From: Javier Gonz=E1lez <javier.gonz@samsung.com>
>>>>>>>
>>>>>>> As the zoned block device will have to deal with features that are
>>>>>>> optional for the backend device, add a flag field to inform the blo=
ck
>>>>>>> layer about supported features. This builds on top of
>>>>>>> blk_zone_report_flags and extendes to the zone report code.
>>>>>>>
>>>>>>> Signed-off-by: Javier Gonz=E1lez <javier.gonz@samsung.com>
>>>>>>> Signed-off-by: SelvaKumar S <selvakuma.s1@samsung.com>
>>>>>>> Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>
>>>>>>> Signed-off-by: Nitesh Shetty <nj.shetty@samsung.com>
>>>>>>> ---
>>>>>>>  block/blk-zoned.c              | 3 ++-
>>>>>>>  drivers/block/null_blk_zoned.c | 2 ++
>>>>>>>  drivers/nvme/host/zns.c        | 1 +
>>>>>>>  drivers/scsi/sd.c              | 2 ++
>>>>>>>  include/linux/blkdev.h         | 3 +++
>>>>>>>  5 files changed, 10 insertions(+), 1 deletion(-)
>>>>>>>
>>>>>>> diff --git a/block/blk-zoned.c b/block/blk-zoned.c
>>>>>>> index 81152a260354..0f156e96e48f 100644
>>>>>>> --- a/block/blk-zoned.c
>>>>>>> +++ b/block/blk-zoned.c
>>>>>>> @@ -312,7 +312,8 @@ int blkdev_report_zones_ioctl(struct block_devi=
ce *bdev, fmode_t mode,
>>>>>>>  		return ret;
>>>>>>>
>>>>>>>  	rep.nr_zones =3D ret;
>>>>>>> -	rep.flags =3D BLK_ZONE_REP_CAPACITY;
>>>>>>> +	rep.flags =3D q->zone_flags;
>>>>>>
>>>>>> zone_flags seem to be a fairly generic flags field while rep.flags i=
s only about
>>>>>> the reported descriptors structure. So you may want to define a
>>>>>> BLK_ZONE_REP_FLAGS_MASK and have:
>>>>>>
>>>>>> 	rep.flags =3D q->zone_flags & BLK_ZONE_REP_FLAGS_MASK;
>>>>>>
>>>>>> to avoid flags meaningless for the user being set.
>>>>>>
>>>>>> In any case, since *all* zoned block devices now report capacity, I =
do not
>>>>>> really see the point to add BLK_ZONE_REP_FLAGS_MASK to q->zone_flags=
, especially
>>>>>> considering that you set the flag for all zoned device types, includ=
ing scsi
>>>>>> which does not have zone capacity. This makes q->zone_flags rather c=
onfusing
>>>>>> instead of clearly defining the device features as you mentioned in =
the commit
>>>>>> message.
>>>>>>
>>>>>> I think it may be better to just drop this patch, and if needed, int=
roduce the
>>>>>> zone_flags field where it may be needed (e.g. OFFLINE zone ioctl sup=
port).
>>>>>
>>>>> I am using this as a way to pass the OFFLINE support flag to the block
>>>>> layer. I used this too for the attributes. Are you thinking of a
>>>>> different way to send this?
>>>>>
>>>>> I believe this fits too for capacity, but we can just pass it in
>>>>> all report as before if you prefer.
>>>>
>>>> The point is that this patch as is does nothing and is needed as a pre=
paratory
>>>> patch if we want to have the offline flag set in the report. But:
>>>> 1) As commented in the offline ioctl patch, I am not sure the flag mak=
es a lot
>>>> of sense. sysfs or nothing at all may be OK as well. When we introduce=
d the new
>>>> open/close/finish ioctls, we did not add flags to signal that the devi=
ce
>>>> supports them. Granted, it was for nullblk and scsi, and both had the =
support.
>>>> But running an application using these on an old kernel, and you will =
get
>>>> -ENOTTY, meaning, not supported. So simply introducing the offline ioc=
tl without
>>>> any flag would be OK I think.
>>>
>>> I see. My understanding after some comments from Christoph was that we
>>> should use these bits to signal any optional features / capabilities
>>> that would depend on the underlying driver, just as it is done with the
>>> capacity flag today.
>>>
>>> If not for the offline transition, for the attributes, I see it exactly
>>> as the same use case as capacity, where we signal that a new field is
>>> reported in the report structure.
>>>
>>> Am I missing something here?
>>
>> Using the report flags for reporting supported operations/features is fi=
ne, but
>> as already mentioned, then document that by changing the description of =
enum
>> blk_zone_report_flags. Right now, it still says:
>>
>> * enum blk_zone_report_flags - Feature flags of reported zone descriptor=
s.
>>
>> Which kind of really point to things the zone descriptor itself has comp=
ared to
>> earlier versions of the descriptor rather than what the device can do or=
 not.
> =

> I see how the offline transition collides with this model. But can we
> agree that the zone attributes is something that fits here?

Flags may be fine. I still do not see it though due to your patches missing
device mapper support. Please send patches that cover all zoned block device
types, including device mapper to show that this is a good approach.

>> And as I argued already, using a flag is fine only for letting a user kn=
ow about
>> a supported feature, but that is far from ideal to have device-mapper ea=
sily
>> discover what a target can support or not. For that, stacked queue limit=
s are
>> much simpler. Which leads to exporting that limit in sysfs rather than u=
sing a
>> flag for the user interface.
> =

> See below
> =

>>
>>>> Since DM support for this would be nice too and we now are in a situat=
ion where
>>>> not all devices support the  ioctl, instead of a report flag (a little=
 out of
>>>> place), a queue limit exported through sysfs may be a cleaner way to b=
oth
>>>> support DM correctly (stacked limits) and signal the support to the us=
er. If you
>>>> choose this approach, then this patch is not needed. The zoned_flags, =
or a
>>>> regular queue flag like for RESET_ALL can be added in the offline ioct=
l patch.
>>>
>>> I see. If we can reach an agreement that the above is a bad
>>> understanding on my side, I will be happy to translate this into a sysfs
>>> entry. If it is OK, I'll give it this week in the mailing list and send
>>> a V4 next week.
>>
>> It is all about device mapper support... How are you planning to do it u=
sing a
>> queue flag without said flags being stackable as queue limits ?
> =

> I guess what I am struggle with here is that you see the capacity
> feature as a different extension than the attributes and the offline
> transition.
> =

> The way I see it, there are things the device supports and things that
> the driver supports. ZAC/ZBC does not support a size !=3D capacity, but
> the driver sets these values to be the same. One thing I struggle with
> is that saying that we support capacity and setting size =3D capacity puts
> the burden in the user to check these values across all zones to
> determine if they can support the driver or not. I think it would be
> clear to have a feature explicitly stating that capacity !=3D size.

From the user (application or in-kernel) perspective, *all* zoned device now
have a zone capacity. I do not think it matters if that comes from the devi=
ce or
from the driver. It is unconditionally supported. The report flag
BLK_ZONE_REP_CAPACITY exist to signal to user applications that the zone
descriptor has the capactiy field, to allow for backward compatibility with
older kernels. See patches for fio or util-linux blkzone posted to see its =
use.

Having a flag that explicitly states that zone capacity !=3D zone size woul=
d be
useful only and only if *all* zones of the device have that property. What =
if
only some zones have a capacity lower than the zone size ? The user would s=
till
need a zone report to sort things out.

> For the attributes, this is very similar - some apply, some don't, and
> we only report the ones that make sense for each driver. I do not see
> how device mappers are treated differently here than in the existing
> capacity features.

The capacity feature is supported by *all* zoned block device. Support comi=
ng
from the device or from the driver does not matter. The API is consistent f=
or
all device types. So in my opinion, there is no need to consider zone capac=
ity
as an attribute. It is supported by everything, it is now part of the API,
signaled with BLK_ZONE_REP_CAPACITY for backward compatibility handling.

You are mixing up the report flags describing the structure of the zone
descriptor API with optional device features attributes. Adding an attribute
field to the report zones descriptors is fine. The presence of that field c=
an be
signaled with a BLK_ZONE_REP_ATTR report flag as you already proposed. No p=
roblem.

But then, imagine a device mapper target using multiple devices with differ=
ent
optional features. How do you propose that the device mapper target sorts t=
his
out and come up with a coherent set of attributes for its target report zon=
es ?
Please propose a solution for that. Your patches so far are all missing tha=
t.

> For the offline transition, I see that the current patches do not set
> flags properly and we would need to inherit the underlying device if we
> want to do it this way. I can understand from your comments that this is
> not a good way of doing it. I see in one of your comments from V1 that
> we could deal with this transition in the scsi driver and keep it in
> memory (i.e., device is still read-only, but driver transitions to
> offline) - can you comment on this?

That would not be persistent across reboot, unlike for ZNS drive. So forget
about this. That was wishful thinking from me. This will not work.

Explicit zone offlining is truly an optional feature of the device. Signali=
ng
its support to the user is necessary, but again, I would like that to be do=
ne in
a way that does not force device mapper targets to forever report nothing f=
or
the optional features. A flag field can certainly be used, but it has to  be
handled in blk_queue_stack_limits(). That may be as simple as taking a bitw=
ise
AND of each device zone attribute flags.


-- =

Damien Le Moal
Western Digital Research

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
