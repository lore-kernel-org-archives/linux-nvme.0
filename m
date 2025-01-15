Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E38AC02180
	for <linux-nvme@archiver.kernel.org>; Wed, 15 Jan 2025 22:17:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=0Jx85AsIKyXJJEctz4xvq5NK7BMWoGKwD+ync+QW+c0=; b=EvnxdA1kXfXzKhlayIp4H8h4Ot
	FiEHJjvGUzfI7hvIvompB74d5wJs5VX73UaiJMqKsOaIC/5u9o+0OTgYybEh+swahjq8leiR/ja6C
	PQpiRr5Z7vTcce1vS60svYeQRKJbaiPr1zP0r8vADx9absTAZquOa3yN6PT8eH8xFENE4ZDiBhugE
	2hTp0lE+oMppXBuupwPZm0o/CEg+iUlR8bbYbk7A0Q/Q1CLWvT/B8lxETwHSmM2SXsg6C/vDmIeN+
	2Gksf1oq9pXKQCrRlvGlvV0pRcDmKT+CSNAuF0QJn4duhXa4MfGKqYT/ZL4KDCmqNC1D/Qg5lph8+
	6n+QynFA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tYBhs-0000000DE9R-18SE;
	Wed, 15 Jan 2025 22:17:48 +0000
Received: from mail-bn7nam10on2060a.outbound.protection.outlook.com ([2a01:111:f403:2009::60a] helo=NAM10-BN7-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tYBhp-0000000DE8t-0Rbg
	for linux-nvme@lists.infradead.org;
	Wed, 15 Jan 2025 22:17:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aui6L3lCQrKITZUmgSBLjkDDIQkZZvBOlIw0KG0gBeNmUA2HLL6mNhmUeqmTc0s3OqTLjQSNiUq/eqztz2Qls+b4VTmkefx7aYO4nSWmo41gmDYwhBSth1U8b820LkJM4kaUQD01ye+Dpg5YGrig4HsGZEqdCMmUCGcNmvpqKqqlZ9DeWn2OI7o4R3P1VO0gtf9R1UDBV864lXw90Phk78o9Wtcbt3K+l4J8YTs1DIajit4JFDxqHzpkSNd3EhGr291HOH3JxO8eACOCyBK9aJ7d0es51xRG8C5vg/C2S86U9lBGHpYILkPdqAjiJNo8gJr+LDd7X93g1y0j0CNzJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0Jx85AsIKyXJJEctz4xvq5NK7BMWoGKwD+ync+QW+c0=;
 b=CEJhXDJDi0c2Xt+iMp1LlN+pHsOX9D1EPaa4UG3NwFX8Cnu0VEaq7vA/vL/N4J+Soe05gJTrzqy4luLYoENUvaYS9vZtMHtHWotBKZBVUh76C/cFTCRYfNfBz35S21O2tnwP9gAhfdH5+IvThmTDxmdHnfhkbRcmA6MRvrM/w1iGrjxRMYTCknGdEkd/wj/CJtlVsDf6eQiGnu18RlHkvKbHlG2IYHZIjlE1AznMkVqvPp9UQESLk9m7dPK2pu5QSkGo2/g9ZlwS1BZqnjGyx/dGaYc/bxlghef5S42ioXfxxtKzCGCH0/L8gLT7IBTOPiTDfUus/DCWRBAbtduq0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=lists.infradead.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0Jx85AsIKyXJJEctz4xvq5NK7BMWoGKwD+ync+QW+c0=;
 b=jx2K7rPkugLhTa7Gdb3HZ37vG8qlVQfucRWGmX591q3sg37vXcBXvTRN2r9WcTHU4hf6S7GlgaCa+QCQz6ag+v1fYM9YFCsD/kPN783WoAecfAJjDKvZzi12Y27wTCu9oUMl2FN4sknmD/KRoudaxUgnqCgan4Z38j542upCoNH0WF5lEXZHIMD/YykWTnSxrY0fQ143Hrk3+oIpClp1yOTQnMW8SjaIjRwmGWJuD+f5UY2JpfNFEE0F+2lyErdJgCjvG+jeS5I8IqYJl+Gvu8yS6fYP4SHyg0Fb2jvybNXeXB48DrSZDZ1cDwc9lVTv5sUEVg3rz3FRrrz2PYEnFA==
Received: from CH0PR03CA0429.namprd03.prod.outlook.com (2603:10b6:610:10e::13)
 by BL1PR12MB5970.namprd12.prod.outlook.com (2603:10b6:208:399::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.18; Wed, 15 Jan
 2025 22:17:29 +0000
Received: from CH2PEPF0000013C.namprd02.prod.outlook.com
 (2603:10b6:610:10e:cafe::2b) by CH0PR03CA0429.outlook.office365.com
 (2603:10b6:610:10e::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8356.13 via Frontend Transport; Wed,
 15 Jan 2025 22:17:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH2PEPF0000013C.mail.protection.outlook.com (10.167.244.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8356.11 via Frontend Transport; Wed, 15 Jan 2025 22:17:28 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 15 Jan
 2025 14:17:14 -0800
Received: from dev.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 15 Jan
 2025 14:17:13 -0800
From: Chaitanya Kulkarni <kch@nvidia.com>
To: <linux-nvme@lists.infradead.org>
CC: <kbusch@kernel.org>, <hch@lst.de>, <sagi@grimberg.me>,
	<dlemoal@kernel.org>, <axboe@kernel.dk>, <bvanassche@acm.org>, "Chaitanya
 Kulkarni" <kch@nvidia.com>
Subject: [PATCH V2] nvmet: fix compilation errors
Date: Wed, 15 Jan 2025 14:17:03 -0800
Message-ID: <20250115221703.62861-1-kch@nvidia.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013C:EE_|BL1PR12MB5970:EE_
X-MS-Office365-Filtering-Correlation-Id: f375b403-fc9d-4a3a-b26d-08dd35b26619
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cHV6SDF4YjZQZ1FuNUlYS1M5SWUvVVJsYlg5SURMUG9xQVJ5VlVsM3UwRGdC?=
 =?utf-8?B?dzdaMmVTdnhqU1lZN3RPNHJCb3piYmQweiszNzd4cGxsanJGM2JISFJoTzRu?=
 =?utf-8?B?UWk1RlhUNWN6ZVBlMklTbG51WVQ5WUlHZXBBaGhFYjFsaXVZZllUZU1OY1Qy?=
 =?utf-8?B?RnFIN2J4VmlYYjJRcnR2OVZMa0tPSUc4a3dDWkpZaHBteFg5dW5WV3haSmlW?=
 =?utf-8?B?Qm5TZHdBRzRuVFR6TG1YaUZnOVg1MWViUkU1NE9wZWdpOFBNSlBjaEgyVkxH?=
 =?utf-8?B?MER5NFpMUHJPNjUrNTZhOXdjUUFyTFVzNlQvVDlzb2FLWityTVJQUGhlQlZR?=
 =?utf-8?B?YU41Wi85VG9zdTZ2Ym1SR24xOWY4VXludHZOTElSZkkyaTMzODdqek9McjlY?=
 =?utf-8?B?d0FTbGZLdWdYSzl2Y2VjT2p1WEM1dGpveWR1Y0x0YWpUSHgycm44cTBwU0Er?=
 =?utf-8?B?N2p2VHhqM1pvZ1Nlb2prYjMyYUwrOEIxTkxZdDhTemMxSHhIZUpCdDBZYXpU?=
 =?utf-8?B?ZG5CZ0RPVy9HbUJVUW8zWlpQZEpaOXBoYUFWQ3lFLytPSFlMcVBFbUl6Y3Zy?=
 =?utf-8?B?U0NsaHNVa2dwWEFXbk90MElnU0FYMUcrZkJJTVY4WFRaMDVMMlpFbjBHcmZO?=
 =?utf-8?B?UDdSQktkSmhWQ3lFbXJOK1pZUmd1N2sxOUFUM05qcktNZUFDSUNDdE4zOXNJ?=
 =?utf-8?B?VjdvbkQxTWFseFQ3Q0pub3RkSjlPN2lhb1EyOXVXS2lTQXd6UTNCaU1aY01n?=
 =?utf-8?B?WG5RNkxQWW1NN1Yxd0Ywb3Z3OVp2azc4YXlPTkJ3TjJlVFdxdjhvamxvK1Zy?=
 =?utf-8?B?S1lUeFlOcDlheTcwaFArTnpqeTlRU01Ba0R5NXMvSFNqZlNha2s5QUxzQXRF?=
 =?utf-8?B?RTNhbzNUYThFVTlDaVVFZ0FyTXZ5V2k1eVk5d1c3bjE1UU11a1owbUpOMDJV?=
 =?utf-8?B?dXErYm9aZmJ2SWhWTnk3ZmxQWHhmRXFIWGpBbEdrcDB4R3R6bE1tRHVyWUhj?=
 =?utf-8?B?MzVjUmxDbXNLQlZ1ZmhVN0xzaThPbGVUNkRGZ3psVDJlUVZ5b0ttcGt0MGcx?=
 =?utf-8?B?U3ZmMG0yeFpvVmYxTXVRcGZSaTZvR0pmNUdJTHhvNE1zZmRmVmc4azRCTW13?=
 =?utf-8?B?WWdDRlNNWEgxRVB3KytPV2Nud0VpYUNacys0QjlnRzRrbjBPWTJCQU1hK3JP?=
 =?utf-8?B?NTc1SGpjY21wSUEwYkZxSGpuWGwvektDTm5rU0tMc0pXNDdYbjZ1aktISzl4?=
 =?utf-8?B?djkrSUlBYlhxcjBTREJaZ08yZEROdStrNzFlTklHS3czVk82d05KZ0h1VG40?=
 =?utf-8?B?c2tyaUp6ckFYT0pZRUpwR29lUGhOZ2Z6NGpMcTJKb0EwYkFPWFhWYlQ4OVNN?=
 =?utf-8?B?dXZGZHlkMzJEeXFLZjUxdFBvU2RPWDYrYjBLM0hWMnNUSlUyamxNM2Rmd0c5?=
 =?utf-8?B?UmFJSERYOXZsMXdIMU5MS3Y0ZGJ4by9Yb2N6Q284RnI0b3p1aW5HVnllZ1Ex?=
 =?utf-8?B?VTRkZlZsUEozY0J1dGRxejIvQTI4NWUrSDBOZ3FZeldhZ05TTkVGSkswYW04?=
 =?utf-8?B?empRWTQ4d1d5YUUxZ1BlUmFuTWttdWFPZEVDK2diWkl1bDlLV0d3RDBDWStG?=
 =?utf-8?B?VkZ2ZTl4Sjl2VVNXdXFySkd3WVVSVTdKRDVLaVNremV0WUk3V2RZWVk3MGpo?=
 =?utf-8?B?ZWFGTk1oRUJYbjF0V29LMktNRFQzYjMyd3I1aGpKcjFPeXVCTW1BdEZPUDJN?=
 =?utf-8?B?Z3o5bjVUVVQ2Q1czOUs2dDc5S3lnejBWZytVdG93cmpOOXh3QzFuanRnN0Nn?=
 =?utf-8?B?VWJJTG05d2h6UU9TVU5HTWNLZThBRjFqR3JkODFGK1Y3ZHk4TEV1RlFwY00z?=
 =?utf-8?B?ZDBCYWVWaVViNW1zZFZRVHMwSXZKVGtaeUdSdlkycTZpeGUrWCtYWW51eVJI?=
 =?utf-8?B?cWxCNFRPSDRoSVF3bHdWRDZzYWE5NXVGZkpsZ0ZWOElVcENDTTlrazBQWE9i?=
 =?utf-8?Q?LowBAd583Gmc6j7S8hOb3vvZ/ssq8s=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2025 22:17:28.8326
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f375b403-fc9d-4a3a-b26d-08dd35b26619
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000013C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5970
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250115_141745_224844_C0ADD048 
X-CRM114-Status: GOOD (  18.37  )
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

nvmet_alloc_ctrl() only takes nvmet_alloc_ctrl_args. nvmet_alloc_ctrl
doesn't have nvmet_req argument. In nvmet_alloc_ctrl nvmet_req is
needed when setting up authentication capabilities since call to
nvmet_setup_auth() requires nvmet_req argument which later uses req->sq
to determnine if tls is enabled or not.

That leads to following compilation errors:-

target/fabrics-cmd.c: In function ‘nvmet_execute_admin_connect’:
target/fabrics-cmd.c:318:35: error: too few arguments to function ‘nvmet_connect_result’
      |                       ^~~~~~~~~~~
target/fabrics-cmd.c:237:12: note: declared here
  237 | static u32 nvmet_connect_result(struct nvmet_ctrl *ctrl, struct nvmet_req *req)
      |            ^~~~~~~~~~~~~~~~~~~~
make[4]: *** [/mnt/data/nvme/scripts/Makefile.build:194: target/fabrics-cmd.o] Error 1
make[4]: *** Waiting for unfinished jobs....
target/core.c: In function ‘nvmet_alloc_ctrl’:
target/core.c:1527:37: error: ‘struct nvmet_alloc_ctrl_args’ has no member named ‘req’
 1527 |         struct nvmet_req *req = args->req;
      |                                     ^~
target/core.c:1635:25: error: too few arguments to function ‘nvmet_setup_auth’
 1635 |         dhchap_status = nvmet_setup_auth(ctrl);
      |                         ^~~~~~~~~~~~~~~~
In file included from target/trace.h:19,
                 from target/core.c:16:
target/nvmet.h:879:4: note: declared here
  879 | u8 nvmet_setup_auth(struct nvmet_ctrl *ctrl, struct nvmet_req *req);
      |    ^~~~~~~~~~~~~~~~
target/core.c:1654:17: error: too few arguments to function ‘nvmet_has_auth’
 1654 |                 nvmet_has_auth(ctrl) ? " with DH-HMAC-CHAP" : "");
      |                 ^~~~~~~~~~~~~~
  889 | static inline bool nvmet_has_auth(struct nvmet_ctrl *ctrl, struct nvmet_req *req)
      |                    ^~~~~~~~~~~~~~
target/core.c:1527:27: warning: unused variable ‘req’ [-Wunused-variable]
 1527 |         struct nvmet_req *req = args->req;
      |                           ^~~

Fix these errors with addition of the nvmet_req *req parameter to
nvmet_alloc_ctrl(), new prototype :-

struct nvmet_ctrl *nvmet_alloc_ctrl(struct nvmet_alloc_ctrl_args *args,
				    struct nvmet_req *req);

When nvmet_alloc_ctrl() is called from nvmet_execute_admin_connect() use
nvmet_execute_admin_connect()'s function parameter nvmet_req *req as
a second argument to nvmet_alloc_ctrl() and when nvmet_alloc_ctrl() is
called from nvmet_pci_epf_create_ctrl() pass NULL as a second argument
since as of now we don't have a way to know if pci epf needs nvme target
authentication.

Also, fix the nvmet_has_auth() and nvmet_setup_auth() calls from function
nvmet_alloc_ctrl() by adding the nvmet_req *req argument. Fix the
nvmet_connect_result() call by adding the nvmet_req *req argument. Now
that we have nvmet_req *req argument, remove local variable nvmet_req 
and arg->req assignment, since there is no nvmet_req *req present in the 
struct nvmet_alloc_ctrl_args.

Fixes: 6202783184bf ("nvmet: Improve nvmet_alloc_ctrl() interface and implementation")
Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
---
V2:-

1. Commit log fix :-
   s/nvmet_alloc_ctr/nvmet_alloc_ctrl (Damien)
   s/argumrnt/argument/               (Damien, Bart)
   s/compliation/compilation          (Damien)
2. Add Fixes tag.                     (Jens)
3. Add RB tag and fix the patch subject line.

 drivers/nvme/target/core.c        | 8 ++++----
 drivers/nvme/target/fabrics-cmd.c | 4 ++--
 drivers/nvme/target/nvmet.h       | 6 +++++-
 drivers/nvme/target/pci-epf.c     | 2 +-
 4 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index ef424f7e0ed6..d642d0f40b0a 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -1522,9 +1522,9 @@ static void nvmet_fatal_error_handler(struct work_struct *work)
 	ctrl->ops->delete_ctrl(ctrl);
 }
 
-struct nvmet_ctrl *nvmet_alloc_ctrl(struct nvmet_alloc_ctrl_args *args)
+struct nvmet_ctrl *nvmet_alloc_ctrl(struct nvmet_alloc_ctrl_args *args,
+				    struct nvmet_req *req)
 {
-	struct nvmet_req *req = args->req;
 	struct nvmet_subsys *subsys;
 	struct nvmet_ctrl *ctrl;
 	u32 kato = args->kato;
@@ -1632,7 +1632,7 @@ struct nvmet_ctrl *nvmet_alloc_ctrl(struct nvmet_alloc_ctrl_args *args)
 	if (args->hostid)
 		uuid_copy(&ctrl->hostid, args->hostid);
 
-	dhchap_status = nvmet_setup_auth(ctrl);
+	dhchap_status = nvmet_setup_auth(ctrl, req);
 	if (dhchap_status) {
 		pr_err("Failed to setup authentication, dhchap status %u\n",
 		       dhchap_status);
@@ -1651,7 +1651,7 @@ struct nvmet_ctrl *nvmet_alloc_ctrl(struct nvmet_alloc_ctrl_args *args)
 		nvmet_is_disc_subsys(ctrl->subsys) ? "discovery" : "nvm",
 		ctrl->cntlid, ctrl->subsys->subsysnqn, ctrl->hostnqn,
 		ctrl->pi_support ? " T10-PI is enabled" : "",
-		nvmet_has_auth(ctrl) ? " with DH-HMAC-CHAP" : "");
+		nvmet_has_auth(ctrl, req) ? " with DH-HMAC-CHAP" : "");
 
 	return ctrl;
 
diff --git a/drivers/nvme/target/fabrics-cmd.c b/drivers/nvme/target/fabrics-cmd.c
index d1e03c120893..3b3af19f8aaf 100644
--- a/drivers/nvme/target/fabrics-cmd.c
+++ b/drivers/nvme/target/fabrics-cmd.c
@@ -305,7 +305,7 @@ static void nvmet_execute_admin_connect(struct nvmet_req *req)
 	args.hostid = &d->hostid;
 	args.kato = c->kato;
 
-	ctrl = nvmet_alloc_ctrl(&args);
+	ctrl = nvmet_alloc_ctrl(&args, req);
 	if (!ctrl)
 		goto out;
 
@@ -315,7 +315,7 @@ static void nvmet_execute_admin_connect(struct nvmet_req *req)
 		goto out;
 	}
 
-	args.result = cpu_to_le32(nvmet_connect_result(ctrl));
+	args.result = cpu_to_le32(nvmet_connect_result(ctrl, req));
 out:
 	kfree(d);
 complete:
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index 845af16561ab..3dcc01da1abe 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -594,7 +594,8 @@ struct nvmet_alloc_ctrl_args {
 	u16			status;
 };
 
-struct nvmet_ctrl *nvmet_alloc_ctrl(struct nvmet_alloc_ctrl_args *args);
+struct nvmet_ctrl *nvmet_alloc_ctrl(struct nvmet_alloc_ctrl_args *args,
+				    struct nvmet_req *req);
 struct nvmet_ctrl *nvmet_ctrl_find_get(const char *subsysnqn,
 				       const char *hostnqn, u16 cntlid,
 				       struct nvmet_req *req);
@@ -888,6 +889,9 @@ int nvmet_auth_ctrl_hash(struct nvmet_req *req, u8 *response,
 			 unsigned int hash_len);
 static inline bool nvmet_has_auth(struct nvmet_ctrl *ctrl, struct nvmet_req *req)
 {
+	if (!req)
+		return false;
+
 	return ctrl->host_key != NULL && !nvmet_queue_tls_keyid(req->sq);
 }
 int nvmet_auth_ctrl_exponential(struct nvmet_req *req,
diff --git a/drivers/nvme/target/pci-epf.c b/drivers/nvme/target/pci-epf.c
index ac30b42cc622..fe7053809308 100644
--- a/drivers/nvme/target/pci-epf.c
+++ b/drivers/nvme/target/pci-epf.c
@@ -2013,7 +2013,7 @@ static int nvmet_pci_epf_create_ctrl(struct nvmet_pci_epf *nvme_epf,
 	args.hostnqn = hostnqn;
 	args.ops = &nvmet_pci_epf_fabrics_ops;
 
-	ctrl->tctrl = nvmet_alloc_ctrl(&args);
+	ctrl->tctrl = nvmet_alloc_ctrl(&args, NULL);
 	if (!ctrl->tctrl) {
 		dev_err(ctrl->dev, "Failed to create target controller\n");
 		ret = -ENOMEM;
-- 
2.40.0


