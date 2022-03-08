Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0309C433EF
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Mar 2022 23:15:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ba9RIa/9Jzsvx+sd9PfQS3UgkpFzRsAQAv8y+1olvKo=; b=3sJzXiS1yIXw7iFvnhgBnaJ1QC
	uFXfQ9WcQVReC9hAnr1n6JcbTrzVbCmYabLbUyIqOASnLFnA283FLkuQsZqCsJO5qAf0fNpTXE+ye
	ZjKv8sWlthJYkxiFgd7YWnpa2ZyBNmxnkNgART7eyZMpkqJijNTomkP0nheAd8tm7GOGskd88nEVt
	H545aNGxk0SMufNK16M6b9jxKdzn49GcyLpUBD+/6nTI0TbBbrs5J5wweNOZKAdYi3gtx/ZBCpkII
	NLzElkevBaCu1y3+EQxa7LkwZymxp/hklZiM3ouGVfTE+3uhMbdy5JJDsMbBz5c2NywgSICU0dIYk
	feP2gDyw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nRj2y-006W9c-Fy; Tue, 08 Mar 2022 23:15:16 +0000
Received: from mail-mw2nam12on20612.outbound.protection.outlook.com
 ([2a01:111:f400:fe5a::612]
 helo=NAM12-MW2-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nRj2w-006W8d-9o
 for linux-nvme@lists.infradead.org; Tue, 08 Mar 2022 23:15:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z5rnpRn+2XW0LDJmO4uKPyeDuG9k2Z15GY05J7vOYUsOI8PrB/C7q5l1cC4RQw1PfnGAw5Mu2PD+KqXe15qQ1h4kEJYAANWEFkr6nFSqSxdNd6GS8vXe2Yzg9gPOyfFAjNZEygm+jBShzj1eZ3wC1stv2bbkuZwLTCVyPIhPwWSyy99zwoXSlRsUZxwLZZa9hJAPCz3zfVfxaMTZzxl91n9uNwfaOPRdOHf05EOj+DSk6kYLdVCOv0RRq/AHLx54OnGy7l87ypvdWfsU2WSDibbKyKWhvvQEZlC6icciJsd4A0phEjnzsPdi2dQ47X08V9W/tyo0mR0RvLh6UfNtvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ba9RIa/9Jzsvx+sd9PfQS3UgkpFzRsAQAv8y+1olvKo=;
 b=ktwJPFSNkNfVDNA6NBEF1H5YhnP49k46kRIP/7FqCP4DUCEyhznSw7BDcaB7STNRVgyJmrxSMJhvtqhcZ97s/rz1PsxOcsqT7ucMcmZU3xuxOenrSxz9RqFeamymcnjKxnEQen/o8b4zyO81GBb3jusmLbe07tYJv/WjF478/vc4EytzW0wVP+WH+nbodePXAP4WHNF+ze98zJF6jG0H7hgKhjvzbz309JADLf5NgCni0J8G+UE7vzn9hz+vUj0cX7NMT7WHkhin/Z64OCiIkuNHMh9QznRJeFcVFvJ/mYTG2hN02QGIt0iDPj9IsHs4yAIqIH1rUMNUwAeopBJoQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.238) smtp.rcpttodomain=grimberg.me smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ba9RIa/9Jzsvx+sd9PfQS3UgkpFzRsAQAv8y+1olvKo=;
 b=jgC+pE6f0Jlk6ikw4RkBwSgdoVAXkLLQvKW1g1TIZ9cCgVubfFuHyoh8x3f3ijRjaB9Me5LL9HVHrx3YumUCDN/Sk5uZ4SDvlOZhLFNV/K5hSv1B1u/VwUngTid/JnI77XJJqv5ItT10i9Wz4d54pZqX5KzfNAkP+XhWZxXEo+DT7XO4mz+Zlw5fDb/Wf/DPV74VsQrXgCkpj9Kyyxo1saAWuTsvo/JICnDq6pobhN4+CiLRatF6akrzHhtdy03EOD56yHkf6mnpFm7zNG1athGCGtS53Fj2zF67Py+iQeN07c6MzJY9K7SUCjb94bDuDVsgzZfrnIX6rba8+ZddWw==
Received: from BN1PR14CA0023.namprd14.prod.outlook.com (2603:10b6:408:e3::28)
 by MN2PR12MB3165.namprd12.prod.outlook.com (2603:10b6:208:ac::27)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Tue, 8 Mar
 2022 23:00:55 +0000
Received: from BN8NAM11FT028.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e3:cafe::e9) by BN1PR14CA0023.outlook.office365.com
 (2603:10b6:408:e3::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14 via Frontend
 Transport; Tue, 8 Mar 2022 23:00:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.238)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.238 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.238; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.238) by
 BN8NAM11FT028.mail.protection.outlook.com (10.13.176.225) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5038.14 via Frontend Transport; Tue, 8 Mar 2022 23:00:55 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by DRHQMAIL105.nvidia.com
 (10.27.9.14) with Microsoft SMTP Server (TLS) id 15.0.1497.18;
 Tue, 8 Mar 2022 23:00:54 +0000
Received: from dev.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.9; Tue, 8 Mar 2022
 15:00:52 -0800
From: Chaitanya Kulkarni <kch@nvidia.com>
To: <linux-nvme@lists.infradead.org>
CC: <hch@lst.de>, <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>
Subject: [PATCH 2/3] nvmet-fc: fix compilation warning for unregitser
Date: Tue, 8 Mar 2022 15:00:21 -0800
Message-ID: <20220308230022.8863-3-kch@nvidia.com>
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
X-MS-Office365-Filtering-Correlation-Id: 6e2f4e8e-dd87-4f22-f5d5-08da01578042
X-MS-TrafficTypeDiagnostic: MN2PR12MB3165:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB316581D228383D0EBCDE71C5A3099@MN2PR12MB3165.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FSJ6wbuTwndRbusaG3OY7K//Ot6zuAN6KNl77JGX/ehHmWMzG8WhqdB29YYVzKjS/mg5HaAbeS1rIdO0ZqbUdsrlPq0sh41+01RjFt2c6Y3eT8YIj1wgdclfrPTLxvMeZzzZylKHAi9BUMK0KFfhc5zff7CixAWs/RWADyZ4rQquEAuUyCSNl/lO5XG+KgVdl9HtJe4UJo4zF9/kwV9ENcIp08HdWK0BirKeYN+GWOiuMp+1+SYbkuorqGkYA8ylij85yhpa1kFc8UpMfkC44hpy/btm+zsRpuIC5MI3nWs9mif/zztSgmgrWJSOvSYpfA2q/W3WoMU7bbFHj1IoDucy/6lfz/nMHvek7kDmo5aEdqyOTRSTYdk0Gdtzuw6MxKpEHDcaT+o7CEPBNvylZN5rHArTkVNLB6jJpHdC9L2MmlEfCuOX1kWi+FJ+7xUc3MoFusUsYVKapj9gc4+NxrH/pfuZtAqXNJHR3ndKt/UixiryCiORacPN+o9XDBY7zFECp9iyC1U9iRbcBjLC+GjQOP+YRL/t9zLww4Ns0VsUL2Aa+/ZBxUxZRqCkrkKbf3HlLuPwVrun3W42UkxRrAWgOcEuPPP5QycUzg9J/HwsSpYSJizt+RyvXC8+aeR13FvJAjcoMb4HgB8n2Wod8W3QPKciHStZMNTOsXjW+L73KcvpndVtnUGQgEUJHg8NM8wZvrEuiFfyGJrrNiXCYw==
X-Forefront-Antispam-Report: CIP:12.22.5.238; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:mail.nvidia.com; PTR:InfoNoRecords; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(6666004)(4326008)(8936002)(26005)(336012)(8676002)(16526019)(54906003)(40460700003)(4744005)(1076003)(6916009)(186003)(5660300002)(36756003)(83380400001)(426003)(2616005)(356005)(107886003)(2906002)(7696005)(36860700001)(82310400004)(81166007)(70586007)(508600001)(70206006)(47076005)(316002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2022 23:00:55.0282 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e2f4e8e-dd87-4f22-f5d5-08da01578042
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[12.22.5.238];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT028.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3165
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220308_151514_360246_CEA6BFF2 
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

This fixes following compilation warning:-

drivers/nvme/target/fc.c:1619: warning: expecting prototype for nvme_fc_unregister_targetport(). Prototype was for nvmet_fc_unregister_targetport() instead

Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
---
 drivers/nvme/target/fc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/target/fc.c b/drivers/nvme/target/fc.c
index 56c2bdfd8e3b..de90001fc5c4 100644
--- a/drivers/nvme/target/fc.c
+++ b/drivers/nvme/target/fc.c
@@ -1604,7 +1604,7 @@ nvmet_fc_delete_ctrl(struct nvmet_ctrl *ctrl)
 }
 
 /**
- * nvme_fc_unregister_targetport - transport entry point called by an
+ * nvmet_fc_unregister_targetport - transport entry point called by an
  *                              LLDD to deregister/remove a previously
  *                              registered a local NVME subsystem FC port.
  * @target_port: pointer to the (registered) target port that is to be
-- 
2.29.0


