Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECA03C6FD1C
	for <linux-nvme@archiver.kernel.org>; Thu, 23 Mar 2023 03:38:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=r+jdk5QY6Tq3MwSYwBWd8t45RhBG+NWI1fHy0zNNZGE=; b=pctKdiX65hzSEaPspS+OZFkuzj
	wevJvqiK7gv4PFaueVlScEReBK8oRNHcFaMIAO4ixLZJKJRblq3viGXUMe9a8ylgNlOjFqM79a3RL
	nVrtQeDPfHk4f19OicuNHkNqV/kEyqd4SUM2VHU8iFcuDbhBTDOx/FnypyUcilbqfOqSwq2C8Ifgr
	l1BGx7rmcVTDUZNuDXhJ2M5BHIlhetGKM1RjtygmeHVjhMJHhhgu0HPgef8sEdkxEjVjXtzpYpKoi
	pV4CIM1F87RGWWTeuIpjWjjxJJQvJkr57pUR3uXDvU817QgGNY035fkPQELJTsPFTO4bOz+BBMIPs
	lA8NTuEQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pfBmN-000eIq-1j;
	Thu, 23 Mar 2023 03:38:19 +0000
Received: from mail-mw2nam10on20608.outbound.protection.outlook.com ([2a01:111:f400:7e89::608] helo=NAM10-MW2-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pfBmL-000eGr-0X
	for linux-nvme@lists.infradead.org;
	Thu, 23 Mar 2023 03:38:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QIjdDnq4pEtus8k0fMeSyPyvEc7CZ7964aSPYInODyCDX0BzF6y+IxvDDaXEI9oPjoN52q7eX9bu6IIlHgX4YY5ttSxGRsRh4MkWAiKxRRVy4kgzhtcFQZhCAQ5GkbDe4iU4i5SNwLwBT3Fj64e+B4CpM4oKXUJvysFgqexTWHsW680cCR2FryQ6iYqPueKvF70TDm4RJs4G6F+P0pXlHUfae2PZ+hpoCqm7FmFaHFy9/gC21pvL0V19GaFvjrXy1oGKkvYNfShMudjkIQlrhPwAPNJm7BcTgSxl6k+Y7vkY9w3f6Jnqj/k9LFG7MhYldDglofzj3wc/YWi3DPfUSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r+jdk5QY6Tq3MwSYwBWd8t45RhBG+NWI1fHy0zNNZGE=;
 b=n52G26FgwazqNKAg/ApZPHEDqkxnJEyf2tMaJcopjgeULK0T7tr3Mq/XEhUq/PI7sbc5FwyUM2+jwLBpNKTe+k7SB3W/4dDLIdE3fHWm8cAKlKw38MXKKb75+8fwL/OJMZqFajywxlAQ2+a9G5vmqLfzwRszAhbfjLqcwR/W80fhtpXQjJP0+aNPLFkvFhDQ8Q/wfh36PSIHwAWAUkTTpSJ0ytHuvQP+OKj9BjsTTCV/VVJ+dWefefNHNOU3KkbuQA8pCZaulhMDk2+cj84WyDp8UzkE6LN4o8ZqE/1RTyUUqXJL0fxfZ/OSxiXQP58ocFzwKMts+cNaTDiH4sVHlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=lists.infradead.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r+jdk5QY6Tq3MwSYwBWd8t45RhBG+NWI1fHy0zNNZGE=;
 b=jUPztMmfgt/sRcaskbbxHkOWaoQkr0P1hfivVy7ANcMrObYFPxUbqB4n1S0zhV0+lyshLG5r39Nx9XoML+IJogswsSf9KMFidyJ1KCVFmAzKPQzDURsBy5YVHC1bQFbtUsHIaKeU5mCocaHfbdw0BZc5W8XDCXOKdjhw/eMgYHbZbsovN/pbvkyja3Q0uQG8rHCpA+18+MMwWgTM/uh0LZqLDH1x5Tfk1yjM+MxlTmbwLR48cGN3PIeFH13NnMhlSSBqBCn9Y4D5iV6XBMXVMk6DpwKmnBbOl9RObU5w/OKilwnxOczURmtwtFXUTipS1O4uUZqfiP08njsAvGZ6hA==
Received: from BN0PR07CA0025.namprd07.prod.outlook.com (2603:10b6:408:141::28)
 by MN2PR12MB4077.namprd12.prod.outlook.com (2603:10b6:208:1da::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.38; Thu, 23 Mar
 2023 03:38:12 +0000
Received: from BN8NAM11FT037.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:141:cafe::e7) by BN0PR07CA0025.outlook.office365.com
 (2603:10b6:408:141::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37 via Frontend
 Transport; Thu, 23 Mar 2023 03:38:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN8NAM11FT037.mail.protection.outlook.com (10.13.177.182) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6222.17 via Frontend Transport; Thu, 23 Mar 2023 03:38:11 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Wed, 22 Mar 2023
 20:38:02 -0700
Received: from zion.nvidia.com (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Wed, 22 Mar
 2023 20:38:01 -0700
From: Chaitanya Kulkarni <kch@nvidia.com>
To: <linux-nvme@lists.infradead.org>
CC: <kbusch@kernel.org>, <hch@lst.de>, <sagi@grimberg.me>, <hare@suse.de>,
	Chaitanya Kulkarni <kch@nvidia.com>
Subject: [PATCH 7/9] nvme-core: cleanup for nvme_set_latency_tolerance
Date: Wed, 22 Mar 2023 20:36:34 -0700
Message-ID: <20230323033636.812758-8-kch@nvidia.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230323033636.812758-1-kch@nvidia.com>
References: <20230323033636.812758-1-kch@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.37]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT037:EE_|MN2PR12MB4077:EE_
X-MS-Office365-Filtering-Correlation-Id: 0cecc035-4707-4074-381b-08db2b50072c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 	2rhwLzFW/sXzRMnliczBanD60NbxJ4hiYQWuesjPZj6SsulPr+brhxZ9Spe6INncJ6LJKjZIHebxmWN3Q0W1P/er1i/AlT75Jl5eV2nWacFKGOohKOHw+fdOjfwZ9NTqtlEenbSqhAV+CTysoXwh7uwV4Lz0acsOVbTt/g3j9JBScTtNhfRTQ0zWpc8NofGsh7wjKsyE5eIoclG+nhjMca43vfHqTt5k6Myc6qs72DGIHvHEL9OSqaoyvaohDi4YkWTBO2BRN+WdC3ztSg/VXO+7oPqLBbv7g+X5pryJRwThHvtOuyw0cg0oQpdHp3KkIM3HeUQW/QptIQ2Pi45fd6IP9mcAg1XPW1wKKuO408QkzVjB75PnvkzVQDaXNt2FyBflMC6okRu2kS1tl+omQ1fRqb2rc2UZnXyIwzRGQTD558yXRIbovPjjosGCAza2e0GK2cKU+lbtxiWmitB8elq1yf6TPTU+VjEhmTDl3GqX02y2ADpMZuzPoX405v5mVIukWo7A5rKhUPyWoF94zt8l4E7qB46u7Ucc3AQ//iwx4cioSepwyNVJKzqAeNf0k0nWta4iVT0mSH5daMiWaBL/xeTxS4UAvQz+ZnLueYQ1susleyh8DXaS182fYSVYiDZ5PzXGSlXjsvkEagVuL3sQwRif6rQYt79sEsJ7s0Izs6jCbUif8kOVxbRakivy8qfCoefHBGa2C6jPkKS2iLr8bKKRv5cSNFad6gkRkU+STFNbhhvkNd9F7nsHSxzv
X-Forefront-Antispam-Report: 	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(136003)(346002)(396003)(39860400002)(376002)(451199018)(40470700004)(46966006)(36840700001)(40460700003)(36756003)(4326008)(8676002)(6916009)(70586007)(70206006)(8936002)(41300700001)(478600001)(316002)(7696005)(54906003)(2906002)(5660300002)(4744005)(82740400003)(36860700001)(356005)(40480700001)(7636003)(1076003)(26005)(16526019)(186003)(107886003)(6666004)(82310400005)(83380400001)(336012)(2616005)(47076005)(426003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2023 03:38:11.8742
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0cecc035-4707-4074-381b-08db2b50072c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: 	BN8NAM11FT037.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4077
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230322_203817_207293_B88BE12F 
X-CRM114-Status: GOOD (  11.71  )
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

Remove the extra line before default in the swicth and add a break
at the end of default in the swicth which is a standard practice.

Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
---
 drivers/nvme/host/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 06dac97c5b0f..fdcba1dc583d 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2594,9 +2594,9 @@ static void nvme_set_latency_tolerance(struct device *dev, s32 val)
 	case PM_QOS_LATENCY_ANY:
 		latency = U64_MAX;
 		break;
-
 	default:
 		latency = val;
+		break;
 	}
 
 	if (ctrl->ps_max_latency_us != latency) {
-- 
2.29.0


