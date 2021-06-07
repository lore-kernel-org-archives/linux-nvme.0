Return-Path: <SRS0=yMBa=LB=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67C5BC47082
	for <linux-nvme@archiver.kernel.org>; Mon,  7 Jun 2021 09:42:14 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 243E761130
	for <linux-nvme@archiver.kernel.org>; Mon,  7 Jun 2021 09:42:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 243E761130
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=WhvbD6JTYZX9MvuOpA6n0eHwzKD6H57NxLhYRt7/ug8=; b=npp/opdzDKoZJm
	Y+1hggfBBRzJOqbvGOPxbIIWVmkKrPTl4VRY0PL/kGyobKVmR9E+yPgmEHg690EY0YfxqS7ZNQKH8
	FF8FGJ2Goe0jOcjmvit704qB3M2Ihzw0LD1++bRCy/shaVKPTXzHd6lKcjqwQ5CUCc/LNJ26YdljV
	pHi8TAYtNkl4ma1C5eE+SRhGqhR+GyY+bX4zjmEhOrWCGh0obWE/g2xvDAEHGxMM/ZQ6/wJDjT1DN
	nt/4ypWQzCJhZ6IG0QDPJcFDjTdTnEtl2b0luAoA6r+Amt3/eNGE6nTUBqHtUSi14VnW3275GcZrC
	d5hWEuf7C/n1/YUDnY7A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lqBli-002frs-Tg; Mon, 07 Jun 2021 09:42:03 +0000
Received: from mail-mw2nam12on2062.outbound.protection.outlook.com
 ([40.107.244.62] helo=NAM12-MW2-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lqBTt-002Z8I-ET
 for linux-nvme@lists.infradead.org; Mon, 07 Jun 2021 09:23:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BLg0PQ9uIYiztwArzdTDUvhcUG2ml2Etc9PtBv94CTJTV8c7WNNQUL6t0KrfWfYPXB3RpMr/Bg+QK424GNHRf07pb60RHkus6leUaicmYjp2AQV/bMLdRnkt1Ajn3T8IMgPUeUJSwdEdejhahOjD4jTi4UavK4hYD9hFQNza/VyHJyi58NEC0Gz1T1pP//God8uEiAaidNB9caH+MxYJYq/++LrJAxUJblG1yOaS/xjn2uyVTunhL559nGfthj73GA5ZFl2w3KmjX6LTNsf/xU+yaD3oZLnc+QNK9AUo6nEp2oXRsEUiZs+H+PnndPk5ChrRQzZAyEMeFnvPB32Ipg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VfcgPvUDYhNFvTAXpg1StQZn3gEze2P9ZZOjO6pgyAI=;
 b=d4iauzXuvGESHkPzoSAmVpwFK8IrRd4NfGWZD6YvwRShyFu55sfrevT1/Vjcj4ymg8xuRfdXJzs58SQvHjBc2pzwCaYLfZlPeiGTjCutGy7AwWZN0v93iSQglyn9DDFaC0PWN6zR7KUPf3WvD4E94Ixnf+2iepcgoVzcN/brrPQBqkeVvX0cbV5QzwrUdSNOL2BpscvEBI6bKYQoGU5/kc2YuXADXGMk8m7wAaphtAuYmEOLsCDysT+zSbElayHpx/RjxnlqvA/lz9XfSD+uhAOxXwaOnmFqWFs+eJdqJNATL+Tw3n2LSiPqXqVKJHxYkM1+Fc3ZPE20H88ie+TAnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.36) smtp.rcpttodomain=lst.de smtp.mailfrom=nvidia.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=nvidia.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VfcgPvUDYhNFvTAXpg1StQZn3gEze2P9ZZOjO6pgyAI=;
 b=O4KsPfURTLeuKmFUxhbpNhhxgBHWQMxnHpxPPNIckz9cE+NNEGqARUAwjZTF9hhQTlrSFDHAFhvNaNrBcIGNossXsW3g/yK9brcbSzJel2g3hBKeEnW5/ffjR7nXcDDIiax7r1WLEL5KJr65aKUPGAA+40HYqhABFNXLfFmmO0ujSK1CBB9Ul0JsDqPNkJZ+htkh9gjulfyl/NOohsRhEegvp41KEMgl0Fg4VNnt+aiHJuxAj6LIDx5sY/L5R/kG48hft/nk0JzWlMSq+F31lKdKQb9SK3CMwDrdmsxbrmiCSXlU06mnWXsNczWhmBNA2rd5jaIiRqWvumHjrWRDnQ==
Received: from BN7PR02CA0009.namprd02.prod.outlook.com (2603:10b6:408:20::22)
 by SA0PR12MB4495.namprd12.prod.outlook.com (2603:10b6:806:70::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.20; Mon, 7 Jun
 2021 09:23:34 +0000
Received: from BN8NAM11FT037.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:20:cafe::44) by BN7PR02CA0009.outlook.office365.com
 (2603:10b6:408:20::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.15 via Frontend
 Transport; Mon, 7 Jun 2021 09:23:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.36)
 smtp.mailfrom=nvidia.com; lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.36 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.36; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.36) by
 BN8NAM11FT037.mail.protection.outlook.com (10.13.177.182) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4195.22 via Frontend Transport; Mon, 7 Jun 2021 09:23:34 +0000
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 7 Jun
 2021 09:23:33 +0000
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 7 Jun
 2021 09:23:32 +0000
Received: from r-nvmx02.mtr.labs.mlnx (172.20.187.6) by mail.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 7 Jun 2021 09:23:30 +0000
From: Max Gurtovoy <mgurtovoy@nvidia.com>
To: <linux-nvme@lists.infradead.org>, <sagi@grimberg.me>, <kbusch@kernel.org>, 
 <hch@lst.de>, <chaitanya.kulkarni@wdc.com>
CC: <ngottlieb@nvidia.com>, <oren@nvidia.com>, Max Gurtovoy
 <mgurtovoy@nvidia.com>
Subject: [PATCH v2 3/4] nvmet: allow mn change if subsys not discovered
Date: Mon, 7 Jun 2021 12:23:23 +0300
Message-ID: <20210607092324.1031046-3-mgurtovoy@nvidia.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210607092324.1031046-1-mgurtovoy@nvidia.com>
References: <20210607092324.1031046-1-mgurtovoy@nvidia.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6d7ba5d3-8502-43e4-4d1c-08d92995ec84
X-MS-TrafficTypeDiagnostic: SA0PR12MB4495:
X-Microsoft-Antispam-PRVS: <SA0PR12MB4495884664B1D32D00999E4BDE389@SA0PR12MB4495.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2958;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Cg0DxR1gfneMOZbbAFa4nhI3dc7TCvDnv5XYRfO0hSK0G3cMbciHGlyqRZGiCPXtzWd/MvxKypf/bFBJ4dr5nvVTEo6UTX28aA3X+PhSjrTPSi2MgM71hbZCbehZzGmBJM2MnFUf+CIRug5gM2udFORgFdNmTBxWw08q2zLQ66xIiBPIHg1K/vCU+SMhPnt1AqYbYtT4nezhWHXGluXYvnsPOGi9F/pZ5CP0hYJVolbwm7tvUcgst3QZt+UVbFVHEwGC3kNiMS1i93O7g+PaFITzVwPqCi3j/6Uewi6ieJQxZ87ndazPbqGM7xhfWMn5UfvKZ0dbfv4EvLleZ9GTM9MFAwWobpLuVBsi6vm2JxQ5hZtajPfde5Di+k8eniPnFf7LqdLldsz4Sgva8vXGaGC4u1+bAb9HM24aKt5WgiTBBuRoBMheALRzbRh1FuUstrERblWEf/EaaM1heep0q6955VKxZ3EKuCKWksi7hlmOrtTOyioy8ct4r8x/ys1/d4i+DVTEWF7zxC6KrmisfRiDmXqDXOPXCuE8RTEDQUmuiPMxpQuv4INtbb+H0S6s4yNPXLRjhbXgaQko5/39NoFIPHp84MG4JIiZZSZCn1vmhKQ2ltWz4JVvPKvxEn817sMFtGHpZ9VHGjFHEhu73KMWW8mrS4tmXvXpL+hMguM=
X-Forefront-Antispam-Report: CIP:216.228.112.36; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:schybrid05.nvidia.com; CAT:NONE;
 SFS:(4636009)(136003)(346002)(39860400002)(396003)(376002)(36840700001)(46966006)(83380400001)(478600001)(36860700001)(82740400003)(70586007)(7636003)(8676002)(86362001)(8936002)(6666004)(4326008)(36756003)(107886003)(356005)(110136005)(1076003)(26005)(5660300002)(316002)(2906002)(36906005)(82310400003)(2616005)(426003)(336012)(54906003)(70206006)(186003)(47076005);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2021 09:23:34.1720 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d7ba5d3-8502-43e4-4d1c-08d92995ec84
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.112.36];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT037.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4495
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210607_022337_554718_D8A88DB8 
X-CRM114-Status: GOOD (  17.17  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

From: Noam Gottlieb <ngottlieb@nvidia.com>

Currently, once the subsystem's model_number is set for the first time
there is no way to change it. However, as long as no connection was
established to nvmf target, there is no reason for such restriction and
we should allow to change the subsystem's model_number as many times as
needed.

In addition, in order to simplfy the changes and make the model number
flow more similar to the rest of the attributes in the Identify
Controller data structure, we set a default value for the model number
at the initiation of the subsystem.

Reviewed-by: Max Gurtovoy <mgurtovoy@nvidia.com>
Signed-off-by: Noam Gottlieb <ngottlieb@nvidia.com>
---
 drivers/nvme/target/admin-cmd.c | 26 --------------------------
 drivers/nvme/target/configfs.c  | 10 ++--------
 drivers/nvme/target/core.c      | 21 +++++++++++++++++----
 drivers/nvme/target/discovery.c |  4 ++--
 4 files changed, 21 insertions(+), 40 deletions(-)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index 5f15c3285a5b..cd60a8184d04 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -313,22 +313,6 @@ static void nvmet_execute_get_log_page(struct nvmet_req *req)
 	nvmet_req_complete(req, NVME_SC_INVALID_FIELD | NVME_SC_DNR);
 }
 
-static u16 nvmet_set_model_number(struct nvmet_subsys *subsys)
-{
-	u16 status = 0;
-
-	mutex_lock(&subsys->lock);
-	if (!subsys->model_number) {
-		subsys->model_number =
-			kstrdup(NVMET_DEFAULT_CTRL_MODEL, GFP_KERNEL);
-		if (!subsys->model_number)
-			status = NVME_SC_INTERNAL;
-	}
-	mutex_unlock(&subsys->lock);
-
-	return status;
-}
-
 static void nvmet_execute_identify_ctrl(struct nvmet_req *req)
 {
 	struct nvmet_ctrl *ctrl = req->sq->ctrl;
@@ -343,16 +327,6 @@ static void nvmet_execute_identify_ctrl(struct nvmet_req *req)
 		mutex_unlock(&subsys->lock);
 	}
 
-	/*
-	 * If there is no model number yet, set it now.  It will then remain
-	 * stable for the life time of the subsystem.
-	 */
-	if (!subsys->model_number) {
-		status = nvmet_set_model_number(subsys);
-		if (status)
-			goto out;
-	}
-
 	id = kzalloc(sizeof(*id), GFP_KERNEL);
 	if (!id) {
 		status = NVME_SC_INTERNAL;
diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
index a13da86fb374..9ef8708b92c6 100644
--- a/drivers/nvme/target/configfs.c
+++ b/drivers/nvme/target/configfs.c
@@ -1154,14 +1154,8 @@ static ssize_t nvmet_subsys_attr_model_show(struct config_item *item,
 					    char *page)
 {
 	struct nvmet_subsys *subsys = to_subsys(item);
-	int ret;
-
-	mutex_lock(&subsys->lock);
-	ret = snprintf(page, PAGE_SIZE, "%s\n", subsys->model_number ?
-			subsys->model_number : NVMET_DEFAULT_CTRL_MODEL);
-	mutex_unlock(&subsys->lock);
 
-	return ret;
+	return snprintf(page, PAGE_SIZE, "%s\n", subsys->model_number);
 }
 
 static ssize_t nvmet_subsys_attr_model_store_locked(struct nvmet_subsys *subsys,
@@ -1169,7 +1163,7 @@ static ssize_t nvmet_subsys_attr_model_store_locked(struct nvmet_subsys *subsys,
 {
 	int pos = 0, len;
 
-	if (subsys->model_number) {
+	if (subsys->subsys_discovered) {
 		pr_err("Can't set model number. %s is already assigned\n",
 		       subsys->model_number);
 		return -EINVAL;
diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index 213a0c2af4f7..146909486b8f 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -1494,6 +1494,7 @@ struct nvmet_subsys *nvmet_subsys_alloc(const char *subsysnqn,
 {
 	struct nvmet_subsys *subsys;
 	char serial[NVMET_SN_MAX_SIZE / 2];
+	int ret;
 
 	subsys = kzalloc(sizeof(*subsys), GFP_KERNEL);
 	if (!subsys)
@@ -1504,6 +1505,12 @@ struct nvmet_subsys *nvmet_subsys_alloc(const char *subsysnqn,
 	get_random_bytes(&serial, sizeof(serial));
 	bin2hex(subsys->serial, &serial, sizeof(serial));
 
+	subsys->model_number = kstrdup(NVMET_DEFAULT_CTRL_MODEL, GFP_KERNEL);
+	if (!subsys->model_number) {
+		ret = -ENOMEM;
+		goto free_subsys;
+	}
+
 	switch (type) {
 	case NVME_NQN_NVME:
 		subsys->max_qid = NVMET_NR_QUEUES;
@@ -1513,15 +1520,15 @@ struct nvmet_subsys *nvmet_subsys_alloc(const char *subsysnqn,
 		break;
 	default:
 		pr_err("%s: Unknown Subsystem type - %d\n", __func__, type);
-		kfree(subsys);
-		return ERR_PTR(-EINVAL);
+		ret = -EINVAL;
+		goto free_mn;
 	}
 	subsys->type = type;
 	subsys->subsysnqn = kstrndup(subsysnqn, NVMF_NQN_SIZE,
 			GFP_KERNEL);
 	if (!subsys->subsysnqn) {
-		kfree(subsys);
-		return ERR_PTR(-ENOMEM);
+		ret = -ENOMEM;
+		goto free_mn;
 	}
 	subsys->cntlid_min = NVME_CNTLID_MIN;
 	subsys->cntlid_max = NVME_CNTLID_MAX;
@@ -1533,6 +1540,12 @@ struct nvmet_subsys *nvmet_subsys_alloc(const char *subsysnqn,
 	INIT_LIST_HEAD(&subsys->hosts);
 
 	return subsys;
+
+free_mn:
+	kfree(subsys->model_number);
+free_subsys:
+	kfree(subsys);
+	return ERR_PTR(ret);
 }
 
 static void nvmet_subsys_free(struct kref *ref)
diff --git a/drivers/nvme/target/discovery.c b/drivers/nvme/target/discovery.c
index b7fdad13094a..7aa62bc6ae84 100644
--- a/drivers/nvme/target/discovery.c
+++ b/drivers/nvme/target/discovery.c
@@ -244,7 +244,6 @@ static void nvmet_execute_disc_identify(struct nvmet_req *req)
 {
 	struct nvmet_ctrl *ctrl = req->sq->ctrl;
 	struct nvme_id_ctrl *id;
-	const char model[] = "Linux";
 	u16 status = 0;
 
 	if (!nvmet_check_transfer_len(req, NVME_IDENTIFY_DATA_SIZE))
@@ -264,7 +263,8 @@ static void nvmet_execute_disc_identify(struct nvmet_req *req)
 
 	memcpy(id->sn, ctrl->subsys->serial, NVMET_SN_MAX_SIZE);
 	memset(id->fr, ' ', sizeof(id->fr));
-	memcpy_and_pad(id->mn, sizeof(id->mn), model, sizeof(model) - 1, ' ');
+	memcpy_and_pad(id->mn, sizeof(id->mn), ctrl->subsys->model_number,
+		       strlen(ctrl->subsys->model_number), ' ');
 	memcpy_and_pad(id->fr, sizeof(id->fr),
 		       UTS_RELEASE, strlen(UTS_RELEASE), ' ');
 
-- 
2.25.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
