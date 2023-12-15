Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79535C35274
	for <linux-nvme@archiver.kernel.org>; Fri, 15 Dec 2023 13:46:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-Type:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=36ixmiS5YxzKLmNyH5nPNBLHggexIDInT9QNDmE91Oc=; b=TACW63Q6ZbIGU4XMhiMbYPi/HM
	ANTI2NjZ82cqtKmRAt9nuaQGvkM5LAwSIMiaBc9CpmjxQwVl0SVuHdUO58fXSE53Bgzg+7pSeWw8e
	IZ0WD8AhBlNjHCGYlKvPAZu17m7BuwWAUU8Fz+hOsmjYqC/mTdYttWtq7manZVDq1Hdu5MLx5+m0U
	FLtBpae5P9kv/CQJTXhXmVtHRbXyltl5rrsb7RR3grnUbNFe4UrzQWVVB9lhqbKhKajNNSGTa6N0t
	x9S1WZ1ycBXtyypHPRl2Z6PVzSy4VUViYmSDdu8lsNyPVmAbjoKmuShzoWWc42NQ5d7Jc1YyvwQiR
	YtbFBa/w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rE8WU-003QG7-0q;
	Fri, 15 Dec 2023 13:46:38 +0000
Received: from mail-mw2nam10on20601.outbound.protection.outlook.com ([2a01:111:f403:2412::601] helo=NAM10-MW2-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rE8WN-003QFK-1r
	for linux-nvme@lists.infradead.org;
	Fri, 15 Dec 2023 13:46:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cvy/e6UKqcTv3y4x5izRO/z2aJEWcekoZmW9LI0UcFR2nz4QocRx0JHrz4TX68zLRpA3Xo3SYNddvVjWk3ok2qM5tzh4jNCqPNIfm5nQd6E++TW/OhoMVI1UCTQLjjImmKiFDTT7m2IqLhzZJOOecTpzPh2IYaB1ZHvAVVsFGz5bLd99nHOpisX4j8J2X+XKmnNKLFUVQN4pEXuC/N6b7TpCfUGQizzpUOMGSy/cUnnFA0x7ByeiD2vFRrbJeYbj4x2ES1KyLDHLsOVgzqxq7VKbSzgSV6qS4CuNdrwRi3VjHtgFfCMcBW3A0XeibaEgJpSbhrwDK8um67Obk3AZAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=36ixmiS5YxzKLmNyH5nPNBLHggexIDInT9QNDmE91Oc=;
 b=kYjOluPxXmrPgkvwns9opadf7vKpotkrGlwjblUylMblz8QBVb9qdclDh8Bn6E9J/hWQJ/UriLM3XXFefHliKtCU7dQBvBUdjisI3mocZLGDvlx9LFfgHL7naejo5iAXKgpzm8wGCRGVK/h463f0kFlPkW2cthIKAzWVH+OyOmzpgIWwf2TNzr0RXdCBNqDQP6FuMW9mDZbY6WfGkUxvoVm4VXZTOVJpXB1azD1GVZdvZFcyDR2aiw1yFjKPUvQBXzKHUkp9OX7VBjdSwtQDTcCbW1D0Cf/jyx/0PakhqLOxMPdC3/9PVJCg0lTR6HG+j63rD1YJXSz3sqFnmK8CFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=36ixmiS5YxzKLmNyH5nPNBLHggexIDInT9QNDmE91Oc=;
 b=kV+Fx58QB4xVT2Ub1JtatQmP83tIMFMm0pqaz+uTNktTX0HlRMRHvwMs9qPCK40LYybC3Jx8/dRbpNA9To5mWAR3G8Jj3zcygA/fgmswWyWMIsgeMtBGG5fNfXo4Vwv0WuR+qGcbDI4D8H7Ef1fNt62Lz0FlxDG41EwY5nknJL015RTXNEEmY/OEdGf36WOne/qHu92A3D4PFAGUfCkzadu2wFCyAibf0hLpZod6GNccekPHHBhzW8g4yjIk9+UNoHY371iNTa5YekHaM+old3fpab0uuzT1+HgAjlhIsZgBwNU1LfsdAemj5h+dft3sv2T/hDn1Rd/1Y42igB9yfg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com (2603:10b6:a03:45e::8)
 by BL1PR12MB5361.namprd12.prod.outlook.com (2603:10b6:208:31f::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.31; Fri, 15 Dec
 2023 13:46:25 +0000
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::eb39:938e:7503:c21e]) by SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::eb39:938e:7503:c21e%3]) with mapi id 15.20.7091.028; Fri, 15 Dec 2023
 13:46:24 +0000
From: Aurelien Aptel <aaptel@nvidia.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: linux-nvme@lists.infradead.org, netdev@vger.kernel.org,
 sagi@grimberg.me, hch@lst.de, kbusch@kernel.org, axboe@fb.com,
 chaitanyak@nvidia.com, davem@davemloft.net, aurelien.aptel@gmail.com,
 smalin@nvidia.com, malin1024@gmail.com, ogerlitz@nvidia.com,
 yorayz@nvidia.com, borisp@nvidia.com, galshalom@nvidia.com,
 mgurtovoy@nvidia.com, edumazet@google.com, pabeni@redhat.com,
 john.fastabend@gmail.com, daniel@iogearbox.net
Subject: Re: [PATCH v21 04/20] net/tls,core: export get_netdev_for_sock
In-Reply-To: <20231214181128.63793cdc@kernel.org>
References: <20231214132623.119227-1-aaptel@nvidia.com>
 <20231214132623.119227-5-aaptel@nvidia.com>
 <20231214181128.63793cdc@kernel.org>
Date: Fri, 15 Dec 2023 15:46:20 +0200
Message-ID: <253bkarino3.fsf@nvidia.com>
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0099.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2bc::20) To SJ1PR12MB6075.namprd12.prod.outlook.com
 (2603:10b6:a03:45e::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR12MB6075:EE_|BL1PR12MB5361:EE_
X-MS-Office365-Filtering-Correlation-Id: 7faabf51-282e-4d5b-e370-08dbfd743aad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: y32W+IZiOesxWIfg4Q3+kg1uM0xVxt9zWMayr9ZRwpLnmmYe+nlCWq9Rcdd/jYzqpMEA/RkKz9F5qrJQQ5pOZC6s6BkdhR+Hv67JbBVeNyZSZfm+7huGp5dWCK3y5PCdg3yjGRo8vTJn5b/zXVZcg16+77tg8VHkXUqNOS8yefXt7ocOp+C+yIXGIcLPzMJGwNLVyFAonQKxlIzwl5zuXnxPZy92KwxxrIrPm9OPPxarZUc7+0GtE0syLqtvcL0fH/ycRIbvaK6wsvEon7DdBnf8jjIrb01rNZu43eq8HpFTCbEbTIAfJfPT0hfcdO+7rMt+36MiRY3AhtD6Ofd2jX2+GryWv+bdRGLuO6zCc9/xo/sobQoo3C9FDztiqzoVawsntBXhf5GxCbUDrQB6rweOMMUvEzqhbMZ53l7mPBW7vviZl4wtlz65U44tF5mosnysGXyIRsTvvc5faMjVdKeDOTb23ICKATZE0puPYIw3l6co+Uxntr+9axqbXZ1bycRZ0WSqTeL0YdXvz+ZHWxEn6nqdhlvbhqW929w9cYUCbuBbv/EGAPnb3RLdkHi6
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR12MB6075.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(376002)(346002)(39860400002)(136003)(230922051799003)(186009)(451199024)(1800799012)(64100799003)(38100700002)(2616005)(83380400001)(26005)(36756003)(86362001)(6506007)(6666004)(6512007)(478600001)(6916009)(316002)(66946007)(66556008)(66476007)(4744005)(2906002)(7416002)(8936002)(4326008)(8676002)(5660300002)(41300700001)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?nKAKjEFYmR32TmGX8cYUDUYzpiwr+5YPzezqghLFDHcvatZzg8TGIFjDt7iH?=
 =?us-ascii?Q?iwyCTFIYnPFOxMCf1IKbr1x8b2IOw6QVYHvdl/NtBuKnpO4ZLD8V1a8mKkUa?=
 =?us-ascii?Q?oCFrPayZcVmNoZzN9wpO2WHXCqLHdeSy1ennSH7+qeFmpxPQMpnFhygLsG8V?=
 =?us-ascii?Q?RU5BK8cB+hW0xP0m4paS0eoXjaHuIXV688pb+XpJfNhr62j/js0n8kDWKCQb?=
 =?us-ascii?Q?nCPXwKJxnyEDJlYwYa1QFAQUvuBwM/h6Z4TQM/99Of6rw0MSear6Q7+sv85M?=
 =?us-ascii?Q?7ulevkhtfBkZYTYUAk/PuSp/4OWpK6AHzFIMAAxmcHjswR2wE31T7JCzTdzE?=
 =?us-ascii?Q?7EJKmtlQ1GhLxG6gkw79cHzg5QGQdxKFXKce7gLVdtvZQZjLkCs9gTIGduNS?=
 =?us-ascii?Q?kDHxXfjm+ML5Yf6iQpBGFXYPIx5ICGWvB6L8yaRpPR5vlJNIsxEvs6lhYPhC?=
 =?us-ascii?Q?PlHIUoBZ26mMAsLcjnP3pHBnALJLjZGBILi1QX+ol66W+//sitQmTxNw/wnW?=
 =?us-ascii?Q?od4b3vgjDAk6Ge+PrRBy7dfQ2XpLv08t3uDkWo+M3lcvVmONPUkYcamKpYTi?=
 =?us-ascii?Q?RY+X1DgaqQ1bbV54GrS6F8gvwzMTnT7GyIgpxHzE7lkZ10z2IiGlsAFc9pZt?=
 =?us-ascii?Q?gpnELMVmT0J+Iqwy8ndDgA7vu3GB7HEgj6bTF78zrIuPKlb4uVRIKqdC+sWL?=
 =?us-ascii?Q?FWk0dY7KTDQi2LsoLxRcM7PfOdPSq37EY51x4y7wEY5RPCN90RVl6j4tA2ZZ?=
 =?us-ascii?Q?rwNKSvLpN8RMA3xA884wljjWIbTkBt41rGDpVR72cDmlYvktifxg8iEhRwLa?=
 =?us-ascii?Q?OgxI/bgGUIxRj0t2iGczpEjsvoiiVCxaHcTkRV+QV+dlBbOJoGLWazCr2b9V?=
 =?us-ascii?Q?qF0F6TwZYraVIMZCtOxmpFMi69wPPYzAT5yiVkfsp7tFyP0X50KvCl4ugDRU?=
 =?us-ascii?Q?MDRwVyJ01UNS4Q0hgEY9r40G1mp9aLo//RFUTkLIrdIOyOKDtzWJD62D1mMM?=
 =?us-ascii?Q?1V2Ak0zmaLJ7u2FbSkjjOEfUGUS7jlrMADS7g/4v3N8wugdIzoPLwzISkHeb?=
 =?us-ascii?Q?Nsi31gBaQEJxTLE+n9o2pAcQNcLJNTX3kOHwAOpgXswinYYFKeo3oLlm1ogE?=
 =?us-ascii?Q?MxBVjCSpRxX/TlGgBuq8Op5UkHhRCZjWWGwNQe+HXQSU7bywOqjtdoIkMz2x?=
 =?us-ascii?Q?AZTPNh3Ax/XIlV4wYrWse7y3jqMeTY6B9jpZ95ZB2jD49oa1czYc6o0CzAi1?=
 =?us-ascii?Q?V50/4eCCe4TjN7vN5oJwtrpLCp+5kOt/4Id7y04WhJQG/ZkChv/pXrkAK8gh?=
 =?us-ascii?Q?OrXSTu4nIgSU0hBNQm+I+Kwh0vq5U3raJ5kzF0LbG2/toT/KYgDxrHa9UPBe?=
 =?us-ascii?Q?xj2auh1e4PYUb79Op4XDi14zc05Fm1ua093MtDMInJax8c/KIC10Mm9uQCoB?=
 =?us-ascii?Q?lV9xFZC0xQwpj/pKyOGmFcLAwGkFQaevk8vMm51LyQ8IqJsCHCv7agXpXX0s?=
 =?us-ascii?Q?Jba2HG31PL+Y1Z1g8EEC7IuMcL+HusVSVRjQWRmpootDCB+l7PeVHOp7I5oU?=
 =?us-ascii?Q?6zd95IL8YLNbsvPrEfjGIb4LK2tFWvchT1wf85EG?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7faabf51-282e-4d5b-e370-08dbfd743aad
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2023 13:46:24.7404
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vIbEBinezDAARYK8vTvsF4QnSt+7deHPOseypUCzT7yzIA9PIzbDk0ZOBpSw+o8Vh6GWR39TwlAuWsu5ITPSTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5361
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231215_054631_678368_CE6FBCE9 
X-CRM114-Status: UNSURE (   4.68  )
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

Jakub Kicinski <kuba@kernel.org> writes:
>> +struct net_device *get_netdev_for_sock(struct sock *sk)
>
> Since the use of this helper is now spreading we should
> switch it to netdev_hold and have the caller pass in a
> netdevice_tracker.

Ok, we will update and store a netdevice_tracker in nvme-tcp.

Thanks

