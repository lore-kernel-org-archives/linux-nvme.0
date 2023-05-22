Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DB34C77B73
	for <linux-nvme@archiver.kernel.org>; Mon, 22 May 2023 13:04:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=v6maIhgnVxS2N0PZlKwgoXZ6PxuW87aB+Hvlu1Cd3pU=; b=uy/CS8ErV7D29u5vQVcTPS0lDi
	HuEC136XwYEiSXcIV3pXOHzfvQAHyW5q6Z+ZKkSshAgstqw6sRP7ha6MHFPjL+nkwE03ZN91j0uHF
	ihrv1n9UB3oWoULN1ro4AYzm8RETOZPm4nPb3SUnHaoXlZ/2v5NbhznaKG2Yh85lyzv84naXN/mwp
	mo1632QOrM7V5A7ZMIfopN0gmIcE3/VJl1bzsPNxRPc76HXA4UnETPjNhq3FPRLa5gAvzVoL+TkFi
	Zd9lploiVP7HjvsCuhdrW8ASTDfpz1khhNAyVl+1QT5Xt1D65h8P65x83bzwUwHQV49xN3juU2rYy
	dGTaysQA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q15DT-006asO-34;
	Mon, 22 May 2023 13:04:47 +0000
Received: from mail-mw2nam12on20616.outbound.protection.outlook.com ([2a01:111:f400:fe5a::616] helo=NAM12-MW2-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q15DR-006aqt-0Z
	for linux-nvme@lists.infradead.org;
	Mon, 22 May 2023 13:04:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W4JQs+/yrlFfG+jdqH1dqYg0WjKaQBmRYnedVnWCNcTYcJRInP/K7bvYGHNIpVimvYa2WuwfpiEUqplW8A+Yh6TP9X5LVk8kfnCrPmRBeoKNe0clrJCI9a0jtKnkwjrNDeDNr3/jAOnapYkDAhnpIDhx9R5QIviMm7vYeeAPNiIGCtsuotdPYsIlTSZuJCJK3B5/jSvDg9nc4yczJmKvlXO2YoDNqjKzETEE95CaVTrj1OgjkIrbGd0YabRdULLKuh5Mkt6Rwi11e1e7eM4g5zN4crMkUYB8gqUJBU7AYXkQmyAEFtQyQEPDC4ZyGD4qvocRO+xDFiEjgxyV/Kz23w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v6maIhgnVxS2N0PZlKwgoXZ6PxuW87aB+Hvlu1Cd3pU=;
 b=kQ7cOm1HdXYMIY97pR0uAky5r3M8Q0vdKjXN6OpLEjsRlR7y1oi34/aTzx6T44dLyOJhj+Fj1/qBtZnz0R0GCDXOlPMmLTTbiAXlDBKmOm2+KQU7ySN3SuHRTGXegQzmeSi6PPuLWvzHvNVZn4xNDfobc2ovPkCcFEdNM2zFi7BH5PSa4aGovtxKJpgS9ITXe15+rv6jrED+bR1De7yMWa8WJqo8lcTgMkJrmaaUGhBF7a6yuYhghdq7iWTlHB+Jf8YaDa/UE49DOp7yMXJdBlId8B0yEibb/mvnfZwfUINLwWKqs+b/1ESwW2TImORiXN4wTTDNrAHbHjYNOuOA4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=suse.de smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v6maIhgnVxS2N0PZlKwgoXZ6PxuW87aB+Hvlu1Cd3pU=;
 b=dbEX6webklRmTeMrbK29oShNQqw8CIxtLXz1hOj+uj2PWgR+kbalPqTQ3a6FZ5PfkiNYPOuevbHhYvkHLZBvd6wfklbydf22Avv3jS8gLP8CYLX7VpuTae5Ga2ynx3dRkNfc3akSYFv0p9L+kz3B/5yWnDzypzfwLZHd9yLJdLKTAxxq6zkqzhchshqhOLPX+rZmmk3ZhIo5e3r0C8ZAWaCHMC5wIpZ4J2/CeTd9RkMLNaD90dXc/36dyE92+VXznpxTs42tT8nwF/XaQ5QJT7JiobxZojoyK+8UAmJtqGBwrVm6O5Pkf8gi+JyYhvgvhShRVHzeubq/C08qoAmWEQ==
Received: from BN9PR03CA0256.namprd03.prod.outlook.com (2603:10b6:408:ff::21)
 by MW6PR12MB8897.namprd12.prod.outlook.com (2603:10b6:303:24a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Mon, 22 May
 2023 13:04:36 +0000
Received: from BN8NAM11FT059.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ff:cafe::af) by BN9PR03CA0256.outlook.office365.com
 (2603:10b6:408:ff::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28 via Frontend
 Transport; Mon, 22 May 2023 13:04:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN8NAM11FT059.mail.protection.outlook.com (10.13.177.120) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6411.28 via Frontend Transport; Mon, 22 May 2023 13:04:36 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Mon, 22 May 2023
 06:04:27 -0700
Received: from dev.nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Mon, 22 May
 2023 06:04:26 -0700
From: Chaitanya Kulkarni <kch@nvidia.com>
To: <hare@suse.de>
CC: <linux-nvme@lists.infradead.org>, <hch@lst.de>, <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>
Subject: [PATCH 1/3] nvme-fabrics: fix qid in error message
Date: Mon, 22 May 2023 06:04:06 -0700
Message-ID: <20230522130408.105328-2-kch@nvidia.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230522130408.105328-1-kch@nvidia.com>
References: <20230522130408.105328-1-kch@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT059:EE_|MW6PR12MB8897:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ea609b3-17ad-4f5a-0175-08db5ac5182d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 	ouHbDYQEICIyiNlDsrDMNN43YPHYyyRHE+z3tiZedK11lsqM/9mVLGISO8zhVrA8/GQUtm6yzqjnVBc5A8c3S/A7BvAJ3SPi95AlzAGu+RWSMUKJGXlTOhrlK1BE1A+zzABWigSbtWgQOIDuKgA7dGPbfu0u58U2sQkMUPRDqS7KGYd5dZWWJG48Gd/mh1r4J9B0AvgPGoUNEt6JcbXZA51SMrX0y62UVYXNkPfprIoea3SniUy+s/fOFwxyoyf5Db1bLZgh0VUG0nLhitIuD4tgZH8nf1Dc9K8cYqAZJ5Wbxy9b2Uuu5ORFX4PO8eSKTTwA1Cutm5fMJRG3Frn1ls0tKoS+HavSefKbBHqdiWxQovKtoAFyg4UFd+RAvCsDwxGHDiZeuInZAnZiybZwAV3DTRYVsrRRPhEPaE8LSiAmQKvLTiIkWIRwgF5WUT/ehfFmi4S2AB8zHxvNZ2ThinZ8Q5+2ZfCku0b9pHyramPCZ/o+RKHQaGTDOjK6QaBs80dF6+8LRsJm6KibVRuf4MmSA/PpFIndjpwIHs81UQm5T0jB0K31p+9gXa1U3pXrWjwFyyJ6Zh6wdbplcUVRZcO0c68ce1TdCplcEv7CbXRvt6b/tRbU2Y+VCkowSHnSvsMMY6ZODUdKyrhKxf55Pat00e+vZTEDxHzl57gtM11CUrsj/tXij/4v79YI3CxsTcVxBSGmvM8Es3COGngIrRr9dQwkiBhPP936MeLbMVarfxa7vkv0EeLUCg2frh8x
X-Forefront-Antispam-Report: 	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(136003)(396003)(39860400002)(451199021)(46966006)(40470700004)(36840700001)(478600001)(186003)(54906003)(41300700001)(5660300002)(26005)(6666004)(7696005)(316002)(4326008)(6916009)(1076003)(336012)(8676002)(8936002)(426003)(16526019)(15650500001)(4744005)(2906002)(47076005)(2616005)(83380400001)(36860700001)(70206006)(70586007)(7636003)(356005)(82740400003)(36756003)(40460700003)(82310400005)(107886003)(40480700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2023 13:04:36.1685
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ea609b3-17ad-4f5a-0175-08db5ac5182d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: 	BN8NAM11FT059.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8897
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230522_060445_218384_E8BBCD10 
X-CRM114-Status: GOOD (  10.56  )
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

When secure concatenation is not implemented, instead of statically
printing the qid=0 in warning message print the qid received from caller
as for I/O queues qid can be non zero.

Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
---
 drivers/nvme/host/fabrics.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
index b1fa27b60917..529a86aea5f5 100644
--- a/drivers/nvme/host/fabrics.c
+++ b/drivers/nvme/host/fabrics.c
@@ -554,7 +554,8 @@ int nvmf_connect_io_queue(struct nvme_ctrl *ctrl, u16 qid)
 		/* Secure concatenation is not implemented */
 		if (result & NVME_CONNECT_AUTHREQ_ASCR) {
 			dev_warn(ctrl->device,
-				 "qid 0: secure concatenation is not supported\n");
+				 "qid %d: secure concatenation is not supported\n",
+				 qid);
 			ret = NVME_SC_AUTH_REQUIRED;
 			goto out_free_data;
 		}
-- 
2.40.0


