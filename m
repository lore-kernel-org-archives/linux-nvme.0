Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 094B0C433F5
	for <linux-nvme@archiver.kernel.org>; Fri, 28 Jan 2022 09:32:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fNp26jSlQp709R63vuVsAMhSsT/ekPu4w1Kspj217dE=; b=QPzIODYuUTCyBfTXHei3DK9PoL
	oC69UVqMqThPgoAp0EWupSruzlHvGqeVd86qYb35kMiFr23Vmid/UOoQ03AfCRc8svLuwtxmL85MY
	PRq3fNYcByC/RxVtCYRjSnTwDwCKDJ+Z7O2EkV8pSLwxA8YR4JBgAYUlRoga7t8Zeokve9oXuFHgW
	kXLVCkl1Z7mIKR0C/kg2yu2pn4qOtI5QjqvQPW0iAHOrhASrvCRL/JKl0YckHKcRGwSjlKQ3uZbXX
	BRfb+JFVoS3DNEgJ9oYRnG09w3NHMH3miTk5ItbONnPGolsF5c+jy6jB9CteAjnskBCeenv7xXOMm
	I4ldP2jw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nDNcJ-001GC7-6W; Fri, 28 Jan 2022 09:32:27 +0000
Received: from mail-dm6nam11on2083.outbound.protection.outlook.com
 ([40.107.223.83] helo=NAM11-DM6-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nDNSr-001DYF-Nu
 for linux-nvme@lists.infradead.org; Fri, 28 Jan 2022 09:22:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AGGM0iu8y8ZdZIOT1NbUZUrmQPp0L7bxRxXwOrUHHtRvqBU1OC60qzHprzuikfLGJW1lQHBm0xotYJveZORCRHB5MeXTqU+mEOlAr24k+r6bGTxFZ1AQpbbhyJR4rNOyjPUUvUE2nzFIjlhhFLOXW0H+cCTwLn8taPfl37lW/ZbIW9tiCqS7febK1VDQR81Kl2JC8/oFYCODutLfSUi+qTE0JpHjpqf5mp90pf2vAjrmw68rkA+E3x9gu+5MPd8Kwm42jpx87vZb+le+5qxsGBLtKq05118qdc8jV8OvJe8d+VegR85hq1LVf7GCh8B0KlBsFNODAriodbRDAsDZyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fNp26jSlQp709R63vuVsAMhSsT/ekPu4w1Kspj217dE=;
 b=kV+hLBYcf3vp9nB82UM6DrniUFBvBjYwiPqHF97rO4h8dbxKIQ5vnUgZByho5AUZl135UNSJZiKsUgMmUbyVPlYz/S7UBMUds1F72Pe+JRzpbZxa1Ds6Q2IhQV+GMlUzbRfpIwSfPr3uZ4y3QEDTG43LXcmE0pwXUmBjFtQaofoOSXna8iNKjVgLGZaLXUqHUcW0KfiTvZ5nRKLSxFlpBDBoIkLaMtwBzD5wIssD6G8Zz6R/y2I90mO92AGieW5aHbQ888D+6R7iUnNT1od/0IvpdzK+Gubnc80DnIfoEdrBoCP11lvqbqbpKeGnBQ4d3G9NHeFfAH4/rLX6e2hyIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.235) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fNp26jSlQp709R63vuVsAMhSsT/ekPu4w1Kspj217dE=;
 b=Y7rX8HL1uNUdmw0UY37brUAsFMY22eZgPVwdKPQt1VFLRfX2nhSGoY2IutwWzhbYoaaGbQOaa7s+KTtnS1om5Q+DTGwrug5DiADiG+jUhKFcx3GZb2PlJG2/yhY8Ei2W/xQ4z/408OayysF6Mw5ZGuVJMYBXuqyM5rsMojiU65WLneRieGHg7zRU6GeInxzCxPqMlOy+aDdrtFaNlwkB2DlZHKo9kX29Bx/75Yv6y+Er8uO121mEusA/qEAqY1oqqtLqlYAdhw9wYCzXNCZqMF3oDIsOdlGvJ1v3/kfQnST6ElwjdaAQ9M8YxfFuFrXZEyRLfx37U7APhZnsBYYsZg==
Received: from BN9PR03CA0281.namprd03.prod.outlook.com (2603:10b6:408:f5::16)
 by BY5PR12MB3985.namprd12.prod.outlook.com (2603:10b6:a03:196::32)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.15; Fri, 28 Jan
 2022 09:22:39 +0000
Received: from BN8NAM11FT009.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f5:cafe::cf) by BN9PR03CA0281.outlook.office365.com
 (2603:10b6:408:f5::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.15 via Frontend
 Transport; Fri, 28 Jan 2022 09:22:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.235)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.235 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.235; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.235) by
 BN8NAM11FT009.mail.protection.outlook.com (10.13.176.65) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4930.15 via Frontend Transport; Fri, 28 Jan 2022 09:22:38 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1497.18;
 Fri, 28 Jan 2022 09:22:37 +0000
Received: from dev.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.9; Fri, 28 Jan 2022
 01:22:36 -0800
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: <linux-nvme@lists.infradead.org>
CC: <hch@lst.de>, <kbusch@kernel.org>, <sagi@grimberg.me>, Chaitanya Kulkarni
 <kch@nvidia.com>
Subject: [PATCH 9/9] nvme-loop: use helper for tagset initialization
Date: Fri, 28 Jan 2022 01:20:15 -0800
Message-ID: <20220128092015.19289-10-chaitanyak@nvidia.com>
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
X-MS-Office365-Filtering-Correlation-Id: d08c837d-3b0d-40dc-2345-08d9e23fba16
X-MS-TrafficTypeDiagnostic: BY5PR12MB3985:EE_
X-Microsoft-Antispam-PRVS: <BY5PR12MB3985011945732D386A016199A3229@BY5PR12MB3985.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1388;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0wgjmAGa5JIG45XXdv/w9h+w0hPZPthyxxILcj7fNShpaO8Mr9bWfLO7oqmL2cE+QZpumJpxqXefUDWESQRnxaBzlmVYgrN8H5plh2OIMtMyXElDQuGLUSYW1lvOJoxfRAo2PVCyPEeNUCgDGq0X7hbARswr5FPG2KuhTnvf8gtJbc4R1JcI5YYiSQrKeWKs45mjIBgP/FFXfinOg21m7PC2AHGptTx2YdwqlJpN1DyTa9CfIMeOWReQNLFLZiUFvmF5nptREcOV8XQw12nAm8hbkC4bayUTGoppbkjmsd+f/0k12fZCTMA6xsdwDxgp/JICd2qqV1Jvtn0gut6AujOtElwPv857nfbOuM9H+EXTrVC7NO9R6Yn5elsVTqp/HDC/YjYBpeMyWFYfj1X9CWYxk65fGsqo3i34eYUe3PW6lWi2dTDaRkC+FMwit1YrHrCh8BWV9mb4dT9WhJdoi3exlZfT7XuVhHjfEiXBryM1+kzUBSewDQ1Q4a8lypXrw2/X5dbjxupAG5636SZfpHNoZi9F096BjMaDnQjhli6Gwu1DxfcpulYXs2GjZ21FP9gntkrpdBILoDhH3tBZFRT2qFAXrV9mPykekGxVFVGk16rbjfMNUEoLcqZ7CvT2gOFpNU9koYIf0TcJggAXn1W5DLbS500JNa20cgjj4iO2BBvWeoaeCwE0lewQeOuFk9sY/lL9+3VOfv7PTJvz+w==
X-Forefront-Antispam-Report: CIP:12.22.5.235; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:mail.nvidia.com; PTR:InfoNoRecords; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(36860700001)(82310400004)(107886003)(70206006)(8936002)(8676002)(70586007)(4326008)(36756003)(5660300002)(26005)(2906002)(83380400001)(40460700003)(86362001)(336012)(6666004)(1076003)(426003)(7696005)(2616005)(186003)(47076005)(508600001)(54906003)(356005)(6916009)(316002)(81166007)(16526019)(36900700001)(20210929001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2022 09:22:38.0747 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d08c837d-3b0d-40dc-2345-08d9e23fba16
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[12.22.5.235];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT009.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3985
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220128_012241_836468_141BCB1C 
X-CRM114-Status: UNSURE (   9.12  )
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
 drivers/nvme/target/loop.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/drivers/nvme/target/loop.c b/drivers/nvme/target/loop.c
index 23f9d6f88804..fdee038041f8 100644
--- a/drivers/nvme/target/loop.c
+++ b/drivers/nvme/target/loop.c
@@ -350,17 +350,12 @@ static int nvme_loop_configure_admin_queue(struct nvme_loop_ctrl *ctrl)
 {
 	int error;
 
-	memset(&ctrl->admin_tag_set, 0, sizeof(ctrl->admin_tag_set));
-	ctrl->admin_tag_set.ops = &nvme_loop_admin_mq_ops;
-	ctrl->admin_tag_set.queue_depth = NVME_AQ_MQ_TAG_DEPTH;
-	ctrl->admin_tag_set.reserved_tags = NVMF_RESERVED_TAGS;
-	ctrl->admin_tag_set.numa_node = ctrl->ctrl.numa_node;
+	nvme_init_admin_tagset(&(ctrl->admin_tag_set), ctrl,
+			       ctrl->ctrl.numa_node,
+			       &nvme_loop_admin_mq_ops, BLK_MQ_F_NO_SCHED,
+			       NVMF_RESERVED_TAGS);
 	ctrl->admin_tag_set.cmd_size = sizeof(struct nvme_loop_iod) +
 		NVME_INLINE_SG_CNT * sizeof(struct scatterlist);
-	ctrl->admin_tag_set.driver_data = ctrl;
-	ctrl->admin_tag_set.nr_hw_queues = 1;
-	ctrl->admin_tag_set.timeout = NVME_ADMIN_TIMEOUT;
-	ctrl->admin_tag_set.flags = BLK_MQ_F_NO_SCHED;
 
 	ctrl->queues[0].ctrl = ctrl;
 	error = nvmet_sq_init(&ctrl->queues[0].nvme_sq);
-- 
2.29.0


