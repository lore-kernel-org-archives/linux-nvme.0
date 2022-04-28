Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6475DC433F5
	for <linux-nvme@archiver.kernel.org>; Thu, 28 Apr 2022 09:19:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=2zEbb5QV4VcFq0XqXbinnJK5Ws8RURkiBP3Gz3Kpj1c=; b=mX1aR/ruf0K33HFMimS7zMWB+J
	RCmIPGYWkL0A0YgGonndN9Jk5xwFHBCrJ6kETvkG5+e4fSHiv+iljh9pGIaeXmwb5nlk1ZEzf99rH
	F4O2vv/GoQNbgYDRv9Utcvjzfy6AH9CqmtGZyEbh8rCiRdMkjyH5ul4OKRCv9W4qE/5Mf4+dPA2KP
	EaBTL1dLeHbrWoUiaWIv/EGnkHSeVj0dnWr6XpW/rLzq1yXVGZpJSZmhOFJZ4qOAIhmqxSLV3pw0W
	SR2pe9TfhIzAb7ngq0oDlFiNE5E9jJxUhzXfuDKn1OAy40uASoA76le2wALgCAbpWLuwzfozG8Itr
	PaRKjE+Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nk0JR-005fVp-8X; Thu, 28 Apr 2022 09:19:49 +0000
Received: from mail-mw2nam12on2062d.outbound.protection.outlook.com
 ([2a01:111:f400:fe5a::62d]
 helo=NAM12-MW2-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nk0JN-005fT0-4z
 for linux-nvme@lists.infradead.org; Thu, 28 Apr 2022 09:19:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ow53EIg63fN/tk9WnCm/XPXy210FW81IRkyQR0MBo8wdgKpJnwA8fc6OFw54PFAjxfjkwRSpz8wj/Z8W1kQYDxe6yxpKnwVhMYHvAZkJVTMhwbaZpqLtSJ+CW5t2NRPmDu5quM5+gFp6QvqhdfVdERBLUbFCVpFljsK5TWYlg2p1L2XEmXXfqc5VErd0r05cr5W9tf78tKMv6XsawyUzqCrstyKZFloVM8KckdyQuiN2DAVLrxj5hIxA53DIuBzxZU6cxJGEMAQedIty2ixYDMmgO6G6N1qKQbGHvCMO86JHuQRSUJYarv4UXfcnOQBHpIlflf5lLUdbkI7nJdmhQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2zEbb5QV4VcFq0XqXbinnJK5Ws8RURkiBP3Gz3Kpj1c=;
 b=LE9XR8p20oP+2Bq8H/XUsCahFujHka63KKWpDDKl3uRlLKV5OkfkxZN1ZMqF+ApUfTH2jgW+ciH5nhvXl9EyMLXhPFF8TAM7yALc5aoh6ItbB2nXK9oCywq0s7Ei4CcsGZ2oVcydocfbE/A65mBNG8VGVzRnMOYu4EZgs6PXuP2r2rWb6/s9o1UhMbZIE8k7UUaE/74Rc8/w0ZxxscnMvHboWPsvjQp7/GNmd/9tca5UOOaoK3usgo/+KGoiJUOs7dVh+IkVB/pci6Lz1+15LZ0qsF/OQWvf6h7k4EKG1UH/0D7KoPW0FLRanhUgI/XyPyARUOICz5F0qhzfscp00A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.236) smtp.rcpttodomain=grimberg.me smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2zEbb5QV4VcFq0XqXbinnJK5Ws8RURkiBP3Gz3Kpj1c=;
 b=EjQeME1j1OHA1M9Bo8ruIzO/1yHRbIyT4gljf/ImI8+hHyw2yJG1CwkeYCBuDj1+KDoL1tMk9ixIOPAlL5DVEmK2CEVsaOLU4HzM5/aI5XlWwsme1ZseRtsRCv5Z9jpJuXyks/s6XB2OdNGezoOt4CuVy80FxsbBzJ6QNeQ/ceZyAEo/5B7EXoSS3PTmO6bFObfsFnJ7X6kL1nZP7vCcAnTATA01Y0IaPl2mG8pMEv774uMRfA4Bv3S+nlrr72eydx5hQ5OZzegc60FC5KpPuM0xMLGE77qplU2XzPYCnsd9sMNZkS0220hnySgKw3KpsMFKWon6ydZFxku93b2C0A==
Received: from BN9PR03CA0894.namprd03.prod.outlook.com (2603:10b6:408:13c::29)
 by DM6PR12MB4107.namprd12.prod.outlook.com (2603:10b6:5:218::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14; Thu, 28 Apr
 2022 09:19:40 +0000
Received: from BN8NAM11FT014.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13c:cafe::d2) by BN9PR03CA0894.outlook.office365.com
 (2603:10b6:408:13c::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.23 via Frontend
 Transport; Thu, 28 Apr 2022 09:19:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.236)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.236 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.236; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.236) by
 BN8NAM11FT014.mail.protection.outlook.com (10.13.177.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5206.12 via Frontend Transport; Thu, 28 Apr 2022 09:19:40 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by DRHQMAIL109.nvidia.com
 (10.27.9.19) with Microsoft SMTP Server (TLS) id 15.0.1497.32;
 Thu, 28 Apr 2022 09:19:38 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Thu, 28 Apr
 2022 02:19:37 -0700
Received: from r-arch-stor04.mtr.labs.mlnx (10.127.8.10) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.986.22 via Frontend
 Transport; Thu, 28 Apr 2022 02:19:36 -0700
From: Max Gurtovoy <mgurtovoy@nvidia.com>
To: <hch@lst.de>, <linux-nvme@lists.infradead.org>, <sagi@grimberg.me>,
 <kbusch@kernel.org>, <kch@nvidia.com>
CC: Max Gurtovoy <mgurtovoy@nvidia.com>
Subject: [PATCH 1/2] nvme: add missing path related status values
Date: Thu, 28 Apr 2022 12:19:34 +0300
Message-ID: <20220428091935.35651-1-mgurtovoy@nvidia.com>
X-Mailer: git-send-email 2.18.2
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2510bea2-3b33-4647-89c6-08da28f83926
X-MS-TrafficTypeDiagnostic: DM6PR12MB4107:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB410755AE745A7F6328DC3AD3DEFD9@DM6PR12MB4107.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zhWAyKdNG28MUQt1fRtBJSjk09Flomdbrub5HJLC1+lhBmrL/IkyvY6GgqdIKuGldqXAGyh3eJYwUr8tWRtGh6rCt8OS1FGLm8ZvNYAJa8DBmywOXFjnu9YeuptW9q9A2EPcFet7/qLZFzSgdzNbNIBUoNYAyMTXZs+K2vK4OD616/laJWUHLQmxQxZeMCCSwjC7dVEOfbDgzr1B0WZBSJ868WLOf7jQv6kffTJmsZFz+7ZZSVMA/qQ5sjrqeg8rhCeNcG81iURciGxqwg+X2vTH1ojtm+6B8V4d5Pz/dI46ZikTjmvbd/sWIQcRFboMHg/I/W9EO2CtG2rTy1ixkTFSqA2iO4Te7R9l7xrjp0L5tj1Z6mXvHNu7334ryhfDR7bs/RY9Dynbwa3HARPyCfpV9AqFLPK3niEPiBx1mcCgOIxdT+//BrvMd5Qz17EbAQ3A7GCzemcs+P0QQ/P2OOAGwfrF7zq+Y0RE/ten5aQ6OOGNfAALAKHdlokOJHtHylccQDA4Vw3ZCVm1eMaIWmRGYrWWO4XGWu6Jelh5W/Ois5TnhMzu6RPifDNy93XEoGvxNAlh+pfcfF3lvY1LHmIalc5WIgoJm6W40Lsz25FPx5MTe7a/MwGXF5xJ/dSJh18Hn3cA9rcCVwCg6gXcA/4exi9Kicq7GthvkRtebut3yYVDsN3eekDs0kjicbPz8sO+lMsRy0dcw/rVOFHQBJWrAPBzQPzE4QNvrx67UAE=
X-Forefront-Antispam-Report: CIP:12.22.5.236; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:InfoNoRecords; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(70586007)(70206006)(4326008)(47076005)(8936002)(86362001)(186003)(8676002)(508600001)(4744005)(36860700001)(336012)(40460700003)(5660300002)(2616005)(426003)(26005)(81166007)(107886003)(356005)(2906002)(82310400005)(6636002)(36756003)(110136005)(83380400001)(1076003)(316002)(36900700001)(2101003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2022 09:19:40.0455 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2510bea2-3b33-4647-89c6-08da28f83926
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[12.22.5.236];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT014.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4107
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220428_021945_228775_AFE13C83 
X-CRM114-Status: UNSURE (   7.49  )
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

The following path related status code from the NVM specification were
added: Internal Path Error (00h) and Controller Pathing Error (60h).

Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
---
 include/linux/nvme.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index f626a445d1a8..bbabdc7600da 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -1679,9 +1679,11 @@ enum {
 	/*
 	 * Path-related Errors:
 	 */
+	NVME_SC_INTERNAL_PATH_ERROR	= 0x300,
 	NVME_SC_ANA_PERSISTENT_LOSS	= 0x301,
 	NVME_SC_ANA_INACCESSIBLE	= 0x302,
 	NVME_SC_ANA_TRANSITION		= 0x303,
+	NVME_SC_CTRL_PATH_ERROR		= 0x360,
 	NVME_SC_HOST_PATH_ERROR		= 0x370,
 	NVME_SC_HOST_ABORTED_CMD	= 0x371,
 
-- 
2.18.2


