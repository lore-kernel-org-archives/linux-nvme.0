Return-Path: <SRS0=qdm1=MO=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E2E8C6377D
	for <linux-nvme@archiver.kernel.org>; Thu, 22 Jul 2021 11:31:47 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3124861264
	for <linux-nvme@archiver.kernel.org>; Thu, 22 Jul 2021 11:31:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3124861264
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=e7vqZTWY4pLJu5NH9gstehp5SaehIYDXi2Ubayjp6ew=; b=W/mz//3fUSmmYM
	ybLXOCwrdC0SXH7HhvbxKrrcgQEC3RhKTURg9lKWg/TB3RiEwEbxLWrtFfMkoDxKmKsi5S/5Mzw2I
	ccAD1seiwiXJyL6kZb6z1Ij8xbKXnRNWnomALDKFgemtrz2gUtIbauvf+CR7mD+G0iYQzO81hw8P5
	60/XhO4LR1IlVYUi3BJHb3B6HeY+HYUxHROkKfAFo+Hwe6DXK0SgzHQNd0x0XNeT6I1CWX8rAVHYy
	WfeX/oswhYA932XLMAzQViaeL9wzNU0wDct+mWd7x3hj/saVy/tb/xh/wWLSvd+4T09QHV+NPfX8b
	w6KUIhLSqSn03feZbeFg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1m6WvG-001Mv8-BU; Thu, 22 Jul 2021 11:31:26 +0000
Received: from mail-co1nam11on2082.outbound.protection.outlook.com
 ([40.107.220.82] helo=NAM11-CO1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1m6WWc-001IkJ-RA
 for linux-nvme@lists.infradead.org; Thu, 22 Jul 2021 11:06:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g4xqKVGkCcwxU5WBjOM9XI23AwTz40088xiALBy3EsEdzpsvUUIsxQu6hj3UYQYmDUUcwsSpjVX/rRz/vo/9bjSw0Wku+gi3TxsskBm1KhLMUZMxEM3LxeC0OmKi3wymiNlreBUlBc5r6z84BYPV0ygtQmn6vTOkEXZPUq0seK4tLuQ2sb945ZzXovawZIpguGMcZRHEMpBEpHotwYyX3MEtwDk1w8MzgMtiQwYnts+ZWQ7DnDSoa4wRrRHjJiOp0V+irh4qHa2zc3OdfCvhqC5hN1WdKh4vVFJEEuVyJo4ASNyoqQMq3wOkYD+t/BQsMe88fjDFBD4FFSnNjh/hEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pxpfYeCcgtIzhDJ4hiPapD/f+pU5+K76rALugvzYsjM=;
 b=VM9EV+/Stgo51gV4e88qfQNFJQeSuBfENiDZTqU3zfZTzBuEQ1q8BJhbVn5Wt0cQj5KbLDOoeF9NIBhmXnKgK6Fpmf/5dBSfeenpJxij/VWdqzaNn3G5brejByDrQB6sfyXvp9jh7HEdcgkATlT7WtKhfgLWX5ZeRcmw7vdiN6KFtW3eJEF5zWHZHHOf9VF6gr9siSO38xqDfX635A3kzkqZC6t1e6fcqu1RDCRQ21Ihflkr8DYwHWvASew/HOCF41WDB/Tp/ln8hLQNUpVuo65tCzhMX6S27BazWlB7gIsYoZ7TgOq5hBqokbqQ8+9JTZsUOeW8s63uiPlvqGUPSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=marvell.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=nvidia.com; 
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pxpfYeCcgtIzhDJ4hiPapD/f+pU5+K76rALugvzYsjM=;
 b=giBnFJwj0kCSoMwaQcwPX94QYDLrYToFp6vs8aw8U018Q0LYIXjVH1hJR0TDffsKfh7MOjuA/l4KmtJzthXwatWpH7jFWxu2EnNFpYldvkP/uFby9eS1Mw1Uv1P2ioytdFZETrIF5YhR8/3jhB41xndlNOco7BuaLKSJzntQQZVC0a2qIv9xFSOuhMEWn1/EipqDEz/KqStqzJNpWV89SyYugrMlAFWuR3Eey+AiexvjaqnauGuW3gbsVyakL+gEZYNS3dUYY9N+cSethoy2sHz/aUQvM5d7BN7r0c+SIVzE4c6Llns5zUJ07UTVysXfSqpTfMSCNFGLM0UeT1N5bg==
Received: from BN9PR03CA0676.namprd03.prod.outlook.com (2603:10b6:408:10e::21)
 by BL0PR12MB2513.namprd12.prod.outlook.com (2603:10b6:207:4a::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.26; Thu, 22 Jul
 2021 11:05:56 +0000
Received: from BN8NAM11FT058.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:10e:cafe::45) by BN9PR03CA0676.outlook.office365.com
 (2603:10b6:408:10e::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.23 via Frontend
 Transport; Thu, 22 Jul 2021 11:05:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; marvell.com; dkim=none (message not signed)
 header.d=none;marvell.com; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 BN8NAM11FT058.mail.protection.outlook.com (10.13.177.58) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4352.24 via Frontend Transport; Thu, 22 Jul 2021 11:05:55 +0000
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 22 Jul
 2021 11:05:55 +0000
Received: from vdi.nvidia.com (172.20.187.5) by mail.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 22 Jul 2021 11:05:50 +0000
From: Boris Pismenny <borisp@nvidia.com>
To: <dsahern@gmail.com>, <kuba@kernel.org>, <davem@davemloft.net>,
 <saeedm@nvidia.com>, <hch@lst.de>, <sagi@grimberg.me>, <axboe@fb.com>,
 <kbusch@kernel.org>, <viro@zeniv.linux.org.uk>, <edumazet@google.com>,
 <smalin@marvell.com>
CC: <boris.pismenny@gmail.com>, <linux-nvme@lists.infradead.org>,
 <netdev@vger.kernel.org>, <benishay@nvidia.com>, <ogerlitz@nvidia.com>,
 <yorayz@nvidia.com>
Subject: [PATCH v5 net-next 21/36] net: drop ULP DDP HW offload feature if no
 CSUM offload feature
Date: Thu, 22 Jul 2021 14:03:10 +0300
Message-ID: <20210722110325.371-22-borisp@nvidia.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20210722110325.371-1-borisp@nvidia.com>
References: <20210722110325.371-1-borisp@nvidia.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2b35ebbd-e5d4-48e0-977b-08d94d00adc8
X-MS-TrafficTypeDiagnostic: BL0PR12MB2513:
X-Microsoft-Antispam-PRVS: <BL0PR12MB2513EFE674B724043DA689E0BDE49@BL0PR12MB2513.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:346;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +lkUdXrnn4LrvhrbyrrtJo2hafQ1L3flwCba5g/9i/vMNJvVty1DpoUqdiyKNAZX/Ck78TxhYR1e5/odcUZtsVjTEvkZIEeuaxi6XHT5+h+RlqfmjT4wd+AuHq07YhGsKhCNg7xsZVLuOIt8Vt6wbGWF/5GnNpv6OA0Ao5gJSIOSQFpFZCcXUvO1xycRXH3cgRAXZyfJp9+R/wxbwVRdto8dzEWQ4xUk/WvSTfB0/G0x0j3X3tAywZ0woYtzNx4oyoY7/OWXPtdKmn9HXsw4Xoyx5JIChcxU/ZwB59nnWvp1iQZWi9mEvnBC/zhEPHTiJTWSHNy7qjy97Gv0YZ2wHhbVd918BixvebtLW11AhyPN60j/GAsvqBY+tVrNbfeYttSe5wlt7kVX3ivn7uVi3MRLhbU8AQRds9XOchJ9fa35bxq0LtozONZ4ypdojIiYsU6CBNmdp5iOsSxp8qtkyeQDGMCb4l05lxJBluudWFTA5PxYrqdGXap42DAh98P2H7Z9RELrXb8WrFMoqkXmW0ThrtPu1jx6oDgT9fK1gOuhMVeSnfmLhTuwtYXvvAdmv3IwRAyB4hhVoAL13Ojg4c7ihUvDox1kSKto6IRyeOV2vXCLwIm2cv52828aqNpQhsWGs7JESWQdvS6IUUzignD5O+1bqD1ASdOUsyACoSrdEhEK6ZtJGt1MAWAZ4TEXhTcrM1Rn4ndrPeyo82V0ySXxi7XsF18UqnxhnHLxdC8=
X-Forefront-Antispam-Report: CIP:216.228.112.34; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:schybrid03.nvidia.com; CAT:NONE;
 SFS:(4636009)(376002)(396003)(39860400002)(346002)(136003)(46966006)(36840700001)(8936002)(186003)(4744005)(4326008)(336012)(2906002)(1076003)(82310400003)(82740400003)(7636003)(426003)(36756003)(7696005)(2616005)(107886003)(26005)(36860700001)(356005)(478600001)(8676002)(6666004)(110136005)(54906003)(5660300002)(36906005)(316002)(70206006)(86362001)(7416002)(70586007)(921005)(47076005);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2021 11:05:55.8140 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b35ebbd-e5d4-48e0-977b-08d94d00adc8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.112.34];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT058.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2513
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210722_040558_948632_B94BDA44 
X-CRM114-Status: UNSURE (   7.44  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

From: Yoray Zack <yorayz@nvidia.com>

Signed-off-by: Yoray Zack <yorayz@nvidia.com>
---
 net/core/dev.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/core/dev.c b/net/core/dev.c
index c253c2aafe97..1c8fcee2e9f9 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -9927,6 +9927,8 @@ static netdev_features_t netdev_fix_features(struct net_device *dev,
 		if (!ip_csum && !hw_csum) {
 			netdev_dbg(dev, "Dropping TLS TX HW offload feature since no CSUM feature.\n");
 			features &= ~NETIF_F_HW_TLS_TX;
+			netdev_dbg(dev, "Dropping ULP DDP HW offload feature since no CSUM feature.\n");
+			features &= ~NETIF_F_HW_ULP_DDP;
 		}
 	}
 
-- 
2.24.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
