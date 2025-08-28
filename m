Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65F1BCA0EED
	for <linux-nvme@archiver.kernel.org>; Thu, 28 Aug 2025 06:06:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=bVMlWPkKAoULVS0B6dtk4Cx56LGMi0+tj+//AC31VrI=; b=rzq1jEnncmkxdnxdxENj8veh6b
	K/sAjXX9iOWFROeTNGPjkw+x6CMyMneaGxwKKV5/Uvr5AgZOjaj50+Jk99wiKj3nIxXR4yfkG1kuy
	jYJP/fEPB72J7+O0JJo8M+bHZlF26IaReqIRZwvmiEBiU0nlCYrgERxyGqImtZnc4NCh9e7jLNgxV
	O8VbuhoqYBijPSdDN1Lqv70S+Yx2YYK1enacYe9a0UxUKIPu/emxY3TZIVf7UNiuc7skvZdnh1AOV
	Zj7IqmWuoETrj5WF8Zg/AOGVh1bkWW32CllV7ynaa8bzr+8M2T8oso9ZjkodB3UEy5D0Ev9HhU48p
	yOEwIFHQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1urVmE-00000000OoP-1dkn;
	Thu, 28 Aug 2025 06:06:26 +0000
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1urVmB-00000000Onz-2zuY
	for linux-nvme@lists.infradead.org;
	Thu, 28 Aug 2025 06:06:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1756361183; x=1787897183;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=bVMlWPkKAoULVS0B6dtk4Cx56LGMi0+tj+//AC31VrI=;
  b=R3eMe6HUjsHDpZOz2qmHGDrMMYMMLxJR+rv7ea2IqiLGW8pstr3qpeAA
   li1HFmwlY3zrtdv8tjOZI3qfvK9UsM1kOciG6HxcAWdCmt1UtUDBqHB+o
   04bzB199sM/8VgHaWxAdffe4/42zQQHZBNZC7Bg/RBF++54TjRs0/B1ZV
   iX1HvIyhJiMseb0d5a+njPyCJrl0A7/1NQZlXb1xPDKus/2fMQw5cwwfi
   1rZNkZ7XvDnHdEU6GGe/Bkv2GJn7yfEjBWmaqLaPpe1I8To/TX8RTww2s
   3XvjndYzcFUb6QKFV3A2tzHYD63YVGOCbPkeqrD83rKhOEz7bNtiwihb5
   w==;
X-CSE-ConnectionGUID: OXzPet4eQHicZ7SEXAZTbA==
X-CSE-MsgGUID: HkxvIUtuRVy0L3QzcaGRPw==
X-IronPort-AV: E=Sophos;i="6.18,217,1751212800"; 
   d="scan'208";a="105978641"
Received: from mail-bn8nam11on2067.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([40.107.236.67])
  by ob1.hgst.iphmx.com with ESMTP; 28 Aug 2025 14:06:22 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r42c81YRrsvmqs7qqUWb82l383niqTsXWyupXdAyrBw2UNwpnJdkT4HkSroaQZnKPQzc+0+g243av4NwKRjAiVW4N08DzTc6+ySOCXQNlVLGw/e48vUsYB/mRyqb7/MKeoQa+YssV38s5+X12bEBStALRZQX6kSxm0QAHL6ybLlALZYMWpRDet3Nfj5tVqMcrEnT2nfIQqMzNhSjYKcqkdN03Xb0HmxgxMEjXP6+i9AQA8C1YI2psIXaCDcwPQUi+lZIQyQRToceAzh8xgmvV7wcbMA7eTiPsiCvMItsciAFMMkMd4+ijkV2oa0EFLs+qlu/Gy45slIfW3QpAA17mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bVMlWPkKAoULVS0B6dtk4Cx56LGMi0+tj+//AC31VrI=;
 b=mn7t6yApxJgx+m6+AQWB+nkUrat6bnKLuGrBVV8VbgfRyh3TxJ0wMdBNrxpxLjL8+2/rA4lpL3abKcyvzLamBvHgB6oipkJYR4tsPS8IdJfj+IWbfPBZTxy86XsB2PFa/2Eke+IUeW72m35m1eCECtooJvRn4NcqgRxhL9EREvH0CsNnm3n40grhEkXdsDIgr7eXnFEfzVAnbCLn4AMGZx3XWsFEh7HwF6lWS/l4I1w9JEC6aUqoWAPNKAwGnaRUe79a1KDub5yldbbM/rY8Tf+Y8odBo7Z/PZzkP7yRoGEjrdlKYvDBGRlJsvlQ3/iiPR5YP8khg4TtqC7jZl06Jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bVMlWPkKAoULVS0B6dtk4Cx56LGMi0+tj+//AC31VrI=;
 b=feVYQgx87xlMqPomGFkmt8xtGiGRFQZwGthnsGJvhTDdLNnDratmtewNJAbghVXLcsLd4rbfDK7Jm/bL9gEiHPmONBaf/4etwQvfXV1stfedcK/0eWoksKxmZRfws1nEQ5WnxLVS5tyRNvgoCt64Ii0kVc8jzSaVPDeHKQ+G1Ps=
Received: from SN7PR04MB8532.namprd04.prod.outlook.com (2603:10b6:806:350::6)
 by DM6PR04MB6697.namprd04.prod.outlook.com (2603:10b6:5:240::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.17; Thu, 28 Aug
 2025 06:06:17 +0000
Received: from SN7PR04MB8532.namprd04.prod.outlook.com
 ([fe80::4e14:94e7:a9b3:a4d4]) by SN7PR04MB8532.namprd04.prod.outlook.com
 ([fe80::4e14:94e7:a9b3:a4d4%6]) with mapi id 15.20.9052.019; Thu, 28 Aug 2025
 06:06:17 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Yi Zhang <yi.zhang@redhat.com>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"chaitanyak@nvidia.com" <chaitanyak@nvidia.com>, "dwagner@suse.de"
	<dwagner@suse.de>
Subject: Re: [PATCH blktests 1/2] common/nvme: add '--no-wait-ns' argument to
 _nvme_connect_subsys()
Thread-Topic: [PATCH blktests 1/2] common/nvme: add '--no-wait-ns' argument to
 _nvme_connect_subsys()
Thread-Index: AQHcE3sBTCLVZvHoCUGtK+tHEzTP2LR3nMQA
Date: Thu, 28 Aug 2025 06:06:17 +0000
Message-ID: <gvk7waz6m33ahfvrb4xjuw4bjf32fhstwgtll7vbskhu3tzc4p@r6q7iyczd3ok>
References: <20250822151053.3248822-1-yi.zhang@redhat.com>
In-Reply-To: <20250822151053.3248822-1-yi.zhang@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR04MB8532:EE_|DM6PR04MB6697:EE_
x-ms-office365-filtering-correlation-id: c9300a9a-4563-4032-5211-08dde5f9004b
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|19092799006|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?u1GBFFlrnpSxTRb4okasOMJvv+ZgJV1toOid+Ld4fAbFzrWnyF/rJxRO6DEP?=
 =?us-ascii?Q?5IVyHcqZ1FtfyJIGbMgMe5PwW72dPlRhHT7v+yjML9pb/36InA5dzn/QM8/0?=
 =?us-ascii?Q?DA66Qf4/ZfgEgjcFkxDXId4Ku5AhLmYIlOkVORx+ssg6fh5oI8wTYmNzowki?=
 =?us-ascii?Q?PFY2jiNpl6cmBDafq4gCvvHDytQL7uXP1i0Eoaa7gjX97ExWoGZ5A3xLeZj6?=
 =?us-ascii?Q?vcuZZCbFkLxOrhHKX575BYaFdGYkIgKJCFbr4UYU1uvMdVS039152vTsoNYb?=
 =?us-ascii?Q?ubPxkRKgnsAj36I1pGaCmYv5eVWGcSVfX6vJP52oWQMwFQul+pi4h3yQbDWF?=
 =?us-ascii?Q?7TDbFEJeoQ/tDUGvG1GVgqgEQohfZ77EyFuESjoG7MLBCz8lvuBlcZAAkuBR?=
 =?us-ascii?Q?cNhSCGver1+RX5csnjVhv/N0yXYwbF6cN//WfEfyXEw+lw8eAkcSa4M7GFdF?=
 =?us-ascii?Q?dGz0MKphBuem56X+EfYbzd/EM+cbyAJWObrX4CsC7fuIxuFacvIdIgP7KHo6?=
 =?us-ascii?Q?W773RL1evKDknTgOQk04t6IeLf5ZsZyge3fdmw+NZq0foQJNzwdleoqfWvvA?=
 =?us-ascii?Q?xvA+HxZHIbXkeb08nrDKCTyIKB+t7qHkS3qgSO1fMZSqhqGCdzOBnFoc1B6z?=
 =?us-ascii?Q?gipnip5d8fx18xsOKdI9/7XB0wHskeHqS9f7/LW2iIt3Ud4rEaEU6tRj++7k?=
 =?us-ascii?Q?08Qax/BrOTwUnwI9M7c7ec1ZUkxArIqVlHkqx6JTnN14JTjIWFVWS7WSj4FQ?=
 =?us-ascii?Q?I0QGGCLTp0f4ucY3wTz7zjcuAPFM/tD1b50tkVr3x51JyqKjbhy4CTjNVvXT?=
 =?us-ascii?Q?lOMbD8B6ihGb26NLopKlDRW230OVgcHiWG55xuDFO3/Idbqjfp9Fx3GjLP26?=
 =?us-ascii?Q?eF2GiJ1q3SQzfZiX4A9A3kZclwi0EiyrhbOr7joXJYhMknt24eBkiQqY36+w?=
 =?us-ascii?Q?k3WJZ2uKDw902OghrybCJzIA0PaM72L5OcQZ/9Xts6E/S/sPsRI4XC1bQm1R?=
 =?us-ascii?Q?qy6Aq0wNpmRWGjwmRpxW8QOHLjdVv7JQnxPWUpSJZhDvJ27NkgTlOBPp0LVM?=
 =?us-ascii?Q?wPMsiCEzjR/iKjQh/Rt8fzVUoaeaB2lJel1nT8WObZBo5UW65QoirvlvozwH?=
 =?us-ascii?Q?UiFLHenNEfBoluA7BsME8kWQvYzKdgOcIRHj2pBAt7e1Vrm+ERC8eE5TupG0?=
 =?us-ascii?Q?91km2cV+HA3+Jt4O6qgHFF4JLtW6bT/imfjnnXpb1yLG8PoUaZKdX9RnST5u?=
 =?us-ascii?Q?yLp+48bSVVZcSmWcHkSiGyFbmIURMqNNTAXgkyAABf1YYSCfU2bWyoK9bs71?=
 =?us-ascii?Q?Wg2UnAwd/S1V0oMTnLN8cLnrd0IGoZF5hkMOofrFea4J2gz4uPOZJjJoQIVn?=
 =?us-ascii?Q?yTF0eWQVCP7Tc/4F0YYmCmfvxB8HlAJ5LiPETNhhT1GSx+GGjU5UPtkCkXpN?=
 =?us-ascii?Q?A3ofjHdHXIDLWKQtC8H+6u8dT7BSPgMm/dcPxFrnm0CoQU1zbU9QDQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR04MB8532.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?b9lEO/eZQhSuX5th8tJgbA6WUtEpzSZiLfcoRhAyk1cc6VhqZI61dUFhFms2?=
 =?us-ascii?Q?SNPAlnyMqP2Xf9IROvzyObBaEuNpnQ21Xz/TF68ez73Vm9D3mkY+sm3GnFio?=
 =?us-ascii?Q?imWs91YpCH6tkpjZiDOWg4VH1i6QQv02KR3XXg0nlZrY07SbQAU3BE1pQTwz?=
 =?us-ascii?Q?mG79Vs+L1qXRrE2B2wQxzPfMfOHN8jPUcYDQSPYUOcmY2FD3rVaUTnSn9H4l?=
 =?us-ascii?Q?WNOwAo44yQyHS2kMw8jwbkRa6HtAnJsfDmdffYvNvGyCRCAd9nYSGUp3zLeT?=
 =?us-ascii?Q?bBvsff7QbatbQxK9cYc4/Z85fWi44LoUyMJt551y4+2rGvhSdrr5knHMr0wx?=
 =?us-ascii?Q?gmMmYc8bc1OYu6aRaAfVLUq75K7dSMGL0Wd1G1mi/EGT1aKkhybqWYbGFADA?=
 =?us-ascii?Q?F8VVgQnd4obyMQ4L4842vURtH8C1kP1DgCEGoG/UqTwMgHe6u7k4IENILLzi?=
 =?us-ascii?Q?Sz7Gnm1rZMjFIjt9qtliuraJEINaUrrMvnfGn0OrSaGnTawtpj7jw7FPbJeq?=
 =?us-ascii?Q?7wL+7IHR6eoMr0dM9CUQZoybv51K4s/uX3DgobfEZ5QxTW0ncUBcSrEl0E/+?=
 =?us-ascii?Q?XHgVvcrRXnevcRTG5D0UjwAvZXQxw7ja3u6IMNjP7UG13HfjtGbtyk37p3yv?=
 =?us-ascii?Q?Phwxo6r8DaKdA94ozEued1VGSig7sjyrK0kIo0QmptNfdg7p9M7W5t1yuCrz?=
 =?us-ascii?Q?THVArOj8qZrJt3MoWlEmxXfbGWVEXkVDZvSMicnV5joc0duUTjksba/IrMbN?=
 =?us-ascii?Q?AX6sZWOGfhLAWfLA4NLXDFfQbKwwMn40yrU6gqELPltep0lB3lZx2HPjg4+7?=
 =?us-ascii?Q?8dLAv9GPm0SsrLUqr7t/mXJP83qtaZVx1miD8w4myVPE61DfETqPuPXO8V2d?=
 =?us-ascii?Q?2C9wmyWMCoSj65xG0ywbMfHEjNlSNx7Fk2OtC/98lyFLScgiATxMePLyonzg?=
 =?us-ascii?Q?HkBn6YbQxTg92zh01RMBjCTNNTNnh1M8hH9t9sVj/V9+4T54byTITTKhWNzB?=
 =?us-ascii?Q?OfBoYvvQYHbX9U3eT4qqyY5F2WpQ5HdDA6OPtlovxC4xRjzeTHyNFVGf/P6N?=
 =?us-ascii?Q?GhdxItn/fSK7+XYAnk4iifx6xxR95KkM9XUgl8638fVhxHlw8vLBmMNjji0M?=
 =?us-ascii?Q?I7MkRyHAqSAxl4gYHCKZ1EOozPyaDldrGbjpxVpRBY6IBsTTRA6TFndyIUMq?=
 =?us-ascii?Q?zrCPJ3SwJNICXuBtwT8xJGH8iIml8X8cwWzcFBkp1UIjGx4owpoSCHmSdd5C?=
 =?us-ascii?Q?kJpgoazdezujXeZ8mYxFezLpYi5zMdSvNofsQ04nBSPA9rTfhU4vdnuTJFdc?=
 =?us-ascii?Q?w8zt/t75OFaNzGmoyGGdvY01ZuS6BX9MQWSgDgj+XyCv0I91EIFv6JS5VzLr?=
 =?us-ascii?Q?HCWpkal0n+wrNSo8BUREGCasABuMuV1ESO8eX/1u+DYrlD5UZtj3fSUcz4so?=
 =?us-ascii?Q?I75iIROHjaiU+WtNlWvx5n2XW/OeuTArEgRlWOydpy9UY309orh1dmFRZapV?=
 =?us-ascii?Q?VVl3ANzxhgMiQ4le+ryBJjKDHOCfyUGCiuxnCnq1/a7ZUftPVA7M/kv9NFTn?=
 =?us-ascii?Q?BD5KFFw+S9NS/0odi8Vcfm6eqpi9+BxRLpeUwJ8/4C3aRZXsmGvC2H4xjwVu?=
 =?us-ascii?Q?gQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <C45CF0CBA01E3B4FB8833F19B418566F@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: mCMiU3o0xLc11LztulTYsCmT3tteepd0i/Y2MOixbLInYy7n8QlwcXsHiO6Tg9f8kNw3i88RcNs4uCtKsf1AcIxIjutq8JUVhzuHS1ja7+TEgBVfEUtyE+6ptBSClhnNhMpzk/2E19v2VO1g2mh9va/EjkmJq6mPorZtFJiXMNmvHPvuibmpET2a6OtcA4JN4uYkpnN4iY8DoiSezk4T8J0sh0ZjRfiofnd9kCuU2sJqvJzwp7SOQj5CvBN8T/mVTLLVHa71kunqAx4kZkd7gxJuzClMfHW0YS2IWJFerP/7YSnvJa/BRmunlQhsJsmQEAbVaOwPpPEaBEcbZWryZXc0MS3DCucA3nRNFHioiPoBSzDA0v2nZHcIPMTPnAqOwooW9swVCXXHqMrk6ov4uUyg/AOkCEOwd2fI3OSJ0SD9Gg499IU4HBXxLaaZIeOXJD6SxxF2lH0nlZmgV+t0R4JG06rsYPVYXzJG0Myqzsm8/4fB+PsGnmWbk8SsnLzoPSlAMyXOmuMmlRLyFaLdBLIrX+lbxqy28RPyHakauYxhhfYU4yGgTWeE6DsIL4PMDIQx/3Gh2BHk3NlYMLa7b7h/4KU6divoPjN7vT4BEsOq9bCjLYixfS31QxBslXBs
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR04MB8532.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9300a9a-4563-4032-5211-08dde5f9004b
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Aug 2025 06:06:17.0857
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dhn1s5vKl+hOutdh6MlLNyd8/+BthAv7xTYEaKkkTkqEu/4rufKSoNXzNHZP79gvT+5JFXwA/JovLQiJyLsawb7a5GUfzqgaz8irwpTnDwE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB6697
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250827_230623_817843_CAAFB417 
X-CRM114-Status: GOOD (  14.83  )
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

On Aug 22, 2025 / 11:10, Yi Zhang wrote:
> The default behavior of _nvme_connect_subsys is just wait for the
> controller ready, but sometimes the namespace was not ready after
> _nvme_connect_subsys especially on RT kernel, it's better we can
> have namespace ready in _nvme_connect_subsys, so
> 1) re-use the the function _nvme_ns_ready to check namespace ready
> 2) add one new argument `--no-wait-ns` to skip for the cases that
> don't need wait for namespace ready
> 3) update to use "return 1" for controller failure check and "return 2"
> for namespace failure check
>=20
> After this change, it will avoids the failures like below which easy to
> be reproduced on rt kernel:

...

I applied this patch. Please note that I took the liberty to simplify the c=
ommit
message per Daniel's comment. Thanks!=

