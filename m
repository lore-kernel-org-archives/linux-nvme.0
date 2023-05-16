Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A4A9C7EE24
	for <linux-nvme@archiver.kernel.org>; Tue, 16 May 2023 10:07:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=stCwePinifCMU9PvnrzPojWNkkJ4jDr/6PMif+eh2pU=; b=KRttSM3ketDW1HzRwvM1MqqnS8
	YOJiurK3Qw2IGsz11iulskD1QWpxy7Hi2q7wIdRdxv6y/okeAguHebpzoKV5pxr2i3QNZibBB/+5j
	zjbQ8wZkhp9NM28gG38ldyYO6WzBqZ44kRpkHwAw5MbWPnmQ0o0h1ffBF8GIXdHNAjQc8tQWVaErR
	QR57YYIzrD7ILRaLRS8Ok9ZxOKfUONEfV9D1mwUAGdYVnVhE1NHyt2lEG/ulNCOwidV5HoJ7xyrne
	oWttEAxFRVOmCxspXk9ENLmvZsZKdLF8h+PtaB6lazEC/iDr+S1GIwxF0JIbiRAX1Y0xnhNNcT6ff
	8Y8u3DyQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pyraE-005C6j-1i;
	Tue, 16 May 2023 10:07:06 +0000
Received: from mail-bn7nam10on2060c.outbound.protection.outlook.com ([2a01:111:f400:7e8a::60c] helo=NAM10-BN7-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pyraB-005C4N-17
	for linux-nvme@lists.infradead.org;
	Tue, 16 May 2023 10:07:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R1ZdssyBLo22emQ+kM/TDmvxdsJkChhTylAjlmP2W+G6+r6O7/oB5i+46wYiEFJZKTMqMJgdQBHWH08nWQv1GqhJveH02FLz59SjY20L9ToV5bY+IQ1V5bPKm5vQopR7n93PxhV+89O5W3YOjAvK3823fj8euHKtyC1AuG6jzONqpU+CraAXcHQrJpsSfou8bcZAPS8qzUgZjncXAIb9FQalyk1yCB5IZD+bO0qNmZJzrgbRjoJLORfR9u8X4SwBmKj7qZjW3P44BRrr/1VLZlJUMofdwJ3sD1eqSB2K33WJShoL/Ih2a72Tql2WCs11wPe887rDCcGU32Y8p5RA3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=stCwePinifCMU9PvnrzPojWNkkJ4jDr/6PMif+eh2pU=;
 b=W++Ey7DSQ0CEIvQa8qUYACWgO2Hid/xRNVfwGkvOmSF1kqiWIxSt9xs78XK+1iTufWn7/FN+gg/eEiL27G8MDNdm8C8pc/nkgYkYVeajnvTtGr4L65S65a26wFUKqBLKbTLfci8+LIfoAX+qGpSNE/a2eYBG7GBLgFjSMGOZqlVh79sjCwQS4lQT8trV9apWZ0SXgH6HQzB+rjoxjIcWe+Pc7aUprc6whbmJ8hmWR/CG0faZW/wwdu5M/GzNpqxioY+HYsNpVI7aT7I79vQZ38p3+5gNwlSFg0UP4edhiIU/GqeqnogMbt7DQiP50N/JrhORvslQ6LzNsXzzTVa8rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=suse.de smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=stCwePinifCMU9PvnrzPojWNkkJ4jDr/6PMif+eh2pU=;
 b=McpBUe2JegkgrNpdn6EZmhMvxrySNgIi8D7DOzgFast6pDGXmo4A9Vp//mhS+wLlHUFBO0g6v1mf0crnbOOjVMCkpsI+wHNC74/BEPLiC7t6Y/0a3dNZNAK6nbC9inyk+TpnYRRKgtpRIriYetOj4ogNsk3n6Z263/JKU20Dr+OLSK8rKoxULFkoHZ/KmePlxAmFY92FL5hl6D9JOoyhVUCRhO4ZJyT+Vq6Kc8T7kGdS1bvvyYUw0uJFaD73AzRsdtE0cjXsild71gOAbqHUW++SR2pTnOqn0CWR6W1f+1mo1Hft2+t/Hh+YtXq/2aK4msLm/Ubsj58vXFiApuL28w==
Received: from SJ0PR13CA0134.namprd13.prod.outlook.com (2603:10b6:a03:2c6::19)
 by PH7PR12MB8794.namprd12.prod.outlook.com (2603:10b6:510:27d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.33; Tue, 16 May
 2023 10:06:59 +0000
Received: from DM6NAM11FT101.eop-nam11.prod.protection.outlook.com
 (2603:10b6:a03:2c6:cafe::47) by SJ0PR13CA0134.outlook.office365.com
 (2603:10b6:a03:2c6::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.14 via Frontend
 Transport; Tue, 16 May 2023 10:06:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DM6NAM11FT101.mail.protection.outlook.com (10.13.172.208) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6411.15 via Frontend Transport; Tue, 16 May 2023 10:06:58 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Tue, 16 May 2023
 03:06:46 -0700
Received: from dev.nvidia.com (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Tue, 16 May
 2023 03:06:46 -0700
From: Chaitanya Kulkarni <kch@nvidia.com>
To: <hare@suse.de>
CC: <kbusch@kernel.org>, <hch@lst.de>, <sagi@grimberg.me>,
	<linux-nvme@lists.infradead.org>, Chaitanya Kulkarni <kch@nvidia.com>
Subject: [PATCH 3/3] nvme-core: use macro defination to define dev attr
Date: Tue, 16 May 2023 03:06:05 -0700
Message-ID: <20230516100605.53712-4-kch@nvidia.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230516100605.53712-1-kch@nvidia.com>
References: <20230516100605.53712-1-kch@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.37]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT101:EE_|PH7PR12MB8794:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ffa0932-b70b-4243-3b39-08db55f54934
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 	R/anq3n5+YT75UD+DfpBQUJew1EDCIBJm85UBpZhBAfMFXnv+63fbd7dtBDC0sYQ0wRaHGyvpChVa1XrXi1fRFitni0tqNQ2MAnczAMNrLrxZWMNw/owboKQvspU9MaA+ULos1vxecalGSZ6c3EHteDTiOIspxZ3pfOgEg3NYh0rBX+EePauVGtJntVYUwKu/POa2Kwvtz56fiEOeXv/D9oYoRG4v8jdX8EqL/BHaGpec1l7h4B0aUmXJYnwrX37KdAcwlraZEhog+VmGNYbAI1VesUtieFIaCCy9F8HHxrt924OnZAWbci0ZbFoRhD8FHmrEUxZwQBHnDlnCo//Y8X5xhf/RPAgm3a7Ik7r/p4+GTebzKMuwEB9M0VzFwio4Vj2GRpdmCUI06sHiK9/a2XPX0dVVxFKurl2FSIDOpxOnhEbKfN46EmfWKaVznNIITjFjhnpAWo5bc59sH5J3aP03DD/SXomDeneIrjdLUuM7tjFr8Y3Xu7P69Y/RoeL9leoCteuGNY+zOSpa9sMopP1QS+xR4pMC6BgQCSwCptIFGY+1zDFG9+36dYJI99/WkTOYdW40yvZbLUkc/QTeisQK1QuPNXE5lvuNfQ8tQW/z1yqzb9Fu7RmcQmm0H1fjbcM+Mb1VUut4ANGRjcJ0aoIbuW4BhjF9jtetJ745RBEkxMzkrpXm+jSHb6BB3vyXlBm+qqsu9fi/iMqekeaEaoAbKVPq7UYYRB15Z4K6ELdGG3HM8O2gW9/amLU+70y
X-Forefront-Antispam-Report: 	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(376002)(136003)(39860400002)(451199021)(36840700001)(40470700004)(46966006)(5660300002)(8676002)(8936002)(426003)(336012)(83380400001)(2616005)(36860700001)(47076005)(82310400005)(107886003)(16526019)(186003)(26005)(1076003)(82740400003)(7636003)(356005)(40460700003)(54906003)(478600001)(6666004)(7696005)(40480700001)(41300700001)(316002)(70206006)(70586007)(6916009)(4326008)(36756003)(2906002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2023 10:06:58.5003
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ffa0932-b70b-4243-3b39-08db55f54934
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: 	DM6NAM11FT101.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8794
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230516_030703_389241_9B9E7781 
X-CRM114-Status: GOOD (  11.16  )
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

Insated of duplicating the code for dhchap_secret & dhchap_ctrl_secret,
define a macro to register device attribute to create device attribute
that will also define store and show helpers.

Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
---
 drivers/nvme/host/sysfs.c | 66 +++++++++++++++------------------------
 1 file changed, 25 insertions(+), 41 deletions(-)

diff --git a/drivers/nvme/host/sysfs.c b/drivers/nvme/host/sysfs.c
index 515baf8d6402..e0a2a041e595 100644
--- a/drivers/nvme/host/sysfs.c
+++ b/drivers/nvme/host/sysfs.c
@@ -407,17 +407,6 @@ static ssize_t dctype_show(struct device *dev,
 static DEVICE_ATTR_RO(dctype);
 
 #ifdef CONFIG_NVME_AUTH
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
 static ssize_t nvme_dhchap_secret_store_common(struct nvme_ctrl *ctrl,
 		const char *buf, size_t count, bool ctrl_secret)
 {
@@ -472,37 +461,32 @@ static ssize_t nvme_dhchap_secret_store_common(struct nvme_ctrl *ctrl,
 	return count;
 }
 
+#define NVME_AUTH_DEVICE_ATTR(NAME, cs)					\
+static ssize_t nvme_ctrl_##NAME##_show(struct device *dev,		\
+		struct device_attribute *attr, char *buf)		\
+{									\
+	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);			\
+	struct nvmf_ctrl_options *opts = ctrl->opts;			\
+									\
+	if (!opts->NAME)						\
+		return sysfs_emit(buf, "none\n");			\
+	return sysfs_emit(buf, "%s\n", opts->NAME);			\
+}									\
+									\
+static ssize_t nvme_ctrl_##NAME##_store(struct device *dev,		\
+		struct device_attribute *attr, const char *buf,		\
+		size_t count)						\
+{									\
+	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);			\
+									\
+	return nvme_dhchap_secret_store_common(ctrl, buf, count, cs);	\
+}									\
+									\
+static DEVICE_ATTR(NAME, S_IRUGO | S_IWUSR,				\
+	nvme_ctrl_##NAME##_show, nvme_ctrl_##NAME##_store);		\
 
-static ssize_t nvme_ctrl_dhchap_secret_store(struct device *dev,
-		struct device_attribute *attr, const char *buf, size_t count)
-{
-	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
-
-	return nvme_dhchap_secret_store_common(ctrl, buf, count, false);
-}
-
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
-	return nvme_dhchap_secret_store_common(ctrl, buf, count, false);
-}
-
-static DEVICE_ATTR(dhchap_ctrl_secret, S_IRUGO | S_IWUSR,
-	nvme_ctrl_dhchap_ctrl_secret_show, nvme_ctrl_dhchap_ctrl_secret_store);
+NVME_AUTH_DEVICE_ATTR(dhchap_secret, false);
+NVME_AUTH_DEVICE_ATTR(dhchap_ctrl_secret, true);
 #endif
 
 static struct attribute *nvme_dev_attrs[] = {
-- 
2.40.0


