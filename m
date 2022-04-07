Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41980C433F5
	for <linux-nvme@archiver.kernel.org>; Thu,  7 Apr 2022 16:47:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:
	Content-Type:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ki1N/K9Y0ZLxJOaozpm6BAEEWnvGwH+P/mAwr1gcLZU=; b=XOm24iU5PF2atb/GhL+UjLHI2R
	Rkh2m3mlUiOAZNyrBeI3EMYEYvrNL0ZnQ09K0g42JEIDlrpRkuBG28xiT9D4xpTmjbTA+wVUnqqNB
	aUatrJDQRYqqHczgNDy5xGCy5hGQOZXfKXVN3OdpOO0ymcBu8tMmqjMCTuIrXQvCwrcknOaiT/mlG
	JQMDJFX+z63SlTFejD1TkJg1UnkGJd91S9w/U9TvFNaRl0wyBPik/XIFEHHEIvo3k7ChZbaixGY8X
	tl8cLwZHnhFIZ1ju3zQUl2o6Qxtob/NQkl9Zmc/i6nmwHv+SNf6ja1WgMn90bV/R7MlziCLhqo3kl
	ZQ2vEAIg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ncVHg-00DBa9-1A; Thu, 07 Apr 2022 16:47:00 +0000
Received: from mail-co1nam11on20619.outbound.protection.outlook.com
 ([2a01:111:f400:7eab::619]
 helo=NAM11-CO1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1ncV01-00D3tH-C7
 for linux-nvme@lists.infradead.org; Thu, 07 Apr 2022 16:28:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PACrXOtFXaYatINYC0ZpKy99zWDThC6o9BHc+Fvx19OE7S9LZAwplzT/gFBCe0XRXpBC+m8hSDXNjrOgtvmpqy7PU5YGIbGRFIl2Ezq1iNviuZrJlJaznTU+LP6FADJ9/jal0+zA6/wgyjY/OrT5UfUB+33ZqWE3r2Txo/RGYXVkecFFn8QVlVLP8N5XlQsy/2Q7lcE6AVlC6uA+vNlVphUrl0YwntQsiKXjXHpY89s2ZB6qgqhITLRnhzBkmq7fCRp3XxOUnibtvrZGC+5h5lt4Ak3W4c6WwGPAvt/g9SQnCHOKxVSg+2LlbqK7bTPKtlBk656j8FyVQQtcLply4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ki1N/K9Y0ZLxJOaozpm6BAEEWnvGwH+P/mAwr1gcLZU=;
 b=lOoccP7MhDsxNzc74A96Akm35E9mERlLW7Ntxbrt2XX7oIdtNd383E4qZ1ge9+ulRzoSw6ATur0PKXgvOq5TzOLmITOhyLJJPQuQHV3dQP6AR3nfoND6xQcicpilphjVwSma9Sad8mFZKwjLGMpZvZNs8tsZB8FsU2otQogJbkTxFvyccbNiEoR/M0aZn5xlPpqt3InHw1otlHrG40NE+8DUxZoo8Cyt03al/PyjChATKm338XJATSoOcl+ubZpPOn9ibI2+KeGF/SLwGKoMBDJNRiP0dBYbHLLDEbmPC+QnqQjecK2/Odgxk/9W8/jWrZPODG5ncS0fj+YRoSoyjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ki1N/K9Y0ZLxJOaozpm6BAEEWnvGwH+P/mAwr1gcLZU=;
 b=MfHFCqFq6UlKPDXuxpg5zs5JE8l4SLNtRBq2cMgV0p85NDSjbIMCWWgXAM4Dt4uLMM6eG6wMuoB3u5jByOzoxDelA9JbvNQT81NioUjV6JIbyordQsd5yn9e1PqN0zBS9kXXjNuaqpGujGQs7tvXPPH2JewL/rfy/KZkt0QhVFBl4nFlQm0XAUi7rjmKjYRKa1pOOqlUPKi/Rinlx7a52wCYYL3X4evjy3N0yb6kKC4To215vIjTHBjaRCUQW6EAW9FMCTXKO5bQJkaA6/mlZJqlKf47hFH3LECJSCr0AsnVyuqSYne6zMpcu3tGVEHITfy4SbEPwNT34i272Ppphg==
Received: from DM6PR12MB3082.namprd12.prod.outlook.com (2603:10b6:5:11b::12)
 by BL1PR12MB5126.namprd12.prod.outlook.com (2603:10b6:208:312::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.22; Thu, 7 Apr
 2022 16:28:41 +0000
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by DM6PR12MB3082.namprd12.prod.outlook.com (2603:10b6:5:11b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.23; Thu, 7 Apr
 2022 16:28:40 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::cdfb:f88e:410b:9374]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::cdfb:f88e:410b:9374%6]) with mapi id 15.20.5144.022; Thu, 7 Apr 2022
 16:28:40 +0000
Date: Thu, 7 Apr 2022 13:28:36 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Leon Romanovsky <leon@kernel.org>
Cc: Bart Van Assche <bvanassche@acm.org>, Ariel Elior <aelior@marvell.com>,
 Anna Schumaker <anna@kernel.org>, Jens Axboe <axboe@fb.com>,
 Christian Benvenuti <benve@cisco.com>,
 Potnuri Bharat Teja <bharat@chelsio.com>,
 Bernard Metzler <bmt@zurich.ibm.com>, Chuck Lever <chuck.lever@oracle.com>,
 "David S. Miller" <davem@davemloft.net>,
 Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
 Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
 Chaitanya Kulkarni <kch@nvidia.com>,
 Jakub Kicinski <kuba@kernel.org>, linux-cifs@vger.kernel.org,
 linux-nfs@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-rdma@vger.kernel.org, Max Gurtovoy <mgurtovoy@nvidia.com>,
 Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>,
 Michal Kalderon <mkalderon@marvell.com>,
 Mustafa Ismail <mustafa.ismail@intel.com>,
 Nelson Escobar <neescoba@cisco.com>, netdev@vger.kernel.org,
 Paolo Abeni <pabeni@redhat.com>, rds-devel@oss.oracle.com,
 Sagi Grimberg <sagi@grimberg.me>, samba-technical@lists.samba.org,
 Santosh Shilimkar <santosh.shilimkar@oracle.com>,
 Selvin Xavier <selvin.xavier@broadcom.com>,
 Steve French <sfrench@samba.org>, Shiraz Saleem <shiraz.saleem@intel.com>,
 target-devel@vger.kernel.org,
 Trond Myklebust <trond.myklebust@hammerspace.com>,
 Yishai Hadas <yishaih@nvidia.com>, Zhu Yanjun <zyjzyj2000@gmail.com>
Subject: Re: [PATCH v2] RDMA: Split kernel-only global device caps from
 uverbs device caps
Message-ID: <20220407162836.GQ2120790@nvidia.com>
References: <0-v2-22c19e565eef+139a-kern_caps_jgg@nvidia.com>
 <ca06d463-cf68-4b6f-8432-a86e34398bf0@acm.org>
 <20220407155244.GP2120790@nvidia.com> <Yk8M5C/7YO7F9sk2@unreal>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yk8M5C/7YO7F9sk2@unreal>
X-ClientProxiedBy: SJ0PR13CA0162.namprd13.prod.outlook.com
 (2603:10b6:a03:2c7::17) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d138cf77-3d78-410c-7242-08da18b3aca4
X-MS-TrafficTypeDiagnostic: DM6PR12MB3082:EE_|BL1PR12MB5126:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB3082D30DDF1D85A74DE24117C2E69@DM6PR12MB3082.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WYgmGJapoZUe5rWhX5YezqTxhj5i1xKD8VrX4FknuldaEAOhMiq5tGEKBcKxwTnW9Kw7+Na+QP4cTdr2/3ENZNg6vVxl+m3+yghRZ8r44p9Bhs+155Al8+6ilw/0A5t6CPA+w7QCLlZC9AMY52T7aGt30/slPiUlR9eTchyoKrpPBYbPqc5hytykW6zKb6OC2uhCK/FTqqQHKcIfZVMEaSi9HywyoZU8qUoKTJ4Na0VXXj/rJrpg/87sz2x4VBQQoA0nn9U6Ka0kAyofXbU1rBj7ArUEJSCJrYS/M1bccJIKH8EaPaMrZHs2RSXMTfAEuju806EuFx5Y2BFdKfeZBTGr8G3cTAjCqA8/tmj0OpbZtvFxqMbhha+seBzHr1U2918YrhT09SNK//tCFelE+SnBUqLxcg45xFn7d38QrKR8YM9HGBBEA77k5rzW/p/jyFjsmOGca2p1288TUH6lHMeiVhpMI7GR9adyi2oWTt0lmjS70n0OnSa2z3drXrPCxdwRiMtDv4joPYvo26qcOtvifQJkZ2f45bvUC7qds9a+UAjXtFABIRuxhZV4YqVFnJQIWDFfUcT7H8nsweXa+lu8GsMFzleVvM/oAN/elorPd94aTiuC81Lm4fxC+k4AgaBcrVu+Wlha2Qf2mejHzg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3082.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(316002)(186003)(6512007)(26005)(7406005)(8936002)(4744005)(2616005)(36756003)(6506007)(4326008)(6666004)(6486002)(8676002)(7416002)(66556008)(66476007)(38100700002)(66946007)(5660300002)(1076003)(86362001)(6916009)(54906003)(33656002)(2906002)(508600001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Z+klXR6jx41TRpwmgyeUcVL4rT7aQWahkKkTEmVF/br/8jR6FIWx2KEsiCIC?=
 =?us-ascii?Q?IM5j3NOt4tPLXWk7QDFPMJ2G80KsNG3M87khlk5LgiGyrtXZHibYPFZuwVjz?=
 =?us-ascii?Q?4f/Sla2pKKYmIYo66uoRx1ykSVrWRX24KjXlVgI8yBoSvgr8/oWl6OCzB1aD?=
 =?us-ascii?Q?DXY3Q/TutcyKXbQ9h/9khmCi62CcP+bzwJIYmQnSXYVjqCK0JZN9Xb78CDMI?=
 =?us-ascii?Q?IIH/E9i69KeyYkx8ye/cyYU4jxwQiURsxo8i1HqRY1UVNNBEfcAonrxjnoix?=
 =?us-ascii?Q?NR1HmbPsDSrWi22FHBHIh4WBBzhwHCjPLwbXWdC4kvxRRBPI5qxQUr2qsUir?=
 =?us-ascii?Q?jtE46kFUFdlHncJbu9caNNpQeJmHZRsaBJU0acr6v7ReGUAV6xIbFewLUUSi?=
 =?us-ascii?Q?GEBKsDUE9UW7J/T0WF89XeaituWNtlh6FwGR6WcELahk8th/YC+sL0f6XKRp?=
 =?us-ascii?Q?DJBQ1ab2VcHeJccbznsiE0jB05XDrp3WTTgBBrXqjPnQw2raIcn2fEZm+/rs?=
 =?us-ascii?Q?4PbOmJc+kU2/KWXu7VfqcqBNHEPu1ovshXfqwIOx84h7PTXa+ud44ZbMVl9M?=
 =?us-ascii?Q?2loE8FrH61rxlvWHV72sahFEmzUz8NIIdkF6KNibz83ugwCtCCSZ+Hx7tK3B?=
 =?us-ascii?Q?qORU0VG8FFBwH+5osTLFUXFtBDyCJZuSLNsnX+RY1H+PQ2EKHTyIXxojTg/p?=
 =?us-ascii?Q?6Y2xzKG8hG/0D6e6vuUXiWfasG3VwDdgXuvN9lvpScqXubxuSLNEzgtgLXwq?=
 =?us-ascii?Q?+XxoomIVk2uhjdGWsS6WPDF8Pw9dRbZoKJ4B27bHzDc2ET6d10z/utw9BMRL?=
 =?us-ascii?Q?kgsnwdfSjphSVpVm/gBAcwbbGkgSxHIfYTVuMePqMRXSifznGmd5CoLk6xc4?=
 =?us-ascii?Q?u/qu2hfOSVZQiMJ11h71FbM2EkSsofR3NEQLzg+fywY0vdCQYI6vBBbBwx1V?=
 =?us-ascii?Q?bjAr/quLRexOohhk1UCbegSmenaomuo4VzF2470obkWA37hXi/ca4y+L2jIa?=
 =?us-ascii?Q?5uQtUZT4gYEu6NOBdd79QW5gD/9u6gIw0gYP8oVSmv6EFudwqJrzPKXZl7j2?=
 =?us-ascii?Q?TR3oFciPto78wbv0hOSJ8xdW1UCjy0cWBUMFVi0s7w5R6FyzHg2cnud+IyI9?=
 =?us-ascii?Q?i/IGs8YVI3Nm3IOzZmfaab4F31vrX/R6CaihaEGi71HKRmVXg/Rz1YcYtSVi?=
 =?us-ascii?Q?pIDq0/HiJ9weXB9prp4mfIXT26r9IldGboQgH6JBinch4w+DS0Ymn4ybVDjy?=
 =?us-ascii?Q?wlM7BBdTeSSdGFrPZFCDbHON4T671Vh+VmhZL+UIBE9jXvc5LnWmwJ4Fn1Rp?=
 =?us-ascii?Q?A5C5aRri0kw22DesY/GjLXRJRSDBw2QBB1Ux35a0xywNkVMJxYv7QOwaM3ZM?=
 =?us-ascii?Q?RpsJy6I97YdAHr952Akhm9EjyVaXS6KFczfJOZhCgejIP/SdXlKD/KZnxB1+?=
 =?us-ascii?Q?UfZ0xLtLvhQ2DrNJTP1LsFLKwpNjApnC4BFcKZppfY2+UAcz0CI3Iw0QnEKa?=
 =?us-ascii?Q?WkfPLMxYa9XaJD1s3Pg+RZwxS6dnD5Jey2Bxkh/bWOCHvjiGMbwFQ812Rau8?=
 =?us-ascii?Q?TkvnIzkAKs8v+sX02e1jiLFi72QkvHZ7p7yba4Q207uN5St6Cz8cx5+4CQpK?=
 =?us-ascii?Q?n+go0/1XI0Gw95tweOGLoWJ716QgCPt0n9DefVRj6kENco453e1LBffYdBEy?=
 =?us-ascii?Q?MCZy9goAAtsrraoKLkHz2drNgYBkJPYea5KtpKye/NpBf22M3KGbpoHeKN9t?=
 =?us-ascii?Q?/DLkJecZTA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d138cf77-3d78-410c-7242-08da18b3aca4
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2022 16:28:40.3529 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7+j/FkIEr5ELu1sfeJD/IpMp4qbwEEMdDm9SsrMeIxzYSKLalrCPQUT8EkRvzBHc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5126
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220407_092845_474262_51C17C57 
X-CRM114-Status: UNSURE (   9.26  )
X-CRM114-Notice: Please train this message.
X-Mailman-Approved-At: Thu, 07 Apr 2022 09:37:59 -0700
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

On Thu, Apr 07, 2022 at 07:10:12PM +0300, Leon Romanovsky wrote:

> Do you see any value in kdoc?
> 
> I personally didn't find it useful for kernel at all.

I did write a proper kdoc with the html and everything for iommufd.

It is OK and is a good starting point for someone to look at to get a
sense where to look next

But it was a lot of work..

Jason

