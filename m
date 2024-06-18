Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6866BC2BA18
	for <linux-nvme@archiver.kernel.org>; Tue, 18 Jun 2024 00:11:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:CC:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BuHzdaejW+5/5z4bCGKOnLS08iIq08U0+dDHF5Hjmo8=; b=d8UsYtvvE1qcxH155fZ8uNwE9D
	Y4boJJ5B+B1dsSzTZ1X58h0qX12AdlXn2ggs2WcAlUcqm/FTot0NoPhFu0EGuLII+gX9wrJgF6++d
	AVwXq638tzqd5YZNh1T4kWoHPT45/80tBBtGJgwOHRcVo+ksxNLgwl23ZxUM1/fPAt6bS8zpOoaN1
	clhDo9hCtAaar0vPfEjQJe4AHvPMcZht+NRMxXK+iBReC1giI9vM65evm8wugzJA23Glujn9IyHMy
	0PGva947Hh6zP2Vndj4ejVKix4MQo45V+Y9R4MGq03Rz3SMf1uCoibT13CR47WwOpiRH7KB1Ja73H
	hm98UjYw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sJMRW-0000000D0ut-3dgf;
	Tue, 18 Jun 2024 00:11:22 +0000
Received: from mail-bn7nam10on20607.outbound.protection.outlook.com ([2a01:111:f403:2009::607] helo=NAM10-BN7-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sJMRU-0000000D0se-1T4V
	for linux-nvme@lists.infradead.org;
	Tue, 18 Jun 2024 00:11:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GgTyQfy7Ep8hG+5DfLhlJPkDrUUhw58MF9JcPEB/CMP/rvA0nr2ODHignF+0e7yXNtOBCL+1en7kvNct1jak3Y19/SANCHwnvkQLmT3CwynP8b9b7R4sRnSUjjGpUu4poyrwNKbQkj1CneMGoX7WxthDAFaSJgBCYAHkYgIfTp7nDBzIm9xIRwqG3ddStX87BR3cDSKnUFEF+63eDXdB7CR4Xj4gCLps/cLj8TNpZ9MURyBcRem3yVR7o29M/Xl0vhRRGikq3KouS8sB95jyjT+N6ffU039zYgJnfcBtBEr2YoxX12n741l181Y8uSRHQAndpKDWs3vDEcDmKVhyhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BuHzdaejW+5/5z4bCGKOnLS08iIq08U0+dDHF5Hjmo8=;
 b=LR6gtcIV/NzQq4UeVP/vASuLQ6n/kSD7GLa1Q4Wsw4112wu8Cx5yDPKdBZJoincctqjX8484odJiahF8zVVLaYZVpEuasXNYrfEPNJLW+92vCUZoYj7ihp22qJjW2e8wB3RZSi4r8+IGk3Vclq2Npz39h+pyiIxogic57srF1/1SZHAtuBs8lNpW23A79NLunYBRXQZLVdTnbLz6EL4Kbw1AbaftDLlJ3fQGKPqRItz0Bp2j1+cNjzx2NhKLzJRDkvyaG6lkPLYGnUR1h07+lOlNR/f8WH3FIA9DxKD6pYlsd3awHInXv08xFgiIiwoFKMBYPo43VlJb7yrGaZ3MvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=lists.infradead.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BuHzdaejW+5/5z4bCGKOnLS08iIq08U0+dDHF5Hjmo8=;
 b=HrIPvIpjTYaN+3vYEQYRYxp13UdpcIx79Noh6xU5D1YzCmqNmeEaO57m2TBx1lm6xkX/IHgDtY/hBwlSDJvnGrYYcZ5gykGvZdWcKtlrlO04dv7Esfvj0NHgx3phzD1MjbRwBxWfegyKQoBYSsmyvBvqqfve3vjqyDLvraFuIT3LXlGHo5hdtixcNMrBz5HO7kP8TOQN0huvOR3zomhRY8OEWc8sHMwIrse3pjoD/mvpocngUpEBxZOpVKwe6o+y4Jw1MvOBdtRVCmj2Eo7moP17EwWR1wAGbPE7r/Gn042dJGBXVh/dG1Z0sDd9um/pE2MWnhiDEibbPDSz+f+1Qw==
Received: from SA1PR04CA0014.namprd04.prod.outlook.com (2603:10b6:806:2ce::20)
 by SN7PR12MB8436.namprd12.prod.outlook.com (2603:10b6:806:2e3::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.24; Tue, 18 Jun
 2024 00:11:15 +0000
Received: from SA2PEPF00003F61.namprd04.prod.outlook.com
 (2603:10b6:806:2ce:cafe::ac) by SA1PR04CA0014.outlook.office365.com
 (2603:10b6:806:2ce::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30 via Frontend
 Transport; Tue, 18 Jun 2024 00:11:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SA2PEPF00003F61.mail.protection.outlook.com (10.167.248.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7677.15 via Frontend Transport; Tue, 18 Jun 2024 00:11:15 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 17 Jun
 2024 17:11:00 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 17 Jun
 2024 17:10:59 -0700
Received: from r-arch-stor03.mtr.labs.mlnx (10.127.8.14) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Mon, 17 Jun 2024 17:10:56 -0700
From: Max Gurtovoy <mgurtovoy@nvidia.com>
To: <leonro@nvidia.com>, <jgg@nvidia.com>, <linux-nvme@lists.infradead.org>,
	<linux-rdma@vger.kernel.org>, <chuck.lever@oracle.com>
CC: <oren@nvidia.com>, <israelr@nvidia.com>, <maorg@nvidia.com>,
	<yishaih@nvidia.com>, <hch@lst.de>, <bvanassche@acm.org>,
	<shiraz.saleem@intel.com>, <edumazet@google.com>, Max Gurtovoy
	<mgurtovoy@nvidia.com>
Subject: [PATCH 5/6] svcrdma: remove the handling of last WQE reached event
Date: Tue, 18 Jun 2024 03:10:33 +0300
Message-ID: <20240618001034.22681-6-mgurtovoy@nvidia.com>
X-Mailer: git-send-email 2.18.1
In-Reply-To: <20240618001034.22681-1-mgurtovoy@nvidia.com>
References: <20240618001034.22681-1-mgurtovoy@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F61:EE_|SN7PR12MB8436:EE_
X-MS-Office365-Filtering-Correlation-Id: 82353845-5ed5-4a9d-a30f-08dc8f2b2b7a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|376011|36860700010|1800799021|82310400023;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?hQam8QpImz7ubivw2pUn4eU+RH5b9GXtk8IaH/aEFnxAhxoke+fKC7n1Qitb?=
 =?us-ascii?Q?72GN4DC0LqCoC0W7QFBnI+BPWS+1T1z4v6ARKZhJ+09W3t/FWAmRuKCHN5bq?=
 =?us-ascii?Q?zobYSedeDRbRHqTQqswFkog45UDv232u+vlojRRjV1NCNGcXLebgfaRmuD1N?=
 =?us-ascii?Q?u3GaMZi7kcM7qXg+4duz2IQlU59W38COTC4IDj8MnkoSY7aBQRwzMQPyIt7y?=
 =?us-ascii?Q?UW8yz8OntBwYdmlxMjrIbWkjmEBOLuB0VJGgUMi3hJ7V1KcmfX/9u2oWv8p5?=
 =?us-ascii?Q?enzPEhzAj6vOY3KiweYaLUpso08tfqFNbhLhD0EFQqVAeOumpRTBbuIG1ene?=
 =?us-ascii?Q?HeGOHi12rjCs8QaUaOA1/C2DBkNh4fENr2j0Zvy6AeSVrxopR+g3kPaI2579?=
 =?us-ascii?Q?4/yD4wbCtg/u2e3TQNMvETkubAgPXhOfTH+kr7Ntj1yFofy5jKVxkdebbdoc?=
 =?us-ascii?Q?RONnP3+gQyiXAZrahsD1GGRl4+mBdL/ojucmvT2p2M1biYgK9L6atauXqw1o?=
 =?us-ascii?Q?CxbaKBFH66HFNeoYCuakaE5Qdbn2w5AY+ZQiF9LgK8LriPFGZ2RzbDS0lz0u?=
 =?us-ascii?Q?a4i3t5fK10FcwD7Lx3SUIOVYaxxy+nul0COnCA7wF2jPXuqGxKMug1PjuKY0?=
 =?us-ascii?Q?eiAz/hTYq+5EOhSyCERke4K5GEwA1K2d+b8oJQu9neGrIoTuN+H0EBtWFtTE?=
 =?us-ascii?Q?CJu2dB+SG5TSdWZ+onUSUnZub1hoOyTBCWHi37+PfUNNMOYo4Or014Ca9uUT?=
 =?us-ascii?Q?usqa9qlOXxHFUOcCxogIblPTGHx9Tg7nfCAn0hhReaXtAx5jXEE/GyXFZ8Dk?=
 =?us-ascii?Q?4/BDTOHa4jp3QKzWZMQykowf4ZULUI0md5NxV4PU/tYr1Bi6HRus+BLBKNIJ?=
 =?us-ascii?Q?vCbSSitUxo6lTBA5ets/SmjN+fBi4IlJeUrThMwJqfAhZVM9fu7CiYGaFYYI?=
 =?us-ascii?Q?Ic/fNMOLCjSBmCIzTPeVRCLP45Luah0BrmHvn76PEJeklSFP6MEKF6Sb4PbZ?=
 =?us-ascii?Q?16o//pimA/4BLBJSvS285D0OpilEVwz3Z9fo/3knMHspi6AfTMF0Yv4kIirW?=
 =?us-ascii?Q?XUyfUZ1vGmKlqK/CtN9yxMDnEqLPIHnOQ9g92gkQQ5JQTTAgpqjSvjQ2Mrpa?=
 =?us-ascii?Q?L26fnomwPsN1cf6bDW8lj5hKvhV8gb+pU3NwZzFeg4DPAiRQO8jOrzGSb8uO?=
 =?us-ascii?Q?dgebxowe442IpUQ0VOIXPF3FUrcT/ICUHdcBPg3jRGuASfM1eoDOCEg9XE1/?=
 =?us-ascii?Q?Y70BKkWslTb1CRs884cA47aFhkslekkLIZ/sIuTu/tWczFtTSvz6WUaosZCL?=
 =?us-ascii?Q?lv8Zlq8c/nHmbmF16c3lje8W62W34H88F6ykdFJot0H5OrTYi8UueAZiUnh5?=
 =?us-ascii?Q?DhSfDbtVkc5GS+q/ie/iNE+R8jX0k2HT/qArfxExWN92zSnw1g=3D=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230037)(376011)(36860700010)(1800799021)(82310400023);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2024 00:11:15.3872
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 82353845-5ed5-4a9d-a30f-08dc8f2b2b7a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003F61.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8436
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240617_171120_547301_3FDBE4F8 
X-CRM114-Status: UNSURE (   8.50  )
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
 net/sunrpc/xprtrdma/svc_rdma_transport.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/net/sunrpc/xprtrdma/svc_rdma_transport.c b/net/sunrpc/xprtrdma/svc_rdma_transport.c
index 2b1c16b9547d..4bb94b02c34c 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_transport.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_transport.c
@@ -107,7 +107,6 @@ static void qp_event_handler(struct ib_event *event, void *context)
 	case IB_EVENT_PATH_MIG:
 	case IB_EVENT_COMM_EST:
 	case IB_EVENT_SQ_DRAINED:
-	case IB_EVENT_QP_LAST_WQE_REACHED:
 		break;
 
 	/* These are considered fatal events */
-- 
2.18.1


