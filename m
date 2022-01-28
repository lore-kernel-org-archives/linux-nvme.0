Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3793FC433F5
	for <linux-nvme@archiver.kernel.org>; Fri, 28 Jan 2022 09:23:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=573zWTuyzzCb+mSgCCZwHrDm9t0BtwhFgLtlUDq9t8c=; b=4mDWyXmCA7yGhOjxCEZQUgHuEN
	mERWZ/XvpF4N7atVoEpJGGxVgosKAyDeIPsWJuVITyLK2gbQ+r+E82HbZL86LCKAEtN8c1eLVhj45
	5l1an+u3gECsiit4rtyhZxh4LA+FfWr+wyRdz7JPnC1SoM2C9Vn9Yl6S5yO2QIt5ksOCUSfOPv0eZ
	wlj4Xy9rZofxcAv6bUby5zUWiXpxjdSUHSm6oHpGPByrhLaKkanY9gQukjTAu8oyK/0EfM5++kZa7
	5cg00QFHAW1rVbekFehFaIM36FN+ZuudAHdwTs2mADH91W6Yqww5ZQ7YnYrkjDsenCsqndM8I7fzJ
	pemaWNBQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nDNU1-001Duc-4Q; Fri, 28 Jan 2022 09:23:53 +0000
Received: from mail-mw2nam08on20608.outbound.protection.outlook.com
 ([2a01:111:f400:7e8c::608]
 helo=NAM04-MW2-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nDNRb-001D20-Do
 for linux-nvme@lists.infradead.org; Fri, 28 Jan 2022 09:21:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F+mg0veXQKts7e2w1LGK8j0TN1GOn7RFxmAxiwbMPl8tZ2BJJ0B+jicxOsPS7olf/QTgMezeX2vxWx+Mm88qNjSSxbpy/t/apyUzY2O/ciZnq1+/i+cRLCaurP2DYiqsk2qQH8CF1WaTcFhyUJoMn6MeLHH+aDIlx/ddBMCRutmBMi1NxMfG2ELpJ5ygEDoXkW1DwL5HxA/+7h+nPUfv8OPX1+Xk6+5vk+0yKaWtRlKEtiuxgUzu99eZHs+pZ5eRojEREl4TBK/PmpXGf0chB7QiYG2bYwMgaLJX6mYLLow5ltfijZZdv3BbKMVfvnS3u0gN2CEF+hE8uCCTCSJFyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=573zWTuyzzCb+mSgCCZwHrDm9t0BtwhFgLtlUDq9t8c=;
 b=MOXGD26d/xID4M6nhg44HwqWLsAmoilUjNWVQwR8Xltv+/SxgCo0mYYNLem/qL+VzJuhRUvTFhY+oZ4cK+4dUBTMAmiE7Qz+s9kSfyb78LQMVHmWZ9ShviAike5XvDxGANUOJ4Q3TMBA6L6i/a+wrNs6rbmcL+erTU6voyY1OoJqom19f+HXfHjuh4WG3yjvNmxvz8V5s0HyFfInTWiVRaL8183oALFblKYguwYtmze5PeDwbrG7OvwWb3BAxlNZL0iDuF+lAJ/TH1gTJBWYdLtL111QpLDGo7DRi03Y74Zxky3E6T7foo03Wstt4XtBvYfeEcCF2DdxNF81dGdW6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.238) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=573zWTuyzzCb+mSgCCZwHrDm9t0BtwhFgLtlUDq9t8c=;
 b=bbWexVdqTb0Qmm7hryRD6uCEgT/Fg4E/je6A4O7uQxlyibrYOSgDdO8c2WVpgL8rTX37X7bm2zCLyqvBxH9gQZKJtxyhNjanujThxhiSZE1pu5N+Ld6Dgt4xkj3PPlGOKfzgQbLTaDQnl4PKMONOxKWoOBjhRtuPkVROxfLLgS2GPJyejw9H+Y2pq/kAymcgATZVG1CoLTe3NM2tLgS8N2Z+0f4VJooWfahqWWClGJH/dHryoU3XciusRBHBBOCuv590AgaytB4SLpsL72PqlFC5vBmBrSF6bCwfGJchnwwxdtLAV/16UMTP9zzlbg2APRnWD/e83f1GeMMWGYc79w==
Received: from DS7PR03CA0231.namprd03.prod.outlook.com (2603:10b6:5:3ba::26)
 by DM6PR12MB3531.namprd12.prod.outlook.com (2603:10b6:5:18b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.13; Fri, 28 Jan
 2022 09:21:21 +0000
Received: from DM6NAM11FT030.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3ba:cafe::5a) by DS7PR03CA0231.outlook.office365.com
 (2603:10b6:5:3ba::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.17 via Frontend
 Transport; Fri, 28 Jan 2022 09:21:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.238)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.238 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.238; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.238) by
 DM6NAM11FT030.mail.protection.outlook.com (10.13.172.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4930.15 via Frontend Transport; Fri, 28 Jan 2022 09:21:20 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by DRHQMAIL105.nvidia.com
 (10.27.9.14) with Microsoft SMTP Server (TLS) id 15.0.1497.18;
 Fri, 28 Jan 2022 09:21:13 +0000
Received: from dev.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.9; Fri, 28 Jan 2022
 01:21:13 -0800
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: <linux-nvme@lists.infradead.org>
CC: <hch@lst.de>, <kbusch@kernel.org>, <sagi@grimberg.me>, Chaitanya Kulkarni
 <kch@nvidia.com>
Subject: [PATCH 3/9] nvme-tcp: use helper to initialize connect_q
Date: Fri, 28 Jan 2022 01:20:09 -0800
Message-ID: <20220128092015.19289-4-chaitanyak@nvidia.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20220128092015.19289-1-chaitanyak@nvidia.com>
References: <20220128092015.19289-1-chaitanyak@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: drhqmail202.nvidia.com (10.126.190.181) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f40952eb-8491-4098-5d4b-08d9e23f8bf3
X-MS-TrafficTypeDiagnostic: DM6PR12MB3531:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB3531C1D31EBE6BAB8C491096A3229@DM6PR12MB3531.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:983;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ImeE1rufPwxn5tqoAFLwOt9S343smp3UeePOVLXAZslkMqB3oBkudHYoTY2zKSZ3JF0YuOWujJA8bJ6Zzg0VzRBRawwP7Dz6XQ+gGsBBpN8vg5DLsbEAsqXDWQFBSCQoN9oEAM7G/gHO4DESrSXux/eNMAehnwHN6G85doc01RwCDz4D8SdgwgqVqgSqU1phYGaVy+KWzrMuRxenyivM9Ug3OjCnFd2xY7jt/gZtrMyhFMT3wHAShJLPgX+VlZjHh33Bw/MpTgBVMg4HzmAS/O98JXfkPmFL4IBR1P/7mE/SQg5GJQQpC4B1upoyzISgivYQeiHtc76eJypjr1ohpOUm9Iti9YxT2h7uTIDI10AGU+sbY6h9RfLCPo3emiFGaONdz5H4GVoxh/N61SAaNjxThcVhv0OJm/m/ZkwpFAAbYuvLFRECNOZZhm8Zpo9KvVdr+bl+jFwfNK0rJRbFVf4+c2p6u9MK86MCs9IqhN/UBsoDhtMItDS9k/izq2+zMGO1qfeWLVhj3sIQ4+wwcuJAEIEWrDTizzkb+Np1NcEET/sisAmsoJVVaKZrWDykYoG5JfKG8TkxCVo4UPpkMTGE6+wT2azsoKvsO7BlLckR5kH3N1aBHJaJGxTJS1ZeVYZ3HlZRNtLKo2h0jAuzBOzDBWGT5qxagMM/bnBO+bkagS4/My+71FFVaeidPOX9o+ou6tbSIETbAX8co3qtWBM1VLsNDwsPMCM83I3VQ1MpMIsJMjnTrHBTK1++8HnMzmUrVeKFheUFf8JDZNEbc9KuIq3wQ0xEXz2sQbUS0AA=
X-Forefront-Antispam-Report: CIP:12.22.5.238; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:mail.nvidia.com; PTR:InfoNoRecords; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(40470700004)(4744005)(336012)(316002)(426003)(1076003)(36860700001)(16526019)(186003)(7696005)(2616005)(36756003)(86362001)(508600001)(6916009)(5660300002)(107886003)(4326008)(2906002)(356005)(70206006)(26005)(47076005)(40460700003)(83380400001)(6666004)(81166007)(8676002)(82310400004)(54906003)(8936002)(70586007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2022 09:21:20.6872 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f40952eb-8491-4098-5d4b-08d9e23f8bf3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[12.22.5.238];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT030.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3531
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220128_012123_517338_27EE514F 
X-CRM114-Status: UNSURE (   9.83  )
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

From: Chaitanya Kulkarni <kch@nvidia.com>

Use helper to remove duplicate code for connect queue initialization
and error handling for all fabrics transports.

Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
---
 drivers/nvme/host/tcp.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 4ceb28675fdf..6cbcc8b4daaf 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -1825,11 +1825,9 @@ static int nvme_tcp_configure_io_queues(struct nvme_ctrl *ctrl, bool new)
 			goto out_free_io_queues;
 		}
 
-		ctrl->connect_q = blk_mq_init_queue(ctrl->tagset);
-		if (IS_ERR(ctrl->connect_q)) {
-			ret = PTR_ERR(ctrl->connect_q);
+		ret = nvme_ctrl_init_connect_q(ctrl);
+		if (ret)
 			goto out_free_tag_set;
-		}
 	}
 
 	ret = nvme_tcp_start_io_queues(ctrl);
-- 
2.29.0


