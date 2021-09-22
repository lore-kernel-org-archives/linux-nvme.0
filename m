Return-Path: <SRS0=1D85=OM=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2A44C433F5
	for <linux-nvme@archiver.kernel.org>; Wed, 22 Sep 2021 21:56:21 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A9EA60F24
	for <linux-nvme@archiver.kernel.org>; Wed, 22 Sep 2021 21:56:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 3A9EA60F24
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=5QWYetiOFcSO6Gj2kj2+oj/JWpZ0CJS+oIzzBUR3b3o=; b=qZyPVq30O+dTpm
	H0RKVGHdcYIE7VJ5DPp6QeivsY2lAvJ6g4bso3VrzCIscHJ0XggQzdmEbRd8L0mdXeJJPD6WHnv2p
	9aKPt6XLx0zjBpN0vxk/tJt0GOCWxtG0b9QSc6mPFQvSZF46iGJZeMQ9TZZiu8Nm7AyZxylJhwG4W
	UeSkU9UIda8XAhACwAFvXIEE8nQALtwQRHx5EaMtkvs4Z4di/NIjkKjfNYfexmoAyR0MPnwt+2c89
	HLSQMWGjwcvKZFrvQdyR9b7lS/81sc2JM4nsnWusXEo5DV6HySsY31LYx9HnDceU7XAzopAh4PVK2
	hkl08nNVjm96fEDAoVpw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mTADa-009mhO-Fq; Wed, 22 Sep 2021 21:55:54 +0000
Received: from mail-dm3nam07on2047.outbound.protection.outlook.com
 ([40.107.95.47] helo=NAM02-DM3-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mTADX-009mgH-Hk
 for linux-nvme@lists.infradead.org; Wed, 22 Sep 2021 21:55:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gFGME/05lDFiu+/iXsccR2y+gRTdXlfDTS7sps/cioOc30Wht8uu2R5SqIHwovSliXhkaGIpZXeJE6RA+SGA23Lb3D/w0ozkY7aTtgBNTmpTeNUxBzmGlwV7XLcQ+LS+vuHQy9VWiAIUn525hq7pT4JpahlkyCP05LXy6LgTO1kJoKVdFDceqCa5OOBoUbWkZPmhgt7l0OUuUhtCIsLn6htjP2LHnImphBGNNkTRlkJTkSEC8nN2OoUiseIu/GqtoP8ni6k9wZqY2IiR+TeIZFBsUwx6vqQsOnE2QrPxxg7Y86MBKig6ANUKpfOWhlxXpkI8jbPIl7qS+DZVYDDyZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=YmAH8g4dPwdk5bjFjt1ih9Zxkxbl3+K4ezaOZoWe2ek=;
 b=DfupmYw2tDjitifBBCuErZk5y500kyPdhwCv4sgFxmIMXG+DNqc8Z3ym+vpurjeDcSrD2qsYIM6RZ/fWs0+b5oPzgg5tzGCUWka7UPr3hjAFRYLMWR2OJg93DIVv25m4ZVni1QI3widvbfMJSbS2+APYyv221tVmBz2b24xl6RxrLzuMC/Tcjr6HpSDB0nRO2JTKn7V3NpAAfD/zPjzmNpLJT9qFOy0E+lKqvD/47BNYDQoWhePiZ6vNkTxLAzMPpkv0SnMz5ISI6zd6qRmcqtjt5RceohGE6rQIWAYCn7Ia6BTmUjLFy7X5kDDC+fYtAaHY8UFbNQcwwaI3hMT8HQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=nvidia.com; 
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YmAH8g4dPwdk5bjFjt1ih9Zxkxbl3+K4ezaOZoWe2ek=;
 b=NtUwy9hQK9N9YiZcO3Wv90IjJHg2tch5jzHSPk51xE9Ysb9OFpQsx3gYr4RKlPdhlqMdgQR7FehMQuXHcO2sovNuBIfyVKSuY23+1cJ7tKmPUdbF1FnhstbsRD2UOIKfa8Pv+I4X7s/tyFDlqQHNeSkFMWQoj6wb7tfFzkX55hpJmENgYEPfHUuCt+vsqCIYURgwQ8QoA8Eq/27hpUxMLU+12gM7iJ4WyRRcExlUhonIDa0X9E+bYU74mbDiwc0Pk1QdmDnNoSY17OSmkqEwVXyD5509/OWEHYMC1wl9JDd6GqbMvDSkYzC/FSxCiEhX0SytsOkPuQaot+wBPoqBDg==
Received: from BN0PR04CA0088.namprd04.prod.outlook.com (2603:10b6:408:ea::33)
 by DM5PR12MB1803.namprd12.prod.outlook.com (2603:10b6:3:10d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.14; Wed, 22 Sep
 2021 21:55:44 +0000
Received: from BN8NAM11FT034.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ea:cafe::f2) by BN0PR04CA0088.outlook.office365.com
 (2603:10b6:408:ea::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13 via Frontend
 Transport; Wed, 22 Sep 2021 21:55:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 BN8NAM11FT034.mail.protection.outlook.com (10.13.176.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4544.13 via Frontend Transport; Wed, 22 Sep 2021 21:55:44 +0000
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Wed, 22 Sep
 2021 21:55:44 +0000
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Wed, 22 Sep
 2021 21:55:43 +0000
Received: from r-arch-stor02.mtr.labs.mlnx (172.20.187.5) by mail.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server id 15.0.1497.18 via Frontend
 Transport; Wed, 22 Sep 2021 21:55:40 +0000
From: Max Gurtovoy <mgurtovoy@nvidia.com>
To: <linux-nvme@lists.infradead.org>, <hch@lst.de>, <kbusch@kernel.org>,
 <sagi@grimberg.me>, <chaitanyak@nvidia.com>
CC: <israelr@nvidia.com>, <mruijter@primelogic.nl>, <oren@nvidia.com>,
 <nitzanc@nvidia.com>, <jgg@nvidia.com>, Max Gurtovoy <mgurtovoy@nvidia.com>
Subject: [PATCH 1/3] nvme-rdma: limit the maximal queue size for RDMA
 controllers
Date: Thu, 23 Sep 2021 00:55:35 +0300
Message-ID: <20210922215537.6499-2-mgurtovoy@nvidia.com>
X-Mailer: git-send-email 2.18.1
In-Reply-To: <20210922215537.6499-1-mgurtovoy@nvidia.com>
References: <20210922215537.6499-1-mgurtovoy@nvidia.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7ec48ec8-4522-4e64-d0a8-08d97e13ba7c
X-MS-TrafficTypeDiagnostic: DM5PR12MB1803:
X-Microsoft-Antispam-PRVS: <DM5PR12MB1803683B2960236A0959DD77DEA29@DM5PR12MB1803.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3826;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UMxnnHx7pQhALQcRSiWhToYXQQI7/aRidZP9ha+kejyQg8oJEoK6tMcTr6cJEs4xe7eSMqj2zIAZALXJ+HlBTJQx/6JZLtZ2tOKdS/VYCUhKXytMJk0Nha+oPrOlmYvhe4XREPKa4rJLeSumzCSTZiuxY+Gu4O3Ywd9BANChPBbFuN9Qj3wsrQQs54UcVdpEm3UTSdyhyFz4Nn+Pf+yBwfDYtl15pxzsAe27twh68apcI8xZ+TiSc3/cdHOimBdGunYXtKR9P9HZKAb+m58h+AqRkpXm6FEJme+5j7X9lDzuBfTjl2kVGFUCS91VvoTkKj26/MVjQ3Re3FOTZsGAEaNkLtCcgGup97l9k31/jnyEyA4tJx6X8m7rtM2JLCj+H/u8X0GJe9KLwHMSRUmkyIYpQMZUDtbbmSSovlUmEvvCtSSwkRzHrR1MUa3DC+B9Ao5zQjIhU4IaxzMI+FSTZiaL3KGpKoq5ahJGAOJMewAcRdpp4l98rW+9/XYmKWnWTipynfalhTvc9c9TBIzqaEcfd0jqxFS5y3x5meHL64gcIozjE692S3kX8ykLd6s+Hu89trEKL9i3TH4IsJhJwofYTw8Hdq0zg9V7FqcPGrEQtrNWNY3bIUiU+kz1zW4ySLqEJdmOUvGMl045oqgm39v2a9+42n6/oFXPHsxOlPN3v1Ezo58BASDkho4HXl9dtGZFnFUWvfU9AndnJSYfOA==
X-Forefront-Antispam-Report: CIP:216.228.112.34; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:schybrid03.nvidia.com; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(8936002)(54906003)(426003)(110136005)(82310400003)(356005)(508600001)(70586007)(107886003)(70206006)(2616005)(83380400001)(336012)(5660300002)(36860700001)(86362001)(4326008)(26005)(36906005)(6636002)(186003)(1076003)(36756003)(8676002)(2906002)(47076005)(6666004)(7636003)(316002);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2021 21:55:44.6197 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ec48ec8-4522-4e64-d0a8-08d97e13ba7c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.112.34];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT034.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1803
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210922_145551_862563_38FB35D7 
X-CRM114-Status: GOOD (  11.25  )
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

Corrent limit of 1024 isn't valid for some of the RDMA based ctrls. In
case the target expose a cap of larger amount of entries (e.g. 1024),
the initiator may fail to create a QP with this size. Thus limit to a
value that works for all RDMA adapters.

Future general solution should use RDMA/core API to calculate this size
according to device capabilities and number of WRs needed per NVMe IO
request.

Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
---
 drivers/nvme/host/rdma.c  | 7 +++++++
 include/linux/nvme-rdma.h | 2 ++
 2 files changed, 9 insertions(+)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index a68704e39084..a2f62eefccd9 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -1111,6 +1111,13 @@ static int nvme_rdma_setup_ctrl(struct nvme_rdma_ctrl *ctrl, bool new)
 			ctrl->ctrl.opts->queue_size, ctrl->ctrl.sqsize + 1);
 	}
 
+	if (ctrl->ctrl.sqsize + 1 > NVME_RDMA_MAX_QUEUE_SIZE) {
+		dev_warn(ctrl->ctrl.device,
+			"ctrl sqsize %u > max queue size %u, clamping down\n",
+			ctrl->ctrl.sqsize + 1, NVME_RDMA_MAX_QUEUE_SIZE);
+		ctrl->ctrl.sqsize = NVME_RDMA_MAX_QUEUE_SIZE - 1;
+	}
+
 	if (ctrl->ctrl.sqsize + 1 > ctrl->ctrl.maxcmd) {
 		dev_warn(ctrl->ctrl.device,
 			"sqsize %u > ctrl maxcmd %u, clamping down\n",
diff --git a/include/linux/nvme-rdma.h b/include/linux/nvme-rdma.h
index 3ec8e50efa16..4dd7e6fe92fb 100644
--- a/include/linux/nvme-rdma.h
+++ b/include/linux/nvme-rdma.h
@@ -6,6 +6,8 @@
 #ifndef _LINUX_NVME_RDMA_H
 #define _LINUX_NVME_RDMA_H
 
+#define NVME_RDMA_MAX_QUEUE_SIZE	128
+
 enum nvme_rdma_cm_fmt {
 	NVME_RDMA_CM_FMT_1_0 = 0x0,
 };
-- 
2.18.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
