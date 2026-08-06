Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B0C0C55838
	for <linux-nvme@archiver.kernel.org>; Thu,  6 Aug 2026 03:30:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:
	Content-Type:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=LLgK/IcRUOqWpyu6BP9tHyjp6F97xYl75tinUxQAMBU=; b=R02YjBPH9g92dz8c4APn7IE1Kp
	NzHIn7mVY1Z4RA5ZHw8o6jS5vDA9KlNtH8y1dUPDIrW+BVmhrOppTtf8ZIavgnnGJtUA59+B0Y/uo
	dvznEaKwovknf+dY5+rm9tMlzVUlXP7b2Jks8H4Eg2rhjKdN48QEhdGHa6UwJ3uZab4/gyzJiX0+/
	bl5eWw98h/sq+lmqGmBcUwWTrJ37zjNNB3kEqMYYWiI4VRX0KlpDg6c5CPq8zE1e/B1tsnEWM+4Vi
	om1flvLPrgrfI5AFen9d8i+W9m2auEVLFK1dRchh1mSw14KRBXM04JPt2mfWCWrX1MB7tDIya5YFY
	XI3FH7SA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wroo5-00000004sEP-41g3;
	Thu, 06 Aug 2026 03:30:09 +0000
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wroo3-00000004sE4-2p8e
	for linux-nvme@lists.infradead.org;
	Thu, 06 Aug 2026 03:30:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1785987010; x=1817523010;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=f4ixBhd7Brx2jeJDn2ZDV6uWgiY8aIJ7ZzMiWDDFOJ4=;
  b=QXVtkjjKf9qJmYmZdCiHHLQ1ZLd3Ard2TMIkzyqpBpm9D+U1QoD/lvtZ
   OaIw9zQVSBfVIrgd5um5PKUih5YsEo9UwdlNWhhiP2DH1tAtB5ZF1ffnx
   R2g6b3qECebJ8UgBKVzqqLGG8UmhPQ4flZNug3JGTM0nIyvQAuI9gCx4s
   JGN/05w9V0Oaro/c3XQlXXmhYn39WPXY1XEdAc/I7wn7xyQw0WP4ipSs8
   kE3Y6xJ9SLSOMw/VIZbt90zHKT69eumInxkV73FMiPpCnkWIkFxcRaQCY
   +mbFUluMksCviAjBrpKsLKqJscWxfAATQKVh2iOt/EgCAdVS6OYrLXBG+
   A==;
X-CSE-ConnectionGUID: Eng7EBueQTSKq3wtbQT/tA==
X-CSE-MsgGUID: u7pVxr/+SI6cJNvMsdtC2g==
X-IronPort-AV: E=Sophos;i="6.25,207,1779120000"; 
   d="scan'208";a="151606734"
Received: from mail-eastusazon11011046.outbound.protection.outlook.com (HELO BL2PR02CU003.outbound.protection.outlook.com) ([52.101.52.46])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 06 Aug 2026 11:30:09 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PIc7QGkfbzwhWv5g1oCszeq9JBoLk06Ku96hAuGonkhW1FP1vAamHIkVPZo9BbtBacvByJ7shLPIqWoEBGzCEiCFH+oBztdeigxNLIPjVBiBUpm4XP/BNRQCTUlGFWu0CwRBW/XUs3peUEEJGB8a1YYW6VA7GoxBexdbPTY4bGDM/wr2D+PI3Eu5Rj47H1L4s0Vs7PTdFpfQxLjAQqbhzxqpFddKM9uhm/eLXCXIENgYhAyGvnpQVMmHtqp0qxaBqs0p8UqW+mjMk0tN9mf6EqxyPbQZuw5S/qQnTs9MxEz4LnEukO1y+hJMQE/3ddLwetTFq+2/2YdbZ8YFKaK8wA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LLgK/IcRUOqWpyu6BP9tHyjp6F97xYl75tinUxQAMBU=;
 b=mRWBX27XB+fEgZ011v2GLdX7sg7nENOuT6XOD5k+INdV2jInbCHq7cNpe7MYZ4MmRF6i90jzhITGvPCbbGf/zkwCY6JHkhoPQyu+kpStc/iSCcvwika9Nse+4DwyfjFdr9bqVvbpHuyVb2s+gskWqlYeiimnweJLBulFS5ZXga0kS8gvBWfDENg8Q339PGjxq/33bsxvQKxAWBtwIJs5eR2v9r+hwY9bjdpH0Al3VUaxbIhxkR/xsVOcOTKEket6b5TlxTcN0gjbU2jg4p7KJaEVBgG3HcHyzDnfQ7cDFYlQFNxTlwBN9wiyjQFj+ylKAwUWu7W4t2izdTEKDKcyPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LLgK/IcRUOqWpyu6BP9tHyjp6F97xYl75tinUxQAMBU=;
 b=zVzjdRiwBqjo5cUSgVFCsVXjq9hYe0p8nYzKeKMGJwSB5WT0mWLbDOPl6AIK1SzxiLmd/86gEMiBP/sub/3lKjtr9XU1gxbQUozgIb8RMd3M9QtIKSSElUn3q+LXllOSlDfPMq306n4hX3T1LMrI1ydQnYA1YzWu184a7MLRPK8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
Received: from SA1PR04MB10065.namprd04.prod.outlook.com
 (2603:10b6:806:4dd::14) by IA3PR04MB9332.namprd04.prod.outlook.com
 (2603:10b6:208:505::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.20; Thu, 6 Aug
 2026 03:30:04 +0000
Received: from SA1PR04MB10065.namprd04.prod.outlook.com
 ([fe80::9b98:bf8a:b0b1:ef85]) by SA1PR04MB10065.namprd04.prod.outlook.com
 ([fe80::9b98:bf8a:b0b1:ef85%4]) with mapi id 15.21.0292.018; Thu, 6 Aug 2026
 03:30:03 +0000
Date: Thu, 6 Aug 2026 12:29:57 +0900
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: John Garry <john.g.garry@oracle.com>
Cc: linux-nvme@lists.infradead.org
Subject: Re: [PATCH blktests] nvme/068: check module reference count with
 patience
Message-ID: <anP_X6bgk-H9bL_3@shinmob>
References: <20260805051353.2037772-1-shinichiro.kawasaki@wdc.com>
 <a7b2a986-9769-4751-994e-eb3d80694b7b@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a7b2a986-9769-4751-994e-eb3d80694b7b@oracle.com>
X-ClientProxiedBy: TY4PR01CA0001.jpnprd01.prod.outlook.com
 (2603:1096:405:26e::6) To SA1PR04MB10065.namprd04.prod.outlook.com
 (2603:10b6:806:4dd::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR04MB10065:EE_|IA3PR04MB9332:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a98d371-e223-49a7-72ea-08def36b00cf
WDCIPOUTBOUND: EOP-TRUE
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|19092799006|1800799024|366016|376014|23010399003|56012099006|11063799006|10067099003|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: qjeiO/ujzeBkIF8tfZMGhtsxGMpLs7El9AfjO8mngwIeqMHZtxhtf2wiIVuowGtBMpt1OAwGnQeO9xN55EyTyUh9OpfZZFcyxm7I8otVnP5hlNPrs2J9HE2N/Oo+aAS4d/IJ+MwEgodMapQsQ9bK4A35392Trm+RrUTRza/lVhviFrW1ETHU5OOOLD0GBMzGuaHiDWtbFigKgpiLkq9kUag/tpAjhM1FBJWRW2SXbHyZ1vEgCMYGUWnLTrdFJglxlkisuQHDup5e5aTJoBPXLRkBk/snXEOt+Lq+VE7BaSVcPU5t5cvoMgwUpjIFPa44g0/FZapJ19m0t2vumeRHcB5DRQLhEQWVEr8swtIJ4XxcYJPrv2APOAgtp3DuIl/ZOB0SvQ0E0G5LNKizoNexXkZHfMh0VXN6AfGY5yKTbml8E60aiUQ/QwcojYUwqFw6qenZcpu0/iII/1/nOOLqSNNWzHFWbmLHs0OEm73E000LrkAT7FJ6OGMm2KpBtzrPS2Z1Ysfb+HOLiy7HDWNSmzxh2bhiIw4Tn25qx30+qaT1hOezT+sWzZjsKB0L//x/PPknoyI6dlod/Jf4JANEewJ6nVUjHPcU3Rlq5XCTBjodT+sj3CAKROzIyNGdZxY8ar+9KGJ7nDVa8rOxazKUsJzgHqNdNO1f+mnBrRAgVs8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR04MB10065.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(366016)(376014)(23010399003)(56012099006)(11063799006)(10067099003)(4143699003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fZPvKEGoCi2LFvd8dAILyX81YAco9uFyVrL2NtNqO5kG1rzSl7Irp1pbL2T/?=
 =?us-ascii?Q?gs9xpsPBbJrHYgO5mofQ0Chti6Bije9F8Ozi29qhv3tnY0a563/EZtR9Urm7?=
 =?us-ascii?Q?ILWJ2NPEEQtx0GwJW8shVE5dWJReQ2OB0rayT4NuSRA3MACXK24JXayTh54N?=
 =?us-ascii?Q?ngwMWElFoyU4+0f4Q88QypLncGnBBQwsy1zWH33jJlnKo1VnTajnpJMMeRdv?=
 =?us-ascii?Q?TLnqaY7fbLj1f0w6dwmp4a9P9vn/87EDDtVAbVhqew0gzsGkei9gN0QrXVcz?=
 =?us-ascii?Q?8nV8lvIQ55yNLYT9qN/3rvDfgzS1g2QQJgXHpcjutX2OU/qgHqfaVWOSCb5K?=
 =?us-ascii?Q?Arp5GZy0rKeFAVc2XFxlSEMi+0dQWvrs7Byay9baAhEWJR65dVDovs7IvoB+?=
 =?us-ascii?Q?SJel4WB81sT6dW7zBd27slG30DCUt22Th6wdbD0lhFzOMrO+uuG7FAYYGrYa?=
 =?us-ascii?Q?7NBVl2IUGqdAuBAgAAPxOSY3VoqLVxK3FvSuLpSmBeQ8+zbZ9RtRshYsUxUB?=
 =?us-ascii?Q?4dc7leE4N1vlzx55GL3PVLO3TMzAyGRXUEA/uUEAImfSCbp844Mc5HEXRald?=
 =?us-ascii?Q?D/85WncW2EExehoYfx6/py6v//gdfjHbzDSFuFrx1ozVNwL9vLhxN8NYybHV?=
 =?us-ascii?Q?8emzOiW/QKsNFzMvyYlRi3Zxgc5t1JHW9/el3azmTzynpABOcH52bmxsy/wS?=
 =?us-ascii?Q?1lxBo4FLOxmKbdv0roEx4sBdnmjsAjH2VfUK3Jt9nfrccCAkKLRvaDKBWKOj?=
 =?us-ascii?Q?vMXE58aCo0aaTMbcugdC4NAy0xGVKPskYqrikxQwuw5R5q3VuZ3RPYQhlrx0?=
 =?us-ascii?Q?0xHJa7jFY5mYE1aiBA9qZJqCowLod2RyWvgFHKKoZwjWtQ6lbrRDT3132+qT?=
 =?us-ascii?Q?wLsulEP3HxoDAe6bhRbO39g0vO2Vzal0tHtslN+JfMg9yfcP9yL79LWabxP9?=
 =?us-ascii?Q?gEERUKcPgZtxVAjqaMAz1zt1yQPwH18iHhtK6msPxuqS25R7quP+7jcAcqHf?=
 =?us-ascii?Q?ocN94aXpGOekhdtOXGFLiAcPyhH3r9Np/27NYaRPSNI8FaqsEukGysFEjsAR?=
 =?us-ascii?Q?VH/o3bHKXXphYmMU8Zme6Lsu8W2p276BSsFkuDCiu26xU4H5wnjzIswSnsBl?=
 =?us-ascii?Q?ixblciPCvjIzKGqrnHsYZcPUoWyjMHL6t5xTLAAZAIAPTwA8f2FjLTUc14XC?=
 =?us-ascii?Q?N7GGKL3SfTwdGsSJNYz4U72+ZCzpyJ5u/jhgax5fncbIKcRnPVI5my/CL1xa?=
 =?us-ascii?Q?5Eui6tWDzrjd92ONdQrfH58SB/Qs+ikPBxzUCtTEj3iFf+z+bP11Q+tZLpdz?=
 =?us-ascii?Q?YpAN85WnQv6Tbvw+ZUFc7z8uSlLeYMfUYQx68Xo9IX7j5548C0/i7DWQEf/X?=
 =?us-ascii?Q?cb7pVx1LAm9wN2jn+nblfgXK9NJtGe8ftc+cEHJjXq29EDe6cBJKChFvC84b?=
 =?us-ascii?Q?nWiYVpJ6b2zo1u6FbzMqIi9iwYxGwmyG4teT6qUMOmMDFTuQM7gAMoS7ipnL?=
 =?us-ascii?Q?yL0yHCAD9YAtou6raM7HwRuvmHfH5RmKimt37A/F2GKcIzUN0PrVL3riQXuu?=
 =?us-ascii?Q?m3Z9OGXzbEA4kX67JihsK4Sxi6QaEc7DyioSUtlCeNRDtdZNBjKIQhYn351f?=
 =?us-ascii?Q?QtRYQakxvuEntBeAuy3D+aYM8jMk7NL4bmmt/902ZLbUJdPFSqPIwk8aMpwf?=
 =?us-ascii?Q?448j4TGnI0EDn2DZ1V/qI800evzOep2LQBDblUm0zvwRp1iMCpjitkERMFFd?=
 =?us-ascii?Q?S1UN6q9egAmPUcFYORPy/Wq3yWqNM4s=3D?=
X-Exchange-RoutingPolicyChecked: R1BrL9ctnj6zUc0VdX+Mdx4Nu5q0UsZAcqX0/0dnaWJ4rYqZ1nD2K2jF0HzVfQvjZcCqVp9KhfWviwVtfUEsdrF38K3NbK6C0YeSEZmHu7N9w3Wi5/VhGzemfzBOBY/w11gTwI7En2t7J0MZb4woiIJb8SaMwcaIKsOFqYCGK85cD/XLmAQLTPLu+0Vtmt7/y70VQeEHDbicXQfBhg1MMGuQuRxCKf0mPS4OYewtfAkJNuRGGxQMgU9rUa/Ien/QTcA0P8qWBrYrnS3X0sCeSM3HhwCFFBmJYn2FzF3acGR3iKryru1mGCF2wSYy8zB+Pp6bu8uQXwtrZKW/mFWBQw==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: hDJ+hStcuTD4CPWMnmwGXVhBnoa2JR88Bnl2zieKR+QpibDVbJ4zJ1HfOD6GOqMdax+2O+u3GlS6v4ThcDQ1vAYVmhq6RPNAqt+OWsDo64EjQMMnKy+w6arqQNlDYdUepbbojr1ZOzQRi9O27naaRpEi4mwoDz+EthfaW8o15sj+4SwxTjuG63fvSdV3nSUA2mKxDEnQDmkyS5KPbcfVQWNBNH6e/WmC4IBRR2oUtQkx1OBWWtcenlEir8jSV/oRymJ4De8aTpEnrTz8FvRRBO5YvyMVal/xEZE8ugVK1jRYpvxoX32jPGR9jEn1t9AMrEtFEHUVDA42UaLVmj2S1IM4m9nPL+lT6vHZ/hH+c52ZP1LF4k/LC7Rylid1HJ4g4FP11ser2wBAGtDxgFU6yUe8K25+KUnw98aFn2CvZQKXVrt+kS3YppDpEpVr0tChzgf6Rj9S0n9FmqOTAPiqVg0clOrzAT9v4Hl1CkGOYbL+QikP/CAMz/Dxvvm6u2sdGCW5WlylB5YfFH90RJc9FH6cteNoOudgVNoVhlsbQ1GVrZni0Y1mnFS+vBeHad5FPtPJHc0AKFPhRXaQSueN9tlyOV4LW0/Jkxdodq4sWs29oLM9ZsMKsI5yDFV3MMFW
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a98d371-e223-49a7-72ea-08def36b00cf
X-MS-Exchange-CrossTenant-AuthSource: SA1PR04MB10065.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2026 03:30:03.4945
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SEkNJiWY1TGkA7uei++9GqNbsDAOb+PeiuaEniMt+ZCpJp+Wm/HTDp5LBBpMWcSjh6hECiCed79zgI6ZwUb+a+ylRJsbApmyTSWQ5Ujhn00=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR04MB9332
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260805_203007_775120_D278D526 
X-CRM114-Status: GOOD (  15.74  )
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

On Aug 05, 2026 / 09:07, John Garry wrote:
> On 05/08/2026 06:13, Shin'ichiro Kawasaki wrote:
[...]
> > diff --git a/tests/nvme/068 b/tests/nvme/068
> > index 4aee95b..7e39e17 100755
> > --- a/tests/nvme/068
> > +++ b/tests/nvme/068
> > @@ -27,6 +27,19 @@ _delayed_nvme_reconnect_ctrl() {
> >    	_nvme_connect_subsys
> >    }
> > +_check_nvme_core_ref_count() {
> > +	local refcnt i
> > +
> > +	for ((i = 0; i < 10; i++)); do
> > +		refcnt=$(_module_use_count nvme_core)
> > +		if [ "$refcnt" != "" ] && [ "$refcnt" -eq "$refcnt_orig" ]; then
> 
> As I remember, $refcnt == "" happens when the driver is built-in. So should
> we just always return 0 immediately when we find this?

Thanks for the catch. Will reflect on v2.

> 
> > +			return
> 
> return 0?

Agreed, explicit 0 return is the better. Will reflect this to v2.


