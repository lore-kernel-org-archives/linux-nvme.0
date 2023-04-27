Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6072EC77B73
	for <linux-nvme@archiver.kernel.org>; Thu, 27 Apr 2023 08:02:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=GoMz/yC9tNi7EIP3YkBz3/WXide8XpiGNBSeWnCkYdY=; b=OqXUjYVBcpgaoU8p7Dbv+s+lNk
	74VnPEL/prGBPKW75m1+MIymIlo/H+sg0mprZJHso4tz18MJRGbBWzrGWvUuvm8ZC/FjsiceBtOHf
	4weAYNEo3ykV3Lx2Hyu7KKH0a9GyE1sco70NxWdd82qEXwjnD3sP1P+LswShGYKOUvdon0toca3m/
	ZN5FR8RFCjaW8E0saqVin4zHUoidqDerA6+xpckb8c2adLJ5j5bWTaFPldE4ybG/pPPBmhQTDErir
	p3az/DaGRLZjBU6iEq62x3/ZGtcT97e0Yo4xtO2nxNNQq8DWGYot8ICe9p1ecuEo8gOafe3mS71XL
	SFkgd5EQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1prwaW-005kxk-2x;
	Thu, 27 Apr 2023 08:02:48 +0000
Received: from mail-dm6nam11on2062c.outbound.protection.outlook.com ([2a01:111:f400:7eaa::62c] helo=NAM11-DM6-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1prwaS-005kvq-1u
	for linux-nvme@lists.infradead.org;
	Thu, 27 Apr 2023 08:02:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jQuuBItlSFL174+GvFFRVxSxqZm6mGEj99oPg+fHR4tdoR3GqNdWnfNUph/ON3s+zTcz5Q0buuM3jMpkFWJh/tSKZzWlfPQ/WG2tgL+6CFjSKohg9qGe4cgSKDlfEz9gQJpv3bFl+jq9DI363YEqqzctUizxRmfpwWOCKZFqZrZyaiazY/NnW6/LYK/p4PVsGZG2EbMplwoffSJ4axeMUc4JXQP3OVo0Wfn5EOZh74vMpSkqLQN14S67M4u9Nc+o/ByKXixgzezjNe0sP+/FYxY0sibd/kaeYKQ+l1Y5Xv6x1U1dA5Dgl0j5xyzE45g3mm8e1rymB2/EG/198w+94w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GoMz/yC9tNi7EIP3YkBz3/WXide8XpiGNBSeWnCkYdY=;
 b=ac/5RympJKHrJx4NNmC3FqXa87fWLnen4VeMC6ZQN5G8DbRWLOTj/tRUyucpYlUO30CrLXMnwhHy8fB4nOeamev1XNVcMScujtqy1ZaTtc7DuEZd9Phm/sWJRTyLVf2dMDjgIQF0g9aeoMCo+Jsp/EB6Yesar9NC+TV/aYuHAKC5eMqAE1rrlTmYr736YpDLttFXbRaslp0t34WsBgd7p13J43ynpHgTph74MK5j8hTCHUVdNwVbRvMbLpbAIJc/4RyK2jBfrjXcyLxIzw80fMNWGdPfzAf01uXGCuyI4WNd2hW19+y+RQoHV1q2c8qlhlLckwWYM11NWUB2wiLwIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=suse.de smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GoMz/yC9tNi7EIP3YkBz3/WXide8XpiGNBSeWnCkYdY=;
 b=V8Zscd/ZgjMfbcdsoTKFUClih5paLK0tImO7ZYN1lEALvQ8/oZmbB5be6tCAquke6nXdfMNIBMVRj2cd9A0ve88C948I4ZzQiTzpiIpRZjGzErcwS537DQMDxX3W1yARb0tz+rEoJQ7mUG7MJeV9Yo52jfYFDUuLwU74R96ZOnsno9xQ9tpwKhZ5I11ZODujbTlKbgZI+A0vnSwluKgOhq70bwhUHVTvLsdx5dZVBEcbIkuLIIw6SLqNrmiOSNeeUWNPH+USTWyg/T0gVt1a8CfUykRbjSQPazaU1IiTyBwt61CAeQVGK/xuir9KhJYKLbqeOJoYY+5do+dgF42sdQ==
Received: from BLAPR03CA0130.namprd03.prod.outlook.com (2603:10b6:208:32e::15)
 by CY5PR12MB6645.namprd12.prod.outlook.com (2603:10b6:930:42::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.20; Thu, 27 Apr
 2023 08:02:39 +0000
Received: from BL02EPF0000C405.namprd05.prod.outlook.com
 (2603:10b6:208:32e:cafe::85) by BLAPR03CA0130.outlook.office365.com
 (2603:10b6:208:32e::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.22 via Frontend
 Transport; Thu, 27 Apr 2023 08:02:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL02EPF0000C405.mail.protection.outlook.com (10.167.241.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6340.15 via Frontend Transport; Thu, 27 Apr 2023 08:02:39 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Thu, 27 Apr 2023
 01:02:15 -0700
Received: from dev.nvidia.com (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Thu, 27 Apr
 2023 01:02:15 -0700
From: Chaitanya Kulkarni <kch@nvidia.com>
To: <hare@suse.de>
CC: <kbusch@kernel.org>, <hch@lst.de>, <sagi@grimberg.me>,
	<linux-nvme@lists.infradead.org>, Chaitanya Kulkarni <kch@nvidia.com>
Subject: [RFC COMPILE ONLY PATCH 0/2] nvme-core: dhchap_secret code cleanup
Date: Thu, 27 Apr 2023 01:02:05 -0700
Message-ID: <20230427080207.17249-1-kch@nvidia.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.37]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0000C405:EE_|CY5PR12MB6645:EE_
X-MS-Office365-Filtering-Correlation-Id: 2dac52f3-82cd-406f-2431-08db46f5c567
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 	7sia0CyMXCoFr8i5SFmyqMgtu8QVyso6wZ6L4D6OPgLsMHjmtr6GBWOx/cF+AhSHbtuyCce6co0K/9rFwp4qmyoz9p8L9afYC6pfVb7b3+f9AASE+t6zIC2pDM8R7XerCqTNPm6QGhw5UwQ+CKTJH2nGian0OgM5id6muelmql0oRCavq2L+pzras7zUwoNqrDEwzD2DdCgHiHCUbVBm01Q/2nUiZl/OqPnKFHn0vWW/qvdtB523Av6swHOSF6vEprMJIFimx97WOTlGVwGyIne6B7p7iA5xhKQJIxHkRalLZDm9lfFZ3DzmCDucBVf/oiWB8qlBrCh6XSXwF9b8gRLAZtJHzp0jcwy8BF2fhtCF/6vc+h52ypFsGMh6DUyVNKswuH/vKZq7cUEbZfRevlhuygnkpE6x/pXY+gKWbAQBazpgBYaelS6FuMTopf/+jOBjDFrEWkzdw3mZnacvZ8AgEzzXpW+xd1EbWi4RI5ZFtFRKk4MrMUzQm3xD4ep7xy2MPiLTncZ9jizz9mlpPE4fZZC6UgloFe14MCShQeHmfwYOzHWn+Vyx/GCa2LY5S5eo+JtPlu9BjFgkKo/PJEWFSboNqu+UbqcHWkJM4/P2zpqe09o4uzKq4LdCXW+dL/tmrtxAo5AynYnU04op8QPLFOM75PKay1Csn32vDUVOhiamZyJnDXHfoJ7d3fztVkWjJqTiTsipwbTfFqkiNsVPOUtPm5BGfKPy2depkZ4=
X-Forefront-Antispam-Report: 	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(396003)(346002)(376002)(451199021)(36840700001)(40470700004)(46966006)(6666004)(36860700001)(40460700003)(356005)(7636003)(36756003)(5660300002)(8676002)(4744005)(8936002)(40480700001)(316002)(41300700001)(2906002)(82310400005)(6916009)(4326008)(70586007)(82740400003)(70206006)(426003)(107886003)(83380400001)(47076005)(336012)(186003)(54906003)(16526019)(26005)(7696005)(1076003)(478600001)(2616005)(219293001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2023 08:02:39.3829
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2dac52f3-82cd-406f-2431-08db46f5c567
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: 	BL02EPF0000C405.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6645
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230427_010244_711760_A10AB3B9 
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

Hi,

Marking it compile only RFC since blktests are failing on current
nvme-6.4 so I was not able to complete the testing.

Bunch of code is repeated all over when defining nvme_ctrl_dhchap_secret
and nvme_ctrl_dhchap_ctrl_secret. Factor out a common function for
nvme_ctrl_secret_dhchap_store() and nvme_ctrl_secret_dhchap_ctrl_store()
into common function nvme_dhchap_secret_store_common().

Add a macro to define device attr in order to remove code duplication
for above mentioned attributes.

No functional changes in this patch-series.

-ck

Chaitanya Kulkarni (2):
  nvme-core: factor out common code into helper
  nvme-core: use macro defination to define dev attr

 drivers/nvme/host/core.c | 128 ++++++++++++++-------------------------
 1 file changed, 44 insertions(+), 84 deletions(-)

-- 
2.40.0


