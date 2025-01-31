Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A019DC02192
	for <linux-nvme@archiver.kernel.org>; Fri, 31 Jan 2025 12:50:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=S/uaw4e8yOhg10hLDdEvRyyu+pE98/D9ddDiUJJJheE=; b=JvNeL3A8rnnAyD+WXIga9QGW3P
	iya+c1Y2LAWzF04ViGEyzGErM8eSSnfsuDIopBEhRga/Ej3+ngHLaeSuO9lcKGabmX3SR0tOGnafz
	lKWs0vSrZCVwcymqZ74jcg74WbxQf0MFwevOBuTe/NXVIQWZgvS1xZSf5rv8zJ3aKDA1t3uGyHzqf
	mwT8hbe2RymKmqeoJkRJSrLqsYKo1WV6yP9Y0+X2YwERrKtyFMIuNLm4FKC6oXpFrbWtuy/a9jcDu
	rQN9B7TiwNGlPOxZLF+m0xvuvwKL23ecs+QQyYxH8fbVNUl8R5MmCisJTLoMFohkgfBblFdaBO6fA
	a34ooeyw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tdqTp-0000000AdJm-0QCO;
	Fri, 31 Jan 2025 12:50:41 +0000
Received: from esa3.hgst.iphmx.com ([216.71.153.141])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tdqTl-0000000AdIk-3KQA
	for linux-nvme@lists.infradead.org;
	Fri, 31 Jan 2025 12:50:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1738327838; x=1769863838;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=NIyfWncNWKDYCt0eAbmcdLF/xxFjXgvJIUzQc6OQtvY=;
  b=bdNsT26fMbEKp3HhO3BDC5efn914lO2rNZHO/LqenYw/ph7h0982p0+4
   qiCienUVV22nvNkhBWiCdu1pKSCV3gH9skwz0xcaQKbVZooUxF7w9lHUJ
   voNKa+YBI0WrpekZx5cYQKCooWEzCewY8TMENyGXfK1QxguviyI5OfSeg
   Vstj9WAij9gjGUjPfl1AY9FoRxdvNKqVCFdp4r465yy4RRFZeQbPse0ta
   S9RDH1Cwo1Gl3mFmOD2DvWkkeK3nzklok5XRLeeyNxJNO77/0dAUeTgFL
   yZjfp/mVwoWn95ivO0xGghvwDK5kjjchBZHbvDDwCVxrDbqxTLYfe9pFs
   g==;
X-CSE-ConnectionGUID: Vo3gOJsWRUCDeYGsswIOfA==
X-CSE-MsgGUID: BmQkBddcQjyStq+mRzQevQ==
X-IronPort-AV: E=Sophos;i="6.13,248,1732550400"; 
   d="scan'208";a="37259505"
Received: from mail-westcentralusazlp17013076.outbound.protection.outlook.com (HELO CY3PR05CU001.outbound.protection.outlook.com) ([40.93.6.76])
  by ob1.hgst.iphmx.com with ESMTP; 31 Jan 2025 20:50:36 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GJ9kkB6Fc5I+N08Qs8Dujebk0DmuaxJMDFD0XJpkGralVrCKkLfO0v/gxp+04kuDLNG57ZNoX8X8ehtbyI3PQD+lkomsLnX40MBAzhGqnbfOQ/pR79ng4By6PuiogJeDCrhGenCnu5RRsY47+RGuJnrFMVulsnfFmMxI6cCV0rmi5G4uHwsqM32lmdupyvGO6kBD1uE+82OgcBAIRBcXrFDt2AEoJB3cGOy5hEYU/FKJbRwMXCTjlvGSaXqJJTctbkx+9hfI5zNDPm0d6eKVAOoJTXYS3tKMdmDQdK86as22JUg/YG9c0kxvK+2Hc2J7N8frcSirUNSWzbwzCPECuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S/uaw4e8yOhg10hLDdEvRyyu+pE98/D9ddDiUJJJheE=;
 b=SpIv+ew1CK8AnubmTK7gcIOYUYJ2Dd3Fyn4Ma7hC43PKWqylR7TSZh81Qk2nhd6QapgVk8XoXWKqYRazUPOgdC+a7NIrt9D14VhEJoh/7BWzwEVQ2WebEy/fqRsk2PuuHFUB8yo1EkOT0tCe/C6Ldo7nnTnybeweGiB8GeiU6W92F+PXX/M3fTeV+TdU3vQslRfcRLOSuVXnMDcrWlrzA9PP92VI5qilGcQdGGl0W4FvGG0S23ZC2JjjBMeHOx5zqHv5sWQpTbpasm8TXZOa4FNm4XPH3ZBdAoXmTJCrNhnpq/WUb6iKvNZuIJk2NrqPpM7gTFsMjbHzKi/KkkF5og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S/uaw4e8yOhg10hLDdEvRyyu+pE98/D9ddDiUJJJheE=;
 b=Gf7NLGDctUv6JMaQ2m6e1++WBt8zCkqKteI7pxx6OdVBjif4QQWW1acbLbzSZIChUWJ/9BRaq8UtcpWcv94GcKwL/pyzz5aAoYqnraSQOo0D+PRxF6zzdQgiR7faIxc0wQzlfPBENA7A12w+1Pgu/6hqIbDp7EfXt1Mw0V3bh3E=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 PH0PR04MB7622.namprd04.prod.outlook.com (2603:10b6:510:4f::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8398.20; Fri, 31 Jan 2025 12:50:34 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a%7]) with mapi id 15.20.8398.020; Fri, 31 Jan 2025
 12:50:34 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Alan Adamson <alan.adamson@oracle.com>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH v2 blktests 2/2] nvme/059: add atomic write tests
Thread-Topic: [PATCH v2 blktests 2/2] nvme/059: add atomic write tests
Thread-Index: AQHbcd5GhXZw5pnsok+/fq73K7lry7Mw2bGA
Date: Fri, 31 Jan 2025 12:50:34 +0000
Message-ID: <vhdb3rsa4vgxm6nm7js75cnlxpv7d4rjxdvqpa5b63u442m3sd@b7w5w6mzjj35>
References: <20250128235034.307987-1-alan.adamson@oracle.com>
 <20250128235034.307987-3-alan.adamson@oracle.com>
In-Reply-To: <20250128235034.307987-3-alan.adamson@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|PH0PR04MB7622:EE_
x-ms-office365-filtering-correlation-id: 6f5f39f1-c12b-428e-a4a0-08dd41f5da84
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?e6r/2T0NJq+2NDe+3pEXxek9PC5oUC5Yhlt3ZQ1ioKII4JU/fqPUbb6o8ceX?=
 =?us-ascii?Q?IO1jN9ruBYMMrmI3pL/c9yGHiHkhRV9tFZ6dj79eulK8y/DQkiuCrqlFqyxP?=
 =?us-ascii?Q?0SHYOPSyZSbMFAGdvd6CKq4n9bv+aMLxoCrJAggMNPbbGXWJsYptyZe+np8F?=
 =?us-ascii?Q?NjnN6DR6kG0brzOowj62R4BcXhgwxe1D8GZ3Y8fRlC3uN3DW4NnmhaqgQK2b?=
 =?us-ascii?Q?leRaKrsK/CLUAazc/0Y+72kxFCjlWQZSRAtY88hTNKmU3gJnIIHvUhjrH4zo?=
 =?us-ascii?Q?aKRbULykYD37cVKOw7HJDLYFtxTd4ArEJwhGZTzdgYMXmTL8mBliTY+0vqZN?=
 =?us-ascii?Q?cXJL4Bd2CeuBNi6nC8GAJsXYQcemUSyHjAEXNYx5EpvMtCncH/HkE/sa5xZm?=
 =?us-ascii?Q?GExG6sWRp5gVLphTl6/6YzQIGNwsvNnvK2yySU8yaCLbtjyeiJyM+4fhfVOa?=
 =?us-ascii?Q?nfE9IICIuEWct7XRDJ7kEFwAOk2IbuagCcbZNEriqqIFY/+af4FhgxKzy/1j?=
 =?us-ascii?Q?OU7F/aX0l95wMMSD3lHd0yaHjwsI/VfT5WCf8eMchM/AQ4G+wxmoBLCYZAdR?=
 =?us-ascii?Q?WDk7mSVVMVBH4tKl/pI7I1u/BGFP5N8wCqpRmNEmv6MeVRu+DUuOK0ik/u/9?=
 =?us-ascii?Q?XZFaqnTyhKLUhioIh2dj6S262Boy8ghDzVWQbfOXchUAg5xueIWXUuRHkg5Q?=
 =?us-ascii?Q?HGMFqK9NuJIqt57w5T2DL9tAxjBoHonT8bZJmwbzRopd8mwClkjWhX1IIr5J?=
 =?us-ascii?Q?vam1FUKCut2qIXDw5qyzqj+XsAQefyH4LL2e86uLvbxrcBBL97AmtPUMat9U?=
 =?us-ascii?Q?rXAsiPwwGpZyr7I0VPD38IT83HoVCEsfMuzA1b9LlxNb7SVxWi3xbwI1Og+n?=
 =?us-ascii?Q?j0JYnw+Ajam3fut3ZjBDS/pRQmKYFyEkEtTaeSgM3Ho2IuN+PF4EonIS1cTv?=
 =?us-ascii?Q?9KIuP2oh7qGppc05lVD0RauWSpfPrgeO+W3pPk5A1IsbZLhnD2MtcRKhVDsV?=
 =?us-ascii?Q?sCFAHvSaJ02XKFmhqi1/6pDdoDNirzNw1BZ9o63RXdewFoWW2uoYkaOfjo/S?=
 =?us-ascii?Q?KVVhfUnHfaef+mREUFhWaV0cEKfWvnggIyaE9ffKhgE05HaRSgHolKr8m0kA?=
 =?us-ascii?Q?lXyjwG+HsH8MZAR6t5StuzdRoKf5ROZo+r06t0FTivi1nEyy8y0x3oTPHtZp?=
 =?us-ascii?Q?PvVEIHErhl+R2N1RSkEtSBGHRnPvae5dYp3J+R+ZUtCipeoGfMlun0U31n8+?=
 =?us-ascii?Q?ScpuOywFTs9Ox4dcYGr7z2cnzQUHqCb2ChmpRYCA2WvcWMYXD3xUQmc5Jl6K?=
 =?us-ascii?Q?xxJIDv1P+3XSj0FXdKa+PyQicRL4JiV4Ki+/lUhlruD0d+xx3AYTO2iTh8Lb?=
 =?us-ascii?Q?Sh3zbRbFKJ4JnNc2oGs3YxHtUsdCviBvO/E9jJM0n0SoMGAu1SYk9WvGnaNL?=
 =?us-ascii?Q?YyszJiJ3ez91FD+vZWRCs2T1ICEhpaqV?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?uveCnfee6ibIsuCWN8qhPJoMiNzUuo1UvKwUF/CbYOCK/SeAxM6fE1y2PBI5?=
 =?us-ascii?Q?bkxhY5x0JuVSaire1VM7W2XzM9eJX8ZliByIYiu43hBHo/vsq8MMFHoZTSVP?=
 =?us-ascii?Q?RuoUKHBuHx1UcEekL6y8/qcOSOcPUVxFb5Jt5EX9l3orvuEJsXkP1DnIy6yG?=
 =?us-ascii?Q?40fU72GmeBTGj+0NsXndVLeCP7rJGd/79sVI5N6uNmimtipEvo5Fb4zOnnPT?=
 =?us-ascii?Q?3ToNKWv+PJZQZYJadA4zyPXarNoi1n9xSFVCXke4kbwAu769TQdUV3mVnVT9?=
 =?us-ascii?Q?ej+ZJzDBEjcsLCkgKESErSCAFDt+0/IQlGmKU14a85MIgXZEytozlbDYjxX5?=
 =?us-ascii?Q?1u1l7NRmJGL1b+xUM4sjKJ1PZWCxyUjdP1ebRt810YzaFIdMILFp390A+YBd?=
 =?us-ascii?Q?Ielw2Q0Jrlv1hFRTwOen6Bc9j+6mPVubUzSf41OhH4fAZobBDr5m2dsK+q4g?=
 =?us-ascii?Q?LLwI2fTAtFI3IZhgwZcB9m0WRO7N8atbVaF6K5zntfJ0e6JzrTbFyO36HRFM?=
 =?us-ascii?Q?VAo29JRs5JkyZ48N7v5cXtJ23d3gG1j5ZsufOra90Fq3Ab1dJOPP0hKTJi6h?=
 =?us-ascii?Q?XEJKclgbiIqtjJHPynDtN9rylQ438n9LLVIE5eJSP4GTczxKOvmiRZlMAsCh?=
 =?us-ascii?Q?rm5Ey+z+ErgiXwUBxJluHfW05dY1DnRXbenvhjst+nE2A74mXeTAofrA/oZs?=
 =?us-ascii?Q?l2Li/ygeZxi/xRMm8GwQK4kDzbFAbClj8AisnHfMxCkzhTshz9n/OcLHO3OR?=
 =?us-ascii?Q?s3RlGVH3zlX2dkqM8EJo1nu/FnSfaXOUslIVBHz+Aqmhy/KDZbtbv66tODlb?=
 =?us-ascii?Q?DR5hqgrOrjF/7QS2IOzpdfupexZooXmfHgoIMJnTMKCOOxDK2JcaSbpRho1D?=
 =?us-ascii?Q?SelooOe3HtjEt6BDz0F5OKsh7FHlnUuPly/nyKrjtq2KyE2dn8wHXr9B27HT?=
 =?us-ascii?Q?D2JB+nYCRspLu4j6VP8rNpRdHtbARRP9S1ePs/dxi9PiQTvNiYfnBhJEkke9?=
 =?us-ascii?Q?82wXykPn1tyKroeNv0F6y+0f2m4xFly8jVxUfZ8kBeU/Y6CzvoqVMOi/7seb?=
 =?us-ascii?Q?wf0xQKwNJDMv2JJ2zRNUM/fUA1F9mSKUUzpTDqdLbpLAm5PYstRE2+lRuOVK?=
 =?us-ascii?Q?td5Zle8jQUt68xfibn3U5Oz2m2Rq7kY/rL1pgcz6JvatXn7S56++mKHWl68j?=
 =?us-ascii?Q?40AHHTwxcWSqPbcDp/GTDfqgUk47urrGR32yMkf0QYIBWXhKYaAEWRapoD8U?=
 =?us-ascii?Q?QyjxMbI5Z7qa2phv0vQSeCKWbqbwcGaqnNPJBdNaFtE/yQNVFhgs0juWrkP9?=
 =?us-ascii?Q?U7Pb5MbEPUiC7c+isVnYXn7mEA2swGSrWxBu22P1hqQvG5Tn5QeVlOYg/8q7?=
 =?us-ascii?Q?Lo/h7qTvb0ocsJAT2hxkhe168i6IC4bzguFPrSu0I2OWgNW14CZvocAPEO/M?=
 =?us-ascii?Q?sWhDBAlyVAaJFOSyT2j0G3VDFdVaAzKtOSMh96WhHklkL1oP7aYumnppENZK?=
 =?us-ascii?Q?9k6GwShABE6eGVTmHngsJDTk/7GW8DltHi69sbtbQRcNQhXSTvRlefAK15kp?=
 =?us-ascii?Q?iDW5y8K9mrfl6wPs2Ols+hXsSW5vUwFmoD5zalZSdhwLuG2Gd+gOZXzOaCY4?=
 =?us-ascii?Q?S3KAI+tb/MZ0+VPFhtC/b14=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <76E93A5A8C2CE246B9E8F7CE0C0DC028@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: KJSY+Y61okL+GrpD/7Ixkqh4CVph+2eIEDLd4xnt2br5e28CClN49rpV4vv2NnphtzXFUiLOfYCgt2BIxpj4U33fmgw1hlw9kU5I5XxEshm2lROu0mSm4TqSR+GMYfwLQMTrxYdgKNjWXvjdjXTnI7SeQRosWHUnAU9cirKfT6C/loIqPy6/4QOn095Lbc4qIuSfQ63PXkIAVeToFM2pjnVg18vYX1YBzKVjaCR7Czz7iJDsSQ0wPomD3CCmQD3IdMD3fkvDCz35DGDjP1TTWFrerKswHuMb03JLZSwxBMH/EJ2jZDwHZQgf8zBG/Wk8teOslnd4l9R56i5lsWFFw3oN7znFirzNk65aIX9k8EeScX2tPb/GIOq95yD/oYTkix97EP4jUkS6M0PGquY30sdYq9RuDof8SSbhy9e/J73jjz+8eWrI47C7lsGZAJdQxLrpQ5IoD7pgMZt15KrerzFHUVHnYC0TUSJxjWKPQOij8HzLKfk/AfOT0hcgnoCOT/9UuJmq47HsrbzL2HIy5t5GLTX7WP+/xiYr/NW83Br6w7vpTO0HYVYRx4Kp4JTADRv5w16KNS9znrB5XR2nQdJwE14LfDbNYybGEBBH9U0UmIxUQrSaEQ87WFnzIlTo
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f5f39f1-c12b-428e-a4a0-08dd41f5da84
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jan 2025 12:50:34.4804
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HRU0v/rM3v+COFqVX5Gi62dhA3o+9Cp/UP2IcGpse7ZvrLOJWpPMoFpRb9qVQ2KOaCpLats6vJwIL7B5Mz9cDbaOnhOellAdMt0Gv6k65C0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7622
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250131_045037_840612_63805C79 
X-CRM114-Status: GOOD (  20.17  )
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

On Jan 28, 2025 / 15:50, Alan Adamson wrote:
> Tests basic atomic write functionality using NVMe devices
> that support the AWUN and AWUPF Controller Atomic Parameters
> and NAWUN and NAWUPF Namespace Atomic Parameters.
>=20
> Testing areas include:
>=20
> - Verify sysfs atomic write attributes are consistent with
>   atomic write capablities advertised by the NVMe HW.
>=20
> - Verify the atomic write paramters of statx are correct using
>   xfs_io.
>=20
> - Perform a pwritev2() (with and without RWF_ATOMIC flag) using
>   xfs_io:
>     - maximum byte size (atomic_write_unit_max_bytes)
>     - a write larger than atomic_write_unit_max_bytes

These test contests are smallre than those in scsi/009. Is it intentional?
No "minimum byte size" test, and no "a write smaller than
atomic_write_unit_min_bytes" test.

>=20
> Signed-off-by: Alan Adamson <alan.adamson@oracle.com>
> ---
>  tests/nvme/059     | 151 +++++++++++++++++++++++++++++++++++++++++++++
>  tests/nvme/059.out |  10 +++
>  2 files changed, 161 insertions(+)
>  create mode 100755 tests/nvme/059
>  create mode 100644 tests/nvme/059.out
>=20
> diff --git a/tests/nvme/059 b/tests/nvme/059
> new file mode 100755
> index 000000000000..032f793e222d
> --- /dev/null
> +++ b/tests/nvme/059
> @@ -0,0 +1,151 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-3.0+
> +# Copyright (C) 2025 Oracle and/or its affiliates
> +#
> +# Test NVMe Atomic Writes
> +
> +. tests/nvme/rc
> +. common/xfs
> +
> +DESCRIPTION=3D"test atomic writes"
> +QUICK=3D1
> +
> +requires() {
> +	_nvme_requires
> +	_have_program nvme
> +	_have_xfs_io_atomic_write
> +}
> +
> +device_requires() {
> +	_require_test_dev_sysfs queue/atomic_write_max_bytes
> +	if (( $(< "${TEST_DEV_SYSFS}"/queue/atomic_write_max_bytes) =3D=3D 0 ))=
; then
> +		SKIP_REASONS+=3D("${TEST_DEV} does not support atomic write")
> +		return 1
> +	fi
> +}

As I commented for the other patch, I suggest to factor out the check in
device_requires().=

