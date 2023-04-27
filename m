Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 497F6C77B73
	for <linux-nvme@archiver.kernel.org>; Thu, 27 Apr 2023 08:03:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gDf2V/+S9j4YOBgG3zkx/BjRPC+HWoRGFH0ZTPC7T04=; b=LKnd+E9hSnOb6DrjeaRvYcHTZ0
	Ln/gknjR+wo7rmGcvXMgNuoSmTDEa7NG+maiH8S9HL4ZGNBEmcvH+Fc7mXV3+73PHQvP1KVN0rYAi
	y3RAeoBrMI/x0eBE8xcyz/LRjOeWN9CQZncy05iXQfUuB6GGiwwJT7EvIGIY3G/HsZODaoLZeSesZ
	YREqrOQe4B6fGm10hrtlMXFAGMSiBY2EsPt0f8WWB9AmMpFs+74U3rxIwwUSKVQIxExCfa1kHjUrQ
	gQZfvdi8spMsISNidJffvrSMgVH6aubf8PC+TpcLI2/9yXzVN/FEROqeB9z0MEHl77MXak3z7izha
	/kQ0kHbQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1prwam-005l1R-2V;
	Thu, 27 Apr 2023 08:03:04 +0000
Received: from mail-dm6nam10on20624.outbound.protection.outlook.com ([2a01:111:f400:7e88::624] helo=NAM10-DM6-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1prwah-005l07-2Z
	for linux-nvme@lists.infradead.org;
	Thu, 27 Apr 2023 08:03:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fhrz3M1KIcaYFP2yvp0pJQsYFEaZwLpTIeo/keFiDhcaotrwnjTBLL5EL52hBxlfFe7QITEvvWAHM8XmeiZEXJdO9Q23mjHRTz/+SY6Tuwv1iDost0RejcWZhUPo4MLSebJ2yafP/3EQwZL5lzSyG+gyx2iZYXoUez6YA0l/arUuUuW5Z3wsWi+RJv7eLJvqldaUaBuQoHKVya/F1pDKiHbyKPAsPE+I1ynuI87RhZmj9KOmEr4MhCoVhifrl+sBwJquPwJ4hkuE/Vwi1yoS1NIh3yi8DFmkB1m79P8nH2T4tndowwVoUzLSvYdumxoKFFiE3/f+/+XlIpogITWIiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gDf2V/+S9j4YOBgG3zkx/BjRPC+HWoRGFH0ZTPC7T04=;
 b=LKN6xF3tHD8py+VSbfzFxxyrt3HMG5SUAYANwvpChOjZMHrskIcTZBrA+BtUBPgIJyxLYvTZR+Q+MvFOYJ8pCmgk3Ieob+jmT//npNyyPmEhhEiURvkMLrw+oLnHY2X7y5G4VAqv1ll45eR/gRnt8HNkFdkBNnkWxO5omOlbH8kGX5fXMD0ZsoqAp7p+nlrea9LMbnHcFWIW/t44tcN84q5mk0ohn86S7bTtvV3Ue9TJyDw9MAxeeYnTkccv3zTK6ZqINXzwC3DVaMc1HLqB7PS3y7wRlgGD3xOx+oskdYN2OUBPouXhMielZmRmoGf5/LruAoxYI0D4Khevdpklmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=suse.de smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gDf2V/+S9j4YOBgG3zkx/BjRPC+HWoRGFH0ZTPC7T04=;
 b=cMygI9ceZ/u/rnWok9E6+uALokf4UZ68LuNBpiWEHP9CzLQeYuLwvAdly6sd/38PaNPrQN1PCXhv95Mkqh4q4mImoK3Owfiul2kad+tEVry56H5oXCgJJJs3E2S0r0hj0xh71+PPDmpMYEOyy0e2TfsSRVKt1FTXfusMQzNB6QqlhKdfCjTj5FbXlSBRavEHvm/+/KuOUwRF2QPn4HO4sfObddRMmyzx0fSzfVxQMXHQ7hi9iNzw/8mfrJaBYgzrCErAdSVG+ZoXvu1pGTid+rTMYoyl/g/+B4CagKriNC64xFtMTTqN2Cob/20OlQ+EKuwRMZ/1QMKKxiZ7zJCb9g==
Received: from BN0PR10CA0015.namprd10.prod.outlook.com (2603:10b6:408:143::33)
 by IA0PR12MB7652.namprd12.prod.outlook.com (2603:10b6:208:434::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.21; Thu, 27 Apr
 2023 08:02:55 +0000
Received: from BL02EPF0000C407.namprd05.prod.outlook.com
 (2603:10b6:408:143:cafe::82) by BN0PR10CA0015.outlook.office365.com
 (2603:10b6:408:143::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.21 via Frontend
 Transport; Thu, 27 Apr 2023 08:02:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL02EPF0000C407.mail.protection.outlook.com (10.167.241.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6340.16 via Frontend Transport; Thu, 27 Apr 2023 08:02:55 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Thu, 27 Apr 2023
 01:02:38 -0700
Received: from dev.nvidia.com (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Thu, 27 Apr
 2023 01:02:37 -0700
From: Chaitanya Kulkarni <kch@nvidia.com>
To: <hare@suse.de>
CC: <kbusch@kernel.org>, <hch@lst.de>, <sagi@grimberg.me>,
	<linux-nvme@lists.infradead.org>, Chaitanya Kulkarni <kch@nvidia.com>
Subject: [RFC PATCH 2/2] nvme-core: use macro defination to define dev attr
Date: Thu, 27 Apr 2023 01:02:07 -0700
Message-ID: <20230427080207.17249-3-kch@nvidia.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230427080207.17249-1-kch@nvidia.com>
References: <20230427080207.17249-1-kch@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.37]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0000C407:EE_|IA0PR12MB7652:EE_
X-MS-Office365-Filtering-Correlation-Id: 937d81ff-11f1-4e89-74e5-08db46f5cf14
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 	zovfmS9+Gj0arr8gDI+HBAdkyjm13sWdLzfMrwsYsIVK4xy7/oRDDY7PBSJnvQzF3EP8ak8IKriV4YfpRoz5GSOB3cvzB9A3NlszIUXinIbRTEBWZXQHnLediBxAnGdWbJgXcjEsgrdifZB1oHJ8UulRGTm7KetjwVovjgwogorKPfZWhpf3GvCVPslOU0RlQHyy2gvO4XT01kFt/YNvGOP4l7EAPtK0TbBA1fWikCDHuqCL3bFOMsFqu3b6aboCx7tnvyTh0BAN15BCgW1wnFN7WVL08SI02ImtxyRDtfANsNYqHP4LRgBIXNZZpg05WtSH6Hb4yfQ6NTvE4MidcYRwbVVV4XmHbH/awmX57dg5YMmwM4SmNDRg0VTU+FIBZU5t3bWO3b6M6mbB9Zp2MZLmEEG9ZWCikYRSEIYYWdnpgxyTlso7z8f+79F3A8jjmA+3XxG+dB5yrvtDsN6/LuGFRJaSm4J2xofeOsQVEHBTbXeU8CcYkhEGTa8Ny1/9jlw10blpCE8SDgdlsiymWxvZOT9FSyhfrx+HlbnWL/T81reLrTU5oRZDIhfthBtau7XtY0Aw7NMfNT6Ekp5lWJpsiag+/EmZ0vpVzesLNQYxIFdZX8aE65iE+Or2ejqhs4EZc54Rj8nTXY8mjZrlDF5BQF5ruNiGkG5WeXZ41xQZ3+zihSRIHgVMrvf35Ox1jBp2ztZrYkCRPM+WPvDq/rAlTP4ftkX3J42XI0KV+7nI3d9xTRUvahU6Wccyb1d5
X-Forefront-Antispam-Report: 	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(376002)(136003)(39860400002)(396003)(346002)(451199021)(36840700001)(40470700004)(46966006)(186003)(316002)(4326008)(6916009)(40460700003)(70586007)(70206006)(54906003)(107886003)(82310400005)(6666004)(7696005)(40480700001)(478600001)(16526019)(36756003)(26005)(1076003)(36860700001)(5660300002)(41300700001)(2616005)(356005)(7636003)(426003)(336012)(47076005)(2906002)(82740400003)(83380400001)(8676002)(8936002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2023 08:02:55.6026
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 937d81ff-11f1-4e89-74e5-08db46f5cf14
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: 	BL02EPF0000C407.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7652
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230427_010259_840801_8C6ADB83 
X-CRM114-Status: GOOD (  10.76  )
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
 drivers/nvme/host/core.c | 71 +++++++++++++++-------------------------
 1 file changed, 27 insertions(+), 44 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 171ae1f2197a..f619158ea2fc 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3780,17 +3780,6 @@ static DEVICE_ATTR_RO(dctype);
 
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
 		char **dhchap_secret, struct nvme_dhchap_key **orig_key,
 		const char *buf, size_t count)
@@ -3833,40 +3822,34 @@ static ssize_t nvme_dhchap_secret_store_common(struct nvme_ctrl *ctrl,
 	return count;
 }
 
-static ssize_t nvme_ctrl_dhchap_secret_store(struct device *dev,
-		struct device_attribute *attr, const char *buf, size_t count)
-{
-	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
-
-	return nvme_dhchap_secret_store_common(ctrl, &ctrl->opts->dhchap_secret,
-			&ctrl->host_key, buf, count);
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
-	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
+#define NVME_AUTH_DEVICE_ATTR(NAME)					\
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
+		struct device_attribute *attr, const char *buf, 	\
+		size_t count)						\
+{									\
+	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);			\
+									\
+	return nvme_dhchap_secret_store_common(ctrl,			\
+			&ctrl->opts->NAME,				\
+			&ctrl->host_key, buf, count);			\
+}									\
+									\
+static DEVICE_ATTR(NAME, S_IRUGO | S_IWUSR,				\
+	nvme_ctrl_##NAME##_show, nvme_ctrl_##NAME##_store);		\
 
-	return nvme_dhchap_secret_store_common(ctrl,
-			&ctrl->opts->dhchap_ctrl_secret, &ctrl->ctrl_key, buf,
-			count);
-}
-static DEVICE_ATTR(dhchap_ctrl_secret, S_IRUGO | S_IWUSR,
-	nvme_ctrl_dhchap_ctrl_secret_show, nvme_ctrl_dhchap_ctrl_secret_store);
+NVME_AUTH_DEVICE_ATTR(dhchap_secret);
+NVME_AUTH_DEVICE_ATTR(dhchap_ctrl_secret);
 #endif
 
 static struct attribute *nvme_dev_attrs[] = {
-- 
2.40.0


