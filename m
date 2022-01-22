Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B80FEC433F5
	for <linux-nvme@archiver.kernel.org>; Sat, 22 Jan 2022 05:05:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=GyOLct9Ke/CQtaMknzx19KqSbUvO6Ua2nLFc2dtvljg=; b=mD572D00N1aWf2qQHkteeIVa1m
	PPxxG2glYGTuX7dl8mB02Xlu8QYP6fSMOr5xVwDwFCaUt0ds/QQOnKU4GlH8DqN3N9TtfG78wj+oW
	NrpveTXaeFikGLjdg3zYS9Th780haODUVSZMll6U54I5dwqmHl7DkghJHA2mW7A7zqvry78cD6L3Q
	o0uc2Zf6bl0XnsLyuIm9EkBrvCY/qo3Xh1Fhwe/MDFC0puv2b08Z3A14BaLRkc0nI+OrSLOYotyBW
	Vpd8o76WAiMUQ2+x1qqNj8LiS5xmG2Q7CgLOnGho6Nn13MkUinJl7KEIdLW0zZPtxAKoKYWJGcyGj
	CEAGZTuA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nB8b3-00Gc8F-Qo; Sat, 22 Jan 2022 05:05:53 +0000
Received: from mail-dm6nam12on2051.outbound.protection.outlook.com
 ([40.107.243.51] helo=NAM12-DM6-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nB8b0-00Gc7f-K9
 for linux-nvme@lists.infradead.org; Sat, 22 Jan 2022 05:05:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gD2vCU8eF57eMydDxmu63d2MTBZyAcT8d3+/wqXbhTEA5nWs/w9Pvzd7vNGNHbRX49QRPghFASkDEh0yNU9HydzF/fX7UjVJBgyhM5bY+yHDpOfK4rW3ui0IHkbvvoqrI92zDwCPd5lkygcWqN3pcrtYj4Yd2Jsffi16tAmJQBzKjkOxtrxPjYSx6NItFqqK4nYMNStGAzl/JvTVcr83oINCp8Gi3t3XdUcb/4uJ56Ly8ON2/w5bcJnkyhwdSV6hRsIplteeehabCKYU8ROlzSk7S4PvJFNuBWuJY7WQK8enGx+5zSiyusQU3jn3Ed2Il6QCba4gtT4QVdmQaDZEVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GyOLct9Ke/CQtaMknzx19KqSbUvO6Ua2nLFc2dtvljg=;
 b=NWte7g4FegnHONF3gN1aKhPjgg4WxkeLYX5ZecFBTPmoRY0wCSOoxeZfEoFnN3C1jsvGAOJYHpUeWijD9rk8EUFWcnNAZpco0GI+5QQK2XecHjmeY24EI/2YJ/RwKDVEl6JasscubhkQjqh1E/xj0UAaUjDJht/ddNvrBxGD7B1E/Kx9yp9IyxsdLPDxVk3veDtE0sZ5qtlB5HzHR6lE9VzB0xaMaYTP9YZremOjg7xWN0i/mOL/hrgtLbMJSrJGU1wjut9yX8h1EPtoVprbxLeB+w4ufOjtV2q+qNfuD3dMe7ZRJN5Fp2dyQWdx+Oivc1ih2bx9VLstI+sEck8XwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.234) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GyOLct9Ke/CQtaMknzx19KqSbUvO6Ua2nLFc2dtvljg=;
 b=rvxSlXW4ls5PCB0h3phovtZVSsloZqWoJm3LTppXPfiQwveUO9lkwyju7ilONZ/paE+rFOmn8Mm9C2qqAlBTQx2DM9Vv3HHQzTXZoPVzUIbPgolbXCFS1AqyKAkXdLv2wACTnQJ2zXI/bHm5lzX+zlDrAS12KnIVymLA49ozK7JgSv5Z0fI+I3Axu9IGMI+CAqOmad1/B3He28XWUUAScaddvdqT05jKs7muGGnb8O9VGbXCeOsyCDynaZMmwbvgHakFZGl0HNC7Y7HcUPyTJtYI+jDBQx1WNd2dKFof1l2o6yJWNJVU+ZyUtjlcsFrbSWgAC1tRwKFl8gNww3UPIw==
Received: from BN9PR03CA0626.namprd03.prod.outlook.com (2603:10b6:408:106::31)
 by DM6PR12MB4402.namprd12.prod.outlook.com (2603:10b6:5:2a5::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.7; Sat, 22 Jan
 2022 05:05:48 +0000
Received: from BN8NAM11FT009.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:106:cafe::9f) by BN9PR03CA0626.outlook.office365.com
 (2603:10b6:408:106::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.10 via Frontend
 Transport; Sat, 22 Jan 2022 05:05:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.234)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.234 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.234; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.234) by
 BN8NAM11FT009.mail.protection.outlook.com (10.13.176.65) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4909.7 via Frontend Transport; Sat, 22 Jan 2022 05:05:47 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by DRHQMAIL101.nvidia.com
 (10.27.9.10) with Microsoft SMTP Server (TLS) id 15.0.1497.18;
 Sat, 22 Jan 2022 05:05:47 +0000
Received: from dev.nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.9; Fri, 21 Jan 2022
 21:05:46 -0800
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: <linux-nvme@lists.infradead.org>
CC: <hch@lst.de>, <kbusch@kernel.org>, <sagi@grimberg.me>, Chaitanya Kulkarni
 <kch@nvidia.com>
Subject: [PATCH] nvme-core: remove unnecessary function parameter
Date: Fri, 21 Jan 2022 21:05:39 -0800
Message-ID: <20220122050539.6726-1-chaitanyak@nvidia.com>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: drhqmail201.nvidia.com (10.126.190.180) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3e2e5d3e-c659-4c52-49bf-08d9dd64da77
X-MS-TrafficTypeDiagnostic: DM6PR12MB4402:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB440284F2E530B53535094A89A35C9@DM6PR12MB4402.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AbhVZnSskMQS1fn4pIcqxyurA7F+wa86m9tM3NKqyGhgDjYMv/K/d/yLn1q0sjHVFyGn8jNubvgcep5ET50bFJcB+8KP3bUveVzPbVZ3JGayXDVJv+ITp6/bKTN44AETaVhkcTWMFZtHwJf95midvC2Hai7GSFh4UH/Wv/LyLOu3uvbXbo0UtEjb6ds1fYh9V5m7/k82pL6N/YUAZPMRCVSbFvQnMQHgMhXsk6fkahkLxMJzTBsNYmi+WVsMfMQiYihvROv/77TxWM9BHhxmcnldjH8TGyvtgOxySBGUkJYLGkAiboyTgjc/7TqiibNARn1pHBsWgNZPCavNE7eoU+/AzCBhcUJE2Aq8bZyNCGhyoutVcExKD3oIEiNCW45Qy70NYii0CmL1Dg+Geg8rzFucXneIIAERfrDVAIPyuBeHkXDAxiVGLMQD2RhkcSqTlXwmxR7uuE6SJdyB1arOTRe2P7b+z7Z2Av0nPXpu/PqxsU9tEYxItOtxEDkApH6D7rYOCHtmRLpoH/1BikQ1SOaaht1QL9OBsrVfwI+BmcFndE8drBx2BY10iNR3zRwrjMNF5eF9BtXZb4S/FbWM2zAU92AbCIHbl2hyN9kLVWQOPJz8OtGrb9yJEgyWrSJgD5xER6V+EwONvrW7S5TfQUN/ozC4QGr4BJyMtVp2aaF4KpcUq3PbBM00UfoUL/GzreK1MM2lENoP51Zw69SPP8q1h9bsuox2oBrFSUf3FDY3wq4sJk/aTliOiJPdi7BJIWnn/+w9M9ZmwYfkoBqgjgJPfnI5rCLjpi+OSzAmGGg=
X-Forefront-Antispam-Report: CIP:12.22.5.234; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:mail.nvidia.com; PTR:InfoNoRecords; CAT:NONE;
 SFS:(4636009)(40470700004)(36840700001)(46966006)(70586007)(356005)(70206006)(82310400004)(508600001)(336012)(4326008)(426003)(81166007)(8936002)(2616005)(7696005)(36756003)(26005)(83380400001)(8676002)(107886003)(2906002)(186003)(16526019)(36860700001)(6666004)(47076005)(1076003)(40460700003)(54906003)(86362001)(316002)(5660300002)(6916009)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2022 05:05:47.9636 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e2e5d3e-c659-4c52-49bf-08d9dd64da77
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[12.22.5.234];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT009.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4402
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220121_210550_705374_9B906B79 
X-CRM114-Status: UNSURE (   9.49  )
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

In function nvme_execute_rq() we don't use gendisk parameter at all.
Remove the unsed parameter and adjust the calls.

Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
---
 drivers/nvme/host/core.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 1759538b36fc..7990c08889da 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1048,8 +1048,7 @@ EXPORT_SYMBOL_GPL(nvme_setup_cmd);
  * >0: nvme controller's cqe status response
  * <0: kernel error in lieu of controller response
  */
-static int nvme_execute_rq(struct gendisk *disk, struct request *rq,
-		bool at_head)
+static int nvme_execute_rq(struct request *rq, bool at_head)
 {
 	blk_status_t status;
 
@@ -1089,7 +1088,7 @@ int __nvme_submit_sync_cmd(struct request_queue *q, struct nvme_command *cmd,
 			goto out;
 	}
 
-	ret = nvme_execute_rq(NULL, req, at_head);
+	ret = nvme_execute_rq(req, at_head);
 	if (result && ret >= 0)
 		*result = nvme_req(req)->result;
  out:
@@ -1205,12 +1204,11 @@ int nvme_execute_passthru_rq(struct request *rq)
 	struct nvme_command *cmd = nvme_req(rq)->cmd;
 	struct nvme_ctrl *ctrl = nvme_req(rq)->ctrl;
 	struct nvme_ns *ns = rq->q->queuedata;
-	struct gendisk *disk = ns ? ns->disk : NULL;
 	u32 effects;
 	int  ret;
 
 	effects = nvme_passthru_start(ctrl, ns, cmd->common.opcode);
-	ret = nvme_execute_rq(disk, rq, false);
+	ret = nvme_execute_rq(rq, false);
 	if (effects) /* nothing to be done for zero cmd effects */
 		nvme_passthru_end(ctrl, effects, cmd, ret);
 
-- 
2.29.0


