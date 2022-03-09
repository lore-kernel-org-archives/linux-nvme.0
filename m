Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D3A8C433EF
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Mar 2022 06:16:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=YLksPYhhrWPkV7CNRhCXPT5mScESDqjbxvGimIVsJ9s=; b=vAoe1vglPnl5HHM9xxCbwRKi5e
	JTeoZFsnpIDhIt5HB7yjnwiA5gXNYDb7RYL0Sh5koh+d4Tlt/dg1kXR0apEzjbWS+w55pDguPFwVA
	aWQJsNlpwTfgnDTRZC7vE+MRBrSCcDaPYHFhLek9qxEQwCVugwIkIYINDOCkqZB/7s/OE4j7w7bsp
	gQtsQtQ9YRSRwXhtMLgNWh9TeQh8lA/speurWyWJpm8sXjvZQRxXVH6i5iv1nnt1iS2Hmbu5QHwSM
	N2G0N1PvApCB3bhLM043iYv6TTAMKd0tuOD3tPJ7bqMiR15smBcGDElBulHivKcQYzuKME4GgOCJi
	Yjyx8ACA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nRpc9-007U4w-CD; Wed, 09 Mar 2022 06:16:01 +0000
Received: from mail-dm6nam11on2061a.outbound.protection.outlook.com
 ([2a01:111:f400:7eaa::61a]
 helo=NAM11-DM6-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nRpc6-007U3m-Lp
 for linux-nvme@lists.infradead.org; Wed, 09 Mar 2022 06:15:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=McxBGYpsqoVa3j1Y4Sl7KOdb/zlwuQI5quFKIwYHLdHYxczHDNzbpKK8ayP8rhoUK9FFVM1aHsJG54aMPyQfyItHiVGf/aylI92xCcQBfRiYYBKWR33c65xXGq5iTE/yJoRNFU9Q/o5j9yzxPiCwui7WjtcSvcZs0B0YHTNlwMSxiw+tEApD/qErPpDnfrQsQPw2sH38aNjGnGB5/BiFolYjBqYDHt4GjJyKAzt0jLcdULNYo7CrXAI9D+IvU8D9vrGqj7fGFzOG5StP/g1NYp/ZpyMudYBcB14VxpaJqsb4GrI6qDzT1vs0bqOQ7cVvQ9myLgeriz1Wbjd4G9vbCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YLksPYhhrWPkV7CNRhCXPT5mScESDqjbxvGimIVsJ9s=;
 b=iUgjGHFDl/gS0oeLXyvTW22vFLupRHSmjtlpI6oX9hC33Ewrfn0OhWl/0uOvwqDoBYYnDv/XQ+KwI2hB7NP66gIwTCNfNKb6ZJxflbST6s6bzboGr/GzqgK96Mcfa4k6dE+4RIJMGc0urL97/CwuVJnHQBpNUiXwtvcZEOeZtZVcC+DFncDVsJNhXqzkTimAtgwBME1OYztbZm7OmmGeHKn6wSdwjHahGD2UX8O8OENjYUgB9Rz7x4vS3zB8iW/6Ew32CjekvDznB0L1Ja1S4XKheBGdh0AFyJyl0HcOPg1ulRTvbsDPZKLK9ghqKRzcrcn9vyCJeJarBzuAhU53lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.235) smtp.rcpttodomain=grimberg.me smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YLksPYhhrWPkV7CNRhCXPT5mScESDqjbxvGimIVsJ9s=;
 b=osU4pKm4nhZxIxUSHL+2to2vfXB3TCg03lEfkwvPwbOJwurDAh6U59j2bE47x9xEXAfKHBMZ1zeQCMEFzzw70a0IF4UREykiFN6iU9u1pfH8X2ejYYkv52AvTbrzBtiYH+u6OLAoTtRBeeQ1AWxWAgzjn/Mm7Z9VhQmSXDx2Ne9+CM2tIF1UBhvp56Cq75bAyb/SL4oIOLddotZAOnf2mEh9KzMZLLLZC/im3SubX7G5X9h4VfxJ+PNd2rUHMzTb4vb62pBXq/Ya064fkgh6FpeVo6CVfHVUl06RYzphXnld2U2rB2bGNIWsp2Q0MkVXoL/PKtf3Az3HFFB/CeGt2Q==
Received: from BN0PR03CA0052.namprd03.prod.outlook.com (2603:10b6:408:e7::27)
 by BYAPR12MB3159.namprd12.prod.outlook.com (2603:10b6:a03:134::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.17; Wed, 9 Mar
 2022 06:00:02 +0000
Received: from BN8NAM11FT044.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e7:cafe::59) by BN0PR03CA0052.outlook.office365.com
 (2603:10b6:408:e7::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14 via Frontend
 Transport; Wed, 9 Mar 2022 06:00:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.235)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.235 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.235; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.235) by
 BN8NAM11FT044.mail.protection.outlook.com (10.13.177.219) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5038.14 via Frontend Transport; Wed, 9 Mar 2022 06:00:01 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1497.18;
 Wed, 9 Mar 2022 06:00:01 +0000
Received: from dev.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.9; Tue, 8 Mar 2022
 21:59:59 -0800
From: Chaitanya Kulkarni <kch@nvidia.com>
To: <linux-nvme@lists.infradead.org>
CC: <hch@lst.de>, <sagi@grimberg.me>, <axboe@kernel.dk>, Chaitanya Kulkarni
 <kch@nvidia.com>
Subject: [V2 2/3] nvmet-fc: fix kernel-doc warning for unregitser
Date: Tue, 8 Mar 2022 21:59:26 -0800
Message-ID: <20220309055927.11267-3-kch@nvidia.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20220309055927.11267-1-kch@nvidia.com>
References: <20220309055927.11267-1-kch@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 62c441c4-ba72-4d1f-933c-08da01920ce7
X-MS-TrafficTypeDiagnostic: BYAPR12MB3159:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB3159DEDB53854FBE8FCB7C0FA30A9@BYAPR12MB3159.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: l12xN7+DSMQnw+nkoJG4zfrxZtxKfD+KU8iXujZQO2VUHfRJoyKj5ANxneacKzxw+9MaA6ONi/T5Awcphy8c5BRQrBYQeNGXz3IW8x+5Ts0VTILCmQkyGlV34NTZwfLMJG6nbILULKc9sombvJst8QSFuvH7+aWwuJoPz+agbqQKDkyqf0BLEyaJ06WW4QJBqfKdJp41lcKSwph1Yqn8QU630FTA0HW/v+GDAItXVlw3KnmZKhojj/ul2phC+7EHIOG0D0I6FW99OOKJSnhfMbu9GI93k7gohaArHR23qY8o87Z7uBmmJFMDNMsXmzXX3L1l3ffmJV/ocJ/weCu1p2opLA2Q3CY3uDPX4m8R2tn49W/Udc7gT64elrb09gc4FJzd9EKhJmvs3SnRcVgdt1pPugFqhcZJLdPJEh+LCts+TfG4wXq5WtpIvdWpWJnWKh1JopexjH9hEKFSD8ZErntV6YtQ7/X5l7DFHzf80AMLRVxap0W6CaI2rmoPROQYxFrTyKduwHEz5I+RHGA1kDmh/zYL67iz2Mh9NFYBRW37q1Ar7BMFlfqWRRN8+PEjDTdxTlHph0Ipk2XyUOlOh6usY7Zu+dCijPPJowBHTM+F+nTGKBC+ZxpQ8sD1YFdN36izKXI+PY0ohfEMV2YnXqKalksj/cIy5FC/6jwmr+yhyqOq2Po6cyKj+ca1GShAwe1U69pEfQEbgAkfuyRnMA==
X-Forefront-Antispam-Report: CIP:12.22.5.235; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:mail.nvidia.com; PTR:InfoNoRecords; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(508600001)(186003)(36756003)(40460700003)(2616005)(426003)(83380400001)(16526019)(26005)(336012)(107886003)(6666004)(7696005)(47076005)(1076003)(2906002)(4326008)(5660300002)(81166007)(70586007)(70206006)(8676002)(4744005)(54906003)(36860700001)(316002)(356005)(8936002)(6916009)(82310400004)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2022 06:00:01.7983 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 62c441c4-ba72-4d1f-933c-08da01920ce7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[12.22.5.235];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT044.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3159
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220308_221558_725673_54E4B736 
X-CRM114-Status: GOOD (  10.45  )
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

This fixes following kernel-doc warning:-

drivers/nvme/target/fc.c:1619: warning: expecting prototype for nvme_fc_unregister_targetport(). Prototype was for nvmet_fc_unregister_targetport() instead

Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
---
 drivers/nvme/target/fc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/target/fc.c b/drivers/nvme/target/fc.c
index 56c2bdfd8e3b..de90001fc5c4 100644
--- a/drivers/nvme/target/fc.c
+++ b/drivers/nvme/target/fc.c
@@ -1604,7 +1604,7 @@ nvmet_fc_delete_ctrl(struct nvmet_ctrl *ctrl)
 }
 
 /**
- * nvme_fc_unregister_targetport - transport entry point called by an
+ * nvmet_fc_unregister_targetport - transport entry point called by an
  *                              LLDD to deregister/remove a previously
  *                              registered a local NVME subsystem FC port.
  * @target_port: pointer to the (registered) target port that is to be
-- 
2.29.0


