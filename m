Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99B47C47073
	for <linux-nvme@archiver.kernel.org>; Sun, 31 Dec 2023 00:53:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:CC:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Mxrbqhwj0GkMjW/ueTE3d4SaqVp17L992l0Xpc9i3cU=; b=I1D8fwr0RCLC30ExTYfmCVXGGz
	bmaG6+NOY+Zido/gpSwsflFBU6KlDjSm8tkUcwVkc6mW2ULAgdzuhhWhtovo+wi4yu2+Z4ryR+pqO
	P+k6cUD1p5P5YpK0c+nPoawk+vFDV6fOGcuFFINfXjoJw9b2CanZBQ538ifFyaH67lZKiLu8q5poV
	v2eJeU4EEInTW6nxu/ItHSPbMZhZf7ueu1j4b4pHGStlQ1KfVXF1l1/VuI4FSvfrFmEwgnzdTzhb+
	B/bZDzLUTJ5trrNbr1V0jnAPVLKpIXwbKSSVZxZf1YPltavWfSNw0MAVR4mkM9w7FKbe9Sw38iJKC
	nX8j6qXg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rJk50-003g2b-3C;
	Sun, 31 Dec 2023 00:53:26 +0000
Received: from mail-bn8nam11on20601.outbound.protection.outlook.com ([2a01:111:f400:7eae::601] helo=NAM11-BN8-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rJk4x-003g1G-23
	for linux-nvme@lists.infradead.org;
	Sun, 31 Dec 2023 00:53:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nP+zmt0ew63RSJskVgJNudSxdZrBYmx4+xLLXebtrUUOOlF5E3ZllHpLckg848XpfoZCVD6BQKdfVxG5mQAc6VFbUXq4ZxFp/Xs87dApDIqFZw6L2JW/8wosRMCMAB4kolVFhMYMddsGp3kOf0NYNRr4gHFgu/Ky67KwJDmzsxlHhFMqEPoUJzIpj6eZFkEQkzh7twx4lequY4fyGmewlvtJcR7fb6a/LZc93c5+bR0YHqRcmYqqs9mcDt3DKGA7j5XbFYDGzu4o0Ob5YIUPHtQD2aA1Fo9/qjzHPK9lpJFrjC9bqOaH9Wc48mvHNfSJo3gk2VhQcLbakvZCDvx78w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mxrbqhwj0GkMjW/ueTE3d4SaqVp17L992l0Xpc9i3cU=;
 b=A5X7RJcP+WGg9DCj4VBpkxCr6WWCPfHRwNCOK/hJlzDNYSoaphxmb8E/MS8TuJe/G6fO/zTIrdKcVhggtsqcWQq7q0aWq0FFgC+0RarM+QWbGdi0kErtHFLKZL2WEUmLksV5HPeLvZcNrv8FKqjcIbEIAnqoRRr6C78vXucee98NpiRCpdOQ6D6Sw7ahwvK8Odwgx6euaSnJzvzaqG2V5WsQAy1GkSEBMmMMqZ/X3a/XT72SD9uJZCku3IPvEi6iRPTU07r1zSKpfzCEavwhosORSxseJ/98i5+9dBANe4T/AZ51KdJlJhPXmVxWiZKwQAjOJQXl9auKvAXlKFgkUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mxrbqhwj0GkMjW/ueTE3d4SaqVp17L992l0Xpc9i3cU=;
 b=fap7p71d34TT0BgBcL5WV1XRj/LetaVAEgc/yezmvP5hIR3kR5FLw+gwuflWAN/Jzr+49QcO0RbHeVr8vryD388GZTDqQs3ZtwkK+1MVhGhCqkXrCkTu1dFhrMK+R5fRopYwCbi2OLasojuT0lcwjgT+qzoTtormRisuCaymkDEnADvd0Br1z4XpKN0uHk/vToi3l2wk0QK8cqb+XRChWd4riPF5X074aQjdj5AOkk2pYRYzAGc/3x6A4QzlUxH92tvlTZfyuf0bnS9U4vBmejkolQVMJWljoOYK8FMHm32V1IDYzPmC8G6SKqpHr0Y+r1J/xyQ+5e00PJPrFfQf9A==
Received: from SA1P222CA0102.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:35e::10)
 by PH0PR12MB8051.namprd12.prod.outlook.com (2603:10b6:510:26d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.23; Sun, 31 Dec
 2023 00:53:18 +0000
Received: from SA2PEPF00001509.namprd04.prod.outlook.com
 (2603:10b6:806:35e:cafe::ae) by SA1P222CA0102.outlook.office365.com
 (2603:10b6:806:35e::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.22 via Frontend
 Transport; Sun, 31 Dec 2023 00:53:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SA2PEPF00001509.mail.protection.outlook.com (10.167.242.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7159.9 via Frontend Transport; Sun, 31 Dec 2023 00:53:17 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Sat, 30 Dec
 2023 16:53:06 -0800
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Sat, 30 Dec
 2023 16:53:06 -0800
Received: from r-arch-stor03.mtr.labs.mlnx (10.127.8.14) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.986.41 via Frontend
 Transport; Sat, 30 Dec 2023 16:53:03 -0800
From: Max Gurtovoy <mgurtovoy@nvidia.com>
To: <kbusch@kernel.org>, <hch@lst.de>, <sagi@grimberg.me>,
	<linux-nvme@lists.infradead.org>
CC: <kanie@linux.alibaba.com>, <oren@nvidia.com>, <israelr@nvidia.com>,
	<kch@nvidia.com>, Max Gurtovoy <mgurtovoy@nvidia.com>
Subject: [PATCH 05/10] nvmet: set maxcmd to be per controller
Date: Sun, 31 Dec 2023 02:52:44 +0200
Message-ID: <20231231005249.18294-6-mgurtovoy@nvidia.com>
X-Mailer: git-send-email 2.18.1
In-Reply-To: <20231231005249.18294-1-mgurtovoy@nvidia.com>
References: <20231231005249.18294-1-mgurtovoy@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001509:EE_|PH0PR12MB8051:EE_
X-MS-Office365-Filtering-Correlation-Id: cb02bc98-dc4b-418a-7916-08dc099ae09f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ljxqhkC4rgg1xuATzX6k39C0hope5O57FxuDlc+zRi/qm9mYPQN6wbm4khUDbuv7rf/SHglTynlYc4ifWnUnID5qoHQtXEFps4miFNQWFkNYFBDArzdQ/+VXm3P7G2ep+IMyiNuQKQC0vyQUszU2q0w/pj4+M7qoCdowT/GG/Nry2lxEQQ+tpBGw11niD0d1csWKWgS4142HqsMSnAOURm+K25i9K22wiSwuwXZoXAnyX/NWLEC5b154zYKcBFfukjLeYxFWGiDIaZMZv77ZrZgyNCCU78XBv6wWJiW4sYqyCLx2zqcpq0LA/86s09M5TsKUBWGPchdh0OYYcXu8xlXjCdvClkPr9WqY4WXtsnRyhffesWxpGWgz/b8zXgu2pMgFZAqZKdEakHvXpKJq7CQDSgjnGSdt4ZrYMkXh9k388B5Ah2v6zFVdlWrH9HTuJuns7z4zmWOuggaY3MkBuNflfnwpvfyGtmRoVa8vZmJs7Z/EJbfOoJ+wzFz0lGrK8wLL0PvOX5Hieci+FkkOtsaq0TFtZ5WJ0L8PqrF7j1ciFA7zo5yIHJbTsA/SBlcNotI2GVHgFMV+dgjfvjHdXwZ+83j+qLmS+hp5deNcnNx2gsaSdIs+NvfXcY14MlKdNkOiFw3cKWWTp1mVAlIdZ42d5LHmWvoaZHJ11jK0LsJVkmbzcBh2pX8g31icAMu59buwHYKegb7WCeptTpzn6uOWsXPvJUU+LR1N4QvGS1vqG0/Soqi4rRnCGRzUkwTX
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(396003)(39860400002)(376002)(136003)(346002)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(82310400011)(46966006)(40470700004)(36840700001)(40480700001)(40460700003)(426003)(336012)(2616005)(26005)(107886003)(1076003)(83380400001)(86362001)(36756003)(356005)(7636003)(82740400003)(47076005)(4326008)(5660300002)(6666004)(36860700001)(54906003)(8936002)(8676002)(110136005)(70206006)(70586007)(316002)(2906002)(41300700001)(478600001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Dec 2023 00:53:17.6522
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cb02bc98-dc4b-418a-7916-08dc099ae09f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00001509.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8051
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231230_165323_683086_ED4D9F35 
X-CRM114-Status: GOOD (  11.44  )
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

This is a preparation for having a dynamic configuration of max queue
size for a controller. Make sure that the maxcmd field stays the same as
the MQES (+1) value as we do today.

Reviewed-by: Israel Rukshin <israelr@nvidia.com>
Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
---
 drivers/nvme/target/admin-cmd.c | 2 +-
 drivers/nvme/target/discovery.c | 2 +-
 drivers/nvme/target/nvmet.h     | 2 +-
 drivers/nvme/target/passthru.c  | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index 39cb570f833d..f5b7054a4a05 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -428,7 +428,7 @@ static void nvmet_execute_identify_ctrl(struct nvmet_req *req)
 	id->cqes = (0x4 << 4) | 0x4;
 
 	/* no enforcement soft-limit for maxcmd - pick arbitrary high value */
-	id->maxcmd = cpu_to_le16(NVMET_MAX_CMD);
+	id->maxcmd = cpu_to_le16(NVMET_MAX_CMD(ctrl));
 
 	id->nn = cpu_to_le32(NVMET_MAX_NAMESPACES);
 	id->mnan = cpu_to_le32(NVMET_MAX_NAMESPACES);
diff --git a/drivers/nvme/target/discovery.c b/drivers/nvme/target/discovery.c
index 668d257fa986..0d5014905069 100644
--- a/drivers/nvme/target/discovery.c
+++ b/drivers/nvme/target/discovery.c
@@ -282,7 +282,7 @@ static void nvmet_execute_disc_identify(struct nvmet_req *req)
 	id->lpa = (1 << 2);
 
 	/* no enforcement soft-limit for maxcmd - pick arbitrary high value */
-	id->maxcmd = cpu_to_le16(NVMET_MAX_CMD);
+	id->maxcmd = cpu_to_le16(NVMET_MAX_CMD(ctrl));
 
 	id->sgls = cpu_to_le32(1 << 0);	/* we always support SGLs */
 	if (ctrl->ops->flags & NVMF_KEYED_SGLS)
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index bf99c58aab52..a76f816edf1d 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -544,7 +544,7 @@ void nvmet_add_async_event(struct nvmet_ctrl *ctrl, u8 event_type,
 		u8 event_info, u8 log_page);
 
 #define NVMET_NR_QUEUES		128
-#define NVMET_MAX_CMD		NVMF_MAX_QUEUE_SIZE
+#define NVMET_MAX_CMD(ctrl)	(NVME_CAP_MQES(ctrl->cap) + 1)
 
 /*
  * Nice round number that makes a list of nsids fit into a page.
diff --git a/drivers/nvme/target/passthru.c b/drivers/nvme/target/passthru.c
index f2d963e1fe94..bb4a69d538fd 100644
--- a/drivers/nvme/target/passthru.c
+++ b/drivers/nvme/target/passthru.c
@@ -132,7 +132,7 @@ static u16 nvmet_passthru_override_id_ctrl(struct nvmet_req *req)
 
 	id->sqes = min_t(__u8, ((0x6 << 4) | 0x6), id->sqes);
 	id->cqes = min_t(__u8, ((0x4 << 4) | 0x4), id->cqes);
-	id->maxcmd = cpu_to_le16(NVMET_MAX_CMD);
+	id->maxcmd = cpu_to_le16(NVMET_MAX_CMD(ctrl));
 
 	/* don't support fuse commands */
 	id->fuses = 0;
-- 
2.18.1


