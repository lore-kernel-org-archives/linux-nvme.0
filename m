Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F771CAC5A5
	for <linux-nvme@archiver.kernel.org>; Wed, 24 Sep 2025 20:34:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=KLDWEloqzUiM5Fc36zmAz9ISk4ayILkbLjAYfvu2yH0=; b=UkLygOyBKPqolDHr1CrHXKTxMT
	Erxm9Ht2WkNXODz2CBtwlVXdHepOkCBoJzozZ0nKB0OcFXWahmhbigkjhA8ps+l1BpJXyH2TWlmAj
	P7gdWZvRUQoTH32YaIg+Qak8suTiSWsXcUFnVCAhtpvDCxgniVw3Hp87cRfDWf1IJG+5trqnvh5IP
	/TtClKlOgtsmt8W9pHuPKjTZ1hLegCt+QZXOGPXhj/XbvTslVMA+//uhO2HzN+96T66YMc6KYQOp0
	79UlXMBiELQ8tj5g3Z7xW2tJvLeFJS3opMNBNYltM8QAbEJs137a9o+jtrhuzh4DRriTTE7/8Ao8j
	Mzx8TEZQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v1WC7-00000003XNn-48bz;
	Wed, 24 Sep 2025 20:34:31 +0000
Received: from mail-southcentralusazlp170110003.outbound.protection.outlook.com ([2a01:111:f403:c10d::3] helo=SN4PR0501CU005.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v1WC5-00000003XLV-0zXu
	for linux-nvme@lists.infradead.org;
	Wed, 24 Sep 2025 20:34:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r+ZhKIVnrKQCC70Vck+sIWEdl+CUSF+6aCmHazIk9yShXagJ5tYSy3/+Nx/CGORktCURcrHOUaMXcOSWm4nDYghvkGpQtNYvnL0lBRPQvZ0An8TcGlaxxr+GBfjpCxaI5GDTKzDQfnnMffQhAJpyFPlkh/gTIbbHO3ucbCCfp+Nruuve8uskLmtiFPJ1AwV6dcXe2U03olmJag8D2QzI9xazLFQmLFZ+/YKcJth04710A68L2iaqVOMY14Ptg3noext+1/78SX9SuH5rmIBSD3t8lAKv2jFs18p2QENGgyvNzl4mqtOtzpLeWconkuVEzt6r2seFKqZPh+oMMYSogQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KLDWEloqzUiM5Fc36zmAz9ISk4ayILkbLjAYfvu2yH0=;
 b=rlUxyZ6/DmgzhYafdaUXn0ZOdc2OxmMsfLcU0OthA6r6aF+WqBYHfiDwwJ+jIQc8e58IimBzWJzHwEo75zleilp86F8STbYEHw1Ic/NrwWptAu4hfj+LqHc6aqSRvTaH1v99k6Bt6efpMaYPiK2fUTlLTBwRf7lnHNV4/fXXOGLKsfGXc6gYi0N6dwMPBrUc97td696i07V38S56sJIXr1TiDQJQhq9NqEGDIln2sD+NSBlMZ6zDDY+sRjiKGvWJgMrIpoMKoMsL+VnreJ8WjyXmZH6krrJkPnhMUeZOU3lH/40pYQPzyn9gZTd/E95AtDXkvn/BNhOEi+YYdwXXhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=lst.de smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KLDWEloqzUiM5Fc36zmAz9ISk4ayILkbLjAYfvu2yH0=;
 b=ha2/taL+cEnC0qFFkuGEsZ6bLe9MOJnwotA2vScTfiIws6OSMrnlUZpwGmHR+g7RFLJxNuGWlTfJkQO9u2zg9UOxkm0+5COMu8Hwr7xZdEqNClhgzAOpm5qyl5SdWmgN06b2SghxVr2Gvio4Rv1uTVKRwRM1/Y3x4nGqrWxLDlvaDDNR7Y0nTXKlQ8vtfkM2WUlxfc9qBWCzwrf9ssZoLuF0AJ9Q77YXhhxn7ioUADky+5t/JHdPoep5aLx47ngWSQXeFZ8XCf3otkDadtNiSm7jRSqOnXW2jacDgH5nuJTghOt9gNszgGUvF8PUc0/Mgl/yxklUH7y4RGjj7sVLSQ==
Received: from BYAPR11CA0055.namprd11.prod.outlook.com (2603:10b6:a03:80::32)
 by CH1PR12MB9645.namprd12.prod.outlook.com (2603:10b6:610:2af::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.19; Wed, 24 Sep
 2025 20:34:20 +0000
Received: from SJ5PEPF000001D5.namprd05.prod.outlook.com
 (2603:10b6:a03:80:cafe::4a) by BYAPR11CA0055.outlook.office365.com
 (2603:10b6:a03:80::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.22 via Frontend Transport; Wed,
 24 Sep 2025 20:34:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ5PEPF000001D5.mail.protection.outlook.com (10.167.242.57) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9160.9 via Frontend Transport; Wed, 24 Sep 2025 20:34:19 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.34; Wed, 24 Sep
 2025 13:34:06 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 24 Sep
 2025 13:34:05 -0700
Received: from r-arch-stor03.mtr.labs.mlnx (10.127.8.14) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Wed, 24 Sep 2025 13:34:03 -0700
From: Max Gurtovoy <mgurtovoy@nvidia.com>
To: <hch@lst.de>, <linux-nvme@lists.infradead.org>, <kbusch@kernel.org>,
	<sagi@grimberg.me>, <kch@nvidia.com>
CC: <israelr@nvidia.com>, Max Gurtovoy <mgurtovoy@nvidia.com>
Subject: [PATCH 1/1] nvmet: remove redundant subsysnqn field from ctrl
Date: Wed, 24 Sep 2025 23:34:02 +0300
Message-ID: <20250924203402.10688-1-mgurtovoy@nvidia.com>
X-Mailer: git-send-email 2.18.1
MIME-Version: 1.0
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D5:EE_|CH1PR12MB9645:EE_
X-MS-Office365-Filtering-Correlation-Id: c1814c7a-1451-4a3f-5d8a-08ddfba9bd08
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|82310400026|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?JW1WWKPBork7xExXHu+RaKKW7YjxJmGIrG2hogr844VyL4GMxdh1LaXJSp/w?=
 =?us-ascii?Q?nFUSqVXj1RRpwGJcT5+wzPo1FtZUGNuYkCZMprr5+Uj7Zn/c640cZfgXSoyR?=
 =?us-ascii?Q?WcTFSZKfgIItu9hUQQotosqYj0y8l1COMlM+OARkWWq7KTSIWHYM0ETr7iY7?=
 =?us-ascii?Q?yVja3YloK/+3NzGT0Z27adI2VaoY5/MaLU0KcfhgjeewT5hFYOQNeHQeZnXF?=
 =?us-ascii?Q?EJlBEHUE1wTfRLu2QHG9OjgyTgtIgiYsAJEIjk1AnqAbTUM7LIp2Ifp9IVq4?=
 =?us-ascii?Q?g0MhdMYB16zXal5reBvTuU7C4mtUO84e4mCa4x46XhFsefz9ZFk2mxylzDp9?=
 =?us-ascii?Q?wQtP+WEmBMPmGnIYh9DrtVQapn6mR2SzMe70EPxyX/FzBX3n4p0nVOgCAHo3?=
 =?us-ascii?Q?gVrj77wgNesTerDHoYqYOYTPYv53rIm7Hb8X41X7N2j+6RL313kHTYghtbj4?=
 =?us-ascii?Q?ILlTXplI8pdPQOnCXsxLXQgslsvLKo93Gro/bvxR/tVUau+PM1smMKwXi78P?=
 =?us-ascii?Q?J7sKv0tJrnCuXRK1g9k7sS5hVaQjm+y2b1FjN/NDRnkAhwJ1OmQLyuybzvN/?=
 =?us-ascii?Q?tkmemAqn+71yqWObdzdAd8wYH/d/zgBtwVQRyvXeQ1gAVjwuHH3AoiKEtVTV?=
 =?us-ascii?Q?FmMVyUSvADRDlcTgnMBf68AaI4ng5blo7yrHeSSdNliuGuLWvziDB84XFtOZ?=
 =?us-ascii?Q?wRniQbLrzUiCKX1L2Y4DB0Bm6XXxwtVogU8In1LA7Ddy+sKrgNys3VzVN/yd?=
 =?us-ascii?Q?pXUlONTztvOaC45fTbN5xGwqS7+MVt97CdnuB6UJAp+JqhglzCzrLS/LXijy?=
 =?us-ascii?Q?7zQ8uCzKQ/FDnXTMKYsA7x1F/msVfOchg61FuC73Tj6S1aeiS1jOrLj7wjCG?=
 =?us-ascii?Q?DI/xYZ3n86+CebRT9iTQtOmRPu6E2BYZTVF5yu30XZMaoz6y6zgUDUF2dkfi?=
 =?us-ascii?Q?bUlyZAuOPx5GYvC5/5IMawkS9ESGASB6G830dYRZ/tyRYWvkS8kAD08IRPgI?=
 =?us-ascii?Q?/KnHQvyoXKI7PXaJAhasNOev3695s51WfD5DEr66BcIw/1qJo0ktDeLDQUus?=
 =?us-ascii?Q?a3QxEBZWzOZkJvBHgOJYk1NsoTKjIqDrxxMPr0VkAs3YfbTaXJbrOGYE7IrK?=
 =?us-ascii?Q?hWfor59mDeYUB1K0PdeeLSZhav25dvaqMp+loLPEgyuE2i0nbwFjPDCucMeG?=
 =?us-ascii?Q?DqaP7RAFj7LBRVcFjoSC67eoSiVuWQLxhwf99iiRvW9eiX10hjxGexd3TEpM?=
 =?us-ascii?Q?9DPM9luqTcPGvFxWe4uaC4++EJ8RrLN2YQ8Mcl/LaQoBBrL7sAwWt2va/upx?=
 =?us-ascii?Q?YKAbPtNJn/TI334m6633apaHlGR1ajfK918vZhR69zK9n07wBGj8xE3/bKUt?=
 =?us-ascii?Q?RI8TrrDA27fVnNn2LN8bxMHGi8BEqe/anA8sP/bYQZGKQ2wKEgxpF7/v25Or?=
 =?us-ascii?Q?DkNf6u9NnR1W/gv5UfAD0CquzXD3oyBMoUzrLtVCzZKa00xftsfXUNLUUD4R?=
 =?us-ascii?Q?9TfOze1WYE32Uxp79t14ykWVTTU+pgU5x2kA?=
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2025 20:34:19.5682
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c1814c7a-1451-4a3f-5d8a-08ddfba9bd08
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001D5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PR12MB9645
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250924_133429_288734_88C93734 
X-CRM114-Status: GOOD (  12.93  )
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

The subsysnqn field in the nvmet controller structure is redundant,
since the subsystem NQN can always be accessed via the controller's
subsystem reference. Remove this field to save memory and avoid
unnecessary duplication.

Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
---
 drivers/nvme/target/auth.c     | 14 +++++++-------
 drivers/nvme/target/core.c     |  1 -
 drivers/nvme/target/nvmet.h    |  1 -
 drivers/nvme/target/passthru.c |  2 +-
 4 files changed, 8 insertions(+), 10 deletions(-)

diff --git a/drivers/nvme/target/auth.c b/drivers/nvme/target/auth.c
index b340380f3892..022e94847800 100644
--- a/drivers/nvme/target/auth.c
+++ b/drivers/nvme/target/auth.c
@@ -380,8 +380,8 @@ int nvmet_auth_host_hash(struct nvmet_req *req, u8 *response,
 	ret = crypto_shash_update(shash, buf, 1);
 	if (ret)
 		goto out;
-	ret = crypto_shash_update(shash, ctrl->subsysnqn,
-				  strlen(ctrl->subsysnqn));
+	ret = crypto_shash_update(shash, ctrl->subsys->subsysnqn,
+				  strlen(ctrl->subsys->subsysnqn));
 	if (ret)
 		goto out;
 	ret = crypto_shash_final(shash, response);
@@ -428,7 +428,7 @@ int nvmet_auth_ctrl_hash(struct nvmet_req *req, u8 *response,
 	}
 
 	transformed_key = nvme_auth_transform_key(ctrl->ctrl_key,
-						ctrl->subsysnqn);
+						ctrl->subsys->subsysnqn);
 	if (IS_ERR(transformed_key)) {
 		ret = PTR_ERR(transformed_key);
 		goto out_free_tfm;
@@ -483,8 +483,8 @@ int nvmet_auth_ctrl_hash(struct nvmet_req *req, u8 *response,
 	ret = crypto_shash_update(shash, "Controller", 10);
 	if (ret)
 		goto out;
-	ret = crypto_shash_update(shash, ctrl->subsysnqn,
-			    strlen(ctrl->subsysnqn));
+	ret = crypto_shash_update(shash, ctrl->subsys->subsysnqn,
+			    strlen(ctrl->subsys->subsysnqn));
 	if (ret)
 		goto out;
 	ret = crypto_shash_update(shash, buf, 1);
@@ -574,7 +574,7 @@ void nvmet_auth_insert_psk(struct nvmet_sq *sq)
 		return;
 	}
 	ret = nvme_auth_generate_digest(sq->ctrl->shash_id, psk, psk_len,
-					sq->ctrl->subsysnqn,
+					sq->ctrl->subsys->subsysnqn,
 					sq->ctrl->hostnqn, &digest);
 	if (ret) {
 		pr_warn("%s: ctrl %d qid %d failed to generate digest, error %d\n",
@@ -589,7 +589,7 @@ void nvmet_auth_insert_psk(struct nvmet_sq *sq)
 		goto out_free_digest;
 	}
 #ifdef CONFIG_NVME_TARGET_TCP_TLS
-	tls_key = nvme_tls_psk_refresh(NULL, sq->ctrl->hostnqn, sq->ctrl->subsysnqn,
+	tls_key = nvme_tls_psk_refresh(NULL, sq->ctrl->hostnqn, sq->ctrl->subsys->subsysnqn,
 				       sq->ctrl->shash_id, tls_psk, psk_len, digest);
 	if (IS_ERR(tls_key)) {
 		pr_warn("%s: ctrl %d qid %d failed to refresh key, error %ld\n",
diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index 61625d692c90..099a05409ac5 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -1654,7 +1654,6 @@ struct nvmet_ctrl *nvmet_alloc_ctrl(struct nvmet_alloc_ctrl_args *args)
 	INIT_WORK(&ctrl->fatal_err_work, nvmet_fatal_error_handler);
 	INIT_DELAYED_WORK(&ctrl->ka_work, nvmet_keep_alive_timer);
 
-	memcpy(ctrl->subsysnqn, args->subsysnqn, NVMF_NQN_SIZE);
 	memcpy(ctrl->hostnqn, args->hostnqn, NVMF_NQN_SIZE);
 
 	kref_init(&ctrl->ref);
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index 2d29df0f66eb..e5a4571199aa 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -284,7 +284,6 @@ struct nvmet_ctrl {
 	__le32			*changed_ns_list;
 	u32			nr_changed_ns;
 
-	char			subsysnqn[NVMF_NQN_FIELD_LEN];
 	char			hostnqn[NVMF_NQN_FIELD_LEN];
 
 	struct device		*p2p_client;
diff --git a/drivers/nvme/target/passthru.c b/drivers/nvme/target/passthru.c
index 0c361b1e3566..96648ec2fadb 100644
--- a/drivers/nvme/target/passthru.c
+++ b/drivers/nvme/target/passthru.c
@@ -150,7 +150,7 @@ static u16 nvmet_passthru_override_id_ctrl(struct nvmet_req *req)
 	 * code path with duplicate ctrl subsysnqn. In order to prevent that we
 	 * mask the passthru-ctrl subsysnqn with the target ctrl subsysnqn.
 	 */
-	memcpy(id->subnqn, ctrl->subsysnqn, sizeof(id->subnqn));
+	memcpy(id->subnqn, ctrl->subsys->subsysnqn, sizeof(id->subnqn));
 
 	/* use fabric id-ctrl values */
 	id->ioccsz = cpu_to_le32((sizeof(struct nvme_command) +
-- 
2.18.1


