Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 004F4C77B61
	for <linux-nvme@archiver.kernel.org>; Mon, 24 Apr 2023 21:13:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=gEfBh8ZpR5UpviPmnAEy6UlFEfGdC8irl1tFNml4U2M=; b=kFR9eiXjqJyVtLb6b50iINpEsI
	DzsgXvNNwmtbvKfxcNi+92d07phBmF6ecXNFpA+LAv6eqZCJdublIDCkSU2ymw3Ccy1cQx8lvoeMb
	Rr3lFICpR3Xu5nJgxaDNA42TbtAOW9Uh0rM3n5u7l2zvBWRnUJ6Z3P7sBt8oXIa0zw6SFqCqvcls0
	XVLaLQXuh/aUM6xXAhqAvIfxonn1geGtZOxsvbQa0YxTdKvoh5XGz1lqHHFcK0TwWzYQuFa6bsmN/
	PIg0acgiDYw8bQJKN2rVumqxpILwrGwJxOt03iYv/ZVOPwg+2Kz3VY+f9KGv5rvXAjqF9ezkYYuyE
	VSdR7VwQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pr3Ul-00HCH7-0h;
	Mon, 24 Apr 2023 21:13:11 +0000
Received: from mail-bn8nam04on20619.outbound.protection.outlook.com ([2a01:111:f400:7e8d::619] helo=NAM04-BN8-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pr3Uf-00HCGh-0t
	for linux-nvme@lists.infradead.org;
	Mon, 24 Apr 2023 21:13:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PpVW/H2JG927MuW6iJEi+fWogfdMiioh62vlUftcRN+zCUmcR1HV/5l3eEZMuDutRXpnRFh54QGwzWn2zXt8XH09fpoKQ2WlOB3mxP353jaMYlMI0m24/16rn2fcF74ckceW1tvK9VWboP9xRdpywW4nVFfCCvuftcJyPW2kMTWWmjqQY8jGwNr2xYbeLQ05H7dj4BltavbQLJDnlaHc/EeJzZugDwaOjJVqGqRXfmlMhoYIkeYi/QY7wzA0Gc5rti0zpPl1jcH8JAt17zmYvc237CDZmAN2OWkpLGX/toRurbb8zk/QcVr4sBs35Mp9J7yzKMTaLqstMA62fGY6sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gEfBh8ZpR5UpviPmnAEy6UlFEfGdC8irl1tFNml4U2M=;
 b=cupCYe1/yfmcatOSFQKOMX5XqHR90CK2XRVecFMITN+7wZxuWqjSp2dJExGBDUxI1ygQ6g8cUCi3xXp/c/Rok25Tex03Y9AJweaCHh8kqBeOTK9jM3TfYKcCWkGuACB9+XnQzpPtXCKd909zLa5sv6DLpE6O59zNhqBOyigTM3YfXH81olX6U78Gry8GMZyqmH/OozCe9JCSmS9OaGc9j+jI0wt1JT3YtjQ6MaKCnZmdA4HumCzwWlI5CfqprcNuzzhk9bYzbKRsyOaEYwoR7yBY0/H+ojJ8h1IXVP61GovbG3MMPFP0V/Pq37A8rfVB7FQUOyWY4VQm83fEPyhE6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=lst.de smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gEfBh8ZpR5UpviPmnAEy6UlFEfGdC8irl1tFNml4U2M=;
 b=H4Dg54H9046Qx1syLPpRXmhzHRTAXewW1/DM5xkQ7eEgrDJHPd742bIM6aPePO8KqwWEjWryIjWlEOeETeb/MXumP42uKxiL/Rp/xlYWCUab2sFyQWsWHnRSCxlyd7stm+vDnPDaYwm82Awvki37wR0f7mod9H5y6ysHqlGvw2WcrYhCOhP3rAu6+diuQ9no3X/CfV/ONgP5kRIEFh0g+oYkNxOcEUV39h7ukZInxRVoKRKsdMaJAxBCmQD+TWPQgHJZQ8RxbYV45EpoHupVTh0yuQVkm/9Txs/ckEL3EZXVJFNw43lx13fcEEDktX4acbACGsiOJh7DsRnywoS/mg==
Received: from BN9P222CA0013.NAMP222.PROD.OUTLOOK.COM (2603:10b6:408:10c::18)
 by SN7PR12MB7371.namprd12.prod.outlook.com (2603:10b6:806:29a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.29; Mon, 24 Apr
 2023 21:13:00 +0000
Received: from BN8NAM11FT023.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:10c:cafe::8f) by BN9P222CA0013.outlook.office365.com
 (2603:10b6:408:10c::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.33 via Frontend
 Transport; Mon, 24 Apr 2023 21:13:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN8NAM11FT023.mail.protection.outlook.com (10.13.177.103) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6340.19 via Frontend Transport; Mon, 24 Apr 2023 21:13:00 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Mon, 24 Apr 2023
 14:12:46 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Mon, 24 Apr
 2023 14:12:46 -0700
Received: from r-arch-stor03.mtr.labs.mlnx (10.127.8.14) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.986.37 via Frontend
 Transport; Mon, 24 Apr 2023 14:12:43 -0700
From: Max Gurtovoy <mgurtovoy@nvidia.com>
To: <hch@lst.de>, <sagi@grimberg.me>, <kbusch@kernel.org>,
	<linux-nvme@lists.infradead.org>, <axboe@kernel.dk>
CC: <oren@nvidia.com>, <israelr@nvidia.com>, Max Gurtovoy
	<mgurtovoy@nvidia.com>
Subject: [PATCH v2 1/1] nvme: move sysfs code to a dedicated sysfs.c file
Date: Tue, 25 Apr 2023 00:12:42 +0300
Message-ID: <20230424211242.19614-1-mgurtovoy@nvidia.com>
X-Mailer: git-send-email 2.18.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT023:EE_|SN7PR12MB7371:EE_
X-MS-Office365-Filtering-Correlation-Id: be9c29b4-23be-4403-560b-08db4508af1a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 	coZMSHTytQk4F0FgDQf2YaQtPltAeviG9LtTd17nJGFVp6FObXwior/C9XhQM8R0MmusneKnFU2nIuVUuDkJPuAYMkT273Sqo0jA+Ua3xhoaQLR5srdyBjyUVICyNVvN8pIBCC7WlZySh0ewyVdTJjXvUjGjYN0szgdNwxmiH9PDdTh7tMOwGZxmTOLDF1g5O4G0hly9HFyGFqlqvgO7xSXKPj9bvge6B2ddy/4S9nqisRTeiFyBBpPReYMBx9DdwFlsbSw13/NIuTPuchzErN/vVqa8XtyTNuT0OBeB4LdaCDS/IgBF/PVyv0BGNW+5YCWOoZ1jp6BOKJ4miGS+R6WMWx+W3UpRieGBrALsh99jW6PTaeJbEnt+Ci9QvRJ1nv3/j+32lCCwzYqKxqUJ3CkllvEv5H78Sd6r40iETsnJ3HsoIGD3YOevV4q+AVhxBBLyTcXAmQse4nrsGLN01ZVd5qzl9ax/sjrfgwqvGhjMIJy9c4tKCQ7vbNYnWKHtC84qg5dlYDqdSHGUeTVFzzMolXlDrgMWZo9jy0LGFElw+Z2mCww8JT2VuTz3UQNKfrEtHMNwq/UUqOzzW4Xx5vfVITRGaj/Lr5rqPNb2ipwIMd92ylQAXpLOepW2Nb6aV+q/aQa8AKgnGxAfifSAIYNPZqoZvOGXUCA5UH6sOSByGax1txV6Vxm4gZzB89xjth4LUeqLnel7dgqc993Zf3/OfeNC7nN/gcSbzI8GoBQ=
X-Forefront-Antispam-Report: 	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(376002)(136003)(396003)(39860400002)(346002)(451199021)(46966006)(36840700001)(40470700004)(83380400001)(34020700004)(70206006)(70586007)(4326008)(40480700001)(5660300002)(47076005)(107886003)(2616005)(426003)(336012)(36860700001)(26005)(1076003)(186003)(82310400005)(7636003)(82740400003)(40460700003)(54906003)(110136005)(478600001)(356005)(36756003)(30864003)(2906002)(86362001)(316002)(8936002)(8676002)(41300700001)(579004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2023 21:13:00.0819
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: be9c29b4-23be-4403-560b-08db4508af1a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: 	BN8NAM11FT023.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7371
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230424_141305_447707_C9AE307C 
X-CRM114-Status: GOOD (  19.15  )
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

The core.c file became long and hard to maintain. Create a dedicated
file to centralize the sysfs functionality. This is a common practice to
separate sysfs/configfs related logic from the main driver logic .c file.
For example, in the nvmet module the configfs interface has its own
dedicated file.

This patch does not include any functional changes.

Reviewed-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
---

changes from v1:
 - rephrase the title from "nvme: add a dedicated .c file for sysfs interface" (Sagi)
 - add Reviewed-by signature from Keith

changes from RFC:
 - Removed RCF tag
 - updated copyrights mistake
 - fix License copy/paste bug (Sagi)

---
 drivers/nvme/host/Makefile |   2 +-
 drivers/nvme/host/core.c   | 650 +-----------------------------------
 drivers/nvme/host/nvme.h   |   4 +
 drivers/nvme/host/sysfs.c  | 655 +++++++++++++++++++++++++++++++++++++
 4 files changed, 662 insertions(+), 649 deletions(-)
 create mode 100644 drivers/nvme/host/sysfs.c

diff --git a/drivers/nvme/host/Makefile b/drivers/nvme/host/Makefile
index e27202d22c7d..d3fc5063e4be 100644
--- a/drivers/nvme/host/Makefile
+++ b/drivers/nvme/host/Makefile
@@ -10,7 +10,7 @@ obj-$(CONFIG_NVME_FC)			+= nvme-fc.o
 obj-$(CONFIG_NVME_TCP)			+= nvme-tcp.o
 obj-$(CONFIG_NVME_APPLE)		+= nvme-apple.o
 
-nvme-core-y				+= core.o ioctl.o
+nvme-core-y				+= core.o ioctl.o sysfs.o
 nvme-core-$(CONFIG_NVME_VERBOSE_ERRORS)	+= constants.o
 nvme-core-$(CONFIG_TRACING)		+= trace.o
 nvme-core-$(CONFIG_NVME_MULTIPATH)	+= multipath.o
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index d6a9bac91a4c..4811e465b31e 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -237,7 +237,7 @@ int nvme_delete_ctrl(struct nvme_ctrl *ctrl)
 }
 EXPORT_SYMBOL_GPL(nvme_delete_ctrl);
 
-static void nvme_delete_ctrl_sync(struct nvme_ctrl *ctrl)
+void nvme_delete_ctrl_sync(struct nvme_ctrl *ctrl)
 {
 	/*
 	 * Keep a reference until nvme_do_delete_ctrl() complete,
@@ -2256,7 +2256,7 @@ static int nvme_report_zones(struct gendisk *disk, sector_t sector,
 #define nvme_report_zones	NULL
 #endif /* CONFIG_BLK_DEV_ZONED */
 
-static const struct block_device_operations nvme_bdev_ops = {
+const struct block_device_operations nvme_bdev_ops = {
 	.owner		= THIS_MODULE,
 	.ioctl		= nvme_ioctl,
 	.compat_ioctl	= blkdev_compat_ptr_ioctl,
@@ -2791,75 +2791,6 @@ static struct nvme_subsystem *__nvme_find_get_subsystem(const char *subsysnqn)
 	return NULL;
 }
 
-#define SUBSYS_ATTR_RO(_name, _mode, _show)			\
-	struct device_attribute subsys_attr_##_name = \
-		__ATTR(_name, _mode, _show, NULL)
-
-static ssize_t nvme_subsys_show_nqn(struct device *dev,
-				    struct device_attribute *attr,
-				    char *buf)
-{
-	struct nvme_subsystem *subsys =
-		container_of(dev, struct nvme_subsystem, dev);
-
-	return sysfs_emit(buf, "%s\n", subsys->subnqn);
-}
-static SUBSYS_ATTR_RO(subsysnqn, S_IRUGO, nvme_subsys_show_nqn);
-
-static ssize_t nvme_subsys_show_type(struct device *dev,
-				    struct device_attribute *attr,
-				    char *buf)
-{
-	struct nvme_subsystem *subsys =
-		container_of(dev, struct nvme_subsystem, dev);
-
-	switch (subsys->subtype) {
-	case NVME_NQN_DISC:
-		return sysfs_emit(buf, "discovery\n");
-	case NVME_NQN_NVME:
-		return sysfs_emit(buf, "nvm\n");
-	default:
-		return sysfs_emit(buf, "reserved\n");
-	}
-}
-static SUBSYS_ATTR_RO(subsystype, S_IRUGO, nvme_subsys_show_type);
-
-#define nvme_subsys_show_str_function(field)				\
-static ssize_t subsys_##field##_show(struct device *dev,		\
-			    struct device_attribute *attr, char *buf)	\
-{									\
-	struct nvme_subsystem *subsys =					\
-		container_of(dev, struct nvme_subsystem, dev);		\
-	return sysfs_emit(buf, "%.*s\n",				\
-			   (int)sizeof(subsys->field), subsys->field);	\
-}									\
-static SUBSYS_ATTR_RO(field, S_IRUGO, subsys_##field##_show);
-
-nvme_subsys_show_str_function(model);
-nvme_subsys_show_str_function(serial);
-nvme_subsys_show_str_function(firmware_rev);
-
-static struct attribute *nvme_subsys_attrs[] = {
-	&subsys_attr_model.attr,
-	&subsys_attr_serial.attr,
-	&subsys_attr_firmware_rev.attr,
-	&subsys_attr_subsysnqn.attr,
-	&subsys_attr_subsystype.attr,
-#ifdef CONFIG_NVME_MULTIPATH
-	&subsys_attr_iopolicy.attr,
-#endif
-	NULL,
-};
-
-static const struct attribute_group nvme_subsys_attrs_group = {
-	.attrs = nvme_subsys_attrs,
-};
-
-static const struct attribute_group *nvme_subsys_attrs_groups[] = {
-	&nvme_subsys_attrs_group,
-	NULL,
-};
-
 static inline bool nvme_discovery_ctrl(struct nvme_ctrl *ctrl)
 {
 	return ctrl->opts && ctrl->opts->discovery_nqn;
@@ -3393,583 +3324,6 @@ static const struct file_operations nvme_dev_fops = {
 	.uring_cmd	= nvme_dev_uring_cmd,
 };
 
-static ssize_t nvme_sysfs_reset(struct device *dev,
-				struct device_attribute *attr, const char *buf,
-				size_t count)
-{
-	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
-	int ret;
-
-	ret = nvme_reset_ctrl_sync(ctrl);
-	if (ret < 0)
-		return ret;
-	return count;
-}
-static DEVICE_ATTR(reset_controller, S_IWUSR, NULL, nvme_sysfs_reset);
-
-static ssize_t nvme_sysfs_rescan(struct device *dev,
-				struct device_attribute *attr, const char *buf,
-				size_t count)
-{
-	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
-
-	nvme_queue_scan(ctrl);
-	return count;
-}
-static DEVICE_ATTR(rescan_controller, S_IWUSR, NULL, nvme_sysfs_rescan);
-
-static inline struct nvme_ns_head *dev_to_ns_head(struct device *dev)
-{
-	struct gendisk *disk = dev_to_disk(dev);
-
-	if (disk->fops == &nvme_bdev_ops)
-		return nvme_get_ns_from_dev(dev)->head;
-	else
-		return disk->private_data;
-}
-
-static ssize_t wwid_show(struct device *dev, struct device_attribute *attr,
-		char *buf)
-{
-	struct nvme_ns_head *head = dev_to_ns_head(dev);
-	struct nvme_ns_ids *ids = &head->ids;
-	struct nvme_subsystem *subsys = head->subsys;
-	int serial_len = sizeof(subsys->serial);
-	int model_len = sizeof(subsys->model);
-
-	if (!uuid_is_null(&ids->uuid))
-		return sysfs_emit(buf, "uuid.%pU\n", &ids->uuid);
-
-	if (memchr_inv(ids->nguid, 0, sizeof(ids->nguid)))
-		return sysfs_emit(buf, "eui.%16phN\n", ids->nguid);
-
-	if (memchr_inv(ids->eui64, 0, sizeof(ids->eui64)))
-		return sysfs_emit(buf, "eui.%8phN\n", ids->eui64);
-
-	while (serial_len > 0 && (subsys->serial[serial_len - 1] == ' ' ||
-				  subsys->serial[serial_len - 1] == '\0'))
-		serial_len--;
-	while (model_len > 0 && (subsys->model[model_len - 1] == ' ' ||
-				 subsys->model[model_len - 1] == '\0'))
-		model_len--;
-
-	return sysfs_emit(buf, "nvme.%04x-%*phN-%*phN-%08x\n", subsys->vendor_id,
-		serial_len, subsys->serial, model_len, subsys->model,
-		head->ns_id);
-}
-static DEVICE_ATTR_RO(wwid);
-
-static ssize_t nguid_show(struct device *dev, struct device_attribute *attr,
-		char *buf)
-{
-	return sysfs_emit(buf, "%pU\n", dev_to_ns_head(dev)->ids.nguid);
-}
-static DEVICE_ATTR_RO(nguid);
-
-static ssize_t uuid_show(struct device *dev, struct device_attribute *attr,
-		char *buf)
-{
-	struct nvme_ns_ids *ids = &dev_to_ns_head(dev)->ids;
-
-	/* For backward compatibility expose the NGUID to userspace if
-	 * we have no UUID set
-	 */
-	if (uuid_is_null(&ids->uuid)) {
-		dev_warn_ratelimited(dev,
-			"No UUID available providing old NGUID\n");
-		return sysfs_emit(buf, "%pU\n", ids->nguid);
-	}
-	return sysfs_emit(buf, "%pU\n", &ids->uuid);
-}
-static DEVICE_ATTR_RO(uuid);
-
-static ssize_t eui_show(struct device *dev, struct device_attribute *attr,
-		char *buf)
-{
-	return sysfs_emit(buf, "%8ph\n", dev_to_ns_head(dev)->ids.eui64);
-}
-static DEVICE_ATTR_RO(eui);
-
-static ssize_t nsid_show(struct device *dev, struct device_attribute *attr,
-		char *buf)
-{
-	return sysfs_emit(buf, "%d\n", dev_to_ns_head(dev)->ns_id);
-}
-static DEVICE_ATTR_RO(nsid);
-
-static struct attribute *nvme_ns_id_attrs[] = {
-	&dev_attr_wwid.attr,
-	&dev_attr_uuid.attr,
-	&dev_attr_nguid.attr,
-	&dev_attr_eui.attr,
-	&dev_attr_nsid.attr,
-#ifdef CONFIG_NVME_MULTIPATH
-	&dev_attr_ana_grpid.attr,
-	&dev_attr_ana_state.attr,
-#endif
-	NULL,
-};
-
-static umode_t nvme_ns_id_attrs_are_visible(struct kobject *kobj,
-		struct attribute *a, int n)
-{
-	struct device *dev = container_of(kobj, struct device, kobj);
-	struct nvme_ns_ids *ids = &dev_to_ns_head(dev)->ids;
-
-	if (a == &dev_attr_uuid.attr) {
-		if (uuid_is_null(&ids->uuid) &&
-		    !memchr_inv(ids->nguid, 0, sizeof(ids->nguid)))
-			return 0;
-	}
-	if (a == &dev_attr_nguid.attr) {
-		if (!memchr_inv(ids->nguid, 0, sizeof(ids->nguid)))
-			return 0;
-	}
-	if (a == &dev_attr_eui.attr) {
-		if (!memchr_inv(ids->eui64, 0, sizeof(ids->eui64)))
-			return 0;
-	}
-#ifdef CONFIG_NVME_MULTIPATH
-	if (a == &dev_attr_ana_grpid.attr || a == &dev_attr_ana_state.attr) {
-		if (dev_to_disk(dev)->fops != &nvme_bdev_ops) /* per-path attr */
-			return 0;
-		if (!nvme_ctrl_use_ana(nvme_get_ns_from_dev(dev)->ctrl))
-			return 0;
-	}
-#endif
-	return a->mode;
-}
-
-static const struct attribute_group nvme_ns_id_attr_group = {
-	.attrs		= nvme_ns_id_attrs,
-	.is_visible	= nvme_ns_id_attrs_are_visible,
-};
-
-const struct attribute_group *nvme_ns_id_attr_groups[] = {
-	&nvme_ns_id_attr_group,
-	NULL,
-};
-
-#define nvme_show_str_function(field)						\
-static ssize_t  field##_show(struct device *dev,				\
-			    struct device_attribute *attr, char *buf)		\
-{										\
-        struct nvme_ctrl *ctrl = dev_get_drvdata(dev);				\
-        return sysfs_emit(buf, "%.*s\n",					\
-		(int)sizeof(ctrl->subsys->field), ctrl->subsys->field);		\
-}										\
-static DEVICE_ATTR(field, S_IRUGO, field##_show, NULL);
-
-nvme_show_str_function(model);
-nvme_show_str_function(serial);
-nvme_show_str_function(firmware_rev);
-
-#define nvme_show_int_function(field)						\
-static ssize_t  field##_show(struct device *dev,				\
-			    struct device_attribute *attr, char *buf)		\
-{										\
-        struct nvme_ctrl *ctrl = dev_get_drvdata(dev);				\
-        return sysfs_emit(buf, "%d\n", ctrl->field);				\
-}										\
-static DEVICE_ATTR(field, S_IRUGO, field##_show, NULL);
-
-nvme_show_int_function(cntlid);
-nvme_show_int_function(numa_node);
-nvme_show_int_function(queue_count);
-nvme_show_int_function(sqsize);
-nvme_show_int_function(kato);
-
-static ssize_t nvme_sysfs_delete(struct device *dev,
-				struct device_attribute *attr, const char *buf,
-				size_t count)
-{
-	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
-
-	if (device_remove_file_self(dev, attr))
-		nvme_delete_ctrl_sync(ctrl);
-	return count;
-}
-static DEVICE_ATTR(delete_controller, S_IWUSR, NULL, nvme_sysfs_delete);
-
-static ssize_t nvme_sysfs_show_transport(struct device *dev,
-					 struct device_attribute *attr,
-					 char *buf)
-{
-	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
-
-	return sysfs_emit(buf, "%s\n", ctrl->ops->name);
-}
-static DEVICE_ATTR(transport, S_IRUGO, nvme_sysfs_show_transport, NULL);
-
-static ssize_t nvme_sysfs_show_state(struct device *dev,
-				     struct device_attribute *attr,
-				     char *buf)
-{
-	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
-	static const char *const state_name[] = {
-		[NVME_CTRL_NEW]		= "new",
-		[NVME_CTRL_LIVE]	= "live",
-		[NVME_CTRL_RESETTING]	= "resetting",
-		[NVME_CTRL_CONNECTING]	= "connecting",
-		[NVME_CTRL_DELETING]	= "deleting",
-		[NVME_CTRL_DELETING_NOIO]= "deleting (no IO)",
-		[NVME_CTRL_DEAD]	= "dead",
-	};
-
-	if ((unsigned)ctrl->state < ARRAY_SIZE(state_name) &&
-	    state_name[ctrl->state])
-		return sysfs_emit(buf, "%s\n", state_name[ctrl->state]);
-
-	return sysfs_emit(buf, "unknown state\n");
-}
-
-static DEVICE_ATTR(state, S_IRUGO, nvme_sysfs_show_state, NULL);
-
-static ssize_t nvme_sysfs_show_subsysnqn(struct device *dev,
-					 struct device_attribute *attr,
-					 char *buf)
-{
-	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
-
-	return sysfs_emit(buf, "%s\n", ctrl->subsys->subnqn);
-}
-static DEVICE_ATTR(subsysnqn, S_IRUGO, nvme_sysfs_show_subsysnqn, NULL);
-
-static ssize_t nvme_sysfs_show_hostnqn(struct device *dev,
-					struct device_attribute *attr,
-					char *buf)
-{
-	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
-
-	return sysfs_emit(buf, "%s\n", ctrl->opts->host->nqn);
-}
-static DEVICE_ATTR(hostnqn, S_IRUGO, nvme_sysfs_show_hostnqn, NULL);
-
-static ssize_t nvme_sysfs_show_hostid(struct device *dev,
-					struct device_attribute *attr,
-					char *buf)
-{
-	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
-
-	return sysfs_emit(buf, "%pU\n", &ctrl->opts->host->id);
-}
-static DEVICE_ATTR(hostid, S_IRUGO, nvme_sysfs_show_hostid, NULL);
-
-static ssize_t nvme_sysfs_show_address(struct device *dev,
-					 struct device_attribute *attr,
-					 char *buf)
-{
-	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
-
-	return ctrl->ops->get_address(ctrl, buf, PAGE_SIZE);
-}
-static DEVICE_ATTR(address, S_IRUGO, nvme_sysfs_show_address, NULL);
-
-static ssize_t nvme_ctrl_loss_tmo_show(struct device *dev,
-		struct device_attribute *attr, char *buf)
-{
-	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
-	struct nvmf_ctrl_options *opts = ctrl->opts;
-
-	if (ctrl->opts->max_reconnects == -1)
-		return sysfs_emit(buf, "off\n");
-	return sysfs_emit(buf, "%d\n",
-			  opts->max_reconnects * opts->reconnect_delay);
-}
-
-static ssize_t nvme_ctrl_loss_tmo_store(struct device *dev,
-		struct device_attribute *attr, const char *buf, size_t count)
-{
-	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
-	struct nvmf_ctrl_options *opts = ctrl->opts;
-	int ctrl_loss_tmo, err;
-
-	err = kstrtoint(buf, 10, &ctrl_loss_tmo);
-	if (err)
-		return -EINVAL;
-
-	if (ctrl_loss_tmo < 0)
-		opts->max_reconnects = -1;
-	else
-		opts->max_reconnects = DIV_ROUND_UP(ctrl_loss_tmo,
-						opts->reconnect_delay);
-	return count;
-}
-static DEVICE_ATTR(ctrl_loss_tmo, S_IRUGO | S_IWUSR,
-	nvme_ctrl_loss_tmo_show, nvme_ctrl_loss_tmo_store);
-
-static ssize_t nvme_ctrl_reconnect_delay_show(struct device *dev,
-		struct device_attribute *attr, char *buf)
-{
-	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
-
-	if (ctrl->opts->reconnect_delay == -1)
-		return sysfs_emit(buf, "off\n");
-	return sysfs_emit(buf, "%d\n", ctrl->opts->reconnect_delay);
-}
-
-static ssize_t nvme_ctrl_reconnect_delay_store(struct device *dev,
-		struct device_attribute *attr, const char *buf, size_t count)
-{
-	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
-	unsigned int v;
-	int err;
-
-	err = kstrtou32(buf, 10, &v);
-	if (err)
-		return err;
-
-	ctrl->opts->reconnect_delay = v;
-	return count;
-}
-static DEVICE_ATTR(reconnect_delay, S_IRUGO | S_IWUSR,
-	nvme_ctrl_reconnect_delay_show, nvme_ctrl_reconnect_delay_store);
-
-static ssize_t nvme_ctrl_fast_io_fail_tmo_show(struct device *dev,
-		struct device_attribute *attr, char *buf)
-{
-	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
-
-	if (ctrl->opts->fast_io_fail_tmo == -1)
-		return sysfs_emit(buf, "off\n");
-	return sysfs_emit(buf, "%d\n", ctrl->opts->fast_io_fail_tmo);
-}
-
-static ssize_t nvme_ctrl_fast_io_fail_tmo_store(struct device *dev,
-		struct device_attribute *attr, const char *buf, size_t count)
-{
-	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
-	struct nvmf_ctrl_options *opts = ctrl->opts;
-	int fast_io_fail_tmo, err;
-
-	err = kstrtoint(buf, 10, &fast_io_fail_tmo);
-	if (err)
-		return -EINVAL;
-
-	if (fast_io_fail_tmo < 0)
-		opts->fast_io_fail_tmo = -1;
-	else
-		opts->fast_io_fail_tmo = fast_io_fail_tmo;
-	return count;
-}
-static DEVICE_ATTR(fast_io_fail_tmo, S_IRUGO | S_IWUSR,
-	nvme_ctrl_fast_io_fail_tmo_show, nvme_ctrl_fast_io_fail_tmo_store);
-
-static ssize_t cntrltype_show(struct device *dev,
-			      struct device_attribute *attr, char *buf)
-{
-	static const char * const type[] = {
-		[NVME_CTRL_IO] = "io\n",
-		[NVME_CTRL_DISC] = "discovery\n",
-		[NVME_CTRL_ADMIN] = "admin\n",
-	};
-	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
-
-	if (ctrl->cntrltype > NVME_CTRL_ADMIN || !type[ctrl->cntrltype])
-		return sysfs_emit(buf, "reserved\n");
-
-	return sysfs_emit(buf, type[ctrl->cntrltype]);
-}
-static DEVICE_ATTR_RO(cntrltype);
-
-static ssize_t dctype_show(struct device *dev,
-			   struct device_attribute *attr, char *buf)
-{
-	static const char * const type[] = {
-		[NVME_DCTYPE_NOT_REPORTED] = "none\n",
-		[NVME_DCTYPE_DDC] = "ddc\n",
-		[NVME_DCTYPE_CDC] = "cdc\n",
-	};
-	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
-
-	if (ctrl->dctype > NVME_DCTYPE_CDC || !type[ctrl->dctype])
-		return sysfs_emit(buf, "reserved\n");
-
-	return sysfs_emit(buf, type[ctrl->dctype]);
-}
-static DEVICE_ATTR_RO(dctype);
-
-#ifdef CONFIG_NVME_AUTH
-static ssize_t nvme_ctrl_dhchap_secret_show(struct device *dev,
-		struct device_attribute *attr, char *buf)
-{
-	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
-	struct nvmf_ctrl_options *opts = ctrl->opts;
-
-	if (!opts->dhchap_secret)
-		return sysfs_emit(buf, "none\n");
-	return sysfs_emit(buf, "%s\n", opts->dhchap_secret);
-}
-
-static ssize_t nvme_ctrl_dhchap_secret_store(struct device *dev,
-		struct device_attribute *attr, const char *buf, size_t count)
-{
-	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
-	struct nvmf_ctrl_options *opts = ctrl->opts;
-	char *dhchap_secret;
-
-	if (!ctrl->opts->dhchap_secret)
-		return -EINVAL;
-	if (count < 7)
-		return -EINVAL;
-	if (memcmp(buf, "DHHC-1:", 7))
-		return -EINVAL;
-
-	dhchap_secret = kzalloc(count + 1, GFP_KERNEL);
-	if (!dhchap_secret)
-		return -ENOMEM;
-	memcpy(dhchap_secret, buf, count);
-	nvme_auth_stop(ctrl);
-	if (strcmp(dhchap_secret, opts->dhchap_secret)) {
-		struct nvme_dhchap_key *key, *host_key;
-		int ret;
-
-		ret = nvme_auth_generate_key(dhchap_secret, &key);
-		if (ret)
-			return ret;
-		kfree(opts->dhchap_secret);
-		opts->dhchap_secret = dhchap_secret;
-		host_key = ctrl->host_key;
-		mutex_lock(&ctrl->dhchap_auth_mutex);
-		ctrl->host_key = key;
-		mutex_unlock(&ctrl->dhchap_auth_mutex);
-		nvme_auth_free_key(host_key);
-	}
-	/* Start re-authentication */
-	dev_info(ctrl->device, "re-authenticating controller\n");
-	queue_work(nvme_wq, &ctrl->dhchap_auth_work);
-
-	return count;
-}
-static DEVICE_ATTR(dhchap_secret, S_IRUGO | S_IWUSR,
-	nvme_ctrl_dhchap_secret_show, nvme_ctrl_dhchap_secret_store);
-
-static ssize_t nvme_ctrl_dhchap_ctrl_secret_show(struct device *dev,
-		struct device_attribute *attr, char *buf)
-{
-	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
-	struct nvmf_ctrl_options *opts = ctrl->opts;
-
-	if (!opts->dhchap_ctrl_secret)
-		return sysfs_emit(buf, "none\n");
-	return sysfs_emit(buf, "%s\n", opts->dhchap_ctrl_secret);
-}
-
-static ssize_t nvme_ctrl_dhchap_ctrl_secret_store(struct device *dev,
-		struct device_attribute *attr, const char *buf, size_t count)
-{
-	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
-	struct nvmf_ctrl_options *opts = ctrl->opts;
-	char *dhchap_secret;
-
-	if (!ctrl->opts->dhchap_ctrl_secret)
-		return -EINVAL;
-	if (count < 7)
-		return -EINVAL;
-	if (memcmp(buf, "DHHC-1:", 7))
-		return -EINVAL;
-
-	dhchap_secret = kzalloc(count + 1, GFP_KERNEL);
-	if (!dhchap_secret)
-		return -ENOMEM;
-	memcpy(dhchap_secret, buf, count);
-	nvme_auth_stop(ctrl);
-	if (strcmp(dhchap_secret, opts->dhchap_ctrl_secret)) {
-		struct nvme_dhchap_key *key, *ctrl_key;
-		int ret;
-
-		ret = nvme_auth_generate_key(dhchap_secret, &key);
-		if (ret)
-			return ret;
-		kfree(opts->dhchap_ctrl_secret);
-		opts->dhchap_ctrl_secret = dhchap_secret;
-		ctrl_key = ctrl->ctrl_key;
-		mutex_lock(&ctrl->dhchap_auth_mutex);
-		ctrl->ctrl_key = key;
-		mutex_unlock(&ctrl->dhchap_auth_mutex);
-		nvme_auth_free_key(ctrl_key);
-	}
-	/* Start re-authentication */
-	dev_info(ctrl->device, "re-authenticating controller\n");
-	queue_work(nvme_wq, &ctrl->dhchap_auth_work);
-
-	return count;
-}
-static DEVICE_ATTR(dhchap_ctrl_secret, S_IRUGO | S_IWUSR,
-	nvme_ctrl_dhchap_ctrl_secret_show, nvme_ctrl_dhchap_ctrl_secret_store);
-#endif
-
-static struct attribute *nvme_dev_attrs[] = {
-	&dev_attr_reset_controller.attr,
-	&dev_attr_rescan_controller.attr,
-	&dev_attr_model.attr,
-	&dev_attr_serial.attr,
-	&dev_attr_firmware_rev.attr,
-	&dev_attr_cntlid.attr,
-	&dev_attr_delete_controller.attr,
-	&dev_attr_transport.attr,
-	&dev_attr_subsysnqn.attr,
-	&dev_attr_address.attr,
-	&dev_attr_state.attr,
-	&dev_attr_numa_node.attr,
-	&dev_attr_queue_count.attr,
-	&dev_attr_sqsize.attr,
-	&dev_attr_hostnqn.attr,
-	&dev_attr_hostid.attr,
-	&dev_attr_ctrl_loss_tmo.attr,
-	&dev_attr_reconnect_delay.attr,
-	&dev_attr_fast_io_fail_tmo.attr,
-	&dev_attr_kato.attr,
-	&dev_attr_cntrltype.attr,
-	&dev_attr_dctype.attr,
-#ifdef CONFIG_NVME_AUTH
-	&dev_attr_dhchap_secret.attr,
-	&dev_attr_dhchap_ctrl_secret.attr,
-#endif
-	NULL
-};
-
-static umode_t nvme_dev_attrs_are_visible(struct kobject *kobj,
-		struct attribute *a, int n)
-{
-	struct device *dev = container_of(kobj, struct device, kobj);
-	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
-
-	if (a == &dev_attr_delete_controller.attr && !ctrl->ops->delete_ctrl)
-		return 0;
-	if (a == &dev_attr_address.attr && !ctrl->ops->get_address)
-		return 0;
-	if (a == &dev_attr_hostnqn.attr && !ctrl->opts)
-		return 0;
-	if (a == &dev_attr_hostid.attr && !ctrl->opts)
-		return 0;
-	if (a == &dev_attr_ctrl_loss_tmo.attr && !ctrl->opts)
-		return 0;
-	if (a == &dev_attr_reconnect_delay.attr && !ctrl->opts)
-		return 0;
-	if (a == &dev_attr_fast_io_fail_tmo.attr && !ctrl->opts)
-		return 0;
-#ifdef CONFIG_NVME_AUTH
-	if (a == &dev_attr_dhchap_secret.attr && !ctrl->opts)
-		return 0;
-	if (a == &dev_attr_dhchap_ctrl_secret.attr && !ctrl->opts)
-		return 0;
-#endif
-
-	return a->mode;
-}
-
-const struct attribute_group nvme_dev_attrs_group = {
-	.attrs		= nvme_dev_attrs,
-	.is_visible	= nvme_dev_attrs_are_visible,
-};
-EXPORT_SYMBOL_GPL(nvme_dev_attrs_group);
-
-static const struct attribute_group *nvme_dev_attr_groups[] = {
-	&nvme_dev_attrs_group,
-	NULL,
-};
-
 static struct nvme_ns_head *nvme_find_ns_head(struct nvme_ctrl *ctrl,
 		unsigned nsid)
 {
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index bf46f122e9e1..f49a142e5013 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -860,7 +860,11 @@ extern const struct attribute_group *nvme_ns_id_attr_groups[];
 extern const struct pr_ops nvme_pr_ops;
 extern const struct block_device_operations nvme_ns_head_ops;
 extern const struct attribute_group nvme_dev_attrs_group;
+extern const struct attribute_group *nvme_subsys_attrs_groups[];
+extern const struct attribute_group *nvme_dev_attr_groups[];
+extern const struct block_device_operations nvme_bdev_ops;
 
+void nvme_delete_ctrl_sync(struct nvme_ctrl *ctrl);
 struct nvme_ns *nvme_find_path(struct nvme_ns_head *head);
 #ifdef CONFIG_NVME_MULTIPATH
 static inline bool nvme_ctrl_use_ana(struct nvme_ctrl *ctrl)
diff --git a/drivers/nvme/host/sysfs.c b/drivers/nvme/host/sysfs.c
new file mode 100644
index 000000000000..4e2e8e47b2f5
--- /dev/null
+++ b/drivers/nvme/host/sysfs.c
@@ -0,0 +1,655 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Sysfs interface for the NVMe core driver.
+ *
+ * Copyright (c) 2011-2014, Intel Corporation.
+ */
+
+#include "nvme.h"
+#include "fabrics.h"
+
+static ssize_t nvme_sysfs_reset(struct device *dev,
+				struct device_attribute *attr, const char *buf,
+				size_t count)
+{
+	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
+	int ret;
+
+	ret = nvme_reset_ctrl_sync(ctrl);
+	if (ret < 0)
+		return ret;
+	return count;
+}
+static DEVICE_ATTR(reset_controller, S_IWUSR, NULL, nvme_sysfs_reset);
+
+static ssize_t nvme_sysfs_rescan(struct device *dev,
+				struct device_attribute *attr, const char *buf,
+				size_t count)
+{
+	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
+
+	nvme_queue_scan(ctrl);
+	return count;
+}
+static DEVICE_ATTR(rescan_controller, S_IWUSR, NULL, nvme_sysfs_rescan);
+
+static inline struct nvme_ns_head *dev_to_ns_head(struct device *dev)
+{
+	struct gendisk *disk = dev_to_disk(dev);
+
+	if (disk->fops == &nvme_bdev_ops)
+		return nvme_get_ns_from_dev(dev)->head;
+	else
+		return disk->private_data;
+}
+
+static ssize_t wwid_show(struct device *dev, struct device_attribute *attr,
+		char *buf)
+{
+	struct nvme_ns_head *head = dev_to_ns_head(dev);
+	struct nvme_ns_ids *ids = &head->ids;
+	struct nvme_subsystem *subsys = head->subsys;
+	int serial_len = sizeof(subsys->serial);
+	int model_len = sizeof(subsys->model);
+
+	if (!uuid_is_null(&ids->uuid))
+		return sysfs_emit(buf, "uuid.%pU\n", &ids->uuid);
+
+	if (memchr_inv(ids->nguid, 0, sizeof(ids->nguid)))
+		return sysfs_emit(buf, "eui.%16phN\n", ids->nguid);
+
+	if (memchr_inv(ids->eui64, 0, sizeof(ids->eui64)))
+		return sysfs_emit(buf, "eui.%8phN\n", ids->eui64);
+
+	while (serial_len > 0 && (subsys->serial[serial_len - 1] == ' ' ||
+				  subsys->serial[serial_len - 1] == '\0'))
+		serial_len--;
+	while (model_len > 0 && (subsys->model[model_len - 1] == ' ' ||
+				 subsys->model[model_len - 1] == '\0'))
+		model_len--;
+
+	return sysfs_emit(buf, "nvme.%04x-%*phN-%*phN-%08x\n", subsys->vendor_id,
+		serial_len, subsys->serial, model_len, subsys->model,
+		head->ns_id);
+}
+static DEVICE_ATTR_RO(wwid);
+
+static ssize_t nguid_show(struct device *dev, struct device_attribute *attr,
+		char *buf)
+{
+	return sysfs_emit(buf, "%pU\n", dev_to_ns_head(dev)->ids.nguid);
+}
+static DEVICE_ATTR_RO(nguid);
+
+static ssize_t uuid_show(struct device *dev, struct device_attribute *attr,
+		char *buf)
+{
+	struct nvme_ns_ids *ids = &dev_to_ns_head(dev)->ids;
+
+	/* For backward compatibility expose the NGUID to userspace if
+	 * we have no UUID set
+	 */
+	if (uuid_is_null(&ids->uuid)) {
+		dev_warn_ratelimited(dev,
+			"No UUID available providing old NGUID\n");
+		return sysfs_emit(buf, "%pU\n", ids->nguid);
+	}
+	return sysfs_emit(buf, "%pU\n", &ids->uuid);
+}
+static DEVICE_ATTR_RO(uuid);
+
+static ssize_t eui_show(struct device *dev, struct device_attribute *attr,
+		char *buf)
+{
+	return sysfs_emit(buf, "%8ph\n", dev_to_ns_head(dev)->ids.eui64);
+}
+static DEVICE_ATTR_RO(eui);
+
+static ssize_t nsid_show(struct device *dev, struct device_attribute *attr,
+		char *buf)
+{
+	return sysfs_emit(buf, "%d\n", dev_to_ns_head(dev)->ns_id);
+}
+static DEVICE_ATTR_RO(nsid);
+
+static struct attribute *nvme_ns_id_attrs[] = {
+	&dev_attr_wwid.attr,
+	&dev_attr_uuid.attr,
+	&dev_attr_nguid.attr,
+	&dev_attr_eui.attr,
+	&dev_attr_nsid.attr,
+#ifdef CONFIG_NVME_MULTIPATH
+	&dev_attr_ana_grpid.attr,
+	&dev_attr_ana_state.attr,
+#endif
+	NULL,
+};
+
+static umode_t nvme_ns_id_attrs_are_visible(struct kobject *kobj,
+		struct attribute *a, int n)
+{
+	struct device *dev = container_of(kobj, struct device, kobj);
+	struct nvme_ns_ids *ids = &dev_to_ns_head(dev)->ids;
+
+	if (a == &dev_attr_uuid.attr) {
+		if (uuid_is_null(&ids->uuid) &&
+		    !memchr_inv(ids->nguid, 0, sizeof(ids->nguid)))
+			return 0;
+	}
+	if (a == &dev_attr_nguid.attr) {
+		if (!memchr_inv(ids->nguid, 0, sizeof(ids->nguid)))
+			return 0;
+	}
+	if (a == &dev_attr_eui.attr) {
+		if (!memchr_inv(ids->eui64, 0, sizeof(ids->eui64)))
+			return 0;
+	}
+#ifdef CONFIG_NVME_MULTIPATH
+	if (a == &dev_attr_ana_grpid.attr || a == &dev_attr_ana_state.attr) {
+		if (dev_to_disk(dev)->fops != &nvme_bdev_ops) /* per-path attr */
+			return 0;
+		if (!nvme_ctrl_use_ana(nvme_get_ns_from_dev(dev)->ctrl))
+			return 0;
+	}
+#endif
+	return a->mode;
+}
+
+static const struct attribute_group nvme_ns_id_attr_group = {
+	.attrs		= nvme_ns_id_attrs,
+	.is_visible	= nvme_ns_id_attrs_are_visible,
+};
+
+const struct attribute_group *nvme_ns_id_attr_groups[] = {
+	&nvme_ns_id_attr_group,
+	NULL,
+};
+
+#define nvme_show_str_function(field)						\
+static ssize_t  field##_show(struct device *dev,				\
+			    struct device_attribute *attr, char *buf)		\
+{										\
+        struct nvme_ctrl *ctrl = dev_get_drvdata(dev);				\
+        return sysfs_emit(buf, "%.*s\n",					\
+		(int)sizeof(ctrl->subsys->field), ctrl->subsys->field);		\
+}										\
+static DEVICE_ATTR(field, S_IRUGO, field##_show, NULL);
+
+nvme_show_str_function(model);
+nvme_show_str_function(serial);
+nvme_show_str_function(firmware_rev);
+
+#define nvme_show_int_function(field)						\
+static ssize_t  field##_show(struct device *dev,				\
+			    struct device_attribute *attr, char *buf)		\
+{										\
+        struct nvme_ctrl *ctrl = dev_get_drvdata(dev);				\
+        return sysfs_emit(buf, "%d\n", ctrl->field);				\
+}										\
+static DEVICE_ATTR(field, S_IRUGO, field##_show, NULL);
+
+nvme_show_int_function(cntlid);
+nvme_show_int_function(numa_node);
+nvme_show_int_function(queue_count);
+nvme_show_int_function(sqsize);
+nvme_show_int_function(kato);
+
+static ssize_t nvme_sysfs_delete(struct device *dev,
+				struct device_attribute *attr, const char *buf,
+				size_t count)
+{
+	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
+
+	if (device_remove_file_self(dev, attr))
+		nvme_delete_ctrl_sync(ctrl);
+	return count;
+}
+static DEVICE_ATTR(delete_controller, S_IWUSR, NULL, nvme_sysfs_delete);
+
+static ssize_t nvme_sysfs_show_transport(struct device *dev,
+					 struct device_attribute *attr,
+					 char *buf)
+{
+	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
+
+	return sysfs_emit(buf, "%s\n", ctrl->ops->name);
+}
+static DEVICE_ATTR(transport, S_IRUGO, nvme_sysfs_show_transport, NULL);
+
+static ssize_t nvme_sysfs_show_state(struct device *dev,
+				     struct device_attribute *attr,
+				     char *buf)
+{
+	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
+	static const char *const state_name[] = {
+		[NVME_CTRL_NEW]		= "new",
+		[NVME_CTRL_LIVE]	= "live",
+		[NVME_CTRL_RESETTING]	= "resetting",
+		[NVME_CTRL_CONNECTING]	= "connecting",
+		[NVME_CTRL_DELETING]	= "deleting",
+		[NVME_CTRL_DELETING_NOIO]= "deleting (no IO)",
+		[NVME_CTRL_DEAD]	= "dead",
+	};
+
+	if ((unsigned)ctrl->state < ARRAY_SIZE(state_name) &&
+	    state_name[ctrl->state])
+		return sysfs_emit(buf, "%s\n", state_name[ctrl->state]);
+
+	return sysfs_emit(buf, "unknown state\n");
+}
+
+static DEVICE_ATTR(state, S_IRUGO, nvme_sysfs_show_state, NULL);
+
+static ssize_t nvme_sysfs_show_subsysnqn(struct device *dev,
+					 struct device_attribute *attr,
+					 char *buf)
+{
+	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
+
+	return sysfs_emit(buf, "%s\n", ctrl->subsys->subnqn);
+}
+static DEVICE_ATTR(subsysnqn, S_IRUGO, nvme_sysfs_show_subsysnqn, NULL);
+
+static ssize_t nvme_sysfs_show_hostnqn(struct device *dev,
+					struct device_attribute *attr,
+					char *buf)
+{
+	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
+
+	return sysfs_emit(buf, "%s\n", ctrl->opts->host->nqn);
+}
+static DEVICE_ATTR(hostnqn, S_IRUGO, nvme_sysfs_show_hostnqn, NULL);
+
+static ssize_t nvme_sysfs_show_hostid(struct device *dev,
+					struct device_attribute *attr,
+					char *buf)
+{
+	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
+
+	return sysfs_emit(buf, "%pU\n", &ctrl->opts->host->id);
+}
+static DEVICE_ATTR(hostid, S_IRUGO, nvme_sysfs_show_hostid, NULL);
+
+static ssize_t nvme_sysfs_show_address(struct device *dev,
+					 struct device_attribute *attr,
+					 char *buf)
+{
+	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
+
+	return ctrl->ops->get_address(ctrl, buf, PAGE_SIZE);
+}
+static DEVICE_ATTR(address, S_IRUGO, nvme_sysfs_show_address, NULL);
+
+static ssize_t nvme_ctrl_loss_tmo_show(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
+	struct nvmf_ctrl_options *opts = ctrl->opts;
+
+	if (ctrl->opts->max_reconnects == -1)
+		return sysfs_emit(buf, "off\n");
+	return sysfs_emit(buf, "%d\n",
+			  opts->max_reconnects * opts->reconnect_delay);
+}
+
+static ssize_t nvme_ctrl_loss_tmo_store(struct device *dev,
+		struct device_attribute *attr, const char *buf, size_t count)
+{
+	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
+	struct nvmf_ctrl_options *opts = ctrl->opts;
+	int ctrl_loss_tmo, err;
+
+	err = kstrtoint(buf, 10, &ctrl_loss_tmo);
+	if (err)
+		return -EINVAL;
+
+	if (ctrl_loss_tmo < 0)
+		opts->max_reconnects = -1;
+	else
+		opts->max_reconnects = DIV_ROUND_UP(ctrl_loss_tmo,
+						opts->reconnect_delay);
+	return count;
+}
+static DEVICE_ATTR(ctrl_loss_tmo, S_IRUGO | S_IWUSR,
+	nvme_ctrl_loss_tmo_show, nvme_ctrl_loss_tmo_store);
+
+static ssize_t nvme_ctrl_reconnect_delay_show(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
+
+	if (ctrl->opts->reconnect_delay == -1)
+		return sysfs_emit(buf, "off\n");
+	return sysfs_emit(buf, "%d\n", ctrl->opts->reconnect_delay);
+}
+
+static ssize_t nvme_ctrl_reconnect_delay_store(struct device *dev,
+		struct device_attribute *attr, const char *buf, size_t count)
+{
+	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
+	unsigned int v;
+	int err;
+
+	err = kstrtou32(buf, 10, &v);
+	if (err)
+		return err;
+
+	ctrl->opts->reconnect_delay = v;
+	return count;
+}
+static DEVICE_ATTR(reconnect_delay, S_IRUGO | S_IWUSR,
+	nvme_ctrl_reconnect_delay_show, nvme_ctrl_reconnect_delay_store);
+
+static ssize_t nvme_ctrl_fast_io_fail_tmo_show(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
+
+	if (ctrl->opts->fast_io_fail_tmo == -1)
+		return sysfs_emit(buf, "off\n");
+	return sysfs_emit(buf, "%d\n", ctrl->opts->fast_io_fail_tmo);
+}
+
+static ssize_t nvme_ctrl_fast_io_fail_tmo_store(struct device *dev,
+		struct device_attribute *attr, const char *buf, size_t count)
+{
+	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
+	struct nvmf_ctrl_options *opts = ctrl->opts;
+	int fast_io_fail_tmo, err;
+
+	err = kstrtoint(buf, 10, &fast_io_fail_tmo);
+	if (err)
+		return -EINVAL;
+
+	if (fast_io_fail_tmo < 0)
+		opts->fast_io_fail_tmo = -1;
+	else
+		opts->fast_io_fail_tmo = fast_io_fail_tmo;
+	return count;
+}
+static DEVICE_ATTR(fast_io_fail_tmo, S_IRUGO | S_IWUSR,
+	nvme_ctrl_fast_io_fail_tmo_show, nvme_ctrl_fast_io_fail_tmo_store);
+
+static ssize_t cntrltype_show(struct device *dev,
+			      struct device_attribute *attr, char *buf)
+{
+	static const char * const type[] = {
+		[NVME_CTRL_IO] = "io\n",
+		[NVME_CTRL_DISC] = "discovery\n",
+		[NVME_CTRL_ADMIN] = "admin\n",
+	};
+	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
+
+	if (ctrl->cntrltype > NVME_CTRL_ADMIN || !type[ctrl->cntrltype])
+		return sysfs_emit(buf, "reserved\n");
+
+	return sysfs_emit(buf, type[ctrl->cntrltype]);
+}
+static DEVICE_ATTR_RO(cntrltype);
+
+static ssize_t dctype_show(struct device *dev,
+			   struct device_attribute *attr, char *buf)
+{
+	static const char * const type[] = {
+		[NVME_DCTYPE_NOT_REPORTED] = "none\n",
+		[NVME_DCTYPE_DDC] = "ddc\n",
+		[NVME_DCTYPE_CDC] = "cdc\n",
+	};
+	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
+
+	if (ctrl->dctype > NVME_DCTYPE_CDC || !type[ctrl->dctype])
+		return sysfs_emit(buf, "reserved\n");
+
+	return sysfs_emit(buf, type[ctrl->dctype]);
+}
+static DEVICE_ATTR_RO(dctype);
+
+#ifdef CONFIG_NVME_AUTH
+static ssize_t nvme_ctrl_dhchap_secret_show(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
+	struct nvmf_ctrl_options *opts = ctrl->opts;
+
+	if (!opts->dhchap_secret)
+		return sysfs_emit(buf, "none\n");
+	return sysfs_emit(buf, "%s\n", opts->dhchap_secret);
+}
+
+static ssize_t nvme_ctrl_dhchap_secret_store(struct device *dev,
+		struct device_attribute *attr, const char *buf, size_t count)
+{
+	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
+	struct nvmf_ctrl_options *opts = ctrl->opts;
+	char *dhchap_secret;
+
+	if (!ctrl->opts->dhchap_secret)
+		return -EINVAL;
+	if (count < 7)
+		return -EINVAL;
+	if (memcmp(buf, "DHHC-1:", 7))
+		return -EINVAL;
+
+	dhchap_secret = kzalloc(count + 1, GFP_KERNEL);
+	if (!dhchap_secret)
+		return -ENOMEM;
+	memcpy(dhchap_secret, buf, count);
+	nvme_auth_stop(ctrl);
+	if (strcmp(dhchap_secret, opts->dhchap_secret)) {
+		struct nvme_dhchap_key *key, *host_key;
+		int ret;
+
+		ret = nvme_auth_generate_key(dhchap_secret, &key);
+		if (ret)
+			return ret;
+		kfree(opts->dhchap_secret);
+		opts->dhchap_secret = dhchap_secret;
+		host_key = ctrl->host_key;
+		mutex_lock(&ctrl->dhchap_auth_mutex);
+		ctrl->host_key = key;
+		mutex_unlock(&ctrl->dhchap_auth_mutex);
+		nvme_auth_free_key(host_key);
+	}
+	/* Start re-authentication */
+	dev_info(ctrl->device, "re-authenticating controller\n");
+	queue_work(nvme_wq, &ctrl->dhchap_auth_work);
+
+	return count;
+}
+static DEVICE_ATTR(dhchap_secret, S_IRUGO | S_IWUSR,
+	nvme_ctrl_dhchap_secret_show, nvme_ctrl_dhchap_secret_store);
+
+static ssize_t nvme_ctrl_dhchap_ctrl_secret_show(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
+	struct nvmf_ctrl_options *opts = ctrl->opts;
+
+	if (!opts->dhchap_ctrl_secret)
+		return sysfs_emit(buf, "none\n");
+	return sysfs_emit(buf, "%s\n", opts->dhchap_ctrl_secret);
+}
+
+static ssize_t nvme_ctrl_dhchap_ctrl_secret_store(struct device *dev,
+		struct device_attribute *attr, const char *buf, size_t count)
+{
+	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
+	struct nvmf_ctrl_options *opts = ctrl->opts;
+	char *dhchap_secret;
+
+	if (!ctrl->opts->dhchap_ctrl_secret)
+		return -EINVAL;
+	if (count < 7)
+		return -EINVAL;
+	if (memcmp(buf, "DHHC-1:", 7))
+		return -EINVAL;
+
+	dhchap_secret = kzalloc(count + 1, GFP_KERNEL);
+	if (!dhchap_secret)
+		return -ENOMEM;
+	memcpy(dhchap_secret, buf, count);
+	nvme_auth_stop(ctrl);
+	if (strcmp(dhchap_secret, opts->dhchap_ctrl_secret)) {
+		struct nvme_dhchap_key *key, *ctrl_key;
+		int ret;
+
+		ret = nvme_auth_generate_key(dhchap_secret, &key);
+		if (ret)
+			return ret;
+		kfree(opts->dhchap_ctrl_secret);
+		opts->dhchap_ctrl_secret = dhchap_secret;
+		ctrl_key = ctrl->ctrl_key;
+		mutex_lock(&ctrl->dhchap_auth_mutex);
+		ctrl->ctrl_key = key;
+		mutex_unlock(&ctrl->dhchap_auth_mutex);
+		nvme_auth_free_key(ctrl_key);
+	}
+	/* Start re-authentication */
+	dev_info(ctrl->device, "re-authenticating controller\n");
+	queue_work(nvme_wq, &ctrl->dhchap_auth_work);
+
+	return count;
+}
+static DEVICE_ATTR(dhchap_ctrl_secret, S_IRUGO | S_IWUSR,
+	nvme_ctrl_dhchap_ctrl_secret_show, nvme_ctrl_dhchap_ctrl_secret_store);
+#endif
+
+static struct attribute *nvme_dev_attrs[] = {
+	&dev_attr_reset_controller.attr,
+	&dev_attr_rescan_controller.attr,
+	&dev_attr_model.attr,
+	&dev_attr_serial.attr,
+	&dev_attr_firmware_rev.attr,
+	&dev_attr_cntlid.attr,
+	&dev_attr_delete_controller.attr,
+	&dev_attr_transport.attr,
+	&dev_attr_subsysnqn.attr,
+	&dev_attr_address.attr,
+	&dev_attr_state.attr,
+	&dev_attr_numa_node.attr,
+	&dev_attr_queue_count.attr,
+	&dev_attr_sqsize.attr,
+	&dev_attr_hostnqn.attr,
+	&dev_attr_hostid.attr,
+	&dev_attr_ctrl_loss_tmo.attr,
+	&dev_attr_reconnect_delay.attr,
+	&dev_attr_fast_io_fail_tmo.attr,
+	&dev_attr_kato.attr,
+	&dev_attr_cntrltype.attr,
+	&dev_attr_dctype.attr,
+#ifdef CONFIG_NVME_AUTH
+	&dev_attr_dhchap_secret.attr,
+	&dev_attr_dhchap_ctrl_secret.attr,
+#endif
+	NULL
+};
+
+static umode_t nvme_dev_attrs_are_visible(struct kobject *kobj,
+		struct attribute *a, int n)
+{
+	struct device *dev = container_of(kobj, struct device, kobj);
+	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
+
+	if (a == &dev_attr_delete_controller.attr && !ctrl->ops->delete_ctrl)
+		return 0;
+	if (a == &dev_attr_address.attr && !ctrl->ops->get_address)
+		return 0;
+	if (a == &dev_attr_hostnqn.attr && !ctrl->opts)
+		return 0;
+	if (a == &dev_attr_hostid.attr && !ctrl->opts)
+		return 0;
+	if (a == &dev_attr_ctrl_loss_tmo.attr && !ctrl->opts)
+		return 0;
+	if (a == &dev_attr_reconnect_delay.attr && !ctrl->opts)
+		return 0;
+	if (a == &dev_attr_fast_io_fail_tmo.attr && !ctrl->opts)
+		return 0;
+#ifdef CONFIG_NVME_AUTH
+	if (a == &dev_attr_dhchap_secret.attr && !ctrl->opts)
+		return 0;
+	if (a == &dev_attr_dhchap_ctrl_secret.attr && !ctrl->opts)
+		return 0;
+#endif
+
+	return a->mode;
+}
+
+const struct attribute_group nvme_dev_attrs_group = {
+	.attrs		= nvme_dev_attrs,
+	.is_visible	= nvme_dev_attrs_are_visible,
+};
+EXPORT_SYMBOL_GPL(nvme_dev_attrs_group);
+
+const struct attribute_group *nvme_dev_attr_groups[] = {
+	&nvme_dev_attrs_group,
+	NULL,
+};
+
+#define SUBSYS_ATTR_RO(_name, _mode, _show)			\
+	struct device_attribute subsys_attr_##_name = \
+		__ATTR(_name, _mode, _show, NULL)
+
+static ssize_t nvme_subsys_show_nqn(struct device *dev,
+				    struct device_attribute *attr,
+				    char *buf)
+{
+	struct nvme_subsystem *subsys =
+		container_of(dev, struct nvme_subsystem, dev);
+
+	return sysfs_emit(buf, "%s\n", subsys->subnqn);
+}
+static SUBSYS_ATTR_RO(subsysnqn, S_IRUGO, nvme_subsys_show_nqn);
+
+static ssize_t nvme_subsys_show_type(struct device *dev,
+				    struct device_attribute *attr,
+				    char *buf)
+{
+	struct nvme_subsystem *subsys =
+		container_of(dev, struct nvme_subsystem, dev);
+
+	switch (subsys->subtype) {
+	case NVME_NQN_DISC:
+		return sysfs_emit(buf, "discovery\n");
+	case NVME_NQN_NVME:
+		return sysfs_emit(buf, "nvm\n");
+	default:
+		return sysfs_emit(buf, "reserved\n");
+	}
+}
+static SUBSYS_ATTR_RO(subsystype, S_IRUGO, nvme_subsys_show_type);
+
+#define nvme_subsys_show_str_function(field)				\
+static ssize_t subsys_##field##_show(struct device *dev,		\
+			    struct device_attribute *attr, char *buf)	\
+{									\
+	struct nvme_subsystem *subsys =					\
+		container_of(dev, struct nvme_subsystem, dev);		\
+	return sysfs_emit(buf, "%.*s\n",				\
+			   (int)sizeof(subsys->field), subsys->field);	\
+}									\
+static SUBSYS_ATTR_RO(field, S_IRUGO, subsys_##field##_show);
+
+nvme_subsys_show_str_function(model);
+nvme_subsys_show_str_function(serial);
+nvme_subsys_show_str_function(firmware_rev);
+
+static struct attribute *nvme_subsys_attrs[] = {
+	&subsys_attr_model.attr,
+	&subsys_attr_serial.attr,
+	&subsys_attr_firmware_rev.attr,
+	&subsys_attr_subsysnqn.attr,
+	&subsys_attr_subsystype.attr,
+#ifdef CONFIG_NVME_MULTIPATH
+	&subsys_attr_iopolicy.attr,
+#endif
+	NULL,
+};
+
+static const struct attribute_group nvme_subsys_attrs_group = {
+	.attrs = nvme_subsys_attrs,
+};
+
+const struct attribute_group *nvme_subsys_attrs_groups[] = {
+	&nvme_subsys_attrs_group,
+	NULL,
+};
-- 
2.18.1


