Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97548C433EF
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Mar 2022 23:15:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=XoDLpHAL4H0O0cfyuEdTc9ik5fYDlMCteQwQOvQf4c8=; b=luEv+H9liFkJABG2TcS4aEbs6x
	ecpqlUA/WoNBNOQlG1ok55hxvzb6Kx0fLxZ9EscQxLuFUFUnVMInIU0uBw22/J9V7Mm8E7zqExelF
	mIXBaXfTWvv+5H89zEjo3qra2jjmdyPFqQe8j/jLEEGjTTvHks/BwgOlOTl+jSx4qaWfFpBe2Se4f
	VgQIjf1MBHgrK/JRgc/5EQJDYEbeUPDFrBpNG9RpH3CJscueevBmFMdjzu3kh/S2FDHD8TNyqsHiJ
	R/BuVHTq39VxQOJbQNSMT5kyF9SwPJ2QTTUkT2CEU8QMD4TvnNICz99eCyYoa4tEN/togNSx7rwnp
	2WZVcFqw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nRj3U-006WHg-D1; Tue, 08 Mar 2022 23:15:48 +0000
Received: from mail-bn8nam12on20600.outbound.protection.outlook.com
 ([2a01:111:f400:fe5b::600]
 helo=NAM12-BN8-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nRj3R-006WGN-BQ
 for linux-nvme@lists.infradead.org; Tue, 08 Mar 2022 23:15:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nRYfbb37xwZh5OxdqPPFKQtU8BRLcWkejGIBBUMEWbGWzTsVimSC46G4b7KDu+h4rjy+tsEKC+3uy9CBbFVgrdUDOyl5qqvE/CCVE+1qh6CQs46yiYy4OmIM/YqJOVguFCVt+bOXl0B2vyTJJ5iBfayT1eOgQmEJdm1llhTJTYZ4csoOu6IMe0lVp9uLCqlnZNWsPkQixz9SsWXwEFYxUf8A3BjpR2G91MobuikttqUe5K2pyfL3uB7/gzWWkmWtOxKBjaLXnk0+ySmUZG7orkiUcfB0xi/aIrW8tyst89xW5oP+VpME8CE0k2ELpm1CUrNQ3ThAGLZqzsVFRcbjoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XoDLpHAL4H0O0cfyuEdTc9ik5fYDlMCteQwQOvQf4c8=;
 b=EFiiHDwFEuBGRXnaALL0ExW6D1PyXz91rUpfWxXxi/t/wRNJu9AeJcc9+iEMscgYTwfZhQYmpiVBWYjBD5e/NUL/fPdErMnIjPjcsIjScBz1uR2rPovbfKyjK4eYTbRnTjDt4fhr375Evt5T+BLAquO7MB2SSuXfIVpCwsMApYiDIdfO2jcJddoKsorEm4EUdY44bt/pqIF17mcmbu5UBoSvHp2camvTQN2/3nsAcSFHkdVe+Pcfg1el5Bg2f1xOoSd9X4tDlI8UQFmGusnxseT2RO3ImVlOZgEDKlWmlWly2KBEDiLFvhiiklYrz7uMJsffiBC+Ook9OhekZLNeMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.235) smtp.rcpttodomain=grimberg.me smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XoDLpHAL4H0O0cfyuEdTc9ik5fYDlMCteQwQOvQf4c8=;
 b=XEKXbtm3UQRcXwQnInlhPYZIKAikXoHUdKMdRodgO/5+wFEngIc+zdAcHpBqigJGK1pVJBI9vdojpDxK5wmPC90GtoQjo26tdiuDfxice8zzQrEJjWzcPnPPKU6kk0liZWHANBcZsDbwrl5C8w0WrNtG4xX/Ft4J7JKh7KOa/gzjY4pXnguiD+cFjFg5FUNKn/YSxug3a7MU+RROovMVAnmE853KJo22FH4fIqcDFSeXgfD4UH0PQkhqZge/u7XgbdMWYrGwfMdxhRvnqUa6gqnyWdUcJ3n1CbtoQn2OQbYG9d6NcBjiCYzfMrGa0N6S7JZa46CwzHrh+98VrHXXow==
Received: from BN0PR07CA0001.namprd07.prod.outlook.com (2603:10b6:408:141::12)
 by MN0PR12MB5930.namprd12.prod.outlook.com (2603:10b6:208:37d::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.15; Tue, 8 Mar
 2022 23:01:36 +0000
Received: from BN8NAM11FT006.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:141:cafe::9f) by BN0PR07CA0001.outlook.office365.com
 (2603:10b6:408:141::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14 via Frontend
 Transport; Tue, 8 Mar 2022 23:01:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.235)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.235 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.235; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.235) by
 BN8NAM11FT006.mail.protection.outlook.com (10.13.177.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5038.14 via Frontend Transport; Tue, 8 Mar 2022 23:01:35 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1497.18;
 Tue, 8 Mar 2022 23:00:31 +0000
Received: from dev.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.9; Tue, 8 Mar 2022
 15:00:30 -0800
From: Chaitanya Kulkarni <kch@nvidia.com>
To: <linux-nvme@lists.infradead.org>
CC: <hch@lst.de>, <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>
Subject: [PATCH 0/3] nvmet: fix compilation warnings
Date: Tue, 8 Mar 2022 15:00:19 -0800
Message-ID: <20220308230022.8863-1-kch@nvidia.com>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2b79062c-58f2-4a7c-05a2-08da01579886
X-MS-TrafficTypeDiagnostic: MN0PR12MB5930:EE_
X-Microsoft-Antispam-PRVS: <MN0PR12MB5930452CCDB3A5EC831F4478A3099@MN0PR12MB5930.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xAgMm/ZUQrFGWKJJDDOJkHDVAF0evW16g3wv54U/Xum4lmioeoz1auAdKuq7NOiJ7WFhfQ1apqVGSkguCYcRjMgBBO9g+0FjYk4GMfRj3Rtcx8oKv/80Idqu4mDaJ6JWCOtKRIOFu7fKPdh8pWLti3ElR2DRgs8DYxEQluMDxAwlDL0rizsSaPlXlZ0iKKwQ0s9mSDUU9gXcUWBC+gJZapEquO1DvgfAMpHG7Stk6v+XQ1pHnx5+OEojxakBnBWNE3sT8v1Bmif2CasB+CTgeaeRVJ2fkEbAqKVnPpGm2tuh0DqUX2JRoZF4kS8IgRndeXzryUXA/2NuJEhFIoJtfTe0N/F9X3PSKI4oE7uQ+WipRYb65wtuZUAzECqW2KCijydJk9U8FnwwCaGCjUrSw9h9xjJvbSTzk5Lw3MEnbQ+fOXUcoArHjJC4vijcalUPtSmPAk+GXqp9FAh/7aBOwK8Cx9/wcai9tCxma36QvzCiowLIP2MfBqW5DKh5lRBcjyOwynhaOsQVZ+sPF7Lr80zKF/nctPAYsTsBJeotCh/nN/siCYbNlB3DErUEe98vPbohOASJfW2us+pKY8D5H9NXIsOO24KxXd3Ej9/PUrdzxE4yTooeXf2xijqvlJn/55f58ablJ0pIkWy+i0aa2XYg2bxkhx6dinEvaHvvzY0evDrFLvi086cE5GmpRYI/O5lrKtJhVmljxio0PgVVNg==
X-Forefront-Antispam-Report: CIP:12.22.5.235; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:mail.nvidia.com; PTR:InfoNoRecords; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(8936002)(6916009)(4744005)(5660300002)(70206006)(70586007)(36860700001)(316002)(83380400001)(36756003)(40460700003)(508600001)(2906002)(426003)(1076003)(16526019)(8676002)(2616005)(26005)(186003)(336012)(54906003)(356005)(81166007)(4326008)(47076005)(7696005)(6666004)(82310400004)(107886003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2022 23:01:35.5924 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b79062c-58f2-4a7c-05a2-08da01579886
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[12.22.5.235];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT006.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5930
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220308_151545_442623_DF696868 
X-CRM114-Status: UNSURE (   6.76  )
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

Fixes for compilation warning for target.

-ck

Chaitanya Kulkarni (3):
  nvmet-fc: fix compilation warning for register
  nvmet-fc: fix compilation warning for unregitser
  nvmet-rdma: fix compilation warning

 drivers/nvme/target/fc.c   | 4 ++--
 drivers/nvme/target/rdma.c | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

-- 
2.29.0


