Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3E32C433EF
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Mar 2022 17:44:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=mIXM2J2c9cF+lTGMXynijBYUuiXZghydA6rU62mN14c=; b=dCenyiQ8ioUlv3yimjM6qnJF9i
	QQ/vyMVmBsR7scdAgX6jPWA9vgUyZF5XTnQEnSQpBcJ5VZdEQo5VkSYU4OiB0bLkfmzq8/MUbKhwQ
	D/2TcSPb2PB/Wltg0oaNMkHnrPPggi1fzkzWCJQrN9JYGECFhG/Dg+bO45vsXJBRfsDCsOz7rIIwF
	hOzIO9+qLDd1Ier8QA66kqpzWsFqBDyg9qid3Z4HLZMjqNcaAUW2yUVAlLtlIC5LK+AkWTTSrYoJG
	c7e1BniJFKV5jdVW+O4PrpaIChlQRoeu0n202L0cTAv9tmqE1277CJtR4ka0Zc1fkICgg/FWP1wf+
	P4geDccQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nS0Lx-009qm8-KH; Wed, 09 Mar 2022 17:44:01 +0000
Received: from mail-mw2nam12on20613.outbound.protection.outlook.com
 ([2a01:111:f400:fe5a::613]
 helo=NAM12-MW2-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nS0Lk-009qgk-Kj
 for linux-nvme@lists.infradead.org; Wed, 09 Mar 2022 17:43:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AWKznSq+U4cAGWfwpGg7qPyIhY0zDpNYbMpNOY1h2FwxNkhD0T+cwmNByw0uGjY2IQVr8qVR0f7Lg1uxRiz7fROBoMJGC2sdpOZaA6BPtet9TQAKOo4LXZ+WOhnBZlY+ZpNVzPZj4lY58PK/4/Qul4FVkRwpk+i/Oi18BZFjhC4iSSBM8sW2QEd3gTYoWGwYhRa43QiD1TwhLnj2imIE/I7p/f57xSEsE0dwRTpMRCx0X+iv4/8/TSQElS1vUO4rx7HoNPSGnw2VHf/IVmOnBY7cYwXeFLlMad5/781Dezno0QcWPhAW5kuw4LtAC67fxaFEX9xEJUldwDeM8XRCuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mIXM2J2c9cF+lTGMXynijBYUuiXZghydA6rU62mN14c=;
 b=Jkw2M9Esk7VObnGXTY0yJwmep7nqWNI2j1BfJXzmkCoaRfXtDxo+F+DNoNCthFtJFXmHcPJkFbxK+JlUaaLthHuNKjCwpkHcvS/lz1S4VvqFi0GBm2PeMy3XRIPBWlPnYYr2XYKPquujklA1q5EOOLjoKPqb8gQf/l0dE1+e/fo0BmTFAvi5G7F74HPpIC7BPV+LFwEs+1sABXpxQehEAcSxXVzQLZrDFYD17CAJbYNyZ6VLPcU31ZQDjJM8aK5tDSVUNCR5+IMNX5uh9IxZPYP8r8ET2kAKd6EZWmDGWk9uZ9f7ZG3xFQxMdOaMPe6qyg1Yl6lPFKt5wM9j/Hx8PQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.236) smtp.rcpttodomain=grimberg.me smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mIXM2J2c9cF+lTGMXynijBYUuiXZghydA6rU62mN14c=;
 b=PC6Qmelr1/bfmSF9P7A91y/Wy/Rw079c0F8Zxb7k4iLrdRcOR/TlYFOW372N9PYSBZ99iuMsvybJhxHi+YEydX8PrU4QLrIAWcmcmBcssx+wOYCsUY+xvwrSBKmWYbNmE8XezcRXmN5wchR6ERKtoHMm6IdyIc9kQvOK7tT8NPHhONeEuuwqRupE8eIpv0hfJoqNzmiqgnM31Vp3TXMv3TJEtvs6NABwLMjZGOaVsTo7niBVY2n0jwNkImfNLEYVzYlU2IZZdZTofPTN/fHfTJgIe7hHFdwRrRy6Ue9k8vay9AWZCWFXV6GOfZ6lm8Z14gS7KMXwAILEXsl3edDMpA==
Received: from MW4PR03CA0100.namprd03.prod.outlook.com (2603:10b6:303:b7::15)
 by MN2PR12MB2928.namprd12.prod.outlook.com (2603:10b6:208:105::27)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Wed, 9 Mar
 2022 17:43:26 +0000
Received: from CO1NAM11FT048.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b7:cafe::10) by MW4PR03CA0100.outlook.office365.com
 (2603:10b6:303:b7::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14 via Frontend
 Transport; Wed, 9 Mar 2022 17:43:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.236)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.236 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.236; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.236) by
 CO1NAM11FT048.mail.protection.outlook.com (10.13.175.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5038.14 via Frontend Transport; Wed, 9 Mar 2022 17:43:25 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by DRHQMAIL109.nvidia.com
 (10.27.9.19) with Microsoft SMTP Server (TLS) id 15.0.1497.18;
 Wed, 9 Mar 2022 17:43:17 +0000
Received: from dev.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.9; Wed, 9 Mar 2022
 09:43:16 -0800
From: Chaitanya Kulkarni <kch@nvidia.com>
To: <linux-nvme@lists.infradead.org>
CC: <hch@lst.de>, <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>
Subject: [PATCH 0/2] nvmet: nvme_excute_get_feat() cleanup
Date: Wed, 9 Mar 2022 09:43:06 -0800
Message-ID: <20220309174308.41832-1-kch@nvidia.com>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e4c3f3ed-783e-4d89-9c0a-08da01f45087
X-MS-TrafficTypeDiagnostic: MN2PR12MB2928:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB29283AAF7A38A592098DE99CA30A9@MN2PR12MB2928.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Vb6VNF4ZFGvHfXBGdss2aMMlg7aVmMPs7XVlU/gOyUCXd1v1na9lPUT3adCzbdLNwlKz5awpeOBKm21iyE/AHOCBE1p8954/Bus8ljzuPpx4QHBsVekFicvE4RINknpzAtE0wopoA/jxMpOD4DL6ZkcBY7jBpKOXSvt5lHosmVyvL8AHaJiFaqHiFDF8f03w1dUEQRaljEKAbWFE6SZS+flrkz9bbvvhe0vDYGfjsWUzZRY1eleeEQ8oPIFwXlITcfq5w26XGmCsSjkO99/f8hWcEZXl23FRoSSYGgviPrLGE9NueNWztc9VY/dbd5Bc7U9z3i8hSaa3ZRstoDSsb3caw/WqpnykqCVPl7DFNHyml37zsZwh9Kt6ixPQAC9S36E/nNir4XQA+kTY4jtHpXYGgzukvlEaKtrjfWgpp6Q4Z8o3701jQfLGAqvgNQZTzjGfgehAxU+ECjarya0L6Ko1yue24BypA5MtSvKLU0PNaKfpMKrVQhQK7T0Aoz9/rZOu9iJH+5EVCBUIGScKIZXhY8hyXaeQ8UxTbBlj6eWc4wo40OiSy2ZIyXV9zLWo1+Mg0Rg3OFR/1mAyBcomFZL33jBMoEKe1vOq37jCG2JEG4KaHN2FJIMLlHc6gYIQPstsW++5yMAZ6oebykFUuuXglNvyleouahePKulisJsSMGwOYR5ilqJaX4hf0DO70lgsIAeuHtxU5IcdKYQE4w==
X-Forefront-Antispam-Report: CIP:12.22.5.236; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:mail.nvidia.com; PTR:InfoNoRecords; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(70586007)(508600001)(7696005)(8936002)(83380400001)(5660300002)(4744005)(6666004)(70206006)(2906002)(1076003)(107886003)(16526019)(186003)(26005)(4326008)(40460700003)(8676002)(82310400004)(47076005)(81166007)(356005)(36860700001)(2616005)(316002)(6916009)(54906003)(336012)(426003)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2022 17:43:25.9340 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e4c3f3ed-783e-4d89-9c0a-08da01f45087
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[12.22.5.236];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT048.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB2928
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220309_094348_714878_A5E3ED40 
X-CRM114-Status: UNSURE (   5.91  )
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

Just open code get feature functions which has only one caller and one
line.

-ck

Chaitanya Kulkarni (2):
  nvmet: open code nvmet_get_feat_async_event()
  nvmet: open code nvmet_get_feat_kato()

 drivers/nvme/target/admin-cmd.c | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

-- 
2.29.0


