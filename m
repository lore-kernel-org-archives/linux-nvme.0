Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C76D0C369AB
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Apr 2025 08:01:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hZK2gWykgsSlCoEc0s+hFznfGd1SpNgij461p1rCp/I=; b=vQubXzGUKJEfvAqWb4nM95ZOva
	hH2EcfFlKo0P6XcSGFz19mL009GUykPOi56WxNyjxW+H51kDHXx+WF7wKCzQ4DUceuriIOrdqfp/y
	EK0jhWGZ0UHPCmDzzP3hcdEwega6kJNfMI/vtSG/+FoWDis/+UsMPmQmLgvAJ/yE0Ozmiw/lo1Py/
	JvIikMobghVsiS2Q7vGKv3QL8LJSEBOOeRKfrRJv+ExHdUArvBnXxl34AukWYeYISED6sQWw5Zq93
	XD6JSTqlFhbagtRslcNpveplREsneB3NqPXM0KXE9Avqq2GptvHXbAs+216fp+fxtX1kymJhdgHqD
	VjT//ilA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u4bEN-00000004ugu-1oLw;
	Tue, 15 Apr 2025 08:01:19 +0000
Received: from esa3.hgst.iphmx.com ([216.71.153.141])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u4b1I-00000004rWF-1JKZ
	for linux-nvme@lists.infradead.org;
	Tue, 15 Apr 2025 07:47:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1744703268; x=1776239268;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=5OIGJUvqZ4Y3QoR4jIeCg9+HoBd9sbXtqeHm+Lk9ywY=;
  b=rwQ50MtBD+IfrR8ROsV4oHAF38WhUKFOMaFKCPpV7CagE4L4OEJymKd3
   drlcF0mPL+F8c31x8XCx2aw7HE7cmr7FKiP/7w9D4Arae+OVP6zWMO3Cs
   aZts+4wJUnKKFieaWcu6tN0J34TyZg8990EJvXrdgcLirMsO8iSRZfL03
   wSMLobPJZUNeapMNTNazI8eTuXcUQDb9iQ7WXzpc0Y1t5sVWON+R9LK+h
   dasIFkvWINZFgr/yWJ6vevYO0KmG61C64G1J1lQGNKxxtrX2VYxY+gx3M
   ENMZVsakGJR0Im+7+Y9FdtDUs9/1XtyHOZD3nzLlrDkF+ngY5NtH+ySPG
   Q==;
X-CSE-ConnectionGUID: 9W/n7Qq1Qb+2ELuOCtSkaA==
X-CSE-MsgGUID: 5ZvGOpxZRa6m7OHNE0CAzA==
X-IronPort-AV: E=Sophos;i="6.15,213,1739808000"; 
   d="scan'208";a="76808485"
Received: from mail-eastus2azlp17011027.outbound.protection.outlook.com (HELO BN8PR05CU002.outbound.protection.outlook.com) ([40.93.12.27])
  by ob1.hgst.iphmx.com with ESMTP; 15 Apr 2025 15:47:46 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=miJi82o1LMwL/x47QwbNpE0eqedA6vZh+3D0OWhcKFlWRLLExHnt+qd/tQojOhym0wltw8Ch/p17201e4qMUwBTSaEEYvY98N9CdmFnDomPxoJa+4ssYwFXt9bVku+ktSube+rCGYy7Sv8PcRJvJwky72sky9EFTNcPl+zw2SstWJghskp08gXajAqTB/T7GvuAq7ngRZUttDM/b5FW0knyvSfNXl+FGAzmP1AkdnFexA2aEkRKbRKxQEj9kZJdU2JOxrMhvr3bYZls39uI0l8/NNNJRWJVpG1sgZCyzK79T/XWAhW5ASwbSoJoR5qC/+j78qia81hvJFlqbu+x3cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hZK2gWykgsSlCoEc0s+hFznfGd1SpNgij461p1rCp/I=;
 b=rR5Yk61Z5jocKl+3+ZTn+6+cwfnYo39CLvJfshDF0DW6HhBXxUTDlUTNl3+vuhbaJjtWd3UD9D37vRQ0hPPWzoPjsnS6PaFagz+udp0vm0choNDh17jMZcDk1PMAIYsRuXMs4uOkKPT8aHhWpu3UBUoUExIkTWSJcCn7TACAI7B9686d/bTISHa95V1/nqlH07kf6InSY1z7UDoqYnUplz5Lr4lKmkaUn/n930C/K70UcteoTy/3cW5fxGM1p4iY6ZN4lgeZSdijDY7QiFrZAZATdjjPIxM7uBil96507NKGjYq7JDlr9dzrYo6gncZQN41Dp+0I/JuoXjHaBcx2lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hZK2gWykgsSlCoEc0s+hFznfGd1SpNgij461p1rCp/I=;
 b=bOWHHrNzzInh6CJj8L4+WyVVR4kWIPmgzA+He7QU3qP5YMiWjuRCgExfXgvwn+y7CoW69Z/Lrbuy18TL0vrjYKaV5/3L+fx9qaPJlPbNq2jZlGOcB8e2LPplte1pfaLV9mVUzG088yOz4hn4P1cm64Cqz6QmS725aMDkYCeUDU0=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 CH3PR04MB8813.namprd04.prod.outlook.com (2603:10b6:610:180::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.31; Tue, 15 Apr
 2025 07:47:43 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a%7]) with mapi id 15.20.8632.030; Tue, 15 Apr 2025
 07:47:43 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
CC: Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH blktests 00/10] nvme: test cases for TLS support
Thread-Topic: [PATCH blktests 00/10] nvme: test cases for TLS support
Thread-Index: AQHbo54k38R8mBe2bEOZYmu+Ge9UOLOkbhiA
Date: Tue, 15 Apr 2025 07:47:42 +0000
Message-ID: <nab6xnd63ose5yqawp5q3nwrgcfi654zveat6iiccci75ob67r@mkfarprb4aeg>
References: <20250402070906.393160-1-shinichiro.kawasaki@wdc.com>
In-Reply-To: <20250402070906.393160-1-shinichiro.kawasaki@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|CH3PR04MB8813:EE_
x-ms-office365-filtering-correlation-id: d9a607c0-8962-4173-8f98-08dd7bf1cdf7
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?XPdhfAo/EUlcSX2F0z07nbhPahbFopawZL/+eafZvrnqbG9CG3ZqS040eU0R?=
 =?us-ascii?Q?B/pkbbPq38hdiZQmzso9Tuc2VFd3b/o63/llYIHpNvFUhDCDEBUsMFpsUJe2?=
 =?us-ascii?Q?coOyQKErAX9agR0V3IRr/Yi2OwqPc7rNHPnPTQKAiIDtd3yYEjTEL5vsGgLm?=
 =?us-ascii?Q?2qE+1dVmTey2CU88qpwNnkvrUFInnj0cyKgMuv3tpYHm88N/0/wal0c2B7US?=
 =?us-ascii?Q?Lb5S6GW9jmXTRL0EZQbWOIiLZDv2b/4FXRjKm/0QQrdKwJsLG0cyUNx68/8F?=
 =?us-ascii?Q?jO+Voz0dJMImcNWf1V0YeL6o5NRgMxccOdRxGPOYLgqdUltGw+6piqkIa3Wm?=
 =?us-ascii?Q?h/ZKDdE8GkrbIKgyNZSTSnfGUav2SPqN/ogMrex/juAYHMNjyPVbu1zYsAlR?=
 =?us-ascii?Q?KQPc4yI+CJg8VdJ25vxcojbcl4GZyeHNDmdR1UlwPgg9MqRMIR79j3JJI93u?=
 =?us-ascii?Q?ROt3n4FE+1t0qrX0sjpVVhrpgnY5KJy4xjCEfppEqIML6TnqrHLlMuFg/OEl?=
 =?us-ascii?Q?BklV7JIJf8Ilwas3GVH+avGAUh4ui4Pd95P+MUgC6t8BiQVNTC5EbLzf0GaR?=
 =?us-ascii?Q?2gMa9WKNfMpoCkz6oAkOT+D48RlxQnvrCBNwcszMGOWLNZFPDeeWdxxH1Pns?=
 =?us-ascii?Q?lHTs7zWvf5cw1ckm/7eSC3xvXs8o04cG3CHfpka9OJCTwNqf+nqJbrHvKxW1?=
 =?us-ascii?Q?fEkfnWjVrFCbNDUXfLAoDLISTiKTKBNd7ejV9GB5UdbmFFLQIn4MTTGJhPn6?=
 =?us-ascii?Q?JUVyQTJOyULwYDIntYT8l7MfFYHh4Kjm7z1XwuFu9W7o3obhpbpfWN/Gml2W?=
 =?us-ascii?Q?8o+/wrIwUN6LWYdWo6uIdZ/jHcosgGSEYiyFBE79QhSY4MK1NCGFJB3PXWfR?=
 =?us-ascii?Q?QwYwPisbGX9IGHN5bUiL+K4dK4q1jz+5pZEla3HP5ZgoFql9Fi1GnytYevrg?=
 =?us-ascii?Q?9/jgczv4xuDBxVCbA6nkfmuXEUp87F4fLKxYfcKiJ2Ku0OXEm9aCDXWupmxn?=
 =?us-ascii?Q?Z3wgk90axX4atLLfsUwSWSkKU1B0fQUBxlHehS87xkTYGoRcXocBjj2eQwij?=
 =?us-ascii?Q?i03zY6a6oRAcLzpDkFpsM5DMbxoUbCCbvkdZ/U64CIddIplK5KGVryTKS1yx?=
 =?us-ascii?Q?VqwAZOwDbw+h35m/qQtgjjX1Qthshuazc9ITs3ax/s/FWWj4brmNWFiogumh?=
 =?us-ascii?Q?sC/wuSAoMfxOY9saCUdOFdwVtLzgPhq0j9YLW+H6AsXdExiXU4kFzUlQrUir?=
 =?us-ascii?Q?oLzypu2Zb38vTOCiFFugdSOzzVa3uPVV7ZhB/xSL2CIcdDDkTV1A4eEU3zon?=
 =?us-ascii?Q?qf5fHh6B7wJE/KkXRB9sZHb0NpLQ/0pDUCjLsWrmJEUqEj3UnMJpXtEASt45?=
 =?us-ascii?Q?sZZwQlUnEDrRhR8OZ/oCBvHHgt7btbogXu33kYZ+7W0EJ3lib6CSlQqYIM+5?=
 =?us-ascii?Q?cmx1yBhyZFq7LQf7ONSKS/V3aHF7SwHSkmj8vXNPc0SkYyUINAEDnw=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?bxX6lnV4M99a4FxacBexcIDGATrnpwUIoldBUYi6rKElsjmjLFwFwm0ym3JR?=
 =?us-ascii?Q?oOWyjbyJbyS/JGZmgdxspi8azlT9N6LCapJWN/YBnSX7PendkfIrrj9rZ6yB?=
 =?us-ascii?Q?UbPxR6cH6cBGna0MtKkGEs4qEnrV+I9DUkLbfZnnLFZB5EbkGgEX8qSXWq8i?=
 =?us-ascii?Q?eGtwt+VRKeavUEBtCWOv88bSR23ODgAPku8u+D2EdvFy8tlJYZM8bzsz/oI7?=
 =?us-ascii?Q?i59SPyV9/y/k5Egl+egjEFpBGjdbJhV5vbDTQUZ2P67Bib4h1yGFSXyaIXhC?=
 =?us-ascii?Q?I1Jnyv7fj3yjUL5lxXUmXI4HCA1gI14UpJqUWAEbEKJEPD9H6ZX/V6aMeNIX?=
 =?us-ascii?Q?NJB7g1v4s4ZkTpeTcZxyY7hcmGQWbTAu+f2BeTS48doCt736yFMaldzOvO08?=
 =?us-ascii?Q?xx83Rnf/8Hgl4P4xTzX5NYOaiPuTT4TbYQ8VZOqU/o+5Wid/fcvbcxjlMQiX?=
 =?us-ascii?Q?k7QOT/JBE2JoVyRApwyXcnMz4/9ih9lMrPgsJ6tqEn4cxyJFbSW/Dq4YVzPw?=
 =?us-ascii?Q?5TuH10LdXOm3439G7LgWKsI59rWVso8We+xhnq74rODUH7nWZaHC9khTjDW9?=
 =?us-ascii?Q?B958zkSg+E9x6E3Se8xbX96+mfDov5yQMEaDmyjxJASLnpLOQpbtLGuTu1EI?=
 =?us-ascii?Q?ILyIsPluMDUWLRVDy+l9Tpdc5cibrsA/c3zYroob4pvICF8Dc7A7pmCqpU+y?=
 =?us-ascii?Q?Y3kj19brdyhalmgnh5koScsXgX4NREn2bXIaVgeV+YifdBqDuP2LtZREtQEG?=
 =?us-ascii?Q?8dSXs3HSLixELYGhsVBoWJWJL0r6JQ2Lye4LHfbXyWwvK1GRBAWW8csDDk4s?=
 =?us-ascii?Q?flU2cHxtCf3Yus/1rbqjxJ7B7yWOKcr4gminttujiM9TGpMoghM0oMLp76xZ?=
 =?us-ascii?Q?lyK3QHO1uMLLpdplHamWNkUP9oZdN7OX2XFAREEcwdNJ7nf51nLmvOQap+DG?=
 =?us-ascii?Q?Vp/jqHIdkRLB6XReIA8PLENIzs790vpoa9/tt/R3K9h8u7leWFyEUuKj8N5z?=
 =?us-ascii?Q?PV1Yui587CdGduRBjadi8CVEL/SoUEFT687sGTz3IZBCS9huKY4WUpDx0zXJ?=
 =?us-ascii?Q?/B2W+N6OrNzMAfAb5I+S0PG9VX1pmyFRqyZG6WEuf8H3aRW5/qAL8TTI+AMj?=
 =?us-ascii?Q?XCa9qoswDDVAkgMv4r2GWHKwCuwz6XnPr6/i1mQzKI/D37tzCUjEeajcMWcz?=
 =?us-ascii?Q?l/5vkB8QDlllyYZxAiXxbm3pqgiZqotuh7RJ8h+8Wu6It9YtPp6xsSa1HK5Q?=
 =?us-ascii?Q?kqhUFk79n85lIQX3Pq8vpEkbHps6uczHfWqN+CX4iHFnAkbttX84iOCIBXPV?=
 =?us-ascii?Q?QqLPcWnBVp3IhAMKuUpQ++Ydz/gd2Ua3yniKNhElVwh2xCRQXd30Mln03xh/?=
 =?us-ascii?Q?zTiyUDDTV4uaVCBRNri+2mTS7JyRrqO3nUQiz8aLSM0naS4QN6RTtGs+gfGf?=
 =?us-ascii?Q?7o9C8ZNcgS+EkNXYkJbBGNYgEMDSBtMKXg9M8VlP8TZ0RII9k2uHshzpxDzx?=
 =?us-ascii?Q?43T+Bu+t2+/RZ1BsQ8uEk8Hax1v8PMx/C+jvqBFiyo0jUT2oz7jZuYpcmaMJ?=
 =?us-ascii?Q?ok5Bv2Mgt8ow+8XCVz0Vy7BMHdLPrC/o4BsjTMqgU0qfF6/9GbzdyBgsD2y4?=
 =?us-ascii?Q?GJ7JHcDW+4K2vFDM3owerow=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1E2C2BC4726D77408FFB54F59BD06EBD@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: zvNqjRrxcBBpDSewCYfeOrg2UQQU/F9iq1mBCi0Ne3BO3eXRiQEOvNJJh4vOu2m+WIk0nQz43dk75loG96WzpgLAAWkS6QgHkhtsfDtyWQ1Rcze8t5Df/skHW4lNogK6u8j+XgVD8CJrbibar5rdq8OGNqoT10CR+NSO9A9Cdid131Y8ZZhoOcvGYpTOy1esi0NigjttWxBX2ZBwXOrtUH9AnUAir1S/n8VVkO9lY/fNQGzYfJPmFLhztSG20DWSgX8UvRtOVSYZzEqVir/weJ2ZSm8Vdf6XXbwYur7j6qvCbtBFQ0u/uNF6TvS8RHNP98CqKD/6WeqOdaphHe/QkmELG5OSQPEtR9Bc7o1lWh98ZQv25M709eE3ebR33IBmytgsYm1DWRgUmhXqQWM1dfRBBBho8ECVtJCUcK4aB+KFduasqwdSK8l9AzGpgTEpjXSTjNAVbfDdsMGuDgbFTQ031HrasyhW0Aqzt4+BIRgPbuoAxXICfQA0mTPBgwzN9cY6KwGCLQAl3X0c3GGZf5/rwp9IGaS+J8Ovow32p6+OfN75ZZcKBktYnGWWA+1UFxaU3uhnZm4zJZC4YVnpcgNcphax0bpBBe31QPxDEgmgManIXjDHexk99Gml9V+T
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9a607c0-8962-4173-8f98-08dd7bf1cdf7
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Apr 2025 07:47:42.8781
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: H9WVzOY+PkAKbPZ/lGPcA95bQy7hNPReX1SpO1FH/3ivkww3tNGQoAbCEXsR2ILjqzqs0u012LC/iMpcG0MDYzWqdyxItRRLWMxfzFJUO7c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR04MB8813
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250415_004748_355199_2C6F98E0 
X-CRM114-Status: GOOD (  18.52  )
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

On Apr 02, 2025 / 16:08, Shin'ichiro Kawasaki wrote:
> Hannes created two testcases and shared them as the GitHub PR 158 [1]. Qu=
ote:
>=20
>  "This pull request adds two new testcases for nvme TLS support, one for =
'plain'
>   TLS with TLS PSKs, and the other one for testing 'secure concatenation'=
 where
>   TLS is started after DH-HMAC-CHAP authentication."
>=20
> The testcases were missing a few requirement checks. They also modified
> systemctl service status after test case runs. To address these problems,=
 I took
> the liberty to add some more patches and modified the testcases. Here I p=
ost the
> modified patch series for wider review.
>=20
> The first five patches are preparation patches to add several helper func=
tions
> for requirement checks and systemctl support. The last five patches are
> originally created by Hannes to add the new testcases nvme/060 and nvme/0=
61.
>=20
> I ran the two test cases using the kernel v6.14 with the patch series tit=
led
> "[PATCHv15 00/10] nvme: implement secure concatenation" [2]. I observed n=
vme/060
> passed, but nvme/061 failed. FYI, I share the failure logs [3]. Actions t=
o fix
> the failure will be appreciated.

FYI, I applied this series. Of note is that the two new test cases were
renumbered from nvme/060 & 061 to nvme/062 & 063 to avoid the number confli=
ct.

> P.S. Hannes, please check the Copyright year of the second test case nvme=
/061.
>      It is 2022, but I guess you meant 2024 or 2025.

I still suspect that Hannes intended the copyright year 2024 or 2025, but k=
eep
it 2022 unless Hannes requests change for it.=

