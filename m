Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D93DC433EF
	for <linux-nvme@archiver.kernel.org>; Wed,  2 Feb 2022 09:06:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=DTn7D7HpIC7BxAztNFp2ytUulN2iN6TXAPLsNPG3Oo8=; b=odz/mbg0ZoMYpZkfX11VeLvadp
	FWJUG4VvAYxkeBIYgQ9zvo/83aoFJMm1tKblft5a1qINZfkPBs1jPZQn6L5iis5ZZBC3RJjh/BBle
	r/KbfC06oSyEts/42g/aQujDIDkCFZhSRGPBNGQh69IFiPIZ+4+GlMDs+AQqQY4wRzM+18IVqk1B8
	1QhsNa2DTj6eU+0+GZVvRNMGVDcrLpnu37BF5ElGEYaP24ImHW4v3Wsa4SFvnbYx3ZWJb59OUUd7O
	HgqT/x++5yIYIg5ykWQbaKE5hKWa1FcxpsDjPgEr5LPIGjmqtySQoFRcfLX7LZzODSoq2UzvwFKlo
	88gR12+g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nFBaY-00Eh5d-Lj; Wed, 02 Feb 2022 09:06:06 +0000
Received: from mail-dm6nam10on20600.outbound.protection.outlook.com
 ([2a01:111:f400:7e88::600]
 helo=NAM10-DM6-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nFBZx-00Egqg-S9
 for linux-nvme@lists.infradead.org; Wed, 02 Feb 2022 09:05:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WwMbnNQ35LPLIxqoYPJqYKU0L5U4dUwB+0MzdLSGv1lQ8YBtvT9eZH3kRuNWazeefuxrt2h95fQ467HlrmSKpLCsSK/F6cDccrMwAgGX87fdGGMdSWIyjAEy9HVRo0WclR10KBCtQ7I09xb1MHJjNe5DYqN1dBJwXoEwQSRj2MebIcM7q2jDsn9HjOSp4ZGwWwXAdZmVGdj91HOqZtzloWQo+Zrzm+7x3CUe0CLRGPoVo64fIph0bbc9yrH6TcAuoxTkClCi2Xns5ldddKe1vj1UcohiMK7yaMqfaM2Xgm9pri+WWm7q6ySGSG3ZtBuu+yjXp/KpfsVm+M36QaEo/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DTn7D7HpIC7BxAztNFp2ytUulN2iN6TXAPLsNPG3Oo8=;
 b=HVYB3gHJGqfy097a9tkok90+fTTGcbFXXiKnpiDV/+93sMMzbNcgnmPRO6HQRIdic9ZF3LueguXWpLDrx7f4n6bUVjUpC9Ym6zasm0DKfcU7n+kngDqq0jCQAzAEuIQlA7I6Vm2lqz1ycN1sEtxjmNkoikLXxzjQEYlHcwdAREVQuwVDhXK8Ebo2xke3/ZkkFr8mWcRpyHupOoLPmnF1oH4nqYyKZuWeZQKCdpvdPFZjnniIg7JnzzBmp7Oi+bdMXj/uvwJ+piPMdvubSXut9TbgCjS+f/wSf6PFqKuAwxgfpR0ODeHBFcMCaX8Gqq0RrjT8nbUKgu/pZaQ7v4GaIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.235) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DTn7D7HpIC7BxAztNFp2ytUulN2iN6TXAPLsNPG3Oo8=;
 b=OSHywd9EBsUzN6oB7MbvyR7EEdY4P14+Wnbx6Z44QeGODD45utuFF2ZoUzyj2VEwR2q6Ox9FwWwpGo9ZvUaiP7uK7yoW75mN8uPpAyihRCORpoeYmwjjD0lmg0PVf1/kjCgpHN/GVbQW0YgdZpPNEe277W/7m8UTu3TaKt/kInvhbCafJ635ML9V8T99/VXWUWxkJiGIBGCc8xeohxcW0Y7UH/Q8Se3nZYaZ1LlJbQIPek/SSBxX8WLCOFsl62spPNT4c6hQS3dKE+1OsMNT8xF2n43Tvghs64HK75TjxrPC4KqpjHnnV0I2g/TAkxUSLw35k6A1eTxKaI4CCEF2nQ==
Received: from MWHPR12CA0037.namprd12.prod.outlook.com (2603:10b6:301:2::23)
 by SN1PR12MB2511.namprd12.prod.outlook.com (2603:10b6:802:23::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.15; Wed, 2 Feb
 2022 09:05:27 +0000
Received: from CO1NAM11FT056.eop-nam11.prod.protection.outlook.com
 (2603:10b6:301:2:cafe::c0) by MWHPR12CA0037.outlook.office365.com
 (2603:10b6:301:2::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.22 via Frontend
 Transport; Wed, 2 Feb 2022 09:05:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.235)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.235 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.235; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.235) by
 CO1NAM11FT056.mail.protection.outlook.com (10.13.175.107) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4951.12 via Frontend Transport; Wed, 2 Feb 2022 09:05:26 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1497.18;
 Wed, 2 Feb 2022 09:05:24 +0000
Received: from dev.nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.9; Wed, 2 Feb 2022
 01:05:23 -0800
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: <linux-nvme@lists.infradead.org>
CC: <hch@lst.de>, <kbusch@kernel.org>, <sagi@grimberg.me>, Chaitanya Kulkarni
 <kch@nvidia.com>
Subject: [PATCH V3 2/2] nvmet: allow bdev in buffered_io mode
Date: Wed, 2 Feb 2022 01:04:45 -0800
Message-ID: <20220202090445.43615-3-chaitanyak@nvidia.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20220202090445.43615-1-chaitanyak@nvidia.com>
References: <20220202090445.43615-1-chaitanyak@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fd1c4d23-75b2-4ff2-56a0-08d9e62b2754
X-MS-TrafficTypeDiagnostic: SN1PR12MB2511:EE_
X-Microsoft-Antispam-PRVS: <SN1PR12MB2511931EEB37F064036BE22BA3279@SN1PR12MB2511.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rdaT8hClTlt5zycsruBdFQ0/tEXvhLqQQMbzx6nGGBYPd0yV5pfkeOafxH+p/5JPsXqGiNIRjAsJDZlNNKqEYptMIHTQMRB0Ek5MgE18g33Mky5uxOJ8g0zo3lFyjqJjLiolri/VVJsHGMd7wXqALewq4V8qY9OdqS8n1NmDa2BNJ4Mg3fVxyghGdCpVgLOAqVgybMPsHqCOMD3RDuIezUA9Co6e8G6hT5IrVwu7YVT0IwiBTUE4wINsr/6A/wEgPuy9HzTEE5s5edwRGl5wwaFm5UtIwZrxYQpBbaDSaddcqBz/skpx8cCFe9DNq8Ocadxwg/3JfgD+B2SmapFCodjTupKv/7AK8TXhsW/VblCfjRwM6/r0K+lPP/b/0r57gFQOX1+gTpR9r6ZttAdPt+DHIQoqOo87FCfC+SrDlJlD+hpWVcERtcC/YRX0+L68Lpn7KgDJv1aKvxb+9n6C7ZDZn93At99NmFdwnE3KqfNROmZ3zzoIayS5r0s8tvj0pi4FHX+9i57PIEovXDXcALYqhi24/ULnuIuWSd5VSwejjZDVhbz45k0IwYoEZWCyHEiuMohPXJrsaLhNduMSMcfyuuFyIAvkgXKDA2ir4wkrdo1MzOHGEnDkk6aBsV1dxZzb8xp2WhsEeQpO2cNgZ97+fQJ96YjcsAtVoA2kd1Xb6dOOazu3+S+jCNO+75EihyWCjuzYdEevGJssGTYMrw==
X-Forefront-Antispam-Report: CIP:12.22.5.235; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:mail.nvidia.com; PTR:InfoNoRecords; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(81166007)(40460700003)(356005)(47076005)(86362001)(316002)(36756003)(6666004)(8676002)(8936002)(70586007)(54906003)(4326008)(6916009)(70206006)(508600001)(7696005)(16526019)(1076003)(2616005)(26005)(426003)(186003)(36860700001)(5660300002)(82310400004)(107886003)(2906002)(83380400001)(336012)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2022 09:05:26.6206 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fd1c4d23-75b2-4ff2-56a0-08d9e62b2754
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[12.22.5.235];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT056.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2511
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220202_010529_972319_17AF4532 
X-CRM114-Status: GOOD (  11.13  )
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

Allow block device to be configured in the buffered I/O mode by using
the file backend. In this way now we can use cache for the block
device namespace which shows significant performance improvement.

We update the block device ns enable function and return early when
buffered_io flag is set.

Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
---
 drivers/nvme/target/io-cmd-bdev.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/nvme/target/io-cmd-bdev.c b/drivers/nvme/target/io-cmd-bdev.c
index 70ca9dfc1771..8b2cfde7ad63 100644
--- a/drivers/nvme/target/io-cmd-bdev.c
+++ b/drivers/nvme/target/io-cmd-bdev.c
@@ -76,6 +76,14 @@ int nvmet_bdev_ns_enable(struct nvmet_ns *ns)
 {
 	int ret;
 
+	/*
+	 * When buffered_io namespace attribute is enabled that means user want
+	 * this block device to be used as a file, so block device can take
+	 * an advantage of cache.
+	 */
+	if (ns->buffered_io)
+		return -ENOTBLK;
+
 	ns->bdev = blkdev_get_by_path(ns->device_path,
 			FMODE_READ | FMODE_WRITE, NULL);
 	if (IS_ERR(ns->bdev)) {
-- 
2.29.0


