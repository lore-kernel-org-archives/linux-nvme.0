Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD61F10F6FBF
	for <linux-nvme@archiver.kernel.org>; Wed,  1 Apr 2026 16:27:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=iNZvqNGn6jhZ5iYQu9YNgyqExuHkEINFNf5vyS7Pj3g=; b=TKKHcW+QfY9IMAc/dEA3XPzgYO
	YQeZxnIxuPqxLzIlzCg47vHCZVZuQ7tXJwpfHwLmsWkKMlfhnX3nBOcNZ3822qfRGrSpTXJFqtFB4
	JY7S0avBKVAOHEtLinIPBM49ZzkB8u9lZzYlw4XJQhjnXdXZWPUkSLpvOOndFHvZNIOjhTe9nqeT1
	Yf8qgnhrnlRVCQiCk25ingdoz2iT/rYVer8RIHgfrZCFERDKwrpzxtYcFay6wtStNxFqFw8J32Gs3
	2Jt6I8k2v2hTtA9l3wADkJd3kKP2ZbgyTgJjR0v8E2XLTtLQxOJ9T9SmT1LSSS5KwRKDFzAf9olSr
	rLyaezcQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w7yPD-0000000FjH1-1klz;
	Wed, 01 Apr 2026 16:26:59 +0000
Received: from mx0a-002e3701.pphosted.com ([148.163.147.86])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w7yPB-0000000FjGR-1Kh7
	for linux-nvme@lists.infradead.org;
	Wed, 01 Apr 2026 16:26:58 +0000
Received: from pps.filterd (m0148663.ppops.net [127.0.0.1])
	by mx0a-002e3701.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 631F64wd1771780;
	Wed, 1 Apr 2026 16:26:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps0720; bh=iN
	ZvqNGn6jhZ5iYQu9YNgyqExuHkEINFNf5vyS7Pj3g=; b=lrWIBd3vUH7PLt2jy8
	4hMSzkgFgWYpNzpzW07C3ssZ2fZehx4zmVgZc0kyzJ5YfQms0rdkMxXpaU9cdSyx
	PSzDOKZ2AApoWcmEYMANlvo57wwLivYFVD1rxN1t0ZyT47Rd7x3sQtzC+GNg8B+I
	P+n+FQ0kcDY9wv3/hhcin3yOTDgIBOrfSpwFykjMoJuvAQKyiLPypf4qUnn+QgVW
	UZRtSoNJeWp2jxFyprM+2GfExgb+YDmPoegIcB+fb+duNTTKbJ+9zWh29ossnhfg
	rW91RbQ6YcNX/ob8IHbHcMdT0y3tHbx39pX4oQ+YHFSvG5NiQR2QBCCfJNEAZraL
	6CGQ==
Received: from p1lg14880.it.hpe.com (p1lg14880.it.hpe.com [16.230.97.201])
	by mx0a-002e3701.pphosted.com (PPS) with ESMTPS id 4d90gp5drt-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 01 Apr 2026 16:26:37 +0000 (GMT)
Received: from p1wg14925.americas.hpqcorp.net (unknown [10.119.18.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by p1lg14880.it.hpe.com (Postfix) with ESMTPS id AB66680171C;
	Wed,  1 Apr 2026 16:26:36 +0000 (UTC)
Received: from p1wg14927.americas.hpqcorp.net (10.119.18.117) by
 p1wg14925.americas.hpqcorp.net (10.119.18.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 1 Apr 2026 04:26:13 -1200
Received: from p1wg14925.americas.hpqcorp.net (10.119.18.114) by
 p1wg14927.americas.hpqcorp.net (10.119.18.117) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 1 Apr 2026 04:26:13 -1200
Received: from p1wg14919.americas.hpqcorp.net (16.230.19.122) by
 p1wg14925.americas.hpqcorp.net (10.119.18.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Wed, 1 Apr 2026 04:26:13 -1200
Received: from CO1PR07CU001.outbound.protection.outlook.com (192.58.206.35) by
 edge.it.hpe.com (16.230.19.122) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 1 Apr
 2026 04:26:12 -1200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M1rYFQecX16+0U/8jUCXxakNmwtLnLuGxj7l563jFFrNkLWo51xjrvjtO/NaJhGN80JbqtYS/IzKblq76B9StF/FStuicyQ45T/G7M/PF6KWWLBDm4iumfAJYWtaSMMA3plhvGCsmveEW8npkTYQlz+PRyNllpoh4PHSfMGuXPYzfkCjQsqKFLDdB+PBx5AlkYXP6xjCpFNMsAHj8DeABb855y68si1FQ+9m3WryDrM25hRxXBHjsfjWKOJMr1SFCWsh4SBEERWKX0HPj8/HCR0GioDFKc5dVx8oXGfHX2P4hNebzWtYGYMqcRgMXlT+E7vr+t9ag/e90Wcbbxg2bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iNZvqNGn6jhZ5iYQu9YNgyqExuHkEINFNf5vyS7Pj3g=;
 b=wzLSD28uaBbusH48B3woZYGkwGn4oe3ScUxnwg+jGCkDHZIW4q08p7U4Cmmugb6S3yrSvkIudBZxARDfitOrbzlc3ew1pSBSkRMISdAyHLSCWKcoGJPAlbLUlKvgvwux3xzK9CNieXmtnFxZX2eDSYzDJXvtZNtK0eIm4PC5EqmUSuckVFhrzY29H6di7238vZEZWoqwNGIQ0KXysyB/mDMjokMK2Vnq5isRvsRTIUuhpuDpfrRXUXhpz/ygk/KzoVubRk3BE3NXBlwy3XOx2Oi3L6c3jdhLzHPOSh1BA+TE32gb60lQDoRpaIMu+ehbKLsEpATDfpFoGvxvqua72w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from SJ0PR84MB2231.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:a03:439::21)
 by IA2PR84MB3901.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:208:4af::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.18; Wed, 1 Apr
 2026 16:26:10 +0000
Received: from SJ0PR84MB2231.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::ce99:823a:6d2c:c390]) by SJ0PR84MB2231.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::ce99:823a:6d2c:c390%5]) with mapi id 15.20.9769.016; Wed, 1 Apr 2026
 16:26:10 +0000
From: "Ballard, Curtis C (HPE Storage)" <curtis.ballard@hpe.com>
To: Daniel Wagner <dwagner@suse.de>
CC: Christoph Hellwig <hch@lst.de>, Hannes Reinecke <hare@suse.de>,
        "Sagi
 Grimberg" <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>,
        "Chaitanya
 Kulkarni" <chaitanyak@nvidia.com>,
        "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>
Subject: RE: libnvme API review
Thread-Topic: libnvme API review
Thread-Index: AQHctS/BFbMIDt4Vo0eUzl2gyYBCNbWxSHFAgAEtcwCAAOUsIIAA2g8AgBZBngCAAAaUIA==
Date: Wed, 1 Apr 2026 16:26:10 +0000
Message-ID: <SJ0PR84MB22313E39A93D7006608C77A59850A@SJ0PR84MB2231.NAMPRD84.PROD.OUTLOOK.COM>
References: <d5b9ca7f-8fd1-48ea-a883-79e92d92ec7e@flourine.local>
 <MW4PR84MB223598544C3E0EC5DA7FAAA09840A@MW4PR84MB2235.NAMPRD84.PROD.OUTLOOK.COM>
 <93520cef-9e3a-4832-9bfa-a0f2c36246e3@flourine.local>
 <SJ0PR84MB2231AC08CA04F54CC29F03319841A@SJ0PR84MB2231.NAMPRD84.PROD.OUTLOOK.COM>
 <0b954855-c99c-4165-a804-edde9a34f1a7@flourine.local>
 <b31136a9-2001-48f0-946e-79016e5836d8@flourine.local>
In-Reply-To: <b31136a9-2001-48f0-946e-79016e5836d8@flourine.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR84MB2231:EE_|IA2PR84MB3901:EE_
x-ms-office365-filtering-correlation-id: bac26bba-ce12-4905-b8f0-08de900b6263
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700021|18002099003|22082099003|56012099003;
x-microsoft-antispam-message-info: lN37qVxX4KaoZ1vsW5LgIZ1daPro4dQbyNVNtLXoeimEK1CsfJAk+wc/5oH4n8ZQNrMxTUH+OVVEH4lKisKmuGi2pd3yOVuzxdGfTOQ1JC/JM4MBLt+4z1uQhQOk6D8osYQELtKH60Q5EP5LAbsaYueSPS7YUxPPZt3SBflV0AW7vJSQM8Piv+URi9ONmUCQbId9hBi+alnP/AOTJ9OSrFNdkWXarBFc3GuDDHAJiGxevHk/wzqEM/YjV6J0lu/TBNSz6MCSgLYHvoW+Dva7OMcOFAfubWfXKzS+dUuyQUE5WrmANEf3I/0RX5gcC+rLftFAisOzuf4Bzkr0rH4AG3SVJuWYmelDMjA4Vz0a2kCkprI72Xr8Fh+XBS5ck6ugKpnXI8kh1ttH0fIFqDLg95VIuth3gIYYARWVNmPFesdhjJk4P1nfcpwfIYwie6fkNR89rRtWgnks5zClXdKr62VWK8r5lHj42XTStnn2SeOp/29o/4Qq2hABoYKg8VAl3rtpTS2JJWsCkIQZbiUGJTBER7+JaYJH0HwMhBfSjqCNaWZnoX/HHBz1IsNTOoCkDzcPd8+EP8M1HP43tp3zrrkGoWYyNYngaRmj05/wYcoiYb4GGpV+ZS4yp8ReQB3VRcKfaFX1yRnWpxI3B36SEiVB/+OPsXnDszQMGyORfQq9Le4NGsyBXsDLxgsx8uPPjYjE2N6SxaHCwkNBz3n6J/ipMWq4E+HGJmxywp08ZQbqIiRY3MvOl0P2+T1mKD76Dv6y2NspbtcBBV/9sApc7wkt3hFG3KN1OUlqBNoPiSI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR84MB2231.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700021)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Gp+COW/G0/qUwDZvRq/WgkCS2eWklXju+txyefOjkfcN/NAhtu0E7A9UOMat?=
 =?us-ascii?Q?hDxRBZ6Rj009o72G4w3E2P/EUufOzpGEb7kc6wEo7DIez3seGLrVn3gXiL83?=
 =?us-ascii?Q?8mHx+6vBQcIQBXC8zV5SImgNKG6vdwv7AcdbxsOTm/qJZc/8LfJNPUH9RIzG?=
 =?us-ascii?Q?jCbJV1f21VlE0o4dVS3SiBHwMb2IH6xazmqj5OIB3zRpxBXR7T/5J+j+d+9y?=
 =?us-ascii?Q?eT+2fxTBFzYEBBcNqUv/hPQm0BJljqRZvW85e0CAWB0/M5JjtnIzrEP0ApVy?=
 =?us-ascii?Q?34dsAXqdgF3ePcREylBCLAUERWnUju+oEUt2Ff6DOclzCJyMKqqieg1+NQ8C?=
 =?us-ascii?Q?KbbUci/W+7zl4+t4hu3KbxMymqtRxkohaNidofh8l0ruoZD7INkMR1KarY3B?=
 =?us-ascii?Q?Lp0tqbvpPw1ShswEt4q7sqxJCDLga6ebVsYRkZzwX0PkVx62snPC/nuidUMT?=
 =?us-ascii?Q?hxizdsdZHE22doEAtiavqYNNxnmcovKSLKNnRNPkd2nwYOZsdeWjLBiTzdV1?=
 =?us-ascii?Q?jq5oXuIdTlX9+hNPVRr0znsejJL/KGCb/4o5BE85Q/u1haGXpmcJvyTCp5Sn?=
 =?us-ascii?Q?IrprVl+bGhuDRAoPwXt9C1WuOEjpQq9B/vEg6/LuKPr2dSacuSMiRkki/pNS?=
 =?us-ascii?Q?vtQRWDXVOJBIj3JKRhnq/M454IQqbhf582Lf+ja6Th+JqURWjb7P01CL+liO?=
 =?us-ascii?Q?gJqA7OELu/ffDYlTuvjQagQv/FFt6KDp4MaHCFBVDntgN7uI7KGrd0OcAtmD?=
 =?us-ascii?Q?cEsBtGBWb/YA/MD/pZ7L2lBdhSMKYZrBxr1V0i1B3M2HIWK6qz3P1f5wfOfO?=
 =?us-ascii?Q?/UDp6579YllMBGpVgmq1W+14mBRdQf6O7Xll0RtP3V3sb1z0nKhvfadP+vcq?=
 =?us-ascii?Q?b+yj1940GHJFRura7GsHIu6tDjUVm2tCUWaC6hRqscx2CKrFoDpf8u2CA4x9?=
 =?us-ascii?Q?NX6m/EpnmErtPUMBCsKpf9yKnjGgjTk71mpS78Xhxwsr24LbLE7u5nFlpVDR?=
 =?us-ascii?Q?1vV9ZfVO9FgllfePbcr9l3ryunc/ZBp7CIaoKL9b4lPWJExvcBiM+42uEz6n?=
 =?us-ascii?Q?e1sf8/7YihEEE89JQgFCwZ8IdLGbpT5g5VV/H0+DKIMJ2oKd6XHkA+nepfS0?=
 =?us-ascii?Q?v8lcouKgxCtiDQ6G0p0rCD6zDrjx6fNSPwXhwTOxf8yuyZWr34nwz+hIyidI?=
 =?us-ascii?Q?A/8z9JsC5EK+5MriI47CopfylvqAaBgxkmul6oGo3DYsz8KdjtitIZskh8Y9?=
 =?us-ascii?Q?Gv23hG5lww8mr1PlbpGGLg0NWK7f/ce7tlGlWG1Qj0uqCponP1hy4JCYsB52?=
 =?us-ascii?Q?KzyNGNwfO6SlAcX62oKe/MaL3cnJNnRPNvn9WcH8NsonuGlE/ocUbwXsw4CZ?=
 =?us-ascii?Q?PoRRzjJJJYi/s34vxRz6QKtNjAAHZZ1DNhr1LWUGObrlDnO7qiDPWxxG/WKa?=
 =?us-ascii?Q?oZ3jULnvrKgbJuE6ElYRKo6D/Yqgc2q5u9DgQzyOh6CUMTfAp7p9eiXm/wci?=
 =?us-ascii?Q?ZNFT3AiKaTAFGouXILvhbFFzbXK3w8h7wHTnoQrkAQrb24gOCLjLIipWoFx0?=
 =?us-ascii?Q?/rIbBb08DJz4vq+aBBzSzlwZVOvoYLpZKblZVWMi0C4miQnsSE09EtJFPSue?=
 =?us-ascii?Q?oni4hDZof/gt5HzmyZLx+omQpDWT/IlvunTPV52MBUu6ei0OOWHP3YVlJ77y?=
 =?us-ascii?Q?DZFTG/49h5jzhyS4lglu1WaDiW8IpT/gwp3Xd9CAPS6SRJXPLze0FnAzJTTG?=
 =?us-ascii?Q?s5xO9giM+g=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: t2+y+5lRBHBpEhhfbbCyNDTmOxirv24Xhmd3stnkXiQKbLnnoXyNFtXh8m9z7GzUTanbEZ5FGYZLGcMNMCZxs0K6fN5/DWSWJqW1oPqOtA4FgjNj3p980cII5+OmQD/pQ0LjRrKUgkLvcniP7ixIEFdYQp/adhx5XRY17vUpqRqltLUd/y9w/4Is596DKV53YJuBQFttjU9cKgnOhcvBFxEwjR/SiZYmSEpjRYPeYMqMR+z1x5B2Y7h48ll/MoUAPYOx79TsOz2ZAzPZ12PWtohKfseYHSOtvioNxBo+v0n6uvJnU8P6tRenVTyW6YOF4rMRYGvOQirSGyeHJbeIaQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR84MB2231.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: bac26bba-ce12-4905-b8f0-08de900b6263
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Apr 2026 16:26:10.2180
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vkvdE+nacaD3tVMAjMmWp/I7or6zMuOj9XVFsqIw9OlWr+SKcxd1R1GffhPtgaHf1nMh/crn2Xeyk/6N3H5NRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA2PR84MB3901
X-OriginatorOrg: hpe.com
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAxMDE1NCBTYWx0ZWRfXx28nS2LtuUxi
 GXhPEpghI08kOYsBHteF8dRoKZmJ8QYgcmpP2bB3Kbe45y0rT909FWZ+frIF5XbIyV5Zm3fATq7
 XpjAcSgMHgUNEkeL+47suvYNa01HkjbjDGFT05SRZn8dbdEAPCkRE0dU/995IApV39hyIriM116
 qo+69SpHNclMU4Kd4gSb2jJsHYfGWnaOg4Mefbh9dmxYd4b8yuSu3hPAQeomHD67eCYZb/85/HZ
 5vXLSo8CKmkWsPWkki1F5v+hfxsO0Xu5EIJ4pOaRBzdiL5k1zbwczfmqjz7xzrAPKUcToDEB7Qz
 qcAQPiDYRERclp8Wg8ezncJLG02U+Y5YSsEXCfHJm3H4Lu6S/rxZStgeHRJdewm05ukKotzylwQ
 E3jkl5Xbb+RIvRkqOlsi4wWy54tQl5GTiq1N7ubMhFusk0rdGMBwb789S6+5t+W1YMRl746HL9t
 m8WG/DgmqMtCNS7DC1w==
X-Proofpoint-GUID: vjhQZPgAU276lYR7KqiKe8gblOnkYYBF
X-Authority-Analysis: v=2.4 cv=KcnfcAYD c=1 sm=1 tr=0 ts=69cd473d cx=c_pps
 a=A+SOMQ4XYIH4HgQ50p3F5Q==:117 a=A+SOMQ4XYIH4HgQ50p3F5Q==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=A5OVakUREuEA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=gQcMVamqm3wCPoSYhaRC:22 a=6_mrDcixewTG61oOsKN3:22
 a=g0NT_kI6thM1A7rtFiEA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: vjhQZPgAU276lYR7KqiKe8gblOnkYYBF
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-01_04,2026-04-01_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 priorityscore=1501 impostorscore=0 adultscore=0
 lowpriorityscore=0 suspectscore=0 phishscore=0 spamscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2604010154
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260401_092657_475086_CC5E4C37 
X-CRM114-Status: GOOD (  13.23  )
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

>On Wed, Mar 18, 2026 at 01:07:10PM +0100, Daniel Wagner wrote:
>> Any opinion/suggestion on the prefix name?
>>=20
>> - libnvme: probably the one which wont conflict with anything else
>
>Alright, I'm going to use libnvme as prefix. Starting with the mass
>renaming...

I'm a minor player in this conversation but as someone who is in
the code some, but not regularly, that makes a lot of sense to me
and I think it will make it easier to understand the code.

Thanks Daniel.

Curtis

