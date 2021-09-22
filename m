Return-Path: <SRS0=1D85=OM=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1063C433F5
	for <linux-nvme@archiver.kernel.org>; Wed, 22 Sep 2021 12:10:53 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5BABD6115A
	for <linux-nvme@archiver.kernel.org>; Wed, 22 Sep 2021 12:10:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 5BABD6115A
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=hL1ucoCSlCHuDVbUpz4vUULL2iCn9/N9PbzbSXSGzfs=; b=QkFtOxiQy2jVun
	l6Mfe/4X4XmX7NyqtSWSRwWhr4mwOMAEVGkwgDo91HuqfzxZeMQ8WhkMnoVdUVV9X9uQryR7V1HTs
	iR8FdSqMJLUDaqndf2yKu9DJbDktCL4ZmDJJSHuzjcmAPtQoz0QL1PBwXH1+2ovJjTNkPBWUXWKoG
	9ORUH/gOk2LldAOhv2oQPgZ8MnVzoo5XFveDy3/Bbyj+tQv5KMywqLnORdArcx04D4Zbci3XdNv5m
	dA2cyFxWlEr1eDLckW7K44Sake0xD+I9Re0Ehro9IiRfShIsLgB4/1wadOebNwxF5lmCJVOPE6rEI
	+M0+AglglXr7SlobGL0Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mT14z-008MS6-KT; Wed, 22 Sep 2021 12:10:25 +0000
Received: from mail-co1nam11on2066.outbound.protection.outlook.com
 ([40.107.220.66] helo=NAM11-CO1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mT14u-008MQk-Ht
 for linux-nvme@lists.infradead.org; Wed, 22 Sep 2021 12:10:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WfLzd6xHJWcF570wivRCglVGHhqJZl/9JUXP4AxmOcagjbPzGp5IQWWhk4Ffvr2yKqrb0YGGHGHXC5k1725x7ROov1SVLzWQk3MM2qF/fYQIOuAC9gCZRSaivC0I6QSfAG8URNMsvxh1AFpC+6tPV00FOuoD4JDfUbsHATS9Ifh1kDFx40ERGNVzlARrrlqobBJ89shVyaKikhOZ2nQrfsqVAXa3HuzXRnEEOrKy98P0aoYk0ADriN/Ov697/NCIrw1bfobfLcG+qAtsNjDjGF9t6q1zErNLhGZL1OGsXhMy6MPgmRrxa9GlynC8OQN8IwhWkSA2LIjvWmz+nYJqUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=TmMUnMrD3WVe/v6yd9/HvM+FM95kt+ZXPBkh6daolDw=;
 b=F6i4oEdq1ZyotVWCkv8p0XZkbotuxBHs42jWXMMtfRnKzqwzNTpmfX00ZKywxOeDF9X09urJTiLUIOw/Gs3S/7EN2xypVn2QobetEVI2MTxBLmbJpbZsfbnmZEyq2AGrxeFI5lvri2QMtMGXXObxkUllPRynpCNWhdfMVYHBB+W0jN7PWmJaM22K90U3Q7HV51w1fxUSyYxX7Mlh3Chlmlaj9BEv463d5oWeQ6oBsy2AGrfpA2lpLdQMAsWRIEEoMXz0WzsjL34NoVf+csNMtSYRnhTL9WkGTk1VK8HgrK3ELnvavjN4FGNwQ5V12Zo4XN9bjgVHiu1KkFIgZgsS9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TmMUnMrD3WVe/v6yd9/HvM+FM95kt+ZXPBkh6daolDw=;
 b=HJT4obnrosyk9G5sqq/GjxtjEOZDT5112/5mJgsc4WNPxRkF5lheZ5JjNLVwMGDdjJzabnxStqZkP9kyHNJKGDmhPUg6pZZfSLLVa/r1ZEuwMOpLO0fhZ9Pj1UPzagNMoitck5ciRuDinbEWGVytoi/uUpVYCa0+F19txRsOuRoMdnhPyrsXlB9F3loaZg4jla7kHrehQCgC8Tx4X1qAIglDju+BMHEBMIgFk0HOJ856xPnAu/c+KbX9bTjshqB/jGizxujDa6EX1Gb9IWmoR2LN9/vBkXlq/cHXLV5FORx+7/cfuqe5rfTqHVav6cV/pQIf9m+/WR4H7cdMAbbc7A==
Authentication-Results: grimberg.me; dkim=none (message not signed)
 header.d=none;grimberg.me; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5224.namprd12.prod.outlook.com (2603:10b6:208:319::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14; Wed, 22 Sep
 2021 12:10:16 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::e8af:232:915e:2f95]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::e8af:232:915e:2f95%8]) with mapi id 15.20.4544.013; Wed, 22 Sep 2021
 12:10:16 +0000
Date: Wed, 22 Sep 2021 09:10:14 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Max Gurtovoy <mgurtovoy@nvidia.com>, Christoph Hellwig <hch@lst.de>,
 linux-nvme@lists.infradead.org, kbusch@kernel.org,
 chaitanyak@nvidia.com, israelr@nvidia.com, mruijter@primelogic.nl,
 oren@nvidia.com, nitzanc@nvidia.com
Subject: Re: [PATCH 2/2] nvmet-rdma: implement get_queue_size controller op
Message-ID: <20210922121014.GF327412@nvidia.com>
References: <20210921190445.6974-1-mgurtovoy@nvidia.com>
 <20210921190445.6974-3-mgurtovoy@nvidia.com>
 <0b93503b-93c6-6314-939a-34bd69c30113@grimberg.me>
 <300d5661-c22c-bb8f-e5c3-38902dd946a0@nvidia.com>
 <20210922074550.GA16099@lst.de>
 <01762668-1572-9f37-73e8-714d4ff23323@nvidia.com>
 <6df58d37-0519-9e97-bae5-a529084c8341@grimberg.me>
Content-Disposition: inline
In-Reply-To: <6df58d37-0519-9e97-bae5-a529084c8341@grimberg.me>
X-ClientProxiedBy: MN2PR22CA0007.namprd22.prod.outlook.com
 (2603:10b6:208:238::12) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
Received: from mlx.ziepe.ca (142.162.113.129) by
 MN2PR22CA0007.namprd22.prod.outlook.com (2603:10b6:208:238::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.15 via Frontend
 Transport; Wed, 22 Sep 2021 12:10:15 +0000
Received: from jgg by mlx with local (Exim 4.94)	(envelope-from
 <jgg@nvidia.com>)	id 1mT14o-003wKl-Nh; Wed, 22 Sep 2021 09:10:14 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6e73a9f1-51a6-4289-20bb-08d97dc1f009
X-MS-TrafficTypeDiagnostic: BL1PR12MB5224:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL1PR12MB522489862E11FEE286496E5AC2A29@BL1PR12MB5224.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: F4ch429rDAYLcXNGluP6Z5XAk3LDqT2FT/KrYnCJZSz3sEvd9dF8SN3z9we9eXBuaqtUrw9Uotm8uigON+CsAW+sGKXqGa/giq1akvTqbCfrNT8iIpIHhk2CWD2353lNiTwR77hyFN2Z2mrX6bwhkWm5IBBCT5hSc77o70Jlzd3mdzXrV0OMaWSJd68T3tcl7TaJVbt5P5VHdTZMuw42lX9/6nenOCHi6nNgd+BGwW5lDI7cvea7+RYvUStjf+xs9xMawq3TwWIqB6Mz92O6JxoZGUyZvEYjuGbuq2ljm+TljvMvEw54mVYaaBpDnsFvtuOiYLBh9Ffp9BAVaEEOFeJOkzOSSts/HGuq3FL0sieSYAipi2mz7rNKCwiALptzy7JOaxGc6g0/qy3x5kJUmJfWJfjAzWIMZc6ZY27mS2TZIl6Bq5fs8584rK5ZhT7V0ViaaWd9AAFiau7WIlXkB9BUa0Y/gm/4dueeLj+Alpp0U8ZfUqOpkXSNVJlnnsyS+48hJIWiOE4xeEE5OMprzAWpHVZXVC3o/DHjSGs0aQ8wdh9gLH2Zlbjq23qjnHgk97kvHmrmonoUnLzJTc6gSYZXNQiPq9mA4Q/bY2/JFkJ5whJAsk9gSKRsgGMOEgqp2/VcTpSoTFzHpDFPl5LWamUrSO96FLAjMtHbdcjmxuAev0u6GP0hO9Jrpz4LQnZK
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB5506.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(1076003)(66946007)(66556008)(36756003)(54906003)(316002)(66476007)(9786002)(9746002)(186003)(83380400001)(4326008)(26005)(2616005)(8676002)(8936002)(426003)(107886003)(38100700002)(2906002)(6916009)(5660300002)(86362001)(508600001)(33656002)(27376004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FhrYVBqa4Z3sy+deF6BErlEp6GETxWLF9LwXhAWj6Qf7d90quxcUXdcFOQTi?=
 =?us-ascii?Q?Q7dk1CFNiBvNKyjUU9uk8RajySRO0Oz31Hm+PGBhDRz4wOLZRCT4zxrVnH7s?=
 =?us-ascii?Q?g6IaQOfGbAfaE9Iji4iHpxxdzX8UT69dRw2CeguM04Za1Ts14raIVpr2WQo8?=
 =?us-ascii?Q?w5u8bDAfBYsEwqEw5A1x+ortnzQTWrgjz+yrO6yNsVIrTVu8HvSZOISRrRP7?=
 =?us-ascii?Q?sg8qgEoQ4XhRNBuD2xwdmX6j6moRA5fAIXhRYFP4SXR2km6LO9blL9ZJTSAY?=
 =?us-ascii?Q?3WpjVno52O6tN1VeMxSbiwV4PwKznpjTf502VglPI48GEKrfl1wvL8ZMFf0V?=
 =?us-ascii?Q?hSAa7EXj+WTVFgDL5brBctSe0V03z3YaE82JUhH4ndAHKCErCv2LXMrwooiW?=
 =?us-ascii?Q?5/qW4y9KK6B810YBwdQUJF5tDrwwJFFJqcwToLKh0uQAaeqBjtvTLS/iTU6Y?=
 =?us-ascii?Q?52sJIHaVwBcvKS2KQEwKhzjSdl50KZtvYEaHU3Wk/GPs+dYDSvWhZrGzUyvR?=
 =?us-ascii?Q?iQkypIdAs1if8F5PQOQGCw4VOr7d2klql7Xr5kennguZS/BwHFOgj8oFho9m?=
 =?us-ascii?Q?fMzS3e4pY3C6+sDh0aZ3eiSaQwgoGsSsGeTMZ2aCGqw+++RUA4ZA7h1fnT7w?=
 =?us-ascii?Q?oXg8/lfFwFQiMYgRnc7pNMVbwn9X/u8S2Zc///e0M5p6eiHgpnKw7W/tFF71?=
 =?us-ascii?Q?Uu1cvZGBEMVDdODcoiJ7c/uuQ1zEOE3Y2+r2Ls0uW3kWLJgkMzzI1iDzMQ1V?=
 =?us-ascii?Q?G/OgUtqEL6XyamdwamD04BxIj8j9lQrqdpXLiJAEWOAGBAVITqshokT4P0Cd?=
 =?us-ascii?Q?ozpPJi/cTBiaOpwsgOTjUCTQa2Ggp3ASYJMQ0nbSTFvgGWKNo/GbGfG2PvUJ?=
 =?us-ascii?Q?2h+YiYfsbTU4NXMELqeEC7CPiKSJyjX1/y/dHCKaqv3/Be2SkLKnZDwQc+0b?=
 =?us-ascii?Q?zMI+jmmnL0ObGDUkprAyYndJpYJ1rgGNkjaqSalAIA5k0YKNmA9z+Xt9Vwf3?=
 =?us-ascii?Q?JPwC/3GcePB6JzuHozO5cMoU75GY5iK+WH+k7RMNCNAvkD2yWNNyXqdjzAKO?=
 =?us-ascii?Q?8mdiKBeJlCR4sYtzO0tuVr2S8OeNLiY8YnQZK4aOzCyFyNsrPI7jflJQVdcC?=
 =?us-ascii?Q?3EtENuaPHFS7BhoD72fEbF8ohYdiDYDxArnOHBJBQCPt4ZUcH7cc4AZSKDBR?=
 =?us-ascii?Q?ShXxv3goWD2yIi9mSqvwc2M3b46UHpX23TBil1km52DKB3c5nwbCzlNAbzXx?=
 =?us-ascii?Q?qVGXC4+n6et8KBq3HGYuNgw5l5MOS9h6lDvQiA8TUuHIUdGAfb2InE3869cE?=
 =?us-ascii?Q?T1rqof9V7TLdZLORvEnft+Iq?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e73a9f1-51a6-4289-20bb-08d97dc1f009
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2021 12:10:16.2719 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Rnplw8Ho5HD5Jm3uOHCczNSNuSdYgXrdefQa7JGqEQZTL3dN7XBPijoDeoUgDt9V
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5224
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210922_051020_695803_74B124E1 
X-CRM114-Status: GOOD (  19.01  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Wed, Sep 22, 2021 at 12:18:15PM +0300, Sagi Grimberg wrote:

> Can't you do this in rdmw_rw? all of the users of it will need the
> exact same value right?

No, it depends on what ops the user is going to use.
 
> > is it necessary for this submission or can we live with 128 depth for
> > now ? with and without new ib_ API the queue depth will be in these
> > sizes.
> 
> I am not sure I see the entire complexity. Even if this calc is not
> accurate, you are already proposing to hard-code it to 128, so you
> can do this to account for the boundaries there.

As I understood it the 128 is to match what the initiator hardcodes
its limit to - both sides have the same basic problem with allocating
the RDMA QP, they just had different hard coded limits. Due to this we
know that 128 is OK for all RDMA HW as the initiator has proven it
already.

For a stable fix to the interop problem this is a good approach.

If someone wants to add all sorts of complexity to try and figure out
the actual device specific limit then they should probably also show
that there is a performance win (or at least not a loss) to increasing
this number further..

Jason

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
