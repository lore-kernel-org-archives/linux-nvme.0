Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63C13C433F5
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Mar 2022 23:01:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=sv95AZyJfhBa4+94+f6jM6nkF/4np5vDUGwA7coFG4A=; b=a01WaSQkyTx0zgsMjGLLQBWghV
	bnD+3PTdQgjcsUjuBgtbgWvbdKDqWhs4MsW2wu38hD8zmIR4bSSpJS1pnARJGz0aDEYx3qZFC7WJE
	ZKCGXH6hrxAi7H1zOGypO91HM6+ETQvX3S2UnBwEsNy1IRXrtO6noW9410AHtdWpz7kqEZeasbeLv
	fY8iWBUcM8aMp7Pjf9BwsIXbLLJW9STr5SDf3eoR8D8xCTzPabg2aGrAxVR+HC+WjQ7NCywdvfQ9I
	+2pe4eu+r8cbFKqCbhGBkvB15XE3Tmvll7SHdxHammYnRyKF/TFYOVkYmXJ5p52+2SIJPrTaNc7Vz
	x+Re5MWQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nRipN-006TVT-6P; Tue, 08 Mar 2022 23:01:13 +0000
Received: from mail-mw2nam12on20605.outbound.protection.outlook.com
 ([2a01:111:f400:fe5a::605]
 helo=NAM12-MW2-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nRipK-006TUV-PN
 for linux-nvme@lists.infradead.org; Tue, 08 Mar 2022 23:01:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CvdKPh2mk/YwXsmy8wAebc3LN9dqRCTYNnO27E1cS1GZdiLklYQ9Qa4ay/eeVs0E/shInnTbHFVE1xZiOAJ+BZ/HaWmbU3B9xiXbOG1f0qsuaCi1I9lQJg01W13zrK0dYMK74csRjyviYPxRCSIsiOAjftUgVlry4yppIxdE3SolDIbpxdISwwG/8YL+MsIlK8kq0gLQowK7NoMnWpTQKt91Xf8oHEwq3brsuyywK8T38xX2Rmk583tfNd+6kyGBm+o/6fLcxileXG2Sdo9dG8epUeOJ9bVVLGXx23VKcsE2S9N1isr/2CChC5xIx6+oZKJztR+VV0j0bz0tg7RpBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sv95AZyJfhBa4+94+f6jM6nkF/4np5vDUGwA7coFG4A=;
 b=Fhsi+kl9Xawv6XR7o34lQIvKumO+fz7RQXhhx0m8Se/t+kVRmAscamD7hGv5UbLo6tEuny7szJL6A5pYvKKvBun1FQ3dW1QM6yaY8Sja1yZjq7zWN7oVjB5JuzDgKbpxkmNRfeGsY2ALRGzehBa42YtrYXreTcxgJ1QWVBH/PsjppfgYDZxLfs5W8Hr3fCIf0sJ3Sf9+goTu1kUnA4kORRRK7fflTOLpICgjugJxKrNfyAnUArRkb7yBBepY3/CgoPWUb3DR7uUfxQHCadK8tRCjHw2nqMvTyyjhg6cMTCkJBcbL1jw2myHQM1KmQoUpbKcFG5dbOQANigoEqNxIvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.236) smtp.rcpttodomain=grimberg.me smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sv95AZyJfhBa4+94+f6jM6nkF/4np5vDUGwA7coFG4A=;
 b=H+jxt96BTgQzuMVUPFx43Y/uhnJFufbmphBxIKC+7mlazUwGQhQNy5YqX4iAlev5cOT0sFd8hEDkd2vxO8RiVVv3+tLhnUwLctpcanAY52aHc3YmpEIORq1asSZYsvs73LQOo7+7MTLklGSPRj+nQvSSL+Qr82dGwyu92r4w+PyDlwQAWD6XSqWhqmwias8dzpDwW4TktemGJBbM4uvhkxj/TWeXbRietcDWNdSaW4AXar1JGPiGmVW0OmMOGnd/79rjaCAJosyitN+dzZ9VlyMsjrhiezNVqiG7BxoMjPg1EmNeveQSVPUY7l0GNBu7QJEDACfKjBJfojjKLSid7A==
Received: from DS7PR03CA0179.namprd03.prod.outlook.com (2603:10b6:5:3b2::34)
 by BY5PR12MB4211.namprd12.prod.outlook.com (2603:10b6:a03:20f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Tue, 8 Mar
 2022 23:01:06 +0000
Received: from DM6NAM11FT055.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b2:cafe::24) by DS7PR03CA0179.outlook.office365.com
 (2603:10b6:5:3b2::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14 via Frontend
 Transport; Tue, 8 Mar 2022 23:01:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.236)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.236 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.236; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.236) by
 DM6NAM11FT055.mail.protection.outlook.com (10.13.173.103) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5038.14 via Frontend Transport; Tue, 8 Mar 2022 23:01:06 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by DRHQMAIL109.nvidia.com
 (10.27.9.19) with Microsoft SMTP Server (TLS) id 15.0.1497.18;
 Tue, 8 Mar 2022 23:01:05 +0000
Received: from dev.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.9; Tue, 8 Mar 2022
 15:01:04 -0800
From: Chaitanya Kulkarni <kch@nvidia.com>
To: <linux-nvme@lists.infradead.org>
CC: <hch@lst.de>, <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>
Subject: [PATCH 3/3] nvmet-rdma: fix compilation warning
Date: Tue, 8 Mar 2022 15:00:22 -0800
Message-ID: <20220308230022.8863-4-kch@nvidia.com>
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
X-MS-Office365-Filtering-Correlation-Id: 4d4cdfbd-6db1-475f-6a2f-08da015786e6
X-MS-TrafficTypeDiagnostic: BY5PR12MB4211:EE_
X-Microsoft-Antispam-PRVS: <BY5PR12MB421183465566DEC15075FC9EA3099@BY5PR12MB4211.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: g+y8+dYl7THtR2w82iGf/axjc3Z9KGA84CClQjN7X0pCO2MoIW5E8noQANtw8pgFn6BaznfyF0Gx7LEfTRlQQ5Mw1tgTYe0uHSxtq0PPjChJbRqSBc7CLoxZo8TCG5ct0sLUMONOyhLwGPsIpdQD1ZgKJoUuMeTCVocqR8WECT2MsgG1f1d6qRZ5zgETHrmU4/dcBhsRLN5JzMW7g01mldbRCN+sG5gY11+Sx36Y1vAD11RodGnhsrJ73eEVLutBCedF2rPChN2dXPtCY8QcSeTe/7zxAtKLMbLfgjSgyyWufXM4n7ZZcLqMk5vQEmqt8yB4M39SvN5OqOf3zAwVb44n/9L+85TkYjLHh8bSkRdUGo+Qf6h9F2Flqrx1szCdEE//82WOqWhjdj0pMEWm0Or7XYrH5vrWNnDsNMBMEa7DBWxp7y4B+1CMK9e5ysrnCfQp9zTBop1fJaJzTkNk7A9Q/8yDeNLmhZe42/MVgcddet7Da0eewX8VvjEMSWZIXBHnoyZFByuNsC6nhrqubkedt7fzYIA13TZOSwC29yZZrklXrdOcnjDDPXPkGsTukEAENXIYtD8JScN4tfrqTswSLHgYj4hkUhARvlCj6YEMOalYipD/GZqbUnXeCqpAZC7JADEu8PondYncjIkS19xQBLQT+Cjx6KKbfQiMW8oLIMqx8XiEQ1Lkf9l3t50qd45aggfv6mhEfpEq9osGdg==
X-Forefront-Antispam-Report: CIP:12.22.5.236; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:mail.nvidia.com; PTR:InfoNoRecords; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(6916009)(8936002)(36756003)(5660300002)(4744005)(107886003)(426003)(82310400004)(54906003)(16526019)(81166007)(2616005)(356005)(6666004)(7696005)(186003)(336012)(26005)(1076003)(47076005)(4326008)(2906002)(40460700003)(8676002)(70586007)(70206006)(83380400001)(316002)(36860700001)(508600001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2022 23:01:06.2126 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d4cdfbd-6db1-475f-6a2f-08da015786e6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[12.22.5.236];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT055.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4211
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220308_150110_883975_09C1D8B4 
X-CRM114-Status: UNSURE (   9.16  )
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

This fixes following compilation warning:-

drivers/nvme/target/rdma.c:1722: warning: expecting prototype for nvme_rdma_device_removal(). Prototype was for nvmet_rdma_device_removal() instead

Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
---
 drivers/nvme/target/rdma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/target/rdma.c b/drivers/nvme/target/rdma.c
index 00656754e331..2446d0918a41 100644
--- a/drivers/nvme/target/rdma.c
+++ b/drivers/nvme/target/rdma.c
@@ -1703,7 +1703,7 @@ static void nvmet_rdma_queue_connect_fail(struct rdma_cm_id *cm_id,
 }
 
 /**
- * nvme_rdma_device_removal() - Handle RDMA device removal
+ * nvmet_rdma_device_removal() - Handle RDMA device removal
  * @cm_id:	rdma_cm id, used for nvmet port
  * @queue:      nvmet rdma queue (cm id qp_context)
  *
-- 
2.29.0


