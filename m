Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCE80C5475B
	for <linux-nvme@archiver.kernel.org>; Fri,  1 Mar 2024 12:09:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-Type:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fU4Mn+x9zVV2UDi1k5S+eERimMYwzvqv1/IgXqlql3o=; b=yKrJaPuxWADWaNzJ8PbDyXvw3f
	InjYujG96k3oQXOkNDcHF14gBf5EG9R0Xxluqo/45yY4gqc53dc5fs5XKSmdc8z1YNxzsTFGXVzm2
	g+pmk6krqioLoxMVVD53Uenb9Y3aYOioO/dtke60JYq4yravaAwxnpJdJ55iUg7WPplTvDi6QKNQ3
	lmeKnM9V6wgaWGA2HIPUFcZdBZjM86MGeowy4zDz7fz0+A/XKSSqQoDYM+Qkag4hufWbzuBb/+wzG
	vs2b2Z2kVynQBTfSo42LkU2JRRw60+wucfjYB/6OYQmP/eM4I9UG/xg3yRypBTeMUqV0hKei1dasG
	4Z4qOQgQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rg1ha-000000006bZ-074o;
	Fri, 01 Mar 2024 12:09:22 +0000
Received: from mail-bn8nam11on20601.outbound.protection.outlook.com ([2a01:111:f403:2414::601] helo=NAM11-BN8-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rg1hX-000000006a3-0CxC
	for linux-nvme@lists.infradead.org;
	Fri, 01 Mar 2024 12:09:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bCWBUaRuVfuxzVGL2k32fphwoO0QvLmRECx9tTl/bqBy+D7f91BdLRtfaV/vwpvN3Kf5Uf53TW6c+XIekvQ/6IBqK3opEvjMjd83Xd9rHlKW/lVJdeJXbgldknWUpJ1/mBgNjidQZEcudsqPNkPduief8sJSUEm7DoUPJz39utFd1fAq2fk+dPr0GoxeuTH0+MDk0SDkwblv+zzyuaJAMZEXtALv/FoiDHUM4iMcNdfI5wUmN9sRhOifqVMMS9KL6JjkgX/KAGMxMWgH+pUccMV/tdTzNEfdBeHejyjxO2tHK6z3+44yw/U1T/erSKuvwT1IvQAikzLlHuF6nemhig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fU4Mn+x9zVV2UDi1k5S+eERimMYwzvqv1/IgXqlql3o=;
 b=X4BrmiLH/ixjxkcDOFAXOcQ1km5OJpb3llT4OwgmA153oX1ttZZicmWgCHwvDi14G6cjun+rQTzWDro/6bWGozvrilXgNLQKBdNms6oVWXHMYdK1+hJb0a4S0IFfkHTMnhTjLf20UoOwVLhLaYodoTzaNgB4iaOqSq3C8C7bqq59MiFzcRYNayOKeBVWovFhmdVpkXInByawQhmULONSeKVOpDjgCPympt/Ogs/C22SncMrd2ZhRiyvVcj/QbgC3Uxu1nidt5OVTodwUYwLq9gpPeKH0FjRI9Rhw/loRzrPXC27My44b8461eN69TSZ/58fVuhbn766mb/CFvMQqdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fU4Mn+x9zVV2UDi1k5S+eERimMYwzvqv1/IgXqlql3o=;
 b=Oh0JGzgMWwRQB1aA2KtseOxGnKJe7iStOMoeCERPHIBBRn5E7AND/VaU6JDnRkgpn0lJuyodNG7RPtbJmMIjf9ykBbBbI7GEAoeR5WhduWSAS6heFABBDf/CexA1XTycQwY7MJePXwTfKXNlBORjbtXIFabwkrzRaEouNG+zu4Gme+uxoARmjqkw1hKo4UsXgcydPtgeETBk/j6lckiL3SnxcNLhPb1xNeDjQ+EFieXfMQwROBC29Uu4W8H3DuQ9Yy4A+8ROesoJbjMLHH3KjE5jRN4JctJCjoGdIemnBqFxOLQeT33RRO6nyCHamzzpMu6OuP9/X8nbgrw5MoYABw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com (2603:10b6:a03:45e::8)
 by CYYPR12MB8991.namprd12.prod.outlook.com (2603:10b6:930:b9::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.39; Fri, 1 Mar
 2024 12:09:06 +0000
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::aa05:b8a0:7d5:b463]) by SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::aa05:b8a0:7d5:b463%3]) with mapi id 15.20.7339.031; Fri, 1 Mar 2024
 12:09:06 +0000
From: Aurelien Aptel <aaptel@nvidia.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: linux-nvme@lists.infradead.org, netdev@vger.kernel.org,
 sagi@grimberg.me, hch@lst.de, kbusch@kernel.org, axboe@fb.com,
 chaitanyak@nvidia.com, davem@davemloft.net, aurelien.aptel@gmail.com,
 smalin@nvidia.com, malin1024@gmail.com, ogerlitz@nvidia.com,
 yorayz@nvidia.com, borisp@nvidia.com, galshalom@nvidia.com,
 mgurtovoy@nvidia.com, edumazet@google.com
Subject: Re: [PATCH v23 00/20] nvme-tcp receive offloads
In-Reply-To: <20240229093219.66d69339@kernel.org>
References: <20240228125733.299384-1-aaptel@nvidia.com>
 <20240229093219.66d69339@kernel.org>
Date: Fri, 01 Mar 2024 14:09:01 +0200
Message-ID: <25334ta5f36.fsf@mtr-vdi-124.i-did-not-set--mail-host-address--so-tickle-me>
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0071.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:153::22) To SJ1PR12MB6075.namprd12.prod.outlook.com
 (2603:10b6:a03:45e::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR12MB6075:EE_|CYYPR12MB8991:EE_
X-MS-Office365-Filtering-Correlation-Id: b8795ac7-aa62-4dc7-3da5-08dc39e8646a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YFUY6C2SmWE9DVyGt69Iryvki81bx5JcexnNWOK0lTn7TMYhic4k+8z9tGarCrV9ZSD28QaSIFtqzUZNg6Lzm/JQfSuNtLuffGAgzmu09ZOdYcVZBVwV1DV01b8BjMmdBasuccH56pYpuHcMmZwZHfqADd8FLQGrzbUOeFgtXKTLgF9iIIyrTI9ManqayFKmFRz9vxLx2XaiwmXhSHnpDVEz/r1T6mecDk5t1naTaZNrExMOYrs93b32PUSHngjembt8ms0K5zm7u1G9Z6aOsqxWbChIRpdRXwOClTITX/G1BTQnBvsU0/ishE7bx1Vyz+whV7v6aA52wwuBZDwpkE3fcsZSID6mYkjmtFM8jdh2dG2wu3nBpKxk7DT3Birm9RyORsB9GId1McSqRY8UdEoVAvCc+BzPOsiZKv0rxJUD/K1zJaXDMRLX2Jk7z8NnRh9K4dO0kXv2qkSLoy6yGojOEJR3DUafMTweaJZB9TTjBuJzFtiT9N8fVn8BWEQ+O3z31gFZAFzB/pmnJfoA+XJ+Cegavu6uRQhAo1hAEO6zLvbhzVZStKwg7HK3AfdAuJBAwtypDUWmweceuoqts0g5/cnlroqjALqN5xO5Ox3RR1rMS5FZyGFL0qgSA0JX/1jsX27BjBoWFfZ4vKinow==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR12MB6075.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?OmKdv6kElXWO1lzX/ztMni6lPu0+qPzUDrxjWhDujVgsNs6rhUsxe0X/tHzg?=
 =?us-ascii?Q?TNcjayRNIS3RaHHahgLzcdVj104/AmhmbjsMT2sh3Qkl/kqSmaS79qKlXYhm?=
 =?us-ascii?Q?OInSkHiyxVXyY49Aib75e+EoNTwDfGp48bfiAfauwhNfNzN2Fh0cld0Mr1O5?=
 =?us-ascii?Q?vdBGJZ3OajWxyUV8QO495il4F+DPrquSK5xTvzI4+B1eVEspk2mX9BPPxGRs?=
 =?us-ascii?Q?Flvpxov0YBlAsO/voJpTyAesHj1APWKPa97ETck8/GN0Wn8JyhXULEdFax/r?=
 =?us-ascii?Q?No3rttXOKFUGultDCb/e9MNFXoGdDQIE5y9w0p1grW5RTbHFmgt35nr4GuIG?=
 =?us-ascii?Q?1iqYWiq067TZHn3tHYtaw8lwssAKd7OrMvqzmYKszdwPrYj87zxAOWgwyFsU?=
 =?us-ascii?Q?n6SJexY2f1pj+IH02un2+N1LrJgzs0EvQZXfWbCGTmYqQymxlkpLUnrJ91/h?=
 =?us-ascii?Q?cMUgfgzidE7+lptYZlqH0+GtxCLa2CBPxaVFDxDD9I/HJWoO6Hfu4v8TxGkD?=
 =?us-ascii?Q?1efY1aMttxjWqKAv1/b488LtjqGcs/yA0mElnTn6GodpDMjIHqONUFWi2lBe?=
 =?us-ascii?Q?EQT8olYJfFmK+iPiXB517IdFJTSY3cwXVSOGINStJswlkuURQ2ilnUzC6ykt?=
 =?us-ascii?Q?9lMzQn8/S/b+PO/2374L0QzY6n6xcdMkSgi6aSB2JgQsSl8AiEEF2mP5Tu4n?=
 =?us-ascii?Q?PHqhzafuN4dikt2w1H0Ovtw0Ty1yA1kw1RbzWpxZ07fmxFWsVRF3l7Y5wiPD?=
 =?us-ascii?Q?UIhZ0LVb6vYWfdtao0QhI32I1dXyQ4EyL22qrxd6rDihLMwhG/XJwBhcd8v/?=
 =?us-ascii?Q?RWqnVU3JQ4kfZWlFK+1oFVBSxxsUy9yQ8gHrEkPQjNppB+ZbG51oIJimoaND?=
 =?us-ascii?Q?dK4dnM8D0QHcy4IxpE3x9i+hi6VotB614t0bZpShdDRB1Bttwm9F3qYyAB4o?=
 =?us-ascii?Q?/ytLlCDk+wlqC5d6PNk2HjsVONsVrE3a/+qt5MAyLIY0rPpLagCMCJBv8jhX?=
 =?us-ascii?Q?yHIXaoxTGI3uBztxRWzvvq4IX+DBs6U1k8ckTHHSzZmformjUA7k0FsRWaCX?=
 =?us-ascii?Q?fSa6aU8NnlEIwmuY2/d6QGtm+rIfTiFZnyf2t3kRGd4M5sv2bnWs1mh91ynC?=
 =?us-ascii?Q?rQma0t1KcNo62pk/FlAIzTiSJpU7ELk/L/VIpH5hq4vFKDsozpX4sVR5qtNv?=
 =?us-ascii?Q?V4OpNiShxjO3fXUScXZGm3gJukH/G2K9gG8bgY2F+b5pdE14kfU6OUeSo134?=
 =?us-ascii?Q?dr6AmXs2Q7oXUwWM2sop4c+Okrp8I8Ggr3epfBPybICRzlZlr8yfIkKGiYfR?=
 =?us-ascii?Q?EJTPmJfK+DnWvruRoim7rf5FzNf7ou3/dmGOKcepKBesuG/kDo30Sbkh+4dK?=
 =?us-ascii?Q?HNmseQ82ODvZXiOm7uwhnit9embWL+qnxCf2WI7RS1A/UQUnR+pmuxh6daLG?=
 =?us-ascii?Q?YGzwktRqDPHVENI0ahUoWlB3HcOuYy+YvTdkvZv0q7C8YOJsrFxB9UN92OJo?=
 =?us-ascii?Q?GfZvltyYFdcVB5E8ocmf5Hceo++PrOvc75lNBFkj7NuulSsLW4KoVmxg1uT/?=
 =?us-ascii?Q?OjuevS85xq2/4zsRfncb5UvfSG8eJ2wnNaRSlYhY?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8795ac7-aa62-4dc7-3da5-08dc39e8646a
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2024 12:09:06.1407
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: viJcPBp4aBJOn9lNSs6bieCUTxh8QAqdzKcmRS/oS2QxmCU8n42qZ5nnXavXfkj9Ep48cC4EXZfNpWTUKIuxFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8991
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240301_040919_129099_F0FC94F6 
X-CRM114-Status: UNSURE (   4.02  )
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

Hi Jakub,

Jakub Kicinski <kuba@kernel.org> writes:
> drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp.c:1017:8-122: WARNING avoid newline at end of message in NL_SET_ERR_MSG_MOD
> drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp.c:1023:8-109: WARNING avoid newline at end of message in NL_SET_ERR_MSG_MOD

Will fix in the next version, thanks.

Out of curiousity, what tool is generating these warnings?
I don't see them on patchwork nor in our local CI (running sparse, smatch,
checkpatch, clang...).

Thanks

