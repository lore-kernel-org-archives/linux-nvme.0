Return-Path: <SRS0=kLfw=OL=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5395C433F5
	for <linux-nvme@archiver.kernel.org>; Tue, 21 Sep 2021 19:05:36 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 92BA0611CE
	for <linux-nvme@archiver.kernel.org>; Tue, 21 Sep 2021 19:05:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 92BA0611CE
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=9RD85XZRnhc9JZ/G3Io6nef3czJerlVxaeQajvVIusY=; b=Cec18n229GDK6m
	59AWFxR4VkcUovg+9gm/ojEhG1JY4XBtFjk7JwPYx/GEM2aVF21gXZFLuz+E9OJUTH6fYyalangAe
	vC+cPtUMSmPP3zSLvyd0EJy/J6Hd4scjfZ4Ithrx1fTiau4UXib+5cz3vpL6/hT4dCZmfXBCBULcG
	eQiwFODAxuyusXUjY+qeP4ufgzdH1omWyX2L8qOCFxhabHGLcsRJmEbs3kg5UNdHMz6URW36yb8ws
	8xEii00ttKnQn6NnR6T6aQS2/R08NUmyyMoW/p30HQyfG70iCm/fitn6NojZs1hQt6uRsh4tQyU5a
	3uIZ7FR13s14PqyaBvLQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mSl4l-005ZL5-8R; Tue, 21 Sep 2021 19:05:07 +0000
Received: from mail-co1nam11on2072.outbound.protection.outlook.com
 ([40.107.220.72] helo=NAM11-CO1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mSl4Z-005ZJ1-TH
 for linux-nvme@lists.infradead.org; Tue, 21 Sep 2021 19:04:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WHWvpiJ7v70dJJOBmVZdy6D31tnllYQjCwi7Fvn/wGQ06SA6IPmPzg/Jf4Bl0dGyidWTjuEBaL58Q/Z3FRkm361x3zA95KWYRbExjkvQl0DciEh0wcp2mtbsowg4SzNPvzwRpCvxqLqlce/HH5TMVevuilrMQw3NNI/YqOIiRVzsMHXMizhEEdIfHz77V9YCaq2czu5dHhmZlvnIExGOw/8/4euZjPOWXKEqkOcgDQX7JvjOfhUF9TMC6J0YiY2jiYwPLLqiHIR6b+g6KVBjlWx+7AYJ0OlfzkW8852dSyC/wp/7oQCd+Bow6gewPbXMr8xJGb+E9lUelWa0Brw0NQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=GEFSOESOnV1dzlbngvCslV/iaQ9QA0cNKn87KDbdl1I=;
 b=OVrwhOw6xO5SDufjHpblt0UCPx0mbIsUaaciNDm0cp20Bnj5CA1EuSTUe4rac7+5f/wYH15rbTgNasgGMUuJZDorBQwyNIRdLLK1Z+3S7cI2SUrdMSlbr8JrjinCOLxddUmRyC0HhK+Da2Kzb0W6bqVmyzOucjXgmkV44drpxJIATen23DnFrM/PW9D1QUc2118uTOeXwWksbpmOIGUL/ilVXkRDBATMVAJ9gu7ttsAdl71JKa3KCATkqjF0NVoQHMGc8MLz5T09gZhzxgkpwgvziAvquNeBlcrSTYYmO28q5tuuYAdSyF18E5KA8hoUdByfx3CyMzdDJ4Tzl9US/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.35) smtp.rcpttodomain=grimberg.me smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=nvidia.com; 
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GEFSOESOnV1dzlbngvCslV/iaQ9QA0cNKn87KDbdl1I=;
 b=VsZvRiIgNLjUe+akNgcIFrKrxmO2E0D+ySlKFTTxrzZfa8DFhlKSTELh7Q4v8m/6RcKpEKlEgCMwhcXAgFQUJyRT1x242HTfgUQmwy50dx9dazjLhNcUr2jXdRlW48y1cEDD0QASS1sQhblOzQa0oi9FFdbr/RSOR388+mOEM1M7nV0Vec0Y/gV8L5gV7dvoTwQmRxtUYm5OmFb5ZtAxo7YzoIzhpAe/Dvj4CN2/7FKPLKPdQs3tlY7+hg1ZCIq5X1AGlV7kVajSVcdz0ixyibFIKWnRI0b6dv4VcVv76ycJB1mV1conijVhiZ6JlhThK/+b3sqcNbO/98Je9HZTgg==
Received: from BN9PR03CA0003.namprd03.prod.outlook.com (2603:10b6:408:fa::8)
 by DM6PR12MB3722.namprd12.prod.outlook.com (2603:10b6:5:1c3::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.16; Tue, 21 Sep
 2021 19:04:52 +0000
Received: from BN8NAM11FT014.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:fa:cafe::c1) by BN9PR03CA0003.outlook.office365.com
 (2603:10b6:408:fa::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14 via Frontend
 Transport; Tue, 21 Sep 2021 19:04:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.35)
 smtp.mailfrom=nvidia.com; grimberg.me; dkim=none (message not signed)
 header.d=none;grimberg.me; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.35 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.35; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.35) by
 BN8NAM11FT014.mail.protection.outlook.com (10.13.177.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4523.14 via Frontend Transport; Tue, 21 Sep 2021 19:04:52 +0000
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Tue, 21 Sep
 2021 19:04:51 +0000
Received: from r-arch-stor02.mtr.labs.mlnx (172.20.187.5) by mail.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server id 15.0.1497.18 via Frontend
 Transport; Tue, 21 Sep 2021 12:04:49 -0700
From: Max Gurtovoy <mgurtovoy@nvidia.com>
To: <linux-nvme@lists.infradead.org>, <hch@lst.de>, <kbusch@kernel.org>,
 <sagi@grimberg.me>, <chaitanyak@nvidia.com>
CC: <israelr@nvidia.com>, <mruijter@primelogic.nl>, <oren@nvidia.com>,
 <nitzanc@nvidia.com>, Max Gurtovoy <mgurtovoy@nvidia.com>
Subject: [PATCH 1/2] nvmet: add get_queue_size op for controllers
Date: Tue, 21 Sep 2021 22:04:44 +0300
Message-ID: <20210921190445.6974-2-mgurtovoy@nvidia.com>
X-Mailer: git-send-email 2.18.1
In-Reply-To: <20210921190445.6974-1-mgurtovoy@nvidia.com>
References: <20210921190445.6974-1-mgurtovoy@nvidia.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c079a4c5-db77-4168-8b8f-08d97d32b132
X-MS-TrafficTypeDiagnostic: DM6PR12MB3722:
X-Microsoft-Antispam-PRVS: <DM6PR12MB3722EA60FCE8EB4015A319D0DEA19@DM6PR12MB3722.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: u6ZaEmVK/IgyK3R2QvDO0bilkUUeUUsf+AnRfGw1Y8fBIeuOF2f7f9AgiQKkWjI3juFatLXbCg3oj/sYThjcIu/8SsTG5fAQSV/pAHiQMgA/dsmoIe5PsnX2O/ZAjVzoTjC6LGB20E6Zo49dUApcqqeCdaiyL/W8TeZga24CYS7wWnzHQppr6AZVbgPyIk/9pILKGD+V0G4PbPBLuXpfEiQ4DikFl5KBsPgTJhvu2ckQkDwzQiSnZ+X0PHLMfELFRyVqjsmy4VQ53QzVAU7gw+rbG+iq1NkCRO1bmWZ4eGYVzeEp8k/kKkZynaCOM9k5iTpdFugfPaXwn3NVTFXTAnWJyRfHMxlEk7H5Ruf7Al/rlx3BHKkDpKEVGZpL47c1JH6Y0gQOf/6Feps7mz97ximJwEArRFyFVfN8dHnc/4wN2zxHibPywNIKUsj8y6pNsMpI5AocTNWaJfpbJIZKWF9yMPevwvVkhi+EiOcgk+kL7XhU0q56ecezMmY9KlhenRMrdkPqJZ5Vt3CzEijWx3D7rIshO/D7uHxC5Rw5d3ECXArUOSTS4gX4hcxdOmgFi/HUq65XL/GYKKUjXGNvi/yYUhkQ0QpC2kSCfdhLxzXL6m7GALe4I4hTTF6xVuDgVXktSjpCp8UloISHSK1GwzCfP+lcm93gr2ZQ+S76CytDdxESWc1YJaY1hrrwyXmvfKM/6a2HJ4xMzBJAI97hHw==
X-Forefront-Antispam-Report: CIP:216.228.112.35; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:schybrid04.nvidia.com; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(70586007)(36860700001)(2616005)(4326008)(1076003)(5660300002)(26005)(6666004)(8676002)(8936002)(70206006)(54906003)(6636002)(83380400001)(47076005)(86362001)(36906005)(2906002)(186003)(508600001)(7636003)(107886003)(110136005)(356005)(426003)(82310400003)(336012)(36756003)(316002);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2021 19:04:52.2570 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c079a4c5-db77-4168-8b8f-08d97d32b132
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.112.35];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT014.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3722
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210921_120456_005958_6722E5F6 
X-CRM114-Status: GOOD (  12.27  )
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

Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
---
 drivers/nvme/target/core.c  | 8 +++++---
 drivers/nvme/target/nvmet.h | 1 +
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index b8425fa34300..cd42655d2980 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -1205,7 +1205,10 @@ static void nvmet_init_cap(struct nvmet_ctrl *ctrl)
 	/* CC.EN timeout in 500msec units: */
 	ctrl->cap |= (15ULL << 24);
 	/* maximum queue entries supported: */
-	ctrl->cap |= NVMET_QUEUE_SIZE - 1;
+	if (ctrl->ops->get_queue_size)
+		ctrl->cap |= ctrl->ops->get_queue_size(ctrl) - 1;
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
index 7143c7fa7464..79a4127f5ec9 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -309,6 +309,7 @@ struct nvmet_fabrics_ops {
 	u16 (*install_queue)(struct nvmet_sq *nvme_sq);
 	void (*discovery_chg)(struct nvmet_port *port);
 	u8 (*get_mdts)(const struct nvmet_ctrl *ctrl);
+	u16 (*get_queue_size)(const struct nvmet_ctrl *ctrl);
 };
 
 #define NVMET_MAX_INLINE_BIOVEC	8
-- 
2.18.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
