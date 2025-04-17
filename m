Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 361C9C369C2
	for <linux-nvme@archiver.kernel.org>; Thu, 17 Apr 2025 23:08:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=QKD9fsI1BGtIMFTeH7Hb6M7uPrp8GLT7XsgJUdwoe/8=; b=qidKo7G3TXfYOZmhAs9f0aIVIL
	4fqEvKsRTyoGRyoD18uKUdgYpBCxgIQey0vJQprakdnRgbimvZwSyw+zlmzOFE4wVz/2Qkzwd2wAq
	LVer0GozpeLq3Iz17d9HC8NKQnYSYhYKS+HEw4fAOqBY5XYZeYURDIuG0tR8M4sy238Yoy9p+cphR
	BOqlxNKcL0VaHJ5LxAKEygnGkQLLiTU42kQXNU9tIrtwKxwO1kjlfqncxmSXX2PH/VCKAtsxs03Nu
	2z0QF2+7+vL2ql9HGSOiXaTItTr6XHgmkitPHgb7WCFLmDq+7wBJ2kAns1CrdxSSPZygwKT2zfQYe
	T/CcRMgQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u5YLJ-0000000EXRY-10Wa;
	Thu, 17 Apr 2025 23:08:25 +0000
Received: from esa3.hgst.iphmx.com ([216.71.153.141])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u5YJz-0000000EXFp-1TUs
	for linux-nvme@lists.infradead.org;
	Thu, 17 Apr 2025 23:07:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1744931224; x=1776467224;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=6/IgNCvhP4LBRGhu+yoJDCkYJ18JIRKqKYkkqsgzWPY=;
  b=h5NMOjav5BpjlNPKg3JrCS3YUpZ3WjkC3XZh/dgbvNzspoVUyNUf6pOK
   OkqrjLhcZ5WA9wPROo2/8pVu+XZfFzir3Hu4qeGCPDSngnPG1NL+1ExUU
   3lsgY/qR40eHtXBBwaw1SPvPOsd9xmci2LBLTcyDsxSbbanVl9OFzy972
   WLH4DSIyL4yd3h8Eb+S5j4weRwPTgfbjXnUFmSVcSwBs5+EDpulqU+p4G
   sDoBGI2jDwLxydtVVihoEmyGWwjlSo21g8i++3SMmXsTshj3x+35+UggS
   +mb/f0IoFAsDUktGJr1z9jOPyf6ap0ap0nWsDvKKBp4I5HWZaaO/169Pz
   A==;
X-CSE-ConnectionGUID: p2OerxD7ROuLTbCrst4MPQ==
X-CSE-MsgGUID: M7iH2u4UQA6ECN+LU8VN5Q==
X-IronPort-AV: E=Sophos;i="6.15,220,1739808000"; 
   d="scan'208";a="77099468"
Received: from mail-mw2nam10lp2040.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.40])
  by ob1.hgst.iphmx.com with ESMTP; 18 Apr 2025 07:07:03 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Fsd6Ehaf97Z5+G9EttlOZjlrQz7A+XMqGdWI4IimmqV6Fj/4KZjJhROSrBVrydqlA4sjXz4u19ieOu7bO86ATYyaiZPtihryzRNZzirX5mvbKxnd17a8W/drb8OwtJqIzjXwrxkRWVaPDUrHWeR/94DKdZTGR6sqIksk4JhYb1J8D8MjKjWV3YxaY3Zp2ylNq1XGtNEZVwgamd92JR0bfUClQnlb26NwHJzB6Va4vW6MrIC8d+RI//GHo1eDF1I1VabcNeS4RsrfFXb5kIs9NFrLtyHSFtBmk1rs+uUYR/p1N7VlV2sVeaxxIwnkFRUccrnwXqu7y3NwGqsF2qLF3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QKD9fsI1BGtIMFTeH7Hb6M7uPrp8GLT7XsgJUdwoe/8=;
 b=aTAgRy519/5lN+8cpIWkfign82SFOjuH2tdPWQsktcTRv7HQy0PUst2whX2PYBChHRcfSFx6N/ujrTe1JTDJO/Z08KKymromUp2C/EwWGF9AalNjKn1bZu8u3So6fCzJfIrKIP7vMSNjD1VdiVx+30VnfezQQuY5RaUaU+vQCaIIGS3eYBalHFjQYRUXydzQO/lgdCdeDyYUBz+Ve2H7NXygHFTFwKvKs6fsvzavtdTd7xK9XgZS4DkC6kXAnWwRnFq4V5jIQOKNtYVrQhdJ/iKsKQtkZA+63VWsWfbG8yDrrGtudKyFPLTWhBS+mNMj+5ApzPtzVpTfDt8EoMauBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QKD9fsI1BGtIMFTeH7Hb6M7uPrp8GLT7XsgJUdwoe/8=;
 b=Sb7PBvSJNdfToWqOp5x1JA1uxjJ7MCGV91NSlm3f2aKhmSDA4gwbYcKcHEgPWR9i1fX9vk7biUOO3jebri/A1wR9bTxFTVsAWb3vpiYfRlWvgOX+nmt+sFWjLZ4bMRisZ7liuO3XCMh7KsRF+uIDPRcjVtMxmXNV+w4/2W0iHv0=
Received: from BY5PR04MB6849.namprd04.prod.outlook.com (2603:10b6:a03:228::17)
 by PH7PR04MB8636.namprd04.prod.outlook.com (2603:10b6:510:244::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.22; Thu, 17 Apr
 2025 23:06:59 +0000
Received: from BY5PR04MB6849.namprd04.prod.outlook.com
 ([fe80::b2a6:2bbf:ed0a:7320]) by BY5PR04MB6849.namprd04.prod.outlook.com
 ([fe80::b2a6:2bbf:ed0a:7320%6]) with mapi id 15.20.8655.022; Thu, 17 Apr 2025
 23:06:59 +0000
From: Kamaljit Singh <Kamaljit.Singh1@wdc.com>
To: Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@suse.de>, Hannes
 Reinecke <hare@kernel.org>, hch <hch@lst.de>
CC: Keith Busch <kbusch@kernel.org>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>, Chris Leech <cleech@redhat.com>
Subject: Re: [PATCH 3/3] nvme-tcp: fix I/O stalls on congested sockets
Thread-Topic: [PATCH 3/3] nvme-tcp: fix I/O stalls on congested sockets
Thread-Index: AQHbpGZdo3Xoo5WOcUmvA6U4U0rVxbOkYTuAgADyiwCAAK1uAIAA7l0AgAGfxuqAAAHz+Q==
Date: Thu, 17 Apr 2025 23:06:59 +0000
Message-ID: <BY5PR04MB6849C8288995B166CD590452BCBC2@BY5PR04MB6849.namprd04.prod.outlook.com>
References: <20250403065522.90807-1-hare@kernel.org>
 <20250403065522.90807-4-hare@kernel.org>
 <1edc23f5-eb48-4006-a2f4-d303b05bd3e0@suse.de>
 <e7371b8a-e0b3-4387-a941-292e1f46b2aa@grimberg.me>
 <5446ef17-d922-4467-9a3c-5001713cc260@suse.de>
 <dac1d594-cf64-41ce-8a23-4b246db75b83@grimberg.me>
 <BY5PR04MB684996C1DB38F3BC4386B55EBCBC2@BY5PR04MB6849.namprd04.prod.outlook.com>
In-Reply-To: <BY5PR04MB684996C1DB38F3BC4386B55EBCBC2@BY5PR04MB6849.namprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR04MB6849:EE_|PH7PR04MB8636:EE_
x-ms-office365-filtering-correlation-id: 6b9c7ad5-d93a-4ba5-c45a-08dd7e048e90
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?Ja/+d9bGj4LrbTlJnS3DWy2NVPmEyeWnQlSST6OMg7cprRcp/6L/uA1gwx?=
 =?iso-8859-1?Q?Xr9Fn2f5LucS3NvVEnGYad/3kqa36Q0ZQfMR9iRmQLfhDciExluu6nv1b0?=
 =?iso-8859-1?Q?itklFBzCIvt41yhA36uV0l6Zx4N9rHE6zyFghiz1dsipcJ4DSW8g2DjTTE?=
 =?iso-8859-1?Q?bO/6+6u977JDH1vRiCLwFuc8EGi/dBDtfSJ9nJ/1PU0Rd0EWCi9UvVzLwj?=
 =?iso-8859-1?Q?BLCfDN0EFrgAFC/EYnHTlnFsIi99K33h8tebfEHUDOR0gZjaSi2/+dQVEG?=
 =?iso-8859-1?Q?Qt9V5nXlESy0Q3Wlr21gd8yjM2vwGOux/N2XM1sMBiMCkNs3c31DmypqsS?=
 =?iso-8859-1?Q?26bVpIGdYn9u3hH4tWsF7QQvG/iXUsOOw5GUGp1yVz5AOUUSDbQkcnGNgp?=
 =?iso-8859-1?Q?xyyDmUxm1ufEUbOY+dsNtim4PHqIKGegXkYj5LwnAl6sf4eNRIH6cGMjNY?=
 =?iso-8859-1?Q?cOK2Cgka2Kmith7+AS1Yoj0bVod2OrDYVNhDe0+5Ch5OmL8gJ7N1g53N6A?=
 =?iso-8859-1?Q?9ZClQSTJnHLPOA682Z9ZFMbiUaeCUGdZUuaT+1wTsqgUxmiUDXlcvM4FhU?=
 =?iso-8859-1?Q?SseEkRt6EPRHpQkbDpYK1Fu/dHVNjJw6vbjQD6UH0MlYWkgUb2TT03fUvA?=
 =?iso-8859-1?Q?aXqj1MlULKx6JRXE3sTV3lP69wGzl1i0Vv6l6lFVqMyvCqHlxcm1/BW8N2?=
 =?iso-8859-1?Q?oHLJSvG7NKUjtw+HXLClXAIHHnmSYnN550AP1p1zHAP7HYlWzavdb+eFTI?=
 =?iso-8859-1?Q?aoCjJbqckT/UQpUgbyvd6e+cWXdvjMI33hBnj68LNP2tFwGS466ot2CBaC?=
 =?iso-8859-1?Q?bYeUhKX+uKZ8tZskMaET0GIud9UJQpXilHoNr+VNwmdE23WI45xVNmQsh5?=
 =?iso-8859-1?Q?aPLjIrOw020n1ZglZ8JnMq5KH6pU5X/xKg8sV1hOHQdaBTbiCwFepg270l?=
 =?iso-8859-1?Q?DxiWZVeIRmIKtME7U7a7Gmm+//hhqbw/bsQa+CX0/PqR4yKziXxdsChO3/?=
 =?iso-8859-1?Q?MZvtz/2MJ65tIRJqdoJlMBqlTycvzUCpMc+LfVVOTSWSnf/3SVylyJUtKz?=
 =?iso-8859-1?Q?Bwyyo4gKA+DNcByWCfYbMMJONg/+gEdOVXHzmN7rHk/G7lCLLtIL4W3tAL?=
 =?iso-8859-1?Q?wf9cWDzznuQ2cX37BZVyvVoXvWW+8vjuVpBdsX62tnE0UJ5j+oDnGRgeAg?=
 =?iso-8859-1?Q?2MhhXhpazQRXxoYQZyEenLshK+S09IE7hqpPMlNLYTHPGhAYyy08Qw+u7N?=
 =?iso-8859-1?Q?KVQl23ygh4zONlMYYivZBFv3ONn055uAsN7iwVeJTPutBa4WyWwAqQdwQl?=
 =?iso-8859-1?Q?poHLDu6lpkQ7WS7Najw8bvg/3vLIoe4tKedb9X+kqRBcie5pCgyqbVcu31?=
 =?iso-8859-1?Q?2wg7GWlGoBM9BENCyKEVYZ5uAhAfvslsX8qX2gg5UbUwqaG+TAoJ3jYdt0?=
 =?iso-8859-1?Q?hrzgCN/5MRIhQ4W0G3nEjMFFQRx+kUIJvxj/hJowWqP0UhNtT2ftzLwXaj?=
 =?iso-8859-1?Q?vlBm+yoQGuTLXCQucjgMANSYC8hGsAxwGntCB0cHvg8A=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR04MB6849.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?GU1gAqUbFHVx2SdaLxrFlc9X16LOmAUgaGf/XzoJeXKF92RFE318glEslB?=
 =?iso-8859-1?Q?3ontAg9JfihvIP6U0tea3ISxNiDsHyFCjEW8nEUJu4qOQl7HAjFokqv5SZ?=
 =?iso-8859-1?Q?VwmISucs8tz2Lr48uyZ9poB8SZF2rgwqHGCr255t+nWktABj8uBI71rI45?=
 =?iso-8859-1?Q?d8F9evkfxPDQVDAUUqRqjoDDDhNCqk8KgaZ4Djal7aSofMwkTmQLldGbXF?=
 =?iso-8859-1?Q?4WQTrhC/tQq0E9xvdEeC34uk3HAwJSBNMNQCqHb0cgfYdeWY1F42o7wHAX?=
 =?iso-8859-1?Q?BSQToLT+HvVHoyuYUhC3on6Vcvby/Epd9qbHGOSgtLNE6LuCM4j6+mJPis?=
 =?iso-8859-1?Q?mn1Nt0kr/ofTgtJ3nZQmGiMaK7mzyisFJyCHDnlYLAZvExO9vUP1sqPngA?=
 =?iso-8859-1?Q?TroqYWTB5Ni2o9vxKQmQy/2k2c2aPuHN9gjq3k72IJTnXk3Yxl2OfWfKSa?=
 =?iso-8859-1?Q?Y/esK5MCnIq6a4jAHGOZrYcL9Qp7wR1FSJUGYZkACZUQy2z+ykWwpAnoyP?=
 =?iso-8859-1?Q?JWW3F2sU6vkYEalJa+RnZiB4ky7iJo//VOg2urtCsoVJWw8ZBbWgRIkCr3?=
 =?iso-8859-1?Q?u5jFPVkapsphG5iDLNhT1JFZuuVUpb9thCZ3r1LcT5EpwM+D2qCFtsaoa9?=
 =?iso-8859-1?Q?ooAywd0FyW2yTjw1ytSPPzkRFdMqVvzMknKG7ehspipgE8CWYZxwsXa1el?=
 =?iso-8859-1?Q?/rIdWI/hM498+OAf0pqWKdSqv1Wa6SU+eWsqffIdU9E75EwadetLKtQNDD?=
 =?iso-8859-1?Q?C6isPELHLXsV8S13zUZKlE+XcSGC6UWuN+8h2+t83R/akKEhL6aeUoH9fP?=
 =?iso-8859-1?Q?jHjwDqXTFtQWWKGsqWUTsFX3WEFTNotQOBNnDGEM73dtKMSSWNJmjvlrdv?=
 =?iso-8859-1?Q?sHBp/Xxxhrk9IXxHqRptGSwYaTogwepLB9dnqD0AcvVVI0T6Uhpmnt15Ow?=
 =?iso-8859-1?Q?Ycy8kxS145GndQODd/OaHXDM8hJAUfBydTcBTeOO+M3oGYFSO5pCUcx1+t?=
 =?iso-8859-1?Q?J8AEMQK51fxPoLPHH8qb/DtB5p1UYlFDyynwU5ZHjPU3DS1O/iuYBKNNJr?=
 =?iso-8859-1?Q?4DR/DjfpsGY5xvTnsTQAfG//q1eKctSpgTdaGYKTmmlDkec1UnDwSTjydI?=
 =?iso-8859-1?Q?ve2Ek2Tgetn8hMoTYc3lY7MGaZn0F0d5q90wivbsIqQqM3Z6D5o9nK/ZYj?=
 =?iso-8859-1?Q?6kQL6sWNv3HUSySSJdKqOkJvgm1LTmM32gd5NKulDiXSF42TGlsJ2Se/e4?=
 =?iso-8859-1?Q?Gp+gpRu+V1sqfUu9BlP8s8a3x7uD//KOYWGq6BSeNB9F4jM5WuLVIAOR64?=
 =?iso-8859-1?Q?r2cq6u23TQRhQopKzV83I5gR+1Yxn5wHVDxJhdxSg806osS4BrYJUYT0ts?=
 =?iso-8859-1?Q?AbPy7+024/XtV7xfqqMzAi0MX0XMAh2sNEiJasEwzzNtC3XKf8s6pmKjcc?=
 =?iso-8859-1?Q?lJanndZuoPrvsJdrGPj3YVi3YPOYunNy1BqV8Fmg5h14v4oLV8O8QtfaKt?=
 =?iso-8859-1?Q?Sj0woSs7d5KhuvTkO9CK+V9fyFzu5wV09gJ3HtwdDbZUP9ktgRoNJHTvSl?=
 =?iso-8859-1?Q?Q34IwmraXhCHVxLTE0EztLFQsCH1gs1wp+G7IywbP6IA24laPe/m5QBvRV?=
 =?iso-8859-1?Q?8NtULWZTN7l+RdFdZPpbIR/T7NxloWev85?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: VE136J2ENWLx7kkX8uixMyeoVC+saLxF7awlE4Z2LNnW7LZma0E0UembDkQxJBk1lxYUlSJ7iszbDgJmVt+IGH5nvqpN6L2ORqlzdmh5QII12H1gQlZd3asvDktkFo31Nz4wexmgHowU6eDnfHJDsVWRca0yzaLGQFOsZ2abS0Fd2/u5Naut2s1ddwNmTrjkqsn1KRHRBYyzuonuaViRV/+mFcNTCvtUKu/Am1aEx6wb1OBIqrSNkUfWgFENW8TI6GS1JQzwTQR10eOzzS8slB9a0ZXPSB4xaYnvXuvFL6OZnJaDSGh0Y8XGHn+mwdkcrVQjUBT44spZz6PT+MoUrlz514lZRoQPH4WcgiPvu1pQs4kjIW9lQL4jj80XV0CGNwU82Rm2ODbl1X1/qfRkPqwvVOb2/PUkeZyhDnPONSHayt5HDMT+KsSdy+wkh1PQQ3wCRXtN9lw2SV5+9LPONWFFQb/qXIYmnE7PZMPJjl7/HVbZZoxqIOcGVTHGfTCVUdFbD4icygmwVINktLWdZPggYIpEvAw/993MzBcuJRESco8Nmz6CFPe6/m7aHfN/+7CHa5fRaS+LTcfJtYE0jIHgHKCyAZuvyMayELwHtUUi+sJ3xGK6NVUDKf6rojxp
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR04MB6849.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b9c7ad5-d93a-4ba5-c45a-08dd7e048e90
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2025 23:06:59.3098
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gUSb8TQHaOHzeFfttP/iS9fX1E5GlEHsHcV61yCh+wd0W1D202vzSxYygq7n8JiiKu+tY3pTsNAZii3jNxbXNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR04MB8636
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250417_160703_398910_E04A0B0C 
X-CRM114-Status: UNSURE (   9.69  )
X-CRM114-Notice: Please train this message.
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
I tried both of these patches but looks like #1 causes an infinite loop. dm=
esg was full of panics.=0A=
I had tried just #1 and later with #1+#2. Both failed the same way.=0A=
=0A=
>How about these two (untested) patches:=0A=
>[1 based on your recv-side fix]:=0A=
>--diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c=0A=
>index 72d260201d8c..4eb9a2dec07e 100644=0A=
>--- a/drivers/nvme/host/tcp.c=0A=
>+++ b/drivers/nvme/host/tcp.c=0A=
>@@ -1348,7 +1348,7 @@ static int nvme_tcp_try_recv(struct nvme_tcp_queue=
=0A=
>*queue)=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0 queue->nr_cqe =3D 0;=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0 consumed =3D sock->ops->read_sock(sk, &rd_desc, n=
vme_tcp_recv_skb);=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0 release_sock(sk);=0A=
>-       return consumed;=0A=
>+       return consumed =3D=3D -EAGAIN ? 0 : consumed;=0A=
>=A0 }=0A=
>=0A=
>=A0 static void nvme_tcp_io_work(struct work_struct *w)=0A=
>--=0A=
>=0A=
>[2 based on your partial write fix]:=0A=
>diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c=0A=
>index 4eb9a2dec07e..daf59e75cf15 100644=0A=
>--- a/drivers/nvme/host/tcp.c=0A=
>+++ b/drivers/nvme/host/tcp.c=0A=
>@@ -129,6 +129,7 @@ enum nvme_tcp_queue_flags {=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0 NVME_TCP_Q_LIVE         =3D 1,=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0 NVME_TCP_Q_POLLING      =3D 2,=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0 NVME_TCP_Q_IO_CPU_SET   =3D 3,=0A=
>+       NVME_TCP_Q_WAKE_SENDER  =3D 4,=0A=
>=A0 };=0A=
>=0A=
>=A0 enum nvme_tcp_recv_state {=0A=
>@@ -1063,6 +1064,7 @@ static void nvme_tcp_write_space(struct sock *sk)=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0 queue =3D sk->sk_user_data;=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0 if (likely(queue && sk_stream_is_writeable(sk))) =
{=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 clear_bit(SOCK_NOSPACE, &=
sk->sk_socket->flags);=0A=
>+               set_bit(NVME_TCP_Q_WAKE_SENDER, &queue->flags);=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 queue_work_on(queue->io_c=
pu, nvme_tcp_wq, &queue->io_work);=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0 }=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0 read_unlock_bh(&sk->sk_callback_lock);=0A=
>@@ -1357,6 +1359,7 @@ static void nvme_tcp_io_work(struct work_struct *w)=
=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 container_of(w, struct nv=
me_tcp_queue, io_work);=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0 unsigned long deadline =3D jiffies + msecs_to_jif=
fies(1);=0A=
>=0A=
>+       clear_bit(NVME_TCP_Q_WAKE_SENDER, &queue->flags);=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0 do {=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 bool pending =3D false;=
=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 int result;=0A=
>@@ -1376,7 +1379,15 @@ static void nvme_tcp_io_work(struct work_struct *w)=
=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 else if (unlikely(result =
< 0))=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 r=
eturn;=0A=
>=0A=
>-               if (!pending || !queue->rd_enabled)=0A=
>+               /* did we get some space after spending time in recv ? */=
=0A=
>+               if (nvme_tcp_queue_has_pending(queue) &&=0A=
>+                   sk_stream_is_writeable(queue->sock->sk))=0A=
>+                       pending =3D true;=0A=
>+=0A=
>+               if (!queue->rd_enabled)=0A=
>+                       return;=0A=
>+=0A=
>+               if (!pending && !test_bit(NVME_TCP_Q_WAKE_SENDER,=0A=
>&queue->flags))=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 r=
eturn;=0A=
>=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0 } while (!time_after(jiffies, deadline)); /* quot=
a is exhausted */=0A=
>--=0A=
>=A0=0A=
=0A=
-Kamaljit=0A=

