Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AC1FC433F5
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Mar 2022 17:43:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nmrZqvVP/4ODfAODOdL6y0OQIi4hnXMBw1t38Iv+PgI=; b=20BjRM37MX9XxvhaiJKxtvIKCL
	c3WtCEJAkX1l0yk6+MeajOhK2WYPWC2lOVYPIjBfzJV5xSiXPMcEOZIGnUUdLE5oy0Jp0nHOWmkgP
	hCRkpm/L8NPZ/ImG5TGoNolK4yMVYKm+Z7GyMdgzZWMXPcAwQpZgrxzTHvdN8ThtrD9dtmHY9ozg9
	7zmOt6GpfppdgBHOtzJZFiKk8lemzQUCGTuFnvcdL7btOyk6tosJx9I9LRDWW4r4NuLYYP8pSb3f7
	NbKz0fGrN6YYfRnwnUVk1TAfwxwt6d+3FndV0blxGSlFmKg7AW5zNNntVYVdoSty3roDP6Q15fyhB
	nK+dGlUA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nS0Lo-009qjF-LL; Wed, 09 Mar 2022 17:43:52 +0000
Received: from mail-bn8nam12on20630.outbound.protection.outlook.com
 ([2a01:111:f400:fe5b::630]
 helo=NAM12-BN8-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nS0Lk-009qgs-Fp
 for linux-nvme@lists.infradead.org; Wed, 09 Mar 2022 17:43:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CySxL5eTZWU60w1khanCi24fVA/Y5bHYtPgm0qByH9vV6ufpyOnGgrI/l9VWPBVEqr8CC4VjMDI0Aki9QCkt8ch/vFAA9mFk7w8BFUJq8BOy9qsAbfjmDxSjO0tkOLCPzguiW9ZN1sTtU5sVsMUR2oXc4mqQyN1CxdFlhrQjAXmHaQPdOBA4zjeL2Yl3lNbSOlxenPBhFngGXw4SRtDhIjIDfhXbzDSPChNrej5IsIKvJJPWN8Zgpec7X4dvpUwImRHFy+Iu2g/IPVeVhNiiaHtZlQVaLFaj4rBvGxAHbZYXu7Zgvl1Iqqt/U568G/u0nNtJ2+8xT6TQJzwZERCfZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nmrZqvVP/4ODfAODOdL6y0OQIi4hnXMBw1t38Iv+PgI=;
 b=Akbwkf+VolMuS+jC+/gpycC60qd/3lkB5k3qu6DO5LtgMGL/wu6zcBPzmg7MyWsGgckLhLmKmUC8az7FH8fqHH07JSSBRGnzaMZcC1UZT3Pq60cJqkzTLQacYjocsyMWwNE3xrhUKYuPHkM9hj6JoulbdVSO6wU/4mc5Sd0S6w2b2o5UwHLZhxwyIT6vg/LuljuzrwdkefS33Y9iVpYu80oVLMM9GLpiZhyOXHv/97MiCRZETBoFPVVD7rLOp4ZHs8ctiucXVZLJEu5Dbe6MUrmTX5PYLBS9vDjQOgi3yobQ4DnP5ZZ7XNuMY6Zb8YbwMgxk24xHfZkuEoJrCPv6xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.234) smtp.rcpttodomain=grimberg.me smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nmrZqvVP/4ODfAODOdL6y0OQIi4hnXMBw1t38Iv+PgI=;
 b=nc5/qOC/ll3gGR2NKhfRZOxXxYgEwTiEyYdb8uxzZm9WZo/s6h3W6clyOBY+6VOJ9hGMg13BJpVlpc7NbZXkf1DtAj6j3cUAcJKFFGWauPgDHwFzqBBzmxC/YXPIkUJYJJyrnytdDPA8Dus3xncIt4PYB77lpL14kX1+U3sZqY2xBIG1V3MWigybqeHlwMdqwmP4TSIB69DY9EP0Tqf68xRL0WsEQ7Nki/cO6W0XTENg0FETK6Scj/P6Pk2H2smbofRfiBZabei6Xqy+R+Sc+P+MGkPw+Qq1LdUAkS3lYgd3n5nkXYuZuw0ZKgX1wdDyGlqbPBPzqXMrY55HP97KEg==
Received: from BN9PR03CA0328.namprd03.prod.outlook.com (2603:10b6:408:112::33)
 by DM6PR12MB4249.namprd12.prod.outlook.com (2603:10b6:5:223::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Wed, 9 Mar
 2022 17:43:40 +0000
Received: from BN8NAM11FT040.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:112:cafe::4c) by BN9PR03CA0328.outlook.office365.com
 (2603:10b6:408:112::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14 via Frontend
 Transport; Wed, 9 Mar 2022 17:43:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.234)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.234 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.234; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.234) by
 BN8NAM11FT040.mail.protection.outlook.com (10.13.177.166) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5038.14 via Frontend Transport; Wed, 9 Mar 2022 17:43:39 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by DRHQMAIL101.nvidia.com
 (10.27.9.10) with Microsoft SMTP Server (TLS) id 15.0.1497.18;
 Wed, 9 Mar 2022 17:43:39 +0000
Received: from dev.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.9; Wed, 9 Mar 2022
 09:43:38 -0800
From: Chaitanya Kulkarni <kch@nvidia.com>
To: <linux-nvme@lists.infradead.org>
CC: <hch@lst.de>, <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>
Subject: [PATCH 2/2] nvmet: open code nvmet_get_feat_kato()
Date: Wed, 9 Mar 2022 09:43:08 -0800
Message-ID: <20220309174308.41832-3-kch@nvidia.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20220309174308.41832-1-kch@nvidia.com>
References: <20220309174308.41832-1-kch@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3bff11c5-0f19-4eb4-05e9-08da01f458e3
X-MS-TrafficTypeDiagnostic: DM6PR12MB4249:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB424902B9B2C861F6C2B7ED79A30A9@DM6PR12MB4249.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RdOH2vAGiIquzlyBbLTN4gkKykiv1U7Q6u3k3D0OybDv3IyWGTamDVXc7Rij+71+ZE6AqFmt/U+WxXk8Yd4nRWi23WW1pHCE7draDVylggB6f+WJELWrCfQFCOk/8r8uQNpVBm+SRaoQa2livSPyh95isP7ntTulxYq8FKNARUC++sZZDR/laNXUQt6HlLxGfUBuhim3h1GcRSVMl5xyxKvx3Ry5tP8lVNYQrWh3dKbAAgzdGasDSt/N6eBJh5WpRxMKKcCmS2Mpl3mexGanYVnFY/drU5Ccf7xgiSm1Rx1FN5kZofHBz5lZ23mt8BCTos7aJCN8+hv5E9ovmKrMXgrW/QdxHTJlal0b5H2hDfSYqj8zND6irQUM1bow/HymNSechNVIBDmTEf5JXPeJbTSPaNwRiATX2ynowfxLEw1eymsdAYaeckE/2TQJifZqpztBSYwbVcYm9l+MziQbTnBuSuSlype9L4lVPeF6E9bmaAHV66ayAHuW+/Gwhxjru4PdWCggfXQhxu4Ol1vR2dW3/IvZL6Ft3NBp9h/rVpOObHyuiwaXY3Yazx8Dk6DPAryE4ux2rIxaUwIjFHPRnwqyGE3aLawciCaywD+930Yt8D3rum1xTwVxrfjoGYQvwp535jBXo7ob75J2vX42HuJrgWRMbArI1loPcjMi75gQ1rUMS8Ul54DKd+85v9hwNi/zCelOFGDLj+Ichhz29w==
X-Forefront-Antispam-Report: CIP:12.22.5.234; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:mail.nvidia.com; PTR:InfoNoRecords; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(1076003)(2616005)(26005)(16526019)(82310400004)(107886003)(186003)(508600001)(7696005)(40460700003)(356005)(81166007)(336012)(426003)(83380400001)(36756003)(47076005)(36860700001)(6916009)(54906003)(4326008)(2906002)(316002)(8936002)(5660300002)(70206006)(70586007)(6666004)(8676002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2022 17:43:39.9705 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bff11c5-0f19-4eb4-05e9-08da01f458e3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[12.22.5.234];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT040.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4249
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220309_094348_555490_D4BF2CDB 
X-CRM114-Status: UNSURE (   8.62  )
X-CRM114-Notice: Please train this message.
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

Just like we have open coded NVME_FEAT_HOST_ID handling, open code one
liner function nvmet_get_feat_kato() for NVME_FEAT_KATO.

Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
---
 drivers/nvme/target/admin-cmd.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index e034ced953a3..50db5dfc1929 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -889,11 +889,6 @@ static u16 nvmet_get_feat_write_protect(struct nvmet_req *req)
 	return 0;
 }
 
-void nvmet_get_feat_kato(struct nvmet_req *req)
-{
-	nvmet_set_result(req, req->sq->ctrl->kato * 1000);
-}
-
 void nvmet_execute_get_features(struct nvmet_req *req)
 {
 	struct nvmet_subsys *subsys = nvmet_req_subsys(req);
@@ -936,7 +931,7 @@ void nvmet_execute_get_features(struct nvmet_req *req)
 			(subsys->max_qid-1) | ((subsys->max_qid-1) << 16));
 		break;
 	case NVME_FEAT_KATO:
-		nvmet_get_feat_kato(req);
+		nvmet_set_result(req, req->sq->ctrl->kato * 1000);
 		break;
 	case NVME_FEAT_HOST_ID:
 		/* need 128-bit host identifier flag */
-- 
2.29.0


