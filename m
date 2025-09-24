Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05D95CAC5A5
	for <linux-nvme@archiver.kernel.org>; Wed, 24 Sep 2025 20:27:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=ZKCbhEFn1Nvmlc0KKwm6b7UEv/3Ai5NSI7ITkYOZuuE=; b=vTz2zEv6nFXfLi2L7B/YoMXPNT
	Zqm8FSw1P924kNMLHyDDIszfSbFerWXjV/Bnm6ORh5BW4EsalQWvZDY3ZzueQy2xwjcfHU5frM4eL
	Cg+fTitb1SHmyZMzck/Q/PVHE+62tZenIZcU3+Ja5r6O5cNJ7FJ6I7Fp4+dUDkaY0s+8Mo6KFB8iP
	pEJEqBIymbmJ0NHtzUNuX9+loTSljVPyayKoymi8EImuLwZbel7mBpYR5VYW+1s7AgCXBm84C10l2
	r0BBJPfFl27JwrlO4BFkIiH10dVyJcCKqMq6rZ1n/+lYvleUhjTM6x49rkfuD97XBWJIFY6Tvdwem
	PvWmLsqA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v1W4a-00000003SJ3-2zkk;
	Wed, 24 Sep 2025 20:26:44 +0000
Received: from mail-westusazlp170120002.outbound.protection.outlook.com ([2a01:111:f403:c001::2] helo=SJ2PR03CU001.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v1W4U-00000003SFt-3knS
	for linux-nvme@lists.infradead.org;
	Wed, 24 Sep 2025 20:26:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EwEBvR/kPHKgUayEng26YLHivWc2JX8AHR3hmLs8W2vuaX5u31ZXyMR5JXTMmUGSARkMsbJnVzMj3qt0iI6R3zA8Dt834/useoFNBY0LiEWI/GeTsyLPS8pcRrdL7+ARge3OBg7EtBw3/Zkv7jEzIFrbS3zG8EP4emkXd0N+60CiTBvUPGWPCzpAPak596wYUb5h7eQL5Ui43KuNn43LhnInFZHx5PhfQEetsXUX7e8QarA3U2eEJ2WEjOdAgzQhHhJIBIoFfGYEHqDYk8wMjXmeJUBK+S3ml0XnmeCV+9nRMdN7hFg53Gh8zDJ33bnIHg/7JrbUONvqEhLfRsZeTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZKCbhEFn1Nvmlc0KKwm6b7UEv/3Ai5NSI7ITkYOZuuE=;
 b=F5xpYoL4KKec+PhSE6FvzosyLRs2pLof77TIzT8eVGPx6XE70+ZbOaUTTWqat1X7lDq2EC3cNudaas+Xi1b16TaSEsQHiJ+Xooioz3pD5e2OZX+oEmFLDHA18/NckUGXCrNaPFdmTuGjjj+F9zyI9hMqW6mNBFxxa93QaVG6B66TU544wZzbimfWhFGtIJ8sQBeOh93p2TZSuJ+fDr/M467oh7XUNQtVkZtuhwqhITN4UWhl+1Didit+2booXycv6j/iufNMNR3AWmbNqHumH7aq5DTOLxjJUR2Z70OGVol2Q73iFMxX5CObpWBo8B8rDYg0oVPD6Qu7oZFOgKhy/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=lst.de smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZKCbhEFn1Nvmlc0KKwm6b7UEv/3Ai5NSI7ITkYOZuuE=;
 b=HEAT4MfAMH+Ch5iTLO/cceZ0MyM6LfQc//63cCNQp7Nz3iHPugbt8jVkVZtMhdXwJgabgggVYU4fcFpvf65sGPUpSI+oaiDat5NLMLu1NEkVdD7GoCF4Xc30yTvMhWcSicPkMqVB0LuYNN0E935kgMwJHXJawLGguiEvvxQdQ+cS7158wW4rV3RQvapL5YeYDk3DRixj9Euh0EEAmAJX6GcTVyWp7DjZbq0lL3iNYVEY3rpbNissnS1EB8oRxyOXeCeq6TC/+gUJQOApFBvVHnilJMu9h+qmwVw1/NApfigvU+zePwRZlzAypjy/MQwz2GFVSQ5/UnaawjUnO8MceQ==
Received: from MN2PR07CA0026.namprd07.prod.outlook.com (2603:10b6:208:1a0::36)
 by BN7PPFFC4F04B28.namprd12.prod.outlook.com (2603:10b6:40f:fc02::6ea) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.13; Wed, 24 Sep
 2025 20:26:21 +0000
Received: from BL02EPF0002992E.namprd02.prod.outlook.com
 (2603:10b6:208:1a0:cafe::a8) by MN2PR07CA0026.outlook.office365.com
 (2603:10b6:208:1a0::36) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.20 via Frontend Transport; Wed,
 24 Sep 2025 20:26:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BL02EPF0002992E.mail.protection.outlook.com (10.167.249.59) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9160.9 via Frontend Transport; Wed, 24 Sep 2025 20:26:20 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 24 Sep
 2025 13:26:08 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Wed, 24 Sep 2025 13:26:07 -0700
Received: from r-arch-stor03.mtr.labs.mlnx (10.127.8.14) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Wed, 24 Sep 2025 13:26:05 -0700
From: Max Gurtovoy <mgurtovoy@nvidia.com>
To: <hch@lst.de>, <linux-nvme@lists.infradead.org>, <kbusch@kernel.org>,
	<sagi@grimberg.me>, <kch@nvidia.com>
CC: <dwagner@suse.de>, <israelr@nvidia.com>, Max Gurtovoy
	<mgurtovoy@nvidia.com>
Subject: [PATCH 0/4] nvmet: fix configfs attr update handling for discovered subsystems
Date: Wed, 24 Sep 2025 23:26:00 +0300
Message-ID: <20250924202604.7201-1-mgurtovoy@nvidia.com>
X-Mailer: git-send-email 2.18.1
MIME-Version: 1.0
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0002992E:EE_|BN7PPFFC4F04B28:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e828edc-cb74-4364-9790-08ddfba89fb9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|36860700013|1800799024|376014|82310400026;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?cbhm08shGaJ3V+EVJiIDcjCaLbMoqP+gjYEjp7L+EdnWP/bhS7TiJFj8Tpeq?=
 =?us-ascii?Q?7F9PV+vvENLDMPXh/Y98I5XooNo2hpKs8lPpArueFK4pln/okbu1C0UWAcmw?=
 =?us-ascii?Q?Fquz1kG0DkuevUYxOWWCLZNBfVVg2d9DYyMKZMcGCqxEb5IfHSC+v3TK3k34?=
 =?us-ascii?Q?sv5oXwYhODXejrye8Oz0p45MtM8434sDiQOKRmaJcmRy6n+jq+6mcNC2+Dio?=
 =?us-ascii?Q?Ja/VU6rWJHfFwSU8vd5w/t2ZdUTue4cUpW4OMDY4cNmZ263sxJhPmb7lQivz?=
 =?us-ascii?Q?hNk3lfn4TSL1J84TJQvgL82JxE56TbXYNcDf3io0PpJb99mtgAUH78/87xDe?=
 =?us-ascii?Q?zq6KwkB8UqxWZK6ZhP14zdilJl8ez4vjQBuXb0XseAA68n540w8wX+8Ss2yG?=
 =?us-ascii?Q?PeCZ9FRj6OxhGDgazFaAV2AV2Dc+z1C+OnKytIukwkSz49LJjfNnU3m70s4b?=
 =?us-ascii?Q?PUfCpIyfcmWMxEYjkX4N+4CvihB/LBLwVZnKdyb4cIiQz8RIC/ZVk21XoOpy?=
 =?us-ascii?Q?IquUgeTuPMLCtIne4DO6j0L05Pd6fl6yV7jEoDT2OzVGTkd4lb4AJJJgo1ne?=
 =?us-ascii?Q?PqYEli1lALsWacRlu8iUWBUIO9hp9ijZmtrfcXX3aq+InuptFq5O8xadK7hg?=
 =?us-ascii?Q?7oq+gZtAEhxsiDuJTdIwi9kyNxPlGR+tBloriMBDboz/VQRM6410pMHgUaLW?=
 =?us-ascii?Q?YWUG/gfdW6B17752QVKtB6OqfQRhThnKawPG7OenPMLyN203xCFEv2mY86yv?=
 =?us-ascii?Q?g9YlVQeBIRi5g+N6E8J75ASnaMS/XZXnaGeiHpGsoGvz9X/q0/UznhGDYXAw?=
 =?us-ascii?Q?Efj1w2KMi2uteOC7Sl/LP3KcYwagbK3zdtxLbVCD0G2fkwiHT3ZX/CedADHw?=
 =?us-ascii?Q?8/Xt4u6MaiiCB5zW1nPAhkiK+73BWsMpOipImvAj6f3agk5fKTPJeAc4gnRY?=
 =?us-ascii?Q?SgsJyvTNUompDmNiT1QO5ONPKlzaycy87CaaY9HgD2yrfSXSCi1oz7S9A5qq?=
 =?us-ascii?Q?rIE+z8U6WwgCvLNRf7x1SF9B96IS+zRfHtb1sHmESKwKyFp/p8edaZ4H3mfZ?=
 =?us-ascii?Q?OvcQPjNNl+TCmY4/CJy5We0Zk5Ihly6OlBLZ7x0dOalHQk2NPNbYA38SFIQU?=
 =?us-ascii?Q?p4MRJ3D8JoJkZ+M7Kp4Ky/cGztZpcpckLZBE5Mzan+j+dnDQvwOixALS8EXh?=
 =?us-ascii?Q?YbOUrs14QvnrU8AWklioU+7ZmywyLdYqD70PfV/oc4yXpNeaemVYLjpEJnId?=
 =?us-ascii?Q?Ri0KmVyAtoa0DqahBlgsQvOMtVkArLrved9AkY1XyHLppSFIwQDegaovAhCU?=
 =?us-ascii?Q?KrRAACpHwJuTm5WLkEq+0b5URIJ2RecIqNxHjaq0a5oVRtPnPClEHLJGHfSY?=
 =?us-ascii?Q?7ngyuM0ITNlamzzXl1Jzd+THoZosksTsV6N/aJVaqyu0ydZ1xL6ik7y9TMjp?=
 =?us-ascii?Q?2Q9bHgsncEG3nUUefmgI5l8eq7OtISqGWS5Ds6rLoStmRNsN/mCLLSlNF/u/?=
 =?us-ascii?Q?azEXtjz6mAW4M69E7AeZyavwglwcV81KvU7x?=
X-Forefront-Antispam-Report: CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2025 20:26:20.7455
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e828edc-cb74-4364-9790-08ddfba89fb9
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0002992E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPFFC4F04B28
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250924_132638_935732_704D179D 
X-CRM114-Status: UNSURE (   9.05  )
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

Hello,
This patch series addresses issues in the NVMe target configfs attribute
handling to ensure subsystem configuration consistency and prevent races
or invalid states once a subsystem has been discovered by a host.

The main goals of this series are:

1. Forbid changes to controller ID min/max attributes values on already
   discovered subsystems.
2. Switch cntlid ida allocation from global to per-subsystem scope,
   matching the granularity of controller ID ranges.
3. Forbid changes to vendor ID and subsystem vendor ID attributes values
   on already discovered subsystems.
4. Forbid changes to max_qid attribute values on already discovered
   subsystems.

This improves consistency by ensuring that user-space configuration
updates do not conflict with controller objects already instantiated in
the kernel.

Max Gurtovoy (4):
  nvmet: forbid changing ctrl ID attributes for discovered subsystems
  nvmet: make cntlid ida per subsystem
  nvmet: prevent max_qid changes for discovered subsystems
  nvmet: prevent vid/ssvid changes for discovered subsystems

 drivers/nvme/target/admin-cmd.c |   6 --
 drivers/nvme/target/configfs.c  | 140 ++++++++++++++++++++++++++------
 drivers/nvme/target/core.c      |  16 ++--
 drivers/nvme/target/nvmet.h     |   1 +
 4 files changed, 125 insertions(+), 38 deletions(-)

-- 
2.18.1


