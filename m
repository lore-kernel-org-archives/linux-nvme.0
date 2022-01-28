Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE020C433EF
	for <linux-nvme@archiver.kernel.org>; Fri, 28 Jan 2022 09:29:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Ymry8Khiq/rlaCHZ/F20rz0EoceiPIihwQGOJnLoTFo=; b=NI2EiJzExoBfpAxbekiWdq17uK
	zYk+j/g+vgfARP6L7gBZhs2zrLIZRhyv7WE72k1kXSIjT0VVe54vHXCbn/APk09/ta7/Jrz0gz5mc
	EaJszn4udEM+AXxWloVgsexp2rEinnHob1lcm0VVV3K8pmQ8FegRALpz6K7MclNCFCubkyWsgvuFR
	fQxbt+n3osXA5kHiCWi7n5w7Qv3zlDopCVL75FavjLuQynnUcZUr+Ace/1Vs9yJBM9OPO3SRtWuxq
	RMpLatEMK2sj3yVV1By6QacTEkPFzOfpX4h8T7SwEHOg8ypckvDoosUHMb09FXrsBYq0jo2Oqfe8c
	Fdps1siA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nDNZG-001FPJ-FA; Fri, 28 Jan 2022 09:29:18 +0000
Received: from mail-co1nam11on2081.outbound.protection.outlook.com
 ([40.107.220.81] helo=NAM11-CO1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nDNST-001DPa-UQ
 for linux-nvme@lists.infradead.org; Fri, 28 Jan 2022 09:22:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FxrJmCO19cm8jahNHKoAf2pbZwn5xLiqzZ0FSGfDq9rEp7RoklKgoHDuLb4W4vKxCl3BJHC7mGJtQ6uRE9LEGNQ63Mfj3ee3b0FJlFp1hEVfSsI+NxDAWf0pvYhE4DgF9rJbZw1woN32WdasZVQEtTq+Q/T6xdr6FT6SbCG3ajgFM1Kyn94w+eISquEDgfwscEbUTDYr9IXgBM3V0ewLamkfYF7YZ96rhWjcISRFCL5NlN7givYHhu3/XyH/dKI/5kUTHVS1jN+CfGDcJXgh/XodMRxwr/+mTq7CBxrgnxYe3fWXpR8RfSETOz7EYtaFgXcIhgkTyg7nAA2O5KR3xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ymry8Khiq/rlaCHZ/F20rz0EoceiPIihwQGOJnLoTFo=;
 b=hG6SWzReCtkulx5NfjGKUrCD9/nqobM9o/BKSsfgANx2W787vHiJg4BnP6zfUGeKan9ZXkRpDOEqBudsofDZ6oPs1QGKvpIbnUDjBL+l/kwOzhkSYT1vq+pex7lG+pWpDEvASpSD3rPT2PLaOljOfnBYges/wGUNJy6z+lnizMMlNKpf4+wgETnReDxz26ndf5vKKJRVoyYpzvbM/dCtm/Mej0AokAjIIqONyGb9RGXOTHuQYwPlj6UQTIPAlzff8Z6ieDhlgbUo/v/lSNiDMYBOBarMBAaZ+Cw7RK39tYO3y+jK4vt/q5XzupAZKoehLn+nk+qE6uMJzRCS7dT0hQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.234) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ymry8Khiq/rlaCHZ/F20rz0EoceiPIihwQGOJnLoTFo=;
 b=pfxlXUV4jlbenaft5fTXON9gEg979Kt4nMtrmFMwqzqbfAAe7qbdgFV3R2VW+iSQtj7tKHp1lLjlQQX3puO/IZKG89C88hzJriMGJT6zBle7yc1+mQcipzVGERVi1dRMCJfWsT3N9T2KLo1jzpeViD96ESfEAbZGLTxMD2fIR3gvwddHlVzgT4t12e3HnfPeaEv7Rj32ewmFr0/Lfn2ODmnt0BvZx++SwJy8EtcxqGF+/tQqXOl7Bnb1ucpSZksWlj8CQKcYKXpWRdGRjT/ODKf+zPNzeyKM1KXBf/Nhy1po93WsyUwvg+yO945l6P6Nra4zwVX2A0O+pc+540XD+w==
Received: from BN0PR04CA0076.namprd04.prod.outlook.com (2603:10b6:408:ea::21)
 by CY4PR12MB1157.namprd12.prod.outlook.com (2603:10b6:903:3b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.10; Fri, 28 Jan
 2022 09:22:15 +0000
Received: from BN8NAM11FT008.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ea:cafe::c7) by BN0PR04CA0076.outlook.office365.com
 (2603:10b6:408:ea::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.15 via Frontend
 Transport; Fri, 28 Jan 2022 09:22:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.234)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.234 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.234; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.234) by
 BN8NAM11FT008.mail.protection.outlook.com (10.13.177.95) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4930.15 via Frontend Transport; Fri, 28 Jan 2022 09:22:14 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by DRHQMAIL101.nvidia.com
 (10.27.9.10) with Microsoft SMTP Server (TLS) id 15.0.1497.18;
 Fri, 28 Jan 2022 09:22:09 +0000
Received: from dev.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.9; Fri, 28 Jan 2022
 01:22:08 -0800
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: <linux-nvme@lists.infradead.org>
CC: <hch@lst.de>, <kbusch@kernel.org>, <sagi@grimberg.me>, Chaitanya Kulkarni
 <kch@nvidia.com>
Subject: [PATCH 7/9] nvme-rdma: use helper for tagset initialization
Date: Fri, 28 Jan 2022 01:20:13 -0800
Message-ID: <20220128092015.19289-8-chaitanyak@nvidia.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20220128092015.19289-1-chaitanyak@nvidia.com>
References: <20220128092015.19289-1-chaitanyak@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: drhqmail202.nvidia.com (10.126.190.181) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1b93004f-acc6-439e-f781-08d9e23fabf7
X-MS-TrafficTypeDiagnostic: CY4PR12MB1157:EE_
X-Microsoft-Antispam-PRVS: <CY4PR12MB1157E2703E47D15BFADC38C9A3229@CY4PR12MB1157.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /ahMV+40DsLA4zM/4HJRXPsyqsBUYrMTVzgaFO9Y4CgZgHQRGuqyqZ1EMmpRQi/d3tEew+DQVRVsK6ylCznPnpWpFdTcFWdFKyLlJ2WMa/jtWSN+9Zb42HuBATuJoKqun1kUe7HYcAl9AyQLPD10/FtDSplQ3erPDKQQWTnqoxqh9oVQ+53qxn9S68nqMeg91D3ZHd9qHpzp85/hjgv+ly6k0mzfNVBkXrzm7Wok7BRyPZV/YECXemGy8ztVlAi3/PYH18nUS5W82Gd6lHVq85LZdEasTpnIPbjWPKqXC/c6IJGXZ0wa9Kq2DWUiHs9UeYBfYbf1jnRD5lmuaJDv3WTGqRIAtUcb0gmYzm0uT2pyBnnvW462/b/Ht88G//fUXtGTSlXsLdcEwkoQfSywbAs3ebnLiqCohh716B97rBDO+cvj0zJ1pBM0y9Rf3s6pNf2licDKESZxrFF6spiCR9wlp+WR4nis6TB4cDygLD2VPASu4iLcOWDUDQkMq4HnX1fW7itsylX9iU+cYQMskk32y0MlW9fdw2uAWjEibJLaaPYmooIRHz4U2bQELiKl3zAoyxhMUkEhcDUDQwOadH8cKufWM4rW8Z9okoAJCEXW5dpYm6cvBHqa55KDA9RFplnUXU+i4dyl4fxbi89FTmD27aKWqGyKdPBKQSkpVR2goCP6Wg7BSTJgVZK9Ump6C7IAmdt04yWFZ0/qAFzqLqiZPETvdtKZw8Z9h1ExcoT+0l6hGHgq+LJohIUJEVSVOBx4LyE/2tyB934CIcx0WpG8AdWHrAzEggtaBgvwNnM=
X-Forefront-Antispam-Report: CIP:12.22.5.234; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:mail.nvidia.com; PTR:InfoNoRecords; CAT:NONE;
 SFS:(4636009)(40470700004)(36840700001)(46966006)(54906003)(316002)(8676002)(2616005)(6666004)(5660300002)(6916009)(2906002)(356005)(36860700001)(26005)(426003)(40460700003)(82310400004)(83380400001)(86362001)(36756003)(1076003)(186003)(508600001)(16526019)(47076005)(81166007)(107886003)(7696005)(70206006)(70586007)(8936002)(4326008)(336012)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2022 09:22:14.3732 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b93004f-acc6-439e-f781-08d9e23fabf7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[12.22.5.234];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT008.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1157
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220128_012218_098744_3F6738C6 
X-CRM114-Status: UNSURE (   9.58  )
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

From: Chaitanya Kulkarni <kch@nvidia.com>

Use helper to remove duplicate code for admin tag initialization
for all transports.

Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
---
 drivers/nvme/host/rdma.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index d033294b063e..1195bb1d5b89 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -799,17 +799,11 @@ static struct blk_mq_tag_set *nvme_rdma_alloc_tagset(struct nvme_ctrl *nctrl,
 
 	if (admin) {
 		set = &ctrl->admin_tag_set;
-		memset(set, 0, sizeof(*set));
-		set->ops = &nvme_rdma_admin_mq_ops;
-		set->queue_depth = NVME_AQ_MQ_TAG_DEPTH;
-		set->reserved_tags = NVMF_RESERVED_TAGS;
-		set->numa_node = nctrl->numa_node;
+		nvme_init_admin_tagset(set, ctrl, nctrl->numa_node,
+				&nvme_rdma_admin_mq_ops, BLK_MQ_F_NO_SCHED,
+				NVMF_RESERVED_TAGS);
 		set->cmd_size = sizeof(struct nvme_rdma_request) +
 				NVME_RDMA_DATA_SGL_SIZE;
-		set->driver_data = ctrl;
-		set->nr_hw_queues = 1;
-		set->timeout = NVME_ADMIN_TIMEOUT;
-		set->flags = BLK_MQ_F_NO_SCHED;
 	} else {
 		set = &ctrl->tag_set;
 		memset(set, 0, sizeof(*set));
-- 
2.29.0


