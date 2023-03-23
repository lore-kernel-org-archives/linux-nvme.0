Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F620C76196
	for <linux-nvme@archiver.kernel.org>; Thu, 23 Mar 2023 03:37:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=89NhEZfOdJbptpfZV1nEoc38jeLd5sp6ZNa01FXaajc=; b=w7M+VepIGE2gSxo58IMs3jraIY
	vJSyuRDvuoPGpyYku+6yzCbZRdYoyD400+N2BloG1rEPPxeYSKCNbQRl1557QN9od8Jyz/ktVzJWr
	0YrCAD/TeqJAn0VjBm5yHOsbOWPQ2vbZJjDiQb4ITUYoF97vzpX0z/aPXB4SHytvBHc5bebYvapZF
	fCiBLdODoHudQ6Tdrfiqjytm8N3zBBPOfz38Mul3oXL4pz9CnkYEFBbI9j5klcH2rgbugUvIsB8Nc
	vzAqD3ZZDm1AugZIlwfdccR3XgRVeQdOghP+XIhG98ofMa3DFnPbcyuWrQR4LY7KUB4wmzGt1R6HS
	dJs1MAIw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pfBlb-000dz9-2i;
	Thu, 23 Mar 2023 03:37:31 +0000
Received: from mail-mw2nam10on20602.outbound.protection.outlook.com ([2a01:111:f400:7e89::602] helo=NAM10-MW2-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pfBlY-000dxp-1v
	for linux-nvme@lists.infradead.org;
	Thu, 23 Mar 2023 03:37:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XYpUlZK2zjzLdNf5RZBM9CsMc5jnoisf4RHEbqNp8iqFIkpioVVN6JJPmtcv+978IDTPUiKQxTD/+9O6cvTu/Aj4d+DQ+DyjBPSWnxUo5+hp0zjHW0YDWrN2erNNxA5PJQl06sKCrcFMIU8ObsVOLUq1Mix5zXEB64QVpTdf5J3At72QUed69eeGtRS8vWcoR6SxSC37v1eeSPNRck+3Cn+HB4C+z/LP9FizWqSYgw1rrTUMe3kC0T9D/2AOfzPNMrioUArCJCkzOCbod25IBBmoZpwwfaA2Y/2m1GdEQugJbv7UNWNvSPpcci8C/Pl/msoMS/50B+WpE+9qVg+INA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=89NhEZfOdJbptpfZV1nEoc38jeLd5sp6ZNa01FXaajc=;
 b=cyUnB5uaRt9PbKkMe7h0mdu4l3jZW5ZWSffw5LMb70JQvuENmhKduDscJw+Jcn8jBo4ItulUu6eGkuYcwNXbw5zl6SccyAtMhaZnpNmHIFpkkYi1tOqDvgwZ4b65mrbiFIoY+HnEdF8CZkcRSaVdGRtZtHBMrP2JrDXA8IxKSbc+etwm46YsdMJkIjQFOHMFJ2Y/VGfItlbNE0udt07jSi70rfPkzWE+neorH4IhX53HqSlKQLbfNM7iBwcamH3ZEuf1Nb5kQjYI547dcisO20INaBYy+P9h2BnQhqGqnfMsdZo8W7fZnRKxmBOOc2FGAZT2DAokNkWXf6VNeScUoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=lists.infradead.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=89NhEZfOdJbptpfZV1nEoc38jeLd5sp6ZNa01FXaajc=;
 b=aVPtpz29KXjd0c5sPzoTnN41/3eA2vMiDVzyajMstDQOGthpevBOQP3qlsmZYMcCU9dY5GtaxP1kgo01CAKb6ATJjy2/hV/zK4+HXD7x/9LN8VDPQUY7uehwaRvuvUjyFkApv1jsgHLFeQdfqD3am1xeZm1PSQ6OCeVc5SHb6NVFI7UILjisvBA46fcjOrg2TcHGmVHBXpKNXx9Ikcp6g/GvcLwafEXcwM7OxmaxUkws4sikZTGh1cvzYiNdIV+jOpuXcUmaEZu9v+z0wxspFvhJmb6658s3yVuykkmPM+Psp1YE7XqFIAtl9yt5K3WnvK5q5AZHuuR2CM/s4Xz82A==
Received: from BN9PR03CA0276.namprd03.prod.outlook.com (2603:10b6:408:f5::11)
 by CH0PR12MB5219.namprd12.prod.outlook.com (2603:10b6:610:d2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Thu, 23 Mar
 2023 03:37:24 +0000
Received: from BN8NAM11FT102.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f5:cafe::40) by BN9PR03CA0276.outlook.office365.com
 (2603:10b6:408:f5::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37 via Frontend
 Transport; Thu, 23 Mar 2023 03:37:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN8NAM11FT102.mail.protection.outlook.com (10.13.177.27) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6222.17 via Frontend Transport; Thu, 23 Mar 2023 03:37:24 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Wed, 22 Mar 2023
 20:37:06 -0700
Received: from zion.nvidia.com (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Wed, 22 Mar
 2023 20:37:05 -0700
From: Chaitanya Kulkarni <kch@nvidia.com>
To: <linux-nvme@lists.infradead.org>
CC: <kbusch@kernel.org>, <hch@lst.de>, <sagi@grimberg.me>, <hare@suse.de>,
	Chaitanya Kulkarni <kch@nvidia.com>
Subject: [PATCH 2/9] nvme-core: remove unnecessary else
Date: Wed, 22 Mar 2023 20:36:29 -0700
Message-ID: <20230323033636.812758-3-kch@nvidia.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230323033636.812758-1-kch@nvidia.com>
References: <20230323033636.812758-1-kch@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.37]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT102:EE_|CH0PR12MB5219:EE_
X-MS-Office365-Filtering-Correlation-Id: 502977de-70f8-4f2c-4477-08db2b4feaad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 	j37bt/pNTg59Bq+k+GoUHGJJ9yMSTf886MZ1+nD101v2LDHU0qfSQ73ERBoO7jgvGvCKoXLxHop7YqWO7eXZJwj05XC4lMfvc6oxOoMLMbIHI8YoesM5OxhnKOvG3bQR5su1iRDfY4j2LZ79FM5rpSktxgfZkvj+G8ELSrm88tGaDI+hEBybst9MJo3z150Q4FIYHIu5aPan1gIhhwKC0sjrHRHSFxLdTTZVuRgL1iPUU2eyczacL6m/kwYsYXqdxtAR/0w/0ai92xyObTqCeWwMWMyyEqrMOkA44BltfM3WFGg3sOV76VoOUScbNkd+wg4OaNVReM+k65yZCG2vH1dZ/5N/3BkcZOI0bRdbV+Or6mhwNh3p4EAVkkEkh0nG4tXIPYGAnMyBEUMygwYVx72GQzTCVunbAYoD3vxAUykZX/QSOa4kz7EzdnQTY/VprhluDf7aTVZ4JfyBs38BYiPGNkiUztDyi40ngwPFPMY5xub3pfjzO+vLv754e0GDRCOV8udgFiFbSgNoMii31/kt42TQHcVR3K+9cjS0lAmcnsI4aq+0eacBg4NQIc/+vGVJtPYZMHvkk20zIwlf3sLXW9Pg5UKpLS9zgErTTD0wem8jY2MADXedglX4TKGNgI/In+McDXrA8Jdkj79QThog8N5WwKSlCFSn3OpQl5seGlYCE1EOCiwZXrwLp+5mlusqAzE16kynmpXd+GnF0ZGRppiuBZjIh1eIVbSIY60J7QWWH8zl+JDic8fqQrgw
X-Forefront-Antispam-Report: 	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(396003)(346002)(136003)(39860400002)(376002)(451199018)(40470700004)(36840700001)(46966006)(356005)(2616005)(336012)(16526019)(6666004)(26005)(1076003)(186003)(107886003)(7696005)(47076005)(426003)(83380400001)(2906002)(478600001)(40480700001)(40460700003)(82310400005)(7636003)(82740400003)(4326008)(8676002)(54906003)(316002)(6916009)(5660300002)(36860700001)(41300700001)(70586007)(8936002)(4744005)(70206006)(36756003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2023 03:37:24.0660
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 502977de-70f8-4f2c-4477-08db2b4feaad
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: 	BN8NAM11FT102.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5219
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230322_203728_635548_EE58BE23 
X-CRM114-Status: GOOD (  10.24  )
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

By returning early we can safely remove the unnecessary else part

Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
---
 drivers/nvme/host/core.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index c9636be68d74..ce516553b517 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -4475,9 +4475,10 @@ static void nvme_scan_ns(struct nvme_ctrl *ctrl, unsigned nsid)
 	if (ns) {
 		nvme_validate_ns(ns, &info);
 		nvme_put_ns(ns);
-	} else {
-		nvme_alloc_ns(ctrl, &info);
+		return;
 	}
+
+	nvme_alloc_ns(ctrl, &info);
 }
 
 static void nvme_remove_invalid_namespaces(struct nvme_ctrl *ctrl,
-- 
2.29.0


