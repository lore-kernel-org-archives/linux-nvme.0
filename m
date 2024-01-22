Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F50AC47DD9
	for <linux-nvme@archiver.kernel.org>; Mon, 22 Jan 2024 14:58:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:CC:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ESyVRkY6XlYwX3lKKxbxSiRQ7PhtG0xxo+PkWZL7o+c=; b=KMaN0cyabSpKij9FKRVf+gnftc
	9NzW5wN+B3AG1EM0+C1roxzzGAHY2oT+hUVmmdfQ5yY0H+MknaexudmGrnQ1+ED+0zKWduVXB2XhZ
	Bpzz6kyr5630YgSbKccAEYdrszumw/a3gTke1Rg8f32wK1s/LOH3hhOUo/8sB2Z6s3emlA1wQv5JS
	AiWAa3w95eVHpd2lohICV+bU2iE6Sj5/oIGMVBG/gQyzZcDNFmH9tLJhzaRsmWG8bfA+jg4nGd7e5
	M+y6LWNtmvbA4Y0XlAzW6rY3UmvavMzaH8t/O6C6WF8JUTcMTIF/8egnEMzLN+Qs/QhyB82heFi/b
	fwijUpiA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rRvkh-00CWHO-2x;
	Mon, 22 Jan 2024 14:58:19 +0000
Received: from mail-sn1nam02on2047.outbound.protection.outlook.com ([40.107.96.47] helo=NAM02-SN1-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rRvkf-00CWDf-0P
	for linux-nvme@lists.infradead.org;
	Mon, 22 Jan 2024 14:58:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a3nVMSM0UMtM4+heFsIWXLnMeczU0Jr7ORP/DyUyxovdckFUkf8JAj75WtABs0/CpG5y2zYNm1rOtiXtP2TRKsELNA9EYiyr/PDlASVb0Cpdh6TPsAnkajjcWtp55mtEhcV7QO1hQn00p/VzC+IJK1POr1eXPBZNKeO5hqOAcJC6coQ5/MYATttbYFzL4ntF7GJqF+WMjB2aj8b9yoNATk/tKrhymp2k80s/4wktJgk7T7nKiddQvCz0Myf3EGVLaMn2QGEAWyNOtGpLlrVHedjZZhpU47TJR5kgj0MWGN0uLbsWZOig+KYzzh54sIyZVOvjSkj1js/Dg7jLJ9ouJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ESyVRkY6XlYwX3lKKxbxSiRQ7PhtG0xxo+PkWZL7o+c=;
 b=L/Q4lF9XuqRTT4rs6voEsVginhELb06liWsAIEkYFj69XNEqW3GMuWr4ZGs10MiYkTbQwbjYBm7CxHxHPI9a+l3AhID1/mUxgSBwnhgmxOgfWyy5GTytVGNepmMuOOSt0uwbyVbPWnQ4NBGSJk/bunRP3K3O8AKCPEyQnfIuY2xQzUFMoFrU7P5j2vWdpR+RT1pm7Ln7wnagQamV8qZuwEiA+0hLD1GgYZ8BN8/LqI0fU5xE8L3H4UeuTv5aYoLetLEbW+vrGEjV+HbOQzdkXTNMf10iZk8ScremWG/8tejE7yVXTJk+wtmYY1rVLP6bRYPcfB85oR5uphfimKqxcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ESyVRkY6XlYwX3lKKxbxSiRQ7PhtG0xxo+PkWZL7o+c=;
 b=bLxcZp6lmr4LGKGLPCtXSMK3/FJH+WgU6a8UvlwJ5fjMgVTfhvhyRlFh+3ryzUxhGi+uSFhImAD2nqcZBWd/sgGUEaPkoGi+LZsug/4AoXEf5AQehXGAGK7cUgAKuZwcex8G25NOHROoR/cDXQVrbWTvZPneZM4z7FbxS9B57lDLllLuvnm5aBj6Q0uB7qpmpBxQvPJi9GWY2nvxm1avSFC4H63pZQYNablg/RXTAA0dLLmar6wWoQH51Bzys9+b/XMg9ikWC+CEBUkX/Y73pzqugpWcv2DdCX6rl7yBxuPumenEgUvakR8YoMqh6PgDDgNErYgmGHbrVfD6BjRSgg==
Received: from SN4PR0501CA0033.namprd05.prod.outlook.com
 (2603:10b6:803:40::46) by BN9PR12MB5177.namprd12.prod.outlook.com
 (2603:10b6:408:11a::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.34; Mon, 22 Jan
 2024 14:57:56 +0000
Received: from SA2PEPF00001508.namprd04.prod.outlook.com
 (2603:10b6:803:40:cafe::44) by SN4PR0501CA0033.outlook.office365.com
 (2603:10b6:803:40::46) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.15 via Frontend
 Transport; Mon, 22 Jan 2024 14:57:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SA2PEPF00001508.mail.protection.outlook.com (10.167.242.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7202.16 via Frontend Transport; Mon, 22 Jan 2024 14:57:56 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 22 Jan
 2024 06:57:22 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Mon, 22 Jan 2024 06:57:21 -0800
Received: from r-arch-stor03.mtr.labs.mlnx (10.127.8.14) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.986.41 via Frontend
 Transport; Mon, 22 Jan 2024 06:57:19 -0800
From: Max Gurtovoy <mgurtovoy@nvidia.com>
To: <kbusch@kernel.org>, <hch@lst.de>, <sagi@grimberg.me>,
	<linux-nvme@lists.infradead.org>
CC: <oren@nvidia.com>, <israelr@nvidia.com>, <dwagner@suse.de>,
	<oevron@nvidia.com>
Subject: [PATCH 7/8] nvme-fabrics: add option to disallow T10-PI offload
Date: Mon, 22 Jan 2024 16:56:58 +0200
Message-ID: <20240122145659.5574-8-mgurtovoy@nvidia.com>
X-Mailer: git-send-email 2.18.1
In-Reply-To: <20240122145659.5574-1-mgurtovoy@nvidia.com>
References: <20240122145659.5574-1-mgurtovoy@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001508:EE_|BN9PR12MB5177:EE_
X-MS-Office365-Filtering-Correlation-Id: 9234d6f0-ad4f-4c58-286f-08dc1b5a8487
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: b+9/6saGsaKZKFD/gHXweNk/iHpQ35HvpdFvyjg0UfiaW1pAybgd8ea3h+RfDaag8uq32OlewrIru/yP2SjVKOmS0VWcpIkeLh4cPnD++HhUGf4pFlgPmbJOI8+USVCmKwcBISTLeK32jNBsxm803vSAqp6ncFaAwD2fpsykTqjzSQB49c0sfmLdYNPOPnXuDTStjdgzpzOg+snpFEPWDT0YUsmPyEbrNjEK3lVrqHJjkoSjJ5kwUeq0awxibXBpUwP4GIq9D/jUGG05W0BNGyLQEJ+cajlQCjbUGDHDbK5DcH5D82pwNcLTJx5SaIPAiIMT6zT78CKkZ4/XJv9kk4Km8qVtIxfiJYoULCNVS/7E2hiY9PPVdOBBIvBrl7nx9aTp/iM1zapM9/RSdg49K7ar/ioAt1vHC6SExZt3XizVKJxA5pAjzKCk7KMAI41XA7bqu4et4vG5jgD4CpcmfTkEaO+WiW8hBLjEaMiuXl9r/XTy8ooJ2jDsiW/BPHsT1ayICwiZ399qp3gg4B0+k/U3jPF9NHMj8APF2dCxPyOjkdRdv2pIvUlRMWD1v21F482WTClRC0yfmNarKDfwd4FD2gpNtAhYzGBTwJg8A80wTZVgOuKdhpe3dNVG/2P5fD05tsIvB7TapTIK17doAn52nVj7dVLH/z8CBQ8jcAEfDP2u+U5pCsmXwob3AVGBA0+IIhhKrEJNiiZ9pBhgGMIEyFUuhnHGW83FrmcF4YSVPJbsOh7A9wR7g+3wj6gB
X-Forefront-Antispam-Report: CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(346002)(376002)(396003)(39860400002)(136003)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(82310400011)(40470700004)(36840700001)(46966006)(40460700003)(40480700001)(6666004)(426003)(336012)(26005)(1076003)(2616005)(107886003)(356005)(36756003)(86362001)(7636003)(82740400003)(41300700001)(36860700001)(47076005)(5660300002)(2906002)(8936002)(8676002)(478600001)(110136005)(4326008)(70206006)(70586007)(316002)(54906003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2024 14:57:56.2974
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9234d6f0-ad4f-4c58-286f-08dc1b5a8487
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00001508.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5177
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240122_065817_200767_B7D56E24 
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

From: Israel Rukshin <israelr@nvidia.com>

Today, T10-PI offload is supported only by nvme-rdma, but nothing
prevents other transports reusing the concept, so do not associate
with rdma transport solely. The flag disallows T10-PI offload, so
users can save system resources and allow a more flexible
configuration.

Signed-off-by: Israel Rukshin <israelr@nvidia.com>
Reviewed-by: Max Gurtovoy <mgurtovoy@nvidia.com>
---
 drivers/nvme/host/fabrics.c | 7 +++++++
 drivers/nvme/host/fabrics.h | 3 +++
 2 files changed, 10 insertions(+)

diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
index aa88606a44c4..046f5a466576 100644
--- a/drivers/nvme/host/fabrics.c
+++ b/drivers/nvme/host/fabrics.c
@@ -673,6 +673,9 @@ static const match_table_t opt_tokens = {
 #endif
 #ifdef CONFIG_NVME_TCP_TLS
 	{ NVMF_OPT_TLS,			"tls"			},
+#endif
+#ifdef CONFIG_BLK_DEV_INTEGRITY
+	{ NVMF_OPT_DISALLOW_PI,		"disallow_pi"		},
 #endif
 	{ NVMF_OPT_ERR,			NULL			}
 };
@@ -702,6 +705,7 @@ static int nvmf_parse_options(struct nvmf_ctrl_options *opts,
 	opts->tls = false;
 	opts->tls_key = NULL;
 	opts->keyring = NULL;
+	opts->disallow_pi = false;
 
 	options = o = kstrdup(buf, GFP_KERNEL);
 	if (!options)
@@ -915,6 +919,9 @@ static int nvmf_parse_options(struct nvmf_ctrl_options *opts,
 		case NVMF_OPT_DATA_DIGEST:
 			opts->data_digest = true;
 			break;
+		case NVMF_OPT_DISALLOW_PI:
+			opts->disallow_pi = true;
+			break;
 		case NVMF_OPT_NR_WRITE_QUEUES:
 			if (match_int(args, &token)) {
 				ret = -EINVAL;
diff --git a/drivers/nvme/host/fabrics.h b/drivers/nvme/host/fabrics.h
index fbaee5a7be19..cd0140a2abe7 100644
--- a/drivers/nvme/host/fabrics.h
+++ b/drivers/nvme/host/fabrics.h
@@ -73,6 +73,7 @@ enum {
 	NVMF_OPT_TLS		= 1 << 25,
 	NVMF_OPT_KEYRING	= 1 << 26,
 	NVMF_OPT_TLS_KEY	= 1 << 27,
+	NVMF_OPT_DISALLOW_PI	= 1 << 28,
 };
 
 /**
@@ -115,6 +116,7 @@ enum {
  * @nr_poll_queues: number of queues for polling I/O
  * @tos: type of service
  * @fast_io_fail_tmo: Fast I/O fail timeout in seconds
+ * @disallow_pi: Disallow metadata (T10-PI) offload support
  */
 struct nvmf_ctrl_options {
 	unsigned		mask;
@@ -140,6 +142,7 @@ struct nvmf_ctrl_options {
 	bool			disable_sqflow;
 	bool			hdr_digest;
 	bool			data_digest;
+	bool			disallow_pi;
 	unsigned int		nr_write_queues;
 	unsigned int		nr_poll_queues;
 	int			tos;
-- 
2.18.1


