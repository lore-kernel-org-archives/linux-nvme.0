Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60621C7EE26
	for <linux-nvme@archiver.kernel.org>; Tue, 16 May 2023 10:06:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xPebOGr2+9WzXdDeSJd8TheW6tzclTGH+ggf+2ZPEQ8=; b=brVG+PzjXdRj7Fm/OHzQ0RfEIV
	ly+ceZofCoxBAI9Kw8qWJbTtWEi3hw7TeLa0kUNXClEl0TZ9j9l507vQsZ3obyUCmI+eiGj21gRpp
	4i0o11KSc2CRBfG+MKE+x57Qnr9zyiNRiF7hP8p3Ee6nQS8AtJvJa9cX8Sb9D7SXskjCV6/ao/LDq
	9jv2J4YuMUPx1eHWggDUaFsMMElWefgtRRdpPWcuUPs2XvpSzbA80FDaMnkSKlm/HP+p73vyBi7cX
	jSVqxEJRRJ+5AIfWN5wyg4fhKN5MVSUhvkmJHCZVGyPwOYWHBIvScYqNkzXlP9Kx9h3pdE2MKAaro
	nLdFXxpg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pyra2-005C0v-37;
	Tue, 16 May 2023 10:06:54 +0000
Received: from mail-dm3nam02on20610.outbound.protection.outlook.com ([2a01:111:f400:7e83::610] helo=NAM02-DM3-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pyra0-005Bz3-24
	for linux-nvme@lists.infradead.org;
	Tue, 16 May 2023 10:06:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gX/JLi4USsJujj+o+WfNMM6Z2c/EpLf35l15fcy1yJpwf+qWwCnDa+mWdxbBzUOVx/OdjLiOZO9+rA8EZwDK97jJoUGtt4/oYdS5TKlVcc6blbHC+yWzS4+QaQ8FllDNcmwYWFYpxfjjuVfpgMp6SVxGG7g5+32sPK07Pbft8Va08L9/nT+wtPlNt9TyfssA0a4QEzCNzK6ItvGAC3s4H++w4cP/kvZtWOf1RRZOekMFEoK8RRstH5V/pCGIe8nGB+1GmfowsaElw5Ri1kLccPLU3cnnsYFxh2oRZWRceSzn7cS8zWi+GzSmOOlYAtemi26XO3Ptl1Fpd3ZnCfMB4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xPebOGr2+9WzXdDeSJd8TheW6tzclTGH+ggf+2ZPEQ8=;
 b=XeeX8nhyaGwC3EPoi53u1xmgT2FzKrzXz2RSAwfT/T4VJGKUIMcfnYFhYizQ8wVc56KEpl59Q5VKe6jPG/rg+2Io6UVxi2iQQzpqVlp5hbGlsNNK1qG4L0ZTPH03NS+6hwtkFQ+q7gT7P32FTPKRK20lFW56h6IbtHGZYYlK4IAo5OjzV9bkRPpZxi60kIIq98QuIiY9Wle6R6XRlE+KBvHN8Srptu8W5boV0kyvwUAOehoCksqyBLnw92XGRT53bdnyd1NYUipnwZc+iBhHSMN2UZaWvP2Y0N4W1saHhL79nfaM/7Ra4FoADvL0SSQ/qCSs5NLVpGl2dHE7OtAZcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=suse.de smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xPebOGr2+9WzXdDeSJd8TheW6tzclTGH+ggf+2ZPEQ8=;
 b=Zvu6FINox+BLgFBT1YcrFX5l3/YviVZZuOk6zyZKMQZng9lVGvUjZjKOxgoUAjjyVkbasmE9uOEIn6qzmLGk2NHzUW3bCpis+Pjr36fehoePT0KLUG8bTWJFQgc5IFtn47QKxLZZpDFtxvn2y9s8cjlb7SQhjaj39JDgQ5PHDJwy2oDFyTxxX7iVXSSQ0wre2aJM/q7DO2DGXgJNK3e8fpxwKFfFxwevrOzDebzgoA4Q2pLrenuab7kgquyMelHIwJg12cUV3rrHjO/8tSlV+dO55i8TyZplbysjXVcfM8AgkPxDJmHuoHx5z8GICyTdfS7yh+MhxFaWeToHnPxaWw==
Received: from BN6PR17CA0035.namprd17.prod.outlook.com (2603:10b6:405:75::24)
 by MW3PR12MB4507.namprd12.prod.outlook.com (2603:10b6:303:2c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.33; Tue, 16 May
 2023 10:06:48 +0000
Received: from BN8NAM11FT105.eop-nam11.prod.protection.outlook.com
 (2603:10b6:405:75:cafe::fa) by BN6PR17CA0035.outlook.office365.com
 (2603:10b6:405:75::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.33 via Frontend
 Transport; Tue, 16 May 2023 10:06:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN8NAM11FT105.mail.protection.outlook.com (10.13.176.183) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6411.15 via Frontend Transport; Tue, 16 May 2023 10:06:48 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Tue, 16 May 2023
 03:06:35 -0700
Received: from dev.nvidia.com (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Tue, 16 May
 2023 03:06:35 -0700
From: Chaitanya Kulkarni <kch@nvidia.com>
To: <hare@suse.de>
CC: <kbusch@kernel.org>, <hch@lst.de>, <sagi@grimberg.me>,
	<linux-nvme@lists.infradead.org>, Chaitanya Kulkarni <kch@nvidia.com>
Subject: [PATCH 2/3] nvme: use generic helper to store ctrl secret
Date: Tue, 16 May 2023 03:06:04 -0700
Message-ID: <20230516100605.53712-3-kch@nvidia.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230516100605.53712-1-kch@nvidia.com>
References: <20230516100605.53712-1-kch@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.37]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT105:EE_|MW3PR12MB4507:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a40ba13-7f57-487e-9f09-08db55f542fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 	HBjoYAZ7CpdGAO8fqrUpqmiNeXjisrdT9YKcA9K6qygm7Qzkh6NW+Y3yB32lDgEjcX98zBBf4ji+jJ5rVm/MbfhnmraSCUe+vVKr2jeneQkdyz+igmshKZPn3Eah+nkoY9aP5dH8/j1x0sr/Frtnk98zxnqPq1rBoO0aCNOeDi9ylsRkgAIlm6CdavaLW6vWimXTbJI7LrDePY7bN0Bj4BiYrMMUVuWPYyKwn7tf1ONzktuRrp8z0m7h5ZpS/lXcciLmUFmLcO7WOZNFEmKH21fm8ZlFGh9UUOb52bFqkp/gcmfVME4j1lq+FdHiSDwyTiYJUTcQgG6UJAWGfBdp8jHBTNdKRyetjjILnugr9AMNKaga2nOZYX/UlmEtFxKHwGuMVav+Nie93YYKEE/1vH+85GpZp0PPTICz+nb9oWrR+YmBq/VjshVerTKBssrqGJRKoAVMdghsBydqz4XsEuNIBu4aG+TDg2lgcRiTex6Nuaexgg4mCwZd2b3WbBtvnq/S/UDLlS/mPuKGDM0uHJgtbklM2stC/m4PKjaZ9vupfW5YNRBbVhD1Bo4Paiflqk49Qz5Dhj7SqCMLZyDatei/p4gIgfXHVHUgRuz2OHRIQT+Akj0FoYaahOkl5WWNPbqLknTx38HbgIk3xM/FrEuNVcgHXF9xmoKw69UH/fvpXN4/z5wJ3p17EpthccSeM93+Ln2i3lPGZGz0SZeNUWBwgrWrSPWK7fH/Oj06zmou0b/69npUX/OabokRYgUeSz/zf1FbTtq7cmHXIQ5/ZkrHAhcOfCiySAaUB3xhoP0=
X-Forefront-Antispam-Report: 	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(346002)(136003)(376002)(451199021)(36840700001)(40470700004)(46966006)(26005)(40460700003)(1076003)(107886003)(47076005)(83380400001)(336012)(426003)(36756003)(36860700001)(40480700001)(2616005)(7636003)(82310400005)(356005)(82740400003)(186003)(16526019)(54906003)(478600001)(2906002)(316002)(41300700001)(5660300002)(8936002)(8676002)(70586007)(4326008)(6916009)(70206006)(7696005)(6666004)(41533002)(219293001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2023 10:06:48.0357
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a40ba13-7f57-487e-9f09-08db55f542fe
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: 	BN8NAM11FT105.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4507
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230516_030652_687377_49044640 
X-CRM114-Status: GOOD (  10.62  )
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

Use generic helper to store the dhchap ctrl secret.

Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
---
 drivers/nvme/host/sysfs.c | 40 +--------------------------------------
 1 file changed, 1 insertion(+), 39 deletions(-)

diff --git a/drivers/nvme/host/sysfs.c b/drivers/nvme/host/sysfs.c
index 9ce3b16f06da..515baf8d6402 100644
--- a/drivers/nvme/host/sysfs.c
+++ b/drivers/nvme/host/sysfs.c
@@ -498,45 +498,7 @@ static ssize_t nvme_ctrl_dhchap_ctrl_secret_show(struct device *dev,
 static ssize_t nvme_ctrl_dhchap_ctrl_secret_store(struct device *dev,
 		struct device_attribute *attr, const char *buf, size_t count)
 {
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


