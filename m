Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E93CC433EF
	for <linux-nvme@archiver.kernel.org>; Wed, 23 Feb 2022 03:37:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=B+UjQq8f2S7z+GEWWdMaMdQ7TMxhcbCA8XGOBYkABM8=; b=IeC0uk759C+rS0D/IMf5HUNsCv
	fIIbdu+/AQCZXy8NE2FVyZR3fL+AspASrCHRzEC8OC/s/NYgYfJdjweHkT6DdCjpssziFBFEZlEbq
	Pi0YYBgEVCS64zng2BuenK4FdyIQU61GdonF4GbYLUY2IilA6xpQICa4lZkqjj4TnyXM7guw5duSe
	TM3e3REISfVkyFLFk2DyCAGYmn+kjwjWILkZXMlAtTNvxX45Uvb7vdDRINdQvLFAeSY9SX+qD52Ag
	CEEbEYyxCkBEWDOWjL3+U7141CFrGmstY8hXOgG6ao0EiBs91F3BlDUheYDjDXmk4RKcA4tkZkGpV
	E6nuaixA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nMiSy-00CYG2-LY; Wed, 23 Feb 2022 03:37:24 +0000
Received: from mail-mw2nam12on20608.outbound.protection.outlook.com
 ([2a01:111:f400:fe5a::608]
 helo=NAM12-MW2-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nMiSt-00CYED-Kt
 for linux-nvme@lists.infradead.org; Wed, 23 Feb 2022 03:37:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FH9PpMnssMLW+vpsjSZP50IsEixKkd661XUlvKYQ9+BfwyFzXFxjPSDd+vkylec4g0gXE0ufxc62j8e8cAQoNhQVoF9pZglOCLPhD3wHB66wr0xpj1vryxlS8DOs1CFwNBAiNU4wuedkKs70x6nVxmZ6y0coeAZvtCI9P4psW/1zXQMhztU1XcrZsumW8OIw3As663Sr1lRlw2EjFZYOMKV3d5qUeQ9y5Litib0VKbIBdKSsb+Y7YgG1wxn1ZZp5VYvxmktM1eIIKbsRBKyNa+7f4P407O2YBHmnHcnZbKo+kIwNiN3y15pmM2x4DdAMyoQhaFFfyVbb8U2dK4oeKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B+UjQq8f2S7z+GEWWdMaMdQ7TMxhcbCA8XGOBYkABM8=;
 b=Se4Oc6T4qienIFvHxP3wftVSjU7jFyPXKRk3wFKD9KjPcs/nFdttu6Yppbcj19C99dfEKNCJyky+vpaGmpHCJvo3PmTSpnuWHtRJvDv6WMBEix78bc/eqLCjiSQVLOdLqSXvDewYoQGO+K6tCrsJ9k2auqKRjD1zT1a7Ep3gzbAnydxMB+030mAoFFCQ68kZ30xM2nHBGajxvZMbIpHgAlQUVEy7KGmH7Q8us/cJ51CBdZijDP4oOPz7YVobxptzKDtY4VdE2KEUSg5yQMluaOgIHMUArN3irt7N2dI7TWDa1FiyafGiRcSgSzvQUys2ef0FI27RIUllyUISDSl/Vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.236) smtp.rcpttodomain=lst.de smtp.mailfrom=nvidia.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=nvidia.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B+UjQq8f2S7z+GEWWdMaMdQ7TMxhcbCA8XGOBYkABM8=;
 b=ooOK3PFgCo86Nn3VMDbFlKHLf2lg/2My5KkNWkA6nY9tYycZa6rGAkTYWcQ34IFu1fHKwZYLIosx7cxW6GRGHoHzB9cZUo3g1hN2geKgJjKPbxdU2EDyWVFjwXlwVSMdB1XjAPHRUhyfUQbV7HwiPyjbo/BgM7thFAe3n33oZm7VYss1KvYwTNHJrkniFUgSgF/LScgTC0xV/wnIkTjRDyMLhBrjyXmPcPj9gPtoXmqVYdtiPJol8midHC4HZctUCMU3CWR9yyb4dOu1EwHP+z+wmmSfEt8vggOyJGJpApGW6w4R5LV11uSPEmkepQM3DsRWqJDu3VOam4hIfJikvw==
Received: from MWHPR02CA0015.namprd02.prod.outlook.com (2603:10b6:300:4b::25)
 by BYAPR12MB4726.namprd12.prod.outlook.com (2603:10b6:a03:98::25)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.16; Wed, 23 Feb
 2022 03:37:16 +0000
Received: from CO1NAM11FT048.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:4b:cafe::29) by MWHPR02CA0015.outlook.office365.com
 (2603:10b6:300:4b::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.21 via Frontend
 Transport; Wed, 23 Feb 2022 03:37:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.236)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.236 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.236; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.236) by
 CO1NAM11FT048.mail.protection.outlook.com (10.13.175.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5017.22 via Frontend Transport; Wed, 23 Feb 2022 03:37:16 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by DRHQMAIL109.nvidia.com
 (10.27.9.19) with Microsoft SMTP Server (TLS) id 15.0.1497.18;
 Wed, 23 Feb 2022 03:37:15 +0000
Received: from dev.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.9; Tue, 22 Feb 2022
 19:37:14 -0800
From: Chaitanya Kulkarni <kch@nvidia.com>
To: <sagi@grimberg.me>
CC: <linux-nvme@lists.infradead.org>, <hch@lst.de>, Chaitanya Kulkarni
 <kch@nvidia.com>
Subject: [PATCH 1/2] nvme-tcp: don't initialize ret variable
Date: Tue, 22 Feb 2022 19:36:56 -0800
Message-ID: <20220223033657.208747-2-kch@nvidia.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20220223033657.208747-1-kch@nvidia.com>
References: <20220223033657.208747-1-kch@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 93ef231e-0fe4-4214-2251-08d9f67dc983
X-MS-TrafficTypeDiagnostic: BYAPR12MB4726:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB47265ABFBD12DBD1015EBCBAA33C9@BYAPR12MB4726.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5YmWI8nQ9VlIPbeMpjGyQOUYN0JJZC0E5XKH4b7pDZOTaImXJxHVxnhHCOs5KEyotY9riqW/vAx2OsIJHKQiPetpQR5WD0EfgeZkozHo9W0PjID8IIWuhITyimWdOUdr5sLMQT//YGxo/Xu2CD4aGo/TpowBcR8+wKla848YkGHTEbWAMOy2euBw6QVu//fY0PQovXtklfm031QrAMefQnEH83ySZ48mijXmq92tfICfMXhw6ZlSIpI6JMJznJK9FGK/V4s2bMhgt/u1kai/vSy9cCMjjqxJHa+8EcBQ/av1wLn5FTs7C3qZW2ow9tjHApB2Itx/sQMPeoAAuIFDh6YUYJqWmxUDxutpWn/ZxgqRxo2v/5+3xiGKcZ+ZCHqdTaRld4c7s3W9irxiuwjQ51y5UMwGnI1pNLBCcjPmCxFGcWDR2/ccwvzHNPiamLwxpunBO/TLpOlpYL6TmfmbFfzMCew4Ub6FS+1HlN85ooUu52h7Q5sVRJfLeRYPhKDRpAfa+Cjp3XXE6UwznxopFnWjUfdX/9MDwDFV13rT1iF/kXHW9vhCnjcrUhPcEe04zL7wsZzo230IoN9KCwjras3PwNfcfYavtBeswod7RCOipOaN9M3bExPs4GlKMFiWpEtIVLukmkRhW1z3Ywh1U+qSWZIneXPrdPdl1RvzFlGQE7IauwS/hMkUvo3ZK8ySrUljyawWFC34vxhDjUF+IQ==
X-Forefront-Antispam-Report: CIP:12.22.5.236; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:mail.nvidia.com; PTR:InfoNoRecords; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(316002)(36860700001)(2616005)(426003)(1076003)(16526019)(107886003)(336012)(5660300002)(6916009)(36756003)(54906003)(40460700003)(83380400001)(26005)(186003)(47076005)(82310400004)(8676002)(7696005)(6666004)(70586007)(2906002)(81166007)(70206006)(4744005)(508600001)(4326008)(8936002)(356005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2022 03:37:16.0701 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 93ef231e-0fe4-4214-2251-08d9f67dc983
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[12.22.5.236];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT048.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB4726
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220222_193719_713833_36B28E56 
X-CRM114-Status: GOOD (  10.51  )
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

No point in initializing ret variable to 0 in nvme_tcp_start_io_queue()
since it gets overwritten by a call to nvme_tcp_start_queue().

Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
---
 drivers/nvme/host/tcp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 6cbcc8b4daaf..bb03ae5ef11f 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -1674,7 +1674,7 @@ static void nvme_tcp_stop_io_queues(struct nvme_ctrl *ctrl)
 
 static int nvme_tcp_start_io_queues(struct nvme_ctrl *ctrl)
 {
-	int i, ret = 0;
+	int i, ret;
 
 	for (i = 1; i < ctrl->queue_count; i++) {
 		ret = nvme_tcp_start_queue(ctrl, i);
-- 
2.29.0


