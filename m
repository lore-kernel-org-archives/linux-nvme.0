Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19E98C43334
	for <linux-nvme@archiver.kernel.org>; Tue, 19 Jul 2022 04:56:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=O0/LlpyV/Dz14cdkk4p3BVe6lKIZb8zfSuMy8iZRu94=; b=0ATKaZk7mahakftKyytpwAbvXk
	39Q5KCD7mRIUJ1cX+T6uwxvTNgcJ7BsZK566NjzHThqpQ9YoLSnuXJ9mV1tg8pb4qPS+a1G5lsDbB
	tdzT1g8kO5ZLMf/vIXY60Vw9TrnblAj2BNUnrvUCucEWzkoIjEOLnPqFAP2otfNtQIChlWpxoVLFF
	whHs4llP+BHjmhJp9Txlhn+zYr0jPQeFpM54dtQNPMZ0giEgEP6iCMTg/kP4dhC32QpEeMEcNmD0C
	bCxSwVQKWIWXJk71DZgOu/VypTHv8Lrf9lNPRfCNUE0mNRZHj+tXUSOaFRv+MP2L1dsOzVXbNe1wR
	Rc/TWe6g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oDfH9-0053SD-7d; Tue, 19 Jul 2022 04:56:03 +0000
Received: from esa1.hgst.iphmx.com ([68.232.141.245])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oDfH6-0053IC-Nz
	for linux-nvme@lists.infradead.org; Tue, 19 Jul 2022 04:56:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1658206560; x=1689742560;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=m9PAzBOW+Xe6NkduzR2OOARXU145GDmy1IWVESQfatQ=;
  b=JGGCUgqfC9ODbpP0a+/B+EdjvyVSDB2DEHCe/BOvhxhl2aaHmLycEiu4
   SstRGkJareuRbelWiRHyYi0bLJK2ooRUuTlnuE6bBp3YOZtLEP0/ErYpn
   1oo04jEFdi1kJV04IYD5iu32SVvMnuQqFdIj/wcfgrd3003xtHh0v7R0G
   Fm5/NUN0ygDiYK8pp0vD5iT+zppWkffWtv70ALA8WvslY8o+fkTpp90cK
   06gkAQxxrJuJ0xWMcsLJl+Vx8yflwdA8l3sD+KWPISu1IVPmorGc4QdkD
   tpYyfEC/JLZMURxAp78tSsbXg0d1zD/5jK4+8PimGC452A7GYSdQzpdef
   A==;
X-IronPort-AV: E=Sophos;i="5.92,283,1650902400"; 
   d="scan'208";a="318388748"
Received: from mail-bn8nam12lp2170.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.170])
  by ob1.hgst.iphmx.com with ESMTP; 19 Jul 2022 12:50:39 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PB4NRpXcjhjCS73SheCWUsT+JlTbXYrAZ18xLo7hw1C0vf+HZnQMKcVAo9JNN6tXbDqv8v9PfR//tqPsDHIbc+hiGKbrlD+geBGf101SzkT+DojkO7qe7Rl1wgfFIiFPpdnuWO2sqlM9cKeKQUra4sBwZE8uzm5Suu5Uq50DZRXBpY2hdbXmtpJd+iR3cuVS9WR4N2VECpEiaaSJEXM9QZBOl2jpIqIiEigzlrEnXlkIwGPsw4pHnZI1dfdIXGQ4hOEVzOt/WIqQ/232fumPcZzBDI4NCBz2jg98smXeCphcs+IgsPXu2Zy51IpMu/6kxwd7J+LzOsGyFKnGN89y+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O0/LlpyV/Dz14cdkk4p3BVe6lKIZb8zfSuMy8iZRu94=;
 b=lEdgWhmkbfTjXCW3rF5X4yIPJjzA2W4yfyVmM3pgIfzc26WfwXBck5QNRyiQg5eEltlkW7Bm4GBLeofnu7zDCx5uv0NKfQrVkCcmq7uHHFi293ElzoweLZ9sJUXTAu9T7bZKXMMXY0B7W1BujZyEG5zowG/hW33GZQ+iGSfJQloY+vNx6DDAZ/nWmtmeSoiJBgl+RSu3ALG2lMDP9DtTEHgnXDKRaylONyu/J3jvo+p1d8Gq/ogKuZp/7Smbgu+egopbwPmx0KCZT8lGaTOs9h2E7Gg/oLFAgEne3K/M4MSmsjN16LQZrth0skq5RCXGo42CrJ3IUwFtLQPdOVsxZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O0/LlpyV/Dz14cdkk4p3BVe6lKIZb8zfSuMy8iZRu94=;
 b=ikhiwDpRlXSSgALstDfW4XpGRQy9JoxSdUOCfbDlHqDXVMDeA1KKdNxr3Aj0M859vrDI4TaNw3GmBTLm5VtLQnaOXBIgKyEeVI1wPP/txt2sUv7GJacg40MavEQdAs8AeD+tRUbk8fD6zlSW52EAFKi0Ah1ZWg/4M+NQhp1+1RM=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 DM5PR04MB0442.namprd04.prod.outlook.com (2603:10b6:3:a9::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5438.22; Tue, 19 Jul 2022 04:50:37 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::3cc7:ac84:d443:5833]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::3cc7:ac84:d443:5833%9]) with mapi id 15.20.5438.023; Tue, 19 Jul 2022
 04:50:37 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Bjorn Helgaas <helgaas@kernel.org>
CC: Chaitanya Kulkarni <chaitanyak@nvidia.com>, Yi Zhang
	<yi.zhang@redhat.com>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>, "linux-scsi@vger.kernel.org"
	<linux-scsi@vger.kernel.org>, "mstowe@redhat.com" <mstowe@redhat.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, Xiao Yang
	<yangx.jy@fujitsu.com>, Keith Busch <kbusch@kernel.org>
Subject: Re: blktests failures with v5.19-rc1
Thread-Topic: blktests failures with v5.19-rc1
Thread-Index:  AQHYfFwe8PMwMXtEZEqIJFDj8WJWFa1IXnmAgAACxQCAADBSgIAAJ8QAgAEp9oCABDqugIAAFNGAgAAEQoCAABbgAIACmtiAgAA6YwCANDpNAA==
Date: Tue, 19 Jul 2022 04:50:36 +0000
Message-ID: <20220719045036.h273puvs3cibafix@shindev>
References: <20220614040044.rypyclhqfv5w4xy7@shindev>
 <20220615194727.GA1022614@bhelgaas>
 <YqpoSp2F+Shqvk/u@kbusch-mbp.dhcp.thefacebook.com>
In-Reply-To: <YqpoSp2F+Shqvk/u@kbusch-mbp.dhcp.thefacebook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 67278073-a409-4c11-d0d5-08da694238f1
x-ms-traffictypediagnostic: DM5PR04MB0442:EE_
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  ZW0b/0Q0FHIAs9qbVaI8qvpJkUB8GIn1IBifs+McS+IweLpRfdfwx5WzmaE1XNBfp6EcYTNTiemwK1J8TAFf3mV+01VUoBGWCQkDlbmI9wUgB3ctiy5mR5x0sLimi+80sFsGiDs42YeTCAdkb/YE06z3qGLsL3Lf2bslWpHz8rua7vXK6GXY3AL2gBTYsb6FqhuDfjuZbLPI60AxmYMUQ8q20Mf+HbqmlQBK3BJCXt4E5y4DTSX7+N8MQ3JsKbuHPzxbdoSVnzbBCV7r178Cl1XmoKJ/ORpNCKqxAWzKu7qhzmRDiD3Fi9nM0eMY6e3iow54pT4j4YKkthwKPRpBluInHV7NwwckLYWNPiuJBeJrMVWtRNIiFGScz7hfzxHi7CNnzhzAUmEUBEZ1TwGgO5THMuv21Kp8i/SfLVUW6jaW6K3kty/LbNnehLxKf2NPxez1p36TGRecCirgWaQUvrGyKgZhTogDbk4n0R8ye6qn3GtFYjGNQoo+kzdwBoS0J4Sk2nKZLnRV6DuXhsc/H/5YhbB6AM4kODzCQoi575xFV7hA5uyxq0h2RkHoAwKCOlvOp9kyS8HYsqkUtTHKcgCp9stkAfOvMtiySG6L45LGIq5yorSZtCdldayF2fqSMfiDuJkSiYdcgAUYe/s8ZwwkBLIPaxKH6T5sVjGAa+6L8Z29wC/HKzGDtBiRjfk45t6A1j9kFnjdnOlGyAJsWRLq53nfEg6EQdWDZ6juTOXi1mf3n0p0/+C6wkDG1xy00fKRXNDSVhzg2fNNzcR/z+4lF8haFkrOuec6OrxOGdBrzH+DSTvbFHS8OBd9UzO5EuILSwmcMXr+wEVQQgfKIw==
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(4636009)(39860400002)(376002)(366004)(136003)(346002)(396003)(966005)(8676002)(478600001)(6486002)(6512007)(6506007)(6916009)(26005)(41300700001)(9686003)(44832011)(64756008)(86362001)(33716001)(71200400001)(82960400001)(122000001)(316002)(66476007)(38100700002)(66556008)(54906003)(83380400001)(186003)(1076003)(2906002)(38070700005)(66946007)(7416002)(76116006)(91956017)(4326008)(8936002)(5660300002)(66446008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?us-ascii?Q?kJ0Wg1NTuNOsWRWF+La6CXMa3DpBHm1w4Y24+zPrpzgRl/PO5jMi5xSidN20?=
 =?us-ascii?Q?uCrfvG68EPFdA5HEsY7p+BC3C7km8+H0bwTX5XFI6wCJhQ4yezaMUlbRe9sg?=
 =?us-ascii?Q?7CQHOYw/qV+wa8gSqjo9P4/XZABOGfTByAAzxuSBx1TFnrL68kJuDo6kspHM?=
 =?us-ascii?Q?JYG3OQFg22+DsmEWeePPRJHy3lAGy+PcAX0WE3ltwGCgWe4RemD0ld/qaMvp?=
 =?us-ascii?Q?C7l/NbDU5WeJE0I59WM3umQDWtrboNVVRQc6LQwp1IiDhrt626nBRbEkTg+a?=
 =?us-ascii?Q?GnimEwMPnyguAmIymDOkPaRe4Y5eytaZrxtUzXF2etFwW8j6gufBTcqtUGy3?=
 =?us-ascii?Q?2y1zmC1TUAPWWKZxIHd2msH1GWsrwrr0WdNg6Bg8huH7jK2siU7qd9KhnUl3?=
 =?us-ascii?Q?b2xPb+/tmLh2j3VDKX2IJMDvi5FKjkUdcBV6MYt/cK6/Bp9yJPOvwiDr6WqP?=
 =?us-ascii?Q?a6bvcwNZACgaV+DZcvUjLYhCRacMk27JjlLfUeKhFE25naoI/4JxxmoLTD3o?=
 =?us-ascii?Q?wRAerrVLMVg267UMAYmI3kO2Cg3ezMaaf8h5OdFO9sSCSwxsHfQs3cFlCXUI?=
 =?us-ascii?Q?SB4k2rZ3ai6AMXjnx/xmSfJUV/rouulPAkKPEhLsd5+0jbeR7snaMyWla1ox?=
 =?us-ascii?Q?aLGyVtGjSMf9j6PNmtcVmD0FTUHspnI95VA8eVYjbw7AmBDt4swT7/p2dOZk?=
 =?us-ascii?Q?BX5zBmcLkp5Af6hvIywx5LzM9szkN1mRiEn0pkHzUwN4Ok+1MCxRTZbCMkAY?=
 =?us-ascii?Q?/0c/ZcHhut5F/i+LemRMyDNtkuHxRuDXkmo7mwgjSDLJKJROsMfAs3AZ1G7i?=
 =?us-ascii?Q?i/noVWTZEX7uJfDksKjIbqOr2F7vhsYQ5otSsRM4EQ5CUvqsWIAtDBPEyu1y?=
 =?us-ascii?Q?7TQ2+Qbhy5VgU+Qv4JJOdZOBtKXaJPn7jk1Zmz0XmSecOs3Ata4eBY6W/EWl?=
 =?us-ascii?Q?wOe3lWxEIGvJjeEDknmloGgMNf2BGKhFhhM8krxbx1xv4Qeem41uSl7aa2xT?=
 =?us-ascii?Q?q/z9sDG0wuM0+qeb9y86/PjJOoxwteXrvu8rMM41MVHNrwftBXoi6pdsZDyU?=
 =?us-ascii?Q?yilBkjap+32tJ7rNybpTSVRLDMMhgb6PlTh6LIVQ4t6wN8JPIfNi+LWsEik6?=
 =?us-ascii?Q?JPstVtF3ok08bJSFpqgrWWuBGvOE4ggaxHLtCQoz0xPFPyW1ZBpWNklX1yjt?=
 =?us-ascii?Q?zxxkOvT61VuPWTfzrs2rwAxY4GWtawz8ekcTpXwGipWCR60KqoK5HoEEXRMW?=
 =?us-ascii?Q?grD6kVAgkcxQ7wzt1+7FPYWsq+yFY51lNLoOmiE2pFRr7fPO3d7ASblA8wnK?=
 =?us-ascii?Q?qnxFeUCf0FrEMaYefWi/iwV98C7p5UzTm0uVtstAhrQsgrAzAClamKFVC8oD?=
 =?us-ascii?Q?qIXkvLegQu9JSNK5JgwTfI0hFeK/NI8yVXWBabH2xSsxbCx5Fio+gv6qRVqa?=
 =?us-ascii?Q?CboboTd+pRE8RGorr9luLF/gBkiD2pgBewl+yTcdR8FY14Oz2YpdDlbhujfp?=
 =?us-ascii?Q?LhrgtfgWab5/fEK6pKu7dU2RRxT+9scQmHSJDei6CvdPNOn0i6+tkbW5Bu06?=
 =?us-ascii?Q?ZNTrgXoI2t2vBiNVSYJSqz2BSMBpq/Zmnm04PFSt3DcP46zhJmjbc0RKRV1E?=
 =?us-ascii?Q?yb8zt25yvhDy+Xi3qltXJy4=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <AE1A12E4CCC73B468ECB00B0A584F7BA@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67278073-a409-4c11-d0d5-08da694238f1
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jul 2022 04:50:37.0006
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TlCFkFUbRDG0s2wDtneEZVTmMTByZ2u2KUKrCIe88WQ/Ii328nTJZW4YixcTuXWjsXPlxcXNJiPkQ+icoS1cs58Da81K75pbsZSZoZm5Xr0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR04MB0442
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220718_215600_825888_79B99915 
X-CRM114-Status: GOOD (  24.74  )
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

On Jun 15, 2022 / 17:16, Keith Busch wrote:
> On Wed, Jun 15, 2022 at 02:47:27PM -0500, Bjorn Helgaas wrote:
> > On Tue, Jun 14, 2022 at 04:00:45AM +0000, Shinichiro Kawasaki wrote:
> > >=20
> > > Yeah, this WARN is confusing for us then it would be valuable to
> > > test by blktests not to repeat it. One point I wonder is: which test
> > > group the test case will it fall in? The nvme group could be the
> > > group to add, probably.
> > >=20
> > > Another point I wonder is other kernel test suite than blktests.
> > > Don't we have more appropriate test suite to check PCI device
> > > rescan/remove race ? Such a test sounds more like a PCI bus
> > > sub-system test than block/storage test.
> >=20
> > I'm not aware of such a test, but it would be nice to have one.
> >=20
> > Can you share your qemu config so I can reproduce this locally?
> >=20
> > Thanks for finding and reporting this!
>=20
> Hi Bjorn,
>=20
> This ought to be reproducible with any pci device that can be removed. Si=
nce we
> initially observed with nvme, you can try with such a device. A quick way=
 to
> get one appearing in qemu is to add parameters:
>=20
>         -drive id=3Dn,if=3Dnone,file=3Dnull-co://,format=3Draw \
> 	-device nvme,serial=3Dfoobar,drive=3Dn

Hello Bjorn,

Did you have chance to reproduce the WARN? Recently, it was reported again =
[1]
and getting attention.

[1] https://lore.kernel.org/linux-block/4ed3028b-2d2f-8755-fec2-0b9cb5ad42d=
2@fujitsu.com/

--=20
Shin'ichiro Kawasaki=

