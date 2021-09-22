Return-Path: <SRS0=1D85=OM=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C370DC433F5
	for <linux-nvme@archiver.kernel.org>; Wed, 22 Sep 2021 21:56:31 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7BEAE60F24
	for <linux-nvme@archiver.kernel.org>; Wed, 22 Sep 2021 21:56:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 7BEAE60F24
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=vbs20n7QbPgYScLZJzAUDY7CTlTDIgHzcLfPEuQvlK8=; b=pxL3Xq0zWwasAj
	02lJZTr3sZ5RLbrc+Wj/TbLODTTzN+KNVJ5xWWmGFqQaoM3giTV3juTdEsxRPo9DK/lPPx0rv8cCX
	6mx6h58LoDlnyTrd/oVqv+9BeAIJwNmEvEgyJz7sdMCMPhHqhKqQyBuZsbXmnzdaQd9yL1kumCuit
	ltXkc+xfNbIHS00QJijDcFtbgwLnN5FKzs09VWu4pGfuj+nL0hO8LDgGVcGoc+8A8XxSk5S4I9U2b
	yXTv90gRvDphbxZvvUnaUs8Ge70mv0T7cIIbOrHKL8qSUetFr/xLElh+GKIn9sPyh31Y1KwS4Ok8+
	55zfB5FNHHVm6VaP2BYg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mTADu-009miv-UF; Wed, 22 Sep 2021 21:56:14 +0000
Received: from mail-dm6nam11on2079.outbound.protection.outlook.com
 ([40.107.223.79] helo=NAM11-DM6-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mTADZ-009mgk-A8
 for linux-nvme@lists.infradead.org; Wed, 22 Sep 2021 21:55:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aPj0btoaKIGBY6AToWmllYO+IlAwtcm/0AL7m9AYQ9vPym4FyXW0ScYTws591pSkms5MsA95+Y4QDX3FpZJCYFPmcW0IlVmjHGyLIIiZPSQDjyuYi8hPoLlbus1SoRKjn9ltxZE2cclKo+3MviSW5D71g76MYsb08jtfIZMNGkmy+CCp2YzbT52dOm2ehZo37+kWWNSxknP+QCf+46D+N5vjAGTcnFqPvay+fLHCxPK0yHhJ7qOkOjlzMz6DGZ2aj3U+NeN0XY9fkEHIQ710KkLOS8XjiR1SqscYSlAeBBXKESwK/TTQX8vytC281fU+qGRPqLwt5tKKikHLqPit4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=7Xp52BtvCL4XFHQslno/9II6WjSa42MWoPC63U6PQhY=;
 b=XObmnbbqtd7Oxqh6G8uMcrwA4fpaHT/vnXZVDhvxwT1xAcEdh2fPd33k4YPDM0bfteIVxuLOAaoZQ3iOfIL9/64J5kwXxwSxalpDoONRJ8MPMB2J0SPVD0c4IpAAirfLM9sF+tvAqAk9MjUD1zvYSnMTKnyaBI3noTNu98CM5lUUQTMp97wN16nitK+pd6HpYr7XBDR/mI3eaGcSatXlLzkYaIHqzDD+pqLi4gr5xDaZMyTGDpZv8yuqLc7tpY9ta95AssbZyQu1uM7Sh8mX3EWqG2/2ARAnZkfQEL9EgujBZ3WVg7W1p/VgnQpS29BOqmicZ9YdTdQcpG9roq7WXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.32) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=nvidia.com; 
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7Xp52BtvCL4XFHQslno/9II6WjSa42MWoPC63U6PQhY=;
 b=AKbrJ4GfyLmPuHh59OYaxAda0w9pXf8nHGC53x7cxKE2U08TUB5u07TEaViDQNuKR5pWdSh5j9wkyEB/6KhEGou9J/fpWfwIJSMnXK3sJd0s85Xfn6lXShjsoooVv4IU/x0sx9Ib7MFdg/A2tyo4tQDYk3Qgs+0cVhqA1msFkZNfTkSBiMe/0aPt4zk8apjWiVnMNU1qCpKR4EXaeb5E2JTCBtrTTq16gB7dYZHwaZlxHWZGeqQOr7yV0/iyR0zJvNR0E0wJ2R6qwLcQ1tlJCfBGJosWjYFrc6vzc8JwZS4HQMmds8A9MFbmygxKV2Gcnn6V6WxliyU9AsxjnE6Bbw==
Received: from BN9P220CA0014.NAMP220.PROD.OUTLOOK.COM (2603:10b6:408:13e::19)
 by DM5PR1201MB0220.namprd12.prod.outlook.com (2603:10b6:4:4e::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.14; Wed, 22 Sep
 2021 21:55:47 +0000
Received: from BN8NAM11FT051.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13e:cafe::6e) by BN9P220CA0014.outlook.office365.com
 (2603:10b6:408:13e::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14 via Frontend
 Transport; Wed, 22 Sep 2021 21:55:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.32)
 smtp.mailfrom=nvidia.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.32 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.32; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.32) by
 BN8NAM11FT051.mail.protection.outlook.com (10.13.177.66) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4544.13 via Frontend Transport; Wed, 22 Sep 2021 21:55:47 +0000
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Wed, 22 Sep
 2021 14:55:46 -0700
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Wed, 22 Sep
 2021 21:55:46 +0000
Received: from r-arch-stor02.mtr.labs.mlnx (172.20.187.5) by mail.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server id 15.0.1497.18 via Frontend
 Transport; Wed, 22 Sep 2021 21:55:43 +0000
From: Max Gurtovoy <mgurtovoy@nvidia.com>
To: <linux-nvme@lists.infradead.org>, <hch@lst.de>, <kbusch@kernel.org>,
 <sagi@grimberg.me>, <chaitanyak@nvidia.com>
CC: <israelr@nvidia.com>, <mruijter@primelogic.nl>, <oren@nvidia.com>,
 <nitzanc@nvidia.com>, <jgg@nvidia.com>, Max Gurtovoy <mgurtovoy@nvidia.com>
Subject: [PATCH 2/3] nvmet: add get_max_queue_size op for controllers
Date: Thu, 23 Sep 2021 00:55:36 +0300
Message-ID: <20210922215537.6499-3-mgurtovoy@nvidia.com>
X-Mailer: git-send-email 2.18.1
In-Reply-To: <20210922215537.6499-1-mgurtovoy@nvidia.com>
References: <20210922215537.6499-1-mgurtovoy@nvidia.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2f269daf-0bcb-4353-0e33-08d97e13bc4c
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0220:
X-Microsoft-Antispam-PRVS: <DM5PR1201MB02204D236A229AC238367AA4DEA29@DM5PR1201MB0220.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: F0lbKIu4eAJhsUdRYto/raQo1RuEsCWIoJBPQZrWzoCOCLOuIfcLPOQ30KLEY10g2u74t2eODjrR1mpqkLVYE4kHhzrJuqHkp1vC9h35tH7uK5EPfoJuyjPQNDi0p9jeOfieROPDw+WruJJgTRd1hW3i06+7I3rjW3wEij9yiteX5gutfkgZWzSgzbvaTfxadNiF8ze2SjmIfRA7FaYLF/U8mPU9oHKNVrTGhT61mzrEhe/BBpUiUZcLs+foj5zlh6KZYrliwTpP/9w34hw/Ztg1OMe/bcMVSEsO5Rt2irPE9XAlFZHCYaxSf6Na4Okpi+sorra/hf6IS9lXg52ZRVzgpSIMyF1IpV06mxlPcNyFDnnFcAo938jipsNoqWbLDovt9Pw805eCB1YwxZFd7aiPAjqhMPCfEoEuFmwMpVyByosBTysfxz5Bfy2VMs4nnWNvMeWeo8V80gSv7j4yfAi9xvfcVJ7PQi/Cfq9oTjDMtHDtsJWKq8Cv9mpbDQ+Z703eZs+EM2dcke/0SepMCQPi5iUqDrwVLZpF8/9lue1A8wWw4zXzhiabYQc64tiHPckPLk3xxVvkzTZIbgeGFMukaN31xESqhv2uQBoKzOBUmK3pkbBJL92S6OpVbl5O9Wj45B4aDxDRhSiYEgUMhIBtmHyn2+K2N3lnRvpjHOM+Bj5KCCPzOd9OJPmjV/MzBVISoklinaNV6mNFyHCL+w==
X-Forefront-Antispam-Report: CIP:216.228.112.32; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:schybrid01.nvidia.com; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(26005)(8676002)(82310400003)(356005)(83380400001)(8936002)(6636002)(4326008)(2906002)(336012)(1076003)(426003)(70206006)(36860700001)(186003)(70586007)(2616005)(7636003)(47076005)(54906003)(110136005)(316002)(6666004)(107886003)(5660300002)(508600001)(36756003)(86362001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2021 21:55:47.6626 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f269daf-0bcb-4353-0e33-08d97e13bc4c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.112.32];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT051.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0220
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210922_145553_406434_FA73A8E5 
X-CRM114-Status: GOOD (  12.89  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Some transports, such as RDMA, would like to set the queue size
according to device/port/ctrl characteristics. Add a new nvmet transport
op that is called during ctrl initialization. This will not effect
transports that don't implement this option.

Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
---
 drivers/nvme/target/core.c  | 8 +++++---
 drivers/nvme/target/nvmet.h | 1 +
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index b8425fa34300..93107af3310d 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -1205,7 +1205,10 @@ static void nvmet_init_cap(struct nvmet_ctrl *ctrl)
 	/* CC.EN timeout in 500msec units: */
 	ctrl->cap |= (15ULL << 24);
 	/* maximum queue entries supported: */
-	ctrl->cap |= NVMET_QUEUE_SIZE - 1;
+	if (ctrl->ops->get_max_queue_size)
+		ctrl->cap |= ctrl->ops->get_max_queue_size(ctrl) - 1;
+	else
+		ctrl->cap |= NVMET_QUEUE_SIZE - 1;
 
 	if (nvmet_is_passthru_subsys(ctrl->subsys))
 		nvmet_passthrough_override_cap(ctrl);
@@ -1367,6 +1370,7 @@ u16 nvmet_alloc_ctrl(const char *subsysnqn, const char *hostnqn,
 	mutex_init(&ctrl->lock);
 
 	ctrl->port = req->port;
+	ctrl->ops = req->ops;
 
 	INIT_WORK(&ctrl->async_event_work, nvmet_async_event_work);
 	INIT_LIST_HEAD(&ctrl->async_events);
@@ -1405,8 +1409,6 @@ u16 nvmet_alloc_ctrl(const char *subsysnqn, const char *hostnqn,
 	}
 	ctrl->cntlid = ret;
 
-	ctrl->ops = req->ops;
-
 	/*
 	 * Discovery controllers may use some arbitrary high value
 	 * in order to cleanup stale discovery sessions
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index 7143c7fa7464..f8e0ee131dc6 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -309,6 +309,7 @@ struct nvmet_fabrics_ops {
 	u16 (*install_queue)(struct nvmet_sq *nvme_sq);
 	void (*discovery_chg)(struct nvmet_port *port);
 	u8 (*get_mdts)(const struct nvmet_ctrl *ctrl);
+	u16 (*get_max_queue_size)(const struct nvmet_ctrl *ctrl);
 };
 
 #define NVMET_MAX_INLINE_BIOVEC	8
-- 
2.18.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
