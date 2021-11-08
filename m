Return-Path: <SRS0=LsNR=P3=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63ABDC433EF
	for <linux-nvme@archiver.kernel.org>; Mon,  8 Nov 2021 14:47:34 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 18B1A61242
	for <linux-nvme@archiver.kernel.org>; Mon,  8 Nov 2021 14:47:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 18B1A61242
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:CC:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=65muZiMt2qDf8DKPVHtPRP+kYuF52EIfFVWvdnCFfFQ=; b=4u10Bka4BQjl2Wc/Aaebza3GYb
	XrnS8AiPtIFHffFt9C1wCxgFQlZLmk6eb+dN2TKjfjtdMRT2IE0I6QoqUjIgxe1RJZlUSRPAhpR3B
	Yx+AP0dsHTlDofO4XW6k2PqrVeKsQHkEJtMRbDklJIn2HMuXcmSJ2yclf/YuOu5W3d88oeNiOjy2B
	fBE6WejRvwOkxxdozNWn3Cm0R8w+kGc/CaGi3SZLAOff1Mw2eZRUdteHsgD3RSZmcJwpga7p4YIWj
	BAkqF3FGxEAJ8e12DpRtgSk/uzg2ij+UYvNccUNISgBg1S1GLTZt+eSxKC5N27/8SA/OrnnYDswgF
	EiQzKHcQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mk5vn-00Ghzw-Fb; Mon, 08 Nov 2021 14:47:31 +0000
Received: from mail-mw2nam08on2048.outbound.protection.outlook.com
 ([40.107.101.48] helo=NAM04-MW2-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mk5va-00Ghwk-4Z
 for linux-nvme@lists.infradead.org; Mon, 08 Nov 2021 14:47:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AvZsuYmdpCVD1okQAM7hbhzWW+FqurfEp81DbEvcUdNKPILtmSMtRRGs9IGz/nVxzuBlZbJqH1wEE4PWnwP7/qEE1O4Q+emCJUKlenhAc6nyXvyECYbgr13PCfr6eV+/CETibZNQ/PrYIBmjzkIlL7Tom21KRV9w7FSkqHNcW2iVpDjKndTKDy54QdYifPQov/iBA7BKBVIdKI0SA1utpySfnWEEPNv33e9BCOemXy527BQ8bXOk+IiQziaaELkidK9Bj+mvIGpspIbA9Qn2ZM6gKPrjqinYvMkl30gW73JiCo6uQgYJsumdOJ4DMB4ILRcFhuN+5ICAT2cgGQ5IIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=65muZiMt2qDf8DKPVHtPRP+kYuF52EIfFVWvdnCFfFQ=;
 b=SM5Q79ngXW7wo1MxdltA8R/n/PvswCbfShKSdRXIUTE9T3DFqThrA8afmxRL1BXfjIKDlbA3wZlI1MrID5/tbgGvfPNvPj/Vj/yl6c94hs0wxg15ATryNd0sEKjV+rYPgikfkmf048dBI54OEsnsThfTtQxVrz0r7UOSWuUEnpA/vEMdI4oumeujIXwoA2IvLcgP7ZEh0E3EWX4SSSltd8zUli2vezu1PgtITviwm9+y0xX2wq+hJZydZiHAtP19n8v+shdOef/EYHncCoDqY5lDs/cXQivL3YV7cBwP8WcYmtIiUMLXvPjcWFpew/QD0D1M5Pnzo1NC7Q5L9qnsEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.35) smtp.rcpttodomain=grimberg.me smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=65muZiMt2qDf8DKPVHtPRP+kYuF52EIfFVWvdnCFfFQ=;
 b=S6cesSvHAmFB40CoOVSpOvNQcYbxQNgu5dfIlppFzQ9HUoDWDJ8VNiqme7H1ImkWx8T10Qf/BtjXgBXLuZcCDyyvmrwn11ieiMF8gPqNrUppYp/1zSpqvSqEibfZwWDjK3k4QMFeVtY9y29WJCkDiRx4tfsPdf9NhzMxCEPagiIzUZO/UR6M9Eh+5JgCbCSdEzHr0no/FJ5FJ1v/RwB0tVRVZEels6diSout+qs3tcpcTTmnoQaL5E2g3Zq/1rKJN7DNphtIJXH8MJCiu4dcva2FEW9c8Ay+NkeGz1L9OSvF++8Uzc2UVXsfcmficv3oGY80DvznMrG01tgVcakmrg==
Received: from BN0PR04CA0137.namprd04.prod.outlook.com (2603:10b6:408:ed::22)
 by CH2PR12MB3894.namprd12.prod.outlook.com (2603:10b6:610:2b::28)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.10; Mon, 8 Nov
 2021 14:47:13 +0000
Received: from BN8NAM11FT018.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ed:cafe::80) by BN0PR04CA0137.outlook.office365.com
 (2603:10b6:408:ed::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.10 via Frontend
 Transport; Mon, 8 Nov 2021 14:47:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.35)
 smtp.mailfrom=nvidia.com; grimberg.me; dkim=none (message not signed)
 header.d=none;grimberg.me; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.35 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.35; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.35) by
 BN8NAM11FT018.mail.protection.outlook.com (10.13.176.89) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4669.10 via Frontend Transport; Mon, 8 Nov 2021 14:47:12 +0000
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Mon, 8 Nov
 2021 14:47:10 +0000
Received: from r-arch-stor02.mtr.labs.mlnx (172.20.187.6) by mail.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server id 15.0.1497.18 via Frontend
 Transport; Mon, 8 Nov 2021 14:47:08 +0000
From: Max Gurtovoy <mgurtovoy@nvidia.com>
To: <linux-nvme@lists.infradead.org>, <hch@lst.de>, <kbusch@kernel.org>,
 <sagi@grimberg.me>
CC: <chaitanyak@nvidia.com>, <oren@nvidia.com>, <benishay@nvidia.com>,
 <borisp@nvidia.com>, <aviadye@nvidia.com>, <idanb@nvidia.com>,
 <jsmart2021@gmail.com>, Max Gurtovoy <mgurtovoy@nvidia.com>
Subject: [PATCH 1/1 nvmecli] fabrics: add new --skip-cid-gen flag to connect
 cmd
Date: Mon, 8 Nov 2021 16:46:58 +0200
Message-ID: <20211108144703.7971-2-mgurtovoy@nvidia.com>
X-Mailer: git-send-email 2.18.1
In-Reply-To: <20211108144703.7971-1-mgurtovoy@nvidia.com>
References: <20211108144703.7971-1-mgurtovoy@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b2318e31-dfef-459d-6acc-08d9a2c6a64a
X-MS-TrafficTypeDiagnostic: CH2PR12MB3894:
X-Microsoft-Antispam-PRVS: <CH2PR12MB3894026BED68EA91F844405BDE919@CH2PR12MB3894.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: b5TjiVPlQh2+UBWAaSWn9kybaRCZV9V4FfCNpUAOtC1ndHQasEun7rKBS4IYWKaW8y3m+6nkyJroafz/4PILAoVZi9s1gt8mXSm9f5lsPa1RqDVigzXyD1GZEBXiKxYPjUoTiizztyF6xHIpli7feuCSoBpbVeK3hsWTISA4+SImYhaMKkern44FE1BG6HCQAGjp3KCPWIRA590QoS5xy1VLjAS4m6dEbGMVYTg7PHeLnXQlVOrowhbd8z6LD3sjjDRKbHE1918DMra1HMliBHYfezaOLl2aszP4F5tq5zX59uf4kxPfy4jvC2IjLHpq23JPWsnx84kHPErTRPRRNlzWKPaZ5xJ7KSSmCJFAbFZCQXVk1vjtebkuh4nHdUXW1ppvrJPJtK8QQHAwgBnshiK5vHjk5nn4mp9xkrpAXsSKql5FP61N0cCXi9+KOtCWsbKDS7WgwS2hg4rIlzsQflPNHUrdZSeGOiZQuIsiifJr21rhB6vKtRvfEtUZTlIUt3NnQzR7PKlTK+HWvzs0GwQ4v4a0VQ5w8wCly59jneTiNDsREjpSIjT1KREoF5yauc0VFzSusrLykCrkGwCzLUKjMRLJXkEjd/d9vl2mIt6oY+wb3KCY1ROUBJE0dyQmZQMtJ0PDFSbk7Tw6PKPjjL3RHPP/znxyVCwpsMcGM931EhrCMeCqWcfuHVftckR6AT8YrcQ5HPDjp/NcaeJlPA==
X-Forefront-Antispam-Report: CIP:216.228.112.35; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:schybrid04.nvidia.com; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(8936002)(2616005)(36756003)(70586007)(316002)(36906005)(336012)(110136005)(54906003)(82310400003)(1076003)(6666004)(5660300002)(508600001)(2906002)(8676002)(70206006)(426003)(36860700001)(107886003)(26005)(86362001)(186003)(4326008)(356005)(7636003)(83380400001)(47076005);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2021 14:47:12.4966 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b2318e31-dfef-459d-6acc-08d9a2c6a64a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.112.35];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT018.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3894
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211108_064718_205528_29653530 
X-CRM114-Status: GOOD (  10.06  )
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

Setting this flag will enable NVME_QUIRK_SKIP_CID_GEN quirk and will
actually add the ability to ignore the command id generation for other
transport alongside PCI transport that is possible today.

Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
---
 Documentation/nvme-connect.html | 15 ++++++++++++++-
 fabrics.c                       | 10 ++++++----
 2 files changed, 20 insertions(+), 5 deletions(-)

diff --git a/Documentation/nvme-connect.html b/Documentation/nvme-connect.html
index 8e25db9..d0a53d6 100644
--- a/Documentation/nvme-connect.html
+++ b/Documentation/nvme-connect.html
@@ -767,7 +767,8 @@ nvme-connect(1) Manual Page
                 [--duplicate-connect      | -D]
                 [--disable-sqflow         | -d]
                 [--hdr-digest             | -g]
-                [--data-digest            | -G]</pre>
+                [--data-digest            | -G]
+                [--skip-cid-gen           | -p]</pre>
 <div class="attribution">
 </div></div>
 </div>
@@ -1028,6 +1029,18 @@ cellspacing="0" cellpadding="4">
         Generates/verifies data digest (TCP).
 </p>
 </dd>
+<dt class="hdlist1">
+-p
+</dt>
+<dt class="hdlist1">
+--skip-cid-gen
+</dt>
+<dd>
+<p>
+        Skip command id generation control that was added to protect against buggy
+	fabric controllers.
+</p>
+</dd>
 </dl></div>
 </div>
 </div>
diff --git a/fabrics.c b/fabrics.c
index 012bcb8..02a4108 100644
--- a/fabrics.c
+++ b/fabrics.c
@@ -72,6 +72,7 @@ static const char *nvmf_dup_connect	= "allow duplicate connections between same
 static const char *nvmf_disable_sqflow	= "disable controller sq flow control (default false)";
 static const char *nvmf_hdr_digest	= "enable transport protocol header digest (TCP transport)";
 static const char *nvmf_data_digest	= "enable transport protocol data digest (TCP transport)";
+static const char *nvmf_skip_cid_gen	= "skip command id generation control (default false)";
 static const char *nvmf_config_file	= "Use specified JSON configuration file or 'none' to disable";
 
 #define NVMF_OPTS(c)									\
@@ -93,7 +94,8 @@ static const char *nvmf_config_file	= "Use specified JSON configuration file or
 	OPT_FLAG("duplicate-connect", 'D', &c.duplicate_connect,  nvmf_dup_connect),	\
 	OPT_FLAG("disable-sqflow",    'd', &c.disable_sqflow,     nvmf_disable_sqflow),	\
 	OPT_FLAG("hdr-digest",        'g', &c.hdr_digest,         nvmf_hdr_digest),	\
-	OPT_FLAG("data-digest",       'G', &c.data_digest,        nvmf_data_digest)     \
+	OPT_FLAG("data-digest",       'G', &c.data_digest,        nvmf_data_digest),    \
+	OPT_FLAG("skip-cid-gen",      'p', &c.skip_cid_gen,       nvmf_skip_cid_gen)	\
 
 
 static void space_strip_len(int max, char *str)
@@ -363,7 +365,7 @@ static int discover_from_conf_file(nvme_host_t h, const char *desc,
 		if (!c)
 			goto next;
 		errno = 0;
-		ret = nvmf_add_ctrl(h, c, &cfg, false);
+		ret = nvmf_add_ctrl(h, c, &cfg, false, false);
 		if (!ret) {
 			__discover(c, &cfg, raw, connect,
 				   persistent, flags);
@@ -513,7 +515,7 @@ int nvmf_discover(const char *desc, int argc, char **argv, bool connect)
 			ret = errno;
 			goto out_free;
 		}
-		ret = nvmf_add_ctrl(h, c, &cfg, false);
+		ret = nvmf_add_ctrl(h, c, &cfg, false, false);
 		if (ret) {
 			nvme_msg(LOG_ERR,
 				 "failed to add controller, error %d\n", errno);
@@ -626,7 +628,7 @@ int nvmf_connect(const char *desc, int argc, char **argv)
 	}
 
 	errno = 0;
-	ret = nvmf_add_ctrl(h, c, &cfg, cfg.disable_sqflow);
+	ret = nvmf_add_ctrl(h, c, &cfg, cfg.disable_sqflow, cfg.skip_cid_gen);
 	if (ret)
 		nvme_msg(LOG_ERR, "no controller found\n");
 out_free:
-- 
2.18.1


