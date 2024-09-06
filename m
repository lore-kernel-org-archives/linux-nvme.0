Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58B73CE7AB9
	for <linux-nvme@archiver.kernel.org>; Fri,  6 Sep 2024 07:08:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-Type:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=bpQkxYeI3aIk/Cv+MiYgwmZtgtmoWCs/h3Am81fQv7k=; b=0vyxmGodWV8NBXMSUXTdolM1Ls
	41rq2IiOlNkIXBlVrMo8VPc1iCcqxaZSQbaFDCbBhdmyAsndNkF2y3jT6IAr33kKOSar0/kEcfur8
	UbvXA5+4FkVVnpWU0YmOKGhp/3ngqYMXqsx07U29JikcLEQy9YqIZCkoEcQarNwOjXr86OpO4n22R
	2IFsKTMieonxAzLRx4l3BC5ZaNWbwTq/tUQ0ZBkI3Mq1AlbARssn5V78hyY6VnRR6jWhk7IexZXoC
	ehRHXQZqTxMV/FhcVQ9xQYM99gFKhEgN8nAk/YwtrA+F1FnArehyx+gccYJRC5mcQjAjE5Gf3SQoZ
	2sSUL5VQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1smT5H-0000000B1Rc-0eBL;
	Fri, 06 Sep 2024 07:08:43 +0000
Received: from mail-sgaapc01on20619.outbound.protection.outlook.com ([2a01:111:f400:feab::619] helo=APC01-SG2-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1smSvc-0000000AyZ2-3OWU
	for linux-nvme@lists.infradead.org;
	Fri, 06 Sep 2024 06:58:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tiBjVnkRcRSQwUhttw90zfTeelG2B3doehQffPRJmfp6pSx4PFUiil0GeeJcCupIjEWY/kDbbWxVJ/Szl7xw4QPqR8s5ji8zxW50JMT60NRVGxAeG6cQV9FgqaAP3jkc/kWVUZG6NVXKUHonrHBtDTJY+23VknBmwQCe3M60w80il+KC6qPxP9TvVOtKdxZn4tF2ySfHZ5KFJUiZepiV+ZIiXm0jkAda6lAZfc8zTBNI9jqcGz+zbcaenUt2mgzN9lDna45x7u+rtz41nVMSWGrEmIMMkPcjhdQbWamZdWTbQymRly7to/VPwF5xKao/c3wQ0qIRekVbzDz5H+NlvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bpQkxYeI3aIk/Cv+MiYgwmZtgtmoWCs/h3Am81fQv7k=;
 b=Pml18OqRAlFlqQQyhr2t1LcX+b0jNfUOjqoH6KwHK++VeB2J6mYNIYS2jev0jgLCspEMpGf/HFJvsQfJLKqoLxqn/Zu/SjuC4TdCxXDceKyyJB9SIIxKguolp24O0+nAukvJjktdv1ErgPKYKbKhdKpiFiwZPZIfGvfZZmUfAnmV3aAP58nt0fnxDDYRbY+VvTHrOnpZldPWhueNEwXBY02comSIEgth63YyiS/BkTmYqQLi/Vvz4gzLg1wgLTv4ZElWhqOwIj3ZLnwImr/KoWSiu2NBXWP977WGnwdkD3FZhimVqF5YnAXFjXz/j8DFONfUemv4xWMkZXYN6JIfiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bpQkxYeI3aIk/Cv+MiYgwmZtgtmoWCs/h3Am81fQv7k=;
 b=JzfLlxlAfkTLTxCQKpDGajhntsJ8pW2rDr/h0bEPvJHIqEL30dv3Z+5lZfZhHMFCFlJktwezdSr8o5p+leETv3Uxr8UM/qdE3su4aQlb2y/7IsB7Df20EtlS3bvzTn6WPhDCiMigQ8SyPdEZlozUrZFJOug/7jx3N5XdeHsNAyY0FmstH5K0WfKsKzO22u/pLTRPNEJqH2ill14viajuK0FBiow7hiF2yfLgaxzlqmTZBUJAu+zA2SLeG5h64+kEDycT5RfT7E5IA9eA+TIa9KkVKXSbmicGeJYlP5Lko9q3rpbwdxDddlD2hL/uDVfQ5pNGG/Xb5BwPSLjqFqxJtw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5899.apcprd06.prod.outlook.com (2603:1096:101:e3::16)
 by TYSPR06MB7247.apcprd06.prod.outlook.com (2603:1096:405:84::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.28; Fri, 6 Sep
 2024 06:58:26 +0000
Received: from SEZPR06MB5899.apcprd06.prod.outlook.com
 ([fe80::8bfc:f1ee:8923:77ce]) by SEZPR06MB5899.apcprd06.prod.outlook.com
 ([fe80::8bfc:f1ee:8923:77ce%3]) with mapi id 15.20.7918.024; Fri, 6 Sep 2024
 06:58:26 +0000
From: Shen Lichuan <shenlichuan@vivo.com>
To: kbusch@kernel.org,
	axboe@kernel.dk,
	hch@lst.de,
	sagi@grimberg.me
Cc: linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	opensource.kernel@vivo.com,
	Shen Lichuan <shenlichuan@vivo.com>
Subject: [PATCH v1] nvme: Convert comma to semicolon
Date: Fri,  6 Sep 2024 14:58:15 +0800
Message-Id: <20240906065815.40300-1-shenlichuan@vivo.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0045.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::19) To SEZPR06MB5899.apcprd06.prod.outlook.com
 (2603:1096:101:e3::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5899:EE_|TYSPR06MB7247:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f4d664e-1b99-4f6f-e9f2-08dcce414e7a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Po51MyowS5U1xW3xCu5Sl+43VCDoLtYpkDdUQgHzUBCLSsR+tQy6JrCZoyVw?=
 =?us-ascii?Q?JeQ7b+4ucYV63Bj+LxiSaip9q9ZYUBSSoFxuki1FfO/C+BYRA3dzngTq2GwP?=
 =?us-ascii?Q?uMq5LkW9d4Ok1hUz/PZ+aJQJgBP/g+nxE92ZsL+WkqCZRwYr6Qkmp5Ro9j3D?=
 =?us-ascii?Q?EBELGeU0Wr5qzp2bH3bImBE2e/nCfb6GzCjcQcLurZWQmIM+dJWSHI5gCB5p?=
 =?us-ascii?Q?YUatlV5VVr9kFo9eQqt6Mw68euml7E0WYghrGFcfnR/B83wk2BqyK48mLFi6?=
 =?us-ascii?Q?Lnwi7GFRTPLvNH9SJCTEWN+MHqEEwsILTzJKX2vMfET5D25hkdwRmsRiVTzb?=
 =?us-ascii?Q?/YS2KXnPqo7iko5jok1l9WWOpp2bak8GmKwUF93HxNyuVc43Xtn2vxTT2Dld?=
 =?us-ascii?Q?1lrNfyvgfm5Rj1EwNLDx/ES6BD5xjeGOYI/hPW6jizXImDp8cpdGoIoZQw8S?=
 =?us-ascii?Q?P+spYi/n0vVjozFO17BZmr62zIzQdJbFSM6q0bPztpvsBJh8DNtdcwp7wuOu?=
 =?us-ascii?Q?FuzVcyq6pkMmUCTXVxJbd2Hp7HgaGZJcZ3VCZ8BIP9sj6CewmzPhlsnYJpru?=
 =?us-ascii?Q?ZN5XQ7uB0t2xgukRBiMEBAfpgEHRKBDxS5ux8RrWEYRtl6DIcSNo5zilweEN?=
 =?us-ascii?Q?+lJr5CgbRsJS2nUX9h6au/LoYl7Uwhjt6op9PN1XctFBBjT0KlrI649eErnt?=
 =?us-ascii?Q?YybKL+EhJwAmYUi8ngSmnFFdVws5rCwwUYgnT4Wou/Hbiuoc5uCU/wV36m5T?=
 =?us-ascii?Q?lO4gdmeL1um6VYkl8IKYRGRKjHqwutTkEMios8RxA3J5t0XD9tkySnhl5nFi?=
 =?us-ascii?Q?KUarmTynVyFqqh5s6UptZDHFR4x/WuFGiFWC+1qZZNnTZfypDJukHixwGaMu?=
 =?us-ascii?Q?6zd99kLHb8YGZixFxvfhQFChM2X+oUpOiFKZNnE126UljtFSIvLw5bGZU3q6?=
 =?us-ascii?Q?JVnkVERcmBJM0T9aO1+Z1gyxhRqF0LyNMrc5MeA2v3JAf/m9uxNPxnIYmkEM?=
 =?us-ascii?Q?brXUFTq/JFhhk7/e6zmxCm9Ty9wAI4IQSy9KSWG8wUd9mdaqMDK/B0vewZtG?=
 =?us-ascii?Q?HfOIKorWtwizWk8ZVluxnceZEVvTGlE8VDweMu2qtMnSrwg3WYgHGbV2COIG?=
 =?us-ascii?Q?psDywa2swMpeNhLL0clw9n+2ECj+y5MjWq/vtFx+NJsvMKBjhzBcjima06zh?=
 =?us-ascii?Q?ihWMf3Owr9fJoSHP46h4CEp8HF0JSqjN0jblWE7GR+WSsqLyNeATdepKqP+L?=
 =?us-ascii?Q?x4WoIFK6Xr02s+2BQYESm8jMOC8TqwGqX5nBdq52P9OmYAE6R7W7qXduHAgt?=
 =?us-ascii?Q?U6oyYRRxhb0ipsJbblCKv+CX7IoxAZ1zlj46k8HGZm6Rs+S4hLl7LFPPfd9M?=
 =?us-ascii?Q?M8AZswK3E6nT1wGZ9zi7Z2wiFipH59QBrKG/JVdgkqQPqUm5Yg=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5899.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bds+B6HyG7Dj06dKwGrW+/MelmmZ0IeIshqZ6meGdkoHO3JmJtkauQEe11Zi?=
 =?us-ascii?Q?o41J4cbpgpTfTKb88wMHa73G55HbCj799qLDuR6Wlv6dcRRJVyYj38ilX9rV?=
 =?us-ascii?Q?C7k5arAiSx/tGfNpmLwx72Fc9QLRdO7LMcD8dkd13IwVkRouk6RE/xO04c47?=
 =?us-ascii?Q?6Bd1mefRrS0aAyI/WZmeFZWrvZlXecexqXF93DXFSZJo6bDfvgStkmdbExv6?=
 =?us-ascii?Q?avkcO7xJWUxKFPW8QCCMg8ghq3V0HN6aKXG+LC7NCKrqVTM+ueWV91O+ALIR?=
 =?us-ascii?Q?pAzri+X2AwZ3ijkepYyKVCSvlgsC5RHalJdcfTFahTnfPec9RuyBQcnz2oVU?=
 =?us-ascii?Q?XEb64hO0Ti06V9f1P5XUuSHV1Yh5dwxYDCVRsxv+mZeO4aXzOmXg9hkEir7C?=
 =?us-ascii?Q?nkdgxkn6mja+oSdJNFuQHwh0iGsPyc7rQMBbi4T3k5peHVeySiAhc6pHIcdT?=
 =?us-ascii?Q?xNt2QefMUkFJK7j7tlqtuSVc3oiVhKhQOxjjAT5WmsUP2sxBkEiUf9J1jqqW?=
 =?us-ascii?Q?koPsbluMzKnVy25W7ITG3Nw+dkuWarMLzjo84bO77AAAnmhlOCoVM914X5f+?=
 =?us-ascii?Q?ur5cplj9+KZYyM6tI/zhGoNf+R3rINeblTHbkgR2ezk6Xhz3B9bjynLyoQ0w?=
 =?us-ascii?Q?Rt6EIgaqbO4IHwd6fEVL3gZd+YHyj8WdUjhVc5lHscYxTIxrxtqI+QEPyYOS?=
 =?us-ascii?Q?YlAHV26FvH06zdJ3C7ZFxfGKeyyPLi4y/NVi437GDEj59bsuDvSzRZwGGcAQ?=
 =?us-ascii?Q?Rz03rCxCdQOv0yO8UZV/iUUG01lxSapApPu6E+7DPiKEW8S0Tl5BnDOWOWHn?=
 =?us-ascii?Q?7RRFzDX64cFgqUSSVJO2bwQxMKaJ8Koswb/r84Okm7dy6pUYQd3IXcS2bbeg?=
 =?us-ascii?Q?3z2Liao8wvCdJNjYzFvrhhr2+BZ+iTmDrxXGi+fn/MjYZpZSqG9kCB/ztjTN?=
 =?us-ascii?Q?QadXU1Dx1RHnUzeeLltDCF977hkR3wCbAdinbc+vdrlYsG5J0JLoyOPu7z+G?=
 =?us-ascii?Q?9wvyIET3i6DFlJdgdj/BB/Me5fOvPICWuTpovKqqWkUgwRgm8ben1yLWYxp1?=
 =?us-ascii?Q?w528dtd7JarCpevjHH4e+wnRGkspTjTtGKitF1/VKk1r88BKUqddFSowfbVt?=
 =?us-ascii?Q?Kd/5UPA6Xu1K+QxR3/cB1Vgki48wR407qH+FNnvXijvJm5Af/yOoHz2q8Xwf?=
 =?us-ascii?Q?Lb/+Rsjkl4ipwYwnfbvFCpkk3AgYo5k0Pn8s8owt/2apA5VHtO+arvP4/Mop?=
 =?us-ascii?Q?UQI5KMkpX4/rw1fnQqhg8zlCAR++MHMxWj2z5WizLO7KVS/FSZjQTHHtdW4Z?=
 =?us-ascii?Q?L/7FloCxlfC3yudGb6JkoqirY5dgQFNzon0CBDAwuA2uzB+MQfIMuZib9Gqf?=
 =?us-ascii?Q?Q280NDB5/JuUcRDUnj9yTThwYTtBPWZAjZ5J+PRjUF9WK5+GDSo7rtA4wtKn?=
 =?us-ascii?Q?WPaKIK4qM/y+HoxrNetUHvqoBNh5OeSjMYah9768DFAQ9RsyZnOjqH28R/cf?=
 =?us-ascii?Q?NvM4pTYVUmRkf3BLgOzQei9ZqT3u2NgxCJhOl6a5oHpma1MtM2OiUTviCND2?=
 =?us-ascii?Q?XY2qmccKO3HwAYsrbNiCKlpdxEG/egt4F5fpeftw?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f4d664e-1b99-4f6f-e9f2-08dcce414e7a
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5899.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2024 06:58:26.6995
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x+ld82YJFxl5ZFo3npgFSngeqJjrlV1VhRPflGMFvJmmrxjXj/V+xFjSMC4w76aywhWZkqls4rWWAXEBGZZUuA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR06MB7247
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240905_235844_874172_72804336 
X-CRM114-Status: UNSURE (   9.35  )
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

To ensure code clarity and prevent potential errors, it's advisable 
to employ the ';' as a statement separator, except when ',' are 
intentionally used for specific purposes.

Signed-off-by: Shen Lichuan <shenlichuan@vivo.com>
---
 drivers/nvme/host/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 0dc8bcc664f2..473149ac41c1 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -4567,7 +4567,7 @@ int nvme_alloc_io_tag_set(struct nvme_ctrl *ctrl, struct blk_mq_tag_set *set,
 	set->flags = BLK_MQ_F_SHOULD_MERGE;
 	if (ctrl->ops->flags & NVME_F_BLOCKING)
 		set->flags |= BLK_MQ_F_BLOCKING;
-	set->cmd_size = cmd_size,
+	set->cmd_size = cmd_size;
 	set->driver_data = ctrl;
 	set->nr_hw_queues = ctrl->queue_count - 1;
 	set->timeout = NVME_IO_TIMEOUT;
-- 
2.17.1


