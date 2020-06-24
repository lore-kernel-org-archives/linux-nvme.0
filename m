Return-Path: <SRS0=WpAz=AF=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ADE9C433E0
	for <linux-nvme@archiver.kernel.org>; Wed, 24 Jun 2020 14:23:14 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CC54C2072E
	for <linux-nvme@archiver.kernel.org>; Wed, 24 Jun 2020 14:23:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="SXGUyxyB";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="pu3ex44u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC54C2072E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=lyxgF601dEgyLc3znW5iEYGmO4x2CHGaO5wBFR9ZBGw=; b=SXGUyxyBMseQZUY3/VrAicEvb
	fMUqgr4UG9iKCuflpIcEXRxdib0R22tE1uWHVaf5S+haul9EWBRYIrK5J5RgEUxM85xdO9cH0mnDs
	U3UR632Aj8EenaVIfvviDCXqk8yvuOhgFoxG+dpLQhepyD+NpDIbqSFL3V8jwIh0a3GPufE3BPFaZ
	dXa002xtFF1EmXtupEmM319q/wylp/5hXQktnQLbvOervla5+d8xoP9klDv25Im00oihvyK8G7Szx
	U211tEsTVpYg2izb68izv2CHUEkxq8qwkYReVKuRLuaGXfy1B1vH+ZChaeZnXay1QGwnMy/NlmRef
	QKmm6U3cA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jo6Iu-0006K3-37; Wed, 24 Jun 2020 14:23:08 +0000
Received: from mail-vi1eur05on2049.outbound.protection.outlook.com
 ([40.107.21.49] helo=EUR05-VI1-obe.outbound.protection.outlook.com)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jo6Iq-0006Gl-IX
 for linux-nvme@lists.infradead.org; Wed, 24 Jun 2020 14:23:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XUVU5UC6rKrZ1EH39Ud1hjYQU46TY7CzX1+ek4AHgJemzfKwiavJj80zhD3SbT+svf+3RTZIWNpY6uqqpmFIG/X1W7ESa4C87ad8T02J57MZyoaXXfkIcd1+qZtUJz6Pf3b527o8OLNnPsIu+eTAVZdqysB7YjZYzM8WCKju1T9xvYZ+WSW4vmYU6rU0wMicmRiI5b3Gx0++jg0ckimwX0DqAzB6ACB7XVRL7i0DLK/7+YvEBjnaFITgG9kq8mk8mYTykSWiJ0EpiT+uZ54NGkrkjABIkYBYK0ebl0R5owhG9ve59G6cb6n/qDfz93ZXZ3ogeD5IQqs5E/DnMFceYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cRDXY+sC0TM3booMAJXCz/etR0xSXFrMg2qPVlOSFIU=;
 b=DJAt+scgG38Sz7HZrkdvdFo6PDe3rQHkzgjMhqU0gIoL+FvAPmjYuCwI00ayHDrkRFenSzaCCmlzT4wd2vvBNy4bLDL8tdNisXuAs4JDsQh8vgH30NNUrIfhTKAqgUI9N4g5P6ey86ba4Qk6Nv8izde6XlClVNyoRpAqJehEopoy6HwsPkAbPgCYh428bJTlSlnhvn7sVtgpeTFyQnpKeiPIj465dqsl3NCz2wyjB3puMO9ALVXuz7QHOMtM3rA7F1JDmjso3cxrjlnzcwCKgPwXp0Ji1qRKKzcggS6AJJfCSNr4LQAWLWqcptEc4clFZggzcQ3ks2XQhLXdWlsRcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cRDXY+sC0TM3booMAJXCz/etR0xSXFrMg2qPVlOSFIU=;
 b=pu3ex44u2B6cmd4WM/uf5Khx97TVDwx9jWExrcJkaKCJVpXrvUyIDka5qAwjXx0GTwJQAgrgiq+/Bbd9KdagQZLtFK8w/1g6hWx9cXiXzECCA8WUKKXv+wXkz9GwAmY8/AMWdoacS1xauL5dZIBYOJJWivsFoecGUUvwxZSkR9g=
Authentication-Results: mellanox.com; dkim=none (message not signed)
 header.d=none;mellanox.com; dmarc=none action=none header.from=mellanox.com;
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (2603:10a6:803:44::15)
 by VI1PR0501MB2493.eurprd05.prod.outlook.com (2603:10a6:800:70::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.21; Wed, 24 Jun
 2020 14:22:59 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::848b:fcd0:efe3:189e]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::848b:fcd0:efe3:189e%7]) with mapi id 15.20.3131.020; Wed, 24 Jun 2020
 14:22:59 +0000
Date: Wed, 24 Jun 2020 11:22:55 -0300
From: Jason Gunthorpe <jgg@mellanox.com>
To: Max Gurtovoy <maxg@mellanox.com>
Subject: Re: [PATCH 3/3] nvme-rdma: assign completion vector correctly
Message-ID: <20200624142255.GR2874652@mellanox.com>
References: <20200623145525.1586-1-maxg@mellanox.com>
 <20200623145525.1586-4-maxg@mellanox.com>
 <20200623152236.GA3072004@mellanox.com>
 <543adcc9-fda0-abb2-c37a-fb961d65c5cd@grimberg.me>
 <ec6b1a89-0cc0-1378-6d29-29b9d255c7f5@mellanox.com>
 <20200624083743.GA23529@lst.de>
 <0e102b77-79bb-0dc6-48e7-10cc3aefc9a8@mellanox.com>
Content-Disposition: inline
In-Reply-To: <0e102b77-79bb-0dc6-48e7-10cc3aefc9a8@mellanox.com>
X-ClientProxiedBy: BL0PR02CA0012.namprd02.prod.outlook.com
 (2603:10b6:207:3c::25) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:44::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by
 BL0PR02CA0012.namprd02.prod.outlook.com (2603:10b6:207:3c::25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3131.20 via Frontend Transport; Wed, 24 Jun 2020 14:22:58 +0000
Received: from jgg by mlx with local (Exim 4.93)	(envelope-from
 <jgg@mellanox.com>)	id 1jo6Ih-00DVqr-RC; Wed, 24 Jun 2020 11:22:55 -0300
X-Originating-IP: [156.34.48.30]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 2b5e174a-e7f1-4687-aa8a-08d8184a185a
X-MS-TrafficTypeDiagnostic: VI1PR0501MB2493:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR0501MB24939CE6DE7FDE07B6D30A4DCF950@VI1PR0501MB2493.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 0444EB1997
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2Q2TbPuZiEmtX/qo/ht52J2Gc+5iLHjgIa18uSSe2kMfm0xxwbtHyXxIQdbrqfsXyi+r4PqhJiKkIISc8MUKurZjXOKT1zdAYT5gVbmGPnnYLBXRu+kSLVpauq+Xmo3QPO09HlwNBbB4YvNmBSldIb/54uZ6S3MbVbgHze7jcrxEc9YjuDD0GPODfsop/25496aIjacZ/O87MllNQDY3qzTkoADdGiAvRMNE5U/9dESCvOK+J1YRqvXGd9qCksi7aP+mLJz+zzEvs4Mqv1NNEWDQPi5Bz43IkP0IzfdPftbQicqloJLdTdkpzKJ7QHTLYz0UMVzOWIOMBGsOVkVpcQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI1PR05MB4141.eurprd05.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(366004)(136003)(39860400002)(346002)(376002)(107886003)(426003)(33656002)(26005)(6862004)(478600001)(66556008)(66476007)(66946007)(186003)(86362001)(9786002)(5660300002)(8676002)(1076003)(83380400001)(9746002)(36756003)(6636002)(4326008)(2906002)(37006003)(2616005)(8936002)(53546011)(316002)(54906003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: jcYzoeAsU8mTOjTwHqYVkLkosnEMOougrbhhV6PbqnRu4FB4A4fFXlcw5kOHOdZJ0TVJBwt0P6P2CfVEpkWzKcBoGaBCtsktZcam5mQtuaOMdn2fPBiLjVWWYqJ7ZnQsuMX9IjxjkA3ua1R7E+fY8eulUIIPZJSSzylRA1T2K3XvHsSWsNOxs25vZnwvKp4+dx8dO3GkO+b9jTIFzsBhlBeFuCoWvYAjGhj6TaTjqqHoD3qQNpI5yy3H1Eq0cOPWhRpLMWF5rvYiW8OYSzQNyq6CPgqoMmHSqzfCX3YIkZ36clbCT11x4+emvMxUB/vrp7qhRMeW/hKwbYuRR8xOEIeJKqzbTynZm7K0LnK/MeTu9o7snKN9B39IUsxCjfWko1yV7pzQZtNsekdbp6Bn43b17plpvv/I6J5l5sklGr8a0D2eYVDIaApbitvmtAqGJZ5e3qdRE3G4fk9ros9Xw/ryX1oLr2VTZOIIpq2Raks=
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b5e174a-e7f1-4687-aa8a-08d8184a185a
X-MS-Exchange-CrossTenant-AuthSource: VI1PR05MB4141.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2020 14:22:59.0995 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xJYHL+34ZGVTF8XBxchxxub753H0dTAMU0NIbk85oc45J3uxsdLpdjX/wzxsKqU5pKR4h9oA4uEDs4Y4aAgmSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0501MB2493
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
Cc: yaminf@mellanox.com, Sagi Grimberg <sagi@grimberg.me>, idanb@mellanox.com,
 israelr@mellanox.com, linux-nvme@lists.infradead.org, shlomin@mellanox.com,
 kbusch@kernel.org, ogerlitz@mellanox.com, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Wed, Jun 24, 2020 at 11:44:06AM +0300, Max Gurtovoy wrote:
> 
> On 6/24/2020 11:37 AM, Christoph Hellwig wrote:
> > On Wed, Jun 24, 2020 at 11:34:22AM +0300, Max Gurtovoy wrote:
> > > On 6/23/2020 8:34 PM, Sagi Grimberg wrote:
> > > > > > The completion vector index that is given during CQ creation can't
> > > > > > exceed the number of support vectors by the underlying RDMA device. This
> > > > > > violation currently can accure, for example, in case one will try to
> > > > > > connect with N regular read/write queues and M poll queues and the sum
> > > > > > of N + M > num_supported_vectors. This will lead to failure in establish
> > > > > > a connection to remote target. Instead, in that case, share a completion
> > > > > > vector between queues.
> > > > > That sounds like a RC patch? Where is the fixes line? Why is it in
> > > > > this series?
> > > > Agree, this should be sent as a separate patch.
> > > The reason I sent it in 1 series is to avoid conflicts. Since all the
> > > patches can go to nvme-5.8, I tried to make life easier.
> > > 
> > > We can do it separately of course.
> > > 
> > > Christoph,
> > > 
> > > would you like to merge patches 1+2 from this series or should I send them
> > > again as well ?
> > I don't think 1+2 are 5.8 material, so please just resend 3 standalone
> > for now, and then resend 1+2 once I've merged it and rebased nvme-5.9
> > on top of nvme-5.8.
> 
> Ok. Actually 1+2 were aimed to be merged to 5.8 but created a conflict
> between Jason's and Jens's trees.
> 
> If we go this way it means we can't push new features to RDMA and use it in
> NVMf in the same cycle.
> 
> Jason,
> 
> can we push iSER CQ sharing to kernel-5.8 ?

I don't think so..

Where are these patches anyhow? I don't see any iser stuff in rdma
patchworks?

If you need a branch for something you should plan it out now.. I can
help organize the branch process for you, but you have to plan it
out :)

Jason

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
