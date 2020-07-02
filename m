Return-Path: <SRS0=dOZ+=AN=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68844C433E0
	for <linux-nvme@archiver.kernel.org>; Thu,  2 Jul 2020 08:49:49 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 25ACF20884
	for <linux-nvme@archiver.kernel.org>; Thu,  2 Jul 2020 08:49:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="mBWrxwcg";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="oa6gSWUz";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="I0FUUrfr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25ACF20884
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:To:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=p5n4DNLvtAQ8oijxxW2iLxnA4NSjOz+Yr5cFPlQ98yA=; b=mBWrxwcgKslZrSpZLzn0q8nIE
	+07pRyEpfts6nMA70QUqIX0vd3dckxuY0O1nn2o3fUrxvvoXpIYh96UiSyWjbyAGjAl0zvkzrIRpl
	2+X/XKuhfOpui1HwtfUM0/SRezhxF4kuTKxXAvwZrI0VYywDHY8IuH9BzYfeeLHFAOB4NehnvSESs
	RJtJFeScOTYrobivIWrulaZS5oXX77r2A0npwRaQLmRaydFT2/zSzXALQkx+25azwgmS0k09l8SI+
	p+3mX9v458KOJu2bElxKrciN9JZp5pVI9hA2NfpvUcYLPnmr33xV4PmFVDxhpdfHwVh2K+c7jKK/q
	8L1GeIExw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jquuf-0004gJ-L3; Thu, 02 Jul 2020 08:49:45 +0000
Received: from esa3.hgst.iphmx.com ([216.71.153.141])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jquud-0004fl-UJ
 for linux-nvme@lists.infradead.org; Thu, 02 Jul 2020 08:49:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1593679784; x=1625215784;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=meUKV6ue7wmNi7x2zGibf/E8QYVphrLvBP+OWosfZIA=;
 b=oa6gSWUzNgt2dcfXjYzmJKPJR1vCM718w3+Zy/EXaaqIQmtgDT8ZLoy8
 eOIMjHRiRFQhCcvDq6qfLUjXOFhHDhLZe0fiAglSyv4XEFZ5f8F9BFJCs
 X0pQ049wGlxrGQLKvdFNcNn1HvSSbrYN1EOOsu7PRBOJmiO/kPfqrs1+C
 LPyzE1iZugFw00JVTnUYosro/9Hj5GY0PFsYwuD8Xaon2tndIrpFLhp1/
 MrMwqSavT7b85mEqsdozD0ZorPHRKKwQrLKJOklaDLdckWl7FXgxPvnlG
 3wJS6P8j6OJwKoTqE1VeUo8XPuJ5HLsJ1XKDH/SfkwCJkIBZVHQe4OI+2 Q==;
IronPort-SDR: yjfwn+LDe4OtVsoVI+kYHNLGOKe9bvQ/jXypOgxHnQn4C5J2SNcf7+VTJEkkeQ2TNmOdn91L0G
 TtBKsFqmybnTGGIKIJnj0wvmMLaBXMP18YEC4OzwAmjQO3rVNw/nBbvrZTccjFK0q3G3nwvrkZ
 raOnUenk7A5dJ/69rTijBR0E0EQ4tD28BGR0UUj6EmG34bvjCzpWxb/jh0eeRuCAqPC0YZfjFa
 /oHditIiAtgRw0EXHB9gEbBpfoMDDm8wIHnTEskTEF+xdCZndFXV5OyimUftIOMnpUoYGI0KJk
 O0I=
X-IronPort-AV: E=Sophos;i="5.75,303,1589212800"; d="scan'208";a="145793424"
Received: from mail-bn3nam04lp2056.outbound.protection.outlook.com (HELO
 NAM04-BN3-obe.outbound.protection.outlook.com) ([104.47.46.56])
 by ob1.hgst.iphmx.com with ESMTP; 02 Jul 2020 16:49:42 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wjln7DjYs6bEF2cSM3Fuyuocf8FEgfGt2nWt0c6H4tnEaTw6CyVgacmWxrSqHoxILHTDtHfpD99V8fFQNy+9TNoieynt6k8Sq8uSo888HcTB0VRaWD0eJkfZuorJ9lssFMqjQPbxUC6IJzA7DAsJD6qLV19Ook6aJbBE177yptBWDFz399yB+T7082o9vDnM6xa1MO3wW14idiXkFViwl3IyZIjAkQiW4+WB1R/cC3lNLsdqOXvE3w7QzfypUFV6mKrr725j6KGjkOSgCwSCaFnOQ7DLkclU0uCb1HrRVzMJSocVwCZpbOtRlp53Irt7v88vYXvWNU/I8/4xsVue2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GUJT3j2FMjT5qfuC0FWvTkvorU3dXLEOfdAaTaryWII=;
 b=MVCAP4JOL3XCqexoGgMd0Ln9XMv44Fa0eZRWTJrCyoOAsORtTMOeWhVo7nUBkk2GrwK/pu+OiN4/7WBHuRfPwAfiUvZaLvBIJhlY7TuefUDs7znsf3Q/IhsuOa86U+b/O9uPi1SeqSVBgwBwtgt17l5oJP6Txg8YpkveXeCCTtzKJf/Kjy8Z/+/nWQahadVhCvySnTvuAoMcE6QBDxHw+JrRLBuBckFy+fRVa8sy2Kjp8H0i6KJfxyoRjYC3f2ygiiTW4EKM8vOMZsCFso2uY5LkhkL7qWwsbTTL8jBGk7oAFshs5GaPXjd/74NVxDwICHvW8KwkL68ML4YDLnI8pQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GUJT3j2FMjT5qfuC0FWvTkvorU3dXLEOfdAaTaryWII=;
 b=I0FUUrfre3XIfTUlwx/GSVklkjDJKNIu68cgVgUY4aXwL3mVPpg6MKK7JX2rYJfu3HaDywW0T6cTzWwWrPMVJPzNncXmQwKRIMNvHUrKCsKHc8ghtakWBADJEk8t6EjgtDJwOPx2yOCP2C0zpsewZXra6i+6Phn15oirSZg3+OA=
Received: from CY4PR04MB3751.namprd04.prod.outlook.com (2603:10b6:903:ec::14)
 by CY4PR04MB1206.namprd04.prod.outlook.com (2603:10b6:903:b8::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.26; Thu, 2 Jul
 2020 08:49:38 +0000
Received: from CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::c593:f271:eebe:ac7]) by CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::c593:f271:eebe:ac7%9]) with mapi id 15.20.3153.022; Thu, 2 Jul 2020
 08:49:38 +0000
From: Damien Le Moal <Damien.LeMoal@wdc.com>
To: =?iso-8859-1?Q?Javier_Gonz=E1lez?= <javier@javigon.com>
Subject: Re: [PATCH 1/4] block: Add zone flags to queue zone prop.
Thread-Topic: [PATCH 1/4] block: Add zone flags to queue zone prop.
Thread-Index: AQHWUD25/vKGWWSejEep48tajSAGnw==
Date: Thu, 2 Jul 2020 08:49:38 +0000
Message-ID: <CY4PR04MB375100663B25D1E1D8490758E76D0@CY4PR04MB3751.namprd04.prod.outlook.com>
References: <20200702065438.46350-1-javier@javigon.com>
 <20200702065438.46350-2-javier@javigon.com>
 <CY4PR04MB37511008EEBF1A77DB4F423BE76D0@CY4PR04MB3751.namprd04.prod.outlook.com>
 <20200702083430.miax2cd44mkhc5fb@mpHalley.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: javigon.com; dkim=none (message not signed)
 header.d=none;javigon.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.182.57]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a73b4a6d-f841-49f7-be37-08d81e64da52
x-ms-traffictypediagnostic: CY4PR04MB1206:
x-microsoft-antispam-prvs: <CY4PR04MB1206CBCC47A626ABAD980C79E76D0@CY4PR04MB1206.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0452022BE1
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WOCbLZPwsVJEM8zmoZyirbn1MLT47pcax7C6cZE9ZST5JMPIEM2JZz41b8dL6rMskGRfHWbwMeJdJZ1c5VbDbemW0dLGSy16MCP0Fitr0DFUjMFPKo6K7hOK2uMlzy2ElaKLC/8Qg81N177M+PLnVYU3rwPvGr/otyFjtU8np9xHiwLX0QBSef3o64FDTtI7gayVjKSoHFfUeaAFziSJi7z1VrJ3+mk5Yz8V640zXGiv9nD7iOsvEEnahV9ogMNGAHmDTK6RdxwEHvi303X7n2KCogc7MgZ/+SxRuA1yGnLnuxIWSrJqUWEoulpBdzoKyNUHcgJ4zU617zEK6EAWcw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR04MB3751.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(136003)(39860400002)(366004)(376002)(346002)(66574015)(33656002)(316002)(54906003)(2906002)(7696005)(186003)(83380400001)(4326008)(26005)(6506007)(53546011)(7416002)(6916009)(66946007)(66476007)(64756008)(76116006)(52536014)(66446008)(66556008)(91956017)(71200400001)(55016002)(9686003)(8936002)(5660300002)(86362001)(478600001)(8676002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: sXpQuYeufFvxFpVCGKSuY/Sf3aAVEns/iHWzaNSmzxaeNqjpMvTh0bMI1fyUooAwB2iLAW9+rh26nFu6bIb4BjksmyT2+6GeN5Pds460sV/lGIH9zaYSoBP9Plf+1S9yrmqk8NY8LLNcmWP30G0PuQp3j8D4S7uP2JRiFokSyaZrv56le9Xp3Cmj13T5lorZnBc2q3pso2pu5h3hj+I0qSbj2AktObKhkQJo7h5AvkS1jE6Za0l44Ispz0ss+TVkgoxr9IpeVypDY3DQg5Oqf2alFhj8VdLgVa58xqecUBr/4lT6PblQwYWPVJAZUxalJN4PtDh3Wklfj813opaG8eePBlt3dTPfv5p8ByiTAqovkbV1WDER02mqClb1E2S5KuvBKFmBv+94cIytxRQvJLNyKAbitzNQEKJXKGDjLPoT5HRdeH07aFkoLPMKGM97hpd5a3WuUREsCU/C4E2Wn9R9yRYjyPvsqyP0pAtXb9pgen2xuKzqD9nSh0tcNhEO
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR04MB3751.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a73b4a6d-f841-49f7-be37-08d81e64da52
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jul 2020 08:49:38.0364 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YAYTb/vzaxjk6laS18pDJnalcaLcBg5FrjcrrD194O+pAqIqoDjOKrUu+pej0c5DlyXKmFHXiZiigb3WM4lqXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR04MB1206
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200702_044944_274269_58022996 
X-CRM114-Status: GOOD (  25.85  )
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

On 2020/07/02 17:34, Javier Gonz=E1lez wrote:
> On 02.07.2020 07:54, Damien Le Moal wrote:
>> On 2020/07/02 15:55, Javier Gonz=E1lez wrote:
>>> From: Javier Gonz=E1lez <javier.gonz@samsung.com>
>>>
>>> As the zoned block device will have to deal with features that are
>>> optional for the backend device, add a flag field to inform the block
>>> layer about supported features. This builds on top of
>>> blk_zone_report_flags and extendes to the zone report code.
>>>
>>> Signed-off-by: Javier Gonz=E1lez <javier.gonz@samsung.com>
>>> Signed-off-by: SelvaKumar S <selvakuma.s1@samsung.com>
>>> Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>
>>> Signed-off-by: Nitesh Shetty <nj.shetty@samsung.com>
>>> ---
>>>  block/blk-zoned.c              | 3 ++-
>>>  drivers/block/null_blk_zoned.c | 2 ++
>>>  drivers/nvme/host/zns.c        | 1 +
>>>  drivers/scsi/sd.c              | 2 ++
>>>  include/linux/blkdev.h         | 3 +++
>>>  5 files changed, 10 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/block/blk-zoned.c b/block/blk-zoned.c
>>> index 81152a260354..0f156e96e48f 100644
>>> --- a/block/blk-zoned.c
>>> +++ b/block/blk-zoned.c
>>> @@ -312,7 +312,8 @@ int blkdev_report_zones_ioctl(struct block_device *=
bdev, fmode_t mode,
>>>  		return ret;
>>>
>>>  	rep.nr_zones =3D ret;
>>> -	rep.flags =3D BLK_ZONE_REP_CAPACITY;
>>> +	rep.flags =3D q->zone_flags;
>>
>> zone_flags seem to be a fairly generic flags field while rep.flags is on=
ly about
>> the reported descriptors structure. So you may want to define a
>> BLK_ZONE_REP_FLAGS_MASK and have:
>>
>> 	rep.flags =3D q->zone_flags & BLK_ZONE_REP_FLAGS_MASK;
>>
>> to avoid flags meaningless for the user being set.
>>
>> In any case, since *all* zoned block devices now report capacity, I do n=
ot
>> really see the point to add BLK_ZONE_REP_FLAGS_MASK to q->zone_flags, es=
pecially
>> considering that you set the flag for all zoned device types, including =
scsi
>> which does not have zone capacity. This makes q->zone_flags rather confu=
sing
>> instead of clearly defining the device features as you mentioned in the =
commit
>> message.
>>
>> I think it may be better to just drop this patch, and if needed, introdu=
ce the
>> zone_flags field where it may be needed (e.g. OFFLINE zone ioctl support=
).
> =

> I am using this as a way to pass the OFFLINE support flag to the block
> layer. I used this too for the attributes. Are you thinking of a
> different way to send this?
> =

> I believe this fits too for capacity, but we can just pass it in
> all report as before if you prefer.

The point is that this patch as is does nothing and is needed as a preparat=
ory
patch if we want to have the offline flag set in the report. But:
1) As commented in the offline ioctl patch, I am not sure the flag makes a =
lot
of sense. sysfs or nothing at all may be OK as well. When we introduced the=
 new
open/close/finish ioctls, we did not add flags to signal that the device
supports them. Granted, it was for nullblk and scsi, and both had the suppo=
rt.
But running an application using these on an old kernel, and you will get
-ENOTTY, meaning, not supported. So simply introducing the offline ioctl wi=
thout
any flag would be OK I think.

Since DM support for this would be nice too and we now are in a situation w=
here
not all devices support the  ioctl, instead of a report flag (a little out =
of
place), a queue limit exported through sysfs may be a cleaner way to both
support DM correctly (stacked limits) and signal the support to the user. I=
f you
choose this approach, then this patch is not needed. The zoned_flags, or a
regular queue flag like for RESET_ALL can be added in the offline ioctl pat=
ch.

> =

>>
>>> +
>>>  	if (copy_to_user(argp, &rep, sizeof(struct blk_zone_report)))
>>>  		return -EFAULT;
>>>  	return 0;
>>> diff --git a/drivers/block/null_blk_zoned.c b/drivers/block/null_blk_zo=
ned.c
>>> index b05832eb21b2..957c2103f240 100644
>>> --- a/drivers/block/null_blk_zoned.c
>>> +++ b/drivers/block/null_blk_zoned.c
>>> @@ -78,6 +78,8 @@ int null_init_zoned_dev(struct nullb_device *dev, str=
uct request_queue *q)
>>>  	}
>>>
>>>  	q->limits.zoned =3D BLK_ZONED_HM;
>>> +	q->zone_flags =3D BLK_ZONE_REP_CAPACITY;
>>> +
>>>  	blk_queue_flag_set(QUEUE_FLAG_ZONE_RESETALL, q);
>>>  	blk_queue_required_elevator_features(q, ELEVATOR_F_ZBD_SEQ_WRITE);
>>>
>>> diff --git a/drivers/nvme/host/zns.c b/drivers/nvme/host/zns.c
>>> index 0642d3c54e8f..888264261ba3 100644
>>> --- a/drivers/nvme/host/zns.c
>>> +++ b/drivers/nvme/host/zns.c
>>> @@ -81,6 +81,7 @@ int nvme_update_zone_info(struct gendisk *disk, struc=
t nvme_ns *ns,
>>>  	}
>>>
>>>  	q->limits.zoned =3D BLK_ZONED_HM;
>>> +	q->zone_flags =3D BLK_ZONE_REP_CAPACITY;
>>>  	blk_queue_flag_set(QUEUE_FLAG_ZONE_RESETALL, q);
>>>  free_data:
>>>  	kfree(id);
>>> diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
>>> index d90fefffe31b..b9c920bace28 100644
>>> --- a/drivers/scsi/sd.c
>>> +++ b/drivers/scsi/sd.c
>>> @@ -2967,6 +2967,7 @@ static void sd_read_block_characteristics(struct =
scsi_disk *sdkp)
>>>  	if (sdkp->device->type =3D=3D TYPE_ZBC) {
>>>  		/* Host-managed */
>>>  		q->limits.zoned =3D BLK_ZONED_HM;
>>> +		q->zone_flags =3D BLK_ZONE_REP_CAPACITY;
>>>  	} else {
>>>  		sdkp->zoned =3D (buffer[8] >> 4) & 3;
>>>  		if (sdkp->zoned =3D=3D 1 && !disk_has_partitions(sdkp->disk)) {
>>> @@ -2983,6 +2984,7 @@ static void sd_read_block_characteristics(struct =
scsi_disk *sdkp)
>>>  					  "Drive-managed SMR disk\n");
>>>  		}
>>>  	}
>>> +
>>>  	if (blk_queue_is_zoned(q) && sdkp->first_scan)
>>>  		sd_printk(KERN_NOTICE, sdkp, "Host-%s zoned block device\n",
>>>  		      q->limits.zoned =3D=3D BLK_ZONED_HM ? "managed" : "aware");
>>> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
>>> index 8fd900998b4e..3f2e3425fa53 100644
>>> --- a/include/linux/blkdev.h
>>> +++ b/include/linux/blkdev.h
>>> @@ -512,12 +512,15 @@ struct request_queue {
>>>  	 * Stacking drivers (device mappers) may or may not initialize
>>>  	 * these fields.
>>>  	 *
>>> +	 * Flags represent features as described by blk_zone_report_flags in =
blkzoned.h
>>> +	 *
>>>  	 * Reads of this information must be protected with blk_queue_enter()=
 /
>>>  	 * blk_queue_exit(). Modifying this information is only allowed while
>>>  	 * no requests are being processed. See also blk_mq_freeze_queue() and
>>>  	 * blk_mq_unfreeze_queue().
>>>  	 */
>>>  	unsigned int		nr_zones;
>>> +	unsigned int		zone_flags;
>>>  	unsigned long		*conv_zones_bitmap;
>>>  	unsigned long		*seq_zones_wlock;
>>>  #endif /* CONFIG_BLK_DEV_ZONED */
>>>
>>
>> And you are missing device-mapper support. DM target devices have a requ=
est
>> queue that would need to set the zone_flags too.
> =

> Ok. I looked at it and I thought that this would be inherited by the
> underlying device. I will add it in V3.
> =

> Javier
> =

> =



-- =

Damien Le Moal
Western Digital Research

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
