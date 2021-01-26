Return-Path: <SRS0=0e7J=G5=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3AC1C433E0
	for <linux-nvme@archiver.kernel.org>; Tue, 26 Jan 2021 19:01:39 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D34922228
	for <linux-nvme@archiver.kernel.org>; Tue, 26 Jan 2021 19:01:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D34922228
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:To:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=MEPGyPTP8uNvvoPLCh0sVrWTjI8q8TXKZHYcymwfVQA=; b=1/Hk456yCKF4v8Jz+5pQIKTDk
	43HtzZdwyUMYvd5yzbJLIZhCVey6NgD7Qbs9EnPfFDJENgZoSpS6IPRNjbTvobEByS3xJsV8xdQ0A
	NxojBRLA4WdriqBmA0B99RrpiJ100V26wzIRMVTonOh+AQzSalLWVSV2/Ra0fZ1esFLxYyxNWgi5y
	TDrYPTFhwQihBWTkRvZ8ocMDrSUL+bG90bqpPmAlRQkybjBSJa99gCLbqcHpn7Ex4ZugLb7IUOgvP
	138j0w4lIWa1gZI4U5XzycctUt+iWnqPM+aJ4i/7DggU1xkDAYUfwJe6335AHL3kdCgpJ4EhtZL48
	qn42WY5Vw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l4TaO-0001dG-9u; Tue, 26 Jan 2021 19:01:08 +0000
Received: from esa1.hgst.iphmx.com ([68.232.141.245])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l4TaK-0001cv-12
 for linux-nvme@lists.infradead.org; Tue, 26 Jan 2021 19:01:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1611687663; x=1643223663;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=cM9Pov89UhKq/eNZfYZ1sWzdazn2yIBtgt7RYUQtlKo=;
 b=EYG6N1uEBhaGZ+nyGDAeWzNLI1fgesYNo/upwNY9StGffQXee2Qsw34g
 etnNaQZnliVtk+cU9fT+/ntQZKzc5O2oco3UxCRjEPMi+hExHInqc5/O8
 nkm7cmhyx/eD74MKDlECnUpnRVCYTPztVFk85wHfoZ8sylqGbGTQQWA/2
 3QFiKX1I2emXpsAXpJFPg/LAvKT7UuHHQ8J49QgneY/RVo5FsGbv1k1QU
 X+DsonhthdvO2VIEt+Seekn98dkQ/hCVprUHe28ULLC73VlhQqwcEwwvQ
 nPXWAuGxAI4iRzChMuUULs8dXmIWAcbweiyPh9f9ZqbngQd+T+GrDyejQ w==;
IronPort-SDR: bduAENlLkWeklNgpI3pw/BAnuSVeeBR4Phf/MLrezj2uZspd1QfhKYrcsK3lIokXCat2U4xvx4
 JkLexXBd5H1Wln6faEpFBu4ezQVEZKJBkUnnFeer1OHvkcsgwOAvjLdKzrT22lejNFyC4x55Qq
 b09C35lk666G/BGJ30K1oTDjVZ98zmo9WPOtHkMBZtdiaJRSftg9yvK4OVQQ0kaQUZAgHZWN9N
 fI+r1GbYHGGz/0q48k8A9MwjdySo7bdYVOcPS9rTU/+2BhpFgL1w0OaR5orVhjHNKIzWwPq2qA
 CGY=
X-IronPort-AV: E=Sophos;i="5.79,377,1602518400"; d="scan'208";a="268742452"
Received: from mail-dm6nam10lp2109.outbound.protection.outlook.com (HELO
 NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.109])
 by ob1.hgst.iphmx.com with ESMTP; 27 Jan 2021 03:01:00 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dDkfaduXFwF0E8zDa5/R/MxA67VVc3ioXb3ObFc0/KINOGJvxKe1rHP0SPDkyPul00jb9roILXAwHZA1eTKDS2gk+OU+eOa2hhm4FwGdmRe9LFP+BoZNJM/kHfbru2dGpQ+50WUY+CuP+oZvoTkdvIZls/5XOWYDKR1lQlDc+4ERC4HK/+S2ZKJiL5JaJRw/5KWnhpzuAu6y+g3j3rPc0xgVwROYg8LHTnEnSAzFgFOusyHfwI4hB6Pl9ilWrha2uiJHHWqMiR6rGQKMC8xtl0IIoqXugxTD7YYTYXQWt5FmDR9s+ayeEbSEeSLV65qkiFyB6X6VsPnny0IoTK5s+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=97gOUmdp+pvspcxSomrz9XmMGjYKg2TVuxOxmsTEEkA=;
 b=L6hBNw0sSTAT+vQVG66PpviVj6xBhUUNhDoS1IqRIA1rGWnZCjrhafm2BaT8v7ewwtVIPxy2pQc2dvw8edWyjbMbQ6K204vBhC4/IUnzlDYgJ6OBV4054ewCYd9bPEmwuwaIIIvJrqPZHiQS5boi2ngutntV12mHepggbhMQDT9oeNonuo7VwcPU38PDoBAZZAoRj2rMo6NoJM8DGDNfYGMDKoT/LR6vvm7r9mWu/B2f++3qkoAWasyouPGF1RCcjzigDD1379K4LqYVmWkV1F7yKq8k3vzxPhlE4GbQZ5UN9I+hEla18/gwtiN7Jc4bAQN3HhxDVaJNw+7xJnCQVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=97gOUmdp+pvspcxSomrz9XmMGjYKg2TVuxOxmsTEEkA=;
 b=OIigYLgahjnjIGnjqt1k6muWDuk7igyOda66SR+VZHsXBidodDlfi35AjvMrS0zWgFs1HptUbmt83QRP8tmwUOBI6awViSu3e9oEReVNQ3Mxq34lyk2CstsIjJWdVIW6M0PBzKJ6V8U1quMNMuBFEQ+JNajOvtod5tmq5XDUKFQ=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB6023.namprd04.prod.outlook.com (2603:10b6:a03:e9::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.14; Tue, 26 Jan
 2021 19:00:59 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::1d83:38d9:143:4c9c]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::1d83:38d9:143:4c9c%5]) with mapi id 15.20.3784.016; Tue, 26 Jan 2021
 19:00:59 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Clay Mayers <Clay.Mayers@kioxia.com>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH V2 0/2] nvme: Support for fused NVME_IOCTL_SUBMIT_IO
Thread-Topic: [PATCH V2 0/2] nvme: Support for fused NVME_IOCTL_SUBMIT_IO
Thread-Index: AQHW81Uk6e6cbZGyEU2+tznAk87Vfw==
Date: Tue, 26 Jan 2021 19:00:59 +0000
Message-ID: <BYAPR04MB49652EA8F4CF06D41C708E2386BC9@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20210105224939.1336-2-clay.mayers@kioxia.com>
 <20210125195844.1390581-1-clay.mayers@kioxia.com>
 <BYAPR04MB49650B6342C736B5268F833686BC9@BYAPR04MB4965.namprd04.prod.outlook.com>
 <b5c179e3eb904800931712d6b92cfbeb@kioxia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kioxia.com; dkim=none (message not signed)
 header.d=none;kioxia.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2600:8802:270c:4b00:b091:5edc:1473:bf45]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d1a612f1-4aa8-447f-f4a0-08d8c22cb844
x-ms-traffictypediagnostic: BYAPR04MB6023:
x-microsoft-antispam-prvs: <BYAPR04MB6023863CE1C6125FE48728A586BC9@BYAPR04MB6023.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bOr/JKMI1Nh05pYYhWJ+D02bd2jqzip9PYdgHFdDN7DBG04uSXpq9SQgAwu46P8Ke6ckS6pFxldeXvB24DJMqrlqAI+Z/Io4r+KUD4uQvax1Mibe+1S7R8ZoIvoBerquFKQolNyFJ1SwERrQKlYs5YQ6WHX0DTRkyZi1zaGBW+fCZKUIjcqSQg+nYhnOlkC/+Lk5G6lVeXsJg5xMnMrCAcdLgHKQ/h+/HS1620k1i2PEGHAVaamFYv4udngEa05lg1YVhFiX+e0nTeUoH5ZW3d91IbsP2+nw9yBL/vV4mwYpEx7MlTk0TqV85R92Ljh65IvQ0NgrNVo+AallSTjaSWFEnW+75NZSZ4dOi+nDZwtRUgPJId6XrFx3VaUQnL8vLWGa6hkiS1F1jEI42f1+Aw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(396003)(346002)(376002)(366004)(39860400002)(5660300002)(110136005)(66946007)(66446008)(2906002)(33656002)(8676002)(54906003)(7696005)(52536014)(83380400001)(86362001)(55016002)(71200400001)(8936002)(64756008)(9686003)(66556008)(4326008)(316002)(186003)(53546011)(66476007)(478600001)(76116006)(6506007);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?BCxb3ndpex+A/2qTP0cy3eVWNXwCNkllznTXtd0z5VR/Am3e9mF5pG2D29ks?=
 =?us-ascii?Q?YIVK5wdcIyjjj11VGpgt8xMdx0h16FXawBNVB8AU/E7kbAeS7hwaI1/UZ0Lz?=
 =?us-ascii?Q?YGqGHhbNa7Jax5S1hwmf1TX8Dtb3YiNtyVNdk8M6HY0D4BYRFoAM2sQHJOfy?=
 =?us-ascii?Q?O1chIs1+tJVaM1BViPD7OpRNEzVYa0v31ncqSV9OosoRdIhTxa6ZFmrxzGkX?=
 =?us-ascii?Q?glTw/wISxtWxAxuIELOMcw6JKPTu3+m25IhXvlUVE9XVg9eLpI70jr5A8PNd?=
 =?us-ascii?Q?wDwr7IWcuGEayVd+gnm20uHHsgoXJNH79qlCDsOQmw2QUWTlTc34v7uLHd/8?=
 =?us-ascii?Q?oKntOpgpCGPQpGoG8jtmTn7fGg+pzrSNRa7wskHKMgsog0IJnlKxGQr3zIzQ?=
 =?us-ascii?Q?2qsHmJju228zEmEwQqXxbu+L5eaz52PLuMBeRxRHrG2TGME1iIv1eHw2mV8e?=
 =?us-ascii?Q?Ml+/3lnyUeb3AfmJdKRHrdaegEDb2KmDMfHlzNv4BPtk4FCnWPzzlxEx+alT?=
 =?us-ascii?Q?Hev3wAh0NKAJIkaNA+QjszLWW7LYWq3UXqBvYfJ8BLDPxUR+WeB7u0lrVcZm?=
 =?us-ascii?Q?GduTYRqcKj695pZuGICqfkX3tQl4FGJZSh8JPZ5lXhRLvicc9U2VRROubp1d?=
 =?us-ascii?Q?gvYCwR324IU3qe5/gtSm9+brLL0t242GBdSLhtIQCiIy9Bh/E/T0mCevspOI?=
 =?us-ascii?Q?CtKqAqlv89dmdXHzf91C4nBEuol/IpIorI2PGJVaRL2AamdGH/ExVyDwayWR?=
 =?us-ascii?Q?4C1AhNwcQuMMljHeiseg5meryUpmKTIPHXgtDYodMDvtIywlG9KzVvgr1g5r?=
 =?us-ascii?Q?wCZfxqbQ+Xn2jnUwStjpzTAvVvOqau+Ll1LMfBcHCjVQx7Lt34WDM77GzJ8N?=
 =?us-ascii?Q?Vkz+22Iw1XsnMNyGR8o6Yl3p+Mb8c/FbkJ6O1KDlT6tD/JdodaM+Db+u/ARe?=
 =?us-ascii?Q?3GnySWZZIH+6l4sEf3K3xzoMAw6NybkMOufCDyJwz74gaOcynK/QPm3QNZ+C?=
 =?us-ascii?Q?bCO0ni8jNTMprHpA7LdyfXUerPZ4/YM++AwUTvAGWheHq+xALiiiw9nxO5ih?=
 =?us-ascii?Q?gwhSCv1fnHs9y3Ts9HtePTs0OinMxJB0lmcfPeVRMotBQpfd1L0n4KvIEc5X?=
 =?us-ascii?Q?Gog8zTRgL1lYgiYzTQ5a2xrZfT3oNDpbfg=3D=3D?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1a612f1-4aa8-447f-f4a0-08d8c22cb844
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jan 2021 19:00:59.7682 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2dL04IUtgamW9RXS3GIvyGIOvYwEP4DEYMq7GcnWYNQ1FhHNXneR6FiF7vuM3dQeLPlKwOvhET/z4NqEPgVAe7Z/E1EtK9iLUC0TVI++D38=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB6023
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210126_140104_399085_90978E39 
X-CRM114-Status: GOOD (  17.76  )
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
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 1/26/21 10:17 AM, Clay Mayers wrote:
>> From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
>> Sent: Monday, January 25, 2021 5:43 PM
>> To: Clay Mayers <Clay.Mayers@kioxia.com>; linux-nvme@lists.infradead.org
>> Cc: Keith Busch <kbusch@kernel.org>; Jens Axboe <axboe@fb.com>;
>> Christoph Hellwig <hch@lst.de>; Sagi Grimberg <sagi@grimberg.me>
>> Subject: Re: [PATCH V2 0/2] nvme: Support for fused
>> NVME_IOCTL_SUBMIT_IO
>>
>> On 1/25/21 12:03, clay.mayers@kioxia.com wrote:
>>> Local pci device fused support is also necessary for NVMeOF targets to
>>> support fused operation.
>> Please explain the use case and the application of the NVMeOF fuse
>> command feature.
> NVMeOF devices are used to create disaggregated storage systems
> where compute and storage are connected over a fabric.  Fused
> compare/write can be used to arbitrate shared access to NVMeOF devices
> w/o a central authority.
>
> A specific example of how fused compare/write is used is the clustered
> file system VMFS.  It uses the SCSI version of compare/write to manage
> meta data on shared SAN systems.  File system meta data is updated
> using locks stored on the storage media.  Those locks are grabbed using
> fused compare/write operations as an atomic test & set.  VMFS originally
> used device reserve, which is a courser gained locking mechanism but it
> doesn't scale as well as an atomic test & set.
If I understand correctly VMFS is out of tree filesystem is it ?
Can you please explain the setup in detail ? what kind of interface
file-system is using to issue the command ?


Based on your description it looks like target is connected to the
vmware based system and host is vmware based host and not the linux
host which is present in this series.
Also what are other applications or is this the only one application?
>


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
