Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DDC3C4828F
	for <linux-nvme@archiver.kernel.org>; Thu,  8 Feb 2024 06:25:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qsBBnXak6TsGE5XI5S2WbLPz1CCh/0kXGtMd70PXn14=; b=n/SxqxQuTAXKGateQbvPGe9Etg
	a5K9FerFCF9d68l0YtT9NOkkjIdSYeqWX8nhx0CUqbq5ZHKMXOwUzRSBRpwYj6I2txH8OvW72ytgB
	mJ5aJUB1EPaqbbboYl8Q1TcG5LZ0vWx/1Pv8EYVXISx5gHMu77wpsSQY1pxdVzCinRVyuaVGx/nXa
	Mckh8HtaPEtGGw2cn4BOPC7Ti+ULT6dMlz8VXqPOZ0fqRYSAHDq6d4Sz2+LbCfGnKdwsX00wA3LvK
	lkVj8VCIoc5TfodZrbekNSPypAPuawpHBhhkCVj92WrgvGJXmSrtlG3HMUANzXXxqSsXEMF/wgRq2
	4f63DGbw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rXxqV-0000000CnJu-2mcq;
	Thu, 08 Feb 2024 06:25:15 +0000
Received: from mail-dm6nam10on2062a.outbound.protection.outlook.com ([2a01:111:f400:7e88::62a] helo=NAM10-DM6-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rXxqT-0000000CnI6-0SZQ
	for linux-nvme@lists.infradead.org;
	Thu, 08 Feb 2024 06:25:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SmyS3GryefHh4iAJ6XPfYsV4qci4rhurnK2hEC+aYtNdW3KDepx2N6VSGsAhh4VB0fkpedtRdJCuTu2MtMyNYjILvjv0FoAp/4qTNCey+8XFsjdYzuQC4q4yyHb2lRzI/DH4NFhZMCwu7YWexzy4uDcw60jHdCZrKmB2jLSRvnKmFuAoUdlkm9/qPuNEX74N/Uo5jkNxELi6b/x+8wrJVaRrDPgmMBcb2c/n05xAHqNE5UlXpdhmVDejuwxssUXXwykxI6xNYy54yOY6OauEgPrT3tv9mD73dZ1n034T5eUF7INDHAO8H4zhp7mIaf/1U7D0gDMlCqdxhK6g4PKjyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qsBBnXak6TsGE5XI5S2WbLPz1CCh/0kXGtMd70PXn14=;
 b=aU9GjwZumntRRWgNwsXYytQrXFxJ4P/TYx0h5yP+Lx8IXlk1ecxP39YJi2YzKdlQ4UosDTmQV3z9yAzFdz+fJErhS5OF2svgpOQ6e7UNB7My2JCQhCCHfQ7vGs1CKZ/5mvo9TzHOLhdmqUI5q0+hm6O0ojc20rNVnIvjHIx/lR9WrebPUC998A6dtwGMVlkoNXZ/dBgNJwzFw1WlXB8lBCBsu69gEfHeSgGVh4pDATirWqt8uYDURQs27P0qPWf0lhJUTOMulhZoGdKvAMpKyFQdi2ulY6+Bvzzh9CjSVMpFapeta5Ph9G3cozARZbcAYtpYYsoWIgdqequkUUa5wA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=suse.de smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qsBBnXak6TsGE5XI5S2WbLPz1CCh/0kXGtMd70PXn14=;
 b=rr6StPJMt1SL26B0vooxxE1BdKF+krweEOioEOHbN/SvLL+yXlC4ItOT6PmQNNH5GD8k17Rg/O4WsKGqvOD/7dpXakkhfuzc9DwZlarKbvLjuLQEeJvy64nqIx6/RJvHl0h2otHgOQcjAaJLFEGwtBufBzaL50HLI69mnqHEGs6hVp5m01p/YzCTyAQxpnLy4LKdac6dAQMN+yD+TYnW2/2fvELwrjaSOZkXJuFk188mAomG2kw0+m+BNDleJC6LJWIdUqVqMhMAca0w8vNYycKVLvhekaIHTZ03MX78SyyfzuTbS5AYWPCmbAe0ItAxRulZDZwUHYDIy8m+5lqvWw==
Received: from CH5PR02CA0020.namprd02.prod.outlook.com (2603:10b6:610:1ed::25)
 by MN2PR12MB4080.namprd12.prod.outlook.com (2603:10b6:208:1d9::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.14; Thu, 8 Feb
 2024 06:25:01 +0000
Received: from CH2PEPF0000009C.namprd02.prod.outlook.com
 (2603:10b6:610:1ed:cafe::d1) by CH5PR02CA0020.outlook.office365.com
 (2603:10b6:610:1ed::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.38 via Frontend
 Transport; Thu, 8 Feb 2024 06:25:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH2PEPF0000009C.mail.protection.outlook.com (10.167.244.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7249.19 via Frontend Transport; Thu, 8 Feb 2024 06:25:00 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 7 Feb 2024
 22:24:46 -0800
Received: from dev.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Wed, 7 Feb
 2024 22:24:46 -0800
From: Chaitanya Kulkarni <kch@nvidia.com>
To: <hare@suse.de>
CC: <kbusch@kernel.org>, <hch@lst.de>, <sagi@grimberg.me>,
	<linux-nvme@lists.infradead.org>, Chaitanya Kulkarni <kch@nvidia.com>
Subject: [PATCH 1/3] nvme-fabrics: factor out auth code into helper
Date: Wed, 7 Feb 2024 22:24:25 -0800
Message-ID: <20240208062427.31255-2-kch@nvidia.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20240208062427.31255-1-kch@nvidia.com>
References: <20240208062427.31255-1-kch@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009C:EE_|MN2PR12MB4080:EE_
X-MS-Office365-Filtering-Correlation-Id: 98e8bf0a-b678-454c-c9f8-08dc286eadfd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: x+AVlIy9axqvsdCSaxIe5bl3ZmZf9PhsK1bfLIIC5zSbZDQKYPEddg9GEQaxCj6hfuAZ+m+sJ1SD9uG2QkEuv9QFs7YBH9arVRL1tCXdRkRBIMFQAz6qgz2Dx2tRiDl5Kvq+w25fdbm9CAXU9R7KSEKV32q7Y9VVw6lFj/kcHSkHvPlORkHxrHjMAdbkOs+gZIcDmyy7loDykboT5qqUrnCkBmZAWFoiStlIYlcOO2r3sLZXex9qiZyMqmD5B2jHmSIahCsaWoDS0J+9YHq25ezy36rdq2Wzlw1PZh2oQurfHdPN15KWo1+UGmOyW7GZOH/r485BbDXvZjGQVrfUG0q+JfkiBelmB1LCN1UkwmS7I9czQ+8LQjy4MkZnvihhu4pAKZQY6IZx9zes2XLknOoiEOLL7OoW+ReNt0jWV1QfHo9K6YRxX3J99Lk37EP4SA5SELRFcpceu33uiGBBuY5Di7EJh0e2M61TWbl97pPed7mkEZcS6iM6NGVUeaUEt7rIjRqddLUzc1Cj9MYoJCw2N/TX+mxcT9XTJqFBqEU6ub060tnPS6UHvDj6Z3zuT9Gv6ZXC9zevzkRd96Luz3YcrEOopLFq5XPoX4xKJpg=
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(346002)(136003)(376002)(396003)(39860400002)(230922051799003)(82310400011)(186009)(64100799003)(451199024)(1800799012)(46966006)(40470700004)(36840700001)(36756003)(478600001)(426003)(107886003)(70586007)(4326008)(6666004)(5660300002)(6916009)(82740400003)(41300700001)(83380400001)(336012)(26005)(7636003)(2616005)(70206006)(2906002)(7696005)(8676002)(316002)(1076003)(356005)(16526019)(8936002)(54906003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2024 06:25:00.8809
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 98e8bf0a-b678-454c-c9f8-08dc286eadfd
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000009C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4080
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240207_222513_191310_21DD57F6 
X-CRM114-Status: GOOD (  13.62  )
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

Post connect command authentication handling code is repeated into in
nvmf_connect_admin_queue() and nvmf_connect_io_queue().

Add a helper to handle post connect command authentication helper. Use
the same helper in nvmf_connect_admin_queue(). This also removes
authentication specific code from a build where authentication feature
is not configured.

Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
---
 drivers/nvme/host/auth.c    | 32 ++++++++++++++++++++++++++++++++
 drivers/nvme/host/fabrics.c | 25 +------------------------
 drivers/nvme/host/nvme.h    |  8 ++++++++
 3 files changed, 41 insertions(+), 24 deletions(-)

diff --git a/drivers/nvme/host/auth.c b/drivers/nvme/host/auth.c
index 3dce480d932e..159071462738 100644
--- a/drivers/nvme/host/auth.c
+++ b/drivers/nvme/host/auth.c
@@ -988,6 +988,38 @@ void nvme_auth_stop(struct nvme_ctrl *ctrl)
 }
 EXPORT_SYMBOL_GPL(nvme_auth_stop);
 
+u16 nvme_auth_post_connect(struct nvme_ctrl *ctrl, u16 qid, u32 result)
+{
+	int ret;
+
+	if (!(result & (NVME_CONNECT_AUTHREQ_ATR | NVME_CONNECT_AUTHREQ_ASCR)))
+		return NVME_SC_SUCCESS;
+
+	/* Secure concatenation is not implemented */
+	if (result & NVME_CONNECT_AUTHREQ_ASCR) {
+		dev_warn(ctrl->device,
+			  "qid %u: secure concatenation is not supported\n",
+			  qid);
+		return NVME_SC_AUTH_REQUIRED;
+	}
+	/* Authentication required */
+	ret = nvme_auth_negotiate(ctrl, qid);
+	if (ret) {
+		dev_warn(ctrl->device,
+			 "qid %u: authentication setup failed\n", qid);
+		return NVME_SC_AUTH_REQUIRED;
+	}
+	ret = nvme_auth_wait(ctrl, qid);
+	if (ret) {
+		dev_warn(ctrl->device, "qid %u: authentication failed\n", qid);
+		return ret;
+	}
+	if (!qid)
+		dev_info(ctrl->device, "qid 0: authenticated\n");
+	return ret;
+}
+EXPORT_SYMBOL_GPL(nvme_auth_post_connect);
+
 void nvme_auth_free(struct nvme_ctrl *ctrl)
 {
 	int i;
diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
index 373ed08e6b92..24f0d298825b 100644
--- a/drivers/nvme/host/fabrics.c
+++ b/drivers/nvme/host/fabrics.c
@@ -460,30 +460,7 @@ int nvmf_connect_admin_queue(struct nvme_ctrl *ctrl)
 
 	result = le32_to_cpu(res.u32);
 	ctrl->cntlid = result & 0xFFFF;
-	if (result & (NVME_CONNECT_AUTHREQ_ATR | NVME_CONNECT_AUTHREQ_ASCR)) {
-		/* Secure concatenation is not implemented */
-		if (result & NVME_CONNECT_AUTHREQ_ASCR) {
-			dev_warn(ctrl->device,
-				 "qid 0: secure concatenation is not supported\n");
-			ret = NVME_SC_AUTH_REQUIRED;
-			goto out_free_data;
-		}
-		/* Authentication required */
-		ret = nvme_auth_negotiate(ctrl, 0);
-		if (ret) {
-			dev_warn(ctrl->device,
-				 "qid 0: authentication setup failed\n");
-			ret = NVME_SC_AUTH_REQUIRED;
-			goto out_free_data;
-		}
-		ret = nvme_auth_wait(ctrl, 0);
-		if (ret)
-			dev_warn(ctrl->device,
-				 "qid 0: authentication failed\n");
-		else
-			dev_info(ctrl->device,
-				 "qid 0: authenticated\n");
-	}
+	ret = nvme_auth_post_connect(ctrl, 0, result);
 out_free_data:
 	kfree(data);
 	return ret;
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 1700063bc24d..bb1c9b74aa55 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -1085,6 +1085,7 @@ void nvme_auth_stop(struct nvme_ctrl *ctrl);
 int nvme_auth_negotiate(struct nvme_ctrl *ctrl, int qid);
 int nvme_auth_wait(struct nvme_ctrl *ctrl, int qid);
 void nvme_auth_free(struct nvme_ctrl *ctrl);
+u16 nvme_auth_post_connect(struct nvme_ctrl *ctrl, u16 qid, u32 result);
 #else
 static inline int nvme_auth_init_ctrl(struct nvme_ctrl *ctrl)
 {
@@ -1107,6 +1108,13 @@ static inline int nvme_auth_wait(struct nvme_ctrl *ctrl, int qid)
 	return NVME_SC_AUTH_REQUIRED;
 }
 static inline void nvme_auth_free(struct nvme_ctrl *ctrl) {};
+static inline u16 nvme_auth_post_connect(struct nvme_ctrl *ctrl, u16 qid,
+		u32 result)
+{
+	if (result & (NVME_CONNECT_AUTHREQ_ATR | NVME_CONNECT_AUTHREQ_ASCR))
+		return NVME_SC_AUTH_REQUIRED;
+	return NVME_SC_SUCCESS;
+}
 #endif
 
 u32 nvme_command_effects(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
-- 
2.40.0


