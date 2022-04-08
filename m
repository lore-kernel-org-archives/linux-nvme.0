Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9592C433EF
	for <linux-nvme@archiver.kernel.org>; Fri,  8 Apr 2022 02:54:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Wc3rGDIpA0n3DgI40YcxqQCiSDMkKDRKd9X+516Hlwc=; b=EJ7nTCnD2DTa6vdDqCuzvKPVBk
	+XEUqpqkvUwnvKl+gmzhbEd2UZQq48VeVDM0kkJPUnXe+wedpvVwgVJEaI40xC0nOwZ3bErU7NOOH
	UW25UiM88qpouUALFnB+kyW+ZwIVlg6onc+MOTCslqBAWsQz7sIM9NZ88qJS0n1H+RKhMDZd09q5T
	r8UV0/Z64YtwBrspF3GcYJZ7j9IWF5vr2cmyQ2OhNML1dSewR/a7SeAdLr3uIIw7fomqu4qruYdgZ
	XB2McOBkLoUSiR0swl85ybcpBRZv8PSqzK9oHC15qfRZd+FGYtdWfy17dxic9Cu4Pofc4fDKwWiKB
	YAF7h9xA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ncelm-00EhiB-Ha; Fri, 08 Apr 2022 02:54:42 +0000
Received: from mail-dm6nam08on20607.outbound.protection.outlook.com
 ([2a01:111:f400:7e8b::607]
 helo=NAM04-DM6-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1ncelj-00Ehhc-T6
 for linux-nvme@lists.infradead.org; Fri, 08 Apr 2022 02:54:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hxJvYoskxdokyilcvouvN8s0ANvWASH+vC/R8JYSxxDa4Ea0fXu2trv/T66Q9wrP9kaxvd87XAplXwpGgHmiQbZ+c//1PUQxF9msKB1ENBuePtqLSinYSPa7SM0qLfbvpToBZehMJ1xW+eTnl9KyDl4GA64nV7yHnSW5mWLATBQbBgiWWJEsauWyOOirU5ctXz1K7YzaGmgZJ67D8GuXaqTRoYOhXPEXsaMKo/ve03n+RuzEfeRizrRxbuaj2JsdgRKBErQaups2Hajes25x4HySdmpU9n4EO/MuYWDUnNStSNqAKLTgqkUme1qYvPFGORI+qNi+GA4//IAo3ObZww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wc3rGDIpA0n3DgI40YcxqQCiSDMkKDRKd9X+516Hlwc=;
 b=GAwZ/V+UkLX8OZVI8YFyQyf/AvZvvNuLJJZVS48PPI1kO0sRfweVGiwncgnszM+HLe+AjPwhP2E7XVyl0wAsf0BhIi8FTmbw91rVynZvSX6YSqGBFdgdqTSPUJZVhPbWG0Vd87KxFOlYzsMYrjjwCVr4RCUSaR190bws1BuNo2zsppm6+rNweW5GNDrjVVyAES/nPnHfDxEPBdCmFZs6hTQADMOWbx7pLwPGgyMUbSqTId87n1IqKDSEORYPZvS+xMtb7wAge7Nop9F/C50J86MSRYVWHo5NVpXvrsdOQG7cdFC0S6qP4uJc6uHhNYxQoGZwM7vOTQzQOQTI8D+FLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.238) smtp.rcpttodomain=grimberg.me smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wc3rGDIpA0n3DgI40YcxqQCiSDMkKDRKd9X+516Hlwc=;
 b=PmAFbmFQUxknng+WkQ8Dgw+8eO9EgShrmuSTcqY93kbjIVnBMIGSPTcvNZseDPURuh4ClyGMt/0S5PvOFvon+gjpErSdU/y+LaEYsaAdEvlqLA6/GI0fN/CxoJW6Uq7s7kzWMFYluBwsEHiKrUMVX9Qu8vfJna1ES/DsacV26rfZh0YWdzqA3haDEncA9CvSz6dPaTAB5KftBVzEAc1Cbvw+FswOWuHgTFzwkto8wfB9p9eWoNLlqzVgQpko40St023F91C7m5UvVUx9veFIkrltsXx1ZyjQZHLUFeKpHaTwOguTRBOM3t/i37vuwpdh2KsBrvKNYit0C20TZUhgdg==
Received: from DM6PR12CA0011.namprd12.prod.outlook.com (2603:10b6:5:1c0::24)
 by MN2PR12MB3262.namprd12.prod.outlook.com (2603:10b6:208:102::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Fri, 8 Apr
 2022 02:39:52 +0000
Received: from DM6NAM11FT031.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1c0:cafe::1c) by DM6PR12CA0011.outlook.office365.com
 (2603:10b6:5:1c0::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.22 via Frontend
 Transport; Fri, 8 Apr 2022 02:39:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.238)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.238 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.238; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.238) by
 DM6NAM11FT031.mail.protection.outlook.com (10.13.172.203) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5144.20 via Frontend Transport; Fri, 8 Apr 2022 02:39:51 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by DRHQMAIL105.nvidia.com
 (10.27.9.14) with Microsoft SMTP Server (TLS) id 15.0.1497.32;
 Fri, 8 Apr 2022 02:39:51 +0000
Received: from dev.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Thu, 7 Apr 2022
 19:39:50 -0700
From: Chaitanya Kulkarni <kch@nvidia.com>
To: <linux-nvme@lists.infradead.org>
CC: <hch@lst.de>, <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>
Subject: [PATCH 1/2] nvmet: handle admin default command set identifier
Date: Thu, 7 Apr 2022 19:39:29 -0700
Message-ID: <20220408023930.85774-2-kch@nvidia.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20220408023930.85774-1-kch@nvidia.com>
References: <20220408023930.85774-1-kch@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4b590994-6c8e-487b-b198-08da19090ed1
X-MS-TrafficTypeDiagnostic: MN2PR12MB3262:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB32628B04E45C5D64CF038CDFA3E99@MN2PR12MB3262.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QW4ic2YXc/o9OcqERPNUDB1z0PSVOKU4j4bVuX05OJ0MmhmCq7r4wM9uhOU74oySrv+w0RRnc2WCeCasTTNRc5w1pfc/tNSh45m4I8A109CPHoKyyrEh/8RvA80gE5bxf6bWNujNO0BBTe8e27gC23Y2eDOivc5fiQKy/0BgSsJwnYhofrFIKIcMKWOyDOFYgEzCZ9zIWZxJbJ7iLR7GH/e4S9/jvvw/bo0+LagaTSn+9Q13dW4I55OXMs6d3xU2h1jutnH0TPBcLaihvY6uJzXGzyMfvXvEwhOzWKRkSg+aJ1MPdVb3JzDbEc2BDUUIh+SlNkO7D8UUvWZilz20Tb1tZVXUekhL3pUOrkgNDu0Yks4RtHjWuOXh7paTM/N7X/bxO6zxpmhikMxcLNoRMy6dPhauoG/9BaL2Ha8H6Gs1+5Zo8pCxDIuEjenFzyY3Sxa0ARqPpg/Sple3rZhMza+V3E78abKEGU3EuH0sEe2lMKYcErqHZg09OsjC2+VyHa+kex57dgbbrELdZFHBHHMwqXVsoG3zM1HWfRYJqwsIoWZDkify9F946mh9wtB+ZUrlvRrLBJXL5uvNS0e4V5P+BW+9rerVpWJlggMflvvCPMyWsPeTq4n6YqNRNLqkpevirwW6hwOen5otT+964JDAsmLQXKtFpJ3T2vZJOCvCcFkrfEF/Opxuz24H0NWzIgVyimjRFe/QsbytlJ/Ong==
X-Forefront-Antispam-Report: CIP:12.22.5.238; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:mail.nvidia.com; PTR:InfoNoRecords; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(47076005)(4326008)(26005)(36860700001)(426003)(336012)(82310400005)(83380400001)(8936002)(16526019)(36756003)(186003)(70206006)(6666004)(356005)(8676002)(40460700003)(70586007)(508600001)(5660300002)(81166007)(2616005)(316002)(6916009)(54906003)(7696005)(2906002)(107886003)(1076003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2022 02:39:51.9276 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b590994-6c8e-487b-b198-08da19090ed1
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[12.22.5.238];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT031.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3262
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220407_195440_013262_41C52379 
X-CRM114-Status: GOOD (  10.39  )
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

The NVMeOF in kernel host when configuring non-mdts limits uses
idnetify controller cns value to NVME_ID_CNS_CS_CTRL and csi value to
NVME_CSI_NVM. In target code we only handle case for NVME_ID_CNS_CS_CTRL
and NVME_CSI_ZNS when CONFIG_BLK_DEV_ZONED is set.

Handle missing case for CONFIG_BLK_DEV_ZONED and !CONFIG_BLK_DEV_ZONED
so it can handle NVME_ID_CNS_CS_CTRL with NVME_CSI_NVM.

This is needed to mask out the errors reported by the blktest nvme/012.

Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
---
 drivers/nvme/target/admin-cmd.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index 397daaf51f1b..e5eea2f0ac9c 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -718,9 +718,16 @@ static void nvmet_execute_identify(struct nvmet_req *req)
 			switch (req->cmd->identify.csi) {
 			case NVME_CSI_ZNS:
 				return nvmet_execute_identify_cns_cs_ctrl(req);
+			case NVME_CSI_NVM:
+				return nvmet_execute_identify_ctrl(req);
 			default:
 				break;
 			}
+		} else {
+			switch (req->cmd->identify.csi) {
+			case NVME_CSI_NVM:
+				return nvmet_execute_identify_ctrl(req);
+			}
 		}
 		break;
 	case NVME_ID_CNS_NS_ACTIVE_LIST:
-- 
2.29.0


