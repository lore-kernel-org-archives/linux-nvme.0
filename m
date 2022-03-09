Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18254C433F5
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Mar 2022 05:59:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=pOfzz+DY55YG5upP0ZzNYmecvu5kt1f2kLk9mvVnZjQ=; b=F2b8AbjS3HV/kfQUdUUF7ceRqu
	hSDhG4oz22oxv9WaOif8wvDGQae5qDMakb8wTLgpLONaLJYmdYpULYaY4bYCVLaCTDpnTR0Xkt2TL
	z4HXzvEqCbYcy/QLYDZ1+WMxpyeoI2TJRqNMy84tQBbfrBixSS/3zGMlbbqZt5FafShH5Yg0caTvf
	1yLWEeBiCETsnBVMy40JAhgv5RhcFKuZ49ffK+OtAHwkn0xWb8j5e4MnjRblHR7yYzI/7TskOH/1b
	N19RmMWkidqaTvKiz3LH8JdkZ9MynrPI6Bk3ITDzuiAY+yYISpIgeRzAoyy9hceF5bqNSEubtoOdM
	3utppH3A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nRpMR-007PKP-JJ; Wed, 09 Mar 2022 05:59:47 +0000
Received: from mail-bn8nam12on20617.outbound.protection.outlook.com
 ([2a01:111:f400:fe5b::617]
 helo=NAM12-BN8-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nRpMP-007PJM-0k
 for linux-nvme@lists.infradead.org; Wed, 09 Mar 2022 05:59:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X7DSrzggUBX9+INvcAkl26AwFwGT3C3nkYaBKArc1OkuMysqxyny9qpr3g1RAZPCqI7OtBFHFnG2neq7gknpNNehBKRTecBtrLqMyDzX2b6GIsiyWm8tfvBFc4a+wqFU7/DtRIArv5hxfZ7/MnFFwKZ2sGokbfQAQhK62QOcwlmXytMoJgNMy33Ur+UELvTQfIfzQ8V/YaD1VI7hjUPz0+n/63dtJKCu66pLeWET9IN49Dl6EjqCO7yYoooULqEY5Gs/n0hMdpVlDY1rC7qNN9gsWb1PfvnWQO84RQnmKMiK72aD+ulXkRQj4pfkXldD0mR93TroXUK1QXNJA7ud/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pOfzz+DY55YG5upP0ZzNYmecvu5kt1f2kLk9mvVnZjQ=;
 b=aBIv32BvtjNIooVWhmu+UnoQudXUOnOmaoWx4nKo+j9QAlDPBtdb4nrNjDxNzKsWrk7uIyecOGfLCbYAZkTQTJEpq5BPPS60+bT3Jb//YPWJkgCm05n5Lv6xFdsx8FpsKaq6jgzFI0CpyTj6P9CS3MId23Wj1GqYwFlIWibtyoQk10/rOrBah1mbfAwKC3PAGkFPMAl0dMC+CYb65xgfV3y1QrwYuHA+6ZnybJ4rHGn3PNsWNB02zXHavFIQxb/UPtcLrbuIBZI1hW3ZViMCya1JwYlAS5kRjZiGG5zL8d2qf90xOkiGNocBGQnEyjHRyhJ9aP6a1nfNVAW7uOiM1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.234) smtp.rcpttodomain=grimberg.me smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pOfzz+DY55YG5upP0ZzNYmecvu5kt1f2kLk9mvVnZjQ=;
 b=MMZKgWGP5Mo6NAHQEIzwsRWMiLxQnvCLs2/wED3/JQ2wk36M2W6r9pYLrWFo3807nRpLsyBTNkHNZ3cKOYP3O4BuEgmTXRekOvXmomaGrn7eSTDhq7RLBsQTfQdbgQ4CAoQ9XtS5eN9oZV59c6mit/FvnamZ8xboEGZYWR2Fttlj0B5zOW6fwV4V3x/gCn1NZqGmbrnsU+j2kBvUazCSBBS+V1JfZzWCgQF8uelTs5KgQORpdAB3UHClAChTk6I2qq0IlFy/bezHHFbCbSyCNjICq2qRiIm5GKCy5GF5BW9qNwPUGlJhsGFQEXFo/a+h715+dEzrZm0+0UYuTG75DA==
Received: from BN9PR03CA0941.namprd03.prod.outlook.com (2603:10b6:408:108::16)
 by PH7PR12MB5712.namprd12.prod.outlook.com (2603:10b6:510:1e3::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.15; Wed, 9 Mar
 2022 05:59:40 +0000
Received: from BN8NAM11FT048.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:108:cafe::8f) by BN9PR03CA0941.outlook.office365.com
 (2603:10b6:408:108::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14 via Frontend
 Transport; Wed, 9 Mar 2022 05:59:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.234)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.234 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.234; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.234) by
 BN8NAM11FT048.mail.protection.outlook.com (10.13.177.117) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5038.14 via Frontend Transport; Wed, 9 Mar 2022 05:59:39 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by DRHQMAIL101.nvidia.com
 (10.27.9.10) with Microsoft SMTP Server (TLS) id 15.0.1497.18;
 Wed, 9 Mar 2022 05:59:38 +0000
Received: from dev.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.9; Tue, 8 Mar 2022
 21:59:37 -0800
From: Chaitanya Kulkarni <kch@nvidia.com>
To: <linux-nvme@lists.infradead.org>
CC: <hch@lst.de>, <sagi@grimberg.me>, <axboe@kernel.dk>, Chaitanya Kulkarni
 <kch@nvidia.com>
Subject: [V2 0/3] nvmet: fix kernel-doc warnings
Date: Tue, 8 Mar 2022 21:59:24 -0800
Message-ID: <20220309055927.11267-1-kch@nvidia.com>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f010dfec-16d0-48d1-0e74-08da0191ffab
X-MS-TrafficTypeDiagnostic: PH7PR12MB5712:EE_
X-Microsoft-Antispam-PRVS: <PH7PR12MB5712D944C23E675039E38B0FA30A9@PH7PR12MB5712.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vE50eR6q0JN9vK1LUeup30exTK6ZDvbgY/3NT8VL6QbJF3F45OP9xK331SXlsQ/V5VXqzl6gV+WOi6oQrOYiXqY7ZAiy7/GsWA0ZswMroWlyW+zDN2WLsXKoWO0QuJihLwLw3ygyfl/OdFSxYjDd9vkEpeWlfcBzqgZtfGtg1QwGZNUBDEQKhWpIMPj5J8JtW1bGjuIWTIKYGD5Bm0stTFE7jO5lslHxYSUtw+xvZ3/qn/MlCJNWWUu1vuHzAwk9St2eOroBmoVKt0rgeVi4KkxBWnSvYc5vTNQ0V7fURGKtE7JAX7KyMzoU2sKINTiR55Ckd9oP70U3amj5f3sXFm0WcPB7ErSMQ38CI3/XqFSXLmOm+JZVV1ks5HZIFTO8vl0wWL662b9UqEuHU/QTVpHb47XChkfP31BETd5hRFu851bvYlgvClPzr52v47/Eb84PtbdQO+5oNDNYuTZX2JUGu8qQtxzxY9x1dVUcMdqrj3u+sdgU531Jeso16OnsTAyd2bmTZfmQuwOA0Awx0LDGtCTInEo4uCqPW+C2aByzoRVWGALIXbQgAECO7cbP9a7LpJOAVlHLJR/ns95zKA/lTPE/OZFd7Qq7qK3zmg0aJM9UIFH0G+R7hqhzU6Oq+Jz47Gfd6As3tA8laAMzQgO1psfk74dC4/SjiC+7EbYaAc9TQaxffBTWaXr9Q6GoShHxFskpVkmWS+9JnYXzuA==
X-Forefront-Antispam-Report: CIP:12.22.5.234; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:mail.nvidia.com; PTR:InfoNoRecords; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(356005)(6916009)(54906003)(81166007)(426003)(70206006)(8676002)(1076003)(70586007)(2906002)(40460700003)(36860700001)(47076005)(36756003)(316002)(2616005)(5660300002)(336012)(83380400001)(16526019)(26005)(82310400004)(8936002)(186003)(4744005)(4326008)(7696005)(107886003)(6666004)(508600001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2022 05:59:39.5757 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f010dfec-16d0-48d1-0e74-08da0191ffab
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[12.22.5.234];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT048.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5712
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220308_215945_279870_EAA21152 
X-CRM114-Status: UNSURE (   7.01  )
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

Fixes for kernel-doc warning for target.

-ck

V1 -> V2:-

1. Replace "compilation" with "kernel-doc" in commit message. (Jens)

Chaitanya Kulkarni (3):
  nvmet-fc: fix kernel-doc warning for register
  nvmet-fc: fix kernel-doc warning for unregitser
  nvmet-rdma: fix kernel-doc warning

 drivers/nvme/target/fc.c   | 4 ++--
 drivers/nvme/target/rdma.c | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

-- 
2.29.0


