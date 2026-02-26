Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3F6AFD4618
	for <linux-nvme@archiver.kernel.org>; Thu, 26 Feb 2026 04:31:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=Rre+Ve9NBjVko+KqVb6pRnh78/bup/CmHBBh2kxxthk=; b=q+5wGrndlntRGh/acb4TqTuuzD
	bfCEeZc4B2pTThuSvml7kWyV2fkPE4dy5+F7RHIvyvassCpqJoGaaSYRWxhK1mYCOA6GCEDSZvWEf
	0QD0Qdiirzz/HOHSqnekIc9e21T2vHmW41IKcLZPzaE67C1KWYgFtmAh+9uV4OBRBpNl3oy9A+nIM
	S70VcaV9mAqp+OixysW4c/pHy79SRM4YKYeooDpROXvK/tvxf+IO3jdBtZgKFKyX0Ulw7TYSVH+lP
	/M6iMGDDC8GzDRv7ApGeh2jo/66FpX72TkI5SYSXzTo3xCQRdIPXkzuNikK79KqxYbaB6Qvb6rBe1
	rCR4mypg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vvT1b-00000005NC6-30v2;
	Thu, 26 Feb 2026 04:30:55 +0000
Received: from mail-southcentralusazlp170110003.outbound.protection.outlook.com ([2a01:111:f403:c10d::3] helo=SN4PR0501CU005.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vvT1Z-00000005NBJ-1hWa
	for linux-nvme@lists.infradead.org;
	Thu, 26 Feb 2026 04:30:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hjyBGzljAyRAlcNe5DCTP0HMOVgeBVAMzCZA8qZMkJdNBnRxJb1x1X2vGNzRU1n9v3SY1mFz1fZ9Bzx7ab51ch7nRPmtZzgPNNCc3xXibXBoQHH0R7wRoCG2KXoCOiHJdWoOh3AtJwmQjkFeWiHYe5oBo1OAUOGOKgcp9h+RTgb7Ifh7JfyYJygVBlNqcN5A0z51S+WtOjejGDWI5BvgM+thOxjEzBtP/9UhShu1jHNzfDuz3wUDi/kSxUWF+JDHouZWZty43tiCrr8a9EWQ1IVy901q4Bwb5TbXUSIWj18+bt8VglTxUks540hKZTLTESarGYZX13fzL3/q9qAJyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rre+Ve9NBjVko+KqVb6pRnh78/bup/CmHBBh2kxxthk=;
 b=Es+H+20DUYikYylna6eyvsVHziN1QgbH9WbkYKzzNbKYhKM6J6BZJFK4CaOMoIrUbryCw4M63QVMn9Yv4qsMTgeXxm12Hbn5P0gZBY2QeLQ6a73LsNwUySea4wQ2aDAGGPNZ4IE6rUKPICXkyCFYfNq582rZyXPhLfNJTi+dhCLxsDMalOODntLHul7z5U7vX2bPnqNVMwHlRAKFLqlgMlkbnsiMLRu8r+ajUMQVu4BWtykZ5h5JTcq8uH7BHe4ooBLkHeMhZ1gxXm3SRJhXR1d1Y71FPiol64Y5aAYaCWlni6j+h655khAa9W9UGZBDOv1h4M5AGhGEz6B2sfp/AA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rre+Ve9NBjVko+KqVb6pRnh78/bup/CmHBBh2kxxthk=;
 b=WXt1s1nffEM2tHilkc8uK+1ArDh1kcOpIjiXGbdaoNCS5RK4qw4IaLn1yWyCb6XnM5ScZgIziwrM/6LQzZ0paZE4AWVp8eeGNO+L1euBy1R6EzZ7A29XLD33Sptph3zRgq80Mfc1X3y6ehLABzj+SGhGQnCEOAolU74E4sP3TRaK7Cb7/Ovxhflv2I9YLp2uy9Tckyt1JoS6CdeacwTDBq68sqH1+DTq0y+dup+YorEAVxLdIFo12lW3FwS82FV1NvDhpg0+w21YiZFLr/7vPoRpRn8sbTIVpnZci51dyLEAaMvfn/7JjspXnD9GSZP6xFHRSHiEsQIi3SwOx0LC2g==
Received: from DS7PR06CA0026.namprd06.prod.outlook.com (2603:10b6:8:54::16) by
 BY5PR12MB4177.namprd12.prod.outlook.com (2603:10b6:a03:201::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.14; Thu, 26 Feb
 2026 04:30:46 +0000
Received: from DS3PEPF0000C37D.namprd04.prod.outlook.com
 (2603:10b6:8:54:cafe::3d) by DS7PR06CA0026.outlook.office365.com
 (2603:10b6:8:54::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.25 via Frontend Transport; Thu,
 26 Feb 2026 04:30:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS3PEPF0000C37D.mail.protection.outlook.com (10.167.23.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Thu, 26 Feb 2026 04:30:45 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 25 Feb
 2026 20:30:30 -0800
Received: from dev.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 25 Feb
 2026 20:30:29 -0800
From: Chaitanya Kulkarni <kch@nvidia.com>
To: <kbusch@kernel.org>, <hch@lst.de>, <sagi@grimberg.me>
CC: <wagi@monom.org>, <shinichiro.kawasaki@wdc.com>,
	<linux-nvme@lists.infradead.org>, Chaitanya Kulkarni <kch@nvidia.com>
Subject: [PATCH V2] nvmet: move async event work off nvmet-wq
Date: Wed, 25 Feb 2026 20:30:03 -0800
Message-ID: <20260226043003.160555-1-kch@nvidia.com>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37D:EE_|BY5PR12MB4177:EE_
X-MS-Office365-Filtering-Correlation-Id: 0029eae2-e6ed-47f9-ef1a-08de74efcf79
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info: /0awCLWqz8hPDYsxUQmdvPIxHUCF4mMm8C3KJe4Eb8JAyhPRF//9g38dCzIuqVS2blGaRW4SWc45GdB5cbo6QKnMNmMBW0vQn2gl0O5A96VzyNkzz8Xyk6y2uiauzSIW0F2BX8wLX1LeldYFgvyxQW8vq0R858ILoIaUfdBGQgYRr6MDfB4BQ/MyF2k/X2pEUxSXasa0LRupBcedd6K8uxYFLLcma/XdQO3E200asWtX2rl7WyJa6VzawQpbdVXzP3eDkblqI0VtDivx74pOwGB79o90CzNIfp1zE/DJpCo4VKP4VY7oKxAH+tsJ4wFcdJp15ug0+y/8TuLi29hOAlSaglFVSufT7xiBpu1+hxqSZ5n5GGJRRakPaXLkgb96rLioYjo0YgImdUOUs2WvBWHyLhgl8H+04/SNIfes8Hw0QW/tbKiwghpFmAUBfFZFFTJlVPJMy/lkTjtO06hoEi3SClCTrNMWB/qq/7ztiX+vZWo+i2cM/jCuZf0EGj+aDM3ufrt9YYJq/BgE5hLZoqsKtWe1P0UXjq4JnAcMf1r9lXuiFheHisyp76SOE1fQKUXPH7CW0r9qZWOM9FiFqlv4TOpHmevr+qSMcsuNzB5eclBbOwBBeZdqlNR+V0JNtzjQJZqdAlCg5JMr/m3T4TiytN9aokx3H3rc09YWOI9F9oUtLdA6VpOgnnZ16mWAm3wtGVA0B3wrC/e6Xh+5c5EBn2Q7KyI5imrjF3l8FeeQ4+dnkJTBtzhnHzA1aoWVekPrar9C1OnkEyeVW7h9w8YIadkdU+v0adOCQkvlDXHwfBKdFuMvBuY2uCPi9KgD5qZMhMCAiFfCe/DL1ceX+w==
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 9wcdt2yKxGay00kFLGVVgbhx5nTedceEM4IlFcTOa7rAosXkXUXAYCfGQlNxHluvldVlNf/Ng3JE7kJGqOoE+HXolqzNmLXPZ6aC0U6GqfrxEHqhFsIuVkQekP9rMle0J4uixxS5wWuo0RpgjQ/62IVaegswB8dTUuHt4MOF6jz+1Qla0j7nmNffiTfCvVJjvxOPr8VkQBAzQFG41w0nOAYCAvVC9YMJX5ppfkYyeM0AbAKBUNHkDlzKKijvLgDc3jlDi1CVsOYqIxzm/jflLDu13BX6rFxEdo0uUFJ17ho2ky3O7chHpkA/8r5Fd+bZLuYflYb3RmvVuv14rvDYmBnCcZrv0pqDPlX9lC7AoKe4zbXApA9QVx4aXSGjtUOmp96MGzSoWVL+hMHTLhBDAk/1NG05NsmRT7+ZvWnqJllJOzF0vmKGsAokpOs9YQ2A
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2026 04:30:45.8648
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0029eae2-e6ed-47f9-ef1a-08de74efcf79
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF0000C37D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4177
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260225_203053_632396_7D59C3BB 
X-CRM114-Status: GOOD (  13.89  )
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
                 lock((wq_completion)nvmet-wq) <--------- 2nd

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

V2:-

* Export nvmet_aen_wq.

---
 drivers/nvme/target/admin-cmd.c |  2 +-
 drivers/nvme/target/core.c      | 14 ++++++++++++--
 drivers/nvme/target/nvmet.h     |  1 +
 drivers/nvme/target/rdma.c      |  1 +
 4 files changed, 15 insertions(+), 3 deletions(-)

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
index cc88e5a28c8a..5075f7123358 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -26,6 +26,8 @@ static DEFINE_IDA(cntlid_ida);
 
 struct workqueue_struct *nvmet_wq;
 EXPORT_SYMBOL_GPL(nvmet_wq);
+struct workqueue_struct *nvmet_aen_wq;
+EXPORT_SYMBOL_GPL(nvmet_aen_wq);
 
 /*
  * This read/write semaphore is used to synchronize access to configuration
@@ -205,7 +207,7 @@ void nvmet_add_async_event(struct nvmet_ctrl *ctrl, u8 event_type,
 	list_add_tail(&aen->entry, &ctrl->async_events);
 	mutex_unlock(&ctrl->lock);
 
-	queue_work(nvmet_wq, &ctrl->async_event_work);
+	queue_work(nvmet_aen_wq, &ctrl->async_event_work);
 }
 
 static void nvmet_add_to_changed_ns_log(struct nvmet_ctrl *ctrl, __le32 nsid)
@@ -1958,9 +1960,14 @@ static int __init nvmet_init(void)
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
@@ -1976,6 +1983,8 @@ static int __init nvmet_init(void)
 	nvmet_exit_discovery();
 out_exit_debugfs:
 	nvmet_exit_debugfs();
+out_free_nvmet_aen_work_queue:
+	destroy_workqueue(nvmet_aen_wq);
 out_free_nvmet_work_queue:
 	destroy_workqueue(nvmet_wq);
 out_free_buffered_work_queue:
@@ -1993,6 +2002,7 @@ static void __exit nvmet_exit(void)
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


