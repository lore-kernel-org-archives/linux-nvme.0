Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C5BACCD199
	for <linux-nvme@archiver.kernel.org>; Mon, 20 Oct 2025 08:51:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gea3YWo4Oh3PCzKEi3fjIZjAFn8U4SUbT9A5SGhDEVk=; b=4gQQZYM4ITghnkFyAliJSdehfb
	/CKJQbruQwf/IcQ2iCOLiwhxKQnDuNiw6JWaOH2aGJN12+reBiYy50DufOmt56OC+rud7HCrhe4rZ
	cay0cAZYeQJH/c3YTvbjDUtu/KLsyuiqrwZAsFCxEtOW3RrSjTCgvbKV/pG/swUJnbOTuYoFZHYwX
	wyZlHrNUe2B8f/85Apr6SpnQrGmVMzWDVgXUuIFOpR4w//a6UhGDxXHbXHpeOqW67A1r7iIHx2c/Y
	LbuwJIZX6XSQFU46dl5bWXB6heV5vuGvWVrmZdKsjpwl1FvRchFAory7TxfmG8bqXQySxt0HUlnc1
	Iu0cfUsA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vAlbX-0000000CSgn-2MdU;
	Mon, 20 Oct 2025 08:50:59 +0000
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vAlbU-0000000CSg6-47u5
	for linux-nvme@lists.infradead.org;
	Mon, 20 Oct 2025 08:50:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1760950256; x=1792486256;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=KQBkYwqRneW54f+XdHug1UG5S4mNQ7RQFm0jC0pRvj4=;
  b=ckncEHb2XPONGAfpC/slPbc/pXupl+C1nqJIdUrqeJ2LC3wNOZ7MY5zk
   ZlXpfLhSku8H5muR8IeeZTsIq/RdjqOYHF1Al8rD1A5nhVVV48yCsRj7S
   XN9H+hgC4Whubh6w3Yy7ZwcXTooNN39PgZQbQj+QQ36+tVeZ+HEBdq48a
   bz2J8sv78J+jZ5vCsTsodx9djytZRgDhWpBPn1QLSzbKm8QZW5ktQGplT
   q1Kjq46kUBXZ0FbRtezmDVlgDJ7F/hprWkCc5OgtsgyLNHsS/g47khaiq
   Xz8Zq+IPQ0h0hD7Dm5+kGVEWLweXAV+c+h6Cp0fJAsCQNFVap2IMetBnS
   Q==;
X-CSE-ConnectionGUID: C0a8T6cjQj6at1LSGPky/w==
X-CSE-MsgGUID: LQy2H500TaGA0xWFGWV9zw==
X-IronPort-AV: E=Sophos;i="6.19,242,1754928000"; 
   d="scan'208";a="133560426"
Received: from mail-westus3azon11010065.outbound.protection.outlook.com (HELO PH7PR06CU001.outbound.protection.outlook.com) ([52.101.201.65])
  by ob1.hgst.iphmx.com with ESMTP; 20 Oct 2025 16:50:54 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UoA5q2yHu2lwTyxM73wO+bB2YqqX4cBmQkx8Puh8L/NaF6ut+Tl2V3JJeaSLwIOXy17XzdEnTEuSCnLoN4ETD/2AXEJWx2voztr7RXho9PAR2mF1w/64ywH+90iyynMryuTeX+/BxsltPFCq4DDZSKmHdzr5WN4ztA+NpfSVCKTWJIOPGVFmgJqBpj9/qoRFwP5dCZXe2geMbMGBhvCDqD5nnIEeclXzPrkn4rzWI4MoqM4i2QE+0DRnHLRK1eqt8/g3YAWssmR+HT+L5YRbfsHZq9Z/vjsTGceAhdlWzuekr7R1fSZmcWfQnKKlKMgWc5sWHbjeu5ng8TrxDcQ2rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gea3YWo4Oh3PCzKEi3fjIZjAFn8U4SUbT9A5SGhDEVk=;
 b=nk9ADzExHE/iGpD1IOImUPKq0kYWsyqe7TuX1uyCxykduQNEIW5shFrh3h2ODrLmMKoSx3luWQcG+7/V11hCbgw2nrajlgvOyG5mVcr5vZOjAAyPHI/M0xa0IghFAhEhOBo8XDKvo0Z5vgteNK3BJBonBLWuQdMPdC/GHmPTg1X6uKyMd8dIoHFU4vqPG+LQhwg1pMzlh2a0rP+fcHZEYNGqZ7QwNh0uRStRwFQonofBmPDSedEt4PGjUbUK/9py5owHy/mKPrX7vKSoCRaY6TGeJ0DDctNIKx3UD47e9p04a3RfSDWoPlsmB2nKvHKz4y56QV2i0qscr+HF21B7Cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gea3YWo4Oh3PCzKEi3fjIZjAFn8U4SUbT9A5SGhDEVk=;
 b=kY4PsiORKFFN8Hwyimm04Ymdmm2Y86J046VaqPD+rWa/hJN2zDEwxeIRNa+3dGeOHEahRPd14Mg/UxNdAdBKWLp64sxzjDTe1hqOyrE0TfK3JoRyqTyTxgbZAyuFpIfQeqOovIjyFttVkZ/VSKJmbH3YD6kuFiO0FlFsZF4gOc0=
Received: from SN7PR04MB8532.namprd04.prod.outlook.com (2603:10b6:806:350::6)
 by SA1PR04MB8468.namprd04.prod.outlook.com (2603:10b6:806:33d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.14; Mon, 20 Oct
 2025 08:50:52 +0000
Received: from SN7PR04MB8532.namprd04.prod.outlook.com
 ([fe80::4e14:94e7:a9b3:a4d4]) by SN7PR04MB8532.namprd04.prod.outlook.com
 ([fe80::4e14:94e7:a9b3:a4d4%7]) with mapi id 15.20.9228.010; Mon, 20 Oct 2025
 08:50:52 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Martin George <martinus.gpy@gmail.com>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, hch
	<hch@lst.de>, "kbusch@kernel.org" <kbusch@kernel.org>, "sagi@grimberg.me"
	<sagi@grimberg.me>, "hare@kernel.org" <hare@kernel.org>, Martin George
	<marting@netapp.com>, Prashanth Adurthi <prashana@netapp.com>
Subject: Re: [PATCH v2] nvme-auth: update sc_c in host response
Thread-Topic: [PATCH v2] nvme-auth: update sc_c in host response
Thread-Index: AQHcQZ6jTlHuyp98EU20Zw2shuKgDg==
Date: Mon, 20 Oct 2025 08:50:51 +0000
Message-ID: <6xoxbezgcnv4bfaevi3pdpesfelia3epxiddk47azho7y5mnhr@ykmlqgnrbl3w>
References: <20250908172457.5512-1-marting@netapp.com>
In-Reply-To: <20250908172457.5512-1-marting@netapp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR04MB8532:EE_|SA1PR04MB8468:EE_
x-ms-office365-filtering-correlation-id: 05721b87-467d-4fd4-196a-08de0fb5c626
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|19092799006|376014|38070700021;
x-microsoft-antispam-message-info: =?us-ascii?Q?/bkncutE5uTrNLVGNKJkgmTxKn3Eeoz6tXugvDoKUg70kQ/c1UdkpTWL7ReX?=
 =?us-ascii?Q?/WQxQm8rZ9UonhuKu3c1kcHJKQ+DtdvGwMJ6P7WtuszAsf2ureQ0FpipnxnD?=
 =?us-ascii?Q?PNlB9vB8QPyDSaqftFH3M6dKP4jiHKPPEjcG/0xwDNn+twbWgYIMXGTdOVtE?=
 =?us-ascii?Q?DlYLz6DNzjFIJiuJidNjlCcRlCz8E7Tr3xcrYzzCsdEsYAwtEjoBbZ7/rOd3?=
 =?us-ascii?Q?fSLbot5QLZ7fTpHckPbMJaGTa3yIy2i2mzvx9/AlBDn7a6Ns1clIFnEyV1KY?=
 =?us-ascii?Q?Vb0OFtmLnWc/GISmqhnJvQbguBe7DBFnLfJPplO/6W1WcfHotQN32IlaZXNw?=
 =?us-ascii?Q?BewHXTZSUh9lMeLep6UF9MRaSkpe0nICc9CHs1bKCrCQHE5NiBxnJTz2jNAw?=
 =?us-ascii?Q?uMb7+oKTw95YTayv7SFtB1PEiyKq1NW9jQjdNVVJpbyRmg6qHudipMoRT7k0?=
 =?us-ascii?Q?45YNPKylfsV68OkZuDWdLCNvwldBWg4r5gmuwevtCZS69qxreN4sQngrsi3x?=
 =?us-ascii?Q?+eTwSRh5ZWzDzmKi02qvuObA8TWHqszfr52SJLrODLhhfaWzS0nIcKRp/Cje?=
 =?us-ascii?Q?vxGVbPX5Nrv3UmlbVGXcyCwpO6yHzQxAqvXklvRed3NIL8snttp6PstxHOmk?=
 =?us-ascii?Q?+IaxlkolVV5tU4jeOP++rFP/vZCRo8s9ZPQmm54ULvOFTNR285V1xQL660TW?=
 =?us-ascii?Q?1oZGuB5NYtVluB42k0od66h5MClHWeO8ctPxF99rr6AQHjhiDw2f3qS1p5Ys?=
 =?us-ascii?Q?WLcfLKlm8cgj5j0sIxWcFsha1xm1MPEtonynQOytGnGJp7+RrPi23AEHThmC?=
 =?us-ascii?Q?a211KX/LRTQCQYJNDFr78R9os1EwU1+Zc4nW5YG0aSYZvOA5y0q9GEMHVgdi?=
 =?us-ascii?Q?bQ9N1w+5uv3r7c3fLQ12qSwZz8LZGdXuzPFf/IQ0QCE5fCmDF0Gn/YBM7LOR?=
 =?us-ascii?Q?cOKdPTQ5oj4o1WI4iLVGhC9psfY9hb4dfiJTyqPJe7/VOaEVNubE2WPPfNrm?=
 =?us-ascii?Q?ZsrJEnoqHtBSabmRAlaag9f1SNlRiZ3JxNQQRpghkIrUCc9A3Vh/SydFovWk?=
 =?us-ascii?Q?4c/THCT96tGbbqeZAoI+rUZXxCfdFAJ4LgKNJL2E4WyH45+mn0p31BchLbXg?=
 =?us-ascii?Q?y9I+dwzRwnnVUL/x13fjgzEuv/O0921jR07rdkOrcar0PcV2rSy1CwUtw4Tk?=
 =?us-ascii?Q?aRGISyT8g8vuBmRveIMb02qDLXHEjwYoiPrcvsnl2kOi+BJipOzwnpWOMj+T?=
 =?us-ascii?Q?P90jTjpj3iQzPaBb8qvbMTZ75/W2OK5Opd7TyBGCNFyxFlhCOglh7FWclPcz?=
 =?us-ascii?Q?pYaXwgetC05HWQ0Vot4Y5RWEt0AhU8UThBxlJ/u86xb+N3/75sxr/RSmT2iq?=
 =?us-ascii?Q?3f3UWnIZRSqdx2TpK9EqyrxbWwSRVoh/FaXXuHKozY6Xyt0hD00cKO+JfJFA?=
 =?us-ascii?Q?ge7CivrQEEqtP5aOEQzhZst4HdyvrVe3a9BKfvs30rHO1BGUuljCCsRj4KAj?=
 =?us-ascii?Q?XzXaTqNS9ZDXTYiKP587DAFP+BUFoGRZs75y?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR04MB8532.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(19092799006)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?n6KLuWspq/NlbnqM3M/gok1pUPe335/8Pe57/m6h1K+jAhvq4PWNBUqurEWm?=
 =?us-ascii?Q?zuZOi95/fFgRiXfKRBMMFRkYCTm2Qfuu9MoQxXjXgitblcnK9cOmzJrHfglj?=
 =?us-ascii?Q?rXMbwFPN72RVhKl5GYvPOcTshECnAsKA6fMBGjDbDKg+XDMJ3DQycwbv6At1?=
 =?us-ascii?Q?OKhbfoAT8i3SXNzuPsucX8aoG6wKuh+18FxT4fOpXRDJpvXyOVHYuqcypUs4?=
 =?us-ascii?Q?hKMtJLBAjJxQQOyRPePV3sqzrFKcxhYztTVcMCWWH3aGx/i6NmFyscxOlU3h?=
 =?us-ascii?Q?KJxmDxC3hkpU4oIhzkN+7IYK9ext9tcLyIPQY7SuIPJLaC4SOaY5PVgAfgNU?=
 =?us-ascii?Q?dc7sUCdsEZQ2G3Oeop8AAcS04gmy4IARQtIuSudQliS4ZvcP2sjYg4PyeNGE?=
 =?us-ascii?Q?maPdlGQRQkk6mDc+2nluAYwe+WtREXRPZ8tsq/zWUxlVFBXFYRwUBH6lf02E?=
 =?us-ascii?Q?pdykbafx3IYOkWhQzIAhoaUpOKA+81iKbhCeBtQfZ8uUVRlEbnomj1jVQb2D?=
 =?us-ascii?Q?7qEB5dw/HT8cbkr372P5vyZat5vZawTuGP4GeMjp6lU/jaGlhKkskfCxTDIf?=
 =?us-ascii?Q?DPwal9sqMwoR5bTtggmy6DvN6xD2Tqcd51TpYjunwPxwMRJhHA1qZmTPANHQ?=
 =?us-ascii?Q?Thmyhpn0pmWYpVlEXjLmeznvxsPB4b2iBmAGCYLqYcN7Qf0l3+F13LQhZkSq?=
 =?us-ascii?Q?enRNVB3Cck+7c2TSHwxOCLMxrbhwlAgYyDlqMBhTh01w4iGs+FUGgPFG3r6U?=
 =?us-ascii?Q?WiJQWB/GsZiSynncm5FWNPxAJGuWLw3FyMXlaNI+1eGtiYesWQnrSHyb6EXG?=
 =?us-ascii?Q?4WaAVaOkdy1tXsE11eZW1b38AejQgv2r2tgITltqHowqtVdu4wSbZLrzScig?=
 =?us-ascii?Q?AKZtZdAFC1ojhtSiSM4cT495ysLsGohUWVJekCFGKeq6o2ybKb4gUgSARAH9?=
 =?us-ascii?Q?3tHlrT3DXtZ5XW4ZH1kAxRjvSMheeSnSdbpULqwyZLRpGqYlyXVAPEQdkTYj?=
 =?us-ascii?Q?N4PDHkzMoeD9bTWCmWCrCC3YO4jZd13V8pArt/R1PmZ+gjqPVNsGYkJK/BZN?=
 =?us-ascii?Q?oI8nC3dSwiCFzbGjegQqmgnujbaETxPIM2HgPRmpKF+DIpz60V3E1AWqK3NO?=
 =?us-ascii?Q?cVn4rCK9F8+adtUU2b+eguP3PZPUrFP8kKmOiklRQbNfeFvyW1NbWsCsgqVU?=
 =?us-ascii?Q?flfYS8La+7NYdbEQA0PS4Q5NB3SjfDONy4/M4wCv3p8MXiWlyA0YwPyEQtGA?=
 =?us-ascii?Q?pKh/Mtd61LYLaQ7NwfXt6KbS3VTu2JDqjrCveYa93bM/mcZFUhpqqozfyT5v?=
 =?us-ascii?Q?Fik8iumso4j2AFt2D4ZiFrL4wyXbC3MEUPYaxqoS8ZErVkkZsT+MVWnfWdLE?=
 =?us-ascii?Q?zQiIvH3pajgfGM8BHNjfN6+VIQw+oo3kygVyrCq45cCcCjm+LlxCNtguC2Si?=
 =?us-ascii?Q?Ae6zoE1LvWj8egJRZIic79PLe8+GmAViy1eDdD4Mi/hiKbLugGidZJMdfhVU?=
 =?us-ascii?Q?YMVgmDiwCH99KZCEqMHevgj+O0X41xJJ/nuKpLxgVFNKMwKZQPnLUptBe5LG?=
 =?us-ascii?Q?WsbhcrRA71fq7L3BDrWRXStPBY1ySU3GwlfrkDikspesm4vpT31rxwXDdbMN?=
 =?us-ascii?Q?KsIslkOGo/rIIRTmcxZfPjE=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3940105255A8BF4489998EB8C2DF3162@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: GF8/QhBqrlEGFVWXxQUAKtBBHJ73mgl/aTlzOsNx5k8faW7t3MREK8pFwBQiwfpG2dIvytMx5omBejQgPV+R30tfcSuN4Xs22s/lGwJz0qh6bwB9rzEDisTW/29n/H5RSHbrINptD/QcuGMX4i7/gNDdJJbcX0Wq2O3BD0kSK4sAla77DIj7asan0lq3AzpJEK/3tRGkhGTC0RhBv+DXTPaq3c+B6FnNQHIpIRB3cbZXxBEndHh3SlEeL6+gdrjF/sKzuT7w3rVGnRKromGCqApcbEAqB9tVFvz6tE127ItGpiveuZvu0trz5BbPZgtOcpDsNKQiKLVgaGh+KcrrMZYl4k3b9/Z5rfFKKcwuGlcR3EZjRiz8f0yOTjn8WgYIoqBNXShz5J045CKoUZJiLcDLawHDUYfKBJL7f/quEBSFSOJZk8LHcF119gVZf6hhMZHzSlXg6oNWRQgNE12eEyxI+Q3mU2s55gEoAe/lKip9JYXjoO1wgt6nCBuwmqAhOr9n0lvH3QlvxpQMMC5xRfAnj7Fyy9GdW6Sec8dyIxMzOHS34wjB1CZvMXkGd83ta3Z2Wm/lKsdrQ3CPJsFxrU2xedpUwHpH7bGBKC1qrM2Wtg5QnK8d59PaZ8Pay9dI
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR04MB8532.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05721b87-467d-4fd4-196a-08de0fb5c626
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Oct 2025 08:50:52.0952
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /kQkpfXuszKgLrVB5kuoeKtTMlv/wg1Wz+RrSWDHp1qgmxJ0pi5KywxjkSLAxE1K6CXfhPwxNAEQdGl7230sl/RI8J9F96HzrQQ+pskXli4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR04MB8468
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251020_015057_042744_46147A6E 
X-CRM114-Status: GOOD (  16.17  )
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

On Sep 08, 2025 / 22:54, Martin George wrote:
> The sc_c field is currently not updated in the host response to the
> controller challenge leading to failures while attempting secure
> channel concatenation. Fix this by adding a new sc_c variable to the
> dhchap queue context structure which is appropriately set during
> negotiate and then used in the host response.
>=20
> Fixes: e88a7595b57f ("nvme-tcp: request secure channel concatenation")
> Signed-off-by: Martin George <marting@netapp.com>
> Signed-off-by: Prashanth Adurthi <prashana@netapp.com>
> ---
> Changes in v2: set *buf to sc_c as suggested by Hannes

I ran blktests with v6.18-rc2 kernel, and found the test case nvme/063 show=
s a
new failure symptom. I bisected and found this patch in the v6.18-rc2 tag
triggers the failrue. Actions for fix will be appreciated. FYI, I attach th=
e
blktests console output [1] and the kernel messages [2].

  To be precise, nvme/063 fails even without this patch as I reported [3]. =
But
  that failure was due to lockdep WARN. This patch introduced a new failure
  symptom. I think both the two failure symptoms should be fixed.


[1] blktests run console output

# NVMET_TRTYPES=3Dtcp ./check nvme/063
nvme/063 (tr=3Dtcp) (Create authenticated TCP connections with secure conca=
tenation)
    runtime  2.922s  ...
WARNING: Test did not clean up port: 0
WARNING: Test did not clean up subsystem: blktests-subsystem-1
rmdir: failed to remove '/sys/kernel/config/nvmet//subsystems/blktests-subs=
ystem-1': Directory not empty
WARNING: Test did not clean up host: nqn.2014-08.org.nvmexpress:uuid:0f01fb=
42-9f7f-4856-b0b3-51e60b8de349
nvme/063 (tr=3Dtcp) (Create authenticated TCP connections with secure conca=
tenation) [failed]01fb42-9f7f-48    runtime  2.922s  ...  3.908s resource b=
usy
    --- tests/nvme/063.out      2025-08-26 21:28:52.805848674 +0900
    +++ /home/shin/Blktests/blktests/results/nodev_tr_tcp/nvme/063.out.bad =
     2025-10-20 17:42:12.097662643 +0900
    @@ -1,7 +1,3 @@
     Running nvme/063
     Test secure concatenation with SHA256
    -Reset controller
    -disconnected 1 controller(s)
    -Test secure concatenation with SHA384
    -disconnected 1 controller(s)
    -Test complete
    ...
    (Run 'diff -u tests/nvme/063.out /home/shin/Blktests/blktests/results/n=
odev_tr_tcp/nvme/063.out.bad' to see the entire diff)
WARNING: Test did not clean up subsystem: blktests-subsystem-1
rmdir: failed to remove '/sys/kernel/config/nvmet//subsystems/blktests-subs=
ystem-1': Directory not empty
WARNING: Test did not clean up host: nqn.2014-08.org.nvmexpress:uuid:0f01fb=
42-9f7f-4856-b0b3-51e60b8de349
rmdir: failed to remove '/sys/kernel/config/nvmet//hosts/nqn.2014-08.org.nv=
mexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349': Device or resource bus=
y


[2] kernel message log

[   59.957999] [    T950] run blktests nvme/063 at 2025-10-20 17:42:08
[   60.146451] [   T1059] nvmet: adding nsid 1 to subsystem blktests-subsys=
tem-1
[   60.168784] [   T1060] nvmet: Allow non-TLS connections while TLS1.3 is =
enabled
[   60.179760] [   T1063] nvmet_tcp: enabling port 0 (127.0.0.1:4420)
[   60.321134] [     T80] nvmet: Created nvm controller 1 for subsystem blk=
tests-subsystem-1 for NQN nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-485=
6-b0b3-51e60b8de349 with DH-HMAC-CHAP.
[   60.329310] [     T89] nvmet: ctrl 1 qid 0 host response mismatch
[   60.329914] [     T89] nvmet: ctrl 1 qid 0 failure1 (1)
[   60.330650] [     T82] nvmet: ctrl 1 fatal error occurred!
[   60.331254] [   T1073] nvme nvme5: qid 0: authentication failed, error -=
129
[   60.333179] [   T1073] nvme nvme5: failed to connect queue: 0 ret=3D-129


[3] https://lore.kernel.org/linux-nvme/ynmi72x5wt5ooljjafebhcarit3pvu6axksl=
qenikb2p5txe57@ldytqa2t4i2x/T/#u=

