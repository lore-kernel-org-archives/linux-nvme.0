Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C60DC77B7A
	for <linux-nvme@archiver.kernel.org>; Fri,  2 Jun 2023 05:38:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=A3SJivZouG/EPULLhBMuZzon7C6hq4doIvGHxhb9xuA=; b=lDYyDBf5qbV+89Bg/czROls2ph
	VT3bLLwmiatFH64YIKmCzBlsDg2/isHjZU2TjAqOzKGyIg7HLqgWi0NT2GQtEQqP/yCwt36WijdiO
	HmPsCgafLLDmvD7Iql28M9vyz+g2Uj0gjCusS5g4JO7R/zZ3jBaREVe16jgASaBPT2AhqcUAkYgsT
	b7P5WJnjqjYTDHe4NCw3SgnxFNFAU8sHfL3tlg3UaBdzhGBmBTaezp90KRTylswWkIP8DuJmu3ui0
	fmA6B8/bCVqqubPdaMRjhOpXHBeLVFWYI0vAG2UR1eZ29WhV+rHcs/mZrXu67A++2oqrHsTqP5AtL
	kxeVIC2A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q4xUX-005nbZ-35;
	Fri, 02 Jun 2023 05:38:25 +0000
Received: from mail-co1nam11on2062a.outbound.protection.outlook.com ([2a01:111:f400:7eab::62a] helo=NAM11-CO1-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q4xUV-005naX-0g
	for linux-nvme@lists.infradead.org;
	Fri, 02 Jun 2023 05:38:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OQ9lem/x1rIjIfGqeo//zP262Stqx5gvYD0PzVQNDFYpXnARTtQ9VGrhXxLKK522zg4NThw94rA4lgpBgVzj4FqadD77Xe2EU7MCw0k5c1L0QC0oVqkA6bBUN5Rp3exfGgrRImCjCImg5YF6skMz7R03xZDu4dRyMsmFpSdEqLnCOCeTqroZSwBfuSFgXniLS8LSzfIdDL8VUBjhjeVTTlU5GC+iNdoVSslBuRfzJJGYh3vxceB+T7+Un2bbn9tCv4ex1X/NjT1Yve/NOQ7n4XmG+h5h7H1K9s1Ke66pwrtAvXM6LM7v87GBcFiT7D1KxEaJIOtNjhT3FIETPt01VA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A3SJivZouG/EPULLhBMuZzon7C6hq4doIvGHxhb9xuA=;
 b=OEhMvFZvGIPUkND3ETn7FHlgCEI3UF/VEo4g3H0hJqa8eCPi44eZaOzlJKeVnAD6uv11gieAt1CcOl3bfMjTi/ry0gNxsvQ/2s6FgCAZMTZQ/NiWSZO5ZmDVMjQv+yKqrMgAffBZhTzTfRMkIbWtGd/IsiXKMCUiQv01I5+mwcxRtk1KxrG3zOBJiI8N/rWEjsDX6Glvg2T1S4MM8HHI4KZESy8ejqNOL6XpmNgTyHvJZKEGi5VOxcG9bowAAToF5BsEHE/B4xFG6hnMmojd90/zdupEzJoYpLXGK78ULARfko+jeeA+CbIh/08pbWj4xWcGNIfPN8UHqqzI9lLVbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=lists.infradead.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A3SJivZouG/EPULLhBMuZzon7C6hq4doIvGHxhb9xuA=;
 b=Ykc2cHj7Zu6lQIEx2YJteIddiYini5O/hAkxTZvwYdWSi3v9AaEouKuZBCkW6/9wFOC2qRI35gPY51X1vYGjenlQoJ2+p9M/iE5hvNVX9RhpfzltCYBUshKCZ0uzMuYSMInFlpLZRwcnznjZbogg1CCw0Mw9XBXSXdtU5bxNNo1GmKdlyJf/wFUoOYlouXXErlu7l9zfztpFN1VCLbNlHGvF1szWYzDW6tIe9YdsHlaycY6kbsXU3iV2ypzCsgTQ9+PkBuJIfDD/16xjs4i57EpiFBVMOQ6cROfSuWdpylgkroNyMdyeAkiP+ttVqzK3FSf8fAAwe6PCyJw6qU4Zlw==
Received: from BN8PR04CA0041.namprd04.prod.outlook.com (2603:10b6:408:d4::15)
 by SA1PR12MB7199.namprd12.prod.outlook.com (2603:10b6:806:2bc::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.26; Fri, 2 Jun
 2023 05:38:18 +0000
Received: from BL02EPF000145BB.namprd05.prod.outlook.com
 (2603:10b6:408:d4:cafe::1b) by BN8PR04CA0041.outlook.office365.com
 (2603:10b6:408:d4::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.26 via Frontend
 Transport; Fri, 2 Jun 2023 05:38:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL02EPF000145BB.mail.protection.outlook.com (10.167.241.211) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6455.18 via Frontend Transport; Fri, 2 Jun 2023 05:38:17 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Thu, 1 Jun 2023
 22:38:08 -0700
Received: from dev.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Thu, 1 Jun 2023
 22:38:07 -0700
From: Chaitanya Kulkarni <kch@nvidia.com>
To: <linux-nvme@lists.infradead.org>
CC: <kbusch@kernel.org>, <axboe@kernel.dk>, <hch@lst.de>, <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>, kernel test robot <lkp@intel.com>,
	"Julia Lawall" <julia.lawall@inria.fr>
Subject: [PATCH] nvme-fabrics: error out to unlock the mutex
Date: Thu, 1 Jun 2023 22:37:13 -0700
Message-ID: <20230602053713.43006-1-kch@nvidia.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF000145BB:EE_|SA1PR12MB7199:EE_
X-MS-Office365-Filtering-Correlation-Id: 158906e1-946c-4c01-ab8b-08db632b9190
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FRaK46jiY6LKvDTvho8DAAhWcjy7mAIMnRjYHb+VzmKaVG5QzNYRGxBd0oQzySttoW9D0MU05ufWh1GMLwzf+CjkJpXDVSkx0b6RWyHDR9UixCXPrIzAZV1Gbk6dlVE9htJbfBU5aWwmfX/rEN5PwNRc8piJheorFOz3BlLxxhQhIxp9rzZ/ejayiLhzldW2RqanGi10nT5O7Fnw0jEhDpI4F6plVD9wUfo8QpYkOOT5JIJRl/YhSioHN2Bagl3m/z3uTKNFo/h1HxJF3lC/Kzv4ElQhCcuJ4IZZRzoFvgSoe/wl2riN/b5FnoeXaOBsnukdO2ihDfMZMYenp0pCuF/0kiVs/MJ28KxcPv5lTe3KNx3KXfXaNI6PH0n2LX4VtsAdefCoqo2d22sv/ZSTcqNi5RRn+ZU1PTilsZQVn4qS6SCOErmqrTygKUOXm/3i+R0fmHuaFT0Ku+L2qLXPQcMM+OOsjp2vATd4BSwpOHfLpxAkmrfIBlTfIUov4Jx18nTsjS3Q+VyiFfjWIvUQItzXaLFJUp/IPcdQf0KdPTnLpYd4ie1d6e4HRiZBIDDGILKHnFd2m/XcopDahbvDA/l8We7+rWPB1VRF0rUEDEY66zHlTyj72R7p21ewBcQUizJKtl1bnSlz5UOtD82a5CeXrq7uqXQEp2ulDd/4jSQSr/8Y0iR/Z70k8pErBPPd4Rt+2hlA3xYRgfkJsZcQYc96TOaTN/47UGAqZzuggBIOr7Ikv20UcOjSZD1HTx8gkjNUcFl/Q1GXpO441/RDGQ==
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(376002)(39860400002)(136003)(346002)(396003)(451199021)(46966006)(40470700004)(36840700001)(40460700003)(5660300002)(7636003)(8936002)(356005)(8676002)(336012)(426003)(83380400001)(2616005)(26005)(82740400003)(1076003)(2906002)(47076005)(16526019)(36860700001)(186003)(40480700001)(6666004)(316002)(70586007)(70206006)(4326008)(82310400005)(6916009)(41300700001)(966005)(7696005)(36756003)(54906003)(478600001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2023 05:38:17.7790
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 158906e1-946c-4c01-ab8b-08db632b9190
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF000145BB.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7199
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230601_223823_258287_23E3EA64 
X-CRM114-Status: GOOD (  13.35  )
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

Currently, in the nvmf_host_add() function, if the nvmf_host_alloc()
call failed to allocate memory for the host, the code would directly
return -ENOMEM without unlocking the nvmf_hosts_mutex. This could
lead to potential issues with mutex synchronization.

Fix that error handling mechanism by jumping to the out_unlock label
when nvmf_host_alloc() fails. This ensures that the mutex is unlocked
before returning the error code. The updated code enhances avoids
possible deadlocks.

Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Julia Lawall <julia.lawall@inria.fr>
Closes: https://lore.kernel.org/r/202306020909.MTUEBeIa-lkp@intel.com/
Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
---
 drivers/nvme/host/fabrics.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
index b1fa27b60917..c4345d1d98aa 100644
--- a/drivers/nvme/host/fabrics.c
+++ b/drivers/nvme/host/fabrics.c
@@ -92,8 +92,10 @@ static struct nvmf_host *nvmf_host_add(const char *hostnqn, uuid_t *id)
 	}
 
 	host = nvmf_host_alloc(hostnqn, id);
-	if (!host)
-		return ERR_PTR(-ENOMEM);
+	if (!host) {
+		host = ERR_PTR(-ENOMEM);
+		goto out_unlock;
+	}
 
 	list_add_tail(&host->list, &nvmf_hosts);
 out_unlock:
-- 
2.40.0


