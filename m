Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9EE5C77B60
	for <linux-nvme@archiver.kernel.org>; Wed, 26 Apr 2023 12:32:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=P9NEHDXCcrBCFqdOeVuqvbK70O3PtjJnunirkZBdyH8=; b=NTz7BYcCJcXsqbjpSEIGjlOpl0
	FzfGQGisJxXca7ZkZFLtm8dMRVhJqDHKzbhv9ml4BTtnZ6j04IGRUn1V853COCPEA/Lv9EVLMbRAn
	Fq98Hj/OVVP0gDNJUgsAbwUf09g0NeXM35nZkEwHQY8CiuCyA8BFDvnXSyiSEyonVfvAKSVc/J+U7
	NNotGthNRcYS1UP2xfCKPX0iAJ0BLNLT8GfQYtcBZ3BcPGnkvhO54J0j7dTMis6UEwMV1DgPRVS/E
	3l28CPthAQy9wr87ZncQ4HXPeUeaEBCTQ84nxq/Pf1ujgXQRpM2WpIc3cDYQJ2/KzaNMiF3GQvBIf
	BZ0TxwKA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1preJi-003vIZ-2D;
	Wed, 26 Apr 2023 12:32:14 +0000
Received: from mail-dm6nam11on2062a.outbound.protection.outlook.com ([2a01:111:f400:7eaa::62a] helo=NAM11-DM6-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1preJe-003vF4-24
	for linux-nvme@lists.infradead.org;
	Wed, 26 Apr 2023 12:32:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OrwMhukoOi9jtewQjq1qvL0ez8/VLZ6k8UuC0MVzs22w2f1RTnT0kKTZKFH0WzYO7ZMd1NanAd/r2R1l9In+GEqEI6NCOyJLoytWp/cFdH0qWgz1zeJbEhI57ot0mc9uW0tciESJQ4LKY4d79NnDnRncWCVF9N0x0qBeS8Gijcj+65bp2pCLdCGClOOoOPLGrmmJmYXfN4jlA3FmBSfBMwQYGFV1MY7KNjEyoq9yt0s2X/xybDGZcvGQdAq25SHoeDmgrTERg09dXXI/JdZzfF2wR/eemiZ+EibMO2dRRY/lh53OAF3WfWwMVgdkIjUsdOB3OyK8YqK1ZkK9hSbpCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P9NEHDXCcrBCFqdOeVuqvbK70O3PtjJnunirkZBdyH8=;
 b=my+1OWZRWSke8lVsImGKaSl5bywCh1hnqor+Mb4qtEJjTmKg0YxT+WcTkICyynQk6h2fsHwe2WKMvBA+UcYwkzJpWRmJMPFpo/p83eVa2lv72VdowuU0pOHnzvSgog5h95x1Sxsz4GYD1sT1yIFxGhMr+GepmnrtDLUEhQqR2heU8HDUEsRaqatCzrLrKwQC7osrE7se8NgvhMBn+961ObZsSKsHDL+0xR+DVCpFjLpAqy1LHje7oE27ArAhaja2y22Wg7l8bN2Wb1lh4o44OXm0uj/IB4bsz9jf3sqasebiYBKdojEnwgXuzkXKjDT+bgeXEee+edEXKDDuuThHYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=lists.infradead.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P9NEHDXCcrBCFqdOeVuqvbK70O3PtjJnunirkZBdyH8=;
 b=FKCyJZHxa4ZELYXzKRabd7YZlLQY5DQ6AxZi9kpO/Ru7IidymB3X8+0O4zw6Tke7kHhSYGXn6aazqpPQazWnJIervvP/xxBoabAIPMcHRsHE3gj40kBpLZ4EGLMuhDEbmEfvGaFBLJ9S7y8dV+JUvC/WKVZ6vIMmCNSMRqQ73hLW7zH52r8tqAvThMhzXW6dj5drTsOuAodBiFrELNK0OP6OXNBsCsVGX+OwSI8EdvR3Dvo96z9uXzz2+SSve++DsRSBtYh4uB/ZvjVlvmQdoo+qMNSsNRiwhwBB23gt0SMQKQW8bQy1TMG9uYqNXd8TfuvG/SKIl72Z0W1/YJxrNg==
Received: from DM6PR04CA0027.namprd04.prod.outlook.com (2603:10b6:5:334::32)
 by BY5PR12MB4999.namprd12.prod.outlook.com (2603:10b6:a03:1da::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.21; Wed, 26 Apr
 2023 12:32:03 +0000
Received: from DM6NAM11FT087.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:334:cafe::b8) by DM6PR04CA0027.outlook.office365.com
 (2603:10b6:5:334::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.21 via Frontend
 Transport; Wed, 26 Apr 2023 12:32:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DM6NAM11FT087.mail.protection.outlook.com (10.13.172.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6340.21 via Frontend Transport; Wed, 26 Apr 2023 12:32:03 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Wed, 26 Apr 2023
 05:31:51 -0700
Received: from dev.nvidia.com (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Wed, 26 Apr
 2023 05:31:50 -0700
From: Chaitanya Kulkarni <kch@nvidia.com>
To: <linux-nvme@lists.infradead.org>
CC: <kbusch@kernel.org>, <axboe@fb.com>, <hch@lst.de>, <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>
Subject: [PATCH 3/3] nvme-tcp:  use helper to reduce common code
Date: Wed, 26 Apr 2023 05:31:19 -0700
Message-ID: <20230426123119.8738-3-kch@nvidia.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230426123119.8738-1-kch@nvidia.com>
References: <20230426123119.8738-1-kch@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.37]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT087:EE_|BY5PR12MB4999:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f68708c-bcba-4789-afda-08db46523d65
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 	SYbUky3bktYexyqKyczPCN4/Clp+jVN20jq51im4mUl1GJYSDJlCTcekbhsdDRD5LQ2/jOU9SeJZWAmqbV+W/W6mcNhgkmjTfDuqCO8dV/wSqATxmwrr2Xyj3rV0Aq59vGrMvrZvUdVJM5iHnc6LHmlSotBSaAV1ZmZj7kSqoiKglwl5hi7JInHvBIqTv30bJ3jf5MoJHZO/fXyNnuvaJDJ/Ts4NWcBSHQVY/xsSWITnK+3kcxkvw2NtwWcjv7Xbc3QJ6DsAUKRKct830alk4IW08cy2YQyCLaXfqMwOZs5ijH3Go4er4xqxCFgZ9cNONQFS0LztzgKL/B6xyv1YiSuAUcRsUGJEBBdrthtblPfu2bb2tIs6ufi5yj7wJeK9XgkHGhO2DzFQaAX2/nSRLv4FqGVUvFErUM3S5Jt+5WReU+Z9HYT/DKnSUsikT9G6j+3iKfWiI4i3yrjSf/SnndD/QLJUftYwcsfJMkmXJr2Tvn4NvCOynkfoEscoAJ69+EXR+ZN8cJrLiM7iu0aHAqSq+27Hr9yY9cON87XxSh6KNHOai5rQT84odfS9AfAYa3sSLd4208exajxf/yy1c8hlI+RtC1NTqRj2A3BsE2s6kjj+gUopHUh1o360d0ohjzFf1xO3EHKj0qVrNp5MyfMEjCUNC7grIvy/mN5OAXwJyuaiixN/oT3rpC3GakJFS10frWKKcFBLaRvnIph2v+W7oVuWBRKuvobjQaPMkFI=
X-Forefront-Antispam-Report: 	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(346002)(39860400002)(376002)(451199021)(36840700001)(40470700004)(46966006)(316002)(4326008)(40460700003)(6916009)(70586007)(70206006)(107886003)(54906003)(34020700004)(82310400005)(6666004)(7696005)(40480700001)(478600001)(36756003)(186003)(16526019)(1076003)(26005)(41300700001)(7636003)(356005)(2616005)(36860700001)(47076005)(4744005)(2906002)(5660300002)(426003)(336012)(8936002)(83380400001)(8676002)(82740400003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2023 12:32:03.2987
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f68708c-bcba-4789-afda-08db46523d65
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: 	DM6NAM11FT087.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4999
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230426_053210_679489_C7E782B9 
X-CRM114-Status: GOOD (  10.31  )
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

Instaed of duplicating same code in every transport to print
ctrl->io_queues, use helper for nvme-tcp transport to remove
repetative code.

Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
---
 drivers/nvme/host/tcp.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 273c1f2760a4..1d775ecc6aa4 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -2464,11 +2464,7 @@ static void nvme_tcp_map_queues(struct blk_mq_tag_set *set)
 		blk_mq_map_queues(&set->map[HCTX_TYPE_POLL]);
 	}
 
-	dev_info(ctrl->ctrl.device,
-		"mapped %d/%d/%d default/read/poll queues.\n",
-		ctrl->io_queues[HCTX_TYPE_DEFAULT],
-		ctrl->io_queues[HCTX_TYPE_READ],
-		ctrl->io_queues[HCTX_TYPE_POLL]);
+	nvme_ctrl_print_io_queues(&ctrl->ctrl, ctrl->io_queues);
 }
 
 static int nvme_tcp_poll(struct blk_mq_hw_ctx *hctx, struct io_comp_batch *iob)
-- 
2.40.0


