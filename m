Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0163DC77B7C
	for <linux-nvme@archiver.kernel.org>; Thu, 11 May 2023 16:55:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:CC:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6SLdZM9mSaYb+wijnynz/vGsxonMwcMbMdZGetCEbE8=; b=QO/qXzuVEFV88ScLFdJZmuCyOK
	c9ol6dCvZz9X9gMCdENQNW7ag4Epv/4B5vrjzbQyhcl1FxMDUj0vkAdxqpNZx0RdBd/FvI1pfo3Sb
	yd4Kp9ct8nKDZDlDKYnSZrPX4UWrKnecDg6mMhHVpjULHjeycqCl9iQ+PrQRkuqFe/s+QQCNDrGIo
	hUsp0xBkeVyjTo4TvtrosdOmBahxyeabcFohbKentUvdvqUYoPxOrBF3itkbEo94gXZBbwTop2eLz
	EmGFCxbXIG5PMaTWskwULmjBZzrI/Oo2Ibvc1NySAAnpKgeHpvtTc452LBFH61c5Jn0asIHmdQgrn
	AeeOGUAw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1px9ZX-009QvR-01;
	Thu, 11 May 2023 16:55:19 +0000
Received: from mail-bn8nam11on20600.outbound.protection.outlook.com ([2a01:111:f400:7eae::600] helo=NAM11-BN8-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1px9ZT-009QtB-2y
	for linux-nvme@lists.infradead.org;
	Thu, 11 May 2023 16:55:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kk9jljpXVUjR82nVOwh2oPLt+no94Mjr3SxPiwILueCViUZPUDnm96vW7sCEjD/2POORQMLGQO7ZewUuuqFbusBjMA0Qr9KXfSI+nHo25AEFW0m3B/d9kJGMKWflWLAqMJlYMql8+RE++HNxVUUcJ/KtvNANtYG40JNH1YCDo6VwqqEy1ZE49bp4fV25ddHJOTsupkwPAyOmsgZkSyE/cS1QuWTZPCmgHTRifSLSAlyhe9NUVvMqxyqzBIMFxxmB6tRduoH8g+t+lYlFpOJmXRq9byqZ1YljEvPoscK8iuHQw4NHIYgX2uGh8zJUSADGxDGipWl3PnF/HA4V3Oq86w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6SLdZM9mSaYb+wijnynz/vGsxonMwcMbMdZGetCEbE8=;
 b=PJo4K5LcdEG6eCFDxbUVdI9aHJKRjfGENZ53YI1BeqS0rguUNgwqONOBngzo/SajcEj91ifLe8KAcodnD7x/cOxIzBX5AYQlGh2honbskLsAOdwVMjIy7iQakkn0lPziw7SGIxWof9u1oYIyNQcN9iSNHn6yn5kboI/zNG1AeCEipviDRA0EyWcI+wHXE+H7LNIDrxq94XYfXM89s/dETwPCeMCjDsjdXNtGdZQHQMYWBBzuzGDFxGgmBQprr7CSK2TSvFmVm/ZGbnZLYjgGNoWcJOyWQXCbRWp0/nmwqFnxGNnceeqTWQSHv2uMioyBqDLZZ5Tx9mBATWt5B5RRjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=lst.de smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6SLdZM9mSaYb+wijnynz/vGsxonMwcMbMdZGetCEbE8=;
 b=A2/ZtKYZARGmjnCpO9bkhZdyRFWYikh4kgQE9eAP4+YoxybMocbNq/2G000f8hLK05bFD8JTArIh4itctCmJq73/mhI/BE/35mws0iySyz61DQcH0sKJNOrmZqdui39hEvWvpVU4okvgpbSFcLrnCtu2ANm2pCYnSBJMc674DiCea4hyQ4/ly4nO5EnkYXGhbZG4HvCPNVtt21QFzjbFid3k2fmXKQVJksHix55EupZUb7hmtMxc50eZ1g/q1+Lglgik3qYy0eP1kBjJVeTPtghbSg+06DHguJBDPfLkiI+wBNPq3E/3Be5+kRL9CFlC9SldaiqeQyYr9ZnajGulvA==
Received: from BN8PR04CA0033.namprd04.prod.outlook.com (2603:10b6:408:70::46)
 by PH7PR12MB6694.namprd12.prod.outlook.com (2603:10b6:510:1b1::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.19; Thu, 11 May
 2023 16:55:02 +0000
Received: from BN8NAM11FT004.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:70:cafe::35) by BN8PR04CA0033.outlook.office365.com
 (2603:10b6:408:70::46) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.22 via Frontend
 Transport; Thu, 11 May 2023 16:55:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN8NAM11FT004.mail.protection.outlook.com (10.13.176.164) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6387.23 via Frontend Transport; Thu, 11 May 2023 16:55:01 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Thu, 11 May 2023
 09:54:48 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Thu, 11 May
 2023 09:54:47 -0700
Received: from r-arch-stor03.mtr.labs.mlnx (10.127.8.14) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.986.37 via Frontend
 Transport; Thu, 11 May 2023 09:54:45 -0700
From: Max Gurtovoy <mgurtovoy@nvidia.com>
To: <hch@lst.de>, <sagi@grimberg.me>, <kbusch@kernel.org>,
	<linux-nvme@lists.infradead.org>
CC: <hare@suse.de>, <axboe@kernel.dk>, <oren@nvidia.com>,
	<ngottlieb@nvidia.com>, <israelr@nvidia.com>, Max Gurtovoy
	<mgurtovoy@nvidia.com>
Subject: [PATCH v2 1/3] nvme-fabrics: unify common code in admin and io queue connect
Date: Thu, 11 May 2023 19:54:39 +0300
Message-ID: <20230511165441.30005-2-mgurtovoy@nvidia.com>
X-Mailer: git-send-email 2.18.1
In-Reply-To: <20230511165441.30005-1-mgurtovoy@nvidia.com>
References: <20230511165441.30005-1-mgurtovoy@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT004:EE_|PH7PR12MB6694:EE_
X-MS-Office365-Filtering-Correlation-Id: f886802c-4613-4c39-5532-08db52407663
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 	4ECYgYlbibg90Ak7OnAsKalucO3N5BPMufQOfUkgAQwB15jqCjB/zlxgoIUvbfY0OMYujvmcQ0vlFkI6RcjtZz85gJjpoYCDl2Ou0zDOKn87XO+n++fz6q2s8URkMNnNn9wCpfZ7DfeoP0+4k/IOB1AzRm2GgHOKnnJ0ombE3IZ/H7yr4Uy0AGwiYaY4etWEqyikJM+U596ygWaziUqqcULpTjmqTYoeuseOGAc5jRYNo8oOSOp98vwNQoY7fha/YnSclgsj1BlGRFwpgc9/5lLbFTPDQ8oukWXhV6MzlLoYy0eYkNb8YykG4QQKUlNRHto9uBFppUQw+V12YxRLF/tGvFou5KzigeMjwzfxpaDJiraaycOlblILwoGViyvbMvFKgjX7rgvVguohWctr5yAng20lbODTEckkivZCeFqa6ISIIbuGbMT321wR6BQoMrOEUBns3zbpBLKwgmRK/5VpFbJxMB3oBu1cU/wrYwkraaPlpht6UHqDOWZSNriGXG5gxqTdruNVOu/K6Jgz5AxxlzsOoeEEZcKtkIIC2cKVFRH8wT+AdgK18ayLI5MTcAtdAGMXUrvTcQKDv8X3Pr0K9Vvb5LFIwjxjmfQhTYEJ5wAYdzMlfZDPE8y+dCyc4gAVUnSgvOPWLO32hHqc7bFg68W9pIf3UhT4BHM1PSVSta8d/yRX07fb3Cyr624MWoVb4SQd9ACylHB+yDzm9EMUr8O6O0nmxmA1/Z2YkEKsoBTzZ+GpllrvdX8YDJWM
X-Forefront-Antispam-Report: 	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(136003)(39860400002)(396003)(451199021)(36840700001)(40470700004)(46966006)(2616005)(107886003)(47076005)(83380400001)(336012)(426003)(36860700001)(40460700003)(40480700001)(186003)(7636003)(41300700001)(70586007)(70206006)(8676002)(5660300002)(8936002)(356005)(82740400003)(2906002)(316002)(4326008)(54906003)(1076003)(478600001)(86362001)(110136005)(26005)(36756003)(82310400005)(6666004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2023 16:55:01.8788
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f886802c-4613-4c39-5532-08db52407663
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: 	BN8NAM11FT004.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6694
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230511_095515_965283_B2042257 
X-CRM114-Status: GOOD (  12.24  )
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
Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
---

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


