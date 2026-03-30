Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62935FF60D0
	for <linux-nvme@archiver.kernel.org>; Tue, 31 Mar 2026 06:26:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-Type:
	Content-Transfer-Encoding:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xkAFoD9AGa3a+dVCY33iT88DiZ62sZo4vQ3Qj2JG3Sw=; b=t8Jbff+qMQnkfmQV2eydmbs71R
	Sqh78ZzN62MEthwR3akwH/Ej8fElLNIIVkN9yMuu4A8SW63ASDAmgNF6PulZSF7c/tUqC7NyX4vLw
	F0xy0STypLOr4APRx4WCULH6O1wmWZlz6uuOZDGTPYbWPtlK4qj9Rat9SCLSIRXSLC2LKlcmGOVkE
	584wtuTKU2DQoy27WIj9UmpBVbZM+bFIHm0eCxAAF+LdpJCrBsEWhVqtCq78Sdyv1mr7LPaXKndi0
	4mJSRuS9Sxt+Nx0RykiVc7FdSnEEmDkCLinZ7f3UK608f5ICnjpzCdGnQorJCaBm3xl+SMsIAVU/k
	LOlowEuA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w7SY7-0000000CMGC-0dYz;
	Tue, 31 Mar 2026 06:26:03 +0000
Received: from mail-ukwestazlp170110003.outbound.protection.outlook.com ([2a01:111:f403:c206::3] helo=CWXP265CU009.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w7KpA-0000000BwwR-1E2n
	for linux-nvme@lists.infradead.org;
	Mon, 30 Mar 2026 22:11:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qbQcEUhaR7arHgJd25Qqqf1rhIcbO7f4xTFaID0lvBWjykNULSwpM/rQSDl+bTyWgq9FK529Cl87PawhJKjhzPODvWjosEly/IGqVz0VCFtorvOtPp0OT8/PxhnIZXz2t5XrOqotYlNNSq/LYiVlSBK09Bt0YvPmM2tKcKmdeBFOi2dMlCuPorY+dXILnK8JXMzU6Obf01eFj+wYckL3jIyhU3wWvFCcTQwrjuPpT/cqfrI6uSz1GhDjes8lK+svL0ezMQ2muuknhWO1yZiwy7DCOEccmjwovuil/+LfOvrXWm/aLohTKnKcOAVvQKTI2Cf5LcSQ0VljFh5vvGg1IQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xkAFoD9AGa3a+dVCY33iT88DiZ62sZo4vQ3Qj2JG3Sw=;
 b=oykdQXbBCsFFOAULPgR7GnPAFfLr3DPxC5VSuArWQV/8C+cRdffzJ9WbCYVDZqHKYnfryZ4h+k5l9P4N5+so7ybq3q61uKStGq+XN/kW6/vyBmd3d/qzRYAy5UilE/rl9Qtkr56ThPYPcZCrYFdTSdo13GkbtYDYuLqthhp0y70sSsfTM4tnld9/pLwmk972Lel8x1vgrDFSOPbNhx3H6Vpp6yntE5+ukOw6YajZJxczFmn1J6d7cUlWtuq0hOFfUq/KdAJ2voEo6jsRKAN4pnBUjKv0K7Fj8CX9ixy2nYEr41J/d0GCjzy46LwxbFi3LnaTN57Dve1a+G93jf1s3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:70::10)
 by CWLP123MB6512.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:186::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.28; Mon, 30 Mar
 2026 22:11:04 +0000
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::de8e:2e4f:6c6:f3bf]) by CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::de8e:2e4f:6c6:f3bf%2]) with mapi id 15.20.9745.022; Mon, 30 Mar 2026
 22:10:58 +0000
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
Subject: [PATCH v9 02/13] lib/group_cpus: remove dead !SMP code
Date: Mon, 30 Mar 2026 18:10:36 -0400
Message-ID: <20260330221047.630206-3-atomlin@atomlin.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260330221047.630206-1-atomlin@atomlin.com>
References: <20260330221047.630206-1-atomlin@atomlin.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN9PR03CA0036.namprd03.prod.outlook.com
 (2603:10b6:408:fb::11) To CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:70::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB3523:EE_|CWLP123MB6512:EE_
X-MS-Office365-Filtering-Correlation-Id: 39f7db68-f33c-453f-46c2-08de8ea9389d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: u/kJLESIqai5x8AanOJWVxsYDhVBihjcdkmg0nNfH9DA3ZCdjGyrFb2/ldUMre7WvfQs+kis+xgh4XfdIr3fs2MQe4FvuawD/mEWDY0Ztb6BZ7flX6td5YLBIeKRzM5wLkPvNaeOB69NXC51zMFqFE05onblAQQQVK/YKwtaeMMT81oDNmUWjSmEvOQ1vC2SatnMkPdpraAYIkDOH+f2UwV45/VPNNIVZT4DYRI7hFcTHGk/fzT+2mLPfIIqmSWFaobqIeFDWJABbQtF58dhapm10uQA19RTPhVz1Kq7acsWB2r/UAIJ81Qtjb4AWCSunrz0WIshFaXHsonifH+U3gTw8UoCWFhdgxvMsoB+dnuX3l5Nv6lozEnK4a8ZKtRcBU6Y3/s5uMjYVPgLvZ6+Y14CkVi8deSgchmPP8sPrOCwa/wIOgFon3OM9XEpfhqjBfXSeTAh7ocbD61hZp4tHTOZ5wHVzdYzDDsZ3ySl/9rCpbeiPIn7wi+RzvG3WNfMcZGve8jtz31V/fORdmYB1gBgNi51DTU6ii3t5RLkwKxCdt3LLDlRtg7e0/k7JGmNQGmJfHHRplpt63fPP4ptSKzhudu/6zg/OEjfgGgyhAlYGbdVDY5pEHRdWa8KFy/S0YXFfL7dWpjWH0qU1KOUpluUPh6JKRTMrLIJ+FgBs/mbOZuTSOeru/tmOqGkXLhfTQxHXFc876uyhRSFQW/f/UmNgxFQNE2puy1+v59R4Sc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wFw2NRiwP0PYNKw0RdAspBVkHTOpoQovinALjcy+Gs1i8R0kuIPg60yxJ6Ek?=
 =?us-ascii?Q?59Xyf1wsbRsJAWWouvP88OxsXZyg78FAD0oCB6C1w1oREQhA1rizxwwivLeq?=
 =?us-ascii?Q?Kw3poZ6K8cfZriSc6FPDa+QWkWyDfYeknC4nZKnUAqrTKCATUNTxxurJPpY1?=
 =?us-ascii?Q?91u48fqSqgOP2mFvicS5erukF3e3Cri1fE4DXfxG3c4ezpD4MAdtqCgsaaw7?=
 =?us-ascii?Q?Kvb6TeEWxFAuQ5tFfHCvj+QOUdSHaFPqtwiNfmluJCbJ7mYqvtgC+HfeAT0A?=
 =?us-ascii?Q?croMupyGG4VFaKMkMCWIUTjUKr4ac84XMzWjerKq9P3oOEVEw/t/DaQQ8aZ1?=
 =?us-ascii?Q?fGzyo6GffGHWboldUunGooQT6Nv5haKUKbRbtZ+bXWZrK32bGM1HWDWqB1y1?=
 =?us-ascii?Q?D9TUHnZ1UvplFAJyOmkuD7EeM/AdE50So55cAJJ0pPXxMUiW7tFjA5iB12Ta?=
 =?us-ascii?Q?OM8qYrTsK9mCQUP56h9/hr996q/TFKqdQJYwcLJ+e5XvC7ksrw9uSJFVIUvu?=
 =?us-ascii?Q?sLN3wf0r+uuN7LaJoxzT4sXzH6eahZt9BzZ7iN8efHB2SC4O0XlJyEON4c7i?=
 =?us-ascii?Q?B7iEvoBYUi7RLyz7ceUW9ZfArT1IOHrbjny2wqstYa1QeQbTso+UTqZPqrpw?=
 =?us-ascii?Q?nCX1HEziSniv3p0SHudT66QkIShT6/6WKyvgjxpLUM7ayM7foDEqA6LgeVrD?=
 =?us-ascii?Q?mXGwHJXRUU+1u4Msb8BKpxehV2xHAxEpoeCgbCYiM4RSXc8AqxNE/5eCtBX7?=
 =?us-ascii?Q?G2vTSBCFN9Gsg63bgEnfHr+o05S/YFrTEPIVSCoB4RhCh2MwXlUlS+P8x9cU?=
 =?us-ascii?Q?WYWXoEr2o/VC36DfaWZGtaGzpYsHexrwv/b8dS2/zpbyqxC/st8q3NU4RiTW?=
 =?us-ascii?Q?Sxv8/f2MfmchGny0TvrgpJ7VLo87G02uFoB0PBVpsXDhXpaH4HKOqHnqIBdq?=
 =?us-ascii?Q?NT6PbW11FTfOoYNAeSPoPNh6uRxJjuiOXRj+6Wn08QZnEg6iI0ltpn2orah3?=
 =?us-ascii?Q?Lb3GkG6RwShQvKxYMNmza5m+ltzl6jKbFEdPOOpMFyeV7C04Xadqcu+GGNEB?=
 =?us-ascii?Q?ckCy4WOvoZuGytAyT2ysmpa+0JBitI7DrcXzILJkFlUmPJcENZAfl5zvoMbo?=
 =?us-ascii?Q?AiRYmWDTSxeQD4pg0DBTRVVYdehBBfxvPN3cZW028AUI1rPOE/Ft/A4SPc/T?=
 =?us-ascii?Q?qubfRRn6H+6zeoRZyz5jispRN+6XMPp6pzr7NHwIQ+M7MRDgu0TuwASIsJRP?=
 =?us-ascii?Q?e8hnBt86/VbyrmZYVHosMQY5db2cP7fPM37D5WHoK7Q1haEFSMlAdpDsQMa7?=
 =?us-ascii?Q?Hdy7PQ4TczjBKrG6gLCBoV6Sq9yHMTRgZ8l1G4TWyb+QiCv8lsRVLxUIqyR9?=
 =?us-ascii?Q?8kx2xeh1acQVH2i4fUBhu488TAzZ9BZ7aotDnnjmITe3wh2WrCuxxNWmvhoz?=
 =?us-ascii?Q?8CG0sOhTwxB8Y5iy4Ikkl9SflTGIuEg0XHUCg13BsdABVGEBhYttwtxinN5b?=
 =?us-ascii?Q?zWQ54+8QfO+YxGnLbT4cJPz+2eDwqgo3gSryQi7lRFdNolrYT9oJHM/esJU0?=
 =?us-ascii?Q?rqFfy4aAYe4v88rHdHP3HbwThX9xQHvY57BpK2RSGD4sufD7ooU7U0JF93mQ?=
 =?us-ascii?Q?JJCXuESnjlN9+X9Lk3NnNpj7sk1gfs3q37aaG9pdBIKeWhqfrFBn0PwE11WL?=
 =?us-ascii?Q?WORq5/U8MDLcOH+Gs+SoBFaCXhQCKTsZwUdgwozCGH29I1VEQGLoqd6HXkt1?=
 =?us-ascii?Q?ybOWsDYFmA=3D=3D?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39f7db68-f33c-453f-46c2-08de8ea9389d
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2026 22:10:58.4639
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Eosq+RotVlXNieDhCfywSedHF+cSuoLL0Vi/EbZZdsNhp5WQf152qW0FVidSyEyBxFSZsz5MUK4gSM39JTgQMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP123MB6512
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260330_151108_353557_C5A6B527 
X-CRM114-Status: GOOD (  10.88  )
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

The support for the !SMP configuration has been removed from the core by
commit cac5cefbade9 ("sched/smp: Make SMP unconditional").

Signed-off-by: Daniel Wagner <wagi@kernel.org>
Reviewed-by: Hannes Reinecke <hare@suse.de>
---
 lib/group_cpus.c | 20 --------------------
 1 file changed, 20 deletions(-)

diff --git a/lib/group_cpus.c b/lib/group_cpus.c
index e6e18d7a49bb..b8d54398f88a 100644
--- a/lib/group_cpus.c
+++ b/lib/group_cpus.c
@@ -9,8 +9,6 @@
 #include <linux/sort.h>
 #include <linux/group_cpus.h>
 
-#ifdef CONFIG_SMP
-
 static void grp_spread_init_one(struct cpumask *irqmsk, struct cpumask *nmsk,
 				unsigned int cpus_per_grp)
 {
@@ -564,22 +562,4 @@ struct cpumask *group_cpus_evenly(unsigned int numgrps, unsigned int *nummasks)
 	*nummasks = min(nr_present + nr_others, numgrps);
 	return masks;
 }
-#else /* CONFIG_SMP */
-struct cpumask *group_cpus_evenly(unsigned int numgrps, unsigned int *nummasks)
-{
-	struct cpumask *masks;
-
-	if (numgrps == 0)
-		return NULL;
-
-	masks = kzalloc_objs(*masks, numgrps);
-	if (!masks)
-		return NULL;
-
-	/* assign all CPUs(cpu 0) to the 1st group only */
-	cpumask_copy(&masks[0], cpu_possible_mask);
-	*nummasks = 1;
-	return masks;
-}
-#endif /* CONFIG_SMP */
 EXPORT_SYMBOL_GPL(group_cpus_evenly);
-- 
2.51.0


