Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAE4AC433FE
	for <linux-nvme@archiver.kernel.org>; Wed,  5 Oct 2022 16:07:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=07P3J3AZWbX1SNZwgGbcXr4rBnSoEcLpJ/DhCt+E8FY=; b=rZRUs5tJM2oAmt4ThUxLxbCH0r
	nNE2O/UT6MC48ux90RzpwrNU+j9Pz31HETbHwtWOkLO4IlnqZvfv1sUTREzQsYQ9vSynmK3ES6onV
	SfZCJPJcsa5X05Nx94W2xL5QfoPef3bHET+CvU01ee0n5lmZUgMoJgHmY/3WYTHSGo3dzEr7Q7Fll
	ikczDWz569CSUeOSEl8o/zU2OtOY/r8XNgQdKcwoLvlUCFqbVI+d8G7WShlgKMfkGxFL8FQoJDZN4
	t8OgeGnPl5rmuMUJFio8e4U5CPhotSOjEZtED2HH/7aU1XMP3S0p+lzhe6aJDlZmRphLqwKDa3ywC
	X5Y+GEdA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1og6w7-00F29C-Qv; Wed, 05 Oct 2022 16:07:55 +0000
Received: from mail-dm6nam12on2043.outbound.protection.outlook.com ([40.107.243.43] helo=NAM12-DM6-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ofv2D-00CBVQ-BP; Wed, 05 Oct 2022 03:25:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d0EFrnMvjmeHElekGRfFUfAPqjKw03WXi9kznPolvF30FOwvCPYSerAoG1cFO62J9rEH9x0irB5gmlWufF2OsYUom+i73q7BUT33yVPEkoBerUrFcxdVeqcD3GcfHnXNIlTmXrp7UjOVS62wkpwGUzsjKY9nyK9K+hck3rk1UCOn8UWda5l1DTToEwqSk75ILTBnDEj5gwwnSJcUQl7tWuaTfVoDI8VJ7d/kC0CBMdpIoCwvyifx+z8xU2tnwOYUU5kmU4PDiClmhWQDCZNdmMa0Ugb6uNEv2XNCqjY86dFLeO4+M4It2kVGULDuLoS+NGdch4yO+13R7EG4TSC+Kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=07P3J3AZWbX1SNZwgGbcXr4rBnSoEcLpJ/DhCt+E8FY=;
 b=HQQ3Pu+sTAmLAOS5kogJLwsmHITkPn9pPHd/3LL2c/VW+wnidYb2CWw0LvMOHKfNq6Nr59FYjxOIsYpElk6ROLCYi/LlPwgol8LvWNiggv+5J4Hrmq8nh/tTQfCu6QOdVF0o3O9G74TK3HSIrBR3e8+CKIiAy20DFMVxgpDwA6oU4U1cThP20yzBV7tMPDcGJTehbT1iI/lPeH8ayq45J/GokWcOmZ8dO8bUtRnrNFFjKk7oTaQuWAyYBS07CM2IifK4waZfa5SvfnsU5ainYTcxHb/g8eRbHPu7qk7Uk/wIqqlyHzWzCQ626BwotgXtePQE9uJpAN/HZbUuM4H9rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=07P3J3AZWbX1SNZwgGbcXr4rBnSoEcLpJ/DhCt+E8FY=;
 b=ff9/qLkZ6ZiB4AAWkBEMh93fFLshKb6QhYS/O3oPi1kCq2EH2vGBl+M+fIqTeTe4J8ipNHr2zqFHGV/ScmkZOLwp2affME5UkfR207oovlOyoMntu9v0qVDlbhl7XHzXPLxmlVQkXG8V7eWX0WVv3lb3yoWAidi0g9XEFBs4l5EEM+wRNaG5QHIw6sXRd7kbyyADIcW5V4auEKLynTGPg+TxZ9hR19eyYvoajmv/42/v02WRpjeAlOFTTugKAEP0WjilXiCOQBeKAW156b/nnPO7du09822cCbm1IaMzL4MYrtVBkJFGkiN3O3QcAJKcJvH1Jx5qFEgvswL5wcUalQ==
Received: from DM5PR07CA0095.namprd07.prod.outlook.com (2603:10b6:4:ae::24) by
 BL1PR12MB5364.namprd12.prod.outlook.com (2603:10b6:208:314::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.24; Wed, 5 Oct
 2022 03:25:21 +0000
Received: from DM6NAM11FT107.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:ae:cafe::ca) by DM5PR07CA0095.outlook.office365.com
 (2603:10b6:4:ae::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.18 via Frontend
 Transport; Wed, 5 Oct 2022 03:25:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DM6NAM11FT107.mail.protection.outlook.com (10.13.172.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5709.10 via Frontend Transport; Wed, 5 Oct 2022 03:25:21 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Tue, 4 Oct 2022
 20:25:13 -0700
Received: from dev.nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Tue, 4 Oct 2022
 20:25:10 -0700
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
Subject: [RFC PATCH 09/21] block: use lib tagset init helper
Date: Tue, 4 Oct 2022 20:22:45 -0700
Message-ID: <20221005032257.80681-10-kch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DM6NAM11FT107:EE_|BL1PR12MB5364:EE_
X-MS-Office365-Filtering-Correlation-Id: d8da00c9-ac73-40dd-3068-08daa6813c1b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 	FmfXgqIfG85vTqQrmAn2WzVvy8HFgobYx2GHXKBE5jt7XZuYALCV1d7rS6iKDNa59r5nd06Mlsiz08R786oPlVXzt+wlTaRAulVu8jqNXZ/97YrRCL2xI0wmXPVY63XZm9Fz+OhJYiUEZ11Zl/UR+LcOhNjZJPMixIpEZYDCykihldmtPHRCMjpAG5Fokr0K0nWsr8rouV5S1ZOqWBTZYCM28YL0LO5T1fAspFhXqg0RI8Poip4XujmFSi6ghSSBsIj/zUoz0u9ZmQd9s6OrynIQoT5ICD/LbHo8fFT1Kzwdqsoz9Z1kurYGPclySrAn1AtpTzWhC69qEeSeQSoqFmcENi8iCEKD7ncnuunD8uqfFSlFC7A5aWhjK7MRsX4jVqxfCgTIjykpqhHfSh+thZYjTKBFiC8EhGi/J0qfhRSab6vhmKlzw0cu+m/AlmtBz4GHESVCyv9tD+z6cWgiAyQUFL0K0+kWsl9EbhJuOqo6ZNx3Njbku/zSl55lt46ob7wiGOR6ejfY56r7PCUUAv4W9Fr6wQK1gq0ra4foGyxFmwClljZJD6S2BpveHeD7LVPJls+hye9NWKr2zX5RVyQZzafKVrO679kJ80g+fTuWKUdCu+cxgaCki8j9hpL8nIA9AGvIWEaEbmUP6kJK0b2bsES6Rx7Ky/06UlA6ljcZJIE8CpNPudlazqjVpr5BUdpQSwR8cVLQS9MM2+TauF+z21auxfORHpai/2+gLt+r9RWXZU5GPksyZY75jiGmADUtsV3l4i65oDkMyfqrd38C3YlaqQevnMyJ+UoCUzHqC4oxcJHONU0wO0DwyLktd7wNaWVT0d++7+djVeO8utMWsCx0SWnwm8zTRA2E2c8=
X-Forefront-Antispam-Report: 	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(346002)(376002)(39860400002)(136003)(396003)(451199015)(46966006)(40470700004)(36840700001)(7696005)(41300700001)(36756003)(6666004)(82740400003)(5660300002)(7366002)(7406005)(7416002)(8936002)(26005)(8676002)(316002)(70206006)(70586007)(4326008)(336012)(40480700001)(83380400001)(47076005)(426003)(82310400005)(16526019)(186003)(1076003)(921005)(356005)(7636003)(40460700003)(2906002)(2616005)(36860700001)(478600001)(110136005)(54906003)(21314003)(2101003)(83996005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2022 03:25:21.4347
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d8da00c9-ac73-40dd-3068-08daa6813c1b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: 	DM6NAM11FT107.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5364
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221004_202525_421526_554C5E39 
X-CRM114-Status: UNSURE (   9.12  )
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
 block/blk-mq.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index e3a8dd81bbe2..d4cb5c44a53d 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -4455,12 +4455,9 @@ int blk_mq_alloc_sq_tag_set(struct blk_mq_tag_set *set,
 		unsigned int set_flags)
 {
 	memset(set, 0, sizeof(*set));
-	set->ops = ops;
-	set->nr_hw_queues = 1;
+	blk_mq_init_tag_set(set, ops, 1, queue_depth, 0, NUMA_NO_NODE, 0,
+			set_flags, NULL);
 	set->nr_maps = 1;
-	set->queue_depth = queue_depth;
-	set->numa_node = NUMA_NO_NODE;
-	set->flags = set_flags;
 	return blk_mq_alloc_tag_set(set);
 }
 EXPORT_SYMBOL_GPL(blk_mq_alloc_sq_tag_set);
-- 
2.29.0


