Return-Path: <SRS0=7QfS=PU=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1A6AC433F5
	for <linux-nvme@archiver.kernel.org>; Mon,  1 Nov 2021 23:17:55 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9805B60524
	for <linux-nvme@archiver.kernel.org>; Mon,  1 Nov 2021 23:17:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 9805B60524
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=2VbEp0N4wxgt3TmKshsG6eoLFQ5ShkVnY6Z0iJhVKjA=; b=FeH/QIDWylzDDnshSvzuJT9rxR
	h5IvgtIvbOGaqx7TPiTcwKRn7EzoPz0oSkRGEYTJ3SQfBeZ+MtI3bjCzrP6e3FRAXsT80c3k3KL7D
	911qscbreVTN8/hboGlJDNF+qBHzKdrc+jelpikdd6dFNZ6UMbo3NKlGyfF/OJayRXsm73yPWQQ68
	I/RGSnjc7fjEBmGewi+gtSLz6BliabGbPo934htf/da5qp6MQfhBif5mZBoIoT60DC/NoNh5WslFd
	vNxrxULA7A0hBlSfOCbniLp2/5qTG26WGBLYilqzV9owLSNyLHcCExKvWD/6bQcqJhIHyc4afd/eI
	Ohcppu0Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mhgYg-00HWTk-Fj; Mon, 01 Nov 2021 23:17:42 +0000
Received: from mail-bn7nam10on2056.outbound.protection.outlook.com
 ([40.107.92.56] helo=NAM10-BN7-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mhgYd-00HWTG-79
 for linux-nvme@lists.infradead.org; Mon, 01 Nov 2021 23:17:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QelNozd4567fowc2KelSENqMRVjYR3yTndtuAr/Z8peuNhYyvYa6vDGvYlthRJIIPuPGSnlI2eJOzUKRUkegQbR4E/TFKoPqXkJ0k3EX8IlSwWL8oV6/C62thB3iF2aoQYYtsxS3tXh4K4VEpLvLi1pQ3tURqamwA++ct5u9TRzKKTrV6tMiK2KiadSbL9QS3fTDCISuBZZPUDcCQLHv/WNfcTXAY65PPEcFc8vpre2g1UdLWsfxxPGgiT/83uImgbDbGkCOjIwapqcrMDXvGaPEuKYQawcNyF3KuY7bQwGRkPUmsa6JrlGU72Zd04bVZWOVW6pkGYtpSmWtavWClg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2VbEp0N4wxgt3TmKshsG6eoLFQ5ShkVnY6Z0iJhVKjA=;
 b=ZHwBWKtUsvbXL3MDN4MBzRlfqWOKKYUMaFv/Ub2P4VysphW6rXBFaL27Y6Xo8d3Mhcbc1v7Yzc2Cn07l3tgPJjVcI5gjqCvhRsebcfgN3zl7YrNZuejtzDjj4mp45aImZ4b8AUl2buzXxQm4rkdTP9AMkarW6nB5E4GW/V/eIMF+GV98DANm8pm+ovxuEnThUW2Kr+Wnslrl5hY/63+ezmYlhN5FGPBnWxQvBHLFKzSflKItholIzed3meZnQqazbUnnxQW/1CWmTdlf1/GdVadbwbC2SV3rjYCa04zoR6N1d/i0ItVBQLFzTEGkkwf68gFNQGclPifrS65BGLt8bA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=lst.de smtp.mailfrom=nvidia.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2VbEp0N4wxgt3TmKshsG6eoLFQ5ShkVnY6Z0iJhVKjA=;
 b=TlsifQGco9HokFOa74R02Wfi2oZFyWAtvZwIe+QzfwIflZB/VyWjm76RBYCxsScZRqmrbH95TY5o3iKPTfU1xayuSfbCPr42P597K7d8wnGDXP3Dts3gQihOUMmQKhBczZYbsC1qVBWS4KZTOxNb+FH83uKXnHJsH8D2PM8x2UPKRRfnTTgwf/gpToh0LTKztCd3BNDkB3EENBKmLXuHF9M/8YrCFDgSN5r/Onpo6M8QwIv8TjoitOjltkaLuSNLxH+NA3sjXQ0lrOVdzSPhB7tKMJJGu8sVDmXAXo4Kqoq8v/+/IPUtSIjNfziDB6qJWvLadXm0BXSQ2Lb1CtwK3g==
Received: from DM5PR16CA0021.namprd16.prod.outlook.com (2603:10b6:3:c0::31) by
 MN2PR12MB3215.namprd12.prod.outlook.com (2603:10b6:208:101::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.20; Mon, 1 Nov
 2021 23:17:27 +0000
Received: from DM6NAM11FT066.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:c0:cafe::47) by DM5PR16CA0021.outlook.office365.com
 (2603:10b6:3:c0::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.15 via Frontend
 Transport; Mon, 1 Nov 2021 23:17:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 DM6NAM11FT066.mail.protection.outlook.com (10.13.173.179) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4649.14 via Frontend Transport; Mon, 1 Nov 2021 23:17:27 +0000
Received: from dev.nvidia.com (172.20.187.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Mon, 1 Nov
 2021 23:17:25 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: <linux-nvme@lists.infradead.org>
CC: <kbusch@kernel.org>, <hch@lst.de>, <sagi@grimberg.me>, Chaitanya Kulkarni
 <kch@nvidia.com>
Subject: [RFC PATCH] nvmf: allow user to choose cid-genctr feature
Date: Mon, 1 Nov 2021 16:17:19 -0700
Message-ID: <20211101231719.10256-1-chaitanyak@nvidia.com>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Type: text/plain; charset="y"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [172.20.187.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 25424929-bff8-4560-dd3e-08d99d8dc52b
X-MS-TrafficTypeDiagnostic: MN2PR12MB3215:
X-Microsoft-Antispam-PRVS: <MN2PR12MB3215C6D96C73306C0934DE17A38A9@MN2PR12MB3215.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Vs4HH+lSWle3BozKhNDIozx6rIhD5nKBQMVyZRQpJECV8oQIknnayy7K71i9kuA6xixndRyxwherx29Qox2R3HGz7ePBPvotXUU95QpM57URRe2U5eHpaPh3AL9rPSHMnl4dyJgbDNyCVRJCWy475JevOGpooQSZ5j9LLyzk5Ycua8B6qw2e0WX6WdQy7fZVlWiYAvYGsZnXQKEvjRVfQIT2IJo3O+X7vPgQqJf3HrXAvCloA536PM0mb8k69MgbTX5PQH+Rh/Dlzeb1UZy8L4P26OPgPw8Uw5P0y42lkwjRltZCekt1hWJ36LWJbR2dZuELoghK7TiY3DhKT2FHuqT3sNeuvuGR5MGPpu0WNjlOt+eWZeCVATOmHkO5JBTZe6zGY38vP5nAPqJYVkwAVFAx7I4zK+y9fOGQe/eXsXCYeTDYmKxLAaLkA+fVnKPsSQJs9lxiwzFRuPoXaKFKvGo+pvoLfqn94HGORB91q3pplrPYv5w5ygngZu0n69hb5/T55UrDWd5zYNnPpoP9S8Ksd0e+DshSN52hqits9QPdGM1+LcRWBJhnkKgDf4jUOSXIEK9ciZaVK2a5/6UtE+Ce9Teni52n6eSy0lZO4xGVBBSJ9g3T47KQMNLHdJ39b+ilN2fguUwnzL2/5uyWioQ8Ha1DrRC6KsogS/Jb/4vWhgR2HEYrDdP0fbyXKcKnr2+DVDF4h1Ni+JyGFwhMMg==
X-Forefront-Antispam-Report: CIP:216.228.112.34; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:schybrid03.nvidia.com; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(107886003)(26005)(47076005)(4326008)(1076003)(36756003)(6916009)(5660300002)(336012)(86362001)(508600001)(70206006)(82310400003)(54906003)(6666004)(316002)(70586007)(36860700001)(8676002)(36906005)(426003)(2906002)(186003)(83380400001)(356005)(16526019)(7696005)(2616005)(8936002)(7636003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2021 23:17:27.2412 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 25424929-bff8-4560-dd3e-08d99d8dc52b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.112.34];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT066.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3215
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211101_161739_465230_90C2B791 
X-CRM114-Status: GOOD (  17.36  )
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

From: Chaitanya Kulkarni <kch@nvidia.com>

Some fabrics controllers use the command id as an index to
implement specific data structures and will fail if the value is
out of bounds. The nvme driver's recently introduced command sequence
number breaks these controllers.
 
Allow the user to choose the use of the genctr in calculating the command
id when connecting to the fabrics controller.
 
The driver will not have the ability to detect bad completions when
this flag is set to false for a ctrl, but we weren't previously
checking this anyway.

Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
---
Hi,
 
Please let know if this approach is acceptable unless there is better one.

The one side effect I see is bloating the nvmf controller options but I
think it is still reasonable.

Also, we can reverse the name of the param from use_genctr ->
skip_genctr to match the NVME_QUIRK_SKIP_CID_GEN macro name along with
the respective logic.

-ck
---
 drivers/nvme/host/fabrics.c | 4 ++++
 drivers/nvme/host/fabrics.h | 2 ++
 drivers/nvme/host/rdma.c    | 3 +++
 drivers/nvme/host/tcp.c     | 3 +++
 4 files changed, 12 insertions(+)

diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
index c5a2b71c5268..6e7dafaff750 100644
--- a/drivers/nvme/host/fabrics.c
+++ b/drivers/nvme/host/fabrics.c
@@ -549,6 +549,7 @@ static const match_table_t opt_tokens = {
 	{ NVMF_OPT_TOS,			"tos=%d"		},
 	{ NVMF_OPT_FAIL_FAST_TMO,	"fast_io_fail_tmo=%d"	},
 	{ NVMF_OPT_DISCOVERY,		"discovery"		},
+	{ NVMF_OPT_USE_GENCTR,		"use_genctr"		},
 	{ NVMF_OPT_ERR,			NULL			}
 };
 
@@ -772,6 +773,9 @@ static int nvmf_parse_options(struct nvmf_ctrl_options *opts,
 			}
 			kfree(p);
 			break;
+		case NVMF_OPT_USE_GENCTR:
+			opts->use_genctr = true;
+			break;
 		case NVMF_OPT_DUP_CONNECT:
 			opts->duplicate_connect = true;
 			break;
diff --git a/drivers/nvme/host/fabrics.h b/drivers/nvme/host/fabrics.h
index c3203ff1c654..8fd845fba386 100644
--- a/drivers/nvme/host/fabrics.h
+++ b/drivers/nvme/host/fabrics.h
@@ -68,6 +68,7 @@ enum {
 	NVMF_OPT_FAIL_FAST_TMO	= 1 << 20,
 	NVMF_OPT_HOST_IFACE	= 1 << 21,
 	NVMF_OPT_DISCOVERY	= 1 << 22,
+	NVMF_OPT_USE_GENCTR	= 1 << 23,
 };
 
 /**
@@ -128,6 +129,7 @@ struct nvmf_ctrl_options {
 	unsigned int		nr_poll_queues;
 	int			tos;
 	int			fast_io_fail_tmo;
+	bool			use_genctr;
 };
 
 /*
diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 9317f26e51e0..41a170c77e6f 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -2333,6 +2333,9 @@ static struct nvme_ctrl *nvme_rdma_create_ctrl(struct device *dev,
 	ctrl->ctrl.opts = opts;
 	INIT_LIST_HEAD(&ctrl->list);
 
+	if (!opts->use_genctr)
+		ctrl->ctrl.quirks |= NVME_QUIRK_SKIP_CID_GEN;
+
 	if (!(opts->mask & NVMF_OPT_TRSVCID)) {
 		opts->trsvcid =
 			kstrdup(__stringify(NVME_RDMA_IP_PORT), GFP_KERNEL);
diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 07156ea9d1a8..1ca2625ffdef 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -2536,6 +2536,9 @@ static struct nvme_ctrl *nvme_tcp_create_ctrl(struct device *dev,
 		goto out_free_ctrl;
 	}
 
+	if (!opts->use_genctr)
+		ctrl->ctrl.quirks |= NVME_QUIRK_SKIP_CID_GEN;
+
 	if (opts->mask & NVMF_OPT_HOST_TRADDR) {
 		ret = inet_pton_with_scope(&init_net, AF_UNSPEC,
 			opts->host_traddr, NULL, &ctrl->src_addr);
-- 
2.29.0


