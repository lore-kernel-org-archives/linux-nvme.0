Return-Path: <SRS0=HFDN=OT=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2261CC433EF
	for <linux-nvme@archiver.kernel.org>; Wed, 29 Sep 2021 06:44:56 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D3B79613A7
	for <linux-nvme@archiver.kernel.org>; Wed, 29 Sep 2021 06:44:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org D3B79613A7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=tXdHuXTpqBSF7cEnV41UxZDAG6msOO6zwFMV5d3Cs74=; b=NbdXFK1yYoNh59
	VsroxbtgkyIAe6lslrEQ7NnyrK/pCMFTlPrEOJw2n6xIojNER2k3fkEFXAKYajifX3uSXs3evrO/W
	wmuGKbKRlCHzyh2ujWVzYnNheU6f79N1S1emFGpC5+GYU53feGZe0v9aqGNvw3vb7tMh+BxM4GI1G
	VGfsA/n4faUVuu0tqJbQ7TXp5dk+Ugihv7XcfRRZc2LLoSqV2gBYcGORT52sk4kWad2QDgkQWzQfR
	XRdAm0wZd7GjAGzc8M7MJmHSibS459i8npck+EEpEo1A0Z5d3xrNmmJ5LUkipQ8ltHLdJjIxMrVoI
	G1MXKm2v1+zYBORJTFkA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mVTKT-00ABZf-LH; Wed, 29 Sep 2021 06:44:33 +0000
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mVTKR-00ABZ7-3Y
 for linux-nvme@lists.infradead.org; Wed, 29 Sep 2021 06:44:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1632897870; x=1664433870;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=NyfR0mMdfst+m6AxvOrSbjFz4SRxlfk/WyGblWqmXKY=;
 b=bv6EsSEruUb3kHYht5mKCWcvMd6kEHqjNhvR8hu4sPKd6xDThOkkgP9e
 JioV1OYc3Ql/t5TmNyqbT5AXDrOod9FFXSFfHiAFk0LHhnH5eTy7/YjBW
 5LW1nXBcutPaOiDUot3u2s73GdwqmPBMTKKW0NnD3X/yNdzfkEi+TZxPY
 4xoZd/WTXPnDOPCM5OOO2FOF6Z7fqkB3xZXlIY6VJZAkdqfUDruFd/CUx
 wMLjqAgcmKQyWhEOT7ApmNfmf0jkTiJMMa8jhSsCLJK/C0Y1YoAQfVr6M
 VhB+7TowQs4yT24IKXGJJ4atnobFLRzGxHUrKEEp6LFpaR6T8mUpAf8KN Q==;
X-IronPort-AV: E=Sophos;i="5.85,331,1624291200"; d="scan'208";a="285072411"
Received: from mail-dm3nam07lp2043.outbound.protection.outlook.com (HELO
 NAM02-DM3-obe.outbound.protection.outlook.com) ([104.47.56.43])
 by ob1.hgst.iphmx.com with ESMTP; 29 Sep 2021 14:44:26 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lyvHG+XAfZBc1WOBLDMPTsyNEfJWXLopz8PmM9KtPea1ZFFS3SG3Pvc2GcFhUbf/W1U3O9JZtNamtA1jWSC/cr7dEwj6pqkaFv6D3ips3oZI5otBdJEGngxfl0v44lCLzRZDlKm9F0BVXAucdGQlYsWpGABreoNw5wE7Z6qEp0KWpAZXiO5XlLavTZhprbVBmIgFCDfFOrQTLWK180a5516cLmZW5jw1BoAqggC1YmVN+FpnbtQAA0QVVSbsuqqtfBJfPCTg9WJhe1vVj9qrQlYtGhL+6yOvRI2Xj4sLgtC7EkDWFWEUGLPLnPGkZ0cnhuBWigjE1ZFk1sOQVzlO0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=NyfR0mMdfst+m6AxvOrSbjFz4SRxlfk/WyGblWqmXKY=;
 b=jx4lckGVAPrQC/FMHciiNaL9N9QbqCJQwoI8TxUSTBkL7veaJDkPIEn+7dQ5bqcG9wfVANshEFTOoQgPKeHO+zE05/DcQrDHF7oZ7U7tv8MuXSuEPNwbxz/i50Wa8hP9XW7Ch/4I0CFoRb7coEN1yUtmcCp/R0wLyfPFXQroeZRw6TShAbvk+08SRXZ2vlJKUSnYffE5vClUBNT3BKJLjn89i5OwLIuZr6eQRqfU78C2Ri3qJXIwJe0fiww68ZA+qnUzBYiMfe/MZh3Lxt/fd2higt27CSSeCVxUiT/Tfzk05Lo/bzF4oOg+8sk35pf2UrbJUdPbWK78N1XVWykUNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NyfR0mMdfst+m6AxvOrSbjFz4SRxlfk/WyGblWqmXKY=;
 b=t3AxLajrcKCDovavoLzIUFtXzf7+o0DTWE+71kmnJMNI+51krJPvV8JYogpXmYbQMAa9UPxeLrrFs9WJz8c8dwc80/LzBe2e0ro8Z93k57LfAPqyOVPfNhOrBv9+LeEZhe/hSkc/CflCOEyMxlOSFfttNMzrQkc7sHISgJd9kVg=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by PH0PR04MB7352.namprd04.prod.outlook.com (2603:10b6:510:1a::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.15; Wed, 29 Sep
 2021 06:44:22 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::5d0d:3d52:2041:885a]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::5d0d:3d52:2041:885a%4]) with mapi id 15.20.4566.015; Wed, 29 Sep 2021
 06:44:22 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: =?iso-8859-1?Q?Javier_Gonz=E1lez?= <javier.gonz@samsung.com>
CC: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "dm-devel@redhat.com" <dm-devel@redhat.com>,
 "lsf-pc@lists.linux-foundation.org" <lsf-pc@lists.linux-foundation.org>,
 "axboe@kernel.dk" <axboe@kernel.dk>, "msnitzer@redhat.com"
 <msnitzer@redhat.com>, "bvanassche@acm.org" <bvanassche@acm.org>,
 "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
 "roland@purestorage.com" <roland@purestorage.com>, "mpatocka@redhat.com"
 <mpatocka@redhat.com>, "hare@suse.de" <hare@suse.de>, "kbusch@kernel.org"
 <kbusch@kernel.org>, "rwheeler@redhat.com" <rwheeler@redhat.com>,
 "hch@lst.de" <hch@lst.de>, "Frederick.Knight@netapp.com"
 <Frederick.Knight@netapp.com>, "zach.brown@ni.com" <zach.brown@ni.com>,
 "osandov@fb.com" <osandov@fb.com>, Adam Manzanares
 <a.manzanares@samsung.com>, SelvaKumar S <selvakuma.s1@samsung.com>, Nitesh
 Shetty <nj.shetty@samsung.com>, Kanchan Joshi <joshi.k@samsung.com>, Vincent
 Fu <vincent.fu@samsung.com>
Subject: Re: [LSF/MM/BFP ATTEND] [LSF/MM/BFP TOPIC] Storage: Copy Offload
Thread-Topic: [LSF/MM/BFP ATTEND] [LSF/MM/BFP TOPIC] Storage: Copy Offload
Thread-Index: AQHXRfrE+mT6pvaiwEOWn89Dsv4XaA==
Date: Wed, 29 Sep 2021 06:44:22 +0000
Message-ID: <PH0PR04MB7416C6D3E446DE6CFFABC5C39BA99@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <BYAPR04MB49652C4B75E38F3716F3C06386539@BYAPR04MB4965.namprd04.prod.outlook.com>
 <PH0PR04MB74161CD0BD15882BBD8838AB9B529@PH0PR04MB7416.namprd04.prod.outlook.com>
 <CGME20210928191342eucas1p23448dcd51b23495fa67cdc017e77435c@eucas1p2.samsung.com>
 <20210928191340.dcoj7qrclpudtjbo@mpHalley.domain_not_set.invalid>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: samsung.com; dkim=none (message not signed)
 header.d=none;samsung.com; dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bd3482f7-e6a0-4889-afce-08d98314921b
x-ms-traffictypediagnostic: PH0PR04MB7352:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PH0PR04MB735289F97E18FAFC64A65DC69BA99@PH0PR04MB7352.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XgIOrqvE/Cc2h7XPGFM8SHpVE8xFu139tuBEj70o//6OYcjYpSabJJKs8vskNAE8KM+alH5G+pkgQkqASqeCEk6k8a390sg3fCK1rcVULO3Q2XVDs0H8fqXHN+ryvRR8ldKyisJDyxifWIqDlsRUNnx99eJ2yEfAq3ULGBtlZwY/TjySt59+QqsqIAtdJ02c0DwRb5K/QwdnTtefY+uo+/6X1q03qehK9SJvJdZsU61CNUonsDTvQ/8oXuL3Ea1vjPopMs2dGtzjam0ZE4AVAwcB8A4OcCZsZEpsvtK0qJLAn7tIywXmwqOHEXPIEEKmYPz5Ui1GxahG4EKNMQojZiDZxLDM0W/t0p2/GuysaJ9qo6q6kuwb8nIroCC7L2EDzmF1AndjX/SGm4bepsaWIZbPNwfQC031oqTY7Z9dOHV2l88dNTVUULOHZsc/MFS1Nd4kM3LgmY+A/B/HqodBoth78oVgSmE4CwEDonpJOUn+ZClB5a7AOQXQuNhop/U0upBR9xMuaBclwgLkqlZshAwqUypDAd915TSerfN+a5apliuOeWNFDehbMmgWaMTfTOX/sQwl7D+3tV0cwTIlCjl2H2Ayt+Pxx0+h82EuGU1jSOW2hxtr/QToaCEOB58zVg4/RBwoSx0aDHIKlIhDZ7BDRmoH8sPrt6m1Myjd+judsQfqvyAnxx/Wg73DHMwuOWXHfbPSexbR2CMUIO5qXA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR04MB7416.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(4326008)(8936002)(91956017)(6506007)(186003)(54906003)(316002)(53546011)(71200400001)(76116006)(8676002)(86362001)(2906002)(5660300002)(66446008)(66476007)(66556008)(64756008)(122000001)(52536014)(508600001)(38100700002)(7416002)(4744005)(7696005)(6916009)(38070700005)(55016002)(33656002)(66946007)(9686003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?3zfCM9fxj5Ip3evj7FIt1xvlD3T2pEczqwvU2iyf+L9FylO8r/PWggLFZ0?=
 =?iso-8859-1?Q?F3yjxixO5wh3vSPb3OouMhL3Fh0Edugz+4d8VMHtRKSOKqgAXPZ0Z7i0rr?=
 =?iso-8859-1?Q?odGOU6w0Ytbdj33j1BXFe/1quUANcsWSz7ujo58v0jytCjTSF+Tb8yaFIA?=
 =?iso-8859-1?Q?lzTXzgDjGiJFnN8c4R0Z5d0HuiKljEbYf/XFw8PaxCTpuKQaH6OYuAQa0R?=
 =?iso-8859-1?Q?IVWRsk0/HLyB++r9ICf3PX/+ZwDuWaJDtHabfzpybhz0kz2mdmPFziB5HH?=
 =?iso-8859-1?Q?LmwmySHbaOdYpfwY8P743DhAIz/3lwtWYhA+aTb96CAEe0XhVYdaNoQt/p?=
 =?iso-8859-1?Q?KkZgTXT7er6RqZiL2DHyG4zY2zlbp49ig/0JTtiXxcAP7pQS4pLOlEijUL?=
 =?iso-8859-1?Q?BeqoZAuO5RxgCELLxwi0Pb7HHkbwn6fPgrkFTT2Q81YuGWoNTxjmvJkEQC?=
 =?iso-8859-1?Q?nRwAGjFCrQ+3x3nduKsQHXj5POlWfR8Jl98lp8jIFbouklsHAc8cdefL25?=
 =?iso-8859-1?Q?5Ao/6rQ+BK8hSVKcMyZrERaAoEM9rXF7JoQi3wFrz8FmESu+ISmckNG95o?=
 =?iso-8859-1?Q?2vgAH4YIJN0vbWuecb3Ty6qNXKMm53a7QyhoSy9EsjglHvuycrGcOmlj2c?=
 =?iso-8859-1?Q?65wzj7ycBiYAwzuhUoIj59zvYS6Qu7sLWHpC3Yh3GtxSqT3xxJIxU+voZr?=
 =?iso-8859-1?Q?0PdqVsM1FTuWWstq8Z+iIIEAgkgqTe0zw/6csCtbfNsNa+CvC9m4j7/JKg?=
 =?iso-8859-1?Q?guxZhMgR7xMVi8tFnjy6wNMNi6ZggBTDBCimUz1h2ELZPSSqK49fw0mSp1?=
 =?iso-8859-1?Q?4hfXaSoUp09KlFSkt/5jwF7jaebpMxlIFyFwUkGlEaXvca9NgzCTAhjLUO?=
 =?iso-8859-1?Q?3ImAL4gx60WVyHGZiOBHklt9Ct+8DTkV/zP0cKWxIOWdRoyve/3x5r2yOk?=
 =?iso-8859-1?Q?LG9Li4/T8oIO1PvNmYiGgDGGzgSjiRpyUXHnApYvTuvJBrhkmNu2ZSnu+T?=
 =?iso-8859-1?Q?1irFze/+/bH/gzrYeMdzXR0dMviqisn+5vFm30bLPkGZx3ass2QdH8uJHR?=
 =?iso-8859-1?Q?bUTbEufDynXIm1uD4FiituW5DXq4mr4JSHTIh2o46zM4brH2XBwV2sIwXm?=
 =?iso-8859-1?Q?DGejF732H+5gDHzEAKPROT6fqCc40wpGZmn1n2Ouz+3/Vc//d6I69U4jXE?=
 =?iso-8859-1?Q?8BGIow+748JTMAfkGVrGAhXWL4SF7+66tjPYgj9qsgWH45i8yfeUwGeavN?=
 =?iso-8859-1?Q?fqji5Y1jKCSLHVMUP5538CWqxrj1dMfiQPUxyBmwi9PHNaKCVe5ju1WkAE?=
 =?iso-8859-1?Q?sU6P1TUOZK5Fcu7pGrsqvLnKsnu5n5KPCc6bonMr6dwt7z23Hz+7LWy2hz?=
 =?iso-8859-1?Q?zuVQxcjLeqyw9YwZGJHF8jv1VA1ChDZQc99kGdqTaJB7QFZTVnEWPS/byM?=
 =?iso-8859-1?Q?lOe5FmOwwbPiS9PCdFAqASlq5tFUdrK01y0sdw=3D=3D?=
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd3482f7-e6a0-4889-afce-08d98314921b
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Sep 2021 06:44:22.1208 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CqT0HiC8Tmmp0wANKmEU2jWJwK40hwfut+1VBNn7LflXYlh5nf/nixeOh37O2HQuIhmdinODpDDXZniqlDKKohC7zvzUmyl053Qwc0yT928=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7352
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210928_234431_261141_118C2F55 
X-CRM114-Status: GOOD (  12.34  )
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
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 28/09/2021 21:13, Javier Gonz=E1lez wrote:
> Since we are not going to be able to talk about this at LSF/MM, a few of
> us thought about holding a dedicated virtual discussion about Copy
> Offload. I believe we can use Chaitanya's thread as a start. Given the
> current state of the current patches, I would propose that we focus on
> the next step to get the minimal patchset that can go upstream so that
> we can build from there.
> =

> Before we try to find a date and a time that fits most of us, who would
> be interested in participating?

I'd definitively be interested in participating.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
