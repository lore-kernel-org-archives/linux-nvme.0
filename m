Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE32AC021B2
	for <linux-nvme@archiver.kernel.org>; Tue, 25 Feb 2025 17:19:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-Type:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6uAgRQHXELFfAcoEGsGtPAesMuChlY6SYbJDZjKoq8g=; b=y1y/oqyKu9cgh9uQPA+Xv6IX3C
	VqnNKhsCMRg6Xivr/bznlBjnOR9e95gWJsGClStcc7EOCBnc6rM+Lpc0jKnrJOKFl/MmMDnY9pxb5
	Zau4vA9+xSJjBv1Xpyns58DcInOQqVz/o3XuwOz6dqAqaatfkdUTny8MEMQzrmsSnMEqKu/huJs6+
	xuK5iuwEg8IMbtcYohsHq/w2jFVxm4Eo9AAnImvKqGnQTXaVWKbKTEoZkBJY4KpPB04DjVLa6Vl5p
	V9GpzAnDwxNTllTFm4nMrb9A/WMmour+6LVE5AmqlDypsrdarLD16iS3oyIkqVSEYWSeySJVSgWwV
	Uwl/2dYg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tmyaJ-00000000apJ-0owW;
	Tue, 25 Feb 2025 17:19:07 +0000
Received: from mail-bn8nam04on20609.outbound.protection.outlook.com ([2a01:111:f403:2408::609] helo=NAM04-BN8-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tmyXX-00000000ZaX-28sW
	for linux-nvme@lists.infradead.org;
	Tue, 25 Feb 2025 17:16:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XE4jGgUSKNzsNhM1DFgT/LMVLWTkbjYLDOEMb7J9gxV+5JlGBukdCWF7/j9P7bZQasSdH9QcmDCLImqwBIBJ5n2PRShIKqBncZgecfGJ83gxf3qgPdleg5RGyBArmRvoh+8UA6tGl6JufIzhI1bUR/HfcTYJsR9yasy1PWozMV23bixGjtWA6PLQhTTt/HTXtN7KQnOipjAvmFNzKQNGVAhgS/2zU8vBfysgZTtwcpT/BRJP/HP8Cz0DPqHoqAkqFRNsSA6HezGsRLuwxPgYgkkSpAYjAlm1vgmehIMwzT67Gq1iJ9/1OphJ2flLrOq2lbY+zpYSiF8xkcTCZeB8KQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6uAgRQHXELFfAcoEGsGtPAesMuChlY6SYbJDZjKoq8g=;
 b=H+npxeJZwm1GCyVEXEmnmiBX0l8AzT7mz4AvF/Caa2lduVjXjVh9t61aFvPRbmnsT8FHY0RWPB2F37nlNBMOAwtkCxxMPcgJZ7u0twa4FhXF1jVwUoKJBDfzNp9iMiW43n67bU5Oi225ggeGEjWh/KrK/24TY+4E+CI6RUwQtxf+Mbq5idzio3iMh7XLg8Hf60+D26y9U8HQOU/02/dOa+wiyzuum9wAPdzV2A27ipOpmdGFEdtvGDSZIKSv8t1USr89F1NHQQH5AHaxv7TXWG0pXMGpMqGS661+aJ0Pik9qVPJzmzGWusdtMCCCT06xJ1aGohZsZ43FJZOZ8heqRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6uAgRQHXELFfAcoEGsGtPAesMuChlY6SYbJDZjKoq8g=;
 b=XYeN1PopTZZgDSmeWD97PRNeJKE6xOYCge9HA/0B/5VYhFjASdooA/Ie/r9L+JPn+XaJsttHxAjOiDi6nVuam8795+UDSSmKFt4eoDpxzzqKxS0P//u9IyoWVRt2H7QjrpK8tFOxYGnL6Wi8tTNeNKTalEmn7xnOiV5Wr0lnzRWdaXpQAu1xa8QtQJJlEL8CSZ3Jev9fkUOuIlrc4lWdOysr0ePr8wwVZNCcIyxGql0t0jcyHs7oTFveyUionVjS1K4C44ER2D8GWu71MHYbry/74qttQaTPeUan7QMHKYQUOSQIuoyEFRO80WdjtmtLYAmYiVYmW2lGdqHeJcU7MA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB8943.namprd12.prod.outlook.com (2603:10b6:a03:547::17)
 by PH8PR12MB6674.namprd12.prod.outlook.com (2603:10b6:510:1c1::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.18; Tue, 25 Feb
 2025 17:16:01 +0000
Received: from SJ2PR12MB8943.namprd12.prod.outlook.com
 ([fe80::7577:f32f:798c:87cc]) by SJ2PR12MB8943.namprd12.prod.outlook.com
 ([fe80::7577:f32f:798c:87cc%5]) with mapi id 15.20.8466.016; Tue, 25 Feb 2025
 17:16:01 +0000
From: Aurelien Aptel <aaptel@nvidia.com>
To: Paolo Abeni <pabeni@redhat.com>, linux-nvme@lists.infradead.org,
 netdev@vger.kernel.org, sagi@grimberg.me, hch@lst.de, kbusch@kernel.org,
 axboe@fb.com, chaitanyak@nvidia.com, davem@davemloft.net, kuba@kernel.org,
 apw@canonical.com, joe@perches.com, dwaipayanray1@gmail.com,
 lukas.bulwahn@gmail.com
Cc: Boris Pismenny <borisp@nvidia.com>, aurelien.aptel@gmail.com,
 smalin@nvidia.com, malin1024@gmail.com, ogerlitz@nvidia.com,
 yorayz@nvidia.com, galshalom@nvidia.com, mgurtovoy@nvidia.com,
 edumazet@google.com, dsahern@kernel.org, ast@kernel.org,
 jacob.e.keller@intel.com
Subject: Re: [PATCH v26 01/20] net: Introduce direct data placement tcp offload
In-Reply-To: <253seo2ywq6.fsf@nvidia.com>
References: <20250221095225.2159-1-aaptel@nvidia.com>
 <20250221095225.2159-2-aaptel@nvidia.com>
 <9d381da6-cef7-431e-be82-fd2888fc480a@redhat.com>
 <253seo2ywq6.fsf@nvidia.com>
Date: Tue, 25 Feb 2025 19:15:57 +0200
Message-ID: <253mseaymgi.fsf@nvidia.com>
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0434.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a9::7) To SJ2PR12MB8943.namprd12.prod.outlook.com
 (2603:10b6:a03:547::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8943:EE_|PH8PR12MB6674:EE_
X-MS-Office365-Filtering-Correlation-Id: 369d7930-6292-4e31-2a99-08dd55c013fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024|921020|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Jo9MQ9CYye97hDf/XKN35m/UfwYUP67pRGoVnJHI4CzPLLEglNbICNWp9uKB?=
 =?us-ascii?Q?vLMK4oD375L8fhjs+DeW365+uvp1err1nRYznt4Es9e1LdZ3v1UUESmeXTHY?=
 =?us-ascii?Q?Hmbu4Q7cDvbUW9zAReQk6uOhryS3/JKeRZYt1MMm37kSZR9vTPLgQiq81CVI?=
 =?us-ascii?Q?B8Avxh9VPXiCf4BBuWVH9CnO6Nw1XOeYI0ZjuCPPiRcjNzCz4NFc6LpR8w2D?=
 =?us-ascii?Q?c0SZqc8UcYruQnUvdDfQvsErp3Ezsgtz9ooStQnWbjYwUuSILb+BRKf2707g?=
 =?us-ascii?Q?oE1CctJM6BNpIlqQDae5xt7Eib1BqYLtSEGNHr5Fja+DyYKGZnMWHpv9Ayza?=
 =?us-ascii?Q?hUXiTL0zZMjIs0L5dXg8hI4K62T6NiC7DSW/pvRbwi5SKgWbLYptkEGYzzOm?=
 =?us-ascii?Q?NKtvYyPYplpu83wMbLVPg2GS2kD/uFG7Zy9mZhU5hTtXKKBpaPsLh49IO2rb?=
 =?us-ascii?Q?l3cIZhd9Fc0jRz3CQHPTUeTPDaR/MYuB+Y5K0Ik5G68whr1a4oly6/jFKakM?=
 =?us-ascii?Q?42YHHXvBCHwXBH04eETE83ndnMnhCQlE18OYVMprTr+r58IGGx1jk5hFXjLW?=
 =?us-ascii?Q?38whr23Oa11D8XiouJsOoOpBupxBMcRpjgZpJDy90pU6kftxUfQ5LOhSfBb8?=
 =?us-ascii?Q?SujHIlkqnE7mx8Cj0eIzDNhyldxG6+O/pzuhKPcKhXQQofY9Ec0s84PeqY86?=
 =?us-ascii?Q?N/EearQONyrcfY+cnF3ObsiZjVMTErCuctdFI41uP2YgEiYMIQBjfUZlA59O?=
 =?us-ascii?Q?KK57he0vXFo5LX5yFQElCYMZrk+j1xTQKLe+3rkVJS5Mkh+kZ/vuc2ci/D1c?=
 =?us-ascii?Q?yPCIP6I599ImnNkpdO0zZ+Jd96D3csmA1FAPS1pucQHPSjZs0N3TbHmR2g9Y?=
 =?us-ascii?Q?7qUoKJRn0I3/3oJ/USxHsC5mNPc2h3hAGyN79MhHrAQZxQ567T5+udSC//gt?=
 =?us-ascii?Q?Y6jTVy3F5HyAlCO45FL092fdjZUsn/Cdj/1gU4xR/Wdwmg95klQc9pSK2Ibk?=
 =?us-ascii?Q?tXmXqNfQNWYM7MW4eHq3BN1pX432uyX9nD2zLR4BeLJZ4DyDwTO2TPJp1wmo?=
 =?us-ascii?Q?30l41ZFEPBiUZNqAyqIfQZwGjHgWYwNJAJ1+k2i0AMBw+Bj+vOCxy7xGKPO3?=
 =?us-ascii?Q?KCAwjS546/g7QNz9B01t9/sjSFTkWxYyThoOwTjVUPrrl/SQiqGn03D9H0XL?=
 =?us-ascii?Q?Zx3QWJGwmsG7lmxj53U8k4rhePVl94ZZf332Ymnmdb9j6mSiGNrLait8INGm?=
 =?us-ascii?Q?cHSXp5HvBF9XBgsMyY0SWmeZ30fF3y1IsVHgy2J3FEJqw5xk9K6wrQxgwiVd?=
 =?us-ascii?Q?LnruaYKmDU5qHKSrXq44b4pJjusTamOYn8exCEXHB3XG3LqjzY/FDNvsKO3g?=
 =?us-ascii?Q?JP1LwlJU1inh5quWR3bVxSaX37EYHt/9qgkp5Pnnok8KZOHbKEIQz3ZChlpI?=
 =?us-ascii?Q?GzAyPhuZyZ4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8943.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(921020)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?CzSsSRPHPhJjoBZz5htbuiDj8xiDuv1ro44wuZgUT/oZ7m80WVuowpzwcj3N?=
 =?us-ascii?Q?33UjtUKNlLTAkHuUjBj8AN814zjPYrW+X6BHl/jLsmn+LPACi3dz1l/tpM49?=
 =?us-ascii?Q?xXYiAhBbwgH6GlPL07fXFRoqhUAJm4o9C9SFFSHqGNxYltEJ/n4ZLDelc/h8?=
 =?us-ascii?Q?s1tgdaehcMDKjJ0UV0eT2yIMifwy5A9cgqpEYy/sY+7b+WPP4sG45opSZJrP?=
 =?us-ascii?Q?Wu3p87L5mJmrVI/icrD6RoVxoOHbhYJPLmIZuSD26WwVR65oGH+CKqUsFnEE?=
 =?us-ascii?Q?zOwIUKOpeHXM8jYO7tTlB3KhhVSeWRaZgvvKBak5ImTHIaC+xWPysByF+rXw?=
 =?us-ascii?Q?mv+I8bxVxxMG9NgXCdAssYpM9C5MmD0JlnunmpuGHsuTlVtTy9nVoA97Vq24?=
 =?us-ascii?Q?MLk35Si5dMyox/QPl4AJwuyPZjZ2HIwWeQkP0Y0IMsOV1ar8k87JUSkHlGfQ?=
 =?us-ascii?Q?QjFYZqy8SblgdwZvsJZdkoheuVM/kHQexvFD7LAl1nRRWd6CblX1rbb8iVxu?=
 =?us-ascii?Q?mXkLWgdpyQN3Dt88iiUPeA6Ebq+ecayW9FlQanHGL5l17qYSLzIdhXLURoln?=
 =?us-ascii?Q?GwQ74Kj1KiEPNG8cgEUaBgO1Otc8DmJaCRjE3gLoboxaRn9orrZq1WRa9pjw?=
 =?us-ascii?Q?hGv0C4HR3bVdWIsGvRJ9yETV1lsydobT9Sru0hh7FvUpr6nmRJp9rEfokUoT?=
 =?us-ascii?Q?Pac6EPNpvA7jMANIYBmTgBxktRrB7RA8WBFu0obZvE9EJon/0XXAPt+aKzak?=
 =?us-ascii?Q?HeRiIdH14HW51rym8elfQ91/orG+IAh3bDAY0YnEhgqcduNj8Ab5qww6cTwF?=
 =?us-ascii?Q?XO3XxSdX5rv/p02czdZmKO5peIkL8OM2Peyk5j+NVH3lvfkWaAJ7HZ/ZTgJw?=
 =?us-ascii?Q?ilBChyYrdcHbEx8E3I9QK3SdxGdqxqXN9SlOTcRumqUcnxDAcsSYXQhUyeh5?=
 =?us-ascii?Q?I8mK4dtzAwLeafadNG8pvJre7JtXaVZGU5ag9NYBarR+cSQxaPImZjtCiYC1?=
 =?us-ascii?Q?wnNgD4/q1/43fK6DM/QrVDOKqmwV6NlDpxVaK5UzWvLwPOlh6Hezv0T/vWr5?=
 =?us-ascii?Q?NAjM0qzx7oQpi0qaif3t8AkqTh0JcDwjrXxC7yt8YvEYl7rmbJe0rYcaA1rU?=
 =?us-ascii?Q?4O6lsMk826EPtoFdHQFE/R/NevAaypGKZJ09NocfnzgWwO++Mz1mwnevgdJL?=
 =?us-ascii?Q?MUi/ntVZk7VL3UvQSK+bcTHREsMceoSmy45TIZfmVSYBntN3oAyh8i1apGHb?=
 =?us-ascii?Q?xt8oeMv06LEYGcl8KnnuZF9PuORAwtQ4suusKLNn8LxmpaoTQ41zO1BcNtvR?=
 =?us-ascii?Q?jRN72LuaA6U8TmLbzbBIj/gba2cDJo3Aun58dACHMS3tFaJi5vQTovieRDTU?=
 =?us-ascii?Q?b58BbH3QN3X+FnUgw+lOHtVYPFTr0iyDh61vucXuWaFzvuOiyuMGwKVgiQOH?=
 =?us-ascii?Q?vtL149dwleDdbZS7uDoWCVoxPQKbpr0zxxiLoD55KvEj2a/rbjaEQP5FkQX5?=
 =?us-ascii?Q?3qanSNiOR1ciOvt+k3s11nE2shQ8k512HHCu9TxCFTXS1trTx3xLFemsceye?=
 =?us-ascii?Q?ZQK9zYB1AjloGjYzKThayoUX0pKlpQ4Lma4CdJPS?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 369d7930-6292-4e31-2a99-08dd55c013fd
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8943.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2025 17:16:01.7224
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CnPwtVlkhR4c8qznLNCT+NGUEj59mP8KC+BKs7cCn3b6Mt1ioHYnpHGjtDR4HtuV9lLVEwOiLlaw07Ed8RBrGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6674
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250225_091615_550832_D9EA3C6F 
X-CRM114-Status: UNSURE (   8.88  )
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


Aurelien Aptel <aaptel@nvidia.com> writes:
> Paolo Abeni <pabeni@redhat.com> writes:
>>> +     /* put in ulp_ddp_sk_del() */
>>> +     dev_hold(netdev);
>>
>> You should use netdev_hold()/netdev_put() instead, with a paired reftracker.
>
> Ok, we will pass the tracker as argument.

There is currently a bug in checkpatch, it seems it cannot deal with kernel
typedefs when they are inside a ifdef:

    $ cat > test.h
    /* SPDX-License-Identifier: MIT */
    #if x
    int a(netdevice_tracker *p);
    #endif
    ^D

    $ ./scripts/checkpatch.pl -f test.h
    ERROR: need consistent spacing around '*' (ctx:WxV)
    #3: FILE: test.h:3:
    +int a(netdevice_tracker *p);
                             ^
    
    total: 1 errors, 0 warnings, 4 lines checked
    
    NOTE: For some of the reported defects, checkpatch may be able to
          mechanically convert to the typical style using --fix or --fix-inplace.
    
    test.h has style problems, please review.
    
    NOTE: If any of the errors are false positives, please report
          them to the maintainer, see CHECKPATCH in MAINTAINERS.


If you remove the #if/#endif it is quiet.

I'm reporting this since NIPA is so strict on checkpatch errors.
I've added checkpatch.pl maintainers in the loop.
In the meantime maybe let's ignore this warning in NIPA?

Thanks

