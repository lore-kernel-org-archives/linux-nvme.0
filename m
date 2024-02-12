Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0A71C4829B
	for <linux-nvme@archiver.kernel.org>; Mon, 12 Feb 2024 01:48:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=E36dXFtDW/oCb91vgE4PoqeHBJDJSZLO9E5VcvDR0M0=; b=H5vDHMA/D2RrWWn8H+V9iLOWkF
	ldQe6Z0YBtx87VRW2anNftTMYoZ+Ze9d0snJjHR2Jp2uqdN2/NXjfmVKB9hzchtd8A74JDN2tZLzR
	LGm8R41h/Edkf3qRBVFNByEDXPzWJX15y9w+HbxG3M4ulZ21OK7udWlQltfpAP3vT4MKFSbKXaV7a
	HY3sBFH3eMH1HQTTMa+tjkph6ZcwRgC27WA2xmF2x0fbq/nd5KmqZmdLzJINwPUXh8W+7jZw3XL5c
	zzXnUgIkJjRNLDCEhS4pBJhYNLPAQnQqK1PiEf40mXklorQZpXKCUg5ftBT1pAWW6dfoEdqMIWI08
	6tFY1TmA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rZLR7-000000040Un-0j8a;
	Mon, 12 Feb 2024 01:48:45 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rZLR5-000000040UG-3Gjh
	for linux-nvme@bombadil.infradead.org;
	Mon, 12 Feb 2024 01:48:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Type:Content-Transfer-Encoding
	:MIME-Version:Message-ID:Date:Subject:CC:To:From:Sender:Reply-To:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=E36dXFtDW/oCb91vgE4PoqeHBJDJSZLO9E5VcvDR0M0=; b=PXVZ3TELeslfYps5h4SkPJcRiI
	MQnWrjJs/j92lHXiprF0MDrfpI/lgi5mqNK+ZgJhtDIjOojy29dvOmItRmBNs0LOy7fzudZYmTPmw
	ysq0U+SSalqY1+4MJEsON0Ga+XnKChvlWDsYEp/fkQEIu1bF2l/A5Ky/GrvT5tw5CJLtnFOEB8HnD
	Qw3huwuuI50wwx1RhE+Te/pMixy/nPWr0wspYZT0ntdH3x6B7+3nPCfByCbtNk6TQ+V5l9cIJDgha
	4EPNRivX6ziRd5I1bfcr+DR9bQO19fK/re/qDn7dzHcTI53bv+ISmbGdXfd5BeJSrFI+u91h4letA
	uNA4GhIg==;
Received: from mail-bn8nam12on20601.outbound.protection.outlook.com ([2a01:111:f403:2418::601] helo=NAM12-BN8-obe.outbound.protection.outlook.com)
	by desiato.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rZLR0-0000000F5Bw-0tL6
	for linux-nvme@lists.infradead.org;
	Mon, 12 Feb 2024 01:48:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hAMumY7cE/tP6k5VzrRuzv+8U0rUCkb/lvNhD67kXbvwPqzInfXejHT6Aj5b3l4pUlghplip0zEq9uBPGWGstqlyv4dxnTvA9vjlEbLcL0Qsgg/v2NDA3ed6NY5vtHx8wQVS+3qVLVgZA3Zi1FTwWz/u+oEhwC2y5F8/kRtnzWJSaOi3/vbz2/FuGOOf+zpWonW0h4b+PZEuXgZTgd5jI7Rg/UOABsiqWT8+0lqqmmRYqU/VZ9DDYHyDMM37+sB+DxZBAHYjTNdns+b/3jV+vVBuvLT/1jrQC15I/rksTd/px+hQjq2h8LcXUr/AglXyn8HmKGH2g8EtF14sCqXx8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E36dXFtDW/oCb91vgE4PoqeHBJDJSZLO9E5VcvDR0M0=;
 b=kSN9QwbJkkvTrz+EfkcvFbXlQo1Qe7CmQ9MkAdhppPhXPD+H0p3u7NkNII5zhvsGYHBMqfDb5L7KJkZNPcOa245MjEGtV7ekZRUH8K6gYJlnb72de6H/eTtnpKy0Rqx0Jlnz1RqhYs5aHQPvpZ4/IxxnERdxrXZsE0EgkVVhZARquzLBgFbvc8sxw0I7YkU+bp3gyCO4Le0U8m6trV1mXXf1YZEzi7q42hX7FK9BqeoAjG4J3alknPfKYcpjnS8+jNzzpiblLT9xRJf1KDL33WthwcslV3iXn1DmzH36VqM31ps3fqn3qeXgGdryyWP7LV4R/ADeNK28K+ka7yAPFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=lists.infradead.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E36dXFtDW/oCb91vgE4PoqeHBJDJSZLO9E5VcvDR0M0=;
 b=jwCuRjf1fADhkPWPmoLGKjKkofGxoMkkyYioPAkqhnUgpMa7ir05ErhrndRXON3gEZZ42mffgnvrX3PJjF5z5vLzypVitsTt5yx3nToutnmBD2NoRNddN/pOIX6d5GRX0qWlT/aP0blSYMOr4batQHzERWFC6lNXQUWnm17+UMGg6Qvx+dmSnl7mmX3Bw7pf1iFN+N5PLHx7CFz2E0MkAJNG7beB8uDOlp5UGuLzA37MDz1lGiTqGrikKq9HTnBcufdt8Ejz6b7ZLqCXcQnJ4bZ3FR0fnwV2KPgda1d1/huduhrPV2sfd6yrnpAdEozErGmDx/1lHkB2fDrYwFT//Q==
Received: from MN2PR10CA0001.namprd10.prod.outlook.com (2603:10b6:208:120::14)
 by BL1PR12MB5093.namprd12.prod.outlook.com (2603:10b6:208:309::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.21; Mon, 12 Feb
 2024 01:48:28 +0000
Received: from BL6PEPF0001AB4F.namprd04.prod.outlook.com
 (2603:10b6:208:120:cafe::53) by MN2PR10CA0001.outlook.office365.com
 (2603:10b6:208:120::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.35 via Frontend
 Transport; Mon, 12 Feb 2024 01:48:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL6PEPF0001AB4F.mail.protection.outlook.com (10.167.242.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7249.19 via Frontend Transport; Mon, 12 Feb 2024 01:48:28 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Sun, 11 Feb
 2024 17:48:11 -0800
Received: from dev.nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Sun, 11 Feb
 2024 17:48:10 -0800
From: Chaitanya Kulkarni <kch@nvidia.com>
To: <linux-nvme@lists.infradead.org>
CC: <kbusch@kernel.org>, <hch@lst.de>, <sagi@grimberg.me>, Chaitanya Kulkarni
	<kch@nvidia.com>
Subject: [PATCH] nvme: nvme.h helper cleanup
Date: Sun, 11 Feb 2024 17:48:03 -0800
Message-ID: <20240212014803.122541-1-kch@nvidia.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4F:EE_|BL1PR12MB5093:EE_
X-MS-Office365-Filtering-Correlation-Id: e598eb52-a59b-4a7f-4925-08dc2b6cb5de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: il0mI5GKfk+bvkIrYFzB9aHqJFGf/7C8aIH1g3JO4kFoan0Di3TdbkB0tZf3n97yDM+DlzKQTTa++jMMM6f3mYSUP1LYav3AYhp2gkDWXQ/CSQVql2GtdF5ZAmHklv+XrIuPn3gluNOrZrOCFZfabLqJjpQBC9rk8wjlNzSabibai8Gulq83XqJGld8jjcJSjhMAtyEjvYJq+aAEvR9AScKH6+ibCAuNptbYetONAtPDBHRaZPqmJFu8GrDSb1Xccvo0PFv/vheqPMV7yoU3HgvL+bbc3QFOfDcjrYaX1gDFhhMX3RKAuUF3N+ucOyB8x9+AU0yoA3lRl9CgVPZdqVvyosk1baP4DrxtCfRFTMRpYQ9gtWP1XyEgR5XRTriha1nKPAnvLi3k5g6v+iM8MacU6ttGioWvMLGFkeTN5eUl3L8DviJr8X0I4Z5PBUiX0diyGThdWX9RFbBy3s7KOe+/A/7T6p50QaDA8SYp0bbUQ3ospnXsfej+22w67sbZfEPD8Ovmlcsct/w9dY1H6lct5ukT+8zp9RgkkcxCtjM33HIh5vz/lupnBKWsg+rbkPVBgF+QAqKO/cRjqxXxg2dy79uNy12oLNObL0qM2kk=
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(396003)(136003)(39860400002)(346002)(376002)(230922051799003)(1800799012)(451199024)(64100799003)(82310400011)(186009)(36840700001)(46966006)(40470700004)(478600001)(41300700001)(8936002)(8676002)(4326008)(5660300002)(2906002)(7696005)(6666004)(70206006)(316002)(54906003)(6916009)(70586007)(83380400001)(2616005)(336012)(426003)(16526019)(356005)(7636003)(26005)(107886003)(1076003)(82740400003)(36756003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2024 01:48:28.5130
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e598eb52-a59b-4a7f-4925-08dc2b6cb5de
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB4F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5093
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240212_014840_620895_E5070F4C 
X-CRM114-Status: GOOD (  12.50  )
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

nvme_ns_head_multipath() is only used in host/core.c :-

  File                     Function
0 drivers/nvme/host/core.c nvme_ns_open
1 drivers/nvme/host/core.c nvme_update_ns_info_generic
2 drivers/nvme/host/core.c nvme_update_ns_info_block
3 drivers/nvme/host/core.c nvme_alloc_ns
4 drivers/nvme/host/core.c nvme_alloc_ns
5 drivers/nvme/host/core.c nvme_ns_remove
6 drivers/nvme/host/nvme.h nvme_ns_head_multipath

nvme_print_defice_info() is only used in host/core.c :-

  File                     Function
0 drivers/nvme/host/core.c nvme_init_ns_head
1 drivers/nvme/host/nvme.h nvme_print_device_info

nvme_is_ana_error() is only used in host/core.c :-

  File                          Function
0 drivers/nvme/host/multipath.c nvme_failover_req
1 drivers/nvme/host/nvme.h      nvme_is_ana_error

nvme_cid_to_rq() is only used in host/tcp.c :-

  File                     Function
0 drivers/nvme/host/nvme.h nvme_cid_to_rq
1 drivers/nvme/host/tcp.c  nvme_tcp_recv_data
2 drivers/nvme/host/tcp.c  nvme_tcp_recv_ddgst
3 drivers/nvme/host/tcp.c  nvme_tcp_recv_ddgst

Move these functions to respective files instead of bloating the header.

Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
---
 drivers/nvme/host/core.c      | 22 +++++++++++++++++++
 drivers/nvme/host/multipath.c | 12 +++++++++++
 drivers/nvme/host/nvme.h      | 40 -----------------------------------
 drivers/nvme/host/tcp.c       |  6 ++++++
 4 files changed, 40 insertions(+), 40 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 60537c9224bf..20c0c141fcc0 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -127,6 +127,28 @@ static void nvme_remove_invalid_namespaces(struct nvme_ctrl *ctrl,
 static void nvme_update_keep_alive(struct nvme_ctrl *ctrl,
 				   struct nvme_command *cmd);
 
+static inline bool nvme_ns_head_multipath(struct nvme_ns_head *head)
+{
+	return IS_ENABLED(CONFIG_NVME_MULTIPATH) && head->disk;
+}
+
+static inline void nvme_print_device_info(struct nvme_ctrl *ctrl)
+{
+	struct nvme_subsystem *subsys = ctrl->subsys;
+
+	if (ctrl->ops->print_device_info) {
+		ctrl->ops->print_device_info(ctrl);
+		return;
+	}
+
+	dev_err(ctrl->device,
+		"VID:%04x model:%.*s firmware:%.*s\n", subsys->vendor_id,
+		nvme_strlen(subsys->model, sizeof(subsys->model)),
+		subsys->model, nvme_strlen(subsys->firmware_rev,
+					   sizeof(subsys->firmware_rev)),
+		subsys->firmware_rev);
+}
+
 void nvme_queue_scan(struct nvme_ctrl *ctrl)
 {
 	/*
diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 74de1e64aeea..5b2581ccb160 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -21,6 +21,18 @@ static const char *nvme_iopolicy_names[] = {
 
 static int iopolicy = NVME_IOPOLICY_NUMA;
 
+static inline bool nvme_is_ana_error(u16 status)
+{
+	switch (status & 0x7ff) {
+	case NVME_SC_ANA_TRANSITION:
+	case NVME_SC_ANA_INACCESSIBLE:
+	case NVME_SC_ANA_PERSISTENT_LOSS:
+		return true;
+	default:
+		return false;
+	}
+}
+
 static int nvme_set_iopolicy(const char *val, const struct kernel_param *kp)
 {
 	if (!val)
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 7b87763e2f8a..3ca486fe927c 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -489,11 +489,6 @@ struct nvme_ns_head {
 #endif
 };
 
-static inline bool nvme_ns_head_multipath(struct nvme_ns_head *head)
-{
-	return IS_ENABLED(CONFIG_NVME_MULTIPATH) && head->disk;
-}
-
 enum nvme_ns_features {
 	NVME_NS_EXT_LBAS = 1 << 0, /* support extended LBA format */
 	NVME_NS_METADATA_SUPPORTED = 1 << 1, /* support getting generated md */
@@ -590,12 +585,6 @@ static inline struct request *nvme_find_rq(struct blk_mq_tags *tags,
 	return rq;
 }
 
-static inline struct request *nvme_cid_to_rq(struct blk_mq_tags *tags,
-                u16 command_id)
-{
-	return blk_mq_tag_to_rq(tags, nvme_tag_from_cid(command_id));
-}
-
 /*
  * Return the length of the string without the space padding
  */
@@ -606,23 +595,6 @@ static inline int nvme_strlen(char *s, int len)
 	return len;
 }
 
-static inline void nvme_print_device_info(struct nvme_ctrl *ctrl)
-{
-	struct nvme_subsystem *subsys = ctrl->subsys;
-
-	if (ctrl->ops->print_device_info) {
-		ctrl->ops->print_device_info(ctrl);
-		return;
-	}
-
-	dev_err(ctrl->device,
-		"VID:%04x model:%.*s firmware:%.*s\n", subsys->vendor_id,
-		nvme_strlen(subsys->model, sizeof(subsys->model)),
-		subsys->model, nvme_strlen(subsys->firmware_rev,
-					   sizeof(subsys->firmware_rev)),
-		subsys->firmware_rev);
-}
-
 #ifdef CONFIG_FAULT_INJECTION_DEBUG_FS
 void nvme_fault_inject_init(struct nvme_fault_inject *fault_inj,
 			    const char *dev_name);
@@ -682,18 +654,6 @@ static inline u32 nvme_bytes_to_numd(size_t len)
 	return (len >> 2) - 1;
 }
 
-static inline bool nvme_is_ana_error(u16 status)
-{
-	switch (status & 0x7ff) {
-	case NVME_SC_ANA_TRANSITION:
-	case NVME_SC_ANA_INACCESSIBLE:
-	case NVME_SC_ANA_PERSISTENT_LOSS:
-		return true;
-	default:
-		return false;
-	}
-}
-
 static inline bool nvme_is_path_error(u16 status)
 {
 	/* check for a status code type of 'path related status' */
diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index a6d596e05602..0bc6bd377c87 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -84,6 +84,12 @@ static void nvme_tcp_reclassify_socket(struct socket *sock)
 static void nvme_tcp_reclassify_socket(struct socket *sock) { }
 #endif
 
+static inline struct request *nvme_cid_to_rq(struct blk_mq_tags *tags,
+		u16 command_id)
+{
+	return blk_mq_tag_to_rq(tags, nvme_tag_from_cid(command_id));
+}
+
 enum nvme_tcp_send_state {
 	NVME_TCP_SEND_CMD_PDU = 0,
 	NVME_TCP_SEND_H2C_PDU,
-- 
2.40.0


