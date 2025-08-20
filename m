Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AE08CA0EE6
	for <linux-nvme@archiver.kernel.org>; Wed, 20 Aug 2025 00:55:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=pReDuGPsgWFveSt1alt4+Qr87xoE69ekm4XcO5dI6mw=; b=hdemq0pMmclMR2ArkHmmlbSjbO
	RGuotHSPF2vbFENHGYWTxoRZ5L0UWjbO3jWZfFvZ7G4dI17JwMHhsEA26feELlwelYONhxYv8BcZR
	uMxSM7PfbAfaKRFlpFyguNQsWqcF6xMx1jyYL78nAPBdVgGEX1deM3gcl/zcTAWNlvgpsgop51veH
	E2mYy7nRIMh9weQdOCT7/mp2vmiApjKV32v67rah5z/zlCa3E9hge62jTMkV26/43mTlhVtXH38nY
	fyCDy/61wnwNcvrU4Cpd7+gNiI8qz6NkJzNH/Rg728Q6t9SWWZ5ISh6igW3StC53LpiueG9kuc/Ge
	rKtnIHng==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uoX74-0000000C0GS-43ry;
	Wed, 20 Aug 2025 00:55:38 +0000
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uoWih-0000000BxKD-3rmb
	for linux-nvme@lists.infradead.org;
	Wed, 20 Aug 2025 00:30:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1755649827; x=1787185827;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=yDTHLrRWkS28fM9kXI6vyW0+uDoJ1XcL8rQ0w8Gt/4k=;
  b=dTXVkpTzAm06WRY+uKtBtl6QgPDJj6qjqixg/yMYV7hKfFMVjfghDKQD
   81chEL1oI7qBAqkO+Q5A9RoeZfwyej6989SCdLsFGhjbODPqsCIaggXvd
   pojjK29RSVV/NedcvcIdCsWS3df5oylyaF3PxnhtHotwvEYXMPEZ9mFQJ
   8T7PZLjOsjVDIbetHUbe0Us0iHrAbtGV1RPseyamwxQLH3blBsIKiyRJh
   1AxlDG1BQnl1UZdxiUM69FifSVGgkVotcQQwMEmUOIODjP2r8HUeVUayO
   T/QHbYi1lBsS5b2xWH7Uh6ogfmPMeKfAQLMaRQ6zywyQgexzBuJ8BFl+E
   Q==;
X-CSE-ConnectionGUID: eWP4mdoEQZOZjuf1h+cnFA==
X-CSE-MsgGUID: sLL8pCddQQqAxRZO68bgLA==
X-IronPort-AV: E=Sophos;i="6.17,302,1747670400"; 
   d="scan'208";a="105246371"
Received: from mail-bn1nam02on2046.outbound.protection.outlook.com (HELO NAM02-BN1-obe.outbound.protection.outlook.com) ([40.107.212.46])
  by ob1.hgst.iphmx.com with ESMTP; 20 Aug 2025 08:30:24 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PRW3MeOUIOh592IUPggL7CauFIcC8gMeC2x+DDwgOuhHWeqOBDfMDU18LDEK9QP1yAuL3zOypVys+oSb40NbSq/8w1nXhRtwLRpUKThwtLDmsGmvEwymJD4KUtVqFwjOLENuECKgeOujqo7SaPuzRcGLlLEt3fQ0Ke0T7c4uCmjLuR6Uy3nv0XjtrEZPmvhXu+KuaVHXrxkJedhciHe5AuY0Dm9gjBLKBhygKz19nUuCzRMTGf3mQrvMkTB2n4R0Ex/xOtHlGjZ/erYJJrjjrDYCHmzXF4Le650VlAjpPJVDRzJu+ymCGUUGW7CVN9bWBGhbG1GRjR1r1CSAGNPq+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pReDuGPsgWFveSt1alt4+Qr87xoE69ekm4XcO5dI6mw=;
 b=eop7FNMbuNyk8Wwz86ePIUjVVAfqLEfcSUwhYVxanqJCkfwnazovyAQ26IEZdZNNa6EuSTaoUll2B2xc6JRLQ+HihadgpIPO2iva59VNbnv+y92UYx3v+JaFxbKMYek5emWPC10U+HpSlnwHD1wU6dcZF9Vy9pW6MF3Y045ii/iGj30Eh7peQRJ8J6YYSG/w5oGi0K1yyKhOE+NetMMfEMl8/kj8zppQ1PASYHY5lxRXoqXlEfh8jLRn/nnA8WVYl0ndnhiRpFRanQVoIFbTSFW86Ex/5+pljEetxrVCHxwHjicRp5s1AScfIY4VHor3SPJTv4J/RFogOsyTqREqYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pReDuGPsgWFveSt1alt4+Qr87xoE69ekm4XcO5dI6mw=;
 b=vcKgxi1Tkst4gePKDi32lvNOS2FJ9SbIKnJSA/yKxXRFZTrmalxsYoIlzDo7npMWK5GhWfPzOyBP5UrMBAauZO0cnn5UnfRzcdtWQlcUgrCb1CFt5G/xitQIm7uDYhHPCdTH1jvqYraYpFXldJ1YywmvvWRaIrBphFVsermoRB8=
Received: from SN7PR04MB8532.namprd04.prod.outlook.com (2603:10b6:806:350::6)
 by CH1PR04MB9734.namprd04.prod.outlook.com (2603:10b6:610:2af::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.16; Wed, 20 Aug
 2025 00:30:22 +0000
Received: from SN7PR04MB8532.namprd04.prod.outlook.com
 ([fe80::4e14:94e7:a9b3:a4d4]) by SN7PR04MB8532.namprd04.prod.outlook.com
 ([fe80::4e14:94e7:a9b3:a4d4%6]) with mapi id 15.20.9031.023; Wed, 20 Aug 2025
 00:30:22 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH blktests] nvme/050: repeat checking test device
 restoration
Thread-Topic: [PATCH blktests] nvme/050: repeat checking test device
 restoration
Thread-Index: AQHcEDmptBaX12h5dk+BlEPnox5cbbRolMqAgAId+gA=
Date: Wed, 20 Aug 2025 00:30:21 +0000
Message-ID: <a6w75o64b3zced2w4wo2wlxzkhxfwhpn5wxwpp47fuv6mdzf7a@pvqlgt6n37tr>
References: <20250818121429.1579513-1-shinichiro.kawasaki@wdc.com>
 <711d41db-4555-4297-b4a7-648f839958ef@nvidia.com>
In-Reply-To: <711d41db-4555-4297-b4a7-648f839958ef@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR04MB8532:EE_|CH1PR04MB9734:EE_
x-ms-office365-filtering-correlation-id: a0d746e1-0ef9-4124-e372-08dddf80bfae
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|19092799006|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?jhP4YVBkkEoJrJftF1pblh3+0GfilpukLGkQv2GzplBmtxB+KG0Z/uas+S7n?=
 =?us-ascii?Q?OcxOCBGPRmzrkI8dAGorEpYjJrO9QAh8C+9rAr2P6raImMTEkisgAmoBQgE8?=
 =?us-ascii?Q?Lfh6HPsdZP0/3WTP4e5agMPvwqXE7eLZYMTqnrHBrM3vH3964xgiF1bicKWN?=
 =?us-ascii?Q?Pki/a3rzqReynGgKHQkBprXFSYTamu6e9VFVoTfWh0Qtzv7fBZU/8j7IDsW3?=
 =?us-ascii?Q?IUG4qcTDQ1KeChZChKNqTtFGKGwsLmDCeENLQEWQcPf3yvPP/Ok2qKRM/Gn1?=
 =?us-ascii?Q?wL0q2tVZ6bMnxRsM0vzZFVKR1SuORioUdyAcyA9OFVRSW5hYE2tg59IPIKBB?=
 =?us-ascii?Q?feWmZx38KFx+/9JWvPVw0mffB+UAFTV5fRM6/ndgTY5EgV+fgUIp5lsNBIo3?=
 =?us-ascii?Q?bKKmXSh28HCWTWc1KADoZQw7IGHx7MXCnxwc5fK8qnLpOzrvqiH930ISRgPd?=
 =?us-ascii?Q?hORSeAu/4dSJgZ1ngjKEwPv3KRaHp46pnD/aIjBZ6OAv9tQKgUrdm0p0cg+t?=
 =?us-ascii?Q?FDPJ+I5/d0vh2OFSBoqlS3K4geksC4S+0jiqrkWdbNY6ieDA4gSxCHpjxb1h?=
 =?us-ascii?Q?Nvgag1X+86oNUyvAQ6v55zWSEorEksnvz1jqI00zCZBeTvjGHc7Dw8LrH7HM?=
 =?us-ascii?Q?vjl4jnzO1NMzjH2yEm+EQHfqcfTAuNcgLkgjRJM8u8FLM/LHs9swY2LeGmpK?=
 =?us-ascii?Q?oXXkk5kFpBkneTnEioWAQ2kkmMdSSFpqWXGx7+kIDZs5OU3ZFM4RwlCQ1Yrs?=
 =?us-ascii?Q?vdYtVer4nnL9mVzVIOncW6qcY7qDDRk6/Vao4Lehs6KsFiel7I/lgOD9/iXZ?=
 =?us-ascii?Q?qESf36If6se9OphHmkQt+i9twCJfcS/sSi09N21j7iWc3PObVxPgqkzwdh6m?=
 =?us-ascii?Q?ySqXDwcPm4c6HzcpUyESzQOPuPval8Y0Op3/ZjfnwRDSo9eBsIYMRDosgRB6?=
 =?us-ascii?Q?DUM0/PGAoARvBT53wbc8FPpmTNlb6+TvgmVtuKUjtVDelEjD+7CD0i0D5XyO?=
 =?us-ascii?Q?pgATDGjcACMCPAsUV7K+r/7KTHLIXF4SruydlSWpLLtesXbf7XR6k11hEx/5?=
 =?us-ascii?Q?YymIi4BuWwX1RcHwV+0rtN94ntFNKXT5khKyFpAaV415YYuBSzLfsoMqtE6U?=
 =?us-ascii?Q?/jiv0XY7tguDqo/MkR28vaIU28PvUP1cJjhakIW4oYAdvE3oZpfiJFafv+RF?=
 =?us-ascii?Q?hvKevelk8A64noTPsXG+r+QrFvuvI1K846D2+XxU4Gw1ovSw78p3UMaz3mxy?=
 =?us-ascii?Q?8UiwUHAg8+7zC7n59gqeLQ9rTYVrlJ82DmvVohddVB5YvZhwTF8fXYMUwK3T?=
 =?us-ascii?Q?tmPy5P/7MhYZWJtfJypl+iKzqMWGkAM6ZnX/q0BhpnpkiOTESq73dguJy1DQ?=
 =?us-ascii?Q?wNGFNPH6HS2e5OLuQTIwvXD9Z+OCU/XRuDizbLaXW7x4ZP4qvAGyDrxU8XG9?=
 =?us-ascii?Q?MmCqt644056Z1LOxLxmi0kTXkR7A4vZqkKNLp/0EhHOZV4Rnpk5VUQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR04MB8532.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(19092799006)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?nFknAI1LX2km7iMvH/mNWZZcfcqKZpm3FwQx0mg5TXE+ifdadwcxGPa7TpnH?=
 =?us-ascii?Q?2IedWqyALC61UOXNpMZWbwA7248vt9/rEJmiQ/8x6iVLcDEfYCmzHLsFk6Ef?=
 =?us-ascii?Q?DaARx3BenV4my4A8rGXRObDEy4OufH1bxGR9BbZAc3v9SNPCtjIkita7Y1jx?=
 =?us-ascii?Q?zOeC9KphcnG2YayGWW2a5wT7SBF+pmd0ZxG04ic8ZsvJxjBogNQ+XirCctht?=
 =?us-ascii?Q?1oMNoomR+O0jN8TYphYj8jL9gHkNvJyhpYhkW1JyrjPqNo3ex9L2oc6Hu4NN?=
 =?us-ascii?Q?fGkOFTNXMkwbhG2vr8enAj65jYZirKXDtbCWTEajXXOsCNDUvWQmb5NWM9TI?=
 =?us-ascii?Q?KYg163omDkW6r01fsjv3AF6Q6MBgz1+kk9MDG5itg6dbkAXrD5hDNHp5UggL?=
 =?us-ascii?Q?WwRrhX/kptxmBHzzgE3mm/8DiZa2DPNJHyuTiHLlbIk+/SYJ2ju6ganKsh8/?=
 =?us-ascii?Q?I01ML1dyvU1nCNUZ/lc60gcYqH5LQe0wbvBcAxfOplaKeSuOPd0/2AZj4dvt?=
 =?us-ascii?Q?p57r6gP0rgmJLjNJdaXBtPDBoivPLkYccBddF96ClEjKmKUhm9Hbkoyz94Nr?=
 =?us-ascii?Q?s1pQBC3sRiLxICcQWsEOdqa5nNXJNxRm+E2sZkMpttUHDYHeROCCXyM2ioQw?=
 =?us-ascii?Q?ASrBmmgeMI5TJfocmtvOFKU8/nCho6oIj7uIMCLdrCLjmDTdmwSf0ATxqUyV?=
 =?us-ascii?Q?Bxj5rroBs2h9hOKdm7yioNFj9DwFNXsjBHF3uWj0De9QUbVOb5jexHd+hvva?=
 =?us-ascii?Q?9vIYzfCJJaTB8ie8TIYoth6em0F5GhRxJMYaoUq2P4IO4CXN9Syd/N30Ca4W?=
 =?us-ascii?Q?bLxBgevp1JKz2/nmiaO/JPXETtpk91JDWkBcwTLTv7KQra65RA75hWehL87S?=
 =?us-ascii?Q?F8ozVvTTqD7mvNsiCDFnCKfHAL/I7Ci8fw6U7jpeHMOMYhYSVBhwwSh5tYvE?=
 =?us-ascii?Q?9XTNnvmnpTVNoGVRid2SXp9Vs5rqND5g1WcCMGjdN4+Iu96Iu922wP13A0fV?=
 =?us-ascii?Q?RGYPdeQzSj2OXjZuhD0PbkfFadDgYp5qv/MzmWUpmE5LXI1ImLxxAzeRkXn0?=
 =?us-ascii?Q?stl81BFq1xjldTagAjc5UaiCzoIbzA/LA1p606yXh8TRv1Lj6gEQIOEGbe29?=
 =?us-ascii?Q?6FhwoXSeDD2BuPItqCtoLMuni1iBZcjojkaSbOfPG8pBuL9kfAWKBc2+KXrB?=
 =?us-ascii?Q?eueB9nijYfk8sxD8rnqxwgRcP6cwUhjvUrvGLo/eU2bYFv6X8eEwtgyxfqjH?=
 =?us-ascii?Q?pGr4HAh5ngS2+GBmGl4L7p3YTFO6qyUEFQ6iOUO2p1I3lB7Z22LCclgnAnLJ?=
 =?us-ascii?Q?tk7VHVC8NNLm6/FE3YV2tYoGli4Q+TIoG7wkDtXVGFCR97NIPk2ZRO1gPHPs?=
 =?us-ascii?Q?wMEIk2qvHxvxkY+CLzELOSMhMpCYu2shPZYd75cAMt8j8jlna7vSSL6G70ks?=
 =?us-ascii?Q?Fahxr1cygJbns2a5pvTH3hZEcJZu5CySNe00i3/lwvk1tXs5jadpQBwVJ1fy?=
 =?us-ascii?Q?yA84fAxP/nbnVoDE/w98OcCZ6DECj5fkLy0+JUIJpjC7fIQEf0BR6ARM/AyV?=
 =?us-ascii?Q?Q4IEBii3JTdoGeUYEwf5d4WSeOh0vIOcTn3ysxrAEkrwvlvpFGLpe+zFuXLn?=
 =?us-ascii?Q?ug=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2B8EB032C4D4EF43AEA1E64FC17A9A9A@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 29/OeNj3HqElS2R1EWfW0pKAg76il4SkNc8m+bkrlwJKYORiXrpqfXXNsdSZG0hl9JD4ImO9p/5UXM9ssaXUORg39AB6bERY4gDLc4B++Q0N0zpK55QiFrzeCZWL+YiRf7OM9a5K/w2yrZ1nrg0/xp0orgd928bmCidPAQJhpPF50Lx/dHAOoOnLnxhXSxaLqyZIrmBCocOem5XW9lY1vUKTUo0YiYlOOWZTzw2QF0wBnUi4PEVvsX2bg7TJGtBvECfBUM7DHn3IrvyFOKxoeUmzQLYASYqBZBxAA2gzS8AvN9BSJJYJ9NEulLMnmaRI+X6WneVidrXH6d4hzzm/+VX+ZoTEDTtYepJVFnJ4lQPo4eeBgw8aw7PTYZaumLx2/iGP06rELzsFg1nPGQVAr9QJ7MV1wPiaydhfP4CL3yMfLhy8QcE8EAt3kahBCwRmlYmS39c55Gj7QZPf/oIJQ1MNzKpUpEamekBdq93hXeRPSONhWGiPxpnoxh9RtnI+dRqysoJLgEtnkXVk/qSGcSlkZ9dypLf9ajiRHjlyrV/9pX6MRCmRh7WCix/Qjvbv3WaMdsaqg2lds0kBYNdZyhLySZN9MP1MPWiHkxeUkKzUkHxZD3yAv+gzJTmyVSyN
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR04MB8532.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0d746e1-0ef9-4124-e372-08dddf80bfae
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Aug 2025 00:30:22.1054
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wBfDDkcXd2E1OmNbKdc/+k/lCV7pcxz5YWBvQroKpC4xZjO5NuI+b5mKkUgtAEjryG3bHGUV3ljoDhxJPSzmLoNeh+r6UD4wegwRpYDveqI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PR04MB9734
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250819_173028_000118_16B91B1F 
X-CRM114-Status: GOOD (  18.01  )
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

On Aug 18, 2025 / 16:10, Chaitanya Kulkarni wrote:
...
> > diff --git a/tests/nvme/050 b/tests/nvme/050
> > index c710832..ba55c6e 100755
> > --- a/tests/nvme/050
> > +++ b/tests/nvme/050
...
> > @@ -49,7 +50,13 @@ test_device() {
> >   	# Remove and rescan the NVME device to ensure that it has come back
> >   	echo 1 > "/sys/bus/pci/devices/${pdev}/remove"
> >   	echo 1 > /sys/bus/pci/rescan
> > -	if [[ ! -b ${TEST_DEV} ]]; then
> > +	for ((i =3D 0; i < 10; i++)); do
>=20
> This looks good to me, however do we want this loop bounded by=20
> hard-coded value
> or we create a config var that user can set on respective setup ?

Thought it is an improvement idea, it looks too much for me.

Actually, the test case nvme/032 has the same wait logic using the same har=
d-
coded loop count and the sleep time, as a test item. So I can have some
confidence that the numbers work good on all blktests running systems.

> either way :-
>=20
>=20
> Looks good.
>=20
> Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>

Thanks!=

