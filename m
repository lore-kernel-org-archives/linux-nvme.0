Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CF6EC27C79
	for <linux-nvme@archiver.kernel.org>; Wed, 19 Jun 2024 17:12:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:CC:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=aPR7+A39StJcUWtUmeN+JgObLXgH7iO4sHk4T9P2e80=; b=2dZS+JUDJLjTj5Vw6Wsryv2IMr
	H3tJofZNdmqo+P0ROWQR8PuQlOJu3q4hky5Eg/fupHjtf+x8lLhAmmph06Xl/kC+OzBNcRXqn603k
	Y7nKusPgl5e7lx/euJlUA/jmq2FfJaD1cvqslUIWkLeWRxSUgwV7GI/xi8gLjv5aJQ+LRcC4VIM4L
	NQjn9p3DdVojQItRI5n+reTxSYSDyCM22YDoN0pVwdmBqM+8YQZjdTk9zsgWcGMCT9jDe1Qc7M+gZ
	+mcGg/1YfGuQ0tB8Sg3oNI14fDPCRsaSXBernTNQk82ZEElT9GfnJYDbk2CQPj/9qV0cgS67VIshE
	mnKRKYbg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sJyrT-00000002AuR-0nLv;
	Wed, 19 Jun 2024 17:12:43 +0000
Received: from mail-dm6nam10on20605.outbound.protection.outlook.com ([2a01:111:f400:7e88::605] helo=NAM10-DM6-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sJyrP-00000002Asn-26pB
	for linux-nvme@lists.infradead.org;
	Wed, 19 Jun 2024 17:12:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nTVxe96dwppU50avGqy6pG/6qmHI0fSyJxYQ2B8Cz4MgXy65oqijn0IPVFR7f4HChi/IjeydTZQ3/oTJuEVdkTrEIi9j2mu1tiZF3JH2ydnwRJ8/es4UwUUTOJPpCEMDA3RTMAQ1S1Yp4fLOczd8R8CHwfFXEGcghxDpk2F1ykPqqhSR7pjV6Tu1zO7iC+PbX6LZwf+ueOwWn0a+UIq2BWI0lTEOMSaw81FxNVZiHbef0gY/ZZSUkvUvWyuxaPMl6t4csTS65KgydVW2q+KuokFyzekDxNNaFsIu083jrltrUAanj4LT83keAp4QlP9xD6p8bkN+pnbbmOOFDxJXdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aPR7+A39StJcUWtUmeN+JgObLXgH7iO4sHk4T9P2e80=;
 b=I7pZpoajoNwH5x4+E9tRQZ7loFoJLGxysxAeuy2LRhFs8a9wc1lNXwFUTqzNRPHtorCVcq70Ykfs2cLqmKkanDZ5DYeM6aQ09mwM6U4I2ZWQfa1h9fusghak+AvZ+igqwtEpx+m4EhMzKWsP2pRmjw0ceJjM122aa3zXLj8/vpYMbxdYuzWYh0GHkwitSfj8pYHH0N6qYizjVHrvRv+zLEut3D4Axp7ViwgkzP1HaTjefmuTZnCyacZR94lbUYid719enBsBR8/06uqiT0SGGjgJYYaCf21xgXfCAvIF3dt0pfX2JbFwLGDsRueRGFVMkddGEJ0RbAONL9pWSkhucw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=lists.infradead.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aPR7+A39StJcUWtUmeN+JgObLXgH7iO4sHk4T9P2e80=;
 b=KJqy6lEKIKjCglNgRwSV0Iz03HnjJQ2vAC44Mi2ozQhbq6aTHq/DKZsDuv/FJhqvkSMw/C447zI38P97kaUgUKf8Yd+InEznGIFRjawkIm7woBB6tnUmtnqEzX5E+S2Hhugo7PWUqRBx59guc0DkFEsjxkodvxHANdIOjXKUQ5XkQBVk6kREmQebmipUkFVXI1aZYAq7u4VYUrPpFuFY27zat8JSY1gl6SrBwit3BonJHkATGBcgXdm56trv79ZjYD1sIYeZdXi7duxy+Hcu6x+o0jad8wqzJyu8sSkKQr6snZfvcfZid4CfsDB6/v048lPXv+JwJRwpfX+Ht+wJtg==
Received: from BLAPR03CA0171.namprd03.prod.outlook.com (2603:10b6:208:32f::31)
 by DS7PR12MB6333.namprd12.prod.outlook.com (2603:10b6:8:96::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.19; Wed, 19 Jun
 2024 17:12:29 +0000
Received: from BL6PEPF0001AB4D.namprd04.prod.outlook.com
 (2603:10b6:208:32f:cafe::ea) by BLAPR03CA0171.outlook.office365.com
 (2603:10b6:208:32f::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.33 via Frontend
 Transport; Wed, 19 Jun 2024 17:12:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL6PEPF0001AB4D.mail.protection.outlook.com (10.167.242.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7677.15 via Frontend Transport; Wed, 19 Jun 2024 17:12:29 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 19 Jun
 2024 10:12:08 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 19 Jun
 2024 10:12:07 -0700
Received: from r-arch-stor03.mtr.labs.mlnx (10.127.8.14) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 19 Jun 2024 10:12:03 -0700
From: Max Gurtovoy <mgurtovoy@nvidia.com>
To: <leonro@nvidia.com>, <jgg@nvidia.com>, <linux-nvme@lists.infradead.org>,
	<linux-rdma@vger.kernel.org>, <chuck.lever@oracle.com>, <sagi@grimberg.me>
CC: <oren@nvidia.com>, <israelr@nvidia.com>, <maorg@nvidia.com>,
	<yishaih@nvidia.com>, <hch@lst.de>, <bvanassche@acm.org>,
	<shiraz.saleem@intel.com>, <edumazet@google.com>, Max Gurtovoy
	<mgurtovoy@nvidia.com>
Subject: [PATCH 2/2] IB/isert: remove the handling of last WQE reached event
Date: Wed, 19 Jun 2024 20:11:53 +0300
Message-ID: <20240619171153.34631-3-mgurtovoy@nvidia.com>
X-Mailer: git-send-email 2.18.1
In-Reply-To: <20240619171153.34631-1-mgurtovoy@nvidia.com>
References: <20240619171153.34631-1-mgurtovoy@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4D:EE_|DS7PR12MB6333:EE_
X-MS-Office365-Filtering-Correlation-Id: f1256a8f-5152-464b-0376-08dc9082fff0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|376011|36860700010|1800799021|82310400023;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?sW5lHSdPjTgApcsqucKiL5PnR6D4YG/ky+oLhkS+OWwcCIAgQfvienbuIPEQ?=
 =?us-ascii?Q?ecnRcNhPrXg8u8kxYganjH/ksF0pkSIv/vhgx1rEr3EgwTyhqQk7Y/4Cm+kx?=
 =?us-ascii?Q?1H2trLZDQYR6wEai0FtQzTcZNYR7MH05rTLP2grDG20OUBpphDG6krG2E5Ba?=
 =?us-ascii?Q?f/n62N/zQNkTWw3Jtp1w6m/7BFLMZNzJonjOO4gqhAJQLHMTP5YtsQE9U2Vw?=
 =?us-ascii?Q?lCUXkWINIcWMJFOmROVRMIdpGes0NtQaxaBOslJGPuDzlWtCmAZvz/U/MVaU?=
 =?us-ascii?Q?qqElxvqlP5F9O2S+EUkXJhv03D01pMcGTsePHZ6IrgnG7YLI6AidWzrGuX6h?=
 =?us-ascii?Q?rGL+thXW7Xs/j26ZFkR18M31Jkh4JybWBPLWhXAetYXuExWIXd2EHmlWgjNm?=
 =?us-ascii?Q?iTC2HrZUkRnMeLKZcvBJ1wHVW/WZoVj9kuKIr/wGU3m7YaplCEIKBHrAJpwN?=
 =?us-ascii?Q?U3ydQX6DnGOH/nC6QIGsJTMfDjXzZwA5Nyl/gUJgVktAV2vf2drb63n7LP8g?=
 =?us-ascii?Q?2585hHTn9afhQnanxOTvpBKwF3ODJaHXFWsex2F+VbTwXIv1SY54UvlwRnfG?=
 =?us-ascii?Q?8/68FOg13nULEn8eGNY6AAtwhvLgKOeqHHZ0O7oNrfcIe4uPfumxtJKLamcW?=
 =?us-ascii?Q?aw3oNqhFOCHtlbg7Ml6DzsqrK+UCBEM7xOQl8fgCWbL8cUV9fViNwLdPYOnK?=
 =?us-ascii?Q?gzE7JzCGEOsvm6PTL5/5ikEmEoJ66EdjERdFY+7cSP1WS6KDzdrjx9Qoqw0F?=
 =?us-ascii?Q?4uRW9d1hFnvO8hcoAt2o9OHstZXMK6JMMYDMofOOEhGmXXL+cDsC8tRbdXGY?=
 =?us-ascii?Q?6xvPlIYANqpoPDCvY6mVD4aMC51v2Lmw9n+SjWiR8UW4Ay95RRhjL2OAYgPC?=
 =?us-ascii?Q?aU5ebmGF+bMgbp8oDF5HQvvYjfFzDWb5DY7szCEGYOn8Wo8SNorxXTyAC3Uu?=
 =?us-ascii?Q?CglVkiMRuGltTmSscbyZgEWrfcJo3vi3z8OBUTq+VnrncrNAMDyfwS7c1u4q?=
 =?us-ascii?Q?MF7HhlkIpXqHSEkukytRhA2KRHqTZg1tYpl7qo+tvhsMdKM59Yg4w69HN+rN?=
 =?us-ascii?Q?A2oq3bvCryPk7/YltuFGsjaYAUlFyDUV9qFQf+YZ9mYHfVyvKvgJsoFT6rQT?=
 =?us-ascii?Q?FCn4H5KhOLXdoEo9IdjpF2fFjrNn+AieFRVhF+abvHf15YquYSdzEdFbDx59?=
 =?us-ascii?Q?dBqRPby4qhuoTOR282KQezidhpTsEg9eyWwX4CY9q7tJIypWeLDg+4klxEjN?=
 =?us-ascii?Q?FQ7/ZVu61LI3QLsWx9ARTSbPE1Y56jwGVvjsAtfwG64ZneXyg+KeX91GXXDD?=
 =?us-ascii?Q?G+lL/CeieuFVnxCMwVvJ2Qb50dqZLfJls67rSg1B7Vj4CY4E8WRZsJpDvu9p?=
 =?us-ascii?Q?tFczlzi+c1lMeiZYnz7+8uZaHYGXu1HK5Q2X+vufD0q/LYsveQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230037)(376011)(36860700010)(1800799021)(82310400023);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2024 17:12:29.1960
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f1256a8f-5152-464b-0376-08dc9082fff0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB4D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6333
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240619_101239_611163_4314A8AC 
X-CRM114-Status: UNSURE (   8.55  )
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

This event is raised for QPs that are associated with a Shared RQ (SRQ).
The iSER target does not support SRQ. Remove this dead code.

Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
---
 drivers/infiniband/ulp/isert/ib_isert.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/infiniband/ulp/isert/ib_isert.c b/drivers/infiniband/ulp/isert/ib_isert.c
index 00a7303c8cc6..42977a5326ee 100644
--- a/drivers/infiniband/ulp/isert/ib_isert.c
+++ b/drivers/infiniband/ulp/isert/ib_isert.c
@@ -91,9 +91,6 @@ isert_qp_event_callback(struct ib_event *e, void *context)
 	case IB_EVENT_COMM_EST:
 		rdma_notify(isert_conn->cm_id, IB_EVENT_COMM_EST);
 		break;
-	case IB_EVENT_QP_LAST_WQE_REACHED:
-		isert_warn("Reached TX IB_EVENT_QP_LAST_WQE_REACHED\n");
-		break;
 	default:
 		break;
 	}
-- 
2.18.1


