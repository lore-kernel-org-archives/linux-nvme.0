Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8F9AFC72C5
	for <linux-nvme@archiver.kernel.org>; Mon, 23 Mar 2026 23:45:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9DzY4QSGItBBsqpGZxRdeUNjXA9lLXqNeng4kQpa9nY=; b=UTU9ClJmVEsrFavbqKgtLC+UlY
	5BTpVJ8GIzizveB/EB/qi07RzfoArze5kcCy5T3DQXiMJIGpB06uHjydFsBzGfhw4yWIkFuFL9aFW
	LBglxu9W6CFCYP6xChhsH3/Ajb6YTit2E6YtZS+X32nOlm96gdEFGYj80lB6dp4xS/30RUKDzQ+KC
	QsIgv1RVsab/4LkOCIT1aROIjmDLLWwCRGSF9xtVcWBhxHHZnpobFOO4ga4ugKkTui+bQU5wEtiaK
	WwqN3MyRwi81PYd/+KagU0CMXCHxifDCRmvm5g1EaZaV7cIKPxXwC0AuhseEd6M1oxW90WMaxnXNj
	Iwi4NOGQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w4oxA-000000009un-0xeb;
	Mon, 23 Mar 2026 23:45:00 +0000
Received: from mail-centralusazon11010062.outbound.protection.outlook.com ([52.101.61.62] helo=DM1PR04CU001.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w4ox7-000000009u8-2Isf
	for linux-nvme@lists.infradead.org;
	Mon, 23 Mar 2026 23:44:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I5bGlTUYoO4IE8PXenSw5cFshzw10I2OZdEOxd4xjEddMmkR0JLitsm8KgXeweIAcOcms+tyxgVQKR8ofnnozoD5VXzHx+E29qWHFYBPSn0sF2ZKxI05GwMDTRB8hB8jg2c2flma9McCmvj3RuachVXCd4M1wJNid7DRheelkvdsrHhf3HkjMkwulE1T8NDV8+DLZ2cpAEt2uwsuT34uj27+tkIqs6cf/f1I4wcqJV8cXkZgHbUn9pSBs4y/nbEK/b8fX4Q8H9VPsuWv3Palcq/liJzAn/06nJ1VVDt2fsTixHn0DLPDwP/9AcAm1GlThAk/olmj4sBODnq2Aot9Hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9DzY4QSGItBBsqpGZxRdeUNjXA9lLXqNeng4kQpa9nY=;
 b=gEkZ8pLA6GMdCvYZGqnzsC7IkFb3HDiNw+FlF9Aubb1CUG6wM2sbvxnINSUIHPvzNH3SA0fCjDithSekkTGAvz0QwADejwN7hM8OyMzZShnmYlq2maktNeH7TJL/QmYdVFS39EgwktJz8rvh3yQIvKk2jZlhlpKc6c5jLb8IzOT4hP0Xca9on5s6V3XkAvD5oAuSYEaYkYjOqC+R2xFywItdXsBg6x/gpmQ+6t/yJTZszM4zht9X/b3RlBJ39RmdMDdP0uAJfMeB4yhLHR6PRfZnD6ogozPc/n2X2SXDYgy32gCOUDx1IgUPzxKlCBXQSI0D+tT8eG/bjrEPEuBN4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9DzY4QSGItBBsqpGZxRdeUNjXA9lLXqNeng4kQpa9nY=;
 b=BuHRvVtY32GshY/sqiTkF67DN6aXdU9fsQZsnT40xteBFFCHWPI2Lbpv9IInx5VrhaAlTMgOY9Qvei040qaYSesC31i0L88ZXhaxYbHJaJbuEeXEk44dXSRFe7yHaxuGYumEN0YOaVUVPprjZENix7aJSysRxmtZsf5uR1VjyGPFBqWVfPyZkEHs14ca7hM1E1JATq5akcnHm0zxihYoX6omMHXmyRO2friW/2KTBYQwXM+sPiH3F70TNKht1uEBHHvmFSMLdFB2f/I6yXm2hjMyBPiUNwSmsAR0rTJY9rXsHMA/XsWoI2ZpL2VIog4lTevGEmIARDPLlUzQ8mAX+g==
Received: from CH5PR05CA0005.namprd05.prod.outlook.com (2603:10b6:610:1f0::6)
 by DM4PR12MB7742.namprd12.prod.outlook.com (2603:10b6:8:102::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Mon, 23 Mar
 2026 23:44:49 +0000
Received: from CH1PEPF0000AD7C.namprd04.prod.outlook.com
 (2603:10b6:610:1f0:cafe::dd) by CH5PR05CA0005.outlook.office365.com
 (2603:10b6:610:1f0::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.31 via Frontend
 Transport; Mon, 23 Mar 2026 23:44:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH1PEPF0000AD7C.mail.protection.outlook.com (10.167.244.84) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Mon, 23 Mar 2026 23:44:49 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 23 Mar
 2026 16:44:35 -0700
Received: from dev.nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 23 Mar
 2026 16:44:34 -0700
From: Chaitanya Kulkarni <kch@nvidia.com>
To: <song@kernel.org>, <yukuai@fnnas.com>, <linan122@huawei.com>,
	<kbusch@kernel.org>, <axboe@kernel.dk>, <hch@lst.de>, <sagi@grimberg.me>
CC: <linux-raid@vger.kernel.org>, <linux-nvme@lists.infradead.org>, "Chaitanya
 Kulkarni" <kch@nvidia.com>, Kiran Kumar Modukuri <kmodukuri@nvidia.com>
Subject: [PATCH 1/2] md: Add PCI_P2PDMA support for MD RAID volumes
Date: Mon, 23 Mar 2026 16:44:15 -0700
Message-ID: <20260323234416.46944-2-kch@nvidia.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260323234416.46944-1-kch@nvidia.com>
References: <20260323234416.46944-1-kch@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7C:EE_|DM4PR12MB7742:EE_
X-MS-Office365-Filtering-Correlation-Id: 85204bfe-295c-445b-71b1-08de89362bfd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|36860700016|82310400026|1800799024|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: kZoTXbL0wirYq4en4Jaf9CpzweG7Ckhh/tYb/N771VKwV2hPPw+QnsMSpp2+bqZRYeyaK20CFLfJodgnZRbQ2bhlzdlD657Wa0AHelWIJDZfeUTe34SV8HqzVYG4xXE+yvwYDq2OV6C/9j51gzL6vVhznAiRs5fbUpfaE0FFva4dUb6r5vu/NVzAqaFtBXSJh2k0kJJLdqAA6fPnHbLghaXad8OLb9TWvbqNdYjCogaiSO4/iIT2Nxokjyr5Tuu/QvNke4as+CmxZs9MTI22Sj9NURnMDXIZZXsqqNrP8nNyQRzSTJJ7cfClbJztpuIwrYykdOJMSYWfOgiEeEW0im7STAEojsMMJw0R5mNgBwEFiU56EwxgLuRuvqWKX4VFDH0UQguBBQpIjNseI+jbVodTDxMFjYDV1gdBRbmBnHE93z8v5BHYKl+mgRUp+KygUXfqgCtRS2PHGZNsqnOl6Xhx6YJIjRYR8iuWZKVwnieV21f9sxmSvfbnz4BrV/SUgrdGuQneHzxl4G0oLm8Bpy/aXa7iDL1ON78NqJUGUIeN04XmIs21+55YmBMK639eiZIAErfDSG1Vyku1UDw9xKIluz6vHDkYdjQGo1XhyRjhJQT/nFdlKtvY0g8wMHHSVyKs5RbjzsnzDwbF6bbCqp/yM1B349IuVZq4VskNlQyb8mddXdQSylb3E32RVtn4P8W+na+5TGr4wWcJBj211VsWwHEgvr2ZqZt2CHT7Mby7dWltvuXcTXFHtaB9JxcxkOCni0lx0vSrTelS/2AfwQ==
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(36860700016)(82310400026)(1800799024)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: zGSLHnPPsEtkRjQSrTQR+8QidO9uf7YPe0b8CBy+Z7lZw+cr89EzookyjzQ0Ii/egItVuaa9nTGols/EcPAXnaxAlUhrLhRINU8fK1+YiAU4CTxDHQkHCkpFn3uZ+lCa+EyBcrNU3lKXtNvzenFwY5RmhH3om6ZTt7j1LWvdZV2f+r/QzkOR3XG5AYarqnjEKq/BXHEhATRQ2EQXceB5fXTaQZhd4hggJis637nYcbJFr/1tdPz4tLZF5GEV98uueQXe2mHwVt5T8eokH0q6biS4/YWQCz7apnRGmoUtfD+LpGYgTc/nedbNGMtcVDtnN0FNwMvjidmixwScz4xH0U5H3rexzCG/AQ8zWHfL0wBCBiSwyNQ7r/Bv59YLapr/WD0WjwaOeeFZAWjCXvzGlxj0ajtlUI9uvMzpBCnKQeb9M0DeMen50urwcmn78SMf
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2026 23:44:49.0762
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 85204bfe-295c-445b-71b1-08de89362bfd
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD7C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7742
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260323_164458_033034_D9E73A8B 
X-CRM114-Status: GOOD (  10.68  )
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

MD RAID does not propagate BLK_FEAT_PCI_P2PDMA from member devices to
the RAID device, preventing peer-to-peer DMA through the RAID layer even
when all underlying devices support it.

Enable BLK_FEAT_PCI_P2PDMA by default in md_init_stacking_limits() and
clear it in mddev_stack_rdev_limits() during array init and 
mddev_stack_new_rdev() during hot-add if any member device lacks support.

Tested with RAID arrays containing multiple NVMe devices with P2PDMA
support, confirming that peer-to-peer transfers work correctly through
the RAID layer.

Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
Signed-off-by: Kiran Kumar Modukuri <kmodukuri@nvidia.com>
---
 drivers/md/md.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/md/md.c b/drivers/md/md.c
index 521d9b34cd9e..a151ea86d844 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -6176,6 +6176,8 @@ int mddev_stack_rdev_limits(struct mddev *mddev, struct queue_limits *lim,
 		if ((flags & MDDEV_STACK_INTEGRITY) &&
 		    !queue_limits_stack_integrity_bdev(lim, rdev->bdev))
 			return -EINVAL;
+		if (!blk_queue_pci_p2pdma(rdev->bdev->bd_disk->queue))
+			lim->features &= ~BLK_FEAT_PCI_P2PDMA;
 	}
 
 	/*
@@ -6231,6 +6233,8 @@ int mddev_stack_new_rdev(struct mddev *mddev, struct md_rdev *rdev)
 	lim = queue_limits_start_update(mddev->gendisk->queue);
 	queue_limits_stack_bdev(&lim, rdev->bdev, rdev->data_offset,
 				mddev->gendisk->disk_name);
+	if (!blk_queue_pci_p2pdma(rdev->bdev->bd_disk->queue))
+		lim.features &= ~BLK_FEAT_PCI_P2PDMA;
 
 	if (!queue_limits_stack_integrity_bdev(&lim, rdev->bdev)) {
 		pr_err("%s: incompatible integrity profile for %pg\n",
@@ -6272,7 +6276,8 @@ void md_init_stacking_limits(struct queue_limits *lim)
 {
 	blk_set_stacking_limits(lim);
 	lim->features = BLK_FEAT_WRITE_CACHE | BLK_FEAT_FUA |
-			BLK_FEAT_IO_STAT | BLK_FEAT_NOWAIT;
+			BLK_FEAT_IO_STAT | BLK_FEAT_NOWAIT |
+			BLK_FEAT_PCI_P2PDMA;
 }
 EXPORT_SYMBOL_GPL(md_init_stacking_limits);
 
-- 
2.39.5


