Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53BC6C25B74
	for <linux-nvme@archiver.kernel.org>; Mon, 27 May 2024 13:16:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=pBYGvHEYU92GWsh2nZ9Vn9SxGcJwfP1MBH5v16L5vzM=; b=TAcVeuqru2Mu5+oO2UIdloXDbH
	EnYBQJJbU/Q4AZljXG7g5sqy59i3nFLvSkTWIrBWagkgRYvlca+hTVfi1NxuP/WE3lNv7l6fInxyC
	ZyhKm4KP1yk3r6ODEkCkkifrWZItE08QyUyojZiLflMSC8DhEoZCeHKUJjF8VCujRMT/1BFxnPBzj
	Sggydrp7RaXXEMymQyYKpcCCVtaN4ZXsRzvXtaSqmAjRfaKGgjQlXE6fuGzDP6C/5fwfDFlvrrMXe
	VZZxyo7zqykb++KGbLqrWXoiG7aSujZGQ3EcyBQsduGQURIajQNb6PQYnt+N7zB4srr3nzEYlY6Gw
	OmYniYzw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sBaCq-0000000F2JR-0Lan;
	Mon, 27 May 2024 13:16:04 +0000
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sBaCm-0000000F2Gx-2dc1
	for linux-nvme@lists.infradead.org;
	Mon, 27 May 2024 13:16:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1716815760; x=1748351760;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=pBYGvHEYU92GWsh2nZ9Vn9SxGcJwfP1MBH5v16L5vzM=;
  b=IAi/XI4EJEW8gykdOaTyUeurnmWbdO07oleyPVYtUSibFX0oPoRJB7ju
   EkBoGKalLe/z207lw/jlhyxJKEa8lvJsi/BrxOykbFjK8gP3pwpZr6gwn
   9p3vEsgz+Guyk7S6s6kuOVtNVw/QTkGSNWQ7s6E7RxRXCXqY8n0Ewd//2
   bYnCQKS3eNUjRCvg5svmzQn+7Mh+UTe/MuP1qazU7Ab9hOc+BG7Df4BLg
   mycyhcSFRNrjnPH1kC/7LOlby51lY5OFu46r316hIlVa3s1HqOq1zIHUi
   W3bZoMfuclX3dRyXfh7wY9EowMVIujeKs0E5mdnxXltO75SZ9orQv9l+a
   g==;
X-CSE-ConnectionGUID: nZniRHxEQkS7waxEnUYLOQ==
X-CSE-MsgGUID: N/uNWM+2TZKXZBM1p9xjig==
X-IronPort-AV: E=Sophos;i="6.08,192,1712592000"; 
   d="scan'208";a="18197269"
Received: from mail-bn7nam10lp2101.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.101])
  by ob1.hgst.iphmx.com with ESMTP; 27 May 2024 21:15:56 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BqJbDkAJFCRZgxcA1Q5HJRFA5uVUU7kSIWMqe8Q5BwuB0GQzJDxECUn1TWSChdZQ0Yr4dM3GpODrBe/DmndDl/nzObuWPwPvEAQ47ch+dYb12gyCRFoa3WB9TEDZLfyOjhUkSVzDM/cAgQbRNQ0/2AjBNsgZ24Xqy/s+QpnL23h8kyTg6dmokfywLobEL2+l0a6DC/a+ZPYREjtNh8GNv0+ddp9zmgmsTakQoSKUxpN5z/e8wquOOIBYRkM72MwO2oyx96D4paIzmycgalY/nz2SLOAFX6lOgyTGiL4fxZiY3BgZ5pdYJbxWSkkPpl9vFpJTnw/EH68SyUeuAKihgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pBYGvHEYU92GWsh2nZ9Vn9SxGcJwfP1MBH5v16L5vzM=;
 b=XSubOWKDjG9pfUPhDmn8rlpZ3nY/VejMNOH/thK18UlpJH8EOD5QOyxcCy3zY3Xe/XI651wPRf6paW/fpM4ln9EK6n9yPPrGMHET5ERv8EIJnaJUU/brREdCsNELjYNZbHrxbdKClMa6mcJ2/JCpLbFVRZX5Jf2nNaG3DAjxzHZUbxxwrbsLrIk06VUVaCqo2doSm+nc3pGsWPP1f9bvCRdFXCjDen2H1NszgPD4IzZWaFecsvuJkxJPFqudhYieSpYjA8CsI3xtnvxY7aLeiikVXgHzqQFiSF1gVHDaEkW6T5mRBUR+gFSJkUsXNWJlXJe9mqU90dPdlaMC1vysIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pBYGvHEYU92GWsh2nZ9Vn9SxGcJwfP1MBH5v16L5vzM=;
 b=dGifLb/wfdGPn491AioPdT6G6gerTlZFivIz7weBKTMioYycCjWKEV/OkWw9q94NAQdQj9KsD8an7kWQ64WeYprQb17V3gPksd7TlKTkmnKboAAxRnrbp0zkg0UXqA2VUoyOuv/0r2V40DewYcYO/WFDPzz1W37M5sB3h8UE+TQ=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 SJ0PR04MB8275.namprd04.prod.outlook.com (2603:10b6:a03:3e7::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.29; Mon, 27 May
 2024 13:15:54 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a%3]) with mapi id 15.20.7611.025; Mon, 27 May 2024
 13:15:54 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Keith Busch <kbusch@meta.com>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"hch@lst.de" <hch@lst.de>, "sagi@grimberg.me" <sagi@grimberg.me>,
	"axboe@kernel.dk" <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCHv3] nvme: use srcu for iterating namespace list
Thread-Topic: [PATCHv3] nvme: use srcu for iterating namespace list
Thread-Index: AQHarfKb6+C2wAPQEU2JMNfmpCKGY7GrFBuA
Date: Mon, 27 May 2024 13:15:54 +0000
Message-ID: <zuydj7radkqstndzah3hxqwoq5m3dtto4en7twfwtejzayjlsg@mcduoyuuixhn>
References: <20240524155345.243814-1-kbusch@meta.com>
In-Reply-To: <20240524155345.243814-1-kbusch@meta.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|SJ0PR04MB8275:EE_
x-ms-office365-filtering-correlation-id: a23a440c-f5c5-47ba-6e6f-08dc7e4f23b6
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|376005|1800799015|366007|38070700009|27256008;
x-microsoft-antispam-message-info: =?us-ascii?Q?0waUjYiW2ruTebZiDPwob9bGziMa3al01vYtKLEOAy42NDRgURBUgJenTjjj?=
 =?us-ascii?Q?mQhCOV8aj3dVYq2XeA/6pHC6K2EOxA4fqCJWeTORaNmsGbXCWueVrSIJ2/pO?=
 =?us-ascii?Q?Zom0a9f7XE3Suit+Msn8e1ucoZxJz+Yt0XjJXAB3FM2dv1PdoUIsKmHQUean?=
 =?us-ascii?Q?1TlQ8o/cP/uF+kCIndzFPugFjuxuubKN7srkzVB5IFxHWsTLDufhMST9dPbA?=
 =?us-ascii?Q?kl9FqkMa9bKnB7P1j00yEKZHbX3gEC0WstFrHQgnDzppifFYAMITJkryMwQz?=
 =?us-ascii?Q?vXp8vUBExDQ88ybECaGkS7s4p9oaWSMApdM7CziMCrdYbM4CjAelbLMZJ8XC?=
 =?us-ascii?Q?ulIkqfkTfQUjDN0Ogn4Ue9wh/tC79PcnIbEkbtplMzPRcQmUwklRVpd8dQBz?=
 =?us-ascii?Q?QuVl90glAwaDa8F3JR/m8TZXeXLP9OCvC3o+rNiMUbLjf5bVLJ4cr2FsbI7b?=
 =?us-ascii?Q?DELFR9bhx53f6+SsUBseQ3snV/3wWSk3IhoBZZOtxIYW6haDqiu0/T8Adfxq?=
 =?us-ascii?Q?cg1Mfj5OekeSaN4qjbuydR1g/3IQJM1RCKUPtVMMpT6l3moaM+7d+bkmOCHK?=
 =?us-ascii?Q?Qbsiug64kBI4IoyCywS9xvkhklpHS/5/nBgPEB9rG/om9yorRZ6HYK+YtOUW?=
 =?us-ascii?Q?Jj3lCz44qGXDAMyY6iFbRnq9U7SmB01z+LHNXDFHmKlC1hZ74GEezd4TZQgY?=
 =?us-ascii?Q?uUN/3SB4Tp/nxImemuuwNFamh7Cp49csUUPlCTjKzkWlDlM4wVmOcApBv1LD?=
 =?us-ascii?Q?SSAjzXT/TvikzGT3Yl+REmOUl+gH0D2ZyPBWW7cHaDOISxmWLxycW641tosu?=
 =?us-ascii?Q?wtrZIYLaWO9HwyP2HdCIufxG603h6agEgNjRmrjg/gm7VAcWUiPrRC4bpWiZ?=
 =?us-ascii?Q?hDlSaS5QUdEmQ9Q7k40cAWLA8m2LMj6NeV5xQXdaSTrwxomHz2MH14yM2A9Z?=
 =?us-ascii?Q?1e0Z6tDY6amttte0QUOx5OfSFd6Qb13ualOOJPpipsUYKQ7uXC1uRZtbGWjC?=
 =?us-ascii?Q?gQqBPYoFILykwrN1zve2EZ/gjMya0TAQgonNtDV7L8E3s26TEdjDIbhORqb+?=
 =?us-ascii?Q?OmaambynaJsHiK9UfwrszGbXMYrVgmAV5IcoqGp5u+zFRaWxn+ZqbnqEovA4?=
 =?us-ascii?Q?gyfcM/6BzH2wpMrkJ5BURGPMT5SoKNzwzP8qYFJ+s/x0wfyw72x0QYpXMhlH?=
 =?us-ascii?Q?tFlNA7e+CuCo2FUfOM5DyLjsldoPO7IAxufmHilJKW0Ca9iFUJHkdCFb/8LV?=
 =?us-ascii?Q?HjTdipl7EXZ4XVAm46fychJP579Jpf5Ymhb2Q63RKVLqXyi+/K/LLfLzUluX?=
 =?us-ascii?Q?krruXdk9z0BS6ap0882SB0jE?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007)(38070700009)(27256008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?/s2cruJX00+740FMyQYqPoC9pYRFSJQiLr1g1yA4CAVlWkPboxe+PA5rG1Q4?=
 =?us-ascii?Q?7a/JPh6+EEcNhwsSZn15NinIXJ89Nhzo9P8D8ZXFmTfSJ/L4A74a35PS6K4R?=
 =?us-ascii?Q?g2F9auCH14lvRW69OQSLgG7BpObAbPzGSnw8uIsAjdSQUB4KGdxK1WB/jGOw?=
 =?us-ascii?Q?ZLcH76aFRtBGDTKVvmMXnDGcwi9OsAPJDh4dJmduM5aAirxXl+aXC09C9tqx?=
 =?us-ascii?Q?qsLR8HRyJQ7al9ntZHiFDvwxuR1OaQqtei1gUCzT67Gx+PSPupOJT8M75/mp?=
 =?us-ascii?Q?Zc0pYikFjN2/pEBuJ6yDHrdahrFD4IJjQSJNojjsy7IiziM1KbID60F9KlGW?=
 =?us-ascii?Q?G2sCGldCorGVr9Rdnv1XQUI81b6cWA0X83FU1nZWeyY8JFWCSzI6jA6uhO0l?=
 =?us-ascii?Q?Iv/UCSvaf1qlwUIT0vCtNBXO7uVPGaLaxGvfRyPzV1FPNcKl65nWlkdnREGQ?=
 =?us-ascii?Q?ggZmCMUyC6oa3/4qAIgbtqriAMhBQNScei+j9+6OmWfCBxUZTLt+UBJ5Coe0?=
 =?us-ascii?Q?hT1uBCac/zcMNXOqPQPp11Y/SHAcOhMo/i3Q40gLeTlHj8rj2OdE7sIhZEso?=
 =?us-ascii?Q?DQQCqJgsdYu9KOgytUUEMaxPlH6iuKbtKBAKyGJzyvZq7YyBWTRK1DwQFwVW?=
 =?us-ascii?Q?ntll4kD0+e+AqT9ScL6csb0cdwA5drt6CUlubybr+nkO8GZqRjUMZdMJpd3W?=
 =?us-ascii?Q?ogy+4atFae5qGv/+UW/EZ/SUKGSgEtIqHGLaXuTdFBXRIRkxsDygALiC023P?=
 =?us-ascii?Q?PeQtBjkVcqALO2S9KjiC8adNhQJ+YWmnAv7xiEqNB37HKpaOFzfoxO/j0Qw3?=
 =?us-ascii?Q?4+hpMEzEOBA0ZE0WjRvdCQ5XnQQhfi2IcgNa3Ndu13GGIswGFfYJ95673Zej?=
 =?us-ascii?Q?vb6/v/2o1yofAGDpmvbx/z/a9Tvo7OPu4IXkfnGkjTs7FSsmoAg6EndoULjU?=
 =?us-ascii?Q?kZNBdtmRCXdhiRTD9gbNyLX5Pu71FnG/IPOURRmEq4WctXbKpX4tWTHGcare?=
 =?us-ascii?Q?rgPB8adhyT2R6UJOrdBbYENYEJ5JezaKEINL9SbjU4bS/ICyia6mcmoC4CTO?=
 =?us-ascii?Q?6XfrYtXtB9bvijpQzCSLdkpSiKLlP8QCO8XRsFH4FVHLBZ/1hMduKjRtOcWf?=
 =?us-ascii?Q?Tmv4s4vIKqG2AtX1Xbxmrcn5cQHRv6WGgqh3eaeHRrBXVxLnO/MdL8I4HtSE?=
 =?us-ascii?Q?q15FeCVccXjFNtGFeIejMXLJeVYI4eL+dV24/eSBOmfXWqEDcW62IDUqfAQr?=
 =?us-ascii?Q?MVtmzzYMbXk+cM0P6iJMMUSSG479aX9mDrav5WL5DG90fS2SK8KtISHibfc8?=
 =?us-ascii?Q?543T8uRXEMGiWDPrIW21R7xDfvfUTbxA5M8wON4eRpB2E5ET2Ri3+Hy37c0v?=
 =?us-ascii?Q?2vHbg/ovbkd2MjGEvRDZ5Kwoetk0YtpPhYjMi1so2WQpoiPJ1znnaO/zdrq7?=
 =?us-ascii?Q?CoGjSzz5FyYfr2GiX+NICfLJfFcVkGINw2dMWY8TzstQzFcs8jYmWPBcyRyG?=
 =?us-ascii?Q?lMVqVi5cFtJDW1i+32ep0F0RN28j5Wq3mlOXmclMFdSjqQuE40ez3X6X5JPw?=
 =?us-ascii?Q?HR2ZVYCuxTiwm33b9NmdAUB1X3lrnbAQpcUQcjj0AWCao4rF+oHGvmDQVJr3?=
 =?us-ascii?Q?jLhb/pUma9Xa5Si49GirwuE=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <B58E505C21F13E4790C330BC67127DD0@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: G+OKYQS+HjaBjWCz+2jA12XkBX6NH5omZUxh5NzuvqU00ziWznqBPYjZ9U6M4MsFzqnX9uM3U4NvN3S3kiLjyYZ5rJ7itvqY3WhuD6ktagr/yCWhhE5Q6I1G7cm8UIgHIPEEjHfbX64xjlUNZE7/KujhDndSOSZDA45iwk1I5yYq7KzmklBk4dJbVqZINCS5t5Lerjje6SHugRgkH7WN0hvp/n7kHh67aDo32SqI2t7FJefefE5E5Vu9ElovtnsbyfMTpo5nIs+VfFIqW4OmhoNQvZTJSI6nmjCoiZKJ4jVmHIJ98YcMzR6JSZWBSV+le/pU3AJQ39xo3zbqRwG6fCnPgU69JS141bp2DOBQ9KplUftMHFULs7lM7UJRCd2+VDRDxQ3kOxVrKDHv5WdxCqfdw2MbU+bvRPb4tAYVBPzPxXZ2A404bRjiqQww6R0TIDIcIRD5l/rafkuvGhYhh2Ewrne4dH1qcqvMsfzNr2Yr10GhKu4FZcKoRGiartVkzRk6/SttkDQ2s/WZi5z4f+8cvrv3zgtH35ZUI6BNXgjozbB39liG0tvrQQY66omaVP01FvGLyN2Dwiq0EYECgk7LJYoUnL2L8/FmyTOH1Z6+IJ+sN2uGzVanMDzpSZ13
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a23a440c-f5c5-47ba-6e6f-08dc7e4f23b6
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 May 2024 13:15:54.6038
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BV/z7mBpkvuWQ7yrm1RBmR3ECZx/kcJYeCSCRov3oHRPW5uStjvXCM6ZR+Wy4BubSx3p3EdjjPzMZHLEIvBx2YTTIj3q3hPbfctDRpG4m1Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB8275
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240527_061600_716237_3FB8EE26 
X-CRM114-Status: GOOD (  11.37  )
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

On May 24, 2024 / 08:53, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
>=20
> The nvme pci driver synchronizes with all the namespace queues during a
> reset to ensure that there's no pending timeout work.
>=20
> Meanwhile the timeout work potentially iterates those same namespaces to
> freeze their queues.
>=20
> Each of those namespace iterations use the same read lock. If a write
> lock should somehow get between the synchronize and freeze steps, then
> forward progress is deadlocked.
>=20
> We had been relying on the nvme controller state machine to ensure the
> reset work wouldn't conflict with timeout work. That guarantee may be a
> bit fragile to rely on, so iterate the namespace lists without taking
> potentially circular locks, as reported by lockdep.
>=20
> Link: https://lore.kernel.org/all/20220930001943.zdbvolc3gkekfmcv@shindev=
/
> Reported-by: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> Tested-by: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>

FYI, I ran my test set again for this v3 patch, and observed no failure. Go=
od.=

