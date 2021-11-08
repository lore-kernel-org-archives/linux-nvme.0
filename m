Return-Path: <SRS0=LsNR=P3=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F62AC433EF
	for <linux-nvme@archiver.kernel.org>; Mon,  8 Nov 2021 14:48:30 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 113AA61361
	for <linux-nvme@archiver.kernel.org>; Mon,  8 Nov 2021 14:48:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 113AA61361
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:CC:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/+fG5fRNYbsOufqVZj6pHCNFgmRqT7l5pnoR7vs36qA=; b=2gIxCuV4wdD1dz8JHciyWVBSGk
	aXcv2omPvJp1804CXExkNYXKkYW+nQpErJNMFOGjKDdmiXhVeEdB3ebTLHFI8Su+7SUDNsqD46oGc
	+NNmuM/oK2ByymWLnLCBFiyI7XlpPI7fJRGahVC61UilKu+OcVZnPG0QxYSlaPNoSzOKoH3hZ5IrW
	htGHnXOJa1siGDUtODmI6iZOhJJSK0mqT4SujkysJtdMAJh4rT+FyBWGvwxbtbGHv6MNTXB+L/F7V
	UEjLb2dGGWhDRFyteMpIMG+e41xCEeZHvTOKBvqN/lQk4iK891i/6//g0b6E6nD4SG6sjiy3ZwiwN
	wkaShSFg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mk5wh-00GiD6-2X; Mon, 08 Nov 2021 14:48:27 +0000
Received: from mail-bn8nam12on2040.outbound.protection.outlook.com
 ([40.107.237.40] helo=NAM12-BN8-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mk5vk-00GhzC-O5
 for linux-nvme@lists.infradead.org; Mon, 08 Nov 2021 14:47:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hIDeXvKJDU+qVSb0IW898J6nPS5o5jEnyNF6ZBcOOkwUZho3Ig12pu+F7CsJ3eG1inQThJmAPMKz0PvzeH56ZvZc2N3awWmB/SUh/NEJ93FYACQh8Qv8TyXYnaxEOCtwOm5ICIaQcn8ymLGNaTX4BpROhHEqlT3kt+RWdi6ve5TRThaUqqhF3WvqWZkztMJTfjyPkKBIZl/oDX/HVqS6736J9Db4snFSKMnJUKryt/UuridDL7DbqgWLQrwpkNrEqYU7wZVhHNUXUr2MCn1yC7Pw8skTeCQeTjS4H6T9Xmqb7VuB329Mu4h73ZVIspVujbqPPl0XgO5/782jaF0g3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/+fG5fRNYbsOufqVZj6pHCNFgmRqT7l5pnoR7vs36qA=;
 b=OHeAd5Y6QmUYnY26p6LxwXLVICEXOZYEQmfOlBO1EPPwIcvj2nI2y9t2masKFpJ+r85a7WnxnwjfxUwJN9ACu6SmqKvA7ts59iU+CPxUuNFkY0N9iNaVBvIQ+DVATKHXIxU+DVzQvRDkvgww1XAEoCGoXXO7BDTlc+ve2tDq5JGIwc/2m7TUhAnlE6JV2LB/TgEyeCrThR0JC+Y915yXGQr8ZkXnD8SYmDDOwOcU7XVnP7rqDxDhyXTLv0IDU9cS+1UgkFE9RqdftV8q6CzAv7NoYNscvkISi/55Le5O1zAGCZCJXTfoh9mx8Q3gWKqOWfpwxW7TmtJDU5FOpVUlBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.35) smtp.rcpttodomain=lists.infradead.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/+fG5fRNYbsOufqVZj6pHCNFgmRqT7l5pnoR7vs36qA=;
 b=Qbox7GCjPQtJHi9kd4sJkMY3v0S5kGtElkQ0yn5k4VPKu3aF1GEycf4//X14Sh19VjXCUMWjoW6xelp7WdmJDW6k3n3Yde7v/1acANWRxY3x8cTAGdP3Qvl/GgIX2SSy7k0wU/9UgqNbi/Z77XzzTH+6UNd2gGS6D6D7pc2M0SxBX9Z8TaznUqBrzCLQjKT44Q+RDdWKJ4LmzsTc3ERbePdzB7LVpVHjAnBg4YZ/93PCRZW7XdSFWpXQHDBs7YcJckHko85eKCPR9D8E2y7a+moflsc8nZUfSZ/XP+lrXSscon34QpcCs5ulmz/RGsdG9CjQLmrKm0kx++L1QvTy7w==
Received: from BN6PR20CA0069.namprd20.prod.outlook.com (2603:10b6:404:151::31)
 by MN2PR12MB4173.namprd12.prod.outlook.com (2603:10b6:208:1d8::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.13; Mon, 8 Nov
 2021 14:47:26 +0000
Received: from BN8NAM11FT044.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:151:cafe::38) by BN6PR20CA0069.outlook.office365.com
 (2603:10b6:404:151::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.11 via Frontend
 Transport; Mon, 8 Nov 2021 14:47:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.35)
 smtp.mailfrom=nvidia.com; lists.infradead.org; dkim=none (message not signed)
 header.d=none;lists.infradead.org; dmarc=pass action=none
 header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.35 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.35; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.35) by
 BN8NAM11FT044.mail.protection.outlook.com (10.13.177.219) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4669.10 via Frontend Transport; Mon, 8 Nov 2021 14:47:25 +0000
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Mon, 8 Nov
 2021 14:47:23 +0000
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Mon, 8 Nov
 2021 14:47:23 +0000
Received: from r-arch-stor02.mtr.labs.mlnx (172.20.187.6) by mail.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server id 15.0.1497.18 via Frontend
 Transport; Mon, 8 Nov 2021 14:47:20 +0000
From: Max Gurtovoy <mgurtovoy@nvidia.com>
To: <linux-nvme@lists.infradead.org>, <hch@lst.de>, <kbusch@kernel.org>,
 <sagi@grimberg.me>
CC: <chaitanyak@nvidia.com>, <oren@nvidia.com>, <benishay@nvidia.com>,
 <borisp@nvidia.com>, <aviadye@nvidia.com>, <idanb@nvidia.com>,
 <jsmart2021@gmail.com>, Max Gurtovoy <mgurtovoy@nvidia.com>
Subject: [PATCH 3/4] nvme-tcp: add command id quirk for TCP controllers
Date: Mon, 8 Nov 2021 16:47:02 +0200
Message-ID: <20211108144703.7971-6-mgurtovoy@nvidia.com>
X-Mailer: git-send-email 2.18.1
In-Reply-To: <20211108144703.7971-1-mgurtovoy@nvidia.com>
References: <20211108144703.7971-1-mgurtovoy@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e532e336-4fcd-47eb-8f0b-08d9a2c6adf6
X-MS-TrafficTypeDiagnostic: MN2PR12MB4173:
X-Microsoft-Antispam-PRVS: <MN2PR12MB4173A09DFBE6F4005BD06F53DE919@MN2PR12MB4173.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Cf+tBx6qoyF9JqDVF1HxGxNFkI9vxhnYmY6c/li1dAFCdIEVvzH83bzhTwL1xvDnwmpk2+VoKMrqOx+J6KOW7/x4f4gIHSG95rFaeEDWz2EJf4JMXXvLltRJZUhHVziJHHo3k8fSyRFojNAw8zXNb7JAKNA4O32Zh4uDTIEfiBogPV8LUXwrOjNgq995xK8jd3jWK38ww2za8Bba+bO/y0OSEkNLcSxArC9f5ytEY6n4xMEdCWlrSVUcAgnLvyyAFydLe7ks0bBfLSHAiCqO0E+wBpNdp5boTPKd2RQPeFO+hxA24UTvSEf9KCEYBfubXCyzszBiKLgcYg7siD/GGCfY3ZFlQDEaJBVymSHF+KTfUb2/OD3KEBt5mouXepArjandA9wNMIty8OQYL4ECfXEPguC8y+cQVUNBsgzowKaC0Bfxz/GK0ntiJ6pSXH9B1lMQKOLWZhs2/LDwJCjVGOvqh5IWa3uNooLFOGdTh4nQNb9t8q/tWAABd2CzAp5T587iw3ZeCScsRYY0zmeJPHyY46RWypWAL8N5xdt2RR9/v6XtUBmlZsd0oapKcJM26iQSRjnI6j0e40Dp3KBXwXRG/7lrNiGBfcGPDvrlSPfV+uQDZwd63radA3WpjLR4CQ7tVKeHsT08faSrz3eXOTIWTTQshz2/bnFptSMGfOfruPrIgn/2jZJaUgSiXM4FgXmGTbcuHpVAKb/2BbSlbQ==
X-Forefront-Antispam-Report: CIP:216.228.112.35; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:schybrid02.nvidia.com; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(86362001)(82310400003)(426003)(2906002)(356005)(1076003)(4744005)(70586007)(508600001)(8936002)(36756003)(36906005)(2616005)(316002)(7636003)(70206006)(110136005)(5660300002)(107886003)(336012)(26005)(83380400001)(54906003)(8676002)(47076005)(6666004)(4326008)(36860700001)(186003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2021 14:47:25.3757 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e532e336-4fcd-47eb-8f0b-08d9a2c6adf6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.112.35];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT044.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4173
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211108_064728_821788_B727BF01 
X-CRM114-Status: UNSURE (   9.97  )
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

Enable NVME_QUIRK_SKIP_CID_GEN quirk if "--skip-cid-gen" flag was
set by the user during the connect command for TCP transport.

Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
---
 drivers/nvme/host/tcp.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 07156ea9d1a8..13f641f0033b 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -2501,6 +2501,7 @@ static struct nvme_ctrl *nvme_tcp_create_ctrl(struct device *dev,
 {
 	struct nvme_tcp_ctrl *ctrl;
 	int ret;
+	unsigned long quirks = 0;
 
 	ctrl = kzalloc(sizeof(*ctrl), GFP_KERNEL);
 	if (!ctrl)
@@ -2567,7 +2568,10 @@ static struct nvme_ctrl *nvme_tcp_create_ctrl(struct device *dev,
 		goto out_free_ctrl;
 	}
 
-	ret = nvme_init_ctrl(&ctrl->ctrl, dev, &nvme_tcp_ctrl_ops, 0);
+	if (opts->skip_cid_gen)
+		quirks |= NVME_QUIRK_SKIP_CID_GEN;
+
+	ret = nvme_init_ctrl(&ctrl->ctrl, dev, &nvme_tcp_ctrl_ops, quirks);
 	if (ret)
 		goto out_kfree_queues;
 
-- 
2.18.1


