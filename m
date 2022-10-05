Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C177C433FE
	for <linux-nvme@archiver.kernel.org>; Wed,  5 Oct 2022 16:11:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=PzU7is90nHkqAaair9hffbX0RYMr1jeAzouRuVIbENE=; b=Jf93N7zhKZ7UHoT6q4mAro7x0R
	TiwZE0Ce0Xs0BO02ej6R/klbJ5aFIeQqiI57EBa7wLJsZX4vMxn1z0ZKnGSkyhNykGF95bzT8gu22
	xok83kd1AnwHqCCtPA3kly/hXF/y37176XxpUPSWLPsQpCGVzQVcaacwMuli8vbIqFJ46gwp9N+oU
	1reQarvoD6lXJgtuSBgs+xDhssLVpcD4Zb8EUGYdL1SJAC0dW8pmwL9qx8F7Lke2l3KEr1hr/Qshc
	m9V05oaT+jz9g1zXTcqPSk0jsY1XLNi3T2yh91H0VWkpe1BxGFernXTClkaWV73YA7ZJMdc4ZNEhF
	stBV42Mg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1og6zQ-00F31p-OD; Wed, 05 Oct 2022 16:11:20 +0000
Received: from mail-dm6nam10on2040.outbound.protection.outlook.com ([40.107.93.40] helo=NAM10-DM6-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ofv45-00CCdc-Lz; Wed, 05 Oct 2022 03:27:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m8H2u1KxEHKI2LjFt9JL+drdS75NF4+WC4MZWgDAo2TmTL3eyufnPg9FWUhHAGyg8lVPEGlFFKkTUoDI8ZgWxkC8wk7pGrchK81s0kyAwuceTOizGQlj4pLznUfLrBvsQva5kx9DkXU4XUucXeNUfehur50tEajyKZyEBOEXuRkrNoSRZC0lRRoxa/e0ipVCgo3J/pM9CpYoKipvqA+9W81YYC7WnRFzbkcA5MjxfkQCf4BUjAPwlcJsrvvGYNUIs9VdVpCfe5ZREn+C/Nx4NcNqkX4codvsDN9R41feKrt0dLipnHTuaSBxvkLTpBvpvN4zFpXgip0WIUf0ohHb0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PzU7is90nHkqAaair9hffbX0RYMr1jeAzouRuVIbENE=;
 b=gAwZls/mDvxRvaxgdlgGl/SEujgeVdLfJX2SNBermn3pSBfNqCQgpHDEvWx4wFpLH6613Yw7POrY5L8bYTkCYddFEk7Ybdovv8jFtmjJJOSyjzn5r/KrMzsi/CJSbX8bEv45tYZF6LNEpfWGfU2LnfVuGjEwYl+iHQ9uR6bHWMBi6SIzNSiyA1JBWJztibAtqr8f6grVxZuxEc00z0WSg4jgoBZHPZJwmL7ACBb/M75xvYzJ4MHfWthmp8Z1JfLM0R3DRtxVviyO5wENJaOjrmq9hEdlz/IzdkvprevxlnxkoUp2DKwe70WtEEvofkMEs5pLR/YPKgeeE3tRqpd46w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PzU7is90nHkqAaair9hffbX0RYMr1jeAzouRuVIbENE=;
 b=Tmr/SE6ey+POHIS4LoeDJZhRIqwYUswyxP1bL82rRkZ/y6URv2wdrWabsEUuu5pMXHztJzRqGBCQG9wUihegYfm15rGN2XZxeTEcAL6bpHFD1GYrNG92g3p8zU6Oj0Hrv4YFXh3D7QS/13UF2caDCAcbHS652fPp2GfnsWu8kPbfikUJDicnnLLWzQz1NaK+HZIme2lzb3m/IMRW1e8H9STXV0026WlWNXtOa1yTDAODQS3PfrsOoHgJwN6WEiav4h8La0hnO0qfCR5tRblaARTstchS6JO9SR+qoC5YRzXcCTh37m+OUEZhYihTCjVkAc7qNAF1J3muNPKhINBkfQ==
Received: from DM6PR02CA0124.namprd02.prod.outlook.com (2603:10b6:5:1b4::26)
 by MN2PR12MB4389.namprd12.prod.outlook.com (2603:10b6:208:262::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.24; Wed, 5 Oct
 2022 03:27:17 +0000
Received: from DM6NAM11FT039.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1b4:cafe::96) by DM6PR02CA0124.outlook.office365.com
 (2603:10b6:5:1b4::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.23 via Frontend
 Transport; Wed, 5 Oct 2022 03:27:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DM6NAM11FT039.mail.protection.outlook.com (10.13.172.83) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5709.10 via Frontend Transport; Wed, 5 Oct 2022 03:27:16 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Tue, 4 Oct 2022
 20:27:14 -0700
Received: from dev.nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Tue, 4 Oct 2022
 20:27:12 -0700
From: Chaitanya Kulkarni <kch@nvidia.com>
To: <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-omap@vger.kernel.org>, <linux-remoteproc@vger.kernel.org>,
	<linux-mmc@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-nvme@lists.infradead.org>,
	<linux-s390@vger.kernel.org>, <linux-scsi@vger.kernel.org>
CC: <axboe@kernel.dk>, <efremov@linux.com>, <josef@toxicpanda.com>,
	<idryomov@gmail.com>, <dongsheng.yang@easystack.cn>, <haris.iqbal@ionos.com>,
	<jinpu.wang@ionos.com>, <mst@redhat.com>, <jasowang@redhat.com>,
	<pbonzini@redhat.com>, <stefanha@redhat.com>, <ohad@wizery.com>,
	<andersson@kernel.org>, <baolin.wang@linux.alibaba.com>,
	<ulf.hansson@linaro.org>, <richard@nod.at>, <miquel.raynal@bootlin.com>,
	<vigneshr@ti.com>, <marcan@marcan.st>, <sven@svenpeter.dev>,
	<alyssa@rosenzweig.io>, <kbusch@kernel.org>, <hch@lst.de>,
	<sagi@grimberg.me>, <sth@linux.ibm.com>, <hoeppner@linux.ibm.com>,
	<hca@linux.ibm.com>, <gor@linux.ibm.com>, <agordeev@linux.ibm.com>,
	<borntraeger@linux.ibm.com>, <svens@linux.ibm.com>, <jejb@linux.ibm.com>,
	<martin.petersen@oracle.com>, <hare@suse.de>, <kch@nvidia.com>,
	<bhelgaas@google.com>, <john.garry@huawei.com>, <mcgrof@kernel.org>,
	<christophe.jaillet@wanadoo.fr>, <vaibhavgupta40@gmail.com>,
	<wsa+renesas@sang-engineering.com>, <damien.lemoal@opensource.wdc.com>,
	<johannes.thumshirn@wdc.com>, <bvanassche@acm.org>, <ming.lei@redhat.com>,
	<shinichiro.kawasaki@wdc.com>, <vincent.fu@samsung.com>,
	<christoph.boehmwalder@linbit.com>, <joel@jms.id.au>,
	<vincent.whitchurch@axis.com>, <nbd@other.debian.org>,
	<ceph-devel@vger.kernel.org>, <virtualization@lists.linux-foundation.org>,
	<asahi@lists.linux.dev>
Subject: [RFC PATCH 18/21] nvme-core: use lib tagset init helper for I/O q
Date: Tue, 4 Oct 2022 20:22:54 -0700
Message-ID: <20221005032257.80681-19-kch@nvidia.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20221005032257.80681-1-kch@nvidia.com>
References: <20221005032257.80681-1-kch@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT039:EE_|MN2PR12MB4389:EE_
X-MS-Office365-Filtering-Correlation-Id: 2538d598-661b-4606-71f4-08daa68180f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 	3wHmtuFdeOlFnBqmD18gkfRN/dllDv09VcQHumRdGr42yeJUnDN8h1ySQq2hhWGm7OrvsWbr7G1D9vWa8Gbe8SQeWQBkI7WAb1JSFBWWkxjTquYyACo/FJz65sztfFSNaXZMYOw0rGrcdX+wliJyATtlraeYq0P0hP/WPW/wP1oiJ1w18iw31O7lvEExadRFrmP40t9dA9F5D46GsNundFL1UXIWR8HyAgE5KPrYCt4L4FnYtCVxTSV0gKmtrSHo4NwUW28wV23x4eF/OPi/E7mDw8/b8I3Quu6MC/yTl36PTUeLZVCNO/r0098QnijojCXz2caBZgTELZHxZCHCk42CFym9mZrRcPdTNyqJwXJIODIETd3mF9XJ5kagsA5g7ZYLfDPyJiSDBuf71Gf9udIRNIAh9S3DRbZpP+cz6Vqp2vVnTFLfffVAR3KTwtlLcLqoynbH1j2fKFpd6YD2k8FZI6yjLFvRmpnE0wq3POGoql03m1WWSgvifIniEsfAZsOsen/ewgVCAvz+IM+/MguPIJF9LAsuPIGDRWbGtKDFBCR3WZQC6EZ4EcjrRU27DILpTGaq0JgWEQg4hI4Fp579iN/oZUNGL8X5mRv03qbZTBU/jsGEZggIl0UlGO03nEK/BOjBe/U/pf/n4Czgsbebg6k7+fvYqrRP7uHCyCT4nGhhA6mlv5hnl1+R7JhKI6gp20ncdXneViYvSpwDEFY6g822c/HHER2vwba1b/cvLSKJ1fhylozi4+8/C7Rp+n2buFD/aDGoHSG0X2tiS5Vs4lhlhGHaiboqWnEulJsK67RnmASRRO9u6e6hgS+r2/B9lf5V3rMjU0jd3zAdRac/78Fw4qzcwWwQuJNcHGc=
X-Forefront-Antispam-Report: 	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(376002)(39860400002)(346002)(136003)(396003)(451199015)(46966006)(36840700001)(40470700004)(7696005)(41300700001)(110136005)(478600001)(8676002)(4326008)(6666004)(70206006)(316002)(36756003)(40460700003)(7406005)(70586007)(54906003)(47076005)(426003)(82740400003)(83380400001)(7636003)(36860700001)(7416002)(7366002)(5660300002)(26005)(8936002)(336012)(82310400005)(356005)(921005)(186003)(2906002)(1076003)(2616005)(16526019)(40480700001)(21314003)(83996005)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2022 03:27:16.9632
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2538d598-661b-4606-71f4-08daa68180f7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: 	DM6NAM11FT039.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4389
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221004_202721_773313_E8938D58 
X-CRM114-Status: UNSURE (   9.03  )
X-CRM114-Notice: Please train this message.
X-Mailman-Approved-At: Wed, 05 Oct 2022 09:06:48 -0700
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

Use the block layer helper to initialize the common fields of tag_set
such as blk_mq_ops, number of h/w queues, queue depth, command size,
numa_node, timeout, BLK_MQ_F_XXX flags, driver data. This initialization
is spread all over the block drivers. This avoids the code repetation of
the inialization code of the tag set in current block drivers and any
future ones.

Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
---
 drivers/nvme/host/core.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 965a4c3e9d44..639767759c41 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -4869,15 +4869,10 @@ int nvme_alloc_io_tag_set(struct nvme_ctrl *ctrl, struct blk_mq_tag_set *set,
 	int ret;
 
 	memset(set, 0, sizeof(*set));
-	set->ops = ops;
-	set->queue_depth = ctrl->sqsize + 1;
+	blk_mq_init_tag_set(set, ops, ctrl->queue_count - 1, ctrl->sqsize + 1,
+			cmd_size, ctrl->numa_node, NVME_IO_TIMEOUT, flags,
+			ctrl);
 	set->reserved_tags = NVMF_RESERVED_TAGS;
-	set->numa_node = ctrl->numa_node;
-	set->flags = flags;
-	set->cmd_size = cmd_size,
-	set->driver_data = ctrl;
-	set->nr_hw_queues = ctrl->queue_count - 1;
-	set->timeout = NVME_IO_TIMEOUT;
 	if (ops->map_queues)
 		set->nr_maps = ctrl->opts->nr_poll_queues ? HCTX_MAX_TYPES : 2;
 	ret = blk_mq_alloc_tag_set(set);
-- 
2.29.0


