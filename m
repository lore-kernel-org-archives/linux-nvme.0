Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13AA0C433EF
	for <linux-nvme@archiver.kernel.org>; Wed, 12 Jan 2022 06:21:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=QzP0p4Yu72yla8dbpxSWXHXZAXkE6A9CtTSJXZXDU9E=; b=Ygrwy4hNn8jCICxAf6UCh9oua5
	numqfA3pV1yo0XwWUECyOjS+9cYddF7C9MLDn3CLOvGWpKvYS6hJXBolbiJ4XkoM7bcmXFld4n90k
	/02xo0vS3wNcLHETqlmW75mTm+UAy7+iFIHOXUObHLqKFLLMv93b0vUr/5iiiMifs7+MymCddzTCs
	/K8S351mPRrGIbFz1yu1ggB8xVf2pgck9GUOBmry0vsTsp/XeUGs5d5i+5cG+E3v1DoZfUhuy2YUY
	DBN0kCq6tG1QwZpIBstmQrDEN2oNxk+vSlePe0MQSJWPVQl1Fym+TcKUHl9dQkfwxWfTBlzL7i+HE
	+MwMek5w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1n7X10-001Gv8-JM; Wed, 12 Jan 2022 06:21:46 +0000
Received: from mail-mw2nam08on2086.outbound.protection.outlook.com
 ([40.107.101.86] helo=NAM04-MW2-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1n7X0r-001GtP-KP
 for linux-nvme@lists.infradead.org; Wed, 12 Jan 2022 06:21:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hmBJ+j+pLSplx1KOt3JvyLQaFDQSZxvn5KNnO7N/uThQjVha1mJW1ruF34bmMR3S9lrnkppNKeYcH7TGl2K7pSNeWXft3Kfx9SM20p+BVtvz51FY8qrxWtmn5ONHINuTZW83tpA0J2tz2fvn/kaWlvbSc1Ltf3swae9cQ2DC8UPzvUDLXK4tMnzOyf0cD0dXSFuH4qbVqwohTI3fK0z/6gPmKtzTk61dfPPhwSD0cJma0FN3TVXtIS0e6N4QyAVMeGVW4jyYLBOjA3Wow1U3H++YIMexADrt3f6i2dHvLMtre1OXFKnTREWTsLv3jv5rqHgemEud4K/SxvczlHeqtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QzP0p4Yu72yla8dbpxSWXHXZAXkE6A9CtTSJXZXDU9E=;
 b=T/beTpj8QH12jjiwLaeX2cHwnS+eq5ZC0adHhJiwrGrnEJvK72EdYpDuv+mrs+jZCAjBd2cOjxGIssbstLzUBpEciWhygwyvP0ID+h1XZ/xqNj2/v3r4KR9nlZhXKKMrzauSe8ngyTLrtPzqt6GRigwQfn5QezOVwMfi0WJZlR5V/Wo2GAaEYnrNLZwOT2oW7UgnzaU1DgpNwygRjWW3cp0pAUEgGJOL3utUS8XPOmRJZKwgRwbG1Blzo51wLGEqYRRw3fIaSTnJGBq4vCVBLq5BgWFyFfmYHg98Uhn2yRZ16TZNXa1CEeAvjomfTKmA/rl4WWEnT/aZgtcXMcFVxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.235) smtp.rcpttodomain=grimberg.me smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QzP0p4Yu72yla8dbpxSWXHXZAXkE6A9CtTSJXZXDU9E=;
 b=pCbqpNsLvpcT5YhHE8sg4f0TLN6Yvv7jPqOk6+TI92FHPkMeO0QO10lmka3/0c1KgyL3qbPYpSvIMtk3rVpUvUUP1YxRFkwCdPzSSh+PltjegnYCqIcU56E3dmc5zYmadyo3xDuCfj9maUjTTVFi8jzUfSkUPgxnUOlbS5563X0ZjEUuvvZkuxIWlD/T21bqD60/2DP5h801+E1nUIrHZOHmz2inzBQ6y8Z8Df8hwPbtVq0N5zBdng2N0LMyycMLkP0bFalsb++sKbcZvHs+Iv+d5c8DvBMeBF/MEN39R5oAVB3hU04OaSLxk+GPZTGEt5chUYSIJJfvmywHBvZ8Ag==
Received: from DS7PR06CA0028.namprd06.prod.outlook.com (2603:10b6:8:54::33) by
 MWHPR12MB1199.namprd12.prod.outlook.com (2603:10b6:300:10::11) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4888.9; Wed, 12 Jan 2022 06:21:36 +0000
Received: from DM6NAM11FT023.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:54:cafe::b9) by DS7PR06CA0028.outlook.office365.com
 (2603:10b6:8:54::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.9 via Frontend
 Transport; Wed, 12 Jan 2022 06:21:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.235)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.235 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.235; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.235) by
 DM6NAM11FT023.mail.protection.outlook.com (10.13.173.96) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4888.9 via Frontend Transport; Wed, 12 Jan 2022 06:21:35 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1497.18;
 Wed, 12 Jan 2022 06:21:34 +0000
Received: from dev.nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.986.9; Tue, 11 Jan 2022
 22:21:34 -0800
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: <linux-nvme@lists.infradead.org>
CC: <hch@lst.de>, <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>
Subject: [PATCH 2/5] nvme-fabrics: remove unnecessary braces for case
Date: Tue, 11 Jan 2022 22:20:58 -0800
Message-ID: <20220112062101.90102-3-chaitanyak@nvidia.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20220112062101.90102-1-chaitanyak@nvidia.com>
References: <20220112062101.90102-1-chaitanyak@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d47372f2-d836-43cf-bb58-08d9d593c8ea
X-MS-TrafficTypeDiagnostic: MWHPR12MB1199:EE_
X-Microsoft-Antispam-PRVS: <MWHPR12MB1199CA5E0ABB5D5A0CA868B6A3529@MWHPR12MB1199.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3968;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8avDIdpTZhXLmCm62IaqxEJSu76Z/GoUypTxqAWpvnz3QM5HPFURv/PfIq6Az3YrcOP6Qjs8sKcbCkB0FQu6RVZiPUqatU7zj120IySKeo6mIQbvFrl1EMWZtzuDSoQgRKWS2WR6HkU5WLJE7+eWFyWWMhTvHBZjV1bN+6CXKdvb0syqpcC+7Jw5/0QKLcDVuVUncg2MkE68HAIkBuD0Kzb0y7VXNgkmziOPvpDuXYU8baTvkHN6/OcAZ02YCr6LCF/fdIsHy2Z7zpVj9GeCO3OrR3Q0kaodF9v7n1ZJ+mJdDdotDOrwa4ExEIvGRBG8bw37ljo1EMrw6dYFqBwxQgEZjIvwwW3QV6kwKGWVYxaEmtb3MglYADalPZSSdV0tFTgpyrqqG3w0dlcxFqVQH42eJhnDTrBTiU9yaAzUvBj9Zrtscv5Ww3DIbO/DL0/yLh42f8mkzdK0BvVm2SOd0+rwJodB/nArc8Dp0yLc3zVyGQMcclM2o29xgSRpUI5JpI8VWhTWIi3UuxYiza2XUZkkP2aEQzazy/njSbFiq+cTmUWcFCQ1twlIXqvzWAVyQRDnTi+WQ4v7P+u7n0jh7m1zrPCwIsCKOqrTPRraEu8RKkX/5mFQkZSzIN7Ch/re3bAM+tPOnvNm5NpG6HR94knEmfnvzsZr//HIXQsnQF4iLcVSwotYdDLG0o4dd/5j48DxtyR9OUObU8VL/M4UJAqmyMzP5fhWJ75Z5l9awiD4xNh6wxb/tH2cxekXgA3Bxiym1Wv5sksVh7HFyD3xyez5F7bXH4hDHaiBLQv4rWM=
X-Forefront-Antispam-Report: CIP:12.22.5.235; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:mail.nvidia.com; PTR:InfoNoRecords; CAT:NONE;
 SFS:(4636009)(46966006)(40470700002)(36840700001)(26005)(336012)(36756003)(186003)(16526019)(83380400001)(1076003)(4744005)(2906002)(356005)(81166007)(426003)(508600001)(36860700001)(5660300002)(8676002)(70586007)(70206006)(2616005)(8936002)(6666004)(82310400004)(7696005)(86362001)(54906003)(107886003)(47076005)(6916009)(40460700001)(316002)(4326008)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2022 06:21:35.6121 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d47372f2-d836-43cf-bb58-08d9d593c8ea
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[12.22.5.235];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT023.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1199
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220111_222137_706535_82F1AD27 
X-CRM114-Status: GOOD (  11.19  )
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

From: Chaitanya Kulkarni <kch@nvidia.com>

Braces are not required for enum value NVME_SC_CONNECT_INVALID_PARAM
when used on the switch-case statement, remove the braces.

Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
---
 drivers/nvme/host/fabrics.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
index a0640986add9..d38a630ce3dc 100644
--- a/drivers/nvme/host/fabrics.c
+++ b/drivers/nvme/host/fabrics.c
@@ -271,7 +271,7 @@ static void nvmf_log_connect_error(struct nvme_ctrl *ctrl,
 	int err_sctype = errval & ~NVME_SC_DNR;
 
 	switch (err_sctype) {
-	case (NVME_SC_CONNECT_INVALID_PARAM):
+	case NVME_SC_CONNECT_INVALID_PARAM:
 		if (offset >> 16) {
 			char *inv_data = "Connect Invalid Data Parameter";
 
-- 
2.29.0


