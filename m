Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2A3EC77B60
	for <linux-nvme@archiver.kernel.org>; Wed, 26 Apr 2023 12:31:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=2VkrTubF+wTl8cCMZ1vZHLsXjz0owfJWbzimsChw4l0=; b=FA5800SKVzXhG/9KiesXtxTnRF
	jMphoXWac1w+bhzRzeoFOVTRwKEgrKjj8+5VR3xVDqk6QRyCpCCCYGyeDsEqsBLBucvlNdfN0Iwi1
	gMDVeifmqha8hX0yMwMZqpv79oNusqdJKpIDF4oqZtxsydvBXBU3AslR8VQsdDjSkAS4yaWXvWk03
	iM1ZKU9lhz7lXiZVgkyP9DCWMq1dX0/kMZuDlwqCK6n6hX1PqMq9Zvu8RoyAGuyPNu3URNhlcRwfk
	sCJILDOQ+EB9ypLv1M9CCl0x9A5ARXp6APOgu0uI9a99rieO9/4jr8ai7+P9BpTN7cPS8L5PIYSBC
	isxCkq5g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1preJG-003v9q-2K;
	Wed, 26 Apr 2023 12:31:46 +0000
Received: from mail-co1nam11on20612.outbound.protection.outlook.com ([2a01:111:f400:7eab::612] helo=NAM11-CO1-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1preJD-003v8W-0V
	for linux-nvme@lists.infradead.org;
	Wed, 26 Apr 2023 12:31:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oIt+VSXRvq44YSoLTtW1jl+YuzQmqdUfiZT3TmDad5TpRhOKTpXU/Rz7W91c4Ivyy/a+TxZO8/BECmx/jONkVqSYzQVzXKBIdBdwLQ4+WnzlMW2jPtNSMr/erzUeNC4GOEwNxANK5Oz/grujyLkCGnzYi0ATpa43hiFzfNaChZhDg8Koq/cwcXplbrh8TZUC+tpQWN725kOZWF5sESRlUlktnYc18XlBSOQa0jnR2NKCo7VJsGw6fuvj7aswRwLq9x3fZyhwg08w1qrNqA2ol6+6eh82Gipv2s0H4sG5//6E155TYw3JXuh4AnJf91eLgyCz3nKiSbmBMmSsthGVEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2VkrTubF+wTl8cCMZ1vZHLsXjz0owfJWbzimsChw4l0=;
 b=j+qMBWJ/7gCwPmLk0IO2EKsqZuf4y1Ovkt4sS2eNdM6PbNdofIJY59yR9JGYHTqJ6PhGMj13tADNqqQn37GIrtaVrG6WIvnN/0wUEiXoUzooaSoOhgYEfTQqD9J4zzNsqggo9ZfgTGtf/E32Qr2Md3iAcKXVKl3k1G9cVtdaPnrtIoHflH9YUr6Iw4Mzj0k6/z+FWdd3WfQlmtUR4X7+NsFe6yCdInnfeGlM4NStNdfyVVbS1QCUHiEeKKVjpl97kyff4ueq6tdh6b/+zmuAwKvFDWFhgdBvwe58nHe5lcKVZRxy75naLpG6yWP6yqnLBVut0Ereo+uGhOmF8DuDfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=lists.infradead.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2VkrTubF+wTl8cCMZ1vZHLsXjz0owfJWbzimsChw4l0=;
 b=c5vi1p44dBBXl4lm7xGIADoxe9gw2xKGPzjyWMvBFS9EDeDpRZiQUaqcE1nNhXF3wJniGiFc9Sd/yrL++UJ0D55mAmqaUXDHQeQwHuxuUmZX4CfSXEfIE+fYvjdtqe4kaGEbt6SSy3VWaUuurRHjobdtd7RUZJJ+03CMDRX4O6WrgEQI0CaglI6mUX6FHO7SGrIY+TUYEemadNF0bkXOAL8QcdZAoI5HSjtmD+bPL0T47rOQuVJwuSJBheXYn1LS4+e2TX6pc3XxqvYlFiGzHrzOU8yvhManY8ZRTn8G4x2oP5g2pmZNHgDH+szLw0Ic0ZjbwwP7Se1/yn7K3l5iTw==
Received: from DS7PR05CA0001.namprd05.prod.outlook.com (2603:10b6:5:3b9::6) by
 SN7PR12MB8057.namprd12.prod.outlook.com (2603:10b6:806:34a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.20; Wed, 26 Apr
 2023 12:31:39 +0000
Received: from DM6NAM11FT072.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b9:cafe::f5) by DS7PR05CA0001.outlook.office365.com
 (2603:10b6:5:3b9::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.20 via Frontend
 Transport; Wed, 26 Apr 2023 12:31:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DM6NAM11FT072.mail.protection.outlook.com (10.13.173.181) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6340.21 via Frontend Transport; Wed, 26 Apr 2023 12:31:39 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Wed, 26 Apr 2023
 05:31:27 -0700
Received: from dev.nvidia.com (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Wed, 26 Apr
 2023 05:31:26 -0700
From: Chaitanya Kulkarni <kch@nvidia.com>
To: <linux-nvme@lists.infradead.org>
CC: <kbusch@kernel.org>, <axboe@fb.com>, <hch@lst.de>, <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>
Subject: [PATCH 1/3] nvme-pci: add and use print io-queues helper
Date: Wed, 26 Apr 2023 05:31:17 -0700
Message-ID: <20230426123119.8738-1-kch@nvidia.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.37]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT072:EE_|SN7PR12MB8057:EE_
X-MS-Office365-Filtering-Correlation-Id: bc4abbdf-a971-4a94-7d7b-08db46522f29
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 	dpy8F6LjVspAliGR81gjyC5CMcSpqHSARB64JQ6Xh8hzkqKDhmk8tPqdUw6fB1abhRatZAg8CYYdb/EpzbGVmJCaSND04k8rVxWPdikMZU86SyRaWjmFlZKKPKzlA8e33hA4U7jj5ypd/UHCJIPDULMz6he+IRcBbvKALe3Y5zAFs0e4ZUcCrJdCQzWaecVUuhu4NoYJCIf8Spe/yibTaLv/ejfLET+VXTxOmo4GuR2leIZasHckNQjX2W908Kq71gal7Hl9GQc5Y2QBnsWxktZQT8mIVBHRMrkMQEoYiecYXG4oQXij+iBHjYogQ994xTc13zoo+X5XbMcgTGgjd7yLgLJreeiTZ/uZ5EkIWoDcOpPnNxAsCM+Lz2LCE6fvDXrhzcDibPwM77f1LeSvNyrRi804YnWaYU7wQb50j0sACdiv95pel9zak6OC7sZDKAwmtIYnTXUJ7iY4m35ls9imn9n71mFZbQO5ToxnPWz6+EhHpS9p1HkjS1dUGwEYCKbO/G/p0MqvOrc3c2LLQx/5pSBmaYsqpHA8Y+JkkneQmV3UTA2WsRZ6E0fXGHKb1yTjZ2+uYYvb5tAFryeS/Yz9ifst2LMeelyD7/sxOejqdP2kTsmupWxgee23wU5bnueltvTtpuYSMLyhZJpoEUmOxqnFF05pFZviYjrNunhhi9FF4rQAjT7qpdBhcuQHudnJpINus4gEaV0LJ8gEqbRgzp6n6dZm+yF9hhqqfzE=
X-Forefront-Antispam-Report: 	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(376002)(396003)(346002)(136003)(451199021)(40470700004)(46966006)(36840700001)(478600001)(36860700001)(83380400001)(107886003)(34020700004)(40480700001)(2616005)(1076003)(26005)(6666004)(7696005)(70586007)(54906003)(70206006)(186003)(16526019)(47076005)(426003)(336012)(41300700001)(7636003)(356005)(5660300002)(40460700003)(316002)(82740400003)(4326008)(6916009)(2906002)(8676002)(8936002)(82310400005)(36756003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2023 12:31:39.4161
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bc4abbdf-a971-4a94-7d7b-08db46522f29
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: 	DM6NAM11FT072.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8057
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230426_053143_202792_118B56D8 
X-CRM114-Status: GOOD (  11.05  )
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

Instaed of duplicating same code in every transport, add helper in the
core to print the ctrl->io_queues, since all the transports are using
same format to print the information we can safely replace repetative
code by a centralize helper.

Use that helper for nvme-pci transport.

Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
---
 drivers/nvme/host/core.c | 10 ++++++++++
 drivers/nvme/host/nvme.h |  1 +
 drivers/nvme/host/pci.c  |  5 +----
 3 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 518c759346f0..ec430947aaf7 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -249,6 +249,16 @@ static void nvme_delete_ctrl_sync(struct nvme_ctrl *ctrl)
 	nvme_put_ctrl(ctrl);
 }
 
+void nvme_ctrl_print_io_queues(struct nvme_ctrl *ctrl, int io_queues[])
+{
+	dev_info(ctrl->device,
+		"mapped %d/%d/%d default/read/poll queues.\n",
+		io_queues[HCTX_TYPE_DEFAULT],
+		io_queues[HCTX_TYPE_READ],
+		io_queues[HCTX_TYPE_POLL]);
+}
+EXPORT_SYMBOL_GPL(nvme_ctrl_print_io_queues);
+
 static blk_status_t nvme_error_status(u16 status)
 {
 	switch (status & 0x7ff) {
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index bf46f122e9e1..4000526cbca0 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -767,6 +767,7 @@ void nvme_unfreeze(struct nvme_ctrl *ctrl);
 void nvme_wait_freeze(struct nvme_ctrl *ctrl);
 int nvme_wait_freeze_timeout(struct nvme_ctrl *ctrl, long timeout);
 void nvme_start_freeze(struct nvme_ctrl *ctrl);
+void nvme_ctrl_print_io_queues(struct nvme_ctrl *ctrl, int io_queues[]);
 
 static inline enum req_op nvme_req_op(struct nvme_command *cmd)
 {
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 593f86323e25..771d2bf5f402 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2356,10 +2356,7 @@ static int nvme_setup_io_queues(struct nvme_dev *dev)
 		nvme_suspend_io_queues(dev);
 		goto retry;
 	}
-	dev_info(dev->ctrl.device, "%d/%d/%d default/read/poll queues\n",
-					dev->io_queues[HCTX_TYPE_DEFAULT],
-					dev->io_queues[HCTX_TYPE_READ],
-					dev->io_queues[HCTX_TYPE_POLL]);
+	nvme_ctrl_print_io_queues(&dev->ctrl, dev->io_queues);
 	return 0;
 out_unlock:
 	mutex_unlock(&dev->shutdown_lock);
-- 
2.40.0


