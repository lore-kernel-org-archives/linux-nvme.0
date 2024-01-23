Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DE4FC47DDB
	for <linux-nvme@archiver.kernel.org>; Tue, 23 Jan 2024 14:41:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:CC:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=XBy4PPmf59Sygde2hlQX82J+gjl0Pr/s8CaEaxXjBRA=; b=ZOkdxDjujpmWmxFEnAPGCb/9dw
	JMVHYzlQRSOTWWAWNDJbdx40VbZQokdGZx8scxUJXfte0WTnfrKNfpczFyJYYNRBUbTveszK1YdkZ
	WhErE/aWAuMk+yxvZqIpUXwBtsKADZu8gWKJ+JrUAGT+j7Gjyu0r1roh61YxN6IA2koycuCxdevZt
	HnwwdGy0r0evHN6zss8U1afK1gcNOTopJP/gH8IKWnQaz9sXRVfolAdudy+6Ni+J8fFxVD1LHM/Sv
	amd4AlpbBCsGG0Cdo07mVypj1eET8UBFNL+dKAgV1CUG98vQQ/Cnj+vMbr4ZaBMcwmlLX2Vp+0867
	oCX5Yh9A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rSHxh-00GqyM-2K;
	Tue, 23 Jan 2024 14:41:13 +0000
Received: from mail-mw2nam10on20600.outbound.protection.outlook.com ([2a01:111:f403:2412::600] helo=NAM10-MW2-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rSHxd-00Gqv9-2P
	for linux-nvme@lists.infradead.org;
	Tue, 23 Jan 2024 14:41:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mLvkx0r3s/cwp8furnjB3XD8Xoc0JC1cpr4glmWPzhmmBcYk9Chi545kczRWQTW/SJDqDWOD6UQntkM4Z2lHbfUfpUxlDbTtIcrlxReBjyuLOHt1xWTeZUx8aEWD9WUgTG5rnxb7wgqFPlJGGEEQ/8ZvcDpKRUD5GNtpWGLcWRJUlmgunhTJNDfisphjs3jODZSUXMrWheHEbMlCswNPNOdc1P0/LFIV96vvD7cwnKKvLtYPMUzVDHdvEwpl6lQOKGkLYDYIsp+nttCuNhHv9NDjV4Kg1dv9aB1boAdaqXUhZgpafnPcysR0b/L+uFSOn+x0JDcYQEtwpj64XLZHsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XBy4PPmf59Sygde2hlQX82J+gjl0Pr/s8CaEaxXjBRA=;
 b=QVzeMuzrHOw/K3HEVciZUGGFMZgNP1RxoxSYEnpoEpMd+51QN8k4C1DOPPTrQU1vBF+I78ur+a1XQDxDWbwpEzEbbeQhaElxVh2kQdCt44mmiFbb7xD+YDQdkAV+av5yiASQ3+aSj7tXL8g4Vgt19Aedy348mV6dmUZbjXxDA0RqZNPY4BvTGVWui6BCMFOJ37nt6S29M8ov16C1zP79/n/4WqAa0c0JuPDUraB8B2D66iLhNX/T+oMvXjwWd4WZhC+O09WymX/siWqkngQV17MlHOM+Xgzj97mtsEUYJ8p8Dm/BzHg47Q5mcPbbOGjPGj5mAuuN5jO4NdrT/unwOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XBy4PPmf59Sygde2hlQX82J+gjl0Pr/s8CaEaxXjBRA=;
 b=frbeiIbHiCbUdYPFRF7WOlL5KNdxnp9Ldj8+OWWC+M0d5e9E8MnMg+Jno/MpB6nJbX5u6JkoFnBqDb51cORtrg4DvEmIvMPy+j1JEITzH6bdgwrBzd/I/A1B5jj5HGmc9P2PXwWLrZLBt+uSR8K+S0FQNsE+f0Voe4IlTi29IfkohKCF29wsAvX55R4EcPvbh1vpOM2e4zqCVw+8JHBrgVcDrbSPFtvuAjh+KRjSLs5KUOnyBaawKHPprsuSBrpSJYnPI+zwnaq5CEHjBuihXvEU1Pbj0Wsw46GLcuVM82UX6Ltf3lwhlCBjf1bjP3uki+if/+QpjQ47NZAS4ufIdA==
Received: from DM6PR10CA0034.namprd10.prod.outlook.com (2603:10b6:5:60::47) by
 SA0PR12MB4591.namprd12.prod.outlook.com (2603:10b6:806:9d::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7202.37; Tue, 23 Jan 2024 14:41:06 +0000
Received: from CY4PEPF0000E9D7.namprd05.prod.outlook.com
 (2603:10b6:5:60:cafe::58) by DM6PR10CA0034.outlook.office365.com
 (2603:10b6:5:60::47) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.38 via Frontend
 Transport; Tue, 23 Jan 2024 14:41:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CY4PEPF0000E9D7.mail.protection.outlook.com (10.167.241.78) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7181.14 via Frontend Transport; Tue, 23 Jan 2024 14:41:06 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 23 Jan
 2024 06:40:53 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Tue, 23 Jan 2024 06:40:53 -0800
Received: from r-arch-stor03.mtr.labs.mlnx (10.127.8.14) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.986.41 via Frontend
 Transport; Tue, 23 Jan 2024 06:40:51 -0800
From: Max Gurtovoy <mgurtovoy@nvidia.com>
To: <kbusch@kernel.org>, <hch@lst.de>, <sagi@grimberg.me>,
	<linux-nvme@lists.infradead.org>, <kch@nvidia.com>
CC: <oren@nvidia.com>, <israelr@nvidia.com>, Max Gurtovoy
	<mgurtovoy@nvidia.com>
Subject: [PATCH 7/8] nvmet: introduce new max queue size configuration entry
Date: Tue, 23 Jan 2024 16:40:31 +0200
Message-ID: <20240123144032.27801-8-mgurtovoy@nvidia.com>
X-Mailer: git-send-email 2.18.1
In-Reply-To: <20240123144032.27801-1-mgurtovoy@nvidia.com>
References: <20240123144032.27801-1-mgurtovoy@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D7:EE_|SA0PR12MB4591:EE_
X-MS-Office365-Filtering-Correlation-Id: 7bc7a3d7-329f-450b-968c-08dc1c2154d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 66r4wavtzfLTjDQkeQFKQaGBDn2GtBsSY83/oJ1IFjeMUW408f3fBTn6FseQMH3IfB07kn23cuMOvvbq+9oOcq9BMw8Dc6FJz/+97PmE1eqD3fyhJdZBSQm1gJapjdvTYQgq6lgKIwO5PIUInCpJ/YeVo59qwJ+xzZIP3zpm3gMAhhs7Bw9nSziDBwceQhGAWVp+ZtnQhNqRdapHXS+zuA0EmZ6b7MnxNr/b+s4uUTzLof2946fj9iwKciyh9t6R32EeDE4YkvCBqgAMDUi9JFZ9Dbf3HDwmqWkioTb1K5MAYPu190dwVhWrC1Zy/N0vz/LO4GdLEByy1NCiD25EKYqt/oo0tdFoZqimiwBJ+ryUZhFo8okNoyXBfyOZyH7mNmMqsZvJOe2+G3V4hRu7604Zt9WK17MnqB/VvF8wBx5w3smkguiXXlP3VM560HnAvWBjOTNH4hai1IgxH6EEKFCxnVYMJ+mnRis7NbRhmw3pVuSQ0GOv00h/VkbOWVAXM9vp/G0ypqse4L7NtNkGZd5gvIT3HKxzAj9U57Cb+4SxfXSCbPP2m5rHuohdgR3H9LSSPSHhjp7jOS9uttJi1swK2AbtoW3Ks+DrbOVe3a3pxeANjgRlPf63EGSGQ2+aCuSTkjTvNS6Z3jgwflC4d0MRgJYWn2hnb3PriZ5G8XDYqbyrDorkooFfK+htQVazcbP/DUzkeIJmJxxmfpNqc/dgOETMTFL9F3k2QinSO7a/rEID9F6tieaL3HiVtsNz
X-Forefront-Antispam-Report: CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(136003)(346002)(396003)(376002)(39860400002)(230922051799003)(186009)(64100799003)(82310400011)(1800799012)(451199024)(36840700001)(46966006)(40470700004)(6666004)(86362001)(2616005)(54906003)(7636003)(70206006)(6636002)(70586007)(356005)(110136005)(107886003)(316002)(36756003)(41300700001)(4326008)(5660300002)(26005)(47076005)(8676002)(8936002)(83380400001)(1076003)(82740400003)(2906002)(36860700001)(426003)(336012)(478600001)(40480700001)(40460700003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2024 14:41:06.1350
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bc7a3d7-329f-450b-968c-08dc1c2154d1
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D7.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4591
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240123_064109_834970_7EDC1AE2 
X-CRM114-Status: GOOD (  19.18  )
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

Using this port configuration, one will be able to set the maximal queue
size to be used for any controller that will be associated to the
configured port.

The default value stayed 1024 but each transport will be able to set the
its own values before enabling the port.

Introduce lower limit of 16 for minimal queue depth (same as we use in
the host fabrics drivers).

Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Israel Rukshin <israelr@nvidia.com>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Reviewed-by: Guixin Liu <kanie@linux.alibaba.com>
Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
---
 drivers/nvme/target/configfs.c | 28 ++++++++++++++++++++++++++++
 drivers/nvme/target/core.c     | 17 +++++++++++++++--
 drivers/nvme/target/nvmet.h    |  4 +++-
 3 files changed, 46 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
index bd514d4c4a5b..f8df2ef715ba 100644
--- a/drivers/nvme/target/configfs.c
+++ b/drivers/nvme/target/configfs.c
@@ -272,6 +272,32 @@ static ssize_t nvmet_param_inline_data_size_store(struct config_item *item,
 
 CONFIGFS_ATTR(nvmet_, param_inline_data_size);
 
+static ssize_t nvmet_param_max_queue_size_show(struct config_item *item,
+		char *page)
+{
+	struct nvmet_port *port = to_nvmet_port(item);
+
+	return snprintf(page, PAGE_SIZE, "%d\n", port->max_queue_size);
+}
+
+static ssize_t nvmet_param_max_queue_size_store(struct config_item *item,
+		const char *page, size_t count)
+{
+	struct nvmet_port *port = to_nvmet_port(item);
+	int ret;
+
+	if (nvmet_is_port_enabled(port, __func__))
+		return -EACCES;
+	ret = kstrtoint(page, 0, &port->max_queue_size);
+	if (ret) {
+		pr_err("Invalid value '%s' for max_queue_size\n", page);
+		return -EINVAL;
+	}
+	return count;
+}
+
+CONFIGFS_ATTR(nvmet_, param_max_queue_size);
+
 #ifdef CONFIG_BLK_DEV_INTEGRITY
 static ssize_t nvmet_param_pi_enable_show(struct config_item *item,
 		char *page)
@@ -1856,6 +1882,7 @@ static struct configfs_attribute *nvmet_port_attrs[] = {
 	&nvmet_attr_addr_trtype,
 	&nvmet_attr_addr_tsas,
 	&nvmet_attr_param_inline_data_size,
+	&nvmet_attr_param_max_queue_size,
 #ifdef CONFIG_BLK_DEV_INTEGRITY
 	&nvmet_attr_param_pi_enable,
 #endif
@@ -1914,6 +1941,7 @@ static struct config_group *nvmet_ports_make(struct config_group *group,
 	INIT_LIST_HEAD(&port->subsystems);
 	INIT_LIST_HEAD(&port->referrals);
 	port->inline_data_size = -1;	/* < 0 == let the transport choose */
+	port->max_queue_size = -1;	/* < 0 == let the transport choose */
 
 	port->disc_addr.portid = cpu_to_le16(portid);
 	port->disc_addr.adrfam = NVMF_ADDR_FAMILY_MAX;
diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index ade5a7bd7f6d..d34520359cc9 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -358,6 +358,18 @@ int nvmet_enable_port(struct nvmet_port *port)
 	if (port->inline_data_size < 0)
 		port->inline_data_size = 0;
 
+	/*
+	 * If the transport didn't set the max_queue_size properly, then clamp
+	 * it to the target limits. Also set default values in case the
+	 * transport didn't set it at all.
+	 */
+	if (port->max_queue_size < 0)
+		port->max_queue_size = NVMET_MAX_QUEUE_SIZE;
+	else
+		port->max_queue_size = clamp_t(int, port->max_queue_size,
+					       NVMET_MIN_QUEUE_SIZE,
+					       NVMET_MAX_QUEUE_SIZE);
+
 	port->enabled = true;
 	port->tr_ops = ops;
 	return 0;
@@ -1223,9 +1235,10 @@ static void nvmet_init_cap(struct nvmet_ctrl *ctrl)
 	ctrl->cap |= (15ULL << 24);
 	/* maximum queue entries supported: */
 	if (ctrl->ops->get_max_queue_size)
-		ctrl->cap |= ctrl->ops->get_max_queue_size(ctrl) - 1;
+		ctrl->cap |= min_t(u16, ctrl->ops->get_max_queue_size(ctrl),
+				   ctrl->port->max_queue_size) - 1;
 	else
-		ctrl->cap |= NVMET_QUEUE_SIZE - 1;
+		ctrl->cap |= ctrl->port->max_queue_size - 1;
 
 	if (nvmet_is_passthru_subsys(ctrl->subsys))
 		nvmet_passthrough_override_cap(ctrl);
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index 144aca2fa6ad..7c6e7e65b032 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -163,6 +163,7 @@ struct nvmet_port {
 	void				*priv;
 	bool				enabled;
 	int				inline_data_size;
+	int				max_queue_size;
 	const struct nvmet_fabrics_ops	*tr_ops;
 	bool				pi_enable;
 };
@@ -543,7 +544,8 @@ void nvmet_subsys_disc_changed(struct nvmet_subsys *subsys,
 void nvmet_add_async_event(struct nvmet_ctrl *ctrl, u8 event_type,
 		u8 event_info, u8 log_page);
 
-#define NVMET_QUEUE_SIZE	1024
+#define NVMET_MIN_QUEUE_SIZE	16
+#define NVMET_MAX_QUEUE_SIZE	1024
 #define NVMET_NR_QUEUES		128
 #define NVMET_MAX_CMD(ctrl)	(NVME_CAP_MQES(ctrl->cap) + 1)
 
-- 
2.18.1


