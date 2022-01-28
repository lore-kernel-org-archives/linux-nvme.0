Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7A41C433EF
	for <linux-nvme@archiver.kernel.org>; Fri, 28 Jan 2022 09:31:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BTaP+DQz31F6lvjRWVg0s4H/7tDT/x0RKvleWdBwtB4=; b=i/B7EQoNvTcq+cfPKEiPUP5RyK
	pjjMF0pQJeqn/lJSDlckL3rl3QhmSLDH3Vk4zRJarvZ+7u8L3XYqCnIFYk7jexNuwCQSU9N18NccE
	pUDTTguuHmDbAPG9PiccA2qdzWWvzFk3cPQxXmWDv7jBo4tkL408cLjXzoGNtYvRVM64NUNl+vh8p
	9qUhvYXefApo/OBNBRBdafnIuVaWJrAzZzwd7P11N02pVaC80ZRvZns99NjkzlVBUbSCawEPy6LuI
	nFoplyaCSAU+JG4tXYDJDSK0ezr+Ol3/bwkoN598cg3fZv4ej632bjVZS2ux7GAMrdbMzw8xJ3TGI
	ANPzjQpg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nDNar-001FpL-IL; Fri, 28 Jan 2022 09:30:58 +0000
Received: from mail-dm6nam12on2077.outbound.protection.outlook.com
 ([40.107.243.77] helo=NAM12-DM6-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nDNSd-001DTZ-6g
 for linux-nvme@lists.infradead.org; Fri, 28 Jan 2022 09:22:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kRvTGVNc+2MAg8outXyY6BFQPL25UV+6PWhoWLxTqVSzu5mbNvqgeWzjcuAq3SB8SB7EeUH4q6hj72PLsW2IxYuMZo7G5HBgVlficwqB93GD9TuiFUWc+GofC4KCdqW8qodbaMhIWUDWqnOu9dflrXSgBPbU3qjMNUDmd+e6cyA4VVsJ5AFvzN6W7xfdbxn6NpCiTmquA6xpsJkuNHQUNDhlMNFad6F4Wjnd8jYwDhbbfnT6/jHSzp3Z0mjyQmH0c0W+/2YCcWKRTW8u57y+65IhpHo7uCk0pUpIv/pFvou6rSFiUTH8nkrUyOloJu7YCyzFvIjLiv2OENVdZPTa8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BTaP+DQz31F6lvjRWVg0s4H/7tDT/x0RKvleWdBwtB4=;
 b=fAGZ+lBW5BEP17jrBjLjAyquQzj42LhKXB4NfZMKZvQ70wPoQ8qy2z6U1orFwkC5QDXuJrAv4WZ89hXgv4WTKqUwC8oM+uzHnrrPt0MvBf3/Boxlk7qHHDyVb46hFklocNWYHYhV3j2bpbYLGT9GhK6zQfU24bVRuqNhNZ8DbL8MNcb+hmRLSk8hEcq+xL5cwob4q/wsZSvVRQAFxfDQ5LCMumTGElCzjxIkoknhxDuEJxCnqz/70e7qA+F89UGx0O3YlOWNN0kM67ProO7uE3ECiLOidFCXn/wGu49187KkEW9DZ+PShXi1R4M20CTVltJp5npu67TdB5iSE1glzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.236) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BTaP+DQz31F6lvjRWVg0s4H/7tDT/x0RKvleWdBwtB4=;
 b=Gj8xuKexWa/1yJtiY9V5kRMIvz90slIi8kh4N0I+SVAE+RDq6nGsOML2j5eULp7Sn0RPWLujOnUyMReVtzuxJ6ib6CEhwsHshQzx7GuiWPe2+eBvJW3UbPOC/jKEtHKtwahbqhkh3NDqJDj+pbNEce7ChEvgpj28FnmvI9/dJijvcdZUODm7a1OpQUGOC4xwP2Yjn7TuowlhgAqR6Cb8cLFBUc6eSRCHv7cQQZ7/wwZnCfXDGQYRHDY4eZmMmMqxFrMYHLZ/bpeO2QxlBKHvv05kFj/3WbhSwxV1LuYcbJdYHDQxvB/RnM1ViuMhf9XmbTTHFvFwfI38ZPnCPUBYLA==
Received: from BN9PR03CA0940.namprd03.prod.outlook.com (2603:10b6:408:108::15)
 by BN8PR12MB2852.namprd12.prod.outlook.com (2603:10b6:408:9a::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.18; Fri, 28 Jan
 2022 09:22:24 +0000
Received: from BN8NAM11FT053.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:108:cafe::ab) by BN9PR03CA0940.outlook.office365.com
 (2603:10b6:408:108::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.15 via Frontend
 Transport; Fri, 28 Jan 2022 09:22:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.236)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.236 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.236; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.236) by
 BN8NAM11FT053.mail.protection.outlook.com (10.13.177.209) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4930.15 via Frontend Transport; Fri, 28 Jan 2022 09:22:24 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by DRHQMAIL109.nvidia.com
 (10.27.9.19) with Microsoft SMTP Server (TLS) id 15.0.1497.18;
 Fri, 28 Jan 2022 09:22:22 +0000
Received: from dev.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.9; Fri, 28 Jan 2022
 01:22:22 -0800
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: <linux-nvme@lists.infradead.org>
CC: <hch@lst.de>, <kbusch@kernel.org>, <sagi@grimberg.me>, Chaitanya Kulkarni
 <kch@nvidia.com>
Subject: [PATCH 8/9] nvme-tcp: use helper for tagset initialization
Date: Fri, 28 Jan 2022 01:20:14 -0800
Message-ID: <20220128092015.19289-9-chaitanyak@nvidia.com>
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
X-MS-Office365-Filtering-Correlation-Id: d8c50377-cec1-4801-5e1f-08d9e23fb1b7
X-MS-TrafficTypeDiagnostic: BN8PR12MB2852:EE_
X-Microsoft-Antispam-PRVS: <BN8PR12MB285237EF2CF68ED31826F4EEA3229@BN8PR12MB2852.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zBQedlj/DRafOrpPY2fd1NsVH8yW8O+3z6O8Z+oBX6Wx0mM/mkaZzoBNsH5oiXxQ5Yfpvk7xDWKzgVIcof+kflrMF+gKXZB/GV7yUhodkbja1H8kO5MUseMXBvubcv6TBAFh/kccLCoqwQGgUU3YRhBe3c4M8acJIsLz3+kDaQEdMinQp9y5o3jYlZkZ4K+5teeV8G69tvKHncWwc3dgd20fY7wpkjKLOcxRgc90FrzH03hsJrxqCuiGQCIRLOukQxMl6n12YUzWivkaaFQ+XHkPGk7hChfQ1u6uIsBkJrp1sMSy+jukl3GzJNKcxLsyDFYqs6XYwO0VMG432UserY4jDu+K1E9Sjbse+Dj5AJSZJGy8pXb0J8UHq517wQ9ZawhuWdGCdzwuLW64XJU3GhvnWmuOnSEITya8hHPBs6OLva+9f3hxdUE95wnrMCSxHRS77cmTadfdxl3s/vMy2IEAue58LLAqxCVGAFNFlKqXWJAf5lrIUU9/t00Mca66GGR7dab/tzvWARLKuYjWBVZhctcbR/2QWQxxMX7CEN1oVxZSqo8sEaqYcHdYNdXso36ylyNfwYlfr2Bbnk8HIx8tgns4LILL6EwTIWWPTgUv9CO1GQ8hplqo4tBnWzyBdWZ3tAHEOafKG3UOT/TjMtOmtvlO9WT36+twVGSskPoLBuWLkOreVS2UgtIfrvmqPVHjOIa1mq07Dud1530zBQ==
X-Forefront-Antispam-Report: CIP:12.22.5.236; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:mail.nvidia.com; PTR:InfoNoRecords; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(356005)(107886003)(1076003)(7696005)(5660300002)(6666004)(2616005)(81166007)(36756003)(16526019)(508600001)(26005)(36860700001)(2906002)(186003)(426003)(336012)(47076005)(316002)(86362001)(8936002)(8676002)(54906003)(4326008)(6916009)(70586007)(83380400001)(82310400004)(70206006)(40460700003)(36900700001)(20210929001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2022 09:22:24.0318 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d8c50377-cec1-4801-5e1f-08d9e23fb1b7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[12.22.5.236];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT053.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB2852
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220128_012227_319057_727AF80F 
X-CRM114-Status: UNSURE (   9.38  )
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
 drivers/nvme/host/tcp.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 6cbcc8b4daaf..e51ceada3bd9 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -1613,16 +1613,10 @@ static struct blk_mq_tag_set *nvme_tcp_alloc_tagset(struct nvme_ctrl *nctrl,
 
 	if (admin) {
 		set = &ctrl->admin_tag_set;
-		memset(set, 0, sizeof(*set));
-		set->ops = &nvme_tcp_admin_mq_ops;
-		set->queue_depth = NVME_AQ_MQ_TAG_DEPTH;
-		set->reserved_tags = NVMF_RESERVED_TAGS;
-		set->numa_node = nctrl->numa_node;
-		set->flags = BLK_MQ_F_BLOCKING;
+		nvme_init_admin_tagset(set, ctrl, nctrl->numa_node,
+				&nvme_tcp_admin_mq_ops, BLK_MQ_F_BLOCKING,
+				NVMF_RESERVED_TAGS);
 		set->cmd_size = sizeof(struct nvme_tcp_request);
-		set->driver_data = ctrl;
-		set->nr_hw_queues = 1;
-		set->timeout = NVME_ADMIN_TIMEOUT;
 	} else {
 		set = &ctrl->tag_set;
 		memset(set, 0, sizeof(*set));
-- 
2.29.0


