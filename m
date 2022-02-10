Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51464C433F5
	for <linux-nvme@archiver.kernel.org>; Thu, 10 Feb 2022 19:12:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=lQh1+Gl0C0c8QwxRiRqW35rPTHFtCDMusmaBhpHU8q4=; b=kBL37XDutvzKzzPFAhAvY2X3bd
	OLrnUtQ3HUUw2gSI9lef8M1qSHcX6sfxq0yUDx2QioCcobD7ZKWsGUvvffdYTfVOvxha6F0U+N4Ik
	25n9pfD07OjpZr+MnYEL6PaxClPhvZGzwyK4nW+5OUR5toOFutGrCcZGSgEWyyptg67zB6jlZJn3w
	1D7GgIt2A/JHizzRKjIksMYqHIudkKv06hl8JkWHJGrAK/gsJPS0xB8kMVzMC/8U+h9WDILMfee4M
	yDNAdrNMwMfpRObVjBrQSHLAYAoLFaaqMq6XgluXlKLwU8uRTI6bJCzFFYNnmcGKl/AaXpM37bwqz
	JxPNsbXw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nIEsC-004jur-G5; Thu, 10 Feb 2022 19:12:56 +0000
Received: from mail-mw2nam08on20604.outbound.protection.outlook.com
 ([2a01:111:f400:7e8c::604]
 helo=NAM04-MW2-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nIEs9-004juW-CQ
 for linux-nvme@lists.infradead.org; Thu, 10 Feb 2022 19:12:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hdwo5C6dUAYKjeh0CwC6HfcYcct7k9+8uybUPDBXSnPXd+a87WsEGGRXKy1F+qCAmci+/klZn/hVFEF28pw7ZOfcv2m4IVfDZZ/T5UAg86gNL9GtEQCA3KHOiH30XbtJz7WHk768+oYdaMrpVCuJL6xNSP6FMVY9RpThfaOmT+EkITASrP5bL4udc33/tUFdnmSDG2KRK8S4kJ28+gWK5GbFAZ8OHh4Tic5VP2D2Vzzh1UdaNb8RD09/4KWATEWqSzkHs5sT59J3zPNHXFS+MWJcFbpuaY6YGJOp1ibusRGCuizupKamTGwnysH9JUDsDjTM5jn/5v2EmfVNXJ8sxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lQh1+Gl0C0c8QwxRiRqW35rPTHFtCDMusmaBhpHU8q4=;
 b=aBiBoA41QvQ4HKIrqoJg8TSWFB2cQihCiLABIhiSiFQjeRq9gI/LIhsi2bGqx4pnjQZ9kDj3XTPQ92285O0UOsRmbXtJfZcCbn5JyfbhjwRPWMYmHHyTN2t7TFfWNKsN2Do6ElOup+OnVepcue8YxB859RT7BM3KkFBi6Boyjp2rfUKWfcVLL0hQddDywCVo4VyyZz0IgEhcj832O5hwy3W5nRDS7LbTZFzbHjqztZake4TmDd3mZzuMMWS+mK+IO27awLgQ3LVyz97WdlsiranfqpgyGKIRy1/vsek8UWsO1o+/DmNs5iDYUC3lLeFCsJXRLkMn5TnhSuw1epNr+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.238) smtp.rcpttodomain=grimberg.me smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lQh1+Gl0C0c8QwxRiRqW35rPTHFtCDMusmaBhpHU8q4=;
 b=TLeuTtBgCi4ZSaFZ84YYsOZ4nsNavIyKAtqfs9rUmKMBnpGmd6JCBuh1jrBUUKHJCuus4U3gzBE8wlY+QZbn4eXwTj+uf4B5XWYFsaQj5lEHzqeijHHJMCBU3biuin1tNPKsiNDXSZI+zZ8D5CxM4qmsPUPD/KoVspWyQN0a3YOYDXLVBd4LGjv0KSxWj8O0qMZl/FEgbGWg0uyc62Hkv5S+rOADtmZ22z6bUj/0kAsurywL5wZxaxGKh57DbOYEyXpKZoQ6xQxinnhUpuXdmxPR1zFT6STfEPFhqFGlC5JTL3IZgyuZEDPFKJHpVDeqwSf5Czx7fpp13Mi8X6P2hA==
Received: from DM6PR11CA0014.namprd11.prod.outlook.com (2603:10b6:5:190::27)
 by DM6PR12MB3178.namprd12.prod.outlook.com (2603:10b6:5:18d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11; Thu, 10 Feb
 2022 19:12:48 +0000
Received: from DM6NAM11FT044.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:190:cafe::fe) by DM6PR11CA0014.outlook.office365.com
 (2603:10b6:5:190::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11 via Frontend
 Transport; Thu, 10 Feb 2022 19:12:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.238)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.238 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.238; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.238) by
 DM6NAM11FT044.mail.protection.outlook.com (10.13.173.185) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4975.11 via Frontend Transport; Thu, 10 Feb 2022 19:12:48 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by DRHQMAIL105.nvidia.com
 (10.27.9.14) with Microsoft SMTP Server (TLS) id 15.0.1497.18;
 Thu, 10 Feb 2022 19:12:43 +0000
Received: from dev.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.9; Thu, 10 Feb 2022
 11:12:43 -0800
From: Chaitanya Kulkarni <kch@nvidia.com>
To: <linux-nvme@lists.infradead.org>
CC: <hch@lst.de>, <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>
Subject: [PATCH] nvme: add a helper to initialize connect_q
Date: Thu, 10 Feb 2022 11:12:36 -0800
Message-ID: <20220210191236.8786-1-kch@nvidia.com>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a96f2dc2-d098-4e01-e14f-08d9ecc9538d
X-MS-TrafficTypeDiagnostic: DM6PR12MB3178:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB317809F1CDE57BCCA0DFED93A32F9@DM6PR12MB3178.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:923;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: maaV4f7oCqtdrrCIyQiUtUJOJg8Vmw29SaMmQrgnbrQiWzalodBCWSKAYmaul7YuoGAMKjGW3ZGqUQ9JBA+/zczl++zUalbWA+EiRxI0R4DHXDTQRKJydNLUGqi7QuX5HnH9OfvXXDYZbY/Ds2WRccOiUw/bukkVsMc+FkYK61m9HEUvil1T/C2pmKeB3yiE+FCUlFU3QX3yxpZkWqfwepCtT54+CEfvFgugpiqdryZmlqsBW3tkYcMcj6OOAGrk2H1sD+7uFbG4Nk1JLHfOC2cc5i7GOVdApmpL/2CdIMB+vxdckcaCYUzLbqANDBw+Jtu76hcuXUm9Xr3SBYmG8qq7aVMpyTHN1dwdQfF8HsbCKl1Zbb0El+B+GsHPzRnh230ZcnfvJKwtQR+NWc0jMM+0oUlK9Sc+xq+mqt/PTDudJK0KchzaMvz79S6VwUYGK51Y0wT/wRPre9VwsdrHANiXv+h2Mi9AHPki1RdNQ8f8gTV4vT247IvGAEvUSxKT0DLfTIqgBkEsAkpmYFQcoYVZuKg48p/wz6a4gnzonOsqg7anCmbA2EE/2jMzvZf8pR1ubtQJhbgirPK67+hww0vk/QFF2gYx8IiH+O2qtVKKt/xH0ih2A4d17UMu6O5iaw41BDE1AlR9NNZ0PBoCeV13dEsB2zbuf0TYX3HUMRKT0p1egwfNwYXR5cbg2ZsLMHKfUBpuxQ3y4tfpIhLrTQ==
X-Forefront-Antispam-Report: CIP:12.22.5.238; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:mail.nvidia.com; PTR:InfoNoRecords; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(107886003)(26005)(36860700001)(356005)(186003)(16526019)(1076003)(426003)(40460700003)(336012)(47076005)(83380400001)(36756003)(81166007)(2616005)(54906003)(70586007)(316002)(6916009)(6666004)(70206006)(4326008)(82310400004)(508600001)(7696005)(8936002)(5660300002)(2906002)(8676002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2022 19:12:48.2618 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a96f2dc2-d098-4e01-e14f-08d9ecc9538d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[12.22.5.238];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT044.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3178
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220210_111253_469216_1D5A1D4E 
X-CRM114-Status: GOOD (  10.48  )
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

Add and use helper to remove duplicate code for fabrics connect_q
initialization and error handling for all the transports.

Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
---
 drivers/nvme/host/fc.c     | 6 ++----
 drivers/nvme/host/nvme.h   | 8 ++++++++
 drivers/nvme/host/rdma.c   | 6 ++----
 drivers/nvme/host/tcp.c    | 6 ++----
 drivers/nvme/target/loop.c | 6 ++----
 5 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index 71b3108c22f0..23c896a138a3 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -2916,11 +2916,9 @@ nvme_fc_create_io_queues(struct nvme_fc_ctrl *ctrl)
 
 	ctrl->ctrl.tagset = &ctrl->tag_set;
 
-	ctrl->ctrl.connect_q = blk_mq_init_queue(&ctrl->tag_set);
-	if (IS_ERR(ctrl->ctrl.connect_q)) {
-		ret = PTR_ERR(ctrl->ctrl.connect_q);
+	ret = nvme_ctrl_init_connect_q(&(ctrl->ctrl));
+	if (ret)
 		goto out_free_tag_set;
-	}
 
 	ret = nvme_fc_create_hw_io_queues(ctrl, ctrl->ctrl.sqsize + 1);
 	if (ret)
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index a162f6c6da6e..f8658f984d64 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -894,6 +894,14 @@ static inline int nvme_update_zone_info(struct nvme_ns *ns, unsigned lbaf)
 }
 #endif
 
+static inline int nvme_ctrl_init_connect_q(struct nvme_ctrl *ctrl)
+{
+	ctrl->connect_q = blk_mq_init_queue(ctrl->tagset);
+	if (IS_ERR(ctrl->connect_q))
+		return PTR_ERR(ctrl->connect_q);
+	return 0;
+}
+
 static inline struct nvme_ns *nvme_get_ns_from_dev(struct device *dev)
 {
 	return dev_to_disk(dev)->private_data;
diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 850f84d204d0..0bf2ce0b1dd6 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -978,11 +978,9 @@ static int nvme_rdma_configure_io_queues(struct nvme_rdma_ctrl *ctrl, bool new)
 			goto out_free_io_queues;
 		}
 
-		ctrl->ctrl.connect_q = blk_mq_init_queue(&ctrl->tag_set);
-		if (IS_ERR(ctrl->ctrl.connect_q)) {
-			ret = PTR_ERR(ctrl->ctrl.connect_q);
+		ret = nvme_ctrl_init_connect_q(&(ctrl->ctrl));
+		if (ret)
 			goto out_free_tag_set;
-		}
 	}
 
 	ret = nvme_rdma_start_io_queues(ctrl);
diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 4ceb28675fdf..6cbcc8b4daaf 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -1825,11 +1825,9 @@ static int nvme_tcp_configure_io_queues(struct nvme_ctrl *ctrl, bool new)
 			goto out_free_io_queues;
 		}
 
-		ctrl->connect_q = blk_mq_init_queue(ctrl->tagset);
-		if (IS_ERR(ctrl->connect_q)) {
-			ret = PTR_ERR(ctrl->connect_q);
+		ret = nvme_ctrl_init_connect_q(ctrl);
+		if (ret)
 			goto out_free_tag_set;
-		}
 	}
 
 	ret = nvme_tcp_start_io_queues(ctrl);
diff --git a/drivers/nvme/target/loop.c b/drivers/nvme/target/loop.c
index eb1094254c82..23f9d6f88804 100644
--- a/drivers/nvme/target/loop.c
+++ b/drivers/nvme/target/loop.c
@@ -543,11 +543,9 @@ static int nvme_loop_create_io_queues(struct nvme_loop_ctrl *ctrl)
 	if (ret)
 		goto out_destroy_queues;
 
-	ctrl->ctrl.connect_q = blk_mq_init_queue(&ctrl->tag_set);
-	if (IS_ERR(ctrl->ctrl.connect_q)) {
-		ret = PTR_ERR(ctrl->ctrl.connect_q);
+	ret = nvme_ctrl_init_connect_q(&(ctrl->ctrl));
+	if (ret)
 		goto out_free_tagset;
-	}
 
 	ret = nvme_loop_connect_io_queues(ctrl);
 	if (ret)
-- 
2.29.0


