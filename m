Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27B01C433F5
	for <linux-nvme@archiver.kernel.org>; Thu, 17 Feb 2022 02:36:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=rcv7jUPQBiWFlRJ2FzCb1fO3m+Ps+A68Gwakk9rP03o=; b=SzEAXb666Mv2T+r0VNOU1Ih6iA
	8lVN8+lzYx4CmqBsIoVpSRMZAHc7uWDPLLXlWpwnhMGS2ksET1mSl+IFZ7JKg+8QnT7cEAYTbeAYp
	5xIdnD8y4ruY1yfiYWLWkpYXrEIe5Xnh5iegZ4ou9UMQkAAlR+OG1tk3Sf85lTfm5R+tSNtiY9OPo
	gGaxeQy9a6J1vCPX1IYt2sVQxffKo7jmP0EVxN/+Nc7gzExRwdAsJGyLjjGkIS6TrCw7zacCHQVSI
	RhVXKn1uuZesfymLlg937NvWNrBQrK00EzV3ilDmjQOEqAoTuYLN20ci4QzArFaeop4VZeA8Cu+Qd
	Uie28Juw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nKWf4-008l5L-9u; Thu, 17 Feb 2022 02:36:50 +0000
Received: from mail-mw2nam12on20600.outbound.protection.outlook.com
 ([2a01:111:f400:fe5a::600]
 helo=NAM12-MW2-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nKWf1-008l4w-Lo
 for linux-nvme@lists.infradead.org; Thu, 17 Feb 2022 02:36:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ELUjjyxcV2CHins+SN+MjkzSGtqnTsPAmyoC12utmaCcGP5r40DMbsWOjFh034KkXGQvjSkRGfjdJNwyqZekKz+UCGAnrl6TzmMOuV9lbVv8RW3G4rXEcT9QjjjOiQ/Y6z1iGS+PUrZwv55AI0EWZtEg5HBvxYR7MPKPVhazapMYveSeAEz3tyEzxu8BPo+mSBX4OXBAgNJTxL//sVylQn+FN8A9R+JnOYFvlR0WltKSTxi62by/axoDCQxghKGuXtuKYnlLXGON1bUSM9pX2Eh+IEquAKVgy3H/3fDD3+jONoNpMtuKiO3u2CmULsU2WPPyGoJAYEfuZzQC12gLyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rcv7jUPQBiWFlRJ2FzCb1fO3m+Ps+A68Gwakk9rP03o=;
 b=DyTg7xEHO1yuTGvode5gWdUNzo/rMArRsylktA55Gp3Ms1nLTcZkp6rQNz1y9ymxzTU19nc7diFl/Zh6F7vIeqibXMpj/wOH/Zdzk3Ds0wMA48sLeGYqJ/WAMPsqJBt+iZH/wn7cTrWrgUTP4lDVCYzs0lmHXXgezd6hP1NUH2NsgA/kHMi2vNk/p8kgrBpBe3LadEY4lQ+uwf7wU5kQ3fEJd96f1Oa1A9OnlX/hWV3z7fbFqgHgle0y+WmJEIYVwPiHoJG/ADNrou2z5iaul1GRejNfWS+Ib/3aTIDoLws4Iw+pUlhYJAfNYRPYusD/kViZCTknhfhDeXPU5ALCEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.238) smtp.rcpttodomain=codeaurora.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rcv7jUPQBiWFlRJ2FzCb1fO3m+Ps+A68Gwakk9rP03o=;
 b=F7F1j7Vrmd/x+CMN0zMyIZKY/HFXz3XsnYYdBXW+SpTozKkqRLgByL76vqQQXl1mzLVg/6UIEU9+YwxHl1bcPbxM5bIXWzLGYA+irNog3MLWoWOnHSnLTVKODQg8Ik2NC+jaCk9UNzjB5RtH85hFmOw4HvJioqGIubiHLEzK2t/QNNjGODdSNlwd8iq9tJ3a9x6Hwg+e1VZcUeBEqX6zAuRt36UoYEMIZUYOcGzKoDngdHDbaBiL8Z9iMukWeLAbOzeCqrdW4K+DsL/AuGQuWxzgh1ax1owiY6rzYVbO+NYO759OHgvXlph37B9wLu1D9JSQ65SPbHSdUgfDhIA/IA==
Received: from BN6PR1701CA0022.namprd17.prod.outlook.com
 (2603:10b6:405:15::32) by CY4PR12MB1798.namprd12.prod.outlook.com
 (2603:10b6:903:11a::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.17; Thu, 17 Feb
 2022 02:36:43 +0000
Received: from BN8NAM11FT054.eop-nam11.prod.protection.outlook.com
 (2603:10b6:405:15:cafe::ea) by BN6PR1701CA0022.outlook.office365.com
 (2603:10b6:405:15::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.19 via Frontend
 Transport; Thu, 17 Feb 2022 02:36:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.238)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.238 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.238; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.238) by
 BN8NAM11FT054.mail.protection.outlook.com (10.13.177.102) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4995.15 via Frontend Transport; Thu, 17 Feb 2022 02:36:42 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by DRHQMAIL105.nvidia.com
 (10.27.9.14) with Microsoft SMTP Server (TLS) id 15.0.1497.18;
 Thu, 17 Feb 2022 02:36:41 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.9; Wed, 16 Feb 2022
 18:36:41 -0800
Received: from vidyas-desktop.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.986.9 via Frontend
 Transport; Wed, 16 Feb 2022 18:36:38 -0800
From: Vidya Sagar <vidyas@nvidia.com>
To: <kbusch@kernel.org>, <axboe@fb.com>, <hch@lst.de>, <sagi@grimberg.me>,
 <nitirawa@codeaurora.org>
CC: <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
 <linux-nvme@lists.infradead.org>, Vidya Sagar <vidyas@nvidia.com>
Subject: [PATCH] nvme/pci: Add QUICK_SIMPLE_SUSPEND for Tegra platforms
Date: Thu, 17 Feb 2022 08:06:35 +0530
Message-ID: <20220217023635.8963-1-vidyas@nvidia.com>
X-Mailer: git-send-email 2.17.1
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 490f0ce1-2512-4625-cba3-08d9f1be551f
X-MS-TrafficTypeDiagnostic: CY4PR12MB1798:EE_
X-Microsoft-Antispam-PRVS: <CY4PR12MB1798F461319FD9B77C8E7A2FB8369@CY4PR12MB1798.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TXNdh+ZzJkKh/Hq3oSllsNxeOFS73DAtq6S7Dc/os5t3oMkuCiTztrQ9w5N2RJcxjbhNl+5cWnWN1veS/8Hm5Sh+j+OW/GasJ2zBJ7YiW2h+OGIXc6rmClECvECeV4Oi1yFKuRNad/nJK8yE5+btKcYNbm9mJOYp4O49a1Dd3sCKdCQVF7LTypVnuKpc6uc46lmOM4LmWNUeD2IKBUfHkxxtgj/08vF1YKr1J5piLaqj/hm0FS5JH+SUWmuo9BMp4MdgZee7Pi3r1ztUcoAT6WBWOB8ZS4fQ1wPsI/F4+bDvyq3+gGz+/oY8sRrnceGtSomIeI6mKIUDAbkib6KeHnXpQzP6KJjRVh8MIohak+EgIPvXT+Af5t/gVQbOjXPWAHqcQrq0TRCvIh8onP4ZSsZ8tL2LOPjOvcB7qV+QQQHf0jQegBOJA8muo3cah0MIJVmCfp7lujN1IDdT1LzOQoJCoZn9caZKJlq/5uQMeR+g3nPz3FiL22a0lxI6MCrGMWP2ngSHadIyZj9iJ2VTxANnqEmTJrL25KM9h7WoB81OXwmeSb1KQtVppf0nhHNZWGNfGTvUBfffOUydOD3GKZPRnBO8u0/v/yIAA+6NfF6U84nJpEqFPFcG6fsAP+rb5HhTYLEQme1Gw1UWJZf6dENiPYkhNTXbJjW16TyP1n+HLSiGW08jgE3NspEaEbxJKz5/Na38ht7t/3ORX8ghWQ==
X-Forefront-Antispam-Report: CIP:12.22.5.238; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:mail.nvidia.com; PTR:InfoNoRecords; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(36860700001)(2906002)(70206006)(8676002)(8936002)(70586007)(86362001)(81166007)(4326008)(426003)(36756003)(508600001)(83380400001)(6666004)(40460700003)(356005)(47076005)(5660300002)(7696005)(82310400004)(107886003)(1076003)(54906003)(110136005)(26005)(336012)(186003)(316002)(2616005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2022 02:36:42.2144 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 490f0ce1-2512-4625-cba3-08d9f1be551f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[12.22.5.238];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT054.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1798
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220216_183647_909199_536BFA82 
X-CRM114-Status: UNSURE (   9.09  )
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

All Tegra platforms remove power to the endpoint devices, hence, enable
the simple suspend path to avoid issues during resume.

Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
---
 drivers/nvme/host/pci.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index ab15bc72710d..f5c5be81d948 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -3035,6 +3035,22 @@ static unsigned long check_vendor_combination_bug(struct pci_dev *pdev)
 			return NVME_QUIRK_SIMPLE_SUSPEND;
 	}
 
+	if (of_machine_is_compatible("nvidia,tegra20") ||
+	    of_machine_is_compatible("nvidia,tegra30") ||
+	    of_machine_is_compatible("nvidia,tegra114") ||
+	    of_machine_is_compatible("nvidia,tegra124") ||
+	    of_machine_is_compatible("nvidia,tegra210") ||
+	    of_machine_is_compatible("nvidia,tegra186") ||
+	    of_machine_is_compatible("nvidia,tegra194") ||
+	    of_machine_is_compatible("nvidia,tegra234")) {
+		/*
+		 * Append quick simple suspend quirk for Tegra platforms
+		 * so that the simple suspend path is executed for these
+		 * platforms to avoid any resume failure.
+		 */
+		return NVME_QUIRK_SIMPLE_SUSPEND;
+	}
+
 	return 0;
 }
 
-- 
2.17.1


