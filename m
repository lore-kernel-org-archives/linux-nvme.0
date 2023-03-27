Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AB4EC76195
	for <linux-nvme@archiver.kernel.org>; Mon, 27 Mar 2023 06:05:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=tMACI+ZrNkdef3dkIvbx6weDef7bGitvzEao5zHauFo=; b=KJ/EEHb5zIaQ7X3OTIHG9TJfL+
	KqjHx6AzR+GDuC0nprTPCNczelXW/+45AKK3pRf8dy4YH5Xutxw9P2UeEHYSMDPL/+ZJ1Hb6bUJfG
	HZF4p4v8ZGQTbGrWxIJsBf0jVnHs3pY8Ij9SEF41Y4MRuK5eqYwwq6Zm5XessiDOL+MAun6wpNXiD
	qZAwLlXAJFBu74fV5RwMFXQTFT5g6GHO11FMdQjgDvc7SKAqWIB12k1vA2nFQ71Wp4HSBS/k3Dp5y
	tXb6W3A8j24cxFThAVK4ScUUJvxn5ep3XCclNDpMCvGdEwC1yr2OikS+G3dHpjvWrOsU3tlruVr7Z
	+kqOqJrQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pgfzK-009uJK-1X;
	Mon, 27 Mar 2023 06:05:50 +0000
Received: from mail-bn8nam12on20614.outbound.protection.outlook.com ([2a01:111:f400:fe5b::614] helo=NAM12-BN8-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pgfzH-009uGc-1t
	for linux-nvme@lists.infradead.org;
	Mon, 27 Mar 2023 06:05:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GQBgY9wwm68/vP5vlKrAvP1HrCYh/Fi0cOmQQY8a0B+kAprVKv1REVz5+K2LY+YHT79/Y7PIvq/0NB8zB+VJq8L8KeUbQps5IWDep1rstZS51R86gJkQvrttPe5ovVH5U36Kjh3xmTJ4KtmJhLRNaim1FqQMktHpEeH0Ik98vBm1ggb74eec86cKlYD0CBRnIfr4nes/iqi2hu4DSxrpG/6A1+eNXf8KQBjWpBwqcbA/Z1oKCaJblpYRIkDZKLEdxLFJ/WpvBavTCf0exPSlDdwfd/O1xwg+oXbfwP5VTkVIRmJpwSYnfUkh0VrWOTYCRe8yeaq9z7PM233+UxsREw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tMACI+ZrNkdef3dkIvbx6weDef7bGitvzEao5zHauFo=;
 b=Jay0mnfC4TykBL3kfRHZGqH+dd8JkvWaiRX2HQUpXFgHqUNFkLZA5v77Tvsb2ZCeAOgmhtlY9a/bo1RksOzJ3V+S/v6CkKQ6bquHOgVBPd7AA5j86lvp7pWffLsO9moY85dSMs4BLyrvASjNAjaRThQxHnyCOy9MuiHuznNYdOgbS9tE1B5BqK2kBoNY8uGrurSU08nFdF95utVt1wrhmU3WJRee71LepopW7sLNHkwoeYGVg9OYUniuOuW4jOnCXZ6H2v6MEdxT3rvX6fi6y01t5wD7asC4h3g6t52FK86uLKQP8+tqADsdnOJ5An/ZwBUPBMSknMiczSqPr+SaDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=lists.infradead.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tMACI+ZrNkdef3dkIvbx6weDef7bGitvzEao5zHauFo=;
 b=IalBXZDwmS6bxzmww7My1AkwPDkrWX6Iqoz1rt59g/RMf08toR7Xm+cdAxbMdlMPKOhBpfYQMmvQegdHekvjWuRwvVkGJ/VAmttuwIuGeRziz/M1A5AeQP/SfNju7OrNyPp16KguzTQ34c2gobHF9ONu07+ev6IFmaL2fQNmnlQPNrTm/yl4C3Ac7MEa+bUga45yOXEjO4Bv/5DzfoKI31BQJHcrBuLhKqTmVgKu9mO0dxoQEcfBZbGezdppAbhU5c2+XS8xo7DsQfC9kpvvOTPLvVyR9dOPaoUBC9kLU6E1G2JYtLgArf7vRwLtDVrJ/fgiym7OmJHqDZzSSKdRZQ==
Received: from MN2PR19CA0026.namprd19.prod.outlook.com (2603:10b6:208:178::39)
 by DM6PR12MB4074.namprd12.prod.outlook.com (2603:10b6:5:218::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.41; Mon, 27 Mar
 2023 06:05:44 +0000
Received: from BL02EPF0000C405.namprd05.prod.outlook.com
 (2603:10b6:208:178:cafe::e2) by MN2PR19CA0026.outlook.office365.com
 (2603:10b6:208:178::39) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.41 via Frontend
 Transport; Mon, 27 Mar 2023 06:05:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL02EPF0000C405.mail.protection.outlook.com (10.167.241.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6178.30 via Frontend Transport; Mon, 27 Mar 2023 06:05:43 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Sun, 26 Mar 2023
 23:05:30 -0700
Received: from dev.nvidia.com (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Sun, 26 Mar
 2023 23:05:29 -0700
From: Chaitanya Kulkarni <kch@nvidia.com>
To: <linux-nvme@lists.infradead.org>
CC: <kbusch@kernel.org>, <hch@lst.de>, <sagi@grimberg.me>, <hare@suse.de>,
	Chaitanya Kulkarni <kch@nvidia.com>
Subject: [PATCH V2 5/8] nvme-core: open code nvme_delete_ctrl_sync()
Date: Sun, 26 Mar 2023 23:04:15 -0700
Message-ID: <20230327060418.86655-6-kch@nvidia.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20230327060418.86655-1-kch@nvidia.com>
References: <20230327060418.86655-1-kch@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.37]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0000C405:EE_|DM6PR12MB4074:EE_
X-MS-Office365-Filtering-Correlation-Id: d50357c7-07a8-479d-989d-08db2e894d14
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 	e0jIwLfx4plbRWGSyB+Z4iHXHB7E/gjUjKUv8a6I8q7Zfo/H2xYrsnFXLPskNz1youBugx2NBqMLuLPW6YMrudoDCObhrVxAslQZ3bOKuWjHl4UYcnCRu1sXulE2pEkgniz9UqeoYTi9fgc1tF6QcsFRrMMuGoMVFVM6eVhb5niP8cn3Q/g91SHREfPJNvX2sh/ghSJCuqJdoo11lihM7FyhEEq/p2xTu76PlVrBi3I2nog5IHpiZZ8tcl5q0CDta2SgMPJFEBMTmoMq2sDbRWsKaWIhrK6LcuzPupjtE+iGu2OBzfELewK/uyRIuagvdhVKZC5wSb74RQzjhxoyRt+n5aWhUENSkkgrDAhvY3GB6g8JgWAsLTYrHQlXZT0O11/cer+TPFvu0Fl7gu7mbVd1gtavfvYHeRMs9W9dQveYQ4JMFNPLvtNJRJ/V4qxitu6hP4h1CaNjoqDncxgRfWCr29kajmA/mEP+Mvc8booGgMvy92gEuI6cpKaaLA6c+xn4bEblYv6mVs3RHM0xBmqoPzLACNUYLemzYiykgQBItoX4V13pQmr9qFYkknkdZWgiPhviKFh1Ca/esvfuqN2UIo4PXphRKMywoGP6i5jakonVG1HElAx4negr/Qxy/JLZBKHoLEC0SnVGaXN35URzEaTndirtNyiMMdmAS5RAaavJLOq6EkvmVxzQCHPjk4aQpigoBV1kxN/iQBronLI4/14qZ14ABdAtFyXXez+uc/GBUtJk1uvuvVfpEO+o
X-Forefront-Antispam-Report: 	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(376002)(396003)(39860400002)(451199021)(40470700004)(46966006)(36840700001)(16526019)(186003)(107886003)(6666004)(26005)(2906002)(83380400001)(40480700001)(356005)(82310400005)(36860700001)(36756003)(82740400003)(40460700003)(336012)(7636003)(426003)(47076005)(2616005)(1076003)(54906003)(70586007)(70206006)(8936002)(7696005)(5660300002)(478600001)(6916009)(4326008)(41300700001)(8676002)(316002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2023 06:05:43.9618
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d50357c7-07a8-479d-989d-08db2e894d14
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: 	BL02EPF0000C405.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4074
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230326_230547_622786_66A3D2F7 
X-CRM114-Status: GOOD (  12.39  )
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
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/host/core.c | 26 ++++++++++++--------------
 1 file changed, 12 insertions(+), 14 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index cf9469e486ec..c4372855924d 100644
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


