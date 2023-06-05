Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96C08C7EE2A
	for <linux-nvme@archiver.kernel.org>; Mon,  5 Jun 2023 06:52:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=l0C3MBnu3YzyxEJagq3unubbVCFU7DzFbpYYQj1Oz5I=; b=B/st6bHNIUxqz3pbUd3r5ryYxL
	H7GvLXz58rjUFGswxE3h0CSE9jGWbepR5ESqQSrOAdrw5D4XkODAwvGgKE3rngLcs7STYSdfGfkHh
	GgD03QxdJg+bTNy7vJdIBKq3xnDmXgXVnLXTl5ocA01gm8/WKHSo4nW5eW5Nbk89bDsb8kHcafFP9
	bl3dmjLrSB30aK+JH7TMnGe5hD0WR5JP0PLFqv0S8G3XPZdpYBHZzNz5AYcnX4N1T40BWVc7CpQpb
	41zeZT5qBQrMz2zHoKekUYh3SYT1uk/IfWTUcYBun4G19q04zyZxhGv7N7XV17gHhebim99WZtFXZ
	uGs4ARSg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q644c-00ERo4-2T;
	Mon, 05 Jun 2023 06:52:14 +0000
Received: from mail-bn1nam02on20612.outbound.protection.outlook.com ([2a01:111:f400:7eb2::612] helo=NAM02-BN1-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q644Z-00ERmC-2L
	for linux-nvme@lists.infradead.org;
	Mon, 05 Jun 2023 06:52:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RdrWbPAvcjWvay3KFk1skF5yIA2j+ZYt1DzAR9qVyEja4ojX+6DppIyKP9ipDJFCnNyveCZj5kubrcO0Eqvv5erbgRXLoC67ZO5u/WmtojJGbyRK/46pE/dpLYP4cUHGs/KlSqJOISiYZTlGdpntbtt0vPCBPXkdEvHd51cCIfLOKBgnRG/nBaQCgU53KW1m0lrSiEAyjTip6FMuejjl9qQ2gellWP1DJaKbKeyw56itzeNRHJy2wxXmZpjy+Cx7QYv63kLZlHT7CvvlZdBwFGnOx9UFRRxiQCvh3Gb/Mv7MCyB8KMswX6af8FUrTnJLlswrIhidPs1odddxBvrPNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l0C3MBnu3YzyxEJagq3unubbVCFU7DzFbpYYQj1Oz5I=;
 b=PDlX7SgjI74Bu09/gG6PTvtjV8TUPU9sPLTK0TR2MBH4myTZTCxjYjCKUZUUcTTTWMzjsC6Cd7AJ87PrI3JNA5cAYRMoRlfcMCG4NGqyAQjMNGodIaP3tKqN0JNhVQZHNllZu0ZAkvVODYRxEgfU2SN1KipRDqO5rCy5oKrNqXPbt+BJ3B7lZk3soV+e2oZcav7VwRghjEkhu2YgoudH6CmwnObdPzKeD83Rn7cbsKcrmFpJafhD/wYuBOXLzZOpznwKBg5pOXy3KkTAnN82oJnGWG8WqdBGgiVKwwVtl96OR24EAsXt53v2ayiUz896h6IVj0WGWU4cl9OHOYyhMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=suse.de smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l0C3MBnu3YzyxEJagq3unubbVCFU7DzFbpYYQj1Oz5I=;
 b=GvGYxCaVFBJGuODwbQmRIvEnOo8vRJJrOEd3Ux8D15EwsBXLYQ8yzBXXisPc7cwtffeul/skH22f32nWthjlLp0cK56qnZK9OjZdcPQE8rceK0elmtu5NI1zn/ogn+y1EonOG1nlxF24dEz+FNne2S07RyrQ8arnErH8E5g0NdH0eOkwF9PHN34dQ5uID9KM+ruHemALhQs+x/KkFtQJCt0uz8tZ2XbDYnP3YdG0ncerCMMkw6HJyXZC9f8DuYxjwxgtzlwjkx9j9AlzD35mzsm8Mbe1KPMcIwjVvwiuhZxpqF7gmGm3rHTN0ZoP2Fawjtocv0Bcva9YAMMYGg6gOg==
Received: from MW4PR03CA0266.namprd03.prod.outlook.com (2603:10b6:303:b4::31)
 by IA1PR12MB6019.namprd12.prod.outlook.com (2603:10b6:208:3d5::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Mon, 5 Jun
 2023 06:52:05 +0000
Received: from CO1NAM11FT076.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b4:cafe::12) by MW4PR03CA0266.outlook.office365.com
 (2603:10b6:303:b4::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32 via Frontend
 Transport; Mon, 5 Jun 2023 06:52:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1NAM11FT076.mail.protection.outlook.com (10.13.174.152) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6455.23 via Frontend Transport; Mon, 5 Jun 2023 06:52:04 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Sun, 4 Jun 2023
 23:51:56 -0700
Received: from dev.nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Sun, 4 Jun 2023
 23:51:55 -0700
From: Chaitanya Kulkarni <kch@nvidia.com>
To: <hare@suse.de>
CC: <kbusch@kernel.org>, <hch@lst.de>, <sagi@grimberg.me>,
	<linux-nvme@lists.infradead.org>, Chaitanya Kulkarni <kch@nvidia.com>
Subject: [PATCH V2 2/2] nvme-core: use macro defination to define dev attr
Date: Sun, 4 Jun 2023 23:51:25 -0700
Message-ID: <20230605065125.47563-3-kch@nvidia.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230605065125.47563-1-kch@nvidia.com>
References: <20230605065125.47563-1-kch@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT076:EE_|IA1PR12MB6019:EE_
X-MS-Office365-Filtering-Correlation-Id: 38022126-9842-414a-fd4b-08db65915f8b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: weNGLwuGGVKOm3YComJv9m8lkEvQG8Tx2w+u/O/+Kprs/amj43VoOVrsfOdzL9ZYMPZZ27ci1mQirZN1luW9Ag804H7Uh7yP92eVV+FllqT9RnuQuesiPuJfJrnmrThfC4Gi3/7ufoacD6LXckzV0HReX1WGVKiTfR2u/n60zUv3IoSn9Sns4e/GfK1KesznZ1rH8KfqRD7O+bhzLG7RxwXmcY9jh44MTrhdm+QhosYkAHtX37WS9GhED0iV3vlwCxKEGuFQCA5vdrEgcdJBgeqdF6Hm7xvHsUEeJAvwu4W/6gCua4SNQ2SVYtusIkRKIgACEpQ8+pq/ueqPWQujBkuZYI/MyYFBXxv5fSW9ToREidlSQDAHcb/b2OHD1/QIJ3LudHreXUMLGENPhSieOz0Q4tHbmlkl/gvveM4ok0gD/50nj9Fv824D0+QGjxlGhICWLzQNC1K3Qehy4ub4+tjS4kZivTS6gxsozQ1PQJ7yvMcu6WiBrTrjuNPSrjTG8c6Os+UoWTR7yABXcd2falaK2PgRktHorWTpZpaN/m1gTwyohRgcybMHdT3qZzz1i9yajZwvgqdJOeaaDxWEcDXxO+kXuD5p/YKqLgFjNWTjIP9yV2k952gZ2hT5zNPPU3KOSSG7oljfXZrdoo17m6/Oa5uau/o5qZqkn3AKqZO5yk1YTH25v2Lh38EggT5Zm/96oOTMRyoebaf5ZTvMBufQvsdD8EOJWDHdlOlhfmfPWoU4L6ed+fCQ5kv1TDaP
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(376002)(346002)(396003)(136003)(451199021)(40470700004)(46966006)(36840700001)(40460700003)(83380400001)(47076005)(336012)(426003)(2906002)(2616005)(36756003)(82310400005)(356005)(82740400003)(7636003)(36860700001)(40480700001)(7696005)(316002)(41300700001)(6666004)(5660300002)(107886003)(8936002)(8676002)(54906003)(478600001)(6916009)(4326008)(70206006)(70586007)(26005)(1076003)(16526019)(186003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2023 06:52:04.9792
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 38022126-9842-414a-fd4b-08db65915f8b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT076.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6019
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230604_235211_766507_5622E663 
X-CRM114-Status: GOOD (  10.23  )
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

Note that this is not newly invented but followed the same format
preasent in block layer and nvme source code.
nvme_show_str_function/nvme_show_int_function/
nvme_subsys_show_str_function/ nullb_device_##NAME##_show/
nullb_device_##NAME##_store/LOOP_ATTR_RO

Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
---
 drivers/nvme/host/sysfs.c | 67 +++++++++++++++------------------------
 1 file changed, 25 insertions(+), 42 deletions(-)

diff --git a/drivers/nvme/host/sysfs.c b/drivers/nvme/host/sysfs.c
index 98becb7a7453..ff72bcfb0ff8 100644
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
@@ -472,38 +461,32 @@ static ssize_t nvme_dhchap_secret_store_common(struct nvme_ctrl *ctrl,
 	return count;
 }
 
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
-	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
-
-	return nvme_dhchap_secret_store_common(ctrl, buf, count, false);
-}
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
 
-static DEVICE_ATTR(dhchap_ctrl_secret, S_IRUGO | S_IWUSR,
-	nvme_ctrl_dhchap_ctrl_secret_show, nvme_ctrl_dhchap_ctrl_secret_store);
+NVME_AUTH_DEVICE_ATTR(dhchap_secret, false);
+NVME_AUTH_DEVICE_ATTR(dhchap_ctrl_secret, true);
 #endif
 
 static struct attribute *nvme_dev_attrs[] = {
-- 
2.40.0


