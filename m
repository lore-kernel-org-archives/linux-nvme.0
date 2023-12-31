Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C843C47073
	for <linux-nvme@archiver.kernel.org>; Sun, 31 Dec 2023 00:53:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:CC:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=W++XI6Pq4ojnPxL5Y2L4tn6ntZtJNUJhdraRmKOybDY=; b=vBU7+DDPEPRLo8949ERxp1Zf7k
	IKZjADGoTTSfOOuXm/NLZewjRyTonTV4MKRTBTfndoz4Kt2n8if/pzEJeuXls7DPWhg7KUAxpv8/t
	Ta6LEeqs8APLblm2YashH73F+/avRn5n/WmmFuw48XB0Nqei8URW4EoPBpr6jGF7530xZngd5vy0W
	ndCTRXNjq40wBMP8GMcj8G0uRNb2l+b6jH+AHVpJNHvOdqBY6eJ0BLUsE7gy+sgbcXmeX+EbTzq1B
	q0ADBdn4MPO5CeSktNpu58JbGtfQ4xCit5RMqDQucXuOSx5hX0uMp0UoVOHmShr6apuAvYsfwHNbo
	bUbrPQsw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rJk5D-003gBp-0k;
	Sun, 31 Dec 2023 00:53:39 +0000
Received: from mail-dm3nam02on20624.outbound.protection.outlook.com ([2a01:111:f400:7e83::624] helo=NAM02-DM3-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rJk57-003g6w-3C
	for linux-nvme@lists.infradead.org;
	Sun, 31 Dec 2023 00:53:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ISVgBieCBtphkEaC2oZgfIfy5molghgnQrFsf9+FlRWSSOHd+/bhbfubmMec84r2zh6eQuvrU4WLhy4xXlnDfVhHmPMdSL7QqikySIX4F3mLtWhAPQs6njgxYS0euoRy/JwzDaS9u177FPo2HglISAASW/hv+hTnUvXXs4Qxb+X2PUxrlWMgbUFrotQu9nja5jEEFwxcwdtWcVMllXGdu9lb6hIuGG7jRvZm7+5y0gmU32L1DJv2VOCSveysZ4yPs/7tRjF3WxQtA4CwJieRgyh7NV2Mk0nxh8l6pw+Fprphy7NrG7VtOg0dkgtXXWxsP+Iv5LTYM251ImccMrTK1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W++XI6Pq4ojnPxL5Y2L4tn6ntZtJNUJhdraRmKOybDY=;
 b=M4cCSaoAlECYz1IE+27eNOUhvdLxo5rKCv5T1IeYuaXe3j5jxLIPV+w+wS2s3iuwQ+CPs3y7WzO+FPJdR+vL9e/z5oj7Naw+TpFPINFwwNKJJ3wXzlA/2zqIgC4J3F8F1rbkhojaDxHkdfNfNBXT/qeW9KvkVpNJUScNOI3bV4BDKQsQ9CNC6Q9MSM3iMzaFmm687VIBsmpMnaTe+yGmrRanOAv7HInV3VC+BEmc9CK0BHWl91Y4dBop9ywem1Zsua6PCAqGxIa3p8DItGlV6DswAvJqqq1beJxtr37E5QC5Ns2eMtEAQgfIQQICxzljbzsby/lIcjBp6rdiecUG/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W++XI6Pq4ojnPxL5Y2L4tn6ntZtJNUJhdraRmKOybDY=;
 b=VkrdawksWRTnOxxl3EqB/w60uleppXmI38tXQHfN2ZFva5vln0cfc79k1Ot/zeMfyWTDqv4LO4YzxyHx47FR7ikLfnnCJ3UW5bt6e6syG6zwpNRi+cfvVwz8Df9gweSgzrVhWIrLOQWmsYE8syFOIxaZzidMpUxXvv0c/J6OfEQi3hk2wnkGe3hQyfYhw1CT7F2ZSfBEBMF9ei43Tdzq1eLS8WRdOq+6O+mhWFkjP8EBvAKI+4CBeseYHiESM37KY3xzdPDWrtIW4LET+XoiLMrKnh/WIeiPGX6kjyzL76VhM9hJlI4lvYHXxusgrjJM26ogMW+q5zmUqvAwrQBwbg==
Received: from SN7PR18CA0012.namprd18.prod.outlook.com (2603:10b6:806:f3::35)
 by SN7PR12MB7912.namprd12.prod.outlook.com (2603:10b6:806:341::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.22; Sun, 31 Dec
 2023 00:53:29 +0000
Received: from SA2PEPF00001506.namprd04.prod.outlook.com
 (2603:10b6:806:f3:cafe::1) by SN7PR18CA0012.outlook.office365.com
 (2603:10b6:806:f3::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.21 via Frontend
 Transport; Sun, 31 Dec 2023 00:53:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SA2PEPF00001506.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7159.9 via Frontend Transport; Sun, 31 Dec 2023 00:53:29 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Sat, 30 Dec
 2023 16:53:17 -0800
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Sat, 30 Dec
 2023 16:53:17 -0800
Received: from r-arch-stor03.mtr.labs.mlnx (10.127.8.14) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.986.41 via Frontend
 Transport; Sat, 30 Dec 2023 16:53:14 -0800
From: Max Gurtovoy <mgurtovoy@nvidia.com>
To: <kbusch@kernel.org>, <hch@lst.de>, <sagi@grimberg.me>,
	<linux-nvme@lists.infradead.org>
CC: <kanie@linux.alibaba.com>, <oren@nvidia.com>, <israelr@nvidia.com>,
	<kch@nvidia.com>, Max Gurtovoy <mgurtovoy@nvidia.com>
Subject: [PATCH 09/10] nvmet: introduce new max queue size configuration entry
Date: Sun, 31 Dec 2023 02:52:48 +0200
Message-ID: <20231231005249.18294-10-mgurtovoy@nvidia.com>
X-Mailer: git-send-email 2.18.1
In-Reply-To: <20231231005249.18294-1-mgurtovoy@nvidia.com>
References: <20231231005249.18294-1-mgurtovoy@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001506:EE_|SN7PR12MB7912:EE_
X-MS-Office365-Filtering-Correlation-Id: 514c5a0d-58e6-4d2d-79b2-08dc099ae781
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GproeVEJ0lcKD8mYFWER6QqanWeW1wbM1fC1qPynED0QimBY/9R1IIRv393lB6baGIjdGZZ5ooGmWk5TmP/ysxVZb2c8O4Pa2P4wEuhoDWSluLFeV4c54yboobDU9pWJqxuYLaky0hOO8lvm90t75KX4GzIVuEiHeCSlypJ0QC3f8M7SCp9mHITXM+aGHGyMpNepvJPJnfbn3+OnGJttDVodqAP9IOcunsD0M9qLjuV35sJlscoeTB+RWGGjtYR1cYoJLI256a2pGyQDY4Ny8EQHwjCKa7h1SSFIWqU5J5t/zSZnLpbwYS1oOgdS+WB3AXy+gGMiDNllnlZ++SpfdHxxYb2PVPEw9B5KabVyBWdb41kLJDIliTCEnJsDWzSH426+jSa+WUbXEryXpNOLzvaqB3CbqmI+3njTtQLCZTQlW9uxeJcFlgzFqCd6k5Qat8GVYKcPWEZS37sTI+4zcRAbQMveiOkf5i27U6JmbaoKKBFrlLFvPzUXm7xba60zLDtiv+QD81t5xTQSRrzrzwXtffnNvrABqrozjJbU863Cv6PXthvP4/w6sur9ZuwzlVg/NTMBI5RuyR1202xFzY8amf1Si77XJT6kJjiIrw1kUOdo90sWUFbDwRWNBjz5f9W1RF6U0Gjw7gUFSjoFK68pvfNPwoBXBvz3aS/ZbygyPp+i0KktK2d4ksfX4mXeTlgMfsUrhdwbn6JEc3T0UHd7xp5cNiDUrt3hPC3mZYW/SxGkwEsqvItvJPm590Dw
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(396003)(376002)(136003)(346002)(230922051799003)(451199024)(186009)(82310400011)(1800799012)(64100799003)(46966006)(36840700001)(40470700004)(2906002)(2616005)(36756003)(86362001)(107886003)(70586007)(40480700001)(478600001)(70206006)(5660300002)(83380400001)(336012)(426003)(26005)(1076003)(110136005)(54906003)(8936002)(8676002)(316002)(40460700003)(4326008)(6666004)(47076005)(36860700001)(41300700001)(356005)(82740400003)(7636003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Dec 2023 00:53:29.1997
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 514c5a0d-58e6-4d2d-79b2-08dc099ae781
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00001506.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7912
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231230_165334_037661_9E56C16D 
X-CRM114-Status: GOOD (  16.14  )
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

Reviewed-by: Israel Rukshin <israelr@nvidia.com>
Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
---
 drivers/nvme/target/configfs.c | 28 ++++++++++++++++++++++++++++
 drivers/nvme/target/core.c     | 16 ++++++++++++++--
 drivers/nvme/target/nvmet.h    |  1 +
 3 files changed, 43 insertions(+), 2 deletions(-)

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
index f08997f58101..f7d82da4c1bc 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -358,6 +358,17 @@ int nvmet_enable_port(struct nvmet_port *port)
 	if (port->inline_data_size < 0)
 		port->inline_data_size = 0;
 
+	/*
+	 * If the transport didn't set the max_queue_size properly, then clamp
+	 * it to the global fabrics limits.
+	 */
+	if (port->max_queue_size < 0)
+		port->max_queue_size = NVMF_MAX_QUEUE_SIZE;
+	else
+		port->max_queue_size = clamp_t(int, port->max_queue_size,
+					       NVMF_MIN_QUEUE_SIZE,
+					       NVMF_MAX_QUEUE_SIZE);
+
 	port->enabled = true;
 	port->tr_ops = ops;
 	return 0;
@@ -1223,9 +1234,10 @@ static void nvmet_init_cap(struct nvmet_ctrl *ctrl)
 	ctrl->cap |= (15ULL << 24);
 	/* maximum queue entries supported: */
 	if (ctrl->ops->get_max_queue_size)
-		ctrl->cap |= ctrl->ops->get_max_queue_size(ctrl) - 1;
+		ctrl->cap |= min_t(u16 , ctrl->ops->get_max_queue_size(ctrl),
+				   ctrl->port->max_queue_size) - 1;
 	else
-		ctrl->cap |= NVMF_MAX_QUEUE_SIZE - 1;
+		ctrl->cap |= ctrl->port->max_queue_size - 1;
 
 	if (nvmet_is_passthru_subsys(ctrl->subsys))
 		nvmet_passthrough_override_cap(ctrl);
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index a76f816edf1d..ab6459441376 100644
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
-- 
2.18.1


