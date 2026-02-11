Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E153DECD6EE
	for <linux-nvme@archiver.kernel.org>; Wed, 11 Feb 2026 20:45:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2LndKb2jFGYiU8UOEQgxz4saC3GC50432Z0R5ExY5ss=; b=nNtLmCtLWfpoucbm6zyVakpkrQ
	ALIfJPtDeX9SQI/rZyl7jqSwt2KvqGKygU9+e8WyHdfwng+YIGKmeUPr+KFG3zYJYhG5mgc+lh25D
	fzpstU4itaxOOzUfOi9BHDG+g4s4ElG/y1o6Nr3cqApnChRFS6n6n8yoOvj7FTr5yVy4Fq/YppAcP
	SShH/ZrqXKP67KubzXcRYgWp0kDns5KxKiQf0v1JQKiouqU4+ldq7V+eUPPUhZAzcAlDeCxG4a1l1
	3T+xx0NEVfEEFaY4ZghlfD8yj+X6rjujVSl7lsK0I1j81gj/VYpPLF4TgE0VaOilS+xavYtp2Qyf7
	d0K5XW9Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vqH5X-0000000122L-3njz;
	Wed, 11 Feb 2026 20:45:31 +0000
Received: from mail-centralusazlp170100005.outbound.protection.outlook.com ([2a01:111:f403:c111::5] helo=DM1PR04CU001.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vqH5V-00000001216-39gY
	for linux-nvme@lists.infradead.org;
	Wed, 11 Feb 2026 20:45:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ra6lMuqNQ+pR1hT+bUAojJxUBxOvntWY/eh0yse6AxFFZ3yqY4vveE9mAIZ57ZqSJF7QW9MmNnQel5TgBnju8qe5/qkNsGY9AJzXpBMpA6vkH0DahSZcF8XWSXnONGr/PfHuR05yQ2zVqUOpGHZgqDJysUVgTa2PpFgEBFEPLG6vnf7elMpVxn3wUhYJHkOQiRu6fhMwKw1fJZbsLTm6tfLIf7UY5dXJG6PpsF1ICH1PYEAJl+QBLw01AFWZeYySqnqWigsQVSa2Fjom9P5m/cv9o4fk3W4u8OnP8tC5pyZiVhwjKj9//Udvo+tgBFwFgU1BHPmRSezWc3MA/Z9VQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2LndKb2jFGYiU8UOEQgxz4saC3GC50432Z0R5ExY5ss=;
 b=MCu+z4o2MigTu49ovwna5UNNDPcBLGucF6xpfbdJp2gwUhjsMHFmkcha2yHZTR7uwq+FyktF+qnsL6IuPCqBKH2ZYg9252mpkcVbb0mIQu14nyrp2FWgGTJFR5c/fyFmBhwF2lG4RLAgEYZ5/+RWr7VEDRAj/s8oa8G6ITVe2S/Wewoew+5nOdqusNJBuMA8AjSNinerYm/WvUDGLT3p4o4KoMmVMpBzYxO+Q1FXWMbIs6lF5Eji69szvnJPrtmT17CRPySc4mjCZXD2aQrx+bgmPecpgyHBBp1WYsorIYxE0U4ob3BAROAlpazlratIrNBjipUryfEIzNuItrLcYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=huawei.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2LndKb2jFGYiU8UOEQgxz4saC3GC50432Z0R5ExY5ss=;
 b=tW+BaS46PxbDzHA9Sy8bqQJfwEI1LQ+0Khw2GEkbrSOB92A3VtSeBlewxq9ur9cdDorh0/YD0mzCXechRH1i1rdo0V/qFzi2ev6qEUVvfd207E/NVZBbF+E5XdUxu6ov2sUN9v4ulcw7v9JJHSio67QIAsYQ1PCF1mDUZeiUT9XdYarOB7m4QzWyzO+mSh8EqGL/Rq1ZIoL37mvTp/ig/nxRMkkZYHUWhUGhs0aZIv66PcocmWWm3WKEH5aiJpbDVItEXvrvqRSGUtw+J8TXl5LP+4SxyaAySTCahkp4SyTP+muXF9zt6prYRAzYekh5888iEW/NS2n2Us+fEFA6Eg==
Received: from BYAPR21CA0010.namprd21.prod.outlook.com (2603:10b6:a03:114::20)
 by CH2PR12MB9459.namprd12.prod.outlook.com (2603:10b6:610:27d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.10; Wed, 11 Feb
 2026 20:45:19 +0000
Received: from CO1PEPF000075F4.namprd03.prod.outlook.com
 (2603:10b6:a03:114:cafe::16) by BYAPR21CA0010.outlook.office365.com
 (2603:10b6:a03:114::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.4 via Frontend Transport; Wed,
 11 Feb 2026 20:45:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1PEPF000075F4.mail.protection.outlook.com (10.167.249.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9611.8 via Frontend Transport; Wed, 11 Feb 2026 20:45:17 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 11 Feb
 2026 12:44:57 -0800
Received: from dev.nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 11 Feb
 2026 12:44:56 -0800
From: Chaitanya Kulkarni <kch@nvidia.com>
To: <linan122@huawei.com>, <song@kernel.org>, <yukuai@fnnas.com>,
	<hch@lst.de>, <sagi@grimberg.me>, <axboe@kernel.dk>
CC: <linux-raid@vger.kernel.org>, <linux-nvme@lists.infradead.org>,
	<linux-block@vger.kernel.org>, Chaitanya Kulkarni <kch@nvidia.com>, "Martin K
 . Petersen" <martin.petersen@oracle.com>, Johannes Thumshirn
	<johannes.thumshirn@wdc.com>
Subject: [PATCH V4 1/3] md: ignore discard return value
Date: Wed, 11 Feb 2026 12:44:36 -0800
Message-ID: <20260211204438.22568-2-kch@nvidia.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260211204438.22568-1-kch@nvidia.com>
References: <20260211204438.22568-1-kch@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000075F4:EE_|CH2PR12MB9459:EE_
X-MS-Office365-Filtering-Correlation-Id: ccbeead2-e302-4827-0c83-08de69ae775d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|36860700013|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?4QbGyiWvo3eyqnzHQuanIRPMaAR7ZowCbePnNDhtLTpZCWQcQ8S58IFpv3X2?=
 =?us-ascii?Q?xhETl812HsvWuBYNIc+G1f9IaMcJ+rXUP6fJ7zuxiknlc+RreOELNXvoqtrI?=
 =?us-ascii?Q?BRmgsFaxidnmUNQaW76BlSchaPrKu+oXXhx6kVjRspyBWtBYvhKbZ+R29GBM?=
 =?us-ascii?Q?Kjr+y0vZnT3miOdXv4lV23Y6+jzlkeihoXaEQPglhwISY3GBScUbq70QIFzS?=
 =?us-ascii?Q?9P15utk0/swy1cz7kozk+vnDRcwPRQ01B+g3MR2DFIbOV57c5QHZ6Wx3ebrm?=
 =?us-ascii?Q?Rn8YzfhFtLT4iOV96iC1QawHMGNjXqpHPzLhygAjjF6ctT5IlMHEZm3I42Xi?=
 =?us-ascii?Q?14JQYB954lOcyxukwba2W2B5qZ3BMcXNDh4BWqVvBT6mCvI5OQRjU4NDTh3i?=
 =?us-ascii?Q?o+zkrzff0PeJy28JqzcpU2aRHNf/tuxY4h+mMTjxcIjZ9ybrGYLSZBbKnR/g?=
 =?us-ascii?Q?xbeeS5+7cnHNtnPkjz7pBhSthV3fPxI4f5czkl9kpXm85LG69CtIGfNCFeeF?=
 =?us-ascii?Q?6AuwdZwbyS7TrjHpsMCdExuKMuDZvFdCIEFa/Yi8qxrZHsDbaPu+MRUru275?=
 =?us-ascii?Q?9vAzaaKhJED/c3ifOeN6UtTQYBkYrClClpF+b6sq+zvdxFDrjS1NsvNBRGhG?=
 =?us-ascii?Q?D7G49H9Fj/Pmi01VhjsRcQFtMMhEbHt0ANU0KTOiWEU9oU9HJC14NDWPeYqn?=
 =?us-ascii?Q?gHQXM3daG/JRx9xOitRI7YZjKv9l7O3N0jy4j8ctf6UsWd6eKgSXOy61IZCG?=
 =?us-ascii?Q?OLJYtHsdPqDlCoU6aFv7HGQZN3OKnQ93tKPi/yxRATjG4tzBOwixvYo6qai7?=
 =?us-ascii?Q?kISLtvRfCC7+ShBaRyFU5baP6I4KjrvqHlEyvySqV+HpUzsKEEQS1IVzFQMM?=
 =?us-ascii?Q?b/4ruGKiqjcQERnwjvgLc39TvbLrghoK4MfY7LY4exCaEQdS3mxYN3s6j8xd?=
 =?us-ascii?Q?zrJeFWrEO+VefRV6EmNg3nV3KuP9rCqGPvzkk4S7hJChyuw1LVyQ8/l+Rut1?=
 =?us-ascii?Q?7IC9kAX4537/yW/Gsm2xhavIUMTCiBQfI/ubCfn+UCooNxzGXsXTMvvSj82O?=
 =?us-ascii?Q?bQkvlSji05mh2EdUxbP22fShLM66JOpi22jRbLZpuEHTyqkLUKnsVTh3LB5j?=
 =?us-ascii?Q?Zn5Thi/ytCthh7hGqlaTl2XxWQvoxpZy0Speox5qRz6zv8qB/ZUySRknBvcL?=
 =?us-ascii?Q?t9hVVxr9hE3Ojy8Z2Y8o1xXto+ByLyOzjuY49Y6c4yCqJljgRpREPcRgDAXW?=
 =?us-ascii?Q?Ws3YDpALDEUY6PvhgsHrRsrq6VJpPV/+1CTWjhHYyK+7JcwQyYRhZuHJtZH+?=
 =?us-ascii?Q?8R5o6CJL30K9lp7fN2kLeoqoYkbWzUulIvkRtCnrEcEDOUDRWSkF5vkTBb9d?=
 =?us-ascii?Q?//z+qUN7myaqpxqotIFcVEizSZ8mkgQOfbgpHQVGR5+7V+U3t6X0tNOBgyj/?=
 =?us-ascii?Q?bQMWSlL2saM4KOo6MG4tORzEAdsEK5Q+aeWvf6FifGJf8PdOdqwdVkoqNvGf?=
 =?us-ascii?Q?OrGyILlkZhT5iZEPyWGIw9XVwptpc2cbAEto0BpowsW7g40Nh9JzDGI+zxvs?=
 =?us-ascii?Q?v0yBrzQgaG8J9u1MWTR+FQK55n2fd7W7QBxp7l+EAzBTIf1tNIFqjIqfOdf6?=
 =?us-ascii?Q?+bt1mBAgD7Kcu/oFFQD6X9Gp82sS8eOtgrL2hq4332ymtgigugRX+xyqYJAR?=
 =?us-ascii?Q?CVQTTw=3D=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(36860700013)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 8Ko+vMRIlkUF/AsSGgBPKoDBDk1ZFcie57qjNnyOahG2oYmn0WAd9JIOYcD/00z0FxJV55GeWa1BpPx+Y9qr8fe3gwwD0o3sWiC0y8QRO+tHDPzPW7xnK7V2ax8rFZ+mTsk6HzfICk+Qd9JRnhPld4e13HLs9ejWsLF4tnyDES8fhOgNmrButgVmn3ZRMeh/ArBrQv5b7iailjL4cJ96iUwuwd388Bu/OkrC87OQ6WKAM1ZbFth9xDjdcovdd8uBo8ESjl4sfd3NTeT9ca+1/BcIx/GrAEDVCvuM/iv+D6TTxMDH69SfMvXtC8poBNnnlr0H3c34h0Ncr+yxsW2q5X5adDO7p8CpFnOjX6TSZz95f99OWYgDo7hDB0ho5KLKCOSQ4gdWWkb20rWw4CUIDUZQFBLwq1J/gBGN3ntxm7I44rsb06TWbMFKjxTwc5NB
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2026 20:45:17.9448
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ccbeead2-e302-4827-0c83-08de69ae775d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000075F4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB9459
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260211_124529_801771_2BB3A6EA 
X-CRM114-Status: GOOD (  10.96  )
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

__blkdev_issue_discard() always returns 0, making all error checking at
call sites dead code.

Simplify md to only check !discard_bio by ignoring the
__blkdev_issue_discard() value.

Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
---
 drivers/md/md.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/md/md.c b/drivers/md/md.c
index 59cd303548de..89c9e63a9139 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -9179,8 +9179,8 @@ void md_submit_discard_bio(struct mddev *mddev, struct md_rdev *rdev,
 {
 	struct bio *discard_bio = NULL;
 
-	if (__blkdev_issue_discard(rdev->bdev, start, size, GFP_NOIO,
-			&discard_bio) || !discard_bio)
+	__blkdev_issue_discard(rdev->bdev, start, size, GFP_NOIO, &discard_bio);
+	if (!discard_bio)
 		return;
 
 	bio_chain(discard_bio, bio);
-- 
2.39.5


