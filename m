Return-Path: <SRS0=LsNR=P3=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08FFEC433EF
	for <linux-nvme@archiver.kernel.org>; Mon,  8 Nov 2021 14:48:15 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BACC361359
	for <linux-nvme@archiver.kernel.org>; Mon,  8 Nov 2021 14:48:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org BACC361359
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:CC:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=iq5R2UTpSuhQkBz2YG/zOVfozh66lE9pSY5jvCO/exE=; b=LGtSkEp+4AdFNumAYnVG8QDSiY
	Jpx9mjZimklQR2Ympjh/EqZtQpNWIfnbcH1IykdHLEqBNY/LZYacKaLmnjpfNguWwKI4/HumJU/no
	U47YNSmfwDmpZTsZ5A1BU6680H2ij1qEjhzhvd7dOMZJx7q7CMzpB/loiPXzRoOdZL6mtA5sSGonL
	Q5LSz+IPc94rADZVWB09Qka5n29SGxwSQH4JJRbIhc9p4zfi6JDTyjXX0KB9evM6AOCHhyCfbabQ1
	yLWYGr3pbMKXwTADEeNZ0XKvti0STqb/mvVxX5SFpYEvwnaHA/p3HTuFCvFOnFYGvVsqFw8QUSOmh
	Kl/X/R9g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mk5wS-00Gi9n-CW; Mon, 08 Nov 2021 14:48:12 +0000
Received: from mail-dm6nam10on2051.outbound.protection.outlook.com
 ([40.107.93.51] helo=NAM10-DM6-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mk5vh-00Ghyc-La
 for linux-nvme@lists.infradead.org; Mon, 08 Nov 2021 14:47:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nbsLTlagyZBAb84BK5u+FaGXELuELRj8f7NWKxBuS8FJnbuDAWcTUuwMlI/hPmmGDjvU/FlRWqXwmzGh8urniTctzwhEpEuFULruMUl4UOD4JBGqCDLL7iP2DaoaNgkYNz4mVh2gwvPuI4y7SseUiJ3/3l8R7CyIfrt0WZEhaDNavkKx5GYhYUhD/ItQNaajUjjsd/w8DPT7VhX/gr+4GiBPKCR+48dnlhpxw5RdZWfNq54qQPfXzZoTC8uWPCg+fvRY4uv31KEltKp5sOcGr92m/JUVjHyFoQjETMG4B38wxTcXHUHozKzfFZu2X1W/NlCaQ5FsUnk9xf2tjN99Rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iq5R2UTpSuhQkBz2YG/zOVfozh66lE9pSY5jvCO/exE=;
 b=nZgpEnckshBT1lTHMUM6rhYKFG/gEFo+B9qLtg59q90faeaMIM5UukkUd7b+9B2YpR1sBWJWn8bxg27tSN7oXSurujKhgeP4GnMOkm+2JH0cyF/jpEjBW/3Le8OyUxyTcaJzcIESlydGpO8DtY+IT+wtfFXK88DwdfH0eELReomZ6hVanhZjOmA+7r0r8tvDVEeoJab0aXX5lvZNdMb+cN6CWXQmHWnVExTaBTbmdvEA5WFpTaLlNyRY+sjghM709FtwTeuw83OG+lw/D1fNU781nwFQWipxBt0cactEzjc7gfJRXT0R8UICa4O7OIwdzjlvb2M96UjPhjiXWj/FVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=lists.infradead.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iq5R2UTpSuhQkBz2YG/zOVfozh66lE9pSY5jvCO/exE=;
 b=UPKBntVNEqT2/HIUDzFDK3ENrnjbL0QajHYPkHG+7eYpgZTnXe5H+n89rAkxQnvNEmYCErRTzIDWUQzY2hja0OX/3nVQmyJqf+PTdTIcNkofDB612PxztoLlOrT6tXq7aHbCn3kQBhe4RPio+QX3jy5S4Nfk0W1IoKnvbkTMkJoyB+Wto06k4qrtKmkSmheSbH9cdmhZ+XY9cTY+z0+4Y54MFbN1r+4SCNYcno3fmXx+C6z2S2ffTUGUWKEacymaX6OxQ3w9XB9tQwbR33G1bgksSe4jkiGkbfZETMnV7UOfkbi61N78qRtx2/9tgBA/PtL2Q8uSTN5Gsfu01I6QXw==
Received: from DM6PR14CA0050.namprd14.prod.outlook.com (2603:10b6:5:18f::27)
 by BYAPR12MB3431.namprd12.prod.outlook.com (2603:10b6:a03:da::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.10; Mon, 8 Nov
 2021 14:47:18 +0000
Received: from DM6NAM11FT003.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:18f:cafe::9e) by DM6PR14CA0050.outlook.office365.com
 (2603:10b6:5:18f::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.10 via Frontend
 Transport; Mon, 8 Nov 2021 14:47:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; lists.infradead.org; dkim=none (message not signed)
 header.d=none;lists.infradead.org; dmarc=pass action=none
 header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 DM6NAM11FT003.mail.protection.outlook.com (10.13.173.162) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4669.10 via Frontend Transport; Mon, 8 Nov 2021 14:47:17 +0000
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Mon, 8 Nov
 2021 14:47:17 +0000
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Mon, 8 Nov
 2021 14:47:16 +0000
Received: from r-arch-stor02.mtr.labs.mlnx (172.20.187.6) by mail.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server id 15.0.1497.18 via Frontend
 Transport; Mon, 8 Nov 2021 14:47:14 +0000
From: Max Gurtovoy <mgurtovoy@nvidia.com>
To: <linux-nvme@lists.infradead.org>, <hch@lst.de>, <kbusch@kernel.org>,
 <sagi@grimberg.me>
CC: <chaitanyak@nvidia.com>, <oren@nvidia.com>, <benishay@nvidia.com>,
 <borisp@nvidia.com>, <aviadye@nvidia.com>, <idanb@nvidia.com>,
 <jsmart2021@gmail.com>, Max Gurtovoy <mgurtovoy@nvidia.com>
Subject: [PATCH 1/4] nvme-fabrics: add command id quirk for fabrics controllers
Date: Mon, 8 Nov 2021 16:47:00 +0200
Message-ID: <20211108144703.7971-4-mgurtovoy@nvidia.com>
X-Mailer: git-send-email 2.18.1
In-Reply-To: <20211108144703.7971-1-mgurtovoy@nvidia.com>
References: <20211108144703.7971-1-mgurtovoy@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 694b262e-99ef-4b81-9d32-08d9a2c6a97f
X-MS-TrafficTypeDiagnostic: BYAPR12MB3431:
X-Microsoft-Antispam-PRVS: <BYAPR12MB3431C82800EB6E835DC42193DE919@BYAPR12MB3431.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:268;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: po3UBBz3XaNNTJ915NtYRFZuZIaU+jMNwk+K4t/3QluNuY20AEOKymVJAv4/5yeku9W7kILWDX8oJ/NU2eAW4bqH8PCAH3e+6Ji69/zM2UIS4C9p6WF+ynSxX+1CZmagvzio1fG0nEFughJiged06hRJGQAXKOp2JQ/gGI+wTAxOMvQwvdr6DBaIGh1dhm7qIQ0e43JYZq9zEiVHxJw5er2CJtoYrOcaglEI75S/+HAVh3t93cjuB68MI6YiMF0MbIYRjEarP9GJ2JfP6stqIY3KZOWPnJB+yihU+1otYPiz7QkkW0TEjdGlXixu+yDA0p5KDbYKdPXSFDX3l+DnaytdcTpZC5VA5SUxc4wNCZ2zJxj8erLOvbsbJTJzpoI+YyPJ4CttoLEbhz0rbzBLbyj31ZsFY8VLkM5qOG72vOfa0nKAe/JyR6vst02klsy1cjWKi7nPGZzq4m4Kh6yazrHyGT2MVTjnQ7JIUcHTe9EtA9hezf6M1BunWszeNqgauo7p4M6iOsDozCsijVr2AbXkMyefO6/+BTB0hPJUp03IuxMztzqZB3XjTXLKglhjkuO9ujv07DfRaATbv1/xabG1s1QKHsvkaUuAiKNJS7pZUjslLclFuntdwLoFvGhK+H36z3FCuyyFDe/hZ+nZn2PMOa+XL8M92bYYiyvh/FXFcZmspMjzX/AL1ZCWh6htzPK5RgGLx9EbcvsNfdAv8A==
X-Forefront-Antispam-Report: CIP:216.228.112.34; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:schybrid03.nvidia.com; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(316002)(7636003)(70206006)(4326008)(6666004)(336012)(47076005)(508600001)(83380400001)(8936002)(82310400003)(26005)(70586007)(1076003)(356005)(36860700001)(36906005)(2906002)(186003)(86362001)(5660300002)(426003)(36756003)(110136005)(8676002)(107886003)(2616005)(54906003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2021 14:47:17.7954 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 694b262e-99ef-4b81-9d32-08d9a2c6a97f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.112.34];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT003.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3431
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211108_064725_732838_4E0D826C 
X-CRM114-Status: GOOD (  14.74  )
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

Commit a2941f6aa71a ("nvme: add command id quirk for apple controllers")
introduced a quirk for apple controllers that were affected by adding
the new generation bit inside the command id. Add this quirk for fabrics
controllers as well, since some fabrics implementations also use command
id as an index in their logic. This quirk will be disabled by default
and can be enabled per connection.

For example (with a suitable NVMe-cli version):
nvme connect -t <transport> -n <nqn> -a <addr> -s <sid> --skip-cid-gen
or
nvme connect -t <transport> -n <nqn> -a <addr> -s <sid> -p

As was mentioned for the apple controllers commit, the driver will not
have the ability to detect bad completions when this quirk is used, but
we weren't previously checking this anyway.

Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
---
 drivers/nvme/host/fabrics.c | 7 ++++++-
 drivers/nvme/host/fabrics.h | 2 ++
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
index c5a2b71c5268..c8ec8ae2266a 100644
--- a/drivers/nvme/host/fabrics.c
+++ b/drivers/nvme/host/fabrics.c
@@ -549,6 +549,7 @@ static const match_table_t opt_tokens = {
 	{ NVMF_OPT_TOS,			"tos=%d"		},
 	{ NVMF_OPT_FAIL_FAST_TMO,	"fast_io_fail_tmo=%d"	},
 	{ NVMF_OPT_DISCOVERY,		"discovery"		},
+	{ NVMF_OPT_SKIP_CID_GEN,	"skip_cid_gen"		},
 	{ NVMF_OPT_ERR,			NULL			}
 };
 
@@ -827,6 +828,9 @@ static int nvmf_parse_options(struct nvmf_ctrl_options *opts,
 		case NVMF_OPT_DISCOVERY:
 			opts->discovery_nqn = true;
 			break;
+		case NVMF_OPT_SKIP_CID_GEN:
+			opts->skip_cid_gen = true;
+			break;
 		default:
 			pr_warn("unknown parameter or missing value '%s' in ctrl creation request\n",
 				p);
@@ -954,7 +958,8 @@ EXPORT_SYMBOL_GPL(nvmf_free_options);
 				 NVMF_OPT_KATO | NVMF_OPT_HOSTNQN | \
 				 NVMF_OPT_HOST_ID | NVMF_OPT_DUP_CONNECT |\
 				 NVMF_OPT_DISABLE_SQFLOW | NVMF_OPT_DISCOVERY |\
-				 NVMF_OPT_FAIL_FAST_TMO)
+				 NVMF_OPT_FAIL_FAST_TMO |\
+				 NVMF_OPT_SKIP_CID_GEN)
 
 static struct nvme_ctrl *
 nvmf_create_ctrl(struct device *dev, const char *buf)
diff --git a/drivers/nvme/host/fabrics.h b/drivers/nvme/host/fabrics.h
index c3203ff1c654..eefb2d1d477e 100644
--- a/drivers/nvme/host/fabrics.h
+++ b/drivers/nvme/host/fabrics.h
@@ -68,6 +68,7 @@ enum {
 	NVMF_OPT_FAIL_FAST_TMO	= 1 << 20,
 	NVMF_OPT_HOST_IFACE	= 1 << 21,
 	NVMF_OPT_DISCOVERY	= 1 << 22,
+	NVMF_OPT_SKIP_CID_GEN	= 1 << 23,
 };
 
 /**
@@ -128,6 +129,7 @@ struct nvmf_ctrl_options {
 	unsigned int		nr_poll_queues;
 	int			tos;
 	int			fast_io_fail_tmo;
+	bool			skip_cid_gen;
 };
 
 /*
-- 
2.18.1


