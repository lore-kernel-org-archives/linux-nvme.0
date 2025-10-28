Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04EF0CCD1BF
	for <linux-nvme@archiver.kernel.org>; Tue, 28 Oct 2025 07:56:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=WSv3/gz2exlIpK5d0AD+NdrCa0MIGi2SDR6QRo5UL0A=; b=QyvRsU2RpIxf5ZMzVFoCXSHSwb
	3OfxoNUG0CsSQA1ixJHMkvVDga7YMDRpDQ8nIKxETQCdIuRjbeYSaoXmDIYRYIUrBx4yVHO/neOj1
	AWO+WXrBqppKAUZoxYz7S8OG7UPkTcCXGPF6fB/kd5mt38oxS4cwH6YgLqhZovJGsQSgi7TAKEY0X
	G4s9lwORhEJ9xIbRscUG2NCHCSEi0HpvEUXY3HBMgs3XgvpT/2R5ADZ9OODVktbaJIds/fItKx820
	BWK6YbV2usm1pFbwt6c7mLK9p9iCrooHlEYKVzyj0mzX6gvxZuwMluAiLHbATFO4NZhHsj/21fNY3
	tlq8YKGg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vDeYp-0000000FUCf-0cqY;
	Tue, 28 Oct 2025 07:56:07 +0000
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vDeYj-0000000FUCF-2KGI
	for linux-nvme@lists.infradead.org;
	Tue, 28 Oct 2025 07:56:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1761638161; x=1793174161;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=ctu8OPHgW2OCzzuoruMAkyTCKR6AG7Ts/BtYbbJiSBY=;
  b=FimUSt/CD7Zi6tmOMW1HW8TWlJLQSNmbK3qAiVD2PXBJeLAAU+/7/rZ4
   A/3RkCg7b6SVwv7ef6SBBDgx1R9SpU8Bd4hHEciT9cYJz6iN0zsft+1xo
   a980SYXqNd4bqzYF4R/EnzXuOKw+MelDKbbWKHr37cH5yj8t1/YRkoukx
   TElXfPaiSdiKZwhwtuC/iPjKhudajo5D4MSmr1UMEJFlNqNlaDq8h5a3S
   8ECyjmuHVpr6YiqZfDTxcjwQXRtt3k6eK2C4t80vcTv5/w3WAwVPlniSv
   EUM10QjHOQ057mkHA7wOknS3egXMUylv04a7X/2jUjKfksYl/545oHhdc
   g==;
X-CSE-ConnectionGUID: EV2uqSfkQ2i2dT1OZcKHyw==
X-CSE-MsgGUID: f/p3FLmYR7GYCci1Dzp7aw==
X-IronPort-AV: E=Sophos;i="6.19,260,1754928000"; 
   d="scan'208";a="131026226"
Received: from mail-westusazon11010000.outbound.protection.outlook.com (HELO BYAPR05CU005.outbound.protection.outlook.com) ([52.101.85.0])
  by ob1.hgst.iphmx.com with ESMTP; 28 Oct 2025 15:55:58 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ihY/KJYQQnOeaMMEynJbFf6QglDUmk3fyMuMUiQQo1+25UVBXG0XvWDPr2Hb4rleWVExDKcX3ObeGL0G21qjVT68t1rnokQ3ExsTiy8tC3lzyn3zeD1uPoQ5aTNUevt0hRubfesaoqNblBGDI314QPyDcyJJlWuwS39vI2gnBxsgy6+0vchTtO8+i9DJxd7kIFh/1xmmTNMjHc01wtKuygjAVLvLMHn+r8CwR84FzTG8grfq7YKNHwTHHEHyLPz4ydSJajUGMJRdutu9YTyk0Qyxg4h1DRqyemrtK7NsNK/gEyHTFbrnpBK2oYyK2glwCSP3XlYiFhA6gkau5pA8mA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WSv3/gz2exlIpK5d0AD+NdrCa0MIGi2SDR6QRo5UL0A=;
 b=GXbik3jzt67IdYV/bgeZaqT7rG3yxKgYwYhGpyLSRwAmiP/NdtYIRSTACPNV5FUKPpJR0he12dBu6gkEXk2Z9nglSiZk8SPiABWkQiFH4S25O7ldFrAthsthTeasKP6zgEuAIx2NR8aDDlTS7vhvyz39wt/ed/nfXCu3W6bSFOm/Z1gl1IBPTUniWs8s+QJf3gHDoPAegI4WgIMvMqJfqvfilLnsqf8K544d+SRJubqn9jMoHzkPaiQDmB33i2VvJM7Di8y2PJGiZouWygfdaiN25E0jwcpop1JxH1lqU0Vhs2oG54v2V2C/W9R8u8RZ9GjL/6RP/BNUrZ+QLzFeTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WSv3/gz2exlIpK5d0AD+NdrCa0MIGi2SDR6QRo5UL0A=;
 b=gqtXsAA43Oe5T1bbKcsSNPAeHbzEjgXt4kzfz9Cw+5C8QONPW8cyH7upWWl3CRzPIegyJ/yGMmqAevfoFwSQtIL/F//sgWcc5Kw5aG/KTe5UVRExFXpLrwQ0ZFpnlZAYpP+auQkMfOXBso5PHKRkk+BRwJmkGFdzWvgIZ9sp0xU=
Received: from SN7PR04MB8532.namprd04.prod.outlook.com (2603:10b6:806:350::6)
 by CH5PR04MB9598.namprd04.prod.outlook.com (2603:10b6:610:20d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.19; Tue, 28 Oct
 2025 07:55:54 +0000
Received: from SN7PR04MB8532.namprd04.prod.outlook.com
 ([fe80::4e14:94e7:a9b3:a4d4]) by SN7PR04MB8532.namprd04.prod.outlook.com
 ([fe80::4e14:94e7:a9b3:a4d4%7]) with mapi id 15.20.9253.011; Tue, 28 Oct 2025
 07:55:54 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Keith Busch <kbusch@kernel.org>
CC: "hch@infradead.org" <hch@infradead.org>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>, Sagi Grimberg <sagi@grimberg.me>, Yi Zhang
	<yi.zhang@redhat.com>
Subject: Re: [PATCH] nvme-multipath: fix lockdep WARN due to partition scan
 work
Thread-Topic: [PATCH] nvme-multipath: fix lockdep WARN due to partition scan
 work
Thread-Index: AQHcQ7K6rFN9PEEv/k6PxzzbrsKZb7TPO7YAgACPX4CAB24XAA==
Date: Tue, 28 Oct 2025 07:55:54 +0000
Message-ID: <c4iaipkglrhgjbovj3uvj4pxnbxdirzxm5yymidiqii55h3i6d@plehjivcjs54>
References: <20251023001937.218014-1-shinichiro.kawasaki@wdc.com>
 <aPnDLr2IiOQUQLKI@infradead.org> <aPo7c8aZ7GDqHFEO@kbusch-mbp>
In-Reply-To: <aPo7c8aZ7GDqHFEO@kbusch-mbp>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR04MB8532:EE_|CH5PR04MB9598:EE_
x-ms-office365-filtering-correlation-id: 9ad2e991-a68b-465d-e7af-08de15f76c13
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|19092799006|1800799024|366016|38070700021;
x-microsoft-antispam-message-info: =?us-ascii?Q?P/yWS2aqaACkoP1vruZWhpbPtWEaVh0NLbCZKhS4jDy3yHLzzopzKuPOK3R8?=
 =?us-ascii?Q?KwVWcBPlJg4oaq9ogV6PhWEA9h74FjCRCfNDgOpC5Cxv0YmGQeaHtghyFUWq?=
 =?us-ascii?Q?4B7n1YTzz8X1Y3TBV7P9F0axlgXfmmH1+sjSiifLUA4YHG+lL51mWO5A7BdM?=
 =?us-ascii?Q?ro23enRML/2suSDCbCqUjdw5r7fyPoJoGXnPX2NOHCyF+mMjCM0rqRu2STYI?=
 =?us-ascii?Q?9tAY+dpefAOAg+Bp7+NVoznBezQbIOn0cDVa2oo7qeHm1NfhMy4hXEZd6N7K?=
 =?us-ascii?Q?d1b277u8+DPPbFgyql/51v0d+MGXyaOhX7DJPFDa6spk0EwvHklKbxJ5RkQ1?=
 =?us-ascii?Q?yPKTIkuu1OhDaao670op8diMpMzChcc+2HkTanNF9mfgPMaxKJDPfe54sJa7?=
 =?us-ascii?Q?2O32W7kOHlpVKboQ91zdqe+S2XcaKrOAuMOJW7ax+NRYzYHhBVx76dccDfJU?=
 =?us-ascii?Q?Khp/LWcF6efbckfZ5/RSmRX3wF0aPXMRbYFoMygunMBFRO9+kVrelbP4/XT4?=
 =?us-ascii?Q?3RnGUoYnSKuV3ztnKQgKwsybOpCjLE/DbRuGN+7YvS/ThmAOqrsPHN10yV82?=
 =?us-ascii?Q?dX8nKBjYlfrRFtjYGeq6nphOnZokELGwL1yclVdw31OptFTTTnak/NH0MHvi?=
 =?us-ascii?Q?A8tLlwz3cKSm5rfmYsQXNqfzB/rpy72wWqxhtJ6fwmb3qDHTb076qKZCu85O?=
 =?us-ascii?Q?aCZ86WqbDqxikaeLFO1Dw8hwTdhhDxpjp9/lN/0o+6L/o0Q/FWdDFts1b+/x?=
 =?us-ascii?Q?1Talt5gJyneeu5p7H6rfcvsQ3UAg2/qxyFsqUL1GawxVzMaITNfcjQv8q6Fv?=
 =?us-ascii?Q?9rlhxsUGPqPqvNYPO1M4iNpM2NsVJoR4MqQgwmJlCzvkMTKy3piHVSw+MwP0?=
 =?us-ascii?Q?dvkQmhjIMsB3kQSJb2VEr6ddO2yJrKfCtIIqybnA5dZKWDFyqP3taii2QO7U?=
 =?us-ascii?Q?rJXQcB+/NR7q0TX6DRHcrIBHRnyLy+0LLTmZrK1jFfeSEfSZb7JtSy/Qbh8c?=
 =?us-ascii?Q?JUSH0RUiCPtWlvMG/usBq+thf1OVXJ4PguRqqgncFlFs4PVygu5m+GkfFJUC?=
 =?us-ascii?Q?IQnCnATBt7BaAWVWsx/kIJrwVh01fejYLvZcjLFuThOMwsiuLLSCOcSZp7PZ?=
 =?us-ascii?Q?qvsQpFGmkMjo3PE6DN61RwIVOEKxAgqIdnyhlO1brK3jiGzepWBFhTpWg+ty?=
 =?us-ascii?Q?VS3195jVNFSnjkPVCA4+plg9JF0eulzXkBPtzef71eJMD2xbMw6Yn7iLlu58?=
 =?us-ascii?Q?ex/jt7z7PDRjsvLlpmHig9us6Mv3ZizXsex3uBKccPgTtey7UOqhz7y9jlcV?=
 =?us-ascii?Q?DsahfTiJJAgC/F/jImnyFRUD4c3buK6lV9lOZhsaIDMgoVYcpepUpP2V59KA?=
 =?us-ascii?Q?rXCEvatZBexy/J9SQYfG3YLYfjRcW6/iTVkH/ClKmuzolwszufr7HnntUe3l?=
 =?us-ascii?Q?+yjR9uuNtwfg+thzC4Mzoj/pr5PvoOnA+YbrXQrLNSMt0WvD4yEbHXgYTMb9?=
 =?us-ascii?Q?wG+6ENAb3C6rNYausMTx5NqJtUbh2i838DoA?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR04MB8532.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(19092799006)(1800799024)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?P0ID3dU9LRn2Q+OjBr1cc8N1/iiXtAB1JvKf0VPl4qp82nqqz/Oats2bI79U?=
 =?us-ascii?Q?3152UNOonD7LzUPQx0AN/yfLIUMBj520W8osjSft4GJVz87fZH4r18zLgFqL?=
 =?us-ascii?Q?9mtLuVxqfkq2FoACN0qdGDKb+2wiYg4PahcyGpPhwLur9fmyExPnTyLnm+y7?=
 =?us-ascii?Q?YVBZ078+CRYXT908c8afcz27/rJXfSnx610BiE/MubQ669gEU7OjZzfpNv5B?=
 =?us-ascii?Q?J8fsHWxb4v2UnnXPLGDEBsiDhSwkZJlr9TK/jIK3GqUEbOD3uJ1KhnVBC5ru?=
 =?us-ascii?Q?J8ELrSXsq2cazTfwKJ/PRwN9dnXcBy70Cj3Eajv1feX/L0tcUYyoXmMVfNLN?=
 =?us-ascii?Q?re2MiDSLTH+xM9VtL1OucVPyXVkHpdYwNNVa/AqWSPO12qUUGGjLenW1v/f4?=
 =?us-ascii?Q?4CuG/bmZMWa7ZkarZVDnRTIPg8zhlOWWgDsYnHkOPm+bDw8CZHsDViaOE3re?=
 =?us-ascii?Q?iUt+PvS3zZxVder8aXeDwsSheZkpcUIY9nyd3EEXckoXEsI9oDQJhyjFBotG?=
 =?us-ascii?Q?L9s949glJY4drj9lDpvmRJRmicCNmns90y0/Wg/BQy4dBHtAD6f5Y8ELP2OX?=
 =?us-ascii?Q?fAOcH76QKGyktwtL4JSZvqoPxKBpgmUGG8sJlbiJjm69x0A5h2OEVLemlQAe?=
 =?us-ascii?Q?sAD6zk+JGMNF0+3s+Zuf0kzcr1MAvY1ahRzqZPEpWp40p1UVOogS0Zf32hyy?=
 =?us-ascii?Q?gtzcqAT7eu0w63FG34EZiR+mh2xrsRJmXuVFzeSCDdf8SuWQQYuKUj1j9CfC?=
 =?us-ascii?Q?VYnqI8rvzNssC7vkpDHxqyIaHCiPKQd1UpJJ6dYpQMdoRQ+Va9R1WToBWVDZ?=
 =?us-ascii?Q?RRfmrnY2KyU/1+tp7132ODk9BjbD4x8IRelnFr9CHKbiZ9nPqobcloijezyQ?=
 =?us-ascii?Q?dL64vQBFySdO23IDn7hDAhD4ZA6+vxItsxnspdBJUQ3wgqCLaeX5MOXiBGkh?=
 =?us-ascii?Q?nKGcZsaW7v//qy1Jgqu2eYlg6YGLb5tLtaa0aDIIbbLyR/UwbKAxuF5tx5Ue?=
 =?us-ascii?Q?IVtpjqrooyaCgO6sHnvI9spqgpgl7Klk6EsFpqPZUuI9myozi0oHN+6pixTZ?=
 =?us-ascii?Q?vLAftWVANYfWfS7XqKydU8DwJHYag+3nQ0TDyKec6kkW9EBfNWndQ9jq0pky?=
 =?us-ascii?Q?PnQ4TKr6k23j129RKxlewTreFH9FD1YPNHfQxI+yrbrkNfmg3NsBxXS4A7Mn?=
 =?us-ascii?Q?pwGtpXqVI8mXAOJJ2eQjhlb9eCmgt+/VAjptncdtSPPR37ILQOplQWrmoriq?=
 =?us-ascii?Q?UNXiEC+/ilrxRs56TqqwC/vU/4zrYb0QH/kRTdosrF4MaYjnMfNyzEDVzS1n?=
 =?us-ascii?Q?ACR1enKRAJB6iQfJhPcdVRwvUX707hOkUci1mI03jJ8aO1uE6xJcdXIBqHO6?=
 =?us-ascii?Q?SfopnDapDQZULpubVaQDc15aQAMxMKpkpBwW7DBLB3u2+fjqmc6PmyTIhkkQ?=
 =?us-ascii?Q?zigFvievYtxYtGXMbRj3qyoj+Q9ATtlLmPFxCzUkUNJ5a2/geH3udkW7M5Hg?=
 =?us-ascii?Q?X4M4aK0L93jHp2xw8xISne7UEFCPbVudjBDWx7BD9ySYU4FM9zMrR1P9lcpW?=
 =?us-ascii?Q?Lx8TgXf4u977pxOVKBuKVFvxQYuMDwkMm2z1ODiC9ShYWRnW4uRmBy2EhCnz?=
 =?us-ascii?Q?BOZQsb9b56tBcYGgQwCGHk4=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <9E778527AC8DDB4A903C2AAAC4B91A24@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: s/oWBtc1W6P2q+ruY5iIlckdEdqjWW+rZXh8S9LfKMD7pVeRsahU1DRfX8NgDmwCgZ8g295OWe2A3UWVHGEVPeGTHIp9knWCyll4HZnCM8dvQpxORB7D0Roav0hMPz6ksGQfXp7WYMMJ00PEiW1NgNIhxDfVxQ3Qdkl1FA/UfUAj50xE5O8+KvRNDSVThuwNRgS9Z389wTTbd4kcy3sNojl9TVT1LkhHQT/5GuUk9SSKWFtokEymEB1tqENZ3RstmvOD4uocw3Q69UAV3btOM8ti66jWV9tfoIdFlW6Fl7KIEMW4rxTqMoxcvMJDgjZZKhLXHkB70fcjpUmWI4/IIiFqUGozgwfDk4t/wj9RW9IAnubi7f50ibPuTAD+anuFpEA6rp+9TszNMp+og9jEYEYfeoHDBaAqdzipUGWKhWUEROhS3BqqwuOQNnJ9DWiNxPLKa7by0KwtUFqFgi1yfKhwL7UbQf9tUHB5aOmNDdWvHRg60MEEAcc+pAj5tobnTTBZSG+9xj5Lox58QUTpKl0n6bc8g2yuWb956D8c3mr+K0yRLxSUE0jkZiC42FtpKnz4VDVXexhrpueuEU0RsXwsjebFT+qIK+5G+92bHJSElV4MzjoPdpoP6jzTIQXP
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR04MB8532.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ad2e991-a68b-465d-e7af-08de15f76c13
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Oct 2025 07:55:54.7467
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FM5W0F991nkYjIfc6XzbG4slXPbhGHyoOWFAqV2sFk47A27svm37v+6kVvC95g+bN7zgyOjeFD3Vk+6zXzGmu/HvmG3tWfqa5oOvrCQej4A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH5PR04MB9598
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251028_005601_678356_6115A55F 
X-CRM114-Status: GOOD (  23.36  )
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

On Oct 23, 2025 / 08:28, Keith Busch wrote:
> On Wed, Oct 22, 2025 at 10:54:54PM -0700, Christoph Hellwig wrote:
> > On Thu, Oct 23, 2025 at 09:19:37AM +0900, Shin'ichiro Kawasaki wrote:
> > > Blktests test cases nvme/014, 057 and 058 fail occasionally due to a
> > > lockdep WARN. As reported in the Closes tag URL, the WARN indicates t=
hat
> > > a deadlock can happen due to the dependency among disk->open_mutex,
> > > kblockd workqueue completion and partition_scan_work completion.
> > >=20
> > > To avoid the lockdep WARN and the potential deadlock, cut the depende=
ncy
> > > by running the partition_scan_work not by kblockd workqueue but by
> > > nvme_wq.
> >=20
> > The partition_scan_work was added in 1f021341eef4 ("nvme-multipath:
> > defer partition scanning") to get it out of the scan work to avoid
> > deadlocks.  I suspect moving it to the same workqueue might reintroduce
> > the deadlocks, so we might have to add a new workqueue here.  Keith
> > might remember more.
>=20
> I don't think it was a problem of the same workqueue, but because
> partition scanning happened in the same work_struct as namespace
> scanning. As long as the two happen in different work items, I believe
> they can use the same workqueue and be fine.

Keith, thank you for the comment.

Christoph, do you think the comment by Keith is enough to apply the patch?
If you still have concern, I will rework the patch to add a new workqueue a=
s
you suggested.=

