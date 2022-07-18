Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60CCDC433EF
	for <linux-nvme@archiver.kernel.org>; Mon, 18 Jul 2022 23:12:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=iIifDYQaVGWujZ+2M7pW5+fEMNfe5KetwMprgZo0aJI=; b=m72WvNPvhUlrtYUvHsnuHTZxWY
	9vwuezxbQmFKq6JAONV56xsKk8v+u2RvpI+LK6j3jrHv1hFjsEpPiiK+bPnc203lbcskyO60IKZuL
	psxYnQ6Gg5QuCnqG1qkP6vtVwqUttGIVkjAzRI/sRQpCWO+g4vwnMSRvJgIDTFhG1itscBmbf6HaN
	3tF0lJeKR05+5wZjw0H2tsSy/793mVmKSa8RNNsogbopaNAASZ0Qni6zRBhZYrzsKy4vkMnKmMtXp
	ihpMIJqzRP2e/+gzt6l9ZIvP2fecn8Aj/vYrdsBW0yvCMPRY3EDpBCFPvxRFhF7CSjhmq/2D6TmHM
	2HY4oJwQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oDZv4-002WnX-Le; Mon, 18 Jul 2022 23:12:54 +0000
Received: from mail-co1nam11on2053.outbound.protection.outlook.com ([40.107.220.53] helo=NAM11-CO1-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oDZv1-002WlG-Bn
	for linux-nvme@lists.infradead.org; Mon, 18 Jul 2022 23:12:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RA7JAH/r+VN8Rr+dM9Zg6RUy9yOmFKkyV4zIY8QpTYV2UpCTuciD8EX34oC8RwnsMAb1jhCoPCsnxmX2gsYWWbl+/tPebA1LvhS97XUqF6idByqquKWiy/VcANujUz65mdXcv1n2mE0QV+rIg26zyFHYVaXFQ8nH1QvQwqHWh3pPe+JXbY6qsZ1C5JeKvIq9obvEWZBPu6/zvQ9kI1T3Vn5EaXu0McyjuVkGmLYzhmi0hAS9YtZ1d/oCmEZIpXjq3naqA0vWiLLmNnHAWfRfUJ3H3KibN1OqNQ86RO5MbogrXJxSRSahT91SxRf8iKbnIvu3WPm5UhXHAxfXKHUVtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iIifDYQaVGWujZ+2M7pW5+fEMNfe5KetwMprgZo0aJI=;
 b=avSD502qZDpuQ4jakvTBpZpGBR+riBNwWVl3s7fIfP5jq2ZqHr1sgUazBjm0ahtmK8+s1CIYZxyut3GglUe+V6m7BheaZpkV5xQNYTZoQ1mrphEBLlGgjRhE00+wuLMfr34uA7yyJfQP4nDsXBgLfTN55JLbjY6avmJJRfKIAPP5mFK0fvRobENbc9R+0cf21KAG8xrAGyjt9vtM/KT4i4OffbQQzZlJUqaKgh4pN1yKR+1rmqZVXJiC0xUfzTkCNNP3H1rICL8XowXP+OP4Xa+pgaqY1xV1VUyhmQi3AUWdnE67Xv907EHTZptGD+KETYkzhKMlQqmSjgpprgZOPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.236) smtp.rcpttodomain=lst.de smtp.mailfrom=nvidia.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=nvidia.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iIifDYQaVGWujZ+2M7pW5+fEMNfe5KetwMprgZo0aJI=;
 b=HHm2k+LAJtWSs1RDn654XU3suzOH2YPOaa5aqadSduNyuTceknubScRYZttQA7dYq31L/9cmruvwsjZkoCmRiuJfzbnSgLnClKmnkFUVP+gDR4t0zTvIBkIRTxPTGrkBHPW80p2pjQv6wIMptJ0jUIvXjxaPJRzvu4eL4N+T7oVjI4beRxvGd4TOTY/2P7fO3fJunhCryqv34XRc43QxZzhBLA14aGwsDD9UYamIsDRzmspg4cvvekDlYmjoaKmEIk8wtk7j8dvdzmbJJoU1lwVvyyqFlV1KcjFJk88O95FZ0DIsVZGlpWexuocHZ8b7WVVyIV5o7f08LYiBxE+03g==
Received: from DM6PR02CA0075.namprd02.prod.outlook.com (2603:10b6:5:1f4::16)
 by MN2PR12MB4566.namprd12.prod.outlook.com (2603:10b6:208:26a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.14; Mon, 18 Jul
 2022 23:12:47 +0000
Received: from DM6NAM11FT038.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1f4:cafe::41) by DM6PR02CA0075.outlook.office365.com
 (2603:10b6:5:1f4::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.21 via Frontend
 Transport; Mon, 18 Jul 2022 23:12:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.236)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.236 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.236; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (12.22.5.236) by
 DM6NAM11FT038.mail.protection.outlook.com (10.13.173.137) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5438.12 via Frontend Transport; Mon, 18 Jul 2022 23:12:46 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by DRHQMAIL109.nvidia.com
 (10.27.9.19) with Microsoft SMTP Server (TLS) id 15.0.1497.32; Mon, 18 Jul
 2022 23:12:40 +0000
Received: from dev.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Mon, 18 Jul
 2022 16:12:39 -0700
From: Chaitanya Kulkarni <kch@nvidia.com>
To: <hare@suse.de>
CC: <linux-nvme@lists.infradead.org>, <hch@lst.de>, <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>
Subject: [PATCH 0/2] nvmet: type missmatch fixes for nvmet-auth
Date: Mon, 18 Jul 2022 16:12:31 -0700
Message-ID: <20220718231233.3886-1-kch@nvidia.com>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: daf498a9-bf99-4d4f-f146-08da6913072b
X-MS-TrafficTypeDiagnostic: MN2PR12MB4566:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 	RznkFhdjRq9KuTu6vQTdxLAHa3Oz5kOuN1oGPbpA/mDje/5vOaF3KFMloeYJQJvLjD2ihudPwblAMkxc5bnCw6b0snpmp0p6WRYwNHQLqgVJMTSAcWdNzcjH477Q3HLLXYmE4zsBZImu/1jECv+fXRLF5tXjRt86Yw7KWrC1Kcwsuau+tc0XCIWm28aeCGNz9pnPnlZZMD+aBOFS9K5XGBrZ7NUKdag6ebetH1PtdnOI9wkQB4yTtJhyPkNJrWwJKBTPvJkUDV1jVdgQpItG/fQxx92bs5JorzVWb/O0a4H5eZA0O3HM1t4AG9A4U5l2mN9syvpqlj9YD1cm0ppBJSHRfMelvVsqaVxe2HO/vPOIpS813WUu9RkcAwm+wnvB0j/oxlhtx3K3kUkRO3zxO0nVnt37AieUVJ+asjR6tJa5MQKI4avMtVoNajcnBS/yR6DKuhMifMmgLPVKWztrLBDwH376GX4EYyLx9lTyc4UJKBBWyzpJpjbu1dYf+wV5c/LmBlzTBqEjD7vI1TJWa1JPrJuVlyrV9Wm6/630xl1jBpP1JSzHRkpwq/pzuHgtwWoP0/73hQzb5bpK32OhcDOAkWwn3C25CkQGBWP2Cn2x1TlAbJIqhwg7xlH5o5AtH+lYKdSbqCsXDRmOJYtjTOWTvOEZhlUHwkYBDLE3Bq3UY9uoDpNHM4Wc9HrLNU3h+Jmz7oWtQ41hyYi36vzsppmLHK4c6Dw9nPc6J7AnYHQNjN1LKy+0rLmvgxtRS0BDfpc7PaywP+FIvpnYQ+/JXQT4qrNqfutyEHrPcf++udR01Qv2Xr96STI0JxWmlQByFNIyYRT9FaVR1l14tc0i9w==
X-Forefront-Antispam-Report: 	CIP:12.22.5.236;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230016)(4636009)(136003)(346002)(376002)(396003)(39860400002)(40470700004)(36840700001)(46966006)(82310400005)(336012)(426003)(16526019)(107886003)(83380400001)(40460700003)(186003)(2616005)(40480700001)(47076005)(82740400003)(81166007)(36860700001)(478600001)(70206006)(70586007)(1076003)(41300700001)(6666004)(26005)(8676002)(4326008)(356005)(6916009)(54906003)(316002)(7696005)(2906002)(5660300002)(4744005)(8936002)(36756003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2022 23:12:46.9618
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: daf498a9-bf99-4d4f-f146-08da6913072b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.236];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: 	DM6NAM11FT038.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4566
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220718_161251_426665_7BEC22FB 
X-CRM114-Status: UNSURE (   5.71  )
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

Couple of type mismatch fixes for nvmet-auth reported by
Dan Carpenter.

-ck

Chaitanya Kulkarni (2):
  nvmet: fix return value check in auth send
  nvmet: fix return value check in auth receive

 drivers/nvme/target/fabrics-cmd-auth.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

-- 
2.29.0


