Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F032DC6FD1F
	for <linux-nvme@archiver.kernel.org>; Thu, 23 Mar 2023 03:38:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=cpjc9J6wxXfR81I/4hYMUDWYGmWmZZOO9XZjiDGxHAU=; b=eWWcKFF2a3xYbIa1qqsYTWKpyj
	nQaHmeGwTJI0OOMjpT4gURIfdjUkjED2DTnojBdOeGdUatzXWeLIRicGmyY1cZ0ekYkoOyhtCArO0
	JnIwKNNEloRWBIcxlgTddtExARhyWv9DDisRckpjvGYDfZGOKfDQFPrtBAbYyMJpbkKcD7mT8fwtg
	CkoJ5wwdC7WKpXqoPyjX5jAy+BjKjWY8eKpl427LUi0V6Zh9QK+du7b4wKwJF/ePpX6nhtlfw2/k0
	dJtKomGOCth7gu+Pf8cTwbIJMOvNUTZtuL5sHx4Ab7vWJoCqGDUxQev6If1VKGqxTI9nGkA1YQ8HY
	Zo4PCgXw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pfBm4-000eBg-1C;
	Thu, 23 Mar 2023 03:38:00 +0000
Received: from mail-bn7nam10on20606.outbound.protection.outlook.com ([2a01:111:f400:7e8a::606] helo=NAM10-BN7-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pfBm2-000e8t-0B
	for linux-nvme@lists.infradead.org;
	Thu, 23 Mar 2023 03:37:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a3z4v0iWd74yLHFKfCve1NlhJnxYmX85ImOOMK8yiJJzeaY+kfPmKFXoxtb1By6w9JL2oaeYki6Og85Rm4YHZdxaDAeeMXiYVeeiFh+SgjzCDIfmDk4I7k77IwmKog94Zg5vPAtKyAdS53KDo8RQTUFb1A/3IXEeSLDE1jnHH1l641OTMnOp2szKxhtujtP9/0cFkxd4RaTgxBPVPu/SQBsagv9xTvPxJ1A+lZhiffd3RKZobSMY5q3Ch2/RkYWiGPchSEnuj5wa8b/Dvrgga7N1HV+cee7wxcf5YM5lj266hDjkcE0u0S2HNn38RnJcgRqvC40WTNPggua4wDbmKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cpjc9J6wxXfR81I/4hYMUDWYGmWmZZOO9XZjiDGxHAU=;
 b=Yf+oml8fYep62+QAqO+6n5X44RmpFffnuzyEDC2fh/LwQJ5sc7Sz/laAwZZqZasAjnzJ/nwMrvfmTAj6hfAOy9BrPC8z/mOhm+SBt8ykXgSiqWffcoMGEF/uOd6fHBbRY+NHx0LXwnlaNO9R7+OgLViso1URnALXevW95i2Wwimma8Z8gl2mp+Jc+4W49xAjxKQokvPsIb+QSyg3WFy3FtvLtaxfA4kwlwbrc+KkJraCNyvt8uRNX6Rnh2FyUem7HQk6soS7nzM8+bvKYskzV8FryKeJTL8UsShKROHmwQxc7ATNXrGm26qiN9seLhegosYVbPjuptLHXcj6OXvrhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=lists.infradead.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cpjc9J6wxXfR81I/4hYMUDWYGmWmZZOO9XZjiDGxHAU=;
 b=HDlx6XTpTeuWTGdYm/bCZceanLBoX3QRPWE9ZOsgiNHUd7ByFqI2nrH3BxUJ9/DV5l+EE2LsH0hBRTwImxrWT99QqRZ6PBMykkncjNoDgB6vwfa1TEa6vPVKwS9bMowpVp1mdvNmOVAzvVoqCHa0LA5DO0pDBw4hP/B+Qo1VCcEA64/xnx2cSGolIXK0edrtC5tCRQQm6uH3oN+WVXeuRQ8KXG9avsI/qTzNcN1h22TY+gGdWeqD0Jd516Q7oBlozuqu5J9DMo73p4cbkj9sYkt6PDwinZt05SCoMHi97xG1UEWq3cbrOne5rs8n5+FNXnYvn02u2OnPHAL+g/2MVA==
Received: from DS7PR05CA0043.namprd05.prod.outlook.com (2603:10b6:8:2f::22) by
 SJ1PR12MB6220.namprd12.prod.outlook.com (2603:10b6:a03:455::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.38; Thu, 23 Mar
 2023 03:37:52 +0000
Received: from DM6NAM11FT005.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:2f:cafe::18) by DS7PR05CA0043.outlook.office365.com
 (2603:10b6:8:2f::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.17 via Frontend
 Transport; Thu, 23 Mar 2023 03:37:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DM6NAM11FT005.mail.protection.outlook.com (10.13.172.238) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6222.17 via Frontend Transport; Thu, 23 Mar 2023 03:37:51 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Wed, 22 Mar 2023
 20:37:50 -0700
Received: from zion.nvidia.com (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Wed, 22 Mar
 2023 20:37:50 -0700
From: Chaitanya Kulkarni <kch@nvidia.com>
To: <linux-nvme@lists.infradead.org>
CC: <kbusch@kernel.org>, <hch@lst.de>, <sagi@grimberg.me>, <hare@suse.de>,
	Chaitanya Kulkarni <kch@nvidia.com>
Subject: [PATCH 6/9] nvme-core: open code nvme_delete_ctrl_sync()
Date: Wed, 22 Mar 2023 20:36:33 -0700
Message-ID: <20230323033636.812758-7-kch@nvidia.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230323033636.812758-1-kch@nvidia.com>
References: <20230323033636.812758-1-kch@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.37]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT005:EE_|SJ1PR12MB6220:EE_
X-MS-Office365-Filtering-Correlation-Id: ab697214-0887-4e49-0d62-08db2b4ffb02
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 	Wr+lzeW4IOPIeoy6BexWCj1xw3SZ739J5SB/rQ0Qxhs3esRvteN5zihEqt6TnB3URxsq3iUEQYxrpvLN6T05UBOLXut9vJif9Mz0CP91OKhihapUU9FDoJ9RYbVngycAYlazxkf7gsQXexaREZy+kLi0a/FusKP1YZrI+YY9PJSX+FEldOjtls9GBreNIqsmZ/WCNDjRZy0bjrvRWMKGv/uHFJcG2OEACCzG+3ppXaT9gvP6oMr0ueYmv/TrnO4ixhTt/pMErUjlOZuMdvptsFPfr8pVPYDVU8HHXQUXhT0DO3dGd+Cetg6jdDFmpNRh/1gE0zkxfyGHepLXXrdNENSRkUVhRuhIS9pjo5eyRvk/HTkPFPhiaygea8jAUna0DSX7wOBrsMia48lNmwvJAJmejF48PtbX7qVzdW7uRqxxsDkh2VyQxWpFKFjLU7bYRWJi4AkjzK4ktDV9gb1j32kD1EtF2TtVLvj020AFQw1OqfzYajrfkTTQF1rsnjLoMTRcRmtYRcCpq8qbtfCXDdCOyffv14dMQkvSN1aDLSFYA2CgK+NRSPlZHX1zheG2Uk3GMZqEJpZ+mW5EcjdLsQdtsr86MrR366QaNi/ZYlM5M50F/0gyPHKyElhudnoauRuKd/6yza+Mu3+q2D9Tu5uBt3k5DCTryMWwhRcTRLAB9TxTJ/UdbYMT7hxfE1LGijmxaYL/VMijChkPIQ0N6/jtjN30LhcIPzftKJgNBpxLUV513CHjEIoXwkCHkuqA
X-Forefront-Antispam-Report: 	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(376002)(346002)(136003)(396003)(39860400002)(451199018)(46966006)(40470700004)(36840700001)(82740400003)(7636003)(8936002)(36860700001)(5660300002)(41300700001)(40480700001)(2906002)(40460700003)(356005)(478600001)(82310400005)(26005)(54906003)(1076003)(47076005)(426003)(83380400001)(36756003)(7696005)(6666004)(107886003)(70206006)(8676002)(6916009)(4326008)(16526019)(186003)(70586007)(2616005)(336012)(316002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2023 03:37:51.5121
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ab697214-0887-4e49-0d62-08db2b4ffb02
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: 	DM6NAM11FT005.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6220
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230322_203758_099566_AAB2C3A7 
X-CRM114-Status: GOOD (  12.47  )
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

There is only one caller for the nvme_delete_ctrl_sync() i.e.
nvme_sysfs_delete(). Just open code the function in the caller.

Also, add a meaningful comment since we don't have the function name to
indicate synchronous deletion of the controller.

Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
---
 drivers/nvme/host/core.c | 26 ++++++++++++--------------
 1 file changed, 12 insertions(+), 14 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 3eb2299a81fc..06dac97c5b0f 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -237,18 +237,6 @@ int nvme_delete_ctrl(struct nvme_ctrl *ctrl)
 }
 EXPORT_SYMBOL_GPL(nvme_delete_ctrl);
 
-static void nvme_delete_ctrl_sync(struct nvme_ctrl *ctrl)
-{
-	/*
-	 * Keep a reference until nvme_do_delete_ctrl() complete,
-	 * since ->delete_ctrl can free the controller.
-	 */
-	nvme_get_ctrl(ctrl);
-	if (nvme_change_ctrl_state(ctrl, NVME_CTRL_DELETING))
-		nvme_do_delete_ctrl(ctrl);
-	nvme_put_ctrl(ctrl);
-}
-
 static blk_status_t nvme_error_status(u16 status)
 {
 	switch (status & 0x7ff) {
@@ -3591,8 +3579,18 @@ static ssize_t nvme_sysfs_delete(struct device *dev,
 {
 	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
 
-	if (device_remove_file_self(dev, attr))
-		nvme_delete_ctrl_sync(ctrl);
+	if (!device_remove_file_self(dev, attr))
+		return count;
+
+	/*
+	 * Delete the controller synchronously but keep a reference until
+	 * nvme_do_delete_ctrl() complete, since ->delete_ctrl can free the
+	 * controller.
+	 */
+	nvme_get_ctrl(ctrl);
+	if (nvme_change_ctrl_state(ctrl, NVME_CTRL_DELETING))
+		nvme_do_delete_ctrl(ctrl);
+	nvme_put_ctrl(ctrl);
 	return count;
 }
 static DEVICE_ATTR(delete_controller, S_IWUSR, NULL, nvme_sysfs_delete);
-- 
2.29.0


