Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6EF1C001E0
	for <linux-nvme@archiver.kernel.org>; Thu, 10 Aug 2023 14:47:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-Type:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=AAsnZRDEjBzzC2qvNGKY+80hzLpPFY9JSKKZTXnb98E=; b=o9OExV9VUBO9TuRr93mRLwjV8n
	ks+gjK54fWQBGuJwFo6zjLUIFFFfSia/yjI3d1LDrPwey5owP4g20h0Kt7gVyi98fkyDPQN0Jjsud
	3Dq8kWx6mmZUNPkhsKyncQ/euvoYwvlARzKxztNXr9bR+y1zFpoFZkNgwy1/62iAadhca5WH/cPqF
	9Lf2pVYy/vQBeXC065In2HteyuurujMVQq7tMmjMSmt/7r1ACErTyiU0MwitS8tL5v4hK8ZjBZTse
	w35yDiezoK0oUI+HzIZ2SJ6HgThXKsCqkqaLGZK/nIiHY7Hba3C5CFIvwpfh19gdfosNZgV7WbocY
	DlAV2SIw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qU6wR-007uhf-1g;
	Thu, 10 Aug 2023 14:47:11 +0000
Received: from mail-mw2nam04on20603.outbound.protection.outlook.com ([2a01:111:f400:7e8c::603] helo=NAM04-MW2-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qU6wO-007ug4-2d
	for linux-nvme@lists.infradead.org;
	Thu, 10 Aug 2023 14:47:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IoqsOMOqJxVAfI2hy9nNSMDbr6AMztdyNc+ZPuYNasKUUQYGfkPv6Lvsln4VtLfVcdc9dI/+wlASz2BocUUbQOwWXIkylHKNoAptlmdiKZ+aON4ZJQvJpRksnzCs2vV8I487WGYVa9UnKxEiXupjkIIquG3uPpDGFXpjoKqZpT+phTc/bTwyDNcYvtQiULFQRgI1OZ1RiatSkXBmnEvXNK1ZUE5xxU0pubEDmHh/M7BcBZQNTMG1ras4LS2TUKLah+pyFC9000lV9wwbechNI5Orz9Y58DxjtAdsbpOovYX7iMhn08okpBa3hxUUhDm/2lNvWAQVF2m9g/Oqx8eudw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AAsnZRDEjBzzC2qvNGKY+80hzLpPFY9JSKKZTXnb98E=;
 b=UDfRdQqhkkDCt71jDTW0jZ2g+i7WjsyjS+h2cNbqVNhZkKAOjNELj7b9UpFjeybQH0pKaPSmfYPjF6xeVW0d7vtmwdFa7gZ66ZcLl1OBKQ4f+gCZf96t9o58CzYXDGQL3tf9ZPERETheB4/FOyv89/jtPpQFrEVaYQlCynNfNOmfTHvFJejqPrNtI8hcX20kAOaeTJt850r3oxj2/hIidPClhtbwv+QtofXk+VdLGLnBqN3tg5WJ6op21PvFjOvSfQqWWj6YetARoX1p1tOR/Kb0cWgC/2MagDl47Qdd9OieHls2IGfvEvgjbTp04/reddWUATmf/w5NuQu3ZR045g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AAsnZRDEjBzzC2qvNGKY+80hzLpPFY9JSKKZTXnb98E=;
 b=bgVlJvfBqfZh+rs1/yzzc9RlpYOhBZuCkimFobtGBDf1Tpc0Esm0B1qaJ2WxTmtRY+MoCIq3o57dfxYVgQ2ZMrUuF8nI8IOZ8ZVW8OSLPYyPg9zx5tXY+dh6axHM4HqEORr0wLxTckdnhrJ/U+KEXFiZbSJSGpRIMcGnpL3Xxzgb2TBOnlh3EsYfkliYygMrS/BoUuVKCiTuiGRr9YsPfXijNHvwhBTpzPJOHTYj0VItWy7RCzviTHWtVuRT1lRnHnSNWRI4Pd2Wpw6d7Icq+plUy0r9pnxzYrUwVIuIIzFs8opY8D8YMejP9OeUan0YfsbSipYVQcx/J3No0xFFyQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com (2603:10b6:a03:45e::8)
 by CY8PR12MB8214.namprd12.prod.outlook.com (2603:10b6:930:76::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30; Thu, 10 Aug
 2023 14:47:00 +0000
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::968e:999a:9134:766b]) by SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::968e:999a:9134:766b%7]) with mapi id 15.20.6652.029; Thu, 10 Aug 2023
 14:46:59 +0000
From: Aurelien Aptel <aaptel@nvidia.com>
To: Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
 netdev@vger.kernel.org, hch@lst.de, kbusch@kernel.org, axboe@fb.com,
 chaitanyak@nvidia.com, davem@davemloft.net, kuba@kernel.org
Cc: Boris Pismenny <borisp@nvidia.com>, aurelien.aptel@gmail.com,
 smalin@nvidia.com, malin1024@gmail.com, ogerlitz@nvidia.com,
 yorayz@nvidia.com, galshalom@nvidia.com, mgurtovoy@nvidia.com
Subject: Re: [PATCH v12 01/26] net: Introduce direct data placement tcp offload
In-Reply-To: <eb7c7bee-7105-ef0d-0f62-c251a2919128@grimberg.me>
References: <20230712161513.134860-1-aaptel@nvidia.com>
 <20230712161513.134860-2-aaptel@nvidia.com>
 <eb7c7bee-7105-ef0d-0f62-c251a2919128@grimberg.me>
Date: Thu, 10 Aug 2023 17:46:52 +0300
Message-ID: <253pm3vvtsz.fsf@nvidia.com>
Content-Type: text/plain
X-ClientProxiedBy: VI1PR08CA0231.eurprd08.prod.outlook.com
 (2603:10a6:802:15::40) To SJ1PR12MB6075.namprd12.prod.outlook.com
 (2603:10b6:a03:45e::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR12MB6075:EE_|CY8PR12MB8214:EE_
X-MS-Office365-Filtering-Correlation-Id: 86b173a7-52c8-4be5-e010-08db99b0a6c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aZ6asPa9uAFT9EhmPV/UIJy/ABg7eczdED9d09q7onWy5BrX2e3YizAZUhklC9AMgR5baqFpyyMI4Kbsr6d1ZNG77zLfwWcULPAvUh/8AvKx7cIu/NBV8rAEigH557Fxf1AhZo9ubPOOeeKL61m9ftO2s1FkVY4Q579FBhf6P24CzJvsVI3XvfaL7uXU0VSTANJ7Pjxjhil3qn3XEc4AxgK7ttIsM+XS9maooHOcC8AuUNJ/AWRF1HYFFvlOrQehf4qhlpmHY4KYCRW+Ehg4Lhn0YJjQMQV51CB63JFLTRJ73nlgC60RfyBYQ9pMJwotzrHQ4kMHdwxThiVskzrEzwgi9j2kln0O1RWjDITnx4djM4FGiAKH6XV2SvS4WwuKVKVNqi5FRqWGw9Xn4KApvXqST91GfPo5L6tQjUZl5/BrRep6qPIh8AI9IrBlhdUmVpFuOMnhl0DzSZmh3I+77heGkK9J9VT8GM9wr1gTviUN86P2f5l0U+bSKX34445uIuRTjCcCBlC7Ai0kQMsM0a6q9AoBlXeRpvt53KoUEAC2+cNnoyGIv7X4JBY62l01
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR12MB6075.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(396003)(376002)(346002)(39860400002)(366004)(451199021)(1800799006)(186006)(26005)(5660300002)(6506007)(8936002)(8676002)(41300700001)(107886003)(36756003)(38100700002)(2906002)(83380400001)(2616005)(86362001)(7416002)(66946007)(66556008)(66476007)(4326008)(6512007)(6666004)(6486002)(478600001)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?C63uJSxAl38bnhWWoY8u4er13w7wRzTiJICtuTiqEv8bRoXDz6F+vsvtdOJ7?=
 =?us-ascii?Q?PWZYC+YavmF0TrI0Bwf9bYw5rtLsrvFJvRvNU8yRd22ZJGwSjk4Y+D7H7kCr?=
 =?us-ascii?Q?BBkG19RKInBeXS1yw+GtKRe5E8BAPoOrSDy+iymFT/FaiwpcRdLTvCRrKFu0?=
 =?us-ascii?Q?b2aQTJKX33A2R1M/0lb7liSYwYEae8VjEKRQj4f2C2hIPTjt5zpsXEHNHkbB?=
 =?us-ascii?Q?FEK5FCcC0rNA/t4HIBs1h1m7Jb5dPkmQyYyD0+Qwfgu9p+KcUWRvZZDdUcHH?=
 =?us-ascii?Q?br7DsIBbg2pHa9nO2fbjejbAbng03RqZNZieaNd08g+QiYczhYltr6CJWwAM?=
 =?us-ascii?Q?K2pYXGBpdP9AbVZDnJpgyJuSuVkUm8K1xuc8lowGCHJffXHx6FoTH8MxHiPq?=
 =?us-ascii?Q?QyHRqb4kl1oTsFO7H6OEq9NIuvSkhgv0wOr2zofoiqx71TDSVFGCItr8yfge?=
 =?us-ascii?Q?UKZiqRFU83y9wdWFzkcBAKYqhsiHE5hhPF1B1wAa5TP75kC4KvOgKQkjNcaM?=
 =?us-ascii?Q?KZzXmYh73jq6w/hEzlFSgaN/spXjwtfqJT5jA9jcyPJ13OFlwSyaU2oEV9yi?=
 =?us-ascii?Q?B6VKzv4BqPubEMJsHcUxBo45B31V/N5DPTAobDqf/dZoEHVSdWPKlAuhQpWI?=
 =?us-ascii?Q?mdgnI5kzFTJsd6Qa2nqb+i/rjhWcbMm3LjjE4WSrF+DGvsINIyZ8VbvpyaPZ?=
 =?us-ascii?Q?f1rx+4KTMOXK4gZAWZ69p70+M8XdJuk2ml4Uj+/MUFflLYelzn8G3kf4M/bw?=
 =?us-ascii?Q?1gZ2LH9dT2UmKM5RZ2PIvYqpi/aSDvZdEyJDYhMp81XSGUJb2bspHzYg+yD+?=
 =?us-ascii?Q?eav94PXYW1ByjSyCVlJs8yFeSJ7WXqEjU5mpC1oQhtxjgVdf9JF7sh68THWg?=
 =?us-ascii?Q?ahAWwpMNGr5O4goJ60khLkSthjVQ7kXrKlNTvYe2oQUrmc3ANNieTAdpektk?=
 =?us-ascii?Q?aKJk3UwZQktgArhzFUmB4x1sXoRPe+FnBz+hy02w6RbpQpWNbMwZeGlFeWof?=
 =?us-ascii?Q?iL9VfNZXjci69W5+YXZj4oBkFvH568gp6aUvLRTwslFLqGwGhkr6t+x1pNdx?=
 =?us-ascii?Q?4XNZ8GRIOng97EbOw4oMbeniR+Aq7R9C6hLQL87i7yuEgEOk0iON8NlYwajs?=
 =?us-ascii?Q?/Pgu238twXRSxNDDLTngj97v9YZQhJkRx4RcgTha9DjGvJRH/dA2nVgZBvBo?=
 =?us-ascii?Q?/9mEN8q6SpybDnyo1DmApqApAXojnelpszNgnhWFxleQe13PdXeocBOA9+xQ?=
 =?us-ascii?Q?JbLYmJtpqiUPR4xZQHdnW2zoo8ln6pg9aNwLyqmuiXsXI7GR+g/GUYuVhI3f?=
 =?us-ascii?Q?plaeQonC4uUj7qaM5z12j4W4IuDLkCo/NidSvgr3LEY3MjEj8GCoPFEO+/yE?=
 =?us-ascii?Q?rfFqpVw8IRT2cP7g3v94cu2kZn2xql86qAqloYwpn90PXxtLsm3/cQTH24xA?=
 =?us-ascii?Q?gHh9IysxrxcC9eY1lP+HhehdGqnJSIlx5C84SO9yGpVXkoPimW+8ULvPFZlW?=
 =?us-ascii?Q?ARnHlq/uEVjws9qzWeT8FsYx1gK0pAUL+mjLtYfRshgOzOgduyxssw3Nfp0m?=
 =?us-ascii?Q?r2mJEc01OkV0ImUi9z8jE1s6CU5ITz6gS4025zAC?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86b173a7-52c8-4be5-e010-08db99b0a6c4
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2023 14:46:59.5652
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SiKtV/2mOM2OQcn/4tVe+igssg3kcUj6HAquATvq6QSYNyf1GkAIjtpTYw1lRGq2LouAoQftKsiLXLyMwjiQTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8214
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230810_074708_874156_947547C0 
X-CRM114-Status: UNSURE (   8.61  )
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

Sagi Grimberg <sagi@grimberg.me> writes:
>> +struct ulp_ddp_limits {
>> +     enum ulp_ddp_type       type;
>> +     int                     max_ddp_sgl_len;
>> +     int                     io_threshold;
>> +     bool                    tls:1;
>
> Is this a catch-all for tls 1.2/1.3 or future ones?

This is catch-all. Once it will be supported together with the offload,
we can add the TLS type incrementaly.

>> +struct ulp_ddp_dev_ops {
>> +     int (*limits)(struct net_device *netdev,
>> +                   struct ulp_ddp_limits *limits);
>> +     int (*sk_add)(struct net_device *netdev,
>> +                   struct sock *sk,
>> +                   struct ulp_ddp_config *config);
>> +     void (*sk_del)(struct net_device *netdev,
>> +                    struct sock *sk);
>> +     int (*setup)(struct net_device *netdev,
>> +                  struct sock *sk,
>> +                  struct ulp_ddp_io *io);
>> +     void (*teardown)(struct net_device *netdev,
>> +                      struct sock *sk,
>> +                      struct ulp_ddp_io *io,
>> +                      void *ddp_ctx);
>> +     void (*resync)(struct net_device *netdev,
>> +                    struct sock *sk, u32 seq);
>> +     int (*set_caps)(struct net_device *dev, unsigned long *bits,
>> +                     struct netlink_ext_ack *extack);
>> +     int (*get_stats)(struct net_device *dev,
>> +                      struct ethtool_ulp_ddp_stats *stats);
>> +};
>
> It would be beneficial to have proper wrappers to these that
> can also do some housekeeping work around the callbacks.

We can add wrappers in net/core/ulp_ddp.c that can NULL-check the
function pointers and do any common housekeeping if needed.

Thanks

