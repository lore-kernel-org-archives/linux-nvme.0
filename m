Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0703C433F5
	for <linux-nvme@archiver.kernel.org>; Thu, 28 Apr 2022 09:15:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=5DOpGNGi+13xEwt26s2CCXKnzbnOJNFISULq/EZqNn0=; b=dBO4RULD7tND2+S1bJJuQNJ7rJ
	bt4uHLa49TOXlbslw2hdc8fVwMUBPt4cr6BjNxL3h+i2hqK4R+GrcEP7ONDtG44YE2uOOSK0dFVT1
	41TQZpZyH8oMvC4o+HRPkVAzf4tXS4vAxNN/MsCh4UnWmw+nO5MTqcZe7KDZ9HSdyZT8mNNcaI9EU
	SlBmoJH5T7N73DPtRH7IvoROpdIt/OU/eIhLBwrySIXHQh9Is6txT2gCVdFWlUj46QNxPxRcv9BXm
	PqlE+9exSenCncPJyDZw8dx8DS75zNQLVphZjD/r/7mN9P49aVLndW4Eufsah+6VAhUrIYUEv+Z+2
	A6G7EMJw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nk0FN-005eUr-RE; Thu, 28 Apr 2022 09:15:37 +0000
Received: from mail-mw2nam12on20600.outbound.protection.outlook.com
 ([2a01:111:f400:fe5a::600]
 helo=NAM12-MW2-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nk0FL-005eTU-JN
 for linux-nvme@lists.infradead.org; Thu, 28 Apr 2022 09:15:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SNF7L7D0NuszoUzOhFhopjwxLCnLWVPpyudssLOUfAV88ApO0uri7Gm5uZviNXHI7WhtjLIXGAc4MTEB1H8fPwNoYjANZc5ocJq7pXjp/j/xFmlSedPx7XRJfaiNcwNSqnL5yQ9qfnq0WMyxZAvpzRvcsq/vR8aTiORd9GBaf2/lErwvBpAT1mmdbNzVgzOnprI6uz3jTNDL3ClO5GHF/NiaMElNhZTpRKErX+Ua1hEqWqHlE5ot7IUf9tHj+e9ls7Ij6pW4OfcQCoEkzDTuQRDHdgZPcwE2AT7/XwnEg9+IQu8P2zYOxrBQFCsUz9UD+nb+mFX4zCnk5GId+qNYlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5DOpGNGi+13xEwt26s2CCXKnzbnOJNFISULq/EZqNn0=;
 b=jugw/4/l8tmeopsxY0GIUUTqTESZG43a3mGKWFeB/ER6d4ULwUlCyj0IATOtSgN880ofCzNw45YgEgie+D85qIg6ayBBgmw6nFAuxB53dFDyDIGBPBN6u5I9Ql2bRKgWMP+U4s6UpJ4JVx7b82r+Vck87yD//PqZnCBsEzKUcAAVe4tQ3z0FsMEcdNgHl5PLHNmZs3rMInwbeEMKl+ncaEjLjbkIKiOmaNrxHBxwpjstkexNSXDDgI5bquEl6qjvCH7AcL8kLbf4NOXSmhBggzQZrHlbSdIAZhdBkMfYAh1VgdfHPxURTble6P/KRKtPTb+CHPx8ZdPpGmaPGZzU3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.235) smtp.rcpttodomain=grimberg.me smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5DOpGNGi+13xEwt26s2CCXKnzbnOJNFISULq/EZqNn0=;
 b=a+b/czG3QjINVp5qkHv0MvmcAe9Bjgn0uFSvLrZJ0FJTSmawcFm4Gt4FrBVbNGAUes86dr6PP3poU2wv27gXKkY+XXhAR7MYZYrb+o7CE3nKCHf/APft7Of2n92h7JAKQsJhFZdtHbWH+cOtk2JvlrgyM19lFO3LphrekbW6z//uOJbhTDWMq+IF3OiZVq2qcY4qfbz1TS0cT3XV0YVc1jDVPYetSq5vmKS/na+wwJFN4StWXTwG007jfeKwZYsYD/PQ7BF/pqbxJzxcWqKK6vK7Bq7SKZsJkA4dtAV3l/Z8OK/5b5fpfC7qw8EdDjtKNttSXuhuuyW9TLPJ9wwspQ==
Received: from BN9PR03CA0211.namprd03.prod.outlook.com (2603:10b6:408:f8::6)
 by BYAPR12MB3429.namprd12.prod.outlook.com (2603:10b6:a03:a8::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.13; Thu, 28 Apr
 2022 09:15:29 +0000
Received: from BN8NAM11FT025.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f8:cafe::ae) by BN9PR03CA0211.outlook.office365.com
 (2603:10b6:408:f8::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.14 via Frontend
 Transport; Thu, 28 Apr 2022 09:15:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.235)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.235 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.235; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.235) by
 BN8NAM11FT025.mail.protection.outlook.com (10.13.177.136) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5206.12 via Frontend Transport; Thu, 28 Apr 2022 09:15:28 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1497.32;
 Thu, 28 Apr 2022 09:15:27 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Thu, 28 Apr
 2022 02:15:26 -0700
Received: from r-arch-stor04.mtr.labs.mlnx (10.127.8.10) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.986.22 via Frontend
 Transport; Thu, 28 Apr 2022 02:15:25 -0700
From: Max Gurtovoy <mgurtovoy@nvidia.com>
To: <hch@lst.de>, <linux-nvme@lists.infradead.org>, <sagi@grimberg.me>,
 <kbusch@kernel.org>, <kch@nvidia.com>
CC: Max Gurtovoy <mgurtovoy@nvidia.com>
Subject: [PATCH 1/1] nvme: remove un-needed include from constants file
Date: Thu, 28 Apr 2022 12:15:24 +0300
Message-ID: <20220428091524.35442-1-mgurtovoy@nvidia.com>
X-Mailer: git-send-email 2.18.2
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0e26e7e7-17fa-40df-f7a5-08da28f7a334
X-MS-TrafficTypeDiagnostic: BYAPR12MB3429:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB3429CD0B30667E1E40B3F30BDEFD9@BYAPR12MB3429.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oWqTDGgiKiV8C+QDw8EK/AS1uezROXb1Yufjk1D/UzDfW//q2zVphHyNVZy6j8dbHDUm+EpFC1WQQNV95psV3OnE/yvTUsccD8m235VC55Ynf0NJeC9cv6Sb8dBUtA/q2UXzq+zUGKeanEMKwVL/zDEHczOUCJKIsGSCenCfXMIf08wMWlmWkQj6pwPJg3wAS6pYtuwfhijMU3UMqvM0MqtBwoUpC3VdlzjAZS1m+nCbA5Rq/3t4YSU/uMrNSJBLbwYkcGS9vfD7N9PrYjoAAtX6SNWyARBNOQh4hLvhVEW0pZt41uomh3p7w7rJFCSXe3rcz4/zDQClZOftiRx9qVfqhgVw4yAa5QBnc0AEQON7Avd2OnUykxNMwKn/KUE+KYWSy7BPAulZif9hRsM8wvI0NGktSHUT7oEPsucvShG4Efuh8oMuiEUInIPxdchErsPzv/t0FBJAbcve7z1xHaelLCUMWtyKV9G8slhwP1QpB5RoCofdevM3ZhnfZV9tFcg6QC7qyZD9AFeFKO+yJ2M18koZfx0a/4IRsJIfalwPXKe2GiT76SVgLBCvCKGvz30/av6crjjFEFDpZfA0aREqVrRyRm4Ayx3JtMfVdS0d/Q//wLXIx4hITiuqQzIdUj/zd4nTEVjZy5V2twYaiGiKM7l5burwfINh8wn6NT5rLWC+lKAIqHnp/5yZ73iEvM/+lu2ORRS5o/3G2wE6QGC21xCKF0bK1GDRCVrs60A=
X-Forefront-Antispam-Report: CIP:12.22.5.235; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:InfoNoRecords; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(82310400005)(47076005)(107886003)(2906002)(316002)(110136005)(86362001)(426003)(186003)(1076003)(2616005)(6636002)(26005)(336012)(36756003)(40460700003)(4326008)(4744005)(8676002)(83380400001)(70586007)(8936002)(70206006)(5660300002)(356005)(36860700001)(508600001)(81166007)(36900700001)(2101003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2022 09:15:28.4506 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e26e7e7-17fa-40df-f7a5-08da28f7a334
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[12.22.5.235];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT025.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3429
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220428_021535_845337_C22998F1 
X-CRM114-Status: UNSURE (   7.26  )
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

No usage of blkdev.h elements.

Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
---
 drivers/nvme/host/constants.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/nvme/host/constants.c b/drivers/nvme/host/constants.c
index 7d49eb34b348..6c2aa8eefb55 100644
--- a/drivers/nvme/host/constants.c
+++ b/drivers/nvme/host/constants.c
@@ -4,7 +4,6 @@
  * Copyright (c) 2022, Oracle and/or its affiliates
  */
 
-#include <linux/blkdev.h>
 #include "nvme.h"
 
 #ifdef CONFIG_NVME_VERBOSE_ERRORS
-- 
2.18.2


