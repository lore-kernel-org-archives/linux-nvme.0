Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 081DDC77B61
	for <linux-nvme@archiver.kernel.org>; Thu, 27 Apr 2023 08:05:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=kbMtWUdoE1WEUDTfSrjIoh6321caHvnddWv53zP8IBQ=; b=eYo3E9eQGxY8l3si+IL3Qae7WT
	5YNZGp2v1trDUwCfosdG7G/aK3pFY+fSLzAaIboh04vWh+sUBLPXRJGRnfjCC4JWQSFLqzQ5ttPRe
	gKP6gu9xjKksWzbedec2/DG3SSECzoCv9+4LbaF+sq70Vkbx2jSSvpy+072AFIMXLILE3LtPWueTo
	9xI5l3W4Ce874v0d0tDGheK7GD3lLpXmwdJxGrnAywJkfkkvy450gB8pnEt/KIiq5CJy08PvpK0e7
	COGp6+Dj3yp9jbqLZYQbN8JHv4NmJmuEcNYQzp+zaNhY2efryYtwpq91+E0/OlMgfGU7aVYNB5nOj
	4w5QSUbg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1prwcz-005lVi-07;
	Thu, 27 Apr 2023 08:05:21 +0000
Received: from mail-bn8nam04on20628.outbound.protection.outlook.com ([2a01:111:f400:7e8d::628] helo=NAM04-BN8-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1prwcw-005lTp-2c
	for linux-nvme@lists.infradead.org;
	Thu, 27 Apr 2023 08:05:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aBTD2GtMqZlWvM/qICFiEVJ+XllgNFshh78ReaPP5iTRerYhj9ZosPpUQQTlnK0O9JbgY4FsE/OwsRFdtlNJYEOpsvXxn19JuOv5hkvbDEP9CdwmCl83r+pPonZ5pJFvoPmdt13w5HOJW47MOGrfaJfn6ZQZ/abcQNPP6atnIe+zRvDSfMdoUI6uzfegffhlvw2rLrIPIuUkCHD+w6dOepbH0ohwsktlKBvvSrTFED2aY+gYU43cxj2jURcqbrr7VYChCGq4CX14JE855NXC1cwZhufDhyBm7I6E4YJyKttW7YwfWspimvUx2H4JEZSSJ5ZCGFkuCZaMH1s1wmLsXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kbMtWUdoE1WEUDTfSrjIoh6321caHvnddWv53zP8IBQ=;
 b=IH5Oi3ZF9+rft4PHRjzLXobmsnce+ooS8nRrau/+7QR5X+38KlcmYczZiHHgwXVmvJ8gA5jk9t39UDU1CjSEXJ9lzaicBYva0JpMPTFnnxWr1S3bbD5DOqr8fKU6NknKO15KrSzkHLORvv4Iyf+FT7Z1XcgZ96Y+5kqWwDiepFwr2jH3MKkqDNYAXR/UMvNBNE3fk+AgMO8KuJB0Nqordt73oUUX7zH8Czo3bP2gBzvOEtqsCeYGWB3KPyrwEg/zGa6/dhKF+diou90YptHPtdO/I7Bu0syMaUWXx/3oBE4r20Y3Uv/Euzmpz2o5gzi3xjmk6S7mMXp136NdkJWiGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=suse.de smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kbMtWUdoE1WEUDTfSrjIoh6321caHvnddWv53zP8IBQ=;
 b=dJd3w9VvP7HGyGWtBbNP+caj0N/wRnoXI2zIbrB+8aOpfLRABSE+G+9Se8W7MtWyX+MQScn90jLS5fMbWcN7cBJh/AwdY5ihisEA//G052PClLN5edoMs15jWlRk6gFeMWzfA7/pTf2bsJIRwYdGrfMIE6LPqvHcC2X98g2v0WKYI7iYZ32TsvAKSz01hbz9dqJzopA5Krmi5jhedcoHvqhu9VrW5G9RaaJ8rbncW9uRh5S6aiskY+FtGDPdBPH04RSep0Qzt6wontwYROuwsRFM8XQwzLDsoBdZQkathGRrjTJjETeg+dN2ogVRpDLzYuYIsbB2eqSq3o6vkivtLw==
Received: from BL0PR01CA0018.prod.exchangelabs.com (2603:10b6:208:71::31) by
 SN7PR12MB7323.namprd12.prod.outlook.com (2603:10b6:806:29a::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6319.33; Thu, 27 Apr 2023 08:05:14 +0000
Received: from BL02EPF0000C406.namprd05.prod.outlook.com
 (2603:10b6:208:71:cafe::17) by BL0PR01CA0018.outlook.office365.com
 (2603:10b6:208:71::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.22 via Frontend
 Transport; Thu, 27 Apr 2023 08:05:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL02EPF0000C406.mail.protection.outlook.com (10.167.241.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6340.15 via Frontend Transport; Thu, 27 Apr 2023 08:05:14 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Thu, 27 Apr 2023
 01:05:04 -0700
Received: from dev.nvidia.com (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Thu, 27 Apr
 2023 01:05:03 -0700
From: Chaitanya Kulkarni <kch@nvidia.com>
To: <hare@suse.de>
CC: <kbusch@kernel.org>, <hch@lst.de>, <sagi@grimberg.me>,
	<linux-nvme@lists.infradead.org>, Chaitanya Kulkarni <kch@nvidia.com>
Subject: [PATCH 1/2] nvme-core: fix memory leak in dhchap_secret_store
Date: Thu, 27 Apr 2023 01:04:55 -0700
Message-ID: <20230427080456.18232-1-kch@nvidia.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.37]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0000C406:EE_|SN7PR12MB7323:EE_
X-MS-Office365-Filtering-Correlation-Id: ccf522b4-b29f-45f1-f79a-08db46f621b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 	c8mtHfcojj3uyGEwubWgzaNgevMvfMmU80tYjBzZPqlK6dtatYO5c7j4NZN/xwpvMRoZRgBO4xiZKZ8N1cXWsVejW46BUwf9DMp3MsyOa7y3XHvjO2QDVMXhck5RCRdT1YugDT7pYP/BmqFLLqo4E0zB2gWkRlC/3apoG76T3vQYDIcYxiIoIfcaBDwl5R5KuPuv53v4mkwgMOhbknUF7Fl10lqMPVYQMDM/WhN2Uv5mUtzqJ45fiZunRDEL4f5AYpCwgMXjkdqMZeIfQ6Rm5eWhQ83DOx4y41o8HZ9DnS903HyhpDEfT1JEPgb+RD5sNawa/epNv8RSNIey4yUIROTGFbkxPgv0MVw9BefdsWQFUQcQLmstdmp5Cajtt20tGvkEwVvvMLWHeCdHCHg4p5qE0GOdgliwgWAWLFH4KxzNJTWbRFixaTiLCc7tiI8WQi7zNmggIG7BuJUSrYPH3iJof8c9VBFfVwh4IL1kmprU8/4SDVipW/kvYq/Fl4ufN2/KVTIfKABrLyKgIYiuzUpXa4uD87tt1yxioNH8T3tIsIZhGcdo+y+riZMXmYoimwtL2xzM2C8vO2YvD4OwNndGKgTuCNCuBlyY9vgqmqp6LwQDE6uPIla/mMC9vmJxsGN3+oDMXR/vH/1QuhGFuf9POBksjCv6r6EIbRLMJ9PAxcCGDWGSkVx+kd+qTc5sSS6D3TwgTA++EWnOW1hpo0ZJ8F7kPf1fnSNWzRQr/3c=
X-Forefront-Antispam-Report: 	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(376002)(39860400002)(396003)(136003)(346002)(451199021)(46966006)(40470700004)(36840700001)(107886003)(47076005)(356005)(4326008)(478600001)(7636003)(82310400005)(54906003)(36756003)(70206006)(4744005)(6666004)(6916009)(7696005)(70586007)(2906002)(82740400003)(5660300002)(316002)(26005)(41300700001)(36860700001)(40460700003)(40480700001)(336012)(1076003)(8936002)(16526019)(2616005)(8676002)(426003)(83380400001)(186003)(219293001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2023 08:05:14.2235
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ccf522b4-b29f-45f1-f79a-08db46f621b1
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: 	BL02EPF0000C406.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7323
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230427_010518_852321_4FBA93EB 
X-CRM114-Status: UNSURE (   9.68  )
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

Free dhchap_secret in nvme_ctrl_dhchap_secret_store() before we return
when nvme_auth_generate_key() returns error.

Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
---
 drivers/nvme/host/core.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 518c759346f0..5a9d97c0c0c1 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3814,8 +3814,10 @@ static ssize_t nvme_ctrl_dhchap_secret_store(struct device *dev,
 		int ret;
 
 		ret = nvme_auth_generate_key(dhchap_secret, &key);
-		if (ret)
+		if (ret) {
+			kfree(dhchap_secret);
 			return ret;
+		}
 		kfree(opts->dhchap_secret);
 		opts->dhchap_secret = dhchap_secret;
 		host_key = ctrl->host_key;
-- 
2.40.0


