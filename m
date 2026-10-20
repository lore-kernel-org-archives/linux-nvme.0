Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E81FC606A31B
	for <linux-nvme@archiver.kernel.org>; Tue, 20 Oct 2026 17:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=4HYIsR7F;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=pUSacKQi
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=zIyyElv2m6umGHiKh/H31yhFq3QG1yIED142cg/Cxsk=; b=4HYIsR7FyPz0wHBUHgZiC1N48d
	qmUQsTxwl08KxSSWOIs9dljgkO1A+8Iz4s/dm3tLKfUWvjyeop+U9hG6sVp725X2+0tjcNkbidFPQ
	k7I24mPtxkP0L52CaOLVC+yxCDJNl7lHgA8MB43JskrNFK90b1GrmvgSXgpPNUJ582gm1nVG16XOj
	yBek+Jyt1Il8+sxI1fuTPP6brCnwQHjGklqAtlC6qI+kh4CO1vI+C2byegkIBUt7EdkxKuibHQp4n
	ErXFmkvs8NkO7PZ+SepKD4y/6BrUoRQl58duHUvKPb0QsS0A/vvXkJBI1djUL34Vwx5aThq0huf35
	hlcv0lSA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xJDtq-0000000ANRk-3Bq9;
	Tue, 20 Oct 2026 17:45:22 +0000
Received: from mail-eastusazon11011045.outbound.protection.outlook.com ([52.101.52.45] helo=BL2PR02CU003.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xJDtk-0000000ANRG-1QOv
	for linux-nvme@lists.infradead.org;
	Tue, 20 Oct 2026 17:45:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jUmZ0pFwzF3+0PO65Z7sDjq/EFjW134NiHg7PO+zE3HpliGgwjPBiQHCbZ0AF7fltTGFoqOKZIvnuwYpO/rNEu3CQhf6MXipUuXEqCcMUxW2l1pA8d2nwGMhZzHOnH/bevfLbEklijBz5LenG+oej5x6VmO+Jzw/Zo6V5wOBQRZ+B28xdeLOMQwydYl+5ITTefqZrKVAkTFehhVDu9JhOean0igVRhYuwxz71K5JFQsLt4R8fFJLslAd5rI6Su8HqaLQ2N+3DYkhC6+g+DaHIEBvlQhUqU+OfEFXR+mjIGpBMSzzcAVNxqeZjzPD7Niru3FXkKNOEsjJ/XR2h74r5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zIyyElv2m6umGHiKh/H31yhFq3QG1yIED142cg/Cxsk=;
 b=owCu8kBihfg1zswOL10brtXTp8sgsEE6jjpd8vpZejuvO5I4NjKTyV4mWHPqaXNd6jVkXQQhHuTqX2/iUUcqcpkcCXLA+SX3b1ZpTkPrE1j4M9tT1/HU4NEDziDsIWmgfUfrZhPw1i8IQgZV+AeeYq+OJ4UlzjQjooioP2gJab31wyw5DfwQF0mf6CIp8dgoLzUtPdCSzHakZEGMGKL3fc0vyKSClY6Q9W3dis+8qw4NXjgNOG5Vo7MJ5X4y5VPqr6nRgVFyMwAy8WRadwh/dvfXOt454pPf/con3nR0Gz5Vg2VZKi51a9Ddn9ObJBEsq6LY559OmxTUNckGjKAfZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.dk smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zIyyElv2m6umGHiKh/H31yhFq3QG1yIED142cg/Cxsk=;
 b=pUSacKQicSsVX00B4zwr9b3T0bSEWON2PTQeUi3HPCziYjF2WSsYEk7aIj2A+Bmhwiz1RGRYWOfpmnoUwEM1uVJCKjlcjj7fjE+tRJivZzRcFS88UTJod9zuFsPf7Jc2dLjWvdPmbDKB9UHD18luc7zGfJXcPybmNxZ6VvveKNPxnacd5BsYRtqAOPv2kLfPbHKKzSJvcQLLzKqoX8Fm8mVRggUDdmS6p8JKdhEFsikhCBA5N0ua9yd+IjHabdQ6rjo03AmGQtSca3uk+gzs/1yVezl8MrNZBdZUzFIWYn38zRpsJ3nGg9cC3ReX+dJna2Atj4CSssE1Xnvcf3qD4A==
Received: from MW4PR04CA0094.namprd04.prod.outlook.com (2603:10b6:303:83::9)
 by DS4PR12MB634945.namprd12.prod.outlook.com (2603:10b6:8:514::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Tue, 20 Oct
 2026 17:45:08 +0000
Received: from SJ1PEPF000026C8.namprd04.prod.outlook.com
 (2603:10b6:303:83:cafe::49) by MW4PR04CA0094.outlook.office365.com
 (2603:10b6:303:83::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.20 via Frontend Transport; Tue,
 20 Oct 2026 17:45:08 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.161) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ1PEPF000026C8.mail.protection.outlook.com (10.167.244.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.15 via Frontend Transport; Tue, 20 Oct 2026 17:45:07 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Tue, 20 Oct
 2026 10:44:48 -0700
Received: from 82875d6-lcedt.nvidia.com (10.126.231.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 20 Oct 2026 10:44:47 -0700
From: Nirmoy Das <nirmoyd@nvidia.com>
To: <axboe@kernel.dk>
CC: <lev@zadarastorage.com>, <kbusch@kernel.org>, <tom.leiming@gmail.com>,
	<yukuai@fygo.io>, <linux-block@vger.kernel.org>,
	<linux-nvme@lists.infradead.org>, <regressions@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, Nirmoy Das <nirmoyd@nvidia.com>,
	<stable@vger.kernel.org>
Subject: [PATCH] blk-mq: restore shared-tag flag after hctx reallocation
Date: Tue, 20 Oct 2026 10:44:35 -0700
Message-ID: <20261020174435.1527425-1-nirmoyd@nvidia.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026C8:EE_|DS4PR12MB634945:EE_
X-MS-Office365-Filtering-Correlation-Id: d31cb993-3425-4f5e-5f14-08df2ed1e1c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|1800799024|376014|7416014|36860700016|82310400026|56012099006|11063799006|5023799004|261009223027099003|10067099003|18002099003|13003099007;
X-Microsoft-Antispam-Message-Info: sjX8fQnp2BP0E5HZO06op/wWSWkSm/1wADnhctop+lBmB2Zk+ceZCc/g1NlTmtQQW4FI/o1iaI+M9WEt2hCeN+FvnW0PChFLOFx3OF5tnWIT5U/yphAx+7x1olYenemFU/1Ww56VDioA20DKXcyC+4I/txOCQxyaVsKvMVPERMLXXnusn/y+ZfZ6eDaynx0m3yhls1C6h52vmPWdzb6VsZAVU+UnJITzPRUdBTIKIbQSPiX/IJvWruySfEccJW0O4OZymcb/SOEnzUQ0rBK3o0oqjdvHaqsmMucnId/emWRpEkhYpxEXLkanL8749BAOr6BVIOhDe53sGxSOkeZ48jq735rUw9ocraU+WPEcY5CJSjzcPBaEL2HgvEU6C0HrQPTYZ3oi4b6e0wdkjuNKHzWVmALev/WNW6bNa00YgdIJhlWdsRslvjyodYYQ9M7nUQ4YT7W0wGkripi8/qLIaB+QBBvMROrQbOkddudPkZkGZSdcCoK0uota5wSbLtVto2z/DNfIUVVcu74N4k8ucjQm+P7iNaHZtmHVTr16tmkGj0DACKujI85hBqrJLYb9w1JYXuyzPkCXqpUifJVNOfp7f95rzlMu8jl9MjSnZ6B39zvlQd6csyWwpPGAuz471CctCyZEIsL6TgAXXRz/w17518d0ichBCpIfnaWgwTkPQlJ1Y/GJuHJnk92vNcv7+CnuTR3I8a5d6WwwtX8xEw==
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(7416014)(36860700016)(82310400026)(56012099006)(11063799006)(5023799004)(261009223027099003)(10067099003)(18002099003)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: dN56mt7Mp3c/1QCro8uxvKzE3BMyNZS7V5YW5MH8GatyKWFh2uqJkTStDrMCVZaLKgtFYeZxUz0cIVxn6ZQVLkR+xi23MoP449Xzn/mVVtHZS0kiIbsmujbg+ew6JKuDMjzs58rWPRJcXI7LzZrlTztcMRa14esswlW6n9GtXBhY7XaNUD37RyCOnkemSgkjAAVB7SZoCaHw1JPYe3OYWNBnJ0Ch8WkULvdIUrZevtBFu13e28TIwP3SCxC0jzIFrjJbYZokAYdAhI3b9GnsfiwZ5toeVue3LWS5GOaIX8UpgCRXr6rSChGbtvIGkcKoNhl45jKHXo0jgbqJo3OfPmiALmZT0IYN4JPQCwThqSMpjMLvOWFXvk0V4Ah7mUPaIQYO9qQcphMfsUUFDw+hWa20KKrGs10qUuKIdUz3pvIDlDphhHsMNZ8eyq9xkAwC
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2026 17:45:07.9243
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d31cb993-3425-4f5e-5f14-08df2ed1e1c2
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000026C8.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB634945
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261020_104516_383167_004E3144 
X-CRM114-Status: UNSURE (   9.88  )
X-CRM114-Notice: Please train this message.
X-Spam-Score: -2.4 (--)
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-16.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	LOTS_OF_MONEY,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

__blk_mq_update_nr_hw_queues() reallocates the hctxs of queues already
on set->tag_list, so blk_mq_add_queue_tag_set() never sets
BLK_MQ_F_TAG_QUEUE_SHARED on them again. A new hctx starts without the
bit and a reused hctx keeps whatever it had when it was parked. An
NVMe/TCP controller reset goes through this path.

With the bit clear and an I/O scheduler, blk_mq_mark_tag_wait() sets
SCHED_RESTART without adding a tag waiter and relies on a completion on
the same hctx to run the queue again. If other queues on the set hold
all the driver tags, this hctx has nothing in flight. Once its
submitters block on scheduler tags, nothing runs it again and I/O
hangs.

Reapply the tag set's shared state after reallocating the hctxs, while
the queues are still frozen.

Reproduced on v7.3 in an arm64 QEMU/KVM guest with a loopback NVMe/TCP
target, four namespaces and mq-deadline. After one controller reset all
four namespaces lost TAG_QUEUE_SHARED and fio stalled. With this change
the bit survives five resets, and fio completes after a reset.

Fixes: 868f2f0b7206 ("blk-mq: dynamic h/w context count")
Reported-by: Lev <lev@zadarastorage.com>
Closes: https://lore.kernel.org/all/00cb01dd3099$c82b66c0$58823440$@zadarastorage.com/
Cc: stable@vger.kernel.org
Assisted-by: LLM Specula
Signed-off-by: Nirmoy Das <nirmoyd@nvidia.com>
---
 block/blk-mq.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 00b75eb95dd943a..ec3a7e5300d0e31 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -5188,6 +5188,7 @@ static void __blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set,
 			set->nr_hw_queues = prev_nr_hw_queues;
 			goto fallback;
 		}
+		queue_set_hctx_shared(q, set->flags & BLK_MQ_F_TAG_QUEUE_SHARED);
 		blk_mq_map_swqueue(q);
 	}
 switch_back:
-- 
2.43.0


