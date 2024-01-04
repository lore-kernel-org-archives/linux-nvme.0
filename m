Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5770AC47074
	for <linux-nvme@archiver.kernel.org>; Thu,  4 Jan 2024 09:26:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:CC:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=SxXusN0aBufLkEOKRhut1zhwHquWtIwz6owFk0p4T00=; b=C9Wuj2cxbYxjyA2wWWXQZwXhEk
	dxL5j864kWGye+hbs3qvv9lGK1EpnYX/SMAqmzDuHEhsdDSLWyrrk/pGBR6xjeE/5oG3dOCSBdnjz
	I8gBiXVeaME8cIQWnnX2TQdKPps8wPgfgdizxK+czpW0pwoyYSboZiKvQy4MOuq6ts4arstCobgjb
	fomydNNEqmpYGYpmaNlndpcd02aOr8HDVTRB9ApmmZt0GewLk9sFAPLO3rlzJLEvMm5Fmriqa2/+R
	mA1R+pZl9AN7nJQ1tUUxkOxiWwNfRkIJmSfHaf7WTcIZxV0TlNItJ1qPyKDUalgw5lIvx95By1GK0
	zplJw2dA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rLJzk-00DMWM-1m;
	Thu, 04 Jan 2024 09:26:32 +0000
Received: from mail-mw2nam12on20616.outbound.protection.outlook.com ([2a01:111:f400:fe5a::616] helo=NAM12-MW2-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rLJzi-00DMSV-01
	for linux-nvme@lists.infradead.org;
	Thu, 04 Jan 2024 09:26:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h/IAJ8zh6UwuiwgBJ94+nSRP7L6rkLNXPJH2i6kizvvexjjnNwdnHjX1J0fh1QHzNlhZYh8omySKrTq8vjkO4L0HRe3JQIZN2PXHfGYRGG7zZVtqzXUWyzXwplP35GdY8WalCcfm+fCktMVxwocZRC33R0Allk3/Y+EP223IFs7s4KLvCdm2FoJOdp9VoTxdY7+SUVZ1axDKX5FJAPZYk1osAkTHZODy8NcllFjgnqQjX9HRvgsLgy3J+IFBW1JORiksNbm0IjmaR/Qvhr8nPJG52GqH6zJS37Uh/QJpC1EnTgPfFvUUzUXlYSFRtDszAOtmb620891RwG2ufCEBBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SxXusN0aBufLkEOKRhut1zhwHquWtIwz6owFk0p4T00=;
 b=MTdbedUnmNfahlSqKnECPNhaQZNkTywhuWd+BkcM0yHhevNlg6wLOb3jNStve4j2Tu5j0xc2tw2PGJah+We2YOWU3yzvqznrB6bMBIP1iZQj30cLNI0qzqLxwT/eufmxhGxDiaf3YfY5IMafgUbBTMJL7FkyWpqShtbVSbKG4SF/zx2faFT/423q922NYblPiRr1lhuaR85ckzQ5+hKbQJIoj2dfhORUAXNQGwUwFeKLpW2oWulyE5g6yFFintTuyj/h4q+tQo+QpFXs1DbkvBNRKN5KNx3Wa9+pbjempBQMldRHAmQeoqYobSgh9jWTSZeyRZ2vJWFKC0i6W2+WSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SxXusN0aBufLkEOKRhut1zhwHquWtIwz6owFk0p4T00=;
 b=oQVWCrX86/9XtiMzuxrejDa6EtQCDY5U4BCZSOKpZE4eozUl259HosM3iA/hjAS+q0ppxatqBpWF9txeOjywr4enfmJnQJUbox797CAg1Tg7Q04Z2+Hx0u2qBZ4krrF7RtkrDPj3MTC6lS14CJfRWauU9/u0SD/d4XvdMylnaJaVqiGo24K1C0kojOjgRcn8b1U7B0V0rt7HcJvaXhohM1iVa917lPOKYsXfcwpXvbuI39Oh6M6YFl4sTnJUHkgVgzQ9Vk7F28QDDUgCGQqJ6vApJXWc4tfcKb6XOrWHI9PaKQaOkvrrf3jiQIY3eycJMVL8a8mPCPAHvg9BieG60A==
Received: from MW4PR03CA0084.namprd03.prod.outlook.com (2603:10b6:303:b6::29)
 by PH8PR12MB6937.namprd12.prod.outlook.com (2603:10b6:510:1bc::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.13; Thu, 4 Jan
 2024 09:26:22 +0000
Received: from CO1PEPF000044F7.namprd21.prod.outlook.com
 (2603:10b6:303:b6:cafe::95) by MW4PR03CA0084.outlook.office365.com
 (2603:10b6:303:b6::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.13 via Frontend
 Transport; Thu, 4 Jan 2024 09:26:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CO1PEPF000044F7.mail.protection.outlook.com (10.167.241.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7181.1 via Frontend Transport; Thu, 4 Jan 2024 09:26:21 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Thu, 4 Jan 2024
 01:26:09 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Thu, 4 Jan 2024 01:26:09 -0800
Received: from r-arch-stor03.mtr.labs.mlnx (10.127.8.14) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.986.41 via Frontend
 Transport; Thu, 4 Jan 2024 01:26:07 -0800
From: Max Gurtovoy <mgurtovoy@nvidia.com>
To: <kbusch@kernel.org>, <hch@lst.de>, <sagi@grimberg.me>,
	<linux-nvme@lists.infradead.org>
CC: <israelr@nvidia.com>, <kch@nvidia.com>, <oren@nvidia.com>, Max Gurtovoy
	<mgurtovoy@nvidia.com>
Subject: [PATCH 7/8] nvmet: introduce new max queue size configuration entry
Date: Thu, 4 Jan 2024 11:25:48 +0200
Message-ID: <20240104092549.25721-8-mgurtovoy@nvidia.com>
X-Mailer: git-send-email 2.18.1
In-Reply-To: <20240104092549.25721-1-mgurtovoy@nvidia.com>
References: <20240104092549.25721-1-mgurtovoy@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F7:EE_|PH8PR12MB6937:EE_
X-MS-Office365-Filtering-Correlation-Id: c71e76d6-c4d4-4b08-4684-08dc0d073707
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YNUIVKc4vh6tsX4U164rCY0XqycgnvYnanIbfXshsgZlPKv5UxgevqP4zzijvAfzTMrAyAaBykHHDA3RGhUzRk46Gij5HKIaa/8ESiCXP2imodS/EhrBDILOvXkDTACB39WOtySA1fWXUV8DCuhi9vfKdHr7VAkmDpih782Ts36AmURScwWua7bdHQSeQNW3C+nJj/eQ5uHGIH/Z2j5hPbTX13Chqzsv7N+fvm6zfnIsu0BAcxpNWK4p0Po0Wal4tq9NyLUGu9HjDelxYhXbT1H8pZbw3fe1mOGk4EL1l3PtP6TNv0sa796HbMQH7bhOp6MCsQwYIbOaPFOqx4uc5F7JIWqacQdnbhPxTHj731aXOdtLohDrgB+iwKN5H81vRmDr3CYa4hPwuHoZj79lX9uCwPB4k+TTPU+Q9Mv5+LilWxsdGQMtTaqLrxWDfX3rwtY8PafUQE/4O1vnsO4AWXetvzhY2ohx6aWNJqpbj+ZH8lvHCPP/Cqch+tH6SezFPFfa1HTBHWNkCSZo+7jX2sk1sYR2petVoTAAig7Su4XMv07KhZOuGzrf8n0rx3ixCNBLjd/lisRfJExdWc4howuNUiRXiSt1oRGnak3lvxU400cwVEDNRVGFLqM7YI7Swvm0zrrQdtbWtDFUpcaKm2Q2Nwt9a6/Ug6PBPgRBVi3SxqQRPE+w6UgHA8UTEA+ff4OtRVYT3qWt3Jc6miyHhS348DZhyFmujQDT55J4o5ObqVaXt0bDvA/Q5n1taYP2
X-Forefront-Antispam-Report: CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(136003)(376002)(346002)(39860400002)(396003)(230922051799003)(1800799012)(451199024)(82310400011)(64100799003)(186009)(40470700004)(46966006)(36840700001)(40460700003)(36756003)(40480700001)(70206006)(86362001)(70586007)(426003)(336012)(7636003)(356005)(5660300002)(41300700001)(6666004)(26005)(1076003)(107886003)(2616005)(47076005)(2906002)(4326008)(82740400003)(478600001)(316002)(36860700001)(54906003)(8936002)(83380400001)(110136005)(8676002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2024 09:26:21.8141
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c71e76d6-c4d4-4b08-4684-08dc0d073707
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F7.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6937
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240104_012630_052641_C3C6262A 
X-CRM114-Status: GOOD (  19.13  )
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


