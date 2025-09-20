Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2799ECAC5A5
	for <linux-nvme@archiver.kernel.org>; Sat, 20 Sep 2025 23:50:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=cjc8dxmbdzXprQh66i8QIJdhvQaAs8WaGKFpzPQU84g=; b=bfJoANGtF1fxy8CjMGUtzNemQF
	hbYLNkqV6SFhfGUlFl5MCz2XN/xBjGHU2abKR0RGWIoX8UjwoKJcXfW/xLYZK+jKu7pWQiJEVF+8S
	TwLAPX71RzUvtN2G7Iu8SC0F/GTf+9l8hFpqfjOF9ojuAqJ+nh4BW7bGcsEIUZ+9DVHNLVQLhHzeW
	vHtRqKj9LzlH1ym3tgevkpk2yspd1bWPqpqcHpaZkG6hqrByiQAvQCu8zqbraph5Z6rs358F4JRHs
	HVBw5z9gX9selKkyKXzuZz3UovJxOtm+TPIForTDxcNWkhp1CGZnzueTaRzvclyf2S+3uZS9srpWI
	uK3pxiMA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v07L8-000000065VB-1j7T;
	Sat, 20 Sep 2025 23:50:02 +0000
Received: from mail-eastusazlp170120007.outbound.protection.outlook.com ([2a01:111:f403:c101::7] helo=BL0PR03CU003.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v07L5-000000065UG-0iXE
	for linux-nvme@lists.infradead.org;
	Sat, 20 Sep 2025 23:50:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vHEUhqQzxzEbPq92wqCYSGNc6wAq8LXdpp/lVPUfLFeRFp/o5XWoCQawp8Jh8JHfZAF/l0B8zlSrK/im5fYMMdnDSfIUqkkyagLzoeBmqrAuD55qdWvqgAi2uAruazdswsU+zgSuw0+lLvNBHh11yG1I2sCyuvZFqF/noJWXD/1q8Fv51iNvSiCRk4m/52rsXs+bKOPB48y9nJlzcD4YAn5eWCmJhDOQxKDhbZEprJ5CVewr7sxdk/8QFkBsZiDiW9Swjt/9kzMaGBDMx/pF9vmpqBff9xAGlF3j0MxtwWAiJApcaw37gwXIW7ihmEuPbLr2eJbglZob3uU5/txVXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cjc8dxmbdzXprQh66i8QIJdhvQaAs8WaGKFpzPQU84g=;
 b=wKWCSYEJ96HMkI+/Tsy9L23lT4mExqDGSY+Nr2FYrTByTTPnCiwYx0VJp+JAjsC4EMzgXeXM4HDAPw5kW69Hoyakg9H1rQ0AqxQMWYDFHU+s1hBwnTX9zArWwLhaMkd5lQGRckqLsddV7LqxfD8ZrfRUdTe/QNmYEg60LKxuhPitY7cEuERNUhsjgcodT+if/bPm5IVaa+3gQLtruC9jTUDg9F1ghq+dBttGZWqM++PuLT86QbrRFnHGSonUegBNL5SUV8iru4fxMZcIHDofZCEXHd8tSN6YPHytnSC27a/wLsf1eCq0t85RDkDLj57a78OscvOpMXbi2FVNPJQA3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=lst.de smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cjc8dxmbdzXprQh66i8QIJdhvQaAs8WaGKFpzPQU84g=;
 b=alWmVixf4Y0gcFKNsWpN8YNF0MBuHLOc52OirL58XWnE3fOKeM/i5W2fVHf+IV77FwyZNcZSyH2WUs2w+iDfg4W9N/Lxr6rWtw9GFpUDtrgUTrVe+40cKS91eCcuUSWQ7jOrvUq/4J+rVrYLxPXMqI8ZLqT0V3yKl5FzvRP2YpsYrtkhdfp0Py/6m4PSf1v97araJd7yKYI5ZWUWm94IJ/TQjzXjrYjMniRwKBTIxkXtmsncISJeAA6IaSy+BEyO9ro1YnGqRkDay1f/HzWEsBvJypX0g1X26Zfl1GnTcNMpBW9lIqxhJnemerxcGmH155K9y9VV09mmmhrLfNJ0Fw==
Received: from BN9PR03CA0508.namprd03.prod.outlook.com (2603:10b6:408:130::33)
 by LV8PR12MB9205.namprd12.prod.outlook.com (2603:10b6:408:191::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.19; Sat, 20 Sep
 2025 23:49:49 +0000
Received: from BN3PEPF0000B06A.namprd21.prod.outlook.com
 (2603:10b6:408:130:cafe::18) by BN9PR03CA0508.outlook.office365.com
 (2603:10b6:408:130::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.18 via Frontend Transport; Sat,
 20 Sep 2025 23:49:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BN3PEPF0000B06A.mail.protection.outlook.com (10.167.243.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9182.0 via Frontend Transport; Sat, 20 Sep 2025 23:49:48 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Sat, 20 Sep
 2025 16:49:47 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Sat, 20 Sep 2025 16:49:46 -0700
Received: from r-arch-stor03.mtr.labs.mlnx (10.127.8.14) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Sat, 20 Sep 2025 16:49:44 -0700
From: Max Gurtovoy <mgurtovoy@nvidia.com>
To: <hch@lst.de>, <linux-nvme@lists.infradead.org>, <kbusch@kernel.org>,
	<sagi@grimberg.me>, <kch@nvidia.com>
CC: <israelr@nvidia.com>, Max Gurtovoy <mgurtovoy@nvidia.com>
Subject: [PATCH 1/3] nvmet: prevent redundant enable/disable of nvmet_port
Date: Sun, 21 Sep 2025 02:49:41 +0300
Message-ID: <20250920234943.4959-1-mgurtovoy@nvidia.com>
X-Mailer: git-send-email 2.18.1
MIME-Version: 1.0
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06A:EE_|LV8PR12MB9205:EE_
X-MS-Office365-Filtering-Correlation-Id: 58cd34a0-d096-4c6c-d97e-08ddf8a0627d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Ku/HvXz/Kg/5o2Iu7d75JEpBAbkvA+u4E4GEksaU8mNZ0u3oeEeQJGqWYXJq?=
 =?us-ascii?Q?TxeK50PY+bN8mJdZJ5sqib9Bl04MPIjXBh13/OEWtPu2xiwvUcRqF15eZ/a7?=
 =?us-ascii?Q?IwnV1MoepoM8CZ/gx4b8rglsU6loJDJLqgRQkLXri6tYfafCYtZJDWpLyTXy?=
 =?us-ascii?Q?91eBq4YR/hLZlWxP0GB4WiAhwcxlZJMQQoM2BMipUvKI3Crd2UqNO0TgrIZ4?=
 =?us-ascii?Q?EPVdbA8qtmsxlwIhS6c0u2AqKlkT4SxijVVFziFJ6ybJDmZCWuuvO6TcC35u?=
 =?us-ascii?Q?hEqfWuKR0AhkFO+RSJi3K62LlqZlOKC8t2ZIq4EgfHJcUZLIgEKFKSBLIu/s?=
 =?us-ascii?Q?pPt3yOsgQhszzNqgeeOUn4C7rxQCmqfvDXawl/0GKbVyJ14aYeTOlL32WCZk?=
 =?us-ascii?Q?93iXc8DyVq9KXU206TPClvco9Pj+f8TK1LxZBaQtLVxq9fDGKD94Wc0Bc4xO?=
 =?us-ascii?Q?EcJSOQ+0lPIxCprgx1YBdrLAt6quz9NbZydHtuPLE4MNGjujzhsYm8FdpoRt?=
 =?us-ascii?Q?aoVFc4T01cF59MG0yc9QKATRP0VnJy1geUHIfa2z+Indrj5NWU1g0gKKSIT+?=
 =?us-ascii?Q?0ouYTbsdhm7nXDyrcVCL1csHp3H+Cm5EwSxi3f4eR+Tkj9YfKBYElkwDyq4s?=
 =?us-ascii?Q?57Hyb+lBtQpLIWpaPuRrezqgeKdjIRSdzxKrGgU1DI5LxqtcoQeVryKBp4Ng?=
 =?us-ascii?Q?KS7EV9a3/lCfWl7TZ48qY+6QOMDHH5VNVXm3ze5Cqp19ZvdVDcYPC2Lbsqll?=
 =?us-ascii?Q?UoCkNiZ5XscRu7mnWR/RpKPIGEDfJaWtepDY/onsFZXMlHec6rsE8zikE0Ew?=
 =?us-ascii?Q?tKB769Qg/Lo+jvGRp67Jz29lw7X8B9scsylD3cfstXde4rcz3S0YOkRFY27S?=
 =?us-ascii?Q?ki/b2woAKWKvuexYqIc29xEemVb5x4zuYv3fXLREUOE1oZK4wVSCtDVxCqXX?=
 =?us-ascii?Q?T6F4DXbZ4uCVvvNoGGBoprwwLJhId7weeME1NHc5JZOfn4S0tde7WCrzsahi?=
 =?us-ascii?Q?4Bm4ghzNOmIpqv4T2wv8gBi2kFK/f8v8oJgREe0lbKHiKi39PAKF7oVHmQJP?=
 =?us-ascii?Q?LEqdjlxqs14TIZtNjei6HtzqzDA/5C/Z/FX4mNwP9Sr71svw16Ysr0ZiaQkc?=
 =?us-ascii?Q?JNuxKeT2gxz+82T6ZdA8iWwTo/VSYzsKZtBxTVNEYFw6T+lSH/CmJjEoiCIj?=
 =?us-ascii?Q?XcKZ1E83NoGcAg+rICePhviBhgWdm4o3KFsXGt+WD8L3aO7QUigiIXqWkAEK?=
 =?us-ascii?Q?anpa9zDhO2TOKbPtoBLPY5efNn3lZfxofCEuKQBJI3R+nL7MuwZ7v/y4y6qL?=
 =?us-ascii?Q?pM2pTafbzKHgGbYP8HiH9jcwLALmvewIXOSxYR8F9sUDiIKFLTeGraYJEiF0?=
 =?us-ascii?Q?LvY7PZdjwemtzp1JaPZRVieOzg3LXqyQQsgDgKKAFfHmKc9J7e89M0NavpP1?=
 =?us-ascii?Q?45InhZfQyQKlyGh3XKppetre1m2BitQZ8pFb6o2DxEZYzJ3fOjM5iHGJMZKZ?=
 =?us-ascii?Q?e0KSH9dJ3sdF2sY=3D?=
X-Forefront-Antispam-Report: CIP:216.228.118.233;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2025 23:49:48.5519
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 58cd34a0-d096-4c6c-d97e-08ddf8a0627d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B06A.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9205
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250920_164959_400645_7016C930 
X-CRM114-Status: UNSURE (   8.57  )
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

Add early return checks in nvmet_enable_port() and nvmet_disable_port()
to avoid redundant operations if the port is already enabled or
disabled.

Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
---
 drivers/nvme/target/core.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index 0dd7bd99afa3..9f5159f04bbd 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -317,6 +317,9 @@ int nvmet_enable_port(struct nvmet_port *port)
 
 	lockdep_assert_held(&nvmet_config_sem);
 
+	if (port->enabled)
+		return 0;
+
 	if (port->disc_addr.trtype == NVMF_TRTYPE_MAX)
 		return -EINVAL;
 
@@ -382,6 +385,9 @@ void nvmet_disable_port(struct nvmet_port *port)
 
 	lockdep_assert_held(&nvmet_config_sem);
 
+	if (!port->enabled)
+		return;
+
 	port->enabled = false;
 	port->tr_ops = NULL;
 
-- 
2.18.1


