Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9208C7EE2C
	for <linux-nvme@archiver.kernel.org>; Tue, 16 May 2023 10:06:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=29vHSWJXQYFrudGrHU1cXK/I/HYeMMXmxrFFGcEAEf0=; b=2wl2AblPax16TI27NYzug3brkN
	OaDjMrj/6j8yHp3QDI5maHx/mFz+/5p7AYYJeWrlgy/Lr+MxQjtEHBmIHUpvHBK/PSvSxlSVkvB/3
	qYKrLw1ehkPMbuuIimb1zSTpfOT0EhSg9YdoMJLmGLI9rDbbO8WKAz3OGZWeGO5KBx6OaP6ju8tBA
	RaqsOHxFvMhRsPKLUTJgys1iFqr2k8sXEetNAkvMLLY7VpMq0f/lhB7M6AXsLCC+pnQGl7g4IfUI+
	j3KiuANiLm0qA9y8qBGCIzS9+k/jwRrg27aj7e8Bx4oRjt5a5BtXik+AbO7eEs0oAHXEyiL+xLha0
	GBhHFYWw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pyrZq-005BuU-2A;
	Tue, 16 May 2023 10:06:42 +0000
Received: from mail-dm6nam04on20620.outbound.protection.outlook.com ([2a01:111:f400:7e8b::620] helo=NAM04-DM6-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pyrZo-005BtO-0D
	for linux-nvme@lists.infradead.org;
	Tue, 16 May 2023 10:06:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AmhzY42VylwkuHjv4cLvEqk2SHJUOw/1f7NhLhLzZpylXjjZWNWJMCChN0JnbfOMHZCN26EuDIyoOl1K2bJBTu67EJMevY9KKzLPymep2qnwHKCBNBACtSA+wxmOYNa9iZ/SL4BJotlaU18jloBDIFX86BWFdyHmB/NA1Kc3WAmt3hhBDc6QqyJ7YDnp0pPxoTP+wrFjzrExFgVuXqaUW/2NgDGDgieBUYUQpod6veXhTjXcLiEy9fk+gtD3yPQ+Y19mwaG8EJghjtsP+fgYlJXt/CxVJtQsXiruEuS8U2ncgkXBE6aGVyryiKJx8KK3GJ4zbNWjsoonbIKgVKevjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=29vHSWJXQYFrudGrHU1cXK/I/HYeMMXmxrFFGcEAEf0=;
 b=iWBMsdWZwNT5TB6JSy0JUwr5M35lCOFynI1tejs57jhfJycNxzqs/L3AUTywq0vqwqQdA6X9hIZh3OqRo/4o6tFBUH7iVFMzGz7YEZnuv66gzetheIBKzJHX7+CCgXHYwUbQ1UnO4tCnwIDbvx0kKSc2qpfdqnpAEpy52MYR7480s6KDgdjz1Z/+V8BikpO03FhuhJyg2YbtjLUKfIkrjeTFAqevTWe6fYQXPwiKJhL4xB0ELCIsdDpWIu0avGK5f71IeTaNZ9sClMwPE27BrpbI6wAqqeEg/4QlVYVW95W8rpohPUCq9fSstzlb/8wMdPBcK4bqKe7Lhhv/lthEPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=suse.de smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=29vHSWJXQYFrudGrHU1cXK/I/HYeMMXmxrFFGcEAEf0=;
 b=X1X4ONB0pa6DTKAVSAuDr2zViRhz8902NY3UC9U2KSiXZHUeplkXd4ReiiuKJcpjkmNEas7CbsTDr8NhDG2SfqMoq5dZHPPwRSCD114nHR41zSaKV8lxfNHNuZPWvevdxA6jK2ayMXhvD9s8ClJ3oHSG8gHneh2hW2eAAFYHJfMyEZK9hTbPs8kaaSmA72+CUGwQzHTHCF1htuZT/gaHFa9Uqtf/f8nedWWFklD0ViRDkWe4gnB0+EPBFz4+KFUI1eaguLSTilultNdnod4qj1ygZSixwSLgOjJXMShxitzTIyC/iuAkY5RJVjtkVccqq8S6w6R5hLRSU6uQdiF+2Q==
Received: from DM5PR07CA0069.namprd07.prod.outlook.com (2603:10b6:4:ad::34) by
 SJ2PR12MB8737.namprd12.prod.outlook.com (2603:10b6:a03:545::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.33; Tue, 16 May
 2023 10:06:36 +0000
Received: from DM6NAM11FT054.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:ad:cafe::6d) by DM5PR07CA0069.outlook.office365.com
 (2603:10b6:4:ad::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.33 via Frontend
 Transport; Tue, 16 May 2023 10:06:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DM6NAM11FT054.mail.protection.outlook.com (10.13.173.95) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6411.15 via Frontend Transport; Tue, 16 May 2023 10:06:36 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Tue, 16 May 2023
 03:06:24 -0700
Received: from dev.nvidia.com (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Tue, 16 May
 2023 03:06:24 -0700
From: Chaitanya Kulkarni <kch@nvidia.com>
To: <hare@suse.de>
CC: <kbusch@kernel.org>, <hch@lst.de>, <sagi@grimberg.me>,
	<linux-nvme@lists.infradead.org>, Chaitanya Kulkarni <kch@nvidia.com>
Subject: [PATCH 1/3] nvme: add generic helper to store secret
Date: Tue, 16 May 2023 03:06:03 -0700
Message-ID: <20230516100605.53712-2-kch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DM6NAM11FT054:EE_|SJ2PR12MB8737:EE_
X-MS-Office365-Filtering-Correlation-Id: 43a66cc2-bae9-4170-45e2-08db55f53bf2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 	/sILcjxaBbw3mYf/lvbHOGOoS86eV9DFvF0GzzjlFNgdubA2cL/rjIHM5PmohvWr48cY+A1+OBrLI9wZuKpY95JqsxZtx6q4HFEKi2055jCTUa2qfvVw7503pW5f+PUCnTFsXKM77kgu/mCfuWye5QS01X9RHxFZSPCZVZTvozE/2g90IkVAKSxp2HlcVf+NKt/ha0gYMazaYULAQDz0TbZtOxDyYyBOt9I4V6UP9jJlcXwspM1DNeMH1BJHf83TOIdtZcxckVSCQEmpr5IjMmxUmEzOHmfgt/c8IsuAQbV4dDR1vcGEy+j1GHF5fuM2fbnw244laeqrRaHRvbULohxgB2bYSzZumCTcIDYcGdluoo2RZAtNkKCArjV41UY3jM2n8jPxb6aIf2PmhzstErIT+BMmkCeBlHAzm9eM+IJD7B5cbLe4mOKZ6vQ9+Pt5KqonZbyxDtxwm7/cZdP43LSCIyoXPiBDVqF8Sv3zs52dR5CW2n5fM2g1+lCmHrIg29wsDFi3nBwqyeqWyPGsfvx0jcsbO/YvsCQpzSsib7ZBaYbsbEc5ovmlMQTz27VLsBkQYuJx7BmpOPzVZ09wNz1IU9eU3SRpkJmuBUcolm8rjB21n7PuYLlEr3/cYq51cxwKhJa2+r1MY+7mIZWlI3lzZoiczbHMVsyOufvR9QdsAD5ID+3r8625YbtQJCC+N9tzpSbKMlHvMCljnCuchS61hP/ahMVJ8RJrjIJ5o+aBtmK+YCLVmVO2yJ+q5WMqE7pGpjzh24QGA2GxtVS6MWGRSqHmJL18KUQV7ha+X1A=
X-Forefront-Antispam-Report: 	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(346002)(376002)(396003)(136003)(451199021)(46966006)(40470700004)(36840700001)(40460700003)(70586007)(70206006)(6916009)(478600001)(4326008)(316002)(54906003)(7696005)(36756003)(83380400001)(47076005)(107886003)(1076003)(16526019)(2616005)(336012)(186003)(36860700001)(26005)(426003)(41300700001)(5660300002)(8936002)(2906002)(8676002)(6666004)(82310400005)(40480700001)(82740400003)(7636003)(356005)(41533002)(219293001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2023 10:06:36.2576
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 43a66cc2-bae9-4170-45e2-08db55f53bf2
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: 	DM6NAM11FT054.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8737
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230516_030640_109924_7ACFC463 
X-CRM114-Status: GOOD (  15.03  )
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
dhchap secret. This helper function will be used by both
nvme_ctrl_dhchap_secret_store() and
nvme_ctrl_dhchap_ctrl_secret_store().

Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
---
 drivers/nvme/host/sysfs.c | 59 ++++++++++++++++++++++++++-------------
 1 file changed, 39 insertions(+), 20 deletions(-)

diff --git a/drivers/nvme/host/sysfs.c b/drivers/nvme/host/sysfs.c
index 796e1d373b7c..9ce3b16f06da 100644
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
+		struct nvme_dhchap_key *new_key, *prev_host_key;
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
+		prev_host_key = *orig_key;
 		mutex_lock(&ctrl->dhchap_auth_mutex);
-		ctrl->host_key = key;
+		*orig_key = new_key;
 		mutex_unlock(&ctrl->dhchap_auth_mutex);
-		nvme_auth_free_key(host_key);
+		nvme_auth_free_key(prev_host_key);
 	} else
-		kfree(dhchap_secret);
+		kfree(new_dhchap_secret);
 	/* Start re-authentication */
 	dev_info(ctrl->device, "re-authenticating controller\n");
 	queue_work(nvme_wq, &ctrl->dhchap_auth_work);
@@ -462,6 +472,15 @@ static ssize_t nvme_ctrl_dhchap_secret_store(struct device *dev,
 	return count;
 }
 
+
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
 
-- 
2.40.0


