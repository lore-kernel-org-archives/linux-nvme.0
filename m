Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 901D7C25B67
	for <linux-nvme@archiver.kernel.org>; Fri, 27 Oct 2023 07:06:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=eizLYXwlATXuDylCblHnp31qE80GZDH/opOHyzMoVqs=; b=dFl2CDV5OWZipGvPOgMQy1u6Dz
	s9YweAcSEWEjmRjb6jOFfIshM3ecPqvtKpTvGYeUelLZCUH2flGdThYQYVWfRULQX3nZ3Xb0DGSfv
	lKJZr2NuCnzYzBCIAa7Hvzw9CVw+0eVvQN1+UHxi+BUyQRKF2XpXPVKWlQzP5BjRSw+2K/Sf018wv
	m6UA/gh9p8Gfhtr4cmjzB15nZ5YmvTnZSse3tzZ3pBVUYR1Wwsq3Qqg2ZJZ4CeAFiGqQAzJ2EEVSU
	paRi/06VQoLTWZGx0H7nqculP0JW/CMT+XdHxEk/6S2i65mKtVD9wiIgfJVKb9zeZf62SI/IXPd5X
	hWVdDRUg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qwGvF-00FjPd-1f;
	Fri, 27 Oct 2023 07:06:21 +0000
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qwGvC-00FjOp-2e
	for linux-nvme@lists.infradead.org;
	Fri, 27 Oct 2023 07:06:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1698390378; x=1729926378;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=eizLYXwlATXuDylCblHnp31qE80GZDH/opOHyzMoVqs=;
  b=ptV1unl7cs0QMrG2IgJvH0VlMUOgwx6AXXbaO2xYqYEf4yDtgbYGo2xx
   hs6GgtOlG6mamyd61rNv9wHD2fcgGiL1as498VU4ZT0dzjD1nnq3rbgcL
   iaGfpwr7o4d3S/zGhOQwBggOq3PoFxlkcDq1ASrYg2CzzVq9QKYEYl8gn
   l26R/moCdXwNmNtTkPZbtuOdh+vxFa78voDlYoS5J7UPmoyDDCqr3Bf++
   yS9vPOpTyWXDan7SbO6uhe2A96etHdY3xYHQJIN4TWTPB3wa6d/D2Y/P1
   QjeUwL08ZyisBv2Er4q9wIB6zU6xp86W8I/NDUBGjPtJeveJVxG+ktUOG
   A==;
X-CSE-ConnectionGUID: Vlvl4JuMSOOlz1LqKCMTdg==
X-CSE-MsgGUID: 2yHVBh8WTQ6ro/OOSQSqJA==
X-IronPort-AV: E=Sophos;i="6.03,255,1694707200"; 
   d="scan'208";a="797970"
Received: from mail-mw2nam12lp2040.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.40])
  by ob1.hgst.iphmx.com with ESMTP; 27 Oct 2023 15:06:11 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jbOwkH3R1qv+90b+97uAfOOf/d/HgBNiRZwHAnyKpBvHK551wZV/jEAB50Qak62vknjSc0VAxlreQrMzgAXfFUZh+ezR7FhrQCJj1dNTJ0TeoRWlWXPP5rdGzKmBfXah2wjj1W4/cdtpN8k81WZz1RTpv23KgurV7LLMhBNiCZ1Azinnm65lamvbZxnpeZrb5Zl4TCWrQvdNgXsCSdzk/NUjNp96nlbYL3e9kxtnpPz76aRrVuNMXrDSRfL3J+W05WfzXfrejx3tRnjiSYLelNGqjZV3G6y6eajYs9bCa8AX+Tdqfsn6fJ6iF+ql/YFN910nyNCJ/EH5y9XF334cyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eizLYXwlATXuDylCblHnp31qE80GZDH/opOHyzMoVqs=;
 b=kcQPTk8QVjUqt6NQRi3veNukoO9AcX3nx5rH7CsyuTPiQMfvftXnOAiYGn10cOJxRU+hc3ScPsIDyIeg4j3Zm/PXIpUAieKGnFJlTnZ/fJz2G7mMBu5VtOlleMZsZ8WWApuvuTMNVlDV2GO+KkP1H/tsbj2uvmRXQQoAObYrzcyyHn1nz8XL+QIogYYbGxjzBZ7FDt7yc7/TMxBmGTzFx673NfF2rJYFdGoDrwZLyhMI4pnt2lDMkx5bn2us/n9SMGmHj28jw3F9eRWy5hDy9xXrnUNb6zzhJrb+tG4eeEyFAKe9sp+k1nMTBQ4CSRrsr2jeefgqEtXcxlSyMtFMDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eizLYXwlATXuDylCblHnp31qE80GZDH/opOHyzMoVqs=;
 b=XGgc+9kn65KellpdQwlisr2YCxmDs5R2Thw8D4kdPz49W4TZre15n5quxgE7fu2lB0hAKhpATzavyzdBMhCo8WwlCb6mbIj9edsF88jRUkeQqhZbC4QGjuEOjnRLPxDKbBKMyPqSHPYjcur2Q7OTFofEB4ovr5MUU72xS/vnilc=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 CH2PR04MB6950.namprd04.prod.outlook.com (2603:10b6:610:9b::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6933.24; Fri, 27 Oct 2023 07:06:08 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::2256:4ad2:cd2b:dc9e]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::2256:4ad2:cd2b:dc9e%3]) with mapi id 15.20.6933.024; Fri, 27 Oct 2023
 07:06:08 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Kanchan Joshi <joshi.k@samsung.com>
CC: "hch@lst.de" <hch@lst.de>, "kbusch@kernel.org" <kbusch@kernel.org>,
	"axboe@kernel.dk" <axboe@kernel.dk>, "sagi@grimberg.me" <sagi@grimberg.me>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"gost.dev@samsung.com" <gost.dev@samsung.com>, "vincentfu@gmail.com"
	<vincentfu@gmail.com>, "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH v2] nvme: remove unprivileged passthrough support
Thread-Topic: [PATCH v2] nvme: remove unprivileged passthrough support
Thread-Index: AQHaCKQOeOzflIN1C0WozhkHZ2YM6g==
Date: Fri, 27 Oct 2023 07:06:08 +0000
Message-ID: <aesib7wh6jkm6tsvonsuk73pmsgi3h6aikpzf52vbjbak3jspd@kbi4cm2uhsak>
References: <CGME20231016061151epcas5p1a0e18162b362ffbea754157e99f88995@epcas5p1.samsung.com>
 <20231016060519.231880-1-joshi.k@samsung.com>
In-Reply-To: <20231016060519.231880-1-joshi.k@samsung.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|CH2PR04MB6950:EE_
x-ms-office365-filtering-correlation-id: 6db66b94-86dd-4750-23f8-08dbd6bb318b
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fBNYLWVFlsximDlqZQ8JyIKIzKHvv0tVZK+7sQK3iFTZbIocHp9aQDmkrU3yM22CovZrVCu0hoVslc+b5Mgp7aBR8z+OPAy0EWUgfhfzOq0/+U5Kx4JjItISY5mjf47wOvFiFUGaYpp30jkwY+cHfImuIGePeL1DWKdIDQZewAfG7FT3/C35Bv1tioxNKNgwFRzzqE/Rgw+nOOSOxmOPYkkjAabMIwEEeNYUnufIbnct3PPQR1kNrTUbANYM0APCQDXfC9jJ8BLPN0zka3J1LwzIKvZi67fuonwCCswxDF0yWdw0Fnz04Vvycz0bpOzegoztf1UW9mxT4fZw/g3CTbbaoBD8exaWWcwsKZThd1eaRNtqAyimaD59QYOY/rrQ1a/oqAZNA/xKd/dZd3c1ei5LeQ46c05H5mfULgWMrkaik3ANj6Em9ntYHje5faFl2zmQ4eN1RSSiTNYknr2R47B+I8XNY5Mzqm0V/lru9wWYXUcX8uMxS01Mxyc5M/3QNliIVgbxI3q2VGhO8p39SAwD54Agp1NoQ2DM3it/7upgL1N0XK2RlYRZzu6FbLKjeD3XBZ2jdlwjHmfvNkstTdQJUSaoJR0eIyRqIuYP1es=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(346002)(396003)(376002)(136003)(366004)(39860400002)(230922051799003)(451199024)(186009)(64100799003)(1800799009)(9686003)(6512007)(71200400001)(478600001)(83380400001)(6486002)(966005)(6506007)(86362001)(82960400001)(38100700002)(122000001)(33716001)(5660300002)(66556008)(66476007)(64756008)(54906003)(6916009)(66446008)(26005)(2906002)(38070700009)(316002)(91956017)(41300700001)(76116006)(8676002)(66946007)(44832011)(4326008)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?0qfRVTEkcqNTnQcVhL1kRvs7DnfJ5/hNxj24Myx8wbtQoIuy2C12FzsPKS/E?=
 =?us-ascii?Q?ksFvjKNt2IDwpDi6gQMBI/1Mmt9qQ3I43Rdk3l/S16Fs4rcxHDXmQKbqxSl+?=
 =?us-ascii?Q?OeFHFLb/7ANMYRxCjLhGEoKNFQsgF69oep7L9sgVe2DiItBDA+OvjMqrrpsq?=
 =?us-ascii?Q?hq3/Uej2McH6J34rXglGaViyEsM6NH8gel0ctNd9hEH7+xukRWvWg7PLksBB?=
 =?us-ascii?Q?JjcDiFibH9SLUdtYRNtccjtah//Msr2+9lGnW97wUQqx9ftLChK2FCPcv1cT?=
 =?us-ascii?Q?dIh+EqwNrjBbiRhITXJWskqDA3g3H0JMc/npew12FFQYkd20K0moLmUghQJT?=
 =?us-ascii?Q?LnDNdW5JwgN3wgqipMA2pbH5y1dyJLq1m9+gTgesTLRx4jTt67Bqt1LYpIi9?=
 =?us-ascii?Q?C7x45fSBQUXvrxgOjo+zRheglUWBV9E2904A4FBYwOe6uQJXHLNvEmSb8MvP?=
 =?us-ascii?Q?axs4+6P0Q/3PK6SxU13vXOQbpJQQ8qRSJAGratxVQE8n+HeHSRYT+Mzy2S4k?=
 =?us-ascii?Q?zLXIRAsIoEuuFcV0WGHr6OjHjxt2W2D+d34CYu6Fi3zDqwsTFIOTVYjK7Qpu?=
 =?us-ascii?Q?KfHhpzrlgIOr2FRVTltNaoK2/GiqBQXFYm1pIAV2V8YBBq/yYRaT4oCTKYSh?=
 =?us-ascii?Q?4VLazDiyl+II0abHr83SCGeGxfhqN5JKucWTtTuTdXy2wv5MJqec1m1MKdGE?=
 =?us-ascii?Q?dqTxCVI2H7UQfrR6VK3hvguacoR7WWIunFbPKMnrzzTvdsgywHwsh2k6JI1m?=
 =?us-ascii?Q?VpkyO6GjJbtxGcjjCn7J3mBciyZgbK7/WVGVmDt6NGPNMEVYEtD6GzQD4p1N?=
 =?us-ascii?Q?QtQFhyq0gAMFiXf+fBFOg9Oz+z475Ugjqocl+kh0/8F+7tZyEyd4vFZxhrlk?=
 =?us-ascii?Q?7+JBhC+lCGGdSpldIYsdmFqwM5X5+8KyVx/qnH1FTV6WSCcWMSxU77r8QaGA?=
 =?us-ascii?Q?9D++ANC8iNqUYCMpGvkzv7MsImKdGUWCpmon9sbjK/MsbfguBcAKOSi3vHHZ?=
 =?us-ascii?Q?P3u2hRru1GdDxbbRM/9Gqmn1P1t4mfZiYhGC1H828dNFp5XWqZCYIXMdmGaB?=
 =?us-ascii?Q?EtJ074VOiXv/xpgvvx3cYP7xIdh2Y9o1LDQKc8H1aaJTeeOEf4lSj3yjdIhi?=
 =?us-ascii?Q?TNzQeEbRMXIYGLQqcPSsHJufLBKNYfy+dglG9K0wt+WZ5lK8roRgJoqW159a?=
 =?us-ascii?Q?j2sNHqWEkXpv+3VhALz4mp8E7bk/q1XDSdGS119dgzuN8l04JYXqwlCidmlz?=
 =?us-ascii?Q?UIvPOYkMZwYudn58WCFj3LeaFUCh0b3H8snC6ZsGUI61gU3BsKqg2F/rbTDZ?=
 =?us-ascii?Q?HHkWU8zh2QmI3G3jGiQINhz4X1ceurgsOEnz4K8f8wHTSpqjyxDkz7+SpoK2?=
 =?us-ascii?Q?5hmAJzwriuABgP3wGz5qa3SGw2UW4N2tWWpNm6z2Gx3tY53fi+73BxqJxlxI?=
 =?us-ascii?Q?5TwTzQSOSakoXkweMYovEBW7gojYHdp6Pp/f8LzSzCujbhRVkTtmELt83NXk?=
 =?us-ascii?Q?GYS4z6dumSimn5XfDDeUQg2D94iX4JhcfAtdjCjm/WYfBwvA0JsC54UXYLVa?=
 =?us-ascii?Q?+uu0/RGlYhpW3BJ8cB5P/ri3qCdVJF/fVVOjh1Bm6kvEgWhnVKcx0UCtQPVG?=
 =?us-ascii?Q?YXubVhAhgsERNnAT4lfPH5Y=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <F8CBC3BA85D2A54E9E368695A8BFEA52@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?bYMXZTmLMsVZ4xBuoNGqy6AyqOEep38nzV3F8WME8hJujvCqns/iB3jLoq6c?=
 =?us-ascii?Q?vvq1eAGvpBKuRX+9rnM9Quy6mxmg/kamLsCMPkTGW8vYsxhSiVKdInTqpO9x?=
 =?us-ascii?Q?QQv0mkBUhhRokBB9eHyA5FtRINyNvsgq/I+fGlYXkhpoyjVh9FA5MLfZef5e?=
 =?us-ascii?Q?gaXlCo6UPE7ZvD23mlnr8Nw/8KFITQ2stqfuTSirZeNgR/+n9K0LXJh9KbHa?=
 =?us-ascii?Q?TLXbtGyoeiB1eXeVvjKOeW8/+X3XJkvbLCiGAbqYXdPXbTIeHWjhV9r7gS6I?=
 =?us-ascii?Q?WbZ8DZwi+a3HAZI/XSdpCEnnuhRcwD919JAPBz+vyMxCsYCr8+vAu+0wMqTs?=
 =?us-ascii?Q?KLwRs90BLRNqAoaZoHod7fyyJJNBgbxh/DRu3Gkz9oklVeD2+DqRG+cHORew?=
 =?us-ascii?Q?kjCUW1ZbaHrM1VgwCwHcvgY8NAXDPpPrUC/8muoVFKBqwncZGMi8A0+58/hy?=
 =?us-ascii?Q?KmXApzZINj+DEJT+A31l3QBMt+qHm5ktAtosaQsv7CN/gQxXCMPdsmn7U+ys?=
 =?us-ascii?Q?w3fJNvMOJNB34HwTkzlQpzOMgzuwu8FsfXfBWGO/eMbEE8bIhIuQxKI6CVN8?=
 =?us-ascii?Q?LIZKNeWigqt53H/KLfpWsel/BskptYjGlXgzHe+KBcVDmsOOv9lRYmZrk3Fq?=
 =?us-ascii?Q?VdqwyL52F7GuMQMct7RXwQdiqgtMF1q3KLNctl4QcUhdbmqr8m5eH3nJtI6j?=
 =?us-ascii?Q?3VehkMuLQr4sPyz8mcTPA7wSVD9TbWJC9Gfv3BNxC+Vpiwb+i3RsVN9bIRuZ?=
 =?us-ascii?Q?yrYUC8cd7syod3XvMYzKVBrxy7nMQfPDkZZTJXDjpimErzB4EyVGRMSsU5Yv?=
 =?us-ascii?Q?IZcTT02dWwPxsnWkd1bc20MZWu/NCon+1WNo9fF3O3Hu0vM5Zne0eAE+L0hS?=
 =?us-ascii?Q?JUMZDFHOHofQWCJaD6D+ijOpQ337yS+14MQy6BSSXk5OW2/5CLKpwLxLANKP?=
 =?us-ascii?Q?m3Mn5kpfw1pLumoyaBSaDuKwB/Aldb6qB1y4r0u0SmIlscIwNXWOm5t2E6tw?=
 =?us-ascii?Q?qMl9?=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6db66b94-86dd-4750-23f8-08dbd6bb318b
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Oct 2023 07:06:08.1433
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YtnrAXUjTNGFDc68K1kyqnzZISUDyjPtbDGPnnsy5CFtmXxuhKf5Pt7+xi7eoMRVygTHS3fR+RUfgGC6ckgz0f+zEovOkOeWvxrlJX2RAI8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR04MB6950
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231027_000619_037985_12CD1AFD 
X-CRM114-Status: GOOD (  12.99  )
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

On Oct 16, 2023 / 11:35, Kanchan Joshi wrote:
> Passthrough has got a hole that can be exploited to cause kernel memory
> corruption. This is about making the device do larger DMA into
> short meta/data buffer owned by kernel [1].
>=20
> As a stopgap measure, disable the support of unprivileged passthrough.
>=20
> This patch brings back coarse-granular CAP_SYS_ADMIN checks by reverting
> following patches:
>=20
> - 7d9d7d59d44 ("nvme: replace the fmode_t argument to the nvme ioctl hand=
lers with a simple bool")
> - 313c08c72ee ("nvme: don't allow unprivileged passthrough on partitions"=
)
> - 6f99ac04c46 ("nvme: consult the CSE log page for unprivileged passthrou=
gh")
> - ea43fceea41 ("nvme: allow unprivileged passthrough of Identify Controll=
er")
> - e4fbcf32c86 ("nvme: identify-namespace without CAP_SYS_ADMIN")
> - 855b7717f44 ("nvme: fine-granular CAP_SYS_ADMIN for nvme io commands")
>=20
> [1] https://lore.kernel.org/linux-nvme/20231013051458.39987-1-joshi.k@sam=
sung.com/

This change looks affecting the blktests test case nvme/046. Should we adju=
st
the test case for the coarse-granular CAP_SYS_ADMIN checks?=

