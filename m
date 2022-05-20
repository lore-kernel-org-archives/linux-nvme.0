Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E1DCC433F5
	for <linux-nvme@archiver.kernel.org>; Fri, 20 May 2022 09:30:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:Message-ID:Date:Subject:CC:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	bh=0FYegpXI4z9r9C05VUwUROtt2TbwfoN1dSxLB63Ozms=; b=qsEA15J3le2e9VLb2MRcd/PtGD
	gPjcv9kglwdOjy6Xdo+N1DSyKScTRLTAuoAgsPlXQq3HbrGUcCKl9Lft4BohyWpi7Y4MYNao3A8EL
	k3ywzPypT831p0ZEISD/gHr97FoMLlinYfGU3WKJj/c0pkHPaf7spWJAstI5YWtvas9rRyNmuD28r
	jUzbcF/Mgji1bq7tvdKhn+pgwYLpnORmozjQ+PkY8iqc5MQfKsCbSo+LmoeBbAXCYPj1oYnA6ShoK
	mx++pPU03kZFZrx21osfg6vQq+odEGciJBKX8Ex4heOecUXEIIy53l9XbMJHa1jI3P2WNF1AfS9iF
	tye2GtNA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nryyC-00Bcdk-FT; Fri, 20 May 2022 09:30:52 +0000
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nryy8-00BcYu-Ey
 for linux-nvme@lists.infradead.org; Fri, 20 May 2022 09:30:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1653039048; x=1684575048;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=0FYegpXI4z9r9C05VUwUROtt2TbwfoN1dSxLB63Ozms=;
 b=doHOVpoZ3tyz4EzQyIXHKF5zaOoyeS03KTBADu3M5Pcj9BpRU74YiZqS
 DlzALkqBum2ir6bspWF5uttdcjCVm6n5V8DcW7sdgeTA9LnKT1dGCCp8s
 D6XT2GmCBGvUohnBk36cPLHCF+1IPMjbBQWydbO5L1qho/GtrQ4r5GPEm
 l4UrJcyaRLocFYip/HBmHmZZAWvnggR1XuflHMlFNrnmXuTWvXRUV8SWd
 tuY5ZfKmInBA+W26Fev1m3fO/5UWK6kUCaDrRpmxi0STZeBVhRHfqvJlY
 2toVv216GpOIuIpjOWplQQpqQONyfQjNpz2vO3buoAfUS8D3NFs4rDH0L Q==;
X-IronPort-AV: E=Sophos;i="5.91,238,1647273600"; d="scan'208";a="305116041"
Received: from mail-dm3nam07lp2047.outbound.protection.outlook.com (HELO
 NAM02-DM3-obe.outbound.protection.outlook.com) ([104.47.56.47])
 by ob1.hgst.iphmx.com with ESMTP; 20 May 2022 17:30:44 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SgeCuow6AbCOp5eJnacuWHo7mtsnSuG1jNLI2dslsBgOnW6eqwl7yK77HlLri/pB+ykAwOkFNoailj0eBAgZzPZqtEN7ujouWKa7i4FX+M3dbbSQ0T1VTpH0HkfWeShVq2xVGmtLqi7BPyp1GL5jjAaRcBDMdbGWLrAP91sRUtQaejcFgBN+IE1qyle9Juedossuy5XRsHfOX8CX/C+l1mnVBP5PdL4ej9s6lYpSy+t92QqJrY1XB0BZPIZb7jv5AQ/pu+pKdD4vfn/IBVojRqWyXcQDAPMt4G6C+PxB0ufXKMKH9eXZ9TUl/1h1y4qDK2QcMqmXNTf00GG1Ia14OA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0FYegpXI4z9r9C05VUwUROtt2TbwfoN1dSxLB63Ozms=;
 b=Nhk+OUQ8VUSoR45TJ/X/sTfgsJybVkDui4fu1jC3wgbwK8w4V9p23gETtCXD/CioXbJ/XtUcDXPAs75hqv3/Ji7B2WDGLxSG6XeXY2BSeEKnmH3W0GNeQ1neJ9oaZGoKJ+8SIHnteUcVPnUabreW6DsRR60HqRUEOHIriGApTDUOh0YSVXzsBPwAODpOi8VxFSEQoUgH4wmmoyvHyrdjPNZ48DDF8VfDw/4/8iYbR49AvmKl1qCnzDn4xzDgIVRaeqEq+tx8htmsh/XyXNTZ/9OgQ5bswmji4bqPDL8ewpV4JNM9w37ip9LZsxKT9n3AyUK1K8SvwzjtxnOAvq2zlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0FYegpXI4z9r9C05VUwUROtt2TbwfoN1dSxLB63Ozms=;
 b=sb78TEkH+34/oUDdVwiJ7Xq1kSFirmiE0UwiG8XbJJ7OBkTj8HTtRZnjxuVS3UAIZOKzAJSP3mY1N7ff78WGpjkUdmmirZCalulTpSobUPkyt8+a3187Kz8T+G2KbbqgJs8Wh7jzgEyj1l4Mnq1Aq38FXvB1o6sqhubb4+tQhWI=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by DM6PR04MB4394.namprd04.prod.outlook.com (2603:10b6:5:9d::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.14; Fri, 20 May
 2022 09:30:43 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::81de:9644:6159:cb38]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::81de:9644:6159:cb38%4]) with mapi id 15.20.5273.017; Fri, 20 May 2022
 09:30:43 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: =?iso-8859-1?Q?Javier_Gonz=E1lez?= <javier.gonz@samsung.com>, Hannes
 Reinecke <hare@suse.de>
CC: Damien Le Moal <damien.lemoal@opensource.wdc.com>, Luis Chamberlain
 <mcgrof@kernel.org>, Theodore Ts'o <tytso@mit.edu>, Christoph Hellwig
 <hch@lst.de>, Pankaj Raghav <p.raghav@samsung.com>, "axboe@kernel.dk"
 <axboe@kernel.dk>, "pankydev8@gmail.com" <pankydev8@gmail.com>,
 "gost.dev@samsung.com" <gost.dev@samsung.com>, "jiangbo.365@bytedance.com"
 <jiangbo.365@bytedance.com>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "linux-block@vger.kernel.org"
 <linux-block@vger.kernel.org>, "linux-fsdevel@vger.kernel.org"
 <linux-fsdevel@vger.kernel.org>, "dm-devel@redhat.com" <dm-devel@redhat.com>, 
 "dsterba@suse.com" <dsterba@suse.com>, "linux-btrfs@vger.kernel.org"
 <linux-btrfs@vger.kernel.org>, Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [dm-devel] [PATCH v4 00/13] support non power of 2 zoned devices
Thread-Topic: [dm-devel] [PATCH v4 00/13] support non power of 2 zoned devices
Thread-Index: AQHYaUWgb63nSgvmhECLq0/sZ1bDBw==
Date: Fri, 20 May 2022 09:30:43 +0000
Message-ID: <PH0PR04MB741634259FDCF264BF1CA7259BD39@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <CGME20220516165418eucas1p2be592d9cd4b35f6b71d39ccbe87f3fef@eucas1p2.samsung.com>
 <20220516165416.171196-1-p.raghav@samsung.com>
 <20220517081048.GA13947@lst.de> <YoPAnj9ufkt5nh1G@mit.edu>
 <7f9cb19b-621b-75ea-7273-2d2769237851@opensource.wdc.com>
 <20220519031237.sw45lvzrydrm7fpb@garbanzo>
 <69f06f90-d31b-620b-9009-188d1d641562@opensource.wdc.com>
 <PH0PR04MB74166C87F694B150A5AE0F009BD09@PH0PR04MB7416.namprd04.prod.outlook.com>
 <4a8f0e1b-0acb-1ed4-8d7a-c9ba93fcfd02@opensource.wdc.com>
 <16f3f9ee-7db7-2173-840c-534f67bcaf04@suse.de>
 <20220520062720.wxdcp5lkscesppch@mpHalley-2.localdomain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b134f74e-d0b9-44cd-2321-08da3a436995
x-ms-traffictypediagnostic: DM6PR04MB4394:EE_
x-microsoft-antispam-prvs: <DM6PR04MB43942CBCF719ACC0460EB4759BD39@DM6PR04MB4394.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JlNiF161A5n7G/mVoZ11PH150UdEAFRSdKYMMRKQ8LbG8x1PayXjix/HC03FkA+Xojm0/uEiaG8niTo4odvWwmbijBmt4yNtYLYv+qCpwTZ1MYo6sIeVcFis6yNv51XJ+2SIqMAs/d0xzYi7N5UZGOA0DhvJSfLbeWQfriwtNgOFTG+4Cg9tx3Fi5xrqpDFYcwQl6VmfO81nmRMMS8nBWAj2QHz1iNWZVT3LCh599N4Dpzdo9YhgeDFlJmoe45/VyF9NsQnvVBfgh0Kbk/l2F0V4xkJOk59W2jJl8TecDFypTzmtpWiO8OIOIPFQ8m6HU57QJ5r8mCD4gS/QQsfvOTMdSNTIfBWw+wIEtxwbLMe6adFnii0CouRzNn9W/faW9f9gLrcAfskyrQlXWnSyd5giGwh/X/Vg1iKCnCVSHJBK591fM8h/eq9p9Vwrxgj011Vg8BzrkUglOGhIFzh5K3p8d5rYO81AgY49aWrdrh2EMSa2j8eJQgAHvx2udRWx+gHiudoaToqkB5LGwVe7QN1FvYHLXib0qcDTXUfz3y6IPjAWYs9ncVSA1PPLCQGeVjq7rENjSbn/aZKRTrZxYDlAD+aNvha/88zL9O0EepPS7DuNGtU5CflcAKCmzVsWNH59JzJiIJT0GmNdqgRR7Lnz4JoKvfQAvve3mZWoKiMKdSSg/rcxZ5BJUBiN1xGmtjllVeZQTAsAVD4zoRxppBfH73KxFotUx2q6BUhSBprA8NhOpHp4zLyb4yhNqZHGGG9NKIalkEAojxQlF67VGUrAtcGOmrZ3zVsKiRG8oiI=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR04MB7416.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(66446008)(54906003)(508600001)(76116006)(4326008)(110136005)(91956017)(66946007)(64756008)(66476007)(66556008)(316002)(8676002)(38100700002)(86362001)(7696005)(82960400001)(83380400001)(52536014)(55016003)(8936002)(71200400001)(5660300002)(38070700005)(186003)(33656002)(2906002)(7416002)(966005)(6506007)(53546011)(122000001)(26005)(9686003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?3j6a5/YpVmW1KmRYiUq7W9ORkthmPG32xtS1A5Ea4Hqjv8pAJo7tFFw7wf?=
 =?iso-8859-1?Q?QZgVwJOb9l5GcnwF/lnOKg1O/CZaB9rio0bbFYzgOdErcIih1+xRLkQ3jp?=
 =?iso-8859-1?Q?KgxZGsdOtAF2XAi6QW3ETWpX6Mbv6lnUrze0TiJGNiKfFpemsJltloq9wk?=
 =?iso-8859-1?Q?tRlQrXNb0D+vUKrw1bOMrUSF9w5RNqP7rm0ZXwoUNZHQkOhDjvBWtcqH7x?=
 =?iso-8859-1?Q?wYzRqjDI0qCXitSGUak34C+K10I72TE8EA6NmIlO6AcPBxKV87nynJCD44?=
 =?iso-8859-1?Q?nbHynPLn1mxuy+R13C0ts4aipoio9q5FEdDLbDhUxdmlHgwKaZSmFMNjn5?=
 =?iso-8859-1?Q?0eejnXjFYvaG2WGxJTm/w0O3drZSPVtrdIH25IrLsut9/jlz/10r0mYA3x?=
 =?iso-8859-1?Q?hxKAPpBU06KVAzqjk/+EA/m110hWfXKjfD45o3v7+j/2J2eQPDLQkehzKz?=
 =?iso-8859-1?Q?C5iE3krj2Xp6NKs0Tlm8lmYv4wE8a48YxAtmDCXn30Ahb/jVYCTDjHs4C/?=
 =?iso-8859-1?Q?/2OJqXp2CvPV2Bbq65QHGrdE+3Kzmuh+aNjMMIfllKy+q/BO+vSpJjnOBc?=
 =?iso-8859-1?Q?HlrYDf07vqIhS6O/UeyccgOmWKDLbjIOIKM3xwnxnhp0kjn6PYHgSUYvV3?=
 =?iso-8859-1?Q?KI8+b8AgTsAOs3x0WROtNn/MuolmX3uY6cT4loRsrdPWPnPomxssUQJwIa?=
 =?iso-8859-1?Q?LefizIaja8hgJog+6QhkHlXxwoReyI51MhHt0O8QRGJPqbUWsZC/HY0oD6?=
 =?iso-8859-1?Q?E/4d1oAdDdG5NwjzMhOuCvcgX3AuVNl2+WYpcAfN6J68lCAao48oXCKQsG?=
 =?iso-8859-1?Q?2JQ8GGsz6RpVrocpd1ad3n7+CudoTljnrvLrs2V4j/X60YJUSxgTLOeGGG?=
 =?iso-8859-1?Q?RCJSLGa+NMc+F2cd8+XRj1sWBbstqsRbh+vfIca8NJOc6uFsEbl2VfIfj8?=
 =?iso-8859-1?Q?OH635qzerE8oqf5Q1WB2kAA8u0pxFoHwLid8YpTsGGQivmXygXE4atByZY?=
 =?iso-8859-1?Q?SbsOiQGDll+s6VI6dYMxt867idgjDfIAMjGfvT/u/JLcgKhaKYU7W+Cy+e?=
 =?iso-8859-1?Q?KZhvPSNJcNvaatMrEcODT2yTfAcI0nvr4rC8Jo75FlGezzoO8+c/ItXvE3?=
 =?iso-8859-1?Q?Ris5b6O59HAbvH5lNiaODoYW36S3ZLiZnI1vdgR6OApkzi8Gcue3ZUHoKO?=
 =?iso-8859-1?Q?HGC2F0YinWLPTbPhq2cfKnlanQFqG3Q6fgkWrZsMY8pMV7sSNwhneSKocP?=
 =?iso-8859-1?Q?vTQXFrOBqPn5s+WOj1ugJXZoqNbYpCPq7QlYTShYeImLQN/9w/NtD7pCHa?=
 =?iso-8859-1?Q?XmCiqPYMlRhbYRlsJvl4zqdZEBSeypr7LsSg4NkiWrQTwdgR3kaDWarbJi?=
 =?iso-8859-1?Q?h0SS1DDXH33tbYWDuqfebYWSn7s2lZktoreHuAsGKlWdNRrJ6wpvWhaHy5?=
 =?iso-8859-1?Q?N9FiIkdps5BcTvboUCc/M3+RJtSaIuHYHcvUFaVJ/8y67Y+P1jkC3ZcUeD?=
 =?iso-8859-1?Q?GsSf3culN1mt2O/CuianDWVmw5nIpad5j4FxJNzzZTxKoKqLiEWwOh0U69?=
 =?iso-8859-1?Q?qGlUjHn3RngvLNw4rII4i5CQpM5P//1D5qJixTGAx41ld2UsgLdzi4fvnf?=
 =?iso-8859-1?Q?2DLDMPZTwuyra2zKll1RNgB4LZjcFXDcgP3EfLDA6C9Qsbv0yOsvJ3mUS9?=
 =?iso-8859-1?Q?xcnOewh6szA322/34s8mRJgOM5/PkLTG/6GM31ivbtzDQng9clV8CW1dL7?=
 =?iso-8859-1?Q?I2aN93M5y3EWqYOuJqM3PsKIVYeqCOdL32TaY76fwHTEEgN6ncd4+LExjV?=
 =?iso-8859-1?Q?r5ehhPCpAqIuT2Js4WwP3sOgqGh8r17LpXY2Uy7rG5rNN9vU5nQu?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b134f74e-d0b9-44cd-2321-08da3a436995
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 May 2022 09:30:43.4791 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4w7CiJTQgmXEXiKA06jwVjZWn+lYT7y7WqRKGUswL/f26dPAdtCVcfdhjD4wRzijiTO/ovpXBDW7hJ9D9y0sT4zyCJx5yRMjcjsULPsGkxE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB4394
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220520_023048_789994_B74B720F 
X-CRM114-Status: GOOD (  18.30  )
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

On 20/05/2022 08:27, Javier Gonz=E1lez wrote:=0A=
> So you are suggesting adding support for !PO2 in the block layer and=0A=
> then a dm to present the device as a PO2 to the FS? This at least=0A=
> addresses the hole issue for raw zoned block devices, so it can be a=0A=
> first step.=0A=
> =0A=
> This said, it seems to me that the changes to the FS are not being a=0A=
> real issue. In fact, we are exposing some bugs while we generalize the=0A=
> zone size support.=0A=
> =0A=
> Could you point out what the challenges in btrfs are in the current=0A=
> patches, that it makes sense to add an extra dm layer?=0A=
=0A=
I personally don't like the padding we need to do for the super block.=0A=
=0A=
As I've pointed out to Pankaj already, I don't think it is 100% powerfail=
=0A=
safe as of now. It could probably be made, but that would also involve=0A=
changing non-zoned btrfs code which we try to avoid as much as we can.=0A=
=0A=
As Damien already said, we still have issues with the general zoned =0A=
support in btrfs, just have a look at the list of open issues [1] we=0A=
have. =0A=
=0A=
[1] https://github.com/naota/linux/issues/=0A=

