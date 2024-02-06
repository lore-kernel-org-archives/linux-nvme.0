Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16B6EC4828D
	for <linux-nvme@archiver.kernel.org>; Tue,  6 Feb 2024 00:31:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=dJLjUfsJN34Ks7fFMNWK9pv9ToDeYqN5S/YD3kRtzOE=; b=bXxgiTu8g2dAPCITFGyOZl7Whf
	2Xf6rxx57XflodFiK1ojpfxjeWrl3SpOi09E2qLgdRYoWKDtkX7KEy+adMAC7IklRvvwbcUBaL+Lk
	m5761k5mZ5Hb1MU1LQ6+cYWz3CfiObaa9ntYRHQAHhY0GBeAaDszJUaodmyokF0PKJwi+HfJk/otr
	pvHZor+uVgAMICZrph5zfvcvzKDDmmY9d1R8Euf5kzLLSEq6KzVnKlMIr6Pqun77qnEbtIXFE00Z9
	gyp0+mT2zzdmxJ0WWghiHW8k216WbZYUSO6uE++NxXP5yeP5tfv66eRyY073NP9mK1vRm6EfJ03nU
	WCxg12Gg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rX9Ma-00000005dtF-2XGw;
	Tue, 06 Feb 2024 00:31:00 +0000
Received: from mail-mw2nam12on20600.outbound.protection.outlook.com ([2a01:111:f403:200a::600] helo=NAM12-MW2-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rX9MX-00000005ds4-1WNs
	for linux-nvme@lists.infradead.org;
	Tue, 06 Feb 2024 00:30:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oNN6GpTAb9IxwpX5hfEc034Lj8Lq+jP+cNAhMgFsXpZRh4uOwl4OrP0zq/kB8333FWw4wyn+OzFKkdzz1U6Jai03iuOt3z+OreOFWcpomv90k6tyUQSjNOdtwZ5hAtW4CYIjeMo5RpLS5WOIZu9COqx8ShMIUXsL3izbR/s39sJXve5SeebRgWGJUEQaYwAms7oT0keLymmSdxkNziOEe//3BZmhqBtFYj7rcFUshVbzVi1teEufAzzmIpr+4jirz08O/FdTPBn6xdQU5Bu8rLrMHksu43PgLgu9KjnBdXJWlR3V5/k2vDeZX1T8xsVpBawjO8t5FVpMykkaL7hMPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dJLjUfsJN34Ks7fFMNWK9pv9ToDeYqN5S/YD3kRtzOE=;
 b=YH/LZn5dZ84qh5EGXVs/C7teNJLczXV0WBL02hnvP1ge1Nlm8DlKdQrDWjWRTCgvKUhjVlmMXPWccH1Lo6lIBYZpearSMgmVe/ObNx+cFjAYmCyvkCBzzoh5CbKrhsGy218BFF+Uvi/MP5uc3evAEHDZnYr6l6sL2+uPUz7JdVaZTiZM/aSR8OvawNJaUM/VXIeq2BW5zLHJ/OFG+PazaW92skttfy6fbLFvK0GfT0Yj6BbeXx2/OIAtEawgu1P/+EtWpXCPAm30oQL5Dpeab5vwO7OMoNNrO6ejpBg6XhZVg35Pj3K1FF+yQen37uKLwu9WaMuO5QZ2JbKMHVsdqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=oracle.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dJLjUfsJN34Ks7fFMNWK9pv9ToDeYqN5S/YD3kRtzOE=;
 b=ryXgIF3C8RroAHHdT3iYbylf25xFynOF/IyGFeoquUCJJF4V1HT4cXglv/flR5HcolhKnmj0uy9+5O5KrEqXsV3HJAIPNeMznz6vDfXxNIsvFCTsMc0b+AyD5lKXt3JKCwL4rgCUKzua2gQJdl6Mk8R3Gd3JMwlRqEzvlYfeCMFTb2eYFXZCJq+rHRmuR8OcUQ1JIo8qrZhcfS8gTZjXMOPLNBQK+EXLgASOD1N/neUNtKj6wg2W02BCjXd2V3zLYihYttkqrPYPgcM7RBBczvbXEDHcYuLnx+Bqo/psRuTRv+2ctP5oG8vwkBvbg9kB9UdiRSPM45UkRayTTrgUaw==
Received: from CY5P221CA0153.NAMP221.PROD.OUTLOOK.COM (2603:10b6:930:6a::23)
 by CH3PR12MB7548.namprd12.prod.outlook.com (2603:10b6:610:144::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.14; Tue, 6 Feb
 2024 00:30:47 +0000
Received: from CY4PEPF0000E9DC.namprd05.prod.outlook.com
 (2603:10b6:930:6a:cafe::50) by CY5P221CA0153.outlook.office365.com
 (2603:10b6:930:6a::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.36 via Frontend
 Transport; Tue, 6 Feb 2024 00:30:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000E9DC.mail.protection.outlook.com (10.167.241.82) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7249.19 via Frontend Transport; Tue, 6 Feb 2024 00:30:46 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 5 Feb 2024
 16:30:29 -0800
Received: from dev.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Mon, 5 Feb
 2024 16:30:29 -0800
From: Chaitanya Kulkarni <kch@nvidia.com>
To: <alan.adamson@oracle.com>
CC: <kbusch@kernel.org>, <hch@lst.de>, <sagi@grimberg.me>,
	<linux-nvme@lists.infradead.org>, Chaitanya Kulkarni <kch@nvidia.com>
Subject: [PATCH] nvme-core: fix comment to reflect right functions
Date: Mon, 5 Feb 2024 16:30:21 -0800
Message-ID: <20240206003021.6422-1-kch@nvidia.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9DC:EE_|CH3PR12MB7548:EE_
X-MS-Office365-Filtering-Correlation-Id: 99202755-8ba0-48f0-9c11-08dc26aadcd5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: N5jEPP7Mjc9q7HHNfahkYDpGgNElXBp30ycksdWclFzoGzIfSZ/TH/ZuCSB1s3gXYnTXx2QXwiQV09rQoFirQWuAy+YUOQHIjyB9Fsl++rkt5JJVKY0Zrz1ooEB+5Gg+w0hdpCb1OU56ZHqgdQmhWpEpYfqvgWyLcuheFfMRDtJjm4jbJDBM1weu5tkyrbdUN1tCxXuCRAeAH65J7B7oQHwowutaqKxHC17ZdBDmucOeHtd62YVt12qIRn2Dv/wATscoqMptb8JrLUAVbjR8elRkhawBjtq6k7/HgkEca6KK4OsQNimqPr0gN+5PI5bOxquffpxwZ7m81Yzbf9UuRBo+MtUWe8Km1yeDPAKRSbukdIoa9jO3p60CuAPOO2+QUT7Kb4kSicPPlwvgO64vtBOUIyDj/XeNS/zsf/O1QXZfioUk0lZk7dJhUbPW8NPl+LM1Gh2PN9UWpuJqXC5MReAXw0kaDfE4krxKd1de/T+gGsZTKccq0j1SYcB9Vx7Jn8aq58xdaBZNbNu6cf/H+zoUVZjMs3Cw4KViHttntwiCntc+VhTBzH/PYhHUzkw5dRLw19XFWAZc5rU5EYyZFDJB0bonvrvLlM9Ib5p0j2bROGAkAlYuud4R7cCccPzAHmPKQ5r1FVfZIO01g7w2d4NwRXaG09JUWZXoZtLGaMStvgPdJIsKSXt0zavic0CaB8Zqy6jUpnHu96b4ECoeoB9XeWMGOMNDcfUGHzt9JYo=
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(396003)(346002)(136003)(376002)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(82310400011)(40470700004)(36840700001)(46966006)(36756003)(2616005)(107886003)(1076003)(26005)(7696005)(426003)(41300700001)(83380400001)(82740400003)(356005)(36860700001)(336012)(16526019)(7636003)(478600001)(47076005)(6666004)(8936002)(8676002)(4326008)(2906002)(5660300002)(6916009)(316002)(54906003)(70586007)(70206006)(40460700003)(40480700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2024 00:30:46.9487
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 99202755-8ba0-48f0-9c11-08dc26aadcd5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9DC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7548
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240205_163057_426228_DF66B7F5 
X-CRM114-Status: UNSURE (   8.99  )
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

The functions and the attribute listed in the comment doesn't exists in
the code, (ns->logging_enabled, nvme_passthru_err_log_enabled_store()
and nvme_passthru_err_log_enabled_show())

Update the comment with right function names and a comment
ns->passthru_err_log_enabled, nvme_io_passthru_err_log_enabled_store()
and nvme_io_passthru_err_log_enabled_show().

Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
---
 drivers/nvme/host/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 975245527c1f..7db700b2ed00 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3762,8 +3762,8 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, struct nvme_ns_info *info)
 
 	/*
 	 * Set ns->disk->device->driver_data to ns so we can access
-	 * ns->logging_enabled in nvme_passthru_err_log_enabled_store() and
-	 * nvme_passthru_err_log_enabled_show().
+	 * ns->passthru_err_log_enabled in
+	 * nvme_io_passthru_err_log_enabled_[store | show]().
 	 */
 	dev_set_drvdata(disk_to_dev(ns->disk), ns);
 
-- 
2.40.0


