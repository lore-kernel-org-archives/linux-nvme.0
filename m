Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3A3CC433EF
	for <linux-nvme@archiver.kernel.org>; Fri, 28 Jan 2022 09:25:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=A/pKxxRWKkKoklgPblLfer8KB7NtJe+zf0po/PX4QFY=; b=fzAFp9+8Ve9GAcWuWWZTcGEx2i
	GUNRBceWQV1FkNxDjqhSJAGsjAa39LicCI01sxBshvzyArTP6IasIAvdJ5C386xQKw6aanszIXWY2
	U+ZSssMFl9BhAJoyfdylfE6U3E3253btBF43XahQmgTQ+ISXIWKXDWxl72bwY+81Z5hpwtQM5F9j6
	LsyePtlywq078NrIgl81HrRnXOVRVFNWfxfF9af3afRzojFm8H3lPxhebaVKUpkTVTTxWbBZ+xjxg
	oNaKrxcoKTjwswH7TcMIO0DSv4SLh7sPJnoBTjDmiZAho1EeTARevAH/MZ2vS3ZRus3V7dZ4R+bYp
	IFapusCQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nDNVE-001EIB-8o; Fri, 28 Jan 2022 09:25:08 +0000
Received: from mail-dm6nam12on2052.outbound.protection.outlook.com
 ([40.107.243.52] helo=NAM12-DM6-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nDNRj-001D5E-7f
 for linux-nvme@lists.infradead.org; Fri, 28 Jan 2022 09:21:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ycrsz8Ex1U+nDKW8ir8jZMLHEGi/AAx7QVYdtheqmqOoYXFvv3NIWi+k+aAlFE5UFeTDToHnA25M50avxeWTUGd5S3RG/cxHjnVfOaVg9Qgj8F9WiOcnc6tH3oOGx5wMEGLSTWj/nxT31S+/vN+WIoQxbDj9L4q7xDSXMqLxC96ab37jhVDBnZgGFRn6yKRe+xuxIgFooodYuIjCWZf6syLLHhrW39Sfmv5SDcVTgqJ3FL4hZsl2JYiSJ3yizVNhWrwyv6HwyEVJ8BklzACtWN5kLcXwExl2NNRHaGzRwFl1lU7Bo5CIfig6U3pVwna+B6SR8FZsH8x8IPyxWRX3LQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A/pKxxRWKkKoklgPblLfer8KB7NtJe+zf0po/PX4QFY=;
 b=SAmUSqmv1tTMukSE2kJeYhcCzOCt37pqGsrnqNMbVcwr62zzHdYGPJeMvAV06mULTp7NLnARRl84C6JBr5SqspbgTyQizPn1JGZPzETxjoHnTU98gA2GozzJL6ops5KIY0uON0NH1PM0NAUipqYnRF/O/mUQ1JBKUrwzKhjW+cUIqz8tzD3VblzEVNbp+cvD+MHPKxenxbMQJdPwAEGvrXfmhMi+PnTxdoJtip3Cv6wUBH9zXWRKnWXLbPoQTvU8iynup2XFyMaZpvW+cH+bwIzoJiTLRxRkTh5Dejuuc/nlhxZhw7B3+6Gitsrtf9NJiCLammNokjhfUoreNsRRXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.234) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A/pKxxRWKkKoklgPblLfer8KB7NtJe+zf0po/PX4QFY=;
 b=cTqkXjPle2SYYjIy10vdajkTCV/VJWIFbcEdzhTzyru/XehZHA80BBb7XFnxbfk38AQYXQFNDwxw9OuSRUk3bQWGJrFVnj94hwlZJ1h4excd0MP1qTQx53/eF5yEgZkolKYqmEVTSg/wx7uJzAGS1v1OHNGDN3Sr5UnRIve/+owThkiLrgF00NVW5tpyooX/UYeV9jK+iLdNM7odgyJz/cxFi4b6FMEW2NYT6x7eCC/JP5mB+PHqrE5oE57GNR1TFkaNjveJNv4ljXm6PXanVbxb2Gii+9k+/GZaSUhYM9GRUiRfV8gDf/EOdniAdl5bUlccBngwpMtWBOntgQFS1g==
Received: from MWHPR01CA0037.prod.exchangelabs.com (2603:10b6:300:101::23) by
 PH0PR12MB5450.namprd12.prod.outlook.com (2603:10b6:510:e8::22) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4909.12; Fri, 28 Jan 2022 09:21:28 +0000
Received: from CO1NAM11FT020.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:101:cafe::bd) by MWHPR01CA0037.outlook.office365.com
 (2603:10b6:300:101::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.17 via Frontend
 Transport; Fri, 28 Jan 2022 09:21:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.234)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.234 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.234; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.234) by
 CO1NAM11FT020.mail.protection.outlook.com (10.13.174.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4930.15 via Frontend Transport; Fri, 28 Jan 2022 09:21:28 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by DRHQMAIL101.nvidia.com
 (10.27.9.10) with Microsoft SMTP Server (TLS) id 15.0.1497.18;
 Fri, 28 Jan 2022 09:21:26 +0000
Received: from dev.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.9; Fri, 28 Jan 2022
 01:21:25 -0800
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: <linux-nvme@lists.infradead.org>
CC: <hch@lst.de>, <kbusch@kernel.org>, <sagi@grimberg.me>, Chaitanya Kulkarni
 <kch@nvidia.com>
Subject: [PATCH 4/9] nvme-loop: use helper to initialize connect_q
Date: Fri, 28 Jan 2022 01:20:10 -0800
Message-ID: <20220128092015.19289-5-chaitanyak@nvidia.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20220128092015.19289-1-chaitanyak@nvidia.com>
References: <20220128092015.19289-1-chaitanyak@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: drhqmail202.nvidia.com (10.126.190.181) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 778b890c-aad0-42a9-dcb8-08d9e23f9078
X-MS-TrafficTypeDiagnostic: PH0PR12MB5450:EE_
X-Microsoft-Antispam-PRVS: <PH0PR12MB5450ECFD0AB4598469CB8214A3229@PH0PR12MB5450.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:345;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wy4FsCOcTeRAawY4We0MMd9MFlp/Psxs8b8PQ8DwrIfRdR/Ry7avAUQQw8/+VDynm/5Feu8p3y5wUboEQr0islg9H/rsx2H3rplbwtkI+9ZvhovAoBJ6GMjPGFCNhYPFx6oMzASKZ5uEM9+NqK0frqtoBVZ9dzjyTUjZb12jK+VI1UtdkRQ3vfLXH1zlS0mIC1j0bJp5VHQSWFPZI/JL0JcPSDJKsCgsj95W8ChPjpMCflrjWGWCPOhWTbo2Ygg4n07p4FvOutlAFLQQb159P8mUKWA0+E4u2pP9Qoyh7ZzK26K9RvAl9Du+Xnto3B/12zF83sRgEEcMTKdnn425uk4HIYDp3Ngc0NpbPY+v2lbxECE/1IxG1ReRBeDU18Wq5gA9ay8E8QnWC9N7idqQb4h+qk3C3R5Ab/RbxEfRLia5TERTGMxiqdKYXZXgZcoWkrr4hk5+R0phubyijqaWEwFzsIdmzGORht/DrSV4R82Pku9tV2PAweOzT+RvCzGgTxdFe2qg/0LMeyT5sqNDDZelPdIh2a5SyD3hRgzxwM7aoDBI5E1xJd6wwwIYbSgvVjraus1by0ZjHrO4uFPfKe1GUAaKhpTldguNDg4ckeuNSaYO6etXdHWo6pWRYb8Cqi1Q7+uJMSCl8zqvDR6NcJdqpnA5OFg0MpLvK/0KBxo6mcYzu8xWJOFX2+J3ieCUATzvmdvo/stiHE1YSS7hgDm6P+TF68vDbYJGqrL30npyGODBP8yg1r940RLtwdIV0eqxYjbEdtEl7OJQdrSc65unTPofgr27+8q1biELCGI=
X-Forefront-Antispam-Report: CIP:12.22.5.234; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:mail.nvidia.com; PTR:InfoNoRecords; CAT:NONE;
 SFS:(4636009)(46966006)(40470700004)(36840700001)(4744005)(2616005)(1076003)(5660300002)(8936002)(508600001)(6916009)(8676002)(86362001)(336012)(426003)(70206006)(6666004)(16526019)(4326008)(26005)(107886003)(186003)(2906002)(7696005)(82310400004)(36860700001)(356005)(83380400001)(54906003)(47076005)(316002)(36756003)(70586007)(40460700003)(81166007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2022 09:21:28.3042 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 778b890c-aad0-42a9-dcb8-08d9e23f9078
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[12.22.5.234];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT020.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5450
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220128_012131_329383_EE7062E9 
X-CRM114-Status: UNSURE (   9.95  )
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

From: Chaitanya Kulkarni <kch@nvidia.com>

Use helper to remove duplicate code for connect queue initialization
and error handling for all fabrics transports.

Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
---
 drivers/nvme/target/loop.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/target/loop.c b/drivers/nvme/target/loop.c
index eb1094254c82..23f9d6f88804 100644
--- a/drivers/nvme/target/loop.c
+++ b/drivers/nvme/target/loop.c
@@ -543,11 +543,9 @@ static int nvme_loop_create_io_queues(struct nvme_loop_ctrl *ctrl)
 	if (ret)
 		goto out_destroy_queues;
 
-	ctrl->ctrl.connect_q = blk_mq_init_queue(&ctrl->tag_set);
-	if (IS_ERR(ctrl->ctrl.connect_q)) {
-		ret = PTR_ERR(ctrl->ctrl.connect_q);
+	ret = nvme_ctrl_init_connect_q(&(ctrl->ctrl));
+	if (ret)
 		goto out_free_tagset;
-	}
 
 	ret = nvme_loop_connect_io_queues(ctrl);
 	if (ret)
-- 
2.29.0


