Return-Path: <SRS0=OxAA=5E=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10B0FC4332D
	for <linux-nvme@archiver.kernel.org>; Thu, 19 Mar 2020 13:54:13 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CFE1E20663
	for <linux-nvme@archiver.kernel.org>; Thu, 19 Mar 2020 13:54:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="kt7GQlIF";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="iavV5eIa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFE1E20663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=dG1v8+uepTMIzf1eVdSj6N3d7/Xm/O+Wdn+zehzCuF0=; b=kt7GQlIFU0zA4B
	3q9VuWlJBUAJX/H6OzkPHETwDsVNksISGaxEYtWA2IuS7dMBdrr/Dzmh2WGOdQ8M8ZV7hz3lpwN85
	z1vlY8ric7bnC0g8IUwoPf1dPADnOsKNK1XG7lMZLOa0p9C5sJnSzD9dU2job4rj3QQV5w/bg+E9z
	DZ5vnefC6w7xX0PqhKDvTqF/RLXZopeUAJipjmlS9n+Wt83g85CZ3PW6Ss2SU5WNaV/RIX2/ghpdo
	SWwMZ5eAoaSUIk1M37pUeZ8DMgiV242/EqKF7r7dSx9V37VRbbsVDjCWli9rK2B68L10vDWa0krGg
	QcYeHDhIU4fgowvz21dw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jEvcd-00017m-44; Thu, 19 Mar 2020 13:54:07 +0000
Received: from mail-eopbgr150047.outbound.protection.outlook.com
 ([40.107.15.47] helo=EUR01-DB5-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jEvcZ-00017B-R4
 for linux-nvme@lists.infradead.org; Thu, 19 Mar 2020 13:54:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DjZzcj+TqZb9GcVNfGaXbrLjC1V+c3Kpwwiqtmc0XKJjA4HoTYYCm/TMaKjKvloUAG7kyD+FMybBercngbOaw446PnSEEf0NAs5JeB+2qqhwB2eH8Tnq5Q/0zAMO+KOMNbYPq9HcOe/NGKvTMJ5ebzJN7n1PkfvF5D0rgx56XJAqlPvx6JfqyVOXW1axQM02INTs/hvR4ZrWujhzzMrElbPgLCIDDR+vGDNXrDCqfw4ZRizh4qgG/ExfIeePIxXQPFkkKp+PQq4LNJoeVTaVGQxD9c7UaQ7jCfQ2Q1UfoS7MSu82NwbCxeHflWqiIUziPR2sWzH8mkGocGgy+wH6Og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j4rCbFSeHaAhrILgIORU7FJ6Ux83uyJHyHnKjNx1xnA=;
 b=ZXYa9d7r8Nav8YNWWvJB6uZMyLF51AaplRTL6c3nwKmvsHxqRfo82oCEBx/KuHQwE35a00dgoCMhfQeZDsewpNrxwwj1ijVRWnkidVewRVhuEN+3rI5/uPlWrMeipuFBhBp5hNv5C5vJg4h/R3X7+tz4DO7U/0xxgtCn5J8pQJeffN+zgGRyO/pSygp0iaH9Y80386EFoYnNAzzIsBDWR5LL7gbW54rDCIcDM4CVf1z4LCPGte98YxX6C8Yi+Pc6caEo5IY+qHp2Hd3L01/2I0Y8VJPyeZdw9eVzR22L0d7TpiWuldqJw+OQmmZnUcDkj26wCNXeer38Qi4u9zk3pA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j4rCbFSeHaAhrILgIORU7FJ6Ux83uyJHyHnKjNx1xnA=;
 b=iavV5eIaRUORe2KRjaxOIc4F8UH00idwlXKbm181s+3MOoZYVKbiiftPnhp57Kysn6pAIMqHNcMhWZAlcVki8eN7Y+zPhiTkP8yKIAKRLmxIa/VtmRFrrOva26brZa4buNCv9GN617zoT4WreGZTIw85fjcihz988HPtuRAOyOo=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (52.133.14.15) by
 VI1PR05MB6382.eurprd05.prod.outlook.com (20.179.27.206) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2835.18; Thu, 19 Mar 2020 13:54:00 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::18d2:a9ea:519:add3]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::18d2:a9ea:519:add3%7]) with mapi id 15.20.2814.025; Thu, 19 Mar 2020
 13:54:00 +0000
Date: Thu, 19 Mar 2020 10:53:56 -0300
From: Jason Gunthorpe <jgg@mellanox.com>
To: Max Gurtovoy <maxg@mellanox.com>
Subject: Re: [PATCH v2 3/5] nvmet-rdma: use SRQ per completion vector
Message-ID: <20200319135356.GZ13183@mellanox.com>
References: <20200318150257.198402-1-maxg@mellanox.com>
 <20200318150257.198402-4-maxg@mellanox.com>
 <d72e0312-1dfd-460e-bc83-49699d86dd64@acm.org>
 <5623419a-39e6-6090-4ae2-d4725a8b9740@mellanox.com>
 <20200319115654.GV13183@mellanox.com>
 <0b11c26f-d3de-faf5-5609-c290ea46ed9c@mellanox.com>
Content-Disposition: inline
In-Reply-To: <0b11c26f-d3de-faf5-5609-c290ea46ed9c@mellanox.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: MN2PR05CA0011.namprd05.prod.outlook.com
 (2603:10b6:208:c0::24) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:44::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.68.57.212) by
 MN2PR05CA0011.namprd05.prod.outlook.com (2603:10b6:208:c0::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2835.11 via Frontend Transport; Thu, 19 Mar 2020 13:53:59 +0000
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)	(envelope-from
 <jgg@mellanox.com>)	id 1jEvcS-0006YX-O5; Thu, 19 Mar 2020 10:53:56 -0300
X-Originating-IP: [142.68.57.212]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: d810e7b3-2b44-4a13-c1c7-08d7cc0cf9cc
X-MS-TrafficTypeDiagnostic: VI1PR05MB6382:|VI1PR05MB6382:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR05MB63828EA77783173E5216A063CFF40@VI1PR05MB6382.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-Forefront-PRVS: 0347410860
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(376002)(396003)(346002)(366004)(136003)(199004)(4326008)(66946007)(66476007)(9786002)(6862004)(9746002)(478600001)(558084003)(26005)(186003)(52116002)(2616005)(1076003)(2906002)(6636002)(86362001)(81166006)(5660300002)(33656002)(37006003)(81156014)(316002)(66556008)(8676002)(36756003)(8936002)(24400500001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:VI1PR05MB6382;
 H:VI1PR05MB4141.eurprd05.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; 
Received-SPF: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8ecRMMB59QTHK7/JwA6NpD9T+pRQlWyaISc4B230EDVLjQFiB4dmXEvIoBRRuhK+9HGUmK6tgfVxeAUQpS/cFp0pOT6SIVRVG/XF5Grv/hbJTFFW7BNmS07HM7+jlK90FkbkXfXNgyv7CAkXfDwSK3B04Oz5JJJoFFzIBwwxQ5/HOn0PTeGKbxIB7U88laiuNH5RUgtmPKDThvswTYVqKsnjM4mMYg908XCvlOHNDZbMEaqhj8C19P0LgM1XUhjnTGYdotqgRHoU9eSRdAInlZB4teR7+MufY2Vb8BA9oUeSAHodwPVPB5Nt0RoeyE+T02Gydl66O2sXGf2IxsPGtgtY2dUFIKNZjsubuv50lMPS/6URiFow3qOTk32N7IeghhLIYBbxfd+YerbmFxAYa2xWl6qnWgPdwO2lRwwWnIB2oLbv5l0KTGn3k00kLdYPZW33Vf7hytTkIXkdSfAK4QgxVLuxf9ScMO9hulis9TGg0chCPVi4RBskCmIF6+vB
X-MS-Exchange-AntiSpam-MessageData: ea7UjBS5zHF4WR0ONRye884+UfHCWf+RRWM6IDtYeFUV9wnYLgiijpfHRp1+M/usrfM3SCY8Zw/ibX8CCET8DlmZL7ncSomAToHlOsL75S4fghhpvj/X8OQNEzGEFVjMaxHOifNUqoUZCTHDUy08pA==
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d810e7b3-2b44-4a13-c1c7-08d7cc0cf9cc
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2020 13:54:00.0792 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zUv6w1AAjl3QJBlUVyKflrM/y77ahqw0BxLQdnYSdMCYL4bjs/GWeIJjFjW59fqCDp0i6xEZNyS3szOwz+0JCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB6382
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200319_065403_884021_112ED012 
X-CRM114-Status: UNSURE (   6.12  )
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
Cc: loberman@redhat.com, Bart Van Assche <bvanassche@acm.org>,
 vladimirk@mellanox.com, idanb@mellanox.com, linux-rdma@vger.kernel.org,
 shlomin@mellanox.com, linux-nvme@lists.infradead.org, leonro@mellanox.com,
 dledford@redhat.com, oren@mellanox.com, kbusch@kernel.org, rgirase@redhat.com,
 hch@lst.de, sagi@grimberg.me
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Thu, Mar 19, 2020 at 02:48:20PM +0200, Max Gurtovoy wrote:

> Nevertheless, this situation is better from the current SRQ per HCA
> implementation.

nvme/srp/etc already use srq? I see it in the target but not initiator?

Just worried about breaking some weird target somewhere

Jason

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
