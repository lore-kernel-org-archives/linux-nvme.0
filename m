Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD58FECD6EE
	for <linux-nvme@archiver.kernel.org>; Wed, 11 Feb 2026 20:45:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=snIUTRbR+YxJWDAGVGRmIywY12Y78QsMSysvwfq5n90=; b=05ga0Wy20oP3bUv8ZzzkZVc0dl
	i1bbbi2EYItoMbU+x/7sJDLyBaZzYjAcRKqS+xihDba0lCIYuKkDXlipHFnNTE318Bc4JKIbcfK5b
	zp7e1vH5NrvJkrBd3US9pWFDEnXyzBEgS6mi6uqapGyEzsIuxc4vKGmtzVcFt5KsUwP/xggduFD/B
	qC7SdI2nWoVdKEMzq3wzrGigKP6Xo2Yha5PaqbrFciESE/HGjb0yIiUSF+me8gWQjuyYnlGL5aXvw
	utSVmwx0QfurVYPnmgJFqsmRtXO8Ixy5FBjj0hyyL845OHDFeCyvWVIzyYdLNx1ysQ54kN4Q+WlTz
	aYPAFPMw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vqH5L-000000011ys-0KPo;
	Wed, 11 Feb 2026 20:45:19 +0000
Received: from mail-centralusazon11011021.outbound.protection.outlook.com ([52.101.62.21] helo=DM5PR21CU001.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vqH5I-000000011yU-3aWa
	for linux-nvme@lists.infradead.org;
	Wed, 11 Feb 2026 20:45:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UMRN1QANifaKWLBOi4Q2T0yVvzVgoaZjLQ4yV+5yQMTDTw3F7BqX8gaq81HOdD7TLbfniQg6ywCd+KRA/641pFhQSdzshUCtUi2u4pNugRJ1+SztQxbkxD1wrX5Qsk9MF3PnrSsAB5D622TxYjD3UWKN7Cw4SxrS9xP6Za5h5BrWM6E3fcwrk5Eo25p2C63H/HRWzr63/RQV2uDeR1aa0LSZoyoqnJw/qOa+v8pojlaiv9BkAmw7blh8Bdm+vP3Xaf4paetMHDbq/uYEpePchsz+NfY8nnIu8zb0EXz25N7E0ZDXy7Zg9Ma3r55hkaKrlvMHkRTP0ZjMez9kWSDuhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=snIUTRbR+YxJWDAGVGRmIywY12Y78QsMSysvwfq5n90=;
 b=KbhDU4GtcwpFtU+eNDnds7jDWthRnz3O4rhYIv5CByW1/KbZF2ULTAwjAY+7fqi0idoHKTNEjaL2SjIYXowi6bGYMciN2b1uW0WLoF5/TkF/orVS5KRUCFaiC5T/XPW6E5Eygwr1zZUuX/1jg/xVSrrY5iJwTs6vcJQSGhrgngufqVbzCXmqcIpLnmPG5rgyXFK6LzHN+R0oAs1xzfpXY1t/Rr6wnf+S2997TVrW1noKUh/jyJj81yrWoozPx1z10WY/+zgZWTpcGLGnx2YwjnFbVPpVuHro2pGNOyYfplL875V4QDDFVZNcsuhffAjxIISRHwlTGMptd+5neSHYug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=huawei.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=snIUTRbR+YxJWDAGVGRmIywY12Y78QsMSysvwfq5n90=;
 b=mmjl25ntfEBhoyn/U+D4OS3ixxPjvJ7SLHOKFDYP48bonDqC9AwBLYtgKmMRnNdTPcG4fVm+GX8vsthCcTqSr2ygueQXdRXm/YNTHBB0AIB4Jkv3pbXPzZQh+D+V3uHyVGL+bDSmuO5OnSo63ocZN6LwEe6C14zG52n/s7TzkAVDoBxSu5Q18sjBD6pPX+0O/qw8XZLhK0R+usLmRHElN2EsWDTBHYCzGVCD/LTbq6QDOwc9zYwAkO7J2ht8PQ+fINIOlb6NQMbvdl+98K89r++0vQN3QQ3pA95INYxav/CyreCPPkJnKuY+oWaZGR3PDJyylYhLv9R+LLvBwSnPQw==
Received: from SA0PR11CA0001.namprd11.prod.outlook.com (2603:10b6:806:d3::6)
 by DS0PR12MB7748.namprd12.prod.outlook.com (2603:10b6:8:130::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.10; Wed, 11 Feb
 2026 20:45:11 +0000
Received: from SN1PEPF0002636E.namprd02.prod.outlook.com
 (2603:10b6:806:d3:cafe::ed) by SA0PR11CA0001.outlook.office365.com
 (2603:10b6:806:d3::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9611.8 via Frontend Transport; Wed,
 11 Feb 2026 20:45:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SN1PEPF0002636E.mail.protection.outlook.com (10.167.241.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9611.8 via Frontend Transport; Wed, 11 Feb 2026 20:45:10 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 11 Feb
 2026 12:44:46 -0800
Received: from dev.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 11 Feb
 2026 12:44:45 -0800
From: Chaitanya Kulkarni <kch@nvidia.com>
To: <linan122@huawei.com>, <song@kernel.org>, <yukuai@fnnas.com>,
	<hch@lst.de>, <sagi@grimberg.me>, <axboe@kernel.dk>
CC: <linux-raid@vger.kernel.org>, <linux-nvme@lists.infradead.org>,
	<linux-block@vger.kernel.org>, Chaitanya Kulkarni <kch@nvidia.com>
Subject: [PATCH V4 0/3] block: ignore discard return value
Date: Wed, 11 Feb 2026 12:44:35 -0800
Message-ID: <20260211204438.22568-1-kch@nvidia.com>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636E:EE_|DS0PR12MB7748:EE_
X-MS-Office365-Filtering-Correlation-Id: da968ac7-a348-4a9e-4551-08de69ae72c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?YqESegGEQmI9MbZcXCN6ANXAoJnypRlKZDN1qT/uyI0BWcapPvDAzmsvDOjs?=
 =?us-ascii?Q?GiybQ6/PNY4nGCS3t9IvjUsHD/o2wza4aPZ9uUi5kRUKvp2G1QwLFEYDf6Vi?=
 =?us-ascii?Q?+9jkgnkEbkmRRBLSo5I8yOA3HK5RzGvjj32y4IKPUIzEEyH8+aqrimJj4MJj?=
 =?us-ascii?Q?DgPh+KuynXAqdgJ/cnfHqjrUqk2Xr2wqRJpELxMbT3fVyWuwzo5/p8rtkkiI?=
 =?us-ascii?Q?UTxb58tZjNduMHaFNAcuotjrBUysFsmM1oVVeglOoKxu8xMHlFQS4kRjkMUp?=
 =?us-ascii?Q?slPwlm5a2YClIxllFKySxwekEbR8nXKewJivYTN/Mth7xXMsW0oePI72O5ZH?=
 =?us-ascii?Q?hsOOPV+vfkqCD5dAoTFkXDTA5GKElm9bgLQHKUUpmfRulZYtTVOqYwmrWbmV?=
 =?us-ascii?Q?TlEEYtO7IFmZ9UF228QDUqSE4UjeybGllStggCXvvWhXQeGOyr8qVksp4E9r?=
 =?us-ascii?Q?vrfkkOAoQDyXqh6o6Qm9loOwwzpbEEbdz3w65cWRwEoD3X6KWPYqo//qxxPq?=
 =?us-ascii?Q?PmKxBk2PvRCfb/vawae7KhxKRbo/uIemBQVCtk4F/L51pEZ8VS+IC2ZixSO3?=
 =?us-ascii?Q?fMY9EeiybZIZGu28gIGc1f8RH8o7xrGxnDNrr9I1awEYoJDKH26+kW6Zn+J4?=
 =?us-ascii?Q?MmjogEQ2eelXhKQt6qRVjEY5OVIW15Q0e5YNVMgl0+KOS5vfU9ZA1hIH3BVl?=
 =?us-ascii?Q?t/2gTGLU33/xaj8kLtP7sMsMCjhXcKDuC8sEU7VL65XkMcVdH7mbJZDjlRuH?=
 =?us-ascii?Q?Z+eN8SomgZnpaAs9e4rv1aN23A8h59Eux8kVqtC3EKPfF+0S6ma3Q2WfnkML?=
 =?us-ascii?Q?ibWWEq6hkU9QngMifXEAsQfVIFWf1TE5O1OdBgIVSrRpOR/Sl1nX1U7CSLRC?=
 =?us-ascii?Q?Qq1eyhnvQJPZ2QXmQklz0b7/YfpTPSHvQ5/ZUkX38OHH9RFwOqAcHk5NLScV?=
 =?us-ascii?Q?RQj1yEnLwQvodKmgbN/MCC6yBtiXhaHZ9xx9gulGy9YhSKtBAYXL4CNQQwKW?=
 =?us-ascii?Q?OfWxpBgO7dJ9qPVnskywrGiqKc/kVr3e1quGjF/5AP9lwGxG2lzDru6AykKO?=
 =?us-ascii?Q?7AhVwNo/wW19WndWiMWz9Z3Oyg3Bl9SoQJV7NJWy+dxpfBlnA63eeHZRuKEk?=
 =?us-ascii?Q?PC3m7Iclx8dArBpDH0skToUac+OLYcttX9Co2yFvaaf/aiQ3FHScr0iJ/jTO?=
 =?us-ascii?Q?xSgzzQrzEjAp8ksyoE2Bns2NXsKOWC+THHX+QvUJiBdJQuCYHv0ZjcEUXUB3?=
 =?us-ascii?Q?yiDuKwm8Pn/oVY0z+BgP6w9yDqMKj5g6l2XVZDiAEZJeT0t/dOTcQwUKxg9N?=
 =?us-ascii?Q?Nv2yT5dM2hMOcj1NpFPuaPWbRMAfO/r78S+tcSIOlmClqRzyxCJefnOZzLp7?=
 =?us-ascii?Q?5RKcstIBbjID+SKh7ehPGTtrvzjkPlOjrJRJ7ewt2Zg2NLOe8sIGzRv4BHmi?=
 =?us-ascii?Q?AHeXdfredaE/XXku/gkGZFwf2YwjHW7igoCuo/wrvVw28mUHcytKBa5xd1t3?=
 =?us-ascii?Q?lGa8MecCsbKe4R5IXVawyNFj2k2PLvt7o8Dc+evV5PjMkpHO2K3u9agPmTBb?=
 =?us-ascii?Q?veBFX5jOzBeddiItQXGT7mSwXWkH3wHKg6/FPqFahSpT3CDltUzP4/CQSiRP?=
 =?us-ascii?Q?CGiANZy71hnr5mrq4OCtiKZLSZGKW01/o2ztUUkrj+1du9PoGns+3o1UUugC?=
 =?us-ascii?Q?FjG+vw=3D=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: i6lBxEqilhwdcHh/zYPQtYZ3+EPw8nPhaB1op8sOJsvuTcNAGtWbXTzU8+BB/DFzE/Y0Jys9m/PBttYtgG9WMmPrMBHjWmWJXxoYdW8ZlO4R0r0tvnchx9miFaJ4aUQ01I6tqpmheacy9yeFnTz0DW9kVuGfZnCCNItEbeGf5lVOMLNU77g4GmhZOwxkdxgaXVn54f8G2zr2oLSkkZI4vW89pI/fJFEMTWwgtnOmqvOOxacNqI5NCiUIdEM4Olyb8KnHS43n6uC5tVV1bvzS2n7ag1meR/sTI09u1eIhOjgN1qwJS1CX9r6O4Lf4acifDm2N8+E19JYC4mrAYy+bi5+SwPV9/4+QB3M5wBXKdKv43gz1BznmeJ9aHUEVr0fFW5lIezVO7IE5WYlUyrjT7YvEHOHEm+yCXpFvJTnO1fSOCchT6UWfIBqZZE7fEgGj
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2026 20:45:10.2107
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: da968ac7-a348-4a9e-4551-08de69ae72c0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002636E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7748
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260211_124516_920351_CB326168 
X-CRM114-Status: GOOD (  10.82  )
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

Hi,

This version has remaining patches from the original series to change
__blkdev_issue_discard() return type from int to void.

First two patches make md and nvmet drivers ignore the return value of
__blkdev_issue_discard() call and last patch changes the actual function
return type from int to void.

-ck

V3->V4:-

* Rebase md and nvmet patch on latest linux-block/for-next
* Add a last patch to change the return type of
  __blkdev_issue_discard() from int to void now that all call sites
  are fixed.

Chaitanya Kulkarni (3):
  md: ignore discard return value
  nvmet: ignore discard return value
  block: change return type to void

 block/blk-lib.c                   |  3 +--
 drivers/md/md.c                   |  4 ++--
 drivers/nvme/target/io-cmd-bdev.c | 28 +++++++---------------------
 include/linux/blkdev.h            |  2 +-
 4 files changed, 11 insertions(+), 26 deletions(-)

-- 
2.39.5


