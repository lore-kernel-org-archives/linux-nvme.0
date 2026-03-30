Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69B78FF60D5
	for <linux-nvme@archiver.kernel.org>; Tue, 31 Mar 2026 06:26:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-Type:
	Content-Transfer-Encoding:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=EFVX2nBQrqOnj8AATFrzWKYq/hh3DTG2CeX+as4ObcM=; b=RA+aCp523gjC6t/vcZnjCTfSr/
	ZeGowoBhwoqtWrrfXqlfZt7yzsX8goSz5rM0qMbd4k+9skr+wkM0JG2nc9K0KCgWdx8NPSkRKH7bv
	/jtAFWVdyPlAo2IoTyQfQEctdjYX4ZtHrxLrOYBgQpRyHvAgJ3XqGHFkTJE6iTPkd2bTAWbGU6SSt
	Uef5qBieBA0+exzsXe2EDDcg25LVl0UxnYjkXlesMpzcpCR2jKFH9cOe2lIrkLJg9MIsQINAoABNg
	SKKXNMCso08+j8cVwDADk3w8oulgS46M71B8z30YW6f5Kqg+9P3FTIbiMuEovxAdwmUnY/uZQ3FIQ
	8YFiWMOw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w7SY9-0000000CMJU-1IdD;
	Tue, 31 Mar 2026 06:26:05 +0000
Received: from mail-ukwestazlp170110003.outbound.protection.outlook.com ([2a01:111:f403:c206::3] helo=CWXP265CU009.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w7KpO-0000000Bx1e-3Uyp
	for linux-nvme@lists.infradead.org;
	Mon, 30 Mar 2026 22:11:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RepAuzxaxOcSbXt2tBNKRHxxxUxiCTkVW+dMOLMu61zM1/oYijGqc/Sm5QAPrfu9vS4XYOAC87MdciQRPlLx5RCxU8VRaLxLhTxcfunhneDfY2Cn55nSpy2yeNa3N/6J2unvkNEVg7MKmzuGxiA0oB9FIHP25yOI7CliMYwSwIZCrRhnG6VVFGNrU2AkM5McPRbv9rTsLQBMR0KTVAn7IV8pluhiG5pP3Oh+hE+12kbMDOA8wuq3D5Nynuk5Foq8c0MfLk97oTca1jRvyXz+AcyMksZINl+B+ki5/ztSX65DHgRk+qcX+D36FRyDvDPC/Z9E6kEXfR7KiW3S0Gk1Xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EFVX2nBQrqOnj8AATFrzWKYq/hh3DTG2CeX+as4ObcM=;
 b=svMJaI8VFvm3tmWGZ0mIA2VZ7ULCab4BHjoD2Sf21nW8djANOxym5DPF555hQ4fE5pG321IiddItRXblFIZitWRqX2psgw/gZc7XgD0L1yJry2LvAWchtDEPHhR+6Mw871RAQb1cEPDI2S2+akdW1E95fkbLVO0/QXVZ2lXZomCebecO5Jq9A+xSYKzYWB8hjDQTMVvdCVPRKaAA5ix59/ZYup9mnVbtjvPjL4Hnpy1q6rwPJKyuifulTTJ875AZKb6KBXWbThYBhiQvavRFJvWP+WM7Qr4RqoMsIrF09z+GF3k9JkSfGjd1mrbzFo72eCceYRqJYm26XcO/HIEBZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:70::10)
 by CWLP123MB6512.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:186::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.28; Mon, 30 Mar
 2026 22:11:20 +0000
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::de8e:2e4f:6c6:f3bf]) by CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::de8e:2e4f:6c6:f3bf%2]) with mapi id 15.20.9745.022; Mon, 30 Mar 2026
 22:11:20 +0000
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
Subject: [PATCH v9 08/13] virtio: blk/scsi: use block layer helpers to constrain queue affinity
Date: Mon, 30 Mar 2026 18:10:42 -0400
Message-ID: <20260330221047.630206-9-atomlin@atomlin.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260330221047.630206-1-atomlin@atomlin.com>
References: <20260330221047.630206-1-atomlin@atomlin.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN9PR03CA0324.namprd03.prod.outlook.com
 (2603:10b6:408:112::29) To CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:70::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB3523:EE_|CWLP123MB6512:EE_
X-MS-Office365-Filtering-Correlation-Id: 09a94da5-df75-45bb-0ac9-08de8ea9458d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: ZrO1xdzl5GpVuj8P2u/SkPy0ZyBsGxP7JwL1ZFfFmDnz9dHx1mkpIPwbYqlZarThfnacXDTbxAAZU2nInkCfIhh7CCXxp12yhypK0S57/p5yZEnDnuAJUqg5ODZuVZRP5sOtKkhIbCfyLrt2WClH48FKhJh2DkvGYrR0QH6lbf40TfBEttaOHFk8VINxdOxE0OSqaEZE0S1A/O4rDMie+ygyuq6QjpiPueS54R5e/c3zWhURgY4TCodx1JsiGc/Ji1c3rRFJfUONDiLMWBX5qFYkjru/MtFn4A427YngoObBoFVsdVxY5n8R/tBrPHHzpokkulsdb99T6X3ybBHnXNcnVOi+7bjjBn1wf5TNWSchRlBfr31tBA7rIFbWbfCMThl2AeWC6xdANISWf5UFCmGvOHeLNG6ut65tbvBuS8Mmq9dm7Ue+GE3jJNl2nykO61yFUc8Td/Ihi9DINmFX11rruUfsVLsw1Kiecsyib7ddzdVNBoAgTL/Iwo9Kj7WQhr4NKZsqKrHfL5gEuJ/Wa1h1gWuFQRn7mp3OT6EVZegmNwy4o4JpfxfZ1xFivg5O3iws5rDnH2GOwLSa9Wnh5IUkDb5T9eDxmmpTrhF2swg3hJtNcZKR13eSTK3SQgh+bkSAdQduFfaKeXCWZcRpoDBkIYO5fx+o8TMaZ9jZC5jhI8L0Vlnk+zE8/BiL8dLduY3GaJEeoM0IZv/+Vi90sxLJ27mgKGVpV7tWy3cRiMw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1IcVUMZL/Wvc9YQq/UqHHIvhKgc/ejypkqTbWnKaxgiUPyNkzeX0pErts0xM?=
 =?us-ascii?Q?u3vXdf2441iYv0YyI/WUsSma/SaHGxodDzv1oHSPHhghbZvS4wpR4uLm2zXJ?=
 =?us-ascii?Q?3ecgXaQSg+N20PPb0W2zFqENQbPaDeLG+LWMAX9DzB3vbv9437OyW/lS8ll1?=
 =?us-ascii?Q?9AwY9tyv4snwk83cUa6fjf5ZRHZY0PhWa1hGBmmwDBGtFKtt9SyJuhT7+FAM?=
 =?us-ascii?Q?H6Y1fV9j+G/1TBej6X02LNNTwTW4Fzf/sFdSueskNRgevrRgotPegsTEqX1l?=
 =?us-ascii?Q?KGLrgeET3rqDPVBHpT51zaTlGejaivT12yfn/5wQf0DdHwCDu7o5t6NF0AMO?=
 =?us-ascii?Q?Ln/o79YuS27d7SX8AGR8bqoVwhusDCLlxaqm790jRR/WJW5mtSPNoCVqTupu?=
 =?us-ascii?Q?vNPIL/SEsak9uGjrUyq0yXiWfF4qRxn9WanB1Nw5I0jvpwR2YCMbousb5XiI?=
 =?us-ascii?Q?bDtGnBNj9wUR4nBpX3DUSOgRhGIPvGIeZ+7/ZdOAou1+l7OM7MyPn4ez62Gc?=
 =?us-ascii?Q?dxBD6CyjepMnRto7H1GaY10A8t6NqIHmVS9+sb+WMBI+7jCGeLEfh/G8iWWS?=
 =?us-ascii?Q?KqUGf7Y6G7K0rFI7id7nnu0I1fU5KGozkxFOc6j8vOnz3yHMXygGqHW7DAAm?=
 =?us-ascii?Q?jdX1qA3LG/ELRYqrJbdAuYtK21cZBKUw/I6M8MjRXhT2HeMjCHMmc8K38Y21?=
 =?us-ascii?Q?H7+u7xQ3jnUAh4G4KRoCTGyQRYBw/YJezTikBErZygOgRs8sYdoxXzZ4pFgi?=
 =?us-ascii?Q?Oc3XnVKH67M/nKB4jobElughjsKH6p7ZdeEmzvy7o/AFpc1VLdX3vbBRhanB?=
 =?us-ascii?Q?3R3gjOiCbv74iZT2wY1esqeVKpgpD2yLtE7feK9LGZCL6RBusCMXOxLfEthZ?=
 =?us-ascii?Q?PpEY78sbMRf91+4hKLAlFwQxwKYVfBnXsQYJRKTZbC8+15hq5Lnkuplt7vxV?=
 =?us-ascii?Q?HIZgrtEhGVwgW/8f/jDXIUwXDUs9wfkDACA4YSdzRmdNQ8VACrKfMtsItG0Z?=
 =?us-ascii?Q?71SCFgpdcER03FRxDpFF6VDT4CIbjCWgNmSkDN8dyTWbvYqTvEFSH08Fdl8G?=
 =?us-ascii?Q?ar+B7IvNnkrkv74w+tKuTmfSMw84LNTsFSgaQGpbSvLALkm8CNiQg4s4Q/7L?=
 =?us-ascii?Q?E57vjhK0xnqmZJorUs8SHUNRRLiO8MFzPsFdLlGA5G8Y0RfIL8Cp10NHtwcO?=
 =?us-ascii?Q?OgPPeLpotdqgOPomFM9UU/baaDFygCCvKvJUsi5qhY97XS7dH9lykbDGvDeT?=
 =?us-ascii?Q?4z2aM+8fZmWzIbjTRrulkeEAZQ0Qjaug8hbkXuiYDFYTBANq7DjnFqIyDGJ8?=
 =?us-ascii?Q?M1G7/tsL+S5r0euDd49d+WUWiXPUMAsx7qB6F2RgEAaI/6o0IwN35fjFVAj8?=
 =?us-ascii?Q?vNl74O7KEfX1Zth1Hr4c5SowYDdGKsLJaNTiWL7lFWElHGMOCmYPff7E0xUj?=
 =?us-ascii?Q?S83rraBJpTwHlTw/SIjt+3NrICNPUwT4xvPrL73Sjxzuc5hJYr8pNijZd0bS?=
 =?us-ascii?Q?YWuGfEUyxZ57wToEZQYWOmN/hMqHrgR1qRopEU9eX9E8ZgLLMbc2xYVC5p7b?=
 =?us-ascii?Q?V08gbWYjRvtathqVAXUYGnTApUR9KaNlGEbhGh/PFWCyLoM5MZea1iwwmOg6?=
 =?us-ascii?Q?APTQ04tRSpc/sCh+2woftYicAfCSutz6iUxuh0Js/2oaSQOXI1RHIWlKUjBA?=
 =?us-ascii?Q?/alzNTrvbFNIwt51CI4je6IWMUM7IA9CSiZeuHkueWLWRc4Icq9iztNn1KAc?=
 =?us-ascii?Q?j1UMNPuLIQ=3D=3D?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09a94da5-df75-45bb-0ac9-08de8ea9458d
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2026 22:11:20.2755
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PJEDIAeGdmbuJJSJ2EhiJYq60TNvAPKzXfUkWNlcGmgeR/k/Uv5Vzj2v8s9EcAdjKaYTSqI/medYTsyU/trc/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP123MB6512
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260330_151122_873018_04DF1673 
X-CRM114-Status: GOOD (  12.43  )
X-Mailman-Approved-At: Mon, 30 Mar 2026 23:26:01 -0700
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


