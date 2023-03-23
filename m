Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BFE3C6FD1C
	for <linux-nvme@archiver.kernel.org>; Thu, 23 Mar 2023 07:53:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8HmlwzCXK5xNmJyfgf5uCFU0q3RdMjBaed/f7BmADNU=; b=wW80BljqkntWibPrlzSAhPCfDb
	TtG7gwW6zZeTJsrpRIUxcWxdvNaCzPQeN+wh2YKkPpn1EWbEx8QkCjvrELxvse4s/OUIyOvuLmwDf
	AiZDsUhEK9QufUY1UwIRJn8DDuRY4R8xdmjkaUj5zDMfZYVtwvaDXnWdg4KRzg6nwlovnOoQF5FQY
	2csXUrDK7FMPzl8wuLYB3gDC9w0c+X2HmYU0fM1qLXcCALRQErGCZblKdr0JpB7/k1DE0H1/Oc7hC
	+Q1OFePRl9yV+HjdqgZ7gnqVCjv61WfF39aGjuu50lXfh7HPDmOxfgQJdn+kxPelQMwFAwVMbbFHy
	w0iL24Tw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pfFlK-001AKl-1h;
	Thu, 23 Mar 2023 07:53:30 +0000
Received: from mail-dm6nam11on2062a.outbound.protection.outlook.com ([2a01:111:f400:7eaa::62a] helo=NAM11-DM6-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pfFlH-001AHT-0G
	for linux-nvme@lists.infradead.org;
	Thu, 23 Mar 2023 07:53:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hgkPJycN926/ZktthARu2ixChDyldBCykgnKLwnJI3buvGDRgZia5FP735mAUgUacur2B5BWfUJsGrTgjX7pwnMLuJHQnhrjuS5NnxPqRuAgMUsB3TAL60fNPhC61mEBLGxjXfpNAlCf6sbT6mWtLLSkcOg6kdf/KXoBVnHtkSwZhQIi5SjkeqBCWvg60IQVYKuglFai3KFJHXDKzvmW10D+4oYqN0t9InJZYuS/k2m53zyczBWk527YEijzmrS4RUC+E73F6/2Ixh9ekIEkIplfdPiXeQSqrb9VpUVuVucB2iO/h6Q38p5Vq9OgNVMSBbocntsfyqdBbeV9wVJnDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8HmlwzCXK5xNmJyfgf5uCFU0q3RdMjBaed/f7BmADNU=;
 b=kmnBhHPfUF7ocb9S03azhQp3gXH3+jVOmd0s5HpsKYpYhL7ThQ8rCXeXbgJGGztdM83d23MQC21WtA67M+ywEhp1wN3Ig5+iJINA0Y2YM2HoU+MnAK/c4fSecpOGyLQhisidPbJvXpyIMDz2CoBCNx4qegK8CyHDKXn5xoLqUYfO7O7OHZFEGmrCgY0g+TLUfpxy4dKIuAVBUU6NUW4AJSQ4ZWImgETeG+bUUgmD+5LEcqEk60RRzClXxo3eUImwC7X28iV0iV4JaZ5k1aYr0vMumRWUXBJHYz8lRQzxyi4X7dl/OazXA6ZAOKSxzJ9WHr5fKfXB8+zqvIgQxTSxyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=lists.infradead.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8HmlwzCXK5xNmJyfgf5uCFU0q3RdMjBaed/f7BmADNU=;
 b=QELfKkN/iu53KBRTjfdnXEu17eimVoFKyQ/Ym469knBTJrkBclPSyP0IpdohOM5svhp7J7TjpK2RojqvQqe7O8QoID8yfwYIpcXDN1tgpC7wgEkU3iOD6GzAW/7eQt331W3+i5b5s99pyWBYTb/kH16Qlftxo0zJqGsJYGR4qEcTm30cnZscscF5KDqE5jI4vH9y6dHwOhUgAkKp9cRcBAK3QQhbNj0OERbDP1ojEuBBawKsai3S5ZBobklwdL8JxnK9pdnv9p0MoGr/sS/zxFgAUDIfB8yBwIYXiqyzxO9JZoe+bg7vsA4Haa4a+SAMV0cYShMre/kzf0Mv2a1FzA==
Received: from BN0PR07CA0029.namprd07.prod.outlook.com (2603:10b6:408:141::11)
 by MW4PR12MB7285.namprd12.prod.outlook.com (2603:10b6:303:22e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Thu, 23 Mar
 2023 07:53:22 +0000
Received: from BN8NAM11FT105.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:141:cafe::aa) by BN0PR07CA0029.outlook.office365.com
 (2603:10b6:408:141::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.38 via Frontend
 Transport; Thu, 23 Mar 2023 07:53:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN8NAM11FT105.mail.protection.outlook.com (10.13.176.183) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6222.17 via Frontend Transport; Thu, 23 Mar 2023 07:53:21 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Thu, 23 Mar 2023
 00:53:07 -0700
Received: from zion.nvidia.com (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Thu, 23 Mar
 2023 00:53:07 -0700
From: Chaitanya Kulkarni <kch@nvidia.com>
To: <linux-nvme@lists.infradead.org>
CC: <kbusch@kernel.org>, <hch@lst.de>, <sagi@grimberg.me>, Chaitanya Kulkarni
	<kch@nvidia.com>
Subject: [PATCH 5/7] nvmet: centralize req completion for change ns
Date: Thu, 23 Mar 2023 00:52:01 -0700
Message-ID: <20230323075203.824096-6-kch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN8NAM11FT105:EE_|MW4PR12MB7285:EE_
X-MS-Office365-Filtering-Correlation-Id: 86c4514c-5cbb-44a5-0479-08db2b73ac90
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 	SMcHMwN+2CgKZ11AekoPx7yOpaVBkklf0xfkg5cJFV55Z2lYtMSd7/FhCtMDQowRkcbf7NFyuFXqu04mflsUHtc/GtKo+FeCmtzNDD0aNCTYh+g7Y0xypsXk4esCtaZtyl4QU2onqPI+07WDnncFBwvDutFMYDYhnzmefg12t1kL8oCwgHIsLN1hdywmbscJuIHZiLI7GKXqfwoSNX+yRIlWNsHebcN3j6P9x1cBaPkUmlKKu42TFW261a/r0BeK8mNk0T2O3Hcw/nU7HMbJWlWiPE/FkK/Y2upUNKyrVzrz7YAgA+vNV1fDAKL4LizP+Y2kMgzI+ii87WlgrM3WdUAjb0FoOOve2Qq848gSB7d27i938JoQloqA/vyZF30Ja+pzXfvATG5r1hhUizU3zXIYG78wiQ1IcFC3L/2QDMlR7BaaTM/G2ECtkn1S0C2EG0r6O/DGCVOaM04f7TeKaZexUzlw5wB1hkS40TZSbL418MbgNEkL/HwDXjEjLDEanCDs+EN4rrkwNR4OOTysmf5DVzyY3WPhhMtv0setXkcKR6RUoR0A4Yxs83cGU1S9V0h+D3CzJ1mF5VtCgUeV0CctbSBRCOZlWewWzDeHVTvS1a7vLRz2Mkx43/NRmJLt8aWSNBghKkoP1nTQGEs3zewqfMQxdmpbMY0PHPNqQrO8c2L06ndJQpjNkpjlNlmZ3iomicZpnd8e9NTNwq+ZUotnm75OK/KOFNFWQgoPDN1xYXetlcf1rZTgswxDqkAe
X-Forefront-Antispam-Report: 	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(136003)(376002)(39860400002)(396003)(346002)(451199018)(46966006)(36840700001)(40470700004)(8936002)(5660300002)(1076003)(36860700001)(82310400005)(356005)(36756003)(82740400003)(2906002)(7636003)(41300700001)(40480700001)(40460700003)(4326008)(426003)(47076005)(336012)(107886003)(478600001)(83380400001)(186003)(6666004)(2616005)(16526019)(7696005)(26005)(54906003)(6916009)(316002)(70586007)(70206006)(8676002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2023 07:53:21.7378
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 86c4514c-5cbb-44a5-0479-08db2b73ac90
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: 	BN8NAM11FT105.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7285
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230323_005327_122982_B5A113E0 
X-CRM114-Status: GOOD (  11.01  )
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
nvmet_execute_get_log_changed_ns() and use the one that is in the caller
nvmet_execute_get_log_page().

Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
---
 drivers/nvme/target/admin-cmd.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index 84cacc93bf65..5e6ac85b1843 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -225,14 +225,14 @@ static void nvmet_execute_get_log_cmd_effects_ns(struct nvmet_req *req)
 	nvmet_req_complete(req, status);
 }
 
-static void nvmet_execute_get_log_changed_ns(struct nvmet_req *req)
+static u16 nvmet_execute_get_log_changed_ns(struct nvmet_req *req)
 {
 	struct nvmet_ctrl *ctrl = req->sq->ctrl;
 	u16 status = NVME_SC_INTERNAL;
 	size_t len;
 
 	if (req->transfer_len != NVME_MAX_CHANGED_NAMESPACES * sizeof(__le32))
-		goto out;
+		return status;
 
 	mutex_lock(&ctrl->lock);
 	if (ctrl->nr_changed_ns == U32_MAX)
@@ -245,8 +245,8 @@ static void nvmet_execute_get_log_changed_ns(struct nvmet_req *req)
 	ctrl->nr_changed_ns = 0;
 	nvmet_clear_aen_bit(req, NVME_AEN_BIT_NS_ATTR);
 	mutex_unlock(&ctrl->lock);
-out:
-	nvmet_req_complete(req, status);
+
+	return status;
 }
 
 static u32 nvmet_format_ana_group(struct nvmet_req *req, u32 grpid,
@@ -339,7 +339,8 @@ static void nvmet_execute_get_log_page(struct nvmet_req *req)
 		status = nvmet_execute_get_log_page_noop(req);
 		break;
 	case NVME_LOG_CHANGED_NS:
-		return nvmet_execute_get_log_changed_ns(req);
+		status = nvmet_execute_get_log_changed_ns(req);
+		break;
 	case NVME_LOG_CMD_EFFECTS:
 		return nvmet_execute_get_log_cmd_effects_ns(req);
 	case NVME_LOG_ANA:
-- 
2.29.0


