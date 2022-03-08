Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C45C2C433F5
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Mar 2022 22:57:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fEXCuEhVmKMfrnbcsLOYCke4+St+mYUL0FZAgYHLaeI=; b=dl9Dg5CgwuRYkesrNRIKsBGPuE
	jI7UUeGoUgwwtDMUigI04fWj0NQrpAnxtTiuD5/mYhNxg9eVU8f1rV3Iv8IfYZCo4/hJHEsP0hG16
	dq9NWMhZv1nykieTUfhcBjfGfQDTTm3gMAiVuX+GTl/13cIei1mnKv32M0gja6hQnqab70qJt8Wbu
	MjdUXTYXBHqPBCC8RAcqlVVVLL5qU6IyI69DnBcHum8fK9oaTR27WvWwbaKoaoPuXc8ZKqH5fcl6h
	VEJaMuP5MWMU4Gy8v3OLHxbYm7jtAbczgi93mUBbp1q+M2W2OkkAXKNGxnnM8u1qQ5m9BsgtyX1q0
	oNE1Jf/A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nRill-006SoF-DW; Tue, 08 Mar 2022 22:57:29 +0000
Received: from mail-bn8nam08on20613.outbound.protection.outlook.com
 ([2a01:111:f400:7e8d::613]
 helo=NAM04-BN8-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nRili-006Smi-4n
 for linux-nvme@lists.infradead.org; Tue, 08 Mar 2022 22:57:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IWx+Ub4huUmkPGY6tlZIXEIBLzcbItlQ4LK/wL3GixzzVNxl/IAy5JrPi4fXQ+B6JLK6NEhe1LjkRliLw02nzmTVylX2377uAifYYlaGWXyB8IyeFElhcM4LHYwVCNfsQh8VjA+34GBOxPlcaIlmASHGApEG0ENEYns/2F7NcXZk2II2bZ9wSzgxv3Tv+kUvctgMpLxl1/t19kKSSxL21k5/Fl5LGAS7u+jrwkUh0vEOhR4gkG4pPgsqgCM4rkbL6Fmn/JjIjphlrCsSexT/gwI+GNJiav6X4yaKe8QC+YneVTihxAnlO4QJK/Pvw/9t0e9a1laPnHUrIL3sSZbZrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fEXCuEhVmKMfrnbcsLOYCke4+St+mYUL0FZAgYHLaeI=;
 b=KWb/1z3Q/GfjT1LFFhxZ0XAF9ltbCTA46TGbv882VJtBUVXJfp0a/H+F69deC02kV+iCMqZgoFU++Mj99eoEk2kUtBTEjI90ZYIwAfQ8D9HFY+zex4Bh/oTjGG5QT5LAIgUHE0Qfz7RWcPqcP22Ye3Mew+0fuI7hJ8th8R+1MYCNBbOg3qxAJkEfJkucPgjA2SRHULIlkHHqwrlJepDFtmo5BytJ+sSI4BIoDA8tuo1x5nO89nJw8KZV9OVtzRFdHp8fxHS2Izspxxf9EQzdtxsmrMvjRkh3JQgkUbWGYEyqIhLQR8LXJtAIZV0ZU9YudqWOLxp0d4CxRmBRbiNsZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.238) smtp.rcpttodomain=grimberg.me smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fEXCuEhVmKMfrnbcsLOYCke4+St+mYUL0FZAgYHLaeI=;
 b=oTAt/FxAJe2Ef6z32pOyfAomZhd3WZzl0CpYUbR6d/C2Y+pdXN9LpP9sJ0MGxDHm4itE7b3zHMS3lAIvw1NCCH6ky93jj8ioxX2pgRwZLl8PxNHTiYVeC8QZBTxBl+DJx4L22F5xBLrzotOtCyMPeGvIWdAXdjr76E+27Sff4vVQlwwwb5s7tW0WXxE+AUlBMPgIeQf13vQTL5y8VW7nCZ8RvbQcpIBVBFwciRBy0t5ncdSbl3ngRGpQRedZZTftkzrAWV8nEpF2n68+iDr3G0ah7+ciHPFyL8iUucFNM68/w9/wtF1h+UIKZT4lPdpV1mSyw3WKBEiplQqjfq2Fxg==
Received: from BN0PR03CA0045.namprd03.prod.outlook.com (2603:10b6:408:e7::20)
 by CY4PR12MB1654.namprd12.prod.outlook.com (2603:10b6:910:3::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.15; Tue, 8 Mar
 2022 22:57:20 +0000
Received: from BN8NAM11FT053.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e7:cafe::27) by BN0PR03CA0045.outlook.office365.com
 (2603:10b6:408:e7::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14 via Frontend
 Transport; Tue, 8 Mar 2022 22:57:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.238)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.238 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.238; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.238) by
 BN8NAM11FT053.mail.protection.outlook.com (10.13.177.209) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5038.14 via Frontend Transport; Tue, 8 Mar 2022 22:57:20 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by DRHQMAIL105.nvidia.com
 (10.27.9.14) with Microsoft SMTP Server (TLS) id 15.0.1497.18;
 Tue, 8 Mar 2022 22:57:19 +0000
Received: from dev.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.9; Tue, 8 Mar 2022
 14:57:17 -0800
From: Chaitanya Kulkarni <kch@nvidia.com>
To: <linux-nvme@lists.infradead.org>
CC: <hch@lst.de>, <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>
Subject: [PATCH 1/2] nvmet: don't fold lines
Date: Tue, 8 Mar 2022 14:56:57 -0800
Message-ID: <20220308225658.8202-2-kch@nvidia.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20220308225658.8202-1-kch@nvidia.com>
References: <20220308225658.8202-1-kch@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 481afd67-2994-4ed0-dd53-08da0157001b
X-MS-TrafficTypeDiagnostic: CY4PR12MB1654:EE_
X-Microsoft-Antispam-PRVS: <CY4PR12MB1654FBD452AE78375EE9DE66A3099@CY4PR12MB1654.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Tzo5aNdZySnld62scjMSxfmZUtaPj9p4jtkYw1n+gku/GUlDJlhl8z20drG26bUGrAqwx5DwQtw4oiQ0ZP1skecUY9SpUEayhAKDO0Di57Sx+eJXQuNMcWBZZmm5DXRCWrCuedRsvQfj408v7IrRAe7wPXnJYxWmoglvAr7HWUzf/R8K83ZEvWdIsBgQlDwol/38TC5iik7PWGepGsnoghS6cIntDCKvA7MadOdQaHTBmmSZAzsRicgnzXJ4X9OaSX8sL5xW14V1M3wsgVdf3BHzYleNfDGJz2u2xIOuqwVRn/FwzVQKqi/XzrVfpJpCXZn0ajUY3sBM/Yh45sZaysVuYjG0iQNcrQZBaqxjdjd8GEQnKTvXhKtnH1beGaaeNYpXerxIjCnC965xfeTDMmnp44+drqCTABBnNmbcj/Zbsky+dPSlJWIw99q9phOmYmWpR6eiwvDquBKNWtprISScaTxAdfDwlsoggBRe5pRcgocJF/VLaYsX14X0prm7W8iYtrJkWNgMQ8Y+gWMNT70Ihc7gX6NYtY2V+qGvrrTIz6H2xVXq5epinf/uaxI2LXbbuulzzw+b8RRPIZPIRJtcp4bfEuERsQNhIsBGvuthZyUG9fye99S90v0vTkOZMOakQrQXTGpH6b7lzY7fb5Rhs/yqyckOiodBHAZYDmKVyY7byKE+WycQ8HvAtfyk1xaxIRqnXmu5dWKqXG1GpA==
X-Forefront-Antispam-Report: CIP:12.22.5.238; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:mail.nvidia.com; PTR:InfoNoRecords; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(36860700001)(70206006)(316002)(47076005)(4326008)(336012)(82310400004)(356005)(6916009)(54906003)(81166007)(2616005)(8676002)(83380400001)(40460700003)(186003)(426003)(1076003)(107886003)(508600001)(36756003)(26005)(16526019)(70586007)(6666004)(5660300002)(8936002)(2906002)(7696005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2022 22:57:20.0236 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 481afd67-2994-4ed0-dd53-08da0157001b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[12.22.5.238];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT053.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1654
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220308_145726_210850_FA6122FB 
X-CRM114-Status: UNSURE (   8.23  )
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

Don't fold line that can fit into 80 char limit. No functional change
in this patch.

Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
---
 drivers/nvme/target/configfs.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
index 091a0ca16361..0f5c680c851a 100644
--- a/drivers/nvme/target/configfs.c
+++ b/drivers/nvme/target/configfs.c
@@ -93,10 +93,9 @@ CONFIGFS_ATTR(nvmet_, addr_adrfam);
 static ssize_t nvmet_addr_portid_show(struct config_item *item,
 		char *page)
 {
-	struct nvmet_port *port = to_nvmet_port(item);
+	__le16 portid = to_nvmet_port(item)->disc_addr.portid;
 
-	return snprintf(page, PAGE_SIZE, "%d\n",
-			le16_to_cpu(port->disc_addr.portid));
+	return snprintf(page, PAGE_SIZE, "%d\n", le16_to_cpu(portid));
 }
 
 static ssize_t nvmet_addr_portid_store(struct config_item *item,
@@ -124,8 +123,7 @@ static ssize_t nvmet_addr_traddr_show(struct config_item *item,
 {
 	struct nvmet_port *port = to_nvmet_port(item);
 
-	return snprintf(page, PAGE_SIZE, "%s\n",
-			port->disc_addr.traddr);
+	return snprintf(page, PAGE_SIZE, "%s\n", port->disc_addr.traddr);
 }
 
 static ssize_t nvmet_addr_traddr_store(struct config_item *item,
@@ -199,8 +197,7 @@ static ssize_t nvmet_addr_trsvcid_show(struct config_item *item,
 {
 	struct nvmet_port *port = to_nvmet_port(item);
 
-	return snprintf(page, PAGE_SIZE, "%s\n",
-			port->disc_addr.trsvcid);
+	return snprintf(page, PAGE_SIZE, "%s\n", port->disc_addr.trsvcid);
 }
 
 static ssize_t nvmet_addr_trsvcid_store(struct config_item *item,
@@ -1236,8 +1233,7 @@ CONFIGFS_ATTR(nvmet_subsys_, attr_model);
 static ssize_t nvmet_subsys_attr_discovery_nqn_show(struct config_item *item,
 			char *page)
 {
-	return snprintf(page, PAGE_SIZE, "%s\n",
-			nvmet_disc_subsys->subsysnqn);
+	return snprintf(page, PAGE_SIZE, "%s\n", nvmet_disc_subsys->subsysnqn);
 }
 
 static ssize_t nvmet_subsys_attr_discovery_nqn_store(struct config_item *item,
-- 
2.29.0


