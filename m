Return-Path: <SRS0=Hg5O=7I=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1FEBC433E0
	for <linux-nvme@archiver.kernel.org>; Tue, 26 May 2020 12:08:02 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B701220787
	for <linux-nvme@archiver.kernel.org>; Tue, 26 May 2020 12:08:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="NbyvK7WJ";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="ESaoUXLU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B701220787
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=3b32urlfhPXKCA9vtKJQom57RUqrf4E/7vdKVqLeC3I=; b=NbyvK7WJuaOa6p
	U/jUnl+s7ZsgVMDZ+FFkkfVVJQQhAO0bXoH+j1X55d93nhgIkqdt3MLferY8ERRfaI7TXdQiC4Iv5
	uvMl5z8C5Zqi0Tzm6/wyimCIBH7ScOe8RdEyKonE1B8mNQBvpFzvO3+iqrizGIA1yYW7NqqM+hRbw
	3WR+0lJzSivUq42mFELh/gWc4od6Moz6dBgnInSF8MGTT8zEh3GcNzB1J8VqP1k9U5PuqnEXbySGA
	Ty6UBxOEUG4LgJK+ZtYL+TB5RvJpKeTwy0GcmV7BSYpm4lDuTJSWQhvJpvrlCEFGWd0awah5HSHAK
	AvouNeA/2QL5TUuVqzLQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jdYNC-00051h-Id; Tue, 26 May 2020 12:07:58 +0000
Received: from mail-eopbgr40050.outbound.protection.outlook.com ([40.107.4.50]
 helo=EUR03-DB5-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jdYN9-000504-F6
 for linux-nvme@lists.infradead.org; Tue, 26 May 2020 12:07:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fxkeFZ1bmP/EJw2/B7Cb+TeveE4oe54d4esa6P24jYLgcoax8cfcMs9AH4RpEwZS2fP7Cd8PO8GdU2lefa8ykF6q+HKLAH0/WPQ8A27j45f8QUI6y9/LfJ2+0/ae3ExFYTtOD56BrcvlicjeE2QQC1NiNqA1qsNDL4y+sPjJ4gb+E+LMnkNgUj4ZOGNksATpmorQ4RoOfDrsP+jFTC6A7oCY3rLlycajH9jylipZR9YN6iIDoZyBm3fMtQEMDpUQqQuJYRPuah5mRRiMlhCrDi7TYW+v0OOPkqigE/U5nLUlaArjyRcc/1V8u95ebOwor+RYXX505xG80KGrXUol8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xri0+aqNsATTPKW66PDEhU1P6lhhIavlDnjhBMmCbE0=;
 b=d3ZwcYc3vHR/FoflSbSB62DXVdZgZ3OIyi9MRJJdM9HZC8FAjj6yofTHqgPRQiVAbS3BF06jeL89izwjwtDvQwZtQEgN2rgdeZg3QaaC212LK9EkoQKCGS3COb19XHMJTtXveL8iYySHLXjnwbWchMRCw5H27ea9y59pkLBZsnffRT1PveEWcLjLP+FdMQQtEixA2mTp15LnOa3UpO4ivmUih7OZwIHt9ZjsKoo21SqBAup9eMFoepGx6EiyQOdCYrvtIINZKFYWnvMGHlWn3c/RkATLXX1x4SjE36bwwJ7pctQRad0iRLtL7pnTfDm64rAWMmtjaiQ35NPyT0V/iA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xri0+aqNsATTPKW66PDEhU1P6lhhIavlDnjhBMmCbE0=;
 b=ESaoUXLUDfTkCqAsQd0JkUhmyakwRkaZ2ujK/7vVb3bGKX5pZ88zS86UOoaFR799cPFaE6o0s1PHZtUsc22+draMeeQqXmSHgrmuYa5aI5KkRb/k+fHwDpXOn1zrZD36zCc0rWqkMOjx3dsB/TsORBPOSr4qfHrfFPjJaD6MaIo=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=mellanox.com;
Received: from AM6PR05MB6408.eurprd05.prod.outlook.com (2603:10a6:20b:b8::23)
 by AM6PR05MB6264.eurprd05.prod.outlook.com (2603:10a6:20b:6::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.29; Tue, 26 May
 2020 12:07:52 +0000
Received: from AM6PR05MB6408.eurprd05.prod.outlook.com
 ([fe80::1466:c39b:c016:3301]) by AM6PR05MB6408.eurprd05.prod.outlook.com
 ([fe80::1466:c39b:c016:3301%4]) with mapi id 15.20.3021.029; Tue, 26 May 2020
 12:07:52 +0000
Date: Tue, 26 May 2020 15:07:50 +0300
From: Leon Romanovsky <leonro@mellanox.com>
To: Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@mellanox.com>
Subject: Re: [PATCH rdma-next v3 6/6] RDMA/cma: Provide ECE reject reason
Message-ID: <20200526120750.GD100179@unreal>
References: <20200526103304.196371-1-leon@kernel.org>
 <20200526103304.196371-7-leon@kernel.org>
 <20200526113628.GC100179@unreal>
Content-Disposition: inline
In-Reply-To: <20200526113628.GC100179@unreal>
X-ClientProxiedBy: AM0PR01CA0077.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:10e::18) To AM6PR05MB6408.eurprd05.prod.outlook.com
 (2603:10a6:20b:b8::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost (2a00:a040:183:2d::a43) by
 AM0PR01CA0077.eurprd01.prod.exchangelabs.com (2603:10a6:208:10e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.24 via Frontend
 Transport; Tue, 26 May 2020 12:07:52 +0000
X-Originating-IP: [2a00:a040:183:2d::a43]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: d34c67ca-46ab-4a9f-e3cc-08d8016d6a92
X-MS-TrafficTypeDiagnostic: AM6PR05MB6264:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR05MB62649DC49587DA5A52A9D770B0B00@AM6PR05MB6264.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1247;
X-Forefront-PRVS: 041517DFAB
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Uii6fm7sszQxMeT5AXuoKcZ5410TYbAj38yZEjj+eDKkn4JPRwJ3Mr9B3LZ9IFRKuQcmeBK1weqXACuS/XkpuacE4yJfTc0O9aN0whZBgvbbj7xQ35oZaE070GIMDPtMN14v3iaWZK2RV4iDYoO74HJAHXPCjRzBo6nSqirn/WWCpCOgR71+krGBaqfUCP/qaJqmSjwfLvBLwNuiVcC+kdwKFQD7v/NXf0fGBxSVUG3NB1fecE+HuToRZiXTsr+q67djV8VLL4clOH5cejs76CZmjnKfh8gOba5Xv1CyogVHa5JuEteBX/m9zg2NrGEM
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM6PR05MB6408.eurprd05.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(7916004)(4636009)(366004)(66556008)(66476007)(66946007)(6496006)(2906002)(6636002)(52116002)(186003)(33656002)(110136005)(498600001)(8936002)(7416002)(1076003)(16526019)(86362001)(54906003)(6486002)(4326008)(9686003)(8676002)(33716001)(5660300002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: UQv62W/Vzxz1LT22qug8hf+YleOOsMP0/1+exWxdDf2gJu5iTfyNyOx/IDQYUbCdQsqy923etsisakQyitmrZDq3IIPCKdMA13QMi90nrm1MYmtkpx3KryhmJkJnseNxQNWaryRO7ucTeRl07IwWSxKVqu5cCLzmr7YRl4KMVRPsO4C61uXwuAtsrQgMA5NyQJ1fECMPlPgknNzNelFpYriE6krMlZbRU15h115EFZ0vo3TJIZ5VauTjXq5vPt2G26Nyw6RERjiIcXqfplb5kBtVnGQdUwzeHSfYHM8iaUBkPwac6hKPihLr0lWc5Pe49G/8GFjV16GUlXCQMyRcCipNGRNrI7vnLHbyDZ52Ny4ilDw3cD9avqUBZofPOL+NRf/0gweGFn4JfPwdGA4hWiQDVj+WWcQFioPc6Avm9hGfzXRe/lWKIt8kNitNtaZ6EGtl59pz4MNeZ2oLHtk8lC6BkeOKXnEKbc4CyZdWbjZfE7IxXgdqwiAQbCzoxcFbOOnQZ5jkMyFlbdZaJFtpJw==
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d34c67ca-46ab-4a9f-e3cc-08d8016d6a92
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2020 12:07:52.6588 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3fQMWZKrVqkF0KAi/GVHbQ/a6JgWSbvC+bQUFA5Z2rjRZPV9KMvUCsviUmJGwkHyo3QdfJax8i7ffjaYvlToFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR05MB6264
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200526_050755_516941_4FE581BA 
X-CRM114-Status: GOOD (  16.23  )
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
 target-devel@vger.kernel.org, Danil Kipnis <danil.kipnis@cloud.ionos.com>,
 Jakub Kicinski <kuba@kernel.org>, Jack Wang <jinpu.wang@cloud.ionos.com>,
 "David S. Miller" <davem@davemloft.net>, Sagi Grimberg <sagi@grimberg.me>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Tue, May 26, 2020 at 02:36:28PM +0300, Leon Romanovsky wrote:
> On Tue, May 26, 2020 at 01:33:04PM +0300, Leon Romanovsky wrote:
> > From: Leon Romanovsky <leonro@mellanox.com>
> >
> > IBTA declares "vendor option not supported" reject reason in REJ
> > messages if passive side doesn't want to accept proposed ECE options.
> >
> > Due to the fact that ECE is managed by userspace, there is a need to let
> > users to provide such rejected reason.
> >
> > Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
> > ---
> >  drivers/infiniband/core/cma.c           |  9 ++++-----
> >  drivers/infiniband/core/ucma.c          | 15 ++++++++++++++-
> >  drivers/infiniband/ulp/isert/ib_isert.c |  4 ++--
> >  drivers/infiniband/ulp/rtrs/rtrs-srv.c  |  2 +-
> >  drivers/infiniband/ulp/srpt/ib_srpt.c   |  3 ++-
> >  drivers/nvme/target/rdma.c              |  3 ++-
> >  include/rdma/rdma_cm.h                  |  2 +-
> >  include/uapi/rdma/rdma_user_cm.h        |  3 ++-
> >  net/rds/ib_cm.c                         |  4 +++-
> >  9 files changed, 31 insertions(+), 14 deletions(-)
>
> For some reason didn't get the failure in CI, this small fixup is
> needed.
>
> commit af02a4a50ec0d18fe9bfb86b96411dfb42054f97 (HEAD -> rdma-next)
> Author: Leon Romanovsky <leon@kernel.org>
> Date:   Tue May 26 14:34:34 2020 +0300
>
>     fixup! RDMA/cma: Provide ECE reject reason
>
>     Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
>
> diff --git a/drivers/nvme/target/rdma.c b/drivers/nvme/target/rdma.c
> index 30a0a9adaddd..d84765f66d49 100644
> --- a/drivers/nvme/target/rdma.c
> +++ b/drivers/nvme/target/rdma.c
> @@ -18,6 +18,7 @@
>  #include <asm/unaligned.h>
>
>  #include <rdma/ib_verbs.h>
> +#include <rdma/ib_cm.h>
>  #include <rdma/rdma_cm.h>
>  #include <rdma/rw.h>
>

and this one:
commit 4c489c296115d1c795f24cd4aad741058671fe50 (HEAD -> rdma-next)
Author: Leon Romanovsky <leon@kernel.org>
Date:   Tue May 26 15:01:19 2020 +0300

    fixup! RDMA/cma: Provide ECE reject reason

    Signed-off-by: Leon Romanovsky <leonro@mellanox.com>

diff --git a/drivers/infiniband/ulp/isert/ib_isert.c b/drivers/infiniband/ulp/isert/ib_isert.c
index 7bc598d7a15c..b7df38ee8ae0 100644
--- a/drivers/infiniband/ulp/isert/ib_isert.c
+++ b/drivers/infiniband/ulp/isert/ib_isert.c
@@ -15,6 +15,7 @@
 #include <linux/in.h>
 #include <linux/in6.h>
 #include <rdma/ib_verbs.h>
+#include <rdma/ib_cm.h>
 #include <rdma/rdma_cm.h>
 #include <target/target_core_base.h>
 #include <target/target_core_fabric.h>
diff --git a/drivers/infiniband/ulp/rtrs/rtrs-srv.c b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
index 67d164ff5aaa..0d9241f5d9e6 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-srv.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
@@ -15,6 +15,7 @@

 #include "rtrs-srv.h"
 #include "rtrs-log.h"
+#include <rdma/ib_cm.h>

 MODULE_DESCRIPTION("RDMA Transport Server");
 MODULE_LICENSE("GPL");
(END)


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
