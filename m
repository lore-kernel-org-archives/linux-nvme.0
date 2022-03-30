Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 033C0C433F5
	for <linux-nvme@archiver.kernel.org>; Wed, 30 Mar 2022 09:40:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=N7TqRPuSyRG3G9s3jv++EsHM9xCJ4X9T9GcFHQBUAkc=; b=0xCu7R8ysqLlbEWVfxtBVdIhb6
	72wpAxBmcScPQnt3rO+J3APaMZHF3Sj5seERDu7PNN45aW9zV6fBamPu7qbCtwb5/m+YyeGpJAlOu
	jhi7O5DI8H44g0pkrh7oXX/6p7kr4d7m84jqDSEu/G7lmVFf0LPAYxsjCSxmJTKPIE4WV2Fzd+umb
	ZAFnRJSjs6L37HRnDvtVJaTYU9iCHYfx2erqiKlUa1nt0WZw3mulMp95j+qYXipSQFq1CKkm/YdX1
	Zm4sQkmTT7jbbYPK7Ozt/843iPOnMJAhoQCl6FB6rtPJHgK1BXGZuKm5xphSc6di4hZJLxArtMxPI
	zpmUcTfQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nZUov-00F0dE-HX; Wed, 30 Mar 2022 09:40:53 +0000
Received: from mail-dm6nam10on20621.outbound.protection.outlook.com
 ([2a01:111:f400:7e88::621]
 helo=NAM10-DM6-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nZUos-00F0cu-EG
 for linux-nvme@lists.infradead.org; Wed, 30 Mar 2022 09:40:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fExPHRnysl1uPZEqXF264zIDy0toDzg6/b97i+Tkgk6fJAnA8kUySC/2lcn3u61mHfxSgKfdSVPwkQc0BN5Mpi4vrpZy347sp7iHHkRYyGkDV+38YUVY4isHRJOUYhZFwgnlzR2GvH0YC5h2KAc3+lx3V3dyYpcKmii0g4Hug76xYGO5yPYYBxneMRemCrQ2YvR35zjRITIWDMgyRTB1x1k7WAMwUXWVOdEvfjEfzgIw4qRkV+SETqyHkq1KJX65hZCBj4PjEy9Pytf7M2Fl/+YwCKpPWyNge5RUHahgSxw7DBk4oZWWYS3Rr6N7sPKF1lMEbzIruDV0beV4ADV0gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N7TqRPuSyRG3G9s3jv++EsHM9xCJ4X9T9GcFHQBUAkc=;
 b=PSEX7YQXFEPn6R42nPFOKH0fpnjMhHKVQ+61uYWAbbofwc3XaPRHHwkI6ZZTtgbIWG8XZKwt4qsjLCwpo/aZRC3k1iKBrQFOtHHF6dRkf1iERAKPEG3Yqsjj9DYa/YxSI7owkjupuFjn6R4q4yPPCTSPUVqcm3qzRAopJg9NkGUMNCqHNXJ3Orw/QDP2C42wLI7bARLT7/Fdnb4ydv98LQed7jfOaqgB0cV8zQjfcHgnyweFgeuPoTGQjD+b14gjP+fav739Xw8WZQdWomFbIlSnJuZcVSq0OI/8q0JjiVoA8+JAEGjk4ZXXuO4OiRX7TN5pXxSZikYDKeRPhIaufw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.234) smtp.rcpttodomain=grimberg.me smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N7TqRPuSyRG3G9s3jv++EsHM9xCJ4X9T9GcFHQBUAkc=;
 b=XwTZ2Or9Cfl6d6Xcj9zALAdWAn73KpJYn5wUgmKeLOcHKti5Q1Rvp0HUeI4nrUPfZzlzvj2p/fAf9gCG0sLgPqz2Xglri7h9o8u0/9GcYZAlIemZVnPOFsk/BRILlOvYYYsbH04AyQrjY48KurY79tSFv6rcWs3mQL6fpaAS14eKVjMQa/HYsPxohz1nfg9LGJWpdu0BAoKMGnTtAnJ0X45zvP1nfbscYWvaunuDY1hwu9qz0tGTXA/YClAHOBkmKui67msgvS0J1sfwZL6nRsQMsWQS/HfTAQRUHKv51emamYjtUcaMjBOTXfFAw2bK7Us9/8G/I6j4MbOwYsWpQg==
Received: from DM5PR13CA0055.namprd13.prod.outlook.com (2603:10b6:3:117::17)
 by MWHPR12MB1424.namprd12.prod.outlook.com (2603:10b6:300:13::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.19; Wed, 30 Mar
 2022 09:40:46 +0000
Received: from DM6NAM11FT022.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:117:cafe::cb) by DM5PR13CA0055.outlook.office365.com
 (2603:10b6:3:117::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.13 via Frontend
 Transport; Wed, 30 Mar 2022 09:40:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.234)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.234 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.234; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.234) by
 DM6NAM11FT022.mail.protection.outlook.com (10.13.172.210) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5123.19 via Frontend Transport; Wed, 30 Mar 2022 09:40:46 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by DRHQMAIL101.nvidia.com
 (10.27.9.10) with Microsoft SMTP Server (TLS) id 15.0.1497.32;
 Wed, 30 Mar 2022 09:40:45 +0000
Received: from dev.nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Wed, 30 Mar
 2022 02:40:44 -0700
From: Chaitanya Kulkarni <kch@nvidia.com>
To: <linux-nvme@lists.infradead.org>
CC: <hch@lst.de>, <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>
Subject: [PATCH] nvmf: dno't duplicate the time out req completion
Date: Wed, 30 Mar 2022 02:40:32 -0700
Message-ID: <20220330094032.23032-1-kch@nvidia.com>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c715ac25-9ccf-4e7d-9408-08da12315dec
X-MS-TrafficTypeDiagnostic: MWHPR12MB1424:EE_
X-Microsoft-Antispam-PRVS: <MWHPR12MB14242B3A581F145CCC900DD2A31F9@MWHPR12MB1424.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Y5CCKSvVKdNhfFe+zbxzOzTi+Uw3qJuQm9QmSHRBLd5OOryk1+rct4K8PoOMPN93HPtMaj+7YCsOnW297RyQInv5U1yB9FIco7NIZLo1EEjwbdf3gFupeLs23wginc65Lz0qLNbLSJ2bDrNt7S6XKnyyfDwLL9oL4FUi9UZDWgHX4osfgOU4t5b227L11ubx+0KfDeFeIxQJ9wjszdkq0vZg0sJL7PNClpwIMk/qcu3nrUX9FpQaRbyd0VvOrDi8rWFj3qRU654+Bilz9lhpmgYEcejrMGypvKDfUp00rPS+VPAOADt/xSOlucHnYh0idQznVbPpGdO5QCSm7Bf9Hm2CDxWl+w50mbxpxVp5Gwaoi87VuDkakEttinEmXP9ypdLOu3v5hfHtTUE8iQ1AW8G5k21aYkqqhdYwaFWQSHZExH38BFj4ZZpvqhFsS1Rg3aggshKbN1d1Dk3EIcZ7IZAyABe0c+Wk7Uu8OPpNbYIIw3CeuWDtSKV846DKlVb4G8/loT61YKs870dcu9ZUex2pmSqOP1Mys1mR79XGzRkE9jDkrUHTo4wKF/1Yf/yPln1Z+nYBRF6B17Ma25Li6x4v4kUPMOXkhDhtLuBAS6dFxcpXavxpuRRAaF+TIKagLbx39FvZX6QjYfVloGPWtfNuo3TqpAVtKUQALGySDpmGXXsDUU2e7flwWoHgEaJ8TfSsMcZyX5GsdLMuDY06Gw==
X-Forefront-Antispam-Report: CIP:12.22.5.234; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:mail.nvidia.com; PTR:InfoNoRecords; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(16526019)(1076003)(83380400001)(70206006)(26005)(336012)(426003)(107886003)(8676002)(8936002)(47076005)(5660300002)(7696005)(70586007)(2616005)(36756003)(186003)(6666004)(508600001)(4326008)(356005)(54906003)(82310400004)(36860700001)(40460700003)(81166007)(2906002)(316002)(6916009)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2022 09:40:46.3579 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c715ac25-9ccf-4e7d-9408-08da12315dec
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[12.22.5.234];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT022.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1424
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220330_024050_530527_B32D19F1 
X-CRM114-Status: GOOD (  11.05  )
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

The RDAMA and TCP transport both complete the timed out request in the
same manner and hence code is duplicated. Add and use the helper
nvmf_complete_timed_out_request() to remove the duplicate code.

Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
---
Hi Christoph/Sagi,

Perhaps newly added nvmf_complete_timed_out_request() should be moved
to host/fabrics.c and to be exported with EXPORT_SYMBOL_GPL() ?

-ck
---
 drivers/nvme/host/fabrics.h | 8 ++++++++
 drivers/nvme/host/rdma.c    | 5 +----
 drivers/nvme/host/tcp.c     | 5 +----
 3 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/nvme/host/fabrics.h b/drivers/nvme/host/fabrics.h
index c3203ff1c654..734dee9b20fc 100644
--- a/drivers/nvme/host/fabrics.h
+++ b/drivers/nvme/host/fabrics.h
@@ -186,6 +186,14 @@ static inline char *nvmf_ctrl_subsysnqn(struct nvme_ctrl *ctrl)
 	return ctrl->subsys->subnqn;
 }
 
+static inline void nvmf_complete_timed_out_request(struct request *rq)
+{
+	if (blk_mq_request_started(rq) && !blk_mq_request_completed(rq)) {
+		nvme_req(rq)->status = NVME_SC_HOST_ABORTED_CMD;
+		blk_mq_complete_request(rq);
+	}
+}
+
 int nvmf_reg_read32(struct nvme_ctrl *ctrl, u32 off, u32 *val);
 int nvmf_reg_read64(struct nvme_ctrl *ctrl, u32 off, u64 *val);
 int nvmf_reg_write32(struct nvme_ctrl *ctrl, u32 off, u32 val);
diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index c49b9c3c46f2..3cb5ef6bd802 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -2009,10 +2009,7 @@ static void nvme_rdma_complete_timed_out(struct request *rq)
 	struct nvme_rdma_queue *queue = req->queue;
 
 	nvme_rdma_stop_queue(queue);
-	if (blk_mq_request_started(rq) && !blk_mq_request_completed(rq)) {
-		nvme_req(rq)->status = NVME_SC_HOST_ABORTED_CMD;
-		blk_mq_complete_request(rq);
-	}
+	nvmf_complete_timed_out_request(rq);
 }
 
 static enum blk_eh_timer_return
diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 10fc45d95b86..cf3804ce5d79 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -2275,10 +2275,7 @@ static void nvme_tcp_complete_timed_out(struct request *rq)
 	struct nvme_ctrl *ctrl = &req->queue->ctrl->ctrl;
 
 	nvme_tcp_stop_queue(ctrl, nvme_tcp_queue_id(req->queue));
-	if (blk_mq_request_started(rq) && !blk_mq_request_completed(rq)) {
-		nvme_req(rq)->status = NVME_SC_HOST_ABORTED_CMD;
-		blk_mq_complete_request(rq);
-	}
+	nvmf_complete_timed_out_request(rq);
 }
 
 static enum blk_eh_timer_return
-- 
2.29.0


