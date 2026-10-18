Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 507CDCCF2C9
	for <linux-nvme@archiver.kernel.org>; Sun, 18 Oct 2026 12:26:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:
	Content-Type:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=JecOddfu4oc1dnj+HoMKbfgmdUe+xfZGW9eYZlLDZ8w=; b=ih896+ZwW+Bua2m/5bBMMpCh+b
	5kEgjlPFF4JDwzOoySMXGhSIEXhnEn+vcnp4ckv1vPXjNiuHRrljrR2O9Xi4omVGeFw5pOx9Hly9W
	/BMWFQ6MhSCtNVb/7axgr99P5o8yUtL1e1NvxJW9kYaTGQ3uBRkS2zLBNanfry+erwTIJG1+dYU0C
	KqTOczOMmekCX9xdH+EVfCWbaPLVVBYbdiR17ztnCUU+s70kao+oTFP1P9yOtkfz1BrzFubLg/kfu
	0uF4zzAabPAjD201t9GIzkOc47zKYugGwt9Oa+TIq5Ew41rBgEFzrLn4hdjvGFpowV+7GvzMtJoOH
	dFAv6Q1g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xIPxx-00000005pwq-1krc;
	Sun, 18 Oct 2026 12:26:17 +0000
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xIPxq-00000005pwS-2RAm
	for linux-nvme@lists.infradead.org;
	Sun, 18 Oct 2026 12:26:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1792326376; x=1823862376;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=JeMDCASuutPDPB9r/CqXrhec4nzGnkF+imy2/0R5SNc=;
  b=E6nIzR94gbeVZuoML0OosBvlaJxMpcuswPRlgFxWO4GJs0xNkOI4KQ5i
   WrR8zhYr3/EXoXZJqNzyaPj3aLbdBcPBaKSnf2RNnsuplptVPa2f5AWLR
   SECMc/m9DiJ5eaUn88y77tM0Jq4gFjZmFVk5GoibJUmbOCAjNEsStGW7Y
   RJEtqgbZUOzCRXqT4LBUouv+1k8O8sTvyNfa0SE3hMrtKSipIOdNXXcJ9
   rui6lrEKkOlUYvqybvUTUe2EARv1iES/kNajtCudEwtk5n5GddDnvyyxv
   krLdbE1Kn89JbN3wr27vEXl11FX2V/nMcfNv376RIuu6Jezp3Bq+X4c+D
   A==;
X-CSE-ConnectionGUID: mET+U00GQU2BUP2gPmXDHQ==
X-CSE-MsgGUID: j5V5/E1CQESe1UPljjQqqg==
X-IronPort-AV: E=Sophos;i="6.27,165,1786982400"; 
   d="scan'208";a="159332338"
Received: from mail-westusazon11012048.outbound.protection.outlook.com (HELO SJ2PR03CU001.outbound.protection.outlook.com) ([52.101.43.48])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 18 Oct 2026 20:26:12 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GR+wSWxnqgYuWquNid+A/xCfnHndeDXFqnJy56ZE194ny00GqxWYVs3Y2srRChiTMrK1b+6Q5ayzkz3wxW0pI/qcz8QbWOGcrzVV/qx/+zdsLPQLlqtINWkpYHQSQ7EjaRlYxsEspwVF2rtfMp9HGbZyZWa3E5Ee8fNbdc+Ii3YadwDrSDZ8jGx6e8SAVddSpCtOZ0zuGs0EDYK7flTJe0v7vk6JQ6FxZgWY0o/fV484dN7vcdiNuHQadsXbuhBKaDrWxttuPlTYWZuKpegWo1L/IN3RGbqvSMGqM3HBCvRVjlXanrhQE6saJFl9W0MjudsnDpyIir1vmXyTzpJVRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JecOddfu4oc1dnj+HoMKbfgmdUe+xfZGW9eYZlLDZ8w=;
 b=MifbBLDj4mVLnOjxLHrHfKZPAMZ+Rg17Qj5t5sY081U5zgUwJ9oL+Z0BrT/WEEBOxNHlNJS04LO0rPDYen1elvW/S1qsWVbmRVQHVayGLDK8HJy51ggt3xCFATikvK+UM4DV6mEhh/gveW3tg9jetVkwzuhknbnTrSTErVBiiknaB9oSPa3J2PYN6VuT351WkxtDqugmGr8PRgdu9ZWVsqXGD02+GNi7yENa+kUm5IvtK8QLtA70sLUHCsfFj+E4vE7U7rNH27vsxllmAnDdVjN8gcWERy5j8/8vh7YpJ70vUJooEPymq0my9ZTzV9BaIxEGw8+iMK6mvTrZ6thC1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JecOddfu4oc1dnj+HoMKbfgmdUe+xfZGW9eYZlLDZ8w=;
 b=dAqzE+aYw+9ssadiRlipXacDEd1EfhG9zwc2mgO7x+s7C6I8oQlYLjkifM1den8UAvxlgk63mTa5x6iemCUPj6xm8HAhPGTLbT2rT1kza39rGTnA+WDWKr6Hvq+8w2Cmsl/+6xLMwC3Yytn9DQnMTFfuUjnQFn/cDGwHsCoX8Mw=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
Received: from SA1PR04MB10065.namprd04.prod.outlook.com
 (2603:10b6:806:4dd::14) by CH2PR04MB6572.namprd04.prod.outlook.com
 (2603:10b6:610:65::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Sun, 18 Oct
 2026 12:26:01 +0000
Received: from SA1PR04MB10065.namprd04.prod.outlook.com
 ([fe80::9b98:bf8a:b0b1:ef85]) by SA1PR04MB10065.namprd04.prod.outlook.com
 ([fe80::9b98:bf8a:b0b1:ef85%5]) with mapi id 15.21.0522.017; Sun, 18 Oct 2026
 12:26:01 +0000
Date: Sun, 18 Oct 2026 21:25:54 +0900
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Surabhi Gogte <sgogte@purestorage.com>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org, 
	linux-kernel@vger.kernel.org, mkhalfella@purestorage.com, randyj@purestorage.com, 
	adailey@purestorage.com, Hannes Reinecke <hare@kernel.org>
Subject: Re: [PATCH v4 3/3] nvme-tcp: parallelize I/O queue allocation and
 startup
Message-ID: <atSzF3URmcpP2_i2@shinmob>
References: <20260922200718.3941465-1-sgogte@purestorage.com>
 <20260922200718.3941465-4-sgogte@purestorage.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260922200718.3941465-4-sgogte@purestorage.com>
X-ClientProxiedBy: TYCP286CA0009.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:26c::11) To SA1PR04MB10065.namprd04.prod.outlook.com
 (2603:10b6:806:4dd::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR04MB10065:EE_|CH2PR04MB6572:EE_
X-MS-Office365-Filtering-Correlation-Id: e020d929-c086-4473-e38d-08df2d12f84b
WDCIPOUTBOUND: EOP-TRUE
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|19092799006|23010399003|366016|56012099006|260925021311599003|260925021911599003|11063799006|4143699003|260925022911599003|261009223027099003|10067099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info: fhSYlEL8eU7Kd3uJTWXj9kS88drYy7CNTyCnJ0Z+AySMi+YfdfiJ3yXsb7TLA1so8R76Pi918JsTalxSHUAQHXYv1ztJy+CFHTNXDI+UsR5wgGTaQRXJGKewgi+saQTw/tXmqy5Gg2Od8nuuXLwbwLQLB6G2OxdLKC0jjeprBDLYO4fC43kBvlrlPJaccjCqvTkiCllu/nurGFp6qc3+6GwaQYh6ZuR+wHk5oskkmWDQWsstOgMrh1p8Kpnx++Le9oftDujSJwRD25YjFzhk7dCgWEOqhp6RkvlgitU/X7G3GwjynLn0CJjxQ5+R22ZMZ+sFbaJQJua4BTf2TiFTT2u4e/+cLkVS+e+hYFMcGuUoR7iFlMIMnDKq39ickLxlex2fBvTJbAeV1WkB8MAlNnqmO0ySeqaqRbrIwUf+Fas5wKoF6Edn57LdILEb4MQ6yygEh8ShZFn8xmH8MOwHJw9PG/8URWo3fA4OZ/ikjK7Rho21qc9pqPCFlaWWNnr0LSZL696yti6trlPfLi/D/0M+vOsAchMIGX0dy5/V0yTIMHpjplcyiHnLpne+QwTUOoQrTIIGx25ZgEavZYHqvc6Qn9Pm/P/vQUqumCxSF4J3Oh4pHuX7nL62F2paqq02SD4k5TwjarvdVJq8qqJjKE8Xry1OL6vKP/vfFw/BKXQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR04MB10065.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(19092799006)(23010399003)(366016)(56012099006)(260925021311599003)(260925021911599003)(11063799006)(4143699003)(260925022911599003)(261009223027099003)(10067099003)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Gw3Bgva2WNmuenp7jn9HpL6jAPkbt9VhVMxEq9DNlbssxnMZw/KOxRfvAKIk?=
 =?us-ascii?Q?/LyUy3PsvxGjFp7k4Ec3tQneG89nviFuNImp6EuHfjaopeAIvD2+sRNE2cN0?=
 =?us-ascii?Q?OYfGFSPEwRntdvNdjrxBiGiorYukebBvAGM/1MA4PneCsRU960ovoVUAQKZj?=
 =?us-ascii?Q?3x17lJTF65+YVqnHCzwGZoy5kt5N6yWL/3eAvHlLYXPuVbZnK65zXJnvGzFb?=
 =?us-ascii?Q?AeExnXMSe4+CoaDgkQlK8szZh/LOzjWdKQpF0qJTk3ehQShxo5IVBhZpXR/q?=
 =?us-ascii?Q?x6klczutbB5LiH3AiFhKlKE6Laj8ipXi1kZ9JxX+Hp/xhr8gtQbkizzvU2H0?=
 =?us-ascii?Q?EWOVhXhIhgUjs9flfgqfNj9+GTJNCYO3x1OXFy3O8pulgBUsdTgcYGg1j8/O?=
 =?us-ascii?Q?eh4CwIL7jmjgl+YhkOiRZQ0U3fKC6tizWIvmZIVnityXILtDZIccCWRYNxgu?=
 =?us-ascii?Q?T6CDm8+rS7X0YuzvfWBqK+6RFMhDk635qjo7Oa1IBhS9dWrjOPtFZM67PZ2A?=
 =?us-ascii?Q?WiyRNuzx3qhGHKT1IdYXtZAhPHWBNQzh89aO8A25ZZM5iolE153OuPYsQuzi?=
 =?us-ascii?Q?YiebSz8psCVGyWRIrULU5TNmpI8o5h0i6v0qoDUYFLxS0VfAoXneqkwwPdAx?=
 =?us-ascii?Q?6pkgHWleyLWbLIZ9Uhn9QXAKInJ9lCtZoy0VHKIsp6t8CXi/IerS/Q6fGiqv?=
 =?us-ascii?Q?jHhwO5/uAJF5yBLVKKZB6C49qk38wFWk24I+q5WYkY8ZwbRia8qOYY8Sva1P?=
 =?us-ascii?Q?M+aBtjRTuLzb5J8ZLjod19o6kxpuEeUx/gHSFUB0SPemtJb/8XO+WigcvGMK?=
 =?us-ascii?Q?1usiHrIGR6zXQ7ceI/xlK5+SGtJp+ho2pnxh+uJuKskyHlf30YUl0n3bC16e?=
 =?us-ascii?Q?w9nofkzJm3nu/0NkzVTclQWeTIsyYFgtkILoRPis7/EDiIU1HaTYMNBOYCBv?=
 =?us-ascii?Q?QxJeNc+SAkpq+A0GI57viAAqNhFFO8iKxIWmCdbVdlj9PuK3qRMFpaG77Anz?=
 =?us-ascii?Q?/+9wOUy0rzuT4OpF8K961Qrw/K8ZOpEAIsTQO1AL6mUbVo/NSnf8zyJMZ0L7?=
 =?us-ascii?Q?j5SFgDlhnF5DTFqrJhFQHRERP6ekn0E5EVd84YzFvvDL9yBwPeF6yHi6F/a7?=
 =?us-ascii?Q?I7igNzoB/iSGlF7yw9YNOVZmukY7+s/fmlFZjMRDLUm8mxnRn0wLMUwLxbH9?=
 =?us-ascii?Q?dUa3/F4zUcu9JrD85cTH+u1QQyTtNlG3xt5l9Txg1bsMamcb+9hwC3Nu439C?=
 =?us-ascii?Q?IofxHGDa84Tw0rbL9pdjlzO0ErcXAqfWpi4b26Qx0wvuuZ1HjIO29AVoCF/i?=
 =?us-ascii?Q?KwG2Pte1MhLR+ETdgAR7wsXRorrQrt/1WTiV5+594N1ivJM51KEyI++bLbCN?=
 =?us-ascii?Q?N/1gvqzvVCTHiUcJzKbYdZBC1k3gW+GsyEOd9rfn0ANbLnGPlXm7LS2vEmp9?=
 =?us-ascii?Q?m2fy/pcpFmJam7U0KJzB0jqYu8uoYFfi7Hw2TYeanE2mfXzUaGoLvcLcwKor?=
 =?us-ascii?Q?nZUSX/BfDWlj6j8/NvZy/tRkwkUuqwvDq5+ZA5fYJ/bHnvlwCrPWjMTse+vh?=
 =?us-ascii?Q?9h4kfXIsH6b+q1cpLd+EB8nHOwAaifJX4q02T9B+tv4np8asLwbOO6x0msAg?=
 =?us-ascii?Q?k84W7iO3ygN3q1wyLt6BHLNGTECoRxIyrPMdtTF6sKUQU8f6+WlKqpyFHffy?=
 =?us-ascii?Q?JwLlGudgS/XKnKg/28qmXCm24CiD8D+xVf0vqVK84OVWkTRSfcqoHq2A3a/W?=
 =?us-ascii?Q?zC7UUiM1HSLsHsR8ok7M8sON7DxaB+k=3D?=
X-Exchange-RoutingPolicyChecked: SvTPkbk0ZM6ih2/55MZ/atb0K4TCdsntDs8dRL7BjUAUPEy6nsyScadtalrmhi2n25VdAGHrJUXAu5AXBLq+SD03zAmHtSEwUP8tS5Dj6ZPCwR9r+9+u9DkdxRecFRnV3FRNdwJB2NpYAqI3vzRiUZ8gO9QJzQCrv+AnoogGgmy2tpspoF7XskkGejyhYGUjQQp4YRZXpzdYGB36xKlQXDjF80/MkTGYBjKWqFeBBSp20OlDq6chPhVtRExHMbnZoojzBWsCChpRXor31LwW9hR0W09Qrg778oTuP7GP/0Ykzuq/2N0aCxdzhD0Gh5tK+/Q/D5H8OODS8zjbA2aagg==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 1s8Q4RSfHK12wgMbb36DsP0OJt+ksHCcpvy9vVcrMMYGX9F0qbZRCDGcUsfksJzECgcdFcJy42xDXqh0u7Ne1ztz4MyQdY6rJAyBTnLQdDRhC1DWNtuZBYbnnqts/6FGEQF3Ehx5K7Xi47p/4D3th5P/9J/CQ+buC43T6afUQjK4xLYbYdA9Tq3deXVWI0Eabr/+K2KrCdko9PY8uhwvU6wsEvlEPUko+UlBoOXE9D17dUUMUlR+53u6+2VJ276bMXrCI3EZPuO7VWBzSaoH3G59PEBwjlOQHv6ZbUnjI07AYqOMpZ5NHrjY5TYHXoJOmjCFwfrf8lP6/6bEBBbMdivdqPZrJ7FicY8ZN7f7n+mVart/NotVaPDaWH/e4gZ6L17jsV8p1AiVY6rPkdV3wCKK346EPOv6O5D2CJ62IY6S2UYwtkWfdrkNWr5CUIeVpQMschB1RzeyIC8RS6faVdyDKmcIRlWkVkhiOp4C/jIGCLvRDVYwENQUURkzozzgOl+StdB6W04Cg3ecwjCY3wOrINmTwYm948YC/09sDymJ4Bi8FpDwJV0lC01CpPFtClVVBFf2f3MjjlxQdBe8S2kAos/OrHWi8kws+jxuTnrbb64ii6eETQZIj67IoWS5
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e020d929-c086-4473-e38d-08df2d12f84b
X-MS-Exchange-CrossTenant-AuthSource: SA1PR04MB10065.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2026 12:26:00.9766
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AMVd2Aj7Wsz4RoUhmuBmyAlhADae1Ozr4EzMTngQbYtsaEMA1VX95MvZ65UdihM3FNIyDScKM4LfoyqiuMxqxwlM7vai8CKSj5FcOMXkOLs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR04MB6572
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261018_052610_691360_ABBC2A58 
X-CRM114-Status: GOOD (  22.55  )
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

On Sep 22, 2026 / 14:07, Surabhi Gogte wrote:
> Similar to commit 2a8513091d2f ("nvme-rdma: parallelize I/O queue
> allocation and startup"), refactor nvme tcp I/O queue setup to use async
> API, combining allocation and startup into a single parallel operation
> per queue. This reduces connection and reconnection setup time when
> there are delays in establishing connections, which is especially
> important for high-core-count hosts.
> 
> Key changes:
> - Use async API to facilitate parallel calls for io queue setup.
> - Add nvme_tcp_queue_setup_ctx for propagating errors from async
>   workers.
> - Remove nvme_tcp_start_io_queues() and __nvme_tcp_alloc_io_queues();
>   their logic is folded into nvme_tcp_setup_io_queues() and
>   nvme_tcp_configure_io_queues().
> - Allocate the io tag set before the queues so that the queue range is
>   known, and only set up the reconnect grow case if the queue count
>   actually increased.
> - Serialize the cpu scan and claim in nvme_tcp_set_queue_io_cpu() with a
>   spinlock, as concurrent callers would otherwise select the same cpu.
>   The per-cpu counters no longer need to be atomics.
> 
> Testing on a 64-core host with 64 IO-queues shows nvme-tcp connection
> time reduced from 61ms to 11ms.

Recently, blktests-CI runs for the kernel at block/for-next branch started
reporting failures of the test case nvme/004 (with tcp transport) and md/001.
The kernel reported a WARN related to lock->magic, and it caused the failures.
FYI, here I share the failure run log at md/001 [1] and dmesg at the failure.

  The md/001 confirms a bug fix in md driver. The bug was triggered when a
  nvme device with tcp transport is used as its backend. Then the test case
  exercises the nvme-tcp driver, which this patch touches.

I bisected and found that this commit is the trigger of the failures. When I
revert this commit from the block/for-next branch tip with git hash
34fbfb9d8d1f, the failure goes away.

Surabhi, could you take a look in the failure?


[1] failure of md/001

md/001 (Raid with bitmap on tcp nvmet with opt-io-size over bitmap size) [failed]
    runtime  3.021s  ...  2.970s
    something found in dmesg:
    [   79.786635] [    T966] run blktests md/001 at 2026-10-18 20:35:29.594227680
    [   80.157789] [    T984] brd: module loaded
    [   80.566933] [   T1008] nvmet: adding nsid 1 to subsystem blktests-subsystem-1
    [   80.637888] [   T1011] nvmet_tcp: enabling port 0 (127.0.0.1:4420)
    [   80.925883] [    T312] nvmet: Created nvm controller 1 for subsystem blktests-subsystem-1 for NQN nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349.
    [   80.940866] [   T1018] nvme nvme5: creating 4 I/O queues.
    [   80.942243] [   T1018] nvme nvme5: mapped 4/0/0 default/read/poll queues.
    [   80.942689] [   T1018] ------------[ cut here ]------------
    [   80.942879] [   T1018] DEBUG_LOCKS_WARN_ON(lock->magic != lock)
    [   80.942882] [   T1018] WARNING: kernel/locking/mutex.c:625 at __mutex_lock+0x1008/0x2510, CPU#0: nvme/1018
    ...
    (See '/home/shin/Blktests/blktests/results/nodev/md/001.dmesg' for the entire message)


[2] dmesg during md/001

2026-10-17T22:40:06Z {detected_level="unknown"} [ 2568.828164] run blktests md/001 at 2026-10-17 22:40:06.674885632
2026-10-17T22:40:07Z {detected_level="unknown"} [ 2569.162185] brd: module loaded
2026-10-17T22:40:07Z {detected_level="unknown"} [ 2569.587993] nvmet: adding nsid 1 to subsystem blktests-subsystem-1
2026-10-17T22:40:07Z {detected_level="unknown"} [ 2569.629198] nvmet_tcp: enabling port 0 (127.0.0.1:4420)
2026-10-17T22:40:07Z {detected_level="unknown"} [ 2569.848587] nvmet: Created nvm controller 1 for subsystem blktests-subsystem-1 for NQN nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349.
2026-10-17T22:40:07Z {detected_level="unknown"} [ 2569.875225] nvme nvme2: creating 4 I/O queues.
2026-10-17T22:40:07Z {detected_level="unknown"} [ 2569.878288] nvme nvme2: mapped 4/0/0 default/read/poll queues.
2026-10-17T22:40:07Z {detected_level="unknown"} [ 2569.883211] ------------[ cut here ]------------
2026-10-17T22:40:07Z {detected_level="debug"}   [ 2569.883660] DEBUG_LOCKS_WARN_ON(lock->magic != lock)
2026-10-17T22:40:07Z {detected_level="warn"}    [ 2569.883666] WARNING: kernel/locking/mutex.c:625 at __mutex_lock+0xb73/0x2350, CPU#2: nvme/55686
2026-10-17T22:40:07Z {detected_level="unknown"} [ 2569.887533] Modules linked in: nvme_tcp(E) nvme_fabrics(E) nvmet_tcp(E) nvmet(E) brd(E) raid1(E) dm_dust(E) loop(E) xfs(E) tun(E) nvme(E) iTCO_wdt(E) intel_rapl_msr(E) intel_pmc_bxt(E) intel_rapl_common(E) pcspkr(E) i2c_i801(E) i2c_smbus(E) nvme_core(E) nvme_keyring(E) virtio_balloon(E) nvme_auth(E) virtio_scsi(E) lpc_ich(E) bochs(E) serio_raw(E) qemu_fw_cfg(E) vmw_vsock_virtio_transport(E) vmw_vsock_virtio_transport_common(E) vsock(E)
2026-10-17T22:40:07Z {detected_level="debug"}   [ 2569.887693] Unloaded tainted modules: nvme_tcp(E):1 nvmet(E):63 nvme_fabrics(E):63 nvme_loop(E):63 loop(E):14 ublk_drv(E):2 null_blk(E):37 scsi_debug(E):53 amd_atl(E):1 edac_mce_amd(E):1 bpf_preload(E):1 [last unloaded: scsi_debug(E)]
2026-10-17T22:40:07Z {detected_level="unknown"} [ 2569.899624] CPU: 2 UID: 0 PID: 55686 Comm: nvme Tainted: G            E       7.3.0-rc7 #1 PREEMPT(lazy)
2026-10-17T22:40:07Z {detected_level="unknown"} [ 2569.902229] Tainted: [E]=UNSIGNED_MODULE
2026-10-17T22:40:07Z {detected_level="unknown"} [ 2569.903507] Hardware name: KubeVirt None/RHEL, BIOS 1.16.3-4.el9 04/01/2014
2026-10-17T22:40:07Z {detected_level="unknown"} [ 2569.905532] RIP: 0010:__mutex_lock+0xb7a/0x2350
2026-10-17T22:40:07Z {detected_level="unknown"} [ 2569.907336] Code: 38 d0 7c 08 84 d2 0f 85 52 17 00 00 44 8b 05 8d af 8d 02 45 85 c0 0f 85 0a f6 ff ff 48 8d 3d ad cc 8e 02 48 c7 c6 c0 fd 2f 85 <67> 48 0f b9 3a e9 f2 f5 ff ff 4d 8d a7 e0 0e 00 00 4c 89 e7 e8 3d
2026-10-17T22:40:07Z {detected_level="unknown"} [ 2569.912320] RSP: 0018:ffff8881438c7370 EFLAGS: 00010246
2026-10-17T22:40:07Z {detected_level="unknown"} [ 2569.914185] RAX: 0000000000000003 RBX: ffff8881face6460 RCX: 1ffffffff0f35008
2026-10-17T22:40:07Z {detected_level="unknown"} [ 2569.916368] RDX: 0000000000000000 RSI: ffffffff852ffdc0 RDI: ffffffff879b9d70
2026-10-17T22:40:07Z {detected_level="unknown"} [ 2569.918675] RBP: ffff8881438c74e0 R08: 0000000000000000 R09: fffffbfff0f35008
2026-10-17T22:40:07Z {detected_level="unknown"} [ 2569.920803] R10: ffffffff879a8047 R11: ffff88812d120008 R12: 0000000000000000
2026-10-17T22:40:07Z {detected_level="unknown"} [ 2569.923039] R13: 0000000000000000 R14: dffffc0000000000 R15: ffff88812d3a0000
2026-10-17T22:40:07Z {detected_level="unknown"} [ 2569.925258] FS:  00007fd431b6b640(0000) GS:ffff8882ac2ea000(0000) knlGS:0000000000000000
2026-10-17T22:40:07Z {detected_level="unknown"} [ 2569.927640] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
2026-10-17T22:40:07Z {detected_level="unknown"} [ 2569.929481] CR2: 00007f50088d0c1c CR3: 000000010d0d4006 CR4: 0000000000770ef0
2026-10-17T22:40:07Z {detected_level="unknown"} [ 2569.932053] PKRU: 55555554
2026-10-17T22:40:07Z {detected_level="unknown"} [ 2569.933507] Call Trace:
2026-10-17T22:40:07Z {detected_level="unknown"} [ 2569.934813]  <TASK>
2026-10-17T22:40:07Z {detected_level="unknown"} [ 2569.936625]  ? nvme_tcp_init_request+0xc8/0x300 [nvme_tcp]
2026-10-17T22:40:07Z {detected_level="unknown"} [ 2569.938805]  ? srso_alias_return_thunk+0x5/0xfbef5
2026-10-17T22:40:07Z {detected_level="unknown"} [ 2569.940675]  ? __alloc_frozen_pages_noprof+0x543/0x7c0
2026-10-17T22:40:07Z {detected_level="unknown"} [ 2569.942464]  ? __pfx___mutex_lock+0x10/0x10
2026-10-17T22:40:07Z {detected_level="unknown"} [ 2569.944123]  ? srso_alias_return_thunk+0x5/0xfbef5
2026-10-17T22:40:07Z {detected_level="unknown"} [ 2569.945814]  ? alloc_pages_node_noprof+0xae/0x150
2026-10-17T22:40:07Z {detected_level="unknown"} [ 2569.947474]  ? nvme_tcp_init_request+0xc8/0x300 [nvme_tcp]
2026-10-17T22:40:07Z {detected_level="unknown"} [ 2569.949268]  nvme_tcp_init_request+0xc8/0x300 [nvme_tcp]
2026-10-17T22:40:07Z {detected_level="unknown"} [ 2569.951141]  blk_mq_alloc_rqs+0x3fc/0x6f0
2026-10-17T22:40:07Z {detected_level="unknown"} [ 2569.952747]  blk_mq_alloc_map_and_rqs+0x168/0x320
2026-10-17T22:40:07Z {detected_level="unknown"} [ 2569.954450]  ? srso_alias_return_thunk+0x5/0xfbef5
2026-10-17T22:40:07Z {detected_level="unknown"} [ 2569.956260]  blk_mq_alloc_set_map_and_rqs+0x1be/0x5a0
2026-10-17T22:40:07Z {detected_level="unknown"} [ 2569.958088]  blk_mq_alloc_tag_set+0x59a/0xc40
2026-10-17T22:40:07Z {detected_level="unknown"} [ 2569.959710]  ? srso_alias_return_thunk+0x5/0xfbef5
2026-10-17T22:40:07Z {detected_level="unknown"} [ 2569.961321]  ? dev_printk_emit+0xbe/0xf3
2026-10-17T22:40:07Z {detected_level="unknown"} [ 2569.962736]  nvme_alloc_io_tag_set+0x37d/0x6a0 [nvme_core]
2026-10-17T22:40:07Z {detected_level="unknown"} [ 2569.964446]  ? __pfx_nvme_alloc_io_tag_set+0x10/0x10 [nvme_core]
2026-10-17T22:40:07Z {detected_level="unknown"} [ 2569.966345]  ? percpu_ref_put_many.constprop.0+0x7f/0x1b0
2026-10-17T22:40:07Z {detected_level="unknown"} [ 2569.968109]  ? __nvme_submit_sync_cmd+0x1e2/0x320 [nvme_core]
2026-10-17T22:40:07Z {detected_level="unknown"} [ 2569.970040]  ? srso_alias_return_thunk+0x5/0xfbef5
2026-10-17T22:40:07Z {detected_level="unknown"} [ 2569.971714]  ? srso_alias_return_thunk+0x5/0xfbef5
2026-10-17T22:40:07Z {detected_level="info"}    [ 2569.973339]  ? _dev_info+0xe6/0x11a
2026-10-17T22:40:07Z {detected_level="info"}    [ 2569.974760]  ? __pfx__dev_info+0x10/0x10
2026-10-17T22:40:07Z {detected_level="unknown"} [ 2569.976153]  ? __pfx_nvme_set_queue_count+0x10/0x10 [nvme_core]
2026-10-17T22:40:07Z {detected_level="unknown"} [ 2569.977938]  ? lock_acquire.part.0+0xc7/0x240
2026-10-17T22:40:07Z {detected_level="unknown"} [ 2569.979582]  nvme_tcp_configure_io_queues.cold+0x27f/0x8ee [nvme_tcp]
2026-10-17T22:40:07Z {detected_level="unknown"} [ 2569.981436]  ? __pfx_nvme_enable_ctrl+0x10/0x10 [nvme_core]
2026-10-17T22:40:07Z {detected_level="unknown"} [ 2569.983132]  ? lockdep_hardirqs_on_prepare.part.0+0x9b/0x140
2026-10-17T22:40:07Z {detected_level="unknown"} [ 2569.984762]  ? __pfx_nvme_tcp_configure_io_queues+0x10/0x10 [nvme_tcp]
2026-10-17T22:40:07Z {detected_level="unknown"} [ 2569.986525]  nvme_tcp_setup_ctrl+0x281/0x5f0 [nvme_tcp]
2026-10-17T22:40:07Z {detected_level="unknown"} [ 2569.988113]  ? srso_alias_return_thunk+0x5/0xfbef5
2026-10-17T22:40:07Z {detected_level="unknown"} [ 2569.989665]  nvme_tcp_create_ctrl+0xf6/0x120 [nvme_tcp]
2026-10-17T22:40:07Z {detected_level="unknown"} [ 2569.991236]  nvmf_create_ctrl+0x34e/0x920 [nvme_fabrics]
2026-10-17T22:40:07Z {detected_level="unknown"} [ 2569.992832]  nvmf_dev_write+0xd5/0x180 [nvme_fabrics]
2026-10-17T22:40:07Z {detected_level="unknown"} [ 2569.994357]  vfs_write+0x1c7/0x1060
2026-10-17T22:40:07Z {detected_level="unknown"} [ 2569.995622]  ? __pfx_vfs_write+0x10/0x10
2026-10-17T22:40:07Z {detected_level="unknown"} [ 2569.996900]  ksys_write+0xf9/0x1d0
2026-10-17T22:40:07Z {detected_level="unknown"} [ 2569.998093]  ? __pfx_ksys_write+0x10/0x10
2026-10-17T22:40:07Z {detected_level="unknown"} [ 2569.999349]  ? srso_alias_return_thunk+0x5/0xfbef5
2026-10-17T22:40:07Z {detected_level="unknown"} [ 2570.000692]  ? lockdep_hardirqs_on_prepare.part.0+0x9b/0x140
2026-10-17T22:40:07Z {detected_level="unknown"} [ 2570.002249]  ? srso_alias_return_thunk+0x5/0xfbef5
2026-10-17T22:40:07Z {detected_level="unknown"} [ 2570.003675]  ? trace_hardirqs_on+0x18/0x160
2026-10-17T22:40:07Z {detected_level="unknown"} [ 2570.005046]  do_syscall_64+0xef/0x5a0
2026-10-17T22:40:07Z {detected_level="unknown"} [ 2570.006137]  ? kmem_cache_free+0x143/0x600
2026-10-17T22:40:07Z {detected_level="unknown"} [ 2570.007405]  ? srso_alias_return_thunk+0x5/0xfbef5
2026-10-17T22:40:07Z {detected_level="unknown"} [ 2570.008722]  ? do_sys_openat2+0x107/0x180
2026-10-17T22:40:07Z {detected_level="unknown"} [ 2570.009946]  ? __pfx_do_sys_openat2+0x10/0x10
2026-10-17T22:40:07Z {detected_level="unknown"} [ 2570.011180]  ? srso_alias_return_thunk+0x5/0xfbef5
2026-10-17T22:40:07Z {detected_level="unknown"} [ 2570.012539]  ? fput_close_sync+0xe5/0x1a0
2026-10-17T22:40:07Z {detected_level="unknown"} [ 2570.013752]  ? __pfx_fput_close_sync+0x10/0x10
2026-10-17T22:40:07Z {detected_level="unknown"} [ 2570.015062]  ? srso_alias_return_thunk+0x5/0xfbef5
2026-10-17T22:40:07Z {detected_level="unknown"} [ 2570.016455]  ? __x64_sys_openat+0x108/0x1d0
2026-10-17T22:40:07Z {detected_level="unknown"} [ 2570.017722]  ? __pfx___x64_sys_openat+0x10/0x10
2026-10-17T22:40:07Z {detected_level="unknown"} [ 2570.019017]  ? trace_hardirqs_on_prepare+0x119/0x150
2026-10-17T22:40:07Z {detected_level="unknown"} [ 2570.020393]  ? do_syscall_64+0x1d7/0x5a0
2026-10-17T22:40:07Z {detected_level="unknown"} [ 2570.021623]  ? do_syscall_64+0x1b9/0x5a0
2026-10-17T22:40:07Z {detected_level="unknown"} [ 2570.022876]  ? srso_alias_return_thunk+0x5/0xfbef5
2026-10-17T22:40:07Z {detected_level="unknown"} [ 2570.024209]  ? trace_hardirqs_on_prepare+0x119/0x150
2026-10-17T22:40:07Z {detected_level="unknown"} [ 2570.025581]  ? do_syscall_64+0x1b9/0x5a0
2026-10-17T22:40:07Z {detected_level="unknown"} [ 2570.026867]  ? srso_alias_return_thunk+0x5/0xfbef5
2026-10-17T22:40:07Z {detected_level="unknown"} [ 2570.028225]  ? trace_hardirqs_on_prepare+0x119/0x150
2026-10-17T22:40:07Z {detected_level="unknown"} [ 2570.029718]  ? srso_alias_return_thunk+0x5/0xfbef5
2026-10-17T22:40:07Z {detected_level="unknown"} [ 2570.031169]  ? do_syscall_64+0x1d7/0x5a0
2026-10-17T22:40:07Z {detected_level="unknown"} [ 2570.032408]  ? do_syscall_64+0x1b9/0x5a0
2026-10-17T22:40:07Z {detected_level="unknown"} [ 2570.033704]  ? srso_alias_return_thunk+0x5/0xfbef5
2026-10-17T22:40:07Z {detected_level="unknown"} [ 2570.035099]  ? trace_hardirqs_on_prepare+0x119/0x150
2026-10-17T22:40:07Z {detected_level="unknown"} [ 2570.036605]  ? srso_alias_return_thunk+0x5/0xfbef5
2026-10-17T22:40:07Z {detected_level="unknown"} [ 2570.037956]  ? do_syscall_64+0x1d7/0x5a0
2026-10-17T22:40:07Z {detected_level="unknown"} [ 2570.039181]  ? srso_alias_return_thunk+0x5/0xfbef5
2026-10-17T22:40:07Z {detected_level="unknown"} [ 2570.040575]  ? __lock_release.isra.0+0x5b/0x180
2026-10-17T22:40:07Z {detected_level="unknown"} [ 2570.041947]  ? srso_alias_return_thunk+0x5/0xfbef5
2026-10-17T22:40:07Z {detected_level="unknown"} [ 2570.043389]  ? do_user_addr_fault+0x8d3/0xe80
2026-10-17T22:40:07Z {detected_level="unknown"} [ 2570.044575]  ? irqentry_exit+0xb8/0x810
2026-10-17T22:40:07Z {detected_level="unknown"} [ 2570.045690]  ? srso_alias_return_thunk+0x5/0xfbef5
2026-10-17T22:40:07Z {detected_level="unknown"} [ 2570.046990]  ? do_syscall_64+0x2d/0x5a0
2026-10-17T22:40:07Z {detected_level="unknown"} [ 2570.048067]  ? srso_alias_return_thunk+0x5/0xfbef5
2026-10-17T22:40:07Z {detected_level="unknown"} [ 2570.049302]  ? srso_alias_return_thunk+0x5/0xfbef5
2026-10-17T22:40:07Z {detected_level="unknown"} [ 2570.050545]  ? do_syscall_64+0x5c/0x5a0
2026-10-17T22:40:07Z {detected_level="unknown"} [ 2570.051649]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
2026-10-17T22:40:07Z {detected_level="unknown"} [ 2570.052916] RIP: 0033:0x7fd431c3d56e
2026-10-17T22:40:07Z {detected_level="unknown"} [ 2570.053948] Code: 4d 89 d8 e8 d4 bd 00 00 4c 8b 5d f8 41 8b 93 08 03 00 00 59 5e 48 83 f8 fc 74 11 c9 c3 0f 1f 80 00 00 00 00 48 8b 45 10 0f 05 <c9> c3 83 e2 39 83 fa 08 75 e7 e8 03 ff ff ff 0f 1f 00 f3 0f 1e fa
2026-10-17T22:40:07Z {detected_level="unknown"} [ 2570.057937] RSP: 002b:00007ffdaa469710 EFLAGS: 00000202 ORIG_RAX: 0000000000000001
2026-10-17T22:40:07Z {detected_level="unknown"} [ 2570.059733] RAX: ffffffffffffffda RBX: 00005609fa418740 RCX: 00007fd431c3d56e
2026-10-17T22:40:07Z {detected_level="unknown"} [ 2570.061425] RDX: 00000000000000cf RSI: 00005609fa418740 RDI: 0000000000000003
2026-10-17T22:40:07Z {detected_level="unknown"} [ 2570.063121] RBP: 00007ffdaa469720 R08: 0000000000000000 R09: 0000000000000000
2026-10-17T22:40:07Z {detected_level="unknown"} [ 2570.064826] R10: 0000000000000000 R11: 0000000000000202 R12: 0000000000000003
2026-10-17T22:40:07Z {detected_level="unknown"} [ 2570.066523] R13: 00005609fa4175b0 R14: 00000000000000cf R15: 00005609fa4175b0
2026-10-17T22:40:07Z {detected_level="unknown"} [ 2570.068235]  </TASK>
2026-10-17T22:40:07Z {detected_level="unknown"} [ 2570.069130] irq event stamp: 11409
2026-10-17T22:40:07Z {detected_level="unknown"} [ 2570.070225] hardirqs last  enabled at (11409): [<ffffffff850e58f5>] _raw_spin_unlock_irqrestore+0x45/0x60
2026-10-17T22:40:07Z {detected_level="unknown"} [ 2570.072350] hardirqs last disabled at (11408): [<ffffffff817db728>] __raw_spin_lock_irqsave+0x58/0x60
2026-10-17T22:40:07Z {detected_level="unknown"} [ 2570.074391] softirqs last  enabled at (11372): [<ffffffff815ffc88>] handle_softirqs+0x638/0x880
2026-10-17T22:40:08Z {detected_level="unknown"} [ 2570.076357] softirqs last disabled at (11365): [<ffffffff8160003f>] __irq_exit_rcu+0x15f/0x290
2026-10-17T22:40:08Z {detected_level="unknown"} [ 2570.078305] ---[ end trace 0000000000000000 ]---
2026-10-17T22:40:08Z {detected_level="unknown"} [ 2570.084017] nvme nvme2: new ctrl: NQN "blktests-subsystem-1", addr 127.0.0.1:4420, hostnqn: nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349
2026-10-17T22:40:08Z {detected_level="unknown"} [ 2570.400433] md127: array will not be assembled in old kernels that lack configurable LBS support (<= 6.18)
2026-10-17T22:40:08Z {detected_level="unknown"} [ 2570.401014] md/raid1:md127: active with 1 out of 2 mirrors
2026-10-17T22:40:08Z {detected_level="unknown"} [ 2570.404015] md127: detected capacity change from 0 to 2093056
2026-10-17T22:40:08Z {detected_level="unknown"} [ 2570.559964] md127: detected capacity change from 2093056 to 0
2026-10-17T22:40:08Z {detected_level="unknown"} [ 2570.560710] md: md127 stopped.
2026-10-17T22:40:08Z {detected_level="unknown"} [ 2570.632174] nvme nvme2: Removing ctrl: NQN "blktests-subsystem-1"
2026-10-17T22:40:09Z {detected_level="unknown"} [ 2571.118121] brd: module unloaded
2026-10-17T22:40:09Z {detected_level="debug"}   [ 2572.039779] scsi_debug:sdebug_driver_probe: scsi_debug: trim poll_queues to 0. poll_q/nr_hw = (0/1)
2026-10-17T22:40:09Z {detected_level="debug"}   [ 2572.040354] scsi host66: scsi_debug: version 0191 [20210520]
2026-10-17T22:40:09Z {detected_level="unknown"} [ 2572.040354]   dev_size_mb=8, opts=0x0, submit_queues=1, statistics=0
2026-10-17T22:40:09Z {detected_level="debug"}   [ 2572.046424] scsi 66:0:0:0: Direct-Access     Linux    scsi_debug       0191 PQ: 0 ANSI: 7
2026-10-17T22:40:09Z {detected_level="unknown"} [ 2572.053271] scsi 66:0:0:0: Power-on or device reset occurred
2026-10-17T22:40:09Z {detected_level="unknown"} [ 2572.063350] sd 66:0:0:0: [sda] 16384 512-byte logical blocks: (8.39 MB/8.00 MiB)
2026-10-17T22:40:09Z {detected_level="unknown"} [ 2572.063603] sd 66:0:0:0: Attached scsi generic sg1 type 0
2026-10-17T22:40:09Z {detected_level="unknown"} [ 2572.064965] sd 66:0:0:0: [sda] Write Protect is off
2026-10-17T22:40:09Z {detected_level="unknown"} [ 2572.065470] sd 66:0:0:0: [sda] Mode Sense: 73 00 10 08
2026-10-17T22:40:09Z {detected_level="unknown"} [ 2572.068116] sd 66:0:0:0: [sda] Write cache: enabled, read cache: enabled, supports DPO and FUA
2026-10-17T22:40:09Z {detected_level="unknown"} [ 2572.075669] sd 66:0:0:0: [sda] permanent stream count = 5
2026-10-17T22:40:10Z {detected_level="unknown"} [ 2572.080471] sd 66:0:0:0: [sda] Preferred minimum I/O size 512 bytes
2026-10-17T22:40:10Z {detected_level="unknown"} [ 2572.082032] sd 66:0:0:0: [sda] Optimal transfer size 524288 bytes
2026-10-17T22:40:10Z {detected_level="unknown"} [ 2572.131009] sd 66:0:0:0: [sda] Attached SCSI disk

