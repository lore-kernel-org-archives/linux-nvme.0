Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0968C433F5
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Mar 2022 23:00:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0iyIJpxUAsVQAYtRTj87nql69NVcnr2jQ13y2LwkLlw=; b=DP7p28pR+qpalWP3l0CJSjV3jV
	3SspgyYVcoxmIS0N+1rvTgSkKzzRe6QlxhJ+F1c8JMxp3kE9vA0fYTSsiEyd6L5lynBI9sSJDub6W
	F/v444gWIT9H+LZcmHa9eiiJ7zsJGntPNtdqWqL+jKLWkfAEUOAkuW0UMzhfBD1kmu8VmBNPJgia1
	DX3En72N+lGzJttF2aW52NI1L7GFKKb+mq9wgLKc1tXdQOqyaFwVz50Os58azVsXMCBoxaCXtLHO5
	FJRqDxQut6dOiTbroQUZsrhaknKmkDiJ0nZD++6R7wIvaRud8LZ95UVsO+iWYA0YyUJ7YP83BEsA2
	rEs/uVLA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nRip0-006TOM-Iz; Tue, 08 Mar 2022 23:00:50 +0000
Received: from mail-dm6nam11on20630.outbound.protection.outlook.com
 ([2a01:111:f400:7eaa::630]
 helo=NAM11-DM6-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nRiox-006TM5-Iu
 for linux-nvme@lists.infradead.org; Tue, 08 Mar 2022 23:00:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KD3G4xkvT+El/+kYa4xgDLFbMaxwX22sNMjIqLp2FBlr+ghQ/6wAIRDNKoN23+QpMsYfpOTPpvDgdLm7ZH7TqpqhfGzfzc2yK87ujwAzXd6FhZgJ6myErkWiuftEbLXonERw4hlAu3OfTWRi2PkWO6SyCmk9ZApcNotW/XqjtsYx04SVnL85P3Edfo1F3y7St3sH8KY2yY1AJTSCOMizB2qB47ktoyQnCFtmItGgasjz2saD26Cf0Wq/xfX6EE0ZVMgxZGbGVql2dcG5vj/ddoiIqi2NmVfiGdEZCYm+AIkLfq+yOQDhvQgXoqPhynVE2FHE5dIVKye2+kvVvuLK3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0iyIJpxUAsVQAYtRTj87nql69NVcnr2jQ13y2LwkLlw=;
 b=mvkYNYqoDeRZWyryXZHMFwtpJN7HoTwpiNZOHdpJcBwLO/si3fSFga6PfUkFPcRDJl52IxYYIIL1197mmtRn9/O1EK182w052jEpxCQqZIS0UC/fuLPjSB/W2L7knZumG9SMXOI8Gan/cOe/+nji/63ISidG4bO+4iZMBTAUI0zSjtBi3l/cuvt5mK2yLKbBnJO3m/wBt70/2RHwpCem9o6m6yuPApnEVyAXeXg3Yt9Qq7hdKTSjDRiv7t3Jcfmq2FKSTD7VEMad6fmi6I7tL5mr+T7gmwYzO1O9xJT05gZp9LixWy/rlhG6qnnRZXqEq7G8aksDDjYlz8PwEpIT0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.238) smtp.rcpttodomain=grimberg.me smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0iyIJpxUAsVQAYtRTj87nql69NVcnr2jQ13y2LwkLlw=;
 b=FnFUAgcyztFD1byPn/kBRugc8rhzLZzjUe/0exGnuQkP//CDrqsuSCbGidcJF9Ivf2qY9PtvVfDS1GTpHJbeFq18tO2+aziMZovnbbYEoVMf9JIyYKmow0DboZt/HxqilfOutPEz+TcoFJqEiZENTCMniacrOkn6ZFVJDEn7I7kvzQetF23bhMfJX1E1guT9slHiiqgL/Np74K4y+4QYweHf0HR2Jt8L3yZEDIlzADBMSenjIRhEiNL65Qw1tOyr2sSFx1sGrwR+sy3G+VWLu2dwBKHat/AGR8k/cjS+6Y/+rjVBcbQ1zpcrURJXYDi0eFnpdHqHI1My3FV5jZYkSw==
Received: from BN9PR03CA0506.namprd03.prod.outlook.com (2603:10b6:408:130::31)
 by DM6PR12MB4732.namprd12.prod.outlook.com (2603:10b6:5:32::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.19; Tue, 8 Mar
 2022 23:00:43 +0000
Received: from BN8NAM11FT039.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:130:cafe::d4) by BN9PR03CA0506.outlook.office365.com
 (2603:10b6:408:130::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14 via Frontend
 Transport; Tue, 8 Mar 2022 23:00:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.238)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.238 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.238; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.238) by
 BN8NAM11FT039.mail.protection.outlook.com (10.13.177.169) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5038.14 via Frontend Transport; Tue, 8 Mar 2022 23:00:43 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by DRHQMAIL105.nvidia.com
 (10.27.9.14) with Microsoft SMTP Server (TLS) id 15.0.1497.18;
 Tue, 8 Mar 2022 23:00:42 +0000
Received: from dev.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.9; Tue, 8 Mar 2022
 15:00:41 -0800
From: Chaitanya Kulkarni <kch@nvidia.com>
To: <linux-nvme@lists.infradead.org>
CC: <hch@lst.de>, <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>
Subject: [PATCH 1/3] nvmet-fc: fix compilation warning for register
Date: Tue, 8 Mar 2022 15:00:20 -0800
Message-ID: <20220308230022.8863-2-kch@nvidia.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20220308230022.8863-1-kch@nvidia.com>
References: <20220308230022.8863-1-kch@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 917971a6-3e54-4d5a-5287-08da01577937
X-MS-TrafficTypeDiagnostic: DM6PR12MB4732:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB47327F3030E7A0FD2338B9B4A3099@DM6PR12MB4732.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pxLJ658J1YoPmwGslyIkuamvvq1Ckb2Oky5uVXX2DwWsryMXs4hyT+AeWFO3mTDWNLdCEbd7Xdp8WOZZ6i6ruRzynuhpipLSUuYllg+jWS/OigKtB+slXIp7FJP9c4Z6KTjBoRWiqhCOUjpVndDjmMw0u2PMLEFOVsSvWLhVHuATvMIZH4AcgizZlJbOKvnPY5Od9JXa7OQCRkPiu5ZHWqJ4+OHm4IAjF5I7z3vk09VnR8V1VKFfN9O//joP0R/MwQE+5ylcntTLZNIFj/GQ0uSgFwQaIvW5oUSNvuP1tnGp8Oens4xXjbsqNdJjpP8bBnkCN/d/H92ltuKmnBm7Y4AzC9D23h7mJ+Cpa7e6zKEHD4zI71bwoFPMGqk5baTbGq8tmgEFQ0x0vRTwTTYxdISkRpeTc/A5AKnAVhA35TXXxi3Y5grOESmP6lSELN18OtdOCgh88nO/df5rTrIsSEMxnHQcuDRvvy1/csmyHMmWRVS5CH0Gaj+RCI9fydHelrHJMbCQf3w+J06zA1Dt1J1FFL49Utregbv88vIdBaKQ6EhL7nhdykNQ3nU5IdmW8oAQvDlIzg4LMlSuPRxKNpP7wC9XEFr+UtG9oyZ/CtAWoNl1/9LNiN7PhEog1CO18VsukPOpzbTzrtKreD9oRsyJDKeKMsBbbkqfilU0xJtB3mQ0q3kg1p7vqwsd6nCQZk7IUoGhlVZASmigZL/afA==
X-Forefront-Antispam-Report: CIP:12.22.5.238; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:mail.nvidia.com; PTR:InfoNoRecords; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(47076005)(2906002)(36756003)(6916009)(54906003)(508600001)(426003)(336012)(70206006)(70586007)(5660300002)(4744005)(107886003)(2616005)(316002)(40460700003)(6666004)(83380400001)(82310400004)(7696005)(81166007)(186003)(16526019)(26005)(36860700001)(8936002)(8676002)(4326008)(356005)(1076003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2022 23:00:43.2079 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 917971a6-3e54-4d5a-5287-08da01577937
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[12.22.5.238];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT039.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4732
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220308_150047_682596_FD93945F 
X-CRM114-Status: GOOD (  10.08  )
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

This fixes following compilation warning :-

drivers/nvme/target/fc.c:1365: warning: expecting prototype for nvme_fc_register_targetport(). Prototype was for nvmet_fc_register_targetport() instead

Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
---
 drivers/nvme/target/fc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/target/fc.c b/drivers/nvme/target/fc.c
index cb013516784c..56c2bdfd8e3b 100644
--- a/drivers/nvme/target/fc.c
+++ b/drivers/nvme/target/fc.c
@@ -1341,7 +1341,7 @@ nvmet_fc_portentry_rebind_tgt(struct nvmet_fc_tgtport *tgtport)
 }
 
 /**
- * nvme_fc_register_targetport - transport entry point called by an
+ * nvmet_fc_register_targetport - transport entry point called by an
  *                              LLDD to register the existence of a local
  *                              NVME subystem FC port.
  * @pinfo:     pointer to information about the port to be registered
-- 
2.29.0


