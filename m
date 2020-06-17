Return-Path: <SRS0=Y48z=76=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E151C433E0
	for <linux-nvme@archiver.kernel.org>; Wed, 17 Jun 2020 00:14:56 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF9212082F
	for <linux-nvme@archiver.kernel.org>; Wed, 17 Jun 2020 00:14:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="P2iXuS26";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="GmtYe+3+";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="Ymrk2r62"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF9212082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date
	:Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=caXi5STkgfCCiwEo+hDwhpzpSnk8a92UwZt051vlpb4=; b=P2iXuS26dDIn33
	TH7Dr6UAT6exI1t0tMqxYAfvCXSGbc5lWCqpmN+RIq4imad0JQmekkEFMwwZH6vcNMv6em2hb4ZkW
	ebM5Lhss1a7GosGG/V/UK24EYHFCxzahV+kkMnuxj2qOMhJl/aPsfq3YsanvBVaiTTg1GicXcuBr1
	kOF48vOKNb94t6/WLaj8L2mGUvy6m5Sdgftmw8t0QOHZU5MnMOJkx/BHAzLkHOpXDGiJWXW2uYWu+
	twphB69wmz8Wb0qDjF9fz2OC35DJ7EcMTffL/IV0hH0171nXQT9oWI8aIY0jdAtjmYXfS7APFkxsN
	rhSXp5+ounP3fQOX9yIg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jlLj8-0007Tw-W1; Wed, 17 Jun 2020 00:14:50 +0000
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jlLj5-0007T2-Er
 for linux-nvme@lists.infradead.org; Wed, 17 Jun 2020 00:14:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1592352892; x=1623888892;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=xEDOOS/SbyyLeKHaA0sBBG3ojEABobXNDrxtTbN/2eU=;
 b=GmtYe+3+mO+LdMi5Buf5C5w16LiEUyDMzZVq42hDDRL3NX5lOKvTDKZF
 RltLjsp8HPnJyXxHj62dqmsbKY3O/7iS9bt3PXIqS71clv/50LscxaC+T
 sH2FPIcAR6nETqnhFx9QncONqIryl3sedkbQ+6eg65ZMWHIwx1WHXxHtT
 01PFjYhHQH9Px4e+bmZGWDx7f8e5EMnO0bYzf3YZG0dXW+wGreKvgHs1B
 cUDSwtDrPdeYJgiOjC1sdzhjNEZEQc8MdJ/uzzzq645EUuvXJaj71KYMa
 cH2mSlqyKsbqNJyCWY6eY2NFgQht6Q4nTTvtt28ReEuSWw1h036MMUzBj w==;
IronPort-SDR: LccTIkO5vGHTCtqjdr80PzB22w92/ENIzUqroPgqXL/l7NsJgbAXaVeRp15kWglwVtHkJJ4WIO
 W4w32vxaVjqD735EJkqs82+5iB7iGd9QsBoMaoYb/k9EJVHWL21u/qAVgK2YPKrhMulPdxDIgl
 0WDgDRemCrQUzt2cEA5jFe7ONwYo+mJQfrXpWLKYuTcVVh8R9PuGBUHkoSbsuKMjk7Hr0rGGZ2
 4F+dSAVcMzQ0G/AeX87brnsujamV43cuwZGna4kwf2kgj4uGwmDA+2uXIplmNTonBInk+vY8SD
 /T8=
X-IronPort-AV: E=Sophos;i="5.73,520,1583164800"; d="scan'208";a="243125272"
Received: from mail-dm6nam12lp2169.outbound.protection.outlook.com (HELO
 NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.169])
 by ob1.hgst.iphmx.com with ESMTP; 17 Jun 2020 08:15:42 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=atG9/Ztlcf8pdnQPHuUjeXff+RelSCOHW8cx/vLQx+Lt5jGnw85zmpQTXaEol568Eq7g2NFnfw7lhGJPGNaUoTeXBHm1ZSwiNucMiBZJON9zP7/vG4QB98UFMwEKlO/hDp7D9SVLRFT8DDmjsqahI4I4+e6uLzv0ZFR8kTEAY/4LwYD0Mm9YedNVpObyTOqdF2qMI7saQ9kL/8xgrydlAE0KD93gdhGj+I/Kmc3vlthtDtfWmGeTdfAn5efxICNyo919nH2ziNd3+9NDN53ZS/ZEiFFlfgPDHmEtVVg6fT1T3C7jnEeOXF5ZKgNpYX9TAaY1wjOBLl4Mt7F4mGTFGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xEDOOS/SbyyLeKHaA0sBBG3ojEABobXNDrxtTbN/2eU=;
 b=U9m1zia3iDEG+QCHoh5tQyuQEUq65vEZAZFI06sDoMz/hX7It2G0MulnDWHdIaL1msfq+/NeWdruQWbYuUNFoCzOawjsbPvngrBPW2xN9RKMe7BdE7KLn/EaYi7/6v1kJmo+u/SRAQw8Pzlk20UpDb+8BOPtz5gcztVmLS79VO4Ygb2ketZvmUiojkRmJ8MrxI209/OXon2BPzktG72WPUuXT1kWLd2Nv5q95m3FO6593wofBw10bmpMC8/dJjbSn1fAzM+i8LTyRUFsu9J1UF398gUR7J3KP+3VRvuNe/zvjsgFinvCpu/T0e1wdoOm15xY3PlLB3VrBAHYh5GXTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xEDOOS/SbyyLeKHaA0sBBG3ojEABobXNDrxtTbN/2eU=;
 b=Ymrk2r62Smod28M1Svwp/R7oVqBXZR+DP+qWQv4qjjJlAcoR0vyyXWgCGXiTZ4ZR7g4nZ+NIJlwMig4LWO/qusc+Xb7nqhchqbI6GEqZH17BgLQ4hof3Dy0rnICRUeRNDq/aYDmyd8LHlHfCxYL2ox3tnWpJxIt+eFSPZDp6Nz4=
Received: from CY4PR04MB3751.namprd04.prod.outlook.com (2603:10b6:903:ec::14)
 by CY4PR04MB1032.namprd04.prod.outlook.com (2603:10b6:910:50::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.26; Wed, 17 Jun
 2020 00:14:35 +0000
Received: from CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::c593:f271:eebe:ac7]) by CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::c593:f271:eebe:ac7%9]) with mapi id 15.20.3088.028; Wed, 17 Jun 2020
 00:14:35 +0000
From: Damien Le Moal <Damien.LeMoal@wdc.com>
To: =?iso-8859-1?Q?Javier_Gonz=E1lez?= <javier@javigon.com>
Subject: Re: [PATCH 5/5] nvme: support for zoned namespaces
Thread-Topic: [PATCH 5/5] nvme: support for zoned namespaces
Thread-Index: AQHWQ22ncHPAnMo9ZkarXHo4UNlnAg==
Date: Wed, 17 Jun 2020 00:14:35 +0000
Message-ID: <CY4PR04MB37513B2D2B7AAE343ABF14C1E79A0@CY4PR04MB3751.namprd04.prod.outlook.com>
References: <20200615233424.13458-1-keith.busch@wdc.com>
 <20200615233424.13458-6-keith.busch@wdc.com>
 <20200616104142.zxw25txhsg2eyhsb@mpHalley.local>
 <d433450a-6e18-217c-d133-ea367d8936be@lightnvm.io>
 <20200616120018.en337lcs5y2jh5ne@mpHalley.local>
 <cf899cd9-c3de-7436-84d4-744c0988a6c9@lightnvm.io>
 <20200616122448.4e3slfghv4cojafq@mpHalley.local>
 <CY4PR04MB3751CC8FE4BDFC256F9E9CD1E79D0@CY4PR04MB3751.namprd04.prod.outlook.com>
 <20200616141620.omqf64up523of35t@MacBook-Pro.localdomain>
 <CY4PR04MB37512BCDD74996057697F5CAE79D0@CY4PR04MB3751.namprd04.prod.outlook.com>
 <20200616150217.inezhntsehtcbjsw@MacBook-Pro.localdomain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: javigon.com; dkim=none (message not signed)
 header.d=none;javigon.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [60.117.181.124]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: e3a17d33-c7c2-4993-21aa-08d812536af5
x-ms-traffictypediagnostic: CY4PR04MB1032:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR04MB1032F0149503157417311896E79A0@CY4PR04MB1032.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 04371797A5
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rSp+p5rFzuK4KzSUMi61T2b+5Z3UgThsYTFJBdbjw0kX/PQg91m2XykGZpkoyOMsAYSKY0QKnPAwdXKUFf9sYsLeForcV12u8Ji4kN/j81lBYX607x6icLsT4Skz5JVl7XyPxjdgv8tVC9Z5ZSYA+jrET5X7yOXld/0mokT6I8yfCoX9j8TNaogiEISACb5wf7fhmhIFzF87/wqAIDhaAs1p6TamIxjYV3Cu+CZwVKXHIIpZGL9MjYh76lTGSEK94fki7ccexk3Faz/++B4Olc+EPD0t/dWBppblnTJPp/QN2gzh7FN1yEc2d0HppXRHWH+kvbAUMZBVKcGFYMHzbkKAFBxZozMtYREjVL2zXF1M1SYrPEHuYcHtGIznwohTFhXiDUzTrYb4ue5+Kkvtyg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR04MB3751.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(39850400004)(396003)(376002)(136003)(346002)(966005)(6916009)(55016002)(66446008)(64756008)(91956017)(76116006)(66556008)(66476007)(26005)(66946007)(8676002)(54906003)(83380400001)(9686003)(8936002)(33656002)(478600001)(6506007)(52536014)(53546011)(71200400001)(2906002)(66574015)(5660300002)(4326008)(186003)(316002)(7696005)(86362001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: qA9Rl/qM+rmS3CzQuzLO/R4HWdrGU7Uoka2CY8jdJ/w2b+N4b7DpqyeAE897T/gsC7FUtxPJ/184SfOrn+gOADICUofayhrse/YGq8/6BioNTIP2yp+hSydCMqPSe+9uD2OaOsfygH8laxVTuqWx2Og5EAyfEh6gxLNHUCA3HHpkvjGIOLh+8+ocJiuXoJCe6lWZUSuG+Sh6DdFORxBV62JovswIB1px/Gih/bHrCpRvAni0QyZTHRi7C/pZbFXy5fEbLz4Y6+uU7aTWuLGiNPUjNhlcQ64FBR7iYqG+z85yOAUsATlEIW4hZT0f6ndL8qgBhiIpdvwj813YEHDkLlV6W8a7mjRkNs3uszwh9np7klHK/mH6rncbc9ZsKwIF9Rv7vBQH1WciguUyY2VtMslKwxCSDz7bdFdyNwMm+c0ph7fdzNDYkYVotg58QYbzhYxkaxoNGTB4fsMweOjixlr7jJrOAQqAIJtvnEpGcQ3EbK3sbCl3qJ2bLPDpau4K
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3a17d33-c7c2-4993-21aa-08d812536af5
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jun 2020 00:14:35.7321 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OBuLmNDf9KTnyrSiRttAHjJzAPFjUhsIqqY56LOr30Afxy+BUPSFsPsW3OJqZ5EpjJnFYQyzngl0DleD2TwcVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR04MB1032
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200616_171447_593375_0163126A 
X-CRM114-Status: GOOD (  22.10  )
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
Cc: Jens Axboe <axboe@kernel.dk>, Niklas Cassel <Niklas.Cassel@wdc.com>,
 Ajay Joshi <Ajay.Joshi@wdc.com>, Sagi Grimberg <sagi@grimberg.me>,
 Keith Busch <Keith.Busch@wdc.com>, Dmitry Fomichev <Dmitry.Fomichev@wdc.com>,
 Aravind Ramesh <Aravind.Ramesh@wdc.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 Hans Holmberg <Hans.Holmberg@wdc.com>,
 =?iso-8859-1?Q?Matias_Bj=F8rling?= <mb@lightnvm.io>,
 Christoph Hellwig <hch@lst.de>, Matias Bjorling <Matias.Bjorling@wdc.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 2020/06/17 0:02, Javier Gonz=E1lez wrote:
> On 16.06.2020 14:42, Damien Le Moal wrote:
>> On 2020/06/16 23:16, Javier Gonz=E1lez wrote:
>>> On 16.06.2020 12:35, Damien Le Moal wrote:
>>>> On 2020/06/16 21:24, Javier Gonz=E1lez wrote:
>>>>> On 16.06.2020 14:06, Matias Bj=F8rling wrote:
>>>>>> On 16/06/2020 14.00, Javier Gonz=E1lez wrote:
>>>>>>> On 16.06.2020 13:18, Matias Bj=F8rling wrote:
>>>>>>>> On 16/06/2020 12.41, Javier Gonz=E1lez wrote:
>>>>>>>>> On 16.06.2020 08:34, Keith Busch wrote:
>>>>>>>>>> Add support for NVM Express Zoned Namespaces (ZNS) Command Set d=
efined
>>>>>>>>>> in NVM Express TP4053. Zoned namespaces are discovered based on =
their
>>>>>>>>>> Command Set Identifier reported in the namespaces Namespace
>>>>>>>>>> Identification Descriptor list. A successfully discovered Zoned
>>>>>>>>>> Namespace will be registered with the block layer as a host mana=
ged
>>>>>>>>>> zoned block device with Zone Append command support. A namespace=
 that
>>>>>>>>>> does not support append is not supported by the driver.
>>>>>>>>>
>>>>>>>>> Why are we enforcing the append command? Append is optional on the
>>>>>>>>> current ZNS specification, so we should not make this mandatory i=
n the
>>>>>>>>> implementation. See specifics below.
>>>>>>>
>>>>>>>>
>>>>>>>> There is already general support in the kernel for the zone append
>>>>>>>> command. Feel free to submit patches to emulate the support. It is
>>>>>>>> outside the scope of this patchset.
>>>>>>>>
>>>>>>>
>>>>>>> It is fine that the kernel supports append, but the ZNS specificati=
on
>>>>>>> does not impose the implementation for append, so the driver should=
 not
>>>>>>> do that either.
>>>>>>>
>>>>>>> ZNS SSDs that choose to leave append as a non-implemented optional
>>>>>>> command should not rely on emulated SW support, specially when
>>>>>>> traditional writes work very fine for a large part of current ZNS u=
se
>>>>>>> cases.
>>>>>>>
>>>>>>> Please, remove this virtual constraint.
>>>>>>
>>>>>> The Zone Append command is mandatory for zoned block devices. Please
>>>>>> see https://lwn.net/Articles/818709/ for the background.
>>>>>
>>>>> I do not see anywhere in the block layer that append is mandatory for
>>>>> zoned devices. Append is emulated on ZBC, but beyond that there is no
>>>>> mandatory bits. Please explain.
>>>>
>>>> This is to allow a single write IO path for all types of zoned block d=
evice for
>>>> higher layers, e.g file systems. The on-going re-work of btrfs zone su=
pport for
>>>> instance now relies 100% on zone append being supported. That signific=
antly
>>>> simplifies the file system support and more importantly remove the nee=
d for
>>>> locking around block allocation and BIO issuing, allowing to preserve =
a fully
>>>> asynchronous write path that can include workqueues for efficient CPU =
usage of
>>>> things like encryption and compression. Without zone append, file syst=
em would
>>>> either (1) have to reject these drives that do not support zone append=
, or (2)
>>>> implement 2 different write IO path (slower regular write and zone app=
end). None
>>>> of these options are ideal, to say the least.
>>>>
>>>> So the approach is: mandate zone append support for ZNS devices. To al=
low other
>>>> ZNS drives, an emulation similar to SCSI can be implemented, with that=
 emulation
>>>> ideally combined to work for both types of drives if possible.
>>>
>>> Enforcing QD=3D1 becomes a problem on devices with large zones. In
>>> a ZNS device that has smaller zones this should not be a problem.
>>
>> Let's be precise: this is not running the drive at QD=3D1, it is "at mos=
t one
>> write *request* per zone". If the FS is simultaneously using multiple bl=
ock
>> groups mapped to different zones, you will get a total write QD > 1, and=
 as many
>> reads as you want.
>>
>>> Would you agree that it is possible to have a write path that relies on
>>> QD=3D1, where the FS / application has the responsibility for enforcing
>>> this? Down the road this QD can be increased if the device is able to
>>> buffer the writes.
>>
>> Doing QD=3D1 per zone for writes at the FS layer, that is, at the BIO la=
yer does
>> not work. This is because BIOs can be as large as the FS wants them to b=
e. Such
>> large BIO will be split into multiple requests in the block layer, resul=
ting in
>> more than one write per zone. That is why the zone write locking is at t=
he
>> scheduler level, between BIO split and request dispatch. That avoids the
>> multiple requests fragments of a large BIO to be reordered and fail. Tha=
t is
>> mandatory as the block layer itself can occasionally reorder requests an=
d lower
>> levels such as AHCI HW is also notoriously good at reversing sequential
>> requests. For NVMe with multi-queue, the IO issuing process getting resc=
heduled
>> on a different CPU can result in sequential IOs being in different queue=
s, with
>> the likely result of an out-of-order execution. All cases are avoided wi=
th zone
>> write locking and at most one write request dispatch per zone as recomme=
nded by
>> the ZNS specifications (ZBC and ZAC standards for SMR HDDs are silent on=
 this).
>>
> =

> I understand. I agree that the current FSs supporting ZNS follow this
> approach and it makes sense that there is a common interface that
> simplifies the FS implementation. See the comment below on the part I
> believe we see things differently.
> =

> =

>>> I would be OK with some FS implementations to rely on append and impose
>>> the constraint that append has to be supported (and it would be our job
>>> to change that), but I would like to avoid the driver rejecting
>>> initializing the device because current FS implementations have
>>> implemented this logic.
>>
>> What is the difference between the driver rejecting drives and the FS re=
jecting
>> the same drives ? That has the same end result to me: an entire class of=
 devices
>> cannot be used as desired by the user. Implementing zone append emulatio=
n avoids
>> the rejection entirely while still allowing the FS to have a single writ=
e IO
>> path, thus simplifying the code.
> =

> The difference is that users that use a raw ZNS device submitting I/O
> through the kernel would still be able to use these devices. The result
> would be that the ZNS SSD is recognized and initialized, but the FS
> format fails.

I understand your point of view. Raw ZNS block device access by an applicat=
ion
is of course a fine use case. SMR also has plenty of these.

My point is that enabling this regular write/raw device use case should not
prevent using btrfs or other kernel components that require zone append.
Implementing zone append emulation in the NVMe/ZNS driver for devices witho=
ut
native support for the command enables *all* use cases without impacting th=
e use
case you are interested in.

This approach is, in my opinion, far better. No one is left out and the user
gains a flexible system with different setup capabilities. The user wins he=
re.

> =

>>
>>> We can agree that a number of initial customers will use these devices
>>> raw, using the in-kernel I/O path, but without a FS on top.
>>>
>>> Thoughts?
>>>
>>>> and note that
>>>> this emulation would require the drive to be operated with mq-deadline=
 to enable
>>>> zone write locking for preserving write command order. While on a HDD =
the
>>>> performance penalty is minimal, it will likely be significant on a SSD.
>>>
>>> Exactly my concern. I do not want ZNS SSDs to be impacted by this type
>>> of design decision at the driver level.
>>
>> But your proposed FS level approach would end up doing the exact same th=
ing with
>> the same limitation and so the same potential performance impact. The bl=
ock
>> layer generic approach has the advantage that we do not bother the highe=
r levels
>> with the implementation of in-order request dispatch guarantees. File sy=
stems
>> are complex enough. The less complexity is required for zone support, th=
e better.
> =

> This depends very much on how the FS / application is managing
> stripping. At the moment our main use case is enabling user-space
> applications submitting I/Os to raw ZNS devices through the kernel.
> =

> Can we enable this use case to start with?

Yes, see above. Again, we should not have to choose one *or* the other. The=
 user
should be able to use both raw accesses *and* file systems that require zone
append. The initial patch set enables the latter. For the former, additional
patches are needed. And the work done in SCSI already simplifies that task.=
 The
block layer is already wired to handle zone append emulation.

> =

> Thanks,
> Javier
> =



-- =

Damien Le Moal
Western Digital Research

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
