Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5289FD5F85
	for <linux-nvme@archiver.kernel.org>; Wed,  8 Apr 2026 07:26:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=unQGZHVKOjY4ixC3nvzGurmZysmJig24SwPwqpNd7QE=; b=PnGoZxmdWONoKdDHanY7CRXlAO
	PeXX+9tswhM1fcB+3qXgYTZLiUcGHteJA+LvQ+pinEM8qJvSFIoeXgDg1JbsTh+Q5SF7cMvD5nQ+s
	4W2cgKXsK/t9oHITH6qO4jZS85g6i79/TJlk0WL8ILTP5XYPBunrQQV9FLi0pveEJa4dgly0pYDEe
	3Tvb0I0UhEn636Cv5iJrXigD1lcy+GmIH+T/2+uoB/fhJLQKDAd99l2VrBkXlwOV0rsBzFjw7CGPG
	SRLHuUoigaWAXGSSSAghts2Qu4ewK4IquYlh+DDooDSnDxqOgtUsNUDUK1amyWl0rZDg/5h1nOxck
	wK0juoeg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wANIs-00000008QTa-20Uh;
	Wed, 08 Apr 2026 07:26:22 +0000
Received: from mail-westus3azlp170120001.outbound.protection.outlook.com ([2a01:111:f403:c107::1] helo=PH8PR06CU001.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wANIo-00000008QSJ-2cGP
	for linux-nvme@lists.infradead.org;
	Wed, 08 Apr 2026 07:26:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WhX03Nt++d5t2RNQiGqkTZn4xR7spkHkRxs1yBTpuVupMX2e10LXvuVETYxJKQM81wZWMhsabTRgHZtAGR/ph4lD1XAXUIKxp5Oqe1Utx7k9HXQlbqGo5FYtDFLuDhi6hAEPrF/xArqnxCfXL2BOx4zu7y4Nygk4rawNJMNq/ad6K+vXjl/iZhF+/4WRBputlw+Yg9Gn0ur8ZuadrGXVspwFIRwWxeZLpILpT9B/NIdAASNGXjZw+IWUzEv2xdYSJgkM50GNKUyqe7oFvkk9L25iRlbqhymZMLVRH/G0c5G+sDpZtBmf3WE8nup775uEPWloHfwTLWJ/dO8XNIdPlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=unQGZHVKOjY4ixC3nvzGurmZysmJig24SwPwqpNd7QE=;
 b=laMylPrxaPfxVN7Ta2tP1QWd47sMmFOEZdqgVxkv8oQRvzvbpbqOkmkvYBNnvh89CJ4EOWsC2k3eLPowch1I/6WQGwZqPdRx2FrfGBN0AE/igMdFi/mkHjYRzHm/uz9hGDpVmLj2F0dN6Yyc6D5eVXRL0mpG1I+/SHZiNvYusFQGFSGBYon/fPYGAciW60mMZ9MTSvMmnXdpabEX6TTwYk0c+3aR3/pz4lWsH2NFbmI5h2z52hTarpP1VlY8wOypPRVeYQEj1RlSoX6OJzbCfYdqpp7TyaSo1sCMo9k5SLIkLY6zlEzKraDInu89gEzsBQeht3d5dAW9KN7rb0bT5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=unQGZHVKOjY4ixC3nvzGurmZysmJig24SwPwqpNd7QE=;
 b=Z9D329Nj99Ph9ryaljejfNA7JbCdaHmIxMMJ+Pa6h0z41lwWuG9c+dGMEV1XNzYLS5fdQ0gYU6KFPx2gR7VkhRC2U61KyRGCQjSDR+TAsaMy3LZ2sR37h/5XeLEaQp1aAsHX1NrZtX7IS4qeYPzAQNtc9ap8BYjk1ABwkYUzYyQDZNk6h3rKu0rcCP28KpH3zfDHg1nGuTwQSsWhLlDvpocbZbRHl30XONYcqO13egIxn4fdQAOwqv+jHBKeW8Ryine7+VZwMoe0XXpbpdPw2K9AOhJP8D0lpetgAOGMs09cbUavXXrgjp2J8PQF9UBugyq8/PW6VHQCPucRlHUl/g==
Received: from BY5PR13CA0015.namprd13.prod.outlook.com (2603:10b6:a03:180::28)
 by PH0PR12MB7813.namprd12.prod.outlook.com (2603:10b6:510:286::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.19; Wed, 8 Apr
 2026 07:26:09 +0000
Received: from SJ5PEPF000001CC.namprd05.prod.outlook.com
 (2603:10b6:a03:180:cafe::e6) by BY5PR13CA0015.outlook.office365.com
 (2603:10b6:a03:180::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.33 via Frontend Transport; Wed,
 8 Apr 2026 07:26:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ5PEPF000001CC.mail.protection.outlook.com (10.167.242.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Wed, 8 Apr 2026 07:26:09 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 8 Apr
 2026 00:25:56 -0700
Received: from dev.nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 8 Apr
 2026 00:25:56 -0700
From: Chaitanya Kulkarni <kch@nvidia.com>
To: <song@kernel.org>, <yukuai@fnnas.com>, <linan122@huawei.com>,
	<kbusch@kernel.org>, <axboe@kernel.dk>, <hch@lst.de>, <sagi@grimberg.me>
CC: <linux-raid@vger.kernel.org>, <linux-nvme@lists.infradead.org>,
	<kmodukuri@nvidia.com>, Chaitanya Kulkarni <kch@nvidia.com>
Subject: [PATCH V2 1/2] md: propagate BLK_FEAT_PCI_P2PDMA from member devices
Date: Wed, 8 Apr 2026 00:25:36 -0700
Message-ID: <20260408072537.46540-2-kch@nvidia.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260408072537.46540-1-kch@nvidia.com>
References: <20260408072537.46540-1-kch@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CC:EE_|PH0PR12MB7813:EE_
X-MS-Office365-Filtering-Correlation-Id: 18799628-cd4f-4ae7-a754-08de95401abc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|82310400026|36860700016|376014|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: LW3V286HRc+Ei7ayYTkuvvgcJc+Dn+SW+y68mYdWIumaVcQs/Q9Xo8QNnPJt7611Ak4rlduc2Ah25US6PJOz6Q0HY3AQeiC5xqLfiP+kh2coH5nAUWmIEhPyW/6dNwKdBhpcexlqOBxajwC/JdHHSttJ5MeddEHkf3KPRolIuHeIe+AluqY+y4YRPOCWcIaO/BefjUqRHbdvFLfbyJRFhpxNM4u8SFsfHhN/dz1xqTlIDfmgeceIkWP7U2LtuA0nSxHkatWrxpnlAO0KJVVAWnL4uq1C9zBYSxi8XjAPUGSyo4zW38PnxfC1D/2MjymfZZIFgwoNCIxmCF+PXeFiWHdCRYeT2ylE2n/G/WEeRe/I+5+EkY7oESftMdAUcCZPO/cw4ZuWyms0kx5uNG3Kit7Pf1+7MWn4K5qbl+77RwPm4V2Ye817pBVHmOgY5rL6xOu7RDahjrjGgpi49iOV69fzJThzUigBUGP196qQ/Aj++o8bEk/Uz2kH1eHHIOW1LkjYP+W6vB1wBp9dp1/IlMjEQwIIngaRt+wVYvzt5+ZDUNWKwChEE2RNRE4kY25yam2J8iOve9QvD1DpTCVPetQ0JRfkkHEWKiuUIDZAnlZHJH+xmGI7o6lSAVf2XdgJrg6w8YjSqgbkIc+FgTzZlKhbv05MpSCgx9Y1oQr+kJjXK1ErSNHArRKL57JGZNkMSb0ZEZNyHMiQu5VzwR+bk1PW3j4XCsw+RH2QCcLhZrHs/X60QPnYT+HeQD6r5Et+o+3DIYxSUFFacv8Vm8pkLw==
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: TGzFVSJAmmzC0khhc31zjt8GGkYv04rbOo4Wq4/O5IMeJyKEEwq93w6GB8QimGhEF+d5P4BaNm1cOZpavQL980Nqj8rhQHpuZYwClTfpTu1sXiAj/cKTxD2zRzyAzAY1pPwrhhJ6RGzU8fiY4EQM9sDTZAl45wUU1cf102jnTuUQyMIi3y/f+XnioETUML1PIdaeLdPH3dyFlk6Z8rQvgnRQuKQCJAone9Rfj05EO1cfr/Z9ByQUWYqJ3e2TV20/wLWHXN07akcxBXoElFcO9z8Up2sem/4a8yy2+0xrFQY4T393aTQIkuDq55b7g6NFxGLOatkuTi/ZJC8SMqvBaVbO13tO2RtXFIyqjkK6h7ZsmYcJgk4gMVGstxej5zv9vE/DNieGnGr3hAnvHFEBGaBBGQUU9FGaFJKmivLNGnQVLZ92XHm3wwGrAztxmaw2
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2026 07:26:09.1881
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 18799628-cd4f-4ae7-a754-08de95401abc
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001CC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7813
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260408_002618_666991_BDD7F9C5 
X-CRM114-Status: GOOD (  10.83  )
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

From: Kiran Kumar Modukuri <kmodukuri@nvidia.com>

MD RAID does not propagate BLK_FEAT_PCI_P2PDMA from member devices to
the RAID device, preventing peer-to-peer DMA through the RAID layer even
when all underlying devices support it.

Enable BLK_FEAT_PCI_P2PDMA in raid0, raid1 and raid10 personalities
during queue limits setup and clear it in mddev_stack_rdev_limits()
during array init and mddev_stack_new_rdev() during hot-add if any
member device lacks support. Parity RAID personalities (raid4/5/6) are
excluded because they need CPU access to data pages for parity
computation, which is incompatible with P2P mappings.

Tested with RAID0/1/10 arrays containing multiple NVMe devices with P2PDMA
support, confirming that peer-to-peer transfers work correctly through
the RAID layer.

Signed-off-by: Kiran Kumar Modukuri <kmodukuri@nvidia.com>
Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
---
 drivers/md/md.c     | 4 ++++
 drivers/md/raid0.c  | 1 +
 drivers/md/raid1.c  | 1 +
 drivers/md/raid10.c | 1 +
 4 files changed, 7 insertions(+)

diff --git a/drivers/md/md.c b/drivers/md/md.c
index 521d9b34cd9e..48d7a3ca8c66 100644
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
diff --git a/drivers/md/raid0.c b/drivers/md/raid0.c
index ef0045db409f..1cdcafd31744 100644
--- a/drivers/md/raid0.c
+++ b/drivers/md/raid0.c
@@ -392,6 +392,7 @@ static int raid0_set_limits(struct mddev *mddev)
 	lim.io_opt = lim.io_min * mddev->raid_disks;
 	lim.chunk_sectors = mddev->chunk_sectors;
 	lim.features |= BLK_FEAT_ATOMIC_WRITES;
+	lim.features |= BLK_FEAT_PCI_P2PDMA;
 	err = mddev_stack_rdev_limits(mddev, &lim, MDDEV_STACK_INTEGRITY);
 	if (err)
 		return err;
diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
index 16f671ab12c0..b25e661e9738 100644
--- a/drivers/md/raid1.c
+++ b/drivers/md/raid1.c
@@ -3192,6 +3192,7 @@ static int raid1_set_limits(struct mddev *mddev)
 	lim.max_hw_wzeroes_unmap_sectors = 0;
 	lim.logical_block_size = mddev->logical_block_size;
 	lim.features |= BLK_FEAT_ATOMIC_WRITES;
+	lim.features |= BLK_FEAT_PCI_P2PDMA;
 	err = mddev_stack_rdev_limits(mddev, &lim, MDDEV_STACK_INTEGRITY);
 	if (err)
 		return err;
diff --git a/drivers/md/raid10.c b/drivers/md/raid10.c
index 4901ebe45c87..07a5b734c8f3 100644
--- a/drivers/md/raid10.c
+++ b/drivers/md/raid10.c
@@ -3939,6 +3939,7 @@ static int raid10_set_queue_limits(struct mddev *mddev)
 	lim.chunk_sectors = mddev->chunk_sectors;
 	lim.io_opt = lim.io_min * raid10_nr_stripes(conf);
 	lim.features |= BLK_FEAT_ATOMIC_WRITES;
+	lim.features |= BLK_FEAT_PCI_P2PDMA;
 	err = mddev_stack_rdev_limits(mddev, &lim, MDDEV_STACK_INTEGRITY);
 	if (err)
 		return err;
-- 
2.39.5


