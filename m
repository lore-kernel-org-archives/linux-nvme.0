Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 023F1C4167B
	for <linux-nvme@archiver.kernel.org>; Thu, 14 Dec 2023 21:21:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=A8mQr4QzOT8MgSHLDTgUdd8TBi3hDkCOxfDq8Y5KlvU=; b=XFdFsIPsk8hwlGahdR2v7+ekGG
	4lsKlqMtlERkGS089p5KBuFTVSilDzOLmBW4vKTe7yLJavEvDTyEUn5fARQxgmMJ4rPlCGXWiTHJ3
	aPd2jx+Gn2QiUEKepYe7LVSgbUoL1H2qrw8WnXeTKZkf6rfOZNLMTdV2JrSP8LgM2uUJErCtK4jta
	+1YcLTjKkJ52yglnyM765ThU776P/vdPaSggkPaFfUTR/FrA2tfUAEs/d3Pn3W5YvvHdJ8TSusgwn
	Xw6tr+H4e00su7Aatf+gPqk0fXmh4BnYmXqTLXd1+QJ/VFDqEcQaE5fIISdV5C2DBXIgYPPO5O33v
	tckJc+KA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rDt9I-001Kam-39;
	Thu, 14 Dec 2023 21:21:40 +0000
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rDt9E-001KaI-1h
	for linux-nvme@lists.infradead.org;
	Thu, 14 Dec 2023 21:21:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1702588896; x=1734124896;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=ZDMwgncsagULpllsj7rke14J9FchQOc7USaXMVwBev4=;
  b=JdEOK0nb4kTIc9pC9nwGPrMJWVm/ZRsGLBaZL0d3Ff58m+ZT1GGDLaOv
   yOFtPqPM8XiB4beml+aka6udXk6nGPTiGATq5e1JfbyC6cAQ4sObsMbIW
   hANu8zKUhcnFQJWQM/zIZw6RQruCTx7ia/FCY4R3pX/NYVcT62WOmLrXc
   Y/hxrDKJspcJ4vPc1XSeW1QuApy7h9XYwdJKSkzsSNBOjJ071hUn8i7BM
   izB623wYLYCGLuo7zSfLPc6xcoKjdiBZy7sGaIZLVMo8y+9aqVOrk/t6f
   Rjz3W46DWMqUBIijjgRNgAC8Eiv94W9bvasW11DS9bWeHtUtm0QB0TJvj
   A==;
X-CSE-ConnectionGUID: NSn0iUuWR6K8j+QNJhXzzw==
X-CSE-MsgGUID: 03ECi1msReiiGFUFUadOUQ==
X-IronPort-AV: E=Sophos;i="6.04,276,1695657600"; 
   d="scan'208";a="5181731"
Received: from mail-dm6nam04lp2040.outbound.protection.outlook.com (HELO NAM04-DM6-obe.outbound.protection.outlook.com) ([104.47.73.40])
  by ob1.hgst.iphmx.com with ESMTP; 15 Dec 2023 05:21:31 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FXvy2H1i/LHUSlxZF0pzZS3WpH6TOOop9BmPfq6LNgzXjk7ZRXKjmVQGV6Y+ExFDDb7GNir7+YicYnGLHToIEf5OvBSyDyEx4MVZTsddBpUQAVLlyyigYc25nEw8wvaRLIlxvj2HL65vCEM5+v4+gebydOVvJ1+Td0bqpgCVdtIgjotlLDfUf+Zt+sE1vwnIBfAtV/7lUoVNA6aL8WKX6QA1axDtXTHmsYjfpDbYq93mjI1tPOnKd98OssaI730hfXzBROD7fB057PmDSTUpR5kysenx+qDgApId4WMTyNOG+OhlVBB6opmDJUA4xW7tf0+KeNa2l4DxsyGlKujOWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A8mQr4QzOT8MgSHLDTgUdd8TBi3hDkCOxfDq8Y5KlvU=;
 b=m37OZlxsElRFcswLlRUVML2ili2a3ek6Inclf6NEmzo4oKJ4/+o4fPPMsG1kaUKXdNm46SuDlwgOUl46mdrsONkwAemOkgnp2NIhzZ0TfsY1nJ7Eur9DnwmX2N68GTe+gZ9kuIDijT8TvEcmDxpojU2OHp96uco/yimsLMg5e2h4XTK2eRqNaLGO7s88OYa0ByohX0sQed2KwoMZ1RTdXb+DvpAf5W96HwVWkYIqUG1xw5d2SZb+KGqvmvhoHlQw/2SLMygf4u4+siHJyEGomHnyqIJmJPVtd4AZrJ0DvKq9wNPub+G9IjGTW5iCDgFxmkdbHUILIIN3vrdwpPnafQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A8mQr4QzOT8MgSHLDTgUdd8TBi3hDkCOxfDq8Y5KlvU=;
 b=R6HOzSvkb+L7F6+vYb0c173OFx8RG+0ztr+MU5Norrqb4rRJzXMenTgT5OMELZGvNrNj/nW+9ZONI62BwnTZJUN78r2XQK6T6Jg4N8w76sTcxzEUFf2ECikzVLYUC5Fgzv72zyagVJ+YTsny9bsD6KGSGV2YL74Tv5xGU2GpzuE=
Received: from MN2PR04MB6272.namprd04.prod.outlook.com (2603:10b6:208:e0::27)
 by DM6PR04MB6986.namprd04.prod.outlook.com (2603:10b6:5:24f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.28; Thu, 14 Dec
 2023 21:21:29 +0000
Received: from MN2PR04MB6272.namprd04.prod.outlook.com
 ([fe80::ffca:609a:2e2:8fa0]) by MN2PR04MB6272.namprd04.prod.outlook.com
 ([fe80::ffca:609a:2e2:8fa0%4]) with mapi id 15.20.7091.028; Thu, 14 Dec 2023
 21:21:29 +0000
From: Niklas Cassel <Niklas.Cassel@wdc.com>
To: Keith Busch <kbusch@kernel.org>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	Kamaljit Singh <Kamaljit.Singh1@wdc.com>, Shinichiro Kawasaki
	<shinichiro.kawasaki@wdc.com>, Damien Le Moal <dlemoal@kernel.org>
Subject: Re: parallel nvme format
Thread-Topic: parallel nvme format
Thread-Index: AQHaLpVHqt1AbKF3cUaSa/U7/bTugbCpBhqAgABDuwA=
Date: Thu, 14 Dec 2023 21:21:28 +0000
Message-ID: <ZXtx2EOnRUMLSjcu@x1-carbon>
References: <ZXsJdJxDXEbCmSec@x1-carbon> <ZXs5B8pYKTBLD1NH@kbusch-mbp>
In-Reply-To: <ZXs5B8pYKTBLD1NH@kbusch-mbp>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR04MB6272:EE_|DM6PR04MB6986:EE_
x-ms-office365-filtering-correlation-id: 4d302860-da21-4b16-723a-08dbfceaa302
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4GalXqZ+FukdUhK+t6ezfnIS2xrz3z6QV06bSgv+4/ltdm1y8x/pI88ZCu18HOQZMjFMsy9s42TC/pePYdNdHnYISDXw7asOwb0bW1BybMXajvGaIihYAbCErhfPIWR5rm9ZMvVpQMuN1rwopw4TvwpsoQHLdANgVje0RrB+JMfo97lBw+1kQrTp1ou+tyR7dQzdHRFUgf2/iJbuhX7QlVXoERdn79PQhYdJQ7thYL1d/qF1Gb162AzVWXdhBqm+FNzhWbB6cPiI/9Dc9vZDNy7w8ZIYyGL5oLgGXUtFEeKFfL136JG1sf4VKQIKwWLEEHRAhlZgfPOdCSFWmw6KZoSvykuoU9X41tl3z9kSZpryiG3JYYOMUxDhhn/aR6XTpyiw+T2tBNi5jcyRn4rHtYFyCYm3FvbTFpiDgsPdE07C4OZrt2uqT3RhTv/M3ZArym2tz8U5Gv6Y9yryjd7vWMNdUlC0+jAt26CTKGSskFaBEX2L/ukBMIGvBqUFTyBEFnr1I7BtjKmUuUv1Xg86vIG27YzFU3ugNAWVR9GWcr3dXJht793hhWrfi6sJD6IqjHWbhnHugxtGjD8Fxs9NWXsv5ltSZe07xKdMwNBjJHM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR04MB6272.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(346002)(136003)(366004)(39860400002)(376002)(396003)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(8676002)(8936002)(4326008)(6916009)(9686003)(316002)(26005)(478600001)(6486002)(38100700002)(64756008)(76116006)(6512007)(54906003)(82960400001)(66946007)(91956017)(66556008)(66476007)(66446008)(71200400001)(6506007)(33716001)(38070700009)(5660300002)(7116003)(83380400001)(2906002)(3480700007)(122000001)(86362001)(41300700001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?szKo05belN+0/cBkGP4uQsPYQG9vuNMaVF3a/CjyYn3NzuyqLtqt6EK2aTjJ?=
 =?us-ascii?Q?tsDQimKCcE2vpPPnCAaVXxYKBOziyy958RB/z5CtXhubnq4JlEwWWM3tp9Uj?=
 =?us-ascii?Q?WC2maemjQsohzDgXa6rMXlfPcTBgGUoHD4F9h2VTrgtVBuClwwjXGPUgpJP9?=
 =?us-ascii?Q?9Encbx1Z+qrRk2g4xoQhv8VAVLdDMsTaHufjmexG6il8grSMR+hDTo76MAQj?=
 =?us-ascii?Q?Zrq3VnQf+7XKlzNTuR6zuKE9FgoGgNI7bn6iZKgwoxCwbLHEK/5YycGc43Rt?=
 =?us-ascii?Q?vctLh1/jkKq02hrt2iZ2mSvec4oNmPx0xJSYX//+Ur70x7/fU45LkitStBzl?=
 =?us-ascii?Q?SNmYMKHzAmzmFe3RdheL31k+H49120zdq/Xi650u7RJ4duLTDdvA7jhnrFtg?=
 =?us-ascii?Q?wQaBfExFh1hceivo/Df+84nBqOWc75lLPOBHOBGzNqXx8NPF/kGcQGojJ/6C?=
 =?us-ascii?Q?XNoPTtUPeVY5az2FxMWAEv2hHdOwcmX2aW53FdIhJhPUuxzwFLllVGs5WCw4?=
 =?us-ascii?Q?WIBTIhmc0XAtZ+Nqv1mZAM63gJqjGK+BzYP7L+J0Z1FEjbPNqgrC8KIkAc2Y?=
 =?us-ascii?Q?/lXv8jL02c+R+cQ5hhbr2MgVKNn3AAqr4ugPto4mVesx7+yDXDwQKd2zDefY?=
 =?us-ascii?Q?5mR3L7SVsTKGzjpm5KIEzGEDu4yKjiEJ6QNCDFfd5+CD3r3za7sLKGL6aYJp?=
 =?us-ascii?Q?FxZCiV6UjOjaeS44EY44ganGgpOikp8koWx1g4cU/FjPA9daSeqLbfh8nAVf?=
 =?us-ascii?Q?HJ2KXaNHsWkzp4ibuvtlipW4wmeC6mQnVdhlNMRWHGGfhFDUzyTLQ/IAGvNj?=
 =?us-ascii?Q?0sdDz3lKFKl+bmG3jXKw/5RYyxsGFD36pUxjDRuSwxC0iOVN++aNdQiv82YY?=
 =?us-ascii?Q?bWadnbHSB7CMNXoqAJch6GqgFalcmjnsN/7DZrUDSIom2tX1MAOfkuARM46t?=
 =?us-ascii?Q?VRW2E41/YPULfxxZWFUutNikWFBLbShyyoJS4E4masw/hduKZos+U5GywnWy?=
 =?us-ascii?Q?EWZy4o1w6Tla9a6BhuTO/aRJtgzWhc1zB9EAjGwpBE82fFCbs/BavyFSAfPt?=
 =?us-ascii?Q?crsLBdc6U7VgaDbCvVquQGFhBaIaoO1AYg6Z8aiYa+p2j0YKLoEGmSS22wDs?=
 =?us-ascii?Q?gMKrbO4B+HU2d87KAxrXac2VC5udY5X3kKXvoUf+ne+nfYxVP8ZMUM5nrqCr?=
 =?us-ascii?Q?GJzZvNPE5U0PUoesBAuiXHkA+3GFuqOOKD8b56ATlPRNjpoXdkxPGoxJfDD6?=
 =?us-ascii?Q?xJqk8HhZaGCOyvCjQoe7I2FBJkbXj+TNcI9Kf1/helQq25KMfWtx++UhLqdM?=
 =?us-ascii?Q?5FFYsS0v/VhSeEI2RWPHW4TCTdHMMnUS3MXR+Jired+ANOlK/hEYFrVFmFiV?=
 =?us-ascii?Q?nyNcdkzY/yfF8L5PbqKvwT0UZnnwPJcL0GiAMUrgZKXSC9O+ZAvgDvaFkbQz?=
 =?us-ascii?Q?tCIycLoG4G60bL53dlc3Vfo6yhUX0gEeFr+7ruzGuNSknsikRNIAdPwnVjcu?=
 =?us-ascii?Q?0dh0duGT//RDgeg1HbqkpcGM10Fwjkm1pa2wFVwIsofCLa0ZsMexzUNy9m0g?=
 =?us-ascii?Q?IMAy0RjwXMy7zSSTOayHJOVXBQp8JCO4HR0XkNcymRKa9saJha7CC6PXymhu?=
 =?us-ascii?Q?pA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <B3781D26F429BE489D431E4A2A413183@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Esrdgcgc+UXZygdDW7gyjVPbodr6JuRm/MIi7STS9hKSxW2ByWI7UZJho8QKcyImSrF5yg02+Hw5JMVh7s94eFZUuVYtFK1tsV4G4vrfYMIbFMKZY12nNw0fvSCub6g9lBrrxEoeZQ0HhccDPa+uYHo9lG/9yc3zOTBfhuu7ciJHNsxEb7uczuqkTCcloB8vwrT+CdYbNXjsun61MaxgC+646b8aA8I5aGvAHZ2Pq1P6rFk9jkxYJ0yhGzUAhK49u2KctEitCnO/tkK36giIjW8GWAS+a27Nhtsy41saoRSZAmzHw3YSOqba0XYOaMaz66234/VAhdYXfMKEHNogUdn5HTiP99rbzL1mOFQVi6uxbYnasRr9NOPHUk+F5uTj6ndEh6rmNczlNa7J193EmxzZiVQgMb1FSPY7BhjCxsSRDvvTwozpMTgLfYQ7bqpRbP/Sfc6FwJBaLs1lLJIzlVzrLkWhxb9dg3AX7U0Sk2RXpjSqGHpxJaXkobopO6AP62WVJ5NujDuZFK9VN0w/zCfCVd8wt1rj65798KrGzmKi7zBigSZV+5r7/QjRYJOLyK7GBtXA0aU8kPCfZSSuU4QWSY9nuoHmekkITGsQZQARYZWLo2uNIh8Q58wD6rve
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR04MB6272.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d302860-da21-4b16-723a-08dbfceaa302
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Dec 2023 21:21:28.9912
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lVqvbyFyjCukFWkpD9SDX5XBTgt3+1xPaIrs/ZIzzqnScQylt2XNbqMVeUxpL1Ul5jMjL6bV9BDNbtD8aXgMRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB6986
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231214_132136_582837_8E60DD20 
X-CRM114-Status: GOOD (  14.84  )
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

On Thu, Dec 14, 2023 at 09:19:03AM -0800, Keith Busch wrote:
>=20
> Hi Niklas!

Hello Keith!

>=20
> Thanks for the report and detailed analysis. What do you think about
> this idea: if scan_lock is already locked, then some other thread is
> expecting to requeue scan_work shortly, so no need to proceed with the
> scan.

nvme_passthru_start() has:

if (effects & NVME_CMD_EFFECTS_CSE_MASK) {
	mutex_lock(&ctrl->scan_lock);


nvme_passthru_end() has:

if (effects & (NVME_CMD_EFFECTS_NIC | NVME_CMD_EFFECTS_NCC)) {
	nvme_queue_scan(ctrl);


What if the first passthru command (format), has
NVME_CMD_EFFECTS_NIC | NVME_CMD_EFFECTS_NCC
set, but the second passthru command (some other command),
satisfies: if (effects & NVME_CMD_EFFECTS_CSE_MASK)
but not:
if (effects & (NVME_CMD_EFFECTS_NIC | NVME_CMD_EFFECTS_NCC))

In that case, the scanning for the first command can get abandoned,
and the second command would never queue a new scan.

Perhaps we could introduce a new bit, NVME_CTRL_NEEDS_SCAN or similar?
(That gets cleared by nvme_scan_work(), after a scan has been performed.)

I guess for format command specifically, we already have
NVME_AER_NOTICE_NS_CHANGED, but that seems to be cleared before by
nvme_scan_work() before the mutex is acquired.
And I'm not sure if all command that have
effects & (NVME_CMD_EFFECTS_NIC | NVME_CMD_EFFECTS_NCC)
set will trigger a NVME_AER_NOTICE_NS_CHANGED AEN.


Kind regards,
Niklas=

