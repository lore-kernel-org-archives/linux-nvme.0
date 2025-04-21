Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E8D5C369AB
	for <linux-nvme@archiver.kernel.org>; Mon, 21 Apr 2025 19:12:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gFw6X3NukXpikYyLMVDjVugw6CsYVCsWw4yA2jEfPSg=; b=gl8P409AzmjBr3CVsDkoFh6klo
	wMteHFfOMBlcqt1xAe1D91K7ZCZbPLZ5Iz3lkwsIOD1OP2xTgD8p1QRHDiE2n6Vh/v8wjcpfQeTaP
	26Fv7Cf5entDpGXZJfEocxAn1539uxCzEeCBRGBqVF8PIa+8bhTExtsf9yOYEKwBbi/OVUS2pdKvz
	KugjfVyNMybp9TVqtiBPRf4GpPtuRg6MjMCH0GfuKjDrNfeLUrUd3Cb5DnS9W1Dc8Km6RsuESlyZy
	lulBxfhS2A/t3QNSLxORiiOhofbj2z8LD5c5+hjibBkbb79eTUoiGmut7hH6NyLDNzSpzLUGya29M
	dfpCutEA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u6wYe-0000000506j-3A0v;
	Mon, 21 Apr 2025 19:11:56 +0000
Received: from esa3.hgst.iphmx.com ([216.71.153.141])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u6wYc-0000000505f-0t7J
	for linux-nvme@lists.infradead.org;
	Mon, 21 Apr 2025 19:11:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1745262714; x=1776798714;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=7VTiUZiKvOH8LTyD5Piyp/rFbnOfBcoCkXSiUpkFf8U=;
  b=ZQ6MxCqPNVp336yEvmLfq2jfDL0d5phzClUUto8nooWEhNsgNpCwU2Bt
   4OsC5wY6JhvR0MCZmVzZOgQcga9XQgWIJXEgz/uF7vFBw3z5PXShx3wEW
   BMgHflMTMOT1eDE/TmBn4A/V9VSsrr6NHibwsFxr+TQnO3I4rv3+N8cDs
   BsA8L0CYKKn7QS05S9LfU7MuVmPVwfmm0Mfjqul3nCjgkNZJyoBpcYOTl
   muhIWgvwCJDwCn9EdyIz3CB14JMBd6bL+9OkpGg8I7qniIoSBcGZsT8s1
   FYx6qHMZoMzXtSwa/2cy5pMWqAEOGczzsTqJoxUuQsELGO61vnKqXzr7x
   w==;
X-CSE-ConnectionGUID: 5db0eGMGRLShF4g7waBYCQ==
X-CSE-MsgGUID: 567OPUN2QPCwNoF/RxOUVA==
X-IronPort-AV: E=Sophos;i="6.15,229,1739808000"; 
   d="scan'208";a="77366101"
Received: from mail-bn8nam11lp2177.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.177])
  by ob1.hgst.iphmx.com with ESMTP; 22 Apr 2025 03:11:51 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yDZ+ls99B5V6+8YxIIBYV+kou22WJwvf0lS436gRZpWv3g66gpx4OKFYBDerwQEldzsq0xGtrukwBPw1Lhdjc/+9ktBgbrWmkP1ddX+b65tHql+Qt9azZbPiOyX8sxVs3RTJh2ftMuj+L4DGJaAkO0FNeAARbIKi/QZSvE9YK7x3bgjFtF3BA94s2KM06IWBa2LXCZAoD3+408htrbIbUfOrSysstc+mNl9aW+xDH+LyLtWf0obTRWFFPD21ST5grqsH0ZYuDtKhhS+ziqK/IwIuiW83Cs7Dm0pairjKkRaVjdG91h6TFCbnhaLp5CMsSK9v5iLSM1YUnEB3U7u0RA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gFw6X3NukXpikYyLMVDjVugw6CsYVCsWw4yA2jEfPSg=;
 b=AOSu48ODo9xBMY3V1CX6f8BG6FA+ga2YQxI+jU8LmfAc4K+UJ5SJwWm0ZUxkGFZ4pbxtNUrc0RWPa/KlkQKN4l7GC43JVoXWGo0K5zm+g/zRf0d6+Yf/9KnIkSXHFE0g9XBThkEXXeZJRV73pY6vzNy9m+up/P1LDfuzsolfwc3ODO7mOTYwLNAk+JDVN7VTNS/D66lfbdECmsf2/dYhZHar52PdKofJaOiiqH/SF2IPuqCz81X/2c3t5zDrgzdDYpO+/uJcFs88zGEOoqNs3i+sKly2sXNzRT6eZ1iygZBXykY+j6/24wr5X3VNUeRWX7jvXWTpFaDB4oE3yMMiWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gFw6X3NukXpikYyLMVDjVugw6CsYVCsWw4yA2jEfPSg=;
 b=J9AuCmXQbk77vqqcHyrbrcbZ5klYAHl7GrC5jyvQ6wUPuknl36r7atkyW5dASLyB8r+snby1bscnm1jzFuIts8ooQS59zA0EXLQlpMtnMcjUTt/oh8i4eJTkniRDuey+fZbxdRcsFxr7DTtGMMDBdHeJr3WFYTC5ME09V9ATkkA=
Received: from BY5PR04MB6849.namprd04.prod.outlook.com (2603:10b6:a03:228::17)
 by CO6PR04MB7489.namprd04.prod.outlook.com (2603:10b6:303:a0::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.35; Mon, 21 Apr
 2025 19:11:48 +0000
Received: from BY5PR04MB6849.namprd04.prod.outlook.com
 ([fe80::b2a6:2bbf:ed0a:7320]) by BY5PR04MB6849.namprd04.prod.outlook.com
 ([fe80::b2a6:2bbf:ed0a:7320%6]) with mapi id 15.20.8655.031; Mon, 21 Apr 2025
 19:11:48 +0000
From: Kamaljit Singh <Kamaljit.Singh1@wdc.com>
To: Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@suse.de>, Hannes
 Reinecke <hare@kernel.org>, hch <hch@lst.de>
CC: Keith Busch <kbusch@kernel.org>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>, Chris Leech <cleech@redhat.com>
Subject: Re: [PATCH 3/3] nvme-tcp: fix I/O stalls on congested sockets
Thread-Topic: [PATCH 3/3] nvme-tcp: fix I/O stalls on congested sockets
Thread-Index: AQHbpGZdo3Xoo5WOcUmvA6U4U0rVxbOkYTuAgADyiwCAAK1uAIAA7l0AgAGfxuqAAMd3AIAB65xqgAMqEs4=
Date: Mon, 21 Apr 2025 19:11:48 +0000
Message-ID: <BY5PR04MB68498E95C971D95BD7964F9ABCB82@BY5PR04MB6849.namprd04.prod.outlook.com>
References: <20250403065522.90807-1-hare@kernel.org>
 <20250403065522.90807-4-hare@kernel.org>
 <1edc23f5-eb48-4006-a2f4-d303b05bd3e0@suse.de>
 <e7371b8a-e0b3-4387-a941-292e1f46b2aa@grimberg.me>
 <5446ef17-d922-4467-9a3c-5001713cc260@suse.de>
 <dac1d594-cf64-41ce-8a23-4b246db75b83@grimberg.me>
 <BY5PR04MB684996C1DB38F3BC4386B55EBCBC2@BY5PR04MB6849.namprd04.prod.outlook.com>
 <ee011198-9a15-44e5-a18e-02d3844ee48b@grimberg.me>
 <BY5PR04MB6849262F5822EC7132BE7414BCBF2@BY5PR04MB6849.namprd04.prod.outlook.com>
 <cb444a0b-ecaa-4f46-8323-e5c39a8c71e7@grimberg.me>
In-Reply-To: <cb444a0b-ecaa-4f46-8323-e5c39a8c71e7@grimberg.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR04MB6849:EE_|CO6PR04MB7489:EE_
x-ms-office365-filtering-correlation-id: 6415836d-bace-412c-93bb-08dd81085d6e
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?jQo+0XtcyBoTV3lo3Eb40GGq4aOcrNOpZIPyKK9eig1rbbJuozm9Sgr3nA?=
 =?iso-8859-1?Q?7ENAetT0lHYHJF4quwqV4PrRgloqry3XgAIXJSbL1MhOgjetn6WKWqZZNS?=
 =?iso-8859-1?Q?gwv7zCbQKR69Icz2bfpafBuuCOkaxI1w0j0QBcgxWQ9A4rcuQgUD2blx9P?=
 =?iso-8859-1?Q?bNi4ckhkZOP2fDVa3sxGz6k/eewOd1V0ojTb9bXFQYhmA11XP45ivXZ5OZ?=
 =?iso-8859-1?Q?+USgLU9hQ8FNvKyVdKehF1uJNvvZzyGd+fRvDOC3E05Y1dZ9Hnxf3sqX1b?=
 =?iso-8859-1?Q?7W+dHAPXVSOTvb16wOjtU1JYE34SxKfUTE1OoC6zgiMuIioU5jiMNy9Qoe?=
 =?iso-8859-1?Q?R7OdagPFBiYFwJXdrZpQ3hx/xtmFYupZeyoVEDrje09D1XxE6SwIN1D0Vu?=
 =?iso-8859-1?Q?k0oBYypYXoVk0wtYp0g0Lu48FYDv4WQV/zsw/pFQINPwobkmaAc1iOgxW9?=
 =?iso-8859-1?Q?mYid8WFcJcWvZxrU8ja+Qx2ZDXwFi63+TTXUujZjpxwhgKAHeq+wTVy2CK?=
 =?iso-8859-1?Q?Pdsj4wUU7E3Qp5P0U9VhFGEKBxIHCALFLAICjfsmdcDHwt7jgvZkaToy+t?=
 =?iso-8859-1?Q?FNhdUTdSQjFOt83y83JI58wCuBUwyqv98+WooCoLPWHL/K5dojsvdHd3Dv?=
 =?iso-8859-1?Q?10O+QtdRQL9yxCn8iXnokBIBUs2D0YEKj0CwR+6UTHAL+fnc4UmMb3waIk?=
 =?iso-8859-1?Q?Hy2ovRsQwmynfyMch9Z7NKApuOBNULO/yCLacvET8EcR2oVGEFHADDMANm?=
 =?iso-8859-1?Q?wtaqZospkzRTDyGCDLtfvwQ4MzWQV+tTozVELRpBN9HPKBaE2/radaOnMx?=
 =?iso-8859-1?Q?SkV/pxfxTgSe2WX5bg/5t3BE49fZla5KGUwUP8JUUhjWmG598aYBtpjAY/?=
 =?iso-8859-1?Q?9zEeOkcY53Hzchnz5mfSOPtnT1Uakj/sXUHoWV4syCAdxx8HAMmpysMM+i?=
 =?iso-8859-1?Q?P1/SMdIC/ELB77ngvyNDVaT7kGAu8baQpDBtnPIfVr65Sgric+R2gV179f?=
 =?iso-8859-1?Q?Fes9ZtRCQAjAYGMxq6JaZH+K3uLWW38Qk5ASMXLB0ZTswSVMPU9aFmfYuX?=
 =?iso-8859-1?Q?nEgqzR6r/CZq7OnDIkNpU7pxXQ5bfLwVoJBh/0vThhSUFfErXN1vNIiTMh?=
 =?iso-8859-1?Q?N5ePW8S2cKp6Y936u/Rpa9S0sEcjg3IlE+8taa0SKO9MYC6o4U6HYlfi1J?=
 =?iso-8859-1?Q?yJcNbQNlHTwvMqNpUpoYrPx/iX/dkvzJmIC7czuvuE7QyH0vQaKh0s/DHW?=
 =?iso-8859-1?Q?uf1AnHGK7KgRAtCIk4eJITqaQsSmdtPfx14xgDZV0a0r6ek+gz4GwHsKew?=
 =?iso-8859-1?Q?sgAOgp1wJUnVHdp7SuCRd3f9VqC225Sq7/5gDnlnq3j85uKrkwEwG23rD0?=
 =?iso-8859-1?Q?dWVnN8YN2Eef6aV5qDWekWgHj61eqDKjb1pIWxSMpQ+V/bemcNmj1KuA9D?=
 =?iso-8859-1?Q?FYeioM2tHC4Wbuf40YWVR2R+XJodk7tNohDwFuQhl5dV8wZ21d7MPCWfy+?=
 =?iso-8859-1?Q?c1PDO/ZLURAzpzXjj8w44+BEurzaaIHzHSDAaLEgWOIso1C+Gu3jnI5dVW?=
 =?iso-8859-1?Q?dNuQi1o=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR04MB6849.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?kfMZFPCgRfD8SApjbq5ZxUujhqDd8I/r+jvPeE8cFXWY7LijoQtkC5zu5M?=
 =?iso-8859-1?Q?do3xEvdUSPLOu9olRwLoZxgYp4sABcjRl7jcP6dFv4j8A+peivU5ECYHuw?=
 =?iso-8859-1?Q?B91sAqY/3nDH2t78V6sGh1hDOxOmVOYlPhXv+akr5WvnhqhSMVz/7O861L?=
 =?iso-8859-1?Q?j9bDPHTDuZkkhjPDQ0j504sdZYJFwTyNK4tzqJzMY/yrXHXIKw4xLrc3An?=
 =?iso-8859-1?Q?2cs88F7rrEYhK7RcoA+6KTLBcfuLg0CYMm0Yss4JRgi9Pa6X6ayZYQhTjx?=
 =?iso-8859-1?Q?9dKJma741YovBYVDDddVRZo9UJ5bYMEzvStFIa7okDyKHJVY+dHY90vQ7u?=
 =?iso-8859-1?Q?aTvnHt6om21HK4yMpsWlHYK1YUpmI1aEiQ/5H73maxVoiVZlBTRG7SLADX?=
 =?iso-8859-1?Q?OhHlhq/wivBSKtg/HEs3eH6oHylmWi7cLMT5MNRgF2GNy508jrDJLO9NHz?=
 =?iso-8859-1?Q?BcfYDxbsT/fPUbBmX+TVd2sht1VhD+zM+ygYCeD8XYQg7wcAEbhecUNz9o?=
 =?iso-8859-1?Q?pEnG6iU68z4cZeGYFFQBRO+I8Cj/ay8eMHdexwSIFrwwwqUYqBsr1Usmp/?=
 =?iso-8859-1?Q?x2Ax0crAoulfy1SYTXgIoJoMhjBuLOwcW9r4IXSRad9VUKQoeiZiL1o65P?=
 =?iso-8859-1?Q?r6bB1A0RDNz3ltsMNqeXXDscFQhwkVh6ZKCoU4BTRb8aMDZf0Y0tWAIEVq?=
 =?iso-8859-1?Q?XAmgXmnarEbvW3rKrS6uMwBirY2rpZ7gtIMNDt/n12NKN9X4gSy3iBI95c?=
 =?iso-8859-1?Q?oVeGI/kGJ/vM70AYCKYUtIXqaw5joa+hCaynO12wlYiuvf0QJ8vCJc8GNR?=
 =?iso-8859-1?Q?F3zgsWFy4S/yMc3wb2/fENJ2xqSd82AkDe/gZMj0bxPYpQIeeRK49L/uh0?=
 =?iso-8859-1?Q?2tNDplHathnJRJKGHdD5gMk12Vd4DA181JTpw43I1wDH6PoFpSB4A9VBbn?=
 =?iso-8859-1?Q?FARCHgta7VgEajGP5Nh1yay2BMrnnzPrS28Bk5fElQdR9Ah+wx5os4NzUB?=
 =?iso-8859-1?Q?rTLGnT4qqm/Y0hqrqCp0PSN2Cix+Bo2Qgodm5zMJZOv2APde4EB5l0RhbD?=
 =?iso-8859-1?Q?h+r2lL0LKy3tXD7bCJu8SFrFuYRk6SVq/O5LK7L6T99KKusoxh5Mjk7cGF?=
 =?iso-8859-1?Q?88b71ufnAezJamfuj8FZUC6a3zPfJ9WE4dsfAa+6wJLQbIjvif8G+GFq7G?=
 =?iso-8859-1?Q?4X5ysDDjuaucJP1Y3iIqY4JvFcbpNB/1ipo6j9T5dhwx70e/65HRXxYVsq?=
 =?iso-8859-1?Q?tQSjx838f2rXGFrbjcz932/xoHpzm+K1h2PXjK5Tumi89V35da2AxuggcU?=
 =?iso-8859-1?Q?j45urgR6krdPNXKrnMt2b1FQc77T5XHLpb+kYJ/92+AqJkE6+m56j5V5r6?=
 =?iso-8859-1?Q?gl+5iLSzuf0Ab+J8rHYrdKZtgTLsGNpssGbwAz/fFci/RhkAP8uKXlSaDx?=
 =?iso-8859-1?Q?0D09JE5vpCMtS+WAHVOEOWrvs/UtjvelnMLJNSuC/mB9ua/78O/Urw3lRg?=
 =?iso-8859-1?Q?iSEGDiE9jbCst/ot4udLAeCEEcwsFYLCrUnnpWVUYv8whghwqL7WB5W7WA?=
 =?iso-8859-1?Q?TYKf07AjyhxXrEYwdFxt5ZqM75ZHfUgqwI5eJg9PKy0ElHgXBaepabinRs?=
 =?iso-8859-1?Q?5HvvGjc8rxGTBtyyvdlqD8RlIir4RklLm6?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: LXwgU+t6gD38Y2qsyw63mSqZvV1KcN9rs0fPfHcYW7g6shudZLB85QQbal4ijw//M1vXn/lugVhL22EnDvHolhIaIy4RbQ2MANb/Jvzk6dFUTNbXbDPvGpLDk8RQmpQb8jYRdLqdwtt1KI4bxytO5RM2u8HI1M4p1rVG3xNcmSteQ+wkIGm+z7T3CzzuW5F5366ArFyjmVCgMZ/Bb0ju7VW19CsdUbWm7r4MQVQ5Yme39jVWJuN+cK5wrTsX/hLlUGk8x4RHHnaiMc7ymD2AHkfk1lNiU43DYI2XFAz5NQFqbBAmty90qLRAyBC9xR1rj/XZEF6cu3hRu3dxn0bSOkphB+DrGEdXDA+QRHQmET+haYhYcqypcoHeJ2s/Ojpd4ed2ivyrPeYPdbsAK4OElrqBBKIYeTkGT96K/gaGveoB7Y5GjsZnZiJYftcpH42lYNS3tjHBPsmWxHS6tln0q3X6k0GsKuD9WPOCCpNETUMlzi0ea/mfj69eb9CfErLjhJSuSz40qm7YXk1yT1t92HkkKGFNbhc4gLE1u3+duFm/pVjeytHqbO7TdBzuWt89knIFuIM5e1RfXPHhAvWJSlYeMZhVWHO+d0pYeo4pmC9adQm2jEksSaQZfcvgFM5J
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR04MB6849.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6415836d-bace-412c-93bb-08dd81085d6e
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Apr 2025 19:11:48.3179
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MPudz9ROmxMXXGuGC58+VltmZ6Ml/qxQhehJ+71xcJataU3/n9PwW9yZ6M6JtiP0tR5rJ19+y7+uE70avSGsjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR04MB7489
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250421_121154_288448_3FDD166C 
X-CRM114-Status: GOOD (  17.99  )
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

Sagi,=0A=
=0A=
>However the log prints are WARN messages that does not exist in any of=0A=
>the patches.=0A=
Just found the issue with my patch integration. I had picked up Hannes' pat=
ch in email =0A=
titled "[PATCH 2/3] nvme-tcp:=A0 sanitize request list handling" and dated =
Fri Match 7th.=A0=0A=
This had the 3 WARN_ON msgs.=0A=
=0A=
I just found another patch-set with almost the same title dated March 27th.=
 =0A=
I'll integrate this one "PATCH 2/5] nvme-tcp: sanitize request list handlin=
g".=0A=
This replaced those WARN_ON msgs w/ dev_err() after if-checks for the same =
=0A=
conditions.=0A=
=0A=
>> The patches I applied are these:=0A=
>> 1: nvme-tcp: partial write tcp-q-wake-sender untested by Sagi=0A=
>> 2: nvme-tcp: recv-side EAGAIN untested fix by Sagi=0A=
>> 3: nvme-tcp: fix I/O stalls on congested sockets=0A=
>=0A=
>The patch I suggested was a replacement for patch (3). Didn't you=0A=
>get conflicts?=0A=
No. But I reviewed it again and have undone this part of patch-3 in my setu=
p.=0A=
-               else if (unlikely(result < 0))=0A=
+               else if (unlikely(result < 0) && result !=3D -EAGAIN)=0A=
=0A=
=0A=
>> 4: nvme-tcp: sanitize request list handling=0A=
>> 5: nvme-tcp: avoid inline sending when handling R2T PDUs=0A=
=0A=
>=0A=
>> [4] =A0 =A0 =A0 =A0 nvme-tcp: sanitize request list handling=0A=
>>=0A=
>> =A0 =A0 =A0Validate the request in nvme_tcp_handle_r2t() to ensure it's =
not=0A=
>> =A0 =A0 =A0part of any list, otherwise a malicious R2T PDU might inject =
a=0A=
>> =A0 =A0 =A0loop in request list processing.=0A=
>>=0A=
>> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c=0A=
>> index 40dce5dc3ff5..4647d5d547f8 100644=0A=
>> --- a/drivers/nvme/host/tcp.c=0A=
>> +++ b/drivers/nvme/host/tcp.c=0A=
>> @@ -455,6 +455,7 @@ nvme_tcp_fetch_request(struct nvme_tcp_queue *queue)=
=0A=
>> =A0 =A0 =A0 =A0 =A0}=0A=
>>=0A=
>> =A0 =A0 =A0 =A0 =A0list_del(&req->entry);=0A=
>> + =A0 =A0 =A0 init_llist_node(&req->lentry);=0A=
>> =A0 =A0 =A0 =A0 =A0return req;=0A=
>> =A0 }=0A=
>>=0A=
>> @@ -562,6 +563,8 @@ static int nvme_tcp_init_request(struct blk_mq_tag_s=
et *set,=0A=
>> =A0 =A0 =A0 =A0 =A0req->queue =3D queue;=0A=
>> =A0 =A0 =A0 =A0 =A0nvme_req(rq)->ctrl =3D &ctrl->ctrl;=0A=
>> =A0 =A0 =A0 =A0 =A0nvme_req(rq)->cmd =3D &pdu->cmd;=0A=
>> + =A0 =A0 =A0 init_llist_node(&req->lentry);=0A=
>> + =A0 =A0 =A0 INIT_LIST_HEAD(&req->entry);=0A=
>>=0A=
>> =A0 =A0 =A0 =A0 =A0return 0;=0A=
>> =A0 }=0A=
>> @@ -773,8 +776,12 @@ static int nvme_tcp_handle_r2t(struct nvme_tcp_queu=
e *queue,=0A=
>>=0A=
>> =A0 =A0 =A0 =A0 =A0nvme_tcp_setup_h2c_data_pdu(req);=0A=
>>=0A=
>> + =A0 =A0 =A0 WARN_ON(queue->request =3D=3D req);=0A=
>> + =A0 =A0 =A0 WARN_ON(llist_on_list(&req->lentry));=0A=
>> + =A0 =A0 =A0 WARN_ON(!list_empty(&req->entry));=0A=
>=0A=
>These are not included in Hannes patch afaict.=0A=
They were, as I noted on above.=0A=
=0A=
=0A=
>I'm assuming that these are the stack traces that are firing...=0A=
>=0A=
>Can you please share the output of gdb:=0A=
>l *nvme_tcp_recv_skb+0x115e=0A=
It points to the 3rd WARN_ON msg. I've replaced those warnings with the pat=
ch you suggested below.=0A=
=0A=
(gdb) l *(nvme_tcp_recv_skb+0x115e)=0A=
0x628e is in nvme_tcp_recv_skb (tcp.c:782).=0A=
777=0A=
778             nvme_tcp_setup_h2c_data_pdu(req);=0A=
779=0A=
780             WARN_ON(queue->request =3D=3D req);=0A=
781             WARN_ON(llist_on_list(&req->lentry));=0A=
782             WARN_ON(!list_empty(&req->entry));=0A=
783             llist_add(&req->lentry, &queue->req_list);=0A=
784             if (list_empty(&queue->send_list))=0A=
785                     queue_work_on(queue->io_cpu, nvme_tcp_wq, &queue->i=
o_work);=0A=
=0A=
>=0A=
>My assumption is that in your case, queue->request is still referenced=0A=
>with the current request when the r2t for it arrives, which is very much=
=0A=
>possible...=0A=
>=0A=
>So this means that the patch "nvme-tcp: sanitize request list handling"=0A=
>is wrong, queue->request may still be referenced when its r2t arrives.=0A=
>=0A=
>I think this patch needs the following:=0A=
>--=0A=
>diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c=0A=
>index f2c829f1aff6..c2d4893ecb94 100644=0A=
>--- a/drivers/nvme/host/tcp.c=0A=
>+++ b/drivers/nvme/host/tcp.c=0A=
>@@ -767,8 +767,7 @@ static int nvme_tcp_handle_r2t(struct nvme_tcp_queue=
=0A=
>*queue,=0A=
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EPROTO;=0A=
> =A0 =A0 =A0 =A0 }=0A=
>=0A=
>- =A0 =A0 =A0 if (queue->request =3D=3D req ||=0A=
>- =A0 =A0 =A0 =A0 =A0 llist_on_list(&req->lentry) ||=0A=
>+ =A0 =A0 =A0 if (llist_on_list(&req->lentry) ||=0A=
> =A0 =A0 =A0 =A0 =A0 =A0 !list_empty(&req->entry)) {=0A=
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(queue->ctrl->ctrl.device,=0A=
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "req %d unexpected r2t wh=
ile processing request\n",=0A=
>--=0A=
>=0A=
>Or in your case - remove the above:=0A=
>--=0A=
> =A0 =A0 =A0 =A0WARN_ON(queue->request =3D=3D req);=0A=
>--=0A=
Made that change. Tested and seeing this. -71 is -EPROTO that patch-2 retur=
ns . =0A=
Trying to narrow it down further. If you have any suggestion, let me know.=
=0A=
=0A=
[Mon Apr 21 11:18:58 2025] nvme nvme0: req 7 unexpected r2t while processin=
g request=0A=
[Mon Apr 21 11:18:58 2025] nvme nvme0: receive failed:  -71=0A=
[Mon Apr 21 11:18:58 2025] nvme nvme0: starting error recovery=0A=
[Mon Apr 21 11:18:58 2025] nvme nvme0: req 11 unexpected r2t while processi=
ng request=0A=
[Mon Apr 21 11:18:58 2025] block nvme0n1: no usable path - requeuing I/O=0A=
[Mon Apr 21 11:18:58 2025] nvme nvme0: receive failed:  -71=0A=
=0A=
=0A=
>> [2025-04-16 22:56:24.758] [Wed Apr 16 22:56:26 2025] WARNING: CPU: 22 PI=
D: 134878 at tcp.c:782 nvme_tcp_recv_skb+0x115e/0x11c0 [nvme_tcp]=0A=
>=0A=
>My assumption is that this is a result of=0A=
>WARN_ON(queue->request =3D=3D req);=0A=
From the gdb decode it points to WARN_ON(!list_empty(&req->entry))=0A=

