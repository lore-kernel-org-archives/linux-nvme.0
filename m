Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCE00C6FD1D
	for <linux-nvme@archiver.kernel.org>; Thu, 23 Mar 2023 07:53:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=e2ihSjXJtlxMV25phpgAuQJVWsFH4vGhW5IexglJ9PM=; b=pL/0advOnyU7cc9nRu48X0NTid
	UamFufN7YAX8lk87aMbBjGxpQxOPATpj4HIBXbBNg/9LtORuTcy85GZYzJJsorVT256LDkqGCds3Q
	j3M6aLKSJpI0HrmUq3oxskPN37o1W39v0oL+RHY6oa/bnwHE4VUBjGIZJAAoLlRiMLMqauNSmHi5/
	r1uVhDhcjMREu9MP/s/yZqoijMKq6E0ZFBFV63zCleLG1UK8zsriCOP+BkKnKSYOWp1DZ6ezTtZs0
	iewyOp/9dtDYNiocNq8grG2AywvxQeeOoFUT27HpZpeyrIB+4N/9W2HM6rNt9vjTA6eWCaxLmU2J0
	/Nli4ziQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pfFku-001A8g-0l;
	Thu, 23 Mar 2023 07:53:04 +0000
Received: from mail-mw2nam10on20606.outbound.protection.outlook.com ([2a01:111:f400:7e89::606] helo=NAM10-MW2-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pfFkr-001A7Y-1c
	for linux-nvme@lists.infradead.org;
	Thu, 23 Mar 2023 07:53:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=go5TqVEIlon8u+l845+iIW1RVH28ZKolGkHrYTYNqFh/4uiSG5bn8fi0R7n+XkULK52SEqt/iNZ2zxCXwaShR8bF1zBTsLLHvenmLckgTnmygqr0ZIkeLOy3xXkeKwMFcBH3XgyzyC9O03tRLPH+05A132rGoAXv3YBgsFilZ6K1pKg/JuvZZMdD6h/j/MrKrTtJgNbj/wK6CjsJF/oqAJzMqBFCgwaMUrt684hpEhsY0nkPhB5WQ2AngRG8t91+QyjdG0ObssMoaZeYJMJmWQ0hXwkr9mKLTSTKnfyKcdAOuxmN+yiLzEGjsGhLdV3b4yfwoloGD/pYM5wHqnwwuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e2ihSjXJtlxMV25phpgAuQJVWsFH4vGhW5IexglJ9PM=;
 b=YzotdBCf4nOvsgo53kHebQr6/qzxwHhKG1YB6E/+G8MO1k/5hhiMYIt6enIYuEJKFnYCCewp+l7B8MwmPSn7p3WzrAanvqEc0Ccff5H3QA5dw0g2POCiqzKwKqCVVx0R3TvGdVfdN7xguSbfhLUdDzawf7hit8RANYJFg9Akj8T9SqasXJKfMA5pTrO0mfRlOhhPKu9oSuGNvBEZTWx2qMntIxDaR3hKdVkQxj8XMEuvVOXo7/JH6A4l0REb0iDaikmsfk14KRJQyTetX3UCL5J2ezrKkFAxHx2T23bXNI614gh3mVkTfzYmamW6T+Y0LDpvQTu87VrUxoRYhS76xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=lists.infradead.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e2ihSjXJtlxMV25phpgAuQJVWsFH4vGhW5IexglJ9PM=;
 b=IY0/PqXTOB2eee14SvuntQKnUNqbZtojuLG37Lo2C80/5QroliLYJZZfNLa/30jNqO8+zt9ybxMvneghbugGEnZegoYxOL51NelITF5Uk1GVbzrhudK6k8ayWHe/+X6HHwPekXmNPdpHwdqqgC4QVLiXhv/X1CaHGZmoZTrOuuDI5ogkcGaRFENka9cS7iiLcGerSTqqI4S0EK3+u4xe8fgQ4RrBFTIUXBVhPnMp7pd0vSt3bAXPwl55PPEEks7SgPsJxfe/vG67KINVq7BsH646RSR4muuDRfGaYa2kVHv+jXagx77Ep+Ye5iP8o11WyqsRP4bai0cPnze1OuXBhg==
Received: from CY5PR22CA0010.namprd22.prod.outlook.com (2603:10b6:930:16::25)
 by DS7PR12MB6045.namprd12.prod.outlook.com (2603:10b6:8:86::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Thu, 23 Mar
 2023 07:52:58 +0000
Received: from CY4PEPF0000C977.namprd02.prod.outlook.com
 (2603:10b6:930:16:cafe::75) by CY5PR22CA0010.outlook.office365.com
 (2603:10b6:930:16::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.38 via Frontend
 Transport; Thu, 23 Mar 2023 07:52:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000C977.mail.protection.outlook.com (10.167.241.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6178.30 via Frontend Transport; Thu, 23 Mar 2023 07:52:57 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Thu, 23 Mar 2023
 00:52:45 -0700
Received: from zion.nvidia.com (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Thu, 23 Mar
 2023 00:52:44 -0700
From: Chaitanya Kulkarni <kch@nvidia.com>
To: <linux-nvme@lists.infradead.org>
CC: <kbusch@kernel.org>, <hch@lst.de>, <sagi@grimberg.me>, Chaitanya Kulkarni
	<kch@nvidia.com>
Subject: [PATCH 3/7] nvmet: centralize req completion for smart log
Date: Thu, 23 Mar 2023 00:51:59 -0700
Message-ID: <20230323075203.824096-4-kch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000C977:EE_|DS7PR12MB6045:EE_
X-MS-Office365-Filtering-Correlation-Id: df7a36c6-3200-46f4-5aa0-08db2b739e48
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 	RU9R2/rtIzeB5wk8rb/Bl+SWgch7GmtNTSsuz7jbkCLE/kYwhTLsbvxVTglrfzIfU3GJAKBmxcVSo0qFbh4snzioA+nbhd6TCkuLz9peyE3fOh40rI0KuCTriKyc+bDx72alNdoDJ4wW7dqqqGb229uPflMERU4NllLq/7PybRqPQlp8t8REA+WWOsQe6I7+rSrTpYwl2mfXJMfIbvT6yftgO/AwXvFEdQ+XJSzg2q1e1xon0KZUF7ucILAPlU00dbKp8eCSYk8xLs78YcbVfjvkCKT7NfTMzSSbbT3gnVnMzyOHNEGzrMZZhQyzzBBRhrF637XS9yx0roG5ERrUExmBmJhCEbiKylBxee0GqkMX0JVIaWknG9FS2lN0a/ssOTrVAXw6U6v4Aw4DBX0/6XOrOoGgtC6SbyiJE98knu/KrNxll9V450rzc2YagAXhTpdyvHDcrrj/OH0Yq4l/OeuopCaCyBAiySvrVk58OjUyVnY6tngPzdz7cpVwO8M9vsbBigOhkUZALSJkVvD89YPEvbhF+8d/jeefgDo26abeQ1aFYhGAxA6hrH5WduZwJEI9R0kwih7i2Xpy+xIiFjOxJ5Mi+sT8UtfiSlCESVoqFUPzvT/EhfuGIcwPBcrWEAG1EC3SHKaMiBrerwP3hF4HWSXogN0UnXbPLTq/bdljORVxS7ssEfV7HfJrkrxLH820kjuHIh+I7cbk0+CKBj38NKi6w7ANnPiopLqxAySujwZMoTp3dn1qSIASeubM
X-Forefront-Antispam-Report: 	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(376002)(136003)(346002)(396003)(451199018)(36840700001)(46966006)(40470700004)(82740400003)(7636003)(36860700001)(5660300002)(8936002)(478600001)(26005)(1076003)(6916009)(426003)(47076005)(41300700001)(70586007)(4326008)(8676002)(70206006)(2616005)(36756003)(336012)(316002)(2906002)(356005)(82310400005)(83380400001)(7696005)(40460700003)(186003)(6666004)(16526019)(107886003)(54906003)(40480700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2023 07:52:57.8582
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: df7a36c6-3200-46f4-5aa0-08db2b739e48
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: 	CY4PEPF0000C977.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6045
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230323_005301_540478_0CD1F5FB 
X-CRM114-Status: GOOD (  11.87  )
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
nvmet_execute_get_log_page_smart() and use the one that is in the caller
nvmet_execute_get_log_page().

Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
---
 drivers/nvme/target/admin-cmd.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index 44ad1c945938..c2f510c80bbf 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -130,18 +130,18 @@ static u16 nvmet_get_smart_log_all(struct nvmet_req *req,
 	return NVME_SC_SUCCESS;
 }
 
-static void nvmet_execute_get_log_page_smart(struct nvmet_req *req)
+static u16 nvmet_execute_get_log_page_smart(struct nvmet_req *req)
 {
 	struct nvme_smart_log *log;
 	u16 status = NVME_SC_INTERNAL;
 	unsigned long flags;
 
 	if (req->transfer_len != sizeof(*log))
-		goto out;
+		return status;
 
 	log = kzalloc(sizeof(*log), GFP_KERNEL);
 	if (!log)
-		goto out;
+		return status;
 
 	if (req->cmd->get_log_page.nsid == cpu_to_le32(NVME_NSID_ALL))
 		status = nvmet_get_smart_log_all(req, log);
@@ -158,8 +158,7 @@ static void nvmet_execute_get_log_page_smart(struct nvmet_req *req)
 	status = nvmet_copy_to_sgl(req, 0, log, sizeof(*log));
 out_free_log:
 	kfree(log);
-out:
-	nvmet_req_complete(req, status);
+	return status;
 }
 
 static void nvmet_get_cmd_effects_nvm(struct nvme_effects_log *log)
@@ -329,7 +328,8 @@ static void nvmet_execute_get_log_page(struct nvmet_req *req)
 		status = nvmet_execute_get_log_page_error(req);
 		break;
 	case NVME_LOG_SMART:
-		return nvmet_execute_get_log_page_smart(req);
+		status = nvmet_execute_get_log_page_smart(req);
+		break;
 	case NVME_LOG_FW_SLOT:
 		/*
 		 * We only support a single firmware slot which always is
-- 
2.29.0


