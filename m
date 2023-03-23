Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B789C6FD1D
	for <linux-nvme@archiver.kernel.org>; Thu, 23 Mar 2023 07:52:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qIWDgPweiupL/zwcxgO2CtN/I1V2gF9oZiecc9Jwv+U=; b=Z9INO7oKFqZvk8+asjEK1UDFjc
	jTyj+kQ2bRCIZYg51l2ujuI1OF4bMmEjBPbNJrsS4nTcwJBQp3R0aenSA9xn1ABqUDknrk6guO8NZ
	vj61DcGnaTxA3Hdbv6wplMqqhn4uLsbcfGUdVVxFdxGaFAgD7Y3Q491tOXstoZAlYctRl6rUfk6Fw
	Z6epyoVHA8nHxQXrDNJnhs2Y5m4JvuDCAMaTRDZyjHr5+pIQyyiNDq0noer5sU/hr04zBy0lqcwGz
	jpWPpy7sVYJO/daHUarKTwtsTHLvKn4Txbwh5VuT/yLW0bJqOj9wUq3oRO54R6cniwmz8Wim72j1/
	IKMq+4EA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pfFkY-001A1b-24;
	Thu, 23 Mar 2023 07:52:42 +0000
Received: from mail-mw2nam12on20609.outbound.protection.outlook.com ([2a01:111:f400:fe5a::609] helo=NAM12-MW2-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pfFkW-001A0U-0z
	for linux-nvme@lists.infradead.org;
	Thu, 23 Mar 2023 07:52:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aDdlsps6F4TIM82WO7R1Mr0r+9AY6e6m5k32D5h0Jq+xhjrlAn1xmbw9TOERhblGkLzgWn2CmpXylu+uydQkC6laZDvDQtup/Pi6j0SNiv0WXsc7e8nVsV+NuKKLIu2gJR1ss4HsaeHmEkc0p8BvCu/tk41jB66mgzgLC5Y/D3cO1sTIc83vrM2FyyU/Ifoatb6VVKZRuxekG/F+GJe1Okc1pKRmTf3rF1mVSzv825z5vXXL9ixuo/gmcTqUcLQw+JbCUe18EVbOSpWoNolM0+pUd2tpuci5muhqed7Qsr+B00Suq0pAW8GOjK38D1myAZJCWn4HQOor+nDNDvOfVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qIWDgPweiupL/zwcxgO2CtN/I1V2gF9oZiecc9Jwv+U=;
 b=KTx6vyMIR3qrcpbuxNW+iOchkygQYrBXCc28Vqn/KmIi+pev2AGIZmLI4YhIXrvhI2stnYolNtzuZ2HbBxL02KQfdB+SGnFjjTWmWZf9WDdJiuWFnM0Umi+3kq/n9ZS/oR/h8k3avUxktz43KEmYk89K8kYQQBJ8r8Ria5KSL0CQNGEoqheb0CMEeHlnzdjQKDzn47mlQa6HMjibGHdVhMxcG5mfFcfJrWdSSQXuR9v+sekgbJv8IbtE8C+wrMNR8GaogL6zc4zi1KscyrDDO3mm2XNyKFKPRg6BYCfItqTOvm0/4cdBfdjjB/z4z9sPJAPTP1coy+ZBuxlbCVp9/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=lists.infradead.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qIWDgPweiupL/zwcxgO2CtN/I1V2gF9oZiecc9Jwv+U=;
 b=bLtxN+sFRRj/KQtBy/34ieU6UyXywOwZYCPo85f6n8N1I5NZwu74clAksUsu/MtGCPglsDJB9FmeympbrAESbXlGlidFgmVuU/Ao0mJJuuVj0NreAvGZFfgfqfMmQSBFtkATvD75nKhvsVmbJ8Lynyj2GCGSCuuo+tbfYYc2hc51Gf5B+Br8vUXFaDyIT1NRmNkmPviWgkuvq74ngCBizkIYqZHNtk4ngt4ieJ4XPLflVMSe3oG9drKIMRxFgHOV5zU9KRnMg4tI7ROkxKCaWda1vy2F4IsVi1zjFpkHBhnZ/9ZYM8i57LhIxJ+VeoWWVm5UBaMwmSQAzqlNOVnR1A==
Received: from CY5PR22CA0026.namprd22.prod.outlook.com (2603:10b6:930:16::16)
 by DM4PR12MB6638.namprd12.prod.outlook.com (2603:10b6:8:b5::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6178.38; Thu, 23 Mar 2023 07:52:35 +0000
Received: from CY4PEPF0000C977.namprd02.prod.outlook.com
 (2603:10b6:930:16:cafe::ee) by CY5PR22CA0026.outlook.office365.com
 (2603:10b6:930:16::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.38 via Frontend
 Transport; Thu, 23 Mar 2023 07:52:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000C977.mail.protection.outlook.com (10.167.241.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6178.30 via Frontend Transport; Thu, 23 Mar 2023 07:52:35 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Thu, 23 Mar 2023
 00:52:23 -0700
Received: from zion.nvidia.com (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Thu, 23 Mar
 2023 00:52:22 -0700
From: Chaitanya Kulkarni <kch@nvidia.com>
To: <linux-nvme@lists.infradead.org>
CC: <kbusch@kernel.org>, <hch@lst.de>, <sagi@grimberg.me>, Chaitanya Kulkarni
	<kch@nvidia.com>
Subject: [PATCH 1/7] nvmet: prep to callers req completion for log
Date: Thu, 23 Mar 2023 00:51:57 -0700
Message-ID: <20230323075203.824096-2-kch@nvidia.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230323075203.824096-1-kch@nvidia.com>
References: <20230323075203.824096-1-kch@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.37]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000C977:EE_|DM4PR12MB6638:EE_
X-MS-Office365-Filtering-Correlation-Id: 86e8e92b-f8b9-4e5d-a058-08db2b7390d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 	L29TJ25PSxTcLOplRJEwxJaDGnul//mhh5aG1b6LUXz6mejC+pKYwXd7sMKkxB3zO9XdsInNoNQS+2O/CC2n/dIhSkt9wtP6DoriKhZZzrIRqN9aPXRmsQZlf+DZ0FLVhOFM5cZ/BYHIUu43Aqb79GQYdKxhQ7Ua7hD3DL4LHkhBcZbHJLh6cRLfZg81jGWxeUoG48ZtsgOiHdX87+f6u2jKkcD9/ecZWJIuQCQq8t0UYMvK9phJQVdoL5FcHYzemTZ45+UkTSSHFcXoD972/id9MRrrK8FKy9zNI4jAtw60CyLVJGzcXmv4MFMwYQG7ujYlK3f4L0tGMlxp10Ttxq0m+icnLxrgGoMOuN430Ic7LsFl7Ho3y/54i98g9ODT7TkUD1A/GNkSamgkiIHo8FJzeJ2Ko3mkckxTesU9Xek5kn9q5t2GifPKYmbanEOS3XkH2mJTOVwXlQofb0hHrHYCuEZZQMN6YdLdeibA5ubQ4zCPaBQt8xBXcv+jPoVyryvsWUD4N2aZclsQNH+P+PxfVMK6jVb8dbdhNPh4stSkIdnRfEoTi4JKwH6vEsFgadRhm871VSuuapi/fQr8e5tiatijqT65Reb1MT01f1j9Tw80ABZlycUhAPHP5ar2jOLE08GEKCIG5sosbvGXnMyiqVJXeT+ShSTlQ4zEztBjCpXWqGKcR+3qqf1GgOWheDXRX0RiNJUpUeAFyb6aRFGhLY+rhyqxtxwWrqgW04cT9Ttk0qN66M7avPiOS+DR
X-Forefront-Antispam-Report: 	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(346002)(136003)(39860400002)(396003)(376002)(451199018)(46966006)(36840700001)(40470700004)(70586007)(4326008)(6916009)(2616005)(70206006)(8676002)(7696005)(82310400005)(83380400001)(41300700001)(36860700001)(8936002)(107886003)(6666004)(5660300002)(36756003)(26005)(1076003)(426003)(478600001)(40480700001)(356005)(40460700003)(7636003)(82740400003)(47076005)(316002)(54906003)(186003)(16526019)(2906002)(336012);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2023 07:52:35.3115
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 86e8e92b-f8b9-4e5d-a058-08db2b7390d5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: 	CY4PEPF0000C977.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6638
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230323_005240_343769_AF3F35C0 
X-CRM114-Status: GOOD (  10.54  )
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

In order to use request completion in nvmet_execute_get_log_page()
and remove repeated calls for nvmet_req_complete() in :-
nvmet_execute_get_log_page_error()
nvmet_execute_get_log_page_smart()
nvmet_execute_get_log_page_noop()
nvmet_execute_get_log_changed_ns(),
nvmet_execute_get_log_cmd_effects_ns() 
nvmet_execute_get_log_page_ana()

add default case for swicth so we will report appropriate error and
keep the backward compatibility.

Please note that this is not a pattern and is present in the
nvmet_execute_set_feature() that save current and future repeated
calls for nvmet_req_completion().

Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
---
 drivers/nvme/target/admin-cmd.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index 39cb570f833d..45e4ba2a498e 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -319,6 +319,8 @@ static void nvmet_execute_get_log_page_ana(struct nvmet_req *req)
 
 static void nvmet_execute_get_log_page(struct nvmet_req *req)
 {
+	u16 status;
+
 	if (!nvmet_check_transfer_len(req, nvmet_get_log_page_len(req->cmd)))
 		return;
 
@@ -340,11 +342,13 @@ static void nvmet_execute_get_log_page(struct nvmet_req *req)
 		return nvmet_execute_get_log_cmd_effects_ns(req);
 	case NVME_LOG_ANA:
 		return nvmet_execute_get_log_page_ana(req);
+	default:
+		pr_debug("unhandled lid %d on qid %d\n",
+			 req->cmd->get_log_page.lid, req->sq->qid);
+		req->error_loc = offsetof(struct nvme_get_log_page_command, lid);
+		status = NVME_SC_INVALID_FIELD | NVME_SC_DNR;
 	}
-	pr_debug("unhandled lid %d on qid %d\n",
-	       req->cmd->get_log_page.lid, req->sq->qid);
-	req->error_loc = offsetof(struct nvme_get_log_page_command, lid);
-	nvmet_req_complete(req, NVME_SC_INVALID_FIELD | NVME_SC_DNR);
+	nvmet_req_complete(req, status);
 }
 
 static void nvmet_execute_identify_ctrl(struct nvmet_req *req)
-- 
2.29.0


