Return-Path: <SRS0=nAjD=O2=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD9E7C433EF
	for <linux-nvme@archiver.kernel.org>; Wed,  6 Oct 2021 08:04:02 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D84E61040
	for <linux-nvme@archiver.kernel.org>; Wed,  6 Oct 2021 08:04:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 7D84E61040
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=HkJWunu7sBf1sxWTE6XfdEP6hk495UbQcs3ZuE2gLlE=; b=IcMQ7tHnf0OGRe
	d/NLXRzDJviWiZ8cvrAnLXmfzsWRypeJyBgedKlHqp76XTP/EFyX9hfeBN7jXYpdNDHlsDj7kxpTp
	I6lyiDRSwkcHIK9WDiUPaWnByUI8buFwwvLPO1z2LuUTHZ68NLQkuyvmyDfWj1RnyWMGb2ZPYJZPV
	IGaI3xwnNSPpirwwAKhVgHg4+HyxPjPYxuL4P56+kXfsDsqmmzUe3bzie8pHxgoe5jzTCPGM+o8ew
	2RbMGgBGgiFst9wKsk7oGMukrWkYTvsaNI79JqpaiSP/eJZDLfLy+WCAI8DWDCr9hcY8Z9C3hm4bB
	quHV0wVFvXiW1Q+bF9mw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mY1u0-00DLJu-6C; Wed, 06 Oct 2021 08:03:48 +0000
Received: from mail-sn1anam02on2071.outbound.protection.outlook.com
 ([40.107.96.71] helo=NAM02-SN1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mY1td-00DLGp-Hg
 for linux-nvme@lists.infradead.org; Wed, 06 Oct 2021 08:03:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UUfSRERR79tytHq8qMSpUIUJPPLsz2JMjUqph7WafagKU3Y6kg9/B7551OUMr3w3R08Wp0kwTdUQiYMmQsh1hSLv4gGRIKvCGcNH5D/wL9LoRG6DqEaFfKeygVWppgmyjhaCcTaoHSOWjLrdrscPM9ek23wMaZvyRUTwqpGwKxSpussEWXRMP1DlRGqOlcR+qHT8XlTG0YULVsNYqkUdosv2Zbajt0tXGWF2cxIw/WWDrlawk1qM5Xmx1wRyNw8GUlPlDKh6UPE92crEhdKPSqA+EsEsY6SctVBsiokRcA9CkbgHBmMuVb8fWNEkhrkS6dAGDXH0/Ua1Dv6dxiGB5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D57cmMDtu5PvkuiXNQXEmcXiXU9sQ5B5T6uRufdfn+E=;
 b=molmLvW+72cSiI1pkwLS6k2Y4vL4q/wYv/2j6hUhpChInj0otNln3BfyDpc8XWXms4juv1v8pgksoubtSODaa5z0hi0kn+n00JV/Zw0komlVDW7qL1sG6Aei83DHCRDqLgB7mHo5cXqR0UfsM2AJv9mAuPaP/uDXveyY8FAOvA4cO2WLhmE2F4BM5ZJYLav8WTBUI7rHa2cv5/zpLLI89MRmPRuVNA8K8MSVvF6CoQyDxQyr0qQ9mTrBpfct6e0Yi4cveBTORNwM6Aqf+FUL30fQi+3b+82mPMNMfVgHmpffZZzK7KZH1ewYXxJPuZavkwjIlYwsM0VZH5SXMHy2hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=lst.de smtp.mailfrom=nvidia.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=nvidia.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D57cmMDtu5PvkuiXNQXEmcXiXU9sQ5B5T6uRufdfn+E=;
 b=OYUSkAXg9eS7GciLo9BKZbgj9DbaoNudZGz1n95b+9vRkqcISVmW9dQ7lzUlcOHczMjhKzneBpgUVVCDfkWopMaqqMdW7p3RAkarZ3ZFaUeDQxCUi6o8sif8bSZrt5bWhtnnQ1PPNjfa5zmpBtZ8heWegChw35WSqVTNZe5YoYBDnUaYYZ/ZeavhQl3RzOr3pN2BlcJJP3YuQyAEm9cD4kB+NX2zggtW/Id6mP6kBdjv+EzpmDbk3d6WL6FfoVMYFZq1i3FZ3o8FKFjluXr5M6OenCRH1MMSB9Cye2Tkhj6jANu4aTj+37pm06oYclw1WVJDVvH/7Zvu2V6h+pgnDw==
Received: from CO2PR04CA0151.namprd04.prod.outlook.com (2603:10b6:104::29) by
 DM5PR12MB2502.namprd12.prod.outlook.com (2603:10b6:4:af::28) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4566.22; Wed, 6 Oct 2021 08:03:16 +0000
Received: from CO1NAM11FT030.eop-nam11.prod.protection.outlook.com
 (2603:10b6:104:0:cafe::66) by CO2PR04CA0151.outlook.office365.com
 (2603:10b6:104::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.18 via Frontend
 Transport; Wed, 6 Oct 2021 08:03:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 CO1NAM11FT030.mail.protection.outlook.com (10.13.174.125) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4566.14 via Frontend Transport; Wed, 6 Oct 2021 08:03:15 +0000
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Wed, 6 Oct
 2021 08:03:15 +0000
Received: from rsws47.mtr.labs.mlnx (172.20.187.6) by mail.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server id 15.0.1497.18 via Frontend
 Transport; Wed, 6 Oct 2021 08:03:13 +0000
From: Israel Rukshin <israelr@nvidia.com>
To: Linux-nvme <linux-nvme@lists.infradead.org>, Sagi Grimberg
 <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>
CC: Israel Rukshin <israelr@nvidia.com>, Nitzan Carmi <nitzanc@nvidia.com>,
 Max Gurtovoy <mgurtovoy@nvidia.com>
Subject: [PATCH 1/3] nvmet: Fix use-after-free when a port is removed
Date: Wed, 6 Oct 2021 08:09:43 +0000
Message-ID: <1633507785-10319-2-git-send-email-israelr@nvidia.com>
X-Mailer: git-send-email 1.8.4.3
In-Reply-To: <1633507785-10319-1-git-send-email-israelr@nvidia.com>
References: <1633507785-10319-1-git-send-email-israelr@nvidia.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: aca4f65e-6581-4cb9-26d7-08d9889fc050
X-MS-TrafficTypeDiagnostic: DM5PR12MB2502:
X-Microsoft-Antispam-PRVS: <DM5PR12MB2502F51D762D88C8141AFFA8DAB09@DM5PR12MB2502.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZU03fS7VvUBUBxnx34RVz86BiTj9YF07zM1bmzgjAfr5CDwq5PjxImUsH0xfg2yjMLB21luo4CEdBIGTRA8Ctm6y2JbbOqGDvKQbssjIZOIJ5zxGmCUH/Qb/yFF31U4GMTMsZ9ZkP+rEWU2NoHylLbtyMoJONT+Fp6kKyWCqWOU3ZNgl5xlWXSCjvdU9gKEYvRk6a/KhhbEf1pOdvic/U8Wkyo8VgayXkAJD1poUvQQfNHZXh8DDOzVSGncXA9CuG88KWIQqvBnmpWgR7bieYl6DraHt2EOtOC6fJX55Z5WnhCPPrGPo+BBfvpwsndx/1PX1BmFCXiGmtY3pY63qCNFY6r3Go+npjP79ikTVqk8XOs6pN3bXqP/6VsjOyKfuWMvfbDrQrUuckX7jWYjG2H4oE4K9e8ek3dhYBKZHOTChYrMnGUeTI3jGsz59xEPm4CTyxTXG5C61vFvKlsj5jl2NEwaJVsUacOfVM9Gh0vsJq6HRbJNyaaYtYG/n9O0fFFI4bf/VTsBNMzhGPeSWjhdCqPmWoIfGWppPKDz69eiiHImvrlEZjG4bHruekZDXkaB9J4c13FbAiNUEOYJ4sdVRf7abL5vXQUNf1WC3nCVxlBnxjsi0NXQkj0y+S8fXM8PqB7nt6FLdh68ihirHcjnmDskAfUDjizQ8M+bwNBPNrAApGEVXGLupOZ7jfVqP1Gad69yRDwQdYKVpQbYWZg==
X-Forefront-Antispam-Report: CIP:216.228.112.34; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:schybrid03.nvidia.com; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(110136005)(107886003)(508600001)(186003)(426003)(2616005)(5660300002)(26005)(6666004)(8676002)(4326008)(82310400003)(54906003)(316002)(36756003)(8936002)(336012)(7636003)(36860700001)(356005)(70586007)(70206006)(2906002)(86362001)(47076005);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2021 08:03:15.5532 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aca4f65e-6581-4cb9-26d7-08d9889fc050
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.112.34];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT030.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2502
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211006_010325_611609_B46EBD88 
X-CRM114-Status: UNSURE (   9.11  )
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

When a port is removed through configfs, any connected controllers
are starting teardown flow asynchronously and can still send commands.
This causes a use-after-free bug for any command that dereferences
req->port (like in nvmet_parse_io_cmd).

To fix this, wait for all the teardown scheduled works to complete
(like release_work at rdma/tcp drivers). This ensures there are no
active controllers when the port is eventually removed.

Signed-off-by: Israel Rukshin <israelr@nvidia.com>
Reviewed-by: Max Gurtovoy <mgurtovoy@nvidia.com>
---
 drivers/nvme/target/configfs.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
index d784f3c200b4..d6cfeb3b3eca 100644
--- a/drivers/nvme/target/configfs.c
+++ b/drivers/nvme/target/configfs.c
@@ -1553,6 +1553,8 @@ static void nvmet_port_release(struct config_item *item)
 {
 	struct nvmet_port *port = to_nvmet_port(item);
 
+	/* Let inflight controllers teardown complete */
+	flush_scheduled_work();
 	list_del(&port->global_entry);
 
 	kfree(port->ana_state);
-- 
2.16.3


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
