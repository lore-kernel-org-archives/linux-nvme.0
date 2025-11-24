Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 950ECCFA466
	for <linux-nvme@archiver.kernel.org>; Mon, 24 Nov 2025 06:49:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:CC:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+kx8D/8hwGaW2g9QyNdr7YAl6C/2OYs0b+ltz02uJFs=; b=uRLaVICELipn1RSGSm2JQ91sfY
	VIFgDqmQLqGmHUtEdjCDDM8nFrSsKbMGZL9SAYkdHpPWhRIL/Rqrw5QGZAoUS/TaeOrnPgIjk3NAR
	xE79JqaDzSlHsRqPYnUW4R0y+YqUCZ0lzUIbeK9t2ZXCzsnzk9yoMToC0ncJoKmobf1dp8ENYCqIV
	tD96zZm3pGHgznu+xbulTZLpMGzoNbKQMpIYZbk7YJSA0QHptkWc/HE//Xt/KZ7fF7D6C+2KiuIAk
	L8Y/P3JOHBK7GJnasrUA+c+wvF7zjpmLgW0M+dPuvkEJ4YMhtX9U16yUlgetP9vk2R0MaZLO977NC
	+Y2kE2Gw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vNQOP-0000000BBZL-49zz;
	Mon, 24 Nov 2025 06:49:45 +0000
Received: from mail-westusazon11012016.outbound.protection.outlook.com ([52.101.43.16] helo=SJ2PR03CU001.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vNQON-0000000BBYX-1H4C
	for linux-nvme@lists.infradead.org;
	Mon, 24 Nov 2025 06:49:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yH2f6UWrha4TUZvJxAtXQfSOI5GgMxI1Hk9cvnv6jL9ZGhz4SCPBp36E6AbvD+WHVKFeefhOR+PLUYnBDKCrnuBgOAsXZ7XpBIewnqseJgO2OT73ewXoPMnooVCQv8V9YGY2Ixkl4kALcTG+xsL7mTcve0t0SzOvo8pzWbII4CfSdgmLKxmHo0nBeKXR4aRvUSkzxXdjFrlCdKtgMjNM6LeCcPXTnlf6ygG7CNud6Gyk89fEV+VYV34JlNPtsd12ZoEMTgiRnU7MFVo4o2Mok7VspfWztyNwCMJMjapCjEh2iZOlOESINvOIQJoJZcCluJmshyKiA3OqZAIZ5lvXEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+kx8D/8hwGaW2g9QyNdr7YAl6C/2OYs0b+ltz02uJFs=;
 b=NcQvg5xqUV/enZJK4q1VwbUbP3CfpVGKJ1NeaGKMxZMeJWVndGlAU/hzBLF+am/oZYK635f61wNqSDP2fTPVlmagl2CjNEOmZo3ZDLmfTleH6GyM16PW4XjPLrwAg1XkvL7oLNrLppwJkF5FbrlkuNj9ZRKFO6phak4GkiLKD9j2mLuJgF9sxfyJvrndMxCytXswgxYHgFi6XRdE1igvq45RW29UD+5n1ioveKM6KdhiVA/4mArOI5bCJHIThE/ywPHiFScUQdJtCEgWW4zV4cUTHBiQFIoIyybRGoxIpX+qWlr/KjQWiFdN8Jp94xHKwBrseuU5wb3Zaxkcehlflw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=lists.infradead.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+kx8D/8hwGaW2g9QyNdr7YAl6C/2OYs0b+ltz02uJFs=;
 b=WH5n8h/WS5hw+pZJtrOyNTIVI3BnDWarV4lAB0Gl1IIcxt9DS8DiU6uuVw1oDvIIvRWCTRpJtvzP0i/NlNw0r3PiZJUCGvca0NJeYmKNWF5h9rzffdoO3VyN0isRPH6D5T65CS+M/prBw7v5ChIeKjbWKOJkj5ya9giZ3MD7yxJqTiryIDzozNO4ouyMoDVagiA48PS4ddiGDYpB3F0IF4X1K6EIckWpSAxYW6vOtC1X4lc8iAEXFjdj3yRG8qEqIHT8vpr3HqSyLcHetwEvXqYUN3XjcKeqm1mj5/2tKrbEYEUgHirwa9QIzClapVnNT3KofT0SiHWPQsLdwL36Sw==
Received: from BY5PR17CA0020.namprd17.prod.outlook.com (2603:10b6:a03:1b8::33)
 by CY8PR12MB7290.namprd12.prod.outlook.com (2603:10b6:930:55::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.17; Mon, 24 Nov
 2025 06:49:37 +0000
Received: from SJ5PEPF000001D3.namprd05.prod.outlook.com
 (2603:10b6:a03:1b8:cafe::1e) by BY5PR17CA0020.outlook.office365.com
 (2603:10b6:a03:1b8::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.17 via Frontend Transport; Mon,
 24 Nov 2025 06:49:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SJ5PEPF000001D3.mail.protection.outlook.com (10.167.242.55) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9366.7 via Frontend Transport; Mon, 24 Nov 2025 06:49:36 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 23 Nov
 2025 22:49:29 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Sun, 23 Nov 2025 22:49:28 -0800
Received: from rsws46.mtr.labs.mlnx (10.127.8.11) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Sun, 23 Nov 2025 22:49:26 -0800
From: Israel Rukshin <israelr@nvidia.com>
To: Linux-nvme <linux-nvme@lists.infradead.org>, Sagi Grimberg
	<sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>, Keith Busch
	<kbusch@kernel.org>, Jens Axboe <axboe@fb.com>
CC: Israel Rukshin <israelr@nvidia.com>, Nitzan Carmi <nitzanc@nvidia.com>,
	Max Gurtovoy <mgurtovoy@nvidia.com>
Subject: [PATCH 2/2] nvmet-tcp: Use kvcalloc for commands array
Date: Mon, 24 Nov 2025 08:49:21 +0200
Message-ID: <1763966961-32140-2-git-send-email-israelr@nvidia.com>
X-Mailer: git-send-email 1.8.4.3
In-Reply-To: <1763966961-32140-1-git-send-email-israelr@nvidia.com>
References: <1763966961-32140-1-git-send-email-israelr@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D3:EE_|CY8PR12MB7290:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e9668c9-639e-4cab-8bc5-08de2b25a243
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|36860700013|376014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?eAIPrrcJhLIUeRqoPP88qyTbeKtQ//jLRXc05u3t1nriM9v5R0VGSntiot1M?=
 =?us-ascii?Q?Ie8VxZhU8e8w74No7kWQGTyHMr/AuJ/qe+sy7gmWo8HAFcWZODmQvVN7bGAV?=
 =?us-ascii?Q?7FRaYS7HCRpcihpBjPsVg8gyMklTQl8ieVEh7siGaviEWLFij6svLUXBtET7?=
 =?us-ascii?Q?0twMxepIGbF24pbgs53XjLF+d8jpb0FchqCm5mvoQf8x/lpiBbTGjArUE/W3?=
 =?us-ascii?Q?0+Xvd0eLFM5vJfV0IhlSnMBzKloUzi6gVHJ/DMPQ2lh+6DFShH1Rs0O7HVOV?=
 =?us-ascii?Q?MwaFJix7KaaUoU/P9xwkV6SbnJbkJnQR7nTqnXh4rQ7A/SQFr/4P6C2zivzx?=
 =?us-ascii?Q?7MTgLWjz3b4P/Wq4sbzaibCuOhPPMC4lDWzIvYnIjO0hxBXbYvLw08zYcp6b?=
 =?us-ascii?Q?GynxszPmcDgai9odS7VOWLsupsa6YiNlkAmMSppMAu0AyfybtN8NSr2Hv5Qs?=
 =?us-ascii?Q?cwWLkqiWKGnwgaeMv1tZAtx3Vi424g//9xp+w538W6Je0FE6Btu5lmZo29dM?=
 =?us-ascii?Q?lvVHZICzS5D8UE4UGY1MmHw7T+b2iMRuuwE1L+kkOppNOUWfaqWvhLoOv5E7?=
 =?us-ascii?Q?xnI91vfR/jQQg8T71tAhj9KZfg3UZ5mwI1fTZsPB1MtsT4uudmJwDYNtK+UL?=
 =?us-ascii?Q?DQAZc4ORoqf99xv8ofcFx+xdH7fYT7TmLtj1Tycrd+Xk5kR/3tk8ml+VVvj4?=
 =?us-ascii?Q?LjTCRrAAAg83vXWdCU2hTi9aNl9AoM3+jQOGhzxJsG1bYNemz6nk5yvQpGMJ?=
 =?us-ascii?Q?lP2GIJFXoY+8UZOWyNIFZFt7Im9P37wXrDCpBy2s09vdzMB0pRzbn0b7wMJA?=
 =?us-ascii?Q?/sPoBOIchaTS5IzOjTumYdqUrAHWt9JjsCX8vxa/DmGgACw3jsDHBmWUyX3+?=
 =?us-ascii?Q?LloSYZUjbjEXTdRg2MtuQrjmsFZeVAcjlgxyhmTTBBptgypsYjqt9JFhLvav?=
 =?us-ascii?Q?yo83Nn8rkcJhwI8EXZI69HGoraIhRjWkf0U8n3EYAZMAr207Kf4W6QGyZwiO?=
 =?us-ascii?Q?3rq5bWmFn2JoMPurd5iUvWWKCtn5OIyCLmSpiGbnGtCf43ZgYOKny3m5WYeE?=
 =?us-ascii?Q?rxYUG/pm0HxrqIPFLF2Cc/yIYDEuAoO8Ke5Gzt7hYkjgRDZtXypDy2POH+wk?=
 =?us-ascii?Q?YtP4t/uRuhOonwfnMAofhK42QgxJYH3sy4zrfaxKfqmAhOTNqiVPNCF2Of2n?=
 =?us-ascii?Q?sDrkINi+XKv7t+JbiSQzdBrZxdnutK1szAY/9aa8OraJH3v/vKY2wRVOpawv?=
 =?us-ascii?Q?0x03uWBzTCRbru1VqksIBgrE4Kttqms9IewsuBDVWwt/iRChO+HrJYUT8Ggo?=
 =?us-ascii?Q?6x8rZD6iRUohwsrvKmmPHyRAhWnRDcjJA26MVpKUTgWZD3oWyp8FvcF48qJh?=
 =?us-ascii?Q?uW9wc7bOSN9FX4RMRPCGRSPQAYGCdk7gMoChy9F3jHGXi4AgdUk+4id/ss19?=
 =?us-ascii?Q?/mv/fyMgh+TA/5k2reEfIujswjjrpci7g5H+maZvPqG78yD/aGLl2v/fkwO6?=
 =?us-ascii?Q?BPXmCAm0B1PgQYolLzbCF6jr63fBbXVuEVchbk0dPmgK8RoDqGAJxGW4OAjz?=
 =?us-ascii?Q?OJy6b7o9qRbCIZKdiOs=3D?=
X-Forefront-Antispam-Report: CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2025 06:49:36.9046
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e9668c9-639e-4cab-8bc5-08de2b25a243
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001D3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7290
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251123_224943_341180_4FBC96F7 
X-CRM114-Status: GOOD (  11.13  )
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

Replace kcalloc with kvcalloc for allocation of the commands
array. Each command structure is 712 bytes. The array typically
exceeds a single page, and grows much larger with high queue depths
(e.g., commands >182KB).

kvcalloc automatically falls back to vmalloc for large or fragmented
allocations, improving reliability. In our case, this memory is not
aimed for DMA operations and could be safely allocated by kvcalloc.
Using virtually contiguous memory helps to avoid allocation failures
and out-of-memory conditions common with kcalloc on large pools.

Signed-off-by: Israel Rukshin <israelr@nvidia.com>
Reviewed-by: Max Gurtovoy <mgurtovoy@nvidia.com>
---
 drivers/nvme/target/tcp.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index 470bf37e5a63..23623a95d2b9 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -1484,7 +1484,7 @@ static int nvmet_tcp_alloc_cmds(struct nvmet_tcp_queue *queue)
 	struct nvmet_tcp_cmd *cmds;
 	int i, ret = -EINVAL, nr_cmds = queue->nr_cmds;
 
-	cmds = kcalloc(nr_cmds, sizeof(struct nvmet_tcp_cmd), GFP_KERNEL);
+	cmds = kvcalloc(nr_cmds, sizeof(struct nvmet_tcp_cmd), GFP_KERNEL);
 	if (!cmds)
 		goto out;
 
@@ -1500,7 +1500,7 @@ static int nvmet_tcp_alloc_cmds(struct nvmet_tcp_queue *queue)
 out_free:
 	while (--i >= 0)
 		nvmet_tcp_free_cmd(cmds + i);
-	kfree(cmds);
+	kvfree(cmds);
 out:
 	return ret;
 }
@@ -1514,7 +1514,7 @@ static void nvmet_tcp_free_cmds(struct nvmet_tcp_queue *queue)
 		nvmet_tcp_free_cmd(cmds + i);
 
 	nvmet_tcp_free_cmd(&queue->connect);
-	kfree(cmds);
+	kvfree(cmds);
 }
 
 static void nvmet_tcp_restore_socket_callbacks(struct nvmet_tcp_queue *queue)
-- 
2.34.1


