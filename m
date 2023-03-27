Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 542FFC76195
	for <linux-nvme@archiver.kernel.org>; Mon, 27 Mar 2023 06:05:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ieuXX9WvfJYeYz7QLOVgsRkqknyhOo5y5HO0lguOrOI=; b=MlCQQujMt0vJgsoF7eoVWud/g2
	+OSrqtaeiCL9cIG2aNwoD2FVXVZPbi3U94yAGwufcOA2sG57H/uf+IxwUBJF5LsoEb40+W99TZuAs
	Rrongv6dda2bl5zIMDROY4fxfskzWRVTc7OZf5E1gL3dmKqqtKJlx0bdjqEtVP/Bl/4S3sVPo1zeI
	VtxN3an0kVj3/VY8/p3QkVlOO8kqilE87pRpwSpa3vR7j1V+bzKi2cXLpSywwJ0QxC+jXHnIKSdz0
	36z+CRxBSVYvN8375P06PV7WMK7bXVVRuTTbUR9cQGQocSQTDY/jiq7sRSwsCAADTHzc9RPzc5yCL
	0cCwGy6A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pgfyk-009u5g-2e;
	Mon, 27 Mar 2023 06:05:14 +0000
Received: from mail-mw2nam04on2061c.outbound.protection.outlook.com ([2a01:111:f400:7e8c::61c] helo=NAM04-MW2-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pgfyi-009u4y-1X
	for linux-nvme@lists.infradead.org;
	Mon, 27 Mar 2023 06:05:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZOjviSVjkTVy1TJtXuX5n31ANWvxy9GpgNm6xk8YkUbNa3Gs6UmDLD9jeqbvGpszoPcHfX0mV9zpLV+9TLXfPBFU1pUhhuw+KOYBpGWnhHN71s+/UHuNhXgGpGqAECi1WQcn6WkPxRT60vvSkRD9yFWMsH8xmc7YTo4S62QlrB/jWXrahgHhZh3LYn2CTS/7Z5201QRZhPX48rAxLeA7MULDfu0p4XCrSZABd17zNXiqZKTMVuwHBBIgame7NyjLTsldzebDa8sICbzjM4wZ8sbbEgrQllrIKXAaYVq1L8GoAcW5wCfViuKOxzaMZL9PCz90eo2JY4ZLDlfMlq70dQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ieuXX9WvfJYeYz7QLOVgsRkqknyhOo5y5HO0lguOrOI=;
 b=kFYawO9f2vWBa0lJ9UR4CD50R/+C8LGTITuupGTkaGSF/CCbP2Dnm+5g0H8ayZolhv5C3zQF5QCtfZeiCwL28PpgYXQNKqMThP+ZZcjPUvW7hOJ7BpL1vePnOnfKcreU3E3FO9j1W4qYpBiZ+2in48Z6wK2XpfmGdP9BUeQYZ6ya7Wta57A4ytIHbFMcFv/2UZus/SLekCcsLdycn3PB1yDTGcKSVb7cCQ/gqJUaplxrB1paP/a9Tts54ms59B3FPcUSWuYjDKX5YBwrZig8wKCiWe6U7fYzS8W3Ud2725m/7Ay9BGZTT3H7dzGDa8ZCgWM0ICJW6wXVEqRf1Q+NXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=lists.infradead.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ieuXX9WvfJYeYz7QLOVgsRkqknyhOo5y5HO0lguOrOI=;
 b=kZCRoa1mc1mDMCOb/MPzNjki5sL6D4YZiccyzl15KCuOVzyEeaTo5WeTHYzJcaASNCI7sNsC25dPBOSmlxaXPcu8/nyeidci3JI8cegJ4ddqMqymbhlrTqi+pdryi/0bm2Z3HNs4APvp8SL3dLLiQ1OcSP7xlPj7Fy6xBNyDc6pxLPHFKRTM2SRcEPXyLulxdJFoJQyikKkTfWRQmFu0ooUJggZbj6TU7Dh/O91EJXaws2Z6RY8jjT9E06/Kcw9wYjBmxw47Oa8u19mjwuKD3zRvDHRV3EWgrsWKRfqx4OXObhqQPFEciF54RwVqBgRyd2lUcHYpQnD+M+U4801FuA==
Received: from BY3PR04CA0029.namprd04.prod.outlook.com (2603:10b6:a03:217::34)
 by PH7PR12MB7965.namprd12.prod.outlook.com (2603:10b6:510:270::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.38; Mon, 27 Mar
 2023 06:05:07 +0000
Received: from CO1PEPF00001A5E.namprd05.prod.outlook.com
 (2603:10b6:a03:217:cafe::8f) by BY3PR04CA0029.outlook.office365.com
 (2603:10b6:a03:217::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.42 via Frontend
 Transport; Mon, 27 Mar 2023 06:05:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1PEPF00001A5E.mail.protection.outlook.com (10.167.241.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6178.30 via Frontend Transport; Mon, 27 Mar 2023 06:05:06 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Sun, 26 Mar 2023
 23:04:52 -0700
Received: from dev.nvidia.com (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Sun, 26 Mar
 2023 23:04:51 -0700
From: Chaitanya Kulkarni <kch@nvidia.com>
To: <linux-nvme@lists.infradead.org>
CC: <kbusch@kernel.org>, <hch@lst.de>, <sagi@grimberg.me>, <hare@suse.de>,
	Chaitanya Kulkarni <kch@nvidia.com>
Subject: [PATCH V2 2/8] nvme-core: remvoe extra line at end of function
Date: Sun, 26 Mar 2023 23:04:12 -0700
Message-ID: <20230327060418.86655-3-kch@nvidia.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20230327060418.86655-1-kch@nvidia.com>
References: <20230327060418.86655-1-kch@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.37]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF00001A5E:EE_|PH7PR12MB7965:EE_
X-MS-Office365-Filtering-Correlation-Id: be5f5cb6-f80a-435e-383a-08db2e8936ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 	i8312hqOnLmNObmv98NJ2hZY0Y5qJGs4XoRLYHMj/UQ1a++iEY0w862NNIpTbDqQcpkg82W2PsvXoJwLDE6Oi2PBmQAL1vdMDrHrqaA3eE6eJUeHN3B3LqRgtIaShUtKKto5HCpSefrDR/pqaDVez0APYa3rvB7c9yrwXmDJVBHEd1kUqxamVvDlBT15xr11AcR1HkTJCIWbmibtKWBnaICXexg8y78gTKtTMgy7OgBrYcrNyk1sc1+J/02BpgMtBdPwtsx6zUma0dNgo2HdEum9PKepabb5JBwiStPVMUwVLW/0d6XzzmdoW5aVpSZpsM9Zb/WfLMJWBevyhr6JPmlA8xzHJojFUPcJUuFFtkEnoBXKJrWeHEqzU2HAUYHq/zZax77jjVjjR4uQ//hyh8U8YiwvcPkolf/lavKjZPNVlQLRibCw9U0z68YGRZnaycDTcvo5RM1v6pfLALhJi+DpgTLlvOYQIXpt3PuLp2UNNbJdlKxErPyMSi2GqHzgLpr+e68fjaLGWTEZd0tjaPWYV8GceVCqIjr1DAUcxJzPk2ibcG55dTEyZ18zaoL6wDnfV0fVqolu9ni7KSueTNhd6QFOHohyslqXqJjlk3a1F0o0I4FuqNLtl4YuuCqj3VA2DC7UAH4yZaPPwUMCDN9JflVmO8/cYFZMVh5HG+Unb0SQAwuuxYb+I3g5lwAj5yyGWwEp1zhpLGW32d7chBoJLL2s4FpfZRz6Kkoq25PTzrhmkLlYiwzO263rw6st
X-Forefront-Antispam-Report: 	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(136003)(39860400002)(346002)(451199021)(36840700001)(40470700004)(46966006)(426003)(47076005)(107886003)(186003)(16526019)(36756003)(316002)(36860700001)(478600001)(54906003)(2906002)(40460700003)(7636003)(8936002)(6916009)(70206006)(41300700001)(356005)(7696005)(40480700001)(70586007)(82740400003)(8676002)(2616005)(1076003)(82310400005)(4326008)(5660300002)(6666004)(4744005)(26005)(336012)(83380400001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2023 06:05:06.7001
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: be5f5cb6-f80a-435e-383a-08db2e8936ce
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: 	CO1PEPF00001A5E.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7965
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230326_230512_513574_29C0244C 
X-CRM114-Status: UNSURE (   9.21  )
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

Remove the extra line at the end of the function.

Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/host/core.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 71e2f6723590..725ffa66fa6a 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -4496,7 +4496,6 @@ static void nvme_remove_invalid_namespaces(struct nvme_ctrl *ctrl,
 
 	list_for_each_entry_safe(ns, next, &rm_list, list)
 		nvme_ns_remove(ns);
-
 }
 
 static int nvme_scan_ns_list(struct nvme_ctrl *ctrl)
-- 
2.29.0


