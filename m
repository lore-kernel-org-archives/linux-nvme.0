Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63F46C7EE2A
	for <linux-nvme@archiver.kernel.org>; Mon, 22 May 2023 08:37:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wbQCydM6FFg4KA1SmauOpDjEtpKo473YaF3/wEARYvA=; b=2GUA6059XShDSsS/RKSKj8DLy5
	4TWviqvO+oFjV3RbBCL3EORP6ZoXhEMHWoZPJ/tBsoxzgWVvaTMVee4WfmWXd2IRCcjrx/0gVj0u+
	8AaifgZ0ZgQ0IVuXRJzhHqQSohFGc8Tb8IyA0kddOdBCWpMu5HgSiGw9IgXVsgyXKiV9Anv1aPw1H
	xof6cGN0Ewf0FU8GA+2VIqT353hT9xNqVrXLc8wBfLu+F4MQ3nkQNU/6apFHQ10eUru9h3HECCkbp
	IB6b7oxxCEz/IH7ODJvvezzTs3ynYQgT7krbM4Gf8Ey9zCxGkKUYrTMRwr6AcnPZcZ8fP9RiNjrox
	bBGhhZ3g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q113B-005m5J-2q;
	Mon, 22 May 2023 08:37:53 +0000
Received: from mail-bn8nam04on20622.outbound.protection.outlook.com ([2a01:111:f400:7e8d::622] helo=NAM04-BN8-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q1136-005m2f-0A
	for linux-nvme@lists.infradead.org;
	Mon, 22 May 2023 08:37:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IE7/fIXBZnf5EtfnepHaCzuAbD9CBZ1d3n1JRvSQZ17cu9M1wBvSLVvxS+YOXiV/FfrAQ9I3+cz5rCkX+VzYidpp6PwCXdJPYlnPvXOz2wYWkZju1WD4qOGjaBGkLctDwST03nyd6Gnc1O0Y4FdlBHTI4x+bxy+4mBRknwYSQ9NH3ZhtLe1iM6N+COVsDyKY+hClRbOrPF8UFsT8MIOIxVrtLYd/6t1w0sN7DD3Bi7hz8oVne1sRMBbunOIJoj7swa/WZUdhesb6gG9wZT7PpQkh0SZ8xGJBk+9PD2EBky/uDefq/rBetZs7+YISXAf8lv0fdLpSaM7pgqa0GgU/Dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wbQCydM6FFg4KA1SmauOpDjEtpKo473YaF3/wEARYvA=;
 b=NiX8uJh5ljDTRudR9dTADgoOkaMqtaG8Us3AobpnzirUgAZ5f7+nc0mFMULPtfD98fnzQLJ5NNoM5Soy2beChcpBbbEnZmkJ1FOzdfqWL/40uZdwl6BKm46yu4DYi8K+Zkdf5n28fQxdY+zL9fsmL/HzF8WwGxVDgpCJG3Hp7iuYNpEBS2iU+gXcmgupjOPe2cHN9lkdxWVh+cj4exLz13lIdQFo76UN14Aor9fEh/IIFjSft96guIlV74aYNS63ocJIAtCLh1uiZ1rCXN2PJxJmrylVdmZxT2EnE3bGTiwlWo4VAVRHp2TkDJZh3dWadpdaso7P/2iHkYZBtFGbKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=suse.de smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wbQCydM6FFg4KA1SmauOpDjEtpKo473YaF3/wEARYvA=;
 b=EbUtFT5FITyL7VQmrV3/NZbCI5DRfc2gE/cpFDQLxYLC0HoiQSHJ+UT5rLJkACTwMqSkyJd/cRif+B72sKBOz1TmpMVXZbUMv7Du7/wetBHXF/+O1ZcleI9Gx++MxjSPZVGurL4QtxRFR9Omyhqkc5AYX2WgQzqVV/ZpkAABIzdRrndJeWLOAzsPJwtGhxwC0rbx9kp1Y/Ka/jXVU8IHUDZvBvIF3Hlwt4IMjrk0McThny1SadLJ7LhkpvLgprX8NcGU2J1mtC30hzjRUHjx/+fes1IP5JF4toRQRha166VoTwOYHpr/PbpoIHbmNwx6vxOWiGcdGIzz0h3sMK57Pg==
Received: from BN9PR03CA0367.namprd03.prod.outlook.com (2603:10b6:408:f7::12)
 by BN9PR12MB5162.namprd12.prod.outlook.com (2603:10b6:408:11b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Mon, 22 May
 2023 08:37:43 +0000
Received: from BN8NAM11FT072.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f7:cafe::94) by BN9PR03CA0367.outlook.office365.com
 (2603:10b6:408:f7::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28 via Frontend
 Transport; Mon, 22 May 2023 08:37:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN8NAM11FT072.mail.protection.outlook.com (10.13.176.165) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6411.28 via Frontend Transport; Mon, 22 May 2023 08:37:43 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Mon, 22 May 2023
 01:37:31 -0700
Received: from dev.nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Mon, 22 May
 2023 01:37:30 -0700
From: Chaitanya Kulkarni <kch@nvidia.com>
To: <hare@suse.de>
CC: <linux-nvme@lists.infradead.org>, <hch@lst.de>, <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>
Subject: [PATCH 1/3] nvmet-auth: use common helper to check secp/spsp
Date: Mon, 22 May 2023 01:37:11 -0700
Message-ID: <20230522083713.107001-2-kch@nvidia.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230522083713.107001-1-kch@nvidia.com>
References: <20230522083713.107001-1-kch@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT072:EE_|BN9PR12MB5162:EE_
X-MS-Office365-Filtering-Correlation-Id: d71a873d-01d1-47a9-0e1d-08db5a9fcf94
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 	3DkVuIPeCKSpUGMG5/yJGs05+rM3+VERSGIb0K39NKJLTOaeuDLsHLw7erGaxmvU1K5QSLR7Inx321YXZ/tbscROiE5TEJkBgRc/67Y/xxaG1uJ6upKZ3/324N4n19AvDhNoirTV5+WImBp9YETmqSUrPnKv1xzatHT2Pl2v5j0j00jLEnyM65QPRtpk2LS8rI+Oaa+rXeL8yk1zsegiEHgqiPSooznPJQwJwLtar5rmBS+6Tw4f32EbWfFzaESkaxQHcbPF0NrJEM9IwhWKD7CAb9ThcXLB6NycKgfdF7BT3uRrs6tq1kKEJwxrtS1x0UeuPWMdngDUInTQ4akITmXyLVbyPSt8Ah0m/kuyRwt1Fp3bdokt/vrzn2bAM3LXRRvIJ3BGOyE5queFxNp153EnabMwPqTbNKPhNIelUQ0gT7TWYEVHYB+e3xfzraNiUp7PFDP0Gfyu8f20Ozh/s82n0kNs+bMCrAEiS7RiZq1sByh3FPLxHhpEePVxggMIHU+kxpTYYrs3Usr9bEMXD0Jk4ed8Jeem5RDHIM8cv8Vib+vUlQKs9f9qib1dmDKF6Hta+HiQVSI+dSeEu5qwKVcMuWTvFmuiDLTOqg9vdlVi3vje8hozfx+q0sH/kl4vweK9NgbAYhgubRmsAMfML/s/MPIqstaZVwe/WrAI+ndnNgpacmEg9USiR01F8/uj3GFsN3kjGaNffwdIWIadY92XEDxiOk1cS3JgurGsetOOO+upUfuz0r2qAaVUI3GL
X-Forefront-Antispam-Report: 	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(136003)(346002)(376002)(451199021)(36840700001)(46966006)(40470700004)(8676002)(8936002)(5660300002)(36860700001)(47076005)(82310400005)(83380400001)(186003)(16526019)(26005)(1076003)(336012)(426003)(2616005)(107886003)(7636003)(356005)(82740400003)(40460700003)(41300700001)(6666004)(7696005)(40480700001)(70206006)(70586007)(316002)(6916009)(4326008)(36756003)(478600001)(54906003)(2906002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2023 08:37:43.0068
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d71a873d-01d1-47a9-0e1d-08db5a9fcf94
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: 	BN8NAM11FT072.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5162
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230522_013748_092907_B8A47C33 
X-CRM114-Status: GOOD (  12.35  )
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
---
 drivers/nvme/target/fabrics-cmd-auth.c | 60 +++++++++++---------------
 1 file changed, 24 insertions(+), 36 deletions(-)

diff --git a/drivers/nvme/target/fabrics-cmd-auth.c b/drivers/nvme/target/fabrics-cmd-auth.c
index 6c9a1ce6068d..6ad322b3d0a9 100644
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


