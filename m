Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9908C433EF
	for <linux-nvme@archiver.kernel.org>; Fri, 28 Jan 2022 09:23:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3HJGStSimYMRpJUfYXgwHH30Yp4I6WWfB6vLPUzNk1E=; b=UDqp6cdcwwX55AcgTgxNhEZ8EK
	xSJUIssAWjeV+N8Inua0RCUmtX1voIGKDU+pd/RRV+GwaNScabxsdLznRLVt1hlCCwQMJDD7i7GIj
	vkzyOJO+lAQKchHApEVIUjVwreNRNIUFvUziRkd7kN7Kc22rvyZz89c6a3t/mXyQDZuR8P9XOm3+b
	0u38FIqt9Q2/uDD9zTINyZ1rj+39vSlQsQ8f4iOipLU0yGltTsiMIbOnA+8PFogqfCygRQudU+kKn
	u3pz0eUc2bx1Br2x9tSQ1gEZvNJXMq3CYXLL3c9ar53PjRJdmK0u7wKAa4bykHLOHGa9vLVSJw/xt
	03StNscA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nDNTO-001Dis-2l; Fri, 28 Jan 2022 09:23:14 +0000
Received: from mail-dm6nam11on2087.outbound.protection.outlook.com
 ([40.107.223.87] helo=NAM11-DM6-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nDNRD-001Cqy-Oy
 for linux-nvme@lists.infradead.org; Fri, 28 Jan 2022 09:21:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rw6V1glW769cX4xnbfEWfZe8pl2JcU0KHDdTn3ttEBmwHCNatk6+nOm36KdpxPVGR8ZOMr7Yh+62XCiAW7bspMNqNbbaKlk/gvaMguRyKq7A6h+5LzNZ6tKFVfRmK+q0TgZSDy7pFeFqyQppTaTy+gD4070ZxMwoEQnhCm+/0ylLYkUfsIdBRHom+g5rEAYQiY4obCLtjWFvdI+6YHfVvYZyTEPKu/+rNOLXSrymUOs+hXaPLwIbDqq2BMtiDxe3V2ihaSD4s9STOF1ym0EOC8TDWDpprib0IfMVU0wMdEGzUHwwf5yEyxzdzrSpcMBkmRua3Ha5WconIsjjNphggg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3HJGStSimYMRpJUfYXgwHH30Yp4I6WWfB6vLPUzNk1E=;
 b=eCbb2AqlqSEIsxBd1SbYl4rVUSQflwwFgavt2HR9P5qlN7L72qNtLhnyiQYxl4MpBL9ZaykGv1DQ0121dZFqRO1lAD7Yu5CXCYLiavDIlYuqqhVuznWcaOwiBzYgGcF8LrrST7ktZN081/gsCB+ypdJIoDGpM38sd4LQDxg9w3VTlhjXfUpUKyyKMb2jAJPYIJWox63QWd5W/bdDRp4ZVO+ahllDeslgIsfAJTnY6V8LaIHClBBABbti7YFcIbJ0DU8jW7NX6AgXGp2BBzM7Is9alJc8jORH3F+Rxm7Y3AdB3dKTn9pHrGhRQu+gA/ylqpOqhf/1N+ai8mnqY0792A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.235) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3HJGStSimYMRpJUfYXgwHH30Yp4I6WWfB6vLPUzNk1E=;
 b=W9n+7KoLqyXNsJtgkUujYV+itIaaHr1UnzQHrUPN2b2Kr09hKzQySwSrXQvdLeJ/0jyddl1F/Z2gNCP1q/yRxQ1xa2VvqCtzY0I3MjMcPydYJo9rglcqu1eGTNZDueQpEasPhtc7ZkgemG/+kiKDjORY8VfRxf+n2IXRdBUXsAVcBcOAvK3+XLmfd6mHUO46H+8fE4Tkd/VTpQWQq5/J7y413U8lLop8zrrQGXCpZCNAv8iaio7dYc62rQHRNn80pOn5b52n0xi9uIEh+zwPZN2vTnEVw5FKQ1qFbSPqzKOSNiIPpSC2mNKLZfTpQUDGtnGEYzxqALzpv/W+ZNgchw==
Received: from BN9PR03CA0054.namprd03.prod.outlook.com (2603:10b6:408:fb::29)
 by CY4PR12MB1750.namprd12.prod.outlook.com (2603:10b6:903:11c::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.15; Fri, 28 Jan
 2022 09:20:57 +0000
Received: from BN8NAM11FT028.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:fb:cafe::c2) by BN9PR03CA0054.outlook.office365.com
 (2603:10b6:408:fb::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.17 via Frontend
 Transport; Fri, 28 Jan 2022 09:20:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.235)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.235 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.235; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.235) by
 BN8NAM11FT028.mail.protection.outlook.com (10.13.176.225) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4930.15 via Frontend Transport; Fri, 28 Jan 2022 09:20:56 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1497.18;
 Fri, 28 Jan 2022 09:20:55 +0000
Received: from dev.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.9; Fri, 28 Jan 2022
 01:20:55 -0800
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: <linux-nvme@lists.infradead.org>
CC: <hch@lst.de>, <kbusch@kernel.org>, <sagi@grimberg.me>, Chaitanya Kulkarni
 <kch@nvidia.com>
Subject: [PATCH 2/9] nvme-rdma: use helper to initialize connect_q
Date: Fri, 28 Jan 2022 01:20:08 -0800
Message-ID: <20220128092015.19289-3-chaitanyak@nvidia.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20220128092015.19289-1-chaitanyak@nvidia.com>
References: <20220128092015.19289-1-chaitanyak@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: drhqmail202.nvidia.com (10.126.190.181) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 445d26ea-8e06-4652-f509-08d9e23f7d54
X-MS-TrafficTypeDiagnostic: CY4PR12MB1750:EE_
X-Microsoft-Antispam-PRVS: <CY4PR12MB1750D5686E749DFE9B68623BA3229@CY4PR12MB1750.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:983;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cDoeWn83m5ppUdlZT4j4m07DkBAn0Lum5s7t1yKcrbCBnAVbE2THNwBib+SxXxp5zn3V/h84pJNEWKfN9GHhrFsZl8bLV7xoMQJfr2RkfUAvrGKKdq3e36g5XaXcyWT0PKLZ7SFsNbjiXZgTb54qSjH47V5YpeUTj5zO5Gh2w3bK5G5/JPfk4MGeXPS/cCcyi1jf5WpIqOvGaJNC6nuHZ/lBMxVDrpFH/8gLUT1/Zc77W/LA7QrVACt02ZdF8UFeXFjj9ONmHDEmzUXlZEqOBXCYzuUMGnkeXpLLhAoZoMsTq+B9qh9LqJO/YfdbR4OCf5VXS234WT1KMbBziNMVIxuOKAefUIEfGmTQeb+LIdfU5Rw56/K84gpqivVIZsKmeu9zTjg+T1qivJoSJhC1C7WFaTTjPbzdMKwVFFPODmfOC7eI2edQHza8CWePsjD9zLZpFd/ffe8dIZLUsmBVuyT3rkh6aYfwdArLcD90eaXbFIDV/Jm/0B3hENoPvRAOhSN8NFmpXGcq01oWnm41gQL7M20Uj6oYzKOCf2EX+xA+lDpExeSU+Ju1OfBMCD8/7XjtBTKmLKaxjjo4LnN8I/0cxYPwZyQUtqchrEPNqobFYSJJWlR+We23kJ0liMVmI2UYqHU68PvznA39Q08//ZXPgMGXE4DCyO8upmQkHQkLBwvWYs9vdmenE+efbt7vlhtK6Naf6R4hJL4liHZ5Rg==
X-Forefront-Antispam-Report: CIP:12.22.5.235; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:mail.nvidia.com; PTR:InfoNoRecords; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(40460700003)(4744005)(2906002)(36860700001)(2616005)(107886003)(356005)(508600001)(36756003)(6916009)(1076003)(83380400001)(81166007)(6666004)(8936002)(82310400004)(8676002)(4326008)(47076005)(54906003)(426003)(186003)(86362001)(70586007)(26005)(70206006)(7696005)(316002)(336012)(16526019)(5660300002)(36900700001)(20210929001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2022 09:20:56.1454 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 445d26ea-8e06-4652-f509-08d9e23f7d54
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[12.22.5.235];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT028.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1750
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220128_012059_951186_6F967ABD 
X-CRM114-Status: UNSURE (   9.73  )
X-CRM114-Notice: Please train this message.
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

From: Chaitanya Kulkarni <kch@nvidia.com>

Use helper to remove duplicate code for connect queue initialization
and error handling for all fabrics transports.

Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
---
 drivers/nvme/host/rdma.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 850f84d204d0..d033294b063e 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -978,11 +978,10 @@ static int nvme_rdma_configure_io_queues(struct nvme_rdma_ctrl *ctrl, bool new)
 			goto out_free_io_queues;
 		}
 
-		ctrl->ctrl.connect_q = blk_mq_init_queue(&ctrl->tag_set);
-		if (IS_ERR(ctrl->ctrl.connect_q)) {
-			ret = PTR_ERR(ctrl->ctrl.connect_q);
+
+		ret = nvme_ctrl_init_connect_q(&(ctrl->ctrl));
+		if (ret)
 			goto out_free_tag_set;
-		}
 	}
 
 	ret = nvme_rdma_start_io_queues(ctrl);
-- 
2.29.0


