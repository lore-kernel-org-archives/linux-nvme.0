Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2348C47DAF
	for <linux-nvme@archiver.kernel.org>; Mon, 22 Jan 2024 14:58:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:CC:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=DEDlZkwP+WuAviUPfc9fD79/I5eCKF9+y/gebma7OWo=; b=ubxv+usscZvqLFeT2rvo7wiEzE
	/S5BIr5a8KW0km+01PoCSo3R9cHTacbBzZgWVVeeWNXWrk1T2/vMesdvQRl5r6AlUY1WqatDRd69O
	0fyIJv16lolJDn9gAjsUCLGfaUEQRaC7KjdnKwSOKm+GZPu8MpCNYXY1cZOwJUK+wcY76WMv2fNUJ
	QLxApVFfgliJ/Cms1lzUmWcmK2MNCmqdb7+OZru1YZfhHhnuxPx1OlrDf54gtPtqkltrt4NuE7Z07
	K42xjcNGi4VgLaHW8DaEnmX4SK/3SKqylEIPRoAzQBKxE5I2+RJOnOuDtn9Tlbzx4VXIak6JockXc
	TX4ZWP1w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rRvkZ-00CW8W-1E;
	Mon, 22 Jan 2024 14:58:11 +0000
Received: from mail-dm6nam04on2069.outbound.protection.outlook.com ([40.107.102.69] helo=NAM04-DM6-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rRvkK-00CVuI-1E
	for linux-nvme@lists.infradead.org;
	Mon, 22 Jan 2024 14:58:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GIknpQccMjr/srigPzG3EC/ZVEaHFcqAngQD/OLmyYxCGNFFAUwy41Q6drBvBlIdr8jy0gghJS69FkT4UeEY7DKNPAGaKyPiOaDVwEwj38Qe6QOKN5q3WXFYtk7LwMRBDC0uEilGkuVELilM/Iaoo6O+zlt9r9k7wrIPbDmRJB4SoQ7OHUj6R+PEXyR8JdSR1NHEHG+TrZpFEYJm6tDkVg3hhsB6PlpVAE8aIs4rHilbhuZrKm1+L+LCphjYMqmboK/ONeg55bah1APSa9H68+vtrb1acQQEUd/C93kyhBfHfOjz8pT8ZpHGhJSR8RTOu1HvWR/NYuKzv3wyZKNw1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DEDlZkwP+WuAviUPfc9fD79/I5eCKF9+y/gebma7OWo=;
 b=HtCovQSj7En6NtlGYT9AyNuWqOW7SayLvvs/kl94AYlpNa0t/6JBB7o3lenDDROPcjNoLF9sLx9k4kc7UjBrLlNRR3yKcacmJ2qsQo/LOIM/w6pHJUK0Uwg31NxbsAA5maMk2MFtLUfThGuB3G3tE/qkcGWpsrR1pe8klSWkVE7SUO8fimKdnmpTsiTV6bdFJ+wd6NpWJIo8Hr6xG1/sU6uigUhzMMywJslVD5hVn/BYGGGMK9jXaAi8HQIFk1DcRHGv+tSwfEO/3xl2LB3Bs3Bwdw8D2bbDZKPHXAdKWbhWaEpltoIrjkizU46Eutu8aT699snsjVl7S5UTUQixAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DEDlZkwP+WuAviUPfc9fD79/I5eCKF9+y/gebma7OWo=;
 b=ToValO+9sGzOwnrnMBMQLWksX5eh6Fm87gj9LCp+QKQPUXyHAbyARilUAxNzXMqWGL0VqegIWGLm6KoplH/kwpoHuIQfyrrrj7SP7PSfeI3QTuQhwTXZJ+pbreC7YB4Igzp9USzXi5Qbj42ZmuimA1p1YYW3LqBfT1rh4G0MAyufaBcy9wUZaQFVUQyOPs4krc+Kc+1eVA9aB2OC/FqP7oM6UNlvmevp7e2ml0gbPnOk2Ar7xjLlzqtye4EQ9F+EjBNngXNTHA+A6C8LeEdZKk89ED5WY5rM/iT6MqELDR6s5bkdGtX0Lj5qZ7x/P/Xx6Mhu4S5nANLxRMwXcoWwUg==
Received: from SA0PR11CA0082.namprd11.prod.outlook.com (2603:10b6:806:d2::27)
 by BL1PR12MB5270.namprd12.prod.outlook.com (2603:10b6:208:31e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.34; Mon, 22 Jan
 2024 14:57:32 +0000
Received: from SA2PEPF00001506.namprd04.prod.outlook.com
 (2603:10b6:806:d2:cafe::24) by SA0PR11CA0082.outlook.office365.com
 (2603:10b6:806:d2::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.16 via Frontend
 Transport; Mon, 22 Jan 2024 14:57:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SA2PEPF00001506.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7202.16 via Frontend Transport; Mon, 22 Jan 2024 14:57:31 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 22 Jan
 2024 06:57:05 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Mon, 22 Jan 2024 06:57:05 -0800
Received: from r-arch-stor03.mtr.labs.mlnx (10.127.8.14) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.986.41 via Frontend
 Transport; Mon, 22 Jan 2024 06:57:03 -0800
From: Max Gurtovoy <mgurtovoy@nvidia.com>
To: <kbusch@kernel.org>, <hch@lst.de>, <sagi@grimberg.me>,
	<linux-nvme@lists.infradead.org>
CC: <oren@nvidia.com>, <israelr@nvidia.com>, <dwagner@suse.de>,
	<oevron@nvidia.com>, Max Gurtovoy <mgurtovoy@nvidia.com>
Subject: [PATCH 1/8] nvme: use Independent ID-NS only for unknown cmd sets
Date: Mon, 22 Jan 2024 16:56:52 +0200
Message-ID: <20240122145659.5574-2-mgurtovoy@nvidia.com>
X-Mailer: git-send-email 2.18.1
In-Reply-To: <20240122145659.5574-1-mgurtovoy@nvidia.com>
References: <20240122145659.5574-1-mgurtovoy@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001506:EE_|BL1PR12MB5270:EE_
X-MS-Office365-Filtering-Correlation-Id: 5858e00b-8679-4f14-293d-08dc1b5a75eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: d0HL7I/UMsuTF0mhKPvWbksE0aqRkkpsMpIGVH154LUtzVBZ+ryQji623POEqQNMD93YlSb9HiJaB6SzhuCLFi/qYOv7MmnpPC7cjLgVhl8Fkjzl5mpUIsDv79kmqvHUVVh4Up3Dx/EfhKrhdkOja/BF6HDXXdIjQapVF338gik3urZjD2y7VJvE81Wr5pBwE5HhNppmJvdSzQ9GXUcQHNq7yqbpYReGcjt/oLxO9EmhR+GVC5jS6ULcv1ii/DxikzZV1Qoqe7lXNd6zN2x/VjjpBOtE9xVgOyIyQKVhM6LWXsqKeWsYd+SAcPI6KLXbcwFNHqGQnf15F6wMSf0zChi6VAe5dRRJqBLze3Y9P3DNV8wCKRSDI4FuiQOT0poI1QlXigG23x8sha21s11hOp6CrgXOSEOwVrDEQnzPC3OWVFV85igd4TF2jwyzpwMDjIz6yLLibFcpNJtIeDhOk4R9X5lmF86HTjWtZhXKuEnCsbnPuw8aDMAVNYYftUsSRbnXNOLdQ2p2uqogZGyOlyzWgnbeOdz06p07/jR76An9uOEMLZGH3vzQcXoDouWsq/29gGLIdcOQ5Nk5Pk/QIYfZJ+eIcNgcSm4aYFnR24nK6RZOTVhaYGAUI9D8/YuUvj+8/r5rDu353YzGLdo7iS3KU0VOMj+bxslgCtmAx1djL2O39e5mNiACjhRP40qyUisWfbd+sO18yV2MuvzUElCDT5ac5w/Qfz+HZRDSFtWAxCk/3t2PPQHxjEsTcUbQ
X-Forefront-Antispam-Report: CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(396003)(346002)(136003)(376002)(230922051799003)(451199024)(186009)(64100799003)(82310400011)(1800799012)(46966006)(40470700004)(36840700001)(40460700003)(40480700001)(478600001)(107886003)(336012)(426003)(1076003)(83380400001)(82740400003)(5660300002)(4326008)(47076005)(8676002)(8936002)(36860700001)(26005)(2906002)(6666004)(86362001)(36756003)(41300700001)(2616005)(54906003)(7636003)(316002)(356005)(70586007)(70206006)(110136005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2024 14:57:31.7713
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5858e00b-8679-4f14-293d-08dc1b5a75eb
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00001506.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5270
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240122_065756_449380_E5BEC67A 
X-CRM114-Status: GOOD (  14.10  )
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

According to the specification, the Admin Identify command is not
part of the Admin commands permitted to return a status code of "Admin
Command Media Not Ready" for "Controller Ready Independent of Media"
feature (represented by NVME_CAP_CRMS_CRIMS capability). Therefore, use
the legacy ID-NS also if this capability is supported by the controller.

Keep using the Independent ID-NS limited mechanism only for unknown
command sets.

Reviewed-by: Israel Rukshin <israelr@nvidia.com>
Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
---
 drivers/nvme/host/core.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 1a17616fbae0..ff18c263c62c 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3808,12 +3808,12 @@ static void nvme_scan_ns(struct nvme_ctrl *ctrl, unsigned nsid)
 	}
 
 	/*
-	 * If available try to use the Command Set Idependent Identify Namespace
-	 * data structure to find all the generic information that is needed to
-	 * set up a namespace.  If not fall back to the legacy version.
+	 * Try to use the Command Set Idependent Identify Namespace data
+	 * structure to find all the generic information that is needed to set
+	 * up a namespace only for unknown command sets. Otherwise, fall back
+	 * to the legacy version.
 	 */
-	if ((ctrl->cap & NVME_CAP_CRMS_CRIMS) ||
-	    (info.ids.csi != NVME_CSI_NVM && info.ids.csi != NVME_CSI_ZNS))
+	if (info.ids.csi != NVME_CSI_NVM && info.ids.csi != NVME_CSI_ZNS)
 		ret = nvme_ns_info_from_id_cs_indep(ctrl, &info);
 	else
 		ret = nvme_ns_info_from_identify(ctrl, &info);
-- 
2.18.1


