Return-Path: <SRS0=LsNR=P3=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE6B0C433EF
	for <linux-nvme@archiver.kernel.org>; Mon,  8 Nov 2021 14:47:45 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 862C361242
	for <linux-nvme@archiver.kernel.org>; Mon,  8 Nov 2021 14:47:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 862C361242
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:CC:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=V6/GK3GTONsMXlEZty2Me83oR27je8Gpus9UOiiExcg=; b=idH1i9Wqv6+8J6jL3HCUJogeG4
	bnb4pdHEnzicczE50tfOgYPBLBV0hJyMzFYsSfVSuxynPcmov3lyHWaHKuYycxYyD40oiNctPa1ml
	48jZVV10USTrHfXfFM0adoVSwFmTl/CDjSw1oTSR/7dqUiKCcr8YYPLPwyvru21WUMgY5UHz+js47
	uSifFfuKLDimzSFj40Y6HWb642S/F2GD1QnuFfnNFAMGOO26865NpsH/i/P0sSvjxcnV5kX4ZXyJB
	pk7zR0tYrFgNGH0wM83XPa2SDvU0MQ1bd+/Qv1shIAswLgb4AjTjuqeqIk3WBGXdPouTZYsVGkReZ
	jSSrxDZg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mk5vy-00Gi2Q-3L; Mon, 08 Nov 2021 14:47:42 +0000
Received: from mail-bn8nam11on2040.outbound.protection.outlook.com
 ([40.107.236.40] helo=NAM11-BN8-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mk5vf-00Ghxn-7k
 for linux-nvme@lists.infradead.org; Mon, 08 Nov 2021 14:47:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kmowE9gw3YVH5P8V+MRPEwUrtydTGXMxaJ55p4wO/Apnct0ldBgCRWdXax2rt9tF8Qc8jdKDWZrdVtvhXMI4ErfeIPWdaY/Kqd1w5aTwNPC5w2vVsFx8CinfVmH74/jZAuqkztC02cw2O2U43gN6crz9f0JBGvWcEe/GXKtshXhywB2GhEvSFhbL4zW2qv9XwkNG7E8Qjr4I8WvTkyqZ3gWOYluOZMzcI3dbMsFaFWvlAWAmwcFOSL7nBezDusZUFSjq8PeqBlsnmoPVZT2sBU6HMxGYPdGEs8GlGSkBawdfF55wCOBtwITTSEc94cmxYstP8xtenIm4LtWmUTFQtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V6/GK3GTONsMXlEZty2Me83oR27je8Gpus9UOiiExcg=;
 b=XT4vhFSzrY3Mb8lbxHpjQ6N0OuzOR1sUW9Zt0X7yiwCqCzbhgNu9H6e65tWpOrXCwOSC8ZBVghgRb7sCJJKRSUoqNodsjXnntQq9LKX5Jdey1ktCrsDIm2YWf2FL7FybeYwQb6FZvhYiNuo4tczamOhSOQYcWpo2Da7SzvkTa6r51nOYQxXzwG3DEbHmBt6tygkYgor8AVvdHMXCuVX731vIvpPfe7K0mRkPxDXwTFA3aMmbmX7xmC6amZPeXVD3cxqIjlHjmfKhCKy06sqQ4jxBgHRYWdMozRrE3kQFYFxR274BA6LO174luV+WypwMnOGVJytPEGFIO4mbhTrXFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.32) smtp.rcpttodomain=grimberg.me smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V6/GK3GTONsMXlEZty2Me83oR27je8Gpus9UOiiExcg=;
 b=Dz6+lmfhbW44py+5ySWqbKmkQ1E9j34EqVAbpSMXnjP9NaRwIjtOvgMRMn62fk1ck2KRxH14c0SCY+0sPv/dy5hb0pK2NOtj68Kvuy52azWFX+oDG/+Jlyl/xCeI5iy2vYe1OHZH6/yy7NUTBOGN7DeZmy8pQn+3LSO55Iz7YYViewFDG1sNvtrFRIJ+ssM02vGCzQ7A2hCZXsgnZR2Jmvmzcj0rmMt6fXp4evzrYqeIxx/jSkqbZb4N2LKrR3FMGT735iat0iLJ/gGjL/TX6y/enCD/JoaFmzdzyNIrQnmuCjxrKBd6QgW2bO2UvH8bo64pa6a398JBRJEP/wsudg==
Received: from DM5PR12CA0063.namprd12.prod.outlook.com (2603:10b6:3:103::25)
 by BN9PR12MB5211.namprd12.prod.outlook.com (2603:10b6:408:11c::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.11; Mon, 8 Nov
 2021 14:47:21 +0000
Received: from DM6NAM11FT040.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:103:cafe::e3) by DM5PR12CA0063.outlook.office365.com
 (2603:10b6:3:103::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.15 via Frontend
 Transport; Mon, 8 Nov 2021 14:47:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.32)
 smtp.mailfrom=nvidia.com; grimberg.me; dkim=none (message not signed)
 header.d=none;grimberg.me; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.32 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.32; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.32) by
 DM6NAM11FT040.mail.protection.outlook.com (10.13.173.133) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4669.10 via Frontend Transport; Mon, 8 Nov 2021 14:47:20 +0000
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Mon, 8 Nov
 2021 06:47:19 -0800
Received: from r-arch-stor02.mtr.labs.mlnx (172.20.187.6) by mail.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server id 15.0.1497.18 via Frontend
 Transport; Mon, 8 Nov 2021 14:47:17 +0000
From: Max Gurtovoy <mgurtovoy@nvidia.com>
To: <linux-nvme@lists.infradead.org>, <hch@lst.de>, <kbusch@kernel.org>,
 <sagi@grimberg.me>
CC: <chaitanyak@nvidia.com>, <oren@nvidia.com>, <benishay@nvidia.com>,
 <borisp@nvidia.com>, <aviadye@nvidia.com>, <idanb@nvidia.com>,
 <jsmart2021@gmail.com>, Max Gurtovoy <mgurtovoy@nvidia.com>
Subject: [PATCH 2/4] nvme-rdma: add command id quirk for RDMA controllers
Date: Mon, 8 Nov 2021 16:47:01 +0200
Message-ID: <20211108144703.7971-5-mgurtovoy@nvidia.com>
X-Mailer: git-send-email 2.18.1
In-Reply-To: <20211108144703.7971-1-mgurtovoy@nvidia.com>
References: <20211108144703.7971-1-mgurtovoy@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 513b6f95-372a-4a0a-d373-08d9a2c6ab25
X-MS-TrafficTypeDiagnostic: BN9PR12MB5211:
X-Microsoft-Antispam-PRVS: <BN9PR12MB5211CD2EC4848887FB2B33EBDE919@BN9PR12MB5211.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NdhSX4stU/n0i4FjCOZpPhXwEDH0l5oKniO/Nu96/IMroa0Qoq7Q48iVxjuHBmto+EEEuoqouA8z9UQO1M8cRBe1cn+LfvnHRe9ax0OdTK2ufxc8efkOlsV3N4ytPtG3F+hfvabEoYRlQ3RxiZy7e+HrdWXr5NgQdNsxzXMdL6w3fEM6axhAhKJGqhblVZe0CWvaSQfAnMRwnEBUancHaPIXG4hfGNlF+DN3StbrRwgj45twiTEO21GG00FdgwLmEVLJZt6QVM9c49TLM2dzCIJ/ANEZC1ARccLDRfZdVh5mMyBxox/PfXTznwTG+7chU1HOH/NCqraI8XOotbS/gXe7p0mx+Bg+rGxtHRL66th3SYNs7uECbRhJM+2MOJ78r8vGUpemmIXzWz/MPXAeGIFsovYIsso8b0vpv/QBLi9njwOWaYUn5SAvK/yVX2BF1hI5k4FxuQ6TwSfZYuhFR2Xo71ZV95EOMtf+pL2nJ0XZLDPtokB+2ZQOqbnh9JyN+RZLNdX8WVG4E5yjeFQS4vCtZ3/N01dcmvRQRi6DJBLYNmqJsaNn2cefdCYozYffOhIZtVAc1ecjRwoegDrANXfbvveDfLOF8sYowcrNUjXHiNhue+PhpykEB4YAWcBtTUYNX4Z0YtF5WtvfWDJkqirK0aJcK1DbWeirL+duF1ti71ZxYsTgXP+U1NQ8jxbLyYyNPOnRfobggtVhCQVKAg==
X-Forefront-Antispam-Report: CIP:216.228.112.32; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:schybrid01.nvidia.com; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(2906002)(47076005)(186003)(26005)(2616005)(110136005)(336012)(36756003)(107886003)(36860700001)(4326008)(82310400003)(54906003)(426003)(316002)(70206006)(86362001)(70586007)(5660300002)(1076003)(508600001)(356005)(83380400001)(8676002)(8936002)(6666004)(7636003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2021 14:47:20.7203 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 513b6f95-372a-4a0a-d373-08d9a2c6ab25
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.112.32];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT040.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5211
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211108_064723_303839_AE2E79B6 
X-CRM114-Status: UNSURE (   9.94  )
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

Enable NVME_QUIRK_SKIP_CID_GEN quirk if "--skip-cid-gen" flag was set by
the user during the connect command for RDMA transport.

Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
---
 drivers/nvme/host/rdma.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 9317f26e51e0..0c4c496bd621 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -2326,6 +2326,7 @@ static struct nvme_ctrl *nvme_rdma_create_ctrl(struct device *dev,
 	struct nvme_rdma_ctrl *ctrl;
 	int ret;
 	bool changed;
+	unsigned long quirks = 0;
 
 	ctrl = kzalloc(sizeof(*ctrl), GFP_KERNEL);
 	if (!ctrl)
@@ -2382,8 +2383,10 @@ static struct nvme_ctrl *nvme_rdma_create_ctrl(struct device *dev,
 	if (!ctrl->queues)
 		goto out_free_ctrl;
 
-	ret = nvme_init_ctrl(&ctrl->ctrl, dev, &nvme_rdma_ctrl_ops,
-				0 /* no quirks, we're perfect! */);
+	if (opts->skip_cid_gen)
+		quirks |= NVME_QUIRK_SKIP_CID_GEN;
+
+	ret = nvme_init_ctrl(&ctrl->ctrl, dev, &nvme_rdma_ctrl_ops, quirks);
 	if (ret)
 		goto out_kfree_queues;
 
-- 
2.18.1


