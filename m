Return-Path: <SRS0=yQ2W=6E=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD210C3815B
	for <linux-nvme@archiver.kernel.org>; Mon, 20 Apr 2020 13:39:03 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9CC6A20857
	for <linux-nvme@archiver.kernel.org>; Mon, 20 Apr 2020 13:39:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="PxOTo0Sw";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="OPIUq1wp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CC6A20857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=FL9JDgrif8LEN6iF5DgQ7DEtoVolJXYzkORa5PYQWC8=; b=PxOTo0Sw/oeAHQ
	oISrWCr4/8G4f8Hc5+Qcqs5IvlAlnnd4mxpdmbCWgI02c0B6tW39L+Y+7iNIP4hlyAi2j3O3oEWEB
	nPiwCAXxWo5WgR6gJcLgFvAt1ERt7Yd3CbmSoZVJdjIFCCQIyP+Xn9I1LZ9mz41C2lzNk6JpW7aB/
	geFrjDD4r0IRPbEqDwzOdf+IP0nyDqunHPwypvBY5+BfMNqQSxc48g8rKNMzhRcJUJ4LryS2BcHoi
	6BJuGEuvtkoU1jdif0/vWpL9llPkntAuZ428+FhuLYENYh8RBPudVZYbclg48d7WU6w5XtqJnwODy
	sBXmhuqvYJ1NT4lSH6/A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jQWdS-0004Z8-SO; Mon, 20 Apr 2020 13:38:54 +0000
Received: from mail-eopbgr20065.outbound.protection.outlook.com ([40.107.2.65]
 helo=EUR02-VE1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jQWav-0001JK-Ua
 for linux-nvme@lists.infradead.org; Mon, 20 Apr 2020 13:36:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Iura5vkVbMH03LdyBXKq8kFUuGJdA7K2pQkw/ZhPMJsMbHKDHElHeu++TQiKicY5p86/Vks9zsFs7hyxLzx63x+OO5noXh4+l+JSYthxD95jk5d+dxwfnhvBsvJMM5dTsjXDoEo/VYPXHjszJ8ngan2I4nnAEnvA4oIvdS8YPC7I4NLCMCZGKEL3HcfmVR62RyIYRmJud1MbeepN8k3R8M7uqJSW1zzyYOt/CM4xvOb5qGoq5mCOiOEr+saCGd4LoEE1TXJCfSX6MtgZ7s6iJu43SVkEyWUrnBCcsTbSd9Ew7ZTvbwZrpMFDWsecbrvU/5lWcBNtZfT/pCAjKbDjSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gGNCD4qjTfkp0JwbP3TeB+wDtVy35k2UTDEasETrYw8=;
 b=jEhmsud3MNeYxf7PROpdetMBVYM+olOuURjrfF7pNQ8QbHGdG8jtYpZVHO6gK0iMoVNCj1Q4WOxxnkl4dopQ+yyfnKt2dot6BszEd7uPqGAYSMCv1sZMtugK1QORzh8k3WoZ5HJAi6NlMAhKq69EzqYUjgnkdID5SK/NhwSL1XxWwtWTs5vvVMYuQhJT9ypmg/wKYzvSSU5VhkLLHG+J/tqArFh+Bsw1oInoV9gHvtQHKbMlhpBW2czzF3LP2//OS78hXaQfVQK91ph1TNeEhBqh376oaJn/0JuiaFEiBjdyh02JjsIwp9uYscjL+yoU8BRDTq55Qpvoi6eQQpeZxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gGNCD4qjTfkp0JwbP3TeB+wDtVy35k2UTDEasETrYw8=;
 b=OPIUq1wpMVQeIyKFMM8HcFgDwrTj3b9XrIfnI6RZ7rj2jN4bSnQDtOj0118BKCkQ4N9Cbz1XH6xxbu0K9PoAc/3UK4YgXophjRaiNv75JJHTXsXgLu1BjGX0zUm8UWx2jGL/MwUn9TcPMznTswt2sMzDGA8b1nxTKMEO10ooCbs=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=leonro@mellanox.com; 
Received: from AM6PR05MB6408.eurprd05.prod.outlook.com (2603:10a6:20b:b8::23)
 by AM6PR05MB4808.eurprd05.prod.outlook.com (2603:10a6:20b:f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.29; Mon, 20 Apr
 2020 13:36:10 +0000
Received: from AM6PR05MB6408.eurprd05.prod.outlook.com
 ([fe80::1466:c39b:c016:3301]) by AM6PR05MB6408.eurprd05.prod.outlook.com
 ([fe80::1466:c39b:c016:3301%4]) with mapi id 15.20.2921.030; Mon, 20 Apr 2020
 13:36:10 +0000
Date: Mon, 20 Apr 2020 16:36:07 +0300
From: Leon Romanovsky <leonro@mellanox.com>
To: Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@mellanox.com>
Subject: Re: [PATCH rdma-next v2 0/7] Add Enhanced Connection Established (ECE)
Message-ID: <20200420133607.GD121146@unreal>
References: <20200413141538.935574-1-leon@kernel.org>
Content-Disposition: inline
In-Reply-To: <20200413141538.935574-1-leon@kernel.org>
X-ClientProxiedBy: AM4PR0202CA0003.eurprd02.prod.outlook.com
 (2603:10a6:200:89::13) To AM6PR05MB6408.eurprd05.prod.outlook.com
 (2603:10a6:20b:b8::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost (2a00:a040:183:2d::a43) by
 AM4PR0202CA0003.eurprd02.prod.outlook.com (2603:10a6:200:89::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.26 via Frontend
 Transport; Mon, 20 Apr 2020 13:36:10 +0000
X-Originating-IP: [2a00:a040:183:2d::a43]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: c6af76cb-dc96-47d8-42b7-08d7e52fc98d
X-MS-TrafficTypeDiagnostic: AM6PR05MB4808:|AM6PR05MB4808:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR05MB4808F309E1722C3B8B31B692B0D40@AM6PR05MB4808.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 03793408BA
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM6PR05MB6408.eurprd05.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(7916004)(4636009)(366004)(52116002)(5660300002)(9686003)(33656002)(66476007)(66556008)(6636002)(54906003)(66946007)(2906002)(7416002)(4326008)(6486002)(110136005)(6666004)(498600001)(8936002)(8676002)(81156014)(6496006)(966005)(86362001)(186003)(1076003)(16526019)(33716001);
 DIR:OUT; SFP:1101; 
Received-SPF: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IVnxZVHgp7XU2ouhlePyLgMQO885hkrwbJG2SBzF6+QC42ucs2eb2m44csy+NfRqkvIaQ04/Jds1+7GjIviQNGJlf4Sq7yrc1VFd1a/MOEwF36N4va3wxwYQ/1V8bu00ky+pSBxLcOSruGvNImMq3Q8u10uspAqYIiAoS4Eiscc1BFz9EqfH9bK6SMVOEXnlyoq8VobwxYOiuHWy7HHZlscgkiB0oJd+NeQVrkidfmLV4eLbXY/A578pKsSpw1LrT4tlR94zHyHHwii4J/v8X/aZRTO7W9wH7FEg8AMeTVFTqHRqm9ewq1WPut0NVafrf16t2U9GnvZdK00+1T0IFxbGuCwIDxniCMK88AamOkYGCPQpP1eQvN/Jkul7+osVukc2XV3ZjqvhdJ8Wu5OYhagahOpUA0PeCwF6LzjYGCfCa3fnWZWj7ZBshUGQbKRtEPp4aEXcETrkj3mPx74/+7hjmzU3Z5LYcn1/taAEodZDScYaFHJQi3Tw71AkhV2wXvfj5lrmwDzm7SHd8yOnnw==
X-MS-Exchange-AntiSpam-MessageData: f6lSVV8SHc77YCs4gXCEooUYWMuG8HPkrmvh07t5Kc2mkDgUwGq4MO1/Yri7jV61y9l8OG75MLZ+EBOAbsScA1l2BLFjAs0eYfLUhA/xanv0utRgb+XfIQhGCawfKadvXBJz98R6DsdvKiPStDPkOCTw3f+DamiIFVfnkSoYWbQ=
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6af76cb-dc96-47d8-42b7-08d7e52fc98d
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2020 13:36:10.5745 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2O0UApw/z6QB4VTepkJV7qek7q5tNoT4ybOZn9Rfhq27pmQ0T60z5LYzRFGYjS42ec2k8P4DVcsPgOqDuryAtw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR05MB4808
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200420_063618_247804_38F6CA76 
X-CRM114-Status: GOOD (  10.62  )
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
Cc: rds-devel@oss.oracle.com, Bart Van Assche <bvanassche@acm.org>,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>, linux-rdma@vger.kernel.org,
 netdev@vger.kernel.org, Santosh Shilimkar <santosh.shilimkar@oracle.com>,
 linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
 target-devel@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Sagi Grimberg <sagi@grimberg.me>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Mon, Apr 13, 2020 at 05:15:31PM +0300, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@mellanox.com>
>
> Changelog:
>  v2:
>  * Rebased on latest rdma-next and removed already accepted patches.
>  * Updated all rdma_reject in-kernel users to provide reject reason.
>  v1: Dropped field_avail patch in favor of mass conversion to use function
>      which already exists in the kernel code.
>  https://lore.kernel.org/lkml/20200310091438.248429-1-leon@kernel.org
>  v0: https://lore.kernel.org/lkml/20200305150105.207959-1-leon@kernel.org
>
> Enhanced Connection Established or ECE is new negotiation scheme
> introduced in IBTA v1.4 to exchange extra information about nodes
> capabilities and later negotiate them at the connection establishment
> phase.
>
> The RDMA-CM messages (REQ, REP, SIDR_REQ and SIDR_REP) were extended
> to carry two fields, one new and another gained new functionality:
>  * VendorID is a new field that indicates that common subset of vendor
>    option bits are supported as indicated by that VendorID.
>  * AttributeModifier already exists, but overloaded to indicate which
>    vendor options are supported by this VendorID.
>
> This is kernel part of such functionality which is responsible to get data
> from librdmacm and properly create and handle RDMA-CM messages.
>
> Thanks
>
> Leon Romanovsky (7):
>   RDMA/cm: Add Enhanced Connection Establishment (ECE) bits
>   RDMA/uapi: Add ECE definitions to UCMA
>   RDMA/ucma: Extend ucma_connect to receive ECE parameters
>   RDMA/ucma: Deliver ECE parameters through UCMA events
>   RDMA/cm: Send and receive ECE parameter over the wire
>   RDMA/cma: Connect ECE to rdma_accept
>   RDMA/cma: Provide ECE reject reason

PR: https://github.com/linux-rdma/rdma-core/pull/745

Thanks

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
