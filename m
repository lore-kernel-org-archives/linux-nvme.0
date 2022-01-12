Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E46BDC433F5
	for <linux-nvme@archiver.kernel.org>; Wed, 12 Jan 2022 06:22:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=TLnvMnsaq00cBZdRTyiUJR/pP5KaUGjAhW1bhWxqtYw=; b=PK/k0SHmtwBhufoJFfOmCvwDYk
	hPkVkCJd7XD31+FLI38m2lxB3triVoITghGe6lZSOTFAaWRxUxMl17IeEAo/HQMQu68BgSVZjeAu9
	yyVsOCgkEeMUfmqHIO/Pf4MED4RLhB0irs2WfGKVa7WZ/QyBjHbzX3ZVYcLOWfBwM1eOic8YVkMRR
	Xq822kzNLoJ0AkPXNrv096zbNAMCSi7og5xS+HT3Gko1IV/dHu7JLV3pHHmjgWjRbUq58zZf9zmB1
	vzkL1nH+Gn6zW46k5zL0mTEY5J0qWTmYOOYdmEdJws+Epf4y7rvmw0m8ZL/poDPqTA/nnWdWBAVle
	86GAGSYg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1n7X1D-001Gyd-Fs; Wed, 12 Jan 2022 06:21:59 +0000
Received: from mail-bn7nam10on2080.outbound.protection.outlook.com
 ([40.107.92.80] helo=NAM10-BN7-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1n7X14-001Gw6-Ot
 for linux-nvme@lists.infradead.org; Wed, 12 Jan 2022 06:21:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IU4M71L+no4biz1FUXptc8ns8vIXngjWtbY89ki+DLzKuwOi27x8LOcI4JUfrjyHNVKcDO/p2KtaIEe0z4sKKvZ5Ns8JbLsJ2qqUDOlMs18z5QURUxZib58OAUppLSI5+LMe1a4Cuz6w/CEAf8VAlCjy8oWjYh1IbYt6PP4OOkhTI4jtECDnXEHC/qbhN4jlt+ZXDMOIBUwyRYbR0WoGDZWTuRExnW3uxIoKzzxoozDwlZcPDju5fqfF6TeV3o7vKsLDgkBGuuJKRUjcYaabqAwbBZmk3/hfPJckY6nEpp+LXjMZRvgMz2NmLGIKDkvGnte8gjxGxv8jrtwjM6rOyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TLnvMnsaq00cBZdRTyiUJR/pP5KaUGjAhW1bhWxqtYw=;
 b=OkVsghfvHfTiM1B5dSBOpU/u17Ea8lym/IvWE+uhURcwfkzZ+cqiTUcz2BlA1vqMJOJuG81Dn+QxOS56ESc4N7vXC3bpD+oyWi/+8clnM/oEaODa1RLXgJRnGE+I7nDv+O/eIxGtMdyRInzY1N+OXTIJV5KhANZhvTCTfVWiPAZkNBGeI5fSMx+ykALX4SUulpKqbZ8wEZcDJ9z77mEGnhEOokbWKpZMyPxv1JQiei0PeuMTdn7nroL+RLkTqBhiHC6Mw1WXDzyIOaziqSnteW1Xzu+vrZJyxet8GmX04NHPv8N9PXqibSwjYChqI6ivXSCxE+tYSYk4X+t5lRt+kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.238) smtp.rcpttodomain=grimberg.me smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TLnvMnsaq00cBZdRTyiUJR/pP5KaUGjAhW1bhWxqtYw=;
 b=JMYR/9APNR7faPSWGNr2jeXnd1510/WOUYY+LNsPGP/tq/DSWokpBXhxl0QIo60fJKcYyUw58EdNgQGgxCJvLC2aWkKXCL9q0RkubdawzYeKB2/Qfypu2yw7B1dW3fqrUY1kBtYlDshheIqAUgVpvjgYNJLIdmmjOQaA0ZDNR6SrDvO3Bc+IP6FwL1SwQJphU6SXc3Sq7ee4m/14d+NUzx+qRS0pFWMqkcP5OwWhcBnKyjWXQdrP4dHSrF2kzoEJwgHf3JY6QRTo8a6qg4HW21sWPlJGFk5J3vTc8VK960Uh7Po6bDXB1mQUKG+ZR9bVlcyKd8hFcM3YjGOaf18fMQ==
Received: from BN6PR19CA0077.namprd19.prod.outlook.com (2603:10b6:404:133::15)
 by DM6PR12MB2986.namprd12.prod.outlook.com (2603:10b6:5:39::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.11; Wed, 12 Jan
 2022 06:21:48 +0000
Received: from BN8NAM11FT034.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:133:cafe::7e) by BN6PR19CA0077.outlook.office365.com
 (2603:10b6:404:133::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.9 via Frontend
 Transport; Wed, 12 Jan 2022 06:21:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.238)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.238 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.238; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.238) by
 BN8NAM11FT034.mail.protection.outlook.com (10.13.176.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4888.9 via Frontend Transport; Wed, 12 Jan 2022 06:21:47 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by DRHQMAIL105.nvidia.com
 (10.27.9.14) with Microsoft SMTP Server (TLS) id 15.0.1497.18;
 Wed, 12 Jan 2022 06:21:46 +0000
Received: from dev.nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.986.9; Tue, 11 Jan 2022
 22:21:45 -0800
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: <linux-nvme@lists.infradead.org>
CC: <hch@lst.de>, <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>
Subject: [PATCH 3/5] nvme-fabrics: use unsigned int type
Date: Tue, 11 Jan 2022 22:20:59 -0800
Message-ID: <20220112062101.90102-4-chaitanyak@nvidia.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20220112062101.90102-1-chaitanyak@nvidia.com>
References: <20220112062101.90102-1-chaitanyak@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9c65c861-cb84-4ef3-401d-08d9d593d028
X-MS-TrafficTypeDiagnostic: DM6PR12MB2986:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB2986D50EC3DFA54CA2B63AE7A3529@DM6PR12MB2986.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1122;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fpWttRtN/syY6U2and+r/lvARpqTxbz9SD4FXkuEykQ8t5xSZrXI8jiKOueHa0i6a75sF61GmCTMvCxVtXxq3YMKJ4RwyKOcgo+5zt7cTOtXoTaX8iKW9DgIJBxCbL2xZ3Cbye6xC3u5YE11bER87kmmlUu3wG7foNjfjWAAMIMY0RzKY2LuhxuqObEwQgyFopsFmQyPercLvCR5aVh6C2FiNqeYNkD4J5rA2iT4PcUOGhfD+8rHSeIgjw0fhbiJon/1XJVCLTuEYGJ1TVxFzkF4Wj50WZFD1zOe5AVF+GXBXeQsEQOq2+RGOOCz3WnkNE0SqB/gTukRNGw0/xOceyfK2EXHvaHV1pQA8221vsqh4Od+6aAWnQhGTHJ4dyRRo01q+5gVz6LIe8nZKaLcKM8yWpOdqlYXlY1jJxDPwl6iqD4YOpxFxAB4fneJ72H7cuIsyIhsx+ETHU6+uV0TN4ktgovCccrWiSOLENzctklu1p354KER5hnBFMTpR1GK6pQWnk3iStVIg14hlSUePkKq7F2CI/T/SFO1J518wnOg0JUks5yt3/9itUjnDOpBweAjyHxqVnwC7oiIElIqUF4j7bL6NzN/E+ZI8gq7WCxKZjzoBeqqdeA3Yd4sGNKyanH4sf7CPtZdlyyj2Gidv6PhP9UHM3iMxzlbpad3febRd51YfAjWNEs0nA+cJVa4eK82CqRJ0ELIoMVohZ1bu0bAs3Zqxq9Vby5dIdFUd5gGYuAWE3hPCoBwWI9esi8sPX2traR+lfB8i+Oelt3BYX37i8wAFIUCfyfhK/+z/Og=
X-Forefront-Antispam-Report: CIP:12.22.5.238; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:mail.nvidia.com; PTR:InfoNoRecords; CAT:NONE;
 SFS:(4636009)(40470700002)(36840700001)(46966006)(82310400004)(86362001)(336012)(6916009)(26005)(316002)(508600001)(6666004)(1076003)(2906002)(83380400001)(4744005)(54906003)(70206006)(8676002)(186003)(107886003)(40460700001)(36860700001)(426003)(36756003)(81166007)(356005)(47076005)(16526019)(8936002)(4326008)(2616005)(5660300002)(70586007)(7696005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2022 06:21:47.7124 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c65c861-cb84-4ef3-401d-08d9d593d028
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[12.22.5.238];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT034.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2986
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220111_222150_849640_C4393C36 
X-CRM114-Status: GOOD (  12.13  )
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

Loop variable i will never have a negative value, so use
unsigned int type instaed of int.

Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
---
 drivers/nvme/host/fabrics.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
index d38a630ce3dc..90b3474ea276 100644
--- a/drivers/nvme/host/fabrics.c
+++ b/drivers/nvme/host/fabrics.c
@@ -872,7 +872,7 @@ static int nvmf_check_required_opts(struct nvmf_ctrl_options *opts,
 		unsigned int required_opts)
 {
 	if ((opts->mask & required_opts) != required_opts) {
-		int i;
+		unsigned int i;
 
 		for (i = 0; i < ARRAY_SIZE(opt_tokens); i++) {
 			if ((opt_tokens[i].token & required_opts) &&
-- 
2.29.0


