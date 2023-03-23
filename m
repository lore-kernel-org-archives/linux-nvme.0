Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C8FDC6FD1C
	for <linux-nvme@archiver.kernel.org>; Thu, 23 Mar 2023 07:52:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=G4ZTkudT36eqJIGY/sg69V+mO2mIDtH8PHDXDSwHYSQ=; b=fIxL/GmTO+cm1+Wx3LhIpBxs2x
	SFqPnHW2K70KZh+/EMGrXyjqMSL6dVO5bPVqq/K/z8G/Hu/S8OgLzzKtCGEa0MRszjYI1dQZXJstM
	o83FKIB3gowQ2igz2bdqu0d56jUozZfZcg38SARsJawTuAyctJYgQ/r8KI7DM4s1Ui2yYnYJ91TZU
	oXCXkc4cHSaTA2rs7qoOLqmK+hgwoR88msZ/rXo+qO5t0+rFX+Yb4WIPv/5QiT8IhDH/6A6+KzLBg
	vVbAiIzsjIvtvRARAp1flTHvTqQoRyoXkBsOf6ab4L8GbRCbVbtL/nhVlVDRSCfphMcoiBKtCVfWX
	ukWpnXaQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pfFkj-001A4x-2e;
	Thu, 23 Mar 2023 07:52:53 +0000
Received: from mail-bn8nam04on20603.outbound.protection.outlook.com ([2a01:111:f400:7e8d::603] helo=NAM04-BN8-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pfFkg-001A3W-2k
	for linux-nvme@lists.infradead.org;
	Thu, 23 Mar 2023 07:52:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lhk7XcreqokCbfLAhUOdxHLFvONgiBhND7uDDlM8nh9aY4YKMenaOzBL9Fy1vYt8SCrusrsptgowINe17Ua24hDxKyxvrDX+lqJ21bFM3h2AD2bz08X97J5I29tMeHBplzXj+KUJOnBT2xhVODrdQU5j+f9LgHbJ8ia6MR4tjJh5GNVPtM0Y9CLdmJ4BqlUWBrr6ZhYKkdiI1SuPAwcGkWCPFUUE/z0F1jE/0DLDQ252nbtBZqAWmhigq5IKhaiJiHoT6zgQ6U9l5YqDA3X4Wmql0EKXFpz2A0n9k2XhbmDQ3EauOIaf9cRazM+prG6Ei2rsRLjhC2DegwX7r81ylw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G4ZTkudT36eqJIGY/sg69V+mO2mIDtH8PHDXDSwHYSQ=;
 b=JSHc1hm+t2orABMGWeouvxxtcDvoPrvx3N2CYTJl0nxMZrPOGccXESVYxRc6kflTXFKaTWT5XV/Aao2rkbd0X89Q5RpCCic8MLERYyu/AxnTK/5sZvgl2D11nZJJtl3yNXFsJ1HHJw30gahI88LlceRfZY0et7iOvO/ETWikE+QGXUwwLq46jYvFYyzFEiI4ZElEs+VrIOY423LVruxTNvRP5GrxZv0Rh0CmMtlwyjRQnnBRF9hHfngYNglyV7haWDtuokzuJkiXAUGD+G0NU+gTQkMB9tJgoKWoL4lQNqxBSNN3fLBmIBp3WshQXZJcocE02NfM3KNEws0XKeIBaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=lists.infradead.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G4ZTkudT36eqJIGY/sg69V+mO2mIDtH8PHDXDSwHYSQ=;
 b=axBYe2Wsoo5g97AIU4HSEnZy9WRvFcIHRggRaFCgA2BPnBzrTARQnMdpx95YxxHatMr/lNe9ScRuK+q7VEnW3k6T4veIb6lw9C3hKk+QMHlBnASmYHP0InB029hno+PptFJRIvVzUbE5H6um4/BHl0OFYhtANEb5vp+XliKtLLGps+kjSR6YGLc9q5bH2AgQMQf39lyJJ0Ro3dw4dHWj8PiW0CLMaYAv3U9xftNP3fbi/+BMvLOE0lwN9NR5yBytaYPxyLGR8pGEsQge2pWjA3oOfmG0MPt7djLNqzhMKp5I8XFnpfVjgZzckph5gXRxIevFfK2MN0T1AHGjv2M35A==
Received: from CY5PR15CA0129.namprd15.prod.outlook.com (2603:10b6:930:68::29)
 by DM4PR12MB8476.namprd12.prod.outlook.com (2603:10b6:8:17e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.38; Thu, 23 Mar
 2023 07:52:47 +0000
Received: from CY4PEPF0000C976.namprd02.prod.outlook.com
 (2603:10b6:930:68:cafe::c3) by CY5PR15CA0129.outlook.office365.com
 (2603:10b6:930:68::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.38 via Frontend
 Transport; Thu, 23 Mar 2023 07:52:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000C976.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6178.30 via Frontend Transport; Thu, 23 Mar 2023 07:52:47 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Thu, 23 Mar 2023
 00:52:34 -0700
Received: from zion.nvidia.com (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Thu, 23 Mar
 2023 00:52:33 -0700
From: Chaitanya Kulkarni <kch@nvidia.com>
To: <linux-nvme@lists.infradead.org>
CC: <kbusch@kernel.org>, <hch@lst.de>, <sagi@grimberg.me>, Chaitanya Kulkarni
	<kch@nvidia.com>
Subject: [PATCH 2/7] nvmet: centralize req completion for err log
Date: Thu, 23 Mar 2023 00:51:58 -0700
Message-ID: <20230323075203.824096-3-kch@nvidia.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230323075203.824096-1-kch@nvidia.com>
References: <20230323075203.824096-1-kch@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.37]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000C976:EE_|DM4PR12MB8476:EE_
X-MS-Office365-Filtering-Correlation-Id: 3884be95-a77a-4f58-70e3-08db2b739833
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 	ub6cKwym5ZrgIsOgB+Qsfxklep736FwkkWn4n/48xgE8/L0rPAezOaWsc0TMVF0NIG27iZUUTN71aEUXtth8DVtj98BG00aBSCw0dMmGljTTYjqPCQ5LWBSxKysrNl0Dw+75Jeo1yJykyAJXzk+Yg0ORyjLwGqpUidrUpztXyDTJbVdvdugh+/kK6AY/NbCUCTpRmkdXt0hszApCl5MA6ISIp9+/PnFdKR6VmVBwzxGcqID+Po1WetvHK+nxBmGWiH6ttsdUf5ArtyRo0LfL6ckn4qACdztRp6J23CuKUNbM2RNZ5VUBf8Lf6ei9BqbMLd3YVsda1X98nBeN96z16anf05nm6GCy3TmSgxuXPsSIhnj49rSS/sygeeMAshp7ONl52rc4CWovXb4615v/TO+7QuoyqtYiQLDcVG0G58vQXE+dPN5iyUbCS8KwowVPR3yUhNC1tvX3as1Zl3k7lr9wbJGDpzwyYyvCbjm4dnO1R7nvKQGb/TF3q9o3VWz25rU3871WHa1xQNgA/p7t8mhoYoEKkVHoGdz0nx8ptwEYTrrpK8cYSI0F/0Tvg8P2gFzV7XCOLBhJaaeiJyXFJUkfLeRbnVFJf5H85TnIyVS3FeqcNDs0LbwH31i3Wy20QuFmaWGXqQwgAuQMsgtFs7hxFzp6wnOsULHMT1jBMgWyx2Si4vTGtJM/Bat2f7dyJQFf0j07YcpEOVAzS6CRiDlgvjE/VGrEIP/hrIfIUrUWRxAj4aJDJsaQ0YD6u+Ud
X-Forefront-Antispam-Report: 	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(136003)(346002)(39860400002)(376002)(396003)(451199018)(46966006)(36840700001)(40470700004)(36756003)(40460700003)(4326008)(8676002)(6916009)(70206006)(70586007)(8936002)(41300700001)(478600001)(316002)(7696005)(54906003)(5660300002)(2906002)(82740400003)(36860700001)(356005)(40480700001)(7636003)(1076003)(16526019)(26005)(107886003)(6666004)(82310400005)(83380400001)(336012)(2616005)(47076005)(186003)(426003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2023 07:52:47.6703
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3884be95-a77a-4f58-70e3-08db2b739833
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: 	CY4PEPF0000C976.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8476
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230323_005250_890142_437F96A3 
X-CRM114-Status: GOOD (  10.30  )
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

Remove nvmet_req_completion() call from
nvmet_execute_get_log_page_error() and use the one that is in the caller
nvmet_execute_get_log_page().

Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
---
 drivers/nvme/target/admin-cmd.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index 45e4ba2a498e..44ad1c945938 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -45,7 +45,7 @@ static void nvmet_execute_get_log_page_noop(struct nvmet_req *req)
 	nvmet_req_complete(req, nvmet_zero_sgl(req, 0, req->transfer_len));
 }
 
-static void nvmet_execute_get_log_page_error(struct nvmet_req *req)
+static u16 nvmet_execute_get_log_page_error(struct nvmet_req *req)
 {
 	struct nvmet_ctrl *ctrl = req->sq->ctrl;
 	unsigned long flags;
@@ -68,7 +68,7 @@ static void nvmet_execute_get_log_page_error(struct nvmet_req *req)
 		offset += sizeof(struct nvme_error_slot);
 	}
 	spin_unlock_irqrestore(&ctrl->error_lock, flags);
-	nvmet_req_complete(req, 0);
+	return NVME_SC_SUCCESS;
 }
 
 static u16 nvmet_get_smart_log_nsid(struct nvmet_req *req,
@@ -326,7 +326,8 @@ static void nvmet_execute_get_log_page(struct nvmet_req *req)
 
 	switch (req->cmd->get_log_page.lid) {
 	case NVME_LOG_ERROR:
-		return nvmet_execute_get_log_page_error(req);
+		status = nvmet_execute_get_log_page_error(req);
+		break;
 	case NVME_LOG_SMART:
 		return nvmet_execute_get_log_page_smart(req);
 	case NVME_LOG_FW_SLOT:
-- 
2.29.0


