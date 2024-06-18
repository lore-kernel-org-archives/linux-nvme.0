Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 090A8C27C79
	for <linux-nvme@archiver.kernel.org>; Tue, 18 Jun 2024 00:25:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:CC:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6v16HIsu7G2TKXjFNWypGO5HhqXcqXt9uhuIv9dz3RY=; b=CycrOgrdpAyaG8O1F2gRRx6Uup
	wPMtnpEhWCF+jWVnRLIQXuJVoeMRpBJr5xksJhTZKi7hOR5SjnnRrx+m4t57CA7ID9KU055f7hvOX
	A10hkd6H+69JYhIhdNC3T/jQCbpggLo9eb4vBaqXP2Nki/iQd7gqzu5LLD+7bI9CjJNwWue37mLWP
	juYA8fCqBjohePq4GtXXGgphDcve/t+yIi/CvyzEbksqjVB34hWQAIGP8PgWfmcrzbTjlgtiS+k2L
	vRV8G+fT5RiXlLHOfapkCgF7mWMwyr8O/9nZb3fOX66FwYaOp38EU0m/nmJFoHOkOgNC1WqwWWw8u
	v3/d5OCg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sJMfE-0000000D36h-2jXj;
	Tue, 18 Jun 2024 00:25:32 +0000
Received: from mail-bn8nam11on20610.outbound.protection.outlook.com ([2a01:111:f403:2414::610] helo=NAM11-BN8-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sJMfB-0000000D35v-288l
	for linux-nvme@lists.infradead.org;
	Tue, 18 Jun 2024 00:25:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bdo84dFAKyGKUJc6sqXci4Ui66mENjln8uaRdkwwJO4Zmyr+4/yaXTFMensgTkAruBGgVTGYpV/Y2mzc10Nw5BDA63E7WeuHTGqSCXi8YjfHiNv+8wbWyiJcy/igJBzO9ZvbUSRtOPrIvXTcSI7XLi6MyIvIMT9BsI4USg2jA/qfItQJ0D4yArcKmdIyCvYND2UhquvQdhQvOxJeKSa8Tao47j8LFBnH9KwVU19N8a4s1XqVrzaFuprukreIMgZY2WoS0xxET2Ltdtj/V20y5ggY8vE/XpBSJWB71XUqC61FbjWy2PLRV5gU/1jJ8sL3nBXdWf5q8f65uZTRCUhurg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6v16HIsu7G2TKXjFNWypGO5HhqXcqXt9uhuIv9dz3RY=;
 b=ZAbrRqYzCeBz3vRYK/27D2/TS7YAyCF+ENaGA8/JSDYxHP1vx5ZS4lUjBzrbcvvRVwY0CEMEZ9nMltM/HCnBb2y9yYPHlRM6rz/GRwJxau0B+WrULHxFp1NRjAqiWCS9wJB6icQSzHYCkg7vT2IHV4RuzdDzp7N9+wQxhTukGlfXOxDghcwD825I+jARVv12fZoVDyr1V8KruVbaouk0bKXgylm9ZG6uL77yunwRamunnM2epsoGM5lgSBDzav41GGj/YIowb5ztvXUzUlLX4nQ4x+YuP4nKgrJDxUib5oRIhacDeYxtrc19Vqz6iOlIV0mTrvFbHqFw1dGf77d1qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=lists.infradead.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6v16HIsu7G2TKXjFNWypGO5HhqXcqXt9uhuIv9dz3RY=;
 b=lJSemR8++lMZfYWjyklZBYPLbofVjcjqpKfZwiXsyZrQWFwjHz1NsEQ7GuOb0c5Uj+EwGOS1camm9GfgNdfH2nB74zcVRwpsg1c7T80vABgvD0Y/J5H4TE94CtBt2PQ2qd5sra1mvPM/wYyOLK7W6hBAPhUTIISE0fK3Z5O0LNDws82NF+k8MWvNFMq48ZZs3Ru+Pad28yJeSisbADXIjrXl+XSpE48yZprbiXLurVZJCJN2pd/CAChgySyeYxc77CV7yPp2hd9u6spbeCgRhsJ4ETj+MwqUnteSowjiuNkFbbXq6iBe9wETMGhuIR3uoJfQVN+tQI76dSepKB01bA==
Received: from DS7PR03CA0163.namprd03.prod.outlook.com (2603:10b6:5:3b2::18)
 by SA1PR12MB7342.namprd12.prod.outlook.com (2603:10b6:806:2b3::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30; Tue, 18 Jun
 2024 00:11:09 +0000
Received: from DS2PEPF00003447.namprd04.prod.outlook.com
 (2603:10b6:5:3b2:cafe::84) by DS7PR03CA0163.outlook.office365.com
 (2603:10b6:5:3b2::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.31 via Frontend
 Transport; Tue, 18 Jun 2024 00:11:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS2PEPF00003447.mail.protection.outlook.com (10.167.17.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7677.15 via Frontend Transport; Tue, 18 Jun 2024 00:11:08 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 17 Jun
 2024 17:10:55 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 17 Jun
 2024 17:10:55 -0700
Received: from r-arch-stor03.mtr.labs.mlnx (10.127.8.14) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Mon, 17 Jun 2024 17:10:51 -0700
From: Max Gurtovoy <mgurtovoy@nvidia.com>
To: <leonro@nvidia.com>, <jgg@nvidia.com>, <linux-nvme@lists.infradead.org>,
	<linux-rdma@vger.kernel.org>, <chuck.lever@oracle.com>
CC: <oren@nvidia.com>, <israelr@nvidia.com>, <maorg@nvidia.com>,
	<yishaih@nvidia.com>, <hch@lst.de>, <bvanassche@acm.org>,
	<shiraz.saleem@intel.com>, <edumazet@google.com>, Max Gurtovoy
	<mgurtovoy@nvidia.com>
Subject: [PATCH 4/6] nvmet-rdma: remove the handling of last WQE reached event
Date: Tue, 18 Jun 2024 03:10:32 +0300
Message-ID: <20240618001034.22681-5-mgurtovoy@nvidia.com>
X-Mailer: git-send-email 2.18.1
In-Reply-To: <20240618001034.22681-1-mgurtovoy@nvidia.com>
References: <20240618001034.22681-1-mgurtovoy@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003447:EE_|SA1PR12MB7342:EE_
X-MS-Office365-Filtering-Correlation-Id: 71b52e57-e779-4407-a911-08dc8f2b278c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|376011|1800799021|82310400023|36860700010;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?6jVr5gbCP1KtLGVB5SMdhkc4gsVTYqoV5OthWDjA8kmclqqfH8bwSo4jcUrT?=
 =?us-ascii?Q?aZ+AJ8PA7t11PMsMJf4sIXOcS12xPHhwWko/8jbBMDmkSJqUV7a345az4hOr?=
 =?us-ascii?Q?5QsBHDZAQJTO+evfsbQ/W8Vaeck7mAo1Zr0fuUGg+jhh1BOsozjsmJGK3IqD?=
 =?us-ascii?Q?bX66dNpCbFlH48Ss74/l9O/zJGWKb/2AgRbbErmnjSIsVCJpH2SIboxWY4eF?=
 =?us-ascii?Q?2FU/NnbaZelOKdr/rEiJdY9eOcoHTk+RBO1qg6MVCifCD4+jr+A+406xksIE?=
 =?us-ascii?Q?xXWgLxoZzW9rtCvJLUxEEDlC+a3+ZqDYgyyqrtcizaYlXMwK17VMzmyJsss6?=
 =?us-ascii?Q?yfoAOTgoj41Fb7BZcO75q8/+iXr08+d39Wr1Tom5awwpfg6j5vMQGSQK4ZdG?=
 =?us-ascii?Q?RNhuKuoeYd3z/2gXy2Eb1nLxT16tUBiktLDLhh5H2TKC6/iWPmk3CP1wdgDC?=
 =?us-ascii?Q?O/IrpebRS12tymNdOcZ4oQvlkLDI6zbF5+fv5u9Ak7hH9/CqA7ZgKs7ugRw6?=
 =?us-ascii?Q?u0+MrJ6D3IneblWZvtNtGjfQRVQeFAVwyADJlV5o63YoW2TmuEpNz4sFsltv?=
 =?us-ascii?Q?m5BPdvBL/OB9A/VgESkoTZsby+SJRAs/N9873isJ9KGZD4SG9sdW2kJR6SLS?=
 =?us-ascii?Q?tAr9Mgoj2uZHBeslagY8VbdmjLdUHjn7EITTq15fj8zI8BHntqi72+UsE9Qp?=
 =?us-ascii?Q?BH+I1PW37UQEbZsQpptXNAVEgIwSCBMPynAGASKxjCL6z52OyYM2CrZMHjxc?=
 =?us-ascii?Q?vPZJOT/X+K66cRDTDhVBRENt45k18hHmtAn8xBURAY1fcgles8Qsr8A+okle?=
 =?us-ascii?Q?gMOYCR6MHolQiwA+NZ+SQLMcbSddV/BlnKloD8HJ3S+eBLQOQ8Jg8fELAd7S?=
 =?us-ascii?Q?6UDDWIkjfLPfOL23FFJ7h0xcEq9p/+euf64Z3Ok8eAwxd8m8HWwuv3fpVODY?=
 =?us-ascii?Q?wuskCpp47AXqGvNcfM/+JIxomLOx43nb9odl3FBu4cH9AD3N4q1cf/jw/mA7?=
 =?us-ascii?Q?GoNS3jOD+QM9nue2BN4EU/iCRbwcZAp0BuIZfiF/PsW1xdqGvHJRCK2PHfa+?=
 =?us-ascii?Q?h2U33eq4Qdq56vP9l4z76/eAkpMFGpcHP4EibRN1xhX2AJvEhJKX+eP2thQC?=
 =?us-ascii?Q?Ul0Ajgsl9dYj5vSKMTeweRbZUpDgOpwIfdc/rDlTSyXvwiKCloFMFHdIOLDr?=
 =?us-ascii?Q?dEY3vMNvS6fJ2UB/pl4MDGnVJDZZ9+NOYw6PNtfsyvimE16uk0BhdwjWMN/J?=
 =?us-ascii?Q?DzSqN2RiIX2a6+oHK/iRkfMNY0+g/Ua3m+szW/j3xyLlRYIL5iIf8m8q2i7n?=
 =?us-ascii?Q?qWxyB4A0+ap5ClbZZriygChjTQ7OArUnhcLIG7PlUjDcl71q8N2XuaXQ3Eqa?=
 =?us-ascii?Q?fFAy2KBIVGh2H8GDzmxlruGAj6BD85UeDZGbWREWhiT7JXGwGQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230037)(376011)(1800799021)(82310400023)(36860700010);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2024 00:11:08.8569
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 71b52e57-e779-4407-a911-08dc8f2b278c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003447.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7342
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240617_172529_567234_4C6FE2BB 
X-CRM114-Status: UNSURE (   8.43  )
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

This event is handled by the RDMA core layer.

Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
---
 drivers/nvme/target/rdma.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/nvme/target/rdma.c b/drivers/nvme/target/rdma.c
index 689bb5d3cfdc..29860acdb335 100644
--- a/drivers/nvme/target/rdma.c
+++ b/drivers/nvme/target/rdma.c
@@ -1520,10 +1520,6 @@ static void nvmet_rdma_qp_event(struct ib_event *event, void *priv)
 	case IB_EVENT_COMM_EST:
 		rdma_notify(queue->cm_id, event->event);
 		break;
-	case IB_EVENT_QP_LAST_WQE_REACHED:
-		pr_debug("received last WQE reached event for queue=0x%p\n",
-			 queue);
-		break;
 	default:
 		pr_err("received IB QP event: %s (%d)\n",
 		       ib_event_msg(event->event), event->event);
-- 
2.18.1


