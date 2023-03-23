Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 256A5C6FD1C
	for <linux-nvme@archiver.kernel.org>; Thu, 23 Mar 2023 07:53:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+el6rZJ6bwLK2LHP5+9q+FbN286atDqVQ/8TmEvfAhw=; b=pNfhEcimE/HSjH1MfaUT5a6eNA
	pPLJ9M/b5aKisNkZUxCaZL8vsUXpzs9RCjIXj4r3WJQhWimZqWOZLmssq/1jixLw+tVeBdyxnk9SI
	7X+0JsLRIk21X3lmHwzjAiqfkMWaMpdx6f8p4cDfJJwA1dpeIWVGky6zZkV7qpa7tyjIgAPLD6K9L
	CyBNjEQrBvGwvg6BnynS8zG1oCummDApnxKsM1LQgQUn6vDQhro2myHXqsMtaNnd2RY86a8Finf7W
	1BQ++eLe1w+cqduAa7HIxn2GfM2wFsAdXyxf6RE3DMrHcpPN7QzIA8mf7xujyB8ORS/+N5Xf70Viq
	kgWiu+Pg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pfFlR-001ANn-1k;
	Thu, 23 Mar 2023 07:53:37 +0000
Received: from mail-bn8nam04on20626.outbound.protection.outlook.com ([2a01:111:f400:7e8d::626] helo=NAM04-BN8-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pfFlO-001ALp-2D
	for linux-nvme@lists.infradead.org;
	Thu, 23 Mar 2023 07:53:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E/1+25E+x/gbIYKBn1M9YLCNdsXOBgycfpuGVsh48InW0IKeZb8HDl9s3au06O2URCSGrXwYMtwLH4ukKmnZsMQ6hsQXbAxV0hlvcL7GlSnzZXdZRNHfzee723eKfOlR+lULz1JWLTVUvvaoOwUNzj3VB4EwVNxTaxPgfS9tFf79HbFNXRT8+PdmnBfRHc89yUpPzfJbJ9WT2wUrV++qY7IDgzCSfKaULOAhZErnwPKQsufym/k7BhezVbPdNaBHTjm9/7ioiz+SMmHO7tPYeqrgSNWamlHygkZLlg3s8m/w3LH/tKBIm4/AS4MOSGPArqZFdeP2HROx77lafcMPDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+el6rZJ6bwLK2LHP5+9q+FbN286atDqVQ/8TmEvfAhw=;
 b=hdTQj8QWvSiqLA9Bd+sz+wNhDyDLqDjenw4+RT3zCWtXOLugK0x6IhjadkM9WxCeadSaY0Z6GtmNz+kLsttnC+blW6iJx6nmEEpbfFjYUIZOKF8UKUOec+EVEXfLaAT7jscKKLVszl9sb8autyQAm2qJ2XKfNNK7DxRBqJ25bDHPJYx2wnrlxvIX4DT/scl3uH6slJ3bwLevJraNfxxCa2OMtR1VpV6QEM1eHl4ZLIk6w5WANEg14HTTgXPM7YFMvLTpmEQmDGU7Kw+k6rLhrzNDUSsLZ5MdPaIOXpL4AA2s5/ZGoNTc7ba0el7aVP9OmRF6WN+DoLZSaNseVWEe6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=lists.infradead.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+el6rZJ6bwLK2LHP5+9q+FbN286atDqVQ/8TmEvfAhw=;
 b=KIz8aJfXv8mLBnqWQqftfbs8P/P+B/5G2vcxPX2Y1LQFAUx+Ph6fyAa2h6svAuirYdiaFYxxsLvUvnmo84Bm920IkdKfmc+BNGllmojek0oYQi8PTR48dlcYVR/d0dcMN8QTtjY6dJvDNGeAymWNkFGoQatyJ3VB/WHyAvfvQbUZwVXoJjnqaEKTYfY9MZs6Twlp3ix0wxjTZcdP8UPyCN4uqlEMPtwn7VxsIzdaDkASFj4CmxWltXcnQ8XisP7Qlq/Rbu4EHEa83Q7DsCcora8mOsiqjDwS4pIb+pqp3uXjQGo18+mEl1N1vTFu1wMt0RoNrwrsm29eJsLhmxGF8g==
Received: from CY5PR15CA0197.namprd15.prod.outlook.com (2603:10b6:930:82::24)
 by MW4PR12MB7382.namprd12.prod.outlook.com (2603:10b6:303:22b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.38; Thu, 23 Mar
 2023 07:53:30 +0000
Received: from CY4PEPF0000C97B.namprd02.prod.outlook.com
 (2603:10b6:930:82:cafe::a9) by CY5PR15CA0197.outlook.office365.com
 (2603:10b6:930:82::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.38 via Frontend
 Transport; Thu, 23 Mar 2023 07:53:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000C97B.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6178.30 via Frontend Transport; Thu, 23 Mar 2023 07:53:30 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Thu, 23 Mar 2023
 00:53:18 -0700
Received: from zion.nvidia.com (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Thu, 23 Mar
 2023 00:53:18 -0700
From: Chaitanya Kulkarni <kch@nvidia.com>
To: <linux-nvme@lists.infradead.org>
CC: <kbusch@kernel.org>, <hch@lst.de>, <sagi@grimberg.me>, Chaitanya Kulkarni
	<kch@nvidia.com>
Subject: [PATCH 6/7] nvmet: centralize req completion for effects log
Date: Thu, 23 Mar 2023 00:52:02 -0700
Message-ID: <20230323075203.824096-7-kch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000C97B:EE_|MW4PR12MB7382:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b0367c5-8293-480c-b78d-08db2b73b1c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 	NWyWFJKFpMS8EJ6obZ43dbxnhdSW/KEVaZs+G78fWM1TzIuVmZ09qHPzURI031FyEkPRB9EixbA7yQFsfmDfoyW6XY7aSQNCD3wnfxZ1O1BEFipiP1VzM/Nqi47YZuBscCBkesq8PTRr+rCeuTfN0ksTZRZxBfHTUccs3NC2bNVl/RIcdX9akulGeSVjTi1xb5i+8eyCi05T4wG8PBFJcxKUenHAbQGQk0vGaR6GfyWgifyfCkWd+gX5wRbwU+rMdBDv+HUtUv1hJZeW8d2T4rQtTi5dggArsPiGHmtnv1ZC/ZAY4eKDvscxCNBTo8oq/x0XAgBKt+KbngxodMLiFcwMuepsJdC9g3f9dRBzBP4sEvvhsc8naewNVl3GzHOCmlThQitas8GstXZENQYqlmaCU0aEqhpgoTo54VsZUzIDCfcZ9FCOi/tNMwTy6olTsEQlkEJvnzpTJ5dF1zfkqAWwBNAfu6dSrPYWv4xhDDPte5BFP0T6MwHXCyobdbOXdbhvODB+PqgT1Ovi/Yw3zK5KEXAB271DRcRro/fJVn8adTcrD0Io43V0eF5bf+HPqRUhL164VnF3VWf/o00ADtNSx53Vm/bFy46Ba8tGw6b+EWwg+LOjaHowyihPD98mduJJxStcFQE7MYuSLYuuleNwaUz/DGtws9Ijsq5wQ6RQ4t5lebIzEktDuLxSd2ou48lQw+Whr2NTLtrq2lIGm0HR+z3dwSLMBGTgLw+HNdmQp2XuO3IlNizd19HCwy4H
X-Forefront-Antispam-Report: 	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(136003)(39860400002)(346002)(396003)(376002)(451199018)(40470700004)(36840700001)(46966006)(16526019)(82740400003)(316002)(83380400001)(2906002)(7636003)(426003)(40480700001)(6666004)(26005)(1076003)(36756003)(478600001)(107886003)(356005)(186003)(40460700003)(336012)(54906003)(5660300002)(36860700001)(41300700001)(8936002)(82310400005)(7696005)(2616005)(8676002)(4326008)(47076005)(6916009)(70206006)(70586007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2023 07:53:30.5721
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b0367c5-8293-480c-b78d-08db2b73b1c5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: 	CY4PEPF0000C97B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7382
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230323_005334_723784_82C2EF0C 
X-CRM114-Status: GOOD (  11.02  )
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

Remove nvmet_req_completion() call
nvmet_execute_get_log_cmd_effects_ns() and use the one that is in the 
caller nvmet_execute_get_log_page().

Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
---
 drivers/nvme/target/admin-cmd.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index 5e6ac85b1843..3fc187580c8d 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -190,16 +190,14 @@ static void nvmet_get_cmd_effects_zns(struct nvme_effects_log *log)
 		cpu_to_le32(NVME_CMD_EFFECTS_CSUPP);
 }
 
-static void nvmet_execute_get_log_cmd_effects_ns(struct nvmet_req *req)
+static u16 nvmet_execute_get_log_cmd_effects_ns(struct nvmet_req *req)
 {
 	struct nvme_effects_log *log;
 	u16 status = NVME_SC_SUCCESS;
 
 	log = kzalloc(sizeof(*log), GFP_KERNEL);
-	if (!log) {
-		status = NVME_SC_INTERNAL;
-		goto out;
-	}
+	if (!log)
+		return NVME_SC_INTERNAL;
 
 	switch (req->cmd->get_log_page.csi) {
 	case NVME_CSI_NVM:
@@ -221,8 +219,7 @@ static void nvmet_execute_get_log_cmd_effects_ns(struct nvmet_req *req)
 	status = nvmet_copy_to_sgl(req, 0, log, sizeof(*log));
 free:
 	kfree(log);
-out:
-	nvmet_req_complete(req, status);
+	return status;
 }
 
 static u16 nvmet_execute_get_log_changed_ns(struct nvmet_req *req)
@@ -342,7 +339,8 @@ static void nvmet_execute_get_log_page(struct nvmet_req *req)
 		status = nvmet_execute_get_log_changed_ns(req);
 		break;
 	case NVME_LOG_CMD_EFFECTS:
-		return nvmet_execute_get_log_cmd_effects_ns(req);
+		status = nvmet_execute_get_log_cmd_effects_ns(req);
+		break;
 	case NVME_LOG_ANA:
 		return nvmet_execute_get_log_page_ana(req);
 	default:
-- 
2.29.0


