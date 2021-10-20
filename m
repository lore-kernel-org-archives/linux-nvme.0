Return-Path: <SRS0=Nmvj=PI=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1106C433F5
	for <linux-nvme@archiver.kernel.org>; Wed, 20 Oct 2021 10:40:51 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C4E661260
	for <linux-nvme@archiver.kernel.org>; Wed, 20 Oct 2021 10:40:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 6C4E661260
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:CC:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=LpMcNOpeUOQuRELZFc11jxNZv+D3VG0b1BzAlerXkrg=; b=RVo4V5jlRu479MhSwJNy8HM2pN
	jTgJkyvA1GkgA2RyoNr6+HmKIJZby83z7EAGotDYfkYvyGrPi0XWXcEBHfpel3rbKBQLpjF9aLRuv
	LX1NpyTKwu4P3wzGk28tuHwo44OWyA37nuxSmggCExYc5SguVLzhTKBQHG9PeTqvw+hrRXxAbWTfp
	yZteCw78hMMVIZ3ePaiN95FHEYJSMdpSmrjn3aPrB0W+yAoxRR06ARCN8V3WOiRVW7PDOTZqO+RV6
	kaZRfu1PaHPoO4KzfDkQk7G/ZqsZ2UyGcqlDUsB/OWKHDqcm6yalZB5rh8+u5qX9982nVTtbCLj5b
	76zBa0dA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1md91a-0049jm-Li; Wed, 20 Oct 2021 10:40:46 +0000
Received: from mail-co1nam11on2078.outbound.protection.outlook.com
 ([40.107.220.78] helo=NAM11-CO1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1md905-0049N2-3o
 for linux-nvme@lists.infradead.org; Wed, 20 Oct 2021 10:39:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Sk937ukLxxw4adMqtSgBx8Vz0MYLbC1MlNG/XFVr96B/j8RCWxxrMjWp6k67dQzU4iGLKihak9T7ZFFg/XZwCMNrKhK4F5ol2/U16HK9zMf4F5FV+XnQJQBinmyx4SgcSl+mmGvH+7ZKuupwpjTh5+hjvIlfBHVS54826iACvhGMEgylv/v6VmElJTUondVc47UGuZJsFeW7wwhZXuJgMvCSbqZHittWw0CUowxULjyvuRegZ3THdnqX2Po6oNe3SoRT0Y5drKfy7t+JyIq18IqB2fPLOpKIcoX81SZZ/bR96FdfLAp8oP1OR/tuL81vNpTBLvZtpmiKQ1cYOMgU9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LpMcNOpeUOQuRELZFc11jxNZv+D3VG0b1BzAlerXkrg=;
 b=CR/mXdYB3ebIjGSE2/lOQzUqzqFdm70AEIhGNTxO16w+iWxxk4BWomaozVYemGNYC25hcotS60aLe76G8Uk9OpEz17Q+tR7CVLfu5W3ltIPn3DSU7dK5vJA10BkIPB7GCDylCVezHrL+W1zibkNQEkZL9mYOxy8Pi4gxQfn+nEO9/oHO7Obxa0Qc8HwRuwmB6mJvu26MJCC39hN/SRYgxDxdvS6P2EuDtdWHqY1DKzfLuBhEJRR/nls2dU5qK6vYWJI2PxFol0c8upfyqZ3NLvxZW4AjtuYUWuWmhr50N5XJe9Ar6JImbGWaWIzGP1+Yb4AxPprCBU4lwsjJTb0fNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=grimberg.me smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LpMcNOpeUOQuRELZFc11jxNZv+D3VG0b1BzAlerXkrg=;
 b=knq8pt9EqIBGffgplFdj12p4t7Ute+e9fMqbXE99JzII48/kLDZEcWMVVUhP8FT1GfhAZNakVNlBq2rOKJUWxVrr9G5ixQ/Pdjo1vqgE6aW8junf+oM8Fl7HxCHMepECTXiiPImdLTd6auncsUyq7HYdjNNGk0qr9aXnMjz53scQf0j2K33eVcDmE7ROZZFtrMQNGf2Vz3AoknXk0vf9zAyn8LxAPwkewYQk1/uO8byZdZfO8YkN4ufkw2ffT1B9vG9StDCnZgmJzI/j9sr5oQrnu8Rtn0wh+UZ4ZZ9fVCltQjtOkkA4Gi+IFCnvrZALgZx4DQezmA9vZF5o2wI5RA==
Received: from BN9PR03CA0643.namprd03.prod.outlook.com (2603:10b6:408:13b::18)
 by BL0PR12MB5538.namprd12.prod.outlook.com (2603:10b6:208:1c9::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.16; Wed, 20 Oct
 2021 10:39:11 +0000
Received: from BN8NAM11FT017.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13b:cafe::6c) by BN9PR03CA0643.outlook.office365.com
 (2603:10b6:408:13b::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.16 via Frontend
 Transport; Wed, 20 Oct 2021 10:39:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; grimberg.me; dkim=none (message not signed)
 header.d=none;grimberg.me; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 BN8NAM11FT017.mail.protection.outlook.com (10.13.177.93) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4628.16 via Frontend Transport; Wed, 20 Oct 2021 10:39:10 +0000
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Wed, 20 Oct
 2021 10:39:09 +0000
Received: from r-arch-stor02.mtr.labs.mlnx (172.20.187.6) by mail.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server id 15.0.1497.18 via Frontend
 Transport; Wed, 20 Oct 2021 10:39:07 +0000
From: Max Gurtovoy <mgurtovoy@nvidia.com>
To: <linux-nvme@lists.infradead.org>, <hch@lst.de>, <kbusch@kernel.org>,
 <sagi@grimberg.me>
CC: <chaitanyak@nvidia.com>, <israelr@nvidia.com>, <oren@nvidia.com>,
 <hare@suse.de>, <jsmart2021@gmail.com>, Max Gurtovoy <mgurtovoy@nvidia.com>
Subject: [PATCH 08/10] nvme-rdma: update WARN_ON condition during reset
Date: Wed, 20 Oct 2021 13:38:42 +0300
Message-ID: <20211020103844.7533-9-mgurtovoy@nvidia.com>
X-Mailer: git-send-email 2.18.1
In-Reply-To: <20211020103844.7533-1-mgurtovoy@nvidia.com>
References: <20211020103844.7533-1-mgurtovoy@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a2772877-6014-44e4-83de-08d993b5da3c
X-MS-TrafficTypeDiagnostic: BL0PR12MB5538:
X-Microsoft-Antispam-PRVS: <BL0PR12MB5538EDBC24996E232D9DBE9ADEBE9@BL0PR12MB5538.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2803;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OaVdWrsH+mlSgnfQe0aXHyqOiGzsRgvwMtBWKZGkEKtzxbwDp/2ADns68lP2llTI/8saa4IK4uiqchEWfKyvv7xA5aDtXku8HkMqFEmbmFHhSzFyaRtwMvHcKi7epjYCal4FDD3oOkWKOIxRZ9cqh1DJIJviUsdP9eduVjbVzhlqc3pL4WoFyJ2vvrDAw7EArYa+Im2CTly/17+MldfbXv7SXY3nQVw/ogyRdncKysCUm76a3fsV6+4zHQeUovnR0MhKdqnyB0DF5NwJj/yPNbi6XufYkGq/BVTZoshbbz3/BRwSUYZ8ZQu2YL4NYIYVA6Pmk9S5cijxprVM8K37lWUfc6et4Km6QEqBgmfSgr6skSWwF3EaabuO3V/tqtTU66nZORbzdOCdBfZTr+j03i2Et9PEuAcXCBHrl5o29Yg4qY2XT0bpf6Jt43fAvy9kcyiGqHN1Lr97lDGFXv1Oig5f2AhIciYJPXjIpoW8D7gI4tAj4vKfaSHldpjgFV+0GLHO1odT0BcdVt7P5pFrr9WGosMm9Gv41ytgNb1IZBL3Ec1JCIWbopf5XMAomzmmcBkutIbL7dQ8/b0p0+cnZaCSTEGdzIMi2I4O+euToRrclPNTXiVdzttCBBTRJpMlJcKqqNNpDysjAZTyUSeMYfB7wOmouQpW9T8PcaJtnhC7vuYWJEbzEa6dGsHvUQy7K2DPKzuaTs7kr2Hw/I/d+w==
X-Forefront-Antispam-Report: CIP:216.228.112.34; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:schybrid03.nvidia.com; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(508600001)(83380400001)(36860700001)(82310400003)(70206006)(7636003)(47076005)(107886003)(4744005)(5660300002)(8676002)(186003)(54906003)(2616005)(336012)(8936002)(2906002)(356005)(26005)(70586007)(36756003)(1076003)(6666004)(86362001)(4326008)(426003)(110136005)(36906005)(316002);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2021 10:39:10.3172 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a2772877-6014-44e4-83de-08d993b5da3c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.112.34];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT017.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB5538
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211020_033913_178268_48427DB8 
X-CRM114-Status: UNSURE (   9.89  )
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

Changing state to NVME_CTRL_CONNECTING might fail if we started ctrl
delete procedure already. This is allowed in NVMe/TCP transport, so no
reason to have different WARN_ON_ONCE condition for NVMe/RDMA.

Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
---
 drivers/nvme/host/rdma.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 8e1e8c8c8a0d..f4eeafee05e5 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -2183,8 +2183,9 @@ static void nvme_rdma_reset_ctrl_work(struct work_struct *work)
 	nvme_rdma_shutdown_ctrl(ctrl, false);
 
 	if (!nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_CONNECTING)) {
-		/* state change failure should never happen */
-		WARN_ON_ONCE(1);
+		/* state change failure is ok if we started ctrl delete */
+		WARN_ON_ONCE(ctrl->ctrl.state != NVME_CTRL_DELETING &&
+			     ctrl->ctrl.state != NVME_CTRL_DELETING_NOIO);
 		return;
 	}
 
-- 
2.18.1


