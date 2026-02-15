Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A019DEF585B
	for <linux-nvme@archiver.kernel.org>; Sun, 15 Feb 2026 01:22:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=oeO79j0vid3MvhSTPJrnj4UdMHAIfUP7R5iZMVCbUmE=; b=Wt1860ijqH0aQVPrEsDwKWJ3xh
	PQ/7C2yZBrQXjy0IAAc3rBIgd2zVKNf14VatIRGK+4hZHTAKAnLoC0oc4W9Hq6YNjloJhRAeQK4EW
	pQYZ+Zzm2s53MqzwWd8pCdbLSfDyOTrRO4WvSXwULO8aYNmRt4squT0oJnI44GUDEIE4xOSjtOsr4
	IGE+BJx8KC21UghW/6OiOYZYCw0/ts4qCwl7K+2u/R9VIR/j+ZZr0ahFfir1FKnrOJZrYJX5UFy8a
	uG7Mul5Z2lK84GL6QkqoyjziiO76a6xMYsGYaaypi1l6EjyRx8N0wE0yu43ZRrcn6fREtL7WsqcUs
	/C7fdyhA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vrQq2-0000000553j-0d6a;
	Sun, 15 Feb 2026 01:22:18 +0000
Received: from mail-centralusazlp170100005.outbound.protection.outlook.com ([2a01:111:f403:c111::5] helo=DM1PR04CU001.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vrQpz-0000000553O-3Otr
	for linux-nvme@lists.infradead.org;
	Sun, 15 Feb 2026 01:22:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UJCNLNIf27nK1GMmN4bevJ85HlGzmo2hazx5jgdFAPIMizcowYLE3QsX90AnRYpnLSavCBfiFRL176UnqsQfcDs5k7Rnf+bsYEyz7Gbo5Qi9AeK7jfwj8RagwYaL3TYSw/7nmVPvk547bfeyF/2f7PsW45XEgH0iCaH2jHKs3C3Z5nmE/ZTnhG428WeGnSIMFDqFeIINLIrL4rOq2Sg9cU784tft7KNy2qBaWFVbQVckHY5jBWD2zfW+1ltubMRLLUAHfEPUSHEKwvbCSdpeZloZuFr9SxW6pujd9KZsXSKBal9DJKwUQk+0CJx44WSRIrjU44Qt6sOH0TlGsd9mZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oeO79j0vid3MvhSTPJrnj4UdMHAIfUP7R5iZMVCbUmE=;
 b=QP1USfb0KtQ6sRQbzrw9msl420l3Rz0RC3Sc8jdkWhfw9PhBJvfTSPOaG5g4fAT6iIx8EihioA5gQJBtNCN+TbLwroh8bYDFs41cZv5q+/ILayDbwI2itLGsH9X7I0IOZsxinupLjJ++sEtMRp1O6fxScW7wx2Fa52C63qjMOnVrWGEeTINRVUJOpadWxu9XU5P6I3YNz0OK1IY8Qhc1HHWOH3uFnawI5zOkIF5FVRLm++o//p3ijYGB+468R4TOJx6TExuHbjpmkfc5mLkd7sUF/WXkBzoKRykj5lywvaPCGLaNWHNZrcTWNEZk77RQSf0AHv5q1aKmunjsErNWSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=lst.de smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oeO79j0vid3MvhSTPJrnj4UdMHAIfUP7R5iZMVCbUmE=;
 b=lqK5G8oUAM6diT2/TV8mQi6BCGZAGFDxsCUuhsVW6lezvo6dxdX0iIdjMq8zzuyRozgvgegcNPi+W0jn9yrqnchnPL5yTT7IHmFq5O2vSnMTNhZfLAaE92zGR4JOkzGw4Q0M5ikuqbgb0+qkDDKyO75taVnX9COONrCme9W6v+8Mp6iDZdcNC30bkkKk/AVabva1ZlzNmum2EzYQvrqfFnKW37OSOJhuEueUrQZtvLt8NyGWRyqfFo3yHFs9RiEzidDQxCsYtr5HZ0S8i9I+9K+/zgRHbwKktE6YigrHsV2T8E5US4JrNbYqOn4gYkOD1wy+xQzg7SExxqsEWiz2pw==
Received: from CY5PR13CA0033.namprd13.prod.outlook.com (2603:10b6:930:11::23)
 by MW4PR12MB7239.namprd12.prod.outlook.com (2603:10b6:303:228::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.10; Sun, 15 Feb
 2026 01:22:09 +0000
Received: from CY4PEPF0000EE36.namprd05.prod.outlook.com
 (2603:10b6:930:11:cafe::44) by CY5PR13CA0033.outlook.office365.com
 (2603:10b6:930:11::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.12 via Frontend Transport; Sun,
 15 Feb 2026 01:22:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000EE36.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9611.8 via Frontend Transport; Sun, 15 Feb 2026 01:22:07 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sat, 14 Feb
 2026 17:21:58 -0800
Received: from dev.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sat, 14 Feb
 2026 17:21:58 -0800
From: Chaitanya Kulkarni <kch@nvidia.com>
To: <hch@lst.de>, <sagi@grimberg.me>, <dwagner@suse.de>
CC: <linux-nvme@lists.infradead.org>, Chaitanya Kulkarni <kch@nvidia.com>
Subject: [PATCH] nvmet: move async event work off nvmet-wq
Date: Sat, 14 Feb 2026 17:21:51 -0800
Message-ID: <20260215012151.11684-1-kch@nvidia.com>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE36:EE_|MW4PR12MB7239:EE_
X-MS-Office365-Filtering-Correlation-Id: d672fa8a-426b-4336-5969-08de6c30a2ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|36860700013|376014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ZeMjgTwaGHKkB6k6ZiCIJ5JytrvrnItfe+NdiVnBZgO5ijfq9kK1bJkNa4Za?=
 =?us-ascii?Q?CZIzA1jiJb+zeVuDNJGrnq3VrXgm9qSpmPyTlJiHNMGf4QYHs3fXNxYnVFPb?=
 =?us-ascii?Q?PjfA80VsZUit9212zfU71fI+H/B++i4XKqnxsAF7fB3VuI0KetsMqbKAHub9?=
 =?us-ascii?Q?zZa9RsmzmyrW6Abo1DDJ4+QI25A7p/YLM13V4menMvVF85Finv7Eepxvv5TN?=
 =?us-ascii?Q?a6CSNlRQQ+KvynLDS7C2YofaXwC7BDctMY0PH8jVsqsMQlqyxW04CTkc/0vZ?=
 =?us-ascii?Q?2lSr0Arc0xY5GkeJ8t/2d3D/aajgV5f6ysN27sj+b8wCuhy64uAg7QgRv/0d?=
 =?us-ascii?Q?5OfKdk2y7kIbhy9y4KCZpgJWt1odYllPocZiEx35HX0S1Y8V+dLK/4dgLZ2t?=
 =?us-ascii?Q?dHAv/uCzCV+Q2SzDFSYyJmLLOrmmM6Fuh/S5jheq1tc8YcM0uolNw6vJ8mZi?=
 =?us-ascii?Q?xz/qy84A5TXrr2tY0jl7mT/Lw/dNPTHeWBqe6GcKQppPq3MCxEqxz5NTj/xS?=
 =?us-ascii?Q?RPQBONU9yaoY5rSOuNbTyOvya2vdziKVW41qt9JmIdAxRy/KU76rCirSN/6z?=
 =?us-ascii?Q?uHMBcLzw9iC3WwUQk8zcbtTIp8JoZSav2Fenz709mHgI6JBlYKXo5pK0kd+V?=
 =?us-ascii?Q?62+nh74hspbUv3P5/PMfbkuB9qP2Vu8nyHsO+kU9BlFYBhw70rEev6PVHhD5?=
 =?us-ascii?Q?FN+b8fBSr+ePCIkdImixBOMdSAVnf6m46118VEk0ZHfcjdbMx4+n8KNKhpxg?=
 =?us-ascii?Q?nD3r9vLPo8gbQTQ1swtdqWLCspEs3dwdIAqkfATK/zU+9qNw+ocSLD8eUseR?=
 =?us-ascii?Q?jUOpRR1LVm1VI3gWFflNCI8OfppzwkpSgUawMJrPS5fbN5LWc+Ey0clq8NZ+?=
 =?us-ascii?Q?5B0PJYiFYlpaKgX3ALL8azt8t1DWKkbfkCeUlJ7USDPC0/7Y/S74rcp7tZln?=
 =?us-ascii?Q?vu/PUVkwBJsAlVhtSERWB67qt+UDmUBIHS2OiGlGTd1WjaT7ddTw+u6gqKVv?=
 =?us-ascii?Q?C5ilXryNurouP8M8OVX7TUM8hDgYh2yhcTxmJtS8i46BYs9af1SMWcF71n3V?=
 =?us-ascii?Q?ZdRhz1IkAp41J1MR2sDprCmCTgeCQ61qgw9Hx9Tgzeh+WukCdYcYnBo0sYR1?=
 =?us-ascii?Q?VB9VQlFoRziG0B/UpY++TPF04kMON8hh07gij3iUOr7U3XkQfAzivRz8hmN5?=
 =?us-ascii?Q?cwwHs+p+AAQKXwhAswxOKjnc3634BrRfeN9SMMnBKbxavZzyiD5/WUG8Bjpd?=
 =?us-ascii?Q?QHHYeNsVrwfNQAIPctO7wNAMkUHeEqC71f2fsoRRS4MHvMEVdyywJ30u7uYr?=
 =?us-ascii?Q?1g7cpcXTuhig+Kah/FwnL9ZvKsE8pGRddxLIg51hhR6wC+KcaXi8rqnf8fhY?=
 =?us-ascii?Q?buJnfhpuNcD+r8kPT4fy2KKTAFzDiOCVd94F5hNTdjRA1kpe2jk9H38+Xviz?=
 =?us-ascii?Q?IgZks+LwLdXwXJjWQiVKB16GJn0/yqB4Z4MNorLfFvOs4+tNQv3Psr7XX21X?=
 =?us-ascii?Q?gKgEC8HFXCLG9XyzyqMPHTWKL4x14LM/S07K36ayV0mnhEp12kPqJ5+RaM2E?=
 =?us-ascii?Q?V4BqS05ymBK7icfBl95H6xgeSRFasOvfDFJ+3mH6zTGl43hOpVx6wK+ifDWG?=
 =?us-ascii?Q?qfkEse9xoy5fHyjTeZyDIKYCLCBdjcnSUNrWIRL5ZKYjrTyb2/V5z7gOJLyh?=
 =?us-ascii?Q?JCPF3A=3D=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: wHQdBPbE81HJBFn8rfqb0E+Qr7schzuzL/ofdPDijcuwfKrJiFpiNaHHatHOAWgO1FXrfPS3wqI8peeOceJyQZtTzls7wjjk1iLCKEFBGQ86qzWUPbG87SBgupmuF5W/VTBciMxtcxUpVI5EFXmMDaZx+qss9wNNU70h/3GJpRTKhv79fBOuVA27nxc8vGaYnscAjf0H/fMRXkDf6YwI++gBWttn1DYtH3nwQSI3xQTRCvKCS8LahRPKYFzhjelz5CqbCB7YhH85bzJBMb1a6bKomQY8JyhoC4dbb6fdZ9gSpeci3NOWsGCoVltiV0iVfkN2lJ24mw1Pf9i6T09NV7dKdTg2VD67BuE00hn3WT4Kkp16fGi1vs+iJGC8Ruzz6Hf22KTgqr4h2WztDfybWnDmOiPFLPpTQF34S7ZiV8kJ3OS42bHykCL7PmoUVrtE
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2026 01:22:07.9646
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d672fa8a-426b-4336-5969-08de6c30a2ef
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE36.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7239
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260214_172215_865777_2CDE4E56 
X-CRM114-Status: GOOD (  13.30  )
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

For target nvmet_ctrl_free() flushes ctrl->async_event_work.
If nvmet_ctrl_free() runs on nvmet-wq, the flush re-enters workqueue
completion for the same worker:-

A. Async event work queued on nvmet-wq (prior to disconnect):
  nvmet_execute_async_event()
     queue_work(nvmet_wq, &ctrl->async_event_work)

  nvmet_add_async_event()
     queue_work(nvmet_wq, &ctrl->async_event_work)

B. Full pre-work chain (RDMA CM path):
  nvmet_rdma_cm_handler()
     nvmet_rdma_queue_disconnect()
       __nvmet_rdma_queue_disconnect()
         queue_work(nvmet_wq, &queue->release_work)
           process_one_work()
             lock((wq_completion)nvmet-wq)  <--------- 1st
             nvmet_rdma_release_queue_work()

C. Recursive path (same worker):
  nvmet_rdma_release_queue_work()
     nvmet_rdma_free_queue()
       nvmet_sq_destroy()
         nvmet_ctrl_put()
           nvmet_ctrl_free()
             flush_work(&ctrl->async_event_work)
               __flush_work()
                 touch_wq_lockdep_map()
                 lock((wq_completion)nvmet-wq)i <--------- 2nd

Lockdep splat:

  ============================================
  WARNING: possible recursive locking detected
  6.19.0-rc3nvme+ #14 Tainted: G                 N
  --------------------------------------------
  kworker/u192:42/44933 is trying to acquire lock:
  ffff888118a00948 ((wq_completion)nvmet-wq){+.+.}-{0:0}, at: touch_wq_lockdep_map+0x26/0x90

  but task is already holding lock:
  ffff888118a00948 ((wq_completion)nvmet-wq){+.+.}-{0:0}, at: process_one_work+0x53e/0x660

  3 locks held by kworker/u192:42/44933:
   #0: ffff888118a00948 ((wq_completion)nvmet-wq){+.+.}-{0:0}, at: process_one_work+0x53e/0x660
   #1: ffffc9000e6cbe28 ((work_completion)(&queue->release_work)){+.+.}-{0:0}, at: process_one_work+0x1c5/0x660
   #2: ffffffff82d4db60 (rcu_read_lock){....}-{1:3}, at: __flush_work+0x62/0x530

  Workqueue: nvmet-wq nvmet_rdma_release_queue_work [nvmet_rdma]
  Call Trace:
   __flush_work+0x268/0x530
   nvmet_ctrl_free+0x140/0x310 [nvmet]
   nvmet_cq_put+0x74/0x90 [nvmet]
   nvmet_rdma_free_queue+0x23/0xe0 [nvmet_rdma]
   nvmet_rdma_release_queue_work+0x19/0x50 [nvmet_rdma]
   process_one_work+0x206/0x660
   worker_thread+0x184/0x320
   kthread+0x10c/0x240
   ret_from_fork+0x319/0x390

Move async event work to a dedicated nvmet-aen-wq to avoid reentrant
flush on nvmet-wq.

Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
---
 drivers/nvme/target/admin-cmd.c |  2 +-
 drivers/nvme/target/core.c      | 13 +++++++++++--
 drivers/nvme/target/nvmet.h     |  1 +
 drivers/nvme/target/rdma.c      |  1 +
 4 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index 3da31bb1183e..100d1466ff84 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -1586,7 +1586,7 @@ void nvmet_execute_async_event(struct nvmet_req *req)
 	ctrl->async_event_cmds[ctrl->nr_async_event_cmds++] = req;
 	mutex_unlock(&ctrl->lock);
 
-	queue_work(nvmet_wq, &ctrl->async_event_work);
+	queue_work(nvmet_aen_wq, &ctrl->async_event_work);
 }
 
 void nvmet_execute_keep_alive(struct nvmet_req *req)
diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index cc88e5a28c8a..b0883c7fdb8f 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -26,6 +26,7 @@ static DEFINE_IDA(cntlid_ida);
 
 struct workqueue_struct *nvmet_wq;
 EXPORT_SYMBOL_GPL(nvmet_wq);
+struct workqueue_struct *nvmet_aen_wq;
 
 /*
  * This read/write semaphore is used to synchronize access to configuration
@@ -205,7 +206,7 @@ void nvmet_add_async_event(struct nvmet_ctrl *ctrl, u8 event_type,
 	list_add_tail(&aen->entry, &ctrl->async_events);
 	mutex_unlock(&ctrl->lock);
 
-	queue_work(nvmet_wq, &ctrl->async_event_work);
+	queue_work(nvmet_aen_wq, &ctrl->async_event_work);
 }
 
 static void nvmet_add_to_changed_ns_log(struct nvmet_ctrl *ctrl, __le32 nsid)
@@ -1958,9 +1959,14 @@ static int __init nvmet_init(void)
 	if (!nvmet_wq)
 		goto out_free_buffered_work_queue;
 
+	nvmet_aen_wq = alloc_workqueue("nvmet-aen-wq",
+			WQ_MEM_RECLAIM | WQ_UNBOUND, 0);
+	if (!nvmet_aen_wq)
+		goto out_free_nvmet_work_queue;
+
 	error = nvmet_init_debugfs();
 	if (error)
-		goto out_free_nvmet_work_queue;
+		goto out_free_nvmet_aen_work_queue;
 
 	error = nvmet_init_discovery();
 	if (error)
@@ -1976,6 +1982,8 @@ static int __init nvmet_init(void)
 	nvmet_exit_discovery();
 out_exit_debugfs:
 	nvmet_exit_debugfs();
+out_free_nvmet_aen_work_queue:
+	destroy_workqueue(nvmet_aen_wq);
 out_free_nvmet_work_queue:
 	destroy_workqueue(nvmet_wq);
 out_free_buffered_work_queue:
@@ -1993,6 +2001,7 @@ static void __exit nvmet_exit(void)
 	nvmet_exit_discovery();
 	nvmet_exit_debugfs();
 	ida_destroy(&cntlid_ida);
+	destroy_workqueue(nvmet_aen_wq);
 	destroy_workqueue(nvmet_wq);
 	destroy_workqueue(buffered_io_wq);
 	destroy_workqueue(zbd_wq);
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index b664b584fdc8..319d6a5e9cf0 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -501,6 +501,7 @@ extern struct kmem_cache *nvmet_bvec_cache;
 extern struct workqueue_struct *buffered_io_wq;
 extern struct workqueue_struct *zbd_wq;
 extern struct workqueue_struct *nvmet_wq;
+extern struct workqueue_struct *nvmet_aen_wq;
 
 static inline void nvmet_set_result(struct nvmet_req *req, u32 result)
 {
diff --git a/drivers/nvme/target/rdma.c b/drivers/nvme/target/rdma.c
index 9c12b2361a6d..038432364967 100644
--- a/drivers/nvme/target/rdma.c
+++ b/drivers/nvme/target/rdma.c
@@ -2088,6 +2088,7 @@ static void nvmet_rdma_remove_one(struct ib_device *ib_device, void *client_data
 	mutex_unlock(&nvmet_rdma_queue_mutex);
 
 	flush_workqueue(nvmet_wq);
+	flush_workqueue(nvmet_aen_wq);
 }
 
 static struct ib_client nvmet_rdma_ib_client = {
-- 
2.39.5


