Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9504C678DC
	for <linux-nvme@archiver.kernel.org>; Wed, 11 Jun 2025 14:53:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=tLa9JCXk4SWds3V3JyWaVhn4HPeSOGI8ODLAHdsJn0k=; b=MWbdubLtpq2buDLlvLTdy0BJ1k
	rnm4fgPVBN+vZ0j+bPLLrVMu6j9J0eyaGQrnUfxF5pR8WrhoTGwniFDN8JcqzKicdjR7NkO1X+plc
	owLaP8g5a8gGhdZ59vlNuub1bZsqncI0GGsptPUpeaNI3JHUwu9Yzz2h/8XFtY22HIvtKqBnsjxsf
	zkuC+MbZoY8vgfEoX7mK9u0r9vYft/dlfwrJrVxibiMvkLfvGknzOGA/kDitczTr6yFH9Tvu4EYwf
	UEojvcANZwRh7yjEf41YYDfG6MXcKzoRwWvVrPzfdnmf7FIx2Go+A79pnZwEbBgUhm9hlKe2AKHvr
	AREmSE+Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uPMp7-0000000AGgY-1sLj;
	Wed, 11 Jun 2025 14:53:05 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uPJGl-00000009hhp-1U6t
	for linux-nvme@bombadil.infradead.org;
	Wed, 11 Jun 2025 11:05:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=MIME-Version:Content-Transfer-Encoding
	:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To
	:From:Sender:Reply-To:Content-Description;
	bh=tLa9JCXk4SWds3V3JyWaVhn4HPeSOGI8ODLAHdsJn0k=; b=NMSeEhBYw9korFGRgEJ1Xjjrar
	SVM6Zmu0AQs3JdViSyOoBQayF7ozx5DMg8tjCkGr+fEwAU6Zum5oMvMVj0B31mhopLCM81HzcUDSM
	23SLPNeb7E5BzuPowgcccYmXkFShs4v7Mv5W9V4Axp7suvOkJSJEBrPEH4uC3+Xe8yvJ3IE1uWbao
	jdh5XymC62PlxrMGI+SHFzYpvZH+Mh399xWn61ln71c9ie1CP2ZyUD0myqTAM6vO9waTorYnqlO91
	5jEGazkpLRz4NelWi+mikWcWyDX7OzwWoBw1sgwzcAzggbUSHWd3GcjZE6UZGTS8+EIMyi8iHW+k8
	vgQ25f/g==;
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
	by desiato.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uPJGi-00000002Jcl-37Yk
	for linux-nvme@lists.infradead.org;
	Wed, 11 Jun 2025 11:05:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1749639919; x=1781175919;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=XduLC68ldWp/MTwMmpgN/Pm/smMdsolv3648zuouzUo=;
  b=DGR/txMNBV7km8cwK+78UqRbc9HPtWPBp/8Ot2LUkooYeT9EU1Mwby2W
   YWSy7dsvvVexhQk2rDyrgtbZLpS7cuz8Q+er0RLjtHH5Zm7QFGO2Q8OGc
   ZW6O3a2FU1w4a9IyASDAZN+yW5x14XXH2YkMmIDoUyrleanU6ZGHd2YTW
   Hp5hnXNJ+ukiE8wNp8OxGPoxkDiMHomJtRmfgVH0y7FATe+LiNMhaDWF3
   jkGeB371iK/qZo3wUXZX7LJ94wKbHcABwby/yZhbMZ5MCf9stX11SXQ9b
   HsSiZxOu4jKCO3zXJlW2yaq3aa6Rdu7vbEW/4sf/lYpmhtdRERjLjLzMO
   g==;
X-CSE-ConnectionGUID: /8/caxjtT06Gro5jjbTXpg==
X-CSE-MsgGUID: IkZWHscGS26spmVL8jO9rw==
X-IronPort-AV: E=Sophos;i="6.16,227,1744041600"; 
   d="scan'208";a="89305814"
Received: from mail-centralusazon11010017.outbound.protection.outlook.com (HELO DM1PR04CU001.outbound.protection.outlook.com) ([52.101.61.17])
  by ob1.hgst.iphmx.com with ESMTP; 11 Jun 2025 19:05:11 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IcufTeQmpkrgeKMLycXtMEAsRjxy4VaXIB5Dpi8kYrgFJH+qLB8LoyMAIcVpxDBGI03bjDmEZkZsi4WgecCBHHBSxQqsMQr0sGT84iUq0jDrUUH+p+krSmhd9nTPaaNFRA942q3Il/9TsAY6e4vQLmwPjpTkudh2nXLnqwp1m+Jr2r3SF0J5p5RbShjx9YFBzHwS1M3+dABRzWDh1yejL7/uAoJYM+19x6P0EGT7fdooFA8Kxa3KhBQoRAgzrJAHedl2/1lkiR5F1ufNSzyxrpRvXYoDPnVajGcO+F2AmUXEIbb2dTooVutRMCH+mPw/0Bg2OL/lFG8a12YgQ/jfaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tLa9JCXk4SWds3V3JyWaVhn4HPeSOGI8ODLAHdsJn0k=;
 b=J0EyI+KUWxMGYkt9SXb7zUjbxg82W1Oyo2Wop5dWkHZi/lpQ33jaWapAUI2TkIqjkCzx+OqSwRpVJo6N+PHefybjJf/EA+mNl+bQXCC+/rq/4fP+zmf2UEj0N7j2qVjWPdPzc2OuK6HcFYFxON4mb/T+0KoOxwQd89AjIMsMVubyOu6R69u9pCHvw16740PO9bW2hPlcAAXORLaIKiTWUOcS9PsKEHY+3EuC/QbAp0wksfNg1KqiwKaSAtk5OzYSerw9oHD5lNrOzwcJ+agNKANSHaO05fgORm2qtz784qzJ2sRqJp01QNPaUpKEg9WXZgKBjg+/eh8Ee5lGV6hFHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tLa9JCXk4SWds3V3JyWaVhn4HPeSOGI8ODLAHdsJn0k=;
 b=ChmLQIOIzSYbSAo297f1ynNkxQK+JbKs1UwEQXaN5lrMXHzEnO+2qdSknKLxQ6bXcmz6YRJ1gM1AOFHSoKQ1SV3bwxwJ9yljlRP47GuPGP/KHnUoPoF/AjNNJEcWSaDwW4EHAG+ExkX75tQfIT3cgOFRrLZM17suVgqIjLcZDLk=
Received: from SN7PR04MB8532.namprd04.prod.outlook.com (2603:10b6:806:350::6)
 by DS1PR04MB9538.namprd04.prod.outlook.com (2603:10b6:8:220::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.19; Wed, 11 Jun
 2025 11:05:09 +0000
Received: from SN7PR04MB8532.namprd04.prod.outlook.com
 ([fe80::4e14:94e7:a9b3:a4d4]) by SN7PR04MB8532.namprd04.prod.outlook.com
 ([fe80::4e14:94e7:a9b3:a4d4%5]) with mapi id 15.20.8835.018; Wed, 11 Jun 2025
 11:05:09 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Keith Busch <kbusch@kernel.org>
CC: Keith Busch <kbusch@meta.com>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>, "axboe@kernel.dk" <axboe@kernel.dk>
Subject: Re: [PATCHv2] block tests: nvme metadata passthrough
Thread-Topic: [PATCHv2] block tests: nvme metadata passthrough
Thread-Index: AQHb2VT/c7SNum11mU2jICi0RCaOB7P8AJqAgACL5YCAAUI6gA==
Date: Wed, 11 Jun 2025 11:05:09 +0000
Message-ID: <pq5fn5vixnxydvfyr3bqxbaxyyyxng3wfkh6gngtfjcemmvjkr@atozjqcyjzpm>
References: <20250609154122.2119007-1-kbusch@meta.com>
 <pgyqdqi76m7skiyirtjb3d7wtbb5223sk64eoqtafg7r763biw@7f4pdqtoptiv>
 <aEhUlw8H2ZD98SpY@kbusch-mbp>
In-Reply-To: <aEhUlw8H2ZD98SpY@kbusch-mbp>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR04MB8532:EE_|DS1PR04MB9538:EE_
x-ms-office365-filtering-correlation-id: 240374da-79b7-4be8-c675-08dda8d7d4db
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018|27256017;
x-microsoft-antispam-message-info: =?us-ascii?Q?o/GtRhKqaYDI8DwE3+hgd5+4dgO8ZuiKeAlR1Wtzak87ZWtw3tRjKzNMFCNu?=
 =?us-ascii?Q?dfCYbIEtDwDk4TncYq0NiHKe/BW5+BSxqv0IqKOlZstTvHqX/9FcgfuvIYhq?=
 =?us-ascii?Q?Rq4T3lT24LjZHwECs2nsWVPCEgQA2ynUZoOt1Q2lvKmn+VXWl83BYX0J/FgH?=
 =?us-ascii?Q?Tbc3R+ir0mfbcDv3IG6esBPjOSWzN9A7LbKV/6Fu4DmrJXuKM6A2UWeuByie?=
 =?us-ascii?Q?SZ4aD7mdetgedaDqQNvfox2bBy9t4fx8sogyXaYbW+sY2/6fRVJEAry4tOMz?=
 =?us-ascii?Q?Z9iVFBcQBzh1/fJw45t7+XxKC+YuX2UOxH8iZ8sYvRCvC+faTMt03dVCpPDY?=
 =?us-ascii?Q?GQj/xN0QGkK1NULdl1bfnonUPSmE55TgsycOpJxIxeVQQPoqnH36DldsDWce?=
 =?us-ascii?Q?IJ2KwjO/4fL2Jc5XCTu0D1vXEskWIYnOnOtQUS0LvJYkIavfCMG1YuXovMvk?=
 =?us-ascii?Q?15CNCcquEXPpW3JX20eSgOXCeZV7sTmbLxS7WxL3ZgeQvgCtFE0M/yJ0dN5G?=
 =?us-ascii?Q?WTxcMc5zCKMRixHp5QgToD1dWoXSqhPrt16tDd5knmrMajk+bs1gtZs8NssO?=
 =?us-ascii?Q?Jnm+Pq0ctrtzVy/OpAhhjUxTgsxmT9CAIGfFWmK8qitgBMoUEOc4JaEseMxB?=
 =?us-ascii?Q?kkqHmknQNiD5tNDm5KKOdOPHykoB6JiyXJE072z9vRRa231s/6vBcXx4L0wO?=
 =?us-ascii?Q?h8H4LKzCWns6MjFz05gML3nsNAtsmpOT7srP6GD9cHQHV0d0aUGvhltvNYyF?=
 =?us-ascii?Q?OQtW7KW++4Rnr+uAwjvOjtZMCsYofIwIdxQS8LNQlYAEoRkuL1nh89kvqHb6?=
 =?us-ascii?Q?vMZ9g4mBeqA7uhR0LxpbGlYglG0KMZZp/9vJrlvl+LPYYdZYOiNyXfeHaOU2?=
 =?us-ascii?Q?ZBvI123E9SFDPzn/FEXGbvC8rGqMfk3g1nVjIgW+/3cIreC+gPbl6TrMWL5F?=
 =?us-ascii?Q?Sr5UTRNvRUNnI1Wp8672SiuQV1e9u0nVQuiqMkzl23pxaYtZNPOIYxpVK1h4?=
 =?us-ascii?Q?KMrVgiWWYZ8y71FHOcU7QGAGr/T2ORd6DYbPPrPpXM5qQGshS98KvcHssXee?=
 =?us-ascii?Q?Bg7X6RM4paGXGd1ZSbIyzvBaFRN2f8tdPO/KNJ+HQx3jADfQK/ucSsbvC4Ij?=
 =?us-ascii?Q?eJrUACNkUFqDXa+mIfPjETlyly6ojRqUyETFI4xdHMUy/lza38l/uI1C1qaT?=
 =?us-ascii?Q?h7OXaFdh1bs/GaOaAxnd6xzFhG4XjMriUSGs2/W108YznPfTVkUe0y/k2zfo?=
 =?us-ascii?Q?n5kMgiyHZktqNwmZboOR2qFdOJcLrfvL3I7ZLV+hvmYSba0ZeZlMPZz3JA8N?=
 =?us-ascii?Q?2Qq5XySpfmy9PWS8wguBuHGwsZBESUiJMiqUg7M1YHhlQPy3raBeT6r9KmFt?=
 =?us-ascii?Q?XkFQ4SqpOBxzlB4c8dzYazEFaoTAm8JWUL1FJZIKGSu9OmMU4R8nyDbZJRno?=
 =?us-ascii?Q?WMDps1GGMNxEDXUk6tJcA7uWt3qBTbrrIRTvwWnIquBMNBD6hPyiGHVzA3LF?=
 =?us-ascii?Q?xnNqOn4ViC4lycu0ZMbYaie704WCkV9XWjUH?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR04MB8532.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018)(27256017);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?0dmKu8wLlSzswO1CMTvbxgoi3Cdv4wNjKNU0uKp+k+0qvOWnLqYBrMKEY2uW?=
 =?us-ascii?Q?qdbqlh5HD/IP99cM8+8wUeUYFC1OsdS5lgKkc21CeUp7vRaPQMxMwLxuDLJp?=
 =?us-ascii?Q?+2EzU+3/iIlAOuR3d/n0zLhrbphnrrzMYt/O14Gi64CZATMLEYPl0Cxk3Pk0?=
 =?us-ascii?Q?vmtUuWimQ6p6w4RifPlj+Lo7n2rx4wooo2etVr186dkczYqK1f+CnKofJSYy?=
 =?us-ascii?Q?9C8M3z3qBnDaArg2T17F7Anu++75HkQVYWvUJRe01p80bMgmoLkawPEM0EZR?=
 =?us-ascii?Q?JIxJbcQSAhts2FSYmQdNuYGZXVp498hHjoMtHOvROr/qS0CfGPYO0BWb/Ws7?=
 =?us-ascii?Q?p1buqIaPnV861UORDrjcSRSgKs8aIHXehr0EJ9qiSkXZRHzMxWfHRH0SIBz3?=
 =?us-ascii?Q?SBXqSiiex81RiOo/0F2Su7mqZB1gYz1ZT68dL+3ntMw9A9X32lR0tpjCHgc2?=
 =?us-ascii?Q?41RaXLBqZC61FqEO1wWD+S2hn+IbPohZUHJ2ilb9FFMRXCxgtF9vbWMLlew9?=
 =?us-ascii?Q?f+w4eLXfgFBb8I7aRMaYQwgoyZ3uV0c42t9RbjInmpw0gYf+Ve5T67oueeOV?=
 =?us-ascii?Q?if79IyIVSCQ/L4H1tu8B8a1J0tbypDIZqDg25ivh/3bUuV0Gn4cMAGmD/6ek?=
 =?us-ascii?Q?cAIS2M8Bbh6y2Yoj789TFNnyGgu1B2xh+0BzKMOCN/cA9sLXAiSWBWaaigD3?=
 =?us-ascii?Q?G8J7+vCrBoOjZqwp/pg4ZLG00x6mJNijCIgWbqMbWcOrgHhEoBESzdr4pOXT?=
 =?us-ascii?Q?RzAguRys23x6rd6RrwA4jOPqWx9oUQyPK7Nlhu4ARN2HFsu45AWcLfpvuKZ7?=
 =?us-ascii?Q?8Cwc0SxHMuucMYMOPqSTySUm+lHLEP9NakK2vGIUGT1ROJz5dp7LR3kCOqtO?=
 =?us-ascii?Q?XwUcglydqM0KRnm8SjQPut0k8j5PqUd2FabCNktNFctQEniwK8lzwdw+xasX?=
 =?us-ascii?Q?jrof0xQB/NO1lH6nzJS/Pt0Qzsc5adeKBTNMpAh15LSpG8cEkGQnb/NCoFDQ?=
 =?us-ascii?Q?QhTGXMP6jOzBZhXFViZE/p4CBtGBMN8Cx4JqichiazQhTpjK17/+pyaeUQj3?=
 =?us-ascii?Q?xTowOQshl196T4XpR/EuBQvy5pTjqJa/uSyYQk/vTze5ouRbRLAZ20m7QUi+?=
 =?us-ascii?Q?P7QjB4Tfr33vPGhnn6169WRjCnICkYhahuRHwyNjtt8w+zqmN+i5OF9i55s2?=
 =?us-ascii?Q?etVkIoAYR9sbg50yUmexKPv8nbC6L19LHD/y+eEHiSJqtQWa5Z0wBiAczYWP?=
 =?us-ascii?Q?mlCndEoaxoQKbgXfjSOJ/iq9d5RXbQRpJA0ECkb+gqquk06FEyXAJS36buoz?=
 =?us-ascii?Q?iQOJyqUh+aQ4orswDZji0N6r2uXfxmADOOf7A8wFbp6oxBj+izOYF7svluWG?=
 =?us-ascii?Q?vNRZwlUMEmeNY7ooAlPBicBOx/OPtvTIiAfnNoYRq/MC8QvYwefCwaOZGwLU?=
 =?us-ascii?Q?e2BnFp3omNpJnKlaXg2jibmJ6fpscJKYUSjXAjsZXoSSCMLoL+OFxg1reWKG?=
 =?us-ascii?Q?fBKwZ74xYgA9pmsM4RqPicMMalQUauo0LGeW4vYQwhYsbv/nufS1xabQ+cVn?=
 =?us-ascii?Q?D+2QuWshe1wK4SDw0FA1dmHeo3zbzjXf+Hx1AulVkNznmOpFamTBua6f/zTX?=
 =?us-ascii?Q?SQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <BA94C9CA337C1D41B531E713C1373C73@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: OOaq08sUKAxrky4S4mgHWPys0NBToakGvJN6bOpiae44F/SLCnqp9dCFhJJw/mMLWR89v6BcOWQTlXnIQNH1k31dpi3iCF/O9fABafmJCgLGkl7yoFdfGOCpHckLT4GyoF1WdXM0/gfzanu79XdXWzzlEcpEk1FNWNqdEWdxr6qcXP3quh7cnr6UeXpAGB3vru8dHdy/7dMaGMj9NdJ9r/zFW/IPBZ3OOl23L6mdgs7eC8uFNtyZ587wXVno6Lb8kpRM0qb3XLSjosMD/PkhSmK4CtxqXXZKyuikKleD2tcuA/hTCgitTf8+sM5jb/1lp9klpOXY9xxtv3AVefdDpbZtn0273rEBeu1Ad4MrewlJ6jaNAleNeA0uCk7FksUjfufYqx1jkaR6MsOKcFvct/VUjpcr/uGVdt6pB5JCghR7M90LBy9N3HTEfBvkKgXhWJitpa4dSGK6gKSgnhJnTjDo8QhMN9G64xoM1nubvIHJl+5VxRPRgvj62YyGi6SdU+QhimGsDa2uPKScmkGiYmueYkp2pl+Sps59A2+Z102HN+1iAYoYRPbyjl5O0coSe+sOzAGx1U8F4Wx/W6QY51XrUj8nhr2wyN6D+c98CIOFmWUQCoLAUAAvS3GQJIg2
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR04MB8532.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 240374da-79b7-4be8-c675-08dda8d7d4db
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jun 2025 11:05:09.8640
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eERWAmDT3tc8E+6Oqjr1Uq5DQ1mV6qTm9CZQ7uSS4hEyZCJDFQgxuOPfoa0pQuTRTJraQwDcmf0y8GpDBobe/x8G6XzNM9oIkouqkqDL6n0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS1PR04MB9538
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250611_120521_351956_90FCB5CF 
X-CRM114-Status: GOOD (  26.91  )
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

On Jun 10, 2025 / 09:51, Keith Busch wrote:
> On Tue, Jun 10, 2025 at 07:31:10AM +0000, Shinichiro Kawasaki wrote:
> > Thanks for this v2. With the fix above, I was able to confirme that the=
 test
> > case passes with v6.16-rc1 kernel. When I reverted the kernel commit be=
low,
> > it failed. It looks working good as the fix confirmation.
> >=20
> >  43a67dd812c5 ("block: flip iter directions in blk_rq_integrity_map_use=
r()")
>=20
> We should probably put a "Link:" tag in the commit message for this:
>=20
> https://lore.kernel.org/linux-block/20250603184752.1185676-1-csander@pure=
storage.com/
> =20
> > To run the test case, I tried QEMU nvme emulation devices with some dif=
ferent
> > options. I found that the namespace should have format with metadata, a=
nd
> > extended LBA should be disabled. IOW, QEMU -drive option should have va=
lue
> > "pi=3D1,pil=3D1,ms=3D8" for the namespace.
>=20
> That's fine, though you don't need to set protection information
> capabilities for this. The test will still run if you enable it, but
> it's probably better if you just let it be opaque metadata. You can also
> test with ms=3D16 or ms=3D64 as both are supported by qemu's nvme device.

Ah, I see. I confirmed that the QEMU -drive option values "pi=3D1,pil=3D1" =
are not
required. Also, I confirmed that "ms=3D16" and "ms=3D64" work. Will reflect=
 it to
the patch series to post.

>=20
> > I suggest to describe the device requirements in the test case comment.=
 Also, I
> > suggest to check the requirements for the test case, and skip if the
> > requirements are not fulfilled. FYI, I prototyped such change as the pa=
tch
> > below. Please let me know what your think. If you are okay with it, I w=
ill
> > repost your patch together with my patch for common/rc and tests/nvme/r=
c as the
> > v3 series.
>=20
> Your changes look good. Thank you for the suggestions!

Sounds, good. Will post the series within a few days.=

