Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85A6CC7EE2A
	for <linux-nvme@archiver.kernel.org>; Mon,  5 Jun 2023 06:45:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xBq6AtpqrRjVRHtTtHTId0fGqlHUj2/V9hdmD04Mtis=; b=tPgmaNqOBLBRMOWOlwdiIiPqmM
	1MXuclwyDSJg+cu5gU3Jw6yqZ6ds7Y0D41C2vmmKiwFsUMB8t2PijEvv0NGmWMaJUO/IL9zQuaxLV
	1Y4CwJsFBRz2X1M/krhMjOk77biPkuWKIpArpkSANcWg0ZQ3OPVMXh+UIAJrH17X4RYC4XrTVx7D1
	YiJSDUF+4ams7RNzegtk7t6sj7W+VOLy1U070FTqNwFJ1OzTx8oO6khSjyK8ZiKCJXKaoiggL9m4R
	/XWIuYNCAfXT0ceETsW+xZx3JDsaA5QonPtHVyKzBGj6hGuQk+31CU+ssjACPZQG+XL/QdYGYqzWq
	wB0J+V9A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q63xw-00EQ5v-0v;
	Mon, 05 Jun 2023 06:45:20 +0000
Received: from mail-sn1nam02on20602.outbound.protection.outlook.com ([2a01:111:f400:7ea9::602] helo=NAM02-SN1-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q63xs-00EQ4E-2g
	for linux-nvme@lists.infradead.org;
	Mon, 05 Jun 2023 06:45:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Oc+9BysSJ2gnR6xb9+jfNkR0hMX76WTft9lrDK72Bm5ke8zF7uZM77oPXweA73XPgsGv/oqQOpriQxI05IZDrr8AYNm1jykUzLjBZxonjX8ZEefLgi3kpAGNwnxvaWVx1hDUnrwQTFsqsxnctapNhgzhOvnMqHL85/gl3nYjyu09apruOyAIE5iI4OClzmigZJeYvt/ftkyJ6jMtEWNl9dRwUTJB3yqC9lGZvFy7btDpTspUTY39iPTiZXCtYRhRj/Aj8Q2Vm8YYAJUpQ8eY6kFcNKrZkhl7zYLNdM+spk+F6ZjJM58ZFsG8q+zzUF/7yc+/GMvfnOQKJDtVWiXJeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xBq6AtpqrRjVRHtTtHTId0fGqlHUj2/V9hdmD04Mtis=;
 b=I+fU7INwBpCajCZjpJ4IBNoqGvcbbCdPVzKEadvPFcA3N/jWzxRp+TnLeGwMVDUeflto0Z9oj/3U8oXPAQ+KIKsxa9rPsrCn1WJepQ7ZZjsYdVvlaGH51fBdtIgwv812Rd8aA0LXutly4dgzhmOf493HedUJzkvS0IcewKenvEjSXLGI+sbkxF5fnHNE5NNqp4XaIkcMJzMqunJd0JGWNpGb1nuzWQ9gFTrGCLWMv2wx51aD9Usx42V7GhOFZx79bYa3jU8OmtvTLldvjJIy8JeOwS905dM7o1IOmtCzVpt7sWvKFRZwj5GjC2rYaTGcBcvuKw7mwjjCoyC+Xsfl5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=suse.de smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xBq6AtpqrRjVRHtTtHTId0fGqlHUj2/V9hdmD04Mtis=;
 b=lbrkojPTS0FvfyBZEGnZtWON5baoczT7Gddo1sQp/fZq2jXowAU2k4I8taRm/rmgHxbXnUX9Vo6PzQli87KYPEn2b6j6JO+f9JshXndD9X1CiFUolTyr6vDspkujSxjtBJdjLykpp6cScvcvYr4YjvlMCM/B6ulUW3IUnxNS43e7YT8jBTkdIDqiw9qEHc7EeeVWp6oc2mvlqs0qKxBrlKsaIjSqZPKrU+vv+P9fIz7/MytzNVkA8jXGybgb90u1RQDy85tzqIV+nKHX4lVJNRFPkKV5KL/7RXj4KvvYimm03ex04894AA4xnqmIfPtpZ303JKv/VBoUwBPm2vd/1Q==
Received: from MW4PR03CA0306.namprd03.prod.outlook.com (2603:10b6:303:dd::11)
 by SJ0PR12MB6878.namprd12.prod.outlook.com (2603:10b6:a03:483::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Mon, 5 Jun
 2023 06:45:10 +0000
Received: from CO1NAM11FT048.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:dd:cafe::69) by MW4PR03CA0306.outlook.office365.com
 (2603:10b6:303:dd::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32 via Frontend
 Transport; Mon, 5 Jun 2023 06:45:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1NAM11FT048.mail.protection.outlook.com (10.13.175.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6455.32 via Frontend Transport; Mon, 5 Jun 2023 06:45:09 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Sun, 4 Jun 2023
 23:44:56 -0700
Received: from dev.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Sun, 4 Jun 2023
 23:44:55 -0700
From: Chaitanya Kulkarni <kch@nvidia.com>
To: <hare@suse.de>
CC: <hch@lst.de>, <sagi@grimberg.me>, <linux-nvme@lists.infradead.org>,
	<kbusch@kernel.org>, Chaitanya Kulkarni <kch@nvidia.com>
Subject: [PATCH V2 1/4] nvmet-auth: use common helper to check secp/spsp
Date: Sun, 4 Jun 2023 23:44:31 -0700
Message-ID: <20230605064434.45233-2-kch@nvidia.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230605064434.45233-1-kch@nvidia.com>
References: <20230605064434.45233-1-kch@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT048:EE_|SJ0PR12MB6878:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a1a7594-0501-4c5e-a48d-08db659067ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NjBbFrJajd8BuepV/ThQcQ9SGdE/YGFidb0oakmm1H367NhTS2llRoIoQLxX/Bjnkgn/idkkEvqbL/CSvaiqVAHsm9/UPZmVReLqNAWMtAbaWZmLPOsP/UvFwYo8NfKdasb2lvpj9S2fB/oMwbGkhhCiJIb8DtZ+ibWGILFw52f4PxBymuHQKeYqk54/EsdakZwA61ZLsivdBQQU2GO4ztceH1YSaFOEr3IYsKkHpSF2pO2OL/lBgAfP3Mwmfy/4PjD1vDMo5zgnJiCEVbZ1YrgK+PtpA1KX2hO2xpVMA3TnVDKOtLfkum+TlWsJlr60b+ySBfavPxKshBVLm5jWurBGcSVFkWZeAtBKNeWJAtC4/wQ8fhS9pJeMP02uAeNpFXdiGUo6qTphRcBQMsfgDmnhUN65KQfIsMvu5u8WANpZbqoH5ggfgTZs/yDt0ZAB30QswcxdXZkV1eShTRA9N1qxevH9N8fzipr3ehS5CGqObaM2NJSYGBBHCaTh852kyu/HZbVrndlcQX2b9KGqatDDsLgri8/x2hFL7ya4UOUTRS8dHhEmVkJd3wubOVMnqK9IajHxW4a7h9EC4TPquEBF2VDXumVfGru90nEJehhu5d77TMNg0SSIj+GLzRA6VPH0XeJq60MMpd5EzmZ5e4IYWCIiJ7iOkYQV22TaqR1U9+bYqZK6ptrhrJBa83l3ZHZqI/g+jekZYvFJUfIskbE3nSoPhqajz/K1TaaNOxFoGtm+d384tiyYDO2PrE3G
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(136003)(346002)(39860400002)(451199021)(36840700001)(46966006)(40470700004)(47076005)(83380400001)(336012)(426003)(82740400003)(54906003)(40480700001)(478600001)(8676002)(8936002)(41300700001)(316002)(70586007)(70206006)(356005)(7636003)(5660300002)(6916009)(40460700003)(4326008)(36756003)(6666004)(7696005)(2906002)(36860700001)(82310400005)(107886003)(16526019)(186003)(1076003)(26005)(2616005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2023 06:45:09.5997
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a1a7594-0501-4c5e-a48d-08db659067ff
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT048.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6878
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230604_234516_874507_07F89F39 
X-CRM114-Status: GOOD (  11.47  )
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

Add a common helper to factor out secp/spsp values check in
nvmet_execute_auth_send() and nvmet_execute_auth_receive().

No functional change in this patch.

Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/target/fabrics-cmd-auth.c | 60 +++++++++++---------------
 1 file changed, 24 insertions(+), 36 deletions(-)

diff --git a/drivers/nvme/target/fabrics-cmd-auth.c b/drivers/nvme/target/fabrics-cmd-auth.c
index 586458f765f1..42594e086de7 100644
--- a/drivers/nvme/target/fabrics-cmd-auth.c
+++ b/drivers/nvme/target/fabrics-cmd-auth.c
@@ -12,6 +12,23 @@
 #include <crypto/kpp.h>
 #include "nvmet.h"
 
+static u16 nvmet_auth_check_secp_spsp(struct nvmet_req *req)
+{
+	if (req->cmd->auth_send.secp != NVME_AUTH_DHCHAP_PROTOCOL_IDENTIFIER) {
+		req->error_loc = offsetof(struct nvmf_auth_send_command, secp);
+		return NVME_SC_INVALID_FIELD | NVME_SC_DNR;
+	}
+	if (req->cmd->auth_send.spsp0 != 0x01) {
+		req->error_loc = offsetof(struct nvmf_auth_send_command, spsp0);
+		return NVME_SC_INVALID_FIELD | NVME_SC_DNR;
+	}
+	if (req->cmd->auth_send.spsp1 != 0x01) {
+		req->error_loc = offsetof(struct nvmf_auth_send_command, spsp1);
+		return NVME_SC_INVALID_FIELD | NVME_SC_DNR;
+	}
+	return NVME_SC_SUCCESS;
+}
+
 static void nvmet_auth_expired_work(struct work_struct *work)
 {
 	struct nvmet_sq *sq = container_of(to_delayed_work(work),
@@ -185,26 +202,12 @@ void nvmet_execute_auth_send(struct nvmet_req *req)
 	struct nvmf_auth_dhchap_success2_data *data;
 	void *d;
 	u32 tl;
-	u16 status = 0;
+	u16 status;
 
-	if (req->cmd->auth_send.secp != NVME_AUTH_DHCHAP_PROTOCOL_IDENTIFIER) {
-		status = NVME_SC_INVALID_FIELD | NVME_SC_DNR;
-		req->error_loc =
-			offsetof(struct nvmf_auth_send_command, secp);
-		goto done;
-	}
-	if (req->cmd->auth_send.spsp0 != 0x01) {
-		status = NVME_SC_INVALID_FIELD | NVME_SC_DNR;
-		req->error_loc =
-			offsetof(struct nvmf_auth_send_command, spsp0);
-		goto done;
-	}
-	if (req->cmd->auth_send.spsp1 != 0x01) {
-		status = NVME_SC_INVALID_FIELD | NVME_SC_DNR;
-		req->error_loc =
-			offsetof(struct nvmf_auth_send_command, spsp1);
+	status = nvmet_auth_check_secp_spsp(req);
+	if (status)
 		goto done;
-	}
+
 	tl = le32_to_cpu(req->cmd->auth_send.tl);
 	if (!tl) {
 		status = NVME_SC_INVALID_FIELD | NVME_SC_DNR;
@@ -432,26 +435,11 @@ void nvmet_execute_auth_receive(struct nvmet_req *req)
 	struct nvmet_ctrl *ctrl = req->sq->ctrl;
 	void *d;
 	u32 al;
-	u16 status = 0;
+	u16 status;
 
-	if (req->cmd->auth_receive.secp != NVME_AUTH_DHCHAP_PROTOCOL_IDENTIFIER) {
-		status = NVME_SC_INVALID_FIELD | NVME_SC_DNR;
-		req->error_loc =
-			offsetof(struct nvmf_auth_receive_command, secp);
-		goto done;
-	}
-	if (req->cmd->auth_receive.spsp0 != 0x01) {
-		status = NVME_SC_INVALID_FIELD | NVME_SC_DNR;
-		req->error_loc =
-			offsetof(struct nvmf_auth_receive_command, spsp0);
-		goto done;
-	}
-	if (req->cmd->auth_receive.spsp1 != 0x01) {
-		status = NVME_SC_INVALID_FIELD | NVME_SC_DNR;
-		req->error_loc =
-			offsetof(struct nvmf_auth_receive_command, spsp1);
+	status = nvmet_auth_check_secp_spsp(req);
+	if (status)
 		goto done;
-	}
 	al = le32_to_cpu(req->cmd->auth_receive.al);
 	if (!al) {
 		status = NVME_SC_INVALID_FIELD | NVME_SC_DNR;
-- 
2.40.0


