Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A871C77B7C
	for <linux-nvme@archiver.kernel.org>; Fri, 12 May 2023 08:22:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=/arxiupp6JW7q2R7PmjNwYCAJDxWRgCVSXx3beO1a00=; b=B0CVg6W+2jP6piMC5lBfz5hBoz
	ZaIxWt0GWyy6Tlzd9aw4/VcKBwpwU5DSYYlQZr+KlZzbbXp5OZ2I8e1dIf3PRQon3yV/2gzrvlFuD
	ytYGX3nQxiUWbSqsqlekhGbLKvxAWq4vvWaJjkhJqpsDUVbz/tnzc2YkLoHzvpr3x2sStDSFhEwbE
	olhulZF8vKdTb+GlK3govnr05J5c/w8SiXtXsDZ0n8fEpjji0RptY7O3plRrbCRZchZ/YdfF5WwiS
	miFH/+qzHluHifL7ZFxuI3IT9b0MNaeICs6LjmtyuMS1X3a0i7Ds3IuQRWNyvREcm4rvMt9PajaWl
	oRo7+KXg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pxO2t-00BJk6-08;
	Fri, 12 May 2023 08:22:35 +0000
Received: from mail-dm6nam11on2062f.outbound.protection.outlook.com ([2a01:111:f400:7eaa::62f] helo=NAM11-DM6-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pxO2p-00BJj1-1K
	for linux-nvme@lists.infradead.org;
	Fri, 12 May 2023 08:22:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PRLZ4NzEczZ3ThFq0O2HKHWt2DcOl2eCp3V4emSq3Es9FE3AG5Do2ZPJnA+4CILjQnpLH31UBeuUw1dHBes+NTwxh7PWz9i4PM2uPaTvPrEeDnKoUkNYWcWUMLRxdCLQWWJQZa9aitF3sQ83LGA0vP5DvgyqaxvASKBIE46yssl6rfgXntqo9CBm5V3ubGYyW7+Po+7ulzpvolCCKtf3dLglz9i0rtLjsctTqQ/EPuLK6rX5fwyzHN27obETgnzuZagU0pj8UI/v2Kyal4VmUMl3asNs/LJMIQhGpjsHj6umgseF0xe07/pVqwNdaPohvuxv2YqKfo4gDkIj54P4BA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/arxiupp6JW7q2R7PmjNwYCAJDxWRgCVSXx3beO1a00=;
 b=eokH0oToWkpzooK+Ma3njo+1SSVjU/VAmofKQOHjduzx/MsS6AfYlJtzr9ATIS5sWYXif+UzwskkGr+OTH++dHLLxVMf2/t+UnkM1e4cT+TPVJ2MIqJz4feqgd2BoR5MEWtgEbDt86ZpquXFsipJwt0xoI/ynYcWIRLhGgNFw3PfUGSSAC9MVKgqW5duSteeaJs/8aB/hLwdRWguQvNqZVEFRL6qjIQ4I1VQj/eFuf0VSVZgpmFXQOAhStwXwHmVHSnDZu5sZAWuCqvI5c3MpWRETjdxYpLB/4BAyfpwRDNhFe6RejZ6J6g0qr2qQLHO2TZynRsrdTVwOQj/gI+GBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=lists.infradead.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/arxiupp6JW7q2R7PmjNwYCAJDxWRgCVSXx3beO1a00=;
 b=BkMNF2Xb5lQHenSqyp0Na3V4F8ySX/X0HlIVz3ltyAFCLphCVzGE2NTloz9rozJcmYwWaLAF3Fvlduv7Qn57XKtkaGM0S8ge43PI8sEgDG3/j6SS2PkXKa7eYEhXAmo+L4ERuqwFpj/e0QPHkVonFEE7nZvSnhCeq1IhvoQmPl98MwH/TYcMJPqG3d1VTDXVsx7MPVxy5+njRi5o+fRusnnqPCXMFIVKcKLsQzonDm1eJUVzs8KT0syzYRXvTFEdWJDWRn1DMKJ2nEnbbqQRVAJPU62qcMiqwJqZwFto8flH339OpVUIndyYQmEel6orFA0gtXQzHZtFFGN9xtsr1Q==
Received: from BN9PR03CA0575.namprd03.prod.outlook.com (2603:10b6:408:10d::10)
 by SJ2PR12MB8881.namprd12.prod.outlook.com (2603:10b6:a03:546::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.20; Fri, 12 May
 2023 08:22:27 +0000
Received: from BN8NAM11FT065.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:10d:cafe::36) by BN9PR03CA0575.outlook.office365.com
 (2603:10b6:408:10d::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.24 via Frontend
 Transport; Fri, 12 May 2023 08:22:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN8NAM11FT065.mail.protection.outlook.com (10.13.177.63) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6387.23 via Frontend Transport; Fri, 12 May 2023 08:22:26 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Fri, 12 May 2023
 01:22:14 -0700
Received: from dev.nvidia.com (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Fri, 12 May
 2023 01:22:14 -0700
From: Chaitanya Kulkarni <kch@nvidia.com>
To: <linux-nvme@lists.infradead.org>
CC: <kbusch@kernel.org>, <axboe@kernel.dk>, <ch@lst.de>, <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>
Subject: [RFC PATCH] nvme-core: add helper to get nvme_ctrl from device
Date: Fri, 12 May 2023 01:22:06 -0700
Message-ID: <20230512082206.4788-1-kch@nvidia.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.37]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT065:EE_|SJ2PR12MB8881:EE_
X-MS-Office365-Filtering-Correlation-Id: 20863b73-0a81-495a-a0d5-08db52c20557
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 	Sv97oqZwiV8p8jOx5+cPY8rOZuVLmnQ/GuPcJxWyWi6jBRitYs6dSBlve8gKwnG5RD+vGqW2BWKjtZqaU8ACueKYtV0cMGUwpOvExIR7XGbka1ZZPIsls3DvyY9nr6DeBp8j89ZSnYcDZevkSnRK4KNwu+qsImIX7xmx+kaGgpziEdArZOwATjQuta/SzL8v3/d57K/kDnUe0tcWysVlSdw/bxOMyHwTi/ns2ppDG/gQwGb9p0kUJTu0+nI+PzaJ7Ve6ZOfhzSfjGVwMcjS254DojIpa2/ZPJTpcY5ZStvhItEMZgkECJUueLMhMLmUOswiyd1RPDfByid1iuXDBQVsKP0J5Gr54863FFjUeAMP/A3YZzBAuTVHmu0Ag0XpgOV+rcvCUsq6pJ2ybUYtWyvaYAZVOSRIfNpVQKChfyo8+j0KaDhQzBZN6JS+XIFZWa4PSOEC+pOMQVpEn8bfChewv9hpM8WFX/ZEbOIbXowPs8jXCIZWitxFTFJf1a0YjhhCHIMIBQWYSkix688f6GLGNoSQE1csDyZLpaU5EmBcuXOGuL7j8eoWIYX4e9blKVsM0IWev6vtbgS1Z5oCt73n5SNy7BGUTi1nJgBXhqYQJkyVecnUcLVsK0BR+XP00X8S2Xyr48wlGptaR+SZR1D8Q7MiWbY9x9op4DuNhkOBtRKIu0gpjT59dy8YaiQyV6yXHVbsUmGXletNzXdH8fr+4bmTMEYDL3A+EJdq5zKB4NpHlbI6aywvI9Ws6wQdi
X-Forefront-Antispam-Report: 	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(136003)(376002)(346002)(451199021)(40470700004)(46966006)(36840700001)(82740400003)(186003)(26005)(7696005)(107886003)(6666004)(7636003)(356005)(1076003)(83380400001)(36860700001)(40480700001)(47076005)(426003)(2616005)(336012)(8936002)(2906002)(4326008)(5660300002)(36756003)(316002)(8676002)(54906003)(6916009)(16526019)(41300700001)(70206006)(70586007)(82310400005)(40460700003)(478600001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2023 08:22:26.7787
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 20863b73-0a81-495a-a0d5-08db52c20557
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: 	BN8NAM11FT065.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8881
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230512_012231_519074_5759A08D 
X-CRM114-Status: GOOD (  14.64  )
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

Just like we have other helpers to_nvmet_port(), to_nvmet_ns(),
ana_groups_to_port() and to_nvmet_ns(), add a helper to get nvme_ctr
from struct device.

Note that this removes the bunch of nvme_ctrl declaration code that is
needed to get the nvme_ctrl from struct device in the host/core.c.
Followwing is the diff :-

drivers/nvme/host/core.c | 69 +++++++++++++++-------------------------

Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
---
 drivers/nvme/host/core.c | 69 +++++++++++++++-------------------------
 1 file changed, 26 insertions(+), 43 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 518c759346f0..a957da110ee1 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -126,6 +126,11 @@ static void nvme_remove_invalid_namespaces(struct nvme_ctrl *ctrl,
 static void nvme_update_keep_alive(struct nvme_ctrl *ctrl,
 				   struct nvme_command *cmd);
 
+static struct nvme_ctrl *dev_to_nvme_ctrl(struct device *dev)
+{
+	return dev_get_drvdata(dev);
+}
+
 void nvme_queue_scan(struct nvme_ctrl *ctrl)
 {
 	/*
@@ -3386,10 +3391,9 @@ static ssize_t nvme_sysfs_reset(struct device *dev,
 				struct device_attribute *attr, const char *buf,
 				size_t count)
 {
-	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
 	int ret;
 
-	ret = nvme_reset_ctrl_sync(ctrl);
+	ret = nvme_reset_ctrl_sync(dev_to_nvme_ctrl(dev));
 	if (ret < 0)
 		return ret;
 	return count;
@@ -3400,9 +3404,7 @@ static ssize_t nvme_sysfs_rescan(struct device *dev,
 				struct device_attribute *attr, const char *buf,
 				size_t count)
 {
-	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
-
-	nvme_queue_scan(ctrl);
+	nvme_queue_scan(dev_to_nvme_ctrl(dev));
 	return count;
 }
 static DEVICE_ATTR(rescan_controller, S_IWUSR, NULL, nvme_sysfs_rescan);
@@ -3557,8 +3559,7 @@ nvme_show_str_function(firmware_rev);
 static ssize_t  field##_show(struct device *dev,				\
 			    struct device_attribute *attr, char *buf)		\
 {										\
-        struct nvme_ctrl *ctrl = dev_get_drvdata(dev);				\
-        return sysfs_emit(buf, "%d\n", ctrl->field);				\
+        return sysfs_emit(buf, "%d\n", dev_to_nvme_ctrl(dev)->field);		\
 }										\
 static DEVICE_ATTR(field, S_IRUGO, field##_show, NULL);
 
@@ -3572,10 +3573,8 @@ static ssize_t nvme_sysfs_delete(struct device *dev,
 				struct device_attribute *attr, const char *buf,
 				size_t count)
 {
-	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
-
 	if (device_remove_file_self(dev, attr))
-		nvme_delete_ctrl_sync(ctrl);
+		nvme_delete_ctrl_sync(dev_to_nvme_ctrl(dev));
 	return count;
 }
 static DEVICE_ATTR(delete_controller, S_IWUSR, NULL, nvme_sysfs_delete);
@@ -3584,9 +3583,7 @@ static ssize_t nvme_sysfs_show_transport(struct device *dev,
 					 struct device_attribute *attr,
 					 char *buf)
 {
-	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
-
-	return sysfs_emit(buf, "%s\n", ctrl->ops->name);
+	return sysfs_emit(buf, "%s\n", dev_to_nvme_ctrl(dev)->ops->name);
 }
 static DEVICE_ATTR(transport, S_IRUGO, nvme_sysfs_show_transport, NULL);
 
@@ -3618,9 +3615,7 @@ static ssize_t nvme_sysfs_show_subsysnqn(struct device *dev,
 					 struct device_attribute *attr,
 					 char *buf)
 {
-	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
-
-	return sysfs_emit(buf, "%s\n", ctrl->subsys->subnqn);
+	return sysfs_emit(buf, "%s\n", dev_to_nvme_ctrl(dev)->subsys->subnqn);
 }
 static DEVICE_ATTR(subsysnqn, S_IRUGO, nvme_sysfs_show_subsysnqn, NULL);
 
@@ -3628,9 +3623,7 @@ static ssize_t nvme_sysfs_show_hostnqn(struct device *dev,
 					struct device_attribute *attr,
 					char *buf)
 {
-	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
-
-	return sysfs_emit(buf, "%s\n", ctrl->opts->host->nqn);
+	return sysfs_emit(buf, "%s\n", dev_to_nvme_ctrl(dev)->opts->host->nqn);
 }
 static DEVICE_ATTR(hostnqn, S_IRUGO, nvme_sysfs_show_hostnqn, NULL);
 
@@ -3638,9 +3631,7 @@ static ssize_t nvme_sysfs_show_hostid(struct device *dev,
 					struct device_attribute *attr,
 					char *buf)
 {
-	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
-
-	return sysfs_emit(buf, "%pU\n", &ctrl->opts->host->id);
+	return sysfs_emit(buf, "%pU\n", &dev_to_nvme_ctrl(dev)->opts->host->id);
 }
 static DEVICE_ATTR(hostid, S_IRUGO, nvme_sysfs_show_hostid, NULL);
 
@@ -3657,10 +3648,9 @@ static DEVICE_ATTR(address, S_IRUGO, nvme_sysfs_show_address, NULL);
 static ssize_t nvme_ctrl_loss_tmo_show(struct device *dev,
 		struct device_attribute *attr, char *buf)
 {
-	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
-	struct nvmf_ctrl_options *opts = ctrl->opts;
+	struct nvmf_ctrl_options *opts = dev_to_nvme_ctrl(dev)->opts;
 
-	if (ctrl->opts->max_reconnects == -1)
+	if (dev_to_nvme_ctrl(dev)->opts->max_reconnects == -1)
 		return sysfs_emit(buf, "off\n");
 	return sysfs_emit(buf, "%d\n",
 			  opts->max_reconnects * opts->reconnect_delay);
@@ -3669,8 +3659,7 @@ static ssize_t nvme_ctrl_loss_tmo_show(struct device *dev,
 static ssize_t nvme_ctrl_loss_tmo_store(struct device *dev,
 		struct device_attribute *attr, const char *buf, size_t count)
 {
-	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
-	struct nvmf_ctrl_options *opts = ctrl->opts;
+	struct nvmf_ctrl_options *opts = dev_to_nvme_ctrl(dev)->opts;
 	int ctrl_loss_tmo, err;
 
 	err = kstrtoint(buf, 10, &ctrl_loss_tmo);
@@ -3690,17 +3679,15 @@ static DEVICE_ATTR(ctrl_loss_tmo, S_IRUGO | S_IWUSR,
 static ssize_t nvme_ctrl_reconnect_delay_show(struct device *dev,
 		struct device_attribute *attr, char *buf)
 {
-	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
-
-	if (ctrl->opts->reconnect_delay == -1)
+	if (dev_to_nvme_ctrl(dev)->opts->reconnect_delay == -1)
 		return sysfs_emit(buf, "off\n");
-	return sysfs_emit(buf, "%d\n", ctrl->opts->reconnect_delay);
+	return sysfs_emit(buf, "%d\n",
+			  dev_to_nvme_ctrl(dev)->opts->reconnect_delay);
 }
 
 static ssize_t nvme_ctrl_reconnect_delay_store(struct device *dev,
 		struct device_attribute *attr, const char *buf, size_t count)
 {
-	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
 	unsigned int v;
 	int err;
 
@@ -3708,7 +3695,7 @@ static ssize_t nvme_ctrl_reconnect_delay_store(struct device *dev,
 	if (err)
 		return err;
 
-	ctrl->opts->reconnect_delay = v;
+	dev_to_nvme_ctrl(dev)->opts->reconnect_delay = v;
 	return count;
 }
 static DEVICE_ATTR(reconnect_delay, S_IRUGO | S_IWUSR,
@@ -3717,18 +3704,16 @@ static DEVICE_ATTR(reconnect_delay, S_IRUGO | S_IWUSR,
 static ssize_t nvme_ctrl_fast_io_fail_tmo_show(struct device *dev,
 		struct device_attribute *attr, char *buf)
 {
-	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
-
-	if (ctrl->opts->fast_io_fail_tmo == -1)
+	if (dev_to_nvme_ctrl(dev)->opts->fast_io_fail_tmo == -1)
 		return sysfs_emit(buf, "off\n");
-	return sysfs_emit(buf, "%d\n", ctrl->opts->fast_io_fail_tmo);
+	return sysfs_emit(buf, "%d\n",
+			  dev_to_nvme_ctrl(dev)->opts->fast_io_fail_tmo);
 }
 
 static ssize_t nvme_ctrl_fast_io_fail_tmo_store(struct device *dev,
 		struct device_attribute *attr, const char *buf, size_t count)
 {
-	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
-	struct nvmf_ctrl_options *opts = ctrl->opts;
+	struct nvmf_ctrl_options *opts = dev_to_nvme_ctrl(dev)->opts;
 	int fast_io_fail_tmo, err;
 
 	err = kstrtoint(buf, 10, &fast_io_fail_tmo);
@@ -3782,8 +3767,7 @@ static DEVICE_ATTR_RO(dctype);
 static ssize_t nvme_ctrl_dhchap_secret_show(struct device *dev,
 		struct device_attribute *attr, char *buf)
 {
-	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
-	struct nvmf_ctrl_options *opts = ctrl->opts;
+	struct nvmf_ctrl_options *opts = dev_to_nvme_ctrl(dev)->opts;
 
 	if (!opts->dhchap_secret)
 		return sysfs_emit(buf, "none\n");
@@ -3836,8 +3820,7 @@ static DEVICE_ATTR(dhchap_secret, S_IRUGO | S_IWUSR,
 static ssize_t nvme_ctrl_dhchap_ctrl_secret_show(struct device *dev,
 		struct device_attribute *attr, char *buf)
 {
-	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
-	struct nvmf_ctrl_options *opts = ctrl->opts;
+	struct nvmf_ctrl_options *opts = dev_to_nvme_ctrl(dev)->opts;
 
 	if (!opts->dhchap_ctrl_secret)
 		return sysfs_emit(buf, "none\n");
-- 
2.40.0


