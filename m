Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00014C433F5
	for <linux-nvme@archiver.kernel.org>; Fri, 10 Dec 2021 11:23:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=CbG0HatEkaNFLChlyZnBddKyC3/NBFTAUqUy/ZNoZEI=; b=D22kWf8s00TDxraZknaY9LS26s
	bpnsge3ltTCxD+p+bg3P7IhKj8eZKBVs6RePDYPCWFLcgsh36tzpVkX9Gw7OgWGfk+RvHgvvnlg9w
	cCUU2bVzrlODHDLHUrJk8l5BENPtfTEcttIi9fEdaa9l0Vrkq4LB5HdybHLstMMD14GBWolJ3piOl
	nXXLWrfOsnMKxbGrzzBEnLnAioY2SgVTIJNi95JYBjUVNQefy8w3lAxNVOCJX78aHRJ2K0l3519s2
	ZlHNj9oEA4CDzvRnWLRC5E6hX6nhFSbBsvyJOMWfZceF+j0Ph7wOq8XMuW4bSXlTC1K7kfCeqFRzC
	cdn5c1NQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mvdzu-001eGT-Jx; Fri, 10 Dec 2021 11:23:30 +0000
Received: from mail-dm6nam10on2052.outbound.protection.outlook.com
 ([40.107.93.52] helo=NAM10-DM6-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mvdym-001dto-Ck
 for linux-nvme@lists.infradead.org; Fri, 10 Dec 2021 11:22:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MQ32HTyuMKg/32qw+rvnJndaxpjr1bpZ3sd81PIgUMjgLG/mQFwtu19YXKyfhyFart3ypz9N/vFXZXlIGdoEboi9FAT4vZ+2EYJ0AD1F9PL+8SdavwJ5ZePONmdJEDs32WWBvIWM27cdVScG8IzEnotCMJRdwAfqs1d5vl6GktZjtWTvxn6dSMU1kGGh6UcBiOge3fvfhMCKA1tKpNHg1ko4LOI5pF9XpBa1iCQ5HRmcK9RtAJqGGxR+uc6Yu/wTSGA6OrUeRwMUXQM6QspbwypJRRWvmc5H1BVzpMBVbrbScrmpa18G0tAXsdTpDNf4nmDgd6UAf7eSqpUSlSByVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CbG0HatEkaNFLChlyZnBddKyC3/NBFTAUqUy/ZNoZEI=;
 b=kcZt6xVibkbW501HnjFl1XEN9TLyPJo7y8zVziEIbSwNPfEfiRK5SqM0mZ6PPewCslmJAshZoC2iU3BfPFVSHRqUQr46FNAOw1hb3r0hwPyiCNGMMy2qL9yMjfjdOZZY4LugSIqnY9FRiLIuK9RkL14B25Hrt0XtZDnUkik/2OQ7eKSBn5H39IHcBwgfkSJJ+9uzjN2DSQrx1eKg4/lUBFJV7zLVO7rTP79pn2NP67wyE5fRusp1KzU5ci24LxRmEA1haNj75ifuF0SPJQwFck5dPdPZ4w/Thmjsa4qaCdurc4Yd7KnYL8WGM+vUPV5wk55n8b2FreS63oVipfh4mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 203.18.50.13) smtp.rcpttodomain=grimberg.me smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CbG0HatEkaNFLChlyZnBddKyC3/NBFTAUqUy/ZNoZEI=;
 b=TiWnQ2hyvQ5jJiBn1qa8deZ22Lp7lSUw3H8sMSLt07w6HYKhabwHdZK89H07T8yWSLP4wv/lQt3oqyBiF681OFxqAl1of2fmm02Jmg/OPYNRetR6KeScqmeyxS4JMpFZt/PVJHOU+yQOhoDoOQPNTVOHrgXh5lQqxkjWW8p+sl+SnBXPJ6bMopU/9vm3mURSMhjv5FH7X1IeR1LcFb0lxObtdVh7TKbvkJeX9nuzoWdFT8Y8c0xa6CTJ/pM85NYZPxgdpYWcDNQ3JLLLqmo0y/mCnGY4ki9T/n2IeUgtLrPh/DuqOqTDHMQM9HaSVl98Kt2ZrhaL9h+GWqsIS4bAOQ==
Received: from BN9PR03CA0476.namprd03.prod.outlook.com (2603:10b6:408:139::31)
 by DM4PR12MB5232.namprd12.prod.outlook.com (2603:10b6:5:39c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.24; Fri, 10 Dec
 2021 11:22:18 +0000
Received: from BN8NAM11FT055.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:139:cafe::95) by BN9PR03CA0476.outlook.office365.com
 (2603:10b6:408:139::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.11 via Frontend
 Transport; Fri, 10 Dec 2021 11:22:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 203.18.50.13)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 203.18.50.13 as permitted sender) receiver=protection.outlook.com;
 client-ip=203.18.50.13; helo=mail.nvidia.com;
Received: from mail.nvidia.com (203.18.50.13) by
 BN8NAM11FT055.mail.protection.outlook.com (10.13.177.62) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4755.13 via Frontend Transport; Fri, 10 Dec 2021 11:22:18 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by HKMAIL102.nvidia.com
 (10.18.16.11) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Fri, 10 Dec
 2021 11:22:15 +0000
Received: from dev.nvidia.com (172.20.187.5) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.986.9; Fri, 10 Dec 2021
 03:22:13 -0800
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: <kbusch@kernel.org>, <hch@lst.de>, <sagi@grimberg.me>
CC: <linux-nvme@lists.infradead.org>, Chaitanya Kulkarni <kch@nvidia.com>
Subject: [PATCH 3/3] nvme: add KConfig options for debug features
Date: Fri, 10 Dec 2021 03:21:16 -0800
Message-ID: <20211210112116.9299-4-chaitanyak@nvidia.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20211210112116.9299-1-chaitanyak@nvidia.com>
References: <20211210112116.9299-1-chaitanyak@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.20.187.5]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0297a512-00e8-444e-45ec-08d9bbcf53a0
X-MS-TrafficTypeDiagnostic: DM4PR12MB5232:EE_
X-Microsoft-Antispam-PRVS: <DM4PR12MB5232577F9981D0EB3674A50FA3719@DM4PR12MB5232.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +t+LjwxntzBGkhBU5d/Y0ZveBt7e4VLrAfyQ62naKPyDD03S4il/7Ptt6GKRmcc1uOAlCxBKNgDT8GZTLaYS5I5JwyZcOvpiVUAQHSxV4//KUhycovjxVp9N55VOy1gVQOEjzeObxtIe+VHY1gnJHOthSmhuB7JB+CgQCgdfXnmbsBWjS+THg3CAT6w4ZY32qB7rMbksjhxX4xLECd5aGjI9/zOLimoQTbG8ewZp8dLQHx0FuddwiYMvCv0qb86Q2ubC/Lb2Vx+6Ad3nZc/r7G8VVfLZoIR7HpOdioyf8B7kdcwJ3eDLmKzVTN0WYMJeZmydCHHI1m21j4hqde7lj6/WaMfpgiahSZ50HG4LQaVE+VgvdTcR8Zw4AwkcuOhr46kiVzv6gsDv7w3Qb9fcz6OIrdiH9yhgAbDFi3Cg1+3ntlYquHcuiPFTteyx8lLUjOm7slIYaBhBDB0UZi65Yx072cmLin0gWgmDUCFzAKCDxeHPXI8FF3gqE7Eu+7kW5f9XbhE9rJZHLjOM7Hf9s3gCozGGC9ikkV3/NvRBVwwpJ1z+HNi1nBvvYsQihhQfKn8C8nbhJ79rs52hbyEkQsntsYEHoOvG0nZmxpzJN0aqEPeBts5DwKaL5uXMeVaC4ZnUFjlFsW/A+cM3F0mNr5gzSF0WDqi4EGwup6lNQeBhbaKAgVF+4BD4ErUx3/fiDWRhLta9y+2YOVi2vClk945InOS4r86U9jY5pvxO1LTZKOsqHgwL10GAmF7r9LB9jpBdIRae0do+faTAVS8htsfWSfYE4oIeRBfLXaWA8yU=
X-Forefront-Antispam-Report: CIP:203.18.50.13; CTRY:HK; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:hkhybrid02.nvidia.com; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(40470700001)(16526019)(186003)(82310400004)(426003)(8936002)(7636003)(107886003)(316002)(2906002)(336012)(2616005)(508600001)(54906003)(36756003)(36860700001)(8676002)(70206006)(26005)(1076003)(4744005)(7696005)(4326008)(70586007)(86362001)(40460700001)(83380400001)(34020700004)(356005)(47076005)(5660300002)(110136005);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2021 11:22:18.0297 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0297a512-00e8-444e-45ec-08d9bbcf53a0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[203.18.50.13];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT055.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5232
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211210_032220_472532_61425F5D 
X-CRM114-Status: UNSURE (   8.59  )
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

Add KConfig menu option to enable and disable gencounter debug
feature that uses config NVME_DEBUG_USE_CID_GENCTR. 

Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
---
 drivers/nvme/host/Kconfig | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/nvme/host/Kconfig b/drivers/nvme/host/Kconfig
index dc0450ca23a3..dfa2609b7006 100644
--- a/drivers/nvme/host/Kconfig
+++ b/drivers/nvme/host/Kconfig
@@ -1,4 +1,14 @@
 # SPDX-License-Identifier: GPL-2.0-only
+menu "Debug (Enable driver debug features)"
+config NVME_DEBUG_USE_CID_GENCTR
+	bool "Enable command ID gen counter for spurious request completion"
+	depends on NVME_CORE
+	help
+	  The NVM Express driver will use generation conunter
+	  when calculating the command id. This is needed to debug the
+	  spurious request completions coming from a buggy controller.
+endmenu
+
 config NVME_CORE
 	tristate
 	select BLK_DEV_INTEGRITY_T10 if BLK_DEV_INTEGRITY
-- 
2.29.0


