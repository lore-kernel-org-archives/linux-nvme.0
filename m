Return-Path: <SRS0=qC0g=5D=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 457CCC5ACD8
	for <linux-nvme@archiver.kernel.org>; Wed, 18 Mar 2020 10:29:57 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E0ED02076C
	for <linux-nvme@archiver.kernel.org>; Wed, 18 Mar 2020 10:29:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="C2C6zlK8";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="DC2z2AeE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0ED02076C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=MVp8YmWUjssJBepbg4HWrqopyHLNZZdDyWEyarZwHSU=; b=C2C6zlK8iCkwNr
	nqL8GJBPTNDzf9GaFrXWngScR0eyUeVeI1/5iCfWx3W65nR703q/buLZnIh4M2mD8/nOOk0/rOMZi
	vwLPfR6nso2HdcniuOXH0F8UUX6n96PNYjZm8F3si7qXaC7YB9zZVTc/tfn356s5EljwPOJ8/3HGX
	9tx8NPyQP/7CMtVmD4Z3nbpJcku2OYQIVmMezsDZOcwrZF3mjESGzpnGWWPyxYKtjF78WO0Vj62E+
	Y/IpfjwSI/fc2qzbdvtKEmv2mli2ywtDunX598UBZ5Xv8gRwG8Iod23Mv8+4PK0iN0ZkhuGE4n078
	/wFOv+VCtih08ZPBqFdA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jEVxQ-00026i-Rr; Wed, 18 Mar 2020 10:29:52 +0000
Received: from mail-db3eur04on0626.outbound.protection.outlook.com
 ([2a01:111:f400:fe0c::626]
 helo=EUR04-DB3-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jEVxN-00025g-N8
 for linux-nvme@lists.infradead.org; Wed, 18 Mar 2020 10:29:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gPTXSTDhwAnBVy6UO+qhSYy8goyBmP6q6+56X1bx7Umh6Y3nNMb5CKxZlijQTFgZPmsJuycrcwUMd28XPntSw4ur9cfX1yK/0GpSUNlMhuvv/7I1lkC6I4iQ4uxgHvHi4k1mYTkQL0x8J49A9PMftIGrjkoZx7T/NFxectRCnaU4UgF6GpmQLs4qaDneNTZnOtHsVF/nLUzZbsgw1Bx74tmUh4zR9m45XMjQ0DRTkCN38LvBucJl0hr6xhSLKnrTy3hQl0w6BAoKUJU9qCWad9YSqXOXzTu0m8w9eM/gMFfK4EccAeci5tTvpJ3cStT0O8FiaInLAbj49dKlPjoW/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kr+aV4AEuY4BXGcB4oaSXLkQTTGJaWP3o8rxQPVMqCI=;
 b=cL6NQkg72fPuxgZk/gWpeijuBYoY27PldMLGkfcWNvMnXAunMM8DXjWvD9zMsdi3n+orAsI77+X5XH+hwfbfsxGZ4jGQv6rU1MxJ1ocoCQCxRNC+dqugQO+tc4Hq3RifFz+esGD/oiZj1abpW/1Aiq5pMTOZrfGkskG70DzQM5bU0DZqURpRxRjhOXtaXOypmdUZvhJPDZbNwGlCZqbRZaBfyvLY8AlJ9YIc05kgUdTZCNFdL6w5vUhPSKeDCrNb0FBENf7R6R1iB8impTorh0tDAgFDBFZEJZbnrShFSKrfivJhKibXxZZQt42rgd7BvLnOqJSx4MK7HRjgQAjUHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kr+aV4AEuY4BXGcB4oaSXLkQTTGJaWP3o8rxQPVMqCI=;
 b=DC2z2AeEjeT0cF8Hq72ZUVT5AY5gM97qY17oW1yggsya6dLKaTrYuj36lZwVIu8dLAdWlbPoti71DnPoXQkGOOsiPyZRRuri1dUKchiTEs3hvsr+7mI8aF01leIJlkgdtIqznv+DEoo4//jnwzWiMlS+yrc29BamMtKPOkgFifc=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=leonro@mellanox.com; 
Received: from AM6PR05MB6408.eurprd05.prod.outlook.com (20.179.5.215) by
 AM6PR05MB6053.eurprd05.prod.outlook.com (20.179.1.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2814.13; Wed, 18 Mar 2020 10:29:45 +0000
Received: from AM6PR05MB6408.eurprd05.prod.outlook.com
 ([fe80::c99f:9130:561f:dea0]) by AM6PR05MB6408.eurprd05.prod.outlook.com
 ([fe80::c99f:9130:561f:dea0%3]) with mapi id 15.20.2814.021; Wed, 18 Mar 2020
 10:29:45 +0000
Date: Wed, 18 Mar 2020 12:29:42 +0200
From: Leon Romanovsky <leonro@mellanox.com>
To: Max Gurtovoy <maxg@mellanox.com>
Subject: Re: [PATCH 1/5] IB/core: add a simple SRQ set per PD
Message-ID: <20200318102942.GT3351@unreal>
References: <20200317134030.152833-1-maxg@mellanox.com>
 <20200317134030.152833-2-maxg@mellanox.com>
 <20200317135518.GG3351@unreal>
 <46bb23ed-2941-2eaa-511a-3d0f3b09a9ed@mellanox.com>
 <20200318064724.GP3351@unreal>
 <ec3ff6af-dd68-d049-5ff3-0c01320117e7@mellanox.com>
Content-Disposition: inline
In-Reply-To: <ec3ff6af-dd68-d049-5ff3-0c01320117e7@mellanox.com>
X-ClientProxiedBy: FR2P281CA0023.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:14::10) To AM6PR05MB6408.eurprd05.prod.outlook.com
 (2603:10a6:20b:b8::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost (2a00:a040:183:2d::393) by
 FR2P281CA0023.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:14::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2835.18 via Frontend Transport; Wed, 18 Mar 2020 10:29:45 +0000
X-Originating-IP: [2a00:a040:183:2d::393]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 97e134a3-99b4-40a6-4fb6-08d7cb27472e
X-MS-TrafficTypeDiagnostic: AM6PR05MB6053:|AM6PR05MB6053:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR05MB6053B4DA4A68CDE63AA3944FB0F70@AM6PR05MB6053.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:569;
X-Forefront-PRVS: 03468CBA43
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(7916004)(4636009)(346002)(39860400002)(376002)(396003)(366004)(136003)(199004)(5660300002)(81166006)(8676002)(8936002)(33716001)(52116002)(2906002)(6496006)(107886003)(6486002)(53546011)(33656002)(4326008)(478600001)(186003)(16526019)(9686003)(6666004)(316002)(1076003)(66556008)(6862004)(81156014)(6636002)(66476007)(66946007)(86362001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:AM6PR05MB6053;
 H:AM6PR05MB6408.eurprd05.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; 
Received-SPF: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8SbYPFi500Qx5u6/fJIBIqjcepPaBvMnD7/FUmz2hNjgdEFdFesQS4UdOaFfUH6OS3nlAPRGdmAAcQMBI0O0vB1j8eWLMxXEb42DvRGxkTtUfETAIGDxb+8UZTXVv5ffY8CMgtPWRb4sFEnb46yO1oY5qrUFD3LNmaQLKPXhLZFwl5IknFbK49FoiHpwS7rK7DCAJ6gcUGqh+qjAWppTz+6nS7EtIFIioaSEpRAdDSUDbkUgC/kgxzGeJLbvRkKAAu6xhJCKlfONvVxoeMOjBSLMN04cRbJnx9P7dhSs+nz3sHcL7YRNYaUAndBIZliwh8XM93TO1WuPJqgxEXs383Z0/Lst+HKN/YR8jocirQqNmhkL4IgW3Bxols/HLALecvKD++qLzKHRAJWm4XL1WTTS2LSt/meeYeMurfrQZBDigecolmr4FBXFKbMIRuU4
X-MS-Exchange-AntiSpam-MessageData: MCxaMz4pQ7ADEqiwaNEhRZmQpTclwKG+RvnXs9S/U/a2QOa5zv+DQ7XeIz9HGVBiLb+IUGtl8T5CWbayRwCccesPhADCG6vxckP3eCZpJKGMnKdt3Mmc2JLHA99T9gov53+/8/RqQ1dMr/BZPGLpXy7Htsal/LOANUR1RHUnQXc=
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97e134a3-99b4-40a6-4fb6-08d7cb27472e
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2020 10:29:45.6294 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vlEnrpzcYccHMI6E5z/Tq6dx13//GFRSo6iNPjkCk9p6bVRe/GhhnvRO5Fs1cHvzdK6GOeJuxFcezpkJV/ye0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR05MB6053
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200318_032949_762708_C948992F 
X-CRM114-Status: GOOD (  19.05  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: loberman@redhat.com, bvanassche@acm.org, vladimirk@mellanox.com,
 shlomin@mellanox.com, linux-rdma@vger.kernel.org,
 linux-nvme@lists.infradead.org, idanb@mellanox.com, dledford@redhat.com,
 jgg@mellanox.com, oren@mellanox.com, kbusch@kernel.org, hch@lst.de,
 sagi@grimberg.me
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Wed, Mar 18, 2020 at 11:46:19AM +0200, Max Gurtovoy wrote:
>
> On 3/18/2020 8:47 AM, Leon Romanovsky wrote:
> > On Tue, Mar 17, 2020 at 06:37:57PM +0200, Max Gurtovoy wrote:
> > > On 3/17/2020 3:55 PM, Leon Romanovsky wrote:
> > > > On Tue, Mar 17, 2020 at 03:40:26PM +0200, Max Gurtovoy wrote:
> > > > > ULP's can use this API to create/destroy SRQ's with the same
> > > > > characteristics for implementing a logic that aimed to save resources
> > > > > without significant performance penalty (e.g. create SRQ per completion
> > > > > vector and use shared receive buffers for multiple controllers of the
> > > > > ULP).
> > > > >
> > > > > Signed-off-by: Max Gurtovoy <maxg@mellanox.com>
> > > > > ---
> > > > >    drivers/infiniband/core/Makefile  |  2 +-
> > > > >    drivers/infiniband/core/srq_set.c | 78 +++++++++++++++++++++++++++++++++++++++
> > > > >    drivers/infiniband/core/verbs.c   |  4 ++
> > > > >    include/rdma/ib_verbs.h           |  5 +++
> > > > >    include/rdma/srq_set.h            | 18 +++++++++
> > > > >    5 files changed, 106 insertions(+), 1 deletion(-)
> > > > >    create mode 100644 drivers/infiniband/core/srq_set.c
> > > > >    create mode 100644 include/rdma/srq_set.h
> > > > >
> > > > > diff --git a/drivers/infiniband/core/Makefile b/drivers/infiniband/core/Makefile
> > > > > index d1b14887..1d3eaec 100644
> > > > > --- a/drivers/infiniband/core/Makefile
> > > > > +++ b/drivers/infiniband/core/Makefile
> > > > > @@ -12,7 +12,7 @@ ib_core-y :=			packer.o ud_header.o verbs.o cq.o rw.o sysfs.o \
> > > > >    				roce_gid_mgmt.o mr_pool.o addr.o sa_query.o \
> > > > >    				multicast.o mad.o smi.o agent.o mad_rmpp.o \
> > > > >    				nldev.o restrack.o counters.o ib_core_uverbs.o \
> > > > > -				trace.o
> > > > > +				trace.o srq_set.o
> > > > Why did you call it "srq_set.c" and not "srq.c"?
> > > because it's not a SRQ API but SRQ-set API.
> > I would say that it is SRQ-pool and not SRQ-set API.
>
> If you have some other idea for an API, please share with us.
>
> I've created this API in core layer to make the life of the ULPs easier and
> we can see that it's very easy to add this feature to ULPs and get a big
> benefit of it.

No one here said against the feature, but tried to understand the
rationale behind name *_set and why you decided to use "set" term
and not "pool", like was done for MR pool.

So my suggestion is to name file as srq_pool.c and use rdma_srq_poll_*()
function names.

Thanks

>
> >
> > Thanks

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
