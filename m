Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BADCC433FE
	for <linux-nvme@archiver.kernel.org>; Fri, 28 Jan 2022 09:27:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=rGlNod6MPzB5pOwMTBLkfG+k01Gu8EDax7WAX7mqPRY=; b=m3m11Tga8nmr7Z2JXPXphA3Xx7
	J/KuDlSBI8R125TaEsEMVCXAPt/p3saeY7VFaRVMT4R0mLm36vMnxQHitQ791iP9MniiHyBo1p6QM
	z91B7lkrLf7Qs/zgUHw4UCV92FFMzs365s1bU3kkejBtRA/v5c5tZSIXwXmMNrJkQ7etEKv4+NlXA
	D1L95vOHOXosnPxxEhaS5x4SQJkMFga4RnheY8BL4pWyeWFCs2jNMhTKzM+l1BG1JYw8eONty8QcC
	1M6fZ4VOHCj3pxg1EhTkoGySrvr0tFE5lE8KIFmL9r1wenqVbveKfefLumPVU1Ciii2QlBthx5ptG
	VYLxiZfQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nDNXi-001F3b-LC; Fri, 28 Jan 2022 09:27:42 +0000
Received: from mail-dm6nam08on2053.outbound.protection.outlook.com
 ([40.107.102.53] helo=NAM04-DM6-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nDNSB-001DHk-G9
 for linux-nvme@lists.infradead.org; Fri, 28 Jan 2022 09:22:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JfLvScN/1H/dGBlk/Q7gYp9GDqvfz3Ko5HOI3pr4DaDx51NnZotlXPi2D8UKJwEio8E4Tz1XaiF85Ce/un4QYT4NidmTjxKntPNm9HHZVBlyMRARVDxRUgc4/5+S7Nq4Qx58tjJDCuUkFK7OLtW35QDm95c7KQOx7b/qRRv34yN5hksqbnPdY3GYwXAnWku77dF8KJV/nxNohh4WvoQeItYxDYmWUWE/rcpoq0Z+7dGXQLYNWbruwmAmL6pY46NHPA4mkrnx5dSEAf4dIRqOYa3BMmqfvtOnLhO/9yuQE0tTzAzc/5ITOhN+Zgy1abR6fUbYTvrX3IGjrNHlV4DMxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rGlNod6MPzB5pOwMTBLkfG+k01Gu8EDax7WAX7mqPRY=;
 b=NfRFTelvEHz0OQJ42StwXK4gxWnBZm4iHcLQsmQ83v2agi6wSkpbtwlNfosaZ3QZCharCb+GDueIy34ACvBrZuTp9B9hZyviGksEDhVnt47ia5HuyEs/dzzEDh0r7kOLHmEFL57+0wdbvaWCOfW3z/LmYceYcRFhFW/TDK75SmaW36TXb3fhyhoHF7qavqVbTtdK0t82DHzJqzum03Fm+dQCzNph50JMw8Coe/68Y3fh/zI18zuBzrd3qa9QKnbkqnhfRMV65E1Z+32JgDGJvSAaR5tlLU5VUJ1ShceEySmNh8YhywQWzYzrJJD6qfEo4nraWowzC7bcXFW9Id6ATw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.235) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rGlNod6MPzB5pOwMTBLkfG+k01Gu8EDax7WAX7mqPRY=;
 b=aiC3QyAqk+AtXC5t8O78wc1lqzA4xRfUAL1QRPfPd8BkC8yZ/JV1RA7jvrckJJUEZU/2OsLXI//K0X2cy9yTZGYGBgykAFimFfYdx37K4vbEf5U4McVK9BSF0B8oFP89YHPeclN4gUb/UGPGIAtdPFzh7B1a4CkTM5nIBDy0DuslS1eyq89G2MQmS1nv6G9/kzrzLiulzgnoanrNXq8lz7fSdOBew0UEnbguvVN5YQX+lAFN8/KL3ty1fiLXw5LKJVfO9/X7oiEEtZbbljNZQVLChTMmPZAdLaSXVhUan8IO9t1NM/0h9qLxgAkwesE2zk3gnUgUNINqbRARaHKEpw==
Received: from BN6PR14CA0021.namprd14.prod.outlook.com (2603:10b6:404:79::31)
 by CH0PR12MB5236.namprd12.prod.outlook.com (2603:10b6:610:d3::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.17; Fri, 28 Jan
 2022 09:21:57 +0000
Received: from BN8NAM11FT005.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:79:cafe::3a) by BN6PR14CA0021.outlook.office365.com
 (2603:10b6:404:79::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.17 via Frontend
 Transport; Fri, 28 Jan 2022 09:21:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.235)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.235 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.235; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.235) by
 BN8NAM11FT005.mail.protection.outlook.com (10.13.176.69) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4930.15 via Frontend Transport; Fri, 28 Jan 2022 09:21:56 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1497.18;
 Fri, 28 Jan 2022 09:21:56 +0000
Received: from dev.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.9; Fri, 28 Jan 2022
 01:21:55 -0800
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: <linux-nvme@lists.infradead.org>
CC: <hch@lst.de>, <kbusch@kernel.org>, <sagi@grimberg.me>, Chaitanya Kulkarni
 <kch@nvidia.com>
Subject: [PATCH 6/9] nvme-pci: use helper for tagset initialization
Date: Fri, 28 Jan 2022 01:20:12 -0800
Message-ID: <20220128092015.19289-7-chaitanyak@nvidia.com>
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
X-MS-Office365-Filtering-Correlation-Id: 37711d5e-315d-460f-3e41-08d9e23fa15f
X-MS-TrafficTypeDiagnostic: CH0PR12MB5236:EE_
X-Microsoft-Antispam-PRVS: <CH0PR12MB5236A496C8D10461831730F4A3229@CH0PR12MB5236.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sOYY5UgnYPEk49WcEN8bQxjePAMJSTHglAN4SqNfryPGv8iUXu7ZL34j+HdB92nqqM4/k4VcaDLWQHwtW5Bfw89Z3NoKHn/Yv0tRzQemTaf9Wuhb/HZNAx8XO1uPes4ROkmsbScV7v899dXrjzrrMtH4tuoHVDSOiFy27cSXxQXznAiZ8Qel0ZPfbzGbr1bJY/tR9NO1RI3rcthpStj8BdgUQLlDx5oCChUdGz6fGjFWpipsgu+OPYdkDtYXubpV63JZEukcQLnKOn4K06rU3pQlrTU2YLvHvjLP7uKvHwUfGSXiY8VA6xdzz4wxbg3og68U4y8fe6HfvxufV2RCuxBkEXeGj8Yna+2oOq1n1j5O1xI+TTacKXTSxKeq8+Ziwz6VVOYiGegIh8Ckw7QsMPs7CALvg6AAwhZZzLictDAQDETRBL1lIT+yygKpmQsKqf7cHL/QC9nAM0g/fmO/2lxYdsF6gEJmEeHoPzB5AGMwJdvqAmiwQMcwKMuiIozgqsf/K3ruAZnkIKWoX2kWKRloYBc4/9VZa7f2Z230iUzwWaB33pX2k8OUIFEmEYH5gFid5XSBampL9VpC/ufmJAHqEaMsvhYx6quX4ej1OQ0Qej6tGy2O1py/lX2NoTs0niXZzO0f4KTjkTOHpmpmqGhDFDId4RMo8jYehFiWeCab3C5yG1SaRBCY47GYTpYeX1KZ4A3jOcAJDqlFN9ZtOQ==
X-Forefront-Antispam-Report: CIP:12.22.5.235; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:mail.nvidia.com; PTR:InfoNoRecords; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(83380400001)(81166007)(2906002)(356005)(26005)(186003)(16526019)(426003)(336012)(82310400004)(1076003)(2616005)(316002)(47076005)(7696005)(5660300002)(86362001)(70586007)(8676002)(8936002)(4326008)(70206006)(107886003)(40460700003)(54906003)(508600001)(6916009)(6666004)(36756003)(36860700001)(36900700001)(20210929001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2022 09:21:56.6107 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 37711d5e-315d-460f-3e41-08d9e23fa15f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[12.22.5.235];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT005.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5236
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220128_012159_589284_133A65AA 
X-CRM114-Status: UNSURE (   9.69  )
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

Use helper to remove duplicate code for admin tag initialization
for all transports.

Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
---
 drivers/nvme/host/pci.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 6a99ed680915..87bdccd85eff 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1755,15 +1755,10 @@ static void nvme_dev_remove_admin(struct nvme_dev *dev)
 static int nvme_alloc_admin_tags(struct nvme_dev *dev)
 {
 	if (!dev->ctrl.admin_q) {
-		dev->admin_tagset.ops = &nvme_mq_admin_ops;
-		dev->admin_tagset.nr_hw_queues = 1;
-
-		dev->admin_tagset.queue_depth = NVME_AQ_MQ_TAG_DEPTH;
-		dev->admin_tagset.timeout = NVME_ADMIN_TIMEOUT;
-		dev->admin_tagset.numa_node = dev->ctrl.numa_node;
+		nvme_init_admin_tagset(&(dev->admin_tagset), dev,
+				       dev->ctrl.numa_node, &nvme_mq_admin_ops,
+				       BLK_MQ_F_NO_SCHED, 0);
 		dev->admin_tagset.cmd_size = sizeof(struct nvme_iod);
-		dev->admin_tagset.flags = BLK_MQ_F_NO_SCHED;
-		dev->admin_tagset.driver_data = dev;
 
 		if (blk_mq_alloc_tag_set(&dev->admin_tagset))
 			return -ENOMEM;
-- 
2.29.0


