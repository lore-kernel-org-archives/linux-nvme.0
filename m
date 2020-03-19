Return-Path: <SRS0=OxAA=5E=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB5D2C4332B
	for <linux-nvme@archiver.kernel.org>; Thu, 19 Mar 2020 09:15:18 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 806C220724
	for <linux-nvme@archiver.kernel.org>; Thu, 19 Mar 2020 09:15:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="k6MvI0GQ";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="jx+kZ6xt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 806C220724
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=OoXxo6jS0KM40t8TIMR/vATOxmAdfhzlO612Bnp1bbA=; b=k6MvI0GQTctOAt
	1zQAoVr1Uj1tzclqaCMVk0CBTlZsT+xBR3JC/sfrsMV3ys7OMVr16+/1FQyTyq3AvaeWevw9L2wnd
	/fVif1VukIgUmMw0T2/qLc5rNhsrfKwd+PnQdPRbB2Wsf5ZmbzNoAmJm4qnXfVeh9knWRW0r54NZd
	fk5IZCBGoPq2arVBJqpPEIKZrv67xZqfTR/7tZXqgOgmu+rA70Zo9sKiWhbJsyrPmPgLSSUWgzbpi
	AV0GSK6grsiR7A8FVJiSAtnarB2zrY3iWkuOsOAqAAmmcHJ1Hq4GpNy0e7/n6sxEuMML7l0FC46Qw
	5X2Dmw2RwrA5QHRyI/gA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jErGl-0007zT-0F; Thu, 19 Mar 2020 09:15:15 +0000
Received: from mail-vi1eur05on2077.outbound.protection.outlook.com
 ([40.107.21.77] helo=EUR05-VI1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jErGX-0006rJ-NE
 for linux-nvme@lists.infradead.org; Thu, 19 Mar 2020 09:15:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J8pMJVw9NAevgA3yvgmSSC2boXiQ4DdrVKyz3rt17ufc6fXzwzwzsQtmFtHqOQAiUK9P9yGaQMrEW3W0FU1xU3aCpSV6vtg8bBTp2RTyQ2zuKeOGELhMSzSSV2n3B2aW7CEwPhP67odgVpcolWukYAC/NGQf0OgxJnhxphzkk7VQcQPQ7nRYw9oWrcWj8Lyn61K0t8mXbVeMwPMY1ZJ0m9inl9203+9yn1ndyE6E6u3ryQHmdUP2K9EsIs6+uQNSdO9kUUPuitickZj5Nejc/ljRnEj4U/0Hvu5ozjck4AyEx1vUN3ksSTuwSh7L36dheeAAZ/0KOfsjLKKcJ/aatQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LfJ2COQTq4Ie7YqBAt0ICB0xnMyCwMxOLhSBEKurHO8=;
 b=I+lAOWQVC2b8ppZLjAx9KtTYQFUISxw1l5+kKEKlV7R92C3cgq3BOiI10vGGy0DHiNp3E5CAYONbf7YaOTODeMvADJW7c40KxeEkHuz+d1TS1fCoqUwWM6NLLbMmx2x/RO1dnwEqhKeaI2I0aVYWyeoNhAMjG8ZphetxveJlhaezUY1VT+Mve1lZbT2QWQhOSy+Yh477IvTlWIxfWEpBuTxCmd/010bEU1EJtbdFbDCC0YBJGzTZ5WlECwS3bMFozUbJLWIa48pzRVx/sp/kmCmT/3qQ9NU8ffJZuREv5SoINU17j9FlmSV7JymZnmMWwqGXspOTwS8/CDxYwCux+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LfJ2COQTq4Ie7YqBAt0ICB0xnMyCwMxOLhSBEKurHO8=;
 b=jx+kZ6xtqQwK0g77U5MKkpM/GtV4dhsp+xIrgNgixC2zhMA6Xx5B40HRpUSpRggnCqwWms2pdbxV7rXbWG0inSH94Ch3lClFBg5fAaoNEqkLehJ2E8vBiHiidOuH2Jqu78kK9++1kcaafHEqaCk8BPB/b+0QqX8JDj+rhH3a1k0=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=leonro@mellanox.com; 
Received: from AM6PR05MB6408.eurprd05.prod.outlook.com (20.179.5.215) by
 AM6PR05MB5029.eurprd05.prod.outlook.com (20.177.34.152) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2814.22; Thu, 19 Mar 2020 09:14:57 +0000
Received: from AM6PR05MB6408.eurprd05.prod.outlook.com
 ([fe80::c99f:9130:561f:dea0]) by AM6PR05MB6408.eurprd05.prod.outlook.com
 ([fe80::c99f:9130:561f:dea0%3]) with mapi id 15.20.2814.021; Thu, 19 Mar 2020
 09:14:57 +0000
Date: Thu, 19 Mar 2020 11:14:54 +0200
From: Leon Romanovsky <leonro@mellanox.com>
To: Max Gurtovoy <maxg@mellanox.com>
Subject: Re: [PATCH v2 2/5] nvmet-rdma: add srq pointer to rdma_cmd
Message-ID: <20200319091454.GN126814@unreal>
References: <20200318150257.198402-1-maxg@mellanox.com>
 <20200318150257.198402-3-maxg@mellanox.com>
 <20200318233258.GR13183@mellanox.com>
 <1a79f626-c358-2941-4e8e-492f5f7de133@mellanox.com>
Content-Disposition: inline
In-Reply-To: <1a79f626-c358-2941-4e8e-492f5f7de133@mellanox.com>
X-ClientProxiedBy: AM4PR0101CA0069.eurprd01.prod.exchangelabs.com
 (2603:10a6:200:41::37) To AM6PR05MB6408.eurprd05.prod.outlook.com
 (2603:10a6:20b:b8::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost (2a00:a040:183:2d::393) by
 AM4PR0101CA0069.eurprd01.prod.exchangelabs.com (2603:10a6:200:41::37) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.20 via Frontend
 Transport; Thu, 19 Mar 2020 09:14:56 +0000
X-Originating-IP: [2a00:a040:183:2d::393]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: dd1d1708-178b-4019-90c3-08d7cbe5fe46
X-MS-TrafficTypeDiagnostic: AM6PR05MB5029:|AM6PR05MB5029:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR05MB5029E173725D6EE6DE2EAC23B0F40@AM6PR05MB5029.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-Forefront-PRVS: 0347410860
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(7916004)(39860400002)(396003)(376002)(136003)(346002)(366004)(199004)(4326008)(66946007)(86362001)(6486002)(9686003)(2906002)(316002)(186003)(16526019)(81156014)(8676002)(81166006)(8936002)(52116002)(1076003)(6636002)(53546011)(6496006)(6862004)(478600001)(33656002)(966005)(66476007)(66556008)(5660300002)(33716001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:AM6PR05MB5029;
 H:AM6PR05MB6408.eurprd05.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; 
Received-SPF: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xzdjKeU2NyogS7ggxBDHXcCT57d4Xqkt6PiysLoeyxVFTo+fTfHapCsJi9aWGEozR13gP19jb9nISx7ypbZodYFl6WhyjeS8gr9seDAvMCFdS34y0oVHDPnhnLY/JqzLpf9YKsoVek6qAmgkNHY1cUjyK81lOINvqd76qInShZIPDx/C+bBnopWSiJkdqAAIgelQU3ts4vCWm5SmkMFX/oiqdGOP+vd5IgUd7b1rnmgcBuXfaIoy4NEgNue+b+oXtJlweRvU2ukCInyIuDdlgCkikHGbABBLjYIhLyutrjabXfteX6UUbR75yPj0q+d7cKJyvi96FNGUCBZbirbE/hI4QIW0A8auHwDJwLHWncTGj+vTTe1Wf0PnTwvvdN9tv8KM744ldY21AAwo/wPDQDpsfMKcOqj9fCFU5BGoZ+BRYA6jl458KxAA5q4pP0xNHRqA8SFYpDGreagi0lxxiIYlYNQuQDg+j1pnGmCqT5Uz4biQ6jSto4zWhP7mmTiJMXy/ny6zYz+NTirc+wFLLw==
X-MS-Exchange-AntiSpam-MessageData: 6+FtteLg2k6CvU8k7qn4Sce67AlPdAQ6NZk4l1UZoN0vdCk3sJIaOwgpvM1DodYnsBbiujUjIehyyPVQgnjE12Vle5GQd7WH6wbEG2Va7nbiMkZ7NnobW9UcmSYjqGsU7rSWR3G7PgQT2hRmOaHEE1PMAX0A2iORjun/Up7k01c=
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd1d1708-178b-4019-90c3-08d7cbe5fe46
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2020 09:14:57.2959 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /VMY4njxijd6vFSkfkAYgIryAjrqqbI2hbccJYwesEGZh1Z4BpmV1/eaV+E9c2GpOkhSjup3Nh/AYD7WXPIKoA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR05MB5029
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200319_021501_820795_BFA4BB2F 
X-CRM114-Status: GOOD (  15.72  )
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
 Jason Gunthorpe <jgg@mellanox.com>, oren@mellanox.com, kbusch@kernel.org,
 rgirase@redhat.com, hch@lst.de, sagi@grimberg.me
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Thu, Mar 19, 2020 at 10:48:22AM +0200, Max Gurtovoy wrote:
>
> On 3/19/2020 1:32 AM, Jason Gunthorpe wrote:
> > On Wed, Mar 18, 2020 at 05:02:54PM +0200, Max Gurtovoy wrote:
> > > This is a preparetion patch for the SRQ per completion vector feature.
> > >
> > > Signed-off-by: Max Gurtovoy <maxg@mellanox.com>
> > > ---
> > >   drivers/nvme/target/rdma.c | 6 ++++--
> > >   1 file changed, 4 insertions(+), 2 deletions(-)
> > Max, how are you sending these emails, and why don't they thread
> > properly on patchworks:
> >
> > https://patchwork.kernel.org/project/linux-rdma/list/?series=258271
> >
> > This patch is missing from the series
> >
> > v1 had the same issue
> >
> > Very strange. Can you fix it?
>
> I'm using "git send-email".
>
> Should I use some special flags or CC another email for it ?
>
> How do you suggest sending patches so we'll see it on patchworks ?

It can be related to your SMTP relay, I see that you are sending
patches through labmailer, and it is known as unreliable. Use the
same SMTP server as you are using to send emails.

Thanks

>
> >
> > Jason

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
