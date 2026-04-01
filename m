Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5AFED39436
	for <linux-nvme@archiver.kernel.org>; Thu,  2 Apr 2026 14:14:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-Type:
	Content-Transfer-Encoding:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4knCfnZAGUMtxw+RvifPy8TClaNGAJvQvEs1bgcMuj0=; b=F/4yTmV48HxwQFyFdiUgR6N3rw
	brgceRnbei0Rtg1GP9i/gbksqgtH1gLzc3BM26Zdjy8zegRapECE8USU50UeNOznbBZkv3SWLJlMq
	MFJuu2nzkb4MXJes6cFVWtb/v2z7j+lZZSvSahp2fwLe0dSUAUMe1LaV47xd+JcC4D4pm1glgPXYH
	6nhBSca7QqpTdZYwbB9lPCZ337gNeknitZtIrcMEVsYtTjohP9HcwX4xdIGJQWrI3lz2Vw8nUiWRJ
	/f015C+a3A0gX4Eo5erM6+n7XrbpSFiFE/zMyW1tIv3nINU9b768StIABKArDbBgO9B3yeWu643B1
	WxIb5INw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w8Ioq-00000000GO0-0lxp;
	Thu, 02 Apr 2026 14:14:48 +0000
Received: from mail-ukwestazon11022079.outbound.protection.outlook.com ([52.101.101.79] helo=CWXP265CU010.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w83yT-0000000GJJj-3KKV
	for linux-nvme@lists.infradead.org;
	Wed, 01 Apr 2026 22:23:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ijNzX0U7099I7UNB9BV67Xr/3cSTQkFYVES/JBnzuwNWSqHdvjyyDXCkgTU/ththuy5ecBHl8NGGdatBWDCUEIrrEHICtlFTtVrQ3E+uW7vkn0BRwSLCcpx5eFdPEz1aATKVHNok0IIp3G0vFRgqWoRp5EMxN2Lzfhfp7j9HX7PE5dwxjaAlH4YptiwvgBwfNTW0gjoLOYkeN1N8/8zzHkhJAOdaYJrrcynkr7/1rnLW1GMSKHmvOGxSeiyp7a0oA+RlLpYI7HdQhOfjt83SV47KHhMP5Az2BAqy12lqjZRIBi3HCw3PEtTpuK20ZJsrKa7GVmGcPp525go0eUREsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4knCfnZAGUMtxw+RvifPy8TClaNGAJvQvEs1bgcMuj0=;
 b=AT32RISbDUbjTAaIJvYt7g08iD63dn3k2WlQejV6cMJqkv3cxYxc1YEUHx2vIL+bSzZu51rJypwNw9U4W5GqPpvRE/ZR5er0e5NdnwL1KxnurhNk5FBnRbMdP/Fd3xzHcJC/fyAHfYJxyT3K3Iqwinirajl/LcAARlr6EAzjRmAdALggFcFt6Afo+jA/oOkvdyNs6j6p3sfUNq6nYjbbayTMLZ7TEEU/Q8bhoORUYpF0ZPpQ9V4sU3v57mPcS8p3Agw2FT2T9fn8CpO/qnrdD2pE7noyAzIeDIE9HWV/ase1MUeMR1Tq1uDTEYjGqW3H9TWMw3gCZRRjXkL9xkpIRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:70::10)
 by CW1P123MB7844.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:212::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.28; Wed, 1 Apr
 2026 22:23:44 +0000
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::de8e:2e4f:6c6:f3bf]) by CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::de8e:2e4f:6c6:f3bf%2]) with mapi id 15.20.9769.016; Wed, 1 Apr 2026
 22:23:44 +0000
From: Aaron Tomlin <atomlin@atomlin.com>
To: axboe@kernel.dk,
	kbusch@kernel.org,
	hch@lst.de,
	sagi@grimberg.me,
	mst@redhat.com
Cc: atomlin@atomlin.com,
	aacraid@microsemi.com,
	James.Bottomley@HansenPartnership.com,
	martin.petersen@oracle.com,
	liyihang9@h-partners.com,
	kashyap.desai@broadcom.com,
	sumit.saxena@broadcom.com,
	shivasharan.srikanteshwara@broadcom.com,
	chandrakanth.patil@broadcom.com,
	sathya.prakash@broadcom.com,
	sreekanth.reddy@broadcom.com,
	suganath-prabu.subramani@broadcom.com,
	ranjan.kumar@broadcom.com,
	jinpu.wang@cloud.ionos.com,
	tglx@kernel.org,
	mingo@redhat.com,
	peterz@infradead.org,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	akpm@linux-foundation.org,
	maz@kernel.org,
	ruanjinjie@huawei.com,
	bigeasy@linutronix.de,
	yphbchou0911@gmail.com,
	wagi@kernel.org,
	frederic@kernel.org,
	longman@redhat.com,
	chenridong@huawei.com,
	hare@suse.de,
	kch@nvidia.com,
	ming.lei@redhat.com,
	steve@abita.co,
	sean@ashe.io,
	chjohnst@gmail.com,
	neelx@suse.com,
	mproche@gmail.com,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	virtualization@lists.linux.dev,
	linux-nvme@lists.infradead.org,
	linux-scsi@vger.kernel.org,
	megaraidlinux.pdl@broadcom.com,
	mpi3mr-linuxdrv.pdl@broadcom.com,
	MPT-FusionLinux.pdl@broadcom.com
Subject: [PATCH v10 08/13] virtio: blk/scsi: use block layer helpers to constrain queue affinity
Date: Wed,  1 Apr 2026 18:23:07 -0400
Message-ID: <20260401222312.772334-9-atomlin@atomlin.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260401222312.772334-1-atomlin@atomlin.com>
References: <20260401222312.772334-1-atomlin@atomlin.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN0PR04CA0011.namprd04.prod.outlook.com
 (2603:10b6:408:ee::16) To CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:70::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB3523:EE_|CW1P123MB7844:EE_
X-MS-Office365-Filtering-Correlation-Id: f153671f-0c72-432e-079d-08de903d55f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 5Fry9p8iVwg74XojouJ2NLPYPGk9VRH2Iw4s010Hgf5YBMox5w7gbuLQEmhtdgmRWd+s+M7240h1rzj8b2uQj1Gltj7eDjlNryvW/TMw4su0vv6WPNx9ujrmhlaLkgxWmw9bfkvl1+ynfmBk7EExt4L8bUo1N94NlcEKFNp7MReI9fY0TPA6BuMVbt4PMbBq3cRi0Cc63XUaD9sYWXRcn+gfLijRYqehnqJeEA62MpgYL5jIenoJ+5ShtQ5ONVqh8TNSHDeIqdSDtC2Bnch6crXJaYD5ks+peOz8AxqQVVDNA0++/K/WMJfdwSAKjdykZd5dKCke/WoPIud5PU4rz9OXwsOcu3HOt9YfNOfci9JUbZpl2+3895F2KiH3W2yIZMiq78SxaxzuJWikzzA3anJqpCP8Gr7aFJEOraGjjE9JeQjxznUHi6BMRf3XXaNkR3JcCW5QFLlxousicsqqxQ9jZN50B8v9UCJ2nRmK2DEysZXDzEfHXT15XA1rskr1jFvpaZqptdYE44thCyZstT9GErD3CInZ7mvwN1nwfmdusckVzdZl9OipT/3LIYtAAsVdAmasskQOdlyL4fxU6Ne3tjXE1HBG41mgSgcJPHEI/ePUWc5Jnu/TwYOGD0w7hK5fyVbI50W+KNMHDkGcL7s3JdZ6P3mdAX4cPIvz1Nqdbndh+26DQMxuJKD9j3nL1krKHycZOrl2xfUgN88UU5nmd3QzInyn5rEtMc3YQy0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ywq6FJ9tCBn/ErCQgRQiR3i2+FcQp7E0uy/0RrTSDssY4a4gzMWoRM/t9Fw6?=
 =?us-ascii?Q?0WIU6wWsYokmXg+R9mrH9nEIp2wfG86eIcos4Vet7SYKGG1Kknq15RRv8Z/q?=
 =?us-ascii?Q?ve963tZ97PjiF/RSUSGSO0rcxirK7u7yYVizLuO1jdMUihRH9tRpnIg34oCH?=
 =?us-ascii?Q?nIflw+w1QmAhv4iDxHfw9zXGkx5wJzd7GvRy4LHuEgM/Y3nZ38mwEgiPAR4U?=
 =?us-ascii?Q?ecoPodPi3/jGSg1FrkCFU3EQOrjjIGfCpvWpH2yxhnUHBa1SEqwULjS9bSb3?=
 =?us-ascii?Q?9xQ5dDPsE1g8z4z6Tt2dk9hr/TOIX0hTSsGTwuieDF1UNz+8Or1ed/mNEgGl?=
 =?us-ascii?Q?ZT4IjSUruzLUTJmxRnhvqWLd80GhSC3po+lFOYy7gljFUhMDXSLzFR5hgMD8?=
 =?us-ascii?Q?rGC4jnQ3YJ+YjHBWvNrpwtTv5Mq461Hk+Oe4e5m9dM3sWoSfgd2FSAzds2OZ?=
 =?us-ascii?Q?fRpdH8PAh9vkNmdsuMPglpNee1zyAFI7e+1V6YNk+zDCe2S9yaO8wyXJ+dfh?=
 =?us-ascii?Q?ULWw+Hw8XQ/eTSc0Jm0ppd8ECzz8XSDKkfYHobSEUm4wziUKCenHT5eUMlZ9?=
 =?us-ascii?Q?0u5xc0f21oThFUuS3Zqi5DxOA5Q8LyaWolszDctjF2gcQ9eARKa2flLgdo1k?=
 =?us-ascii?Q?oH2I6cYNc6aYuJG2Zl0PXuhXpeyyVW1eSqQwlyiHtpH4JSst9xCw8G7eLMhA?=
 =?us-ascii?Q?+OSK4egNiAeCUPjl2fot7dUbxLqQXSvVc2mL3dJFM/+MEN10V6qf0dwvMtXH?=
 =?us-ascii?Q?kta0Syir3T3MHxiqRFVFgw9NJyDTb9taRuo7oNZQOXKB98Wp1i9x7ZCeLfO3?=
 =?us-ascii?Q?rCZdq6gQMZY3v/5F6gtwn07zmmWfOeyAVjbQZjEQLlaAcAFpciJ4pyozsgp5?=
 =?us-ascii?Q?TuXlOOOHI65j9v2OjTcjIAl7WR9JmbNEA8wdJkN8F2jTc5QECIgOa5qQLp+s?=
 =?us-ascii?Q?jowN5Bj8AFe5DoPrSzK21eMLwh5y9Ot4MhP7i2Y90+CpOMWgacW1PwqHTGFp?=
 =?us-ascii?Q?AKR7InA4IYMkembZL1Sc7TqagmoiFKeYwUCejgef7I/NG0kU3808Y2jIp/TX?=
 =?us-ascii?Q?2h784fSchIxadjlKDK+um3oi8os6w4Q3Dr6KtyPrbvu+n5CeGMjdMPKEy1rX?=
 =?us-ascii?Q?m9tsNETpNbMwzvGhzsnBUbju7T1PO3D9oP4UMTSVjBNTOaHnBnNyk/IhAM3k?=
 =?us-ascii?Q?HpSdeKlzrUUpzEme9YjiIx2JhCyJVtkJHFtrNqklHcKXwkijKsqj8GltaI+0?=
 =?us-ascii?Q?LT6CYCRo9g/B31Kw3Og/2D5S5gL/9lsAlvUq+Ct/NdKpgrwSa5Sd21Mteb3t?=
 =?us-ascii?Q?yd+hzDwQ/NXVK8UNIm4J+tmW7Cl0ibW1WZfHKu8WzIgEYki4c9OuCbe3East?=
 =?us-ascii?Q?68WLu6euBnNAuFvLsr5RF7kzx9iOHujGKhHu366OyVjRNcnvOR6Gf40k6+Gf?=
 =?us-ascii?Q?aW/fA03W+Q90znWYRsLsy4HA0ync7Ny1OayGPnCi699xiIQyWwqCtse1vjvN?=
 =?us-ascii?Q?Si1/M6/ZCAMIN7TyZszj/EOw0t98T2RjsCO8/TjzGLj8ZfRlT6jU0nmCIjcf?=
 =?us-ascii?Q?OaAxvjSZm9HeFinD5Cjkpij0jEeWamOw518iRbJIBG5A/HMBw+XnMgd8UfWV?=
 =?us-ascii?Q?i4zWoaB80MxwIAffkL7B6S+3nt1V+3WSWVNFHVvPkr/tJQ3AToa4NVjVKpVk?=
 =?us-ascii?Q?xhc/nxHhrZVtLBRf/T9Ab13J4d8ar5nHjRAo6ZFL7x5NZDOo73IsWMS424es?=
 =?us-ascii?Q?gVFGPHR4eg=3D=3D?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f153671f-0c72-432e-079d-08de903d55f5
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2026 22:23:44.3497
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vjUPWyneSKWiYWun8LxVriv66rstazNLuZTS5HuKwKAbhN7IkrKVRwp6TdxuVdCQpDATHUfG1cvptE+K+ARdjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CW1P123MB7844
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260401_152345_834531_99950CCA 
X-CRM114-Status: GOOD (  12.60  )
X-Mailman-Approved-At: Thu, 02 Apr 2026 07:14:41 -0700
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

From: Daniel Wagner <wagi@kernel.org>

Ensure that IRQ affinity setup also respects the queue-to-CPU mapping
constraints provided by the block layer. This allows the virtio drivers
to avoid assigning interrupts to CPUs that the block layer has excluded
(e.g., isolated CPUs).

Reviewed-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Daniel Wagner <wagi@kernel.org>
Signed-off-by: Aaron Tomlin <atomlin@atomlin.com>
---
 drivers/block/virtio_blk.c | 4 +++-
 drivers/scsi/virtio_scsi.c | 5 ++++-
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index b1c9a27fe00f..9d737510454b 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -964,7 +964,9 @@ static int init_vq(struct virtio_blk *vblk)
 	unsigned short num_vqs;
 	unsigned short num_poll_vqs;
 	struct virtio_device *vdev = vblk->vdev;
-	struct irq_affinity desc = { 0, };
+	struct irq_affinity desc = {
+		.mask = blk_mq_possible_queue_affinity(),
+	};
 
 	err = virtio_cread_feature(vdev, VIRTIO_BLK_F_MQ,
 				   struct virtio_blk_config, num_queues,
diff --git a/drivers/scsi/virtio_scsi.c b/drivers/scsi/virtio_scsi.c
index 0ed8558dad72..520a7da5386e 100644
--- a/drivers/scsi/virtio_scsi.c
+++ b/drivers/scsi/virtio_scsi.c
@@ -849,7 +849,10 @@ static int virtscsi_init(struct virtio_device *vdev,
 	u32 num_vqs, num_poll_vqs, num_req_vqs;
 	struct virtqueue_info *vqs_info;
 	struct virtqueue **vqs;
-	struct irq_affinity desc = { .pre_vectors = 2 };
+	struct irq_affinity desc = {
+		.pre_vectors = 2,
+		.mask = blk_mq_possible_queue_affinity(),
+	};
 
 	num_req_vqs = vscsi->num_queues;
 	num_vqs = num_req_vqs + VIRTIO_SCSI_VQ_BASE;
-- 
2.51.0


