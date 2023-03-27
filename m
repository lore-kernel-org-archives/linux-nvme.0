Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACBABC7619A
	for <linux-nvme@archiver.kernel.org>; Mon, 27 Mar 2023 06:06:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6ERZvv1tAlUz6ilEYJjEZ2REerUQa2KUdFzPU2gFuR4=; b=aFb8VAjSrOplCVPtXrsqQzYS17
	urU3T/YMnDP/IShxJjdTJs42fC+s4pYX7rtuIBKe3BSHc3/CSAfajzeDPfyqeq8Uela6+z0/KKPmt
	zQXCDoF3XEQfEnLHf3HROWxo4LMnFiq14BDnIXhqCVH2fY3DxKzF526p/P09+kkryaQVh6BilMdoH
	jfGUS2rW/ELSa07U3eqKQxCETJrMCD3H5NFpZsTgDgWsHZRNxqfUy4No40K82HBcuUPCJPLg8U7Q6
	2lcSTx2zyY45BpKejaD5pydNyiYiMoGqVWpqmdlqgdg+Fdg5ubBTQhedNjG+J3KiUH/F4+9sBwQAx
	v1O/KSnQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pgfzX-009uOZ-1d;
	Mon, 27 Mar 2023 06:06:03 +0000
Received: from mail-mw2nam12on20610.outbound.protection.outlook.com ([2a01:111:f400:fe5a::610] helo=NAM12-MW2-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pgfzV-009uMP-1G
	for linux-nvme@lists.infradead.org;
	Mon, 27 Mar 2023 06:06:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PKS07Dl/0AZcpXOAuJoursD6cDpz76ne9eiQP4JbGatrwZtDWcCNT5+Ec6eGLenUf0C5mlVTRyk1s0exWBnQcPpgBpLTQfEiphqFmgZ9KVQea0YR08lifhgWLUctlk3bLRGx9vayTsMSVLMsOh8NwhggdbMMl5tLlu/pwrVEtTTUFuaavZNHvfQBLoHTpcU2kisJcyS3bNzNQcjId3gG7ysvT7Su2iWt2ZHfeIqPVcUHhBnlvx+vEH9498Zo+RNxeZSNeLmj/XXAXuEBbVbrQx9PIHll03yWA+zqdr+CWhwwbYmUXjGQVaLTnEt5obe6Yjd1cxQbpuwT39K+uRqxMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6ERZvv1tAlUz6ilEYJjEZ2REerUQa2KUdFzPU2gFuR4=;
 b=UZLlY9IhqoeezlR3rUwmgxSoEFSQ0GHwSkBJmK+mbsuJmEJZzDiNRgPtEihRWa5BFBWwOtYbc23oUCuRfQEgC/vPA8tsBmx0il+n8w6miMv450cfwvlt1+Kp2h+RhewSXi3Q0lvCQJpyKbyZk2E6Qdk7o3UR/UvbVaksXL1Jakx1oNlgogCCFA3E2IuLORCnmc19MnrgiJkE5f08HsPytB48rBkqNGuxbLEgdErVImtIrX/o/st3dMaf7fKiA+aR5JBYzNDOUZmwZy+2vVg0rAvXfwiJK1M8UiS3sDNaviVlA2cCukoNllayBv4GSo6t1bZwQUoOtxENbtvFQFnNuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=lists.infradead.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6ERZvv1tAlUz6ilEYJjEZ2REerUQa2KUdFzPU2gFuR4=;
 b=CLvZYPtIEWS0z5FJvDPHjSc/vDrKx2B8lVnXXqGzEKVNFwPjyEdIS8y3EntnNqgJHplJ9tNQF3EmqTuSCXBUZ08b1hhLH4HWx9JtXhyl2m0zEmx0sFpM+ntsDGcDikiLYrnjiRYwiyTGyNzP0wEq5is956yaMoiIwaD4wdJvBIifXuXdVx0O9YYWL8Yyd39ZHfCdQ2XGHXKVimpUlkxyKSO3SnBITmUwk5zg0+zEB+gQg6RmOeti9dOm87Ssn3kjF8INxV19q/YTmtxu+yx+u3oxSOC0WOrElE6cDXic1IfizZZAbFbaHgW6euOZtIQesWnhpYpJ1oy8x1fIYoyrBQ==
Received: from BLAPR03CA0100.namprd03.prod.outlook.com (2603:10b6:208:32a::15)
 by IA1PR12MB6411.namprd12.prod.outlook.com (2603:10b6:208:388::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.38; Mon, 27 Mar
 2023 06:05:57 +0000
Received: from BL02EPF0000C404.namprd05.prod.outlook.com
 (2603:10b6:208:32a:cafe::2f) by BLAPR03CA0100.outlook.office365.com
 (2603:10b6:208:32a::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.41 via Frontend
 Transport; Mon, 27 Mar 2023 06:05:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL02EPF0000C404.mail.protection.outlook.com (10.167.241.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6178.30 via Frontend Transport; Mon, 27 Mar 2023 06:05:56 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Sun, 26 Mar 2023
 23:05:42 -0700
Received: from dev.nvidia.com (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Sun, 26 Mar
 2023 23:05:41 -0700
From: Chaitanya Kulkarni <kch@nvidia.com>
To: <linux-nvme@lists.infradead.org>
CC: <kbusch@kernel.org>, <hch@lst.de>, <sagi@grimberg.me>, <hare@suse.de>,
	Chaitanya Kulkarni <kch@nvidia.com>
Subject: [PATCH V2 6/8] nvme-core: cleanup for nvme_set_latency_tolerance
Date: Sun, 26 Mar 2023 23:04:16 -0700
Message-ID: <20230327060418.86655-7-kch@nvidia.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20230327060418.86655-1-kch@nvidia.com>
References: <20230327060418.86655-1-kch@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.37]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0000C404:EE_|IA1PR12MB6411:EE_
X-MS-Office365-Filtering-Correlation-Id: 75028771-5d9f-4652-e4e3-08db2e8954a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 	sCo63FI+rde6xkhHUanITjZBk/3DB8tOn4s4DcNtvTmAViEgewqjPpcCqtdOmACMMe+o9Bxf11LT5rgxtlX32ZT1hc2/5YQblEhH3gVYMzH7BIPysMpBtN3InIrnmAkbYJZtePdrOpqwPCd9Dm5M7sufah3Rh6xlF1/qIvqEoYPN+9V5V611eSbWYkKxMJhqp3+1+FGs+oorTBUUf66RZQOhNlwAE/rDMy20MXgW9FBK7Wi509aqrobAVQ67YxS2macNoBM6xByhu4CPN1aJeLN9Zq40vpISpQV+wPkOZ5L2Y6bgs2FT0Uid/yK0ppbic2o1AkLx7B16eaFhy/6ptMEkZ6ndvqhVhjS5e4xDjQ9xMdHusGlJVgFNFH5QniiEYCJ2bK8maPuclTQtrIFkYYEpILAmAnTehgd2uXV0UkpmWDRZmYUHrxY5GPl4JCZ6ZR4jfZ9rM6ioAMh98f59do4wJWycMTtwcbvquBtf4VlfgthJSYGVDiwNc/0kJyzapWC+h2nN19Ve5JqRd6X2kuhZOMh0nBZPepm4X6fbg89yVnXbH/JwfYS9+HkiqPRdxQ1t/lDZlCHZfTxnBdrLmm5i39fhhAMG4PNOLueGkhRcRAlLPt8ukIoc0CyDR34Dreg+hORL8azTZ0X17o6sVLJlm9ONkfOH0qNVblr7ib95pH+cJuCj5dSSSFszjT8DDjR4FPfp6KbX14Wnvj2UmTw5U0L36pWAIesj+Z46KREpVOHOG7AFfIfQoP2PuTbR
X-Forefront-Antispam-Report: 	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(346002)(396003)(136003)(376002)(451199021)(40470700004)(46966006)(36840700001)(2616005)(16526019)(26005)(36756003)(54906003)(36860700001)(2906002)(4326008)(8676002)(6916009)(316002)(7696005)(1076003)(82310400005)(7636003)(70586007)(6666004)(70206006)(40480700001)(186003)(356005)(478600001)(5660300002)(47076005)(426003)(82740400003)(4744005)(41300700001)(83380400001)(40460700003)(336012)(8936002)(107886003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2023 06:05:56.6712
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 75028771-5d9f-4652-e4e3-08db2e8954a7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: 	BL02EPF0000C404.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6411
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230326_230601_434858_1134D30C 
X-CRM114-Status: GOOD (  11.51  )
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

Remove the extra line before default in the swicth and add a break
at the end of default in the swicth which is a standard practice.

Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/host/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index c4372855924d..bc1091953562 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2594,9 +2594,9 @@ static void nvme_set_latency_tolerance(struct device *dev, s32 val)
 	case PM_QOS_LATENCY_ANY:
 		latency = U64_MAX;
 		break;
-
 	default:
 		latency = val;
+		break;
 	}
 
 	if (ctrl->ps_max_latency_us != latency) {
-- 
2.29.0


