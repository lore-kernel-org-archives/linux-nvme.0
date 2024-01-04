Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82CEDC47073
	for <linux-nvme@archiver.kernel.org>; Thu,  4 Jan 2024 09:26:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:CC:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=JWCs/AG9peOA/e/+JUHfRngEYF29QZkRZjihIPDZAso=; b=micXyjzixk1NIG2oc3HHmKyn6z
	X+Bs/TEh5VAaJbLX+EYUTQwtDRHo+HlHeeR+GdD0j3J/tZILdVbZUUXI8pWf2QEAqNljptauyrPze
	gGnXxjEyZn2hFhL3qCtVBOZ6m0DzYY7Q7z0IZKjD5Tg9z8Ia8IUfo7QeR4ls60WRntJW5LwNg8sMm
	id+/pXIiiJP8IRyutCJgXZrtnr9d1BlQGwQoXejHP+8GlNsM6tNfxbmVhwO61qh6wB+/FwBeQa6ys
	T46XaoCDNi8WrjEKRY60qDEevFkF+u1zLwazQqjakf7Sz925DxfAp8j3javdlhnEN2VY7Z799zf6Q
	4RnEFBww==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rLJzR-00DMK0-17;
	Thu, 04 Jan 2024 09:26:13 +0000
Received: from mail-bn8nam12on20614.outbound.protection.outlook.com ([2a01:111:f400:fe5b::614] helo=NAM12-BN8-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rLJzO-00DMJP-1s
	for linux-nvme@lists.infradead.org;
	Thu, 04 Jan 2024 09:26:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TtHCmKYIeNkbDlyWRmNcJiUVb4e88YIXTzRwIULeAFCwCeUTUQcLKnF1KcGlzxQx4B0OwIT3g542tXXvooXMewBLQxrBzHxiHI3UYnHMsIO1cd2NdkG4oDb//Nj5gp/OU/8WcuLK3CNHwdyhav9Ps4zwcJRZBBS/v7naHUG6FLRf57/dYV5PJihOqhgdq8bLi+ThwvccMV3x8PnH8tg1/lTq7lDH0rxH7kAs22Q8Di2fCYLdsbHhs8Gg5E2qRm409Mk1V3LwJj67SJU4vKHr2vpKVAn6w/21XDdF70doaWLzs98PPn6olfMjX0nevSpXERVhagXIjmpzTzjqo3kScg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JWCs/AG9peOA/e/+JUHfRngEYF29QZkRZjihIPDZAso=;
 b=exq9dUtal2mvH0RgyGXQ9FK3qIJ6lhAPMkvtNVSSIfvHKm1sWLB62a8drONH6SkOsfB5cM6abhqyx1nzPkltUrsumOe//ZWHkbVgQ13Fzx5MdFc26XkgcWjF+TTIds1rzPO2rbKsCrCSLfMNmDawIvMFIsUkS06wBGi5X2HPhB4lbmMWm86GFafKtQmzJ6YIZ9V3SJ6XKh5nHS2WiY4jjd+l+tYaSNVSjbuBLNY2sGUiUThl6vCIVfMYxT/za5KqdmB34KvigjZ4htV/hVpeFgAA6MS8EnVQ4i26HkOv/BRyuFs8O3wHZRy2jdl7oNAgaDHv1NXV5gtYNzCeAcJqvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JWCs/AG9peOA/e/+JUHfRngEYF29QZkRZjihIPDZAso=;
 b=pvm4dxa02hDTZuJn1LWNaTTcvLzfBtI+Pj2VpcfRIXMTRKOgJVfbgtONGCx/oHMK3Qg82p9VzVUYn0dSsN+gO3mRJU85T/Dej5ECcOaCXW3Wy05TVKI+zjd/CzO6ELzEVarfBhjdaioih92538RmWVgx6XcyyY2rrDBY/LZDZ7EcI7YEk4i0ik2sJPAxcevd7KSWYxgjizZuCjGsexzEQ64lpe+VM+5aDwtD0IpW4bRTYhx5ksv1JK1u6LbuPHvu1wiCZhpeXcKIycMmBGB7KZI4copouzY7ZCLKFyk4CH7VoHwAMqP0jrpRs+5jSdeuejojFJcBiCawd7OAeLAVgw==
Received: from MN2PR07CA0010.namprd07.prod.outlook.com (2603:10b6:208:1a0::20)
 by CY5PR12MB6034.namprd12.prod.outlook.com (2603:10b6:930:2e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.13; Thu, 4 Jan
 2024 09:26:06 +0000
Received: from BL6PEPF0001AB52.namprd02.prod.outlook.com
 (2603:10b6:208:1a0:cafe::de) by MN2PR07CA0010.outlook.office365.com
 (2603:10b6:208:1a0::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.24 via Frontend
 Transport; Thu, 4 Jan 2024 09:26:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BL6PEPF0001AB52.mail.protection.outlook.com (10.167.241.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7159.9 via Frontend Transport; Thu, 4 Jan 2024 09:26:06 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Thu, 4 Jan 2024
 01:25:54 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Thu, 4 Jan 2024 01:25:54 -0800
Received: from r-arch-stor03.mtr.labs.mlnx (10.127.8.14) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.986.41 via Frontend
 Transport; Thu, 4 Jan 2024 01:25:52 -0800
From: Max Gurtovoy <mgurtovoy@nvidia.com>
To: <kbusch@kernel.org>, <hch@lst.de>, <sagi@grimberg.me>,
	<linux-nvme@lists.infradead.org>
CC: <israelr@nvidia.com>, <kch@nvidia.com>, <oren@nvidia.com>, Max Gurtovoy
	<mgurtovoy@nvidia.com>
Subject: [PATCH 1/8] nvme-rdma: move NVME_RDMA_IP_PORT from common file
Date: Thu, 4 Jan 2024 11:25:42 +0200
Message-ID: <20240104092549.25721-2-mgurtovoy@nvidia.com>
X-Mailer: git-send-email 2.18.1
In-Reply-To: <20240104092549.25721-1-mgurtovoy@nvidia.com>
References: <20240104092549.25721-1-mgurtovoy@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB52:EE_|CY5PR12MB6034:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f12b62d-9cba-497c-e6ff-08dc0d072db8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qjljwkgCe+aTeZ+kmP0cqwT80RD/UbOA9D96Bwl/PPRB1p3ItzvWqZOGPwGk8IhgN0ppMrJTNb0SUgMQBOGyHRWOlH0dSMX4WAJvkn36kPCnsxquQiXce8iX6+gMAVpkWvfq1owGmAuv/yE84jJNNhCcLMqIqBnuPAoIlQ9hblzjuGzzn2oar/0pmWAoCTxOM34kLbpjYP+HpuODNbbN/BiJmmhfBxSOqQ/pjSFjkbRsmh2OGvtV1thRGQvUuo57/HED8ZspttxCzkvErYA4/Wl10bSil+Dph6cF2OOs2Ampprz7PeqM9qhAYUP3L0o//HTBIZYncwPzLzd5cluQ6Otii6aG0ItVhnt92StoKtSNQLaF+XetgbVQQVeYscU7ALBQGP0c7zxZzJCV9Tg+61aftEynjIJyD5rOCc5zi7PZf16T27Ufz/KzqG/lGbXUEjEF0Eby0p2MNpGTJ9CTptpLBCyXUuwSU28Ssui3xsSkYAJzkcjpFA+tqvh1tDqEEyzRotgOUPAX6f3bbEv79XeNvsQI38/BCEZvsqbrqXLKsQEUsrVPpvfcOPorHaSJwWKlCPm5lwS249sP9Y4Q4TvDANQ9oim3k6JIGCYgBRUZOmLPbuy0j7eyZlmUr9CRGmRz/4qrjt5esGMha9wb0JeuoiWRZGQ4WZS2SLM51lTTTSEju0zoBUjRL3yKHawJ5oBon0zvqye6V+LIvUZFISN7BaQRM0fyhuLvlbY7440lLTUMtT//ub2NmtD6/EHr
X-Forefront-Antispam-Report: CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(396003)(376002)(346002)(136003)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(82310400011)(46966006)(40470700004)(36840700001)(336012)(356005)(7636003)(82740400003)(36756003)(40480700001)(40460700003)(86362001)(426003)(26005)(1076003)(6666004)(4326008)(54906003)(47076005)(478600001)(316002)(8676002)(8936002)(83380400001)(70206006)(107886003)(36860700001)(70586007)(110136005)(2616005)(41300700001)(5660300002)(2906002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2024 09:26:06.0917
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f12b62d-9cba-497c-e6ff-08dc0d072db8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB52.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6034
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240104_012610_642054_F47F1A4C 
X-CRM114-Status: GOOD (  10.45  )
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

The correct place for this definition is the nvme rdma header file and
not the common nvme header file.

Reviewed-by: Israel Rukshin <israelr@nvidia.com>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
---
 include/linux/nvme-rdma.h | 2 ++
 include/linux/nvme.h      | 2 --
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/nvme-rdma.h b/include/linux/nvme-rdma.h
index 4dd7e6fe92fb..146dd2223a5f 100644
--- a/include/linux/nvme-rdma.h
+++ b/include/linux/nvme-rdma.h
@@ -6,6 +6,8 @@
 #ifndef _LINUX_NVME_RDMA_H
 #define _LINUX_NVME_RDMA_H
 
+#define NVME_RDMA_IP_PORT		4420
+
 #define NVME_RDMA_MAX_QUEUE_SIZE	128
 
 enum nvme_rdma_cm_fmt {
diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index 462c21e0e417..ee28acdb8d43 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -23,8 +23,6 @@
 
 #define NVME_DISC_SUBSYS_NAME	"nqn.2014-08.org.nvmexpress.discovery"
 
-#define NVME_RDMA_IP_PORT	4420
-
 #define NVME_NSID_ALL		0xffffffff
 
 enum nvme_subsys_type {
-- 
2.18.1


