Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99D49C7619A
	for <linux-nvme@archiver.kernel.org>; Mon, 27 Mar 2023 06:06:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Q2BOTq/KCo5EQEeRbMvOcuIlwOQQ0fnpD6Rq1ENkHx0=; b=H83BQKDMm4azEJpK5WR29NffLk
	AFIxFTAa1QLfykg0c+qWb21YxVpO9xuDmfQ9jhB2KDliPWTo9786/2t9w7W7TyD+dt1imtnN8lJtK
	B2j0lsgB3eWCoQ6E6wp/AkizuHfVJ0ppia/5rH76FEW0wHRBz/QxuoQJy0dRh7Bmifa3r4MZmRRwV
	HJY7KeYM952GO2m3l75eFFy6D3eHjz0KOncE8RrctG9ag3Y1YQ29E+Kg7+iQ9Rq8Vbc7m5IvN6/IJ
	Swltuzdae6I0cLYg1/rsIDhaZ2wTsTO7emj+qXp88lV5FQS5ESH3kQTJHYQ+E2mxoeIHEZa1UuFa/
	D8f8mmUg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pgfzq-009uVk-1d;
	Mon, 27 Mar 2023 06:06:22 +0000
Received: from mail-bn1nam02on2060a.outbound.protection.outlook.com ([2a01:111:f400:7eb2::60a] helo=NAM02-BN1-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pgfzn-009uTM-2d
	for linux-nvme@lists.infradead.org;
	Mon, 27 Mar 2023 06:06:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VCzvZOaqKfNKfhvZGGmlyEACxQfGMvV1F6ZBWfggxUtOmFckjsBeftX0NYqi6J7cIEdoY7OP84cTuaxXcTRLrNP/ILhNo3SqyyGJOZYh5ZJooM1IcggDtYAoJ4DnQiBoNbGXyEXlY/H4kiZ5z6Xl7Xh5+rfavOkIkWDTlclhDoTdXx7NCfrxKCSOzpwnY2SLxO9D+8Qrymb9ElQq6Hxr1srPXH0/C4TkrHiMySgXnQsf3wKIdl11ZgF9D1sB+CLJLelO9Sy+Jl3lI8DW4SCS5GpOe3ScsctQzWqoG2ToRZdctIB5r8PbW+N+iYm6ZNDFjrSZ4p00/QxliYLlwOQzJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q2BOTq/KCo5EQEeRbMvOcuIlwOQQ0fnpD6Rq1ENkHx0=;
 b=QJPeD/gFK7bJc/mMOqfteXcO/ghM5sVkzHZMJGqrIVPSTzQdn2WIqQcHnljUw4BTFZM6AKUBTlqYgqG7FXZm9Q83j0njAJuMcMptrwBNj2KL8WpFO4sype+7Ga5zC6gir2cc7m66JObkqvCWhB9neTeGxx0FY6FW43n2om3QdcN5iOBb9xY75wE3F4CM4DSVsF4Lm+ok2qWwC8lFzrAYzxCW0apZkvjFnUiukyOsPs3VAY/0JnRdsvVZLHTRmMzx3CJHqTxa+iLUwPTNHxmrue44ZEdlzFvTnANlsFOSoYRw93MptPrRIPzX12ULDZXQtBwqHtU9BtZy1KSkofrclw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=lists.infradead.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q2BOTq/KCo5EQEeRbMvOcuIlwOQQ0fnpD6Rq1ENkHx0=;
 b=ddCJM3hJH+eAHhN1HW64dpc9izjo6I6cnfGcRstWHTOB3kFDhyQ0alUqamhoxJ/3ksXX498Fem5uxw3o57LWpG32gWMWPvB9BVlEUhGb8Llwt39Hdv9yqb/toTra0ZKcylaHngr5GVUvwBrWARLU495P3GMfRtuH82V7XkbT15bIU70xoaioRIaoW1g8NC2MbSzqtklzSk/RFKPaeKo7rNbj9UmuiB2jC7p75Y+++zEwLgiKIO7HpXYKX5yId+uGBrY9g/cMEH7y0fhU/IIu8AN2/j1O9KFwOdkExsC22keuQkKWMftVlSMFZ5spjgI77WJ9PNA19CmTIHKe7mqr7Q==
Received: from MW4PR04CA0108.namprd04.prod.outlook.com (2603:10b6:303:83::23)
 by SJ0PR12MB6877.namprd12.prod.outlook.com (2603:10b6:a03:47f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.41; Mon, 27 Mar
 2023 06:06:14 +0000
Received: from CO1PEPF00001A5E.namprd05.prod.outlook.com
 (2603:10b6:303:83:cafe::93) by MW4PR04CA0108.outlook.office365.com
 (2603:10b6:303:83::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.41 via Frontend
 Transport; Mon, 27 Mar 2023 06:06:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1PEPF00001A5E.mail.protection.outlook.com (10.167.241.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6178.30 via Frontend Transport; Mon, 27 Mar 2023 06:06:13 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Sun, 26 Mar 2023
 23:05:53 -0700
Received: from dev.nvidia.com (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Sun, 26 Mar
 2023 23:05:52 -0700
From: Chaitanya Kulkarni <kch@nvidia.com>
To: <linux-nvme@lists.infradead.org>
CC: <kbusch@kernel.org>, <hch@lst.de>, <sagi@grimberg.me>, <hare@suse.de>,
	Chaitanya Kulkarni <kch@nvidia.com>
Subject: [PATCH V2 7/8] nvme-core: remove unneacessary else
Date: Sun, 26 Mar 2023 23:04:17 -0700
Message-ID: <20230327060418.86655-8-kch@nvidia.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20230327060418.86655-1-kch@nvidia.com>
References: <20230327060418.86655-1-kch@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.37]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF00001A5E:EE_|SJ0PR12MB6877:EE_
X-MS-Office365-Filtering-Correlation-Id: aaf42849-cfd4-44c5-caee-08db2e895ec4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 	Z7OyjYAxW88nK/28WwtB2u6I9lvNagw8/HN0pNqNGJRJcFHuN4npkjcY6WBPitjdFVoAJUQq0wzx9MVJWf57aVSUTBQrKGare7AlNJAV51Rg2+gHDG/X0LL+0xUcbmg/E4C+0RELfReyuzrt365de2oS5DXUtWueP0eQUVr8rQSFoEXxREEbKSwmI+wBEJNEWAgnEFi3fd8gxbOIjmPAjboYOBhZKkm3S4XVPCH0ea4Amah0caCXu84zAaeM9YZR7+ahhxroLwrTvvaX6+Dxrk1JI1/2+yHCzeCyxNlywqO8mkeOv3JvOY9D4pnNKEIj6RRJfCIjNqOhFJegpnAJG5HsZGHq8Fxdu2q3kPMkkyEC8N11hw9g3FwGvpEmaZ2jr3zVQLts0Gd/HnlQn3vqUhNPdBtbbu5wDI1nC4wGx439pEzZ57Zs9IWxyW8kJ+wt/bIOc+MjTcpR8SDTi+oH3mVReB12nZH1E+J23Xa8TIwAg9s3a9i8M4XD4I2yTw8W1V0wncYJRaENMnBVfi8b6dX9mWtY/3nXrkB5Lruw59jamPm0TMrn08yKjnhMPv9+DIUeLkhI9RHIwYze2xSQwRo9gmcCbmgMQPWoe2c5IwBg69oPlSbJKCPYGalAneNpRg1pg/W2kf+u+hoQvg6rxasZ8PBEBmhKirs13i8J47CjgOY7dw8W4186A65/QeiP+iH6ewF0HWIoaW++4ZOP+cIOv3A5xyL0tcjpew8q/uiHDhFEVp8vz/tDaEZvDsyj
X-Forefront-Antispam-Report: 	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(39860400002)(136003)(396003)(451199021)(46966006)(36840700001)(40470700004)(82310400005)(36756003)(356005)(2906002)(40460700003)(478600001)(6666004)(107886003)(83380400001)(336012)(1076003)(26005)(7696005)(2616005)(426003)(47076005)(40480700001)(54906003)(4326008)(70586007)(36860700001)(6916009)(316002)(70206006)(8676002)(186003)(82740400003)(7636003)(16526019)(8936002)(41300700001)(5660300002)(4744005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2023 06:06:13.7472
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aaf42849-cfd4-44c5-caee-08db2e895ec4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: 	CO1PEPF00001A5E.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6877
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230326_230619_854949_78055A74 
X-CRM114-Status: GOOD (  11.53  )
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

There is no need for the else when direct return is used at the
end of the function.

Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/host/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index bc1091953562..fda851e8b7c6 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3418,8 +3418,8 @@ static inline struct nvme_ns_head *dev_to_ns_head(struct device *dev)
 
 	if (disk->fops == &nvme_bdev_ops)
 		return nvme_get_ns_from_dev(dev)->head;
-	else
-		return disk->private_data;
+
+	return disk->private_data;
 }
 
 static ssize_t wwid_show(struct device *dev, struct device_attribute *attr,
-- 
2.29.0


