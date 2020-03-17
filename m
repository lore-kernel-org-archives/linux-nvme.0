Return-Path: <SRS0=JSXe=5C=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84151C1975A
	for <linux-nvme@archiver.kernel.org>; Tue, 17 Mar 2020 19:54:31 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5681120714
	for <linux-nvme@archiver.kernel.org>; Tue, 17 Mar 2020 19:54:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ePQjvp5h";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="dINjBBrT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5681120714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=eevvYZ09AH/m0uIU0OHyQTdI6OspoHIpI3yR6Dxz6Fc=; b=ePQjvp5hSjMxhj
	/JFgQINHvCrByw8iR2fQry64u9iZR62IZeQsY6eCARD7KKF+F6kB9M9RC2Cj5Xyc8AzQmYHDZabmi
	DEFM/PizCMkAubQ0D4umUBW/c4WSL9znGjwVx6fnCNMjsvdZjnZl0Prdk0921r+Bl/375ql59/0+n
	b+PMVeXZyy3hnmybP/lGF+ERl/xJcPf8UPcTQhlckrMsMDQcD2ezi3mEvEgYhS6r/kl4F3WsELx4U
	+C2oG3n9VfYR1NDPTkeoxreRGNtfZSuzzWx11UFckP2oMsDTXYs+9CPIJkNzB4HxbECAYCyl0N4mx
	DJOb3QtclecbuZIFVpYg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jEIIG-0003cT-Kf; Tue, 17 Mar 2020 19:54:28 +0000
Received: from mail-eopbgr60069.outbound.protection.outlook.com ([40.107.6.69]
 helo=EUR04-DB3-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jEIID-0003bj-Vz
 for linux-nvme@lists.infradead.org; Tue, 17 Mar 2020 19:54:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bw/gAzwe4vgRkK+/1yf5KzeGVVtDDfK027c2X0tS0MvDKwQvBucVp1NOq2u4XrOyu4/a0BKpzSp3eaOkaECakJrtOM0hz2BBHwsFqARNvDtFQFLij0BkAjqAEYM7km4BcG8cStBXFxMU6MSJxwkPo2gzk9+Aw8ilOYQVkZ085wlJCjf5fzmyNGyLsxXm6kxEMHgukjx7ZNH8dsXUPcz4e06RfYlXZyK/j/raxYbpMNKMs8zyf4RkIj6bvxVGCToDDlTuG+22f282o0fhFIDqL2M+CusUlbzEKp1y2btfdoivIoyxIoktRUvgLPnHGeW5bdAjbRjIY6FWUmeJDv28FA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2mcfG8F5k1CWsKjuryRTKFitzLrtRq9s1b/GPSBMRFY=;
 b=UTHtuGVCCo0HkgdvQvNq/uU1GftZGAx1yxVikWnLU1ncSDc3L+o2l15xDz6+XR3wxHLUYTr9M3w/iiaNkjDnE22bOGUReo2iS+RxD86jddu/cjSa7uXCgG9B3mQ816OJr+2LEDpsBj1OCFv5VNbTXlgJDJ7JwLbkM+WXRCyKIZCPY2Dh3AqhgEQVf76leDFJPa6Xs4cjRw00gXkPBCsUptEeYdWRcGH0pNSNO0ZN7gjW9amJW3ZS5fBZ8BaHbClIff780XsbSIV0NUXDjZc5YeADSVCmZV82f86DSmH5tXtIBPEkhTsvs4WH8WCjGBXHm9UAFtMcpCxiRxZtp2UHrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2mcfG8F5k1CWsKjuryRTKFitzLrtRq9s1b/GPSBMRFY=;
 b=dINjBBrTnT/QhOvXZnzMT/KFuXQXRccBsEQbMkG9R1pa9ghW5lnlGhOFFPzqavcjughxwqFRBVXPnFRuWwSj1JgArtTbBtYGaSFpiEqA5HdlYkyWdgVHVjAprlUyN5xol9M0zzKzZ9rw4IObJBrHUsDuxPzelt7JriQaM8/bxWc=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=leonro@mellanox.com; 
Received: from AM6PR05MB6408.eurprd05.prod.outlook.com (20.179.5.215) by
 AM6PR05MB6149.eurprd05.prod.outlook.com (20.178.94.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2814.19; Tue, 17 Mar 2020 19:54:21 +0000
Received: from AM6PR05MB6408.eurprd05.prod.outlook.com
 ([fe80::c99f:9130:561f:dea0]) by AM6PR05MB6408.eurprd05.prod.outlook.com
 ([fe80::c99f:9130:561f:dea0%3]) with mapi id 15.20.2814.021; Tue, 17 Mar 2020
 19:54:21 +0000
Date: Tue, 17 Mar 2020 21:54:17 +0200
From: Leon Romanovsky <leonro@mellanox.com>
To: Jason Gunthorpe <jgg@mellanox.com>
Subject: Re: [PATCH 1/5] IB/core: add a simple SRQ set per PD
Message-ID: <20200317195417.GK3351@unreal>
References: <20200317134030.152833-1-maxg@mellanox.com>
 <20200317134030.152833-2-maxg@mellanox.com>
 <20200317135518.GG3351@unreal>
 <46bb23ed-2941-2eaa-511a-3d0f3b09a9ed@mellanox.com>
 <20200317181036.GX13183@mellanox.com>
Content-Disposition: inline
In-Reply-To: <20200317181036.GX13183@mellanox.com>
X-ClientProxiedBy: ZR0P278CA0053.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:1d::22) To AM6PR05MB6408.eurprd05.prod.outlook.com
 (2603:10a6:20b:b8::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost (2a00:a040:183:2d::393) by
 ZR0P278CA0053.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:1d::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2814.18 via Frontend Transport; Tue, 17 Mar 2020 19:54:21 +0000
X-Originating-IP: [2a00:a040:183:2d::393]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: eddd1e65-7681-43be-0aa5-08d7caacfc68
X-MS-TrafficTypeDiagnostic: AM6PR05MB6149:|AM6PR05MB6149:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR05MB614912E5345AF13083E696D1B0F60@AM6PR05MB6149.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 0345CFD558
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(7916004)(346002)(366004)(396003)(376002)(136003)(39860400002)(199004)(33716001)(33656002)(86362001)(2906002)(66946007)(66476007)(66556008)(5660300002)(478600001)(186003)(8936002)(16526019)(6862004)(6666004)(4326008)(107886003)(9686003)(4744005)(52116002)(6486002)(316002)(1076003)(6496006)(8676002)(81166006)(6636002)(81156014);
 DIR:OUT; SFP:1101; SCL:1; SRVR:AM6PR05MB6149;
 H:AM6PR05MB6408.eurprd05.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; 
Received-SPF: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 08o+tNZrY8FeZ9eYKRgy3evY0bMd2kyIt4GUBaO685VbAtP93AEbkppklMH/7cYla2JjN8p2B8yzl92MUtOp4CrShJHvHWAkbZhPRMFLoymQIj3UcjGzMFT1iUxftO35XbXB2wCTtX/V2lY0yTxDkGTouWJs92zNzkhPHE57Yf0E696kImwk6coZ219fkoTZ4XvUeRXVFXIhD2c76OSyh0MgbNhYfWa/rEo2xVbEDVhIZb9fgXL1gHzcA+EXhiuwVZHtjD1xQRTtIh89pRPk5yEe/CPMQFcu9hkVJHYZNkb+1IH5mbZo1sBc5ivhK7YM0mPHIL6vdD5Nu8+IycdhC/UKSNKSQUKabDchbpnEIyMbkJFB7Dpl+Tj8/IOQmidRmLWN5w75dn6DgR5jhctSnfkY9LfvNRa6h5PyG1xdDqCkGtZTdp6tVdUQ6MYa8Pzo
X-MS-Exchange-AntiSpam-MessageData: fTlqLD1qMjpqlO0KmCIcpfT4+HxA/09CWoHk1Blioe1UngBEKbzT+DjJR0TS6NW83pWlPqacqtCc9j9x7ZoOkKCebwxfJTfPXMKyc/z3gpJ7jZEgmrPcEH5xEs5fgEpGrVIegmbFn0tCS5Am7PtH3xLAFn52sWl1ZYiH4PkT9Ak=
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eddd1e65-7681-43be-0aa5-08d7caacfc68
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2020 19:54:21.6295 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BbtTwdKcvJDrkay57bY+FqYSV4GIYpyQZ5yCLstCY20P6irFuZMARkt56seu5enx6H+LYO9WXJQHI7uOjP0n2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR05MB6149
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200317_125426_032451_5E04E5AE 
X-CRM114-Status: UNSURE (   9.41  )
X-CRM114-Notice: Please train this message.
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
 oren@mellanox.com, kbusch@kernel.org, Max Gurtovoy <maxg@mellanox.com>,
 hch@lst.de, sagi@grimberg.me
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Tue, Mar 17, 2020 at 03:10:36PM -0300, Jason Gunthorpe wrote:
> On Tue, Mar 17, 2020 at 06:37:57PM +0200, Max Gurtovoy wrote:
>
> > > > +#include <rdma/ib_verbs.h>
> > > > +
> > > > +struct ib_srq *rdma_srq_get(struct ib_pd *pd);
> > > > +void rdma_srq_put(struct ib_pd *pd, struct ib_srq *srq);
> > > At the end, it is not get/put semantics but more add/remove.
> >
> > srq = rdma_srq_add ?
> >
> > rdma_srq_remove(pd, srq) ?
> >
> > Doesn't seems right to me.
> >
> > Lets make it simple. For asking a SRQ from the PD set lets use rdma_srq_get
> > and returning to we'll use rdma_srq_put.
>
> Is there reference couting here? get/put should be restricted to
> refcounting APIs, IMHO.

No, there is no refcounting, Max introduced some counter which he
decrease and increase, but doesn't have any other usage of it, simply
burning CPU cycles.

Thanks

>
> Jason

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
