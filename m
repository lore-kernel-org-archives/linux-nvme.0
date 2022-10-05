Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 068A2C433F5
	for <linux-nvme@archiver.kernel.org>; Wed,  5 Oct 2022 16:07:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=pirAfU4FfXwMh3u28xo2OzxHQCAPZFaBgDu7+URsTqM=; b=D3bDcKs40ES48DSuA/eO3Nnjjr
	/UnG5OsAVV1IJE3rKF+zwbDrW+1gSUeXeULmK2QyCTC6mR+7a8d/5rzC0cmTPrKYFsqB2EwXimVD8
	IHwBaZBfz0zNuUvlRv0ND0Ou7qkep+UyjaZF2rM+mehACE5zj1FD9cNiRd7q/BiyNkx8JYYvaCvWe
	Rt/O4sKfLZWAAs9J+96t8o0WYxsZ0bsZL5B5mVuLNaZGtqie7tJH5PDBisbSZG5wPQFUk/Ebzu+sk
	NqjBJoSSypqGHMFbrw2BAyrvTBR0NsuTfEq3FpPrSJ6jRuoq4/+8fzSbYRdXeRNR+vu1WNfOmMFr7
	19X16TdQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1og6vM-00F1s9-Se; Wed, 05 Oct 2022 16:07:08 +0000
Received: from mail-dm6nam04on2087.outbound.protection.outlook.com ([40.107.102.87] helo=NAM04-DM6-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ofv12-00CAk8-Oz; Wed, 05 Oct 2022 03:24:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bS0JfTcNGucfNfmXnvtdBWY6rMhYDg7JqYoM5DutQ+ASBUE37JLyEKv8HZDiAgN5aUjCxHcXcQrvgKuauHxE3OPRSjep8LmXftdfD2jPYAyDPFRrasuEGPMhZzB9SKtYU3rqOL8m/MtvoLd4sA9myl2QWhkf/TQ1a7dqkY7oBivmYCU89mlMogh846C/RIiAjmw8FrUrxfFmbe9a3BBsF1QahGjrHW4w9cZMQx/LSwYGH3vNmXO8B37ImxNhTOXS9cvNRkuMS5Qq6Uty4RFfp+DjJGiDEGePEdEbkZ/OzZv6PA9WpZLoeB2we6dGWIbe6rDwZjk8m0rjx0S0Mne2kA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pirAfU4FfXwMh3u28xo2OzxHQCAPZFaBgDu7+URsTqM=;
 b=nB4wRUcE4chrL9/bEX+apYzGQeDQLQRnrK69vU+vyH0nAyeGwGe3PVLMbsu9mXm74oISSKyKDGb9QBX2ilJTfe0WRR9VikyINAgm/mHDuX9h7mESvHXSsR6a3IRmNo/1sYoCtKi7APEvKHfbHhIccp5lRdyea00jPXSXQxjqBMfXYYrwSnaG4Gxsh9xLJbvWKUzi3wf3RiSRuliwA5XSvHWYZ4n9dm38YW4s2MpiUqZXiwAEXz8NzftmNffu5yWUlWBbLvrADWsFNuvsfTXyCAZ5aObGWHPTEo4Nfu1N7J0CbTdaIBBWl8gy2WJs0VXSwrJNB0Q6mENzKAkrLWehVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pirAfU4FfXwMh3u28xo2OzxHQCAPZFaBgDu7+URsTqM=;
 b=nr+mqRLaJGYAkpuYd5Wg2V79uttwWuSKyYteaSGl6etEvNYfrZL7uNvjXdp+pNx9Q6lwP8sXM3qKDTKZu3pSQYRRkzW5t4Y4j7t59CykXSk6L8TN4OjD3Ze3uBuXOo/txSXiDoY9veZFJJEcc8Q3Lk2L663MT/CF1kPeccgrkKlCekguJ1PwkqC5K/2AFkonJOYkqLdVMgkS9L8RW4u0IKcCPLaON+boOLK92ZfjFrUkEmalptth3idy/5muOl/OdhPJ2dH38RP0AW5ES4x+YItMgP+sKovQtLFaosq8Ymvn1pkiQl+QemBdHzsDvx58y0KCnskzXcAQ66CvRymDwg==
Received: from BN0PR04CA0178.namprd04.prod.outlook.com (2603:10b6:408:eb::33)
 by MW4PR12MB6975.namprd12.prod.outlook.com (2603:10b6:303:20a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.24; Wed, 5 Oct
 2022 03:24:08 +0000
Received: from BN8NAM11FT027.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:eb:cafe::a5) by BN0PR04CA0178.outlook.office365.com
 (2603:10b6:408:eb::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.26 via Frontend
 Transport; Wed, 5 Oct 2022 03:24:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN8NAM11FT027.mail.protection.outlook.com (10.13.177.96) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5709.10 via Frontend Transport; Wed, 5 Oct 2022 03:24:08 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Tue, 4 Oct 2022
 20:24:04 -0700
Received: from dev.nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Tue, 4 Oct 2022
 20:24:01 -0700
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
Subject: [RFC PATCH 04/21] rnbd: use lib tagset init helper
Date: Tue, 4 Oct 2022 20:22:40 -0700
Message-ID: <20221005032257.80681-5-kch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN8NAM11FT027:EE_|MW4PR12MB6975:EE_
X-MS-Office365-Filtering-Correlation-Id: bcc9ef70-cc37-44f9-7a0c-08daa6811063
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 	bqeaBh+FDtob0efTfDjtCRGnAXvQeAEebwQeqecTFRGQoNwz2Ia/r7kE7afGzq5zJ9UufOr1tk6zq8KFI1uzi8vd231QcXnbgqQo1hvAvpiBwafMb7gfxX0yWQ+xQUf/OsQS3yohtECZqw1LosaoxS5bhDA6s60CjNP+Ul3+5t1jBgk6tNF3+FyA5NLzLlA0cyYKuoAknhw5GUWfoe/AVL2Z+s8U6A0Dgwf4XPdL5acdyOMrW7fis5T2PlOVaxxwUiesO3k/x19LrjGHkVSVC7pYNNqkTGtgpJfZ1B3EGcm+tNn1SkrzqkqVjiQAqr9yNZF+WiZms6dBTRcNsdFa8j+VFA0QeycDcjFJaBOpGh9Nlm8mgpF/CwuFxnTCDFGvJGh3kHSq06ADQAXSaaW70pOJg/3nCPy/aUufegygG1+au7RE3L01RSl8NNJRjq0q90kqvkznNikwRCRTMjavRSAAdFnOMFb96ePChrD1JfoURRwcrlV0G6qT5DCWe2/wbZk76D6v2abVhBozax3ulqiaG+B5yf95zuX/SO9IVorSEOPL7/EY9eGUtrZbj02u//KRX+67Wfbkd0tUZo+9ZgvPpugD+/CxRvQ5Wu28xQpHXbZ11LDIATaxk6Z1OoB7e5gH1V0k9JZfzk3v6YnPKJHb7m4rzVo1h5/DbGuncuSgIRWaNh0OSIGD6amgehUAv24lJPpqUyebRwLifp3mA6FtQ5G6PwD1mpHOdojG4yG5qNAIjbmj8yZEbvwLeXqaLgTbEt68LFvlkPLKn70B/h7VTA7u3OmOBpa1whuntrBlFWw7qD8eB0L4uyDPekJmbBg9Myh5OUiibu5cGkXkzeo2461XYHHVUVfJ7v5lfwQ=
X-Forefront-Antispam-Report: 	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(346002)(396003)(376002)(39860400002)(136003)(451199015)(40470700004)(46966006)(36840700001)(70206006)(2906002)(921005)(41300700001)(7416002)(7406005)(5660300002)(8936002)(7366002)(36756003)(478600001)(82740400003)(40480700001)(316002)(8676002)(4326008)(6666004)(7696005)(54906003)(82310400005)(2616005)(110136005)(26005)(36860700001)(16526019)(70586007)(7636003)(356005)(186003)(336012)(83380400001)(426003)(47076005)(40460700003)(1076003)(21314003)(2101003)(83996005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2022 03:24:08.0730
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bcc9ef70-cc37-44f9-7a0c-08daa6811063
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: 	BN8NAM11FT027.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6975
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221004_202412_849605_8E9B0EDB 
X-CRM114-Status: UNSURE (   9.38  )
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
 drivers/block/rbd.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index f9e39301c4af..c666692955cd 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -4901,12 +4901,11 @@ static int rbd_init_disk(struct rbd_device *rbd_dev)
 	int err;
 
 	memset(&rbd_dev->tag_set, 0, sizeof(rbd_dev->tag_set));
-	rbd_dev->tag_set.ops = &rbd_mq_ops;
-	rbd_dev->tag_set.queue_depth = rbd_dev->opts->queue_depth;
-	rbd_dev->tag_set.numa_node = NUMA_NO_NODE;
-	rbd_dev->tag_set.flags = BLK_MQ_F_SHOULD_MERGE;
-	rbd_dev->tag_set.nr_hw_queues = num_present_cpus();
-	rbd_dev->tag_set.cmd_size = sizeof(struct rbd_img_request);
+
+	blk_mq_init_tag_set(&rbd_dev->tag_set, &rbd_mq_ops, num_present_cpus(),
+			rbd_dev->opts->queue_depth,
+			sizeof(struct rbd_img_request), NUMA_NO_NODE, 0,
+			BLK_MQ_F_SHOULD_MERGE, NULL);
 
 	err = blk_mq_alloc_tag_set(&rbd_dev->tag_set);
 	if (err)
-- 
2.29.0


