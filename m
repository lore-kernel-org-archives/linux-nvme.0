Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 487C0C3ABAD
	for <linux-nvme@archiver.kernel.org>; Wed, 30 Apr 2025 10:01:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-Type:
	Content-Transfer-Encoding:References:In-Reply-To:Message-Id:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=JKZdvNAOF58+OSzBJoJJAcltvZUfAW/mVJgUl9WXgxI=; b=wP5fXtFSf6lntdGkrhV0XzRPhf
	rAp+PJBr6pLuhXNbQ3l5Yo+BQ2i8SelPFm0Cl0e+1ANpQu03kmndfv2W2Dlt73FYCEaR4LJ9R+ZOh
	3i/zAW3dDfWIvAqogGsrdo/BBsJn+N8wtbEbwg2TAiZVy4qmckSrj2pZBjckRZqbN6LViE44TY9Xw
	0thObLt3FYqpV9VinJwjSyadmOvcImh9umGiJIUwOajQlb8k9Zfn380JmHSmdZSpbndsI+jyzz57A
	omRrBKUUHU6D8gDo703zpVKS+4LkAfONZCJU0+Ekvg4wvpH0wW2c+kjLfQkkITRpemnMk6KxAcc2c
	R3QPxa6w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uA4Fn-0000000CSPl-1EgS;
	Wed, 30 Apr 2025 10:01:23 +0000
Received: from mail-mw2nam12on20600.outbound.protection.outlook.com ([2a01:111:f403:200a::600] helo=NAM12-MW2-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uA3HS-0000000CFIW-15sx
	for linux-nvme@lists.infradead.org;
	Wed, 30 Apr 2025 08:59:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lCAymJe8W6UkOBJbANWT/ZZ9qkSCQWRysP1d5Syha4xp1ma9q2jeUi7m0lCrwkxOpf5m+KsPcl4qraZ+je05ymLY+Tl+oiyw/2vXWBHzc9upAxBKjNQKEBrZcADaTR8nHrvdH0X76eGwLLMSXjjYlkdQQP9ATR/xBZ7qYfAYGl8mwcklymfPoC4gU6RYckO7YloUoOVJklc12K+gKkzWYbByo8Zdx5nhTzA0r8f5l/w2fr5zrJChv+Q3S4ZfouNKxKn/4lMHsOTNOh9wZNylEM6rhPWI2OdDaVuEIQBkddnOM2r5sSZzhQR6/POs9zmg74x9Mo66xI5qutY2+6rkQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JKZdvNAOF58+OSzBJoJJAcltvZUfAW/mVJgUl9WXgxI=;
 b=PX5b3rbDhuTPBW18SIIdBqccWO/pZdNSjQyOB2D8aJlC7G62HU3Yyz/H+8O041Js8ObBYCa5lgAU3OlXmwGlgcGnHlQOviTNz+NBLG5hPxMHJ7ovXKAFU/gKjiaRJFztRjX0j5LJV4mpXN3aNakRyySl/dHgS/hKj9soqivoDffXik0NPLsmWUy4IQNwdXcLVA3BI8fiDUtEocz96HDywmkg7NOkvOABxIlEu9Kv7+bix3DGhGkVSpXZ8B/fxv3FIV4daGzFO2e9Lp7jhIQ4qWIm1mZjVERXQ/vkWCZpOVDKBS9tTF8vld5MuJ+tzZi2bJtWsSsfBPKhDZ18KgqyxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JKZdvNAOF58+OSzBJoJJAcltvZUfAW/mVJgUl9WXgxI=;
 b=tW5R3MhReBtMqL2AbFlcyLtT4P70IpvwmZOOJ6ahlbhuq9aRGYmG+r+fYalz32DMGLGG8dqZJELXr9q79FEv4iHIDdePoXhfLCEue83aLE+f+GKlqd2lDfWEf5BZv3puC15Ba+9TZb1rErrUXXl60M/uzIlnl0GrXIcQfGJ2tCJvGGWicRHvE7GS14kKIHqbFoZ8lSodGd3L7IAl0glEWZ9hTFqnlxKkc9IYhYF6J+/PidJdEExL8bHG/bwDWSlLm0bd/66cNnDeOTBxh7UHzkZX+8Mjzs3q7d/D7Ey+qVHPJQKIVEOTkHDJlTuoRA6zGffEtVlO8xgA/P1PYc4w2Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB8943.namprd12.prod.outlook.com (2603:10b6:a03:547::17)
 by SA1PR12MB7319.namprd12.prod.outlook.com (2603:10b6:806:2b5::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.27; Wed, 30 Apr
 2025 08:58:54 +0000
Received: from SJ2PR12MB8943.namprd12.prod.outlook.com
 ([fe80::7577:f32f:798c:87cc]) by SJ2PR12MB8943.namprd12.prod.outlook.com
 ([fe80::7577:f32f:798c:87cc%5]) with mapi id 15.20.8699.012; Wed, 30 Apr 2025
 08:58:54 +0000
From: Aurelien Aptel <aaptel@nvidia.com>
To: linux-nvme@lists.infradead.org,
	netdev@vger.kernel.org,
	sagi@grimberg.me,
	hch@lst.de,
	kbusch@kernel.org,
	axboe@fb.com,
	chaitanyak@nvidia.com,
	davem@davemloft.net,
	kuba@kernel.org
Cc: aaptel@nvidia.com,
	aurelien.aptel@gmail.com,
	smalin@nvidia.com,
	malin1024@gmail.com,
	ogerlitz@nvidia.com,
	yorayz@nvidia.com,
	borisp@nvidia.com,
	galshalom@nvidia.com,
	mgurtovoy@nvidia.com,
	tariqt@nvidia.com,
	gus@collabora.com
Subject: [PATCH v28 13/20] net/mlx5e: NVMEoTCP, offload initialization
Date: Wed, 30 Apr 2025 08:57:34 +0000
Message-Id: <20250430085741.5108-14-aaptel@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250430085741.5108-1-aaptel@nvidia.com>
References: <20250430085741.5108-1-aaptel@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TL0P290CA0004.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:5::17) To SJ2PR12MB8943.namprd12.prod.outlook.com
 (2603:10b6:a03:547::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8943:EE_|SA1PR12MB7319:EE_
X-MS-Office365-Filtering-Correlation-Id: 9fe1442f-a662-4f5c-8f83-08dd87c53c2a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?4KocnB00Gs4sHA3XbnoHAHVr3bJgGC5BrVtoenJMf7b3jcBlFHVV+nhVULaK?=
 =?us-ascii?Q?1xtayYi81Sg5yFVkfseE+mHWWzLAPpySzWufdAMegPcXcMDKbmGHNN+dgbs3?=
 =?us-ascii?Q?hiDG7FwTxKjjwJ3jZTuq2kQNMHE4UrPvLqnFYSvQuhPohgUo2pzsnRmwqY/j?=
 =?us-ascii?Q?kwvv6m6bQOhifgCZPF0OhYJOAIWoZvKPyj5ZXBH0hRLZLJHpxteTTWOxIOLY?=
 =?us-ascii?Q?0+daFN/ThVeF+x9QCF1VRkmWehQroFgw0bIjcOJozUixqE+3u8AYQL8M5xFH?=
 =?us-ascii?Q?DK00d++iCzVNEuVGBcPQ4O1FBCKUdCgIrXpaFyaEgfWKtxYmHB9yHehRUj80?=
 =?us-ascii?Q?UWOndRaHaUPC1/rSDf17D9MCpwXVUeBbTuPYQkBeYD1IglomznXtmoVNQSsI?=
 =?us-ascii?Q?ygJyxsocilY0iq368KF3WG3yzVGOoaVDC3+65ZrmTp9wzXU1LEMv2uiRNpS8?=
 =?us-ascii?Q?WcEYK1CVURJkGZvkoDMOUUQz6UATqvWhibsS2sP6+CcX/sHmu3CqCkeAP0sg?=
 =?us-ascii?Q?BXK7BPvzFGUJ4kW4L2ptBplPDunFDk8jGooBbhArEb+5m/wN8B5jkOEe2fpx?=
 =?us-ascii?Q?vrtF8syWPo8gFVXQeIR03e35A/taCyh1LfZNB3BnpBafuRlQxPmmX4xe7Bo6?=
 =?us-ascii?Q?LxjM2PxC2Ge4Marjaa0DwjxPjSTAYwkhpXDkb3FOiTyKwdJT5VUb/Or6tjll?=
 =?us-ascii?Q?/z6U3kkgDEH6H8c2MeH1+UT9xNoiiWCqARUC0u5SC4iKuv8Fdtxtj9AU0OZ2?=
 =?us-ascii?Q?dzuFAaYUTvUWcklzAEKSLceptuVGNfEwZfVLcUfY6t6Pevb8aZ+ZNYA/stIK?=
 =?us-ascii?Q?s9O0OUNWKQXdg5xPE1ZSqU5zldxPm6h5M6jY1w/u3kRXzBeGIliZJrlAD7V/?=
 =?us-ascii?Q?7QvtPBNA01RLdriPN2urJJmCQtJn4l/UWNGPfQijaq0kE+4KZrZaotA2/krL?=
 =?us-ascii?Q?6wwC/NChL8qyJ4pIaHXpC06oaOMUD6+p1bDJuQiPT+U2n77aEcPXRYEPX1yM?=
 =?us-ascii?Q?m8etRTjDZNztIMubraXc0BXP7nb4kJMQ+pFrbEFyCJCuFhfbb+aPKNjcMmy7?=
 =?us-ascii?Q?1twBYNj4unRiX0VHJkLkqxD44xXxNVPCc0Uv1TqV4xWmt9TI+k15ZQpLVHXs?=
 =?us-ascii?Q?8vCgH3xvCAMiQFTN3bpNwjvmxfrcLlGFQBMaNHPxRMu3BmerGH4k+vi2LIHz?=
 =?us-ascii?Q?qG1x0s9LOHAD6gXMotVH1prS4695GBFpbKENPXG7zDIe8k2i6cieunRNRETn?=
 =?us-ascii?Q?cZNH+uOkSOVWskmDrVVUc9IooM/4yVCeqsmtl2SlPaGM2O0tFn5mA06Px1wn?=
 =?us-ascii?Q?nxw7S98PkB8mrcup/a3CkieVhJcM7Yn5howf/8MROK/tQoV49pupl7GOf0Ln?=
 =?us-ascii?Q?kX1exMYA297Be5Boupu4vDnKMy0rkLunb4Y1bApc6oukS947mzD1vCOC5mhK?=
 =?us-ascii?Q?nXHi5yV83v0=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8943.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yo7ZyS2vM39MQFLjfHIX6onz2P/SLJapGzeLvxneu+rHodN6jkU3ER0S9QR8?=
 =?us-ascii?Q?JcEvEOq4WW+bfG822i7Fy9v5s1EhGOQNnK3OdQsZGuO50jAtQ5XoAJH+T5rI?=
 =?us-ascii?Q?1RLb4YUDQc5RsrNpacWnDuk1uklIqB4U1xP13ZOCft4ipRsnxlbEIjm4GPUZ?=
 =?us-ascii?Q?TdKYU+Gj5ALs8qdK2GoqlW/HdtuWuw+g4EEok/5J7QLcfaMdwqbIgfXvU3Z6?=
 =?us-ascii?Q?nunLyTzzgRoTsIJaUFzUNCg6daMOjAfDwqeoHx3ClHpohMUoaXO5w0ngj12u?=
 =?us-ascii?Q?rVID/Bnt80qNzEMs9JIWBCtewcaywHlLb1R6D9mihjtH80InssaGlQQhJ9Gb?=
 =?us-ascii?Q?vut/bMoC0zAzhjqHYuFGHRtIlErLTeugMefdfzFaxk4FOBXYXsx63DX1aP4c?=
 =?us-ascii?Q?NFT5Dqn4yz6EzssD8CwBwL0KeV5VmDFzb1CDvmC9eZ4K9gYysHggV2Inudqi?=
 =?us-ascii?Q?4FLPIu2XB1t7q2/oodAOP2cTXlZ4IivV/fgrOIC2ZrH3pIC0VtGePFR6+H8Y?=
 =?us-ascii?Q?XvlzW9stUOPXf9k/x8aIbbtrp/aobZD1UryPuG7lvsRlAG45TGRgNexhJxVO?=
 =?us-ascii?Q?tqXAJWDyH6lbSW+9S+U4IeAq9PXhQ2wGFX1wE//Fuxup1FIY2ctLQAo5NbPA?=
 =?us-ascii?Q?xARemrB7wdve2hiUVwuDG/wh8nozmx1oFHCME7xKGCqKprQ2TyhJjTHOsPfA?=
 =?us-ascii?Q?G7ACNIkpqJwueWqmZ9kO6joMLXyuvbr1c72CBT8CRbFLNnitAGuT0XrgXpRp?=
 =?us-ascii?Q?kCD/Z6uM81M1OC1FlwkUrztUX7yiEeYHmq+/1bmhSC98IodBsw00h4lsz6qG?=
 =?us-ascii?Q?O1TPbmghDfgcnkVMl44bnzo16W8w2z+BuGFh0Odqi9V3OgE+v8Mgkh5itWVB?=
 =?us-ascii?Q?+Jt1Gb1K9fDkvVgL2HLelvFIzYoNqsnqFO96FMZGAm8/hvh2+T8UTVqtk6HV?=
 =?us-ascii?Q?J4I22GlFi7FDVb/VcfQ+gs2kUlPMwyo+NNlM+B++a5TcnhEq6xpqnWIr0Kuz?=
 =?us-ascii?Q?1SRTPDTY6Emu+CVbGlwLy0keUccQpYNMFjm1l6R1u2AGqSU59XGurOQpfTWZ?=
 =?us-ascii?Q?S6zNcVXaUpfGsjw5vRMvEjcvivEW16NEkf6oyANOB1wD1mUW+BkLQug+teBm?=
 =?us-ascii?Q?dF8nh+ivim2Nn+e6+v07mBScF0qQB8VVxcPs7YjA8P3hsjUXEVcpADM6xlGA?=
 =?us-ascii?Q?LE20QpnG2T8cNe3V3p5GQtQnSKdG3lX0Rl73hQfNxMPVVwH5k4eRwRYYj2uH?=
 =?us-ascii?Q?mZL1dOUE5cDag6YIddfyO3MDwkMUJcq1sJYhi9x46R0gQvKhji5e3xbWqBY+?=
 =?us-ascii?Q?63FHEzLs1kkLL/HaBOfvnU0pCTzfg5X8cVEXsrTb00fk++NUv71jpOBBBv7J?=
 =?us-ascii?Q?QZZ0Yvn2yJYjT7k1Z0YzlxSciKcuspBoCas1r+FkHuF4eqCn9olRbINrlC6p?=
 =?us-ascii?Q?Y76wOtuwCScNELJDmrLmhfJoXnlDvQys5u4luoo3xpPF7eFxanyl3j3xZPz4?=
 =?us-ascii?Q?zRdBlKpBkEaeVOVb+qUYVSxgxXduG+/pMNVgKUS+wNspYtmkmpWqdnAfYKcm?=
 =?us-ascii?Q?ve9nkl3y2GPpxMIXLthHRXKBurdWEOUijDM4//Lr?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fe1442f-a662-4f5c-8f83-08dd87c53c2a
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8943.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2025 08:58:54.7853
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BVHALRzwXLGA5vIrsKvt1IM3YHtiiJA3kK98ck5w/F6V3lBK4Ib56iHEokWUK96b23c4HN6MEKf/SAFJDly+wQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7319
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250430_015902_579578_43794E1D 
X-CRM114-Status: GOOD (  19.96  )
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

From: Ben Ben-Ishay <benishay@nvidia.com>

This commit introduces the driver structures and initialization blocks
for NVMEoTCP offload. The mlx5 nvmeotcp structures are:

- queue (mlx5e_nvmeotcp_queue) - pairs 1:1 with nvmeotcp driver queues and
  deals with the offloading parts. The mlx5e queue is accessed in the ddp
  ops: initialized on sk_add, used in ddp setup,teardown,resync and in the
  fast path when dealing with packets, destroyed in the sk_del op.

- queue entry (nvmeotcp_queue_entry) - pairs 1:1 with offloaded IO from
  that queue. Keeps pointers to the SG elements describing the buffers
  used for the IO and the ddp context of it.

- queue handler (mlx5e_nvmeotcp_queue_handler) - we use icosq per NVME-TCP
  queue for UMR mapping as part of the ddp offload. Those dedicated SQs are
  unique in the sense that they are driven directly by the NVME-TCP layer
  to submit and invalidate ddp requests.
  Since the life-cycle of these icosqs is not tied to the channels, we
  create dedicated napi contexts for polling them such that channels can be
  re-created during offloading. The queue handler has pointer to the cq
  associated with the queue's sq and napi context.

- main offload context (mlx5e_nvmeotcp) - has ida and hash table instances.
  Each offloaded queue gets an ID from the ida instance and the <id, queue>
  pairs are kept in the hash table. The id is programmed as flow tag to be
  set by HW on the completion (cqe) of all packets related to this queue
  (by 5-tuple steering). The fast path which deals with packets uses the
  flow tag to access the hash table and retrieve the queue for the
  processing.

We query nvmeotcp capabilities to see if the offload can be supported and
use 128B CQEs when this happens. By default, the offload is off but can
be enabled with `ethtool --ulp-ddp <device> nvme-tcp-ddp on`.

Signed-off-by: Ben Ben-Ishay <benishay@nvidia.com>
Signed-off-by: Boris Pismenny <borisp@nvidia.com>
Signed-off-by: Or Gerlitz <ogerlitz@nvidia.com>
Signed-off-by: Yoray Zack <yorayz@nvidia.com>
Signed-off-by: Shai Malin <smalin@nvidia.com>
Signed-off-by: Aurelien Aptel <aaptel@nvidia.com>
Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/Kconfig   |  11 +
 .../net/ethernet/mellanox/mlx5/core/Makefile  |   2 +
 drivers/net/ethernet/mellanox/mlx5/core/en.h  |   4 +
 .../net/ethernet/mellanox/mlx5/core/en/fs.h   |   4 +-
 .../ethernet/mellanox/mlx5/core/en/params.c   |  13 +-
 .../ethernet/mellanox/mlx5/core/en/params.h   |   3 +
 .../mellanox/mlx5/core/en_accel/en_accel.h    |   3 +
 .../mellanox/mlx5/core/en_accel/fs_tcp.h      |   2 +-
 .../mellanox/mlx5/core/en_accel/nvmeotcp.c    | 228 ++++++++++++++++++
 .../mellanox/mlx5/core/en_accel/nvmeotcp.h    | 125 ++++++++++
 .../ethernet/mellanox/mlx5/core/en_ethtool.c  |   6 +
 .../net/ethernet/mellanox/mlx5/core/en_fs.c   |   4 +-
 .../net/ethernet/mellanox/mlx5/core/en_main.c |  17 ++
 .../net/ethernet/mellanox/mlx5/core/main.c    |   1 +
 14 files changed, 414 insertions(+), 9 deletions(-)
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp.c
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp.h

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/Kconfig b/drivers/net/ethernet/mellanox/mlx5/core/Kconfig
index 6ec7d6e0181d..8e64ec593725 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/Kconfig
+++ b/drivers/net/ethernet/mellanox/mlx5/core/Kconfig
@@ -165,6 +165,17 @@ config MLX5_EN_TLS
 	help
 	Build support for TLS cryptography-offload acceleration in the NIC.
 
+config MLX5_EN_NVMEOTCP
+	bool "NVMEoTCP acceleration"
+	depends on ULP_DDP
+	depends on MLX5_CORE_EN
+	default y
+	help
+	Build support for NVMEoTCP acceleration in the NIC.
+	This includes Direct Data Placement and CRC offload.
+	Note: Support for hardware with this capability needs to be selected
+	for this option to become available.
+
 config MLX5_SW_STEERING
 	bool "Mellanox Technologies software-managed steering"
 	depends on MLX5_CORE_EN && MLX5_ESWITCH
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/Makefile b/drivers/net/ethernet/mellanox/mlx5/core/Makefile
index d292e6a9e22c..7e01096bdde0 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/Makefile
+++ b/drivers/net/ethernet/mellanox/mlx5/core/Makefile
@@ -110,6 +110,8 @@ mlx5_core-$(CONFIG_MLX5_EN_TLS) += en_accel/ktls_stats.o \
 				   en_accel/fs_tcp.o en_accel/ktls.o en_accel/ktls_txrx.o \
 				   en_accel/ktls_tx.o en_accel/ktls_rx.o
 
+mlx5_core-$(CONFIG_MLX5_EN_NVMEOTCP) += en_accel/fs_tcp.o en_accel/nvmeotcp.o
+
 #
 # SW Steering
 #
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en.h b/drivers/net/ethernet/mellanox/mlx5/core/en.h
index d87ab31dd0af..4051f23c0fc4 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en.h
@@ -316,6 +316,7 @@ struct mlx5e_params {
 	int hard_mtu;
 	bool ptp_rx;
 	__be32 terminate_lkey_be;
+	bool nvmeotcp;
 };
 
 static inline u8 mlx5e_get_dcb_num_tc(struct mlx5e_params *params)
@@ -931,6 +932,9 @@ struct mlx5e_priv {
 #endif
 #ifdef CONFIG_MLX5_EN_TLS
 	struct mlx5e_tls          *tls;
+#endif
+#ifdef CONFIG_MLX5_EN_NVMEOTCP
+	struct mlx5e_nvmeotcp      *nvmeotcp;
 #endif
 	struct devlink_health_reporter *tx_reporter;
 	struct devlink_health_reporter *rx_reporter;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/fs.h b/drivers/net/ethernet/mellanox/mlx5/core/en/fs.h
index b5c3a2a9d2a5..88b1d01f6c19 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/fs.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/fs.h
@@ -77,7 +77,7 @@ enum {
 	MLX5E_INNER_TTC_FT_LEVEL,
 	MLX5E_FS_TT_UDP_FT_LEVEL = MLX5E_INNER_TTC_FT_LEVEL + 1,
 	MLX5E_FS_TT_ANY_FT_LEVEL = MLX5E_INNER_TTC_FT_LEVEL + 1,
-#ifdef CONFIG_MLX5_EN_TLS
+#if defined(CONFIG_MLX5_EN_TLS) || defined(CONFIG_MLX5_EN_NVMEOTCP)
 	MLX5E_ACCEL_FS_TCP_FT_LEVEL = MLX5E_INNER_TTC_FT_LEVEL + 1,
 #endif
 #ifdef CONFIG_MLX5_EN_ARFS
@@ -182,7 +182,7 @@ struct mlx5e_fs_any *mlx5e_fs_get_any(struct mlx5e_flow_steering *fs);
 void mlx5e_fs_set_any(struct mlx5e_flow_steering *fs, struct mlx5e_fs_any *any);
 struct mlx5e_fs_udp *mlx5e_fs_get_udp(struct mlx5e_flow_steering *fs);
 void mlx5e_fs_set_udp(struct mlx5e_flow_steering *fs, struct mlx5e_fs_udp *udp);
-#ifdef CONFIG_MLX5_EN_TLS
+#if defined(CONFIG_MLX5_EN_TLS) || defined(CONFIG_MLX5_EN_NVMEOTCP)
 struct mlx5e_accel_fs_tcp *mlx5e_fs_get_accel_tcp(struct mlx5e_flow_steering *fs);
 void mlx5e_fs_set_accel_tcp(struct mlx5e_flow_steering *fs, struct mlx5e_accel_fs_tcp *accel_tcp);
 #endif
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/params.c b/drivers/net/ethernet/mellanox/mlx5/core/en/params.c
index 58ec5e44aa7a..674bd729971c 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/params.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/params.c
@@ -826,7 +826,8 @@ static void mlx5e_build_common_cq_param(struct mlx5_core_dev *mdev,
 	void *cqc = param->cqc;
 
 	MLX5_SET(cqc, cqc, uar_page, mdev->priv.uar->index);
-	if (MLX5_CAP_GEN(mdev, cqe_128_always) && cache_line_size() >= 128)
+	if (MLX5_CAP_GEN(mdev, cqe_128_always) &&
+	    (cache_line_size() >= 128 || param->force_cqe128))
 		MLX5_SET(cqc, cqc, cqe_sz, CQE_STRIDE_128_PAD);
 }
 
@@ -857,6 +858,10 @@ static void mlx5e_build_rx_cq_param(struct mlx5_core_dev *mdev,
 	void *cqc = param->cqc;
 	u8 log_cq_size;
 
+	/* nvme-tcp offload mandates 128 byte cqes */
+	param->force_cqe128 |= IS_ENABLED(CONFIG_MLX5_EN_NVMEOTCP) &&
+		params->nvmeotcp;
+
 	switch (params->rq_wq_type) {
 	case MLX5_WQ_TYPE_LINKED_LIST_STRIDING_RQ:
 		hw_stridx = MLX5_CAP_GEN(mdev, mini_cqe_resp_stride_index);
@@ -1207,9 +1212,9 @@ static u8 mlx5e_build_async_icosq_log_wq_sz(struct mlx5_core_dev *mdev)
 	return MLX5E_PARAMS_MINIMUM_LOG_SQ_SIZE;
 }
 
-static void mlx5e_build_icosq_param(struct mlx5_core_dev *mdev,
-				    u8 log_wq_size,
-				    struct mlx5e_sq_param *param)
+void mlx5e_build_icosq_param(struct mlx5_core_dev *mdev,
+			     u8 log_wq_size,
+			     struct mlx5e_sq_param *param)
 {
 	void *sqc = param->sqc;
 	void *wq = MLX5_ADDR_OF(sqc, sqc, wq);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/params.h b/drivers/net/ethernet/mellanox/mlx5/core/en/params.h
index bd5877acc5b1..7349478e4c30 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/params.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/params.h
@@ -17,6 +17,7 @@ struct mlx5e_cq_param {
 	struct mlx5_wq_param       wq;
 	u16                        eq_ix;
 	u8                         cq_period_mode;
+	bool                       force_cqe128;
 };
 
 struct mlx5e_rq_param {
@@ -140,6 +141,8 @@ void mlx5e_build_xdpsq_param(struct mlx5_core_dev *mdev,
 			     struct mlx5e_params *params,
 			     struct mlx5e_xsk_param *xsk,
 			     struct mlx5e_sq_param *param);
+void mlx5e_build_icosq_param(struct mlx5_core_dev *mdev,
+			     u8 log_wq_size, struct mlx5e_sq_param *param);
 int mlx5e_build_channel_param(struct mlx5_core_dev *mdev,
 			      struct mlx5e_params *params,
 			      struct mlx5e_channel_param *cparam);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/en_accel.h b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/en_accel.h
index 33e32584b07f..ee35925d987f 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/en_accel.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/en_accel.h
@@ -40,6 +40,7 @@
 #include "en_accel/ktls.h"
 #include "en_accel/ktls_txrx.h"
 #include <en_accel/macsec.h>
+#include "en_accel/nvmeotcp.h"
 #include "en.h"
 #include "en/txrx.h"
 
@@ -208,11 +209,13 @@ static inline void mlx5e_accel_tx_finish(struct mlx5e_txqsq *sq,
 
 static inline int mlx5e_accel_init_rx(struct mlx5e_priv *priv)
 {
+	mlx5e_nvmeotcp_init_rx(priv);
 	return mlx5e_ktls_init_rx(priv);
 }
 
 static inline void mlx5e_accel_cleanup_rx(struct mlx5e_priv *priv)
 {
+	mlx5e_nvmeotcp_cleanup_rx(priv);
 	mlx5e_ktls_cleanup_rx(priv);
 }
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/fs_tcp.h b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/fs_tcp.h
index 7e899c716267..6714644986a1 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/fs_tcp.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/fs_tcp.h
@@ -6,7 +6,7 @@
 
 #include "en/fs.h"
 
-#ifdef CONFIG_MLX5_EN_TLS
+#if defined(CONFIG_MLX5_EN_TLS) || defined(CONFIG_MLX5_EN_NVMEOTCP)
 int mlx5e_accel_fs_tcp_create(struct mlx5e_flow_steering *fs);
 void mlx5e_accel_fs_tcp_destroy(struct mlx5e_flow_steering *fs);
 struct mlx5_flow_handle *mlx5e_accel_fs_add_sk(struct mlx5e_flow_steering *fs,
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp.c
new file mode 100644
index 000000000000..ca9c3aaf941f
--- /dev/null
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp.c
@@ -0,0 +1,228 @@
+// SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB
+// Copyright (c) 2023, NVIDIA CORPORATION & AFFILIATES.
+
+#include <linux/netdevice.h>
+#include <linux/idr.h>
+#include "en_accel/nvmeotcp.h"
+#include "en_accel/fs_tcp.h"
+#include "en/txrx.h"
+
+#define MAX_NUM_NVMEOTCP_QUEUES	(4000)
+#define MIN_NUM_NVMEOTCP_QUEUES	(1)
+
+static const struct rhashtable_params rhash_queues = {
+	.key_len = sizeof(int),
+	.key_offset = offsetof(struct mlx5e_nvmeotcp_queue, id),
+	.head_offset = offsetof(struct mlx5e_nvmeotcp_queue, hash),
+	.automatic_shrinking = true,
+	.min_size = MIN_NUM_NVMEOTCP_QUEUES,
+	.max_size = MAX_NUM_NVMEOTCP_QUEUES,
+};
+
+static int
+mlx5e_nvmeotcp_offload_limits(struct net_device *netdev,
+			      struct ulp_ddp_limits *limits)
+{
+	return 0;
+}
+
+static int
+mlx5e_nvmeotcp_queue_init(struct net_device *netdev,
+			  struct sock *sk,
+			  struct ulp_ddp_config *config)
+{
+	return 0;
+}
+
+static void
+mlx5e_nvmeotcp_queue_teardown(struct net_device *netdev,
+			      struct sock *sk)
+{
+}
+
+static int
+mlx5e_nvmeotcp_ddp_setup(struct net_device *netdev,
+			 struct sock *sk,
+			 struct ulp_ddp_io *ddp)
+{
+	return 0;
+}
+
+static void
+mlx5e_nvmeotcp_ddp_teardown(struct net_device *netdev,
+			    struct sock *sk,
+			    struct ulp_ddp_io *ddp,
+			    void *ddp_ctx)
+{
+}
+
+static void
+mlx5e_nvmeotcp_ddp_resync(struct net_device *netdev,
+			  struct sock *sk, u32 seq)
+{
+}
+
+int set_ulp_ddp_nvme_tcp(struct net_device *netdev, bool enable)
+{
+	struct mlx5e_priv *priv = netdev_priv(netdev);
+	struct mlx5e_params new_params;
+	int err = 0;
+
+	/* There may be offloaded queues when an netlink callback to
+	 * disable the feature is made. Hence, we can't destroy the
+	 * tcp flow-table since it may be referenced by the offload
+	 * related flows and we'll keep the 128B CQEs on the channel
+	 * RQs. Also, since we don't deref/destroy the fs tcp table
+	 * when the feature is disabled, we don't ref it again if the
+	 * feature is enabled multiple times.
+	 */
+	if (!enable || priv->nvmeotcp->enabled)
+		return 0;
+
+	err = mlx5e_accel_fs_tcp_create(priv->fs);
+	if (err)
+		return err;
+
+	new_params = priv->channels.params;
+	new_params.nvmeotcp = enable;
+	err = mlx5e_safe_switch_params(priv, &new_params, NULL, NULL, true);
+	if (err)
+		goto fs_tcp_destroy;
+
+	priv->nvmeotcp->enabled = true;
+	return 0;
+
+fs_tcp_destroy:
+	mlx5e_accel_fs_tcp_destroy(priv->fs);
+	return err;
+}
+
+static int mlx5e_ulp_ddp_set_caps(struct net_device *netdev,
+				  unsigned long *new_caps,
+				  struct netlink_ext_ack *extack)
+{
+	struct mlx5e_priv *priv = netdev_priv(netdev);
+	DECLARE_BITMAP(old_caps, ULP_DDP_CAP_COUNT);
+	struct mlx5e_params *params;
+	int ret = 0;
+	int nvme = -1;
+
+	mutex_lock(&priv->state_lock);
+	params = &priv->channels.params;
+	bitmap_copy(old_caps, priv->nvmeotcp->ddp_caps.active,
+		    ULP_DDP_CAP_COUNT);
+
+	/* always handle nvme-tcp-ddp and nvme-tcp-ddgst-rx together
+	 * (all or nothing)
+	 */
+
+	if (ulp_ddp_cap_turned_on(old_caps, new_caps, ULP_DDP_CAP_NVME_TCP) &&
+	    ulp_ddp_cap_turned_on(old_caps, new_caps,
+				  ULP_DDP_CAP_NVME_TCP_DDGST_RX)) {
+		if (MLX5E_GET_PFLAG(params, MLX5E_PFLAG_RX_CQE_COMPRESS)) {
+			NL_SET_ERR_MSG_MOD(extack,
+					   "NVMe-TCP offload not supported when CQE compress is active. Disable rx_cqe_compress ethtool private flag first");
+			goto out;
+		}
+
+		if (netdev->features & (NETIF_F_LRO | NETIF_F_GRO_HW)) {
+			NL_SET_ERR_MSG_MOD(extack,
+					   "NVMe-TCP offload not supported when HW_GRO/LRO is active. Disable rx-gro-hw ethtool feature first");
+			goto out;
+		}
+		nvme = 1;
+	} else if (ulp_ddp_cap_turned_off(old_caps, new_caps,
+					  ULP_DDP_CAP_NVME_TCP) &&
+		   ulp_ddp_cap_turned_off(old_caps, new_caps,
+					  ULP_DDP_CAP_NVME_TCP_DDGST_RX)) {
+		nvme = 0;
+	}
+
+	if (nvme >= 0) {
+		ret = set_ulp_ddp_nvme_tcp(netdev, nvme);
+		if (ret)
+			goto out;
+		change_bit(ULP_DDP_CAP_NVME_TCP,
+			   priv->nvmeotcp->ddp_caps.active);
+		change_bit(ULP_DDP_CAP_NVME_TCP_DDGST_RX,
+			   priv->nvmeotcp->ddp_caps.active);
+	}
+
+out:
+	mutex_unlock(&priv->state_lock);
+	return ret;
+}
+
+static void mlx5e_ulp_ddp_get_caps(struct net_device *dev,
+				   struct ulp_ddp_dev_caps *caps)
+{
+	struct mlx5e_priv *priv = netdev_priv(dev);
+
+	mutex_lock(&priv->state_lock);
+	memcpy(caps, &priv->nvmeotcp->ddp_caps, sizeof(*caps));
+	mutex_unlock(&priv->state_lock);
+}
+
+const struct ulp_ddp_dev_ops mlx5e_nvmeotcp_ops = {
+	.limits = mlx5e_nvmeotcp_offload_limits,
+	.sk_add = mlx5e_nvmeotcp_queue_init,
+	.sk_del = mlx5e_nvmeotcp_queue_teardown,
+	.setup = mlx5e_nvmeotcp_ddp_setup,
+	.teardown = mlx5e_nvmeotcp_ddp_teardown,
+	.resync = mlx5e_nvmeotcp_ddp_resync,
+	.set_caps = mlx5e_ulp_ddp_set_caps,
+	.get_caps = mlx5e_ulp_ddp_get_caps,
+};
+
+void mlx5e_nvmeotcp_cleanup_rx(struct mlx5e_priv *priv)
+{
+	if (priv->nvmeotcp && priv->nvmeotcp->enabled)
+		mlx5e_accel_fs_tcp_destroy(priv->fs);
+}
+
+int mlx5e_nvmeotcp_init(struct mlx5e_priv *priv)
+{
+	struct mlx5e_nvmeotcp *nvmeotcp = NULL;
+	int ret = 0;
+
+	if (!(MLX5_CAP_GEN(priv->mdev, nvmeotcp) &&
+	      MLX5_CAP_DEV_NVMEOTCP(priv->mdev, zerocopy) &&
+	      MLX5_CAP_DEV_NVMEOTCP(priv->mdev, crc_rx) &&
+	      MLX5_CAP_GEN(priv->mdev, cqe_128_always)))
+		return 0;
+
+	nvmeotcp = kzalloc(sizeof(*nvmeotcp), GFP_KERNEL);
+
+	if (!nvmeotcp)
+		return -ENOMEM;
+
+	ida_init(&nvmeotcp->queue_ids);
+	ret = rhashtable_init(&nvmeotcp->queue_hash, &rhash_queues);
+	if (ret)
+		goto err_ida;
+
+	/* report ULP DPP as supported, but don't enable it by default */
+	set_bit(ULP_DDP_CAP_NVME_TCP, nvmeotcp->ddp_caps.hw);
+	set_bit(ULP_DDP_CAP_NVME_TCP_DDGST_RX, nvmeotcp->ddp_caps.hw);
+	nvmeotcp->enabled = false;
+	priv->nvmeotcp = nvmeotcp;
+	return 0;
+
+err_ida:
+	ida_destroy(&nvmeotcp->queue_ids);
+	kfree(nvmeotcp);
+	return ret;
+}
+
+void mlx5e_nvmeotcp_cleanup(struct mlx5e_priv *priv)
+{
+	struct mlx5e_nvmeotcp *nvmeotcp = priv->nvmeotcp;
+
+	if (!nvmeotcp)
+		return;
+
+	rhashtable_destroy(&nvmeotcp->queue_hash);
+	ida_destroy(&nvmeotcp->queue_ids);
+	kfree(nvmeotcp);
+	priv->nvmeotcp = NULL;
+}
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp.h b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp.h
new file mode 100644
index 000000000000..f6432a3737cd
--- /dev/null
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp.h
@@ -0,0 +1,125 @@
+/* SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB */
+/* Copyright (c) 2023, NVIDIA CORPORATION & AFFILIATES. */
+#ifndef __MLX5E_NVMEOTCP_H__
+#define __MLX5E_NVMEOTCP_H__
+
+#ifdef CONFIG_MLX5_EN_NVMEOTCP
+
+#include <net/ulp_ddp.h>
+#include "en.h"
+#include "en/params.h"
+
+struct mlx5e_nvmeotcp_queue_entry {
+	struct mlx5e_nvmeotcp_queue *queue;
+	u32 sgl_length;
+	u32 klm_mkey;
+	struct scatterlist *sgl;
+	u32 ccid_gen;
+	u64 size;
+
+	/* for the ddp invalidate done callback */
+	void *ddp_ctx;
+	struct ulp_ddp_io *ddp;
+};
+
+struct mlx5e_nvmeotcp_queue_handler {
+	struct napi_struct napi;
+	struct mlx5e_cq *cq;
+};
+
+/**
+ *	struct mlx5e_nvmeotcp_queue - mlx5 metadata for NVMEoTCP queue
+ *	@ulp_ddp_ctx: Generic ulp ddp context
+ *	@tir: Destination TIR created for NVMEoTCP offload
+ *	@fh: Flow handle representing the 5-tuple steering for this flow
+ *	@id: Flow tag ID used to identify this queue
+ *	@size: NVMEoTCP queue depth
+ *	@ccid_gen: Generation ID for the CCID, used to avoid conflicts in DDP
+ *	@max_klms_per_wqe: Number of KLMs per DDP operation
+ *	@hash: Hash table of queues mapped by @id
+ *	@pda: Padding alignment
+ *	@tag_buf_table_id: Tag buffer table for CCIDs
+ *	@dgst: Digest supported (header and/or data)
+ *	@sq: Send queue used for posting umrs
+ *	@ref_count: Reference count for this structure
+ *	@after_resync_cqe: Indicate if resync occurred
+ *	@ccid_table: Table holding metadata for each CC (Command Capsule)
+ *	@ccid: ID of the current CC
+ *	@ccsglidx: Index within the scatter-gather list (SGL) of the current CC
+ *	@ccoff: Offset within the current CC
+ *	@ccoff_inner: Current offset within the @ccsglidx element
+ *	@channel_ix: Channel IX for this nvmeotcp_queue
+ *	@sk: The socket used by the NVMe-TCP queue
+ *	@crc_rx: CRC Rx offload indication for this queue
+ *	@priv: mlx5e netdev priv
+ *	@static_params_done: Async completion structure for the initial umr
+ *      mapping synchronization
+ *	@sq_lock: Spin lock for the icosq
+ *	@qh: Completion queue handler for processing umr completions
+ */
+struct mlx5e_nvmeotcp_queue {
+	struct ulp_ddp_ctx ulp_ddp_ctx;
+	struct mlx5e_tir tir;
+	struct mlx5_flow_handle *fh;
+	int id;
+	u32 size;
+	/* needed when the upper layer
+	 * immediately reuses CCID + some packet loss happens
+	 */
+	u32 ccid_gen;
+	u32 max_klms_per_wqe;
+	struct rhash_head hash;
+	int pda;
+	u32 tag_buf_table_id;
+	u8 dgst;
+	struct mlx5e_icosq sq;
+
+	/* data-path section cache aligned */
+	refcount_t ref_count;
+	/* for MASK HW resync cqe */
+	bool after_resync_cqe;
+	struct mlx5e_nvmeotcp_queue_entry *ccid_table;
+	/* current ccid fields */
+	int ccid;
+	int ccsglidx;
+	off_t ccoff;
+	int ccoff_inner;
+
+	u32 channel_ix;
+	struct sock *sk;
+	u8 crc_rx:1;
+	/* for ddp invalidate flow */
+	struct mlx5e_priv *priv;
+	/* end of data-path section */
+
+	struct completion static_params_done;
+	/* spin lock for the ico sq, ULP can issue requests
+	 * from multiple contexts
+	 */
+	spinlock_t sq_lock;
+	struct mlx5e_nvmeotcp_queue_handler qh;
+};
+
+struct mlx5e_nvmeotcp {
+	struct ida queue_ids;
+	struct rhashtable queue_hash;
+	struct ulp_ddp_dev_caps ddp_caps;
+	bool enabled;
+};
+
+int mlx5e_nvmeotcp_init(struct mlx5e_priv *priv);
+int set_ulp_ddp_nvme_tcp(struct net_device *netdev, bool enable);
+void mlx5e_nvmeotcp_cleanup(struct mlx5e_priv *priv);
+static inline void mlx5e_nvmeotcp_init_rx(struct mlx5e_priv *priv) {}
+void mlx5e_nvmeotcp_cleanup_rx(struct mlx5e_priv *priv);
+extern const struct ulp_ddp_dev_ops mlx5e_nvmeotcp_ops;
+#else
+
+static inline int mlx5e_nvmeotcp_init(struct mlx5e_priv *priv) { return 0; }
+static inline void mlx5e_nvmeotcp_cleanup(struct mlx5e_priv *priv) {}
+static inline int set_ulp_ddp_nvme_tcp(struct net_device *dev, bool en)
+{ return -EOPNOTSUPP; }
+static inline void mlx5e_nvmeotcp_init_rx(struct mlx5e_priv *priv) {}
+static inline void mlx5e_nvmeotcp_cleanup_rx(struct mlx5e_priv *priv) {}
+#endif
+#endif /* __MLX5E_NVMEOTCP_H__ */
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c b/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
index fdf9e9bb99ac..c52911dd8f0f 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
@@ -41,6 +41,7 @@
 #include "en/ptp.h"
 #include "lib/clock.h"
 #include "en/fs_ethtool.h"
+#include "en_accel/nvmeotcp.h"
 
 #define LANES_UNKNOWN		 0
 #define MAX_LANES		 8
@@ -2149,6 +2150,11 @@ int mlx5e_modify_rx_cqe_compression_locked(struct mlx5e_priv *priv, bool new_val
 		return -EINVAL;
 	}
 
+	if (priv->channels.params.nvmeotcp) {
+		netdev_warn(priv->netdev, "Can't set CQE compression after ULP DDP NVMe-TCP offload\n");
+		return -EINVAL;
+	}
+
 	new_params = priv->channels.params;
 	MLX5E_SET_PFLAG(&new_params, MLX5E_PFLAG_RX_CQE_COMPRESS, new_val);
 	if (rx_filter)
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_fs.c b/drivers/net/ethernet/mellanox/mlx5/core/en_fs.c
index 05058710d2c7..07d2122ee88a 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_fs.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_fs.c
@@ -62,7 +62,7 @@ struct mlx5e_flow_steering {
 #ifdef CONFIG_MLX5_EN_ARFS
 	struct mlx5e_arfs_tables       *arfs;
 #endif
-#ifdef CONFIG_MLX5_EN_TLS
+#if defined(CONFIG_MLX5_EN_TLS) || defined(CONFIG_MLX5_EN_NVMEOTCP)
 	struct mlx5e_accel_fs_tcp      *accel_tcp;
 #endif
 	struct mlx5e_fs_udp            *udp;
@@ -1554,7 +1554,7 @@ void mlx5e_fs_set_any(struct mlx5e_flow_steering *fs, struct mlx5e_fs_any *any)
 	fs->any = any;
 }
 
-#ifdef CONFIG_MLX5_EN_TLS
+#if defined(CONFIG_MLX5_EN_TLS) || defined(CONFIG_MLX5_EN_NVMEOTCP)
 struct mlx5e_accel_fs_tcp *mlx5e_fs_get_accel_tcp(struct mlx5e_flow_steering *fs)
 {
 	return fs->accel_tcp;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index de25401547d2..3cd1513e4c66 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -53,6 +53,7 @@
 #include "en_accel/macsec.h"
 #include "en_accel/en_accel.h"
 #include "en_accel/ktls.h"
+#include "en_accel/nvmeotcp.h"
 #include "lib/vxlan.h"
 #include "lib/clock.h"
 #include "en/port.h"
@@ -4427,6 +4428,13 @@ static netdev_features_t mlx5e_fix_features(struct net_device *netdev,
 		netdev->netns_immutable = false;
 	}
 
+	if (features & (NETIF_F_LRO | NETIF_F_GRO_HW)) {
+		if (params->nvmeotcp) {
+			netdev_warn(netdev, "Disabling HW-GRO/LRO, not supported after ULP DDP NVMe-TCP offload\n");
+			features &= ~(NETIF_F_LRO | NETIF_F_GRO_HW);
+		}
+	}
+
 	mutex_unlock(&priv->state_lock);
 
 	return features;
@@ -5186,6 +5194,9 @@ const struct net_device_ops mlx5e_netdev_ops = {
 	.ndo_has_offload_stats   = mlx5e_has_offload_stats,
 	.ndo_get_offload_stats   = mlx5e_get_offload_stats,
 #endif
+#ifdef CONFIG_MLX5_EN_NVMEOTCP
+	.ulp_ddp_ops             = &mlx5e_nvmeotcp_ops,
+#endif
 };
 
 void mlx5e_build_nic_params(struct mlx5e_priv *priv, struct mlx5e_xsk *xsk, u16 mtu)
@@ -5665,6 +5676,11 @@ static int mlx5e_nic_init(struct mlx5_core_dev *mdev,
 	if (err)
 		mlx5_core_err(mdev, "TLS initialization failed, %d\n", err);
 
+	err = mlx5e_nvmeotcp_init(priv);
+	if (err)
+		mlx5_core_err(mdev, "NVMEoTCP initialization failed, %d\n",
+			      err);
+
 	mlx5e_health_create_reporters(priv);
 
 	/* If netdev is already registered (e.g. move from uplink to nic profile),
@@ -5685,6 +5701,7 @@ static int mlx5e_nic_init(struct mlx5_core_dev *mdev,
 static void mlx5e_nic_cleanup(struct mlx5e_priv *priv)
 {
 	mlx5e_health_destroy_reporters(priv);
+	mlx5e_nvmeotcp_cleanup(priv);
 	mlx5e_ktls_cleanup(priv);
 	mlx5e_fs_cleanup(priv->fs);
 	debugfs_remove_recursive(priv->dfs_root);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/main.c b/drivers/net/ethernet/mellanox/mlx5/core/main.c
index 41e8660c819c..2c2422b1cb03 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/main.c
@@ -1804,6 +1804,7 @@ static const int types[] = {
 	MLX5_CAP_CRYPTO,
 	MLX5_CAP_SHAMPO,
 	MLX5_CAP_ADV_RDMA,
+	MLX5_CAP_DEV_NVMEOTCP,
 };
 
 static void mlx5_hca_caps_free(struct mlx5_core_dev *dev)
-- 
2.34.1


