Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB1B8C7EE24
	for <linux-nvme@archiver.kernel.org>; Mon,  5 Jun 2023 06:52:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=rxy0clotKkSqKt0U8byvkbvLWmkYLUdnz/KGmTVdEOw=; b=WalCNpdrIDF+wfJgjFATJ5/C0K
	fbo5iB5VigHmQnbesHjz3YaEdd2AVR9zmAVQdgwj+4EY6XG1pCpxp/kcJmAZtLoT0hEY9BFlSMaO3
	jyJZd1rhvWYhK4tFZkxFM0qolR1kPXxsQWi5INHmnYvAKGWxqPHEa1x092rNyDi5gEin+MOBMzPv4
	/s2lwjAtZX5rKF7UDWwW1zSCP4CYQ9avzVE3LUHhWiOrzc4QCRqehvSE0s5qmuUB7TiEelOkF2k0g
	ka/TbPnWaVhSUkg1xK1eFPal2CDdeLITeICyzgtJ2elTVUlDjW9ya/MtbznHTfWRauNRhz755gfAr
	wiBh5jAg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q644R-00ERje-2V;
	Mon, 05 Jun 2023 06:52:03 +0000
Received: from mail-bn7nam10on2062f.outbound.protection.outlook.com ([2a01:111:f400:7e8a::62f] helo=NAM10-BN7-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q644N-00ERhK-2v
	for linux-nvme@lists.infradead.org;
	Mon, 05 Jun 2023 06:52:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aTyR3x5nU2GjWHF2jbnksRmvDEV8fXTbiCqcklOnvVcW30x8jXGhl+mSIkXA4ZcysoAJsgXX/LaXGRyZblq6gcyg3DmnhzglY8xgcg7IRRAjk9LLHasyfmPwxogW8ShSqPAsFRGc2MuBM3IH4t+XHVX2mxlRlG+Y09K54xmFWhkLH9+bxb2hNqGiG2WMveAf8LznTgGLxIJJjzSrUKf7yL5v+kqYjncLkv37u+WVjCczpBNCPWetyVa3N6C9Knsu2hkFJoQc3yaRQlpq516hH3+evrBlQtYuki2qnpyj9WDB5NSZ8ZxVb/x4r8KSMi6hsxQtyeRBmi6ij224gavj8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rxy0clotKkSqKt0U8byvkbvLWmkYLUdnz/KGmTVdEOw=;
 b=ZvGt20sdGi2R9jvJseNMDyQ+oM6gvf13jAR5OiXE6JpoQpMPY/fN4u8+KuMW7RyTlP5Hi1cecquc/jLI+aAgAXjiiFSKBP/6woO5DWfqmTipEgacoccFxDxD8V1FGtCjIEZ8x7R2v37Ze9oVaOadKeRCE6D99Q5XCFASNZ8h/lwqVtRmeKOkeaMNNKt/95GortybwuOpwPTDbbDWDSz+Oex5PwgMZjpxvWLNvzi1m1XbV5gftyP3qWVLF5COQrriJ+rlPcB7wvNhEqC7xyVbHBtwAeXUQ3kZRdtUTkOW0b52ZmSXvBnU6UghW6LyoqT7k/GsQJvcPmPOHQooLZFIWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=suse.de smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rxy0clotKkSqKt0U8byvkbvLWmkYLUdnz/KGmTVdEOw=;
 b=AbZCYxXh0WqbK7tlmuTjYF8KSH3kL+faAUkt9hBibVzeFICoNs+ab0N7Jc/gdRXF95tus8dbke/GMR/wkIE81Q76rdA8yZnwFH2qF4dfKE4PrbZASaLwaR5xbnEvjZbW3f/RWvGeIzs77UNcU6gN4zpBO+9kNEzYjSZzlsdlt2/fPT384PludgfiZ/o+enHuEQYY7H7SkI0PGCC/6n9xx+KSKCIVjY3DNQk739v3ncY8wG9HJoAxMQyNqNcmFfgl/S/g52pulX1IeM/UoiAbqJNstIIQEjd016sze4OhFCX3O8h7lWHyMCL11rgL54qqv/EghtM0ZtcEYp6FKfnWdw==
Received: from MW4PR03CA0187.namprd03.prod.outlook.com (2603:10b6:303:b8::12)
 by DM6PR12MB4499.namprd12.prod.outlook.com (2603:10b6:5:2ab::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Mon, 5 Jun
 2023 06:51:56 +0000
Received: from CO1NAM11FT071.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b8:cafe::41) by MW4PR03CA0187.outlook.office365.com
 (2603:10b6:303:b8::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32 via Frontend
 Transport; Mon, 5 Jun 2023 06:51:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1NAM11FT071.mail.protection.outlook.com (10.13.175.56) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6455.32 via Frontend Transport; Mon, 5 Jun 2023 06:51:55 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Sun, 4 Jun 2023
 23:51:44 -0700
Received: from dev.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Sun, 4 Jun 2023
 23:51:43 -0700
From: Chaitanya Kulkarni <kch@nvidia.com>
To: <hare@suse.de>
CC: <kbusch@kernel.org>, <hch@lst.de>, <sagi@grimberg.me>,
	<linux-nvme@lists.infradead.org>, Chaitanya Kulkarni <kch@nvidia.com>
Subject: [PATCH V2 1/2] nvme: add generic helper to store secret
Date: Sun, 4 Jun 2023 23:51:24 -0700
Message-ID: <20230605065125.47563-2-kch@nvidia.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230605065125.47563-1-kch@nvidia.com>
References: <20230605065125.47563-1-kch@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT071:EE_|DM6PR12MB4499:EE_
X-MS-Office365-Filtering-Correlation-Id: 3228585d-2788-4e22-adfb-08db65915a20
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ymmT0ceETUbTDLh+OdsPwXtgGDQatB+M5FisMY2msGzV5g5O9RWb1/Hh/+bUHSfmgtCKD5CiWA0NmBHBx4jKdp2EAfHSrk/hy6tvu9I79kK1YyoeJCbKAJApYyysD0YjGCk91R/24qrerEZLS+hzt12qNbS2E7IeQ82KD4wT5WrPoQ21WCt6NWb3XCOzCqZzVeoDNcs8YKJD3MPpr05+2XDncYenjiNybt9pVLKghwxddIqDDUkCB5yafzTPDWzpV975vJUBnuH9eWp+edfQX6X0Nd8iGIiixOAncxWw4u1JtcTBCQPBetpDD6kdCrdmYj2ckSe99dRlPaQiichuhZxjSt7WQclTOFegCD5/Dr6ZNyzpAGluv9XYHVpJKJlUChziY5EmPnYsYUrdU4M5A/vgpar7ZZrgRQSGyoFPXcOPrM5z67hfMDCTsacQ+KbGIAZIRyKRx3dUe3/AiR2D2+ffZh636lLKj8zNurr1a+EzjprD3b0HPSB0FjJn9/Q1Rp0IAhmpoBzoZdZXr1w8WUeBZL0hduyH7gP5ILcjzj2tqcSBe9NR3C35xeO69Wq0BfmdpmQfIM1Eo4QUtnsE9k5DehP09IZdJ61acyuEQDItXDSoR76P3wEw0bqwu6DSS5iN2l/FK+t4FgyJvIJaf8leB/UPUb9UjyiTmED9Mv8PqeQfkozAs30f7Gth/noppBMHlIawZE/R1fzKMNE/kpK5aroH4TPxN34pKpLqi0M+aRXBA/Ps+BHFxe+SaStIe3aAHCCH7i/BlNs+Hdi7NGRlWEzSdvMv6jbHtuCWU7M=
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(396003)(39860400002)(136003)(451199021)(46966006)(40470700004)(36840700001)(54906003)(40460700003)(478600001)(5660300002)(8936002)(8676002)(36756003)(2906002)(82310400005)(4326008)(6916009)(70586007)(70206006)(316002)(82740400003)(40480700001)(7636003)(356005)(41300700001)(83380400001)(47076005)(1076003)(2616005)(26005)(186003)(16526019)(107886003)(336012)(426003)(36860700001)(7696005)(6666004)(41533002)(219293001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2023 06:51:55.8874
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3228585d-2788-4e22-adfb-08db65915a20
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT071.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4499
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230604_235159_945476_37290E37 
X-CRM114-Status: GOOD (  13.95  )
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

Refactor code to avoid duplication and improve maintainability:

Consolidate the shared code between the functions
nvme_ctrl_dhchap_secret_store() and
nvme_ctrl_dhchap_ctrl_secret_store(). This duplication not only
increases the likelihood of bugs but also requires additional effort for
maintenance and testing.

Introduce a new generic helper function called
nvme_dhchap_secret_store_common() to handle the storage of the
dhchap secret. Update nvme_ctrl_dhchap_secret_store() and
nvme_ctrl_dhchap_ctrl_secret_store() to use newly introduced helper.

Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
---
 drivers/nvme/host/sysfs.c | 96 ++++++++++++++++-----------------------
 1 file changed, 39 insertions(+), 57 deletions(-)

diff --git a/drivers/nvme/host/sysfs.c b/drivers/nvme/host/sysfs.c
index 796e1d373b7c..98becb7a7453 100644
--- a/drivers/nvme/host/sysfs.c
+++ b/drivers/nvme/host/sysfs.c
@@ -418,43 +418,53 @@ static ssize_t nvme_ctrl_dhchap_secret_show(struct device *dev,
 	return sysfs_emit(buf, "%s\n", opts->dhchap_secret);
 }
 
-static ssize_t nvme_ctrl_dhchap_secret_store(struct device *dev,
-		struct device_attribute *attr, const char *buf, size_t count)
+static ssize_t nvme_dhchap_secret_store_common(struct nvme_ctrl *ctrl,
+		const char *buf, size_t count, bool ctrl_secret)
 {
-	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
-	struct nvmf_ctrl_options *opts = ctrl->opts;
-	char *dhchap_secret;
+	struct nvme_dhchap_key **orig_key;
+	char **dhchap_secret;
+	char *new_dhchap_secret;
+
+	if (ctrl_secret) {
+		if (!ctrl->opts->dhchap_ctrl_secret)
+			return -EINVAL;
+		dhchap_secret = &ctrl->opts->dhchap_ctrl_secret;
+		orig_key = &ctrl->ctrl_key;
+	} else {
+		if (!ctrl->opts->dhchap_secret)
+			return -EINVAL;
+		dhchap_secret = &ctrl->opts->dhchap_secret;
+		orig_key = &ctrl->host_key;
+	}
 
-	if (!ctrl->opts->dhchap_secret)
-		return -EINVAL;
 	if (count < 7)
 		return -EINVAL;
 	if (memcmp(buf, "DHHC-1:", 7))
 		return -EINVAL;
 
-	dhchap_secret = kzalloc(count + 1, GFP_KERNEL);
-	if (!dhchap_secret)
+	new_dhchap_secret = kzalloc(count + 1, GFP_KERNEL);
+	if (!new_dhchap_secret)
 		return -ENOMEM;
-	memcpy(dhchap_secret, buf, count);
+	memcpy(new_dhchap_secret, buf, count);
 	nvme_auth_stop(ctrl);
-	if (strcmp(dhchap_secret, opts->dhchap_secret)) {
-		struct nvme_dhchap_key *key, *host_key;
+	if (strcmp(new_dhchap_secret, *dhchap_secret)) {
+		struct nvme_dhchap_key *new_key, *prev_key;
 		int ret;
 
-		ret = nvme_auth_generate_key(dhchap_secret, &key);
+		ret = nvme_auth_generate_key(new_dhchap_secret, &new_key);
 		if (ret) {
-			kfree(dhchap_secret);
+			kfree(new_dhchap_secret);
 			return ret;
 		}
-		kfree(opts->dhchap_secret);
-		opts->dhchap_secret = dhchap_secret;
-		host_key = ctrl->host_key;
+		kfree(*dhchap_secret);
+		*dhchap_secret = new_dhchap_secret;
+		prev_key = *orig_key;
 		mutex_lock(&ctrl->dhchap_auth_mutex);
-		ctrl->host_key = key;
+		*orig_key = new_key;
 		mutex_unlock(&ctrl->dhchap_auth_mutex);
-		nvme_auth_free_key(host_key);
+		nvme_auth_free_key(prev_key);
 	} else
-		kfree(dhchap_secret);
+		kfree(new_dhchap_secret);
 	/* Start re-authentication */
 	dev_info(ctrl->device, "re-authenticating controller\n");
 	queue_work(nvme_wq, &ctrl->dhchap_auth_work);
@@ -462,6 +472,14 @@ static ssize_t nvme_ctrl_dhchap_secret_store(struct device *dev,
 	return count;
 }
 
+static ssize_t nvme_ctrl_dhchap_secret_store(struct device *dev,
+		struct device_attribute *attr, const char *buf, size_t count)
+{
+	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
+
+	return nvme_dhchap_secret_store_common(ctrl, buf, count, false);
+}
+
 static DEVICE_ATTR(dhchap_secret, S_IRUGO | S_IWUSR,
 	nvme_ctrl_dhchap_secret_show, nvme_ctrl_dhchap_secret_store);
 
@@ -480,44 +498,8 @@ static ssize_t nvme_ctrl_dhchap_ctrl_secret_store(struct device *dev,
 		struct device_attribute *attr, const char *buf, size_t count)
 {
 	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
-	struct nvmf_ctrl_options *opts = ctrl->opts;
-	char *dhchap_secret;
 
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
-		if (ret) {
-			kfree(dhchap_secret);
-			return ret;
-		}
-		kfree(opts->dhchap_ctrl_secret);
-		opts->dhchap_ctrl_secret = dhchap_secret;
-		ctrl_key = ctrl->ctrl_key;
-		mutex_lock(&ctrl->dhchap_auth_mutex);
-		ctrl->ctrl_key = key;
-		mutex_unlock(&ctrl->dhchap_auth_mutex);
-		nvme_auth_free_key(ctrl_key);
-	} else
-		kfree(dhchap_secret);
-	/* Start re-authentication */
-	dev_info(ctrl->device, "re-authenticating controller\n");
-	queue_work(nvme_wq, &ctrl->dhchap_auth_work);
-
-	return count;
+	return nvme_dhchap_secret_store_common(ctrl, buf, count, false);
 }
 
 static DEVICE_ATTR(dhchap_ctrl_secret, S_IRUGO | S_IWUSR,
-- 
2.40.0


