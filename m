Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1805E77188
	for <linux-nvme@archiver.kernel.org>; Wed, 15 Jan 2025 03:01:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=ee1CbuTEEsb2ydhq4Wko2woXBHVyY0RsRJMUOVVAPxM=; b=F7bg9pQkPw3jhLrayVFin/VJ9P
	Id1Dnll9Sd/ZHdOCMdWbfjD3jn7aZ611KCQdOq8Ut5Ocaiu7Qn/NGPmEgyNZjRVXDnbdKSMHg/f7X
	8NcWaIYcXi7yIXfcqOGNvhwqQWY8ehguCFj8h2WZHrQr1hfLjFS3WnKYT1ziCOMDF1ZngkrAaMWCg
	LGqUihYYXaBpflHOJjw48R2Z0dkcRK6xRXJoZ2IdDbFtaREGANZoyaRLURJ1HnsBjstQMTcH241y9
	hPRhf4QVo6JbYsg1iOJ/CX6vXJoXtAHHIxjFPiasfCHL6uahlthnKxO0ZohkZYmmTiQ2Vdivhbtuh
	0lMrR+FQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tXtfA-0000000ATN4-40UQ;
	Wed, 15 Jan 2025 03:01:48 +0000
Received: from mail-bn1nam02on2062b.outbound.protection.outlook.com ([2a01:111:f403:2407::62b] helo=NAM02-BN1-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tXtf9-0000000ATMf-08Fp
	for linux-nvme@lists.infradead.org;
	Wed, 15 Jan 2025 03:01:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MaiQ7Ix4U3aXgcOmk5tSKxVz6g3c0srvzcuK2D4mlasRWIyXmyvQlmZWL5e4n1XjLh9+bUYw6sWrMgTMHMKsQ/vhB9jeQhRxvP4R0K86/94Vk+anHnX0bKO2k+ovNVYF6yy1d+7r3ANSXLEjdn9mPsyJma801UwLOuCnCbEcdbsBN4AdfP3JMrS0mC9wcJ7DlTo46pw+2Hao6NOiV+RGhC7YxhQchlt/ZzUASGNNOmn3X1PliYizdoUVrmCL9we1nZng8J4SoKO4U2Tgj4qdIfGq0N6aLypjSPPRQYfV+dyWnuRuxzbWTL52LwvbE9JJiAHKoFgiYImvoXtM3+WlZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ee1CbuTEEsb2ydhq4Wko2woXBHVyY0RsRJMUOVVAPxM=;
 b=w1F1nV3kGd/+VJyEgHvQLu9NkFYuhR+s1YgWwMd4TsTzKbqlghU6SakNJZvcpqwRy8kcyjvnxzYIoQkoyKHuIyNX1rVXUF9Z7XIP0JbHxq8CXljo2112M5qtwSJPs881fzLODqXSHS3awhWnNrb8HihHNcw3y6alF5vORLVE9I9eQKk4oD8nUD7gqfafcAmvUj6C84NGN/N2J253SJNCk0MesAGvVw+aTmNAv4SfPvsxvAZf5sStsA+oZsSA6EHCXIcgf4SrxBLXcz5pcuQvTUuw7C4ITmU47TUbT3gS1Xj7ESEc6WGmzvQBbKAV70CkAB22+6hprEZalyOU3fwwYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=lists.infradead.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ee1CbuTEEsb2ydhq4Wko2woXBHVyY0RsRJMUOVVAPxM=;
 b=VA/fE3HREl8xstKFAAsNrhwVHS+Aa0dg8PTeT2F5tdscc35rK/IG5ZuQX1F9xkewgDJVTcja0ieuMBmcJ217L7juVyHWH5bOaifRKiJkWghA2P9LsgZHgSesfFVaAKEFixCM63UEjeU4jKK4GNGsjasWieMYQgntPEXcU+wQetv1pq59JrlvVAiw4PjsL9Td/ZitPNVv20+Mqa+NRNX6sKU8w1IjWb11Knj3HV8n4QGL++mVTBnKC0S9u8juOxZwTQf4Z+lt8Uw5mcJpL8DPVGVMrlg8YNM5pHanfxjrH8VEv8lHO6zJH61wNQXR9cXJB1Aa7od9CDhXQ6RFSib0UA==
Received: from BN8PR12CA0022.namprd12.prod.outlook.com (2603:10b6:408:60::35)
 by IA1PR12MB9521.namprd12.prod.outlook.com (2603:10b6:208:593::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.18; Wed, 15 Jan
 2025 03:01:38 +0000
Received: from BL02EPF0001A107.namprd05.prod.outlook.com
 (2603:10b6:408:60:cafe::f3) by BN8PR12CA0022.outlook.office365.com
 (2603:10b6:408:60::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8356.13 via Frontend Transport; Wed,
 15 Jan 2025 03:01:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL02EPF0001A107.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8356.11 via Frontend Transport; Wed, 15 Jan 2025 03:01:38 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 14 Jan
 2025 19:01:22 -0800
Received: from dev.nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 14 Jan
 2025 19:01:22 -0800
From: Chaitanya Kulkarni <kch@nvidia.com>
To: <linux-nvme@lists.infradead.org>
CC: <kbusch@kernel.org>, <hch@lst.de>, <sagi@grimberg.me>, Chaitanya Kulkarni
	<kch@nvidia.com>
Subject: [PATCH 1/2] nvme-auth: remove unnecessary semicolon
Date: Tue, 14 Jan 2025 19:01:14 -0800
Message-ID: <20250115030114.40215-1-kch@nvidia.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A107:EE_|IA1PR12MB9521:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ea765ef-5c69-45e6-5514-08dd3510ee0b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?0VHkzeO3qEe5m+aFQxCHhw7c3Y+XHpjXL48hA0ByhtzXYRABCG8CCseIanjH?=
 =?us-ascii?Q?oxVz4HKJtxbfSni2VVHzpGjEu7zRkXsiTxsPkZ8J5i6bIld49gB1PBH6rm99?=
 =?us-ascii?Q?bPlRV5HZLW5480ccMq534HWvXBKUp4Qg59wsKeE8x5txjCzvrEnR65UWJP+9?=
 =?us-ascii?Q?Zf2eWMcl9pugCpG8nA9s4/+IK91qcw/QMEh95b4Y8CFB/2IkzsKvj2VAfdP1?=
 =?us-ascii?Q?53gI6K4u2K7qUepT16dY2yZeOYEW+mdwJ6K6J5lKbvd9f75Zm7RS0rT1BJuZ?=
 =?us-ascii?Q?HQl4Y4akRp/SulC72Qewbpmw3VH+Gl7BJXxGWy65RrxPw/BMCN+tLV/JU3IH?=
 =?us-ascii?Q?uxJ6sgthzZkwX8ujC9NytIFNOKuU4MPUne//eXcokQ3hFsMdDjPj9giIixbL?=
 =?us-ascii?Q?HrAIzVnf5gmzDZM8anTQAxf0z8lmo/ZkuI/Q57+88tZLnScemrW44HkB3/1J?=
 =?us-ascii?Q?GQqUQnrwlhpGv4ABIX+MiqYWbQLAJwaSdGczGWLdgCsjMRptYp4k9V6KzCK5?=
 =?us-ascii?Q?nyOB1HRweFeMGFKXW3uaASGMQ5nSSi3tA6WrYUTabsv9b7nnVyUthqZmwSBm?=
 =?us-ascii?Q?cFg7+kOEb0Uh2Bkzw7fZfDoGCHYbo8GQUDDNcxC1IrQYPr71ZMN4LFwHSjKV?=
 =?us-ascii?Q?dIqn0RJ4q0akE0NPEvRhdUMePg7ZLPm3nTa5uOn8ATnLqdyv/p7uqQMwPXLu?=
 =?us-ascii?Q?u7WGblUEpy8h6+iUuHezOAkEkxjRTupKv8ksGi+pupHx3/xbQmaf6CHfMoUR?=
 =?us-ascii?Q?3N6n9xwP38NKap/+92lo1I2C+be3zKwG+q9WYj83rtR5hdiZBY4PfvvlC3Lq?=
 =?us-ascii?Q?G2rl/wZQWGTze1dCMPIr7NoPsalsBg62akGZRGK+kM9eUMidyxoEnQZxLpE3?=
 =?us-ascii?Q?cMNUjgiyXZlVyOkbAtQNhZhUFmvUaVjLPh90xLQgyAAQLShTfYPxPRCM8mdH?=
 =?us-ascii?Q?cDbjVMIF6JlIMXq+1tpmvkxN0CP5g4IFzSDpvg0HjPYl4WhbSnLnk0viU66e?=
 =?us-ascii?Q?7AO/gKpQlGukg5hCnM20R4tk2yPUr5OTBXvELwHm0GGc9wqhryCESiPNWcO2?=
 =?us-ascii?Q?llHwy/fLENl+L88m9cFJb5q3fLY7LRNn8nF36XJ2W8r6VnKeuRiPtfzrGyG3?=
 =?us-ascii?Q?xT3vHKcFVp41A3NiF7s2JPpAzlXeykZZKCjskU3jQ/u18T0A7j67/0SGouRl?=
 =?us-ascii?Q?NbfCf6idBggWGQ9fT2dmxA4lZ5Pm1H2R+qrUsIbmiHu4SOLlhDrUqUN691XR?=
 =?us-ascii?Q?jVBVLByGjHxw0keBXTWfziEs2NCRls8lgApqNfW6hoddjyjOKj+gNjxxhOIu?=
 =?us-ascii?Q?nnYkgj0KA6nDY/+vdghIrSq/qjEOKGTItKOa+0WWBChN3DXXOhmKCv9dSkPC?=
 =?us-ascii?Q?PEXUACePBNMwAJPSAUEOSYiw3zjaSsJBOvdlny8KsL0DbGJyaDm2HIbtrk7W?=
 =?us-ascii?Q?q74xWdJvDs7BnfP6VB2IIKftf5uOmGeN+sqjzfWYtTgpYEAB9jaPJhfAYFQC?=
 =?us-ascii?Q?r2Hv3Ou4wphA5tQ=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2025 03:01:38.3916
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ea765ef-5c69-45e6-5514-08dd3510ee0b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A107.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9521
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250114_190147_085722_5F1B040A 
X-CRM114-Status: GOOD (  10.22  )
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

Remove the unnecessary semicolon to get rid of the warning:-

cocci warnings: (new ones prefixed by >>)
   drivers/nvme/host/auth.c:742:2-3: Unneeded semicolon
   drivers/nvme/host/auth.c:751:2-3: Unneeded semicolon

Also, use this opportunity to align the following dev_dbg function
parameters since they fit into one line.

Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
---
 drivers/nvme/host/auth.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/auth.c b/drivers/nvme/host/auth.c
index 000c0a4197ba..896223e24850 100644
--- a/drivers/nvme/host/auth.c
+++ b/drivers/nvme/host/auth.c
@@ -739,9 +739,9 @@ static int nvme_auth_secure_concat(struct nvme_ctrl *ctrl,
 			 "%s: qid %d failed to generate digest, error %d\n",
 			 __func__, chap->qid, ret);
 		goto out_free_psk;
-	};
-	dev_dbg(ctrl->device, "%s: generated digest %s\n",
-		 __func__, digest);
+	}
+	dev_dbg(ctrl->device, "%s: generated digest %s\n", __func__, digest);
+
 	ret = nvme_auth_derive_tls_psk(chap->hash_id, psk, psk_len, digest, &tls_psk);
 	if (ret) {
 		dev_warn(ctrl->device,
-- 
2.40.0


