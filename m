Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4E54C433F5
	for <linux-nvme@archiver.kernel.org>; Wed, 12 Jan 2022 06:22:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hdZYDiMsUsyac6L50eUFc7MR6Fgj8mcAYSOF9TYr5J8=; b=bxdcnmX4zp1d/oaHeQdRU5c5IT
	NBzf6YCaxn8Y3pBxFyRy8dcqBRsgPdGzYXXdIBifT6zERkYiDK1HgLxpMQHCiI3sc/E8jTxuEPWNi
	muNhnhuGm+s7ThsYVabAEUC6AAlVdX9NGPE2TUnrE+//9a663k3znSMU8PROZ619DC+PkIbTS+GxD
	w3ayTu/IvAY5R8oPHBlja+L/rzCxuGuqMQnWi93pTpERykAZg/XluDdbti/Qu7P7Sn4lWy7DFepC7
	0EaxSwNUEj40fN9ZH3es2bEUTsdo8rsVWNKq6p4IHofCQDcGNKL4gkA2SSjw/0UIA361nqkMYdsbm
	/KVDtaDg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1n7X1s-001HA2-Mq; Wed, 12 Jan 2022 06:22:40 +0000
Received: from mail-bn7nam10on2055.outbound.protection.outlook.com
 ([40.107.92.55] helo=NAM10-BN7-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1n7X1S-001H35-N8
 for linux-nvme@lists.infradead.org; Wed, 12 Jan 2022 06:22:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ce6a5m0T5igcLcjRCqI7b00p57Oc9bPXTaHPxd8w6cmqfeX3yyc/Mcn0629DBSPhu1Kx0y0L9fAxAy4Q6NKVE4qZjFWIO9x5Tt0faN5Az6b+uvzRdoijPdbkid1RcKq98Xym7pQZ8/givge+BXyLoyeCZIyFUpyW29nlLN1OiCt8HU0ZgK97DvMA1PqiMyu4fL53fvGG+iuQ69gDdIHHl4Bt6H0wr2Y9FKcisYQD0wI3UBMwYm24RpZOyzS0I2iA6t6XtDgsND88eDe50eJYRzrNqSOq134SdPMcYh2XBGvaKQVMn5NZMb7iOJnjOYtPiHzhwB1/Q8LQN6vqZiBFLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hdZYDiMsUsyac6L50eUFc7MR6Fgj8mcAYSOF9TYr5J8=;
 b=ekSVEWimSXf74c3oez/+KDFy/sRVimPjcABygUyyUC3ItBcPr9cOyFxsSg+5tbReIxXNeX90+16ddw16/LLHOrTcPjMDVLdQXfZIgXYquZd3dKgRh2uFBycJSjoQ2fBs9Z76XaD0YIGkI5vnlekBR9pNr+6f4JwyvPGn1akr2v2vbm9oRuh4lZKHiZ4RYlP+Lbe0ULkO8TejHYb6Q7EkMDk8KRg/tUCDNTssXns5dAvULy3pDYg1a/I9aIx760OyvakUz/q6+UQ0LO774uyXH7tCFs6YB9JGmO91+3DTQ1gD0q8Bu8eGfz5exkC7XdKFQ2JDNxSqjZPBn+GroVKOGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.236) smtp.rcpttodomain=grimberg.me smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hdZYDiMsUsyac6L50eUFc7MR6Fgj8mcAYSOF9TYr5J8=;
 b=M9ziSvcFV7kx9bNyDimTqJGFqaRxzKWh1EA8zteTBaZU97Oq+0lt9W7HbVpkJc5OlrBqFz/+8LLBEF+C1hLF9BvzBoY6iMGsd20NJvuiwMpIGByHml5gQM1MgwAaJyV6wxeqX1xGDOFpZcBWKirGpj/ljM5ZUWVkNUjXOc+QxAZHs3XDiaXBAu6zrCCe5zAxsoicknyVkehNHgdx2VJLsqzkbqMLgDPhRm4UCTpTkpJwfiiq+dDT1RuxrGleauPgU6/GKcvDyTMv6nVM63PuRNqMUG3JDXVEf1M8UqFwr2XIBfwSdFQjdA4z8Hblpn8crcZIxVGd5zCE+FLHiphrNg==
Received: from DM6PR02CA0079.namprd02.prod.outlook.com (2603:10b6:5:1f4::20)
 by DM5PR12MB2472.namprd12.prod.outlook.com (2603:10b6:4:b9::39) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.11; Wed, 12 Jan
 2022 06:22:12 +0000
Received: from DM6NAM11FT044.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1f4:cafe::c4) by DM6PR02CA0079.outlook.office365.com
 (2603:10b6:5:1f4::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.9 via Frontend
 Transport; Wed, 12 Jan 2022 06:22:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.236)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.236 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.236; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.236) by
 DM6NAM11FT044.mail.protection.outlook.com (10.13.173.185) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4888.9 via Frontend Transport; Wed, 12 Jan 2022 06:22:12 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by DRHQMAIL109.nvidia.com
 (10.27.9.19) with Microsoft SMTP Server (TLS) id 15.0.1497.18;
 Wed, 12 Jan 2022 06:22:11 +0000
Received: from dev.nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.986.9; Tue, 11 Jan 2022
 22:22:10 -0800
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: <linux-nvme@lists.infradead.org>
CC: <hch@lst.de>, <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>
Subject: [PATCH 5/5] nvme-fabrics: set ret to -ENODEV for error case
Date: Tue, 11 Jan 2022 22:21:01 -0800
Message-ID: <20220112062101.90102-6-chaitanyak@nvidia.com>
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
X-MS-Office365-Filtering-Correlation-Id: a86e999a-8656-41a1-1993-08d9d593de9c
X-MS-TrafficTypeDiagnostic: DM5PR12MB2472:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB2472C612BEDACB6DF6018EADA3529@DM5PR12MB2472.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1388;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IzYuWDVMTOadCaRezeHRkw5CG9CTg1PCROxE877QwNohpimz7rY6fa/gDx984KFTcKE+uJhCRX+Bl8rzpvbiBtFGn+9Q4eg3CCoQ+BvyUBYiVuJmYlyAVvQTZ5i/W7MUAu0Qe26KSxz4AsfNR3MR7quuHXe/tg+NF4LiXPWNdp10k6yISMTkgUhRlVdwgNVMQ6ApZjFcITEphJMiUo9MVLR+xuVTP5Ve63q8re7YfNjtvbWPCcNb0ep7YLWchGY3wOcrlOtczKlaTSw9uvzdpr+IsA6uBOi9yR9vFEaMnh1YpNP9DU9rm0jzEdBr6SwwSkg2YBdG5FkRf2c5OGc+gQSu5vV9LVlfDgnivGSKD9v2bY1C3Q4Su5VaCyVdyw4dYXak/nt1okBXmj/AKOm0RGRrb3a0w1UQXo8vpv4bmVdlMcRw9Nnp69QdM3VtvEY+2mDnTTa7v1eeJzjraCiTCY4nIP7B9NQ73l5LXhAXVJ+QzVwPfqoaanA0oSSSxbjaqR70jC3Q48OWbgFDpYal9qRwfkjADwMsyb/krMDNIeAxA6BReWmOMC5xCXAVeTDt75hWOTTxhP5pl1WUbi7ceTmwmepbr4fzguKhc0jFY64gwhEp3Ba51FJ+DdYEUNjv/pIIkP+DiIikgyKpfBBZybDDPDJO7OOJ/fWu0UN8PJcyEyt1r87VObgOv/XQXU/KSBjrHQFSVHtzWXYJOG+4Jd25PjyTrSv2a7x71QFpEqsUAqyWvAEeGtDugRtbC7pk2XeL/V7CmwBDrliwNKhs+zuRKj36ShqF6Qr5EJMskQU=
X-Forefront-Antispam-Report: CIP:12.22.5.236; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:mail.nvidia.com; PTR:InfoNoRecords; CAT:NONE;
 SFS:(4636009)(40470700002)(36840700001)(46966006)(40460700001)(186003)(426003)(70206006)(8676002)(2616005)(16526019)(508600001)(336012)(5660300002)(8936002)(4326008)(70586007)(36756003)(47076005)(81166007)(7696005)(356005)(1076003)(2906002)(86362001)(6666004)(107886003)(4744005)(316002)(83380400001)(54906003)(36860700001)(26005)(82310400004)(6916009)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2022 06:22:12.0223 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a86e999a-8656-41a1-1993-08d9d593de9c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[12.22.5.236];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT044.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2472
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220111_222214_820681_40C9A5F0 
X-CRM114-Status: GOOD (  10.21  )
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

In function nvmf_dev_show() if we don't find the controller set the
ret variable to -ENODEV.

Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
Suggested-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/host/fabrics.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
index df0326db306f..ca23ac926710 100644
--- a/drivers/nvme/host/fabrics.c
+++ b/drivers/nvme/host/fabrics.c
@@ -1097,6 +1097,7 @@ static int nvmf_dev_show(struct seq_file *seq_file, void *private)
 	ctrl = seq_file->private;
 	if (!ctrl) {
 		__nvmf_concat_opt_tokens(seq_file);
+		ret = -ENODEV;
 		goto out_unlock;
 	}
 
-- 
2.29.0


