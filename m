Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1279CC46CCD
	for <linux-nvme@archiver.kernel.org>; Wed, 20 Dec 2023 09:28:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=z/5Vv/FnzIbrXqzsSU43SZ6dEUv0n+rz/bkhMjNZLwc=; b=b1RTSbIvvsnnMH87zz96PNYS/f
	gJEz5f9oiutN+h8YTH3cRGTbS69o9OPoq0lL2INDmP0CjN1Inye6DpbxnAciciWmSeL1ULNrSORNK
	WUvZjO+rLi0sBTYpfL/QvJa6d9Q6+aMrUumlBrDVpLOd2DE7nqptZrFchaiqn619PXEick0pxaT+A
	6+7tQHQcWgdTGgyAYaGB5OBAhbVu8sdvP7JyntH4avvRXL5lSnRI9U+Cmn9EqKvJIRHUR5g96h1SW
	8u1n4ygzEldNFanBBKrhugV/nIlq3bkpjNuRlApb8EmYGdlZ/VgQ2grp1SWQjqRrd9wCaMmmi9bcE
	jOnGa4Fg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rFssB-00Gk2s-0D;
	Wed, 20 Dec 2023 09:28:15 +0000
Received: from mail-bn7nam10on20601.outbound.protection.outlook.com ([2a01:111:f403:2009::601] helo=NAM10-BN7-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rFss7-00Gk2C-1I
	for linux-nvme@lists.infradead.org;
	Wed, 20 Dec 2023 09:28:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ToRzqjouKtKRz8u0VYuCzMbAWMOizbz4wmp2hMIVR9XjeS+dcEIdfc9r4gszc0SBR/PPQk7HTFDTzipm2iMSxEcY3Xcwi5lWUECRUljyl6j/iVOmgH4Bcm16+10Of5WkjXcrqYWPSRUMk3RHx7ea8su0dv91yXXiJXsBjlYRkxCiOiXPJk4Yct3NNPIvOKixiqHJMf6V6ofy+6k/Xf+KDdEFzP3NOXzp2UmB2RxxrP5S+21kXKC6OEDTq6IOKP3Jzx/83P/hhkSCpGSQ8OS80/RlcxAK2FM2DrWGKc51eCsMqtHJ0TZxOG+g/t+q5dkHV72/w2/HlYYk8CGZcz/ezQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z/5Vv/FnzIbrXqzsSU43SZ6dEUv0n+rz/bkhMjNZLwc=;
 b=KAjcf/3N4YqvS6C+x4bcE2pmoyp+95cXOnZKRJKnsAazCeLz5M8aqZ7N5h5OKM9wA3SfTStmefXO7GvkAJx1ujIWiBIq/3kHZkI0fgfWQQwQxw8Q2SGL4Z8/0yx1UzdENHJVVWq/ra3bCVgxE/HgKi0OQi2w7a+JhQIaBJsaLYnE0sfMEyXKVNp8ydJ+mfpanZPKhCdtIzvripEMYMRJwlkTH4d23IWIgXQZPJJloOwC5rOp16CW0cJCx+7hK+qaiuIbrxrv57B5joC8m0KdoD7rqAWSDCV3m3kCARE3GPQ1ZXf90drGH8hKBAUTGsplZJ3Qr+UJkRkh/pH2WeX1Hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=suse.de smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z/5Vv/FnzIbrXqzsSU43SZ6dEUv0n+rz/bkhMjNZLwc=;
 b=B2S0EL5V4IfKHIR4KFA98Iqtmof46KcasZjTVzZbdcP6TOrZ+y3RoCjSU7GSWR/gJUX9sJhsYCWDT3/Wq1Hoedi2hS3WrFE+cdNaT+gmqWrVe3Uo106s5nA5eLxTab/yfUl6k1an4hqFtuE7X5RdKTk8iy7HunJPid5vmw/IWte/6xiaY5MTnEKs0Uxiw+Ap2PV5otv/XlShgMCJGwoU98Kngg3tjHmvAU5QfbaH1hyQV46rg/6/0jL4kN4qM705IhMwwpxJkfuKKSSzfROjWC3Aqekv3+EZuma2Q2UiFeoiKHynw9MABgaLKbeJDl/s9RERx5m3QPLnucFXWjJVeQ==
Received: from BL1PR13CA0286.namprd13.prod.outlook.com (2603:10b6:208:2bc::21)
 by PH8PR12MB7254.namprd12.prod.outlook.com (2603:10b6:510:225::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.18; Wed, 20 Dec
 2023 09:28:04 +0000
Received: from BL02EPF0001A0FE.namprd03.prod.outlook.com
 (2603:10b6:208:2bc:cafe::4b) by BL1PR13CA0286.outlook.office365.com
 (2603:10b6:208:2bc::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.18 via Frontend
 Transport; Wed, 20 Dec 2023 09:28:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL02EPF0001A0FE.mail.protection.outlook.com (10.167.242.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7113.14 via Frontend Transport; Wed, 20 Dec 2023 09:28:03 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 20 Dec
 2023 01:27:48 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 20 Dec
 2023 01:27:47 -0800
Received: from r-arch-stor03.mtr.labs.mlnx (10.127.8.14) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.986.41 via Frontend
 Transport; Wed, 20 Dec 2023 01:27:45 -0800
From: Max Gurtovoy <mgurtovoy@nvidia.com>
To: <dwagner@suse.de>, <kbusch@kernel.org>, <hch@lst.de>, <sagi@grimberg.me>,
	<linux-nvme@lists.infradead.org>
CC: <oren@nvdia.com>, Max Gurtovoy <mgurtovoy@nvidia.com>
Subject: [PATCH 1/1] nvme-fabrics: don't check ioccsz/iorcsz for discovery
Date: Wed, 20 Dec 2023 11:27:45 +0200
Message-ID: <20231220092745.35325-1-mgurtovoy@nvidia.com>
X-Mailer: git-send-email 2.18.1
MIME-Version: 1.0
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FE:EE_|PH8PR12MB7254:EE_
X-MS-Office365-Filtering-Correlation-Id: 60c32ed3-1723-4298-cdd1-08dc013df765
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gjQ5v/fRu7E1X52sfhetHY2BJqepylb5o9BybLn3nV52JMPuh904A78INsNWCGjZBa+jZ+0tNa+YxjB3kZfaJePjsbd7ikoXZ3f+pOeThvdipM4mrOLLjr8srgnx1LZ1p4JtJKuQ8Of3Eo7ltXKA/KWHiY023nX89Zi1NUD0wXGV7IwEKVApDAfYQ0e8bhXOnWdvBF6lck72Dopk2Z5Z+ctHpZrFvq8y6FhpVjNhu0RF3Ywrqb6B6iwQMw1ogS9PYcORqphTMlM9t4z/no60uwBNk7XxE9fs2NI3TySi5Xh8YguLvu9MqIHbhDez8uNa48V/olxV6DuVQ1JRLt1kDibnd6eiX9oFGTUroCy3upXtDVwaC0xYZK1sIoLox/06m1FBDjg8d8sR9W1x2MfyhhD7gLNuqbUeovScOkz/TesZ06pbVNxqG159rJr/c/y9gmfFW0dIJNT05GiKPRQvspaRVFLwpGAgP1mu3lL6x3D28ifCtyy/dRaT7hkybe4r38+Jqs6be+NsCAhiA+0AhP2sgIyNvSrsG8F30y0Pnw7r5+/wMNeN/nZ+exhmUaE9IhXrRL6mtwNu4NpdjSL1bBmsDeDAgYIAVZjjBoSSCi6AlFkY2xjBfIb9s2GtRdvmesE6Nn/a3jzabJtb8DaWEf9GqDgDZp9G8LEFBQceGvhc3pPpsFOhxVvITCgaMzJIPwtfxPf0XLRGMwpaGMIeewRoort0l/+m819r8+KaKudTbuGd0/lQDCLE0lQalxo0
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(346002)(39860400002)(376002)(136003)(396003)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(82310400011)(46966006)(40470700004)(36840700001)(2616005)(83380400001)(336012)(426003)(107886003)(1076003)(26005)(86362001)(36756003)(4326008)(8676002)(8936002)(41300700001)(2906002)(5660300002)(110136005)(70586007)(316002)(54906003)(70206006)(478600001)(7636003)(47076005)(82740400003)(36860700001)(356005)(40480700001)(40460700003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2023 09:28:03.3013
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 60c32ed3-1723-4298-cdd1-08dc013df765
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0FE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7254
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231220_012811_641161_C6BC906C 
X-CRM114-Status: UNSURE (   9.46  )
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

IOCCSZ and IORCSZ are reserved for discovery controllers. Avoid checking
their values during identify controller phase.

Fixes: 2fcd3ab39826 ("nvme-fabrics: check ioccsz and iorcsz")
Reported-by: Daniel Wagner <dwagner@suse.de>
Tested-by: Daniel Wagner <dwagner@suse.de>
Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
---
 drivers/nvme/host/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index ee2e4c49892d..b218ac88fcf8 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3068,14 +3068,14 @@ static int nvme_check_ctrl_fabric_info(struct nvme_ctrl *ctrl, struct nvme_id_ct
 		return -EINVAL;
 	}
 
-	if (ctrl->ioccsz < 4) {
+	if (!nvme_discovery_ctrl(ctrl) && ctrl->ioccsz < 4) {
 		dev_err(ctrl->device,
 			"I/O queue command capsule supported size %d < 4\n",
 			ctrl->ioccsz);
 		return -EINVAL;
 	}
 
-	if (ctrl->iorcsz < 1) {
+	if (!nvme_discovery_ctrl(ctrl) && ctrl->iorcsz < 1) {
 		dev_err(ctrl->device,
 			"I/O queue response capsule supported size %d < 1\n",
 			ctrl->iorcsz);
-- 
2.18.1


