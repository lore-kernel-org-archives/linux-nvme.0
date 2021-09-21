Return-Path: <SRS0=kLfw=OL=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 338E6C433EF
	for <linux-nvme@archiver.kernel.org>; Tue, 21 Sep 2021 19:05:43 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F263461186
	for <linux-nvme@archiver.kernel.org>; Tue, 21 Sep 2021 19:05:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org F263461186
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=MuJ24Q46+cOI3M8qE58TsZGJIK1oubyO6q25H7i5y7U=; b=oEsSLliSSFJ3l+
	Q2/xA5RM9mFrhCJWQJIJrQnE2IIBlt/CNORPnrMEgfaOuFGUAYxttXnGjHK1ta6NQoeHowj+Mvd3Q
	2oBhuOHlBSKDlpb1J0Fpa78q9UhhZp7WTJMAnf9sUemJL5L5HKc6CVeYsUkP7KTWL2lIUJD2XII9w
	m54yye6srl/P2FkTvS/Jv0TJk1qsWUnXrtpBV85xAiww9XYKlTNRU7k+hiWfzbdwNZZyI5G+yLzPv
	ASDawn9kKlWNF4FcTUH51es0oUi7PglB7aqqWs0DQgUrR+oB95HA5u+v0V5HWBuDF1tg/bFvWx6NT
	VgzLmhYiQEb95ms69ymQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mSl4v-005ZM3-IO; Tue, 21 Sep 2021 19:05:17 +0000
Received: from mail-co1nam11on2053.outbound.protection.outlook.com
 ([40.107.220.53] helo=NAM11-CO1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mSl4b-005ZJW-Fg
 for linux-nvme@lists.infradead.org; Tue, 21 Sep 2021 19:04:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=igBN9lnMKYQMsjNu9HAKLnUFIlAIFW1OYesJBUkdT2/4lUh4XPzEAlbkgdeabr4iXfnuIXbDfAEwX0k7X9oqVd3jWOyKR/24OudGL29ejeQrxQmB89ENrQPDM6/YgrE3Bf0RvW0avri2rWfk9xqqYwxprq3NRwR0S9Mm3N7wAG3MF03P0TE4uvp05DKe2xKmCU8k9gfQ/ZZ2Y5NFvY0AASjNVv9gX/vW/sTDfxRWI7mirDtsVZAfRSmeU+3Ae7O6zjqICrOBketnjKuslWVxRAP9H9okfna04csvqJ7ft6R80i/WUfkOFwvJAQLWkT2D0YjZqqV69pkjatifv96jKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=jnZ/cK1CxmMsL2CNaQQAgIfwPNOwuICoyKGZ1JQXHLU=;
 b=BQBoerRmhRdb6IFCeLA2fCpsn/bfV+hng0dArQ2IbMqwr1F63EBWTZRB7sRKhENMAydo4Ich7irP9/Nlg3m08slzgmBQFeTDxk6f72MAZ6+J6wO9qAcYaheDFw7LcrAbiu+ARlf59LvpYgfutri6Yhnhyq40/67rmfwkekpJnzJOS8vw+Y3IUKlSaoa0Ivk3LT/nExCIm+N1pKdnndWR6kkjriCWbbGUpSdE60rlSndmhu7nj451rXMZKJ4pVZeFzKjmcYY3cQzDEo1GihVlqfeh7LhbiWIONwpWSV8LjoiZSgag5HiQnSGYbPeWJaQaf621oCGSL/Z49h4WK8S9tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.32) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=nvidia.com; 
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jnZ/cK1CxmMsL2CNaQQAgIfwPNOwuICoyKGZ1JQXHLU=;
 b=jSfxjts1Mnw+ho6OKVj2zE+6VA4PY00Kbs7iD3FPLJnHBsRCLXb7SGFPyH7/nFLl/eOjN/0AgBWdZlR+UhpQDqqgeytWI1swQ/Aa0ClHDQeV6UklOTITfTE4RoSIM3OzR5sLqEcUoDZ/rwLRBR6A7xwSrjh2AH4oDHXfaMdr+ex1kg3xRmDmo95MqY0QsLNeSSamX+vZUC/Nm8r2dmj1vn9HkGOSTyZVbWAROh8XWGTZDxN/f+2iRfchUHiTXwL26Uk1QaKWibCjIllCDCFKTgP73zvDZyGW+w4qr8YDcIr78vE54r2A6W5WZdeMV9gAMVekbuVmehEd5T6cvn+ByQ==
Received: from BN9PR03CA0562.namprd03.prod.outlook.com (2603:10b6:408:138::27)
 by DM6PR12MB4403.namprd12.prod.outlook.com (2603:10b6:5:2ab::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13; Tue, 21 Sep
 2021 19:04:55 +0000
Received: from BN8NAM11FT007.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:138:cafe::ec) by BN9PR03CA0562.outlook.office365.com
 (2603:10b6:408:138::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13 via Frontend
 Transport; Tue, 21 Sep 2021 19:04:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.32)
 smtp.mailfrom=nvidia.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.32 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.32; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.32) by
 BN8NAM11FT007.mail.protection.outlook.com (10.13.177.109) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4523.14 via Frontend Transport; Tue, 21 Sep 2021 19:04:54 +0000
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Tue, 21 Sep
 2021 12:04:54 -0700
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Tue, 21 Sep
 2021 19:04:54 +0000
Received: from r-arch-stor02.mtr.labs.mlnx (172.20.187.5) by mail.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server id 15.0.1497.18 via Frontend
 Transport; Tue, 21 Sep 2021 12:04:51 -0700
From: Max Gurtovoy <mgurtovoy@nvidia.com>
To: <linux-nvme@lists.infradead.org>, <hch@lst.de>, <kbusch@kernel.org>,
 <sagi@grimberg.me>, <chaitanyak@nvidia.com>
CC: <israelr@nvidia.com>, <mruijter@primelogic.nl>, <oren@nvidia.com>,
 <nitzanc@nvidia.com>, Max Gurtovoy <mgurtovoy@nvidia.com>
Subject: [PATCH 2/2] nvmet-rdma: implement get_queue_size controller op
Date: Tue, 21 Sep 2021 22:04:45 +0300
Message-ID: <20210921190445.6974-3-mgurtovoy@nvidia.com>
X-Mailer: git-send-email 2.18.1
In-Reply-To: <20210921190445.6974-1-mgurtovoy@nvidia.com>
References: <20210921190445.6974-1-mgurtovoy@nvidia.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ca1e98ea-8c37-4135-f6c0-08d97d32b2c9
X-MS-TrafficTypeDiagnostic: DM6PR12MB4403:
X-Microsoft-Antispam-PRVS: <DM6PR12MB4403882A430513CF6467190CDEA19@DM6PR12MB4403.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Jz8zhQGJjd5Xly44GvDF4SVI0oKiXSV1cKf3811puLCf4E8QzGCYWzFRt7usYnqK4MDLQXPWaru0nH/wB0Mzl0AN7BxyfGHUMSfxDK2YmNiHssRufB1NmZRn5XdPdJ8ONBXLWbVHTMCfJs0nCxmdZXI1LE50bitophYPEa3C7Y0M+duS7JvVQreUvZ1ezPN49e53pk79e19IehAROLLqn1iuet8/VvU0A8Wg1Xl9wGGweAUeQKf90bReaSAf/x0aW/VyUb4UPY4Ay8Tvlb5keLnSK613LUYlTKmsY6JZw2Tr42lpbrOnqDFmOfho0D1Edbadt0KYU1/npl3GBtTDPcsMCdTAUXP1IFG0qNHe9KZ0yMW9kwso73TSBVjLCimu6E5ycFOF9R5zPc7AdeMVjMMm50bO2ecfgVL2oUedkP4MpVcpKlghuqSPQgPagdzogRBRaMCKhNPmaOI/Z/pcnJUYuSYfadlwBeh/ikAj8JHGEn+112Mq6i1y4SPLs16u5ml8KhjsBVJQVWcOxQuy/+6bI1XORbLDA+skgc8xLfmf2HHingvvz7kEgGkn3h28GlftnFY2HD1EsZpx8uSyxr/DuQb+vHcfSUJAXLP9tllWymFeIYRO6zGTl9BeZdvxU3d8JOa2pnK6wGzSKHqGrGKy83gAj1YuApJ78sAByZLaDjBthXQ1TdKwWTm75ycLW9+hZ5pcph9xN2rixgGJKA==
X-Forefront-Antispam-Report: CIP:216.228.112.32; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:schybrid01.nvidia.com; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(83380400001)(70586007)(82310400003)(26005)(107886003)(110136005)(426003)(4326008)(336012)(54906003)(508600001)(2616005)(36860700001)(86362001)(7636003)(36756003)(186003)(356005)(1076003)(47076005)(6636002)(5660300002)(70206006)(8676002)(6666004)(316002)(8936002)(2906002);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2021 19:04:54.9334 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ca1e98ea-8c37-4135-f6c0-08d97d32b2c9
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.112.32];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT007.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4403
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210921_120457_590510_F62E5F6B 
X-CRM114-Status: GOOD (  10.57  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Limit the maximal queue size for RDMA controllers. Today, the target
reports a limit of 1024 and this limit isn't valid for some of the RDMA
based controllers. For now, limit RDMA transport to 128 entries (the
default queue depth configured for Linux NVMeoF host fabric drivers).
Future general solution should use RDMA/core API to calculate this size
according to device capabilities and number of WRs needed per NVMe IO
request.

Reported-by: Mark Ruijter <mruijter@primelogic.nl>
Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
---
 drivers/nvme/target/rdma.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/nvme/target/rdma.c b/drivers/nvme/target/rdma.c
index 891174ccd44b..16342c5f31e8 100644
--- a/drivers/nvme/target/rdma.c
+++ b/drivers/nvme/target/rdma.c
@@ -36,6 +36,8 @@
 #define NVMET_RDMA_MAX_MDTS			8
 #define NVMET_RDMA_MAX_METADATA_MDTS		5
 
+#define NVMET_RDMA_QUEUE_SIZE	128
+
 struct nvmet_rdma_srq;
 
 struct nvmet_rdma_cmd {
@@ -1975,6 +1977,11 @@ static u8 nvmet_rdma_get_mdts(const struct nvmet_ctrl *ctrl)
 	return NVMET_RDMA_MAX_MDTS;
 }
 
+static u16 nvmet_rdma_get_queue_size(const struct nvmet_ctrl *ctrl)
+{
+	return NVMET_RDMA_QUEUE_SIZE;
+}
+
 static const struct nvmet_fabrics_ops nvmet_rdma_ops = {
 	.owner			= THIS_MODULE,
 	.type			= NVMF_TRTYPE_RDMA,
@@ -1986,6 +1993,7 @@ static const struct nvmet_fabrics_ops nvmet_rdma_ops = {
 	.delete_ctrl		= nvmet_rdma_delete_ctrl,
 	.disc_traddr		= nvmet_rdma_disc_port_addr,
 	.get_mdts		= nvmet_rdma_get_mdts,
+	.get_queue_size		= nvmet_rdma_get_queue_size,
 };
 
 static void nvmet_rdma_remove_one(struct ib_device *ib_device, void *client_data)
-- 
2.18.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
