Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A0CEC77B7F
	for <linux-nvme@archiver.kernel.org>; Fri, 12 May 2023 15:42:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:CC:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=eNEOURhLohPrNtm8V6z/GdPYgp2cxWOhetLrfdtcVYE=; b=hQU5O8ACk9A25FnX1fB5MOuoqY
	LmykvQu+mHsK+FNv7j1W1/83khkwwSUVgxUHwj/lXDNdTz54Mypnm1Kpc++iPNuU/t/1rOQ5itDqh
	N6Ui6VvfpBF+V8ck3uKCgngLF89p641LP4pKFifEHqT7UEHMxcB6F+n6zcNzV1iz5WzjueOBFpTJi
	TTV48Y0DmU2wiBOH6o+JewHENXq+/b5GIUYbPBg1tahXUpYTZwm6gyZH/SlDJg6o3JeL7DxWariSg
	OTy8j2FAxD7KweAYe5gq6+r2sZAhez+UUlvz5F9BGUicaeC9/1sf3Y20F9GEiT49Zv5/oqznfQAxP
	keznM1uA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pxUuP-00CObX-3D;
	Fri, 12 May 2023 15:42:18 +0000
Received: from mail-dm6nam10on2061a.outbound.protection.outlook.com ([2a01:111:f400:7e88::61a] helo=NAM10-DM6-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pxUuN-00COaQ-15
	for linux-nvme@lists.infradead.org;
	Fri, 12 May 2023 15:42:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZMl74CTGZt/lpSwisr8lLc5W1CwbR+5XlELp8i3vvvpZvnY613CMmwlCRcTw2RRN9psGWYjPIcwz50d7KY43yUbdQI3XOmO2/mkNMVgmBdtlOk5RFRo3TbDwPbYYfoFOMJmuCWlPKDrr0QRW+Z03yki4qBdFq+HQ0Kxq44E7J8dhokpIsU+Nu2A0hjmsonn8o3OcOMebzTB/a+kNXoUGaHsw9WLjg3R3LRyQ1VXQct3DCv/xZr4KZQLhG3dpRD6aOhTNj00SAJUVQ/68pfP0BF3JW0JGTe7Dl5/fNMscDdqPAPQH9JL3pnPmeXcPaWqSQLeERxCwhKta19Cwu23ipQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eNEOURhLohPrNtm8V6z/GdPYgp2cxWOhetLrfdtcVYE=;
 b=le5CtmlAK1zrYVWFD1BNVUUZ/ArRpiCDnZIWGGoLkFXT4SmyvQdNOqnC/IXIAmB85VeusM3Ex4Xeo46SAv1igYpBAxYyRm63C3ssbbxM10xelIEZjVOL63Cv8T9ckRAJqIoubqFIoRIYs16gEwVNBrsHb9uLzm39N28henHm67kN1pcHzsyRh175sngC3gQAu//4xLPW2LCafv4krL6QnZbEDM89+N0UkCGOV/SsjN+6xHKdWTVLNj0YTSefEngS17DvBvJ5POnRIkkuGn5eXL98eGpXtYCcisuOCrIneAFu1agBW9AfSfDzpMQsk8TYlM7prPyYQnMVDxV1HtxcQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=lst.de smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eNEOURhLohPrNtm8V6z/GdPYgp2cxWOhetLrfdtcVYE=;
 b=PXxrCykPKd5UvS9Zdqr0Phwh2LQX92VgCtXnqCRVe1Bf1LxNQ1yzcUAkTkS3fkeRSw10O8fAEEFzRRlp33nTO2H/koi0/Lk5bMvTA4iUEaO7DsQm3UbtK6d7492riqyyQmu6QqmqFxUzpZUUd2ZUggtWXkUBHdJ28rFC7sxPIWWbV8dFleZIX0KECWfuI5NuFnUmltsT4UCCNY2cfvVkIhOajjye/Md5b93wFctn9//Q17k9y1UYCsqfteC8+sFfDfWjaUhPcwCS+WHaUH/ZJ3vfNv7AywzAlyyKpH3QbRzgL/Jb3p4AYb3IY7Je6mXYebcjryxBlvIs+kMGd24gfA==
Received: from CY5PR10CA0012.namprd10.prod.outlook.com (2603:10b6:930:1c::12)
 by CY5PR12MB6201.namprd12.prod.outlook.com (2603:10b6:930:26::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.23; Fri, 12 May
 2023 15:42:11 +0000
Received: from CY4PEPF0000E9D8.namprd05.prod.outlook.com
 (2603:10b6:930:1c:cafe::9f) by CY5PR10CA0012.outlook.office365.com
 (2603:10b6:930:1c::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.24 via Frontend
 Transport; Fri, 12 May 2023 15:42:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000E9D8.mail.protection.outlook.com (10.167.241.83) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6411.11 via Frontend Transport; Fri, 12 May 2023 15:42:10 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Fri, 12 May 2023
 08:42:03 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Fri, 12 May
 2023 08:42:02 -0700
Received: from r-arch-stor03.mtr.labs.mlnx (10.127.8.14) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.986.37 via Frontend
 Transport; Fri, 12 May 2023 08:41:59 -0700
From: Max Gurtovoy <mgurtovoy@nvidia.com>
To: <hch@lst.de>, <sagi@grimberg.me>, <kbusch@kernel.org>,
	<linux-nvme@lists.infradead.org>
CC: <hare@suse.de>, <axboe@kernel.dk>, <oren@nvidia.com>,
	<ngottlieb@nvidia.com>, <israelr@nvidia.com>, Max Gurtovoy
	<mgurtovoy@nvidia.com>
Subject: [PATCH v3 1/3] nvme-fabrics: unify common code in admin and io queue connect
Date: Fri, 12 May 2023 18:41:53 +0300
Message-ID: <20230512154155.38694-2-mgurtovoy@nvidia.com>
X-Mailer: git-send-email 2.18.1
In-Reply-To: <20230512154155.38694-1-mgurtovoy@nvidia.com>
References: <20230512154155.38694-1-mgurtovoy@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D8:EE_|CY5PR12MB6201:EE_
X-MS-Office365-Filtering-Correlation-Id: 9371b4df-8af7-4a24-7e60-08db52ff737a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 	gTPDkiIX4P+bVqrn4tZtsI+FfuB1P5dq80UXYPEnSq2wY0/q7fJ/K24JTtNQlPYw1mYNl9Fop78FijqcT0q7VcqjCcJ6qMYpKUpe2VqFj1smTtiZVU0YVr7/5KkE19PVHjf8z9FHxAU8MbE2Hplk57HVb5xESzov7kDHKZTRaKJg2kZWme/bKD5b/YYEuslqJnIItILvKGaf3GK3sM/s5kh0t0pKrzRBSZ6AVZTHFLWNghHb0lURNyWFOJSvdtzjfDguguuZiCCuuHQds4Qgsl2BYAJlvZ6jxRnojhf6sSyYASKgkaVID+rdd71LXPTR/hO/aLNQGRcemnB+EGwGjvGacH6twvaosB2PX9JOXKK9OvtsJ5lC+zlxluTkrPL71U1ZdpWi3DwyWzQrp2UUaZI/BO84DEawfsISE1TyqqQQNABbBrtj2T6eD3T/RNkS0m/2IWwzg/o9Um+DcTt3aauHfv9oI0GwzCO6xK5UNMGTLb53w2ipyA4iE4kc1Ha4qDYhXL6Pcxabc5OZU9yGsZbqqqdKht4SY3drq98rhTTQ62tqZGaBE1ucbQXMR4twPQzM2lvcpzjTkRosVZUMFLyiH6FYfT6EnlZcs1IHFhXdFgCHYtgotxt2SfWVL5W0bYnslG1UigqwAVCM+aMHZuacI0OnkWvfVZ/1xHYtXgLENKg1GVY8pKyr56W/vr/XE1B49W08ZmBPTPUPQ5WX9joIixeCwDWDGJ3bRxD7ASm/PzWkYeBJ1/vWznQqb3Iu
X-Forefront-Antispam-Report: 	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(346002)(376002)(136003)(396003)(451199021)(46966006)(36840700001)(40470700004)(86362001)(36756003)(336012)(110136005)(54906003)(316002)(70206006)(70586007)(4326008)(478600001)(41300700001)(82310400005)(40480700001)(5660300002)(8676002)(8936002)(6666004)(2906002)(7636003)(82740400003)(356005)(107886003)(186003)(2616005)(26005)(1076003)(36860700001)(426003)(83380400001)(47076005)(40460700003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2023 15:42:10.9509
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9371b4df-8af7-4a24-7e60-08db52ff737a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: 	CY4PEPF0000E9D8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6201
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230512_084215_376015_F91DFF7F 
X-CRM114-Status: GOOD (  12.96  )
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

To simplify code maintenance, it is recommended to avoid duplicating
code.

Tested-by: Noam Gottlieb <ngottlieb@nvidia.com>
Reviewed-by: Israel Rukshin <israelr@nvidia.com>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
---

changes from v2:
- collected Reviewed-by signatures (Hannes & Christoph)

changes from v1:
- address comments from Christoph

---
 drivers/nvme/host/fabrics.c | 74 +++++++++++++++++++++----------------
 1 file changed, 43 insertions(+), 31 deletions(-)

diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
index 0069ebff85df..0c0172bdc4dc 100644
--- a/drivers/nvme/host/fabrics.c
+++ b/drivers/nvme/host/fabrics.c
@@ -349,6 +349,45 @@ static void nvmf_log_connect_error(struct nvme_ctrl *ctrl,
 	}
 }
 
+static struct nvmf_connect_data *nvmf_connect_data_prep(struct nvme_ctrl *ctrl,
+		u16 cntlid)
+{
+	struct nvmf_connect_data *data;
+
+	data = kzalloc(sizeof(*data), GFP_KERNEL);
+	if (!data)
+		return NULL;
+
+	uuid_copy(&data->hostid, &ctrl->opts->host->id);
+	data->cntlid = cpu_to_le16(cntlid);
+	strncpy(data->subsysnqn, ctrl->opts->subsysnqn, NVMF_NQN_SIZE);
+	strncpy(data->hostnqn, ctrl->opts->host->nqn, NVMF_NQN_SIZE);
+
+	return data;
+}
+
+static void nvmf_connect_cmd_prep(struct nvme_ctrl *ctrl, u16 qid,
+		struct nvme_command *cmd)
+{
+	cmd->connect.opcode = nvme_fabrics_command;
+	cmd->connect.fctype = nvme_fabrics_type_connect;
+	cmd->connect.qid = cpu_to_le16(qid);
+
+	if (qid) {
+		cmd->connect.sqsize = cpu_to_le16(ctrl->sqsize);
+	} else {
+		cmd->connect.sqsize = cpu_to_le16(NVME_AQ_DEPTH - 1);
+
+		/*
+		 * set keep-alive timeout in seconds granularity (ms * 1000)
+		 */
+		cmd->connect.kato = cpu_to_le32(ctrl->kato * 1000);
+	}
+
+	if (ctrl->opts->disable_sqflow)
+		cmd->connect.cattr |= NVME_CONNECT_DISABLE_SQFLOW;
+}
+
 /**
  * nvmf_connect_admin_queue() - NVMe Fabrics Admin Queue "Connect"
  *				API function.
@@ -377,28 +416,12 @@ int nvmf_connect_admin_queue(struct nvme_ctrl *ctrl)
 	int ret;
 	u32 result;
 
-	cmd.connect.opcode = nvme_fabrics_command;
-	cmd.connect.fctype = nvme_fabrics_type_connect;
-	cmd.connect.qid = 0;
-	cmd.connect.sqsize = cpu_to_le16(NVME_AQ_DEPTH - 1);
-
-	/*
-	 * Set keep-alive timeout in seconds granularity (ms * 1000)
-	 */
-	cmd.connect.kato = cpu_to_le32(ctrl->kato * 1000);
-
-	if (ctrl->opts->disable_sqflow)
-		cmd.connect.cattr |= NVME_CONNECT_DISABLE_SQFLOW;
+	nvmf_connect_cmd_prep(ctrl, 0, &cmd);
 
-	data = kzalloc(sizeof(*data), GFP_KERNEL);
+	data = nvmf_connect_data_prep(ctrl, 0xffff);
 	if (!data)
 		return -ENOMEM;
 
-	uuid_copy(&data->hostid, &ctrl->opts->host->id);
-	data->cntlid = cpu_to_le16(0xffff);
-	strncpy(data->subsysnqn, ctrl->opts->subsysnqn, NVMF_NQN_SIZE);
-	strncpy(data->hostnqn, ctrl->opts->host->nqn, NVMF_NQN_SIZE);
-
 	ret = __nvme_submit_sync_cmd(ctrl->fabrics_q, &cmd, &res,
 			data, sizeof(*data), NVME_QID_ANY, 1,
 			BLK_MQ_REQ_RESERVED | BLK_MQ_REQ_NOWAIT);
@@ -468,23 +491,12 @@ int nvmf_connect_io_queue(struct nvme_ctrl *ctrl, u16 qid)
 	int ret;
 	u32 result;
 
-	cmd.connect.opcode = nvme_fabrics_command;
-	cmd.connect.fctype = nvme_fabrics_type_connect;
-	cmd.connect.qid = cpu_to_le16(qid);
-	cmd.connect.sqsize = cpu_to_le16(ctrl->sqsize);
+	nvmf_connect_cmd_prep(ctrl, qid, &cmd);
 
-	if (ctrl->opts->disable_sqflow)
-		cmd.connect.cattr |= NVME_CONNECT_DISABLE_SQFLOW;
-
-	data = kzalloc(sizeof(*data), GFP_KERNEL);
+	data = nvmf_connect_data_prep(ctrl, ctrl->cntlid);
 	if (!data)
 		return -ENOMEM;
 
-	uuid_copy(&data->hostid, &ctrl->opts->host->id);
-	data->cntlid = cpu_to_le16(ctrl->cntlid);
-	strncpy(data->subsysnqn, ctrl->opts->subsysnqn, NVMF_NQN_SIZE);
-	strncpy(data->hostnqn, ctrl->opts->host->nqn, NVMF_NQN_SIZE);
-
 	ret = __nvme_submit_sync_cmd(ctrl->connect_q, &cmd, &res,
 			data, sizeof(*data), qid, 1,
 			BLK_MQ_REQ_RESERVED | BLK_MQ_REQ_NOWAIT);
-- 
2.18.1


