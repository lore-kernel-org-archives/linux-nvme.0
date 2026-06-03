Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73215CD6E55
	for <linux-nvme@archiver.kernel.org>; Wed,  3 Jun 2026 11:00:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:
	Content-Type:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=tR+41P9njfk0+rm8+RWv4Es3bBTMHxZtuUWzjnLHJ7I=; b=d1htwiqGuNQ4/g88yxue1D2/p/
	jHY7WaeH1irdxpc0/GE1lxRKTzq8mh7r78HV5quxAGeasTgkfN1/Jsv4/kFJ3mzNAleMGaRA1k3zC
	CqDIu+BKNxWL41Gt50RcgUJKwrcSAQEUgTNd1VwHbK/Moncwl94GMgWQAcqTiYAJI+xdupinhUTEb
	dKXQc7oY24iRnuCsdmetoq1HzsGCeegDoMAD5p/YbErYQwEt1f66wVDm8a5AFduvW+DFwfC2ceSxv
	wzSAiiJWofJB/LlL/WsVkDfxj4gq0v2MpB7wPqDaoqAlCJ9QsCUu69em5S/iX2IhTTApt4FcoZhwO
	eyVuefrA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wUjKy-0000000Err4-2rIU;
	Wed, 03 Jun 2026 11:00:40 +0000
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wUjKv-0000000Erqk-1XOQ
	for linux-nvme@lists.infradead.org;
	Wed, 03 Jun 2026 11:00:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1780484438; x=1812020438;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=3KQ7sxTkn1eQWuKoHVSLwSux778FdwpmlM3wzUcEznQ=;
  b=aYeVyxPQPldsG3mTkjWGKRUfa3mEseV/5ELkmkFGonqzHWYNKWUSI307
   0uJpOnPwHa/v9xUkEd5TTQSO/0BYjZDGyYk6UKBl1jpHM+UlyS1kkYhpu
   8+Afy5iapiLGrZjxCQp58BJw3yPY4mpkiYbTdPHBR56oeUOJ1s2LNRfpy
   AIXcPSnEWjxIxqm64B1UgJpkkkqN6tcdh6u7xBhyh6GlEz3xsUPFJCOgd
   re5VJCAVbzQkv6drvPaepE8Wz6g+B8tK4SPunnak5m9AXrrtVa1dHq9/a
   4nc8x6xx8KZCuG4DHpkLV5mCEdZmzX0ilMsHNW1PlCS+ouO6UcUSLl7bM
   Q==;
X-CSE-ConnectionGUID: XoPQgzseTkalhwYh4vmtEA==
X-CSE-MsgGUID: 4VFhiJ3wTYGKvDP5iEQUCw==
X-IronPort-AV: E=Sophos;i="6.24,185,1774281600"; 
   d="scan'208";a="146848301"
Received: from mail-centralusazon11010025.outbound.protection.outlook.com (HELO DM1PR04CU001.outbound.protection.outlook.com) ([52.101.61.25])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 03 Jun 2026 19:00:36 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VbEmF83JNSvk0auiSLVr31IBqcx6kNa9tb697c9TG18dm+SCW9FE1QrqEt16Sl3lqDJlfxq3PR8YyMk+dSfsH8Z7nUDZQecvScx6IjUO8vs4rgYKy42yXYnufSn/my77ZDAgZuLoLHjB0dYf1jJ9Xx48cy7EgjBwvHxBBrEFYBnvZ5x2+g5aUMKVxrRZEl3Iog10ON+/2qehmo2a7dts3ha0BluTf7C02uoJbjTH/wljmy6nW6odklJCF9/OUGL0IFrWV5UQFGNwyGLzAeangJvRSliTWWlCUgyLesPHljuuG4rP5PP+g/GnE4UFAxn4PYC0M9DGCdfR3a5Gi3JxwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tR+41P9njfk0+rm8+RWv4Es3bBTMHxZtuUWzjnLHJ7I=;
 b=Hj9mycH9Fu+W/qg4jsABtNlM9hwSOlWw8AIxt7QWf/jhK3yhziZ/vtMpMQb2NFecfVa9B6ZawkIwFxsrehrxUMXqXFq61gI4tORvJ5mwivpK1KJBqBs1uOYUDi0uqDb4cEVAq/UyjWkP8lmphTAxdbmzRW9ZoZXGe63yd/qOCVPcYlwivq0eeJUQ/SCrHBTdosP03YvBc337LgceacUA0l40cghOH5mO49xMpP556HPAL0sJwoILLW4jp+txnJLjxhRl9cc1WYykb8tS/0ZLMr+9doj+DLuanaWOikgt6WYCjid865d9umgaTRchDtH4v1C8lYlfzeE1y1tRd4PKQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tR+41P9njfk0+rm8+RWv4Es3bBTMHxZtuUWzjnLHJ7I=;
 b=j5yx8r05Px4wOPevHt2gTpH7XoBZZmsM81QWzCLKL8zipOCARRiPLoAc9MxbbJUXgJT9prCODDm/9LxUWopc3XDSyWmIcm0i0k2UfdaTsz3gd5gFdQfN+Skiid70xi6XwIDaO8xcebfBpby0EuNtse5rG8cwys7hwtegcwVzvy8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
Received: from SA1PR04MB10065.namprd04.prod.outlook.com
 (2603:10b6:806:4dd::14) by BL3PR04MB8026.namprd04.prod.outlook.com
 (2603:10b6:208:345::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Wed, 3 Jun 2026
 11:00:33 +0000
Received: from SA1PR04MB10065.namprd04.prod.outlook.com
 ([fe80::9b98:bf8a:b0b1:ef85]) by SA1PR04MB10065.namprd04.prod.outlook.com
 ([fe80::9b98:bf8a:b0b1:ef85%6]) with mapi id 15.21.0092.006; Wed, 3 Jun 2026
 11:00:33 +0000
Date: Wed, 3 Jun 2026 20:00:26 +0900
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org, Jens Axboe <axboe@kernel.dk>, 
	Christoph Hellwig <hch@infradead.org>, Sagi Grimberg <sagi@grimberg.me>, 
	Nilay Shroff <nilay@linux.ibm.com>
Subject: Re: [PATCH 2/2] nvme-tcp: lockdep: use dynamic lockdep keys per
 socket instance
Message-ID: <aiAI4v_V63sBrTz6@shinmob>
References: <20260530052045.296749-1-shinichiro.kawasaki@wdc.com>
 <20260530052045.296749-3-shinichiro.kawasaki@wdc.com>
 <ah6srseW316tqOZa@kbusch-mbp>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ah6srseW316tqOZa@kbusch-mbp>
X-ClientProxiedBy: TY6PR01CA0014.jpnprd01.prod.outlook.com
 (2603:1096:405:3bc::7) To SA1PR04MB10065.namprd04.prod.outlook.com
 (2603:10b6:806:4dd::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR04MB10065:EE_|BL3PR04MB8026:EE_
X-MS-Office365-Filtering-Correlation-Id: 47834b49-9227-41ea-416d-08dec15f5569
X-LD-Processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
WDCIPOUTBOUND: EOP-TRUE
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|19092799006|366016|376014|56012099006|4143699003|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: UopyDzqxeIZyb0ZsOAiPs/gf1ms2L9phsCDTDdvvRq8yTfP2rup74Dcqo2u74U29pcJeXfuw8A5kKP8nBK/WqgzqPa4NE64l28slY5Pazy7w92T5jL3GMwV3CC8k2Pi66+eJ+r5OaxKtdtN5oUct0MF+RWfTFstByriUcOib4HtUam6froslJ9PC7AZ9q57uEszRbA67cTTo8bcFeSkhfB9nt6VTldN4mj0o7yXFoGslM5KCs0b7cSOOaHVglMKLFozArdIbdbJJRv/iAJnvLmrM0HeLXIra6DLxPydiu48n+wEKleVgLhqa/DaiHlpiLEvk+4W88s4vJwlO0pRq+NFZ6tNQPO44Yi7QMqvfGl4yr9cP8DHDXQ3CanRr/V4Nb/YiZH61I629NKaCZu4adkCd4hOEmj1+ky83F36W3EDaCuBvhwH9w+H1CJhwKiYCtUK0cl836TP5l6M2QtVd26g6hR7XM4NySkst4eOfWR+0KQO+SLzXdd7iDT5KFoVaHAxnRTz2wyBkeogjbKQwyu4W59zls5uKc1Yh9L6bvrrbxPYWa2F4cGOqbftXMYekxsQXZQkzd1TnmggmVxUfcJNAhU5Gn36DHFEJowvaJW+WCHz9aulQDyt8WL5a2g4W1inenLeHKnUTRqES5OzzxBNIcIaSF3Ti5G3A0Lb/b2qh/43Pvja5Fxdpm8X8Jm+c
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR04MB10065.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(19092799006)(366016)(376014)(56012099006)(4143699003)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0eLnJqoYiwen8qDqTBUS2Y/843wu6nI44wNHt1eBnYn8W+gxoXoWZ7uCAonT?=
 =?us-ascii?Q?mwUmxOTTXpgObX03RHeYTBeNQGTmMtiS9C6ZrLo/CwHywijPvVuklHJWJas8?=
 =?us-ascii?Q?uq6Rpw0QbJexoZe0H3fKXgNOL4ojKw/gQnb6saq0WH5utUPK63h0X8yQtwnn?=
 =?us-ascii?Q?2d4NAqcJU0G5aRUG7AlIwp8hjfoJ/cdeM24wEtkzyL3o90GDFjiG1dwyol39?=
 =?us-ascii?Q?RnhQhsCRKFWqe1EcLiftgiuVpFmujVm9WjHfXuUBIMA8Yhw/7xheTEsAtBKW?=
 =?us-ascii?Q?HebfnGeUx5lGFy4yHD44ai2gFwXpORi7OJqToK4OoM7Pd7/9nuwpWiuAlT3P?=
 =?us-ascii?Q?RBauRfkgSEEkfjKdLpwcoqrFrrVZozR7ECxJeLH40ilE24BqE3roRCxuSRCn?=
 =?us-ascii?Q?Wy4lJa9N2oqsaWfKyOUcSaC6Qx0eNqauHLHzKSDS0SbG65iYFYxknugHNpEx?=
 =?us-ascii?Q?u4pTScGfivWAdSyCPyzekRaHZwu3TCkhSKSVxW50UlrJKn83osg7pundn+dF?=
 =?us-ascii?Q?xTTuCAicAHiJuEyZlrxm6onvaD/LGIRI/OZxQYP1MBc/x11q5+YtaLF4Hr9O?=
 =?us-ascii?Q?Rl9TWZl0tiqwjtqQ1Axcy/dpbkMrdz+EzW+JKbm+LPqGjzuimWExhg6Hk0TE?=
 =?us-ascii?Q?0o8UaYJbd9Ib1po6RMT0snmQZF0B0Jx40JOKAXXdIZXzUOTeOk/Dj7VWPdjr?=
 =?us-ascii?Q?xY0Lde1dtRYAnkFHqu7yqtZ5JZI9r7KUPtpm9XGyhqZaBUkrjoMs5Cp38NLs?=
 =?us-ascii?Q?ak/gV3gVBk7Nj2pqiD+cS4fi/XFUG7tKUywoqf4EApYGHQrMFp9hbapiKtQD?=
 =?us-ascii?Q?tIDymkEfmoZFigc7RzhjBuOtGBavPUQ/kBE+B7U8cOQHOrbvAWv4eYDvLEt9?=
 =?us-ascii?Q?xAgXDicDjjOkKJGoXLY3xAPH28H+iehJ6TT1ivW5/S4wswpxnx8rsiFHUULm?=
 =?us-ascii?Q?v4wyEDy2b92xG1A1O/gleaivP//Ax6jSmXUgPyeVHXKIWVLf0RMLsIv2SBnJ?=
 =?us-ascii?Q?btjSw0aBVTkq6Eyly9x0TGlZtMaBmZI9lcBhkKP6ZexzYvLlM++ZPkuJX5Z8?=
 =?us-ascii?Q?xrAyKncrTNVqcN6i5VC4Pxb0plnKNCGQwsDsgjnbIMshXlyPEm4dYxVgmbS9?=
 =?us-ascii?Q?HqBTqKVAne0021A8NO+yAU3wTy6+qFlG7Xm4t8kFHmhg9tsAzgtKp6B6iBkg?=
 =?us-ascii?Q?p8KNIMXKNxPtsyRI9INzGGZp4md3GkBfxtlXgrZBEa5G47TYocfzCxd7M3V+?=
 =?us-ascii?Q?DmgClL1cZUsJOLpQXOAq0SxfO+0NPHea8vRMV6LbhqpDhnrhqciYFX6l5qTN?=
 =?us-ascii?Q?xv9FoYBa9gaREFDVP11FxmuoifbDK5q8ypcXa5XHEygNR1PUjNdObhSOB+YA?=
 =?us-ascii?Q?b5CwAwXK0D3mVYvkm67wDgccNqWeub04TkNm5WxQzp9nxv+q1kmlTR8oOj+b?=
 =?us-ascii?Q?YhFF0JGPUbMDTgqtrdmxL5z7+681h1FzhqkT32CpvjtsgU6utLhLkpxWyKD7?=
 =?us-ascii?Q?jf53oazyk/Qew0j+LCQImRgOQhkJAjZEWSsOEnSfkFV2O+LLrlZA6fBLM3k6?=
 =?us-ascii?Q?Tejn2efKyjHReYLud0uPFtwjiHFsp+LJRXp6wm9MvziXekTJdwK4k7R4BsKV?=
 =?us-ascii?Q?A47sNUGoFJzsjdPSToQfNd4qGXDRuc/GiacgUhIYPiF4JK2CLrZCzosXPS0B?=
 =?us-ascii?Q?HOdMftJgAFfmq4/clRNwKyANvVRp+/mlFsDOS67bpkVEBnRZqeknyZ93Tv3g?=
 =?us-ascii?Q?fqUJuFzt3Syyp0Il/dyJoH6OBTpQCpE=3D?=
X-Exchange-RoutingPolicyChecked: MzHuVbQ5HMK98I2pwDvdC/UJzFqIjHbtFEuYt9LJ4CDm8IulYhtVFi7HXI3W/y07qXe+dNzKQ29ZSe9ckM4osRlaKvXHIFulL46ChTsXiMWuRQ0BOqH+GIa4bpJw2gsQARwlZ1thn7jYVQ+ptcIBh4WPtJZo74FToxwDu08MsA9kZyUVDK+S5VdS5I/9WfkCFwGFCgxtAGH49aagZuKKNir422rhI53yKlvC4eVx40FI3ePyjwTn6KtmVSwpo6+rp1JDGEHmRYlA1EvnYwnFiw+K4Hl8fkgs8XTZBuMe5hOIH5iWUgNRyopVvkvQNTRgDjskuTAku9vDssJvY4sSbw==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: dQ+Coa7YL+hjTit/T7YUur3TXAUONfb0l5kkWwkr46wIfHbpal5W03tMQf+L4kBKLKLVtA7OZxQmYKaWNiVO35SlKXsTXzSeqizcg5mLKqDKNFejbSch1AUVlO4K/h7nr9KZZy68EZulBLcskCHA+XeYe/NRrtRCANI5HOZnK1PmhzRBdX1bzhKsGfxdzUwKevKwio2y0Fw9JHUXiYZvJi3sYdN/XOWq44eedG7+BlDa1GgFWI+tvIn5aACPoMP2DVC+cPNuZdU89b/WqDyQLxWyJg+aFpcfpkeCFMl+os3+fq+UCvVBZm3s3sq+SCdePFR1MM3HaxYm5BQuUbqyImeCqqWWWlfprhlZVnha3s8sCBDE0CxKwK4bA/TJvkDLVR1ohVEeYVSvt9HClDPKR+H0s8t5kDSy0p44ZbbGoAJY3ahrWaxH8JcalleU+9XSap4JiWKigvyTdcVEAIlHLJArWKfbXp9Gna5ZcZ8uVTND765eHkZ1ZA4LiX2FmEu0c0ZRq0ffP0XfLZvy0gRLlds2zDOGCLgrgsnRJQnp8OP1awRe3IkPUyqDkfmzKtPxahzIHG/DlDKKAsZ2fXvDKQ77Jai6PCpXMPCpwONGUwQaUHJo6Exlf/044krCoBN6
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47834b49-9227-41ea-416d-08dec15f5569
X-MS-Exchange-CrossTenant-AuthSource: SA1PR04MB10065.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2026 11:00:33.3102
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /VCF7Avt2Y3RFmX38gTimWryDkbEnz1lXhjQ6V1CA/DyXa5sbc1r+SpJTVVTISSWGTxgcZWvIXrhM4FUkbWUsUgqYbF27DHSHRxR+0n6pFI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR04MB8026
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260603_040037_482274_2991BE1C 
X-CRM114-Status: GOOD (  19.02  )
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

On Jun 02, 2026 / 11:13, Keith Busch wrote:
> On Sat, May 30, 2026 at 02:20:45PM +0900, Shin'ichiro Kawasaki wrote:
> > -static void nvme_tcp_reclassify_socket(struct socket *sock)
> > +static void nvme_tcp_reclassify_socket(struct nvme_tcp_queue *queue)
> >  {
> > -	struct sock *sk = sock->sk;
> > +	struct sock *sk = queue->sock->sk;
> > +
> > +	lockdep_register_key(&queue->nvme_tcp_sk_key);
> > +	lockdep_register_key(&queue->nvme_tcp_slock_key);
> 
> ...
> 
> > @@ -1468,6 +1473,11 @@ static void nvme_tcp_free_queue(struct nvme_ctrl *nctrl, int qid)
> >  	kfree(queue->pdu);
> >  	mutex_destroy(&queue->send_mutex);
> >  	mutex_destroy(&queue->queue_lock);
> > +
> > +#ifdef CONFIG_DEBUG_LOCK_ALLOC
> > +	lockdep_unregister_key(&queue->nvme_tcp_sk_key);
> > +	lockdep_unregister_key(&queue->nvme_tcp_slock_key);
> > +#endif
> >  }
> >  
> >  static int nvme_tcp_init_connection(struct nvme_tcp_queue *queue)
> > @@ -1813,7 +1823,7 @@ static int nvme_tcp_alloc_queue(struct nvme_ctrl *nctrl, int qid,
> >  	}
> >  
> >  	sk_net_refcnt_upgrade(queue->sock->sk);
> > -	nvme_tcp_reclassify_socket(queue->sock);
> > +	nvme_tcp_reclassify_socket(queue);
> 
> On a subsequent error in this function, I think you need to call
> lockdep_unregister_key directly in on of the goto error cases since we
> don't call nvme_tcp_free_queue for this failed queue.

Thank you for point it out. lockdep_unregister_key() calls are required in the
error paths. I will add them in v2.

