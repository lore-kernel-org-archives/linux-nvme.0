Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7082EC47089
	for <linux-nvme@archiver.kernel.org>; Wed, 30 Nov 2022 21:34:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=j5dSiEfZXrgF/LMgEv4I0Fn9ajmE4Ab+nBYmbzDgNsw=; b=D1Lwm6/wwbnJAymrJ/Ri3LHq/u
	N39N+ErgFIDVsLlYRxkAg1PE7ylbxvzfQFtLU68FAyicSkAuOD8cL3w1P5QRuxxrg6bLgkj/lF8SY
	NiHXBt3tZjT7P14HnjLqGcnLq/t8NaGWNcDE2s0lYrkHLfy0o69VrIUEwt4OSsPIjv2JDGwUsOoqR
	371/Gcnd2djA3UlUShxStW6uk5VXjmOnWmXi984d6Mc3nsx4hLyR/f1ErffxZrvLgsDMTSR4FbhWu
	/aDxWXLtxmlTJxPJSk7jJPrbolqPogGFv//MHbjWCcwHfrx8OKbeBzLl1NHVPqZQMgNh/+wueK003
	NVl0C2RQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p0Uih-002qbp-6t; Wed, 30 Nov 2022 21:34:19 +0000
Received: from mail-bn8nam11on20601.outbound.protection.outlook.com ([2a01:111:f400:7eae::601] helo=NAM11-BN8-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p0Uid-002qZx-DC
	for linux-nvme@lists.infradead.org; Wed, 30 Nov 2022 21:34:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nf4A/csKbjWT3O/eNn/BQstuLlg17iz72qNCgr8FN0DvGrkNQ+Klbn/uG8sMOqnoLLnKe2vvsxa9XOAjHaOeycQ+iDsdxgBeDBBp+SW11koynaQumUMMTaXf7WIlEI2FPjrkwTOHaZ0ka/zocN9lr6Lk55KlgvMVAtvJqlUBpWp+/49TpGS3SVdSVbG/MzFcKMI2aqPJTzzVj8YVN3aoQQxwGbZdHtpJoXptpIRTmA6wo5TGeIml+PszhXM6BeRFIapXM4wSfh5R3BDb5P1r/2ynT7UV2hnQjwh0+TtBQaC/ercs53i/LvZ2DCPkTuqzINPHU40eMjtlz6zCMHlk8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j5dSiEfZXrgF/LMgEv4I0Fn9ajmE4Ab+nBYmbzDgNsw=;
 b=G7s15wU4S7xJSUzTc8ONe9YY9UykcpQmcrK6zw7mdnURyVj0ZsrtPckRoyFohvWJye0u0cHhi8stqvq4eW3tPWIzZJkDpDYnu2o1JNqQZkNVh0W5Z1f+XpxxLBXX8iOcwN0+TVwiO4rP4Q+MQ9R/trQQxn0g7PunQSoyvNNDKirNiysyxgh4YNMZ7TqaQRJjgVeowGF8QnNQMm5hKzGCW67+vdjemcW7+OfIviMf+FoDc1prIwCd4BrrBxeP/b4XtjzXVuGE3hELoluNcdy3/Eyuk8PU9jLPuThu1p759dQ7N/z6MAgxV8kq+cDBjdDf90OKrcws0yT50r3ese1M9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=lists.infradead.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j5dSiEfZXrgF/LMgEv4I0Fn9ajmE4Ab+nBYmbzDgNsw=;
 b=qda6RT9MmH+/ALhPt0loA60EADSzSZFND/Nd+4x3s9fO/f3sE2kK9mOJXXiiyfdLOAOCytBmYkxiKgrycg5zxtsodUVsuzoBzp4m71N4CWLMBcTKcNh0TK4GKr1NHrIaS2pl6DwDF/aLOzE8IE1WQKG9ikCkatUoyY4oiAfP2LqWXte5PKT1yTAMeF5WtOx/i09/npp4dQ2h52TKaPuq4RXL8Z6FmER8KcFBfadAHT8LjxzYRn+T19vh7lLgxBBTr6Ao0KZNpFjUnIrLgeLfL2Wn5UmxCe5c9tiyrHrsh7QAPZKYn9kFjPGLtiijWsoBRZ4TaUmUjdJAuAPtK2MiCg==
Received: from DS7PR03CA0341.namprd03.prod.outlook.com (2603:10b6:8:55::23) by
 CY5PR12MB6035.namprd12.prod.outlook.com (2603:10b6:930:2d::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5857.21; Wed, 30 Nov 2022 21:34:09 +0000
Received: from DM6NAM11FT059.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:55:cafe::66) by DS7PR03CA0341.outlook.office365.com
 (2603:10b6:8:55::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23 via Frontend
 Transport; Wed, 30 Nov 2022 21:34:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DM6NAM11FT059.mail.protection.outlook.com (10.13.172.92) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5857.23 via Frontend Transport; Wed, 30 Nov 2022 21:34:09 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Wed, 30 Nov
 2022 13:34:01 -0800
Received: from dev.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Wed, 30 Nov
 2022 13:34:00 -0800
From: Chaitanya Kulkarni <kch@nvidia.com>
To: <linux-nvme@lists.infradead.org>
CC: <james.smart@broadcom.com>, <kbusch@kernel.org>, <hch@lst.de>,
	<sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>
Subject: [PATCH 2/2] nvme-fc: move common code into helper
Date: Wed, 30 Nov 2022 13:33:41 -0800
Message-ID: <20221130213341.9625-2-kch@nvidia.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20221130213341.9625-1-kch@nvidia.com>
References: <20221130213341.9625-1-kch@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT059:EE_|CY5PR12MB6035:EE_
X-MS-Office365-Filtering-Correlation-Id: 269460ef-c4c9-43b7-c99f-08dad31a9dc4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 	Pw1x+UMQA8KgnY54u3+U2Vh16vYb5IGb725v1gXNG+8Kohil3BhMiej9EYwycQz9o7rAj1RfPj5MPZwoXIrnRkvjVAtUTtzqrOdrmrfw+IGZyFDXxjrZsJVwCMM6qzgRWiemXRbRqUfDP4RUqgsE4J23Th28yKGfjf61o3bQmnCVieEFmEwiw/wqXjIM5aQIJhKGdZgKyBzls+uLoAtA64NCo6mZJYOoCn6wzrERZCpI54YZ5EIIH+Yt1foR5zIbnklo3MsoDSwIcgIK98vaI4rzXKBMtfzo5EPKeTumagtXfRdvWBDXINe9DoQagg/oL5BnjkdP6dtgk6JCOodLh7c954aX9CrVrKGqoJFI12wMmoRuPvzoH6qfV1MH0CfWri86370wzWhCJgrvRDiYJz3PVsayJw3J5ZhiSUEmOFnso1OAoBHcDoqaSvkHSvYtetkH95hs9EiQMxFhGKcNhIlkLP2RFHZ+BvghgwgWvYwWEetY9+M2NnjGXxUp2DDGTf/Ku1RmvVTdM/JT2ifFuJeFEVavewSdPKudcoBzjwSCp59QKDqlTw34u0UnPiCmW2LsC0sA1A/rkpAOh8wHsyP7PYmczhAyN6Bs/LaiHdt2xslegig4ZfLHgZXPuLU3JHX0BUpAasqvvFQ/DYKVCMaCQYhY7/8XxU9eHR7DCj0XXItl3tyOBMfLmurazusngVyDQ2a8LXobORRgCThiww==
X-Forefront-Antispam-Report: 	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(376002)(346002)(136003)(396003)(451199015)(40470700004)(36840700001)(46966006)(36860700001)(70586007)(7636003)(41300700001)(40460700003)(2906002)(356005)(47076005)(83380400001)(82310400005)(40480700001)(7696005)(2616005)(186003)(26005)(5660300002)(336012)(8936002)(16526019)(8676002)(4326008)(6666004)(107886003)(316002)(478600001)(1076003)(6916009)(426003)(82740400003)(70206006)(36756003)(54906003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2022 21:34:09.4470
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 269460ef-c4c9-43b7-c99f-08dad31a9dc4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: 	DM6NAM11FT059.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6035
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221130_133415_469309_939D0F6F 
X-CRM114-Status: GOOD (  10.29  )
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

Add a helper to move the duplicate code for error message
from nvme_fc_rcv_ls_req() to nvme_fc_rcv_ls_req_err_msg().

Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
---
 drivers/nvme/host/fc.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index 06bae7150087..42fa450187f8 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -1701,6 +1701,15 @@ nvme_fc_handle_ls_rqst_work(struct work_struct *work)
 	spin_unlock_irqrestore(&rport->lock, flags);
 }
 
+static
+void nvme_fc_rcv_ls_req_err_msg(struct nvme_fc_lport *lport,
+				struct fcnvme_ls_rqst_w0 *w0)
+{
+	dev_info(lport->dev, "RCV %s LS failed: No memory\n",
+		(w0->ls_cmd <= NVME_FC_LAST_LS_CMD_VALUE) ?
+			nvmefc_ls_names[w0->ls_cmd] : "");
+}
+
 /**
  * nvme_fc_rcv_ls_req - transport entry point called by an LLDD
  *                       upon the reception of a NVME LS request.
@@ -1755,10 +1764,7 @@ nvme_fc_rcv_ls_req(struct nvme_fc_remote_port *portptr,
 
 	lsop = kzalloc(sizeof(*lsop), GFP_KERNEL);
 	if (!lsop) {
-		dev_info(lport->dev,
-			"RCV %s LS failed: No memory\n",
-			(w0->ls_cmd <= NVME_FC_LAST_LS_CMD_VALUE) ?
-				nvmefc_ls_names[w0->ls_cmd] : "");
+		nvme_fc_rcv_ls_req_err_msg(lport, w0);
 		ret = -ENOMEM;
 		goto out_put;
 	}
@@ -1766,10 +1772,7 @@ nvme_fc_rcv_ls_req(struct nvme_fc_remote_port *portptr,
 	lsop->rqstbuf = kzalloc(sizeof(*lsop->rqstbuf), GFP_KERNEL);
 	lsop->rspbuf = kzalloc(sizeof(*lsop->rspbuf), GFP_KERNEL);
 	if (!lsop->rqstbuf || !lsop->rspbuf) {
-		dev_info(lport->dev,
-			"RCV %s LS failed: No memory\n",
-			(w0->ls_cmd <= NVME_FC_LAST_LS_CMD_VALUE) ?
-				nvmefc_ls_names[w0->ls_cmd] : "");
+		nvme_fc_rcv_ls_req_err_msg(lport, w0);
 		ret = -ENOMEM;
 		goto out_free;
 	}
-- 
2.29.0


