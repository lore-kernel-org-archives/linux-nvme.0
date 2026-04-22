Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E853BFAD3F9
	for <linux-nvme@archiver.kernel.org>; Thu, 23 Apr 2026 03:08:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-Type:
	Content-Transfer-Encoding:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1zbgHWZHCMR8qK0mrPQje8Fz7DdS9z6CZMQHkm92wcI=; b=Ji0uO2cbdVlS+Pm22DSznhNwF2
	KDWe6t3PYrIUoXqDEEguVG5wHI1yBmCHISjVHn4E1Dkd8OiZrmHvnTy/OEHAXOnPp+aAbp/PCx1pF
	oUb1Ol+50PzwyWWTHdGUq2gSYq7kR470OBretQJ1Oimx/9i72KilMy/7R7Yd1yeN5hKeOd8xZt8rT
	+6/GSEYxmGDmB870gbP2RzGLCBDkTlgTlEN08Er5k6d2Lh+in4zKOHJKRrjmekz8PqdhP1CLOO2oO
	Y2A8SkQ0y+4TMBH5nYiz3iqMvekdRso2+cH+SUvQBAjLSaJSte5ZB9pvaNU/cgNBDWvv8dNCo/03Y
	OJnfZqYA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wFkQr-0000000AwqK-14UT;
	Thu, 23 Apr 2026 03:08:49 +0000
Received: from mail-uksouthazon11020124.outbound.protection.outlook.com ([52.101.196.124] helo=LO3P265CU004.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wFchK-0000000AeaF-3qLE
	for linux-nvme@lists.infradead.org;
	Wed, 22 Apr 2026 18:53:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v5TazKl7HyayTX1FVOT16kW1+17hcZZPbb0WewCtk8Bgpl0sK6KOlXUVf45LR4LXoJoscA4SFBtiwYiEqHDD0gSUDgkrAJu3KTvUP0JplAZO6DyY/FD7keu78XGCi+5Piz2QNnduG7oLXYqaPB+FwYG6YgSfe4yL1FkUhh8kZEIhIvj0UtT0TfRGi9JxcvFi1aRKkn4w+XG+qiiZuzJ18BBplsM4xPsdEI6WcUQrqXFlcmiHmDJ32Ef/QyoJn/5achUT1m5E+zxjY0/o7+LOR8Trnu1lKC13uu553COcf/zQ7C6FFvzn3QrUXAvDqiiKEgqI7w//xqxFZrj1l6ZMug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1zbgHWZHCMR8qK0mrPQje8Fz7DdS9z6CZMQHkm92wcI=;
 b=xtqwunq7cVhYc044FO70rUzA5ZVZr/yr/5MvmeYyYP62jq0PkV1OYKr1QzUP2AKGq6J9yib6l1lRWciebwxw5yJg6igqxEG6i+UREw0aWbTpGm3dlc2bZaC+rNl4FSu7FWOsst/HAOBk6LnHXiWs3zITXwHyp1l/9weCxfPoGPcogMR4Hc6Dva/CWbIAGouKil8mFkncBC1JaJ1TFGtZ7UptOCqzVZpjR+B6kdoKiM/jJN/5qHRyM5cm1vY7RUP7fjPMztzu8NbY0Fn+jzpA7eVl3BovslHEjDaAtkQ2OKY72xSVWjY1P/r9QGwS1h1kldcz7XmvV+ZzWgF8fzcJTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:70::10)
 by LO0P123MB7717.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:407::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.19; Wed, 22 Apr
 2026 18:53:16 +0000
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::de8e:2e4f:6c6:f3bf]) by CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::de8e:2e4f:6c6:f3bf%2]) with mapi id 15.20.9846.019; Wed, 22 Apr 2026
 18:53:16 +0000
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
	tom.leiming@gmail.com,
	steve@abita.co,
	sean@ashe.io,
	chjohnst@gmail.com,
	neelx@suse.com,
	mproche@gmail.com,
	nick.lange@gmail.com,
	marco.crivellari@suse.com,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	virtualization@lists.linux.dev,
	linux-nvme@lists.infradead.org,
	linux-scsi@vger.kernel.org,
	megaraidlinux.pdl@broadcom.com,
	mpi3mr-linuxdrv.pdl@broadcom.com,
	MPT-FusionLinux.pdl@broadcom.com
Subject: [PATCH v12 13/13] docs: add io_queue flag to isolcpus
Date: Wed, 22 Apr 2026 14:52:15 -0400
Message-ID: <20260422185215.100929-14-atomlin@atomlin.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260422185215.100929-1-atomlin@atomlin.com>
References: <20260422185215.100929-1-atomlin@atomlin.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO6P123CA0019.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:313::13) To CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:70::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB3523:EE_|LO0P123MB7717:EE_
X-MS-Office365-Filtering-Correlation-Id: b36bbe55-e848-4029-319a-08dea0a06973
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: lxuohPdGlkDyQTJGJPcVsWIjVqfzCANuZGLCJWTU+yjvFamLzhMkFrUigpU6aOdUHyTNUm5Q2zM+tA+tlmsLW3hZhkP60/cOWzad//qTzv62VARJy51XQXa435rAA2azgTt0WRA3E7+YWP+yzR1lurnmb7SztMfTcJ4BvMvAr7x8owN/wt0i/jz4MIti7rpcgDWTBhsVvxnwQ1dm838GJeqquavwyr4n/kApM+BCku0Y6qJnSTIIiyBQqasfWHvS/SPLs6KfynF7PHifcTwz96f2wpfQhfD1UAKONF10zOTggiIeYwwyHzRAKZuuyRsW8pMrQIoYxtlA38L5+om7Q4rTPe42DQg2EerkFnn02TgBeQkdqsYYPBjohnpa9t0wrccXiUCl6amID3y/DzvuLvzOQaG0g7xjJdD492L7l7nba4dQzXfQaqJ7Ur0vBFA0eV6yfi+NaupmZDy+ioE5gZ+eIeZW6xHzx7qmqtP3Q6IFzdSqcPItf1r6H+MFyJ6TeyvE370ZcU5noX8hhG/SyDmaM6gK93A5Cy4kQBCCKi2k8bdV/RpxO8ak87A3v1LN/gkjLFnkDcKeE3xht78yTfrFjNoJWx/+lHad+FJZD+pAcWni2WMYp/L6DEKQABQ2NPJowAX/DT/Iehgs70OeZqE4qJpM0SGreoQA38NvtnwlauxIvlJWLBBcOfrwxE6B5aB5KMuTtnyOgOcIhr8lg/sw+DbP2Yao3DLIlS2OS0E=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?AegIc/cT+DCHFbDazO3vnkOfd2z2AepxGm/SqldrM8InOoaErHzxJCvgfaBa?=
 =?us-ascii?Q?Z8lQwP6/X3nb0VW3e7YdKfp06MByj6IERQgZ98USFEjPOxE+JCZkyu8WBRIb?=
 =?us-ascii?Q?LTGhMhr/pQgGmsnfUTn0ZnxQ1WnsVQFH3cHMrgPjNWBSxVtXoJ8qzwH4PqOj?=
 =?us-ascii?Q?XqnEBBVFsjGWXdlmOtfomDu/0fIM0pwcBtjFMp3bbA63KO9f8T/GC9TaZwSv?=
 =?us-ascii?Q?MIhyQn6ziJ18o1LCW83JF7hZ6y1845oZrSrHiI7+ezvhUYGQ1cpMA9DULUFX?=
 =?us-ascii?Q?U6zrk2BuwzSHPDZC8BuYzd1hsTa8V8F1rRzllQxyEWXtRNPlF6UW4nlEqtbG?=
 =?us-ascii?Q?qPuEfKCCrU37Yr+Pv7ypuGDGjNT6O9/I9uxeUw+EXouvurrqGut+CFaGrQZn?=
 =?us-ascii?Q?Bi+s8+xXshD0x5vUu0jwX1dLk1+iiR4pKcWuNPnwxuoBa8PsslyvxiVASirN?=
 =?us-ascii?Q?6rDNXOY5aH8KVFMSvRxWgTXRcoVpdlxKlbViCoSSXcjSmmZktgBupGqBPVBz?=
 =?us-ascii?Q?GQ99JV8i80cggEQyp7LDwrpjLOu6eHe0Av5C28BQUcQSKUDr0cLysmXYrCOX?=
 =?us-ascii?Q?0QWM3QerDZCcoOK85bt+WY1c5JxShq0kdhlD89atI634kNYe5SsVupSWn+4N?=
 =?us-ascii?Q?a98PdI/62oPeaXaUtoqKO7C1E55ECHUjdHTHk8JlVXFxW87AUMQ+kNUCBC7Q?=
 =?us-ascii?Q?jBhIAKS+UFVUVgQuxnTrOg98zmvvEM76hJ2W/f+KQ3WT3cdUhSBwQMjLy7r0?=
 =?us-ascii?Q?wKc7MDCS892ELecZB1q9S1js/we+hU31ZMiNgUXSgUEUp3wb9M012/kaU395?=
 =?us-ascii?Q?2Y3+MRdPpViMFlPQW/90fUvCHGLB9S2SVUeJl+rSlcgSKy4ySxpNYOTUOPGd?=
 =?us-ascii?Q?seTGxGj9cYsbggn6X6aNJPTCa2hsqhJ+eIZsve93herJn+2MMpmCpqG5obX2?=
 =?us-ascii?Q?xR95/yxRoCCewmWw0adRzlsWaK4TSso3s48Ra3eMrGbcXo6XL1J4caSRMLBK?=
 =?us-ascii?Q?GENGakTLTnQVRWDbK1emAZnnV8CgCOswROlE3A+T9rmM3+uVbQB4EOoMidSf?=
 =?us-ascii?Q?jM8XGRAf5Okyb5fKXHKQ0SaeQxtgmj2yqJdvGPyetrGuxCDB+yYoBY5mw0vi?=
 =?us-ascii?Q?DpVvc8RzAhr0unenUd5/OJUgZBqQe6ElbDG/incdTemiwXr6wlitFHSTz4Tl?=
 =?us-ascii?Q?ENDNuFh05RqNxavwAY/FlMVRWnCiO8KXHb4zWqs5cOShNOG0oUQbTnh4ga85?=
 =?us-ascii?Q?gUVV67tOZ465C5sh8sZjykwm+6vpBCDoT+ncQ8XhJoTjuly+2iWcDwCr0t6k?=
 =?us-ascii?Q?MUms5ojJ7U9mvJiyfqWvlNkAjKbgSaFmeOjV7bjTGW7+YaB/EVsOCuo8uSgk?=
 =?us-ascii?Q?3SI93v3CqY9zm93lixtO+6Xl+zXHhBoWOxQ2RemqEiIRDAtScbyMa7EDAa99?=
 =?us-ascii?Q?wXIFO4UqbtbxnjCiOw2dIEi6XEroxwzKFut0tzIqiKII+wPR/HRR46tEKVCW?=
 =?us-ascii?Q?Vpt3pNoJWT7b78BtBv71e+wlFfC6RYDHJjDAfjheScI8NX5wZUv/KW0ho2T/?=
 =?us-ascii?Q?n4EpUfvVe116sU7Gx6XNLM536V0HEeegfYW/DT3XPbvlslI6HuMUgraZDFwv?=
 =?us-ascii?Q?jd631O6/H3Vea1/BhaIbtx/CF0hdyus3sFidmt30GlRvR8Maz3roMiFXdEjL?=
 =?us-ascii?Q?TjEeXha5xA+FyBeYcG80unHxxbFdcrJqtFRZNwzXlHVqGBHcYUalaVusDl9+?=
 =?us-ascii?Q?iz49uStmNQ=3D=3D?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b36bbe55-e848-4029-319a-08dea0a06973
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2026 18:53:15.9939
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PsnRcmRMAzCIN4YWv8+ySNraPHOLPxUGJmCFJVdGddVs/MTG5JHCMgbZsFljsl41xUgZZ1R2h43mJxPi5AMuAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO0P123MB7717
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260422_115318_957863_FEA15A45 
X-CRM114-Status: GOOD (  11.71  )
X-Mailman-Approved-At: Wed, 22 Apr 2026 20:08:43 -0700
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

The io_queue flag informs multiqueue device drivers where to place
hardware queues. Document this new flag in the isolcpus
command-line argument description.

Signed-off-by: Daniel Wagner <wagi@kernel.org>
Reviewed-by: Hannes Reinecke <hare@suse.de>
[atomlin: Refined io_queue kernel parameter documentation]
Signed-off-by: Aaron Tomlin <atomlin@atomlin.com>
---
 .../admin-guide/kernel-parameters.txt         | 30 ++++++++++++++++++-
 1 file changed, 29 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index cf3807641d89..e2d798351964 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -2810,7 +2810,6 @@ Kernel parameters
 			  "number of CPUs in system - 1".
 
 			managed_irq
-
 			  Isolate from being targeted by managed interrupts
 			  which have an interrupt mask containing isolated
 			  CPUs. The affinity of managed interrupts is
@@ -2833,6 +2832,35 @@ Kernel parameters
 			  housekeeping CPUs has no influence on those
 			  queues.
 
+			io_queue
+			  Applicable to managed IRQs only. Restrict
+			  multiqueue hardware queue allocation to online
+			  housekeeping CPUs. This guarantees that all
+			  managed hardware completion interrupts are routed
+			  exclusively to housekeeping cores, shielding
+			  isolated CPUs from I/O interruptions even if they
+			  initiated the request.
+
+			  The io_queue configuration takes precedence over
+			  managed_irq. When io_queue is used, managed_irq
+			  placement constraints have no effect.
+
+			  Note: Using io_queue restricts the number of
+			  allocated hardware queues to match the number of
+			  housekeeping CPUs. This prevents MSI-X vector
+			  exhaustion and forces isolated CPUs to share
+			  submission queues.
+
+			  Note: Offlining housekeeping CPUs which serve
+			  isolated CPUs will fail. The isolated CPUs must
+			  be offlined before offlining the housekeeping
+			  CPUs.
+
+			  Note: When I/O is submitted by an application on
+			  an isolated CPU, the hardware completion
+			  interrupt is handled entirely by a housekeeping
+			  CPU.
+
 			The format of <cpu-list> is described above.
 
 	iucv=		[HW,NET]
-- 
2.51.0


