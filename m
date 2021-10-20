Return-Path: <SRS0=Nmvj=PI=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8B6BC433F5
	for <linux-nvme@archiver.kernel.org>; Wed, 20 Oct 2021 10:42:22 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A5723610EA
	for <linux-nvme@archiver.kernel.org>; Wed, 20 Oct 2021 10:42:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org A5723610EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:CC:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=TMCP4nmrSIR4LqVlFQxjgS0f6/Krc0FbonMZaf0ttB0=; b=j8JA/9MwVTfLzhGuWWuCt8Qtt1
	xDOl32utVEBtTrpR8ElhO33SFfgnkhOKXE7RPkfYmHJtR3Tt/nrdu9VkGABjMO/nFKBTh0beI63fx
	be+fbauRBMFIXxt12jw82QHWuurMZe6knvCwDEXy6F0/u7eVs0p6tdedy1a5wZoKCyW1zn8IDdyfn
	MFtz0lb5SWkQMAcM/gOUhzgAunI6kSPURzpL2Bz6msVvaH4sPcoPR8uznV/KqLXsMNzlKrPfN5P7K
	RPQqAdmZTPcoNcXCe6VBa8OzXMwbDkZfC8cc/adtfV3VfnMCBpUimVtfgt4602xBiDjtmxitdIUcR
	QxSAVh/Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1md934-004A3g-9a; Wed, 20 Oct 2021 10:42:18 +0000
Received: from mail-mw2nam08on2083.outbound.protection.outlook.com
 ([40.107.101.83] helo=NAM04-MW2-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1md90C-0049O0-Gr
 for linux-nvme@lists.infradead.org; Wed, 20 Oct 2021 10:39:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kop2lMo0stuHK+OPhG0qCOoQ9v7hDkrxxujUpxbs7EN6NIRl1QY1fSNbYh4gSSBVJIsyLgi7YmCmf4ridi5NWdrh/GS6ev6GmWa6GA41YI6QHDcpodRrTrLZRtCI0lutrU9YkfdB0Ntv4slqBvthdJ1/2FGKV8eT6t8X9Hw6s37jZ482fhD2Ywk8VcsnOPyKMU7lm76p5FIgC2z+x/QpviZLrUcmlKmqNGSE79ezJP/OpBsCjo7bcmFHOLKJxWseQikhcKP9y+v3uA6kV1d6trCtzBzD4rrpeqiCkfTnvWKhMPOeVuelyYQmRGl8vLny8c1tKjVQGuNrs04SrfW6wQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TMCP4nmrSIR4LqVlFQxjgS0f6/Krc0FbonMZaf0ttB0=;
 b=MELSP3eyAosSvgv6g3Wmz1EH0rytFcwNk5w1N9mcY/cZZQWujrjdStMscIhoclUwFZuZRIL7nlhRMsF5/NQl3wLa5za6PXOEhp34CK36GNUsI24FlAmiuEWknN9rFu7K32k82+k5fBcTkDM/eKxk+L5xE+KVHrKsGgdCMeIkkVA6UZQ8AUtOX/NPxuepSUPoecnydL9ZFy/6EnHXbk4zly+ZWZu6y6M5jyR2/j17fp3H7RPmi4Uy/W5pi+gztCev9vTW7e7zYbfksJaZP/wN8a1/1MdBOF7Z+4a7guzYiX3XFvo27a1VM3+ED0TkKxS0e2IjYfPcRrZFin40wLhhgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.36) smtp.rcpttodomain=grimberg.me smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TMCP4nmrSIR4LqVlFQxjgS0f6/Krc0FbonMZaf0ttB0=;
 b=qxRJOptih4fuhzjmBRh5hrTqw44oSH7JaPsK5avCcqjw/1F5ioxh2pSViJDNbpMLvbGP9FWQt8KBCgI/b6P8TjVa1RaKa+8ceyFj0q7c5gj84gw8fQX+52q59JFaKeikCGTVZhDXzG50jU16NluFuuoZ7fTNgiXchx/KDBXGXr9pQ30UVoSo4SwPdy7DhmV6BkBzmGeZPRtL5LzrvbpUZcGjzzLI88hIL+Xr3t+r/iis9FWpnEqWYg18P738UgyMiQi9AzYLj1Km2GUZLR8LaxYsDVqRvFQkGmX3xDuMJUERkG2BxhoKk+v9QqmxkscYz2T5CxBKcKTHEGfaKzucFw==
Received: from DM3PR08CA0021.namprd08.prod.outlook.com (2603:10b6:0:52::31) by
 SJ0PR12MB5440.namprd12.prod.outlook.com (2603:10b6:a03:3ac::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.16; Wed, 20 Oct
 2021 10:39:14 +0000
Received: from DM6NAM11FT020.eop-nam11.prod.protection.outlook.com
 (2603:10b6:0:52:cafe::60) by DM3PR08CA0021.outlook.office365.com
 (2603:10b6:0:52::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.15 via Frontend
 Transport; Wed, 20 Oct 2021 10:39:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.36)
 smtp.mailfrom=nvidia.com; grimberg.me; dkim=none (message not signed)
 header.d=none;grimberg.me; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.36 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.36; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.36) by
 DM6NAM11FT020.mail.protection.outlook.com (10.13.172.224) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4628.16 via Frontend Transport; Wed, 20 Oct 2021 10:39:13 +0000
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Wed, 20 Oct
 2021 10:39:06 +0000
Received: from r-arch-stor02.mtr.labs.mlnx (172.20.187.6) by mail.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server id 15.0.1497.18 via Frontend
 Transport; Wed, 20 Oct 2021 10:39:04 +0000
From: Max Gurtovoy <mgurtovoy@nvidia.com>
To: <linux-nvme@lists.infradead.org>, <hch@lst.de>, <kbusch@kernel.org>,
 <sagi@grimberg.me>
CC: <chaitanyak@nvidia.com>, <israelr@nvidia.com>, <oren@nvidia.com>,
 <hare@suse.de>, <jsmart2021@gmail.com>, Max Gurtovoy <mgurtovoy@nvidia.com>
Subject: [PATCH 07/10] nvme-fabrics: add nvmf_init_ctrl/nvmf_uninit_ctrl API
Date: Wed, 20 Oct 2021 13:38:41 +0300
Message-ID: <20211020103844.7533-8-mgurtovoy@nvidia.com>
X-Mailer: git-send-email 2.18.1
In-Reply-To: <20211020103844.7533-1-mgurtovoy@nvidia.com>
References: <20211020103844.7533-1-mgurtovoy@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bc2b180c-ddc4-441a-9207-08d993b5dc59
X-MS-TrafficTypeDiagnostic: SJ0PR12MB5440:
X-Microsoft-Antispam-PRVS: <SJ0PR12MB5440D863B922D8B09EB8EC6ADEBE9@SJ0PR12MB5440.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2733;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: X7DpgXFDVULZ7MTzIuSapK5GUp8KEVPvUZJpANFEiKuMN3Rs5U11JHKnC3OvWyNKRynNHO8DnXySBe1ZwmyB+24PUKvAottxUPREU4poMefiHb6E6UJRbAace1J7OWx8egT46d91TINK0jki7f83Q8e64mH9c8JQms4zVim+d5CgIv0nwL8hkNQqEwn5cskBL5iC0tGTMFK+45k4K1UeZKOZC1vOJC8/EvemGn3iHXhnmOCXoZztl8omFWKNxsSYKWmsW+MgAGLOlmy7QwvFFtmS2UBNbA7mIywq/A/rvrGz4ronxmGgG8bZGgetrozDqK0hxY+QrXqFIH5lo2vOFJRT2zvktIa8j4JCIPNsBRtwzu8flNB1btQVdHxs2x27lCB4oyvi56JLgWLcpX43ocUNC9y7QrwUJfO6xHAoS/D6DdhqVsGHHzVU+w5lcPxpjDHomgdUuOxyH3wldhSW7+jU/TtYXfN8uAE5EBr36OOvtnMngm6zRQR+1gPybkU35z3ZJd2Q2VoKXUpCrUXoUGOfSDRTvFQgQK+lPjukbt5ioLUtVMKNOFbIQ4hq+Q630V07fZegXOdWWpP6qYBFpcoO+qSE4vvhecgzI6tZ0ofHEcFQvopGUKAgNWiU7iXMrCDLxSLfWrWtEr+rUAZNW6t2gCc5Xkeo9mmwoVkvHW2cPtHwcC9PHCSHj06I+oarCWV103efRM5+n4PnRjpBRA==
X-Forefront-Antispam-Report: CIP:216.228.112.36; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:schybrid05.nvidia.com; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(1076003)(83380400001)(36906005)(70586007)(508600001)(47076005)(86362001)(316002)(36756003)(2616005)(70206006)(36860700001)(8936002)(356005)(336012)(186003)(5660300002)(26005)(2906002)(7636003)(6666004)(4326008)(426003)(54906003)(110136005)(82310400003)(8676002)(107886003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2021 10:39:13.9530 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bc2b180c-ddc4-441a-9207-08d993b5dc59
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.112.36];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT020.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5440
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211020_033920_588394_E45F956D 
X-CRM114-Status: GOOD (  10.98  )
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

Centralize the initalization and un-initialization of fabrics specific
settings. For now, only used by RDMA and TCP fabric transports.

Also, convert the reconnect_work and error_recovery_work to be static
functions since they are not used outside the fabrics driver anymore.

Reviewed-by: Israel Rukshin <israelr@nvidia.com>
Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
---
 drivers/nvme/host/fabrics.c | 20 ++++++++++++++++----
 drivers/nvme/host/fabrics.h |  4 ++--
 drivers/nvme/host/rdma.c    |  7 ++-----
 drivers/nvme/host/tcp.c     |  7 ++-----
 4 files changed, 22 insertions(+), 16 deletions(-)

diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
index 6a2283e09164..e50f6b32a286 100644
--- a/drivers/nvme/host/fabrics.c
+++ b/drivers/nvme/host/fabrics.c
@@ -493,7 +493,7 @@ void nvmf_reconnect_or_remove(struct nvme_ctrl *ctrl)
 }
 EXPORT_SYMBOL_GPL(nvmf_reconnect_or_remove);
 
-void nvmf_error_recovery_work(struct work_struct *work)
+static void nvmf_error_recovery_work(struct work_struct *work)
 {
 	struct nvme_ctrl *ctrl = container_of(work,
 				struct nvme_ctrl, err_work);
@@ -514,7 +514,6 @@ void nvmf_error_recovery_work(struct work_struct *work)
 
 	nvmf_reconnect_or_remove(ctrl);
 }
-EXPORT_SYMBOL_GPL(nvmf_error_recovery_work);
 
 void nvmf_error_recovery(struct nvme_ctrl *ctrl)
 {
@@ -526,7 +525,7 @@ void nvmf_error_recovery(struct nvme_ctrl *ctrl)
 }
 EXPORT_SYMBOL_GPL(nvmf_error_recovery);
 
-void nvmf_reconnect_ctrl_work(struct work_struct *work)
+static void nvmf_reconnect_ctrl_work(struct work_struct *work)
 {
 	struct nvme_ctrl *ctrl = container_of(to_delayed_work(work),
 			struct nvme_ctrl, connect_work);
@@ -548,7 +547,20 @@ void nvmf_reconnect_ctrl_work(struct work_struct *work)
 		 ctrl->nr_reconnects);
 	nvmf_reconnect_or_remove(ctrl);
 }
-EXPORT_SYMBOL_GPL(nvmf_reconnect_ctrl_work);
+
+void nvmf_init_ctrl(struct nvme_ctrl *ctrl)
+{
+	INIT_DELAYED_WORK(&ctrl->connect_work, nvmf_reconnect_ctrl_work);
+	INIT_WORK(&ctrl->err_work, nvmf_error_recovery_work);
+}
+EXPORT_SYMBOL_GPL(nvmf_init_ctrl);
+
+void nvmf_uninit_ctrl(struct nvme_ctrl *ctrl)
+{
+	cancel_work_sync(&ctrl->err_work);
+	cancel_delayed_work_sync(&ctrl->connect_work);
+}
+EXPORT_SYMBOL_GPL(nvmf_uninit_ctrl);
 
 /**
  * nvmf_register_transport() - NVMe Fabrics Library registration function.
diff --git a/drivers/nvme/host/fabrics.h b/drivers/nvme/host/fabrics.h
index 49c98b69647f..06933e7a4ff4 100644
--- a/drivers/nvme/host/fabrics.h
+++ b/drivers/nvme/host/fabrics.h
@@ -190,8 +190,8 @@ int nvmf_get_address(struct nvme_ctrl *ctrl, char *buf, int size);
 bool nvmf_should_reconnect(struct nvme_ctrl *ctrl);
 void nvmf_reconnect_or_remove(struct nvme_ctrl *ctrl);
 void nvmf_error_recovery(struct nvme_ctrl *ctrl);
-void nvmf_error_recovery_work(struct work_struct *work);
-void nvmf_reconnect_ctrl_work(struct work_struct *work);
+void nvmf_init_ctrl(struct nvme_ctrl *ctrl);
+void nvmf_uninit_ctrl(struct nvme_ctrl *ctrl);
 bool nvmf_ip_options_match(struct nvme_ctrl *ctrl,
 		struct nvmf_ctrl_options *opts);
 
diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 9c62f3766f49..8e1e8c8c8a0d 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -2159,9 +2159,7 @@ static const struct blk_mq_ops nvme_rdma_admin_mq_ops = {
 
 static void nvme_rdma_shutdown_ctrl(struct nvme_rdma_ctrl *ctrl, bool shutdown)
 {
-	cancel_work_sync(&ctrl->ctrl.err_work);
-	cancel_delayed_work_sync(&ctrl->ctrl.connect_work);
-
+	nvmf_uninit_ctrl(&ctrl->ctrl);
 	nvme_rdma_teardown_io_queues(&ctrl->ctrl, shutdown);
 	blk_mq_quiesce_queue(ctrl->ctrl.admin_q);
 	if (shutdown)
@@ -2292,8 +2290,7 @@ static struct nvme_ctrl *nvme_rdma_create_ctrl(struct device *dev,
 		goto out_free_ctrl;
 	}
 
-	INIT_DELAYED_WORK(&ctrl->ctrl.connect_work, nvmf_reconnect_ctrl_work);
-	INIT_WORK(&ctrl->ctrl.err_work, nvmf_error_recovery_work);
+	nvmf_init_ctrl(&ctrl->ctrl);
 	INIT_WORK(&ctrl->ctrl.reset_work, nvme_rdma_reset_ctrl_work);
 
 	ctrl->ctrl.queue_count = opts->nr_io_queues + opts->nr_write_queues +
diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index e6e8de2dcc8e..7f50b423388f 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -2034,9 +2034,7 @@ static int nvme_tcp_setup_ctrl(struct nvme_ctrl *ctrl, bool new)
 
 static void nvme_tcp_teardown_ctrl(struct nvme_ctrl *ctrl, bool shutdown)
 {
-	cancel_work_sync(&ctrl->err_work);
-	cancel_delayed_work_sync(&ctrl->connect_work);
-
+	nvmf_uninit_ctrl(ctrl);
 	nvme_tcp_teardown_io_queues(ctrl, shutdown);
 	blk_mq_quiesce_queue(ctrl->admin_q);
 	if (shutdown)
@@ -2438,8 +2436,7 @@ static struct nvme_ctrl *nvme_tcp_create_ctrl(struct device *dev,
 	ctrl->ctrl.sqsize = opts->queue_size - 1;
 	ctrl->ctrl.kato = opts->kato;
 
-	INIT_DELAYED_WORK(&ctrl->ctrl.connect_work, nvmf_reconnect_ctrl_work);
-	INIT_WORK(&ctrl->ctrl.err_work, nvmf_error_recovery_work);
+	nvmf_init_ctrl(&ctrl->ctrl);
 	INIT_WORK(&ctrl->ctrl.reset_work, nvme_reset_ctrl_work);
 
 	if (!(opts->mask & NVMF_OPT_TRSVCID)) {
-- 
2.18.1


