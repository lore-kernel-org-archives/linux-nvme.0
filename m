Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 410D7C433FE
	for <linux-nvme@archiver.kernel.org>; Wed,  5 Oct 2022 16:10:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=IVI12i+CsVkSIoxPmC7PFsKXb72W0P7ag9bZcIi/GW4=; b=ddbhB/D6YKEj0OxCM9wlMzpKjt
	ikW+RdQSQROR3NC2fWM58ryAtpzEIow5k3B0XuQv/KzT9MdvkVmfsJLFjRK6phF/HqntUpNNBVklz
	nKaxZZN1CebLYnXu98Tg81OI/oQonCRkSRdaupXLBlM8u+qrDzwKAW+4OjuARCyTxO/nPHMmDbVlQ
	9NI/twrWTJgctSf0Ie85tLS6zVvLVj45gIuwijWh7m7afvpgIk/yKRjpCkk+ckYe45IZ2gkByCDIE
	kS5Dl6MoG18FHknRTmturKsKAsOqyh9EfzLQyleZwTCfirSypjU7cHnNsMYUeZ1OdZCAKMoC5WTcS
	stBA2hPw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1og6yE-00F2jo-VC; Wed, 05 Oct 2022 16:10:07 +0000
Received: from mail-bn7nam10on2069.outbound.protection.outlook.com ([40.107.92.69] helo=NAM10-BN7-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ofv3m-00CCSB-Mw; Wed, 05 Oct 2022 03:27:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mujiqwEL9lUQWEE0N7tveZFnDsAaUuqYJyPS6aSdwjzSnVXTc9TDnnmC/u6gyagWslJ3VaAYE3ykgh3KzowjBFH1SNDRboL2Wb4Yg1HlhPTqF8sI9J/lj6+eixi3h0SzTHVAuZIMLV4cxqL34JicjjgT7MYqpuAw0H2pmJWAlaJmSzDgvUvjv7fKmNZIJT7Hs2RZ/RHEGP5sVZR2WXiAVoBrEhIC5wtPqLOnR1ZoaEPCw6wLgUyX9YALKa2xmsZsy1ggH9OGFr68OgQh8Wr8JxR7ku0y/76N6T0h7bM2OUe5pfQ5AHDpTA6HTFRElrHIQHjOQp9UE/Jb8l3zuriQ3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IVI12i+CsVkSIoxPmC7PFsKXb72W0P7ag9bZcIi/GW4=;
 b=O86MSEjEX/Fplgusk6anLJOiWEYrGTytd0Wf893f1i0/2czBpU04qDogVEjNnxYz17rEb5YiukVT+XyhW58dzkMJye1XWQjN5N6PuesgWyXpHmKsei5Gjh0nSno0Ekr/69BEC+WsczxIu19WxGFBE2BowSRrrRJ/XHX5yElYS5ruKAU42Gin0NuY2xT6CwVmXmpmft1LIsAN+50sJYnfWqwC4qh8fH0GXDKvGiGGLbdYVATo8hI7aVQSmQyMZpcS8nKcMwhPXUUFUgyf8dn4/hDVQPimYX2meOIhvwm3SdKXktBHwaL68iXsdLbZfBMAQ3zLX22/aMNU9yAgKx/R9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IVI12i+CsVkSIoxPmC7PFsKXb72W0P7ag9bZcIi/GW4=;
 b=Cwnu3ifBKC5XbffDpdLYcCV/BRaEpmi3uce6YrTWFj0dVLTWNAN6hBgxcHHM+Cm5CAW6Vmtl1pabpSAAjiXAOrVVrkHGuxtd/jV4ydELmnukzR9m73uk3AEA8xIVrLaDI/uBBj66s48ucGF3edCC2ULkwoQvl4VkUvgj6H2iW4cPj+QApYPhO/Fgi2FWCOfWD51S/HbRqy8jpa3OaTNuiI5KT4wES+neRUO4jj/7e8XPh8nADANlVLsozWBagUKK93qB5z8fy1HCWUy/6R82dGYsD+8L95BukYCU7lgRvw/6aKoFUu0I2ErWwSEGW6Q5uiuvyQF3OcaXWXGRgKaHgA==
Received: from BN0PR04CA0091.namprd04.prod.outlook.com (2603:10b6:408:ec::6)
 by PH7PR12MB5781.namprd12.prod.outlook.com (2603:10b6:510:1d0::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.24; Wed, 5 Oct
 2022 03:26:57 +0000
Received: from BN8NAM11FT059.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ec:cafe::ce) by BN0PR04CA0091.outlook.office365.com
 (2603:10b6:408:ec::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.29 via Frontend
 Transport; Wed, 5 Oct 2022 03:26:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN8NAM11FT059.mail.protection.outlook.com (10.13.177.120) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5709.10 via Frontend Transport; Wed, 5 Oct 2022 03:26:57 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Tue, 4 Oct 2022
 20:26:47 -0700
Received: from dev.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Tue, 4 Oct 2022
 20:26:44 -0700
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
Subject: [RFC PATCH 16/21] mmc: core: use lib tagset init helper
Date: Tue, 4 Oct 2022 20:22:52 -0700
Message-ID: <20221005032257.80681-17-kch@nvidia.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20221005032257.80681-1-kch@nvidia.com>
References: <20221005032257.80681-1-kch@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT059:EE_|PH7PR12MB5781:EE_
X-MS-Office365-Filtering-Correlation-Id: 924c6177-d801-48b0-c783-08daa681755f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 	gLrFJeTHeNGvZUVco4hAOcMYz5kr9dpxm1fnHiDJcQUOZ+0zN//0IQnzGyPi2zDJSI/y2Rh3pEBUK/cDs9DVfRIUgtnRwFWTmrQPhDWKj8oO8Ea4J/gjgRlYBeG+KY3yPzpD2i4ecsORjdzLoXFvMd/xoUmFeDqyXv5n4l3DfWNvQi9H6RGMDva7zfZgxBgBJ415aCKlOPm21hqs/ZAnLSqf+9gV4GYZ3tS0SWfvLj2sDh7ChsN5hJfJXngUPs1/NzmMfJaFXrivVIfHfn+VW7l5T7U5a+6fPk5JiVf3JNm4xjkoP6h1una9ZGzZL8lYrAQJ5glsoifYvih8CDqxxYjBfuUzUg9jAi7odfeIwoWE0BDgV7urQsXH4brrqvXrO8Qe8PoFbxk2tgh8Pl/9dKkkKSRUifKO8peKHxmMd0/y/Joix3sgnD42rvcFeOHDhhZCytcg2nz37SrlZoFBBO1n//4KsqCdDKblstqmChZrN1LTmleLTufgDPda1lU04GjqvpaLo4OeQ2R7lpPcGvd8WYv0ILRgS6cDIhnM6U6T6vNOQCx0gGSewRcI5Icw/s2i8k5PzVKKGI/Qers3xb7ssMIMnnrJnyIvoEe0P4NmRGy7XsP3m+UOT6QB42LINzD02zPSYOHUAUieb2iM6cW2UxTxu3MpsPNiY6md8eqSnxucd+DqRzpSfYVurPHP7urisF1bjhk4S1NcjZTCLijHnq7M6/3A720eReLZ/dtO9d3x5PSsqQgH0eqeREEIz5NEnSlMVH8B7vaIPuRwcenF4vd+MDotjoyNkIi/WtNV18FKWebKJA1qADP6xNbSTE0woEIlpivldxoQnh1zWN1KHANITUwT9CaJGZz08XU=
X-Forefront-Antispam-Report: 	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(136003)(346002)(376002)(396003)(39860400002)(451199015)(36840700001)(46966006)(40470700004)(1076003)(6666004)(7696005)(70586007)(70206006)(82740400003)(478600001)(40460700003)(54906003)(82310400005)(36860700001)(40480700001)(7636003)(4326008)(36756003)(356005)(2616005)(26005)(921005)(83380400001)(2906002)(47076005)(8676002)(186003)(16526019)(7416002)(110136005)(336012)(316002)(426003)(7366002)(5660300002)(7406005)(8936002)(41300700001)(21314003)(83996005)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2022 03:26:57.4674
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 924c6177-d801-48b0-c783-08daa681755f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: 	BN8NAM11FT059.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5781
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221004_202702_805020_D6BD8918 
X-CRM114-Status: UNSURE (   9.90  )
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
 drivers/mmc/core/queue.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/mmc/core/queue.c b/drivers/mmc/core/queue.c
index fefaa901b50f..599a34a5680a 100644
--- a/drivers/mmc/core/queue.c
+++ b/drivers/mmc/core/queue.c
@@ -417,7 +417,6 @@ struct gendisk *mmc_init_queue(struct mmc_queue *mq, struct mmc_card *card)
 	spin_lock_init(&mq->lock);
 
 	memset(&mq->tag_set, 0, sizeof(mq->tag_set));
-	mq->tag_set.ops = &mmc_mq_ops;
 	/*
 	 * The queue depth for CQE must match the hardware because the request
 	 * tag is used to index the hardware queue.
@@ -427,11 +426,9 @@ struct gendisk *mmc_init_queue(struct mmc_queue *mq, struct mmc_card *card)
 			min_t(int, card->ext_csd.cmdq_depth, host->cqe_qdepth);
 	else
 		mq->tag_set.queue_depth = MMC_QUEUE_DEPTH;
-	mq->tag_set.numa_node = NUMA_NO_NODE;
-	mq->tag_set.flags = BLK_MQ_F_SHOULD_MERGE | BLK_MQ_F_BLOCKING;
-	mq->tag_set.nr_hw_queues = 1;
-	mq->tag_set.cmd_size = sizeof(struct mmc_queue_req);
-	mq->tag_set.driver_data = mq;
+	blk_mq_init_tag_set(&mq->tag_set, &mmc_mq_ops, 1, 0,
+			sizeof(struct mmc_queue_req), NUMA_NO_NODE, 0,
+			BLK_MQ_F_SHOULD_MERGE | BLK_MQ_F_BLOCKING, mq);
 
 	/*
 	 * Since blk_mq_alloc_tag_set() calls .init_request() of mmc_mq_ops,
-- 
2.29.0


