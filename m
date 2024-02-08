Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6049FC48260
	for <linux-nvme@archiver.kernel.org>; Thu,  8 Feb 2024 06:25:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=P92+51yjhusDfh0pk81ArhI5ZcgUgWVNU7SYANKju0A=; b=JL55sxx4NACWVFlRD/VSUW0y9g
	3iT18dBKTmz0fDTh1Cnm7T6wGb0J+Mg4YYmaQC5Lp1mDmjerzL4qGPWKr9BDUkHfnYiJFmINmcfvi
	6WlOCPGioqqekIWCKBzLJhJtK8MpCTHFx+TLFTYA9LUYFuucpxe+/M9EGQxL9oYCIX7NCEfgLysgy
	TiE6VIP1n7wWxil03yjsvafiTAVip3WzPoxFGIy7g4wav8BJbuE72m7snIjg0eWu+e4vRpj03MhxN
	4tpuFa88626Ml4QsLPOJgapz3E5Oygts5PwoBiicruTR65BNC7jurwW7WmaTWXP0CQvqvtpDoRB/U
	+AO2fU1w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rXxqk-0000000CnRm-3nBv;
	Thu, 08 Feb 2024 06:25:30 +0000
Received: from mail-mw2nam12on20601.outbound.protection.outlook.com ([2a01:111:f403:200a::601] helo=NAM12-MW2-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rXxqh-0000000CnQL-3vo4
	for linux-nvme@lists.infradead.org;
	Thu, 08 Feb 2024 06:25:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jsGfL/M1HK/I+psUduJOt8A1QYYiT7DuNNJEwSLtKVoPJ4c8uJhECfOLYuFODaxASP28grd1ttk7c0stmonOB34Jhh+hK6DAnAJzV2/MrHp4d9FCmmqZagNuNH5p/K7vymcBVv15hXYa+h7wyDP+PlW0Gzt4S2f8TMB+8hAgv+e17iawzL7z2DTLsiBGT5cx17jYU56RLXkg2FFukz8LZcEWMMUUdIckTl2vUuCZLHSKLy6LuqqOQ6hBY47UY7T2sRPFIiGnToQ5sF6kvVBj4WFks6xxocidDfLyynayZ1vRUkWAzi1cLcN/GJFIwFxTmSzMYNk8iDODzuesumr/2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P92+51yjhusDfh0pk81ArhI5ZcgUgWVNU7SYANKju0A=;
 b=AkeZJWLvrC4v0ktGC4M/N99aKNULoTNcsT7Bnt2X0C0guYsus4PSS4A+cCEb49lk6GX1l2gKGhY0bTdeYHcZPtNSlVOWFVADY5Z8vx4NMSj5dFAm4jzRe/s7/ebodwYCoxtqih+oJlTEtPEzmSfVmD2h62eGy9m/4HsRzUFqM2BBxeb36HnwDEZ0ieICk7ExLAXmozMnF9SZm3kG5R9RHhQ1jS2RItGfp0MePmRNZhWi5BzU1qNoJwPk6HEJmKix4klI1wAHceLmGxiYULM3ifBpnuDAPiyJxIgadisA81GGGBnD/uyaO2IsMfrtMW+mk7gz0/iAzJLaIhkVbRJisQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=suse.de smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P92+51yjhusDfh0pk81ArhI5ZcgUgWVNU7SYANKju0A=;
 b=tjQdJu0FpmtCQ0XCfI1nQLjhWi/JmXtoHrfkDNhYdPPutoQcXmmlEoMVqk+4YCL1hLgLSeREKrIo0vH4seyKpj7ZJezPcttL1Hkg4bsv4RUJ94ADyW+gm8mFaalpO3FnmTLxumOnGLUa+Da1JIpb2BYuABY17wcOBmvvfyv3cM/20qSTwDSIwI++YRIR8LlrifDyx+mSelxgSViZf88aTuJHRa9uzeQC6RvUAW769ViaQ6+JUhjXb8x2F3eAAjzOiGp5aKeHSMD4W4rIQDFVTcRRKKxLW+Lr9btsk0KDQvPmMG87sVNP/nykSmW1QUfl2M1HeV5SMisO3yBtRY0geQ==
Received: from CH5PR04CA0011.namprd04.prod.outlook.com (2603:10b6:610:1f4::27)
 by SJ2PR12MB8689.namprd12.prod.outlook.com (2603:10b6:a03:53d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.14; Thu, 8 Feb
 2024 06:25:22 +0000
Received: from CH2PEPF00000099.namprd02.prod.outlook.com
 (2603:10b6:610:1f4:cafe::e0) by CH5PR04CA0011.outlook.office365.com
 (2603:10b6:610:1f4::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.38 via Frontend
 Transport; Thu, 8 Feb 2024 06:25:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH2PEPF00000099.mail.protection.outlook.com (10.167.244.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7249.19 via Frontend Transport; Thu, 8 Feb 2024 06:25:21 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 7 Feb 2024
 22:25:09 -0800
Received: from dev.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Wed, 7 Feb
 2024 22:25:08 -0800
From: Chaitanya Kulkarni <kch@nvidia.com>
To: <hare@suse.de>
CC: <kbusch@kernel.org>, <hch@lst.de>, <sagi@grimberg.me>,
	<linux-nvme@lists.infradead.org>, Chaitanya Kulkarni <kch@nvidia.com>
Subject: [PATCH 3/3] nvme-auth: unexport negotiate and wait functions
Date: Wed, 7 Feb 2024 22:24:27 -0800
Message-ID: <20240208062427.31255-4-kch@nvidia.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20240208062427.31255-1-kch@nvidia.com>
References: <20240208062427.31255-1-kch@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000099:EE_|SJ2PR12MB8689:EE_
X-MS-Office365-Filtering-Correlation-Id: 704b14cb-b951-4284-e28d-08dc286eba7e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZndnfyomURhpBG1EnzVm6ZF+vk9Har/XjdNYdLYHSSaXAaRP0JAugrG5QCFkbOeYWRtmaOIO0GZt701GvXcHfGfAwGcuT3/elCMg0StGExpExyCcPfppXg7UNiWr6dUC2PfGMhg0kipY1t+M+CfYNLFbEXo/ypK3YrN9C25JHHVHgjacrL5VI8/UbwbUphfA/BHeHOnaGd93LEawwEZr+092rgPQQwgPPT+gn0FDctp9Q5nH+txt4ok1JFDNinvVH08Jw6nXFlWYQe3u2TEwyHj0Is5Ucc0g9fQoTuDvSWjgJ3iBYgOEKkQdYGuieRpMKHbgSbhhaPmSzXsVA+DaqYtIXGD96VHjiEW2hyyepmS5YjeM/l+vE6FIcFpWodweONR8NqqDCIIOdpM8XLYrvSHRLqZEnepFmHbpLzF+ZiTMNXWG40PjRoQPQfnqEA5R2DlwBJG864tBE831VhN2zbCn03RixXkIfBnk6Fi4FahvxJlhqbIvGQoEr/z+cR1OShAMY1bFkL3WjXfzEHSTMr8eNxL7ABm/mjDO3lpMDXuNAQaNNluNdClZfji5BiQ1Q29mG/W8bu8SQqIRG5TVibbhs1FCoNWXQbIt0qTWJ5k=
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(396003)(136003)(39860400002)(346002)(376002)(230922051799003)(82310400011)(64100799003)(451199024)(1800799012)(186009)(36840700001)(40470700004)(46966006)(41300700001)(2616005)(107886003)(26005)(1076003)(426003)(16526019)(356005)(8936002)(7636003)(82740400003)(7696005)(70206006)(336012)(2906002)(70586007)(6666004)(316002)(4326008)(8676002)(5660300002)(54906003)(6916009)(478600001)(83380400001)(36756003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2024 06:25:21.8440
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 704b14cb-b951-4284-e28d-08dc286eba7e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000099.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8689
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240207_222528_005515_EC15194A 
X-CRM114-Status: UNSURE (   9.33  )
X-CRM114-Notice: Please train this message.
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

Now that post connect functionality is moved from host/fabrics.c to
host/auth.c we don't need nvme_auth_wait() and nvme_auth_negotiate() to
be exported from nvme authentication code, unexport them to make it
private.

Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
---
 drivers/nvme/host/auth.c |  6 ++----
 drivers/nvme/host/nvme.h | 10 ----------
 2 files changed, 2 insertions(+), 14 deletions(-)

diff --git a/drivers/nvme/host/auth.c b/drivers/nvme/host/auth.c
index 159071462738..2fa8c4ee50ed 100644
--- a/drivers/nvme/host/auth.c
+++ b/drivers/nvme/host/auth.c
@@ -852,7 +852,7 @@ static void nvme_queue_auth_work(struct work_struct *work)
 		chap->error = ret;
 }
 
-int nvme_auth_negotiate(struct nvme_ctrl *ctrl, int qid)
+static int nvme_auth_negotiate(struct nvme_ctrl *ctrl, int qid)
 {
 	struct nvme_dhchap_queue_context *chap;
 
@@ -871,9 +871,8 @@ int nvme_auth_negotiate(struct nvme_ctrl *ctrl, int qid)
 	queue_work(nvme_auth_wq, &chap->auth_work);
 	return 0;
 }
-EXPORT_SYMBOL_GPL(nvme_auth_negotiate);
 
-int nvme_auth_wait(struct nvme_ctrl *ctrl, int qid)
+static int nvme_auth_wait(struct nvme_ctrl *ctrl, int qid)
 {
 	struct nvme_dhchap_queue_context *chap;
 	int ret;
@@ -885,7 +884,6 @@ int nvme_auth_wait(struct nvme_ctrl *ctrl, int qid)
 	nvme_auth_reset_dhchap(chap);
 	return ret;
 }
-EXPORT_SYMBOL_GPL(nvme_auth_wait);
 
 static void nvme_ctrl_auth_work(struct work_struct *work)
 {
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index bb1c9b74aa55..a4d13ed8f6c3 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -1082,8 +1082,6 @@ int __init nvme_init_auth(void);
 void __exit nvme_exit_auth(void);
 int nvme_auth_init_ctrl(struct nvme_ctrl *ctrl);
 void nvme_auth_stop(struct nvme_ctrl *ctrl);
-int nvme_auth_negotiate(struct nvme_ctrl *ctrl, int qid);
-int nvme_auth_wait(struct nvme_ctrl *ctrl, int qid);
 void nvme_auth_free(struct nvme_ctrl *ctrl);
 u16 nvme_auth_post_connect(struct nvme_ctrl *ctrl, u16 qid, u32 result);
 #else
@@ -1099,14 +1097,6 @@ static inline void __exit nvme_exit_auth(void)
 {
 }
 static inline void nvme_auth_stop(struct nvme_ctrl *ctrl) {};
-static inline int nvme_auth_negotiate(struct nvme_ctrl *ctrl, int qid)
-{
-	return -EPROTONOSUPPORT;
-}
-static inline int nvme_auth_wait(struct nvme_ctrl *ctrl, int qid)
-{
-	return NVME_SC_AUTH_REQUIRED;
-}
 static inline void nvme_auth_free(struct nvme_ctrl *ctrl) {};
 static inline u16 nvme_auth_post_connect(struct nvme_ctrl *ctrl, u16 qid,
 		u32 result)
-- 
2.40.0


