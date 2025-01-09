Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 993B1E77197
	for <linux-nvme@archiver.kernel.org>; Thu,  9 Jan 2025 06:31:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=eQQ74hIVXs68yGw0zGU+4Mzwomi/Xpi5ZLmDbjPcMGg=; b=DKgmC9LjKanMzhkz3laE99n8M/
	yHqtqZATugB3nPUe6ZBThusG5kjr6aj2uqYCBi/Fa92rp3tzcSEfMTWmVfdzVOY1ye13pZv7xofHv
	mBKFsvD2FR3hq0Q2tbQxRAkJJDHiGBr0JY+3zFIAxJ0lveQSNlzzaliq5KSGIGB0Zza8kiNeZ4cv4
	zYFXAHFmVZghJl+VWDYsYvh0YXJFSx6RJWIWGHNutTxsvR6YEqh+eK0JESjt3dRZ2T9DXnvpCYYRj
	Cz3h2HIByrOFG2vRUiiaOALXSzpL/McR44yU+TPeG+7bOREU2EFvQmT21kOLU6chsUO60WE4iBJyU
	eNEFiCKQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tVm4o-0000000Avl0-3ez4;
	Thu, 09 Jan 2025 06:31:30 +0000
Received: from mail-dm6nam11on2060d.outbound.protection.outlook.com ([2a01:111:f403:2415::60d] helo=NAM11-DM6-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tVm4l-0000000Avjb-3AId
	for linux-nvme@lists.infradead.org;
	Thu, 09 Jan 2025 06:31:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=agcwJOZ4msi/DbUDbRT8m/HHjkWTdNQSjFIFO6fWWgpqH6rzcxZb8ld0uj347IH1xTRJOfxoXUvpIXbozmasZC3A5v8hGzZEhfhw6DECMvrxZQFWuz2T4d2/X8crmQMgYpxv/bUE8FQQ1M8Db36BKmWyYuUBeyBmScdZxaoyufVS64OiGYjXyrZDBllFOdzrL1s898zfgFxzhY3uXNyaEDI5o02loBxl+SNWDfefPXFgmHKhMlkPABY0LTg2JOfCCDcVnNrUEdrbeXbT2VKqPcqytDlPyf080B3tEjjfgvjvrwt0ZoHOxQaPiCuIAUUBDyOzo0osgVFUpD39Fuzt1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eQQ74hIVXs68yGw0zGU+4Mzwomi/Xpi5ZLmDbjPcMGg=;
 b=SOwl5Q4PM55KGNJ0rqTPUYACkCCfkNRUNd3v3DCILOQPDR4awEepy8sKjoRqfme0kk/UYhDHDlMNP1TJpDHqrtREC2hDtcA9cb0Gve7QIdIzH9tGjpmLMvuLSOKQjLH4jrNtTCX0Vxi+UunJSmjmKJmsbF3Yx2z3GW9qGYPzqcxEap7+VCCxw5kHdufvDvUDiBXp5ZPTwxa3DA75n0hI56Hyz15E0vXwceWRAFfpyrnJzmo7DpCon4q3tzVRDdjz3mzJ+u8U6M6P9Dn99iZDRx70hRZKGEFatzecUGKRFonmZ2lAJi4mCjnnZnLs1F9vCMH+RWVBwM0h5dXzENz++w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=lists.infradead.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eQQ74hIVXs68yGw0zGU+4Mzwomi/Xpi5ZLmDbjPcMGg=;
 b=KlzoDzhyYoSn5O1u4XrQZP7TJbfc3Lv2PzkHho5snVwoKYdatzodpgx1CkDr2/MVoajJSlwaIzma+LqCud+ILQ65YfnymHUXH5HokJFY4MkoKcYvMPc83O98F40F8c9aE+xInThY/eItraqwepyYysN6EcxjMJLJLuIEkb0oL9oGtswPkYoCMLZm5hb7InCBsMFXjGumQ1zX8jKZcap5bmudpGMmLnPHa4NWo0Y6Fj7eeYjxx5hbPwc8VgweBMxfKvPs8khu6yRJ9HJqj2xmlYrSZ+gW5l3pWR1EIZYNEABVDVRS/bRl/qFqhUyHR4UYL2dPfXXsMweADJKwRsl8uQ==
Received: from CY8PR22CA0022.namprd22.prod.outlook.com (2603:10b6:930:45::25)
 by DM4PR12MB6495.namprd12.prod.outlook.com (2603:10b6:8:bc::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.11; Thu, 9 Jan
 2025 06:31:21 +0000
Received: from CY4PEPF0000E9D7.namprd05.prod.outlook.com
 (2603:10b6:930:45:cafe::63) by CY8PR22CA0022.outlook.office365.com
 (2603:10b6:930:45::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8335.11 via Frontend Transport; Thu,
 9 Jan 2025 06:31:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000E9D7.mail.protection.outlook.com (10.167.241.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8335.7 via Frontend Transport; Thu, 9 Jan 2025 06:31:20 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 8 Jan 2025
 22:31:08 -0800
Received: from dev.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 8 Jan 2025
 22:30:51 -0800
From: Chaitanya Kulkarni <kch@nvidia.com>
To: <linux-nvme@lists.infradead.org>
CC: <kbusch@kernel.org>, <hch@lst.de>, <sagi@grimberg.me>, Chaitanya Kulkarni
	<kch@nvidia.com>, kernel test robot <lkp@intel.com>
Subject: [PATCH 1/2] nvme-tcp: initialize the mq_map to NULL
Date: Wed, 8 Jan 2025 22:30:42 -0800
Message-ID: <20250109063043.95996-1-kch@nvidia.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D7:EE_|DM4PR12MB6495:EE_
X-MS-Office365-Filtering-Correlation-Id: 01d5dd0c-150b-4e6e-bd94-08dd30773b4f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|36860700013|1800799024|376014|82310400026;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?tD+rKFbYVZT6yKBftFtT9wuKMGPnQan1NRAjALGcm0Povft6PXCyL7V/0o7k?=
 =?us-ascii?Q?HUoK8AfdXkNj2wTXU0VcEumFtGiU7vduA/fwwhTdwYfAEJJvSJNtVL+bjURZ?=
 =?us-ascii?Q?kmFpLCCUB2RS3Lee5+fuv4hmfg+IUCa8slMMT1lkXpAM32SckuPohYgOdpGp?=
 =?us-ascii?Q?kP07rghMSAeTE7ZJuiZI5TZZnf+UseUTCI2b3rxfIcRzZCQwuLbHdX/8Bp6B?=
 =?us-ascii?Q?r1L2p7tta55Y3KCEeksmZg5M/NIvXf75D5v+5Yi5+M6iczbwp0tyHTwcj5aa?=
 =?us-ascii?Q?3nPZLS8ZgcLUJnbtkm9xlvqIjVn9oWUhn8kqZCvxGfLbYjcuYcAY0PHtp9QI?=
 =?us-ascii?Q?3HWYQ6NMXUZVI+iLj5lvSkIPRAP5PkkyyYLR9VMEeTR41H4m0SuTFkJduzQA?=
 =?us-ascii?Q?q2+gYpVBdoBNBCG4xK1Swbp9ihoV9k8bNLaK6XPJgUj1erqf+i1zb8TD8G1C?=
 =?us-ascii?Q?PoxWIBY+HRNnQNX0aFgYgJeWLRYKF7SdJYkO7RETC3bTxDTztjzsNFrPNOn0?=
 =?us-ascii?Q?i2i/r08lkFb+/k2ZzeNdy1QGESqLDrgNZ+3Qe9dCod8moUMAvuAvFveCKvh3?=
 =?us-ascii?Q?iQ1+ptDiiJGmyln1YDxiRywgV8vXpXNIS7uaBxaswELW9CaTIx97Gcw8IHjq?=
 =?us-ascii?Q?gvJQEDpIrgDKhRoPgFlaM4qmo6yLiMM/J+bFFb1g+TwNSH2nYx3dwDphzkfF?=
 =?us-ascii?Q?oL8+V9QNcK1gB0aUdOdNKQYIEBqdDiAA2wKrcMYYDzrnVEjp7DMR6zxkAyV7?=
 =?us-ascii?Q?uP45b24iE5jrlygFH6CbLbz2qU8I9DAi59mnJqPLf2vnA0pdOyWQsNuKeMXj?=
 =?us-ascii?Q?2yiKVZmtLnpv7ANRXi2eSLC43CwFnMV0goOKYAKTmRND0ev/IFy2MvQ9AUzH?=
 =?us-ascii?Q?fcpBVHbT9EyBQwzYiAH2FUj35E2jYP6ZQk84zKcjvXibkdRVGnDVBmw0uzfZ?=
 =?us-ascii?Q?J+mpvPa+mBXhiUobdKbHhz2avYa/01eR1gc0g5d+GcURhKPw/40hmm0VzrOZ?=
 =?us-ascii?Q?dyeUYx+xab87O521nlpLFA0cpkUrqt33qvQeaHwfPdLKZm5OyIwayNOGniL7?=
 =?us-ascii?Q?oezSRSwe65Fj2BvMatUi5eaJUPGRKJ4AZA1LBP1arkExdQ3gpsAAklDLB1g4?=
 =?us-ascii?Q?C2g2gvadC26p1OkmRJP1fLt+eBozsyMkeP+lNNpmicC112Y4FEWt3VgZ4gVn?=
 =?us-ascii?Q?4o+6OJXsjpgxOo3M/XPHuQCiaUDVUOhPd8iIePPUKfGDot6QX7I/CVnm81Id?=
 =?us-ascii?Q?SyoYqhi8ciy3GVwyLY8jx8kqxi1re8N0CfZIus+A2hRbkE5ovQYNs2cEg+ST?=
 =?us-ascii?Q?V5cEDg/fqe9mUZb8vt2VnHeHTv2C0RX9VAwtOg/7lhR9roaeZg+PjVnAeoWF?=
 =?us-ascii?Q?0KaQLSeefCmSO0UJc/81PWktoA+H/6Af8zh/hCLWjYB3I+Be+ykHOciVJlQL?=
 =?us-ascii?Q?g/XCD717ZBZr3pO0XMHX5WHkOFFE9UteTS+2CFjMlwF9b5wjgn+fliRTTmdU?=
 =?us-ascii?Q?MysbMxFtI2uQDV4=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2025 06:31:20.9395
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 01d5dd0c-150b-4e6e-bd94-08dd30773b4f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D7.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6495
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250108_223127_793842_F4B7E426 
X-CRM114-Status: GOOD (  11.40  )
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

Initialize the local variable mq_map to NULL to remove the kernel
test robot warning.

drivers/nvme/host/tcp.c:1594:13: warning: variable 'mq_map' is used
uninitialized whenever 'if' condition is false [-Wsometimes-uninitialized]

Fixes: bd0f5c103101 ("nvme-tcp: Fix I/O queue cpu spreading for multiple controllers")  
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202501091328.r4kJ6xhy-lkp@intel.com/
Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
---
 drivers/nvme/host/tcp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 544d6aa00cc3..d6a40b7dba73 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -1578,7 +1578,7 @@ static void nvme_tcp_set_queue_io_cpu(struct nvme_tcp_queue *queue)
 	struct nvme_tcp_ctrl *ctrl = queue->ctrl;
 	struct blk_mq_tag_set *set = &ctrl->tag_set;
 	int qid = nvme_tcp_queue_id(queue) - 1;
-	unsigned int *mq_map;
+	unsigned int *mq_map = NULL;
 	int cpu, n = 0, min_queues = INT_MAX, io_cpu;
 
 	if (wq_unbound)
-- 
2.40.0


