Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBBFBC46CD2
	for <linux-nvme@archiver.kernel.org>; Sun,  7 Jan 2024 00:30:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=0c8XxJv5wxnCw04yvVFPwkW9MufoFuvV0UrhpC5MuEU=; b=0Ga/DhC/0v3+/NW1nQVzuVUCKk
	7OazWbLJFKD4R0JFnjfcHkxWZAomdsyzKeU96oszRZTsEeA7K/hkU8eeisszQDnmSoOAGThtEmKxQ
	Oe9LdK+/CqOV6mlduFrfLP8yhGFzPxj0qAkS3/mOXLMqtY8dTc3ihwvlcI4c9D/LFED/RteJNHPEB
	AIDqYDEfGP7u++aJAXQiXDpUpmSp/mfO4lHJWbhUVmkDTOR4pHmktWCwgHlIDtrSRM6lSUA+xgKRt
	oIh1nr21SrqNCdNvxjlCxwTLir/iG3mrXzZjI+BCKHnryID0pTNpNiZZ4slRHSEnVYS/kgNyc9vHH
	qT4q5+SQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rMH3V-0026pc-0L;
	Sun, 07 Jan 2024 00:30:21 +0000
Received: from mail-mw2nam04on20601.outbound.protection.outlook.com ([2a01:111:f400:7e8c::601] helo=NAM04-MW2-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rMH3S-0026oa-09
	for linux-nvme@lists.infradead.org;
	Sun, 07 Jan 2024 00:30:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PlCuUPR/FgPH6mDMF0yhwR8s11O7xFfiGD4J9pXt3mL3jLwTVFiQrOaV6NyhuT6HpbS0/ar/VRvqC5wQslIrFUQLGl49ltgjLCNjOPebA3Fj/+lbvMc3QGystWRHsNB+nfz5bfLwNTUqkewATJVHqHBIZo8MINVp2cDonChgTgAk2zd1xtHERCJTQ78sDnfMxSmgJQV6VJJIu+NCgwBwUCU56igkLIKIDDKLX/We2rc0nS7TdMV+pd+rkI5Y1KKKRBKKTT53DmBm/QfisNXowvvg7/89L4pQB1STS0gEZqW3RludtrutyZHKLltjIcXzBSWBfWPD7D57SLRAgzdA4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0c8XxJv5wxnCw04yvVFPwkW9MufoFuvV0UrhpC5MuEU=;
 b=deXcxmiAu9pxT35CbPoTnG0tbhxaHG0xsJH9hBzSInbVLSd8vrHX+YYVUMYRDj4j1GK3ZXGkYfSojjpTWyTLhqKPZO2eQmpxS3oWFzzxObdFmxv+FiXIzE3MGagYL/YhXfFF8wQTH3+SZu4cjWpkm7Q57cX3BoSbFw1Zf0xnbf1vLA/lwe2wbxMix+YpStFssiDVr/rij5sYhyLRvLDOsNT73Xqx2sX3YjFCDCUE7zXfw6BbHKyM+GRpoQSiOKVMj7rl4p4Q+odPaNk/0vudnJH503bD1RZMiLi5IvEUyNNsc8od9NzprNPMXKM6yUTqFWVSvSG76xrLqIeIM85rEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0c8XxJv5wxnCw04yvVFPwkW9MufoFuvV0UrhpC5MuEU=;
 b=us7Ps32nC+ZPfdvaGZMrsXcvrwi7QHWC0ZrJfl/8Bd2UmDIF/VXhL9qIqAtk/rZMn9NARK+163zR0IyyeJjcxme02z6pXScY1uCl7rMsjOSthIJJb3GSBNx1nTD2Rc6pKiD5wTHYTIlONacDwEYBqqFwI0AoCDf2P32QiPvjl/ovMbXwOLgQNKdADObgVAIRGPKOg7K1deuOW4KJq0VpPSarYrykjacwFQet0WCRC2YSUSSM7jvxRtrs1AMFN5Iwb9zGQHPn4K1FQG1Hb1oBqehjIvDJHrA1ocbdP0FGXSnoVz3pX39Hp1hkSnjJaBBO7MoE6ko1IBMpj0yJzPOZ1A==
Received: from MN2PR02CA0031.namprd02.prod.outlook.com (2603:10b6:208:fc::44)
 by PH7PR12MB6540.namprd12.prod.outlook.com (2603:10b6:510:213::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.20; Sun, 7 Jan
 2024 00:30:11 +0000
Received: from BL6PEPF0001AB76.namprd02.prod.outlook.com
 (2603:10b6:208:fc:cafe::b7) by MN2PR02CA0031.outlook.office365.com
 (2603:10b6:208:fc::44) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.19 via Frontend
 Transport; Sun, 7 Jan 2024 00:30:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL6PEPF0001AB76.mail.protection.outlook.com (10.167.242.169) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7181.13 via Frontend Transport; Sun, 7 Jan 2024 00:30:10 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Sat, 6 Jan 2024
 16:29:52 -0800
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Sat, 6 Jan 2024
 16:29:52 -0800
Received: from r-arch-stor03.mtr.labs.mlnx (10.127.8.14) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server id 15.2.986.41 via Frontend
 Transport; Sat, 6 Jan 2024 16:29:50 -0800
From: Max Gurtovoy <mgurtovoy@nvidia.com>
To: <kbusch@kernel.org>, <hch@lst.de>, <sagi@grimberg.me>,
	<linux-nvme@lists.infradead.org>
CC: Max Gurtovoy <mgurtovoy@nvidia.com>
Subject: [PATCH 1/2] nvme-rdma: enhance timeout kernel log
Date: Sun, 7 Jan 2024 02:29:49 +0200
Message-ID: <20240107002950.6233-1-mgurtovoy@nvidia.com>
X-Mailer: git-send-email 2.18.1
MIME-Version: 1.0
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB76:EE_|PH7PR12MB6540:EE_
X-MS-Office365-Filtering-Correlation-Id: 64c32f35-16ef-4887-d480-08dc0f17cea6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dhJBW8VTO7xQe1xW9Ac/Rd9tNkjd+kagYkq76wSERH08BDZNf2M9L7ZrhYa0Ic234fAKDxjtUth3w5aRjbnnhp4clMkf7MR9jCiWpl6u3zXQtM31NxO9/zdxLXye+SIyxbYqH7Tm27LbXuxEuiUscud5mCOZ6a84RExt4GZaaKltoCqZWHhH7Hix55fVWUwkAmR4TN6l+P9xDYZCYHg4p4WKCwHogn+cjZ5UARRfM6mX/newmLpr5E4mBeaSkcjzVTrfqWqyFGDo6/8Zrwb2X5iRrjgsl3XH247d/l0C+x7iwCumI8KUYhZokPdN0BS1ak3uV0RggkyFIYvjPlaSv5zKyipe5jLQyZONRCXl28YFERSN5sAS3aiwRml0CYxbNUE1Qf1Rqg7u05NMaJKzUPJuZAdIoUImhUetrDP1Mk0Kd6FyNDrd5I7/+C69doxebPE0t1jU/DWO1ap4QCKe+xuBTWgZWFXO2QIj2jTmttFtg3dK7DWrZtDWJXGrGAtyBzLUDSwx/GKttrkFW1Nv9fN6tgVhaULgQc51XwBOGmbQtT6e8W6He4e6F8XX/l7vFzxAtmJIk1/AvQyHfFO0LYEoeQ0bTuPHEkQIRCrX8n/A0PB5B3ILOKzqKkAPcqdL5afZTJGaJae0VbIuIK3iPndu8z85LWUaPZo82KXTF4MAkMIGKUkfsPc06oJpBrWp4yQfazqu6AsLkBwclFmNTxgosJ6M2DE2cXkGxGENONY=
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(136003)(39860400002)(396003)(346002)(376002)(230922051799003)(451199024)(1800799012)(64100799003)(82310400011)(186009)(46966006)(36840700001)(40470700004)(40460700003)(336012)(426003)(107886003)(26005)(1076003)(83380400001)(2616005)(36860700001)(82740400003)(47076005)(5660300002)(4326008)(41300700001)(2906002)(478600001)(8936002)(8676002)(316002)(70206006)(70586007)(110136005)(86362001)(36756003)(356005)(7636003)(40480700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2024 00:30:10.3597
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 64c32f35-16ef-4887-d480-08dc0f17cea6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB76.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6540
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240106_163018_087987_BEFA9171 
X-CRM114-Status: UNSURE (   7.91  )
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

Print the command_id along side blk-mq's tag to help match commands with
protocol wire traces and logs.

Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
---
 drivers/nvme/host/rdma.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 7c99c87688dd..a380bafbed08 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -1946,9 +1946,14 @@ static enum blk_eh_timer_return nvme_rdma_timeout(struct request *rq)
 	struct nvme_rdma_request *req = blk_mq_rq_to_pdu(rq);
 	struct nvme_rdma_queue *queue = req->queue;
 	struct nvme_rdma_ctrl *ctrl = queue->ctrl;
-
-	dev_warn(ctrl->ctrl.device, "I/O %d QID %d timeout\n",
-		 rq->tag, nvme_rdma_queue_idx(queue));
+	u8 opcode = req->req.cmd->common.opcode;
+	u8 fctype = req->req.cmd->fabrics.fctype;
+	int qid = nvme_rdma_queue_idx(queue);
+
+	dev_warn(ctrl->ctrl.device,
+		 "I/O tag %d (%04x) opcode %#x (%s) QID %d timeout\n",
+		 rq->tag, nvme_cid(rq), opcode,
+		 nvme_opcode_str(qid, opcode, fctype), qid);
 
 	if (ctrl->ctrl.state != NVME_CTRL_LIVE) {
 		/*
-- 
2.18.1


