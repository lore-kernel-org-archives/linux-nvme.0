Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 490D2C77B7C
	for <linux-nvme@archiver.kernel.org>; Wed, 10 May 2023 18:03:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:CC:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=NP/UlbsSLondYTAxKSsM5vPbdGKCCbNjUjQUArqJ4hg=; b=3jPcelzuz1LdaaWvjWka9dkszq
	7SpFDr0u8tkYjPHU1+kyJaB+Y5comGlq8V6O4d8IrgsFaCSLL+Y9Hl87UsFktL2yrwYzjQieyP8Wt
	kJnHMW+O2edCEik/vyeTdRnRYcb6MZVdGaRd+m8IfLID7nAyxw6/M55Py+UyClG4RoOocMdzKvocR
	L88y4Dm2zoLnrCvQF4T0U2/SfPmd0/FWCRUP0Bt/d7j8xeQbMxomWQvqKsuQKDUPBZMV5GJmgyptq
	WZbZ9PCmcU8uzQAr70y7801hOgSjNPS0G6hbnayZ553Tjngxm9jVXmGyRQbOf2oPiwRgBZHiLG5S2
	VTg5xvIQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pwo9T-006hpR-0P;
	Wed, 10 May 2023 18:02:59 +0000
Received: from mail-dm6nam10on2062f.outbound.protection.outlook.com ([2a01:111:f400:7e88::62f] helo=NAM10-DM6-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pwo9Q-006hoC-0h
	for linux-nvme@lists.infradead.org;
	Wed, 10 May 2023 18:02:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tfg/4Udtn1mHv1YOBRGgrVEgwtGAVIHtttcV8Ec7t08Zd4A79UqRUmaf/sN5XsuJWeTIVq6VabJW78lIUiK5jR/Rcgq2WB7j4G9B3Fp7uRwifpv3ccQU8gdav713a0BJOarjp4YtONM13mtw3sghdFft/kEK+ieZANIuGKYLIs7UweDc3vGUf6ZLEaLeQyKuEim8BSuysSFSSXR2lg7zdzGFmTsc60QjVXb1Sa2BhFee+4Arq6zUw51U/ivbzmgGb05sSfn5cO72HPXSSUd0QTQ4pibr7U4vSHPkMlktW+9ds8JemGxn2LlR6bAppgBFF9UKZtdO+Cl4afX/N28E/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NP/UlbsSLondYTAxKSsM5vPbdGKCCbNjUjQUArqJ4hg=;
 b=j/RBw5N5ZFgbYSSr4PHZLhAGg0BBjy/D5rXztOkcDqAxLRy72RQ29I3PtAiaKiBwkcciXDcknN4dLAbhjG5p8OpaObtzLz8RNhNcZkCts9AIQKSmr3Xe1bagUgo+yAWEoMEipNsiae9KA3ILSiuisKR2au6P2e85Wh3vOrQDhi8YkzcMR5bol580XYKee3JeWVKu/OX1tPJu5ilKYhl8a4zEE/LmikEAwoi8VuooFWpNIRzCpUdAzt/xI5d6VaMpGRDoNytfW+kyI1oKbT6z1I4SVHDYbR9YlAgHmSMFh7szWIY25irPhNO7ZV6L3nXznhxRGpH85KcsYdcATO22gA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=lst.de smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NP/UlbsSLondYTAxKSsM5vPbdGKCCbNjUjQUArqJ4hg=;
 b=HUdyCE3CEl1GVaoxw4t35pcO/l60WHk9Ltz4Pgi9aJpxBALlSGzh/OKo09s0daiw4n1C8ojbe+eJVdgl97ezeq6xM5+zuz2fR1BlFsS9NBFLUg2L3UgAgXS2m4vgvQXcb7Z/jonhuc02wC6u2rJZuqk2gg4P0sU9AO34NNqFDFECe3VcKcN0PAvDJiEXBjz7CJ+MyU42kjcka5+PG1NpofhkoB5Bt7RNFw6ZxdSeA3jJzjDbH2o19Dmfq+ZOHk4OOn1eyshQJfRxAzeNFauhmvIQYhbYGrdQUMs7mJNoUq9SvP/C9rUC59Y3vyosc3+UUKk1o6OhyzMJPt0GHBLUyg==
Received: from MW4PR04CA0235.namprd04.prod.outlook.com (2603:10b6:303:87::30)
 by SA1PR12MB7367.namprd12.prod.outlook.com (2603:10b6:806:2b5::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.31; Wed, 10 May
 2023 18:02:50 +0000
Received: from CO1NAM11FT015.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:87:cafe::3d) by MW4PR04CA0235.outlook.office365.com
 (2603:10b6:303:87::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.20 via Frontend
 Transport; Wed, 10 May 2023 18:02:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1NAM11FT015.mail.protection.outlook.com (10.13.175.130) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6387.21 via Frontend Transport; Wed, 10 May 2023 18:02:49 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Wed, 10 May 2023
 11:02:38 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Wed, 10 May
 2023 11:02:38 -0700
Received: from r-arch-stor03.mtr.labs.mlnx (10.127.8.14) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.986.37 via Frontend
 Transport; Wed, 10 May 2023 11:02:35 -0700
From: Max Gurtovoy <mgurtovoy@nvidia.com>
To: <hch@lst.de>, <sagi@grimberg.me>, <kbusch@kernel.org>,
	<linux-nvme@lists.infradead.org>
CC: <hare@suse.de>, <axboe@kernel.dk>, <oren@nvidia.com>,
	<ngottlieb@nvidia.com>, <israelr@nvidia.com>, Max Gurtovoy
	<mgurtovoy@nvidia.com>
Subject: [PATCH 1/3] nvme-fabrics: unify common code in admin and io queue connect
Date: Wed, 10 May 2023 21:02:29 +0300
Message-ID: <20230510180231.18865-2-mgurtovoy@nvidia.com>
X-Mailer: git-send-email 2.18.1
In-Reply-To: <20230510180231.18865-1-mgurtovoy@nvidia.com>
References: <20230510180231.18865-1-mgurtovoy@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT015:EE_|SA1PR12MB7367:EE_
X-MS-Office365-Filtering-Correlation-Id: ede7ddd0-fca2-4b3d-190b-08db5180c477
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 	tZokgFr9CDXOO1+j9edFXy/dKcqkGWT+5Dz200FNVfebU1vVUhKliMQ79svG+GwUgthlhk5SOW2l0N7NIjIHVdqVfl3Tz3nqfq/IFQ/uGvEB6XMK4SyWmqLLxEWo1QcT0/zdy0bH7cEOdcUsq/4kXh75Oiw1TKNdAEx2qFXK3eKHdpVW0EXgjXue7at8RXZCWj/Dy5kEj4ejwLheAyFtS5gj3XBQLQWW/X7cy16UW/eT3r4UrxELsH8Mp0gaiXbJA8j3riyiD2YLjKzgkIDjC9CIjU2kTJRmjYwhliv9rgecytqp+OgKk4y5vMMQsLW6mzQRoAR+37PubsN7xjF/N6fcclSVgH8vf51D1dr+XPHvT4/WUl9IUKyGp/hJEOSjVAbzpRQyDKxLGWUtyHzrlBotMD5lWbc0oGqRvZ0RpNf72TI+AsGP7eJIPj9eGTbYvW8yhE2UW0JuYGP3TicAmMwyMfTsV6jviamEpR8JzK1TgxdA8fnew2TNBneVDX0FJVxEeWMQ0r2a+y2bzjt+jlv5aiIGZ3GqiLfrmDriSRHhMewGK3BeHpskpDbjynLQbbIlL47n9Ft4oUf0Wk9Pwv1LqWzWuh2eXNRDy7wsKNqcY5f4oPuaJY9DCuF80gDNfKDExkj4JtzJndExttmIQRH0wMBMK+0A7wUPDCsbiC+TcMh59IeVbt2gp3M/1wWNKt12dmzlqs2dW42iO+Ka8Q==
X-Forefront-Antispam-Report: 	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(346002)(39860400002)(376002)(451199021)(36840700001)(46966006)(40470700004)(40460700003)(316002)(4326008)(70206006)(70586007)(478600001)(54906003)(110136005)(6666004)(426003)(36756003)(86362001)(83380400001)(36860700001)(1076003)(26005)(47076005)(107886003)(2616005)(8936002)(5660300002)(82310400005)(40480700001)(8676002)(41300700001)(82740400003)(186003)(7636003)(2906002)(356005)(336012);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2023 18:02:49.5922
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ede7ddd0-fca2-4b3d-190b-08db5180c477
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: 	CO1NAM11FT015.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7367
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230510_110256_257621_0005635E 
X-CRM114-Status: GOOD (  13.05  )
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
 drivers/nvme/host/fabrics.c | 75 ++++++++++++++++++++++---------------
 1 file changed, 44 insertions(+), 31 deletions(-)

diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
index 0069ebff85df..d11db06d293b 100644
--- a/drivers/nvme/host/fabrics.c
+++ b/drivers/nvme/host/fabrics.c
@@ -349,6 +349,46 @@ static void nvmf_log_connect_error(struct nvme_ctrl *ctrl,
 	}
 }
 
+static struct nvmf_connect_data *nvmf_connect_data_prepare(struct nvme_ctrl *ctrl,
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
+static void nvmf_connect_cmd_prepare(struct nvme_ctrl *ctrl, u16 qid,
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
+		 * For admin queue, set keep-alive timeout in seconds
+		 * granularity (ms * 1000)
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
@@ -377,28 +417,12 @@ int nvmf_connect_admin_queue(struct nvme_ctrl *ctrl)
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
+	nvmf_connect_cmd_prepare(ctrl, 0, &cmd);
 
-	data = kzalloc(sizeof(*data), GFP_KERNEL);
+	data = nvmf_connect_data_prepare(ctrl, 0xffff);
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
@@ -468,23 +492,12 @@ int nvmf_connect_io_queue(struct nvme_ctrl *ctrl, u16 qid)
 	int ret;
 	u32 result;
 
-	cmd.connect.opcode = nvme_fabrics_command;
-	cmd.connect.fctype = nvme_fabrics_type_connect;
-	cmd.connect.qid = cpu_to_le16(qid);
-	cmd.connect.sqsize = cpu_to_le16(ctrl->sqsize);
+	nvmf_connect_cmd_prepare(ctrl, qid, &cmd);
 
-	if (ctrl->opts->disable_sqflow)
-		cmd.connect.cattr |= NVME_CONNECT_DISABLE_SQFLOW;
-
-	data = kzalloc(sizeof(*data), GFP_KERNEL);
+	data = nvmf_connect_data_prepare(ctrl, ctrl->cntlid);
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


