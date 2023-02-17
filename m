Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89D02C636D6
	for <linux-nvme@archiver.kernel.org>; Fri, 17 Feb 2023 16:19:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Hj5AAQhbJ3PW1LQ5W2daQP5NpfItZx+uWqVInHYeAgs=; b=sakYTUkPLg+72b9fv2UhxWDPhi
	O0mh6kgNGLvUbJ6wi7KATAL9Q3v8KpVC6LxBZ1cpcFey9e7ZtrWgMZ0PbPMIm7ChwycoGEab0k9ob
	buMjd5LG5prKjJLgTN7qvJUoJ2yHom4Kc1MAvgOutwq6b4XQrOLleQZEIbg8RgF4TsNQzKNgs5/Qy
	k9s1n0EWz7mGy2A8pbVq7cjh6pIDpBZfmJs9AT108rEJ9CCLf9Al3ARFGFgMVcUrxx4C+BmqVdTiL
	Ip+KnFWjFISux1pxv5Ytc4kYU15IZHL23BpqHtBfRzWYJTh3fsYanPX5fIav3CnoDahclZb6t4kCO
	phe5TjFg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pT3Si-00F1Lx-AD; Fri, 17 Feb 2023 16:19:52 +0000
Received: from mail-eastus2azlp170110002.outbound.protection.outlook.com ([2a01:111:f403:c110::2] helo=BN6PR00CU002-vft-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pT3Sg-00F1Ko-Ag
	for linux-nvme@lists.infradead.org; Fri, 17 Feb 2023 16:19:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cm/swbrV5qgUKHyyGb+EuyFV1TK+DDrlQFgz8Qx2Y/yl7QeDcbar+c72LXkGcGq6YgTSRqN2QTc7ROnIfkPg0LIkKBd5RNIn0sPOT979lMw8TYMfATQk2Z4VW0reY0ZokOnChKfx07FAdKjTHfjypT+EAwIQTfpYXm29slQ8f/uaoC0L3qWLUXtzGyJ43QanzuMFeYm/hnPdBm7zkUNw0yriRC0yWaPgciX1Jn1/AJRBZJLVrb6wUZxxspzK3eCpBAmzxUBISwBicWvxxH7tOjTpDryp7WfoG30k2q6FWEEhb2E/fgzNjrXF8Fd6qW/pyYDzC8Pn+uFxI2/Hw3ZCrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hj5AAQhbJ3PW1LQ5W2daQP5NpfItZx+uWqVInHYeAgs=;
 b=FKq/MiLr14c5ACZ8ud1ZQjoB35VadrF5eZrlKfOzMiSnsJX3wko9BMIEFC3++hSGMFcCKvpgvOztc3e13H0vD50uDGK/Bz5HbcuCKLs/djPCC4ZAd+lxhaxJ07tS6e5T6T4G0ImsR0141jmw1Nw7Y5dwArQ/CK1aP+nd1LQLpQ/P6vLOBP4fCZa0DiGs796oP8gijpOMmkDKoblhlKNsh1A4zHryQoU6KdPOSqjy+AU8eIIF00Vb6k41PUOWfDuZSfIv13KctJXccgNamphedt+kdJrxtP+eeSEcWeAg8ayUCVW9e4xAPzo8E+b3c8FZTZ3PEs52JUc63R3qvqLbbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
Received: from BYAPR21MB1688.namprd21.prod.outlook.com (2603:10b6:a02:bf::26)
 by CD1PPF18E09A17F.namprd21.prod.outlook.com (2603:10b6:340:1:0:2:0:7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.1; Fri, 17 Feb
 2023 16:05:22 +0000
Received: from BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::629a:b75a:482e:2d4a]) by BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::629a:b75a:482e:2d4a%7]) with mapi id 15.20.6134.012; Fri, 17 Feb 2023
 16:05:14 +0000
From: "Michael Kelley (LINUX)" <mikelley@microsoft.com>
To: Daniel Gomez <dagmcr@gmail.com>, Keith Busch <kbusch@kernel.org>
CC: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>, Gerd Bayer <gbayer@linux.ibm.com>,
	"asahi@lists.linux.dev" <asahi@lists.linux.dev>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: RE: max_hw_sectors error caused by recent NVMe driver commit
Thread-Topic: max_hw_sectors error caused by recent NVMe driver commit
Thread-Index: Adk91saIeniTqD2RReK/0l1vmobdkgAJdtIAAHJbWFAAAY76gADB2tSAAAUpPfA=
Date: Fri, 17 Feb 2023 16:05:14 +0000
Message-ID:  <BYAPR21MB16887CE0FC5AFD717C741524D7A19@BYAPR21MB1688.namprd21.prod.outlook.com>
References:  <BYAPR21MB1688B4BBFCCCD01C016A62D4D7DF9@BYAPR21MB1688.namprd21.prod.outlook.com>
 <CAPsT6hnbAA_uCiVjST8VaPgb6TyfBq9nO2S7OPqJX3=YhzBD9g@mail.gmail.com>
 <BYAPR21MB16882541DC2DA7AB91E58A03D7DD9@BYAPR21MB1688.namprd21.prod.outlook.com>
 <Y+psCbPTfF9JkW2c@kbusch-mbp>
 <CAPsT6hkYqg2N6_Xf5aL2ijydTJfPYemUVKPZFGgdAik=DwTygQ@mail.gmail.com>
In-Reply-To:  <CAPsT6hkYqg2N6_Xf5aL2ijydTJfPYemUVKPZFGgdAik=DwTygQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels:  MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=1d8a1559-b4dc-45d3-8645-bdeb2ed7cc86;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-02-17T15:56:11Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR21MB1688:EE_|CD1PPF18E09A17F:EE_
x-ms-office365-filtering-correlation-id: 9fff4f26-8b2c-42b1-8720-08db1100c179
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  MhoahWXTf710tL7LldaPf/QgGNs0y5j/umUCM02RFpE6l6pX8/iLkT96GCTyPrRcxPMVjddolOa9hxX3KKx6u1bRqsGqD1wUo8ZFvVCDW9kM53RyfInC1qWDKzdclGJXL8A4b2xd4bsJIqmU8DLBPpahlb9a8+LUy805IMDxbWcEb4FXRe7A7Lom/wNzEbrgiHQd7GVVZGqz62RAp4BUuPceucmXfFlzOWsdPSi/d3rKIR+o8gReGmT8QepM1201INXN79J3J9VIq2/7lYyVohrX2ej/b2toCRIiLmVOvZLDtZyDiFXIev1U39phk5d3r9Grcne6yGyY8w21DImQ9/oSsH7fVbP3B9SxPrsP2+jnSBbVHf9fPagcjbOXLNKfmMxEqZoCVk13V0fXesvhVjQIvKOzroWFTvVFFGw9srHLAmJ3iRDDI5my1JLAqwcj8Pez5IIDab6g3qCOA2N2yG5VyA81JGKzFmVeRmLbks2Z5jQq6uiSSDceF513TvKo7JIzhIbL5Nh/vFJMr2Gudp2xyn7KpBu3GEzja3YBTsWEjd64DycWxEE/mQlpWBtRpZAgK0Kk+hkbkpgpMiLkhP4N1Zg7DrKsBAqSkjbiEIMplX6I68b/jJg4dkYn8u5VMagzA5hODQf11ICze0ZRcvae1ohd9+ssedLwVDsCjGISt28cd145L4IafAMkg1VlWbHHPCa9Y4kcEG0tTlMOQCbZzkdoZgpxauHshu3UIKV7830GLfS3DQvUl7N+PNrY
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR21MB1688.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(346002)(376002)(396003)(136003)(366004)(451199018)(38070700005)(316002)(6506007)(38100700002)(8936002)(110136005)(122000001)(54906003)(86362001)(4326008)(82950400001)(33656002)(55016003)(8676002)(41300700001)(82960400001)(9686003)(2906002)(8990500004)(64756008)(186003)(71200400001)(76116006)(478600001)(7696005)(52536014)(66476007)(66946007)(66556008)(66899018)(66446008)(5660300002)(10290500003)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?us-ascii?Q?zj3n9/6+9xWa6amPKL1mZBQEQ/iDJeWCVxyOHqYmBDe4yJQ920U6O+7xOBsz?=
 =?us-ascii?Q?5L4uP9UYh/llzSfkudEUIDE3vhbGOFwoOcecTy33BlWNOvrOVfHOGM3f6lsA?=
 =?us-ascii?Q?dfQwKeMxTSUmKiaeUxvxlqrPsLOwFLCN3ANj2Wp/792ByGnmcSAvvTLvxHHj?=
 =?us-ascii?Q?VsRxBixYRvkjKVNm/PPbAMNW/LIecFwoNvkeTZOPTfFuFQVoO+yMCAM/ANEP?=
 =?us-ascii?Q?J7TbBquk+LOcZzkZ8ShKjZ+eHt8cTn3zPtYG9K423CGBlDjPHRbPB/ZTJ1/w?=
 =?us-ascii?Q?UKJ9VKcIa+8bY6ntEK3X6nRupJKoYzbVZ/KAB3ozYnmOsOE40TgUMVuECRTK?=
 =?us-ascii?Q?HDkpgUgjSnMtucGjqXZOFDYmKZBGTV19deLVl5ywVWIB7zPttt1n4A0MpHfj?=
 =?us-ascii?Q?uOSEn9LxLD64COIzf1F0uIdVg5f50I1FkAjAGzRtUcwAiPW6vHEOG+RmJXxh?=
 =?us-ascii?Q?ronn5wy9f6kXGtaYstKz5qmHSTkuGejBP7HIdAJHdz7VV4fvcEJe85arfM4o?=
 =?us-ascii?Q?LYgEllrldhl/0lXG3kLcW8DESOqosOshMeb+LPe6Mgt+B5C3zjLUQ/1u/LVM?=
 =?us-ascii?Q?dGGdME+l6DOef8pyzPZRcoP6K9pEfVXS1bzDQ+u0UrwnnA/xLYNdXXuyzMbZ?=
 =?us-ascii?Q?mymn6j+RX2a6Op1EaiakX7zcscQaWsFTIJnxkWhVH/w0jJkN5hwy8KEtQUvp?=
 =?us-ascii?Q?8MZH3PIG2tUnffZ95FADb2fBm/mGAD4NlxITZ1qlSE31fBKdohfgb0+vuOKw?=
 =?us-ascii?Q?Av+zzluSjsYPPRlYh3iAGlJesDsTuGEjr3gkMq1nS7gk6Cqc3QVbSw5hxdrn?=
 =?us-ascii?Q?P9NQ5xiYoAizHd1X7dlF/Ng1i97wGf9U6YsIL5KJEjuwWnSdW2lq7Y9aEJ4z?=
 =?us-ascii?Q?/Cj6XZ/PFrw2Q++qEBr9MInq5FRBm4iyyQvFOAvmtb9VxpK74e/YxNS6dasI?=
 =?us-ascii?Q?/3wcERjz2ykqFYMxbWj7ppYorbiYipUDYN4JDDY1aTrhVrbZpz7lM6wNEarr?=
 =?us-ascii?Q?ITgqvDc+cElinHJHLCrFo18BBGgDtEf0X+IuvNBO9aLqIn2QIIygvdEzlFfE?=
 =?us-ascii?Q?z/brrEIgWwNSfV2bBVUtc2kbgdO+5WGoge0tvrk5TXKPBqPoVrNOXfXVUA/V?=
 =?us-ascii?Q?7mElgtuMgjVBz3IVRyglG3Xb1cHrbCsbykaeIWBPGFQmKy+yFIR2C1w1veib?=
 =?us-ascii?Q?iObmZnzYbwiK9mdwYjptfpvMRqefGHVdUme6vDVhnvcVo2pJFcL4qh42OAvc?=
 =?us-ascii?Q?XKv/zaXGSQbQiGUESn+QnM+SbsFby0CE50GHAqwKhqypxnL06TsJPyPPsko+?=
 =?us-ascii?Q?DiPV8IigRCr7/Y4F44h1n8RTV/lsU7YpmAS1pf40Tetqh/XFvFIdYBKMjp30?=
 =?us-ascii?Q?ZXSeKJlXzgJWKASu+daog28I0FsDsIoWX11huArwJhL3gB6FB4izRRv1dj+B?=
 =?us-ascii?Q?xBVz8aSN0lnVXIBq9mqZqIOcXSgUTNKYbMHkoNZkUz62981iBiscPwjWdloV?=
 =?us-ascii?Q?bdbH+REbIe9Nq7c/oS0nm65I+1pw1VHoeA0LoxDaCptwoPjNuo1acdUx6sWy?=
 =?us-ascii?Q?SfqLqyQyBjL+6hCcpEWHhMl35HLkB8uyi3gRjIobwQsI/rPOYVigTFSw+9FI?=
 =?us-ascii?Q?IfczDA8rs2eZKBvoo/PHpG3Z+0+Tjxb0jpVseJV/mVQ9pVRsWFiqynEmlDtF?=
 =?us-ascii?Q?9119qQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR21MB1688.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fff4f26-8b2c-42b1-8720-08db1100c179
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Feb 2023 16:05:14.6384
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tBttyfT5Ps5lYff8C+t0qlcjIbP4Q9ny0MH8yMEV+BnE9On3QCK8XDCz/ypDrXuYlVQI0N6zROXcMVy66JQCw8KKJ6qr6GGmCLHXPBe/8kc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CD1PPF18E09A17F
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230217_081950_378424_57330646 
X-CRM114-Status: GOOD (  22.31  )
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

From: Daniel Gomez <dagmcr@gmail.com> Sent: Friday, February 17, 2023 5:28 =
AM
>=20
> >> value to be set.  In your example, I would guess the value of 512 Kbyt=
es came
> >> from querying the NVMe device for its max transfer size. Ideally, to s=
upport
> >> 512 Kbyte transfers, you would want 129 segments (to allow for startin=
g in
> >> the middle of a page as describe above).  But the value of max_segment=
s
> >> is limited by the NVME driver itself using the value of NVME_MAX_SEGS
> >> defined in drivers/nvme/host/pci.c.  The value of 127 is chosen to mak=
e
> >> sure that the data structure containing the scatterlist fits in a sing=
le page.
>=20
> >
> > Should be 128 possible segements now in -next, but yeah, 129 would be i=
deal.
>=20
> Quoting Michael,
>=20
> >> the middle of a page as describe above).  But the value of max_segment=
s
> >> is limited by the NVME driver itself using the value of NVME_MAX_SEGS
> >> defined in drivers/nvme/host/pci.c.  The value of 127 is chosen to mak=
e
> >> sure that the data structure containing the scatterlist fits in a sing=
le page.
>=20
> Yes, I can see that. I guess the 129 needs to be reduced to 127 (or
> after Keith optimization patch to 128) but not when the device is
> limited to a lower max_segments value because they fit anyway in a
> single page?

Yes, that's correct.   But "the device is limited to a lower max_segments
value" isn't really because max_segments is limited.  The limit is on
max_hw_sectors_kb derived from the NVMe controller MDTS value,
as you have shown in your table below.  Then the max_segments value
is derived from max_hw_sectors_kb.  For example, if max_hw_sectors_kb
is 128 Kbytes, you can never need more than 33 segments.  Each segment
can describe 4 Kbytes (a page), so with 128 Kbytes you get 32 segments.
Then add 1 segment to handle the case where the memory buffer doesn't
start on a page boundary, and you get 33.   I'm making a subtle distinction
here between "max_segments is limited" and "you can't need more than
XX segments for a given max_hw_sectors_kb value".

Michael

>=20
> Following the kernel code, I can see the max_hw_sectors_kb is
> calculated using max_hw_sectors =3D 2 ^ (MDTS + page_shift - 9),
> max_hw_sectors_kb is just max_hw_sectors >> 1, and max_segments is 2 ^
> (MDTS) + 1 (simplified). Using QEMU (NVMe emulation) to be able to
> change the MDTS, I get the following:
>=20
>   MDTS   max_hw_sectors   max_hw_sectors_kb   max_segments
>  ------ ---------------- ------------------- --------------
>   0      1024             512                 127
>   1      16               8                   3
>   2      32               16                  5
>   3      64               32                  9
>   4      128              64                  17
>   5      256              128                 33
>   6      512              256                 65
>   7      1024             512                 127
>=20
> >
> > The limit confuses many because sometimes user space can sometimes get =
512kib
> > IO to work and other times the same program fails, and all because of p=
hysical
> > memory continuity that user space isn't always aware of. A sure-fire wa=
y to
> > never hit that limit is to allocate hugepages.

