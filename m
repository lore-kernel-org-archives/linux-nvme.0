Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C459F8E4A7
	for <linux-nvme@archiver.kernel.org>; Fri, 17 Apr 2026 04:42:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-Type:
	Content-Transfer-Encoding:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ee9AYLriQVkhiQVnDInfi9nP0h08/1jbZ3RuojyHH9c=; b=a+SkX9+2r2p7s+YRQZTkmFPZ2h
	y68uZLH6vGQcJSqXzFw7r7vkKdw3sWMTO3cf+9Rd9ZounbIHS/TcYZBD5zhX0UjI7EhuBIZuZaxNu
	PqwYGzFFQ9dy+eDrUTePxl9r5YhcXuDyMCc8I4B8CCM4y2flzW/ldjOhUJu0mtM/XmEvDZ8CvEfMF
	EHT5neDJwdvByb2huxeBWj5KIQm7VvAOrb3k/JVQXqTuTafqn9MpKHyK1p567Xx7L7glB5yHITmv1
	MfCNfaCAdMRknCVqkC76dmBkRxRno5FpOQ3p8ARx2RWTJhwoJIHaTn8SH3wcWFdWnFl9gioQIm2Mm
	HPTub5bw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wDb1n-00000003QYQ-2Ncb;
	Fri, 17 Apr 2026 04:42:03 +0000
Received: from mail-ukwestazon11020117.outbound.protection.outlook.com ([52.101.195.117] helo=CWXP265CU008.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wDSPT-00000002sYF-0kXM
	for linux-nvme@lists.infradead.org;
	Thu, 16 Apr 2026 19:29:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TCVKArScU/Obd9ed4jDlzSKaDHvfpRppHOfkNLzjBkI6Xs8yWhkM/TDgBy6vXz0oFTkRoPqfXE56LDXljUrXQWO2Xf0a0UsI7jtl0kjCKDZ12CioG4KOpvw1/r4EwzDaLRdME8PVaMNunMS5xDocbhzCzf+A9t38iZ0XyAVcnUaQDjcsr1Hx+WP2WFFvmD9aYCK2OEwNDsSGb5aEnHkoobSh917hE+aPDWHU4uIk+p0hebbz3LCRvWtAhC6Su43k/1j9LHMw49hdkX0Mj8qJw6xLvNV5AeJeqNsq2gZp1hPD0150f873aRKV5xuEBVpAwRctElAuBZnMcStRDONAWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ee9AYLriQVkhiQVnDInfi9nP0h08/1jbZ3RuojyHH9c=;
 b=wa7hYyJvRV881NexY6v9bbGvaj+XRcXEMdzQR8D1qmJnf7xyTyCoTLuFC2nuP+Bx6fkqrvPj8yA/Rj0E4nZvxTF9942J43Zm8+1+5MYxw5Cg98LB/Or8cno5QANAJgjC/0tDKkEgk5LEYfHEvJoUAhugn8KfjjwczLrNISkL1466o42lObZ1meeHl7vWcw+kVcP2oRdweAIP3UL6HcyfAf5B7EP5Y5C/fxI4/xUShYowG2VgZe/8jfi+EoF8OkfQn3CEE3OIY/soV6dZZXEf1RWEXlFhgrpiM+kZU3asq2eF+6Gbjhpdte2y4pVIWfy0VevqEjQ/wAlCN/Y1hQWBAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:70::10)
 by CWXP123MB4039.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:c5::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.25; Thu, 16 Apr
 2026 19:29:50 +0000
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::de8e:2e4f:6c6:f3bf]) by CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::de8e:2e4f:6c6:f3bf%2]) with mapi id 15.20.9769.046; Thu, 16 Apr 2026
 19:29:50 +0000
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
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	virtualization@lists.linux.dev,
	linux-nvme@lists.infradead.org,
	linux-scsi@vger.kernel.org,
	megaraidlinux.pdl@broadcom.com,
	mpi3mr-linuxdrv.pdl@broadcom.com,
	MPT-FusionLinux.pdl@broadcom.com
Subject: [PATCH v11 01/13] scsi: aacraid: use block layer helpers to calculate num of queues
Date: Thu, 16 Apr 2026 15:29:30 -0400
Message-ID: <20260416192942.1243421-2-atomlin@atomlin.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260416192942.1243421-1-atomlin@atomlin.com>
References: <20260416192942.1243421-1-atomlin@atomlin.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BLAPR03CA0143.namprd03.prod.outlook.com
 (2603:10b6:208:32e::28) To CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:70::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB3523:EE_|CWXP123MB4039:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ebbfbac-1c47-4964-1a5b-08de9bee870e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: B4ieU48D+QZ05UTlr/ax25V+96iUXH+FUphK7cGdqFdu6sD0f/xrJxLrSLJuFOogsI2cENRRydGM7nCsTdMZCYnsYgVoAHP8sP8SS/USZbPsQNhM10glBls7eaV248Cr4ilk6/QkdDIbomfSoXif8LNjdMVOK9p4AlwNGj2WDQPlvPm1UdJPAUA42brh9fEZGErDswaso0eawBfgHrWFi3P9YFWztteiXz1TtXliVL+033VMNJFLO+QJvt18SeqXwnvwXURtptoS4D1lnRqp7JZHdypFmUMN2wsNVmNdaHDLW9EXO7uNOpzn/VKgtphqmCCKYJvmQJs/7k3c0QM7eTC8BjVy8wxs1VvE8cM5OF6dwVIR69rA99wacjVNiS5yZuN0Z/34dNwkCwQiFi6f7sx6cI5FC3J07KCcg34dccVPsD5s37M/2sIAzTqFG/+H/edWz6otkkcZS4thqwYxRNbHm3tDYfwUYfflU7iOQJiJKechOF1R0A7GTugj4SSU9G+jSPuBu6bZfaVpPKbhtP7uCxkmTi9mM3MJDDI+JkOXna4mbIMp2S0i2EgzMa6AbUvID90UEywVnw26smOLTswzoe2IcvslQ5zR1w1HIC5dCKkHFsn8CCzPO8wthwQIxSdGM67YmhA5pJVDLDaJoFPT1B35Pr7mdtIyUn4i7IYvJ5TWBguNVm8T2K6I5q3ZlkYtmVbtLfM3xq48dX3hXyUZ97ZVPh5W/UIdjUDM2wY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1QNQpS/n/0OcniBzRBKEfK2CzXU6mBzSBnuAqzfuJhdBxzYTmRg17GPAcIOO?=
 =?us-ascii?Q?EJ8Viq10V/hCkTAKfEy3QipeTrRKA6rMCEq7vAEC+n/im2KcHramU3uNPlVa?=
 =?us-ascii?Q?ksMAo2DZgSwivjfec9ksZu1drZOsr38HyjwpXpvQAxPLzZ77VxTdyQBQMDlU?=
 =?us-ascii?Q?9ZpGnktOXXIOuNHcTsvJI06ZaG7v4RRFG0rA+vpdDuisZOHNNY/FVdjiF2Ao?=
 =?us-ascii?Q?z4ea7j+5kqyj2YIq4Zpxu7D83GjLQSlL8y6+qBhL1SQeHs8TVUWBxUgvZB8i?=
 =?us-ascii?Q?gG73HlDgN23ebriTIBRSctw2YLVlYtNndJKSQqRhxJLWlXvz+LllOKSyF+Jc?=
 =?us-ascii?Q?ItiJPy+vgrXFQGBRdp6TSTmmtM4Jn2QBRpduL8uVJXhci22tUPZBfzHEGJdy?=
 =?us-ascii?Q?R6cd4qOpGr3QWCTvqowmDk45CCUyMZGLlJw1UwUtnQJDsHc5CduSFHtI6kaH?=
 =?us-ascii?Q?Ax9fjkcPsYL4wqqPlL7u8MXrgeN7buZ2AkMmuUXJ9igao7hrTyxI500D953t?=
 =?us-ascii?Q?4h3dw9lUMTxKrSld8fBjacsIIwRZa/pfvA19o0oHcoYotJEgiTb9SZYh+JRC?=
 =?us-ascii?Q?Yla69QG0B/CLtbY0ocX4aqmDQp44ms2evt2aL7hjj/cSsfV8iXHOi4lz51Sc?=
 =?us-ascii?Q?3Eow1KWcD8gcOr5WaCIuY/LXUxcitCv1pIapfCQTOK7C6tYvkCMpuIGekORU?=
 =?us-ascii?Q?8BwPKNP267nfou4ngpWtx18K1IB9I1wYUY1o+RvH94kgNTtWvlF0pwvvIH7C?=
 =?us-ascii?Q?ovhBDr1QnWkLK2nLPhM0BQ3tE+zblZALFZEHz/Q58fyubzHwjbrMwmA90tBr?=
 =?us-ascii?Q?aMdnYR+HBHHSO85gbpG9caM5CqFHxDcjKxQrhJjDhxtO0MvgUonHF9LyiC7W?=
 =?us-ascii?Q?RxXfKEyPQroEFKR8HgmDEYfuR3mgPuIDSL8Q2TlglUII8k2OnQ455Y0x2iSk?=
 =?us-ascii?Q?yw8zcfDeGOnoZ7zSuKcIgm7rZR/9+pehKs3ejTk4XkYvtgDLqHAStrz3CU2c?=
 =?us-ascii?Q?tXz/aEJuMmiICd824BcV4Fp0Kd0PGhB4t7KRzOWQBHiOZFmGO259Q7oJSx1x?=
 =?us-ascii?Q?LQIoQWTzmykRmQsx/5kPamLRZeIXCBccjTlshagB+Zj2AG7laQho1k94n6Mh?=
 =?us-ascii?Q?TNUP8wuJeWIkp0d5X4ojws5euv36uB3w9kgvQQ1YFWAFCtLHsOcZU+J2B/4E?=
 =?us-ascii?Q?lX6dBXFE946DQAThi4TS5KqM4Rfw9p13ca1X7xjKeF7eLMw9Yk3IrbeL3Z98?=
 =?us-ascii?Q?2i94a4Ob1Wmij2A1AGlJj5diHmEHBrnr+v5kb+5dvM6KFqP7imk6xU/wjnMN?=
 =?us-ascii?Q?HaHA6UCX9DsI7XEegA96sUxv4zTBrQhhQIyftDxqnH6E1oD/zigshsxcuUkp?=
 =?us-ascii?Q?JNNmBHihSAZ75DFeB36hhiHEna1tuxxMKOKW3WMIy25ayiZq+LhaAjGT5dSX?=
 =?us-ascii?Q?QZQzX7/Xv80ePHXGojdiT0O7Mq8ztURYxwkbqoEh6NrWNQSUpI7r00CmE9SY?=
 =?us-ascii?Q?LagpA861+l2ksxj8Og9yO6Dv3c62DHFgapmRwz/wqyLl4CFCsiwCfFjsqE/J?=
 =?us-ascii?Q?YI+cbZfImd3G8rq7yp1dUQkxOfSmgZDfAzvhefr6IGLI39O5s2Vq8b9ToqSN?=
 =?us-ascii?Q?WmJrgWBn7tz7i0aKrjk/8lcAw/2/TdyAb2LO+fVyCcHpUZ30rkd1jcnMQ3Y2?=
 =?us-ascii?Q?a6stnnxO6w7iIv9YxnaAAMsMKogbXnn9B10OtE8ev8dJJLQ4L/tizrNT6MaB?=
 =?us-ascii?Q?qDXk/doRZw=3D=3D?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ebbfbac-1c47-4964-1a5b-08de9bee870e
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2026 19:29:50.4719
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rkDxy4MzsTvkkwjDjRka6BVm2EYoqFBF2HLNOUU37y7jAiAwxBEb4pOoO361+xK3Xm9MM8TJi4gRC//Ay8g/+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWXP123MB4039
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260416_122955_222702_978A3030 
X-CRM114-Status: UNSURE (   9.67  )
X-CRM114-Notice: Please train this message.
X-Mailman-Approved-At: Thu, 16 Apr 2026 21:42:01 -0700
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

The calculation of the upper limit for queues does not depend solely on
the number of online CPUs; for example, the isolcpus kernel
command-line option must also be considered.

To account for this, the block layer provides a helper function to
retrieve the maximum number of queues. Use it to set an appropriate
upper queue number limit.

Fixes: 94970cfb5f10 ("scsi: use block layer helpers to calculate num of queues")
Signed-off-by: Daniel Wagner <wagi@kernel.org>
Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Aaron Tomlin <atomlin@atomlin.com>
---
 drivers/scsi/aacraid/comminit.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/scsi/aacraid/comminit.c b/drivers/scsi/aacraid/comminit.c
index 9bd3f5b868bc..ec165b57182d 100644
--- a/drivers/scsi/aacraid/comminit.c
+++ b/drivers/scsi/aacraid/comminit.c
@@ -469,8 +469,7 @@ void aac_define_int_mode(struct aac_dev *dev)
 	}
 
 	/* Don't bother allocating more MSI-X vectors than cpus */
-	msi_count = min(dev->max_msix,
-		(unsigned int)num_online_cpus());
+	msi_count = blk_mq_num_online_queues(dev->max_msix);
 
 	dev->max_msix = msi_count;
 
-- 
2.51.0


