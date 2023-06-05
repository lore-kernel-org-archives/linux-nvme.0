Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86BD1C77B73
	for <linux-nvme@archiver.kernel.org>; Mon,  5 Jun 2023 09:20:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=DJmc1YvW4xRLGO8Y4Q7shRI39Mt56kAH8G61cim7M3M=; b=w4ffO+Y6RZ7Ht2yod57XIVuGrr
	G6qgbI9kGmePdSEI4crS2jdg+Gi4cF3txbD/CwF4FQD4qohpd2nlxLjVM5xCNcGCoNzkHfE1kEdgB
	bhAZVCgR0ZNr1UIH7ophHfwU8CRreFH/KyG83eoQm/v2oeBUB8qIkUYxcmmCM/QB9sLA+ia/oTMVq
	GVHfOeWg4MydqEtJO+8arSoX/tFIRo+rKkqS8bn/ES+94AxHlqrQNIgIJRwfBkMKPihwZRWbRwxTY
	TyHrpG87QSXWeRhbz2EjgQwMmXWFKnUy9IUweF12IikmNeRZRH++XeW5KRfrHCrL6WxmDO/cu0Gye
	wh/lYBRA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q66Nh-00Ep50-1y;
	Mon, 05 Jun 2023 09:20:05 +0000
Received: from mail-bn8nam12on20606.outbound.protection.outlook.com ([2a01:111:f400:fe5b::606] helo=NAM12-BN8-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q66Ne-00Ep3b-1l
	for linux-nvme@lists.infradead.org;
	Mon, 05 Jun 2023 09:20:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lsFtYXKkmfHZAgVnY7XZo/Ca9H7HbuGTgY7HftbbCh4JEVzXxfxYPMhvd+cWCT1F9a6HVRDzvczvLCotMwdgSDWvQwFFu2NkRedu2vRx/EXoxtz1UugUoTsKSMqu50/oc0K5DslvEIVECLD9H1JrjKKLPocyrzcVacYyZknGK+KqmSzhKL4uAsqOmd6yT4ZcyDZyUzPulrHKtOfBQcP+HFZavhFNqW81pEQclmMuOT9GjpCE0vZNDNlztFUsb2r3xSbH8+pV72QbuZUk9fgoIpSXuZWc66r2x5NiTnuB4KmYbnwtd4SylWU2jQ0pEZ/3Z02FDoN4wune8y5slSIzYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DJmc1YvW4xRLGO8Y4Q7shRI39Mt56kAH8G61cim7M3M=;
 b=PQap1ldR6aQCptOdICJ7qsPZj/666El9XU6FVK/+ZUV9dWtQz2cfN9RxYdH0fez0og+EsI16u594jT5MMQGN5+rVFCzPETuGiYg5TbZV8GEMMy0fWsh7eJeSzk4W+5VVwGCuiUhJKrMEqUS6JQT4zf6N7EUS4RcwqErDTU29O4l2u1m09HNqJQZq4w8dMo5NInB8ERhWqft9t0cy+HMx+QY/1wcu6603OhXaFiwsBv5HAPn1x99sSga7omL9krYndmM1YVwVsE11rCNd9sCDilWL/8r9OgwcHeO1CW+iKkspyTFu8NPVYeFZ2kXCbS0NxzQE40mkCNPhRmpsu4Bvbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=suse.de smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DJmc1YvW4xRLGO8Y4Q7shRI39Mt56kAH8G61cim7M3M=;
 b=DXy3k2H2H3jMD0oK+ViOwR9iTrVqY5jeh3MJyOkIi+J/tBQoWZLB6DotX9Us+V5p5ZdNxGz8eKURQAHmW9EjIBpsb1CF9u2EH1CNn97pNASnOQy13ZXauNpvj15JPo1nlFWp7V5EZXA+rzKTsqV6UE4aXQJ5tSEen3tDusQY4D4OZT9aMrov1Ygnko9lUdY/wQI0eIVTQ2ioDdHiF5EYE10bo20egTrniuZjmzY0cOnMhE3IHpfPpHA01cZ7vxPUnXvx6LPhgdYVZIIGlGDW0a2kXY+UfVvxQ/Tn4fTiqFVx4XQMCAqwPKFH1jbB2S/nfEKsE7BY8QvyTeTAEviyig==
Received: from MW4P223CA0028.NAMP223.PROD.OUTLOOK.COM (2603:10b6:303:80::33)
 by DS0PR12MB7725.namprd12.prod.outlook.com (2603:10b6:8:136::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Mon, 5 Jun
 2023 09:19:56 +0000
Received: from CO1NAM11FT023.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:80:cafe::7) by MW4P223CA0028.outlook.office365.com
 (2603:10b6:303:80::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33 via Frontend
 Transport; Mon, 5 Jun 2023 09:19:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1NAM11FT023.mail.protection.outlook.com (10.13.175.35) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6455.32 via Frontend Transport; Mon, 5 Jun 2023 09:19:55 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Mon, 5 Jun 2023
 02:19:40 -0700
Received: from dev.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Mon, 5 Jun 2023
 02:19:39 -0700
From: Chaitanya Kulkarni <kch@nvidia.com>
To: <hare@suse.de>
CC: <hch@lst.de>, <sagi@grimberg.me>, <linux-nvme@lists.infradead.org>,
	<kbusch@kernel.org>, Chaitanya Kulkarni <kch@nvidia.com>
Subject: [PATCH V3 1/3] nvmet-auth: use common helper to check secp/spsp
Date: Mon, 5 Jun 2023 02:19:18 -0700
Message-ID: <20230605091920.34253-2-kch@nvidia.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230605091920.34253-1-kch@nvidia.com>
References: <20230605091920.34253-1-kch@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT023:EE_|DS0PR12MB7725:EE_
X-MS-Office365-Filtering-Correlation-Id: 8870be23-4fb4-4c38-f7bd-08db65a606db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NuWQ0GHZu9fSGnNwhwL9VdDv8VM6EYYBFdzw32pasoSNp7EVxjN8CSG2JCE1DJOanA+ZWZuD9S+mUfZFBSmSuL4lw+RkGCvna2SSKMx8YkAdR0uP78fT1D8W26+9B4v0uqYOAXwkYBKnAS6rg5PF8+TVmxsgXKa6+E9AetIqteewwFwy+YUy8gSX/hoOJKQLJis4dlj1B1IwNi75D7Twhnoso9sexDbFNkNxljS9LZLlSGe3RZsE7TJboeUZVYvuWKH/kQOJvlehLoAA/IS+0VUFAiEPj0dbrTkN4WzclRs+DBsnXOjOTkrmkWed9Altm+iJ71K0CG/J1GO2Lb5V4EVoPZYoFtOgAwjt09fWPdddVZ1wkoCIJPZeZ35463/zQ+whqTDwWrkVFAiOSbjhama9/sRQLYu4cwo1BYQwhrAFBSc1gE2LSldNuPODSZjcrMs/RBiRXjFAfNQHmMUQcpwKrW948T3vBQYHH1Szrzcsp6JRpEKi48J7gYqXbRHHUUagAj+B9S3HeH2q51uyleFf97PDpuy3GSt5yBLc5py0Q8IWbTCJEpp68rxnCBJUZcDrZg12A8sCusQZ/nxqyv7YrEC+jCe/n0SjZgdwT5TUQG4qpujB0wJ2HfKZPO9vLNQ0uwrlvHr6h0pYkRBEtR4zatYoXLLwINQO2dRoT1co7LFnTMKm828rmKDIhWaOyPB2ine6ssW5HlJBnB4yi/Ir7t5z727EmbHoQtrvX71GGy5b7kpELMxzMqOglxb+
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(376002)(346002)(396003)(136003)(451199021)(40470700004)(46966006)(36840700001)(40460700003)(83380400001)(47076005)(336012)(426003)(2906002)(2616005)(36756003)(82310400005)(356005)(82740400003)(7636003)(36860700001)(40480700001)(7696005)(316002)(41300700001)(6666004)(5660300002)(107886003)(8936002)(8676002)(54906003)(478600001)(6916009)(4326008)(70206006)(70586007)(26005)(1076003)(16526019)(186003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2023 09:19:55.6175
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8870be23-4fb4-4c38-f7bd-08db65a606db
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT023.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7725
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230605_022002_591541_85C315C0 
X-CRM114-Status: GOOD (  11.07  )
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
index 586458f765f1..847aa12d2915 100644
--- a/drivers/nvme/target/fabrics-cmd-auth.c
+++ b/drivers/nvme/target/fabrics-cmd-auth.c
@@ -12,6 +12,23 @@
 #include <crypto/kpp.h>
 #include "nvmet.h"
 
+static u16 nvmet_auth_common_prep(struct nvmet_req *req)
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
+	status = nvmet_auth_common_prep(req);
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
+	status = nvmet_auth_common_prep(req);
+	if (status)
 		goto done;
-	}
 	al = le32_to_cpu(req->cmd->auth_receive.al);
 	if (!al) {
 		status = NVME_SC_INVALID_FIELD | NVME_SC_DNR;
-- 
2.40.0


